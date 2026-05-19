// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, unused_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of the Scaffold/FloatingActionButton family.
//
// This file is part of the D4rt flutter-test corpus and is executed by an
// analyzer-free, sandboxed Dart interpreter. The script exports exactly one
// top-level entry point - `dynamic build(BuildContext)` - which the runtime
// invokes a single time. The returned widget tree is then handed straight
// to the host app's renderer.
//
// The rendered output is a long, static gallery that walks through Flutter's
// Scaffold FloatingActionButton subsystem. Eight thematic sections cover:
//
//   1. Hero intro - what a FloatingActionButton is, why Scaffold owns its
//      placement, and how the geometry pipeline (FAB + BAB + SnackBar)
//      cooperates through ScaffoldGeometry.
//   2. FAB anatomy - the surface of `FloatingActionButton`, the three named
//      constructors (.small, .large, .extended) and the public properties
//      (heroTag, mini, isExtended, foregroundColor, backgroundColor,
//      shape, elevation, focusElevation, hoverElevation, highlightElevation,
//      splashColor, materialTapTargetSize, clipBehavior, enableFeedback).
//   3. FAB size variant comparison - default / small / large / extended drawn
//      side-by-side with annotations.
//   4. FAB location gallery - a 4x5 grid of mock Scaffold viewports, one per
//      `FloatingActionButtonLocation` constant. Every named location in the
//      framework is represented: startTop, centerTop, endTop, miniStartTop,
//      miniCenterTop, miniEndTop, startFloat, centerFloat, endFloat,
//      miniStartFloat, miniCenterFloat, miniEndFloat, startDocked,
//      centerDocked, endDocked, miniStartDocked, miniCenterDocked,
//      miniEndDocked, endContained. The viewports are *painted mocks* (plain
//      Containers) - they do not host a real Scaffold, so the demo stays
//      analyzer-clean inside the d4rt sandbox.
//   5. FloatingActionButtonAnimator - a card explaining the
//      enter/exit/scale-in/scale-out callback that drives FAB swap animations,
//      plus the two built-in animators (scaling, noAnimation).
//   6. BottomAppBar + FAB notch - a wide mock viewport showing the canonical
//      "FAB docked into a notched BottomAppBar" composition with the notch
//      margin/clip behaviour annotated.
//   7. ScaffoldFeatureController card - a card explaining the controller type
//      returned by `ScaffoldMessenger.of(context).showSnackBar(...)`,
//      `Scaffold.of(context).showBottomSheet(...)`, and the now-deprecated
//      `Scaffold.of(context).showSnackBar` path. Documents `closed`, `close`,
//      `setState`, and the difference between `SnackBarClosedReason` and
//      `MaterialBannerClosedReason`.
//   8. Recipes + pitfalls - eight idiomatic snippets and six callouts
//      (heroTag collisions, missing Scaffold ancestor, FAB inside Hero,
//      docked FAB without a BottomAppBar, FAB during keyboard inset,
//      ScaffoldMessenger vs Scaffold.of).
//
// Build-time discipline: no `setState`, no `Timer`, no `Future`/`Stream`,
// no `async`, no live `AnimationController`, no `for-in` over a bridged
// instance returned from a Flutter API, and no `Tween.animate(...).value`
// reads. FABs in the gallery use `onPressed: () {}` placeholders so that the
// callback exists but never fires under the static interpreter pass.
import 'dart:math' as math;
import 'dart:ui' show FontFeature;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// Literal ARGB values keep the demo theme-independent. The palette is built
// around a soft "blueprint" feeling - cool greys plus accent blue/violet -
// because the demo presents Scaffold geometry as a layout blueprint.
const Color _kCanvas = Color(0xFFF3F4F8);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardSoft = Color(0xFFF7F8FB);
const Color _kCardDark = Color(0xFF1B1D2A);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF1A1C25);
const Color _kInkSecondary = Color(0xFF424657);
const Color _kInkTertiary = Color(0xFF8C90A1);
const Color _kInkOnDark = Color(0xFFEDEEF5);
const Color _kInkOnDarkSecondary = Color(0xFFA3A6B8);
const Color _kAccent = Color(0xFF2563EB); // blue
const Color _kAccentSoft = Color(0xFFEFF6FF);
const Color _kAccentViolet = Color(0xFF7C3AED);
const Color _kAccentTeal = Color(0xFF0D9488);
const Color _kAccentGreen = Color(0xFF16A34A);
const Color _kAccentAmber = Color(0xFFD97706);
const Color _kAccentRose = Color(0xFFE11D48);
const Color _kAccentPink = Color(0xFFEC4899);
const Color _kFabFill = Color(0xFF2563EB);
const Color _kFabFillSecondary = Color(0xFF7C3AED);
const Color _kFabOnFill = Color(0xFFFFFFFF);
const Color _kViewportBg = Color(0xFFF1F3F8);
const Color _kAppBarMock = Color(0xFFCBD5E1);
const Color _kBodyMock = Color(0xFFE5E7EB);
const Color _kBottomBarMock = Color(0xFF94A3B8);
const Color _kBabSurface = Color(0xFFFFFFFF);
const Color _kCodeBg = Color(0xFF1E1F22);
const Color _kCodeText = Color(0xFFE6E6E6);
const Color _kCodeAccent = Color(0xFF7DD3FC);
const Color _kCodeKeyword = Color(0xFFFFA657);
const Color _kCodeString = Color(0xFFA5D6A7);
const Color _kCodeComment = Color(0xFF6E7681);

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
// Top-level private functions, kept out of StatelessWidget classes so the
// file reads top-to-bottom like a tutorial.

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
      border: Border.all(color: const Color(0xFF2A2D32)),
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
                    fontSize: 12.0,
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
    margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
    height: 1.0,
    color: _kHairline,
  );
}

// ---------------------------------------------------------------------------
// MOCK SCAFFOLD VIEWPORT
// ---------------------------------------------------------------------------
// A mock viewport is a static painting of "what a Scaffold would look like"
// for a given FloatingActionButtonLocation. We avoid building a real
// Scaffold per cell because we want to highlight *where* the FAB lands
// without paying for 19 nested Material apps inside one build pass.
//
// Geometry: the viewport is a 200x290 rounded rectangle, drawn as a Stack:
//   - background: viewport surface
//   - top bar:    AppBar mock (36 px high)
//   - body:       body mock with a 'placeholder' grid
//   - bottom bar: BottomAppBar mock or BottomNavigationBar mock
//   - FAB:        a positioned circle in the requested anchor slot
//
// The `_FabSlot` enum below enumerates every named slot. Each slot maps to
// an (alignment, isMini, isInBottomBar) tuple, which is then turned into
// concrete Positioned coordinates by `_mockViewport`.

enum _FabSlot {
  startTop,
  centerTop,
  endTop,
  miniStartTop,
  miniCenterTop,
  miniEndTop,
  startFloat,
  centerFloat,
  endFloat,
  miniStartFloat,
  miniCenterFloat,
  miniEndFloat,
  startDocked,
  centerDocked,
  endDocked,
  miniStartDocked,
  miniCenterDocked,
  miniEndDocked,
  endContained,
}

class _SlotGeometry {
  const _SlotGeometry({
    required this.label,
    required this.dx,
    required this.dy,
    required this.mini,
    required this.docked,
    required this.contained,
  });
  final String label;
  final double dx; // horizontal anchor: 0=start, 0.5=center, 1=end
  final double dy; // vertical anchor: 0=top, 0.5=docked, 0.8=float
  final bool mini;
  final bool docked;
  final bool contained;
}

_SlotGeometry _geometryFor(_FabSlot slot) {
  switch (slot) {
    case _FabSlot.startTop:
      return const _SlotGeometry(
          label: 'startTop',
          dx: 0.05,
          dy: 0.0,
          mini: false,
          docked: false,
          contained: false);
    case _FabSlot.centerTop:
      return const _SlotGeometry(
          label: 'centerTop',
          dx: 0.5,
          dy: 0.0,
          mini: false,
          docked: false,
          contained: false);
    case _FabSlot.endTop:
      return const _SlotGeometry(
          label: 'endTop',
          dx: 0.95,
          dy: 0.0,
          mini: false,
          docked: false,
          contained: false);
    case _FabSlot.miniStartTop:
      return const _SlotGeometry(
          label: 'miniStartTop',
          dx: 0.05,
          dy: 0.0,
          mini: true,
          docked: false,
          contained: false);
    case _FabSlot.miniCenterTop:
      return const _SlotGeometry(
          label: 'miniCenterTop',
          dx: 0.5,
          dy: 0.0,
          mini: true,
          docked: false,
          contained: false);
    case _FabSlot.miniEndTop:
      return const _SlotGeometry(
          label: 'miniEndTop',
          dx: 0.95,
          dy: 0.0,
          mini: true,
          docked: false,
          contained: false);
    case _FabSlot.startFloat:
      return const _SlotGeometry(
          label: 'startFloat',
          dx: 0.05,
          dy: 0.8,
          mini: false,
          docked: false,
          contained: false);
    case _FabSlot.centerFloat:
      return const _SlotGeometry(
          label: 'centerFloat',
          dx: 0.5,
          dy: 0.8,
          mini: false,
          docked: false,
          contained: false);
    case _FabSlot.endFloat:
      return const _SlotGeometry(
          label: 'endFloat',
          dx: 0.95,
          dy: 0.8,
          mini: false,
          docked: false,
          contained: false);
    case _FabSlot.miniStartFloat:
      return const _SlotGeometry(
          label: 'miniStartFloat',
          dx: 0.05,
          dy: 0.8,
          mini: true,
          docked: false,
          contained: false);
    case _FabSlot.miniCenterFloat:
      return const _SlotGeometry(
          label: 'miniCenterFloat',
          dx: 0.5,
          dy: 0.8,
          mini: true,
          docked: false,
          contained: false);
    case _FabSlot.miniEndFloat:
      return const _SlotGeometry(
          label: 'miniEndFloat',
          dx: 0.95,
          dy: 0.8,
          mini: true,
          docked: false,
          contained: false);
    case _FabSlot.startDocked:
      return const _SlotGeometry(
          label: 'startDocked',
          dx: 0.05,
          dy: 0.5,
          mini: false,
          docked: true,
          contained: false);
    case _FabSlot.centerDocked:
      return const _SlotGeometry(
          label: 'centerDocked',
          dx: 0.5,
          dy: 0.5,
          mini: false,
          docked: true,
          contained: false);
    case _FabSlot.endDocked:
      return const _SlotGeometry(
          label: 'endDocked',
          dx: 0.95,
          dy: 0.5,
          mini: false,
          docked: true,
          contained: false);
    case _FabSlot.miniStartDocked:
      return const _SlotGeometry(
          label: 'miniStartDocked',
          dx: 0.05,
          dy: 0.5,
          mini: true,
          docked: true,
          contained: false);
    case _FabSlot.miniCenterDocked:
      return const _SlotGeometry(
          label: 'miniCenterDocked',
          dx: 0.5,
          dy: 0.5,
          mini: true,
          docked: true,
          contained: false);
    case _FabSlot.miniEndDocked:
      return const _SlotGeometry(
          label: 'miniEndDocked',
          dx: 0.95,
          dy: 0.5,
          mini: true,
          docked: true,
          contained: false);
    case _FabSlot.endContained:
      return const _SlotGeometry(
          label: 'endContained',
          dx: 0.95,
          dy: 0.6,
          mini: false,
          docked: false,
          contained: true);
  }
}

Widget _fabDot({required bool mini, Color colour = _kFabFill}) {
  final double size = mini ? 28.0 : 40.0;
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: colour,
      borderRadius: BorderRadius.circular(size * 0.3),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33000000),
          offset: Offset(0.0, 2.0),
          blurRadius: 4.0,
        ),
      ],
    ),
    alignment: Alignment.center,
    child: const Icon(Icons.add, color: _kFabOnFill, size: 16.0),
  );
}

Widget _mockViewport(_FabSlot slot) {
  final _SlotGeometry g = _geometryFor(slot);
  // Viewport box dimensions.
  const double w = 200.0;
  const double h = 290.0;
  const double appBarH = 36.0;
  const double bottomBarH = 44.0;

  // Resolve FAB centre. Horizontal: dx in [0,1] maps to [14, w-14] inset.
  final double fabSize = g.mini ? 28.0 : 40.0;
  final double cx = 14.0 + g.dx * (w - 28.0);

  // Vertical resolution depends on dy:
  //   dy == 0.0 -> top, anchored just below AppBar
  //   dy == 0.5 -> docked, straddling the BottomAppBar top edge
  //   dy == 0.6 -> contained: inside the BottomAppBar's vertical band
  //   dy == 0.8 -> float, sitting above the BottomAppBar
  double cy;
  if (g.dy <= 0.0) {
    cy = appBarH; // straddle the appbar bottom edge
  } else if (g.contained) {
    cy = h - bottomBarH * 0.5;
  } else if (g.docked) {
    cy = h - bottomBarH;
  } else {
    cy = h - bottomBarH - fabSize * 0.5 - 6.0;
  }

  final List<Widget> stackChildren = <Widget>[
    // Viewport background
    Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: _kViewportBg,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: _kHairline),
      ),
    ),
    // AppBar mock
    Positioned(
      left: 0.0,
      right: 0.0,
      top: 0.0,
      child: Container(
        height: appBarH,
        decoration: const BoxDecoration(
          color: _kAppBarMock,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Container(
              width: 16.0,
              height: 16.0,
              decoration: const BoxDecoration(
                color: Color(0xFF64748B),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              width: 70.0,
              height: 10.0,
              decoration: BoxDecoration(
                color: const Color(0xFF64748B),
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
          ],
        ),
      ),
    ),
    // Body mock
    Positioned(
      left: 8.0,
      right: 8.0,
      top: appBarH + 8.0,
      bottom: bottomBarH + 8.0,
      child: Container(
        decoration: BoxDecoration(
          color: _kBodyMock,
          borderRadius: BorderRadius.circular(6.0),
        ),
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 100.0,
              height: 8.0,
              color: const Color(0x33000000),
            ),
            const SizedBox(height: 6.0),
            Container(
              width: 140.0,
              height: 6.0,
              color: const Color(0x22000000),
            ),
            const SizedBox(height: 6.0),
            Container(
              width: 60.0,
              height: 6.0,
              color: const Color(0x22000000),
            ),
          ],
        ),
      ),
    ),
    // BottomAppBar mock
    Positioned(
      left: 0.0,
      right: 0.0,
      bottom: 0.0,
      child: Container(
        height: bottomBarH,
        decoration: BoxDecoration(
          color: g.docked || g.contained ? _kBabSurface : _kBottomBarMock,
          borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(16.0),
          ),
          border: const Border(
            top: BorderSide(color: _kHairline),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        alignment: Alignment.centerLeft,
        child: Row(
          children: <Widget>[
            Container(
              width: 14.0,
              height: 14.0,
              decoration: BoxDecoration(
                color: const Color(0xFF64748B),
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              width: 14.0,
              height: 14.0,
              decoration: BoxDecoration(
                color: const Color(0xFF64748B),
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            const Spacer(),
            Container(
              width: 14.0,
              height: 14.0,
              decoration: BoxDecoration(
                color: const Color(0xFF64748B),
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              width: 14.0,
              height: 14.0,
              decoration: BoxDecoration(
                color: const Color(0xFF64748B),
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
          ],
        ),
      ),
    ),
    // FAB
    Positioned(
      left: cx - fabSize * 0.5,
      top: cy - fabSize * 0.5,
      child: _fabDot(mini: g.mini),
    ),
  ];

  return Container(
    margin: const EdgeInsets.all(6.0),
    width: w,
    height: h + 30.0,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: w,
          height: h,
          child: Stack(children: stackChildren),
        ),
        const SizedBox(height: 6.0),
        Center(
          child: Text(
            g.label,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
              color: _kInkSecondary,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 1 - HERO BANNER + INTRO
// ---------------------------------------------------------------------------

Widget _heroBanner() {
  return Container(
    margin: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF1D4ED8),
          Color(0xFF7C3AED),
        ],
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 44.0,
              height: 44.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: const Color(0x33FFFFFF),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Icon(
                Icons.add_circle,
                color: Color(0xFFFFFFFF),
                size: 26.0,
              ),
            ),
            const SizedBox(width: 12.0),
            const Expanded(
              child: Text(
                'Scaffold + FloatingActionButton: anatomy and locations',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFFFFFF),
                  letterSpacing: -0.3,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'A FloatingActionButton is not just a circular button. It is a slot '
          'in the Scaffold layout pipeline. Scaffold reserves space for the '
          'FAB, picks a position via FloatingActionButtonLocation, animates '
          'transitions with FloatingActionButtonAnimator, and publishes the '
          'result through ScaffoldGeometry so SnackBars and BottomSheets can '
          'avoid overlap.',
          style: TextStyle(
            color: Color(0xFFEDEEF5),
            fontSize: 13.5,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 10.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _pill('FloatingActionButton', colour: _kFabFill),
            _pill('FloatingActionButtonLocation', colour: _kAccentViolet),
            _pill('FloatingActionButtonAnimator', colour: _kAccentTeal),
            _pill('ScaffoldFeatureController', colour: _kAccentAmber),
            _pill('BottomAppBar', colour: _kAccentRose),
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
        _cardTitle('The FAB is part of Scaffold layout, not just decoration'),
        const SizedBox(height: 10.0),
        const Text(
          'A FloatingActionButton can technically be rendered anywhere, but in '
          'Material design it is *positioned by Scaffold*. The Scaffold reads '
          'three properties off itself - floatingActionButton, '
          'floatingActionButtonLocation, floatingActionButtonAnimator - and '
          'runs a custom layout pass that:',
          style: _kBodyStyle,
        ),
        const SizedBox(height: 8.0),
        const _BulletList(items: <String>[
          'Sizes the FAB child via a child constraint.',
          'Computes the anchor point in screen coordinates via the location.',
          'Cross-fades or scales between locations via the animator.',
          'Publishes the result on ScaffoldGeometry so SnackBars stack above.',
          'Notches a BottomAppBar around the FAB if the location is docked.',
        ]),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kAccentSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kAccent.withOpacity(0.3)),
          ),
          child: const Text(
            'Rule of thumb: when you change FAB location across a route, change '
            'the location property, not the FAB widget identity. Scaffold will '
            'tween the position; rebuilding a different FAB widget hops.',
            style: TextStyle(
              fontSize: 13.0,
              height: 1.45,
              color: _kInk,
            ),
          ),
        ),
      ],
    ),
  );
}

class _BulletList extends StatelessWidget {
  const _BulletList({required this.items});
  final List<String> items;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (int i = 0; i < items.length; i++)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 6.0, right: 8.0),
                  width: 6.0,
                  height: 6.0,
                  decoration: const BoxDecoration(
                    color: _kAccent,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(child: Text(items[i], style: _kBodySoftStyle)),
              ],
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 2 - FAB ANATOMY
// ---------------------------------------------------------------------------

class _AnatomyRow {
  const _AnatomyRow(this.name, this.type, this.purpose);
  final String name;
  final String type;
  final String purpose;
}

const List<_AnatomyRow> _kAnatomyConfig = <_AnatomyRow>[
  _AnatomyRow('child', 'Widget?', 'Icon or label shown inside the FAB.'),
  _AnatomyRow('onPressed', 'VoidCallback?',
      'Tap handler; null disables the button and lowers elevation.'),
  _AnatomyRow('tooltip', 'String?',
      'Long-press / hover tooltip text, also used for semantics.'),
  _AnatomyRow('foregroundColor', 'Color?',
      'Text/icon colour, falls back to colorScheme.onPrimaryContainer.'),
  _AnatomyRow('backgroundColor', 'Color?',
      'Surface colour, falls back to colorScheme.primaryContainer.'),
  _AnatomyRow('focusColor', 'Color?',
      'Overlay when focused via keyboard / FocusNode.'),
  _AnatomyRow('hoverColor', 'Color?',
      'Overlay when pointer hovers (mouse / stylus).'),
  _AnatomyRow('splashColor', 'Color?',
      'Ink-splash colour painted at the tap origin.'),
  _AnatomyRow(
      'elevation', 'double?', 'Default resting elevation; commonly 6 dp.'),
  _AnatomyRow('focusElevation', 'double?',
      'Elevation when focused; commonly 8 dp.'),
  _AnatomyRow('hoverElevation', 'double?',
      'Elevation when hovered; commonly 8 dp.'),
  _AnatomyRow('highlightElevation', 'double?',
      'Elevation while pressed; commonly 12 dp.'),
  _AnatomyRow('disabledElevation', 'double?',
      'Elevation when onPressed is null; defaults to 0 in M3.'),
  _AnatomyRow('mini', 'bool', 'True => 40x40 FAB; false => 56x56 FAB.'),
  _AnatomyRow('isExtended', 'bool',
      'True for the extended (pill) variant with label + icon.'),
  _AnatomyRow('extendedIconLabelSpacing', 'double?',
      'Gap between icon and label when isExtended is true.'),
  _AnatomyRow('extendedPadding', 'EdgeInsetsGeometry?',
      'Padding inside an extended FAB.'),
  _AnatomyRow(
      'extendedTextStyle', 'TextStyle?', 'TextStyle for the extended label.'),
  _AnatomyRow('shape', 'ShapeBorder?',
      'Border shape; defaults to a circle (RoundedRectangleBorder in M3).'),
  _AnatomyRow('clipBehavior', 'Clip',
      'How the child is clipped; defaults to Clip.none.'),
  _AnatomyRow('autofocus', 'bool', 'Whether to take focus on mount.'),
  _AnatomyRow('focusNode', 'FocusNode?',
      'External FocusNode for traversal/keyboard control.'),
  _AnatomyRow('heroTag', 'Object?',
      'Hero animation tag; default is const _DefaultHeroTag().'),
  _AnatomyRow('materialTapTargetSize', 'MaterialTapTargetSize?',
      'Padded vs shrink-wrapped hit target.'),
  _AnatomyRow('enableFeedback', 'bool?',
      'Audio/haptic feedback on press; usually true.'),
  _AnatomyRow(
      'mouseCursor', 'MouseCursor?', 'Cursor while hovering the FAB.'),
];

Widget _anatomySection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('Public surface of FloatingActionButton',
            subtitle:
                'Configuration, style, semantics. Pulled from the Flutter SDK.'),
        const SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: _kHairline),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 8.0),
                decoration: const BoxDecoration(
                  color: _kCardSoft,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(8.0)),
                  border: Border(bottom: BorderSide(color: _kHairline)),
                ),
                child: Row(
                  children: const <Widget>[
                    SizedBox(
                      width: 180.0,
                      child: Text('Property', style: _kCaptionStyle),
                    ),
                    SizedBox(
                      width: 130.0,
                      child: Text('Type', style: _kCaptionStyle),
                    ),
                    Expanded(child: Text('Purpose', style: _kCaptionStyle)),
                  ],
                ),
              ),
              for (int i = 0; i < _kAnatomyConfig.length; i++)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 8.0),
                  decoration: BoxDecoration(
                    color: i.isEven ? _kCardBg : _kCardSoft,
                    border: const Border(
                      bottom: BorderSide(color: _kHairline),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 180.0,
                        child: Text(
                          _kAnatomyConfig[i].name,
                          style: _kMonoInlineStyle,
                        ),
                      ),
                      SizedBox(
                        width: 130.0,
                        child: Text(
                          _kAnatomyConfig[i].type,
                          style: const TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12.0,
                            color: _kAccentViolet,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          _kAnatomyConfig[i].purpose,
                          style: _kBodySoftStyle,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'Three named constructors complement the default:',
          style: _kBodyStyle,
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: const <Widget>[
            _CtorChip(
              'FloatingActionButton(...)',
              'Default 56x56 circular FAB. mini=false, isExtended=false.',
              _kFabFill,
            ),
            _CtorChip(
              'FloatingActionButton.small(...)',
              'A 40x40 mini variant; sets mini=true.',
              _kAccentTeal,
            ),
            _CtorChip(
              'FloatingActionButton.large(...)',
              '96x96 oversized FAB for hero placements (M3).',
              _kAccentViolet,
            ),
            _CtorChip(
              'FloatingActionButton.extended(...)',
              'Pill-shaped, with icon + label. Sets isExtended=true.',
              _kAccentAmber,
            ),
          ],
        ),
      ],
    ),
  );
}

class _CtorChip extends StatelessWidget {
  const _CtorChip(this.name, this.desc, this.colour);
  final String name;
  final String desc;
  final Color colour;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230.0,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: colour.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: colour.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: colour,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(desc, style: _kBodySoftStyle),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 3 - SIZE VARIANT COMPARISON
// ---------------------------------------------------------------------------

Widget _sizeVariantsSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('Size variants side-by-side',
            subtitle:
                'Default vs .small vs .large vs .extended at native sizes.'),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 18.0,
          runSpacing: 18.0,
          alignment: WrapAlignment.start,
          children: const <Widget>[
            _SizeCell(
              label: 'default (56x56)',
              size: 56.0,
              colour: _kFabFill,
              extended: false,
            ),
            _SizeCell(
              label: '.small (40x40)',
              size: 40.0,
              colour: _kAccentTeal,
              extended: false,
            ),
            _SizeCell(
              label: '.large (96x96)',
              size: 96.0,
              colour: _kAccentViolet,
              extended: false,
            ),
            _SizeCell(
              label: '.extended (pill)',
              size: 48.0,
              colour: _kAccentAmber,
              extended: true,
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: const Text(
            'Picking a size:\n'
            '* default - most apps; sits in endFloat by default.\n'
            '* .small  - dense screens where a 56dp circle is too loud.\n'
            '* .large  - hero CTA on a feature screen; pair with M3 navigation.\n'
            '* .extended - when the action needs a label and the screen is wide.',
            style: TextStyle(
              fontSize: 13.0,
              height: 1.55,
              color: _kInk,
            ),
          ),
        ),
      ],
    ),
  );
}

class _SizeCell extends StatelessWidget {
  const _SizeCell({
    required this.label,
    required this.size,
    required this.colour,
    required this.extended,
  });
  final String label;
  final double size;
  final Color colour;
  final bool extended;
  @override
  Widget build(BuildContext context) {
    Widget fab;
    if (extended) {
      fab = Container(
        height: 48.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: colour,
          borderRadius: BorderRadius.circular(24.0),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x33000000),
              offset: Offset(0.0, 2.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Icon(Icons.edit, color: Color(0xFFFFFFFF), size: 18.0),
            SizedBox(width: 8.0),
            Text(
              'Compose',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 14.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    } else {
      fab = Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: colour,
          shape: BoxShape.circle,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x33000000),
              offset: Offset(0.0, 2.0),
              blurRadius: 6.0,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Icon(
          Icons.add,
          color: const Color(0xFFFFFFFF),
          size: size * 0.45,
        ),
      );
    }
    return Container(
      width: 160.0,
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: _kCardSoft,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: _kHairline),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 100.0, child: Center(child: fab)),
          const SizedBox(height: 8.0),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: _kInkSecondary,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 4 - LOCATION GALLERY
// ---------------------------------------------------------------------------
// 19 mock viewports laid out as a Wrap so the grid reflows by available
// width. Each cell is a self-contained _mockViewport.

Widget _locationGallery() {
  const List<_FabSlot> slots = <_FabSlot>[
    _FabSlot.startTop,
    _FabSlot.centerTop,
    _FabSlot.endTop,
    _FabSlot.miniStartTop,
    _FabSlot.miniCenterTop,
    _FabSlot.miniEndTop,
    _FabSlot.startFloat,
    _FabSlot.centerFloat,
    _FabSlot.endFloat,
    _FabSlot.miniStartFloat,
    _FabSlot.miniCenterFloat,
    _FabSlot.miniEndFloat,
    _FabSlot.startDocked,
    _FabSlot.centerDocked,
    _FabSlot.endDocked,
    _FabSlot.miniStartDocked,
    _FabSlot.miniCenterDocked,
    _FabSlot.miniEndDocked,
    _FabSlot.endContained,
  ];
  return _card(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.fromLTRB(6.0, 6.0, 6.0, 4.0),
          child: Text(
            'Every FloatingActionButtonLocation constant, drawn as a mock '
            'Scaffold viewport. Top row groups by vertical band: top, float, '
            'docked, contained. Each group has start/center/end and a mini '
            'variant where one exists.',
            style: _kBodyStyle,
          ),
        ),
        Wrap(
          children: <Widget>[
            for (int i = 0; i < slots.length; i++) _mockViewport(slots[i]),
          ],
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: <Widget>[
              _pill('top: above body, below appbar', colour: _kAccentTeal),
              _pill('float: above bottom bar', colour: _kAccent),
              _pill('docked: straddles BottomAppBar', colour: _kAccentViolet),
              _pill('contained: inside BottomAppBar band',
                  colour: _kAccentAmber),
              _pill('mini: 40x40 footprint', colour: _kAccentPink),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 - FloatingActionButtonAnimator
// ---------------------------------------------------------------------------

Widget _animatorSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('FloatingActionButtonAnimator',
            subtitle:
                'Bridges location/animation when FAB or its location changes.'),
        const SizedBox(height: 10.0),
        const Text(
          'Scaffold delegates the FAB transition to a '
          'FloatingActionButtonAnimator. Two animators ship with the framework:',
          style: _kBodyStyle,
        ),
        const SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _AnimatorTile(
                title: 'FloatingActionButtonAnimator.scaling',
                colour: _kAccent,
                points: const <String>[
                  'Default for stock Scaffold.',
                  'Scales the outgoing FAB to zero, then scales the incoming '
                      'FAB up from zero.',
                  'Position is also lerped between old and new anchor.',
                  'rotationProgress controls a brief mid-tween hop.',
                ],
              ),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: _AnimatorTile(
                title: 'FloatingActionButtonAnimator.noAnimation',
                colour: _kAccentTeal,
                points: const <String>[
                  'Cuts immediately to the new FAB / location.',
                  'Useful for tests, golden snapshots, accessibility modes.',
                  'No scale tween, no position lerp.',
                  'getOffset returns the end anchor directly.',
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: const Text(
            'Custom animators override four methods:\n'
            '  Offset getOffset({begin, end, progress})\n'
            '  Animation<double> getScaleAnimation({parent})\n'
            '  Animation<double> getRotationAnimation({parent})\n'
            '  Animation<double>? getAnimationRestart(...)\n'
            'Return your own Tween-based animations; Scaffold drives them with '
            'its internal animation controllers.',
            style: TextStyle(
              fontSize: 13.0,
              height: 1.55,
              color: _kInk,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

class _AnimatorTile extends StatelessWidget {
  const _AnimatorTile({
    required this.title,
    required this.colour,
    required this.points,
  });
  final String title;
  final Color colour;
  final List<String> points;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: colour.withOpacity(0.08),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: colour.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.0,
              fontWeight: FontWeight.w700,
              color: colour,
            ),
          ),
          const SizedBox(height: 8.0),
          for (int i = 0; i < points.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 6.0, right: 6.0),
                    width: 5.0,
                    height: 5.0,
                    decoration: BoxDecoration(
                      color: colour,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(child: Text(points[i], style: _kBodySoftStyle)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 6 - BottomAppBar + FAB NOTCH
// ---------------------------------------------------------------------------

Widget _notchSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('BottomAppBar with a docked FAB notch',
            subtitle: 'A wide mock viewport showing how Scaffold sews the FAB '
                'into the BottomAppBar.'),
        const SizedBox(height: 14.0),
        // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #51, P2):
        // The mock-viewport Stack was 220 dp tall, of which the body band
        // (top: 56, bottom: 70) was only 94 dp. With 12-dp padding on each
        // side the content area shrank to 70 dp, but the four 38-dp inbox
        // rows (avatar 28 + outer 5 padding × 2) required 152 dp — leaving
        // a deterministic 82-dp bottom overflow. Bumping the viewport
        // height to 310 dp grows the body band to ~184 dp and fits the
        // rows with room to spare.
        Center(
          child: SizedBox(
            width: 360.0,
            height: 310.0,
            child: Stack(
              children: <Widget>[
                // Phone shell
                Container(
                  decoration: BoxDecoration(
                    color: _kViewportBg,
                    borderRadius: BorderRadius.circular(18.0),
                    border: Border.all(color: _kHairline),
                  ),
                ),
                // App bar
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  top: 0.0,
                  child: Container(
                    height: 44.0,
                    decoration: const BoxDecoration(
                      color: _kAppBarMock,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(18.0)),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      'Inbox',
                      style: TextStyle(
                        color: _kInk,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                // Body
                Positioned(
                  left: 12.0,
                  right: 12.0,
                  top: 56.0,
                  bottom: 70.0,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _kBodyMock,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        for (int i = 0; i < 4; i++)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 28.0,
                                  height: 28.0,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFCBD5E1),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 10.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                        height: 8.0,
                                        width: 120.0,
                                        color: const Color(0x33000000),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Container(
                                        height: 6.0,
                                        width: 180.0,
                                        color: const Color(0x22000000),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                // BottomAppBar with notch (faked via Row + circular gap)
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: SizedBox(
                    height: 60.0,
                    child: CustomPaint(
                      painter: _NotchedBabPainter(),
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                          children: const <Widget>[
                            Icon(Icons.menu, color: _kInk, size: 22.0),
                            SizedBox(width: 12.0),
                            Icon(Icons.search, color: _kInk, size: 22.0),
                            Spacer(),
                            SizedBox(width: 80.0), // notch reserve
                            Spacer(),
                            Icon(Icons.bookmark_border,
                                color: _kInk, size: 22.0),
                            SizedBox(width: 12.0),
                            Icon(Icons.more_vert, color: _kInk, size: 22.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                // FAB docked over notch
                Positioned(
                  left: 360.0 / 2.0 - 28.0,
                  bottom: 60.0 - 28.0,
                  child: Container(
                    width: 56.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      color: _kFabFill,
                      shape: BoxShape.circle,
                      boxShadow: const <BoxShadow>[
                        BoxShadow(
                          color: Color(0x40000000),
                          offset: Offset(0.0, 3.0),
                          blurRadius: 8.0,
                        ),
                      ],
                    ),
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.add,
                      color: _kFabOnFill,
                      size: 26.0,
                    ),
                  ),
                ),
                // Annotations
                const Positioned(
                  right: 10.0,
                  top: 50.0,
                  child: _AnnotationArrow(
                    label: 'notchMargin: 4 dp gap\n'
                        'between BAB and FAB',
                    colour: _kAccentRose,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kAccentSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kAccent.withOpacity(0.3)),
          ),
          child: const Text(
            'To get this composition with a real Scaffold:\n'
            '  bottomNavigationBar: BottomAppBar(\n'
            '    shape: CircularNotchedRectangle(),\n'
            '    notchMargin: 4.0,\n'
            '    child: Row(children: [ ... menu icons ... ]),\n'
            '  ),\n'
            '  floatingActionButton: FloatingActionButton(...),\n'
            '  floatingActionButtonLocation: FloatingActionButtonLocation\n'
            '      .centerDocked,',
            style: TextStyle(
              fontSize: 12.5,
              height: 1.55,
              fontFamily: 'monospace',
              color: _kInk,
            ),
          ),
        ),
      ],
    ),
  );
}

class _NotchedBabPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint fill = Paint()
      ..color = _kBabSurface
      ..style = PaintingStyle.fill;
    final Paint stroke = Paint()
      ..color = _kHairline
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    const double notchRadius = 32.0;
    const double notchMargin = 4.0;
    final double cx = size.width / 2.0;
    final Path path = Path();
    path.moveTo(0.0, 0.0);
    path.lineTo(cx - notchRadius - notchMargin, 0.0);
    // Notch arc: a half-circle dipping down into the BAB.
    path.arcToPoint(
      Offset(cx + notchRadius + notchMargin, 0.0),
      radius: const Radius.circular(notchRadius + notchMargin),
      clockwise: false,
    );
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    canvas.drawPath(path, fill);
    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(_NotchedBabPainter oldDelegate) => false;
}

class _AnnotationArrow extends StatelessWidget {
  const _AnnotationArrow({required this.label, required this.colour});
  final String label;
  final Color colour;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: colour.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: colour.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10.5,
          fontWeight: FontWeight.w600,
          color: colour,
          height: 1.3,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 7 - ScaffoldFeatureController
// ---------------------------------------------------------------------------

Widget _featureControllerSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('ScaffoldFeatureController<T, U>',
            subtitle:
                'The return value of showSnackBar / showBottomSheet / showMaterialBanner.'),
        const SizedBox(height: 10.0),
        const Text(
          'Whenever you call one of these:',
          style: _kBodyStyle,
        ),
        const SizedBox(height: 6.0),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(
            'ScaffoldMessenger.of(context).showSnackBar(snackBar)\n'
            'ScaffoldMessenger.of(context).showMaterialBanner(banner)\n'
            'Scaffold.of(context).showBottomSheet(builder: ...)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.5,
              height: 1.6,
              color: _kInk,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'you get a typed controller back. The shape is:',
          style: _kBodyStyle,
        ),
        const SizedBox(height: 6.0),
        _codeBlock(
          'class ScaffoldFeatureController<T extends Widget, U> {\n'
          '  T          get _widget;                 // shown widget\n'
          '  Future<U>  get closed;                  // resolves on dismissal\n'
          '  void       close([U? reason]);          // programmatic dismissal\n'
          '  StateSetter setState;                   // imperative rebuild\n'
          '}',
          title: 'public surface',
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: _kHairline),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: const <Widget>[
              _CtrlReturnRow(
                from: 'showSnackBar',
                generic: 'SnackBar, SnackBarClosedReason',
                tip:
                    'closed resolves to swipe / action / timeout / hide / remove.',
              ),
              _CtrlReturnRow(
                from: 'showMaterialBanner',
                generic: 'MaterialBanner, MaterialBannerClosedReason',
                tip:
                    'banners stack; close them via the controller or queue.',
              ),
              _CtrlReturnRow(
                from: 'showBottomSheet',
                generic: 'T extends Widget, T',
                tip:
                    'closed resolves with whatever value was passed to close().',
              ),
              _CtrlReturnRow(
                from: 'showMaterialBanner (deprecated path: Scaffold.of)',
                generic: 'MaterialBanner, MaterialBannerClosedReason',
                tip:
                    'prefer ScaffoldMessenger.of for stacking and route safety.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: const Text(
            'Lifecycle tips:\n'
            '* The Future<closed> never throws; it resolves once.\n'
            '* setState rebuilds the *feature widget* in-place (rarely needed).\n'
            '* close() is idempotent; calling twice is a no-op.\n'
            '* The controller does not survive route pop; use ScaffoldMessenger '
            'for app-wide SnackBars.',
            style: TextStyle(
              fontSize: 13.0,
              height: 1.55,
              color: _kInk,
            ),
          ),
        ),
      ],
    ),
  );
}

class _CtrlReturnRow extends StatelessWidget {
  const _CtrlReturnRow({
    required this.from,
    required this.generic,
    required this.tip,
  });
  final String from;
  final String generic;
  final String tip;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _kHairline)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 220.0,
            child: Text(from, style: _kMonoInlineStyle),
          ),
          SizedBox(
            width: 200.0,
            child: Text(
              '<$generic>',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                color: _kAccentViolet,
              ),
            ),
          ),
          Expanded(child: Text(tip, style: _kBodySoftStyle)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// SECTION 8 - RECIPES
// ---------------------------------------------------------------------------

Widget _recipesSection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _codeBlock(
        '// Recipe 1: A standard Scaffold with a default FAB.\n'
        'Scaffold(\n'
        '  appBar: AppBar(title: const Text(\'Notes\')),\n'
        '  body: const NoteList(),\n'
        '  floatingActionButton: FloatingActionButton(\n'
        '    onPressed: _onNewNote,\n'
        '    tooltip: \'New note\',\n'
        '    child: const Icon(Icons.add),\n'
        '  ),\n'
        ');',
        title: 'recipe_1_default_fab.dart',
      ),
      _codeBlock(
        '// Recipe 2: Extended FAB with a label that contracts on scroll.\n'
        'FloatingActionButton.extended(\n'
        '  onPressed: _onCompose,\n'
        '  icon: const Icon(Icons.edit),\n'
        '  label: const Text(\'Compose\'),\n'
        '  isExtended: !_collapsed,\n'
        ');',
        title: 'recipe_2_extended_collapse.dart',
      ),
      _codeBlock(
        '// Recipe 3: Choose location based on screen width.\n'
        'final bool wide = MediaQuery.of(context).size.width >= 600.0;\n'
        'Scaffold(\n'
        '  floatingActionButton: FloatingActionButton(\n'
        '    onPressed: _action,\n'
        '    child: const Icon(Icons.add),\n'
        '  ),\n'
        '  floatingActionButtonLocation: wide\n'
        '      ? FloatingActionButtonLocation.endTop\n'
        '      : FloatingActionButtonLocation.endFloat,\n'
        ');',
        title: 'recipe_3_responsive_location.dart',
      ),
      _codeBlock(
        '// Recipe 4: Avoid heroTag collision when two Scaffolds share a route.\n'
        'FloatingActionButton(\n'
        '  heroTag: \'inbox-compose\',\n'
        '  onPressed: _onCompose,\n'
        '  child: const Icon(Icons.edit),\n'
        ');',
        title: 'recipe_4_hero_tag.dart',
      ),
      _codeBlock(
        '// Recipe 5: BottomAppBar with notched centerDocked FAB.\n'
        'Scaffold(\n'
        '  body: _body,\n'
        '  floatingActionButton: FloatingActionButton(\n'
        '    onPressed: _onAdd,\n'
        '    child: const Icon(Icons.add),\n'
        '  ),\n'
        '  floatingActionButtonLocation:\n'
        '      FloatingActionButtonLocation.centerDocked,\n'
        '  bottomNavigationBar: BottomAppBar(\n'
        '    shape: const CircularNotchedRectangle(),\n'
        '    notchMargin: 4.0,\n'
        '    child: Row(children: _navButtons),\n'
        '  ),\n'
        ');',
        title: 'recipe_5_notched_bab.dart',
      ),
      _codeBlock(
        '// Recipe 6: Show a SnackBar with a typed result via closed.\n'
        'final controller = ScaffoldMessenger.of(context).showSnackBar(\n'
        '  SnackBar(\n'
        '    content: const Text(\'Item deleted\'),\n'
        '    action: SnackBarAction(label: \'UNDO\', onPressed: _undo),\n'
        '    duration: const Duration(seconds: 4),\n'
        '  ),\n'
        ');\n'
        'controller.closed.then((SnackBarClosedReason reason) {\n'
        '  if (reason == SnackBarClosedReason.action) _commit();\n'
        '});',
        title: 'recipe_6_snackbar_controller.dart',
      ),
      _codeBlock(
        '// Recipe 7: Programmatic dismissal of a bottom sheet.\n'
        'final controller = Scaffold.of(context).showBottomSheet<String>(\n'
        '  (BuildContext context) => _SheetBody(),\n'
        ');\n'
        'await Future<void>.delayed(const Duration(seconds: 30));\n'
        'controller.close(\'timeout\');\n'
        'final String reason = await controller.closed;',
        title: 'recipe_7_bottom_sheet_close.dart',
      ),
      _codeBlock(
        '// Recipe 8: Swap animator to a custom one.\n'
        'class _SnapAnimator extends FloatingActionButtonAnimator {\n'
        '  const _SnapAnimator();\n'
        '  @override\n'
        '  Offset getOffset({required Offset begin, required Offset end,\n'
        '                    required double progress}) =>\n'
        '      progress < 0.5 ? begin : end;\n'
        '  @override\n'
        '  Animation<double> getScaleAnimation({required Animation<double> '
        'parent}) =>\n'
        '      AlwaysStoppedAnimation<double>(1.0);\n'
        '  @override\n'
        '  Animation<double> getRotationAnimation({required Animation<double>'
        ' parent}) =>\n'
        '      AlwaysStoppedAnimation<double>(0.0);\n'
        '}\n'
        '// Then: Scaffold(floatingActionButtonAnimator: const _SnapAnimator())',
        title: 'recipe_8_custom_animator.dart',
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 9 - PITFALLS
// ---------------------------------------------------------------------------

class _Pitfall {
  const _Pitfall(this.title, this.detail, this.colour);
  final String title;
  final String detail;
  final Color colour;
}

const List<_Pitfall> _kPitfalls = <_Pitfall>[
  _Pitfall(
    'heroTag collisions in routes',
    'Two FloatingActionButtons in the same Hero scope use the same default '
        'tag and will throw at push time. Give each one a heroTag.',
    _kAccentRose,
  ),
  _Pitfall(
    'No Scaffold ancestor',
    'Scaffold.of(context) throws when called above the Scaffold. Use a Builder '
        'or Scaffold.maybeOf for nullable lookup.',
    _kAccentAmber,
  ),
  _Pitfall(
    'docked location without a BottomAppBar',
    'centerDocked / endDocked still positions the FAB, but there is no notch '
        'to dock into; the result looks like a misaligned float.',
    _kAccentViolet,
  ),
  _Pitfall(
    'FAB inside a Hero with isExtended toggling',
    'Toggling .isExtended during a Hero flight pushes a new RenderObject and '
        'aborts the flight. Keep size constant during route transitions.',
    _kAccentTeal,
  ),
  _Pitfall(
    'Keyboard insets covering the FAB',
    'Scaffold.resizeToAvoidBottomInset=true resizes the body but the FAB '
        'follows the bottom. Use FloatingActionButtonLocation.endTop or set '
        'resizeToAvoidBottomInset=false on the route.',
    _kAccentGreen,
  ),
  _Pitfall(
    'ScaffoldMessenger.of vs Scaffold.of for SnackBar',
    'Scaffold.of(context).showSnackBar is deprecated; use ScaffoldMessenger.of '
        'so SnackBars survive route pushes and stack across screens.',
    _kAccentPink,
  ),
];

Widget _pitfallsSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('Six things that bite Flutter engineers',
            subtitle: 'Each callout maps to a real-world bug report.'),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (int i = 0; i < _kPitfalls.length; i++)
              SizedBox(
                width: 280.0,
                child: _PitfallTile(_kPitfalls[i]),
              ),
          ],
        ),
      ],
    ),
  );
}

class _PitfallTile extends StatelessWidget {
  const _PitfallTile(this.pitfall);
  final _Pitfall pitfall;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: pitfall.colour.withOpacity(0.07),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: pitfall.colour.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: pitfall.colour,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  pitfall.title,
                  style: TextStyle(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: pitfall.colour,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(pitfall.detail, style: _kBodySoftStyle),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// CHEAT-SHEET FOOTER
// ---------------------------------------------------------------------------

Widget _chipGroup(String title, List<String> chips, Color colour) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    width: 280.0,
    decoration: BoxDecoration(
      color: const Color(0x22FFFFFF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: const Color(0x44FFFFFF)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            color: _kInkOnDark,
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: <Widget>[
            for (int i = 0; i < chips.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 3.0,
                ),
                decoration: BoxDecoration(
                  color: colour,
                  borderRadius: BorderRadius.circular(999.0),
                ),
                child: Text(
                  chips[i],
                  style: const TextStyle(
                    color: Color(0xFF1B1D2A),
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ],
    ),
  );
}

Widget _cheatSheetFooter() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: _kCardDark,
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Cheat-sheet: Scaffold FAB subsystem',
          style: TextStyle(
            color: _kInkOnDark,
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Pick a row, grep the SDK, apply.',
          style: TextStyle(
            color: _kInkOnDarkSecondary,
            fontSize: 13.0,
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            _chipGroup('Constructors', const <String>[
              'FloatingActionButton',
              '.small',
              '.large',
              '.extended',
            ], const Color(0xFFA7F3D0)),
            _chipGroup('Locations: top', const <String>[
              'startTop',
              'centerTop',
              'endTop',
              'miniStartTop',
              'miniCenterTop',
              'miniEndTop',
            ], const Color(0xFFFDE68A)),
            _chipGroup('Locations: float', const <String>[
              'startFloat',
              'centerFloat',
              'endFloat',
              'miniStartFloat',
              'miniCenterFloat',
              'miniEndFloat',
            ], const Color(0xFFFBCFE8)),
            _chipGroup('Locations: docked', const <String>[
              'startDocked',
              'centerDocked',
              'endDocked',
              'miniStartDocked',
              'miniCenterDocked',
              'miniEndDocked',
              'endContained',
            ], const Color(0xFFFCA5A5)),
            _chipGroup('Animator', const <String>[
              'scaling',
              'noAnimation',
              'getOffset',
              'getScaleAnimation',
              'getRotationAnimation',
            ], const Color(0xFFC4B5FD)),
            _chipGroup('Feature controller', const <String>[
              'showSnackBar',
              'showBottomSheet',
              'showMaterialBanner',
              'closed',
              'close([reason])',
              'setState',
            ], const Color(0xFFBAE6FD)),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            'Tagline: "Scaffold is a layout broker. The FAB is its featured '
            'tenant; SnackBar and BottomSheet are the neighbours that ask '
            'Scaffold not to overlap them."',
            style: TextStyle(
              color: _kInkOnDark,
              fontSize: 13.5,
              height: 1.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// MAIN BUILD ENTRY POINT
// ---------------------------------------------------------------------------
// The interpreter calls this function exactly once. We deliberately do not
// instantiate a real Scaffold inside the build tree; the gallery uses mocked
// viewports drawn as plain Containers. This keeps the demo small, fast, and
// independent of the surrounding host app's MediaQuery/Directionality.
// ===========================================================================
dynamic build(BuildContext context) {
  print('Scaffold FAB deep visual demo: building widget tree');

  // Demonstration: instantiate the locations symbolically so their runtime
  // types are touched. We do not for-in over them.
  final FloatingActionButtonLocation locStartTop =
      FloatingActionButtonLocation.startTop;
  final FloatingActionButtonLocation locCenterDocked =
      FloatingActionButtonLocation.centerDocked;
  final FloatingActionButtonLocation locEndFloat =
      FloatingActionButtonLocation.endFloat;
  final FloatingActionButtonLocation locEndContained =
      FloatingActionButtonLocation.endContained;
  print('locStartTop.runtimeType=${locStartTop.runtimeType}');
  print('locCenterDocked.runtimeType=${locCenterDocked.runtimeType}');
  print('locEndFloat.runtimeType=${locEndFloat.runtimeType}');
  print('locEndContained.runtimeType=${locEndContained.runtimeType}');

  final FloatingActionButtonAnimator scalingAnimator =
      FloatingActionButtonAnimator.scaling;
  final FloatingActionButtonAnimator noAnim =
      FloatingActionButtonAnimator.noAnimation;
  print('scalingAnimator.runtimeType=${scalingAnimator.runtimeType}');
  print('noAnim.runtimeType=${noAnim.runtimeType}');

  // A throw-away math reference so the dart:math import stays meaningful.
  final double tau = math.pi * 2.0;
  print('tau=$tau');

  return Container(
    color: _kCanvas,
    child: SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Section 1
          _heroBanner(),
          _sectionHeader(1, 'Why FAB lives inside Scaffold',
              'A layout slot, not just a circular button.'),
          _heroIntroCard(),
          _sectionDivider(),

          // Section 2
          _sectionHeader(2, 'FAB anatomy',
              'Public surface: properties, named constructors.'),
          _anatomySection(),
          _sectionDivider(),

          // Section 3
          _sectionHeader(3, 'Size variants',
              'default vs .small vs .large vs .extended.'),
          _sizeVariantsSection(),
          _sectionDivider(),

          // Section 4
          _sectionHeader(4, 'Location gallery',
              '19 mock Scaffold viewports, one per location constant.'),
          _locationGallery(),
          _sectionDivider(),

          // Section 5
          _sectionHeader(5, 'FloatingActionButtonAnimator',
              'Swap animations driven by Scaffold internals.'),
          _animatorSection(),
          _sectionDivider(),

          // Section 6
          _sectionHeader(6, 'BottomAppBar + FAB notch',
              'How docked FABs cut a notch in the BottomAppBar.'),
          _notchSection(),
          _sectionDivider(),

          // Section 7
          _sectionHeader(7, 'ScaffoldFeatureController',
              'Typed handle returned by show* APIs.'),
          _featureControllerSection(),
          _sectionDivider(),

          // Section 8
          _sectionHeader(8, 'Recipes',
              'Eight idiomatic FAB / Scaffold patterns.'),
          _recipesSection(),
          _sectionDivider(),

          // Section 9
          _sectionHeader(9, 'Pitfalls',
              'Six callouts that commonly bite Flutter engineers.'),
          _pitfallsSection(),
          _sectionDivider(),

          // Footer
          _cheatSheetFooter(),
        ],
      ),
    ),
  );
}
