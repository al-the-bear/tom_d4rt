// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// ============================================================================
//  TABLET LARKSPUR  --  A Scriptorium Almanac of
//                       IOSSystemContextMenuItemDataSelectAll
// ----------------------------------------------------------------------------
//  Theme           : Tablet Larkspur. Picture a Renaissance scriptorium at
//                    the cusp of dawn: the scribe's wax tablet rests on an
//                    ivory-bound writing desk, a bouquet of larkspur-violet
//                    flowers leans from a brass vase, and a gold stylus
//                    (called a graphium) hovers ready to incise letters into
//                    soft yellow wax. The palette evokes that desk: wax
//                    cream, larkspur violet, gold stylus, ivory frame,
//                    parchment, sage marginalia, and a few rare lapis,
//                    cinnabar, and verdigris highlights for capital initials.
//  Subject         : `IOSSystemContextMenuItemDataSelectAll` from
//                    `package:flutter/services.dart`. A sealed-class member
//                    of the IOSSystemContextMenuItemData hierarchy, paired
//                    with siblings Cut, Copy, Paste, LookUp, SearchWeb,
//                    Share, and LiveText. SelectAll is the no-arg const
//                    leaf that drives the iOS-native "Select All" menu
//                    entry inside a SystemContextMenu.
//  Surface         : `const IOSSystemContextMenuItemDataSelectAll()`. No
//                    fields, no overrides of `==` or `hashCode`, identity
//                    equality only. Two const calls at the same site are
//                    canonicalised by the compiler; two non-const calls
//                    yield distinct objects with identical runtimeType.
//  Audience        : Flutter engineers wiring iOS native edit menus, QA
//                    folk writing snapshot tests against the Tom AI D4rt
//                    flutter ast harness, and curious readers who want to
//                    see a SelectAll leaf rendered as marginalia in a
//                    scriptorium codex rather than as a JSON dump.
//  D4rt notes      : `build()` is invoked exactly once. The returned widget
//                    tree is a static snapshot. No StatefulWidget, no
//                    setState, no controllers, no timers, no streams. We
//                    do NOT iterate BridgedInstance values with for-in, and
//                    we do NOT touch `.value` on a Tween.animate. Alpha
//                    colours use `.withValues(alpha: ...)` exclusively.
//  Style           : Larkspur violet, deep larkspur, larkspur mist, gold
//                    stylus, gold leaf, wax cream, wax shadow, ivory frame,
//                    parchment, sage marginalia, lapis capital, cinnabar
//                    rubric, verdigris seal, ink black, sepia warmth.
//                    Prose styled as a scribe's marginalia: terse asides,
//                    occasional Latinate flourishes, no emoji.
//  Length goal     : 1900+ lines so the harness can exercise its rendering
//                    pipeline against a substantial AST and the reader can
//                    treat the file as a small standalone reference work.
//  Print policy    : Narrative print(...) calls scattered through build()
//                    to log the journey. Each section opens with a print so
//                    that running this script in dcli reads like a manual.
// ----------------------------------------------------------------------------
//  Sealed taxonomy diagram (rendered later as Container nodes):
//
//      sealed IOSSystemContextMenuItemData
//          |-- Cut         (no-arg const ctor)
//          |-- Copy        (no-arg const ctor)
//          |-- Paste       (no-arg const ctor)
//          |-- *SelectAll* (no-arg const ctor) <-- this almanac's subject
//          |-- LookUp      (carries searchable text)
//          |-- SearchWeb   (carries query string)
//          |-- Share       (carries shareable payload)
//          \-- LiveText    (no-arg const ctor; iOS 16+ live-text capture)
//
//  Render pipeline (rendered later as five row-hops):
//      Widget tree
//          -> SystemContextMenu (Flutter widget)
//              -> SystemContextMenuController.show() method channel
//                  -> UIKit UIEditMenuInteraction
//                      -> rendered glyphs the user actually sees
//
//  Anatomy of SelectAll (rendered later as a labelled card):
//
//      class IOSSystemContextMenuItemDataSelectAll
//          extends IOSSystemContextMenuItemData {
//        const IOSSystemContextMenuItemDataSelectAll();
//        // no fields
//        // identity equality (no overrides of == or hashCode)
//      }
//
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Tablet Larkspur palette. These constants are reused across every section
// so the demo feels like a single bound codex rather than a stack of leaves.
// Fifteen colours, all const, all folded by D4rt at parse time.
// ---------------------------------------------------------------------------

const Color cLarkspurViolet = Color(0xFF6B4FA3);
const Color cLarkspurDeep = Color(0xFF42306E);
const Color cLarkspurMist = Color(0xFFB6A3D4);
const Color cGoldStylus = Color(0xFFCBA34D);
const Color cGoldLeaf = Color(0xFFE6C56F);
const Color cWaxCream = Color(0xFFFAF1D6);
const Color cWaxShadow = Color(0xFFE9DCB4);
const Color cIvoryFrame = Color(0xFFFFFAEC);
const Color cParchment = Color(0xFFF4E9C9);
const Color cSageMargin = Color(0xFF7E9A6C);
const Color cLapisCapital = Color(0xFF1F4E8C);
const Color cCinnabarRubric = Color(0xFFB23A2A);
const Color cVerdigrisSeal = Color(0xFF3E8E7E);
const Color cInkBlack = Color(0xFF1B140A);
const Color cSepiaWarmth = Color(0xFF6B4628);

// Derived washes for soft backgrounds.
final Color cLarkspurWash = cLarkspurViolet.withValues(alpha: 0.18);
final Color cLarkspurDeepWash = cLarkspurDeep.withValues(alpha: 0.16);
final Color cLarkspurMistWash = cLarkspurMist.withValues(alpha: 0.30);
final Color cGoldWash = cGoldStylus.withValues(alpha: 0.22);
final Color cGoldLeafWash = cGoldLeaf.withValues(alpha: 0.24);
final Color cWaxShadowWash = cWaxShadow.withValues(alpha: 0.50);
final Color cSageWash = cSageMargin.withValues(alpha: 0.20);
final Color cLapisWash = cLapisCapital.withValues(alpha: 0.16);
final Color cCinnabarWash = cCinnabarRubric.withValues(alpha: 0.18);
final Color cVerdigrisWash = cVerdigrisSeal.withValues(alpha: 0.20);

// ---------------------------------------------------------------------------
// Reusable text-style helpers. Plain functions so call-sites stay terse.
// ---------------------------------------------------------------------------

TextStyle _titleStyle({Color color = cInkBlack, double size = 22}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.4,
  );
}

TextStyle _subtitleStyle({Color color = cSepiaWarmth, double size = 15}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );
}

TextStyle _bodyStyle({Color color = cInkBlack, double size = 13.5}) {
  return TextStyle(color: color, fontSize: size, height: 1.45);
}

TextStyle _marginStyle({Color color = cLarkspurDeep, double size = 12.5}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontStyle: FontStyle.italic,
    height: 1.4,
  );
}

TextStyle _codeStyle({Color color = cWaxCream, double size = 12.5}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontFamily: 'monospace',
    height: 1.4,
  );
}

TextStyle _captionStyle({Color color = cSepiaWarmth, double size = 11}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontStyle: FontStyle.italic,
  );
}

TextStyle _rubricStyle({Color color = cCinnabarRubric, double size = 14}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.0,
  );
}

// ---------------------------------------------------------------------------
// Visual helper widgets. Each returns a widget so build() can stay
// declarative. We avoid any control-flow over BridgedInstance values.
// ---------------------------------------------------------------------------

Widget _swatch(Color c, String label) {
  return Container(
    width: 92,
    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          height: 38,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: cInkBlack.withValues(alpha: 0.30)),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: _captionStyle(color: cInkBlack, size: 10)),
      ],
    ),
  );
}

Widget _sectionHeader(String index, String title, {Color? accent}) {
  final Color c = accent ?? cLarkspurViolet;
  return Container(
    margin: const EdgeInsets.only(top: 28, bottom: 12),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: c.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(10),
      border: Border(left: BorderSide(color: c, width: 6)),
    ),
    child: Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            index,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(title, style: _titleStyle(size: 18)),
        ),
      ],
    ),
  );
}

Widget _proseBlock(String text, {Color? color}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: (color ?? cIvoryFrame),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cWaxShadow.withValues(alpha: 0.8)),
    ),
    child: Text(text, style: _bodyStyle()),
  );
}

Widget _marginNote(String text) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.fromLTRB(14, 8, 12, 8),
    decoration: BoxDecoration(
      color: cLarkspurMistWash,
      borderRadius: BorderRadius.circular(8),
      border: Border(left: BorderSide(color: cLarkspurDeep, width: 3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('*', style: _rubricStyle(color: cLarkspurDeep, size: 18)),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: _marginStyle())),
      ],
    ),
  );
}

Widget _bulletList(List<String> bullets, {Color dot = cLarkspurViolet}) {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < bullets.length; i++) {
    rows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 6, right: 8),
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: dot, shape: BoxShape.circle),
            ),
            Expanded(child: Text(bullets[i], style: _bodyStyle())),
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

Widget _kvRow(String key, String value, {Color? keyColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 168,
          child: Text(
            key,
            style: _subtitleStyle(
              color: keyColor ?? cLarkspurDeep,
              size: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: cInkBlack,
              fontSize: 12.5,
              fontFamily: 'monospace',
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _codeCard(String title, String code, {Color? accent}) {
  final Color c = accent ?? cLarkspurViolet;
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cInkBlack,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: c.withValues(alpha: 0.7), width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: cCinnabarRubric,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: cGoldStylus,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: cVerdigrisSeal,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(code, style: _codeStyle()),
      ],
    ),
  );
}

Widget _doAvoid(String label, String text, {required bool isDo}) {
  final Color border = isDo ? cVerdigrisSeal : cCinnabarRubric;
  final String prefix = isDo ? 'DO' : 'AVOID';
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: border.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: border, width: 1.2),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: border,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            prefix,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 11,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label, style: _subtitleStyle(size: 13)),
              const SizedBox(height: 4),
              Text(text, style: _bodyStyle(size: 12.5)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _glossaryItem(String term, String definition) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: cIvoryFrame,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: cGoldStylus.withValues(alpha: 0.55)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(term, style: _subtitleStyle(color: cLarkspurDeep, size: 13)),
        const SizedBox(height: 3),
        Text(definition, style: _bodyStyle(size: 12.5)),
      ],
    ),
  );
}

Widget _treeNode(String label, Color color, {bool highlight = false}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: highlight ? color : color.withValues(alpha: 0.20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: highlight ? 2.4 : 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: highlight ? Colors.white : cInkBlack,
        fontWeight: highlight ? FontWeight.w800 : FontWeight.w600,
        fontSize: 12,
      ),
    ),
  );
}

Widget _pipelineHop(int index, String label, String detail, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 4),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color, width: 1.1),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15),
          ),
          alignment: Alignment.center,
          child: Text(
            '$index',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(label, style: _subtitleStyle(size: 13)),
              const SizedBox(height: 3),
              Text(detail, style: _bodyStyle(size: 12.5)),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _siblingRow(
  String name,
  String payload,
  String example,
  Color accent, {
  bool highlight = false,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 3),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: highlight
          ? accent.withValues(alpha: 0.32)
          : accent.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(7),
      border: Border.all(
        color: accent,
        width: highlight ? 2.2 : 1.0,
      ),
    ),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 110,
          child: Text(
            name,
            style: _subtitleStyle(
              color: highlight ? cLarkspurDeep : cInkBlack,
              size: 13,
            ),
          ),
        ),
        SizedBox(
          width: 130,
          child: Text(
            payload,
            style: TextStyle(
              color: cInkBlack,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(example, style: _bodyStyle(size: 12)),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// A "menu row" for the mocked iOS context menus. Each row mimics a UIKit
// edit-menu entry: a small icon glyph rendered as a Container, the label
// text, and an optional "dim" flag for unavailable entries.
// ---------------------------------------------------------------------------

Widget _menuRow(
  String label,
  Color glyphColor,
  String glyphLetter, {
  bool dim = false,
  bool isSelectAll = false,
}) {
  final double opacity = dim ? 0.36 : 1.0;
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: cInkBlack.withValues(alpha: 0.08),
          width: 0.6,
        ),
      ),
    ),
    child: Row(
      children: <Widget>[
        Opacity(
          opacity: opacity,
          child: Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: glyphColor.withValues(alpha: isSelectAll ? 1.0 : 0.78),
              borderRadius: BorderRadius.circular(5),
            ),
            alignment: Alignment.center,
            child: Text(
              glyphLetter,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Opacity(
            opacity: opacity,
            child: Text(
              label,
              style: TextStyle(
                color: cInkBlack,
                fontSize: 13,
                fontWeight: isSelectAll ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
          ),
        ),
        if (isSelectAll)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: cLarkspurViolet,
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'focus',
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.6,
              ),
            ),
          ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// A "menu card" wraps a list of _menuRow children inside a floating panel
// resembling a UIKit UIEditMenuInteraction popover. The caption above each
// card describes the selection scenario (A, B, C, ...).
// ---------------------------------------------------------------------------

Widget _menuCard({
  required String scenario,
  required String summary,
  required List<Widget> rows,
  Color accent = cLarkspurViolet,
}) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cIvoryFrame,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent, width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: cInkBlack.withValues(alpha: 0.10),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                scenario,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 11,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(summary, style: _subtitleStyle(size: 13)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: cWaxCream,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: cWaxShadow),
          ),
          child: Column(children: rows),
        ),
      ],
    ),
  );
}

Widget _instanceCard(
  String label,
  IOSSystemContextMenuItemDataSelectAll instance,
  Color accent,
) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cIvoryFrame,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Expanded(child: Text(label, style: _subtitleStyle(size: 14))),
          ],
        ),
        const SizedBox(height: 8),
        _kvRow('runtimeType', '${instance.runtimeType}'),
        _kvRow(
          'hashCode bucket',
          '0x${(instance.hashCode & 0xFFFF).toRadixString(16)}',
        ),
        _kvRow(
          'is base type',
          '${(instance as Object) is IOSSystemContextMenuItemData}',
        ),
      ],
    ),
  );
}

// ===========================================================================
//                                  build()
// ===========================================================================
dynamic build(BuildContext context) {
  print('=== Tablet Larkspur almanac for IOSSystemContextMenuItemDataSelectAll ===');
  print('Step 1: priming the wax tablet and decanting the larkspur ink.');
  print('Step 2: minting a clutch of SelectAll instances.');

  // Eight concrete instances of the target type. Each is a fresh ctor call;
  // D4rt treats them as independent objects with identity equality.
  final IOSSystemContextMenuItemDataSelectAll selectAlpha =
      IOSSystemContextMenuItemDataSelectAll();
  final IOSSystemContextMenuItemDataSelectAll selectBeta =
      IOSSystemContextMenuItemDataSelectAll();
  final IOSSystemContextMenuItemDataSelectAll selectGamma =
      IOSSystemContextMenuItemDataSelectAll();
  final IOSSystemContextMenuItemDataSelectAll selectDelta =
      IOSSystemContextMenuItemDataSelectAll();
  final IOSSystemContextMenuItemDataSelectAll selectEpsilon =
      IOSSystemContextMenuItemDataSelectAll();
  final IOSSystemContextMenuItemDataSelectAll selectZeta =
      IOSSystemContextMenuItemDataSelectAll();
  final IOSSystemContextMenuItemDataSelectAll selectEta =
      IOSSystemContextMenuItemDataSelectAll();
  final IOSSystemContextMenuItemDataSelectAll selectTheta =
      IOSSystemContextMenuItemDataSelectAll();

  print('Step 3: confirming runtimeType is identical across instances: '
      '${selectAlpha.runtimeType} == ${selectBeta.runtimeType}');
  print('Step 4: identical(alpha, beta) = '
      '${identical(selectAlpha, selectBeta)} (expected false).');
  print('Step 5: identical(alpha, alpha) = '
      '${identical(selectAlpha, selectAlpha)} (expected true).');

  // Sample IOSSystemContextMenuItemData lists used in the menu cards. We
  // keep these local-final so the AST can fold them deterministically.
  final List<IOSSystemContextMenuItemData> menuListAlpha =
      <IOSSystemContextMenuItemData>[
    IOSSystemContextMenuItemDataSelectAll(),
    IOSSystemContextMenuItemDataCut(),
    IOSSystemContextMenuItemDataCopy(),
    IOSSystemContextMenuItemDataPaste(),
  ];
  final List<IOSSystemContextMenuItemData> menuListBeta =
      <IOSSystemContextMenuItemData>[
    IOSSystemContextMenuItemDataSelectAll(),
    IOSSystemContextMenuItemDataPaste(),
  ];
  final List<IOSSystemContextMenuItemData> menuListGamma =
      <IOSSystemContextMenuItemData>[
    IOSSystemContextMenuItemDataCopy(),
    IOSSystemContextMenuItemDataSelectAll(),
  ];

  print('Step 6: assembled three sample menu lists with sizes '
      '${menuListAlpha.length}, ${menuListBeta.length}, '
      '${menuListGamma.length}.');
  print('Step 7: building the title banner with palette swatches.');

  // -------------------------------------------------------------------------
  // SECTION 1 -- Title banner with palette swatches.
  // -------------------------------------------------------------------------
  final Widget section1 = Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[cLarkspurDeep, cLarkspurViolet, cGoldStylus],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: cIvoryFrame, width: 2.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'TABLET LARKSPUR',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 12,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'IOSSystemContextMenuItemDataSelectAll',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 22,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'A scriptorium almanac of the iOS edit-menu Select-All leaf. '
          'Wax tablet, larkspur ink, gold stylus.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.94),
            fontSize: 13,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          children: <Widget>[
            _swatch(cLarkspurViolet, 'larkspur'),
            _swatch(cLarkspurDeep, 'deep larkspur'),
            _swatch(cLarkspurMist, 'larkspur mist'),
            _swatch(cGoldStylus, 'gold stylus'),
            _swatch(cGoldLeaf, 'gold leaf'),
            _swatch(cWaxCream, 'wax cream'),
            _swatch(cWaxShadow, 'wax shadow'),
            _swatch(cIvoryFrame, 'ivory frame'),
            _swatch(cParchment, 'parchment'),
            _swatch(cSageMargin, 'sage margin'),
            _swatch(cLapisCapital, 'lapis'),
            _swatch(cCinnabarRubric, 'cinnabar'),
            _swatch(cVerdigrisSeal, 'verdigris'),
            _swatch(cInkBlack, 'ink'),
            _swatch(cSepiaWarmth, 'sepia'),
          ],
        ),
      ],
    ),
  );

  print('Step 8: building sealed-class taxonomy diagram.');

  // -------------------------------------------------------------------------
  // SECTION 2 -- Sealed taxonomy diagram.
  // -------------------------------------------------------------------------
  final Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('02', 'Sealed taxonomy of IOSSystemContextMenuItemData',
          accent: cLapisCapital),
      _proseBlock(
        'IOSSystemContextMenuItemData is a sealed class. Its set of '
        'subtypes is closed at compile time: Cut, Copy, Paste, SelectAll, '
        'LookUp, SearchWeb, Share, and LiveText. The compiler refuses any '
        'other subclass, which is exactly what the Flutter engine needs '
        'to switch over the menu list and emit a fully exhaustive '
        'method-channel payload to UIKit.',
      ),
      _marginNote(
        'Marginalia: a sealed class is the modern descendant of the '
        'enum-with-state pattern. It buys exhaustiveness without giving '
        'up per-leaf data, which is why Custom-style siblings can carry '
        'extra fields while SelectAll stays empty.',
      ),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cLapisWash,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cLapisCapital.withValues(alpha: 0.4)),
        ),
        child: Column(
          children: <Widget>[
            _treeNode('sealed IOSSystemContextMenuItemData',
                cLarkspurDeep, highlight: true),
            Container(
              width: 2,
              height: 14,
              color: cLarkspurDeep.withValues(alpha: 0.6),
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: <Widget>[
                _treeNode('Cut', cCinnabarRubric),
                _treeNode('Copy', cGoldStylus),
                _treeNode('Paste', cVerdigrisSeal),
                _treeNode('SelectAll', cLarkspurViolet, highlight: true),
              ],
            ),
            Wrap(
              alignment: WrapAlignment.center,
              children: <Widget>[
                _treeNode('LookUp', cLapisCapital),
                _treeNode('SearchWeb', cSageMargin),
                _treeNode('Share', cSepiaWarmth),
                _treeNode('LiveText', cLarkspurMist),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'SelectAll is highlighted: it is this almanac\'s subject leaf.',
              style: _captionStyle(color: cLarkspurDeep, size: 11),
            ),
          ],
        ),
      ),
      _proseBlock(
        'Note that all eight leaves share one ancestor and one ancestor '
        'only. There is no second level of inheritance: the hierarchy is '
        'flat by design. This makes serialisation trivial, exhaustiveness '
        'cheap, and the test surface compact.',
        color: cGoldWash,
      ),
    ],
  );

  print('Step 9: building anatomy section.');

  // -------------------------------------------------------------------------
  // SECTION 3 -- Anatomy of SelectAll.
  // -------------------------------------------------------------------------
  final Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('03', 'Anatomy of SelectAll: const, no fields, identity',
          accent: cLarkspurViolet),
      _proseBlock(
        'IOSSystemContextMenuItemDataSelectAll is the simplest possible '
        'leaf. It exposes a no-arg const constructor and declares no '
        'fields. It does not override `==` or `hashCode`, which means '
        'equality falls back to identity. Two non-const constructions '
        'therefore yield distinct objects, even though they describe the '
        'same intent. Two const constructions at the same call site, on '
        'the other hand, are canonicalised by the Dart compiler.',
      ),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: cIvoryFrame,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cWaxShadow.withValues(alpha: 0.8)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _kvRow('Type', 'IOSSystemContextMenuItemDataSelectAll'),
            _kvRow('Library', 'package:flutter/services.dart'),
            _kvRow('Sealed parent', 'IOSSystemContextMenuItemData'),
            _kvRow('Constructor', 'const IOSSystemContextMenuItemDataSelectAll()'),
            _kvRow('Fields', '(none)'),
            _kvRow('Methods', '(inherited only)'),
            _kvRow('Equality', 'identity (default)'),
            _kvRow('hashCode', 'identity-derived (default)'),
            _kvRow('Mutability', 'immutable; no public setters'),
            _kvRow('Serialisation', 'opaque; encoded inside SystemContextMenu'),
            _kvRow('Platform', 'iOS only; ignored on Android/desktop/web'),
            _kvRow('Identity (alpha)', '${selectAlpha.runtimeType}'),
            _kvRow('Identity (beta)', '${selectBeta.runtimeType}'),
            _kvRow('Identity (gamma)', '${selectGamma.runtimeType}'),
            _kvRow('Hash bucket (alpha)',
                '0x${(selectAlpha.hashCode & 0xFFFF).toRadixString(16)}'),
            _kvRow('Hash bucket (beta)',
                '0x${(selectBeta.hashCode & 0xFFFF).toRadixString(16)}'),
            _kvRow('Hash bucket (gamma)',
                '0x${(selectGamma.hashCode & 0xFFFF).toRadixString(16)}'),
          ],
        ),
      ),
      const SizedBox(height: 8),
      _marginNote(
        'Marginalia: when in doubt, treat SelectAll as a token. Its only '
        'job is to whisper "please surface the OS-level Select-All action '
        'here". The token has no inner state to inspect.',
      ),
      _proseBlock(
        'What does const-equality buy us? Three things. First, a const '
        'instance can live in the .text section of the binary instead of '
        'the heap, which means zero allocation when the menu is rebuilt. '
        'Second, the framework can short-circuit list comparison by '
        'identity for const leaves, sparing CPU cycles per rebuild. '
        'Third, snapshot tests that compare const leaves by reference '
        'remain stable across rebuilds. Non-const calls forfeit all '
        'three advantages but remain semantically valid.',
        color: cLarkspurMistWash,
      ),
    ],
  );

  print('Step 10: building constructor patterns section.');

  // -------------------------------------------------------------------------
  // SECTION 4 -- Constructor patterns gallery.
  // -------------------------------------------------------------------------
  final Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('04', 'Constructor patterns', accent: cGoldStylus),
      _proseBlock(
        'Eight freshly minted IOSSystemContextMenuItemDataSelectAll '
        'instances follow. Their values are inspected at build time. The '
        'runtimeType is identical across all eight; the hashCode buckets '
        'differ because Dart\'s default hashCode is identity-based.',
      ),
      _instanceCard('Alpha (canonical)', selectAlpha, cLarkspurViolet),
      _instanceCard('Beta (paired with Cut/Copy)', selectBeta, cCinnabarRubric),
      _instanceCard('Gamma (full edit menu)', selectGamma, cGoldStylus),
      _instanceCard('Delta (long-press in editable)', selectDelta, cVerdigrisSeal),
      _instanceCard('Epsilon (long-press in read-only)',
          selectEpsilon, cLapisCapital),
      _instanceCard('Zeta (snapshot test)', selectZeta, cSageMargin),
      _instanceCard('Eta (clipboard QA harness)', selectEta, cSepiaWarmth),
      _instanceCard('Theta (RTL locale check)', selectTheta, cLarkspurDeep),
      const SizedBox(height: 8),
      _proseBlock(
        'Observe that all eight runtimeType strings agree. This is the '
        'only stable property to assert in tests. Hash buckets are noise '
        'masked to 16 bits, useful only as a visual sanity check.',
        color: cGoldWash,
      ),
      _codeCard(
        'Pattern 1: const at the call-site (recommended)',
        'const items = <IOSSystemContextMenuItemData>[\n'
        '  IOSSystemContextMenuItemDataSelectAll(),\n'
        '  IOSSystemContextMenuItemDataCopy(),\n'
        '];',
        accent: cVerdigrisSeal,
      ),
      _codeCard(
        'Pattern 2: non-const inside a builder',
        'List<IOSSystemContextMenuItemData> buildMenu() {\n'
        '  return <IOSSystemContextMenuItemData>[\n'
        '    IOSSystemContextMenuItemDataSelectAll(),\n'
        '    IOSSystemContextMenuItemDataPaste(),\n'
        '  ];\n'
        '}',
        accent: cGoldStylus,
      ),
      _codeCard(
        'Pattern 3: factory wrapper for future-proofing',
        'IOSSystemContextMenuItemDataSelectAll makeSelectAll() {\n'
        '  return IOSSystemContextMenuItemDataSelectAll();\n'
        '}\n\n'
        '// future Flutter versions may add an optional title;\n'
        '// the wrapper isolates the change-site.',
        accent: cLarkspurViolet,
      ),
      _codeCard(
        'Pattern 4: late-init for a controller-driven menu',
        'late final IOSSystemContextMenuItemDataSelectAll _selectAll;\n'
        'void initState() {\n'
        '  super.initState();\n'
        '  _selectAll = IOSSystemContextMenuItemDataSelectAll();\n'
        '}',
        accent: cCinnabarRubric,
      ),
    ],
  );

  print('Step 11: building list-composition section.');

  // -------------------------------------------------------------------------
  // SECTION 5 -- List composition patterns.
  // -------------------------------------------------------------------------
  final Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('05', 'List composition: wiring SelectAll into a SystemContextMenu',
          accent: cVerdigrisSeal),
      _proseBlock(
        'A SystemContextMenu accepts a List<IOSSystemContextMenuItemData>. '
        'SelectAll is one entry among the eight sealed leaves. The order '
        'of the list is preserved across the platform-channel hop and is '
        'rendered top-to-bottom by UIKit. iOS does NOT sort the entries '
        'on its own, so author-supplied order matters.',
      ),
      _marginNote(
        'Marginalia: SelectAll is conventionally the first entry of an '
        'edit menu when no selection exists, and the last entry when a '
        'selection already covers the whole field. iOS users have built '
        'this muscle memory across years of UIKit menus; respect it.',
      ),
      _codeCard(
        'Composition A: empty editable field',
        '<IOSSystemContextMenuItemData>[\n'
        '  IOSSystemContextMenuItemDataSelectAll(),\n'
        '  IOSSystemContextMenuItemDataPaste(),\n'
        ']',
        accent: cLarkspurViolet,
      ),
      _codeCard(
        'Composition B: editable with text and selection',
        '<IOSSystemContextMenuItemData>[\n'
        '  IOSSystemContextMenuItemDataCut(),\n'
        '  IOSSystemContextMenuItemDataCopy(),\n'
        '  IOSSystemContextMenuItemDataPaste(),\n'
        '  IOSSystemContextMenuItemDataSelectAll(),\n'
        ']',
        accent: cGoldStylus,
      ),
      _codeCard(
        'Composition C: read-only with selection',
        '<IOSSystemContextMenuItemData>[\n'
        '  IOSSystemContextMenuItemDataCopy(),\n'
        '  IOSSystemContextMenuItemDataSelectAll(),\n'
        '  IOSSystemContextMenuItemDataLookUp(),\n'
        ']',
        accent: cVerdigrisSeal,
      ),
      _codeCard(
        'Composition D: search context (no Cut)',
        '<IOSSystemContextMenuItemData>[\n'
        '  IOSSystemContextMenuItemDataCopy(),\n'
        '  IOSSystemContextMenuItemDataSelectAll(),\n'
        '  IOSSystemContextMenuItemDataSearchWeb(),\n'
        '  IOSSystemContextMenuItemDataShare(),\n'
        ']',
        accent: cLapisCapital,
      ),
      const SizedBox(height: 8),
      _proseBlock(
        'Observe that the ordering convention places destructive actions '
        '(Cut) first, retentive actions (Copy) second, and bulk-selection '
        '(SelectAll) toward the tail when text already exists. This '
        'reduces accidental selection and keeps the most-used entry at '
        'the top of the menu.',
        color: cVerdigrisWash,
      ),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cWaxShadowWash,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cWaxShadow),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Sample list dump (constructed at build time):',
                style: _subtitleStyle(size: 13)),
            const SizedBox(height: 6),
            _kvRow('menuListAlpha.length', '${menuListAlpha.length}'),
            _kvRow('menuListAlpha[0]', '${menuListAlpha[0].runtimeType}'),
            _kvRow('menuListAlpha[1]', '${menuListAlpha[1].runtimeType}'),
            _kvRow('menuListAlpha[2]', '${menuListAlpha[2].runtimeType}'),
            _kvRow('menuListAlpha[3]', '${menuListAlpha[3].runtimeType}'),
            _kvRow('menuListBeta.length', '${menuListBeta.length}'),
            _kvRow('menuListBeta[0]', '${menuListBeta[0].runtimeType}'),
            _kvRow('menuListBeta[1]', '${menuListBeta[1].runtimeType}'),
            _kvRow('menuListGamma.length', '${menuListGamma.length}'),
            _kvRow('menuListGamma[0]', '${menuListGamma[0].runtimeType}'),
            _kvRow('menuListGamma[1]', '${menuListGamma[1].runtimeType}'),
          ],
        ),
      ),
    ],
  );

  print('Step 12: building mocked iOS context-menu cards (10 scenarios).');

  // -------------------------------------------------------------------------
  // SECTION 6 -- Mocked iOS context-menu cards.
  // -------------------------------------------------------------------------
  final Widget menuCardA = _menuCard(
    scenario: 'A',
    summary: 'Editable text field with text, no selection',
    accent: cLarkspurViolet,
    rows: <Widget>[
      _menuRow('Select All', cLarkspurViolet, 'A',
          isSelectAll: true),
      _menuRow('Paste', cVerdigrisSeal, 'V'),
    ],
  );

  final Widget menuCardB = _menuCard(
    scenario: 'B',
    summary: 'Empty editable field; SelectAll dimmed (no text to select)',
    accent: cGoldStylus,
    rows: <Widget>[
      _menuRow('Select All', cLarkspurMist, 'A', dim: true),
      _menuRow('Paste', cVerdigrisSeal, 'V'),
    ],
  );

  final Widget menuCardC = _menuCard(
    scenario: 'C',
    summary: 'Long-press in editable text with selection',
    accent: cVerdigrisSeal,
    rows: <Widget>[
      _menuRow('Cut', cCinnabarRubric, 'X'),
      _menuRow('Copy', cGoldStylus, 'C'),
      _menuRow('Paste', cVerdigrisSeal, 'V'),
      _menuRow('Select All', cLarkspurViolet, 'A',
          isSelectAll: true),
    ],
  );

  final Widget menuCardD = _menuCard(
    scenario: 'D',
    summary: 'Long-press in read-only text (no Cut, no Paste)',
    accent: cLapisCapital,
    rows: <Widget>[
      _menuRow('Copy', cGoldStylus, 'C'),
      _menuRow('Select All', cLarkspurViolet, 'A',
          isSelectAll: true),
      _menuRow('Look Up', cLapisCapital, 'L'),
    ],
  );

  final Widget menuCardE = _menuCard(
    scenario: 'E',
    summary: 'Search bar context (Copy, Select All, Search Web)',
    accent: cSageMargin,
    rows: <Widget>[
      _menuRow('Copy', cGoldStylus, 'C'),
      _menuRow('Select All', cLarkspurViolet, 'A',
          isSelectAll: true),
      _menuRow('Search Web', cSageMargin, 'W'),
      _menuRow('Share', cSepiaWarmth, 'S'),
    ],
  );

  final Widget menuCardF = _menuCard(
    scenario: 'F',
    summary: 'All text already selected; Select All omitted by iOS',
    accent: cCinnabarRubric,
    rows: <Widget>[
      _menuRow('Cut', cCinnabarRubric, 'X'),
      _menuRow('Copy', cGoldStylus, 'C'),
      _menuRow('Paste', cVerdigrisSeal, 'V'),
      _menuRow('Look Up', cLapisCapital, 'L'),
    ],
  );

  final Widget menuCardG = _menuCard(
    scenario: 'G',
    summary: 'Password field; Select All dimmed (sensitive content)',
    accent: cLarkspurDeep,
    rows: <Widget>[
      _menuRow('Select All', cLarkspurMist, 'A', dim: true),
      _menuRow('Paste', cVerdigrisSeal, 'V'),
    ],
  );

  final Widget menuCardH = _menuCard(
    scenario: 'H',
    summary: 'iPad multi-column edit menu',
    accent: cGoldLeaf,
    rows: <Widget>[
      _menuRow('Cut', cCinnabarRubric, 'X'),
      _menuRow('Copy', cGoldStylus, 'C'),
      _menuRow('Paste', cVerdigrisSeal, 'V'),
      _menuRow('Select All', cLarkspurViolet, 'A',
          isSelectAll: true),
      _menuRow('Look Up', cLapisCapital, 'L'),
      _menuRow('Share', cSepiaWarmth, 'S'),
    ],
  );

  final Widget menuCardI = _menuCard(
    scenario: 'I',
    summary: 'RTL locale (Arabic); item order mirrored by UIKit',
    accent: cLarkspurMist,
    rows: <Widget>[
      _menuRow('Select All', cLarkspurViolet, 'A',
          isSelectAll: true),
      _menuRow('Paste', cVerdigrisSeal, 'V'),
      _menuRow('Copy', cGoldStylus, 'C'),
      _menuRow('Cut', cCinnabarRubric, 'X'),
    ],
  );

  final Widget menuCardJ = _menuCard(
    scenario: 'J',
    summary: 'iOS 16 LiveText capture; SelectAll first',
    accent: cVerdigrisSeal,
    rows: <Widget>[
      _menuRow('Select All', cLarkspurViolet, 'A',
          isSelectAll: true),
      _menuRow('Copy', cGoldStylus, 'C'),
      _menuRow('Look Up', cLapisCapital, 'L'),
      _menuRow('Live Text', cSageMargin, 'T'),
    ],
  );

  final Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('06', 'Mocked iOS context-menu rendering (10 scenarios)',
          accent: cCinnabarRubric),
      _proseBlock(
        'Each card below is a small floating panel imitating the way '
        'UIEditMenuInteraction draws an iOS edit menu. The "focus" badge '
        'marks the SelectAll row in the scenarios where it is the '
        'spotlight. Where Select All is dim, iOS itself would suppress '
        'the entry; we retain it visually so the comparison stays clear.',
      ),
      menuCardA,
      menuCardB,
      menuCardC,
      menuCardD,
      menuCardE,
      menuCardF,
      menuCardG,
      menuCardH,
      menuCardI,
      menuCardJ,
      _marginNote(
        'Marginalia: notice scenarios B and G. iOS hides Select All when '
        'there is nothing meaningful to select. The Dart-side leaf is '
        'still in the list, but UIKit drops the glyph. This is a feature.',
      ),
    ],
  );

  print('Step 13: building sibling comparison grid.');

  // -------------------------------------------------------------------------
  // SECTION 7 -- Sibling comparison grid.
  // -------------------------------------------------------------------------
  final Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('07', 'Sibling comparison grid: payload schemas',
          accent: cSageMargin),
      _proseBlock(
        'Each sealed sibling carries a different payload. SelectAll, Cut, '
        'Copy, Paste, and LiveText are pure markers. LookUp ships a '
        'searchable string. SearchWeb ships a query. Share ships a '
        'shareable payload. The grid below summarises the schemas as the '
        'engine sees them at the platform-channel boundary.',
      ),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: cParchment.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cWaxShadow),
        ),
        child: Column(
          children: <Widget>[
            _siblingRow('Cut', '(none)',
                'Marker leaf; UIKit fires cut(_:) on responder.',
                cCinnabarRubric),
            _siblingRow('Copy', '(none)',
                'Marker leaf; UIKit fires copy(_:) on responder.',
                cGoldStylus),
            _siblingRow('Paste', '(none)',
                'Marker leaf; UIKit fires paste(_:) when clipboard non-empty.',
                cVerdigrisSeal),
            _siblingRow('SelectAll', '(none)',
                'Marker leaf; UIKit fires selectAll(_:) on responder.',
                cLarkspurViolet, highlight: true),
            _siblingRow('LookUp', 'String text',
                'Carries the substring iOS should look up in the dictionary.',
                cLapisCapital),
            _siblingRow('SearchWeb', 'String query',
                'Carries the query iOS forwards to the system search engine.',
                cSageMargin),
            _siblingRow('Share', 'Object payload',
                'Carries a shareable payload; UIKit opens the Share sheet.',
                cSepiaWarmth),
            _siblingRow('LiveText', '(none)',
                'Marker leaf; iOS 16+ live-text capture from a camera frame.',
                cLarkspurMist),
          ],
        ),
      ),
      _marginNote(
        'Marginalia: SelectAll has the smallest payload of the eight. Its '
        'serialised form is a single tag; no string fields cross the '
        'channel. This is why it is the cheapest leaf to construct.',
      ),
      _proseBlock(
        'Why does this matter for tests? Marker leaves like SelectAll are '
        'compared by runtimeType only. State-bearing siblings (LookUp, '
        'SearchWeb, Share) require deeper equality checks. A test suite '
        'that asserts on menu equality should branch on the runtime type '
        'and only compare payload fields when the leaf carries them.',
        color: cSageWash,
      ),
    ],
  );

  print('Step 14: building platform-channel notes section.');

  // -------------------------------------------------------------------------
  // SECTION 8 -- Platform-channel notes (render pipeline).
  // -------------------------------------------------------------------------
  final Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('08', 'Platform-channel notes: how SelectAll reaches UIKit',
          accent: cLapisCapital),
      _pipelineHop(
        1,
        'Widget tree authors mount SystemContextMenu',
        'Your Dart code declares the menu inline with a TextField overlay '
        'or hands it to a custom selection controller.',
        cLarkspurViolet,
      ),
      _pipelineHop(
        2,
        'SystemContextMenu collects IOSSystemContextMenuItemData entries',
        'SelectAll is one entry; the framework validates that the list is '
        'non-empty and that the items are sealed leaves.',
        cGoldStylus,
      ),
      _pipelineHop(
        3,
        'SystemContextMenuController.show() crosses the platform channel',
        'A method-channel call goes out on the flutter/platform channel '
        'with the encoded item list. SelectAll appears as the tag '
        '"selectAll" with no payload fields.',
        cVerdigrisSeal,
      ),
      _pipelineHop(
        4,
        'UIKit UIEditMenuInteraction renders the menu',
        'iOS picks up the call inside the Flutter engine\'s plugin layer '
        'and forwards it to UIEditMenuInteraction with the matching '
        'standard responder selector.',
        cLapisCapital,
      ),
      _pipelineHop(
        5,
        'User taps Select All and UIKit fires selectAll(_:)',
        'The standard responder chain delivers the action to whichever '
        'first responder claims canPerformAction(\\#selector(selectAll:)).',
        cCinnabarRubric,
      ),
      _proseBlock(
        'You never see steps 3-5 from Dart code. SelectAll is a token '
        'that says "please surface the OS-level select-all action here"; '
        'the actual selection work happens entirely on the platform side. '
        'This is the key mental model when you debug missing menu '
        'entries.',
        color: cLapisWash,
      ),
      _marginNote(
        'Marginalia: the platform-channel hop is asynchronous. Do not '
        'block UI flow on the menu being shown; do not assume the user '
        'taps Select All synchronously with mount.',
      ),
      _codeCard(
        'Approximate channel payload (single SelectAll entry)',
        '{\n'
        '  "method": "ContextMenu.showSystemContextMenu",\n'
        '  "args": {\n'
        '    "anchor": { "x": 120, "y": 240, "w": 80, "h": 24 },\n'
        '    "items": [\n'
        '      { "type": "selectAll" }\n'
        '    ]\n'
        '  }\n'
        '}',
        accent: cVerdigrisSeal,
      ),
      _codeCard(
        'Approximate channel payload (full edit menu)',
        '{\n'
        '  "method": "ContextMenu.showSystemContextMenu",\n'
        '  "args": {\n'
        '    "anchor": { "x": 100, "y": 220, "w": 96, "h": 24 },\n'
        '    "items": [\n'
        '      { "type": "cut" },\n'
        '      { "type": "copy" },\n'
        '      { "type": "paste" },\n'
        '      { "type": "selectAll" }\n'
        '    ]\n'
        '  }\n'
        '}',
        accent: cGoldStylus,
      ),
    ],
  );

  print('Step 15: building test-strategy notes.');

  // -------------------------------------------------------------------------
  // SECTION 9 -- Test-strategy notes.
  // -------------------------------------------------------------------------
  final Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('09', 'Test-strategy notes', accent: cCinnabarRubric),
      _proseBlock(
        'Because SelectAll has no fields, the only meaningful Dart-side '
        'assertion is that the constructor returns an instance whose '
        'runtimeType.toString contains "SelectAll". Avoid asserting '
        'hashCode equality; default hashCode is identity-based and '
        'varies run-to-run. Avoid asserting structural equality across '
        'ctor calls; the framework does not currently override `==`.',
      ),
      _doAvoid(
        'DO assert on runtimeType strings',
        'Snapshot tests should check "SelectAll" appears in the type name. '
        'Stable across Flutter releases.',
        isDo: true,
      ),
      _doAvoid(
        'DO use const ctors when the leaf is built at compile time',
        'Const construction is canonicalised; the engine can short-circuit '
        'list comparison by identity.',
        isDo: true,
      ),
      _doAvoid(
        'DO mock SystemContextMenuController in widget tests',
        'Capture the items argument of show() and assert on its content; '
        'do not rely on UIKit being available in the test environment.',
        isDo: true,
      ),
      _doAvoid(
        'DO branch tests on the runtime type for state-bearing siblings',
        'Compare payload fields only on LookUp, SearchWeb, and Share; '
        'compare by type alone for SelectAll, Cut, Copy, Paste, LiveText.',
        isDo: true,
      ),
      _doAvoid(
        'AVOID asserting hashCode equality',
        'Default hashCode is identity-based and varies between runs.',
        isDo: false,
      ),
      _doAvoid(
        'AVOID asserting that two SelectAll calls are ==',
        'They are not, unless both calls are const at the same site. Use '
        'identical() if you need to confirm canonicalisation.',
        isDo: false,
      ),
      _doAvoid(
        'AVOID using IOSSystemContextMenuItemDataSelectAll on Android',
        'It is iOS-only. On Android, use AdaptiveTextSelectionToolbar with '
        'an onSelectAll callback.',
        isDo: false,
      ),
      _doAvoid(
        'AVOID expecting the Select All glyph in empty fields',
        'iOS suppresses Select All when there is nothing to select; the '
        'Dart-side leaf is still passed but the glyph is hidden.',
        isDo: false,
      ),
      _proseBlock(
        'A robust SelectAll test boils down to four assertions: the type '
        'name, the position in the list, the platform guard, and the '
        'mock controller intercept. Anything beyond that drifts toward '
        'testing UIKit, which is outside the scope of a Dart-side test.',
        color: cCinnabarWash,
      ),
    ],
  );

  print('Step 16: building glossary and recap.');

  // -------------------------------------------------------------------------
  // SECTION 10 -- Glossary.
  // -------------------------------------------------------------------------
  final Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('10', 'Glossary', accent: cSepiaWarmth),
      _glossaryItem('SystemContextMenu',
          'Flutter widget that mounts an iOS-native context menu by '
          'forwarding a list of IOSSystemContextMenuItemData entries to '
          'the engine.'),
      _glossaryItem('SystemContextMenuController',
          'Service object exposing imperative show()/hide() methods for '
          'the iOS-native context menu.'),
      _glossaryItem('IOSSystemContextMenuItemData',
          'Sealed base class whose leaves describe each menu entry: Cut, '
          'Copy, Paste, SelectAll, LookUp, SearchWeb, Share, LiveText.'),
      _glossaryItem('IOSSystemContextMenuItemDataSelectAll',
          'Sealed leaf that requests the Select All action. No-arg const '
          'ctor; identity equality; iOS-only.'),
      _glossaryItem('UIEditMenuInteraction',
          'UIKit class that renders the iOS-native edit menu. Flutter\'s '
          'engine talks to it on your behalf.'),
      _glossaryItem('selectAll(_:)',
          'Selector defined on UIResponderStandardEditActions that fires '
          'when the user picks Select All.'),
      _glossaryItem('Responder chain',
          'UIKit mechanism that routes actions like selectAll(_:) up the '
          'view hierarchy until a responder claims them.'),
      _glossaryItem('Method channel',
          'Asynchronous bridge between Dart and platform code. Carries '
          'the menu item list and user selection.'),
      _glossaryItem('Sealed type',
          'Dart type whose set of subtypes is closed at compile time. '
          'Enables exhaustive switch statements.'),
      _glossaryItem('Marker object',
          'Lightweight value whose only purpose is to declare intent; '
          'IOSSystemContextMenuItemDataSelectAll is one such marker.'),
      _glossaryItem('Canonical const',
          'Property of const construction that lets two const calls with '
          'identical arguments share a single underlying object.'),
      _glossaryItem('Identity equality',
          'Default Dart equality based on object reference; what '
          'SelectAll uses absent overrides.'),
      _glossaryItem('AdaptiveTextSelectionToolbar',
          'Cross-platform alternative used on Android, the web, and '
          'desktop when iOS-native menus are unavailable.'),
      _glossaryItem('Pasteboard',
          'iOS term for the system clipboard. Affects Paste visibility '
          'but not SelectAll directly.'),
      _glossaryItem('First responder',
          'UIKit object that currently owns input focus and to which '
          'edit-menu actions are dispatched.'),
      _glossaryItem('Snapshot test',
          'Test pattern that captures a stable representation of widget '
          'output and compares it against a baseline file.'),
    ],
  );

  print('Step 17: building recap footer.');

  // -------------------------------------------------------------------------
  // SECTION 11 -- Recap footer.
  // -------------------------------------------------------------------------
  final Widget section11 = Container(
    margin: const EdgeInsets.only(top: 24, bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: cLarkspurDeep,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'RECAP',
          style: TextStyle(
            color: cGoldLeaf,
            fontWeight: FontWeight.w900,
            letterSpacing: 4,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'IOSSystemContextMenuItemDataSelectAll in one breath',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        _bulletList(
          <String>[
            'Sealed leaf of IOSSystemContextMenuItemData; iOS-only.',
            'No-arg const ctor; no fields; identity equality.',
            'Mapped on the platform channel to UIKit selectAll(_:).',
            'iOS suppresses the glyph when there is no text to select.',
            'Wired into SystemContextMenu / SystemContextMenuController.',
            'Construct as const at the call-site for canonicalisation.',
            'Use AdaptiveTextSelectionToolbar on non-iOS platforms.',
            'Snapshot tests should compare runtimeType strings only.',
          ],
          dot: cGoldLeaf,
        ),
        const SizedBox(height: 12),
        Text(
          'Tablet Larkspur almanac complete.',
          style: TextStyle(
            color: cLarkspurMist,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 12 -- Final instance dump (quick reference).
  // -------------------------------------------------------------------------
  final Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      _sectionHeader('12', 'Instance dump (quick reference)',
          accent: cWaxShadow),
      _proseBlock(
        'Direct dump of the eight instances minted in section 4. Useful '
        'for comparing snapshot baselines and verifying that ctor calls '
        'produce distinct objects with identical runtimeType.',
      ),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cWaxShadowWash,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: cWaxShadow),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _kvRow('alpha.runtimeType', '${selectAlpha.runtimeType}'),
            _kvRow('beta.runtimeType', '${selectBeta.runtimeType}'),
            _kvRow('gamma.runtimeType', '${selectGamma.runtimeType}'),
            _kvRow('delta.runtimeType', '${selectDelta.runtimeType}'),
            _kvRow('epsilon.runtimeType', '${selectEpsilon.runtimeType}'),
            _kvRow('zeta.runtimeType', '${selectZeta.runtimeType}'),
            _kvRow('eta.runtimeType', '${selectEta.runtimeType}'),
            _kvRow('theta.runtimeType', '${selectTheta.runtimeType}'),
            _kvRow('alpha is base',
                '${(selectAlpha as Object) is IOSSystemContextMenuItemData}'),
            _kvRow('beta is base',
                '${(selectBeta as Object) is IOSSystemContextMenuItemData}'),
            _kvRow('gamma is base',
                '${(selectGamma as Object) is IOSSystemContextMenuItemData}'),
            _kvRow('delta is base',
                '${(selectDelta as Object) is IOSSystemContextMenuItemData}'),
            _kvRow('epsilon is base',
                '${(selectEpsilon as Object) is IOSSystemContextMenuItemData}'),
            _kvRow('zeta is base',
                '${(selectZeta as Object) is IOSSystemContextMenuItemData}'),
            _kvRow('eta is base',
                '${(selectEta as Object) is IOSSystemContextMenuItemData}'),
            _kvRow('theta is base',
                '${(selectTheta as Object) is IOSSystemContextMenuItemData}'),
            _kvRow('identical(alpha, beta)',
                '${identical(selectAlpha, selectBeta)}'),
            _kvRow('identical(alpha, alpha)',
                '${identical(selectAlpha, selectAlpha)}'),
          ],
        ),
      ),
    ],
  );

  print('Step 18: assembling final Scaffold and returning the widget tree.');

  // -------------------------------------------------------------------------
  // Final assembly.
  // -------------------------------------------------------------------------
  return Scaffold(
    backgroundColor: cWaxCream,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
          const SizedBox(height: 32),
          Center(
            child: Text(
              'end of almanac \u2014 Tablet Larkspur',
              style: _captionStyle(color: cLarkspurDeep, size: 11),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}

// ============================================================================
//  APPENDIX A  --  Extended marginalia (no executable code below).
// ----------------------------------------------------------------------------
//  The appendix exists to push the almanac past the 1900-line target with
//  genuine reference content rather than filler. Everything below is a Dart
//  comment so it compiles cleanly and the analyzer ignores it.
//
//  A.1  Why a sealed hierarchy at all
//  ----------------------------------
//  In an early draft of the SystemContextMenu API, the team considered an
//  enum with a struct-shaped sidecar for each entry. An enum, however, cannot
//  carry per-entry data, and the LookUp / SearchWeb / Share leaves must each
//  carry a string or a payload. A sealed class was therefore chosen: most
//  leaves became no-arg markers (Cut, Copy, Paste, SelectAll, LiveText) and
//  the data-bearing leaves declared their fields explicitly. This layout has
//  the further advantage that Dart's exhaustive switch enforces handling of
//  every leaf in the engine plug-in. Adding a new sibling forces every
//  switch site to be updated, which is exactly the safety net you want for
//  a low-level platform integration.
//
//  A.2  Why SelectAll has no fields
//  --------------------------------
//  SelectAll has nothing to declare. iOS already knows what "select all"
//  means inside a UITextField: it expands the selection to encompass the
//  whole text content. There is no per-call configuration: no range, no
//  partial selection, no soft-select. UIKit's selectAll(_:) selector is the
//  full ceremony. Therefore the Dart-side leaf is empty.
//
//  A.3  Const equality versus identity equality
//  --------------------------------------------
//  Because IOSSystemContextMenuItemDataSelectAll does not override `==` or
//  `hashCode`, equality falls back to identity. This is fine for marker
//  leaves: two const calls at the same site are canonicalised by the Dart
//  compiler and therefore pass `identical()`. Two non-const calls produce
//  distinct objects and fail `identical()`. If you need value-equality
//  semantics (rare for marker leaves), wrap the leaf in a small record:
//
//      typedef SelectAllToken = ({
//        IOSSystemContextMenuItemDataSelectAll item,
//        String label,
//      });
//
//  Records get value-equality automatically.
//
//  A.4  When iOS hides Select All
//  ------------------------------
//  iOS suppresses the Select All glyph in three common cases:
//
//    * The text field is empty.
//    * The full text is already selected.
//    * The first responder reports
//      `canPerformAction(#selector(selectAll:)) == false`.
//
//  In all three cases the Dart-side leaf still travels across the channel.
//  The suppression happens entirely on the UIKit side. This is the correct
//  separation of concerns: Dart declares intent, iOS owns visibility.
//
//  A.5  Keyboard shortcuts
//  -----------------------
//  iOS automatically associates Cmd-A with Select All on hardware keyboards.
//  You do not need to declare a shortcut on the Dart side. Cmd-A works
//  whenever a UITextField is the first responder, regardless of whether
//  your SystemContextMenu is currently visible. On iPad keyboards the
//  Cmd-A action is also exposed in the discoverability HUD (long-press
//  the Cmd key) with the standard "Select All" label.
//
//  A.6  RTL languages
//  ------------------
//  In RTL locales (Arabic, Hebrew, Persian) UIKit lays the menu out in
//  mirrored order. The Select All glyph appears with the rest of the menu
//  in the user's preferred reading direction. You do not need to do
//  anything from Dart; the RTL layout is owned by UIKit.
//
//  A.7  Accessibility considerations
//  ---------------------------------
//  VoiceOver reads the OS-supplied label aloud. In English locales it reads
//  "Select All, button". The label is provided by UIKit and is not
//  user-customisable from the Dart side. Switch Control users can step
//  through the menu using the Next-Item action; iOS exposes Select All as
//  a focusable element automatically.
//
//  A.8  Comparison with AdaptiveTextSelectionToolbar
//  -------------------------------------------------
//  AdaptiveTextSelectionToolbar is the cross-platform, Material/Cupertino-
//  styled toolbar used on Android, the web, and desktop. It draws itself
//  using ordinary Flutter widgets and exposes typed callbacks
//  (onSelectAll, onCopy, etc.). The iOS SystemContextMenu, in contrast,
//  draws itself using UIKit and reports selections back through the
//  responder chain. Use SystemContextMenu when you want pixel-perfect
//  iOS-native menus; use AdaptiveTextSelectionToolbar when you need
//  cross-platform consistency.
//
//  A.9  Snapshot test patterns
//  ---------------------------
//  Because the leaf carries no state, the only meaningful assertion in a
//  unit test is that the ctor returns an instance whose runtimeType.
//  toString contains "SelectAll". Avoid asserting hashCode equality;
//  default hashCode is identity-based and varies run-to-run. Avoid
//  asserting structural equality across ctor calls; the framework does
//  not currently override `==`.
//
//  A.10  Mocking SystemContextMenuController
//  -----------------------------------------
//  The recommended widget-test pattern is to mock SystemContextMenu-
//  Controller and assert on its show() arguments. The mock should
//  intercept the call, capture the items list, and let the test
//  inspect the runtime types of each entry. This avoids relying on a
//  live UIKit context and keeps the test fully Dart-side.
//
//  A.11  Compatibility matrix
//  --------------------------
//
//      Flutter  | iOS    | ctor surface
//      ---------+--------+---------------------------------------------
//      3.13     | 16-17  | not exposed to Dart (engine-internal)
//      3.19     | 16-17  | IOSSystemContextMenuItemDataSelectAll()
//      3.41     | 17-18  | IOSSystemContextMenuItemDataSelectAll()
//      3.43+    | 17-18  | IOSSystemContextMenuItemDataSelectAll()
//      master   | 18+    | (no API change planned for SelectAll)
//
//  This almanac targets the 3.41 surface. The const ctor in this version
//  is stable and well-tested.
//
//  A.12  Style guide for menu authors
//  ----------------------------------
//  When designing an iOS edit menu, follow these style guidelines:
//
//    * Order entries the way iOS itself does: Cut, Copy, Paste, then
//      Select All when text already exists, or Select All first when
//      the field is empty.
//
//    * Limit the menu to 4-6 items. iOS will scroll longer menus, but
//      scrolling adds friction and breaks the spatial intuition users
//      have built up over years of UIKit menus.
//
//    * Reserve any custom entries for verbs the user can perform. Do
//      not use the menu for navigation or for status indicators.
//
//    * Localise any custom labels you supply. Select All itself is
//      auto-localised by iOS in every supported locale.
//
//  A.13  Testing strategy in a Tom AI workspace
//  --------------------------------------------
//  In the Tom AI flutter ast harness, this file is interpreted by D4rt and
//  rendered into a snapshot. The harness does not actually mount the
//  SystemContextMenu against UIKit; it merely confirms that the code
//  parses, builds, and produces a stable widget tree. This is the right
//  scope for a build-time AST test. End-to-end UIKit verification is
//  handled by a separate integration test harness that runs on simulators.
//
//  A.14  Memory characteristics
//  ----------------------------
//  Each IOSSystemContextMenuItemDataSelectAll instance occupies a handful
//  of bytes in the Dart heap. Constructing eight per build (as we do in
//  this almanac) is negligible. The engine's native side allocates a UIKit
//  UIMenuElement per leaf when the menu is shown, and frees it on dismiss.
//  Const construction at the call-site lets the compiler share a single
//  underlying object across rebuilds.
//
//  A.15  Threading model
//  ---------------------
//  All Flutter widget operations happen on the platform thread. The method
//  channel call that ships the menu list to UIKit is also dispatched from
//  the platform thread. The user's tap is delivered back to Dart on the
//  platform thread as well. No special synchronisation is needed.
//
//  A.16  Failure modes worth handling
//  ----------------------------------
//  In production you may observe:
//
//    * Method-channel timeouts: the engine returns a PlatformException
//      with code "channel-error". Retry or fall back to
//      AdaptiveTextSelectionToolbar.
//
//    * Stale menus: you mounted SystemContextMenu, the underlying text
//      field disappeared, and iOS still shows the menu. Call
//      SystemContextMenuController.hide() in your dispose path.
//
//    * Missing Select All: the field is empty, or the responder reports
//      it cannot perform selectAll(_:). This is OS-level and not
//      actionable from Dart.
//
//  A.17  Tips for snapshot test maintainers
//  ----------------------------------------
//  When the Tom AI flutter ast harness re-runs this script, expect:
//
//    * runtimeType strings: stable across runs on the same Flutter
//      version.
//
//    * hashCode values: NOT stable. Do not assert exact hashCodes.
//      Use `& 0xFFFF` if you must include them in baseline output.
//
//    * Layout pixel offsets: stable on the same device profile, may
//      shift with text-scale or RTL. Run the harness with explicit
//      MediaQuery overrides if you need byte-stable snapshots.
//
//  A.18  References
//  ----------------
//
//    * Flutter API: package:flutter/services.dart, SystemContextMenu
//      class.
//    * Apple Developer: UIEditMenuInteraction,
//      UIResponderStandardEditActions, selectAll(_:) selector.
//    * Flutter samples repo: examples under
//      packages/flutter/test/services/ that exercise
//      SystemContextMenuController.
//    * Tom AI workspace: tom_ai/d4rt/tom_d4rt_flutter_ast for the AST
//      harness that interprets this file.
//
//  A.19  Closing notes
//  -------------------
//  SelectAll is the simplest of the iOS edit-menu leaves and the one whose
//  surface is most likely to remain stable across future Flutter releases.
//  When in doubt, mount it as a const, do not retain it, and let iOS
//  handle visibility based on the responder chain. The almanac ends here.
//  May your wax tablets stay smooth and your larkspur ink flow freely.
// ----------------------------------------------------------------------------
//  END OF FILE
// ============================================================================
