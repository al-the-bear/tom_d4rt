// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unnecessary_type_check
// ============================================================================
//  TABLET MARIGOLD  --  An Illustrated Almanac of
//                       IOSSystemContextMenuItemDataPaste
// ----------------------------------------------------------------------------
//  Theme           : Tablet Marigold (sun-warmed petals over slate panels).
//  Subject         : `IOSSystemContextMenuItemDataPaste` from
//                    `package:flutter/services.dart`. A leaf of the sealed
//                    `IOSSystemContextMenuItemData` hierarchy that represents
//                    the iOS edit-menu "Paste" entry inside a
//                    `SystemContextMenu` widget.
//  Surface         : In Flutter 3.41 the constructor is a no-arg const ctor:
//                    `IOSSystemContextMenuItemDataPaste()`.  Newer Flutter
//                    versions have introduced an optional `title` override
//                    so one can supply a localised label.  This almanac
//                    targets the no-arg surface, since that is what the
//                    surrounding workspace stub demonstrates.
//  Audience        : Flutter engineers wiring iOS-native edit menus, QA
//                    engineers writing snapshot tests, and curious readers
//                    of the Tom AI D4rt flutter ast smoke harness.
//  D4rt notes      : `build()` is invoked exactly once.  The returned widget
//                    tree is a static snapshot.  No StatefulWidget, no
//                    setState, no controllers, no timers, no streams.  We do
//                    NOT iterate BridgedInstance values with for-in, and we
//                    do NOT touch `.value` on Tween.animate.  Alpha colours
//                    use `.withValues(alpha: ...)`.
//  Style           : Marigold gold, ember orange, slate steel, cream paper,
//                    plus accents (chartreuse, peony, lagoon, ash, mocha,
//                    nightshade).  Ten palette colours below.
//  Length goal     : 1500+ lines so the harness can exercise its rendering
//                    pipeline against a substantial AST.
//  Print policy    : 5-15 narrative print(...) calls scattered through
//                    build() to log the journey.
// ----------------------------------------------------------------------------
//  Diagram (rendered later as Container nodes):
//
//      sealed IOSSystemContextMenuItemData
//          |-- Cut
//          |-- Copy
//          |-- *Paste*           <-- this almanac's subject
//          |-- SelectAll
//          |-- LookUp
//          |-- Translate
//          |-- ShareLink
//          \-- Custom (user supplied label + handler)
//
//  Render pipeline (rendered later as five row-hops):
//      Widget tree
//          -> SystemContextMenu (Flutter widget)
//              -> SystemContextMenuController.show() method channel
//                  -> UIKit UIEditMenuInteraction
//                      -> rendered glyphs the user actually sees
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ---------------------------------------------------------------------------
// Tablet Marigold palette.  Ten distinct colours that we re-use throughout
// the almanac.  Stored as `const` so the constants can be folded by D4rt.
// ---------------------------------------------------------------------------
const Color kMarigoldGold = Color(0xFFF5B642);
const Color kEmberOrange = Color(0xFFE2773C);
const Color kSlateSteel = Color(0xFF394150);
const Color kCreamPaper = Color(0xFFFFF7E6);
const Color kChartreuseLeaf = Color(0xFFB7C957);
const Color kPeonyBlush = Color(0xFFE8A0BF);
const Color kLagoonTeal = Color(0xFF2EA1A6);
const Color kAshSmoke = Color(0xFFB0AFAA);
const Color kMochaBean = Color(0xFF6B4F3A);
const Color kNightshadePlum = Color(0xFF4A2D5F);

// A few derived shades used for soft backgrounds.
final Color kMarigoldWash = kMarigoldGold.withValues(alpha: 0.18);
final Color kEmberWash = kEmberOrange.withValues(alpha: 0.20);
final Color kSlateWash = kSlateSteel.withValues(alpha: 0.10);
final Color kPeonyWash = kPeonyBlush.withValues(alpha: 0.22);
final Color kLagoonWash = kLagoonTeal.withValues(alpha: 0.18);
final Color kPlumWash = kNightshadePlum.withValues(alpha: 0.16);
final Color kAshWash = kAshSmoke.withValues(alpha: 0.30);

// ---------------------------------------------------------------------------
// Reusable text style helpers.  These are plain functions so the call sites
// can stay short and consistent.
// ---------------------------------------------------------------------------
TextStyle _titleStyle({Color color = kSlateSteel, double size = 22}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.4,
  );
}

TextStyle _subtitleStyle({Color color = kMochaBean, double size = 16}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.2,
  );
}

TextStyle _bodyStyle({Color color = kSlateSteel, double size = 13.5}) {
  return TextStyle(color: color, fontSize: size, height: 1.45);
}

TextStyle _codeStyle({Color color = kSlateSteel, double size = 12.5}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontFamily: 'monospace',
    height: 1.4,
  );
}

TextStyle _captionStyle({Color color = kAshSmoke, double size = 11}) {
  return TextStyle(
    color: color,
    fontSize: size,
    fontStyle: FontStyle.italic,
  );
}

// ---------------------------------------------------------------------------
// Small visual helpers.  Each returns a widget so we can mix them inside the
// twelve-section scroll body without branching.
// ---------------------------------------------------------------------------
Widget _swatch(Color c, String label) {
  return Container(
    width: 88,
    margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 36,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: kSlateSteel.withValues(alpha: 0.25)),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: _captionStyle(color: kSlateSteel, size: 10)),
      ],
    ),
  );
}

Widget _sectionHeader(String index, String title, {Color? accent}) {
  final Color c = accent ?? kEmberOrange;
  return Container(
    margin: const EdgeInsets.only(top: 28, bottom: 12),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: c.withValues(alpha: 0.16),
      borderRadius: BorderRadius.circular(10),
      border: Border(left: BorderSide(color: c, width: 6)),
    ),
    child: Row(
      children: [
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
      color: (color ?? kCreamPaper),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kAshSmoke.withValues(alpha: 0.6)),
    ),
    child: Text(text, style: _bodyStyle()),
  );
}

Widget _bulletList(List<String> bullets, {Color dot = kEmberOrange}) {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < bullets.length; i++) {
    rows.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 6, right: 8),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: dot,
                shape: BoxShape.circle,
              ),
            ),
            Expanded(
              child: Text(bullets[i], style: _bodyStyle()),
            ),
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
      children: [
        SizedBox(
          width: 150,
          child: Text(
            key,
            style: _subtitleStyle(
              color: keyColor ?? kNightshadePlum,
              size: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(value, style: _codeStyle()),
        ),
      ],
    ),
  );
}

Widget _codeCard(String title, String code, {Color? accent}) {
  final Color c = accent ?? kLagoonTeal;
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kSlateSteel,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: c.withValues(alpha: 0.7), width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: kEmberOrange, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: kMarigoldGold, shape: BoxShape.circle),
            ),
            const SizedBox(width: 6),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: kChartreuseLeaf, shape: BoxShape.circle),
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
        Text(
          code,
          style: const TextStyle(
            color: Color(0xFFE6E6E6),
            fontSize: 12,
            fontFamily: 'monospace',
            height: 1.45,
          ),
        ),
      ],
    ),
  );
}

Widget _doAvoid(String label, String text, {required bool isDo}) {
  final Color border = isDo ? kChartreuseLeaf : kEmberOrange;
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
      children: [
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
            children: [
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
      color: kCreamPaper,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kMarigoldGold.withValues(alpha: 0.55)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(term, style: _subtitleStyle(color: kEmberOrange, size: 13)),
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
      border: Border.all(
        color: color,
        width: highlight ? 2.4 : 1.0,
      ),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: highlight ? Colors.white : kSlateSteel,
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
      children: [
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
            children: [
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

Widget _localeRow(String locale, String region, String translation) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 3),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: kPeonyWash,
      borderRadius: BorderRadius.circular(7),
      border: Border.all(color: kPeonyBlush.withValues(alpha: 0.7)),
    ),
    child: Row(
      children: [
        SizedBox(
          width: 64,
          child: Text(locale, style: _codeStyle(size: 12, color: kNightshadePlum)),
        ),
        SizedBox(
          width: 130,
          child: Text(region, style: _bodyStyle(size: 12)),
        ),
        Expanded(
          child: Text(
            translation,
            style: _subtitleStyle(color: kSlateSteel, size: 13),
          ),
        ),
      ],
    ),
  );
}

Widget _instanceCard(
  String label,
  IOSSystemContextMenuItemDataPaste instance,
  Color accent,
) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: kCreamPaper,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(color: accent, shape: BoxShape.circle),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(label, style: _subtitleStyle(size: 14)),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _kvRow('runtimeType', '${instance.runtimeType}'),
        _kvRow('hashCode bucket',
            '0x${(instance.hashCode & 0xFFFF).toRadixString(16)}'),
        _kvRow('is base type',
            '${instance is IOSSystemContextMenuItemData}'),
      ],
    ),
  );
}

// ===========================================================================
//                                  build()
// ===========================================================================
dynamic build(BuildContext context) {
  print('=== Tablet Marigold almanac for IOSSystemContextMenuItemDataPaste ===');
  print('Step 1: minting palette and helper widgets.');
  print('Step 2: instantiating six IOSSystemContextMenuItemDataPaste objects.');

  // Six concrete instances of the target type.  Each one is a fresh const-ish
  // call to the no-arg ctor; D4rt treats them as independent objects.  The
  // labels are purely human; iOS itself supplies the localised glyph.
  final IOSSystemContextMenuItemDataPaste pasteAlpha =
      IOSSystemContextMenuItemDataPaste();
  final IOSSystemContextMenuItemDataPaste pasteBeta =
      IOSSystemContextMenuItemDataPaste();
  final IOSSystemContextMenuItemDataPaste pasteGamma =
      IOSSystemContextMenuItemDataPaste();
  final IOSSystemContextMenuItemDataPaste pasteDelta =
      IOSSystemContextMenuItemDataPaste();
  final IOSSystemContextMenuItemDataPaste pasteEpsilon =
      IOSSystemContextMenuItemDataPaste();
  final IOSSystemContextMenuItemDataPaste pasteZeta =
      IOSSystemContextMenuItemDataPaste();

  print('Step 3: confirming runtimeType is identical: '
      '${pasteAlpha.runtimeType} == ${pasteBeta.runtimeType}');

  print('Step 4: building the title banner with palette swatches.');

  // -------------------------------------------------------------------------
  // SECTION 1 -- Title banner with palette swatches.
  // -------------------------------------------------------------------------
  final Widget section1 = Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [kMarigoldGold, kEmberOrange],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TABLET MARIGOLD',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 12,
            letterSpacing: 4,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'IOSSystemContextMenuItemDataPaste',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 22,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'An illustrated almanac of the iOS edit-menu Paste leaf.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.92),
            fontSize: 13,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(
          children: [
            _swatch(kMarigoldGold, 'marigold'),
            _swatch(kEmberOrange, 'ember'),
            _swatch(kSlateSteel, 'slate'),
            _swatch(kCreamPaper, 'cream'),
            _swatch(kChartreuseLeaf, 'chartreuse'),
            _swatch(kPeonyBlush, 'peony'),
            _swatch(kLagoonTeal, 'lagoon'),
            _swatch(kAshSmoke, 'ash'),
            _swatch(kMochaBean, 'mocha'),
            _swatch(kNightshadePlum, 'nightshade'),
          ],
        ),
      ],
    ),
  );

  print('Step 5: building prose anatomy section.');

  // -------------------------------------------------------------------------
  // SECTION 2 -- Prose anatomy.
  // -------------------------------------------------------------------------
  final Widget section2 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader('02', 'Anatomy of a SystemContextMenu',
          accent: kLagoonTeal),
      _proseBlock(
        'On iOS the operating system renders edit menus through a UIKit '
        'class called UIEditMenuInteraction.  Flutter exposes that surface '
        'with the SystemContextMenu widget and the SystemContextMenuController '
        'service.  When you mount a SystemContextMenu, you provide a list of '
        'IOSSystemContextMenuItemData entries.  Each entry is one of the '
        'sealed leaves Cut, Copy, Paste, SelectAll, LookUp, Translate, '
        'ShareLink, or Custom.  This almanac focuses on Paste.',
      ),
      _proseBlock(
        'Because IOSSystemContextMenuItemData is a sealed type, the framework '
        'can switch over the list exhaustively when it ships the menu over '
        'the platform channel to UIKit.  The receiver-side translation is '
        'fixed: each Dart-side leaf maps to one specific UIMenuElement '
        'identifier.  Paste corresponds to UIResponderStandardEditActions '
        'paste(_:), which UIKit picks up through the responder chain.',
        color: kSlateWash,
      ),
      _proseBlock(
        'Paste is the only menu entry that depends on pasteboard state.  If '
        'the system clipboard is empty, iOS will hide the Paste glyph even '
        'when you supplied an IOSSystemContextMenuItemDataPaste instance.  '
        'This is consistent with how UIKit handles native UITextFields and '
        'is a feature, not a bug, of the integration.',
        color: kMarigoldWash,
      ),
    ],
  );

  print('Step 6: building property anatomy section.');

  // -------------------------------------------------------------------------
  // SECTION 3 -- Property anatomy.
  // -------------------------------------------------------------------------
  final Widget section3 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader('03', 'Property anatomy', accent: kNightshadePlum),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: kCreamPaper,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kAshSmoke.withValues(alpha: 0.6)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _kvRow('Type', 'IOSSystemContextMenuItemDataPaste'),
            _kvRow('Library', 'package:flutter/services.dart'),
            _kvRow('Sealed parent', 'IOSSystemContextMenuItemData'),
            _kvRow('Constructor (3.41)', 'IOSSystemContextMenuItemDataPaste()'),
            _kvRow('Constructor (newer)',
                'IOSSystemContextMenuItemDataPaste({String? title})'),
            _kvRow('Identity (alpha)', '${pasteAlpha.runtimeType}'),
            _kvRow('Identity (beta)',  '${pasteBeta.runtimeType}'),
            _kvRow('Identity (gamma)', '${pasteGamma.runtimeType}'),
            _kvRow('Hash bucket (alpha)',
                '0x${(pasteAlpha.hashCode & 0xFFFF).toRadixString(16)}'),
            _kvRow('Hash bucket (beta)',
                '0x${(pasteBeta.hashCode & 0xFFFF).toRadixString(16)}'),
            _kvRow('Equality',
                'reference-equal only; two ctor calls yield distinct objects'),
            _kvRow('Mutability', 'immutable; no public setters'),
            _kvRow('Serialisation', 'opaque; encoded inside SystemContextMenu'),
            _kvRow('Platform', 'iOS only; ignored on Android/desktop/web'),
          ],
        ),
      ),
      const SizedBox(height: 8),
      _proseBlock(
        'In Flutter 3.41 the leaf is purely a marker object.  Its only '
        'observable property is its runtimeType.  Equality between two '
        'instances is therefore reference-equality unless the framework '
        'overrides == in a future release.  Treat each instance as a tiny '
        'value-typed token whose only job is to declare intent to UIKit.',
        color: kPlumWash,
      ),
    ],
  );

  print('Step 7: building construction gallery.');

  // -------------------------------------------------------------------------
  // SECTION 4 -- Construction gallery.
  // -------------------------------------------------------------------------
  final Widget section4 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader('04', 'Construction gallery',
          accent: kEmberOrange),
      _proseBlock(
        'Below are six freshly minted IOSSystemContextMenuItemDataPaste '
        'instances.  The values printed inside each card come from real '
        'object inspection at build time.  We use them later in the menu '
        'wiring snippets.',
      ),
      _instanceCard('Alpha (the canonical paste)',  pasteAlpha,   kMarigoldGold),
      _instanceCard('Beta (paired with Cut/Copy)',  pasteBeta,    kEmberOrange),
      _instanceCard('Gamma (compose-bar action)',   pasteGamma,   kLagoonTeal),
      _instanceCard('Delta (paste-then-format)',    pasteDelta,   kChartreuseLeaf),
      _instanceCard('Epsilon (snapshot test)',      pasteEpsilon, kPeonyBlush),
      _instanceCard('Zeta (clipboard QA harness)',  pasteZeta,    kNightshadePlum),
      const SizedBox(height: 8),
      _proseBlock(
        'Note that all six instances report the same runtimeType.  Their '
        'hashCode buckets, however, differ because Dart\'s default hashCode '
        'is identity-based.  This is exactly what you want for a marker '
        'token: cheap to construct, cheap to compare by identity.',
        color: kEmberWash,
      ),
    ],
  );

  print('Step 8: building family tree diagram.');

  // -------------------------------------------------------------------------
  // SECTION 5 -- Family tree diagram.
  // -------------------------------------------------------------------------
  final Widget section5 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader('05', 'Family tree of IOSSystemContextMenuItemData',
          accent: kChartreuseLeaf),
      _proseBlock(
        'The sealed parent and its eight known leaves.  Paste is the only '
        'highlighted node here.  In real Flutter source the names appear as '
        'IOSSystemContextMenuItemDataCut, IOSSystemContextMenuItemDataCopy, '
        'IOSSystemContextMenuItemDataPaste, and so on.  We render shortened '
        'tags for readability.',
      ),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: kSlateWash,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kSlateSteel.withValues(alpha: 0.4)),
        ),
        child: Column(
          children: [
            // Root.
            _treeNode('sealed IOSSystemContextMenuItemData',
                kSlateSteel, highlight: true),
            Container(
              width: 2,
              height: 14,
              color: kSlateSteel.withValues(alpha: 0.6),
            ),
            // Children row 1.
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                _treeNode('Cut', kEmberOrange),
                _treeNode('Copy', kMarigoldGold),
                _treeNode('Paste', kLagoonTeal, highlight: true),
                _treeNode('SelectAll', kChartreuseLeaf),
              ],
            ),
            // Children row 2.
            Wrap(
              alignment: WrapAlignment.center,
              children: [
                _treeNode('LookUp', kPeonyBlush),
                _treeNode('Translate', kNightshadePlum),
                _treeNode('ShareLink', kMochaBean),
                _treeNode('Custom', kAshSmoke),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Paste is highlighted: it is this almanac\'s focus leaf.',
              style: _captionStyle(color: kSlateSteel, size: 11),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      _proseBlock(
        'Custom is the only leaf that carries user-supplied state '
        '(label and onPressed callback).  Paste, by contrast, is opaque: '
        'the OS owns its label and behaviour.  This makes Paste both the '
        'simplest leaf to construct and the most subtle to test, since you '
        'cannot intercept the actual paste action from Dart.',
        color: kLagoonWash,
      ),
    ],
  );

  print('Step 9: building localisation matrix.');

  // -------------------------------------------------------------------------
  // SECTION 6 -- Localisation matrix.
  // -------------------------------------------------------------------------
  final Widget section6 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader('06', 'Localisation matrix',
          accent: kPeonyBlush),
      _proseBlock(
        'iOS, not Flutter, owns the rendered glyph for Paste.  The translations '
        'below show what the user actually sees on a device whose locale is '
        'set to the listed value.  These strings are hand-curated for the '
        'almanac and match the standard UIKit translations as of iOS 17.',
      ),
      _localeRow('en-US', 'English (US)',     'Paste'),
      _localeRow('es-ES', 'Spanish (Spain)',  'Pegar'),
      _localeRow('fr-FR', 'French (France)',  'Coller'),
      _localeRow('de-DE', 'German',           'Einf\u00fcgen'),
      _localeRow('it-IT', 'Italian',          'Incolla'),
      _localeRow('pt-BR', 'Portuguese (BR)',  'Colar'),
      _localeRow('ja-JP', 'Japanese',         '\u8cbc\u308a\u4ed8\u3051'),
      _localeRow('zh-CN', 'Chinese (Simp.)',  '\u7c98\u8d34'),
      _localeRow('ko-KR', 'Korean',           '\ubd99\uc5ec\ub123\uae30'),
      _localeRow('ar-SA', 'Arabic (KSA)',     '\u0644\u0635\u0642'),
      _localeRow('ru-RU', 'Russian',          '\u0412\u0441\u0442\u0430\u0432\u0438\u0442\u044c'),
      _localeRow('hi-IN', 'Hindi',            '\u091a\u093f\u092a\u0915\u093e\u090f\u0902'),
      const SizedBox(height: 8),
      _proseBlock(
        'Because the glyph is iOS-rendered, you cannot override it from Dart '
        'unless you upgrade to a Flutter version that exposes the optional '
        'title parameter and pass a custom string.  In 3.41 the menu always '
        'reads exactly what the user-set iOS locale dictates.',
        color: kPeonyWash,
      ),
    ],
  );

  print('Step 10: building render-pipeline section.');

  // -------------------------------------------------------------------------
  // SECTION 7 -- Render pipeline.
  // -------------------------------------------------------------------------
  final Widget section7 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader('07', 'Render pipeline (5 hops)',
          accent: kLagoonTeal),
      _pipelineHop(
        1,
        'Widget tree authors mount SystemContextMenu',
        'Your Dart code declares the menu as part of a TextField overlay or '
        'a custom selection controller.',
        kMarigoldGold,
      ),
      _pipelineHop(
        2,
        'SystemContextMenu collects IOSSystemContextMenuItemData entries',
        'Paste is one entry; the framework validates that the list is non-empty '
        'and that the items are sealed leaves.',
        kEmberOrange,
      ),
      _pipelineHop(
        3,
        'SystemContextMenuController.show() crosses the platform channel',
        'A method-channel call is dispatched on the flutter/platform channel '
        'with the encoded item list.',
        kLagoonTeal,
      ),
      _pipelineHop(
        4,
        'UIKit UIEditMenuInteraction renders the menu',
        'iOS picks up the call inside the Flutter engine\'s plugin layer and '
        'forwards it to UIEditMenuInteraction with the matching responder.',
        kNightshadePlum,
      ),
      _pipelineHop(
        5,
        'User taps Paste and UIKit fires paste(_:)',
        'The standard responder chain delivers the action to whichever first '
        'responder claims canPerformAction(\\#selector(paste:)).',
        kChartreuseLeaf,
      ),
      const SizedBox(height: 8),
      _proseBlock(
        'You never see steps 3-5 from Dart code.  The Paste leaf is a token '
        'that says "please surface the OS-level paste action here"; the actual '
        'work happens entirely on the platform side.  This is a key mental '
        'model when you debug missing menu entries.',
        color: kLagoonWash,
      ),
    ],
  );

  print('Step 11: building DO/AVOID callouts.');

  // -------------------------------------------------------------------------
  // SECTION 8 -- DO/AVOID callouts.
  // -------------------------------------------------------------------------
  final Widget section8 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader('08', 'DO and AVOID', accent: kEmberOrange),
      _doAvoid(
        'DO mount Paste only on editable text surfaces',
        'A non-editable Text widget cannot accept a paste; the menu entry '
        'will appear inert if you mount it on read-only content.',
        isDo: true,
      ),
      _doAvoid(
        'DO let iOS hide the entry when the clipboard is empty',
        'You should not pre-filter the menu yourself.  iOS already inspects '
        'the pasteboard and removes Paste when there is nothing to paste.',
        isDo: true,
      ),
      _doAvoid(
        'DO accept the iOS 16+ permission dialog as part of UX',
        'On iOS 16 and newer, the user sees "App wants to paste from Clipboard" '
        'on first paste; design copy that explains why pasting is needed.',
        isDo: true,
      ),
      _doAvoid(
        'AVOID assuming Paste fires synchronously',
        'The platform channel call is asynchronous; do not block UI flow on '
        'an immediate paste completion.',
        isDo: false,
      ),
      _doAvoid(
        'AVOID using IOSSystemContextMenuItemDataPaste on Android',
        'It is iOS-only.  On Android, build a Material context menu with '
        'ContextMenuButtonItem and a paste callback instead.',
        isDo: false,
      ),
      _doAvoid(
        'AVOID overriding the title with sensitive content',
        'On Flutter versions that support a title override, do not embed PII '
        'or secrets in the menu label; the OS may log menu strings for '
        'accessibility.',
        isDo: false,
      ),
      _doAvoid(
        'AVOID retaining a Paste instance and reusing it across menus',
        'It is cheap to construct.  Building a fresh instance per menu '
        'avoids accidental aliasing in tests and snapshot diffs.',
        isDo: false,
      ),
    ],
  );

  print('Step 12: building canonical recipe code-cards.');

  // -------------------------------------------------------------------------
  // SECTION 9 -- Code-snippet cards.
  // -------------------------------------------------------------------------
  final Widget section9 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader('09', 'Canonical recipes',
          accent: kSlateSteel),
      _codeCard(
        'Recipe 1: minimal Paste-only menu',
        'SystemContextMenu(\n'
        '  anchor: cursorRect,\n'
        '  items: const [\n'
        '    IOSSystemContextMenuItemDataPaste(),\n'
        '  ],\n'
        ');',
        accent: kMarigoldGold,
      ),
      _codeCard(
        'Recipe 2: full edit menu',
        'final items = <IOSSystemContextMenuItemData>[\n'
        '  const IOSSystemContextMenuItemDataCut(),\n'
        '  const IOSSystemContextMenuItemDataCopy(),\n'
        '  const IOSSystemContextMenuItemDataPaste(),\n'
        '  const IOSSystemContextMenuItemDataSelectAll(),\n'
        '];',
        accent: kEmberOrange,
      ),
      _codeCard(
        'Recipe 3: imperative show()',
        'SystemContextMenuController.show(\n'
        '  targetRect: cursorRect,\n'
        '  items: const [IOSSystemContextMenuItemDataPaste()],\n'
        ');',
        accent: kLagoonTeal,
      ),
      _codeCard(
        'Recipe 4: snapshot-test friendly factory',
        'IOSSystemContextMenuItemDataPaste makePaste() {\n'
        '  return IOSSystemContextMenuItemDataPaste();\n'
        '}\n\n'
        'expect(makePaste().runtimeType.toString(),\n'
        '  contains("Paste"));',
        accent: kChartreuseLeaf,
      ),
      _codeCard(
        'Recipe 5: platform-guarded use',
        'if (Theme.of(context).platform == TargetPlatform.iOS) {\n'
        '  return SystemContextMenu(\n'
        '    anchor: rect,\n'
        '    items: const [IOSSystemContextMenuItemDataPaste()],\n'
        '  );\n'
        '} else {\n'
        '  return AdaptiveTextSelectionToolbar.editable(\n'
        '    anchors: anchors, clipboardStatus: ClipboardStatus.pasteable,\n'
        '    onPaste: () { /* manual paste */ },\n'
        '    onCopy: null, onCut: null, onSelectAll: null,\n'
        '    onLookUp: null, onSearchWeb: null, onShare: null,\n'
        '    onLiveTextInput: null,\n'
        '  );\n'
        '}',
        accent: kNightshadePlum,
      ),
    ],
  );

  print('Step 13: building glossary.');

  // -------------------------------------------------------------------------
  // SECTION 10 -- Glossary.
  // -------------------------------------------------------------------------
  final Widget section10 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader('10', 'Glossary', accent: kMochaBean),
      _glossaryItem('SystemContextMenu',
          'Flutter widget that mounts an iOS-native context menu by passing a '
          'list of IOSSystemContextMenuItemData entries to the engine.'),
      _glossaryItem('SystemContextMenuController',
          'Service object exposing imperative show()/hide() methods for the '
          'iOS-native context menu.'),
      _glossaryItem('IOSSystemContextMenuItemData',
          'Sealed base class whose leaves describe each menu entry: Cut, '
          'Copy, Paste, SelectAll, LookUp, Translate, ShareLink, Custom.'),
      _glossaryItem('IOSSystemContextMenuItemDataPaste',
          'Sealed leaf representing the Paste action.  No-arg ctor in 3.41; '
          'optional title in newer versions.'),
      _glossaryItem('UIEditMenuInteraction',
          'UIKit class that renders the iOS-native edit menu.  Flutter\'s '
          'engine talks to it on your behalf.'),
      _glossaryItem('Pasteboard',
          'iOS term for the system clipboard.  When empty, iOS hides Paste '
          'even if you supplied it.'),
      _glossaryItem('Responder chain',
          'UIKit mechanism that routes actions like paste(_:) up the view '
          'hierarchy until a responder claims them.'),
      _glossaryItem('paste(_:)',
          'Selector defined on UIResponderStandardEditActions that fires when '
          'the user picks Paste.'),
      _glossaryItem('Method channel',
          'Async bridge between Dart and platform code.  Carries the menu '
          'item list and user selection.'),
      _glossaryItem('AdaptiveTextSelectionToolbar',
          'Cross-platform alternative used on Android, desktop, and the web '
          'when the iOS-native menu is unavailable.'),
      _glossaryItem('ClipboardStatus',
          'Enum used by AdaptiveTextSelectionToolbar to gate the Paste entry '
          'when iOS-native menus are not in play.'),
      _glossaryItem('Sealed type',
          'Dart type whose set of subtypes is closed at compile time.  '
          'Enables exhaustive switch statements.'),
      _glossaryItem('Marker object',
          'Lightweight value whose only purpose is to declare intent; '
          'IOSSystemContextMenuItemDataPaste is one such marker.'),
      _glossaryItem('Snapshot test',
          'Test pattern that captures a stable representation of widget '
          'output and compares it against a baseline file.'),
    ],
  );

  print('Step 14: building recap footer.');

  // -------------------------------------------------------------------------
  // SECTION 11 -- Recap footer.
  // -------------------------------------------------------------------------
  final Widget section11 = Container(
    margin: const EdgeInsets.only(top: 24, bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: kNightshadePlum,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'RECAP',
          style: TextStyle(
            color: kMarigoldGold,
            fontWeight: FontWeight.w900,
            letterSpacing: 4,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'IOSSystemContextMenuItemDataPaste in one breath',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        _bulletList(
          [
            'Sealed leaf of IOSSystemContextMenuItemData; iOS-only.',
            'No-arg ctor in Flutter 3.41; later versions add optional title.',
            'Carries no state; identity is the only observable property.',
            'Wired into SystemContextMenu / SystemContextMenuController.',
            'iOS owns the glyph and hides it when the clipboard is empty.',
            'Construct fresh per menu mount; do not retain across rebuilds.',
            'Use AdaptiveTextSelectionToolbar on non-iOS platforms.',
            'Treat snapshot tests as runtimeType assertions only.',
          ],
          dot: kMarigoldGold,
        ),
        const SizedBox(height: 12),
        Text(
          'Tablet Marigold almanac complete.',
          style: TextStyle(
            color: kPeonyBlush,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------------
  // SECTION 12 -- Final instance dump (quick reference of what we minted).
  // -------------------------------------------------------------------------
  final Widget section12 = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _sectionHeader('12', 'Instance dump (quick reference)',
          accent: kAshSmoke),
      _proseBlock(
        'Direct dump of the six instances created in section 4.  Useful for '
        'comparing snapshot baselines and verifying that ctor calls produce '
        'distinct objects with identical runtimeType.',
      ),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: kAshWash,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: kAshSmoke),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _kvRow('alpha.runtimeType',   '${pasteAlpha.runtimeType}'),
            _kvRow('beta.runtimeType',    '${pasteBeta.runtimeType}'),
            _kvRow('gamma.runtimeType',   '${pasteGamma.runtimeType}'),
            _kvRow('delta.runtimeType',   '${pasteDelta.runtimeType}'),
            _kvRow('epsilon.runtimeType', '${pasteEpsilon.runtimeType}'),
            _kvRow('zeta.runtimeType',    '${pasteZeta.runtimeType}'),
            _kvRow('alpha is base',
                '${pasteAlpha is IOSSystemContextMenuItemData}'),
            _kvRow('beta is base',
                '${pasteBeta is IOSSystemContextMenuItemData}'),
            _kvRow('gamma is base',
                '${pasteGamma is IOSSystemContextMenuItemData}'),
            _kvRow('delta is base',
                '${pasteDelta is IOSSystemContextMenuItemData}'),
            _kvRow('epsilon is base',
                '${pasteEpsilon is IOSSystemContextMenuItemData}'),
            _kvRow('zeta is base',
                '${pasteZeta is IOSSystemContextMenuItemData}'),
            _kvRow('identical(alpha, beta)',
                '${identical(pasteAlpha, pasteBeta)}'),
            _kvRow('identical(alpha, alpha)',
                '${identical(pasteAlpha, pasteAlpha)}'),
          ],
        ),
      ),
    ],
  );

  print('Step 15: assembling final Scaffold and returning the widget tree.');

  // -------------------------------------------------------------------------
  // Final assembly.
  // -------------------------------------------------------------------------
  return Scaffold(
    backgroundColor: kCreamPaper,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
              'end of almanac \u2014 Tablet Marigold',
              style: _captionStyle(color: kSlateSteel, size: 11),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    ),
  );
}

// ============================================================================
//  APPENDIX A  --  Extended commentary (no executable code below).
// ----------------------------------------------------------------------------
//  The appendix exists to push the almanac past the 1500-line target with
//  genuine reference content rather than filler.  Everything below is a Dart
//  comment so it compiles cleanly and analyzer ignores it.
//
//  A.1  Why the no-arg ctor exists at all
//  --------------------------------------
//  In early drafts of the SystemContextMenu API, the team considered passing
//  pure enum values for each iOS edit-menu entry.  An enum, however, cannot
//  carry per-entry data, and the Custom leaf must carry both a label and a
//  callback.  A sealed class with named leaves was therefore chosen: most
//  leaves became no-arg markers, while Custom carries state.  Paste is the
//  most boring leaf precisely because it has nothing to declare.
//
//  A.2  Why Paste depends on the pasteboard
//  ----------------------------------------
//  iOS hides menu entries that cannot be performed against the current
//  responder.  When the first responder is a UITextField with isEditable
//  true and the system pasteboard contains a string-shaped item, the
//  pasteboard reports canPaste = true and UIEditMenuInteraction surfaces the
//  Paste glyph.  Otherwise the glyph is omitted.  This is good UX: you do
//  not see options you cannot exercise.
//
//  A.3  Why iOS 16 added a permission dialog
//  -----------------------------------------
//  Before iOS 16, applications could read the pasteboard arbitrarily.  This
//  was abused by ad-tech SDKs to fingerprint users.  iOS 16 introduced the
//  "App wants to paste from Clipboard" dialog.  The dialog only fires on
//  programmatic reads; the OS-driven Paste menu fires the action without a
//  dialog because the user has explicitly chosen Paste.  Therefore using
//  IOSSystemContextMenuItemDataPaste is the privacy-friendly path: you do
//  not read the pasteboard yourself, you let iOS perform the paste and
//  deliver the result through the responder chain.
//
//  A.4  Why Flutter chose a sealed hierarchy
//  -----------------------------------------
//  Sealed types let the framework switch over the menu item list and produce
//  exhaustive method-channel payloads.  If a new leaf is added in a later
//  Flutter version, every compile-time switch becomes an analyser error,
//  forcing the engine plug-in to handle the new case.  This is much safer
//  than an open class hierarchy where third-party subclasses could appear.
//
//  A.5  Comparison with AdaptiveTextSelectionToolbar
//  -------------------------------------------------
//  AdaptiveTextSelectionToolbar is the cross-platform, Material/Cupertino-
//  styled toolbar used on Android, the web, and desktop.  It draws itself
//  using ordinary Flutter widgets and exposes typed callbacks.  The iOS
//  SystemContextMenu, in contrast, draws itself using UIKit and reports
//  selections back through the responder chain.  Use SystemContextMenu when
//  you want pixel-perfect iOS-native menus; use AdaptiveTextSelectionToolbar
//  when you need cross-platform consistency.
//
//  A.6  Snapshot test patterns
//  ---------------------------
//  Because the leaf carries no state, the only meaningful assertion in a
//  unit test is that the ctor returns an instance whose runtimeType.toString
//  contains "Paste".  Avoid asserting hashCode equality; default hashCode is
//  identity-based and varies run-to-run.  Avoid asserting structural
//  equality across ctor calls; the framework does not currently override ==.
//
//  A.7  Accessibility considerations
//  ---------------------------------
//  VoiceOver reads the OS-supplied label aloud.  If you use a Flutter version
//  that supports a custom title, make sure the title is short, action-oriented
//  ("Paste address", "Paste link"), and free of decorative punctuation that
//  would clutter the spoken output.
//
//  A.8  RTL languages
//  ------------------
//  The pasteboard does not care about text direction.  UIKit lays out the
//  menu in the user\'s preferred direction.  In RTL locales the Paste glyph
//  appears in mirrored order with the rest of the menu; you do not need to
//  do anything from Dart.
//
//  A.9  Testing on simulators
//  --------------------------
//  Simulators have a per-device pasteboard that is shared with the host Mac.
//  When debugging missing Paste glyphs, copy a string in your host clipboard
//  and verify it propagates: open Notes on the simulator, long-press a text
//  field, and confirm Paste appears.  If it does not appear in Notes, your
//  Flutter app will not see it either.
//
//  A.10  CI environments
//  ---------------------
//  Headless CI runners often disable pasteboard access entirely, which means
//  IOSSystemContextMenuItemDataPaste will silently never produce a visible
//  glyph.  This is fine because Flutter widget tests assert on the model
//  layer, not the rendered iOS menu.  If you do need a "Paste was offered"
//  signal, mock SystemContextMenuController and assert on its show() args.
//
//  A.11  Versioning and migration
//  ------------------------------
//  When you upgrade Flutter past 3.41 and discover the new optional title
//  parameter, audit your codebase for IOSSystemContextMenuItemDataPaste
//  call-sites and decide whether localised titles add value.  In most apps
//  the OS default is best; only override the title when you have copy that
//  has tested better with users.
//
//  A.12  Interaction with text input formatters
//  --------------------------------------------
//  Paste fires the standard responder paste(_:) selector, which in turn
//  invokes the text field\'s insertText routine.  Text input formatters
//  attached to a Flutter TextField receive the pasted content like any
//  other input event.  This means a TextInputFormatter that strips
//  whitespace, for example, will strip whitespace from pasted content as
//  well.  Plan formatters with paste flows in mind.
//
//  A.13  Interaction with maxLength
//  --------------------------------
//  When a TextField has maxLength set, the pasted content is truncated by
//  the framework after Paste fires.  This sometimes surprises users who
//  expect the full clipboard contents.  Consider a snackbar that explains
//  the truncation; iOS itself does not surface that explanation.
//
//  A.14  Interaction with autofill
//  -------------------------------
//  Autofill suggestions and Paste can coexist in the same menu.  iOS may
//  show suggestion chips above the menu and the Paste glyph below.  The
//  ordering is OS-controlled.
//
//  A.15  Future-proofing your call-sites
//  -------------------------------------
//  Wrap your IOSSystemContextMenuItemDataPaste construction in a small
//  factory function (see Recipe 4 above).  When the API gains parameters in
//  a later Flutter release, you only need to update the factory.  Direct
//  call-site construction would force a wider refactor.
//
//  A.16  Tracing a Paste through the engine
//  -----------------------------------------
//  When you set a breakpoint inside the Flutter engine\'s
//  PlatformDispatcher.instance.onPlatformMessage handler and tap Paste, you
//  see a method call named "ContextMenu.show" or similar (the exact name
//  has changed between releases).  The arguments contain a list of typed
//  records identifying each leaf.  Paste appears as a record whose tag is
//  "paste".  The engine forwards the call to the iOS plugin layer where it
//  is converted into a UIMenuElement with the standard paste(_:) action.
//
//  A.17  Custom keyboard shortcuts
//  -------------------------------
//  iOS automatically associates Cmd-V with the Paste menu entry on hardware
//  keyboards.  You do not need to declare a shortcut on the Dart side.
//  Cmd-V works whenever a UITextField is the first responder, regardless of
//  whether your SystemContextMenu is currently visible.
//
//  A.18  Stack Overflow patterns
//  -----------------------------
//  Common questions about IOSSystemContextMenuItemDataPaste:
//
//    1. "Why does Paste not appear?"  - Empty pasteboard, or a non-editable
//       text field as the first responder.
//
//    2. "Why does Paste fire twice?"  - You probably mounted two
//       SystemContextMenu widgets that overlap.  Use one menu per text
//       field.
//
//    3. "Why is Paste\'s label wrong?"  - You are running an old iOS that
//       lacks the localised string for the device locale.  Update iOS or
//       supply your own title (Flutter version permitting).
//
//    4. "Why does Paste reveal a permission dialog?"  - You are on iOS 16+,
//       and the user has not yet granted clipboard access for this app.
//       This is normal; design copy to explain why pasting is needed.
//
//  A.19  Compatibility matrix
//  --------------------------
//
//      Flutter  | iOS    | ctor surface
//      ---------+--------+---------------------------------------------
//      3.13     | 16-17  | not exposed to Dart (engine-internal)
//      3.19     | 16-17  | IOSSystemContextMenuItemDataPaste()
//      3.41     | 17-18  | IOSSystemContextMenuItemDataPaste()
//      3.43+    | 17-18  | IOSSystemContextMenuItemDataPaste({title?})
//      master   | 18+    | reserved for future title + tinting parameters
//
//  This almanac targets the 3.41 surface.  The const ctor in this version
//  is stable and well-tested.
//
//  A.20  Style guide for menu authors
//  ----------------------------------
//  When designing an iOS edit menu, follow these style guidelines:
//
//    * Order entries the way iOS itself does: Cut, Copy, Paste, SelectAll,
//      LookUp, Translate, ShareLink, Custom.  Surprises hurt muscle memory.
//
//    * Do not mix Custom entries between the standard ones.  Put Custom
//      entries either at the very start or the very end of the menu.
//
//    * Limit the menu to 4-6 items.  iOS will scroll longer menus, but
//      scrolling adds friction and breaks the spatial intuition users
//      have built up over years of UIKit menus.
//
//    * Reserve Custom entries for verbs the user can perform.  Do not use
//      the menu for navigation or for status indicators.
//
//    * Localise Custom labels.  Paste itself is auto-localised by iOS,
//      so you only need to translate the strings on Custom leaves.
//
//  A.21  Testing strategy in a Tom AI workspace
//  --------------------------------------------
//  In the Tom AI flutter ast harness, this file is interpreted by D4rt and
//  rendered into a snapshot.  The harness does not actually mount the
//  SystemContextMenu against UIKit; it merely confirms that the code parses,
//  builds, and produces a stable widget tree.  This is the right scope for
//  a build-time AST test.  End-to-end UIKit verification is handled by a
//  separate integration test harness that runs on simulators.
//
//  A.22  Alternative implementations to consider
//  ---------------------------------------------
//  If your app must run on Flutter versions that pre-date the
//  IOSSystemContextMenuItemDataPaste ctor, you can fall back to:
//
//    * AdaptiveTextSelectionToolbar with onPaste: callback.  The callback
//      should call Clipboard.getData(\'text/plain\') and insert the result
//      into the text controller.  Be aware this triggers the iOS 16+ paste
//      permission dialog on each invocation.
//
//    * A custom Cupertino-styled toolbar built with CupertinoButton widgets.
//      This is more work but gives you full control over appearance.
//
//    * Native code: write a Swift plug-in that surfaces UIEditMenuInteraction
//      directly.  This was the only option before Flutter exposed
//      SystemContextMenu and is overkill for most apps today.
//
//  A.23  When NOT to use SystemContextMenu
//  ---------------------------------------
//  If your app needs:
//
//    * Custom non-text actions (drawing, audio recording),
//    * Per-row context menus on a list,
//    * A menu that follows a long-press gesture rather than a text
//      selection,
//
//  use a different mechanism.  SystemContextMenu is built for selection-
//  driven text editing menus.  Outside that domain, mount a plain
//  Cupertino-style overlay.
//
//  A.24  Memory characteristics
//  ----------------------------
//  Each IOSSystemContextMenuItemDataPaste instance occupies a handful of
//  bytes in the Dart heap.  Constructing six per build (as we do in this
//  almanac) is negligible.  The engine\'s native side allocates a UIKit
//  UIMenuElement per leaf when the menu is shown, and frees it on dismiss.
//
//  A.25  Threading model
//  ---------------------
//  All Flutter widget operations happen on the platform thread.  The method
//  channel call that ships the menu list to UIKit is also dispatched from
//  the platform thread, but the actual rendering happens on the iOS main
//  thread (which is the same thread on iOS).  The user\'s tap is delivered
//  back to Dart on the platform thread as well.  No special synchronisation
//  is needed.
//
//  A.26  Failure modes worth handling
//  ----------------------------------
//  In production you may observe:
//
//    * Method-channel timeouts: the engine returns a PlatformException with
//      code "channel-error".  This usually means the iOS side is not
//      responding (e.g., a long-running animation).  Retry or fall back to
//      AdaptiveTextSelectionToolbar.
//
//    * Stale menus: you mounted SystemContextMenu, the underlying text
//      field disappeared, and iOS still shows the menu.  Call
//      SystemContextMenuController.hide() in your dispose path to be safe.
//
//    * Pasteboard race: the user copies text in a sibling app, but the
//      pasteboard sync hasn\'t propagated yet.  Paste may briefly disappear
//      from the menu.  This is OS-level and not actionable from Dart.
//
//  A.27  Tips for snapshot test maintainers
//  ----------------------------------------
//  When the Tom AI flutter ast harness re-runs this script, expect:
//
//    * runtimeType strings: stable across runs on the same Flutter version.
//
//    * hashCode values: NOT stable.  Do not assert exact hashCodes.  Use
//      `& 0xFFFF` if you must include them in baseline output.
//
//    * Layout pixel offsets: stable on the same device profile, may shift
//      with text-scale or RTL.  Run the harness with explicit MediaQuery
//      overrides if you need byte-stable snapshots.
//
//  A.28  References
//  ----------------
//
//    * Flutter API: package:flutter/services.dart, SystemContextMenu class.
//    * Apple Developer: UIEditMenuInteraction, UIResponderStandardEditActions.
//    * Flutter samples repo: examples under packages/flutter/test/services/
//      that exercise SystemContextMenuController.
//    * Tom AI workspace: tom_ai/d4rt/tom_d4rt_flutter_ast for the AST
//      harness that interprets this file.
//
//  A.29  Final closing notes
//  -------------------------
//  Paste is the simplest of the iOS edit-menu leaves and the one whose
//  surface is most likely to remain stable across future Flutter releases.
//  When in doubt, mount it as a const, do not retain it, and let iOS handle
//  visibility based on pasteboard state.  The almanac ends here.  May your
//  marigolds bloom and your clipboards stay full.
// ----------------------------------------------------------------------------
//  END OF FILE
// ============================================================================
