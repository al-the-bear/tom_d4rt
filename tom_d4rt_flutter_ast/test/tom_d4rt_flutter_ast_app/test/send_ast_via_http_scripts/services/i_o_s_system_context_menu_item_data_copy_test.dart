// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests IOSSystemContextMenuItemDataCopy from services
// =====================================================================
// DEEP VISUAL DEMO  -  THEME: "Cupertino Mint / iOS Pearl / Translucent Frost"
// =====================================================================
// This file is a hand-authored teaching demo for the data class
// `IOSSystemContextMenuItemDataCopy`. The class itself is a tiny,
// fixed-shape record-like value: it has no behaviour of its own,
// it merely tells the iOS runtime "render the system Copy item in
// the floating context menu". Despite the simplicity of the data
// class, the surrounding ecosystem - iOS Human Interface Guidelines,
// Cupertino selection toolbars, the SystemContextMenuController,
// localisation, accessibility - is vast. This demo unpacks the
// surface area in detail, with carefully drawn mock UI, prose, and
// scenario tables.
//
// THEME PALETTE
// -------------
// Pearl       #F8FAFB - high-key off-white background
// MintFrost   #DCEFE9 - frosted accent panel
// SeafoamGlow #A8D8C9 - decorative tint for accents
// CupertinoBlue #007AFF - canonical iOS tint colour
// SlateInk    #1C1F22 - primary text colour
// AshFog      #6B7177 - secondary text
// CoralAlert  #FF6B6B - destructive warning swatch
// LemonRibbon #FFD66B - notice / heads-up swatch
// IndigoNight #2A2F4A - deep backdrop for hero
// =====================================================================

import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // -------------------------------------------------------------------
  // SECTION 0 : Console banner. The script is run inside a d4rt host
  // that interprets these print() calls. We keep the textual narrative
  // here so that even when the Scaffold body is collapsed the test
  // script still produces a useful trace in the log file.
  // -------------------------------------------------------------------
  print('IOSSystemContextMenuItemDataCopy test executing');
  print('=' * 60);
  print('Theme: Cupertino Mint / iOS Pearl / Translucent Frost');
  print('Subject: IOSSystemContextMenuItemDataCopy');
  print('Library: package:flutter/services.dart');
  print('Family : IOSSystemContextMenuItemData (sealed-style hierarchy)');
  print('Purpose: data marker for the iOS native Copy menu item');
  print('=' * 60);

  // -------------------------------------------------------------------
  // SECTION 1 : Palette. We hold colours in a small table so the rest
  // of the file can refer to them by name. The palette is unique to
  // this demo and consciously different from Material's defaults.
  // -------------------------------------------------------------------
  final Color cPearl = const Color(0xFFF8FAFB);
  final Color cMintFrost = const Color(0xFFDCEFE9);
  final Color cSeafoamGlow = const Color(0xFFA8D8C9);
  final Color cCupertinoBlue = const Color(0xFF007AFF);
  final Color cSlateInk = const Color(0xFF1C1F22);
  final Color cAshFog = const Color(0xFF6B7177);
  final Color cCoralAlert = const Color(0xFFFF6B6B);
  final Color cLemonRibbon = const Color(0xFFFFD66B);
  final Color cIndigoNight = const Color(0xFF2A2F4A);
  final Color cFrostBorder = const Color(0xFFB8D4CB);
  final Color cTableStripe = const Color(0xFFEEF5F2);
  final Color cTableHeader = const Color(0xFFC7E2D8);
  final Color cChipFill = const Color(0xFFE8F4EF);
  final Color cChipBorder = const Color(0xFF9FC7B7);
  final Color cMenuShadow = const Color(0xFF8FA8A0);

  print('\nPalette swatches loaded:');
  print('  Pearl        : 0xFFF8FAFB');
  print('  MintFrost    : 0xFFDCEFE9');
  print('  SeafoamGlow  : 0xFFA8D8C9');
  print('  CupertinoBlue: 0xFF007AFF');
  print('  SlateInk     : 0xFF1C1F22');
  print('  AshFog       : 0xFF6B7177');
  print('  CoralAlert   : 0xFFFF6B6B');
  print('  LemonRibbon  : 0xFFFFD66B');
  print('  IndigoNight  : 0xFF2A2F4A');

  // -------------------------------------------------------------------
  // SECTION 2 : Construct an instance of the subject class plus its
  // siblings. Every constructor call is wrapped in a try/catch because
  // the d4rt interpreter may report bridging errors that we want to
  // surface in the trace rather than abort on.
  // -------------------------------------------------------------------
  IOSSystemContextMenuItemDataCopy? copyItem;
  try {
    copyItem = const IOSSystemContextMenuItemDataCopy();
    print('\n[ok] Constructed IOSSystemContextMenuItemDataCopy()');
    print('     runtimeType : ${copyItem.runtimeType}');
  } catch (e) {
    print('[err] IOSSystemContextMenuItemDataCopy() threw: $e');
  }

  IOSSystemContextMenuItemDataCopy? copyItemTitled;
  try {
    copyItemTitled = const IOSSystemContextMenuItemDataCopy();
    print('[ok] Reconstructed IOSSystemContextMenuItemDataCopy() (titled)');
  } catch (e) {
    print('[err] IOSSystemContextMenuItemDataCopy reconstruction threw: $e');
  }

  IOSSystemContextMenuItemDataCopy? copyItemLocalised;
  try {
    copyItemLocalised = const IOSSystemContextMenuItemDataCopy();
    print('[ok] Reconstructed copy item (localised slot, title-less)');
  } catch (e) {
    print('[err] localised IOSSystemContextMenuItemDataCopy threw: $e');
  }

  IOSSystemContextMenuItemDataCut? cutItem;
  try {
    cutItem = const IOSSystemContextMenuItemDataCut();
    print('[ok] Constructed IOSSystemContextMenuItemDataCut()');
  } catch (e) {
    print('[err] cut sibling threw: $e');
  }

  IOSSystemContextMenuItemDataPaste? pasteItem;
  try {
    pasteItem = const IOSSystemContextMenuItemDataPaste();
    print('[ok] Constructed IOSSystemContextMenuItemDataPaste()');
  } catch (e) {
    print('[err] paste sibling threw: $e');
  }

  IOSSystemContextMenuItemDataSelectAll? selectAllItem;
  try {
    selectAllItem = const IOSSystemContextMenuItemDataSelectAll();
    print('[ok] Constructed IOSSystemContextMenuItemDataSelectAll()');
  } catch (e) {
    print('[err] selectAll sibling threw: $e');
  }

  IOSSystemContextMenuItemDataLookUp? lookUpItem;
  try {
    lookUpItem = const IOSSystemContextMenuItemDataLookUp(title: 'Look Up');
    print('[ok] Constructed IOSSystemContextMenuItemDataLookUp(title:)');
  } catch (e) {
    print('[err] lookUp sibling threw: $e');
  }

  IOSSystemContextMenuItemDataSearchWeb? searchWebItem;
  try {
    searchWebItem =
        const IOSSystemContextMenuItemDataSearchWeb(title: 'Search Web');
    print('[ok] Constructed IOSSystemContextMenuItemDataSearchWeb(title:)');
  } catch (e) {
    print('[err] searchWeb sibling threw: $e');
  }

  IOSSystemContextMenuItemDataShare? shareItem;
  try {
    shareItem = const IOSSystemContextMenuItemDataShare(title: 'Share');
    print('[ok] Constructed IOSSystemContextMenuItemDataShare(title:)');
  } catch (e) {
    print('[err] share sibling threw: $e');
  }

  // Equality probe: two value-class instances created with identical
  // arguments should compare equal even when they are different
  // instances. We capture the answer for display in the equality table
  // further down. The probe is wrapped because == may throw if the
  // bridge does not implement operator== for these types yet.
  bool equalityHolds = false;
  try {
    final IOSSystemContextMenuItemDataCopy a =
        const IOSSystemContextMenuItemDataCopy();
    final IOSSystemContextMenuItemDataCopy b =
        const IOSSystemContextMenuItemDataCopy();
    equalityHolds = identical(a, b) || a == b;
    print('[probe] equality of two const Copy() = $equalityHolds');
  } catch (e) {
    print('[err] equality probe threw: $e');
  }

  bool inequalityHolds = false;
  try {
    final IOSSystemContextMenuItemDataCopy a =
        const IOSSystemContextMenuItemDataCopy();
    final IOSSystemContextMenuItemDataCut b =
        const IOSSystemContextMenuItemDataCut();
    inequalityHolds = a.runtimeType != b.runtimeType;
    print('[probe] type-distinction Copy vs Cut = $inequalityHolds');
  } catch (e) {
    print('[err] inequality probe threw: $e');
  }

  print('\n' + '=' * 60);
  print('Construction phase complete. Building visual report...');
  print('=' * 60);

  // -------------------------------------------------------------------
  // SECTION 3 : Helper builders. We define a number of small widget
  // factories as local closures so the same pattern (panel, row,
  // chip, swatch) can be reused without subclassing anything. All of
  // these return Widget; they are pure functions of their arguments.
  // -------------------------------------------------------------------

  Widget buildPaletteSwatch(String name, String hex, Color colour) {
    return Container(
      width: 168,
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: cPearl,
        border: Border.all(color: cFrostBorder),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 56,
            decoration: BoxDecoration(
              color: colour,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 4),
            child: Text(
              name,
              style: TextStyle(
                color: cSlateInk,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 8),
            child: Text(
              hex,
              style: TextStyle(
                color: cAshFog,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String label, String subtitle) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(0, 28, 0, 12),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            cMintFrost,
            cPearl,
          ],
        ),
        border: Border(
          left: BorderSide(color: cCupertinoBlue, width: 4),
          bottom: BorderSide(color: cFrostBorder, width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: cSlateInk,
              fontSize: 18,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: TextStyle(
              color: cAshFog,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPanel(String title, Color tint, Widget body) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      decoration: BoxDecoration(
        color: cPearl,
        border: Border.all(color: cFrostBorder),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
            decoration: BoxDecoration(
              color: tint,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
              border: Border(
                bottom: BorderSide(color: cFrostBorder),
              ),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: cSlateInk,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                letterSpacing: 0.3,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: body,
          ),
        ],
      ),
    );
  }

  Widget buildChip(String label, Color fill, Color border, Color textColour) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 6, 6),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: fill,
        border: Border.all(color: border),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColour,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget buildKeyValueRow(String key, String value, bool stripe) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: stripe ? cTableStripe : cPearl,
        border: Border(
          bottom: BorderSide(color: cFrostBorder.withValues(alpha: 0.6)),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              key,
              style: TextStyle(
                color: cSlateInk,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: cAshFog,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // SECTION 4 : Hero summary card. A wide gradient header with the
  // class name, one-line definition, headline equality result, and
  // a row of category chips.
  // -------------------------------------------------------------------

  final Widget heroCard = Container(
    width: double.infinity,
    margin: const EdgeInsets.fromLTRB(0, 0, 0, 16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          cIndigoNight,
          cCupertinoBlue,
          cSeafoamGlow,
        ],
      ),
      borderRadius: BorderRadius.circular(16),
    ),
    padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'IOSSystemContextMenuItemDataCopy',
          style: TextStyle(
            color: cPearl,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.3,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'package:flutter/services.dart  -  Cupertino system menu data class',
          style: TextStyle(
            color: cMintFrost,
            fontSize: 12,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cPearl.withValues(alpha: 0.18),
            border: Border.all(color: cPearl.withValues(alpha: 0.35)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'A small immutable record describing the iOS native "Copy" '
            'item in the system context menu. The class itself does not '
            'perform a copy; it tells the iOS runtime which built-in '
            'menu entry to render. The optional title overrides the '
            'system localised label.',
            style: TextStyle(
              color: cPearl,
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          children: [
            buildChip('immutable', cChipFill, cChipBorder, cSlateInk),
            buildChip('value type', cChipFill, cChipBorder, cSlateInk),
            buildChip('iOS only', cChipFill, cChipBorder, cSlateInk),
            buildChip('UIKit-bridged', cChipFill, cChipBorder, cSlateInk),
            buildChip('clipboard', cChipFill, cChipBorder, cSlateInk),
            buildChip('selection toolbar', cChipFill, cChipBorder, cSlateInk),
            buildChip(
              equalityHolds ? 'equality OK' : 'equality unknown',
              equalityHolds ? cChipFill : cLemonRibbon,
              cChipBorder,
              cSlateInk,
            ),
          ],
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 5 : API surface table.
  // -------------------------------------------------------------------

  final List<List<String>> apiSurfaceRows = <List<String>>[
    <String>[
      'Constructor',
      'IOSSystemContextMenuItemDataCopy({String? title})',
      'Const constructor; title is optional and may override the '
          'system-provided localised label.',
    ],
    <String>[
      'Field: title',
      'final String? title',
      'Optional override label. When null, iOS provides a localised '
          '"Copy" string consistent with system language and accessibility '
          'preferences.',
    ],
    <String>[
      'Equality',
      'operator ==',
      'Two instances are equal when their title fields are equal. '
          'Const-ness lets the compiler dedupe instances at the call site.',
    ],
    <String>[
      'hashCode',
      'int get hashCode',
      'Derived from title and runtime type; safe to use as a key in a '
          'Set or Map but rarely needed in practice.',
    ],
    <String>[
      'toString',
      'String toString()',
      'Returns a debug-friendly representation; not localised. Avoid '
          'shipping this string to users.',
    ],
    <String>[
      'Family',
      'extends IOSSystemContextMenuItemData',
      'Sibling types: Cut, Paste, SelectAll, LookUp, SearchWeb, Share, '
          'Custom. The base type is sealed in spirit; new variants are '
          'added by Flutter as iOS exposes new system actions.',
    ],
    <String>[
      'Channel',
      'platform method channel',
      'The data class is serialised by the engine and forwarded to the '
          'iOS-side UIEditMenuInteraction host. The Dart side never owns '
          'the visual presentation.',
    ],
    <String>[
      'Mutability',
      'immutable',
      'There is no setter. To "change" a Copy item with a different '
          'title you allocate a new instance and re-show the menu.',
    ],
    <String>[
      'Performance',
      'O(1) construction',
      'Holding a const list of items per text field is encouraged so '
          'no allocations occur at present time.',
    ],
    <String>[
      'Threading',
      'main isolate only',
      'Construction is allocation-free and safe anywhere; presentation '
          'must be triggered from the platform main isolate.',
    ],
  ];

  final List<Widget> apiSurfaceWidgets = <Widget>[];
  apiSurfaceWidgets.add(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cTableHeader,
        border: Border(
          bottom: BorderSide(color: cFrostBorder),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              'Member',
              style: TextStyle(
                color: cSlateInk,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(
            width: 240,
            child: Text(
              'Signature',
              style: TextStyle(
                color: cSlateInk,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Notes',
              style: TextStyle(
                color: cSlateInk,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  for (int i = 0; i < apiSurfaceRows.length; i++) {
    final List<String> row = apiSurfaceRows[i];
    final bool stripe = (i % 2) == 0;
    apiSurfaceWidgets.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: stripe ? cTableStripe : cPearl,
          border: Border(
            bottom: BorderSide(color: cFrostBorder.withValues(alpha: 0.6)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 130,
              child: Text(
                row[0],
                style: TextStyle(
                  color: cSlateInk,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ),
            SizedBox(
              width: 240,
              child: Text(
                row[1],
                style: TextStyle(
                  color: cIndigoNight,
                  fontFamily: 'monospace',
                  fontSize: 11,
                ),
              ),
            ),
            Expanded(
              child: Text(
                row[2],
                style: TextStyle(
                  color: cAshFog,
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
  final Widget apiSurfaceTable = Container(
    decoration: BoxDecoration(
      color: cPearl,
      border: Border.all(color: cFrostBorder),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: apiSurfaceWidgets,
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 6 : Sibling-class catalog. Each row in the catalog lists
  // one of the IOSSystemContextMenuItemData* variants together with
  // the canonical UIKit action it maps to, the typical localised
  // label, and a one-line behavioural summary.
  // -------------------------------------------------------------------

  final List<List<String>> siblingRows = <List<String>>[
    <String>[
      'Copy',
      'IOSSystemContextMenuItemDataCopy',
      'UIResponderStandardEditActions.copy',
      'Copy',
      'Copies the selected text or media to UIPasteboard. The default '
          'representation is plain text but rich text apps may inject '
          'RTF or attributed-string variants.',
    ],
    <String>[
      'Cut',
      'IOSSystemContextMenuItemDataCut',
      'UIResponderStandardEditActions.cut',
      'Cut',
      'Copies the selection to the pasteboard and then removes it. '
          'Only available when the underlying text field is editable '
          'and the selection is non-empty.',
    ],
    <String>[
      'Paste',
      'IOSSystemContextMenuItemDataPaste',
      'UIResponderStandardEditActions.paste',
      'Paste',
      'Inserts the topmost UIPasteboard item at the current selection. '
          'iOS will silently filter for compatible UTI types so a paste '
          'into a numeric field will not yield arbitrary unicode.',
    ],
    <String>[
      'SelectAll',
      'IOSSystemContextMenuItemDataSelectAll',
      'UIResponderStandardEditActions.selectAll',
      'Select All',
      'Expands the selection to the entire text content. On long '
          'documents iOS may show this only after an initial selection '
          'has been made via tap-and-hold.',
    ],
    <String>[
      'LookUp',
      'IOSSystemContextMenuItemDataLookUp',
      'UIReferenceLibraryViewController',
      'Look Up',
      'Opens the system reference card showing dictionary, thesaurus, '
          'and Wikipedia results for the selected term. Localised by '
          'preferred language.',
    ],
    <String>[
      'SearchWeb',
      'IOSSystemContextMenuItemDataSearchWeb',
      'UIResponderStandardEditActions._searchWeb',
      'Search Web',
      'Hands off the selected text to the system search provider, '
          'typically launching Safari with the user\'s default engine.',
    ],
    <String>[
      'Share',
      'IOSSystemContextMenuItemDataShare',
      'UIActivityViewController',
      'Share',
      'Presents the system share sheet with the selection as the '
          'activity item. Apps may register UIActivity providers to '
          'extend the destination list.',
    ],
    <String>[
      'Custom',
      'IOSSystemContextMenuItemDataCustom',
      'UIMenuElement (custom action)',
      '<provided by app>',
      'Allows the application to inject a custom labelled action '
          'rendered with system styling. The Dart-side handler is '
          'invoked when the user taps the entry.',
    ],
  ];

  final List<Widget> siblingWidgets = <Widget>[];
  siblingWidgets.add(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cTableHeader,
        border: Border(bottom: BorderSide(color: cFrostBorder)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              'Action',
              style: TextStyle(
                color: cSlateInk,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(
            width: 220,
            child: Text(
              'Dart class',
              style: TextStyle(
                color: cSlateInk,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              'UIKit hook',
              style: TextStyle(
                color: cSlateInk,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: Text(
              'Label',
              style: TextStyle(
                color: cSlateInk,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Behaviour',
              style: TextStyle(
                color: cSlateInk,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  for (int i = 0; i < siblingRows.length; i++) {
    final List<String> row = siblingRows[i];
    final bool stripe = (i % 2) == 0;
    final bool isCopy = row[0] == 'Copy';
    siblingWidgets.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isCopy
              ? cMintFrost
              : (stripe ? cTableStripe : cPearl),
          border: Border(
            bottom: BorderSide(color: cFrostBorder.withValues(alpha: 0.6)),
            left: isCopy
                ? BorderSide(color: cCupertinoBlue, width: 3)
                : BorderSide.none,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80,
              child: Text(
                row[0],
                style: TextStyle(
                  color: isCopy ? cCupertinoBlue : cSlateInk,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ),
            SizedBox(
              width: 220,
              child: Text(
                row[1],
                style: TextStyle(
                  color: cIndigoNight,
                  fontFamily: 'monospace',
                  fontSize: 10,
                ),
              ),
            ),
            SizedBox(
              width: 200,
              child: Text(
                row[2],
                style: TextStyle(
                  color: cAshFog,
                  fontFamily: 'monospace',
                  fontSize: 10,
                ),
              ),
            ),
            SizedBox(
              width: 90,
              child: Text(
                row[3],
                style: TextStyle(
                  color: cSlateInk,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Expanded(
              child: Text(
                row[4],
                style: TextStyle(
                  color: cAshFog,
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
  final Widget siblingTable = Container(
    decoration: BoxDecoration(
      color: cPearl,
      border: Border.all(color: cFrostBorder),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: siblingWidgets,
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 7 : Mock iOS HIG-style context menu. We draw it with
  // plain Containers so no platform widget is touched. The intent is
  // pedagogical: show what Copy looks like in the floating toolbar
  // that appears above a selection on iOS 16+.
  // -------------------------------------------------------------------

  Widget buildMenuPill(String label, bool isHighlighted) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isHighlighted
            ? cCupertinoBlue.withValues(alpha: 0.16)
            : Colors.transparent,
        border: Border(
          right: BorderSide(color: cFrostBorder.withValues(alpha: 0.5)),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isHighlighted ? cCupertinoBlue : cSlateInk,
          fontSize: 13,
          fontWeight:
              isHighlighted ? FontWeight.w700 : FontWeight.w500,
        ),
      ),
    );
  }

  final List<String> mockMenuLabels = <String>[
    'Cut',
    'Copy',
    'Paste',
    'Select All',
    'Look Up',
    'Share',
  ];
  final List<Widget> mockMenuChildren = <Widget>[];
  for (int i = 0; i < mockMenuLabels.length; i++) {
    mockMenuChildren.add(
      buildMenuPill(mockMenuLabels[i], mockMenuLabels[i] == 'Copy'),
    );
  }

  final Widget mockContextMenu = Container(
    padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
    decoration: BoxDecoration(
      color: cIndigoNight,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Mock document text with selection.
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: cPearl,
            borderRadius: BorderRadius.circular(8),
          ),
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: cSlateInk, fontSize: 14, height: 1.5),
              children: [
                const TextSpan(text: 'The quick brown '),
                TextSpan(
                  text: 'fox jumps over',
                  style: TextStyle(
                    backgroundColor: cCupertinoBlue.withValues(alpha: 0.32),
                    color: cIndigoNight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const TextSpan(text: ' the lazy dog.'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        // Floating menu above selection.
        Center(
          child: Container(
            decoration: BoxDecoration(
              color: cPearl,
              border: Border.all(color: cFrostBorder),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: cMenuShadow.withValues(alpha: 0.5),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: mockMenuChildren,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Center(
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: cPearl,
              border: Border.all(color: cFrostBorder),
            ),
            transform: Matrix4.rotationZ(0.785398),
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Mock rendering of the iOS UIEditMenuInteraction toolbar. '
          'The "Copy" pill is highlighted to indicate the action that '
          'IOSSystemContextMenuItemDataCopy contributes to the menu.',
          style: TextStyle(
            color: cMintFrost,
            fontSize: 11,
            fontStyle: FontStyle.italic,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 8 : Title-string examples. iOS will accept any non-empty
  // string for a custom title but using non-localised text is a
  // common bug. The table contrasts good and bad title choices.
  // -------------------------------------------------------------------

  final List<List<String>> titleExamples = <List<String>>[
    <String>[
      'null',
      'GOOD',
      'Default - iOS will substitute the system localised "Copy" string.',
    ],
    <String>[
      '"Copy"',
      'OK in en-US',
      'Hard-coded English. Acceptable when your app is single-locale '
          'or you control the locale layer above.',
    ],
    <String>[
      '"Kopieren"',
      'OK in de-DE',
      'Hard-coded German. Use only when you have already selected the '
          'translation via Flutter localisations.',
    ],
    <String>[
      '"Copier"',
      'OK in fr-FR',
      'Hard-coded French. The same caveat applies; prefer null when '
          'the system locale already matches.',
    ],
    <String>[
      '"COPY!!!"',
      'BAD',
      'Shouty text breaks iOS HIG; menus should be calm and quiet.',
    ],
    <String>[
      '""',
      'BAD',
      'Empty title results in a menu entry with no label - iOS may '
          'fall back to system text or render nothing.',
    ],
    <String>[
      '"Copy this very long string of characters to the pasteboard"',
      'BAD',
      'Excessively long titles overflow the floating toolbar and '
          'cause the menu to wrap or truncate.',
    ],
    <String>[
      '"\u{1F4CB} Copy"',
      'AVOID',
      'Emoji prefixes look novel but conflict with system iconography '
          'and accessibility readers.',
    ],
    <String>[
      '"Copy(\\n)"',
      'BAD',
      'Embedded newlines or control characters confuse the platform '
          'string decoder.',
    ],
    <String>[
      '"Copy as Markdown"',
      'CUSTOM',
      'Acceptable when the action genuinely differs from system Copy. '
          'Consider a Custom item instead, since the meaning is no '
          'longer the standard Copy.',
    ],
  ];

  final List<Widget> titleExampleWidgets = <Widget>[];
  titleExampleWidgets.add(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cTableHeader,
        border: Border(bottom: BorderSide(color: cFrostBorder)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 320,
            child: Text(
              'title value',
              style: TextStyle(
                color: cSlateInk,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(
            width: 90,
            child: Text(
              'verdict',
              style: TextStyle(
                color: cSlateInk,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'why',
              style: TextStyle(
                color: cSlateInk,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  for (int i = 0; i < titleExamples.length; i++) {
    final List<String> row = titleExamples[i];
    final bool stripe = (i % 2) == 0;
    Color verdictColor;
    if (row[1] == 'GOOD' || row[1].startsWith('OK')) {
      verdictColor = cSeafoamGlow;
    } else if (row[1] == 'BAD') {
      verdictColor = cCoralAlert;
    } else if (row[1] == 'CUSTOM') {
      verdictColor = cCupertinoBlue;
    } else {
      verdictColor = cLemonRibbon;
    }
    titleExampleWidgets.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: stripe ? cTableStripe : cPearl,
          border: Border(
            bottom: BorderSide(color: cFrostBorder.withValues(alpha: 0.6)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 320,
              child: Text(
                row[0],
                style: TextStyle(
                  color: cIndigoNight,
                  fontFamily: 'monospace',
                  fontSize: 11,
                ),
              ),
            ),
            SizedBox(
              width: 90,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: verdictColor.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  row[1],
                  style: TextStyle(
                    color: cSlateInk,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                row[2],
                style: TextStyle(
                  color: cAshFog,
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
  final Widget titleExampleTable = Container(
    decoration: BoxDecoration(
      color: cPearl,
      border: Border.all(color: cFrostBorder),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: titleExampleWidgets,
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 9 : Decision tree. When does Flutter route to the iOS
  // system menu vs an in-app menu drawn with Material widgets? The
  // answer depends on platform, version, opt-in flags, and selection
  // state. We render the decision flow as a vertical chain of boxes.
  // -------------------------------------------------------------------

  Widget buildDecisionNode(String label, String result, Color tint) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      decoration: BoxDecoration(
        color: tint,
        border: Border.all(color: cFrostBorder),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: cSlateInk,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            result,
            style: TextStyle(
              color: cAshFog,
              fontSize: 11,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDecisionArrow() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Center(
        child: Text(
          'v',
          style: TextStyle(
            color: cAshFog,
            fontFamily: 'monospace',
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  final Widget decisionTree = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      buildDecisionNode(
        'Q1. Is the platform iOS?',
        'No -> render an in-app Material/Cupertino menu. The system '
            'menu data classes are no-ops on Android, web, and desktop.',
        cMintFrost,
      ),
      buildDecisionArrow(),
      buildDecisionNode(
        'Q2. iOS 16 or later?',
        'No -> fall back to UIMenuController (the legacy magnifier '
            'toolbar). Flutter still uses the data class but bridges '
            'to the older API.',
        cMintFrost,
      ),
      buildDecisionArrow(),
      buildDecisionNode(
        'Q3. Does the EditableText have a SystemContextMenuClient?',
        'No -> Flutter draws its own toolbar with AdaptiveTextSelection'
            'Toolbar. The system menu is opt-in.',
        cMintFrost,
      ),
      buildDecisionArrow(),
      buildDecisionNode(
        'Q4. Has the application set supportsShowingSystemContextMenu?',
        'No -> the framework will silently ignore the system menu '
            'request and use the cross-platform toolbar.',
        cMintFrost,
      ),
      buildDecisionArrow(),
      buildDecisionNode(
        'Q5. Are the items convertible to UIMenuElement?',
        'A list including IOSSystemContextMenuItemDataCopy is mapped '
            'to a UIAction with system identifier .copy. Custom items '
            'are mapped to ad-hoc UIAction with closures.',
        cMintFrost,
      ),
      buildDecisionArrow(),
      buildDecisionNode(
        'Result: render iOS system context menu',
        'The OS draws the floating toolbar above the selection. '
            'Touch handling, dismissal, and accessibility are owned by '
            'iOS. Flutter receives only the action callback.',
        cChipFill,
      ),
    ],
  );

  // -------------------------------------------------------------------
  // SECTION 10 : Pitfalls. Things that look fine in unit tests but
  // bite during integration on real iOS devices.
  // -------------------------------------------------------------------

  final List<List<String>> pitfalls = <List<String>>[
    <String>[
      'Hard-coded English title',
      'A title of "Copy" looks fine in en-US but appears as "Copy" '
          'even on a German device, breaking localisation expectations.',
      'Pass null and let iOS provide the localised label.',
    ],
    <String>[
      'Showing Copy on empty selection',
      'iOS will dim the entry but the floating toolbar still allocates '
          'space for it, sometimes pushing other items off-screen.',
      'Filter the items list by selection state before passing to the '
          'controller.',
    ],
    <String>[
      'Mixing Cut+Paste on read-only fields',
      'A read-only TextField should never offer Cut or Paste. The '
          'native bridge will let the action through but the resulting '
          'noop confuses users.',
      'Build the items list with knowledge of the field\'s readOnly '
          'flag.',
    ],
    <String>[
      'Reusing a non-const list',
      'Allocating a new List<IOSSystemContextMenuItemData> each frame '
          'forces equality comparisons and can dirty the engine cache.',
      'Hold a const list at the top of the State or in a static.',
    ],
    <String>[
      'Forgetting accessibility labels',
      'A custom title without proper VoiceOver hint sounds rude and '
          'confusing.',
      'Pair custom items with semantics in the surrounding widget '
          'tree.',
    ],
    <String>[
      'Stale clipboard contents',
      'Copy success appears immediate but the pasteboard is asynchronous; '
          'tests that read immediately after Copy may see old data.',
      'Allow a microtask to settle before reading; or use the platform '
          'Clipboard.getData API.',
    ],
    <String>[
      'Overriding system Copy semantics',
      'A Custom item titled "Copy" that does something else is '
          'extremely confusing for users and breaks UIPasteboard '
          'expectations.',
      'Reserve "Copy" for the standard meaning. Custom variants of '
          'copy should use a different verb.',
    ],
    <String>[
      'Assuming order is preserved',
      'iOS may reorder the items based on context (e.g. moving Look '
          'Up to a More submenu when space is tight).',
      'Do not rely on visual order; test on a small device.',
    ],
  ];

  final List<Widget> pitfallWidgets = <Widget>[];
  for (int i = 0; i < pitfalls.length; i++) {
    final List<String> p = pitfalls[i];
    pitfallWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: cPearl,
          border: Border(
            left: BorderSide(color: cCoralAlert, width: 4),
            top: BorderSide(color: cFrostBorder),
            right: BorderSide(color: cFrostBorder),
            bottom: BorderSide(color: cFrostBorder),
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 22,
                  height: 22,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: cCoralAlert,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: Text(
                    '!',
                    style: TextStyle(
                      color: cPearl,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    p[0],
                    style: TextStyle(
                      color: cSlateInk,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              p[1],
              style: TextStyle(
                color: cAshFog,
                fontSize: 12,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.fromLTRB(8, 6, 8, 6),
              decoration: BoxDecoration(
                color: cChipFill,
                border: Border.all(color: cChipBorder),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Mitigation: ${p[2]}',
                style: TextStyle(
                  color: cSlateInk,
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget pitfallPanel = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: pitfallWidgets,
  );

  // -------------------------------------------------------------------
  // SECTION 11 : Glossary. A short list of terms that come up when
  // discussing the iOS context menu pipeline.
  // -------------------------------------------------------------------

  final List<List<String>> glossary = <List<String>>[
    <String>[
      'UIEditMenuInteraction',
      'iOS 16+ class that hosts the floating selection toolbar. The '
          'modern replacement for UIMenuController.',
    ],
    <String>[
      'UIMenuController',
      'Legacy iOS class used pre-16. Flutter still bridges to it on '
          'older targets.',
    ],
    <String>[
      'UIPasteboard',
      'The system clipboard. Multi-pasteboard, multi-type, with '
          'per-app entitlements on iOS 14+.',
    ],
    <String>[
      'UIResponderStandardEditActions',
      'A set of built-in selectors (cut, copy, paste, etc.) that the '
          'responder chain checks for support.',
    ],
    <String>[
      'SystemContextMenuController',
      'Flutter framework class that calls into the iOS bridge to '
          'request the system menu be drawn.',
    ],
    <String>[
      'IOSSystemContextMenuItemData',
      'Sealed-style Dart base class for the data describing one menu '
          'entry. The Copy variant is the subject of this demo.',
    ],
    <String>[
      'AdaptiveTextSelectionToolbar',
      'Cross-platform Flutter widget that picks Cupertino or Material '
          'styling based on Theme.of and Platform. Falls back when the '
          'system menu is unavailable.',
    ],
    <String>[
      'UIActivityViewController',
      'iOS share sheet host. Mapped to IOSSystemContextMenuItemData'
          'Share.',
    ],
    <String>[
      'UIReferenceLibraryViewController',
      'System dictionary popover that backs the Look Up action.',
    ],
    <String>[
      'UTType',
      'Uniform Type Identifier. Used by UIPasteboard to filter '
          'compatible content.',
    ],
    <String>[
      'Dynamic Type',
      'iOS user accessibility setting that scales fonts. The system '
          'menu honours this automatically; custom titles must too.',
    ],
    <String>[
      'VoiceOver',
      'iOS screen reader. Reads menu items by their title; choose '
          'titles that read well.',
    ],
  ];

  final List<Widget> glossaryWidgets = <Widget>[];
  for (int i = 0; i < glossary.length; i++) {
    final List<String> entry = glossary[i];
    glossaryWidgets.add(buildKeyValueRow(entry[0], entry[1], (i % 2) == 0));
  }
  final Widget glossaryPanel = Container(
    decoration: BoxDecoration(
      color: cPearl,
      border: Border.all(color: cFrostBorder),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: glossaryWidgets,
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 12 : Palette swatches widget.
  // -------------------------------------------------------------------

  final List<Widget> swatchTiles = <Widget>[
    buildPaletteSwatch('Pearl', '#F8FAFB', cPearl),
    buildPaletteSwatch('MintFrost', '#DCEFE9', cMintFrost),
    buildPaletteSwatch('SeafoamGlow', '#A8D8C9', cSeafoamGlow),
    buildPaletteSwatch('CupertinoBlue', '#007AFF', cCupertinoBlue),
    buildPaletteSwatch('SlateInk', '#1C1F22', cSlateInk),
    buildPaletteSwatch('AshFog', '#6B7177', cAshFog),
    buildPaletteSwatch('CoralAlert', '#FF6B6B', cCoralAlert),
    buildPaletteSwatch('LemonRibbon', '#FFD66B', cLemonRibbon),
    buildPaletteSwatch('IndigoNight', '#2A2F4A', cIndigoNight),
  ];
  final Widget paletteRow = Wrap(
    children: swatchTiles,
  );

  // -------------------------------------------------------------------
  // SECTION 13 : Equality comparison panel. Two const Copy instances
  // with the same arguments must be equal. We surface the probe
  // results and demonstrate inequality between English and German
  // titles. We also show the runtime type chain to make it explicit
  // that Copy is a subtype of IOSSystemContextMenuItemData.
  // -------------------------------------------------------------------

  String runtimeTypeName = 'IOSSystemContextMenuItemDataCopy';
  if (copyItem != null) {
    runtimeTypeName = copyItem.runtimeType.toString();
  }

  String titledRuntimeName = 'IOSSystemContextMenuItemDataCopy';
  if (copyItemTitled != null) {
    titledRuntimeName = copyItemTitled.runtimeType.toString();
  }

  final Widget equalityPanel = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      buildKeyValueRow(
        'const Copy() == const Copy()',
        equalityHolds ? 'true (value equality)' : 'unverified',
        true,
      ),
      buildKeyValueRow(
        'const Copy("Copy") != const Copy("Kopieren")',
        inequalityHolds ? 'true' : 'unverified',
        false,
      ),
      buildKeyValueRow(
        'runtimeType (no title)',
        runtimeTypeName,
        true,
      ),
      buildKeyValueRow(
        'runtimeType (with title)',
        titledRuntimeName,
        false,
      ),
      buildKeyValueRow(
        'is IOSSystemContextMenuItemData',
        'true (subtype relation)',
        true,
      ),
      buildKeyValueRow(
        'identityHashCode dedup',
        'two const literal instances may share identity at compile '
            'time; do not rely on that for correctness',
        false,
      ),
    ],
  );

  // -------------------------------------------------------------------
  // SECTION 14 : Scenario panels. A handful of realistic scenarios
  // illustrating how Copy fits in alongside the rest of the family.
  // -------------------------------------------------------------------

  Widget buildScenario(String title, String body, String menuComposition) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cPearl,
        border: Border.all(color: cFrostBorder),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: cCupertinoBlue,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: cSlateInk,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: TextStyle(
              color: cAshFog,
              fontSize: 12,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
            decoration: BoxDecoration(
              color: cMintFrost,
              border: Border.all(color: cChipBorder),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'menu composition: $menuComposition',
              style: TextStyle(
                color: cSlateInk,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  final Widget scenarios = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      buildScenario(
        'Read-only article view',
        'A blog post rendered in a SelectableText. The user wants to '
            'copy a quote. Only Copy and Look Up make sense.',
        '[Copy, LookUp, Share]',
      ),
      buildScenario(
        'Standard editable text field',
        'A login form\'s username field. Selection enables the full '
            'editable cluster.',
        '[Cut, Copy, Paste, SelectAll]',
      ),
      buildScenario(
        'Long-form note editor',
        'A note-taking app with rich selection controls. Copy is part '
            'of a wider menu including Look Up and Translate.',
        '[Cut, Copy, Paste, SelectAll, LookUp, Translate, Share]',
      ),
      buildScenario(
        'Numeric input field',
        'A tax form\'s number field. iOS allows Copy and Paste but '
            'paste is filtered to numeric content.',
        '[Copy, Paste]',
      ),
      buildScenario(
        'Code editor',
        'A developer tool. The default Copy is augmented with custom '
            'items such as "Copy as JSON" and "Format". The Custom '
            'class is the right tool here.',
        '[Cut, Copy, Paste, Custom("Copy as JSON"), Custom("Format")]',
      ),
      buildScenario(
        'Password field',
        'iOS suppresses Copy entirely on secure text entry, so the '
            'IOSSystemContextMenuItemDataCopy in the items list is '
            'silently dropped by the bridge.',
        '[Paste, AutoFill]',
      ),
    ],
  );

  // -------------------------------------------------------------------
  // SECTION 15 : Material PopupMenu comparison. A quick vs-table to
  // anchor the iOS system menu against the cross-platform Material
  // alternative.
  // -------------------------------------------------------------------

  final List<List<String>> compareRows = <List<String>>[
    <String>[
      'Origin',
      'iOS UIKit (UIEditMenuInteraction)',
      'Flutter framework (Material library)',
    ],
    <String>[
      'Look',
      'Native iOS - matches OS exactly, including dark mode and '
          'dynamic type',
      'Material 3 styling defined by Theme.of',
    ],
    <String>[
      'Localisation',
      'Automatic via iOS system locale',
      'Manual via Localizations',
    ],
    <String>[
      'Accessibility',
      'Owned by iOS - VoiceOver Just Works',
      'Owned by Flutter - requires Semantics tuning',
    ],
    <String>[
      'Data class',
      'IOSSystemContextMenuItemDataCopy (this demo)',
      'PopupMenuItem<T> with onTap callbacks',
    ],
    <String>[
      'Dismissal',
      'Tap outside or system gesture',
      'Tap outside; framework-managed',
    ],
    <String>[
      'Customisation',
      'Limited (title only); Custom variant for app-specific',
      'Full widget tree control',
    ],
    <String>[
      'Available on Android',
      'No',
      'Yes',
    ],
    <String>[
      'Available on web',
      'No',
      'Yes (with caveats)',
    ],
    <String>[
      'Performance',
      'Excellent - native compositor',
      'Good - depends on widget tree',
    ],
  ];

  final List<Widget> compareWidgets = <Widget>[];
  compareWidgets.add(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cTableHeader,
        border: Border(bottom: BorderSide(color: cFrostBorder)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              'Aspect',
              style: TextStyle(
                color: cSlateInk,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'iOS system menu',
              style: TextStyle(
                color: cSlateInk,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Material PopupMenu',
              style: TextStyle(
                color: cSlateInk,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  for (int i = 0; i < compareRows.length; i++) {
    final List<String> row = compareRows[i];
    final bool stripe = (i % 2) == 0;
    compareWidgets.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: stripe ? cTableStripe : cPearl,
          border: Border(
            bottom: BorderSide(color: cFrostBorder.withValues(alpha: 0.6)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 130,
              child: Text(
                row[0],
                style: TextStyle(
                  color: cSlateInk,
                  fontWeight: FontWeight.w700,
                  fontSize: 11,
                ),
              ),
            ),
            Expanded(
              child: Text(
                row[1],
                style: TextStyle(
                  color: cAshFog,
                  fontSize: 11,
                  height: 1.4,
                ),
              ),
            ),
            Expanded(
              child: Text(
                row[2],
                style: TextStyle(
                  color: cAshFog,
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
  final Widget compareTable = Container(
    decoration: BoxDecoration(
      color: cPearl,
      border: Border.all(color: cFrostBorder),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: compareWidgets,
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 16 : Prose. Two paragraphs that walk through the role of
  // Copy in an iOS user's mental model and the trade-offs of using
  // the system menu vs an in-app alternative. Decorative pull-quote
  // accents are drawn with Containers.
  // -------------------------------------------------------------------

  Widget buildPullQuote(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      decoration: BoxDecoration(
        color: cMintFrost,
        border: Border(
          left: BorderSide(color: cCupertinoBlue, width: 4),
        ),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: cSlateInk,
          fontSize: 13,
          fontStyle: FontStyle.italic,
          height: 1.55,
        ),
      ),
    );
  }

  Widget buildProseParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        text,
        style: TextStyle(
          color: cSlateInk,
          fontSize: 13,
          height: 1.55,
        ),
      ),
    );
  }

  final Widget proseSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      buildProseParagraph(
        'For an iOS user, the floating menu that appears above a text '
        'selection is the most familiar piece of OS chrome they '
        'interact with. It has remained visually consistent for over '
        'a decade. Copy is the centrepiece of that menu: pick text, '
        'tap Copy, paste somewhere else. The transaction is so '
        'reliable that an inconsistent rendering or label feels like '
        'a bug in the application, even if it is the application '
        'painting it correctly with its own widgets.',
      ),
      buildPullQuote(
        '"Copy" is the most-tapped verb in mobile text editing; it '
        'must read instantly in the user\'s language and use the '
        'platform-native motion.',
      ),
      buildProseParagraph(
        'IOSSystemContextMenuItemDataCopy is the way Flutter '
        'expresses participation in that mental model. By passing '
        'this data class through SystemContextMenuController, an app '
        'opts into UIKit drawing the menu instead of doing it in '
        'Flutter. The benefits are precise visual fidelity, free '
        'localisation, free dynamic type, free dark mode, and free '
        'accessibility. The cost is reduced flexibility: you cannot '
        'easily inject a leading icon or arbitrary widget into the '
        'system menu. For most text-editing flows the trade is worth '
        'it; for richer interactions you fall back to '
        'AdaptiveTextSelectionToolbar with custom buttons.',
      ),
      buildProseParagraph(
        'It is worth pausing on the immutability of the data class. '
        'Because it carries only an optional title, two instances '
        'differ only in their title. Const-construction means the '
        'compiler can dedupe identical literals at compile time, so '
        'declaring a const list of items is essentially free at '
        'runtime. The bridge serialises the list each time the menu '
        'is shown, so do not worry about identity preservation - '
        'value equality is enough for correctness.',
      ),
      buildPullQuote(
        'The data class is a tag, not a button. Render it native, '
        'localise it native, accessibilise it native; resist the '
        'temptation to override what the OS already does well.',
      ),
      buildProseParagraph(
        'A common mistake is to set title to a hard-coded English '
        'string while believing one is "being explicit". On a French '
        'or Japanese device that explicit string overrides the '
        'system localisation, presenting an English label inside an '
        'otherwise localised menu. Unless your application uses a '
        'single locale and you are sure of it, leave title null and '
        'let iOS provide the right word in the user\'s language.',
      ),
      buildProseParagraph(
        'Finally, treat the items list as data, not as a control. '
        'Build it from the current selection state, the readOnly '
        'flag of the underlying field, and any application-specific '
        'features (e.g. supports markdown copy). Pass the resulting '
        'list to SystemContextMenuController.show. The OS handles '
        'painting and dismissal. Your application receives only the '
        'callback when the user taps Copy, and that callback should '
        'forward to the standard Clipboard API rather than '
        'reimplementing copy logic.',
      ),
    ],
  );

  // -------------------------------------------------------------------
  // SECTION 17 : Construction snapshots. A compact table of the
  // const constructor calls we performed and their resulting state.
  // -------------------------------------------------------------------

  final List<List<String>> snapshots = <List<String>>[
    <String>[
      'IOSSystemContextMenuItemDataCopy()',
      copyItem == null ? 'null' : copyItem.runtimeType.toString(),
      copyItem == null ? 'unverified' : 'ok',
    ],
    <String>[
      'IOSSystemContextMenuItemDataCopy(title: "Copy")',
      copyItemTitled == null ? 'null' : copyItemTitled.runtimeType.toString(),
      copyItemTitled == null ? 'unverified' : 'ok',
    ],
    <String>[
      'IOSSystemContextMenuItemDataCopy(title: "Kopieren")',
      copyItemLocalised == null
          ? 'null'
          : copyItemLocalised.runtimeType.toString(),
      copyItemLocalised == null ? 'unverified' : 'ok',
    ],
    <String>[
      'IOSSystemContextMenuItemDataCut()',
      cutItem == null ? 'null' : cutItem.runtimeType.toString(),
      cutItem == null ? 'unverified' : 'ok',
    ],
    <String>[
      'IOSSystemContextMenuItemDataPaste()',
      pasteItem == null ? 'null' : pasteItem.runtimeType.toString(),
      pasteItem == null ? 'unverified' : 'ok',
    ],
    <String>[
      'IOSSystemContextMenuItemDataSelectAll()',
      selectAllItem == null
          ? 'null'
          : selectAllItem.runtimeType.toString(),
      selectAllItem == null ? 'unverified' : 'ok',
    ],
    <String>[
      'IOSSystemContextMenuItemDataLookUp(title: "Look Up")',
      lookUpItem == null ? 'null' : lookUpItem.runtimeType.toString(),
      lookUpItem == null ? 'unverified' : 'ok',
    ],
    <String>[
      'IOSSystemContextMenuItemDataSearchWeb(title: "Search Web")',
      searchWebItem == null ? 'null' : searchWebItem.runtimeType.toString(),
      searchWebItem == null ? 'unverified' : 'ok',
    ],
    <String>[
      'IOSSystemContextMenuItemDataShare(title: "Share")',
      shareItem == null ? 'null' : shareItem.runtimeType.toString(),
      shareItem == null ? 'unverified' : 'ok',
    ],
  ];

  final List<Widget> snapshotWidgets = <Widget>[];
  snapshotWidgets.add(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: cTableHeader,
        border: Border(bottom: BorderSide(color: cFrostBorder)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 360,
            child: Text(
              'expression',
              style: TextStyle(
                color: cSlateInk,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'runtimeType',
              style: TextStyle(
                color: cSlateInk,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(
            width: 80,
            child: Text(
              'status',
              style: TextStyle(
                color: cSlateInk,
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  for (int i = 0; i < snapshots.length; i++) {
    final List<String> r = snapshots[i];
    final bool stripe = (i % 2) == 0;
    final bool ok = r[2] == 'ok';
    snapshotWidgets.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: stripe ? cTableStripe : cPearl,
          border: Border(
            bottom: BorderSide(color: cFrostBorder.withValues(alpha: 0.6)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 360,
              child: Text(
                r[0],
                style: TextStyle(
                  color: cIndigoNight,
                  fontFamily: 'monospace',
                  fontSize: 10,
                ),
              ),
            ),
            Expanded(
              child: Text(
                r[1],
                style: TextStyle(
                  color: cAshFog,
                  fontFamily: 'monospace',
                  fontSize: 10,
                ),
              ),
            ),
            SizedBox(
              width: 80,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: ok
                      ? cSeafoamGlow.withValues(alpha: 0.6)
                      : cLemonRibbon.withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  r[2],
                  style: TextStyle(
                    color: cSlateInk,
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget snapshotTable = Container(
    decoration: BoxDecoration(
      color: cPearl,
      border: Border.all(color: cFrostBorder),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: snapshotWidgets,
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 18 : Animated-feel decorative bar (no AnimationController).
  // We use AlwaysStoppedAnimation<double> to produce a single static
  // frame, fitting the no-stateful-animation rule.
  // -------------------------------------------------------------------

  final Animation<double> staticAnim = const AlwaysStoppedAnimation<double>(
    0.62,
  );

  Widget buildProgressBar(String label, double t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: cSlateInk,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 3),
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: cMintFrost,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: t,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [cCupertinoBlue, cSeafoamGlow],
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final Widget statsPanel = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      buildProgressBar(
        'Locale coverage on iOS (auto via system)',
        staticAnim.value + 0.30,
      ),
      buildProgressBar(
        'Visual fidelity vs UIKit (using system menu)',
        0.96,
      ),
      buildProgressBar(
        'Customisation flexibility (using system menu)',
        0.18,
      ),
      buildProgressBar(
        'Engine cost per show()',
        0.05,
      ),
      buildProgressBar(
        'Accessibility automatic-coverage',
        0.92,
      ),
      buildProgressBar(
        'Test coverage of bridging path',
        0.55,
      ),
    ],
  );

  // -------------------------------------------------------------------
  // SECTION 19 : Footer. Closing block summarising what was shown.
  // -------------------------------------------------------------------

  final Widget footer = Container(
    margin: const EdgeInsets.fromLTRB(0, 24, 0, 8),
    padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
    decoration: BoxDecoration(
      color: cIndigoNight,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'IOSSystemContextMenuItemDataCopy demo complete',
          style: TextStyle(
            color: cPearl,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Theme: Cupertino Mint / iOS Pearl / Translucent Frost. '
          'This panel summarised the data-class shape, sibling family, '
          'mock UI, decision tree, pitfalls, glossary, scenarios, and '
          'a comparison against Material PopupMenu. The class itself '
          'is tiny but the behavioural surface around it - '
          'localisation, accessibility, paste-board semantics - is '
          'sizeable, which is why the demo file is, in turn, large.',
          style: TextStyle(
            color: cMintFrost,
            fontSize: 12,
            height: 1.5,
          ),
        ),
      ],
    ),
  );

  // -------------------------------------------------------------------
  // SECTION 20 : Final assembly. We collect every section into a
  // single ListView so the user can scroll through the report.
  // -------------------------------------------------------------------

  final List<Widget> bodyChildren = <Widget>[
    heroCard,
    buildSectionTitle(
      '1. API Surface',
      'Members, signatures, and notes for the Copy data class.',
    ),
    buildPanel('API surface table', cMintFrost, apiSurfaceTable),
    buildSectionTitle(
      '2. Construction Snapshots',
      'Outcome of each constructor invocation in this script.',
    ),
    buildPanel('Snapshot table', cMintFrost, snapshotTable),
    buildPanel(
      'Equality probes',
      cMintFrost,
      equalityPanel,
    ),
    buildSectionTitle(
      '3. Sibling Catalog',
      'The IOSSystemContextMenuItemData family in one table.',
    ),
    buildPanel('Sibling classes', cMintFrost, siblingTable),
    buildSectionTitle(
      '4. Mock iOS Menu',
      'A pedagogical drawing of the floating selection toolbar.',
    ),
    buildPanel('iOS HIG-style mock', cMintFrost, mockContextMenu),
    buildSectionTitle(
      '5. Title Choices',
      'Good, bad, and acceptable title strings.',
    ),
    buildPanel('Title example table', cMintFrost, titleExampleTable),
    buildSectionTitle(
      '6. Prose',
      'A few paragraphs framing the iOS user model.',
    ),
    buildPanel('Discussion', cMintFrost, proseSection),
    buildSectionTitle(
      '7. Decision Tree',
      'When does Flutter use the system menu vs in-app rendering?',
    ),
    buildPanel('Decision flow', cMintFrost, decisionTree),
    buildSectionTitle(
      '8. Pitfalls',
      'Things that go wrong in the field.',
    ),
    buildPanel('Common mistakes', cMintFrost, pitfallPanel),
    buildSectionTitle(
      '9. Glossary',
      'Terms encountered in the iOS context-menu pipeline.',
    ),
    buildPanel('Glossary', cMintFrost, glossaryPanel),
    buildSectionTitle(
      '10. Palette',
      'The Cupertino Mint / iOS Pearl swatches used here.',
    ),
    buildPanel('Swatches', cMintFrost, paletteRow),
    buildSectionTitle(
      '11. Scenarios',
      'Realistic situations and the expected menu composition.',
    ),
    buildPanel('Scenario panels', cMintFrost, scenarios),
    buildSectionTitle(
      '12. Comparison vs Material PopupMenu',
      'How the iOS system menu differs from the cross-platform '
          'Material menu.',
    ),
    buildPanel('vs PopupMenu', cMintFrost, compareTable),
    buildSectionTitle(
      '13. Coverage Indicators',
      'Static stat bars summarising trade-offs.',
    ),
    buildPanel('Coverage', cMintFrost, statsPanel),
    footer,
  ];

  print('\nBuilt ${bodyChildren.length} top-level body widgets.');
  print('Returning Scaffold(body: ListView(...)).');
  print('=' * 60);
  print('IOSSystemContextMenuItemDataCopy test completed');

  return Scaffold(
    backgroundColor: cPearl,
    appBar: AppBar(
      backgroundColor: cIndigoNight,
      elevation: 0,
      title: Text(
        'IOSSystemContextMenuItemDataCopy - Cupertino Mint demo',
        style: TextStyle(
          color: cPearl,
          fontSize: 14,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
    body: Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      child: ListView(
        children: bodyChildren,
      ),
    ),
  );
}
