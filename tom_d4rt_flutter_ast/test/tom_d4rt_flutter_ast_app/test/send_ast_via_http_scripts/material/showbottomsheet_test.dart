// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of showModalBottomSheet / showBottomSheet.
//
// This file is part of the D4rt flutter-test corpus and is executed by an
// analyzer-free, sandboxed Dart interpreter. The script exports exactly one
// top-level entry point - `dynamic build(BuildContext)` - which the runtime
// invokes a single time. The returned widget tree is then handed straight
// to the host app's renderer.
//
// IMPORTANT runtime caveat - the script's `build` runs exactly once. There
// is no user gesture loop and no second build pass. That means
// `showModalBottomSheet(...)` cannot actually be invoked at build time. The
// gallery therefore renders the sheets as static mock-up panels - inert
// containers shaped like real M3 bottom sheets, complete with handle, scrim
// and parameter badges - overlaid at the bottom of each mock viewport.
//
// Ten thematic sections walk through the API surface:
//
//   1. Hero intro - modal vs persistent and where each function lives.
//   2. Parameter anatomy - the seventeen knobs of showModalBottomSheet.
//   3. Mock sheet gallery - eight static silhouettes covering
//      isScrollControlled true/false, showDragHandle, useSafeArea variants,
//      backgroundColor/shape/elevation tweaks and the rare "full screen"
//      configuration that DraggableScrollableSheet enables.
//   4. Barrier diagram - scrim layer, barrierColor, barrierLabel, the
//      isDismissible gesture funnel and the modal route stack.
//   5. Modal vs persistent matrix - six axes that distinguish
//      showModalBottomSheet, showBottomSheet and Scaffold.bottomSheet.
//   6. Material 3 spec panel - tonal elevation curve, shape token
//      (RoundedRectangleBorder, top-corners only at 28dp), drag-handle
//      dimensions and safe-area inset behaviour.
//   7. Code recipes - six idiomatic call sites.
//   8. Modal route lifecycle - the seven-step state diagram a
//      ModalBottomSheetRoute walks from push to dispose.
//   9. Pitfalls panel - eight callouts including the ListView /
//      isScrollControlled trap, keyboard insets, root navigator surprises
//      and Hero ticker leaks on dismiss.
//  10. Cheat-sheet footer - chip groups for the API surface.
//
// Build-time discipline: no `setState`, no `Timer`, no `Future`, no
// `async`, no live `AnimationController`. Buttons that conceptually call
// `showModalBottomSheet` are rendered as plain Containers with no `onTap`
// - the demo is a wallpaper, not an interactive playground.
import 'dart:math' as math;
import 'dart:ui' show FontFeature;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
const Color _kCanvas = Color(0xFFF3F4F8);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardSoft = Color(0xFFF7F8FC);
const Color _kCardDark = Color(0xFF181A24);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF161825);
const Color _kInkSecondary = Color(0xFF3F4255);
const Color _kInkTertiary = Color(0xFF8B8FA3);
const Color _kInkOnDark = Color(0xFFEDEEF5);
const Color _kInkOnDarkSecondary = Color(0xFFA3A6B8);

const Color _kSheetSurface = Color(0xFFF4EFF8);
const Color _kSheetSurfaceWarm = Color(0xFFFBF6EF);
const Color _kSheetSurfaceCool = Color(0xFFEEF1F8);
const Color _kSheetHandle = Color(0xFFCAC4D0);
const Color _kSheetHandleDark = Color(0xFF49454F);
const Color _kSheetEdge = Color(0xFFE7E0EC);
const Color _kScrim = Color(0x80000000);
const Color _kScrimSoft = Color(0x40000000);
const Color _kScrimHard = Color(0xB3000000);

const Color _kAccent = Color(0xFF6750A4);
const Color _kAccentSoft = Color(0xFFEADDFF);
const Color _kAccentBlue = Color(0xFF2563EB);
const Color _kAccentTeal = Color(0xFF14B8A6);
const Color _kAccentGreen = Color(0xFF22C55E);
const Color _kAccentAmber = Color(0xFFF59E0B);
const Color _kAccentRose = Color(0xFFE11D48);
const Color _kAccentViolet = Color(0xFF8B5CF6);
const Color _kAccentOrange = Color(0xFFEA580C);
const Color _kAccentSky = Color(0xFF0EA5E9);
const Color _kAccentSlate = Color(0xFF475569);

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
          width: 200.0,
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

Widget _bulletList(List<String> items, {Color bullet = _kAccent}) {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < items.length; i += 1) {
    rows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 6.0, right: 8.0),
              width: 6.0,
              height: 6.0,
              decoration: BoxDecoration(
                color: bullet,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            Expanded(child: Text(items[i], style: _kBodyStyle)),
          ],
        ),
      ),
    );
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: rows,
  );
}

// ---------------------------------------------------------------------------
// MOCK BOTTOM SHEET HELPERS
// ---------------------------------------------------------------------------

Widget _mockDragHandle({Color colour = _kSheetHandle}) {
  return Container(
    margin: const EdgeInsets.only(top: 10.0, bottom: 6.0),
    width: 32.0,
    height: 4.0,
    decoration: BoxDecoration(
      color: colour,
      borderRadius: BorderRadius.circular(2.0),
    ),
  );
}

Widget _mockListTile({String label = 'Action label', IconData icon = Icons.bookmark_border}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10.0),
    child: Row(
      children: <Widget>[
        Container(
          width: 28.0,
          height: 28.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kAccent.withOpacity(0.10),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Icon(icon, size: 16.0, color: _kAccent),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Container(
            height: 10.0,
            decoration: BoxDecoration(
              color: _kSheetEdge,
              borderRadius: BorderRadius.circular(3.0),
            ),
          ),
        ),
        const SizedBox(width: 18.0),
        Container(
          width: 40.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: _kSheetEdge,
            borderRadius: BorderRadius.circular(3.0),
          ),
        ),
      ],
    ),
  );
}

Widget _mockSheetTitle(String label) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 6.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: _kInk,
              letterSpacing: -0.2,
            ),
          ),
        ),
        Container(
          width: 22.0,
          height: 22.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kSheetEdge,
            borderRadius: BorderRadius.circular(11.0),
          ),
          child: const Icon(Icons.close, size: 14.0, color: _kInkSecondary),
        ),
      ],
    ),
  );
}

Widget _mockSheet({
  required double height,
  required String title,
  bool showHandle = true,
  double topRadius = 28.0,
  Color surface = _kSheetSurface,
  int tileCount = 4,
  bool fullCorners = false,
}) {
  final BorderRadius radius = fullCorners
      ? BorderRadius.circular(topRadius)
      : BorderRadius.only(
          topLeft: Radius.circular(topRadius),
          topRight: Radius.circular(topRadius),
        );
  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < tileCount; i += 1) {
    tiles.add(_mockListTile(
      label: 'Tile $i',
      icon: <IconData>[
        Icons.share_outlined,
        Icons.copy_outlined,
        Icons.edit_outlined,
        Icons.delete_outline,
        Icons.archive_outlined,
        Icons.report_outlined,
      ][i % 6],
    ));
  }
  return Container(
    height: height,
    decoration: BoxDecoration(
      color: surface,
      borderRadius: radius,
      border: Border.all(color: _kSheetEdge),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x29000000),
          offset: Offset(0.0, -3.0),
          blurRadius: 12.0,
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        if (showHandle)
          _mockDragHandle(colour: _kSheetHandle)
        else
          const SizedBox(height: 10.0),
        _mockSheetTitle(title),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 18.0),
          height: 1.0,
          color: _kSheetEdge,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: tiles,
          ),
        ),
      ],
    ),
  );
}

Widget _mockViewport({
  required Widget sheet,
  required String label,
  required List<Widget> badges,
  Color scrim = _kScrim,
  bool showScrim = true,
  bool persistent = false,
  Color background = _kCardSoft,
  double height = 320.0,
  String? appBarTitle,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _kHairline),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 8.0,
                height: 8.0,
                decoration: BoxDecoration(
                  color: persistent ? _kAccentGreen : _kAccentRose,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    color: _kInk,
                  ),
                ),
              ),
              Text(
                persistent ? 'persistent' : 'modal',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  color: persistent ? _kAccentGreen : _kAccentRose,
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          height: 1.0,
          color: _kHairline,
        ),
        SizedBox(
          height: height,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(18.0),
              bottomRight: Radius.circular(18.0),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  color: const Color(0xFFFFFFFF),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        height: 44.0,
                        padding: const EdgeInsets.symmetric(horizontal: 14.0),
                        alignment: Alignment.centerLeft,
                        decoration: const BoxDecoration(
                          color: Color(0xFFE7E0EC),
                        ),
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.menu, size: 18.0, color: _kInk),
                            const SizedBox(width: 10.0),
                            Text(
                              appBarTitle ?? 'Scaffold',
                              style: const TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: _kInk,
                              ),
                            ),
                            const Spacer(),
                            const Icon(Icons.more_vert, size: 18.0, color: _kInk),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(14.0),
                          color: const Color(0xFFFAF9FB),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Container(
                                height: 12.0,
                                decoration: BoxDecoration(
                                  color: _kSheetEdge,
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Container(
                                height: 12.0,
                                width: 200.0,
                                decoration: BoxDecoration(
                                  color: _kSheetEdge,
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                              ),
                              const SizedBox(height: 18.0),
                              Container(
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: _kSheetEdge.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: _kSheetEdge.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (showScrim)
                  Positioned.fill(
                    child: Container(color: scrim),
                  ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: sheet,
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 12.0),
          child: Wrap(
            spacing: 6.0,
            runSpacing: 6.0,
            children: badges,
          ),
        ),
      ],
    ),
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
        colors: <Color>[Color(0xFF1E1B4B), Color(0xFF6750A4), Color(0xFFB497E8)],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x33312E81),
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
                'package:flutter/material.dart',
                style: TextStyle(
                  color: Color(0xFFEDEEF5),
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
                'bottom_sheet.dart',
                style: TextStyle(
                  color: Color(0xFFEDEEF5),
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
          'showModalBottomSheet',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'and the persistent showBottomSheet next door.',
          style: TextStyle(
            color: Color(0xFFE9D9FF),
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'A complete tour of the bottom-sheet API: the modal/persistent '
          'split, the seventeen parameter knobs, the M3 visual spec, the '
          'modal-route lifecycle, and the pitfalls that make experienced '
          'engineers shake a fist at the keyboard insets.',
          style: TextStyle(
            color: Color(0xFFE0E1F4),
            fontSize: 14.5,
            height: 1.45,
          ),
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _pill('showModalBottomSheet', colour: const Color(0xFFFDE68A)),
            _pill('showBottomSheet', colour: const Color(0xFF93C5FD)),
            _pill('ModalBottomSheetRoute', colour: const Color(0xFFA7F3D0)),
            _pill('Scaffold.bottomSheet', colour: const Color(0xFFFBCFE8)),
            _pill('DraggableScrollableSheet', colour: const Color(0xFFFCD34D)),
            _pill('BottomSheetThemeData', colour: const Color(0xFFFCA5A5)),
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
          'Two functions, one spec',
          subtitle:
              'showModalBottomSheet pushes a route onto the Navigator; '
              'showBottomSheet attaches a persistent sheet to the enclosing '
              'Scaffold. Both render the same M3 BottomSheet widget under '
              'the hood and share most layout parameters.',
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
            'Modal sheets steal focus and a scrim covers the page; '
            'persistent sheets cohabit with the Scaffold body, share the '
            'gesture system, and never lay a scrim down. Choose modal for '
            'destructive actions and quick pickers; choose persistent for '
            'companion content that should remain readable while users '
            'interact with the main view.',
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
                'showModalBottomSheet<T>(...) returns Future<T?>.',
                'showBottomSheet<T>(...) returns PersistentBottomSheetController<T>.',
                'Both honour BottomSheetThemeData defaults.',
                'M3 default radius: 28dp on top corners only.',
                'Sheets respect Scaffold.bottomNavigationBar height.',
              ]),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: _bulletList(
                const <String>[
                  'Tapping the scrim dismisses iff isDismissible=true.',
                  'Drag-handle: 32x4dp pill, surfaceVariant fill.',
                  'Keyboard insets push the sheet up via MediaQuery.',
                  'isScrollControlled lifts the height cap (default 0.5).',
                  'transitionAnimationController lets you reuse a ticker.',
                ],
                bullet: _kAccentBlue,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _heroOverview() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Anatomy of a modal bottom sheet',
          subtitle: 'Five concentric layers stacked from screen to fingertip.',
        ),
        const SizedBox(height: 14.0),
        Container(
          height: 240.0,
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _kHairline),
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFFE7E0EC),
                  ),
                ),
              ),
              const Positioned(
                left: 14.0,
                top: 14.0,
                child: Text(
                  '1 — application chrome',
                  style: TextStyle(
                    fontSize: 11.5,
                    fontFamily: 'monospace',
                    color: _kInkSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Positioned(
                left: 50.0,
                top: 60.0,
                right: 50.0,
                bottom: 110.0,
                child: Container(
                  color: const Color(0xB3000000),
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(8.0),
                  child: const Text(
                    '2 — scrim (barrierColor • barrierLabel • isDismissible)',
                    style: TextStyle(
                      fontSize: 11.5,
                      fontFamily: 'monospace',
                      color: Color(0xFFFFFFFF),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30.0,
                right: 30.0,
                bottom: 0.0,
                height: 120.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: _kSheetSurface,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(28.0),
                      topRight: Radius.circular(28.0),
                    ),
                    border: Border.all(color: _kSheetEdge),
                  ),
                  child: Column(
                    children: <Widget>[
                      _mockDragHandle(),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '3 — drag handle    4 — sheet surface    '
                            '5 — content',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontFamily: 'monospace',
                              color: _kInkSecondary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      _mockListTile(label: 'Action', icon: Icons.share),
                      _mockListTile(label: 'Action', icon: Icons.copy),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Layers 1 and 2 are owned by the modal route; layers 3-5 are the '
          'BottomSheet widget itself. showBottomSheet skips layer 2 entirely '
          'and inserts layers 3-5 as siblings of the Scaffold body.',
          style: _kBodySoftStyle,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 - PARAMETER ANATOMY
// ---------------------------------------------------------------------------
// Every parameter of showModalBottomSheet (Flutter 3.16+) gets a row in this
// table. The schema is: name, dart type, default, single-sentence purpose.

class _ParamRow {
  const _ParamRow(this.name, this.type, this.defaultValue, this.purpose,
      {this.category = 'layout'});
  final String name;
  final String type;
  final String defaultValue;
  final String purpose;
  final String category;
}

const List<_ParamRow> _kParamRows = <_ParamRow>[
  _ParamRow('context', 'BuildContext', 'required',
      'The element whose Navigator pushes the route.',
      category: 'context'),
  _ParamRow('builder', 'WidgetBuilder', 'required',
      'Build callback for the sheet contents; receives a fresh context.',
      category: 'content'),
  _ParamRow('backgroundColor', 'Color?', 'theme.surface',
      'Body fill. Overrides BottomSheetThemeData.backgroundColor.',
      category: 'visual'),
  _ParamRow('barrierColor', 'Color?', 'Color(0x80000000)',
      'Scrim tint behind the sheet. null forwards to BarrierTheme.',
      category: 'visual'),
  _ParamRow('barrierLabel', 'String?', 'modalBarrierDismissLabel',
      'Accessibility label announced for the scrim region.',
      category: 'visual'),
  _ParamRow('elevation', 'double?', 'theme.modal=1.0',
      'Z-elevation used to compute the surfaceTint overlay in M3.',
      category: 'visual'),
  _ParamRow('shape', 'ShapeBorder?', 'top28dpRoundedRect',
      'Sheet outline. Default rounds top corners only at 28dp.',
      category: 'visual'),
  _ParamRow('clipBehavior', 'Clip?', 'Clip.antiAlias',
      'Clips content to shape; antialias produces the smoothest corners.',
      category: 'visual'),
  _ParamRow('constraints', 'BoxConstraints?', 'null',
      'Optional layout constraints; bypasses the default 0.5 maxHeight cap.',
      category: 'layout'),
  _ParamRow('isScrollControlled', 'bool', 'false',
      'When true, body owns its own ScrollController; height cap is removed.',
      category: 'layout'),
  _ParamRow('useRootNavigator', 'bool', 'false',
      'When true, walks up to the root Navigator before pushing.',
      category: 'route'),
  _ParamRow('useSafeArea', 'bool', 'false',
      'Wraps the sheet in a SafeArea so it respects display cutouts.',
      category: 'layout'),
  _ParamRow('isDismissible', 'bool', 'true',
      'When true, taps on the scrim pop the route.',
      category: 'gesture'),
  _ParamRow('enableDrag', 'bool', 'true',
      'When true, vertical drags can dismiss the sheet.',
      category: 'gesture'),
  _ParamRow('showDragHandle', 'bool?', 'theme.showDragHandle',
      'When true, the 32x4dp drag-handle pill is drawn at the top.',
      category: 'visual'),
  _ParamRow('transitionAnimationController', 'AnimationController?', 'internal',
      'Reuse an existing ticker; defaults to a route-owned controller.',
      category: 'animation'),
  _ParamRow('anchorPoint', 'Offset?', 'null',
      'Hint for which display the sheet should appear on (multi-display).',
      category: 'route'),
  _ParamRow('routeSettings', 'RouteSettings?', 'null',
      'Settings forwarded to the pushed ModalRoute.',
      category: 'route'),
  _ParamRow('sheetAnimationStyle', 'AnimationStyle?', 'null',
      'Override the sheet enter/exit AnimationStyle (Flutter 3.22+).',
      category: 'animation'),
];

Color _categoryColour(String category) {
  if (category == 'context') return _kAccentSlate;
  if (category == 'content') return _kAccentBlue;
  if (category == 'visual') return _kAccentViolet;
  if (category == 'layout') return _kAccentTeal;
  if (category == 'route') return _kAccentRose;
  if (category == 'gesture') return _kAccentAmber;
  if (category == 'animation') return _kAccentOrange;
  return _kInkTertiary;
}

Widget _parameterRow(_ParamRow row, {required bool zebra}) {
  return Container(
    color: zebra ? _kCardSoft : _kCardBg,
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 9.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 180.0,
          child: Text(row.name, style: _kMonoInlineStyle),
        ),
        SizedBox(
          width: 170.0,
          child: Text(
            row.type,
            style: const TextStyle(
              fontSize: 12.5,
              fontFamily: 'monospace',
              color: _kAccent,
            ),
          ),
        ),
        SizedBox(
          width: 140.0,
          child: Text(
            row.defaultValue,
            style: const TextStyle(
              fontSize: 12.5,
              fontFamily: 'monospace',
              color: _kInkSecondary,
            ),
          ),
        ),
        SizedBox(
          width: 84.0,
          child: _pill(row.category, colour: _categoryColour(row.category)),
        ),
        Expanded(
          child: Text(
            row.purpose,
            style: const TextStyle(
              fontSize: 12.5,
              color: _kInk,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _parameterTable() {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < _kParamRows.length; i += 1) {
    rows.add(_parameterRow(_kParamRows[i], zebra: i.isOdd));
  }
  return _card(
    padding: const EdgeInsets.all(6.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 12.0),
          decoration: const BoxDecoration(
            color: _kCardDark,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: const Row(
            children: <Widget>[
              SizedBox(
                width: 180.0,
                child: Text('name',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'monospace',
                        color: _kInkOnDark,
                        fontWeight: FontWeight.w700)),
              ),
              SizedBox(
                width: 170.0,
                child: Text('type',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'monospace',
                        color: _kInkOnDark,
                        fontWeight: FontWeight.w700)),
              ),
              SizedBox(
                width: 140.0,
                child: Text('default',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'monospace',
                        color: _kInkOnDark,
                        fontWeight: FontWeight.w700)),
              ),
              SizedBox(
                width: 84.0,
                child: Text('cat',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'monospace',
                        color: _kInkOnDark,
                        fontWeight: FontWeight.w700)),
              ),
              Expanded(
                child: Text('purpose',
                    style: TextStyle(
                        fontSize: 12.0,
                        fontFamily: 'monospace',
                        color: _kInkOnDark,
                        fontWeight: FontWeight.w700)),
              ),
            ],
          ),
        ),
        ...rows,
      ],
    ),
  );
}

Widget _paramCategoryLegend() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('Category legend',
            subtitle:
                'Each parameter is bucketed by what it controls. Mix-and-match across categories defines the personality of every concrete sheet.'),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _pill('context', colour: _categoryColour('context')),
            _pill('content', colour: _categoryColour('content')),
            _pill('visual', colour: _categoryColour('visual')),
            _pill('layout', colour: _categoryColour('layout')),
            _pill('route', colour: _categoryColour('route')),
            _pill('gesture', colour: _categoryColour('gesture')),
            _pill('animation', colour: _categoryColour('animation')),
          ],
        ),
        const SizedBox(height: 12.0),
        _kvRow('context', 'Which navigator owns the future.'),
        _kvRow('content', 'What renders inside the sheet body.'),
        _kvRow('visual', 'Surface tint, shape, corners, elevation.'),
        _kvRow('layout', 'Constraints, safe-area, scroll behaviour.'),
        _kvRow('route', 'Navigator routing, settings, anchor.'),
        _kvRow('gesture', 'Drag/dismiss intent handling.'),
        _kvRow('animation', 'Ticker, AnimationStyle, transition curve.'),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 - MOCK SHEET GALLERY
// ---------------------------------------------------------------------------
// Eight viewports, each showing a different parameter configuration. We
// emphasise the configurations engineers actually reach for in real apps.

Widget _galleryDefaultModal() {
  return _mockViewport(
    label: 'Default modal sheet — isScrollControlled: false',
    appBarTitle: 'Compose',
    sheet: _mockSheet(
      height: 200.0,
      title: 'Share to…',
      showHandle: true,
      tileCount: 3,
    ),
    badges: <Widget>[
      _pill('isScrollControlled: false', colour: _kAccentTeal),
      _pill('showDragHandle: true', colour: _kAccentViolet),
      _pill('isDismissible: true', colour: _kAccentAmber),
      _pill('enableDrag: true', colour: _kAccentAmber),
    ],
  );
}

Widget _galleryScrollControlled() {
  return _mockViewport(
    label: 'isScrollControlled: true — claims the full height',
    appBarTitle: 'Cart',
    height: 340.0,
    sheet: _mockSheet(
      height: 280.0,
      title: 'Edit address',
      showHandle: true,
      tileCount: 6,
    ),
    badges: <Widget>[
      _pill('isScrollControlled: true', colour: _kAccentRose),
      _pill('useSafeArea: true', colour: _kAccentBlue),
      _pill('child: ListView.builder', colour: _kAccentGreen),
    ],
  );
}

Widget _galleryNoHandle() {
  return _mockViewport(
    label: 'showDragHandle: false — flat top, gesture only on body',
    appBarTitle: 'Profile',
    sheet: _mockSheet(
      height: 180.0,
      title: 'Sign out?',
      showHandle: false,
      tileCount: 2,
    ),
    badges: <Widget>[
      _pill('showDragHandle: false', colour: _kAccentRose),
      _pill('enableDrag: true', colour: _kAccentAmber),
    ],
  );
}

Widget _gallerySafeArea() {
  return _mockViewport(
    label: 'useSafeArea: true — respects display cutout & home-indicator',
    appBarTitle: 'Map',
    sheet: Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: _mockSheet(
        height: 200.0,
        title: 'Nearby places',
        showHandle: true,
        tileCount: 3,
      ),
    ),
    badges: <Widget>[
      _pill('useSafeArea: true', colour: _kAccentBlue),
      _pill('bottom inset = 24dp', colour: _kAccentSlate),
    ],
  );
}

Widget _galleryCustomShape() {
  return _mockViewport(
    label: 'shape: top-radius 8dp + tinted background',
    appBarTitle: 'Photos',
    sheet: _mockSheet(
      height: 200.0,
      title: 'Edit photo',
      topRadius: 8.0,
      surface: _kSheetSurfaceWarm,
      tileCount: 3,
    ),
    badges: <Widget>[
      _pill('shape: RRect top 8dp', colour: _kAccentViolet),
      _pill('backgroundColor: surfaceWarm', colour: _kAccentOrange),
      _pill('elevation: 4', colour: _kAccentSlate),
    ],
  );
}

Widget _galleryFullScreen() {
  return _mockViewport(
    label: 'isScrollControlled + DraggableScrollableSheet → near full screen',
    appBarTitle: 'Inbox',
    height: 360.0,
    sheet: _mockSheet(
      height: 320.0,
      title: 'Messages',
      showHandle: true,
      tileCount: 8,
    ),
    badges: <Widget>[
      _pill('isScrollControlled: true', colour: _kAccentRose),
      _pill('DraggableScrollableSheet', colour: _kAccentBlue),
      _pill('initialChildSize: 0.9', colour: _kAccentTeal),
    ],
  );
}

Widget _galleryPersistent() {
  return _mockViewport(
    label: 'showBottomSheet — no scrim, stays attached to Scaffold',
    appBarTitle: 'Music',
    persistent: true,
    showScrim: false,
    sheet: _mockSheet(
      height: 160.0,
      title: 'Now playing',
      showHandle: true,
      surface: _kSheetSurfaceCool,
      tileCount: 2,
    ),
    badges: <Widget>[
      _pill('persistent', colour: _kAccentGreen),
      _pill('barrierColor: none', colour: _kAccentSlate),
      _pill('controller.close() to dismiss', colour: _kAccentBlue),
    ],
  );
}

Widget _galleryNonDismissible() {
  return _mockViewport(
    label: 'isDismissible: false — scrim ignores taps (consent dialog feel)',
    appBarTitle: 'Onboarding',
    scrim: _kScrimHard,
    sheet: _mockSheet(
      height: 220.0,
      title: 'Accept terms',
      showHandle: false,
      tileCount: 3,
    ),
    badges: <Widget>[
      _pill('isDismissible: false', colour: _kAccentRose),
      _pill('enableDrag: false', colour: _kAccentRose),
      _pill('barrierColor: 0xB3000000', colour: _kAccentSlate),
    ],
  );
}

Widget _gallerySection() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 8.0),
        child: _galleryDefaultModal(),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 8.0),
        child: _galleryScrollControlled(),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 8.0),
        child: _galleryNoHandle(),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 8.0),
        child: _gallerySafeArea(),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 8.0),
        child: _galleryCustomShape(),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 8.0),
        child: _galleryFullScreen(),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 8.0),
        child: _galleryPersistent(),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 8.0),
        child: _galleryNonDismissible(),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 - BARRIER DIAGRAM
// ---------------------------------------------------------------------------

Widget _barrierStackLayer(String label, Color colour, double opacity,
    {bool dashed = false}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 3.0),
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: colour.withOpacity(opacity),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(
        color: colour.withOpacity(0.5),
        width: dashed ? 1.5 : 1.0,
      ),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 28.0,
          height: 28.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: const Icon(Icons.layers, size: 16.0, color: Color(0xFFFFFFFF)),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13.0,
              color: _kInk,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _barrierDiagram() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('The barrier scrim, layer by layer',
            subtitle:
                'A modal route inserts three siblings into the Overlay: the '
                'scrim, the sheet body, and the gesture detector that funnels '
                'pop intents.'),
        const SizedBox(height: 14.0),
        _barrierStackLayer(
            'Overlay parent — owned by Navigator', _kAccentSlate, 0.10),
        _barrierStackLayer(
            'ModalBarrier — uses barrierColor + barrierLabel + semanticsDismissible',
            _kAccentRose,
            0.18),
        _barrierStackLayer(
            'AnimatedBuilder<double> — interpolates scrim alpha',
            _kAccentAmber,
            0.18),
        _barrierStackLayer(
            'BottomSheet — the visible widget, gesture-detecting',
            _kAccentViolet,
            0.18),
        _barrierStackLayer(
            'PrimaryFocusScope — keyboard reaches the sheet, not the page',
            _kAccentBlue,
            0.18),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: const Text(
            'When `isDismissible: false`, the ModalBarrier still paints but '
            'its onTap is null. The scrim therefore looks like a normal '
            'scrim but ignores pointer events, which can confuse users — '
            'pair it with an explicit close button inside the sheet.',
            style: _kBodySoftStyle,
          ),
        ),
      ],
    ),
  );
}

Widget _barrierColorVariants() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('barrierColor — three common values',
            subtitle:
                'Pure black at 50% is the default; a tinted scrim can match '
                'the page mood; a near-opaque scrim signals destructive '
                'intent.'),
        const SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            Expanded(child: _barrierSwatch('default', _kScrim, '0x80000000')),
            const SizedBox(width: 12.0),
            Expanded(
                child: _barrierSwatch(
                    'tinted', const Color(0x804F46E5), '0x804F46E5')),
            const SizedBox(width: 12.0),
            Expanded(
                child:
                    _barrierSwatch('opaque', _kScrimHard, '0xB3000000')),
          ],
        ),
      ],
    ),
  );
}

Widget _barrierSwatch(String label, Color scrim, String hex) {
  return Container(
    height: 110.0,
    decoration: BoxDecoration(
      color: const Color(0xFFE7E0EC),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kHairline),
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Stack(
        children: <Widget>[
          Positioned.fill(child: Container(color: scrim)),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            height: 50.0,
            child: Container(
              decoration: const BoxDecoration(
                color: _kSheetSurface,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(14.0),
                  topRight: Radius.circular(14.0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 6.0),
                    width: 24.0,
                    height: 3.0,
                    decoration: BoxDecoration(
                      color: _kSheetHandle,
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 8.0,
            top: 6.0,
            child: Text(label,
                style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFFFFFFF))),
          ),
          Positioned(
            right: 8.0,
            top: 6.0,
            child: Text(hex,
                style: const TextStyle(
                    fontSize: 10.5,
                    fontFamily: 'monospace',
                    color: Color(0xFFFFFFFF))),
          ),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 - MODAL vs PERSISTENT MATRIX
// ---------------------------------------------------------------------------

class _MatrixRow {
  const _MatrixRow(this.axis, this.modal, this.persistent, this.scaffoldSheet);
  final String axis;
  final String modal;
  final String persistent;
  final String scaffoldSheet;
}

const List<_MatrixRow> _kMatrix = <_MatrixRow>[
  _MatrixRow('API entry',
      'showModalBottomSheet<T>()',
      'showBottomSheet<T>()',
      'Scaffold(bottomSheet: ...)'),
  _MatrixRow('Return type',
      'Future<T?>',
      'PersistentBottomSheetController<T>',
      '— (widget property)'),
  _MatrixRow('Scrim?',
      'yes (ModalBarrier)',
      'no',
      'no'),
  _MatrixRow('Steals focus?',
      'yes (FocusScope barrier)',
      'no',
      'no'),
  _MatrixRow('Pushes a route?',
      'yes (ModalBottomSheetRoute)',
      'yes (LocalHistoryEntry)',
      'no'),
  _MatrixRow('Coexists with body?',
      'no — page is covered',
      'yes — body remains tappable',
      'yes — Scaffold lays them out'),
  _MatrixRow('Default height cap',
      '9/16 unless isScrollControlled',
      'no cap',
      'no cap'),
  _MatrixRow('Drag dismiss?',
      'yes if enableDrag',
      'yes if enableDrag',
      'driven by user code'),
  _MatrixRow('Tap-scrim dismiss?',
      'yes if isDismissible',
      'n/a (no scrim)',
      'n/a'),
  _MatrixRow('Animation owner',
      'route owns AnimationController',
      'Scaffold owns AnimationController',
      'Scaffold owns AnimationController'),
  _MatrixRow('Multi-display anchorPoint',
      'supported',
      'inherits Scaffold display',
      'inherits Scaffold display'),
  _MatrixRow('Best for',
      'destructive picks, action sheets',
      'companion controls (player, editor)',
      'always-present companion'),
];

Widget _matrixHeader() {
  return Container(
    padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 12.0),
    decoration: const BoxDecoration(
      color: _kCardDark,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.0),
        topRight: Radius.circular(10.0),
      ),
    ),
    child: const Row(
      children: <Widget>[
        SizedBox(
          width: 160.0,
          child: Text('axis',
              style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  color: _kInkOnDark,
                  fontWeight: FontWeight.w700)),
        ),
        Expanded(
          child: Text('showModalBottomSheet',
              style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  color: _kInkOnDark,
                  fontWeight: FontWeight.w700)),
        ),
        Expanded(
          child: Text('showBottomSheet',
              style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  color: _kInkOnDark,
                  fontWeight: FontWeight.w700)),
        ),
        Expanded(
          child: Text('Scaffold.bottomSheet',
              style: TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  color: _kInkOnDark,
                  fontWeight: FontWeight.w700)),
        ),
      ],
    ),
  );
}

Widget _matrixRow(_MatrixRow row, {required bool zebra}) {
  return Container(
    color: zebra ? _kCardSoft : _kCardBg,
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 160.0,
          child: Text(row.axis,
              style: const TextStyle(
                  fontSize: 12.5,
                  fontFamily: 'monospace',
                  color: _kInkSecondary,
                  fontWeight: FontWeight.w600)),
        ),
        Expanded(child: Text(row.modal, style: _kBodyStyle)),
        Expanded(child: Text(row.persistent, style: _kBodyStyle)),
        Expanded(child: Text(row.scaffoldSheet, style: _kBodyStyle)),
      ],
    ),
  );
}

Widget _modalVsPersistentMatrix() {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < _kMatrix.length; i += 1) {
    rows.add(_matrixRow(_kMatrix[i], zebra: i.isOdd));
  }
  return _card(
    padding: const EdgeInsets.all(6.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _matrixHeader(),
        ...rows,
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 - M3 SPEC PANEL
// ---------------------------------------------------------------------------

Widget _elevationSwatch(String level, double tonal, Color tint) {
  return Container(
    width: 96.0,
    margin: const EdgeInsets.only(right: 10.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: tint,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kHairline),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0x29000000),
          offset: Offset(0.0, tonal * 0.5),
          blurRadius: tonal * 1.2,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          level,
          style: const TextStyle(
            fontSize: 12.5,
            fontWeight: FontWeight.w700,
            color: _kInk,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          '${tonal.toStringAsFixed(0)} dp',
          style: const TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            color: _kInkSecondary,
          ),
        ),
        const SizedBox(height: 16.0),
        Container(
          height: 24.0,
          decoration: BoxDecoration(
            color: _kSheetSurface,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: _kSheetEdge),
          ),
        ),
      ],
    ),
  );
}

Widget _m3SpecPanel() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('Material 3 spec conformance',
            subtitle:
                'Default visual values come straight from BottomSheetThemeData '
                'when the host MaterialApp uses ThemeData(useMaterial3: true).'),
        const SizedBox(height: 14.0),
        _kvRow('shape (default)',
            'RoundedRectangleBorder(top: 28dp, bottom: 0)'),
        _kvRow('backgroundColor', 'theme.colorScheme.surfaceContainerLow'),
        _kvRow('surfaceTintColor', 'theme.colorScheme.surfaceTint'),
        _kvRow('modalBackgroundColor',
            'theme.colorScheme.surfaceContainerLow'),
        _kvRow('modalElevation', '1.0 dp'),
        _kvRow('elevation (persistent)', '4.0 dp'),
        _kvRow('dragHandleSize', 'Size(32, 4)'),
        _kvRow('dragHandleColor',
            'theme.colorScheme.onSurfaceVariant @ 40% opacity'),
        _kvRow('clipBehavior', 'Clip.antiAlias'),
        _kvRow('constraints.maxWidth (compact)', '640 dp'),
        _kvRow('barrierColor', 'theme.colorScheme.scrim @ 50% opacity'),
        const SizedBox(height: 14.0),
        const Text('Tonal elevation curve',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: _kInk,
            )),
        const SizedBox(height: 8.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              _elevationSwatch('L0', 0.0, const Color(0xFFFFFFFF)),
              _elevationSwatch('L1', 1.0, const Color(0xFFF7F2FA)),
              _elevationSwatch('L2', 3.0, const Color(0xFFF1ECF4)),
              _elevationSwatch('L3', 6.0, const Color(0xFFECE6F0)),
              _elevationSwatch('L4', 8.0, const Color(0xFFE9E3ED)),
              _elevationSwatch('L5', 12.0, const Color(0xFFE6E0E9)),
            ],
          ),
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
            'Modal sheets render at elevation L1 (≈1dp) so they pair with '
            'the scrim. Persistent sheets render at elevation L3-L4 because '
            'no scrim exists and the surface needs to differentiate itself '
            'from the body.',
            style: _kBodyStyle,
          ),
        ),
      ],
    ),
  );
}

Widget _m3DragHandleSpec() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle('Drag handle dimensions',
            subtitle:
                'A 32x4dp pill, vertically padded by 22dp on top and 22dp on '
                'the bottom, centred horizontally.'),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: _kSheetSurface,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kSheetEdge),
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: 32.0,
                height: 4.0,
                decoration: BoxDecoration(
                  color: _kSheetHandle,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _pill('width 32dp', colour: _kAccent),
                  const SizedBox(width: 8.0),
                  _pill('height 4dp', colour: _kAccentBlue),
                  const SizedBox(width: 8.0),
                  _pill('radius 2dp', colour: _kAccentTeal),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 - CODE RECIPES
// ---------------------------------------------------------------------------

const String _kCodeBasic = '''final String? choice = await showModalBottomSheet<String>(
  context: context,
  builder: (BuildContext ctx) {
    return SafeArea(
      child: Wrap(
        children: <Widget>[
          ListTile(title: const Text('Share'),
              onTap: () => Navigator.pop(ctx, 'share')),
          ListTile(title: const Text('Copy'),
              onTap: () => Navigator.pop(ctx, 'copy')),
        ],
      ),
    );
  },
);''';

const String _kCodeScrollControlled = '''showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true, // unlock the 0.5 height cap
  useSafeArea: true,        // respect display cutouts
  builder: (BuildContext ctx) {
    return DraggableScrollableSheet(
      initialChildSize: 0.85,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      expand: false,
      builder: (BuildContext ctx, ScrollController c) {
        return ListView.builder(
          controller: c,
          itemCount: 200,
          itemBuilder: (_, int i) => ListTile(title: Text('Row #' + '\$i')),
        );
      },
    );
  },
);''';

const String _kCodeThemed = '''showModalBottomSheet<void>(
  context: context,
  backgroundColor: Theme.of(context).colorScheme.surfaceContainerLowest,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
  ),
  elevation: 4.0,
  clipBehavior: Clip.antiAlias,
  showDragHandle: true,
  builder: (BuildContext ctx) => const _MyEditorSheet(),
);''';

const String _kCodePersistent = '''final PersistentBottomSheetController<void> controller =
    Scaffold.of(context).showBottomSheet<void>(
  (BuildContext ctx) => const _PlayerControls(),
  backgroundColor: theme.colorScheme.surfaceContainerLow,
  elevation: 4.0,
);
// later:
controller.close();''';

const String _kCodeKeyboard = '''showModalBottomSheet<void>(
  context: context,
  isScrollControlled: true, // mandatory when content uses TextField
  builder: (BuildContext ctx) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(ctx).viewInsets.bottom,
      ),
      child: const _ComposeForm(),
    );
  },
);''';

const String _kCodeRootNav = '''showModalBottomSheet<void>(
  context: context,
  useRootNavigator: true, // skip nested Navigator (e.g. inside a BottomNav)
  routeSettings: const RouteSettings(name: '/share-sheet'),
  builder: (BuildContext ctx) => const _ShareSheet(),
);''';

Widget _codeRecipes() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _codeBlock(_kCodeBasic, title: 'basic.dart — picker that returns a String'),
      _codeBlock(_kCodeScrollControlled,
          title: 'scroll_controlled.dart — DraggableScrollableSheet inside'),
      _codeBlock(_kCodeThemed,
          title: 'themed.dart — custom shape, elevation, surface tint'),
      _codeBlock(_kCodePersistent,
          title: 'persistent.dart — Scaffold.of(context).showBottomSheet'),
      _codeBlock(_kCodeKeyboard,
          title: 'keyboard.dart — viewInsets padding for TextField content'),
      _codeBlock(_kCodeRootNav,
          title: 'root_navigator.dart — skip nested navigators'),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 8 - MODAL ROUTE LIFECYCLE
// ---------------------------------------------------------------------------

class _LifecycleStep {
  const _LifecycleStep(this.title, this.detail, this.colour);
  final String title;
  final String detail;
  final Color colour;
}

const List<_LifecycleStep> _kLifecycle = <_LifecycleStep>[
  _LifecycleStep(
      '1 · push',
      'showModalBottomSheet calls Navigator.of(context).push(ModalBottomSheetRoute).',
      _kAccent),
  _LifecycleStep(
      '2 · install',
      'ModalRoute creates AnimationController; OverlayEntries for barrier + body added.',
      _kAccentBlue),
  _LifecycleStep(
      '3 · animate-in',
      'AnimationController.forward(); barrier alpha 0→1, sheet slides bottom→0.',
      _kAccentTeal),
  _LifecycleStep(
      '4 · settled',
      'AnimationStatus.completed; sheet receives focus; primary FocusScope swaps.',
      _kAccentGreen),
  _LifecycleStep(
      '5 · interactive',
      'User scrolls, drags, taps tiles; Navigator.pop(result) is the exit signal.',
      _kAccentAmber),
  _LifecycleStep(
      '6 · animate-out',
      'AnimationController.reverse(); barrier alpha 1→0; sheet slides back down.',
      _kAccentOrange),
  _LifecycleStep(
      '7 · dispose',
      'Route popped; OverlayEntries removed; AnimationController disposed; Future completes.',
      _kAccentRose),
];

Widget _lifecycleNode(_LifecycleStep step) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4.0),
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: step.colour.withOpacity(0.10),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: step.colour.withOpacity(0.4)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 32.0,
          height: 32.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: step.colour,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Icon(Icons.bolt, size: 18.0, color: Color(0xFFFFFFFF)),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(step.title,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  )),
              const SizedBox(height: 3.0),
              Text(step.detail, style: _kBodySoftStyle),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _lifecycleArrow() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.0),
    child: Row(
      children: <Widget>[
        const SizedBox(width: 28.0),
        Container(
          width: 2.0,
          height: 14.0,
          color: _kAccent.withOpacity(0.4),
        ),
      ],
    ),
  );
}

Widget _lifecycleDiagram() {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < _kLifecycle.length; i += 1) {
    rows.add(_lifecycleNode(_kLifecycle[i]));
    if (i < _kLifecycle.length - 1) {
      rows.add(_lifecycleArrow());
    }
  }
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _cardTitle('ModalBottomSheetRoute lifecycle',
            subtitle:
                'The seven states a modal sheet walks through, from push '
                'to dispose. AnimationController is owned by the route, not '
                'by your builder.'),
        const SizedBox(height: 12.0),
        ...rows,
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 9 - PITFALLS
// ---------------------------------------------------------------------------

class _Pitfall {
  const _Pitfall(this.title, this.symptom, this.fix, this.colour);
  final String title;
  final String symptom;
  final String fix;
  final Color colour;
}

const List<_Pitfall> _kPitfalls = <_Pitfall>[
  _Pitfall(
      'ListView with isScrollControlled: false',
      'Sheet locks at 50% screen height; inner ListView never scrolls past the cap.',
      'Set isScrollControlled: true and wrap content in DraggableScrollableSheet (or SizedBox.expand).',
      _kAccentRose),
  _Pitfall(
      'TextField inside a default sheet',
      'Keyboard opens, sheet content is hidden beneath the IME.',
      'Set isScrollControlled: true AND pad the body with MediaQuery.viewInsets.bottom.',
      _kAccentRose),
  _Pitfall(
      'useRootNavigator: false inside a tab',
      'Nested Navigator pops the sheet but the tab bar still covers half of it.',
      'Use useRootNavigator: true when you want full-screen modal feel.',
      _kAccentOrange),
  _Pitfall(
      'Hero leak on dismiss',
      'AnimationController disposed before Hero ticker finishes; assertion fires.',
      'Pass your own transitionAnimationController and dispose it after the future settles.',
      _kAccentAmber),
  _Pitfall(
      'isDismissible: false confuses users',
      'Scrim looks tappable but absorbs taps silently.',
      'Add an explicit close button inside the sheet body, or remove the scrim with a different UX.',
      _kAccentOrange),
  _Pitfall(
      'Calling showBottomSheet outside a Scaffold',
      'Throws "No Scaffold widget found"; persistent sheets need a Scaffold ancestor.',
      'Use Scaffold.of(context).showBottomSheet, and ensure the context is below the Scaffold.',
      _kAccentRose),
  _Pitfall(
      'BackdropFilter inside a sheet on Android < 8',
      'Performance drops; sheet drag becomes janky during the slide-in.',
      'Avoid live blurs; use a static frosted-glass image, or guard with Platform.isAndroid.',
      _kAccentAmber),
  _Pitfall(
      'showModalBottomSheet inside a Builder + Theme.of',
      'Sheet does not inherit your overlay theme overrides.',
      'Wrap the builder return in a fresh Theme(data: Theme.of(parent), child: ...).',
      _kAccentOrange),
];

Widget _pitfallCard(_Pitfall p) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: p.colour.withOpacity(0.06),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: p.colour.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.warning_amber_rounded, size: 18.0, color: p.colour),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(p.title,
                  style: const TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  )),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        _kvRow('symptom', p.symptom),
        _kvRow('fix', p.fix, valueColour: _kAccentGreen),
      ],
    ),
  );
}

Widget _pitfallsSection() {
  final List<Widget> cards = <Widget>[];
  for (int i = 0; i < _kPitfalls.length; i += 1) {
    cards.add(_pitfallCard(_kPitfalls[i]));
  }
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _cardTitle('Eight pitfalls',
            subtitle:
                'Field-tested traps with the symptom you will see and the '
                'one-line fix.'),
        const SizedBox(height: 10.0),
        ...cards,
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 10 - CHEAT SHEET FOOTER
// ---------------------------------------------------------------------------

Widget _chipGroup(String title, List<String> chips, Color colour) {
  final List<Widget> pills = <Widget>[];
  for (int i = 0; i < chips.length; i += 1) {
    pills.add(_pill(chips[i], colour: colour));
  }
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title,
            style: const TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: _kInkOnDark,
              fontFamily: 'monospace',
            )),
        const SizedBox(height: 6.0),
        Wrap(spacing: 6.0, runSpacing: 6.0, children: pills),
      ],
    ),
  );
}

Widget _cheatSheetFooter() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: _kCardDark,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _kHairlineDark),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Cheat-sheet',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              color: _kInkOnDark,
              letterSpacing: -0.3,
            )),
        const SizedBox(height: 4.0),
        const Text(
          'Pin this strip; everything you reach for day-to-day on the '
          'showBottomSheet API surface.',
          style: TextStyle(fontSize: 12.5, color: _kInkOnDarkSecondary),
        ),
        const SizedBox(height: 10.0),
        _chipGroup('functions', const <String>[
          'showModalBottomSheet',
          'showBottomSheet',
          'Scaffold.of(context).showBottomSheet',
        ], const Color(0xFFFDE68A)),
        _chipGroup('widgets', const <String>[
          'BottomSheet',
          'DraggableScrollableSheet',
          'PersistentBottomSheetController',
          'ModalBottomSheetRoute',
        ], const Color(0xFF93C5FD)),
        _chipGroup('layout knobs', const <String>[
          'isScrollControlled',
          'useSafeArea',
          'constraints',
          'anchorPoint',
        ], const Color(0xFFA7F3D0)),
        _chipGroup('visual knobs', const <String>[
          'backgroundColor',
          'elevation',
          'shape',
          'clipBehavior',
          'showDragHandle',
          'barrierColor',
          'barrierLabel',
        ], const Color(0xFFFBCFE8)),
        _chipGroup('gesture knobs', const <String>[
          'isDismissible',
          'enableDrag',
        ], const Color(0xFFFCD34D)),
        _chipGroup('routing knobs', const <String>[
          'useRootNavigator',
          'routeSettings',
        ], const Color(0xFFFCA5A5)),
        _chipGroup('animation knobs', const <String>[
          'transitionAnimationController',
          'sheetAnimationStyle',
        ], const Color(0xFFC4B5FD)),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: const Text(
            'Tagline: "Modal sheets are routes with a scrim. Persistent '
            'sheets are widgets with no scrim. Both are 28dp at the top, '
            '0dp at the bottom, and both want isScrollControlled when you '
            'render a ListView."',
            style: TextStyle(
              color: Color(0xFFEDEEF5),
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
// The interpreter calls this function exactly once. No live AnimationController
// is created; no showModalBottomSheet call is issued. The returned tree is a
// long static gallery that documents the API by drawing it.
// ===========================================================================
dynamic build(BuildContext context) {
  print('showModalBottomSheet visual demo: building widget tree');
  print('kDebugMode=$kDebugMode');
  // Doing some `math` work so the import survives a lint pass.
  final double diagonal = math.sqrt(28.0 * 28.0 + 4.0 * 4.0);
  print('drag-handle diagonal=$diagonal');
  print('parameter count=${_kParamRows.length}');
  print('matrix rows=${_kMatrix.length}');
  print('lifecycle steps=${_kLifecycle.length}');
  print('pitfall count=${_kPitfalls.length}');

  return Container(
    color: _kCanvas,
    child: SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _heroBanner(),
          _sectionHeader(1, 'Modal vs persistent',
              'Two sister functions, one shared visual spec.'),
          _heroIntroCard(),
          _heroOverview(),
          _sectionDivider(),

          _sectionHeader(2, 'Parameter anatomy',
              'Seventeen knobs, bucketed by what they control.'),
          _parameterTable(),
          _paramCategoryLegend(),
          _sectionDivider(),

          _sectionHeader(3, 'Mock sheet gallery',
              'Eight viewports that show how each knob looks on screen.'),
          _gallerySection(),
          _sectionDivider(),

          _sectionHeader(4, 'The barrier layer',
              'Scrim alpha, dismiss semantics and the overlay stack.'),
          _barrierDiagram(),
          _barrierColorVariants(),
          _sectionDivider(),

          _sectionHeader(5, 'Modal vs persistent matrix',
              'Twelve axes across the three ways to ship a bottom sheet.'),
          _modalVsPersistentMatrix(),
          _sectionDivider(),

          _sectionHeader(6, 'Material 3 spec conformance',
              'Surface, shape, drag-handle and tonal elevation defaults.'),
          _m3SpecPanel(),
          _m3DragHandleSpec(),
          _sectionDivider(),

          _sectionHeader(7, 'Code recipes',
              'Six idiomatic call sites you will paste again and again.'),
          _codeRecipes(),
          _sectionDivider(),

          _sectionHeader(8, 'Modal route lifecycle',
              'Seven states a ModalBottomSheetRoute walks through.'),
          _lifecycleDiagram(),
          _sectionDivider(),

          _sectionHeader(9, 'Pitfalls',
              'Eight callouts that bite Flutter engineers in production.'),
          _pitfallsSection(),
          _sectionDivider(),

          _sectionHeader(10, 'Cheat-sheet',
              'A compact strip of the showBottomSheet API surface.'),
          _cheatSheetFooter(),
        ],
      ),
    ),
  );
}
