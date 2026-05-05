// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unnecessary_import, prefer_interpolation_to_compose_strings

// =====================================================================
// clipping_test.dart
// ---------------------------------------------------------------------
// Deep dive into Flutter's CLIPPING widgets.
//
// Clipping in Flutter means restricting the painted region of a child
// to a particular geometric shape. The painter still LAYS OUT the
// child the same way; only the pixels that fall outside the clip
// shape are discarded during rasterization.
//
// The four standard clipping widgets:
//
//   * ClipRect   -- clip to the child's own rectangle. Mostly used to
//                   stop a child from painting outside its layout
//                   bounds (e.g. an OverflowBox that intentionally
//                   draws outside, or a ShaderMask whose paint bleeds).
//   * ClipRRect  -- clip to a rounded rectangle. Probably the most
//                   used clip widget in production UI: chips, cards,
//                   thumbnails, anything with rounded corners that
//                   contains an image or a gradient that should not
//                   spill past the corner radius.
//   * ClipOval   -- clip to an ellipse inscribed in the child's box.
//                   When the child is square it is a circle; when
//                   it is a rectangle it is an ellipse.
//   * ClipPath   -- clip to an arbitrary Path. The path is supplied
//                   either by a CustomClipper<Path> subclass, or via
//                   ClipPath.shape(...) which builds the path from a
//                   ShapeBorder. Inside the d4rt sandbox we cannot
//                   subclass at runtime, so we rely on the .shape
//                   convenience constructor and on the ShapeBorder
//                   library (StadiumBorder, ContinuousRectangleBorder,
//                   BeveledRectangleBorder, RoundedRectangleBorder,
//                   CircleBorder).
//
// The Clip enum controls the antialiasing strategy:
//
//   * Clip.none                     -- do NOT clip at all. The widget
//                                      reserves the layout slot but
//                                      pixels outside leak through.
//                                      Cheapest. Use when you can
//                                      mathematically guarantee no
//                                      overflow.
//   * Clip.hardEdge                 -- clip with a 1-pixel hard mask.
//                                      Cheap, jagged on diagonals and
//                                      curves.
//   * Clip.antiAlias                -- clip with a smooth alpha mask.
//                                      Default for ClipRRect, ClipOval,
//                                      ClipPath. Slightly more
//                                      expensive than hardEdge.
//   * Clip.antiAliasWithSaveLayer   -- as above, plus an offscreen
//                                      saveLayer to make the clip
//                                      composite cleanly with blend
//                                      modes. Most expensive; only
//                                      use when antialias seams are
//                                      visible at the edge of a
//                                      complex composited child.
//
// Theme: INK BLACK + NEON PINK + CREAM. Each plate looks like a
// page from a printer's specimen book where samples of clip shapes
// are pasted onto a cream sheet with neon-pink registration marks.
// =====================================================================

import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// Color palette: ink-black + neon-pink + cream specimen book.
// ---------------------------------------------------------------------
const Color _kInkBlack = Color(0xFF0E0B12);
const Color _kInkSoft = Color(0xFF1F1A26);
const Color _kCream = Color(0xFFF7EFDB);
const Color _kCreamDeep = Color(0xFFEBDFC1);
const Color _kNeonPink = Color(0xFFFF2E88);
const Color _kNeonPinkSoft = Color(0xFFFF7AB6);
const Color _kNeonPinkGlow = Color(0xFFFFB8D8);
const Color _kAccentTeal = Color(0xFF24C7C0);
const Color _kAccentTealSoft = Color(0xFF7CE1DD);
const Color _kAccentLime = Color(0xFFB8E84B);
const Color _kAccentSun = Color(0xFFF7C948);
const Color _kAccentBlood = Color(0xFFB8243A);
const Color _kAccentRoyal = Color(0xFF3A39B5);
const Color _kAccentPlum = Color(0xFF6B2A78);
const Color _kAccentDust = Color(0xFFB89A78);
const Color _kRegisterMark = Color(0xFFFF2E88);
const Color _kPaperShadow = Color(0x55000000);

// =====================================================================
// ENTRY POINT
// =====================================================================
dynamic build(BuildContext context) {
  print('==========================================================');
  print(' clipping_test.dart -- Flutter clipping widget tour');
  print(' Theme: ink-black + neon-pink + cream specimen book');
  print('==========================================================');
  print('Standard clipping widgets covered:');
  print('  * ClipRect    -- rectangular clip to layout bounds.');
  print('  * ClipRRect   -- rounded-rectangle clip with BorderRadius.');
  print('  * ClipOval    -- ellipse inscribed in the layout box.');
  print('  * ClipPath    -- arbitrary path via ShapeBorder.');
  print('Clip enum behaviors covered:');
  print('  * Clip.none, Clip.hardEdge, Clip.antiAlias,');
  print('  * Clip.antiAliasWithSaveLayer.');
  print('----------------------------------------------------------');

  return Container(
    color: _kCream,
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _section1Banner(),
        const SizedBox(height: 28),
        _section2ClipEnumAnatomy(),
        const SizedBox(height: 28),
        _section3ClipRectGallery(),
        const SizedBox(height: 28),
        _section4ClipRRectGallery(),
        const SizedBox(height: 28),
        _section5ClipOvalGallery(),
        const SizedBox(height: 28),
        _section6ClipPathGallery(),
        const SizedBox(height: 28),
        _section7CustomClipperPanel(),
        const SizedBox(height: 28),
        _section8PerformanceNotes(),
        const SizedBox(height: 28),
        _section9Recap(),
        const SizedBox(height: 16),
      ],
    ),
  );
}

// =====================================================================
// SECTION 1: TITLE BANNER
// ---------------------------------------------------------------------
// Specimen-book cover plate. Ink-black ground, neon-pink registration
// marks at corners, cream title bar across the middle. Built with a
// Stack so we can overlap the registration marks freely.
// =====================================================================
Widget _section1Banner() {
  print('=== Section 1: Title banner ===');
  print('Banner uses Stack + Positioned + LinearGradient.');
  print('Outer height fixed at 168.');
  print('Registration marks are crosshairs in neon pink.');

  return Container(
    height: 168,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kInkBlack, width: 2),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: _kPaperShadow,
          offset: Offset(0, 6),
          blurRadius: 16,
        ),
      ],
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_kInkBlack, _kInkSoft, _kInkBlack],
      ),
    ),
    child: Stack(
      children: <Widget>[
        // Faint pink stripe band across the middle.
        Positioned(
          top: 60,
          left: 0,
          right: 0,
          height: 36,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  _kNeonPink.withValues(alpha: 0.0),
                  _kNeonPink.withValues(alpha: 0.85),
                  _kNeonPinkSoft.withValues(alpha: 0.95),
                  _kNeonPink.withValues(alpha: 0.85),
                  _kNeonPink.withValues(alpha: 0.0),
                ],
                stops: const <double>[0.0, 0.2, 0.5, 0.8, 1.0],
              ),
            ),
          ),
        ),
        // Registration cross top-left.
        Positioned(left: 12, top: 12, child: _registrationMark()),
        // Registration cross top-right.
        Positioned(right: 12, top: 12, child: _registrationMark()),
        // Registration cross bottom-left.
        Positioned(left: 12, bottom: 12, child: _registrationMark()),
        // Registration cross bottom-right.
        Positioned(right: 12, bottom: 12, child: _registrationMark()),
        // Title.
        Padding(
          padding: const EdgeInsets.fromLTRB(80, 22, 80, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text(
                'SPECIMEN  09  --  CLIPPING  WIDGETS',
                style: TextStyle(
                  color: _kCream,
                  fontSize: 12,
                  letterSpacing: 4,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Clip the world to a shape',
                style: TextStyle(
                  color: _kCream,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'ClipRect / ClipRRect / ClipOval / ClipPath',
                style: TextStyle(
                  color: _kNeonPinkSoft,
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
        ),
        // Plate number circle.
        Positioned(
          right: 22,
          bottom: 22,
          child: Container(
            width: 56,
            height: 56,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _kNeonPink,
              shape: BoxShape.circle,
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x88FF2E88),
                  blurRadius: 10,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: const Text(
              '09',
              style: TextStyle(
                color: _kInkBlack,
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// Registration crosshair used at banner corners.
Widget _registrationMark() {
  return SizedBox(
    width: 28,
    height: 28,
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 28,
          height: 2,
          decoration: const BoxDecoration(color: _kRegisterMark),
        ),
        Container(
          width: 2,
          height: 28,
          decoration: const BoxDecoration(color: _kRegisterMark),
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _kRegisterMark, width: 1.4),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 2: CLIP ENUM ANATOMY
// ---------------------------------------------------------------------
// Four side-by-side panels comparing the four Clip values:
// none / hardEdge / antiAlias / antiAliasWithSaveLayer.
// We render the same circular content under each clipBehavior so the
// visual quality and conceptual difference are obvious side by side.
// =====================================================================
Widget _section2ClipEnumAnatomy() {
  print('=== Section 2: Clip enum anatomy ===');
  print('Comparing the four Clip enum values:');
  print('  Clip.none                     => no clip; child can spill.');
  print('  Clip.hardEdge                 => 1px hard alpha mask.');
  print('  Clip.antiAlias                => smooth alpha mask.');
  print('  Clip.antiAliasWithSaveLayer   => smooth + offscreen layer.');

  return _platePanel(
    title: '2. The Clip enum',
    subtitle: 'Four antialiasing strategies, four trade-offs.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _clipEnumPanel(
              label: 'Clip.none',
              caption: 'no clip; pixels spill',
              behavior: Clip.none,
              swatch: _kAccentSun,
            )),
            const SizedBox(width: 10),
            Expanded(child: _clipEnumPanel(
              label: 'Clip.hardEdge',
              caption: '1px hard mask',
              behavior: Clip.hardEdge,
              swatch: _kAccentTeal,
            )),
            const SizedBox(width: 10),
            Expanded(child: _clipEnumPanel(
              label: 'Clip.antiAlias',
              caption: 'smooth alpha mask',
              behavior: Clip.antiAlias,
              swatch: _kNeonPink,
            )),
            const SizedBox(width: 10),
            Expanded(child: _clipEnumPanel(
              label: 'antiAlias+SL',
              caption: 'smooth + saveLayer',
              behavior: Clip.antiAliasWithSaveLayer,
              swatch: _kAccentRoyal,
            )),
          ],
        ),
        const SizedBox(height: 14),
        _enumLegend(),
      ],
    ),
  );
}

// One Clip enum demonstration panel.
Widget _clipEnumPanel({
  required String label,
  required String caption,
  required Clip behavior,
  required Color swatch,
}) {
  // We use an OverflowBox so the child paints LARGER than its slot.
  // With Clip.none the larger child leaks; with the other three it is
  // cropped, with progressively smoother edges.
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kCreamDeep,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kInkBlack, width: 1),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: _kInkBlack,
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: const TextStyle(
              color: _kCream,
              fontFamily: 'monospace',
              fontSize: 10,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Stage where the clipping behavior is shown.
        Container(
          height: 90,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kCream,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: _kInkBlack, width: 0.6),
          ),
          child: SizedBox(
            width: 60,
            height: 60,
            child: ClipOval(
              clipBehavior: behavior,
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[swatch, _kInkBlack],
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  label.split('.').last,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: _kCream,
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          caption,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: _kInkBlack.withValues(alpha: 0.75),
            fontSize: 10,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// Legend explaining trade-offs.
Widget _enumLegend() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kInkBlack,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Text(
          'Antialiasing trade-off ladder',
          style: TextStyle(
            color: _kNeonPinkGlow,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'none < hardEdge < antiAlias < antiAliasWithSaveLayer',
          style: TextStyle(
            color: _kCream,
            fontFamily: 'monospace',
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Going right = smoother edges, more GPU work. saveLayer is '
          'expensive: it allocates an offscreen bitmap, paints the '
          'subtree into it, then composites the masked result. Reach '
          'for it ONLY when you see seams between an antialiased clip '
          'and a child that uses blend modes.',
          style: TextStyle(
            color: _kCreamDeep,
            fontSize: 11,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 3: ClipRect GALLERY
// ---------------------------------------------------------------------
// ClipRect clips a child to its own paint rectangle. This is mainly
// useful when a child intentionally paints outside its layout bounds,
// for example via OverflowBox, Transform, or by drawing a shadow.
// We show several scenarios where ClipRect contains paint.
// =====================================================================
Widget _section3ClipRectGallery() {
  print('=== Section 3: ClipRect gallery ===');
  print('ClipRect is the simplest clipper: it clips to the child rect.');
  print('Used to confine widgets that paint outside their own bounds.');

  return _platePanel(
    title: '3. ClipRect gallery',
    subtitle: 'Confine a paint that wants to spill.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: <Widget>[
            _clipRectCardPlain(),
            _clipRectCardOverflow(),
            _clipRectCardScalingChild(),
            _clipRectCardGradientStripe(),
            _clipRectCardWindowSlot(),
            _clipRectCardScrollViewport(),
          ],
        ),
        const SizedBox(height: 14),
        _captionBlock(
          'ClipRect is a no-rounding axis-aligned mask. The child still '
          'lays out and paints into the same canvas region; ClipRect just '
          'asks the rasterizer to discard pixels that fall outside the '
          'child\'s rectangle. It is the cheapest clip widget.',
        ),
      ],
    ),
  );
}

Widget _clipRectCardPlain() {
  return _galleryCard(
    title: 'plain',
    subtitle: 'rect == child rect',
    child: SizedBox(
      width: 130,
      height: 90,
      child: ClipRect(
        clipBehavior: Clip.hardEdge,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[_kNeonPink, _kAccentSun],
            ),
          ),
          alignment: Alignment.center,
          child: const Text(
            'ClipRect',
            style: TextStyle(
              color: _kInkBlack,
              fontWeight: FontWeight.w800,
              fontSize: 13,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _clipRectCardOverflow() {
  return _galleryCard(
    title: 'overflow',
    subtitle: 'OverflowBox child',
    child: SizedBox(
      width: 130,
      height: 90,
      child: ClipRect(
        clipBehavior: Clip.hardEdge,
        child: OverflowBox(
          minWidth: 0,
          minHeight: 0,
          maxWidth: 220,
          maxHeight: 160,
          alignment: Alignment.center,
          child: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: <Color>[_kAccentTeal, _kInkBlack],
              ),
            ),
            alignment: Alignment.center,
            child: const Text(
              'OVERFLOW\n(220x160)',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _kCream,
                fontWeight: FontWeight.w700,
                fontSize: 11,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _clipRectCardScalingChild() {
  return _galleryCard(
    title: 'scaled child',
    subtitle: 'Transform.scale 1.6x',
    child: SizedBox(
      width: 130,
      height: 90,
      child: ClipRect(
        clipBehavior: Clip.hardEdge,
        child: Transform.scale(
          scale: 1.6,
          alignment: Alignment.center,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[_kAccentLime, _kAccentTeal, _kAccentRoyal],
              ),
            ),
            alignment: Alignment.center,
            child: const Text(
              'scale 1.6',
              style: TextStyle(
                color: _kInkBlack,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _clipRectCardGradientStripe() {
  return _galleryCard(
    title: 'gradient',
    subtitle: 'wide stripe',
    child: SizedBox(
      width: 130,
      height: 90,
      child: ClipRect(
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                _kAccentBlood,
                _kNeonPink,
                _kAccentSun,
                _kAccentLime,
                _kAccentTeal,
                _kAccentRoyal,
                _kAccentPlum,
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget _clipRectCardWindowSlot() {
  return _galleryCard(
    title: 'window',
    subtitle: 'inset content',
    child: SizedBox(
      width: 130,
      height: 90,
      child: ClipRect(
        clipBehavior: Clip.hardEdge,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(color: _kInkBlack),
            ),
            Positioned(
              left: -20,
              top: -20,
              right: -20,
              bottom: -20,
              child: Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    radius: 0.85,
                    colors: <Color>[
                      _kNeonPinkGlow.withValues(alpha: 0.95),
                      _kNeonPink.withValues(alpha: 0.7),
                      _kInkBlack.withValues(alpha: 0.95),
                    ],
                  ),
                ),
              ),
            ),
            const Center(
              child: Text(
                'WINDOW',
                style: TextStyle(
                  color: _kCream,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w800,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _clipRectCardScrollViewport() {
  return _galleryCard(
    title: 'viewport',
    subtitle: 'simulated scroll',
    child: SizedBox(
      width: 130,
      height: 90,
      child: ClipRect(
        clipBehavior: Clip.hardEdge,
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              left: -10,
              top: -10,
              child: Container(
                width: 200,
                height: 30,
                decoration: const BoxDecoration(color: _kAccentTeal),
                alignment: Alignment.center,
                child: const Text(
                  'row 1',
                  style: TextStyle(color: _kInkBlack, fontSize: 11),
                ),
              ),
            ),
            Positioned(
              left: -10,
              top: 30,
              child: Container(
                width: 200,
                height: 30,
                decoration: const BoxDecoration(color: _kAccentSun),
                alignment: Alignment.center,
                child: const Text(
                  'row 2',
                  style: TextStyle(color: _kInkBlack, fontSize: 11),
                ),
              ),
            ),
            Positioned(
              left: -10,
              top: 70,
              child: Container(
                width: 200,
                height: 30,
                decoration: const BoxDecoration(color: _kNeonPink),
                alignment: Alignment.center,
                child: const Text(
                  'row 3',
                  style: TextStyle(color: _kInkBlack, fontSize: 11),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// =====================================================================
// SECTION 4: ClipRRect GALLERY
// ---------------------------------------------------------------------
// ClipRRect clips to a rounded rectangle. The corner radii are
// described by a BorderRadius. We show many BorderRadius variants:
// circular, all-corner, only top, only bottom, only one corner,
// elliptical, asymmetric.
// =====================================================================
Widget _section4ClipRRectGallery() {
  print('=== Section 4: ClipRRect gallery ===');
  print('ClipRRect uses BorderRadius and is the most common clipper.');
  print('Variants: circular, only-corners, elliptical, asymmetric.');

  return _platePanel(
    title: '4. ClipRRect gallery',
    subtitle: 'Rounded rectangles, every flavour.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: <Widget>[
            _rrectCard(
              title: 'circular(0)',
              subtitle: 'square',
              radius: BorderRadius.zero,
            ),
            _rrectCard(
              title: 'circular(8)',
              subtitle: 'subtle',
              radius: BorderRadius.circular(8),
            ),
            _rrectCard(
              title: 'circular(20)',
              subtitle: 'card',
              radius: BorderRadius.circular(20),
            ),
            _rrectCard(
              title: 'circular(60)',
              subtitle: 'pill',
              radius: BorderRadius.circular(60),
            ),
            _rrectCard(
              title: 'top only',
              subtitle: 'tab head',
              radius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            _rrectCard(
              title: 'bottom only',
              subtitle: 'sheet',
              radius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            _rrectCard(
              title: 'one corner',
              subtitle: 'topLeft 40',
              radius: const BorderRadius.only(
                topLeft: Radius.circular(40),
              ),
            ),
            _rrectCard(
              title: 'asymmetric',
              subtitle: 'TL 28 / BR 8',
              radius: const BorderRadius.only(
                topLeft: Radius.circular(28),
                topRight: Radius.circular(4),
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(28),
              ),
            ),
            _rrectCard(
              title: 'elliptical',
              subtitle: 'X != Y',
              radius: const BorderRadius.all(
                Radius.elliptical(40, 14),
              ),
            ),
            _rrectCard(
              title: 'horizontal',
              subtitle: 'left only',
              radius: const BorderRadius.horizontal(
                left: Radius.circular(28),
              ),
            ),
            _rrectCard(
              title: 'vertical',
              subtitle: 'top only',
              radius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            _rrectCard(
              title: 'staircase',
              subtitle: 'increasing',
              radius: const BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(48),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _captionBlock(
          'ClipRRect almost always wants Clip.antiAlias (its default). '
          'For tight radii on busy gradients antiAliasWithSaveLayer can '
          'remove the faint seam at the corner where the gradient meets '
          'the rounded edge.',
        ),
      ],
    ),
  );
}

Widget _rrectCard({
  required String title,
  required String subtitle,
  required BorderRadius radius,
}) {
  return _galleryCard(
    title: title,
    subtitle: subtitle,
    child: SizedBox(
      width: 130,
      height: 90,
      child: ClipRRect(
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: _rrectFiller(title),
      ),
    ),
  );
}

Widget _rrectFiller(String label) {
  // Vivid filler that makes the clipped corner visible.
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          _kNeonPink,
          _kAccentSun,
          _kAccentLime,
          _kAccentTeal,
        ],
        stops: <double>[0.0, 0.4, 0.7, 1.0],
      ),
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: const TextStyle(
        color: _kInkBlack,
        fontWeight: FontWeight.w800,
        fontSize: 11,
      ),
    ),
  );
}

// =====================================================================
// SECTION 5: ClipOval GALLERY
// ---------------------------------------------------------------------
// ClipOval clips to the ellipse inscribed in the child's box.
// Square box  -> circle.
// Rectangle   -> ellipse.
// We demonstrate avatar-style circles, wide ellipses, and stacked
// portrait clips.
// =====================================================================
Widget _section5ClipOvalGallery() {
  print('=== Section 5: ClipOval gallery ===');
  print('ClipOval inscribes an ellipse into the child\'s rectangle.');
  print('Square box => circle; rectangle box => ellipse.');

  return _platePanel(
    title: '5. ClipOval gallery',
    subtitle: 'Circles, ellipses, and avatars.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: <Widget>[
            _ovalCard(
              title: 'circle 96',
              subtitle: 'square box',
              size: const Size(96, 96),
              filler: _ovalFillerSolid(_kNeonPink),
            ),
            _ovalCard(
              title: 'circle 64',
              subtitle: 'avatar',
              size: const Size(64, 64),
              filler: _ovalFillerInitials('JD'),
            ),
            _ovalCard(
              title: 'wide ellipse',
              subtitle: '160 x 70',
              size: const Size(160, 70),
              filler: _ovalFillerGradient(<Color>[
                _kAccentTeal,
                _kAccentRoyal,
              ]),
            ),
            _ovalCard(
              title: 'tall ellipse',
              subtitle: '70 x 140',
              size: const Size(70, 140),
              filler: _ovalFillerGradient(<Color>[
                _kAccentSun,
                _kAccentBlood,
              ]),
            ),
            _ovalCard(
              title: 'tiny dot',
              subtitle: '24 x 24',
              size: const Size(24, 24),
              filler: _ovalFillerSolid(_kAccentLime),
            ),
            _ovalCard(
              title: 'big head',
              subtitle: '120 x 120',
              size: const Size(120, 120),
              filler: _ovalFillerInitials('AM'),
            ),
            _ovalCard(
              title: 'lozenge',
              subtitle: '180 x 50',
              size: const Size(180, 50),
              filler: _ovalFillerGradient(<Color>[
                _kAccentPlum,
                _kNeonPink,
                _kAccentSun,
              ]),
            ),
            _ovalCard(
              title: 'iris',
              subtitle: 'radial',
              size: const Size(96, 96),
              filler: Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: <Color>[
                      _kCream,
                      _kAccentTeal,
                      _kAccentRoyal,
                      _kInkBlack,
                    ],
                    stops: <double>[0.0, 0.45, 0.7, 1.0],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _captionBlock(
          'ClipOval is rarely used to clip a non-square box, so most '
          'production code uses it for circular avatars. It picks Clip.'
          'antiAlias by default, which gives a clean antialiased '
          'circular silhouette.',
        ),
      ],
    ),
  );
}

Widget _ovalCard({
  required String title,
  required String subtitle,
  required Size size,
  required Widget filler,
}) {
  return _galleryCard(
    title: title,
    subtitle: subtitle,
    child: SizedBox(
      width: 192,
      height: 168,
      child: Center(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: ClipOval(
            clipBehavior: Clip.antiAlias,
            child: filler,
          ),
        ),
      ),
    ),
  );
}

Widget _ovalFillerSolid(Color c) {
  return Container(decoration: BoxDecoration(color: c));
}

Widget _ovalFillerGradient(List<Color> colors) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: colors,
      ),
    ),
  );
}

Widget _ovalFillerInitials(String initials) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[_kNeonPink, _kAccentPlum, _kInkBlack],
      ),
    ),
    alignment: Alignment.center,
    child: Text(
      initials,
      style: const TextStyle(
        color: _kCream,
        fontWeight: FontWeight.w900,
        fontSize: 22,
        letterSpacing: 1.4,
      ),
    ),
  );
}

// =====================================================================
// SECTION 6: ClipPath GALLERY
// ---------------------------------------------------------------------
// ClipPath clips to an arbitrary path. In the d4rt sandbox we cannot
// subclass CustomClipper at runtime so we use ClipPath.shape(...) which
// derives its path from a ShapeBorder. This covers a surprising amount
// of the design vocabulary:
//
//   * StadiumBorder            -- classic pill shape.
//   * ContinuousRectangleBorder-- iOS-style "smooth" rounded corners.
//   * BeveledRectangleBorder   -- chamfered corners.
//   * RoundedRectangleBorder   -- standard rounded rect.
//   * CircleBorder             -- inscribed circle.
// =====================================================================
Widget _section6ClipPathGallery() {
  print('=== Section 6: ClipPath gallery ===');
  print('ClipPath.shape() derives its path from any ShapeBorder.');
  print('No runtime subclass needed -- great for d4rt sandbox.');

  return _platePanel(
    title: '6. ClipPath gallery',
    subtitle: 'Arbitrary shapes from ShapeBorder.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: <Widget>[
            _pathCard(
              title: 'StadiumBorder',
              subtitle: 'pill',
              shape: const StadiumBorder(),
              size: const Size(180, 70),
            ),
            _pathCard(
              title: 'Continuous',
              subtitle: 'iOS smooth',
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
              size: const Size(150, 100),
            ),
            _pathCard(
              title: 'Beveled',
              subtitle: 'chamfered',
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              size: const Size(150, 100),
            ),
            _pathCard(
              title: 'Rounded',
              subtitle: 'standard',
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              size: const Size(150, 100),
            ),
            _pathCard(
              title: 'Circle',
              subtitle: 'inscribed',
              shape: const CircleBorder(),
              size: const Size(110, 110),
            ),
            _pathCard(
              title: 'Rounded asym',
              subtitle: 'TL/BR vs TR/BL',
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
              ),
              size: const Size(150, 100),
            ),
            _pathCard(
              title: 'Beveled deep',
              subtitle: 'octagon-like',
              shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              size: const Size(150, 100),
            ),
            _pathCard(
              title: 'Continuous wide',
              subtitle: 'big radius',
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              size: const Size(180, 80),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _captionBlock(
          'ClipPath.shape forwards (size, textDirection) to the '
          'ShapeBorder.getOuterPath method. Because ShapeBorder paths are '
          'parametric (not bitmap), the resulting clip looks crisp at any '
          'size and any device pixel ratio.',
        ),
      ],
    ),
  );
}

Widget _pathCard({
  required String title,
  required String subtitle,
  required ShapeBorder shape,
  required Size size,
}) {
  return _galleryCard(
    title: title,
    subtitle: subtitle,
    child: SizedBox(
      width: 200,
      height: 140,
      child: Center(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: ClipPath.shape(
            shape: shape,
            clipBehavior: Clip.antiAlias,
            child: _pathFiller(title),
          ),
        ),
      ),
    ),
  );
}

Widget _pathFiller(String label) {
  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          _kAccentRoyal,
          _kAccentTeal,
          _kAccentLime,
          _kAccentSun,
          _kNeonPink,
        ],
        stops: <double>[0.0, 0.25, 0.5, 0.75, 1.0],
      ),
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: const TextStyle(
        color: _kInkBlack,
        fontWeight: FontWeight.w800,
        fontSize: 12,
        letterSpacing: 0.4,
      ),
    ),
  );
}

// =====================================================================
// SECTION 7: CustomClipper TEXT PANEL
// ---------------------------------------------------------------------
// We cannot subclass CustomClipper<Path> in the d4rt sandbox because
// the renderer cannot resolve a user-defined subclass back into a real
// dart:ui Path at paint time. Instead we present the canonical pattern
// as code-text so the reader still sees how it would be done in
// production.
// =====================================================================
Widget _section7CustomClipperPanel() {
  print('=== Section 7: CustomClipper text panel ===');
  print('Custom subclasses cannot be rendered in the d4rt sandbox.');
  print('Showing the canonical CustomClipper<Path> pattern as text.');

  const String code =
      'class WaveClipper extends CustomClipper<Path> {\n'
      '  @override\n'
      '  Path getClip(Size size) {\n'
      '    final path = Path();\n'
      '    path.lineTo(0, size.height - 20);\n'
      '    path.quadraticBezierTo(\n'
      '      size.width * 0.25, size.height,\n'
      '      size.width * 0.5,  size.height - 20,\n'
      '    );\n'
      '    path.quadraticBezierTo(\n'
      '      size.width * 0.75, size.height - 40,\n'
      '      size.width,        size.height - 20,\n'
      '    );\n'
      '    path.lineTo(size.width, 0);\n'
      '    path.close();\n'
      '    return path;\n'
      '  }\n'
      '\n'
      '  @override\n'
      '  bool shouldReclip(WaveClipper oldClipper) => false;\n'
      '}\n'
      '\n'
      '// usage:\n'
      'ClipPath(\n'
      '  clipper: WaveClipper(),\n'
      '  clipBehavior: Clip.antiAlias,\n'
      '  child: HeroBackground(),\n'
      ')';

  return _platePanel(
    title: '7. CustomClipper pattern',
    subtitle: 'Code-text panel (sandbox cannot render runtime subclasses).',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _codeBlock(code),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _bulletBlock(
                title: 'Why subclass?',
                bullets: const <String>[
                  'You need a path that is not a ShapeBorder.',
                  'You want to depend on dynamic state (audio level, '
                      'progress, scroll offset) inside getClip.',
                  'You need shouldReclip to skip rebuilding the path '
                      'when inputs do not actually change.',
                ],
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _bulletBlock(
                title: 'Two methods',
                bullets: const <String>[
                  'getClip(Size size) -- build the Path for the given '
                      'layout size.',
                  'shouldReclip(old) -- return true to invalidate the '
                      'cached path. Keep this cheap.',
                  'Optional getApproximateClipRect for hit-testing.',
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _captionBlock(
          'In production code, prefer ClipPath.shape with a ShapeBorder '
          'whenever possible: it caches better, supports text direction, '
          'composes with InkWell, and avoids a custom shouldReclip '
          'implementation.',
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kInkBlack,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _kNeonPink, width: 1),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: _kCream,
        fontFamily: 'monospace',
        fontSize: 11,
        height: 1.45,
      ),
    ),
  );
}

Widget _bulletBlock({required String title, required List<String> bullets}) {
  final List<Widget> lines = <Widget>[];
  for (final String b in bullets) {
    lines.add(
      Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(top: 6, right: 8),
              decoration: const BoxDecoration(
                color: _kNeonPink,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Text(
                b,
                style: const TextStyle(
                  color: _kInkBlack,
                  fontSize: 11,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kCreamDeep,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _kInkBlack, width: 0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            color: _kInkBlack,
            fontWeight: FontWeight.w800,
            fontSize: 12,
            letterSpacing: 0.6,
          ),
        ),
        ...lines,
      ],
    ),
  );
}

// =====================================================================
// SECTION 8: PERFORMANCE NOTES
// ---------------------------------------------------------------------
// Mini reference card with rough cost ranking and common pitfalls.
// =====================================================================
Widget _section8PerformanceNotes() {
  print('=== Section 8: Performance notes ===');
  print('Cost ranking: ClipRect ~ ClipRRect (small radius) <');
  print('              ClipPath simple < ClipPath complex <<');
  print('              any clip with antiAliasWithSaveLayer.');

  return _platePanel(
    title: '8. Performance notes',
    subtitle: 'Cheap clips, expensive clips, common pitfalls.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _perfPanel(
              accent: _kAccentLime,
              title: 'Cheap',
              lines: const <String>[
                'ClipRect over a stable child.',
                'ClipRRect with small uniform radius.',
                'ClipOval over a square avatar (cached).',
                'Clip.hardEdge when edges are axis-aligned.',
              ],
            )),
            const SizedBox(width: 12),
            Expanded(child: _perfPanel(
              accent: _kAccentSun,
              title: 'Watch',
              lines: const <String>[
                'Animated BorderRadius -- recalculates every frame.',
                'Many nested ClipPaths -- each adds a draw step.',
                'ClipPath inside a list item -- clipping cost x N.',
                'Clip.antiAlias on tiny shapes -- AA cost dominates.',
              ],
            )),
            const SizedBox(width: 12),
            Expanded(child: _perfPanel(
              accent: _kAccentBlood,
              title: 'Expensive',
              lines: const <String>[
                'Clip.antiAliasWithSaveLayer (offscreen buffer).',
                'CustomClipper that returns a brand new Path each frame.',
                'shouldReclip that always returns true.',
                'ClipPath wrapping a subtree with shadows + filters.',
              ],
            )),
          ],
        ),
        const SizedBox(height: 14),
        _captionBlock(
          'Rule of thumb: pick the lightest clip widget that can express '
          'the shape you want. A circular avatar wants ClipOval, not a '
          'CustomClipper. A pill shape wants ClipPath.shape with '
          'StadiumBorder, not a hand-rolled path.',
        ),
        const SizedBox(height: 12),
        _checklistBlock(),
      ],
    ),
  );
}

Widget _perfPanel({
  required Color accent,
  required String title,
  required List<String> lines,
}) {
  final List<Widget> body = <Widget>[];
  for (final String l in lines) {
    body.add(
      Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 6,
              height: 6,
              margin: const EdgeInsets.only(top: 6, right: 8),
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Text(
                l,
                style: const TextStyle(
                  color: _kCream,
                  fontSize: 11,
                  height: 1.35,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kInkBlack,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: accent, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(
              color: _kInkBlack,
              fontSize: 10,
              letterSpacing: 1.6,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        ...body,
      ],
    ),
  );
}

Widget _checklistBlock() {
  const List<String> items = <String>[
    'Did you really need a clip, or would a Container with a '
        'BorderRadius and a child paint inside it have sufficed?',
    'Could you replace the clip with a DecoratedBox + BoxDecoration so '
        'the painter does the corner work natively?',
    'If you must clip, is the clip widget as far DOWN the tree as '
        'possible? A clip near the leaf is cheaper than one wrapping a '
        'whole subtree.',
    'For animated clips, is shouldReclip returning false when inputs '
        'have not actually changed?',
    'For dialogs and pages, can you skip antiAliasWithSaveLayer and '
        'accept a 1px seam to save the offscreen buffer?',
  ];
  final List<Widget> rows = <Widget>[];
  int idx = 1;
  for (final String it in items) {
    rows.add(
      Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: _kNeonPink,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                idx.toString(),
                style: const TextStyle(
                  color: _kInkBlack,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                ),
              ),
            ),
            Expanded(
              child: Text(
                it,
                style: const TextStyle(
                  color: _kInkBlack,
                  fontSize: 11,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    idx++;
  }
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kCreamDeep,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kInkBlack, width: 0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const Text(
          'Pre-flight checklist',
          style: TextStyle(
            color: _kInkBlack,
            fontWeight: FontWeight.w800,
            fontSize: 12,
            letterSpacing: 0.6,
          ),
        ),
        ...rows,
      ],
    ),
  );
}

// =====================================================================
// SECTION 9: RECAP CARD
// ---------------------------------------------------------------------
// Closing card. Small grid of one-liners for each clipping widget,
// plus a final reminder about Clip enum semantics.
// =====================================================================
Widget _section9Recap() {
  print('=== Section 9: Recap ===');
  print('Recap card with one-line summary per widget.');

  return _platePanel(
    title: '9. Recap',
    subtitle: 'One-liners per clipping widget.',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _recapCell(
              accent: _kNeonPink,
              widgetName: 'ClipRect',
              line: 'Clip a child to its own paint rectangle. Cheapest. '
                  'Use to confine paint that intentionally overflows.',
            )),
            const SizedBox(width: 10),
            Expanded(child: _recapCell(
              accent: _kAccentTeal,
              widgetName: 'ClipRRect',
              line: 'Clip to a rounded rectangle described by '
                  'BorderRadius. The default for cards, chips, '
                  'thumbnails.',
            )),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _recapCell(
              accent: _kAccentSun,
              widgetName: 'ClipOval',
              line: 'Clip to the inscribed ellipse. Square => circle, '
                  'rectangle => ellipse. Avatars and dots.',
            )),
            const SizedBox(width: 10),
            Expanded(child: _recapCell(
              accent: _kAccentRoyal,
              widgetName: 'ClipPath',
              line: 'Clip to a Path supplied by a CustomClipper or by '
                  'ClipPath.shape(...) with a ShapeBorder.',
            )),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kInkBlack,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text(
                'Clip enum cheatsheet',
                style: TextStyle(
                  color: _kNeonPinkGlow,
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.4,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'none -> no clip; child can spill.\n'
                'hardEdge -> 1px hard mask; cheapest real clip.\n'
                'antiAlias -> smooth alpha mask; default for all but '
                'ClipRect.\n'
                'antiAliasWithSaveLayer -> smooth + offscreen buffer; '
                'use only when seams show.',
                style: TextStyle(
                  color: _kCream,
                  fontFamily: 'monospace',
                  fontSize: 11,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Center(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              color: _kNeonPink,
              borderRadius: BorderRadius.circular(60),
              boxShadow: const <BoxShadow>[
                BoxShadow(
                  color: Color(0x66FF2E88),
                  blurRadius: 14,
                ),
              ],
            ),
            child: const Text(
              'END OF SPECIMEN 09',
              style: TextStyle(
                color: _kInkBlack,
                fontSize: 12,
                letterSpacing: 2.4,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _recapCell({
  required Color accent,
  required String widgetName,
  required String line,
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kCreamDeep,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: accent, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            widgetName,
            style: const TextStyle(
              color: _kInkBlack,
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          line,
          style: const TextStyle(
            color: _kInkBlack,
            fontSize: 11,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SHARED GALLERY CARD
// ---------------------------------------------------------------------
// Wraps a single clip sample with a labelled cream cell.
// =====================================================================
Widget _galleryCard({
  required String title,
  required String subtitle,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: _kCreamDeep,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _kInkBlack, width: 1),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x22000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: _kInkBlack,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: _kCream,
                  fontFamily: 'monospace',
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: _kInkBlack.withValues(alpha: 0.7),
                fontSize: 10,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        child,
      ],
    ),
  );
}

// =====================================================================
// SHARED CAPTION BLOCK
// ---------------------------------------------------------------------
// Small italicized caption used at the bottom of gallery sections.
// =====================================================================
Widget _captionBlock(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _kCreamDeep,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: _kInkBlack, width: 0.6),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: _kInkBlack,
        fontSize: 11,
        height: 1.4,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

// =====================================================================
// SHARED PLATE PANEL
// ---------------------------------------------------------------------
// Specimen-page wrapper. Each section is wrapped in a "plate" so the
// overall document reads like a printer's specimen book. The plate has
// a header strip (ink-black with neon-pink underline), a subtitle, and
// a body slot that the section fills with its own widgets.
// =====================================================================
Widget _platePanel({
  required String title,
  required String subtitle,
  required Widget body,
}) {
  return Container(
    decoration: BoxDecoration(
      color: _kCream,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _kInkBlack, width: 1.4),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: _kPaperShadow,
          blurRadius: 10,
          offset: Offset(0, 5),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Header strip with neon-pink underline.
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: const BoxDecoration(
            color: _kInkBlack,
            borderRadius: BorderRadius.vertical(top: Radius.circular(9)),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        color: _kCream,
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: _kNeonPinkGlow.withValues(alpha: 0.9),
                        fontSize: 11,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 56,
                height: 22,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _kNeonPink,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  'SPECIMEN',
                  style: TextStyle(
                    color: _kInkBlack,
                    fontSize: 9,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Neon underline strip.
        Container(
          height: 3,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[
                _kNeonPink,
                _kNeonPinkSoft,
                _kNeonPinkGlow,
                _kNeonPinkSoft,
                _kNeonPink,
              ],
            ),
          ),
        ),
        // Body.
        Padding(
          padding: const EdgeInsets.all(14),
          child: body,
        ),
      ],
    ),
  );
}
