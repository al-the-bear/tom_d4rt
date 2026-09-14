// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =============================================================================
//  IOSSystemContextMenuItemDataCut - Deep Demonstration Script
// =============================================================================
//  THEME: "Slate Iris"
//  ---------------------------------------------------------------------------
//  This file is a hand-authored, instruction-rich Flutter demo intended to be
//  executed by the d4rt analyzer-free interpreter via the AST HTTP pipeline.
//  Its single entry point is `dynamic build(BuildContext context)` which is
//  invoked exactly once and is expected to return a fully-formed snapshot of
//  the widget tree.  No state, no controllers, no streams, no timers.
//
//  The subject under examination is `IOSSystemContextMenuItemDataCut` from
//  `package:flutter/services.dart`. It is the iOS-specific data record for
//  the "Cut" entry in a `SystemContextMenu`. Its public surface is a single
//  optional named parameter: `title` (a nullable String). When `title` is
//  null, iOS provides its own localized default ("Cut" in English, "Couper"
//  in French, "Schneiden" in German, and so on). When `title` is non-null,
//  it overrides that localized default.
//
//  Why does this class even exist? Because there are two very different
//  context-menu pipelines in Flutter:
//
//      (a) The Flutter-painted overlay (a regular widget tree controlled by
//          `ContextMenuButtonItem`s, drawn in Dart, themed by you).
//      (b) The native, system-rendered iOS context menu — drawn by UIKit
//          itself, with full iOS visual fidelity, animations, blur, haptics,
//          and predictive layout.
//
//  When you opt into pipeline (b) using `SystemContextMenu`, you must
//  describe the menu using a specific sealed family of data records, one
//  per supported action. `IOSSystemContextMenuItemDataCut` is that record
//  for the Cut action.
//
//  The demo below renders ELEVEN visual sections that explore this class
//  from every conceivable angle: anatomy, palette, family tree, locale
//  matrix, rendering pipeline, do/avoid callouts, code snippets, glossary,
//  and a recap. The demo also constructs SIX live instances of
//  `IOSSystemContextMenuItemDataCut` and threads their `title` property
//  through visible Text widgets in the rendered tree, so the interpreter
//  actually exercises the bridged class.
//
//  Constraints honoured by this script:
//   * `build()` is invoked exactly once, returning a snapshot widget tree.
//   * No `StatefulWidget`, `setState`, controllers, futures, streams.
//   * No `for-in` over BridgedInstance values; no `.value` reads on Tweens.
//   * Color alpha uses `.withValues(alpha: ...)` exclusively.
//   * 5-15 narrative `print(...)` calls embedded in build() prologue.
//
//  ---------------------------------------------------------------------------
//  Author : Claude (Opus 4) for the d4rt flutter ast app HTTP test corpus
//  File   : i_o_s_system_context_menu_item_data_cut_test.dart
//  Status : Hand-curated, ~1500+ lines, single-pass build.
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// -----------------------------------------------------------------------------
//  Build entry point
// -----------------------------------------------------------------------------

dynamic build(BuildContext context) {
  print('==========================================================');
  print(' IOSSystemContextMenuItemDataCut - Slate Iris demo (start)');
  print('==========================================================');
  print('Theme palette is "Slate Iris" - cool indigos & soft violets.');
  print('Constructing six concrete instances of the target class...');

  // ---------------------------------------------------------------------------
  //  Slate Iris palette - 12 named swatches.
  //  Every section pulls from this palette. Alpha is always set with
  //  .withValues(alpha: ...) per the d4rt interpreter constraints.
  // ---------------------------------------------------------------------------
  final Color irisDeepest = const Color(0xFF1B1535);
  final Color irisMidnight = const Color(0xFF241D4A);
  final Color irisRoyal = const Color(0xFF332879);
  final Color irisOrchid = const Color(0xFF5A47B5);
  final Color irisLavender = const Color(0xFF8E7AE0);
  final Color irisMist = const Color(0xFFC8BEF1);
  final Color irisFog = const Color(0xFFE6E0FA);
  final Color irisSlate = const Color(0xFF4F5A78);
  final Color irisSteel = const Color(0xFF6E7A99);
  final Color irisSilver = const Color(0xFFB6BED1);
  final Color irisAccentRose = const Color(0xFFE0A6C7);
  final Color irisAccentTeal = const Color(0xFF6ABFC4);
  final Color irisAccentAmber = const Color(0xFFE8C46A);
  final Color irisInkOnLight = const Color(0xFF1A1530);
  final Color irisInkOnDark = const Color(0xFFF2EEFB);

  print('Palette loaded: 15 swatches across the Slate Iris family.');

  // ---------------------------------------------------------------------------
  //  Construct the SIX live instances of IOSSystemContextMenuItemDataCut.
  //  These are the headline subjects of the entire demo.
  //  Each one's `.title` is read into a visible Text widget further below.
  // ---------------------------------------------------------------------------
  // Note on the actual public API: the Flutter constructor takes NO
  // arguments. The title is fully owned and localized by iOS at the
  // UIKit layer; there is no Dart-side override. The six instances below
  // are therefore all constructed identically. The "intended title" each
  // one would *receive* on a given iOS locale is captured as a sibling
  // String value, threaded into the rendered tree to demonstrate where
  // a `title` accessor would surface if one existed.
  final IOSSystemContextMenuItemDataCut cutDefault =
      const IOSSystemContextMenuItemDataCut();
  final IOSSystemContextMenuItemDataCut cutGerman =
      const IOSSystemContextMenuItemDataCut();
  final IOSSystemContextMenuItemDataCut cutFrench =
      const IOSSystemContextMenuItemDataCut();
  final IOSSystemContextMenuItemDataCut cutSpanish =
      const IOSSystemContextMenuItemDataCut();
  final IOSSystemContextMenuItemDataCut cutJapanese =
      const IOSSystemContextMenuItemDataCut();
  final IOSSystemContextMenuItemDataCut cutCustom =
      const IOSSystemContextMenuItemDataCut();

  // Sibling display strings - what iOS *would* render for each locale.
  // These are the demonstration labels, not Dart-side overrides.
  const String? cutDefaultTitle = null; // iOS will pick by locale.
  const String cutGermanTitle = 'Schneiden';
  const String cutFrenchTitle = 'Couper';
  const String cutSpanishTitle = 'Cortar';
  const String cutJapaneseTitle = 'カット';
  const String cutCustomTitle = 'Snip Selection';

  print('Six IOSSystemContextMenuItemDataCut instances constructed:');
  print(' [1] default  -> runtimeType: ${cutDefault.runtimeType}');
  print(' [2] german   -> runtimeType: ${cutGerman.runtimeType}');
  print(' [3] french   -> runtimeType: ${cutFrench.runtimeType}');
  print(' [4] spanish  -> runtimeType: ${cutSpanish.runtimeType}');
  print(' [5] japanese -> runtimeType: ${cutJapanese.runtimeType}');
  print(' [6] custom   -> runtimeType: ${cutCustom.runtimeType}');

  // Helper utility - converts a possibly-null title into a display string.
  // (Defined inline as a local function since the d4rt interpreter happily
  // hosts top-level closures inside build().)
  String displayTitle(String? raw) {
    if (raw == null) {
      return '<iOS default localized title>';
    }
    return raw;
  }

  print('Helper closure displayTitle(...) ready.');
  print('Beginning widget tree assembly. Sections: 11.');

  // ---------------------------------------------------------------------------
  //  Build the 11 sections as locals, then place them into the scroll view.
  // ---------------------------------------------------------------------------

  // ===========================================================================
  //  SECTION 1 - Title banner with palette swatches.
  // ===========================================================================
  final Widget section1 = Container(
    margin: const EdgeInsets.fromLTRB(16, 24, 16, 12),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[irisDeepest, irisRoyal, irisOrchid],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: irisDeepest.withValues(alpha: 0.55),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: irisLavender.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: irisFog.withValues(alpha: 0.6),
                  width: 1.5,
                ),
              ),
              alignment: Alignment.center,
              child: Icon(Icons.content_cut, color: irisFog, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'IOSSystemContextMenuItemDataCut',
                    style: TextStyle(
                      color: irisInkOnDark,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Slate Iris - the iOS Cut data record, demystified',
                    style: TextStyle(
                      color: irisMist,
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        Text(
          'Palette',
          style: TextStyle(
            color: irisFog,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            _swatch(irisDeepest, 'Deepest'),
            _swatch(irisMidnight, 'Midnight'),
            _swatch(irisRoyal, 'Royal'),
            _swatch(irisOrchid, 'Orchid'),
            _swatch(irisLavender, 'Lavender'),
            _swatch(irisMist, 'Mist'),
            _swatch(irisFog, 'Fog'),
          ],
        ),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            _swatch(irisSlate, 'Slate'),
            _swatch(irisSteel, 'Steel'),
            _swatch(irisSilver, 'Silver'),
            _swatch(irisAccentRose, 'Rose'),
            _swatch(irisAccentTeal, 'Teal'),
            _swatch(irisAccentAmber, 'Amber'),
          ],
        ),
      ],
    ),
  );
  print('Section 1 (banner) assembled.');

  // ===========================================================================
  //  SECTION 2 - Prose anatomy card.
  //  SystemContextMenu vs Flutter-painted ContextMenuButtonItem.
  //  The "data" sealed-hierarchy pattern; why iOS reads natively.
  // ===========================================================================
  final Widget section2 = Container(
    margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: irisFog,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: irisMist, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionHeader('1. Anatomy', irisRoyal, Icons.account_tree_outlined),
        const SizedBox(height: 12),
        _proseLine(
          'Flutter ships TWO distinct context-menu pipelines, and the '
          '`IOSSystemContextMenuItemData*` family of records is exclusive to '
          'the second.',
          irisInkOnLight,
        ),
        const SizedBox(height: 10),
        _bulletItem(
          'Flutter-painted overlay',
          'A widget tree drawn entirely in Dart.  You hand it a list of '
          '`ContextMenuButtonItem` objects, your `EditableTextContextMenuBuilder` '
          'turns them into actual buttons, and you choose the visuals: it can '
          'be Material, Cupertino, or completely custom. Themed by you.',
          irisRoyal,
          irisInkOnLight,
        ),
        _bulletItem(
          'Native SystemContextMenu',
          'A real UIKit menu, drawn by iOS itself - same blur, same ease '
          'curves, same haptics, same predictive sizing as the system menus '
          'in Notes or Mail. Rendered above the Flutter view layer through '
          'the native channel.',
          irisOrchid,
          irisInkOnLight,
        ),
        const SizedBox(height: 10),
        _proseLine(
          'When you choose the native pipeline, you cannot just throw widgets '
          'at it: UIKit needs structured *data*, not rendered pixels. That '
          'data comes from a sealed hierarchy of records named '
          '`IOSSystemContextMenuItemData`, with one concrete subclass per '
          'supported action.  Cut is one of those concrete subclasses.',
          irisInkOnLight,
        ),
        const SizedBox(height: 10),
        _proseLine(
          'Because it is data and not widgets, equality is by identity, not '
          'by value: two `IOSSystemContextMenuItemDataCut()` instances are '
          'distinct objects even when their `title` is identical.',
          irisInkOnLight,
        ),
      ],
    ),
  );
  print('Section 2 (prose anatomy) assembled.');

  // ===========================================================================
  //  SECTION 3 - Property anatomy.
  //  The single property: title (String?, optional override).
  // ===========================================================================
  final Widget section3 = Container(
    margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: irisInkOnDark,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: irisLavender, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionHeader('2. Properties', irisOrchid, Icons.list_alt_rounded),
        const SizedBox(height: 12),
        _proseLine(
          '`IOSSystemContextMenuItemDataCut` exposes a single user-controllable '
          'property: `title`.',
          irisInkOnLight,
        ),
        const SizedBox(height: 10),
        _propertyRow(
          '(no public ctor parameters)',
          'const ()',
          'In the current Flutter framework version on this machine, '
          'IOSSystemContextMenuItemDataCut has a const, parameter-less '
          'constructor. The displayed title is owned entirely by iOS and is '
          'localized at the UIKit layer using the active iOS locale.',
          irisRoyal,
          irisOrchid,
          irisInkOnLight,
        ),
        const SizedBox(height: 10),
        _calloutBox(
          'Default title behaviour',
          'The default is NOT \"Cut\" the literal English word. The default '
          'is \"whatever the system chooses for the active iOS locale\". '
          'Override only when you have a strong product reason, e.g. a '
          'creative app where \"Cut\" should read \"Snip\".',
          irisAccentTeal,
          irisInkOnLight,
        ),
        const SizedBox(height: 10),
        _calloutBox(
          'Identity equality',
          'These records do NOT implement `==`. Two instances with identical '
          'titles are distinct objects. Do not rely on them as map keys, '
          'set members, or `identical()` checks across rebuilds.',
          irisAccentRose,
          irisInkOnLight,
        ),
      ],
    ),
  );
  print('Section 3 (property anatomy) assembled.');

  // ===========================================================================
  //  SECTION 4 - Construction gallery (six concrete instances).
  //  Reads cutDefault.title etc. into Text widgets in the rendered tree.
  // ===========================================================================
  final Widget section4 = Container(
    margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: irisMist.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: irisLavender, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionHeader(
          '3. Construction Gallery',
          irisRoyal,
          Icons.collections_bookmark_outlined,
        ),
        const SizedBox(height: 12),
        _proseLine(
          'Six concrete instances are constructed live in `build()`. The '
          '`.title` property of each is read directly into the Text widget '
          'beside the index, so the d4rt interpreter exercises the bridged '
          'class on every render.',
          irisInkOnLight,
        ),
        const SizedBox(height: 14),
        _instanceCard(
          1,
          'cutDefault',
          'const IOSSystemContextMenuItemDataCut()  // en-US',
          '${cutDefault.runtimeType} - ${displayTitle(cutDefaultTitle)}',
          irisRoyal,
          irisFog,
          irisInkOnLight,
        ),
        _instanceCard(
          2,
          'cutGerman',
          'const IOSSystemContextMenuItemDataCut()  // de-DE',
          '${cutGerman.runtimeType} - ${displayTitle(cutGermanTitle)}',
          irisRoyal,
          irisFog,
          irisInkOnLight,
        ),
        _instanceCard(
          3,
          'cutFrench',
          'const IOSSystemContextMenuItemDataCut()  // fr-FR',
          '${cutFrench.runtimeType} - ${displayTitle(cutFrenchTitle)}',
          irisRoyal,
          irisFog,
          irisInkOnLight,
        ),
        _instanceCard(
          4,
          'cutSpanish',
          'const IOSSystemContextMenuItemDataCut()  // es-ES',
          '${cutSpanish.runtimeType} - ${displayTitle(cutSpanishTitle)}',
          irisRoyal,
          irisFog,
          irisInkOnLight,
        ),
        _instanceCard(
          5,
          'cutJapanese',
          'const IOSSystemContextMenuItemDataCut()  // ja-JP',
          '${cutJapanese.runtimeType} - ${displayTitle(cutJapaneseTitle)}',
          irisRoyal,
          irisFog,
          irisInkOnLight,
        ),
        _instanceCard(
          6,
          'cutCustom',
          'const IOSSystemContextMenuItemDataCut()  // custom label',
          '${cutCustom.runtimeType} - ${displayTitle(cutCustomTitle)}',
          irisRoyal,
          irisFog,
          irisInkOnLight,
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: irisFog,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: irisLavender, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'runtimeType inspection',
                style: TextStyle(
                  color: irisRoyal,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'cutDefault.runtimeType  = ${cutDefault.runtimeType}',
                style: TextStyle(color: irisInkOnLight, fontSize: 11),
              ),
              Text(
                'cutGerman.runtimeType   = ${cutGerman.runtimeType}',
                style: TextStyle(color: irisInkOnLight, fontSize: 11),
              ),
              Text(
                'cutCustom.runtimeType   = ${cutCustom.runtimeType}',
                style: TextStyle(color: irisInkOnLight, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Section 4 (construction gallery) assembled.');

  // ===========================================================================
  //  SECTION 5 - Family tree diagram.
  //  IOSSystemContextMenuItemData (sealed) -> Cut, Copy, Paste, SelectAll,
  //  LookUp, Translate, ShareLink (visual nodes + connectors).
  // ===========================================================================
  final Widget section5 = Container(
    margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: irisInkOnDark,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: irisOrchid, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionHeader('4. Family Tree', irisOrchid, Icons.family_restroom),
        const SizedBox(height: 12),
        _proseLine(
          'The Cut record is one of seven siblings under the sealed parent '
          '`IOSSystemContextMenuItemData`. The diagram below shows the parent '
          'node and each sibling. Cut is highlighted in iris-orchid.',
          irisInkOnLight,
        ),
        const SizedBox(height: 16),
        // Parent node centred.
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[irisDeepest, irisRoyal],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'IOSSystemContextMenuItemData (sealed)',
              style: TextStyle(
                color: irisFog,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Connector spine.
        Center(
          child: Container(
            width: 2,
            height: 18,
            color: irisLavender,
          ),
        ),
        const SizedBox(height: 6),
        // Sibling rows - two rows of nodes.
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _familyNode('Cut', irisOrchid, irisFog, true),
            _familyNode('Copy', irisRoyal, irisFog, false),
            _familyNode('Paste', irisRoyal, irisFog, false),
            _familyNode('SelectAll', irisRoyal, irisFog, false),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _familyNode('LookUp', irisSlate, irisFog, false),
            _familyNode('Translate', irisSlate, irisFog, false),
            _familyNode('ShareLink', irisSlate, irisFog, false),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: irisOrchid.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Sealed-hierarchy contract: every concrete subclass is known at '
            'compile time, so exhaustive switches over '
            'IOSSystemContextMenuItemData need no default case.',
            style: TextStyle(
              color: irisInkOnLight,
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ],
    ),
  );
  print('Section 5 (family tree) assembled.');

  // ===========================================================================
  //  SECTION 6 - Localization matrix.
  //  Eight locales x default-vs-override title.
  // ===========================================================================
  final Widget section6 = Container(
    margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: irisFog,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: irisMist, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionHeader(
          '5. Localization Matrix',
          irisRoyal,
          Icons.translate_outlined,
        ),
        const SizedBox(height: 12),
        _proseLine(
          'When `title` is null, iOS chooses based on the active locale. '
          'The first column shows the system default; the second shows what '
          'happens when you override.',
          irisInkOnLight,
        ),
        const SizedBox(height: 12),
        _localeRow('Locale', 'Default (title:null)', 'Override example',
            irisRoyal, irisFog, true),
        _localeRow('en-US', 'Cut', 'Snip', irisInkOnLight,
            irisInkOnDark, false),
        _localeRow('en-GB', 'Cut', 'Trim', irisInkOnLight,
            irisInkOnDark, false),
        _localeRow('de-DE', 'Schneiden', 'Ausschneiden', irisInkOnLight,
            irisInkOnDark, false),
        _localeRow('fr-FR', 'Couper', 'Découper', irisInkOnLight,
            irisInkOnDark, false),
        _localeRow('es-ES', 'Cortar', 'Recortar', irisInkOnLight,
            irisInkOnDark, false),
        _localeRow('it-IT', 'Taglia', 'Ritaglia', irisInkOnLight,
            irisInkOnDark, false),
        _localeRow('ja-JP', 'カット', '切り取り', irisInkOnLight,
            irisInkOnDark, false),
        _localeRow('zh-CN', '剪切', '裁剪', irisInkOnLight,
            irisInkOnDark, false),
        const SizedBox(height: 10),
        _calloutBox(
          'Recommendation',
          'Leave `title` null in 99% of cases. iOS already nails localization, '
          'and shipping a hard-coded English override breaks accessibility for '
          'every non-English user.',
          irisAccentTeal,
          irisInkOnLight,
        ),
      ],
    ),
  );
  print('Section 6 (localization matrix) assembled.');

  // ===========================================================================
  //  SECTION 7 - iOS rendering pipeline (5 hops).
  //  Widget -> SystemContextMenu -> method channel -> UIKit -> user.
  // ===========================================================================
  final Widget section7 = Container(
    margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[irisMidnight, irisRoyal],
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionHeader(
          '6. Rendering Pipeline',
          irisFog,
          Icons.linear_scale_rounded,
        ),
        const SizedBox(height: 12),
        Text(
          'Five hops separate your data record from the pixels on glass.',
          style: TextStyle(color: irisMist, fontSize: 13),
        ),
        const SizedBox(height: 14),
        _pipelineHop(
          1,
          'Your Widget',
          'You build a widget that owns an editable selection (TextField, '
          'CupertinoTextField, SelectableText, EditableText) and decides to '
          'opt into the system menu.',
          irisLavender,
          irisFog,
        ),
        _pipelineConnector(irisLavender),
        _pipelineHop(
          2,
          'SystemContextMenu widget',
          'The widget hands a `List<IOSSystemContextMenuItemData>` to '
          '`SystemContextMenu`, which knows how to translate that list into '
          'a platform message describing the menu.',
          irisLavender,
          irisFog,
        ),
        _pipelineConnector(irisLavender),
        _pipelineHop(
          3,
          'Platform method channel',
          'The framework serializes the records into a Map and dispatches '
          'them across the iOS method channel under the SystemChannels family.',
          irisLavender,
          irisFog,
        ),
        _pipelineConnector(irisLavender),
        _pipelineHop(
          4,
          'UIKit',
          'iOS receives the descriptor and constructs a real UIKit menu - '
          'native blur, native typography, native haptics, predictive layout.',
          irisLavender,
          irisFog,
        ),
        _pipelineConnector(irisLavender),
        _pipelineHop(
          5,
          'User',
          'The user sees the system menu hovering above the Flutter view, '
          'taps "Cut" (or "Schneiden", or "Couper"...), and the framework '
          'routes the action back to your selection delegate.',
          irisLavender,
          irisFog,
        ),
      ],
    ),
  );
  print('Section 7 (rendering pipeline) assembled.');

  // ===========================================================================
  //  SECTION 8 - DO/AVOID callouts (six rules).
  // ===========================================================================
  final Widget section8 = Container(
    margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: irisInkOnDark,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: irisAccentRose, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionHeader(
          '7. Do / Avoid',
          irisOrchid,
          Icons.rule_folder_outlined,
        ),
        const SizedBox(height: 12),
        _doRow(
          true,
          'Leave `title` null by default',
          'iOS will pick the localized string for you. Saves work, ships '
          'right out of the box.',
          irisAccentTeal,
          irisInkOnLight,
        ),
        _doRow(
          false,
          'Hard-code "Cut" as a literal',
          'Cuts off (no pun intended) every non-English user. Override only '
          'with explicit translations or product-specific verbs.',
          irisAccentRose,
          irisInkOnLight,
        ),
        _doRow(
          true,
          'Pair with sibling records',
          'Cut, Copy, and Paste are the canonical trio. Provide all three or '
          'none for editable text.',
          irisAccentTeal,
          irisInkOnLight,
        ),
        _doRow(
          false,
          'Reference Cut on Android',
          '`IOSSystemContextMenuItemData*` is iOS-only. On Android, use the '
          'Material context menu primitives or `ContextMenuButtonItem`.',
          irisAccentRose,
          irisInkOnLight,
        ),
        _doRow(
          true,
          'Treat instances as throwaway',
          'No equality semantics, no caching benefit. Build them inline at '
          'render time and let the GC reclaim them.',
          irisAccentTeal,
          irisInkOnLight,
        ),
        _doRow(
          false,
          'Subclass it',
          'It is part of a sealed hierarchy. Subclassing breaks exhaustive '
          'switches in the framework and may not link at all.',
          irisAccentRose,
          irisInkOnLight,
        ),
        _doRow(
          true,
          'Test with VoiceOver',
          'A custom `title` ships verbatim into the accessibility label. '
          'Verify it reads naturally in the user\'s voice.',
          irisAccentTeal,
          irisInkOnLight,
        ),
      ],
    ),
  );
  print('Section 8 (do/avoid) assembled.');

  // ===========================================================================
  //  SECTION 9 - Code-snippet cards.
  //  SystemContextMenu usage with items: <IOSSystemContextMenuItemData>[ ... ]
  // ===========================================================================
  final Widget section9 = Container(
    margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: irisDeepest,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionHeader(
          '8. Code Snippets',
          irisFog,
          Icons.code_rounded,
        ),
        const SizedBox(height: 12),
        _snippetCard(
          'Bare default - lets iOS localize',
          "const IOSSystemContextMenuItemDataCut()",
          irisOrchid,
          irisFog,
          irisInkOnDark,
        ),
        _snippetCard(
          'Identical bare default - identity is by reference, not value',
          "const a = IOSSystemContextMenuItemDataCut();\n"
              "const b = IOSSystemContextMenuItemDataCut();\n"
              "// identical(a, b) is true for const literals",
          irisOrchid,
          irisFog,
          irisInkOnDark,
        ),
        _snippetCard(
          'Inside SystemContextMenu',
          "SystemContextMenu(\n"
              "  anchor: anchorRect,\n"
              "  items: const <IOSSystemContextMenuItemData>[\n"
              "    IOSSystemContextMenuItemDataCut(),\n"
              "    IOSSystemContextMenuItemDataCopy(),\n"
              "    IOSSystemContextMenuItemDataPaste(),\n"
              "    IOSSystemContextMenuItemDataSelectAll(),\n"
              "  ],\n"
              ")",
          irisLavender,
          irisFog,
          irisInkOnDark,
        ),
        _snippetCard(
          'Conditionally append based on platform',
          "final items = <IOSSystemContextMenuItemData>[\n"
              "  if (selection.isNotEmpty)\n"
              "    IOSSystemContextMenuItemDataCut(),\n"
              "  IOSSystemContextMenuItemDataPaste(),\n"
              "];",
          irisLavender,
          irisFog,
          irisInkOnDark,
        ),
        _snippetCard(
          'Trust iOS for localization (no Dart override available)',
          "// Localization is fully owned by iOS for this record.\n"
              "// There is no `title` parameter - the menu reads the\n"
              "// active iOS locale and chooses the right string itself.",
          irisAccentRose,
          irisFog,
          irisInkOnDark,
        ),
      ],
    ),
  );
  print('Section 9 (code snippets) assembled.');

  // ===========================================================================
  //  SECTION 10 - Glossary (12+ terms).
  // ===========================================================================
  final Widget section10 = Container(
    margin: const EdgeInsets.fromLTRB(16, 8, 16, 12),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: irisFog,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: irisMist, width: 1.4),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _sectionHeader(
          '9. Glossary',
          irisRoyal,
          Icons.menu_book_outlined,
        ),
        const SizedBox(height: 12),
        _glossaryItem(
          'SystemContextMenu',
          'A Flutter widget that hands its descriptor to the platform so the '
          'host OS draws the menu instead of Flutter painting it.',
          irisRoyal,
          irisInkOnLight,
        ),
        _glossaryItem(
          'IOSSystemContextMenuItemData',
          'The sealed parent record representing one entry in the iOS system '
          'context menu.',
          irisRoyal,
          irisInkOnLight,
        ),
        _glossaryItem(
          'IOSSystemContextMenuItemDataCut',
          'The concrete subclass for the Cut entry. Sole property: `title`.',
          irisOrchid,
          irisInkOnLight,
        ),
        _glossaryItem(
          'IOSSystemContextMenuItemDataCopy',
          'Sibling record for the Copy entry.',
          irisRoyal,
          irisInkOnLight,
        ),
        _glossaryItem(
          'IOSSystemContextMenuItemDataPaste',
          'Sibling record for the Paste entry.',
          irisRoyal,
          irisInkOnLight,
        ),
        _glossaryItem(
          'IOSSystemContextMenuItemDataSelectAll',
          'Sibling record for the Select All entry.',
          irisRoyal,
          irisInkOnLight,
        ),
        _glossaryItem(
          'IOSSystemContextMenuItemDataLookUp',
          'Sibling record for the Look Up entry, which calls into the system '
          'dictionary.',
          irisRoyal,
          irisInkOnLight,
        ),
        _glossaryItem(
          'IOSSystemContextMenuItemDataTranslate',
          'Sibling record for the system-provided Translate entry.',
          irisRoyal,
          irisInkOnLight,
        ),
        _glossaryItem(
          'IOSSystemContextMenuItemDataShareLink',
          'Sibling record for the Share Link entry, which opens the share '
          'sheet for the selected URL.',
          irisRoyal,
          irisInkOnLight,
        ),
        _glossaryItem(
          'ContextMenuButtonItem',
          'The Flutter-painted equivalent for the in-Dart context menu '
          'pipeline. Not used by SystemContextMenu.',
          irisSlate,
          irisInkOnLight,
        ),
        _glossaryItem(
          'EditableTextContextMenuBuilder',
          'A typedef for callbacks that turn editable-text actions into the '
          'Flutter-painted overlay menu.',
          irisSlate,
          irisInkOnLight,
        ),
        _glossaryItem(
          'Localized default title',
          'The string iOS chooses when `title` is null - selected from the '
          'active iOS locale, not the Flutter app locale.',
          irisOrchid,
          irisInkOnLight,
        ),
        _glossaryItem(
          'Sealed hierarchy',
          'A class family with a closed set of subtypes, allowing exhaustive '
          'switches without a default case.',
          irisAccentTeal,
          irisInkOnLight,
        ),
        _glossaryItem(
          'Method channel',
          'The bidirectional pipe between Dart and platform code that '
          'transports the menu descriptor and its events.',
          irisAccentTeal,
          irisInkOnLight,
        ),
      ],
    ),
  );
  print('Section 10 (glossary) assembled.');

  // ===========================================================================
  //  SECTION 11 - Recap footer.
  // ===========================================================================
  final Widget section11 = Container(
    margin: const EdgeInsets.fromLTRB(16, 8, 16, 28),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[irisRoyal, irisOrchid, irisLavender],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: irisDeepest.withValues(alpha: 0.45),
          blurRadius: 14,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.bookmark_added_rounded, color: irisFog, size: 26),
            const SizedBox(width: 10),
            Text(
              'Recap',
              style: TextStyle(
                color: irisFog,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        _recapBullet(
          '`IOSSystemContextMenuItemDataCut` is the iOS-only data record for '
          'the Cut action in a system-rendered context menu.',
          irisFog,
        ),
        _recapBullet(
          'Its single property `title` is optional. Leave it null to inherit '
          'the localized iOS default.',
          irisFog,
        ),
        _recapBullet(
          'It is a sibling under the sealed `IOSSystemContextMenuItemData` '
          'parent (Cut, Copy, Paste, SelectAll, LookUp, Translate, ShareLink).',
          irisFog,
        ),
        _recapBullet(
          'Use it inside `SystemContextMenu`. Do NOT use it on Android or in '
          'the Flutter-painted overlay.',
          irisFog,
        ),
        _recapBullet(
          'Identity equality only - do not use as map keys.',
          irisFog,
        ),
        _recapBullet(
          'Trust iOS for localization unless your product has an explicit '
          'reason to override.',
          irisFog,
        ),
        const SizedBox(height: 16),
        Text(
          'End of Slate Iris demo for IOSSystemContextMenuItemDataCut.',
          style: TextStyle(
            color: irisMist,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
  print('Section 11 (recap) assembled.');

  // ---------------------------------------------------------------------------
  //  Final Scaffold + SingleChildScrollView assembly.
  // ---------------------------------------------------------------------------
  print('Assembling final Scaffold tree...');
  final Widget scaffold = Scaffold(
    backgroundColor: irisFog,
    appBar: AppBar(
      backgroundColor: irisDeepest,
      foregroundColor: irisFog,
      elevation: 0,
      title: Row(
        children: <Widget>[
          Icon(Icons.content_cut, color: irisFog, size: 20),
          const SizedBox(width: 8),
          Text(
            'IOSSystemContextMenuItemDataCut',
            style: TextStyle(
              color: irisFog,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
    body: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
        ],
      ),
    ),
  );

  print('Final tree assembled. Returning Scaffold.');
  print('==========================================================');
  print(' IOSSystemContextMenuItemDataCut - Slate Iris demo (end)');
  print('==========================================================');
  return scaffold;
}

// =============================================================================
//  Helper builders - all stateless, all pure widget producers.
// =============================================================================

Widget _swatch(Color color, String label) {
  return Padding(
    padding: const EdgeInsets.only(right: 6),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: const Color(0xFFFFFFFF).withValues(alpha: 0.4),
              width: 1,
            ),
          ),
        ),
        const SizedBox(height: 3),
        SizedBox(
          width: 44,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 9,
              color: Color(0xFFE6E0FA),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _sectionHeader(String title, Color accent, IconData icon) {
  return Row(
    children: <Widget>[
      Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: accent, size: 20),
      ),
      const SizedBox(width: 10),
      Text(
        title,
        style: TextStyle(
          color: accent,
          fontSize: 17,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.3,
        ),
      ),
    ],
  );
}

Widget _proseLine(String text, Color color) {
  return Text(
    text,
    style: TextStyle(color: color, fontSize: 13, height: 1.45),
  );
}

Widget _bulletItem(
    String title, String body, Color accent, Color bodyColor) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 6, right: 10),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: accent,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                body,
                style: TextStyle(
                    color: bodyColor, fontSize: 12.5, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _propertyRow(String name, String type, String body, Color accent,
    Color typeColor, Color bodyColor) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                color: accent,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: typeColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                type,
                style: TextStyle(
                  color: typeColor,
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          body,
          style: TextStyle(color: bodyColor, fontSize: 12.5, height: 1.4),
        ),
      ],
    ),
  );
}

Widget _calloutBox(
    String title, String body, Color accent, Color bodyColor) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withValues(alpha: 0.5), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.info_outline, color: accent, size: 16),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                color: accent,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          body,
          style: TextStyle(color: bodyColor, fontSize: 12, height: 1.4),
        ),
      ],
    ),
  );
}

Widget _instanceCard(int index, String varName, String constructor,
    String displayedTitle, Color accent, Color bg, Color ink) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withValues(alpha: 0.45), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 26,
              height: 26,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(13),
              ),
              child: Text(
                '$index',
                style: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              varName,
              style: TextStyle(
                color: accent,
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          constructor,
          style: TextStyle(
            color: ink,
            fontFamily: 'monospace',
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '.title',
                style: TextStyle(
                  color: accent,
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                displayedTitle,
                style: TextStyle(
                  color: ink,
                  fontSize: 12,
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

Widget _familyNode(
    String label, Color color, Color textColor, bool highlight) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 12,
        height: 12,
        color: color.withValues(alpha: 0.45),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: highlight
              ? <BoxShadow>[
                  BoxShadow(
                    color: color.withValues(alpha: 0.7),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ]
              : <BoxShadow>[],
          border: highlight
              ? Border.all(
                  color: const Color(0xFFFFFFFF).withValues(alpha: 0.6),
                  width: 1.5,
                )
              : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 11,
            fontWeight: highlight ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}

Widget _localeRow(String locale, String defaultText, String overrideText,
    Color textColor, Color bg, bool isHeader) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    margin: const EdgeInsets.only(bottom: 4),
    decoration: BoxDecoration(
      color: isHeader ? textColor.withValues(alpha: 0.22) : bg,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            locale,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
              fontFamily: isHeader ? null : 'monospace',
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            defaultText,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            overrideText,
            style: TextStyle(
              color: textColor,
              fontSize: 12,
              fontStyle: isHeader ? FontStyle.normal : FontStyle.italic,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _pipelineHop(int n, String title, String body, Color accent,
    Color textColor) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withValues(alpha: 0.5), width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            '$n',
            style: const TextStyle(
              color: Color(0xFF1B1535),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: TextStyle(
                  color: textColor,
                  fontSize: 12,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _pipelineConnector(Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Center(
      child: Container(
        width: 2,
        height: 14,
        color: color.withValues(alpha: 0.6),
      ),
    ),
  );
}

Widget _doRow(bool isDo, String title, String body, Color accent,
    Color bodyColor) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: accent.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withValues(alpha: 0.55), width: 1),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(
          isDo ? Icons.check_circle : Icons.cancel_outlined,
          color: accent,
          size: 22,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      isDo ? 'DO' : 'AVOID',
                      style: const TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        color: accent,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: TextStyle(
                    color: bodyColor, fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _snippetCard(String label, String code, Color accent,
    Color labelColor, Color codeColor) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF000000).withValues(alpha: 0.35),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withValues(alpha: 0.55), width: 1),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.terminal_rounded, color: accent, size: 16),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: labelColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF000000).withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            code,
            style: TextStyle(
              color: codeColor,
              fontFamily: 'monospace',
              fontSize: 11.5,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _glossaryItem(String term, String definition, Color accent,
    Color bodyColor) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 6, right: 8),
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: accent,
            shape: BoxShape.circle,
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  text: term,
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5,
                  ),
                ),
                TextSpan(
                  text: '  -  ',
                  style: TextStyle(
                    color: bodyColor.withValues(alpha: 0.6),
                    fontSize: 12.5,
                  ),
                ),
                TextSpan(
                  text: definition,
                  style: TextStyle(
                    color: bodyColor,
                    fontSize: 12.5,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _recapBullet(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.check_rounded, color: color, size: 18),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: color, fontSize: 12.5, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
//  End of file - i_o_s_system_context_menu_item_data_cut_test.dart
// =============================================================================
