// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: hand-authored deep visual demo for LicenseEntry,
// LicenseEntryWithLineBreaks, LicenseRegistry and LicensePage/AboutDialog
//
// Topic coverage:
//   - LicenseEntry            (abstract base class shape)
//   - LicenseEntryWithLineBreaks (the canonical concrete subclass)
//   - LicenseParagraph        (text + indent leaf of a license entry)
//   - LicenseRegistry         (static add/read pipeline of licenses)
//   - LicensePage             (Material screen consuming the registry)
//   - AboutListTile           (a ListTile that opens the AboutDialog)
//   - AboutDialog             (the dialog hosting "View licenses" CTA)
//
// Build-time discipline (analyzer-free interpreter):
//   * Returns a single Scaffold from `build(BuildContext)`. No StatefulWidget.
//   * No async, Future, Timer, Stream subscription, AnimationController.
//   * Never calls LicenseRegistry.addLicense at script-eval time; that API
//     would yield from a Stream and we don't run the event loop here.
//   * LicenseRegistry.licenses is described in code-snippet Text() only.
//   * No bridged for-in loops; indexed loops over toList() snapshots only.
//   * Tween.transform(t) instead of Tween(...).animate(...).value.
//
// Visual layout (12 thematic sections):
//   1.  Hero banner + table of contents.
//   2.  LicenseEntry abstract anatomy card.
//   3.  LicenseEntryWithLineBreaks construction gallery (5 entries).
//   4.  Deep dive: rendering paragraphs of MIT-style and BSD-style entries.
//   5.  LicenseParagraph indentation showcase (incl. centeredIndent).
//   6.  LicenseRegistry inventory card + addLicense flow diagram.
//   7.  Code-snippet recipe cards (registration, generator pattern, dispose).
//   8.  Mock AboutDialog rendering.
//   9.  Mock LicensePage rendering (master/detail-ish).
//  10.  AboutListTile anatomy and screenshot.
//  11.  Best-practice / pitfalls panel.
//  12.  Cheat-sheet footer with chips.
//
// The file is deliberately verbose - every section carries explanatory Text
// cards and a between-section print() trace so the runtime log doubles as a
// table-of-contents for the rendered demo.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// The palette is deliberately understated; licenses are dense legal text and
// the demo treats them like archival material rather than UI chrome.
const Color _kCanvas = Color(0xFFF5F4EF);
const Color _kCanvasDeep = Color(0xFFEAE7DC);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardSoft = Color(0xFFFAF8F2);
const Color _kCardParchment = Color(0xFFFBF7EA);
const Color _kCardDark = Color(0xFF1F1B16);
const Color _kHairline = Color(0x1A000000);
const Color _kHairlineDeep = Color(0x33000000);
const Color _kHairlineOnDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF1F1B16);
const Color _kInkSecondary = Color(0xFF4D453A);
const Color _kInkTertiary = Color(0xFF8C8474);
const Color _kInkOnDark = Color(0xFFF1ECDF);
const Color _kInkOnDarkSecondary = Color(0xFFB8B0A0);
const Color _kAccent = Color(0xFF8A5A1A); // walnut / parchment accent
const Color _kAccentSoft = Color(0xFFF1E4CC);
const Color _kAccentDeep = Color(0xFF5C3B0F);
const Color _kAccentBlue = Color(0xFF1F4E9D);
const Color _kAccentBlueSoft = Color(0xFFDDE7F4);
const Color _kAccentGreen = Color(0xFF2E7D32);
const Color _kAccentGreenSoft = Color(0xFFDDF0E0);
const Color _kAccentRed = Color(0xFFB91C1C);
const Color _kAccentRedSoft = Color(0xFFF6D5D5);
const Color _kAccentAmber = Color(0xFFB87A0F);
const Color _kAccentAmberSoft = Color(0xFFF8E6BF);
const Color _kAccentViolet = Color(0xFF5E3A8E);
const Color _kAccentVioletSoft = Color(0xFFE5D9F1);
const Color _kAccentTeal = Color(0xFF0F6B66);
const Color _kAccentTealSoft = Color(0xFFCCEAE7);
const Color _kStamp = Color(0xFFB22222);
const Color _kCodeBg = Color(0xFF1B1B1F);
const Color _kCodeKeyword = Color(0xFFFFB86C);
const Color _kCodeString = Color(0xFFA5D6A7);
const Color _kCodeComment = Color(0xFF7A7E89);
const Color _kCodePlain = Color(0xFFE0E0E0);

const TextStyle _kHeroTitle = TextStyle(
  fontSize: 26.0,
  fontWeight: FontWeight.w800,
  color: _kInk,
  letterSpacing: -0.6,
);
const TextStyle _kHeroSubtitle = TextStyle(
  fontSize: 14.5,
  color: _kInkSecondary,
  fontWeight: FontWeight.w500,
  height: 1.45,
);
const TextStyle _kSectionTitle = TextStyle(
  fontSize: 20.0,
  fontWeight: FontWeight.w700,
  color: _kInk,
  letterSpacing: -0.3,
);
const TextStyle _kSectionSub = TextStyle(
  fontSize: 13.0,
  color: _kInkSecondary,
  fontWeight: FontWeight.w500,
  height: 1.45,
);
const TextStyle _kCardTitle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.w700,
  color: _kInk,
);
const TextStyle _kCardBody = TextStyle(
  fontSize: 13.0,
  color: _kInkSecondary,
  height: 1.45,
);
const TextStyle _kLabel = TextStyle(
  fontSize: 11.0,
  fontWeight: FontWeight.w700,
  color: _kInkSecondary,
  letterSpacing: 0.7,
);
const TextStyle _kKeyText = TextStyle(
  fontSize: 12.0,
  fontWeight: FontWeight.w700,
  color: _kAccentDeep,
);
const TextStyle _kMono = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12.5,
  color: _kInk,
  height: 1.5,
);
const TextStyle _kMonoSmall = TextStyle(
  fontFamily: 'monospace',
  fontSize: 11.5,
  color: _kInkSecondary,
  height: 1.5,
);
const TextStyle _kCodeBase = TextStyle(
  fontFamily: 'monospace',
  fontSize: 12.5,
  color: _kCodePlain,
  height: 1.55,
);

// ---------------------------------------------------------------------------
// MASTER ENTRY POINT
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  print('[license_test] >>> build() entered.');
  print('[license_test] Constructing LicenseEntryWithLineBreaks samples.');

  // -------------------------------------------------------------------------
  // SAMPLE LICENSE TEXTS
  // -------------------------------------------------------------------------
  // These are heavily-abbreviated, illustrative excerpts. They are *not* the
  // full canonical text of any license - the demo focuses on how the entry
  // is rendered, not on legal completeness.
  const String _kMitText =
      'MIT License\n'
      '\n'
      'Copyright (c) 2026 Tom Framework Contributors\n'
      '\n'
      'Permission is hereby granted, free of charge, to any person obtaining\n'
      'a copy of this software and associated documentation files (the\n'
      '"Software"), to deal in the Software without restriction, including\n'
      'without limitation the rights to use, copy, modify, merge, publish,\n'
      'distribute, sublicense, and/or sell copies of the Software, and to\n'
      'permit persons to whom the Software is furnished to do so, subject\n'
      'to the following conditions:\n'
      '\n'
      'The above copyright notice and this permission notice shall be\n'
      'included in all copies or substantial portions of the Software.\n'
      '\n'
      'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,\n'
      'EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF\n'
      'MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.\n';

  const String _kBsdText =
      'BSD 3-Clause License\n'
      '\n'
      'Copyright (c) 2026, Tom Framework.\n'
      'All rights reserved.\n'
      '\n'
      'Redistribution and use in source and binary forms, with or without\n'
      'modification, are permitted provided that the following conditions\n'
      'are met:\n'
      '\n'
      '  1. Redistributions of source code must retain the above copyright\n'
      '     notice, this list of conditions and the following disclaimer.\n'
      '\n'
      '  2. Redistributions in binary form must reproduce the above copyright\n'
      '     notice, this list of conditions and the following disclaimer in\n'
      '     the documentation and/or other materials provided with the\n'
      '     distribution.\n'
      '\n'
      '  3. Neither the name of the copyright holder nor the names of its\n'
      '     contributors may be used to endorse or promote products derived\n'
      '     from this software without specific prior written permission.\n';

  const String _kApacheText =
      'Apache License\n'
      'Version 2.0, January 2004\n'
      'http://www.apache.org/licenses/\n'
      '\n'
      'TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION\n'
      '\n'
      '1. Definitions.\n'
      '\n'
      '"License" shall mean the terms and conditions for use, reproduction,\n'
      'and distribution as defined by Sections 1 through 9 of this document.\n'
      '\n'
      '"Licensor" shall mean the copyright owner or entity authorized by the\n'
      'copyright owner that is granting the License.\n'
      '\n'
      '"Legal Entity" shall mean the union of the acting entity and all\n'
      'other entities that control, are controlled by, or are under common\n'
      'control with that entity.\n';

  const String _kGplText =
      'GNU GENERAL PUBLIC LICENSE\n'
      'Version 3, 29 June 2007\n'
      '\n'
      'Copyright (C) 2007 Free Software Foundation, Inc.\n'
      '\n'
      'Everyone is permitted to copy and distribute verbatim copies of this\n'
      'license document, but changing it is not allowed.\n'
      '\n'
      '                            Preamble\n'
      '\n'
      'The GNU General Public License is a free, copyleft license for\n'
      'software and other kinds of works.\n';

  const String _kTomCustomText =
      'Tom Framework Internal License (Excerpt)\n'
      '\n'
      'This component is part of the Tom workspace and is governed by the\n'
      'workspace-level license file at the root of the repository.\n'
      '\n'
      '  - Internal use is unrestricted.\n'
      '  - External redistribution requires written consent.\n'
      '  - Bug reports may be filed via the project tracker.\n'
      '\n'
      'For the full text, see LICENSE in the workspace root.\n';

  // -------------------------------------------------------------------------
  // LICENSE ENTRY GALLERY
  // -------------------------------------------------------------------------
  print('[license_test] Building LicenseEntryWithLineBreaks gallery.');

  final LicenseEntryWithLineBreaks _entryMit = LicenseEntryWithLineBreaks(
    const <String>['tom_framework', 'tom_core_kernel'],
    _kMitText,
  );
  final LicenseEntryWithLineBreaks _entryBsd = LicenseEntryWithLineBreaks(
    const <String>['tom_d4rt'],
    _kBsdText,
  );
  final LicenseEntryWithLineBreaks _entryApache = LicenseEntryWithLineBreaks(
    const <String>['tom_d4rt_ast', 'tom_d4rt_generator'],
    _kApacheText,
  );
  final LicenseEntryWithLineBreaks _entryGpl = LicenseEntryWithLineBreaks(
    const <String>['tom_devops'],
    _kGplText,
  );
  final LicenseEntryWithLineBreaks _entryTom = LicenseEntryWithLineBreaks(
    const <String>['tom_framework'],
    _kTomCustomText,
  );

  // Snapshot the paragraphs once - iterating an iterable that backs into a
  // bridged generator twice is fine in pure Dart, but the interpreter
  // prefers an indexed toList() view.
  final List<LicenseParagraph> _mitParas = _entryMit.paragraphs.toList();
  final List<LicenseParagraph> _bsdParas = _entryBsd.paragraphs.toList();
  final List<LicenseParagraph> _apacheParas = _entryApache.paragraphs.toList();
  final List<LicenseParagraph> _gplParas = _entryGpl.paragraphs.toList();
  final List<LicenseParagraph> _tomParas = _entryTom.paragraphs.toList();

  print('[license_test] MIT entry has ${_mitParas.length} paragraphs.');
  print('[license_test] BSD entry has ${_bsdParas.length} paragraphs.');
  print('[license_test] Apache entry has ${_apacheParas.length} paragraphs.');
  print('[license_test] GPL entry has ${_gplParas.length} paragraphs.');
  print('[license_test] Tom entry has ${_tomParas.length} paragraphs.');
  print(
    '[license_test] LicenseParagraph.centeredIndent = '
    '${LicenseParagraph.centeredIndent}',
  );

  // A tiny tween demonstration. We use Tween.transform(t) per the script
  // rules: no Animation, no AnimationController, no .animate(...).value.
  final Tween<double> _stampScaleTween = Tween<double>(begin: 0.85, end: 1.05);
  final double _stampScale = _stampScaleTween.transform(0.55);
  print('[license_test] Decorative stamp scale = $_stampScale.');

  // -------------------------------------------------------------------------
  // ASSEMBLE SECTIONS
  // -------------------------------------------------------------------------
  final List<Widget> _slivers = <Widget>[];

  _slivers.add(_buildHero());
  _slivers.add(const SizedBox(height: 24.0));
  print('[license_test] Section 1 (hero) appended.');

  _slivers.add(_buildSectionHeader(
    '01',
    'LicenseEntry anatomy',
    'The abstract base class. Every concrete license entry exposes two '
        'iterables: packages and paragraphs. Everything else in this demo '
        'is built on top of this minimal contract.',
  ));
  _slivers.add(_buildEntryAnatomy());
  _slivers.add(const SizedBox(height: 28.0));
  print('[license_test] Section 2 (anatomy) appended.');

  _slivers.add(_buildSectionHeader(
    '02',
    'LicenseEntryWithLineBreaks gallery',
    'Five concrete entries covering the canonical FOSS licenses plus a '
        'Tom-internal flavour. Each card shows packages, runtimeType, and '
        'a paragraph count tally.',
  ));
  _slivers.add(_buildGallery(<LicenseEntryWithLineBreaks>[
    _entryMit,
    _entryBsd,
    _entryApache,
    _entryGpl,
    _entryTom,
  ], <List<LicenseParagraph>>[
    _mitParas,
    _bsdParas,
    _apacheParas,
    _gplParas,
    _tomParas,
  ]));
  _slivers.add(const SizedBox(height: 28.0));
  print('[license_test] Section 3 (gallery) appended.');

  _slivers.add(_buildSectionHeader(
    '03',
    'Paragraph deep dive',
    'The same gallery, but with each entry expanded to show every '
        'LicenseParagraph the line-break parser produced.',
  ));
  _slivers.add(_buildParagraphDeepDive('MIT License',
      _entryMit.packages.toList(), _mitParas, _kAccentBlue, _kAccentBlueSoft));
  _slivers.add(const SizedBox(height: 18.0));
  _slivers.add(_buildParagraphDeepDive('BSD 3-Clause',
      _entryBsd.packages.toList(), _bsdParas, _kAccentGreen, _kAccentGreenSoft));
  _slivers.add(const SizedBox(height: 18.0));
  _slivers.add(_buildParagraphDeepDive(
      'Apache 2.0',
      _entryApache.packages.toList(),
      _apacheParas,
      _kAccentAmber,
      _kAccentAmberSoft));
  _slivers.add(const SizedBox(height: 18.0));
  _slivers.add(_buildParagraphDeepDive('GPL 3.0',
      _entryGpl.packages.toList(), _gplParas, _kAccentRed, _kAccentRedSoft));
  _slivers.add(const SizedBox(height: 18.0));
  _slivers.add(_buildParagraphDeepDive('Tom Internal',
      _entryTom.packages.toList(), _tomParas, _kAccentViolet, _kAccentVioletSoft));
  _slivers.add(const SizedBox(height: 28.0));
  print('[license_test] Section 4 (deep dive) appended.');

  _slivers.add(_buildSectionHeader(
    '04',
    'LicenseParagraph indentation showcase',
    'The .indent value is an int. 0 is flush-left. Positive values nest. '
        'The sentinel LicenseParagraph.centeredIndent means "centre this '
        'paragraph", typically used for license titles.',
  ));
  _slivers.add(_buildIndentShowcase());
  _slivers.add(const SizedBox(height: 28.0));
  print('[license_test] Section 5 (indent showcase) appended.');

  _slivers.add(_buildSectionHeader(
    '05',
    'LicenseRegistry inventory',
    'Where every LicenseEntry the app ships eventually lives. addLicense() '
        'pushes a generator; .licenses pulls them back out as a Stream. '
        'In this demo we describe both - we do not subscribe.',
  ));
  _slivers.add(_buildRegistryCard());
  _slivers.add(const SizedBox(height: 18.0));
  _slivers.add(_buildRegistryFlow());
  _slivers.add(const SizedBox(height: 28.0));
  print('[license_test] Section 6 (registry) appended.');

  _slivers.add(_buildSectionHeader(
    '06',
    'Recipe code cards',
    'Idiomatic snippets you can drop into your app: registering a license '
        'from a string asset, registering many at once, and the common '
        'mistake of forgetting to call addLicense before runApp.',
  ));
  _slivers.add(_buildRecipeCards());
  _slivers.add(const SizedBox(height: 28.0));
  print('[license_test] Section 7 (recipes) appended.');

  _slivers.add(_buildSectionHeader(
    '07',
    'AboutDialog mock',
    'AboutDialog is the Material widget that surfaces app metadata and the '
        '"VIEW LICENSES" CTA. Below is a faithful static render of one.',
  ));
  _slivers.add(_buildAboutDialogMock());
  _slivers.add(const SizedBox(height: 28.0));
  print('[license_test] Section 8 (about dialog) appended.');

  _slivers.add(_buildSectionHeader(
    '08',
    'LicensePage mock',
    'LicensePage is the screen you reach from AboutDialog. It groups '
        'entries by package and renders each entry as a list tile that '
        'drills into the full text.',
  ));
  _slivers.add(_buildLicensePageMock(<LicenseEntryWithLineBreaks>[
    _entryMit,
    _entryBsd,
    _entryApache,
    _entryGpl,
    _entryTom,
  ], <List<LicenseParagraph>>[
    _mitParas,
    _bsdParas,
    _apacheParas,
    _gplParas,
    _tomParas,
  ]));
  _slivers.add(const SizedBox(height: 28.0));
  print('[license_test] Section 9 (license page) appended.');

  _slivers.add(_buildSectionHeader(
    '09',
    'AboutListTile anatomy',
    'AboutListTile is a one-liner you drop into a Drawer or Settings list. '
        'When tapped, it pushes the AboutDialog with the provided metadata.',
  ));
  _slivers.add(_buildAboutListTileMock());
  _slivers.add(const SizedBox(height: 28.0));
  print('[license_test] Section 10 (about list tile) appended.');

  _slivers.add(_buildSectionHeader(
    '10',
    'Best practices & pitfalls',
    'Eight callouts collected from real Tom Framework app reviews.',
  ));
  _slivers.add(_buildPitfallsPanel());
  _slivers.add(const SizedBox(height: 28.0));
  print('[license_test] Section 11 (pitfalls) appended.');

  _slivers.add(_buildSectionHeader(
    '11',
    'Cheat-sheet',
    'Chip groups summarising the API surface for quick reference.',
  ));
  _slivers.add(_buildCheatSheet());
  _slivers.add(const SizedBox(height: 36.0));
  print('[license_test] Section 12 (cheat sheet) appended.');

  _slivers.add(_buildFooter(_stampScale));
  _slivers.add(const SizedBox(height: 24.0));
  print('[license_test] Footer appended.');

  print('[license_test] <<< build() returning Scaffold.');

  return Scaffold(
    backgroundColor: _kCanvas,
    appBar: _buildAppBar(),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20.0, 18.0, 20.0, 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _slivers,
        ),
      ),
    ),
  );
}

// ===========================================================================
// APP BAR
// ===========================================================================
PreferredSizeWidget _buildAppBar() {
  return AppBar(
    backgroundColor: _kCanvasDeep,
    elevation: 0.0,
    foregroundColor: _kInk,
    title: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        Icon(Icons.copyright_outlined, color: _kAccentDeep, size: 22.0),
        SizedBox(width: 10.0),
        Text(
          'LicenseRegistry / LicensePage  —  deep visual demo',
          style: TextStyle(
            fontSize: 15.5,
            fontWeight: FontWeight.w700,
            color: _kInk,
            letterSpacing: -0.2,
          ),
        ),
      ],
    ),
    bottom: const PreferredSize(
      preferredSize: Size.fromHeight(1.0),
      child: Divider(height: 1.0, thickness: 1.0, color: _kHairline),
    ),
  );
}

// ===========================================================================
// SECTION 1: HERO
// ===========================================================================
Widget _buildHero() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.0),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[_kCardParchment, _kCardSoft],
      ),
      border: Border.all(color: _kHairline, width: 1.0),
    ),
    padding: const EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 22.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 44.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: _kAccentSoft,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: _kHairline, width: 1.0),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.menu_book_outlined,
                  color: _kAccentDeep, size: 24.0),
            ),
            const SizedBox(width: 14.0),
            const Expanded(
              child: Text(
                'Open-source license plumbing in Flutter',
                style: _kHeroTitle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'This script renders a self-contained gallery covering '
          'LicenseEntry, LicenseEntryWithLineBreaks, LicenseParagraph, '
          'LicenseRegistry and the consumer widgets AboutListTile, '
          'AboutDialog and LicensePage. Every screen on this page is '
          'static — there is no Stream subscription, no addLicense() call, '
          'no Future, no Timer. The widgets you see are mock renders that '
          'mirror the real Material implementation.',
          style: _kHeroSubtitle,
        ),
        const SizedBox(height: 16.0),
        const Divider(color: _kHairline, height: 1.0, thickness: 1.0),
        const SizedBox(height: 14.0),
        const Text('CONTENTS', style: _kLabel),
        const SizedBox(height: 8.0),
        _buildHeroToc(),
      ],
    ),
  );
}

Widget _buildHeroToc() {
  final List<String> _items = const <String>[
    '01  LicenseEntry anatomy',
    '02  LicenseEntryWithLineBreaks gallery',
    '03  Paragraph deep dive',
    '04  Indentation showcase',
    '05  LicenseRegistry inventory',
    '06  Recipe code cards',
    '07  AboutDialog mock',
    '08  LicensePage mock',
    '09  AboutListTile anatomy',
    '10  Best practices & pitfalls',
    '11  Cheat-sheet',
  ];
  final List<Widget> _rows = <Widget>[];
  for (int i = 0; i < _items.length; i++) {
    _rows.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        children: <Widget>[
          Container(
            width: 6.0,
            height: 6.0,
            decoration: const BoxDecoration(
              color: _kAccent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              _items[i],
              style: const TextStyle(
                fontSize: 12.5,
                color: _kInkSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    ));
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: _rows,
  );
}

// ===========================================================================
// SECTION HEADERS
// ===========================================================================
Widget _buildSectionHeader(String number, String title, String subtitle) {
  return Padding(
    padding: const EdgeInsets.only(top: 4.0, bottom: 12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 38.0,
          height: 38.0,
          decoration: BoxDecoration(
            color: _kAccentSoft,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kHairline, width: 1.0),
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w800,
              color: _kAccentDeep,
            ),
          ),
        ),
        const SizedBox(width: 14.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(title, style: _kSectionTitle),
              const SizedBox(height: 4.0),
              Text(subtitle, style: _kSectionSub),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 2: LICENSEENTRY ANATOMY
// ===========================================================================
Widget _buildEntryAnatomy() {
  return Container(
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kHairline, width: 1.0),
    ),
    padding: const EdgeInsets.all(18.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: _kAccentBlueSoft,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: const Text(
                'abstract class',
                style: TextStyle(
                  fontSize: 11.0,
                  color: _kAccentBlue,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            const Text('LicenseEntry', style: _kCardTitle),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Every concrete license is some subclass of LicenseEntry. The '
          'abstract surface is intentionally tiny — two iterable getters '
          'and a private constructor. Subclasses parse a raw blob into the '
          'paragraph sequence Flutter expects.',
          style: _kCardBody,
        ),
        const SizedBox(height: 14.0),
        _buildAnatomyRow(
          'packages',
          'Iterable<String>',
          'Logical package names this entry applies to. Often a single '
              'package, sometimes many (mono-licensed mono-repos).',
        ),
        _buildAnatomyRow(
          'paragraphs',
          'Iterable<LicenseParagraph>',
          'The body. Each paragraph carries an integer indent plus the '
              'raw text line. Empty lines act as paragraph separators in '
              'LicenseEntryWithLineBreaks.',
        ),
        _buildAnatomyRow(
          'const LicenseEntry()',
          'protected constructor',
          'You do not call this directly. Subclass it or use the '
              'pre-built LicenseEntryWithLineBreaks.',
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kHairline),
          ),
          child: const Text(
            'class LicenseEntry {\n'
            '  const LicenseEntry();\n'
            '  Iterable<String> get packages;\n'
            '  Iterable<LicenseParagraph> get paragraphs;\n'
            '}',
            style: _kMono,
          ),
        ),
      ],
    ),
  );
}

Widget _buildAnatomyRow(String name, String type, String doc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 150.0,
          child: Text(name, style: _kKeyText),
        ),
        SizedBox(
          width: 220.0,
          child: Text(
            type,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: _kAccentBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(child: Text(doc, style: _kCardBody)),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 3: GALLERY
// ===========================================================================
Widget _buildGallery(
  List<LicenseEntryWithLineBreaks> entries,
  List<List<LicenseParagraph>> paragraphLists,
) {
  final List<Widget> _cards = <Widget>[];
  final List<String> _titles = <String>[
    'MIT License',
    'BSD 3-Clause',
    'Apache 2.0',
    'GPL 3.0',
    'Tom Internal',
  ];
  final List<Color> _swatch = <Color>[
    _kAccentBlue,
    _kAccentGreen,
    _kAccentAmber,
    _kAccentRed,
    _kAccentViolet,
  ];
  final List<Color> _swatchSoft = <Color>[
    _kAccentBlueSoft,
    _kAccentGreenSoft,
    _kAccentAmberSoft,
    _kAccentRedSoft,
    _kAccentVioletSoft,
  ];
  for (int i = 0; i < entries.length; i++) {
    final LicenseEntryWithLineBreaks _e = entries[i];
    final List<LicenseParagraph> _ps = paragraphLists[i];
    final List<String> _pkgs = _e.packages.toList();
    _cards.add(_buildGalleryCard(
      _titles[i],
      _pkgs,
      _ps.length,
      _e.runtimeType.toString(),
      _swatch[i],
      _swatchSoft[i],
    ));
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _cards[0],
      const SizedBox(height: 10.0),
      _cards[1],
      const SizedBox(height: 10.0),
      _cards[2],
      const SizedBox(height: 10.0),
      _cards[3],
      const SizedBox(height: 10.0),
      _cards[4],
    ],
  );
}

Widget _buildGalleryCard(
  String title,
  List<String> packages,
  int paragraphCount,
  String runtimeTypeLabel,
  Color accent,
  Color accentSoft,
) {
  final List<Widget> _chips = <Widget>[];
  for (int i = 0; i < packages.length; i++) {
    _chips.add(Container(
      margin: const EdgeInsets.only(right: 6.0, bottom: 6.0),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: accentSoft,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: _kHairline, width: 1.0),
      ),
      child: Text(
        packages[i],
        style: TextStyle(
          fontSize: 11.0,
          color: accent,
          fontWeight: FontWeight.w700,
        ),
      ),
    ));
  }
  return Container(
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kHairline, width: 1.0),
    ),
    padding: const EdgeInsets.all(14.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 44.0,
          height: 44.0,
          decoration: BoxDecoration(
            color: accentSoft,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kHairline, width: 1.0),
          ),
          alignment: Alignment.center,
          child: Icon(Icons.description_outlined, color: accent, size: 22.0),
        ),
        const SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(child: Text(title, style: _kCardTitle)),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3.0),
                    decoration: BoxDecoration(
                      color: _kCardSoft,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: _kHairline, width: 1.0),
                    ),
                    child: Text(
                      '$paragraphCount ¶',
                      style: const TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.w700,
                        color: _kInkSecondary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Text(
                'runtimeType = $runtimeTypeLabel',
                style: _kMonoSmall,
              ),
              const SizedBox(height: 6.0),
              Wrap(children: _chips),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 4: PARAGRAPH DEEP DIVE
// ===========================================================================
Widget _buildParagraphDeepDive(
  String title,
  List<String> packages,
  List<LicenseParagraph> paragraphs,
  Color accent,
  Color accentSoft,
) {
  final List<Widget> _rows = <Widget>[];
  final int _maxShown = paragraphs.length > 18 ? 18 : paragraphs.length;
  for (int i = 0; i < _maxShown; i++) {
    final LicenseParagraph _p = paragraphs[i];
    _rows.add(_buildParagraphRow(i, _p, accent));
  }
  if (paragraphs.length > _maxShown) {
    _rows.add(Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Text(
        '… ${paragraphs.length - _maxShown} more paragraph(s) elided.',
        style: const TextStyle(
          fontSize: 11.5,
          color: _kInkTertiary,
          fontStyle: FontStyle.italic,
        ),
      ),
    ));
  }
  return Container(
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kHairline, width: 1.0),
    ),
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: accentSoft,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                title.toUpperCase(),
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w800,
                  color: accent,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                'packages: ${packages.join(", ")}',
                style: _kMonoSmall,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Divider(color: _kHairline, height: 1.0, thickness: 1.0),
        const SizedBox(height: 10.0),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: _rows),
      ],
    ),
  );
}

Widget _buildParagraphRow(int index, LicenseParagraph p, Color accent) {
  final bool _centered = p.indent == LicenseParagraph.centeredIndent;
  final int _displayIndent = _centered ? 0 : p.indent;
  return Container(
    margin: const EdgeInsets.only(bottom: 4.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: index.isEven ? _kCardSoft : _kCardBg,
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 32.0,
          child: Text(
            '#$index',
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: accent,
              fontFamily: 'monospace',
            ),
          ),
        ),
        SizedBox(
          width: 70.0,
          child: Text(
            _centered ? 'centered' : 'indent=$_displayIndent',
            style: const TextStyle(
              fontSize: 10.5,
              color: _kInkTertiary,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            p.text,
            style: TextStyle(
              fontSize: 11.5,
              color: _kInk,
              fontFamily: 'monospace',
              height: 1.4,
              fontWeight: _centered ? FontWeight.w700 : FontWeight.w400,
            ),
            textAlign: _centered ? TextAlign.center : TextAlign.left,
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 5: INDENTATION SHOWCASE
// ===========================================================================
Widget _buildIndentShowcase() {
  final List<int> _indents = const <int>[0, 1, 2, 3, 4, 5];
  final List<Widget> _rows = <Widget>[];
  for (int i = 0; i < _indents.length; i++) {
    final int _ind = _indents[i];
    _rows.add(_buildIndentRow(_ind));
  }
  _rows.add(_buildIndentRow(LicenseParagraph.centeredIndent));
  return Container(
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kHairline, width: 1.0),
    ),
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Indent ladder', style: _kCardTitle),
        const SizedBox(height: 6.0),
        const Text(
          'LicenseParagraph.indent is a hint to the renderer. The exact '
          'pixel mapping is up to the consumer — LicensePage typically '
          'multiplies the indent by a fixed pad. The sentinel value '
          'centeredIndent (a special negative-ish marker) renders the '
          'paragraph centred instead of indented.',
          style: _kCardBody,
        ),
        const SizedBox(height: 4.0),
        Text(
          'LicenseParagraph.centeredIndent = '
          '${LicenseParagraph.centeredIndent}',
          style: _kMonoSmall,
        ),
        const SizedBox(height: 12.0),
        const Divider(color: _kHairline, height: 1.0, thickness: 1.0),
        const SizedBox(height: 10.0),
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: _rows),
      ],
    ),
  );
}

Widget _buildIndentRow(int indent) {
  final bool _centered = indent == LicenseParagraph.centeredIndent;
  final double _pad = _centered ? 0.0 : indent.toDouble() * 16.0;
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 90.0,
          child: Text(
            _centered ? 'centered' : 'indent=$indent',
            style: _kMonoSmall,
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.fromLTRB(_pad + 6.0, 6.0, 6.0, 6.0),
            decoration: BoxDecoration(
              color: _kCardParchment,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: _kHairline),
            ),
            child: Text(
              _centered
                  ? 'A centred line — typical of license titles.'
                  : 'Text rendered with indent level $indent (≈${(_pad).toStringAsFixed(0)} px).',
              textAlign: _centered ? TextAlign.center : TextAlign.left,
              style: TextStyle(
                fontSize: 12.0,
                color: _kInk,
                fontWeight: _centered ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 6: LICENSEREGISTRY INVENTORY + FLOW
// ===========================================================================
Widget _buildRegistryCard() {
  return Container(
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kHairline, width: 1.0),
    ),
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: _kAccentTealSoft,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: const Text(
                'static class',
                style: TextStyle(
                  fontSize: 11.0,
                  color: _kAccentTeal,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            const Text('LicenseRegistry', style: _kCardTitle),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'LicenseRegistry is a singleton with no instances. Its static '
          'surface is just two members: addLicense, which pushes a '
          'Stream<LicenseEntry>-producing closure into the registry, and '
          'licenses, a getter that returns Stream<LicenseEntry> spanning '
          'every registered source. The registry is normally seeded once '
          'in main() before runApp() so that LicensePage can read it back.',
          style: _kCardBody,
        ),
        const SizedBox(height: 14.0),
        _buildAnatomyRow(
          'addLicense',
          'void Function(LicenseEntryCollector)',
          'Register a generator that yields entries on demand. The '
              'collector signature is `Stream<LicenseEntry> Function()`.',
        ),
        _buildAnatomyRow(
          'licenses',
          'Stream<LicenseEntry>',
          'Pull side of the pipeline. Every collector is invoked and its '
              'output multiplexed into a single broadcast stream.',
        ),
        _buildAnatomyRow(
          'reset',
          'void Function() — internal',
          'Test-only hook to clear collectors. Not part of the public '
              'surface but useful to know exists for golden tests.',
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kHairline),
          ),
          child: const Text(
            'class LicenseRegistry {\n'
            '  static void addLicense(LicenseEntryCollector collector);\n'
            '  static Stream<LicenseEntry> get licenses;\n'
            '}',
            style: _kMono,
          ),
        ),
      ],
    ),
  );
}

Widget _buildRegistryFlow() {
  return Container(
    decoration: BoxDecoration(
      color: _kCardParchment,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kHairline, width: 1.0),
    ),
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Registry data flow', style: _kCardTitle),
        const SizedBox(height: 10.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildFlowBox('main()', _kAccentBlue, _kAccentBlueSoft),
            _buildArrow(),
            _buildFlowBox(
                'addLicense(\n  () async* {…}\n)', _kAccentAmber, _kAccentAmberSoft),
            _buildArrow(),
            _buildFlowBox(
                'collectors[]', _kAccentTeal, _kAccentTealSoft),
          ],
        ),
        const SizedBox(height: 14.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildFlowBox('LicensePage', _kAccentViolet, _kAccentVioletSoft),
            _buildArrow(reverse: true),
            _buildFlowBox(
                'licenses\n(Stream)', _kAccentGreen, _kAccentGreenSoft),
            _buildArrow(reverse: true),
            _buildFlowBox(
                'collectors[]', _kAccentTeal, _kAccentTealSoft),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'Top row: registration side. Bottom row: consumption side. '
          'Notice how the collectors list sits in the middle — it is the '
          'rendezvous between writers and readers.',
          style: _kCardBody,
        ),
      ],
    ),
  );
}

Widget _buildFlowBox(String label, Color accent, Color accentSoft) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 2.0),
    width: 96.0,
    padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: accentSoft,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: accent, width: 1.2),
    ),
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w700,
        color: accent,
        height: 1.2,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _buildArrow({bool reverse = false}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 2.0),
    child: Icon(
      reverse ? Icons.arrow_back_rounded : Icons.arrow_forward_rounded,
      size: 18.0,
      color: _kInkTertiary,
    ),
  );
}

// ===========================================================================
// SECTION 7: RECIPE CODE CARDS
// ===========================================================================
Widget _buildRecipeCards() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildCodeCard(
        '1) Register a single license from a string asset',
        <_CodeLine>[
          _CodeLine('void main() {', _kCodeKeyword),
          _CodeLine('  LicenseRegistry.addLicense(() async* {', _kCodePlain),
          _CodeLine(
              "    final raw = await rootBundle.loadString('assets/LICENSE');",
              _kCodePlain),
          _CodeLine('    yield LicenseEntryWithLineBreaks(', _kCodePlain),
          _CodeLine("      <String>['my_app'],", _kCodeString),
          _CodeLine('      raw,', _kCodePlain),
          _CodeLine('    );', _kCodePlain),
          _CodeLine('  });', _kCodePlain),
          _CodeLine('  runApp(const MyApp());', _kCodePlain),
          _CodeLine('}', _kCodeKeyword),
        ],
      ),
      const SizedBox(height: 10.0),
      _buildCodeCard(
        '2) Register many at once from a manifest',
        <_CodeLine>[
          _CodeLine(
              '// Each yield emits one LicenseEntry. The framework pulls',
              _kCodeComment),
          _CodeLine(
              '// them lazily, so it is fine for the closure to be slow.',
              _kCodeComment),
          _CodeLine('LicenseRegistry.addLicense(() async* {', _kCodePlain),
          _CodeLine(
              "  final List<String> packages = ['foo', 'bar', 'baz'];", _kCodePlain),
          _CodeLine('  for (final pkg in packages) {', _kCodeKeyword),
          _CodeLine(
              "    final body = await rootBundle.loadString('lic/\$pkg.txt');",
              _kCodePlain),
          _CodeLine(
              '    yield LicenseEntryWithLineBreaks(<String>[pkg], body);',
              _kCodePlain),
          _CodeLine('  }', _kCodePlain),
          _CodeLine('});', _kCodePlain),
        ],
      ),
      const SizedBox(height: 10.0),
      _buildCodeCard(
        '3) Open LicensePage directly without AboutDialog',
        <_CodeLine>[
          _CodeLine(
              'showLicensePage(', _kCodeKeyword),
          _CodeLine('  context: context,', _kCodePlain),
          _CodeLine(
              "  applicationName: 'Tom Framework Demo',", _kCodeString),
          _CodeLine("  applicationVersion: '1.0.0',", _kCodeString),
          _CodeLine(
              '  applicationIcon: const FlutterLogo(),', _kCodePlain),
          _CodeLine(
              "  applicationLegalese: '© 2026 Tom contributors',", _kCodeString),
          _CodeLine(');', _kCodePlain),
        ],
      ),
      const SizedBox(height: 10.0),
      _buildCodeCard(
        '4) Hand-roll a LicenseEntry subclass',
        <_CodeLine>[
          _CodeLine(
              'class MyLicense extends LicenseEntry {', _kCodeKeyword),
          _CodeLine('  const MyLicense();', _kCodePlain),
          _CodeLine('  @override', _kCodeComment),
          _CodeLine(
              "  Iterable<String> get packages => ['my_app'];", _kCodePlain),
          _CodeLine('  @override', _kCodeComment),
          _CodeLine(
              '  Iterable<LicenseParagraph> get paragraphs sync* {',
              _kCodePlain),
          _CodeLine(
              "    yield const LicenseParagraph('Hand-rolled.', 0);",
              _kCodeString),
          _CodeLine('  }', _kCodePlain),
          _CodeLine('}', _kCodeKeyword),
        ],
      ),
      const SizedBox(height: 10.0),
      _buildCodeCard(
        '5) Read the registry (in a real app, not at script-eval time)',
        <_CodeLine>[
          _CodeLine(
              '// LicenseRegistry.licenses is a broadcast Stream.', _kCodeComment),
          _CodeLine(
              '// FutureBuilder + toList() is the idiomatic consumer pattern.',
              _kCodeComment),
          _CodeLine('final entries = await LicenseRegistry.licenses', _kCodePlain),
          _CodeLine('    .toList();', _kCodePlain),
          _CodeLine(
              "print('total licenses: \${entries.length}');", _kCodePlain),
        ],
      ),
      const SizedBox(height: 10.0),
      _buildCodeCard(
        '6) The classic mistake — registering after first frame',
        <_CodeLine>[
          _CodeLine(
              '// DON\'T do this. The first LicensePage build will miss', _kCodeComment),
          _CodeLine('// any entry registered after the first frame.', _kCodeComment),
          _CodeLine('runApp(MyApp());', _kCodePlain),
          _CodeLine('// …later, in some initState…', _kCodeComment),
          _CodeLine(
              'LicenseRegistry.addLicense(() async* { /* … */ });',
              _kCodePlain),
        ],
      ),
    ],
  );
}

class _CodeLine {
  const _CodeLine(this.text, this.color);
  final String text;
  final Color color;
}

Widget _buildCodeCard(String title, List<_CodeLine> lines) {
  final List<Widget> _rows = <Widget>[];
  for (int i = 0; i < lines.length; i++) {
    _rows.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 28.0,
            child: Text(
              '${i + 1}'.padLeft(2, '0'),
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: _kCodeComment,
              ),
            ),
          ),
          Expanded(
            child: Text(
              lines[i].text,
              style: _kCodeBase.copyWith(color: lines[i].color),
            ),
          ),
        ],
      ),
    ));
  }
  return Container(
    decoration: BoxDecoration(
      color: _kCodeBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kHairlineOnDark, width: 1.0),
    ),
    padding: const EdgeInsets.all(14.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.code_rounded, color: _kCodeKeyword, size: 16.0),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: _kInkOnDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: _rows),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 8: ABOUTDIALOG MOCK
// ===========================================================================
Widget _buildAboutDialogMock() {
  return Container(
    decoration: BoxDecoration(
      color: _kCanvasDeep,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kHairline),
    ),
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: <Widget>[
        // Mock dialog
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: _kCardBg,
            borderRadius: BorderRadius.circular(14.0),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 18.0,
                offset: Offset(0.0, 8.0),
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(22.0, 22.0, 22.0, 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 48.0,
                    height: 48.0,
                    decoration: BoxDecoration(
                      color: _kAccentBlueSoft,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    alignment: Alignment.center,
                    child: const Icon(Icons.book_outlined,
                        color: _kAccentBlue, size: 26.0),
                  ),
                  const SizedBox(width: 14.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          'Tom Framework Demo',
                          style: TextStyle(
                            fontSize: 17.0,
                            fontWeight: FontWeight.w700,
                            color: _kInk,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          'Version 1.0.0',
                          style: TextStyle(
                            fontSize: 12.5,
                            color: _kInkSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              const Text(
                'A Flutter demo curated by the Tom Framework team.',
                style: _kCardBody,
              ),
              const SizedBox(height: 6.0),
              const Text(
                '© 2026 Tom Framework contributors.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: _kInkTertiary,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 14.0),
              Container(
                height: 1.0,
                color: _kHairline,
              ),
              const SizedBox(height: 12.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  _buildDialogButton('VIEW LICENSES', _kAccentBlue, false),
                  const SizedBox(width: 8.0),
                  _buildDialogButton('CLOSE', _kAccentBlue, true),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'AboutDialog binds together applicationName, applicationVersion, '
          'applicationIcon, applicationLegalese, and a list of "children" '
          'widgets. Tapping VIEW LICENSES navigates to LicensePage.',
          style: _kCardBody,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildDialogButton(String label, Color accent, bool filled) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: filled ? accent : Colors.transparent,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: accent, width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        color: filled ? Colors.white : accent,
        letterSpacing: 1.0,
      ),
    ),
  );
}

// ===========================================================================
// SECTION 9: LICENSEPAGE MOCK
// ===========================================================================
Widget _buildLicensePageMock(
  List<LicenseEntryWithLineBreaks> entries,
  List<List<LicenseParagraph>> paragraphLists,
) {
  return Container(
    decoration: BoxDecoration(
      color: _kCanvasDeep,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: _kHairline),
    ),
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: <Widget>[
        // Phone frame
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: _kCardBg,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: _kHairlineDeep, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Faux AppBar
              Container(
                padding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 10.0),
                decoration: const BoxDecoration(
                  color: _kCanvasDeep,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
                ),
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.arrow_back, size: 18.0, color: _kInk),
                    const SizedBox(width: 12.0),
                    const Expanded(
                      child: Text(
                        'Licenses',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                          color: _kInk,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1.0, color: _kHairline),
              // Header with applicationName
              Container(
                padding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 10.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: _kAccentBlueSoft,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.book_outlined,
                          color: _kAccentBlue, size: 22.0),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'Tom Framework Demo',
                            style: TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                              color: _kInk,
                            ),
                          ),
                          Text(
                            'Version 1.0.0',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: _kInkSecondary,
                            ),
                          ),
                          Text(
                            '© 2026 Tom Framework contributors',
                            style: TextStyle(
                              fontSize: 11.5,
                              color: _kInkTertiary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1.0, color: _kHairline),
              // List of license tiles
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: _buildLicenseTiles(entries, paragraphLists),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        const Text(
          'LicensePage groups entries by their first package. Tapping a tile '
          'pushes a detail route that streams the LicenseParagraph sequence '
          'with the appropriate indent stops. The mock above shows the '
          'top-level list with paragraph counts.',
          style: _kCardBody,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

List<Widget> _buildLicenseTiles(
  List<LicenseEntryWithLineBreaks> entries,
  List<List<LicenseParagraph>> paragraphLists,
) {
  final List<Widget> _out = <Widget>[];
  for (int i = 0; i < entries.length; i++) {
    final LicenseEntryWithLineBreaks _e = entries[i];
    final List<LicenseParagraph> _ps = paragraphLists[i];
    final List<String> _pkgs = _e.packages.toList();
    _out.add(_buildLicenseTile(_pkgs, _ps.length, i == entries.length - 1));
  }
  return _out;
}

Widget _buildLicenseTile(
    List<String> packages, int paragraphCount, bool isLast) {
  return Container(
    padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 12.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: isLast ? Colors.transparent : _kHairline,
          width: 1.0,
        ),
      ),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                packages.first,
                style: const TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: _kInk,
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                packages.length == 1
                    ? '1 license'
                    : '${packages.length} packages, $paragraphCount paragraphs',
                style: const TextStyle(
                  fontSize: 11.5,
                  color: _kInkSecondary,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right, size: 18.0, color: _kInkTertiary),
      ],
    ),
  );
}

// ===========================================================================
// SECTION 10: ABOUTLISTTILE MOCK
// ===========================================================================
Widget _buildAboutListTileMock() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          color: _kCardBg,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: _kHairline),
        ),
        padding: const EdgeInsets.fromLTRB(14.0, 12.0, 14.0, 12.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              decoration: BoxDecoration(
                color: _kAccentBlueSoft,
                borderRadius: BorderRadius.circular(8.0),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.info_outline,
                  color: _kAccentBlue, size: 20.0),
            ),
            const SizedBox(width: 14.0),
            const Expanded(
              child: Text(
                'About Tom Framework Demo',
                style: TextStyle(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w600,
                  color: _kInk,
                ),
              ),
            ),
            const Icon(Icons.open_in_new, size: 16.0, color: _kInkTertiary),
          ],
        ),
      ),
      const SizedBox(height: 12.0),
      Container(
        decoration: BoxDecoration(
          color: _kCardSoft,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: _kHairline),
        ),
        padding: const EdgeInsets.all(14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('AboutListTile fields', style: _kCardTitle),
            const SizedBox(height: 10.0),
            _buildAnatomyRow('icon', 'Widget?', 'Leading icon. Defaults to a placeholder.'),
            _buildAnatomyRow(
                'applicationName',
                'String?',
                'Falls back to Title widget in the surrounding scope.'),
            _buildAnatomyRow('applicationVersion', 'String?',
                'Free-form. Typical format: "1.0.0+123".'),
            _buildAnatomyRow('applicationIcon', 'Widget?',
                'Rendered next to the name in AboutDialog and LicensePage.'),
            _buildAnatomyRow(
                'applicationLegalese',
                'String?',
                'Short copyright/legalese line. Multi-line strings render '
                    'verbatim.'),
            _buildAnatomyRow(
                'aboutBoxChildren',
                'List<Widget>?',
                'Extra widgets shown in the AboutDialog between the '
                    'legalese and the action buttons.'),
            _buildAnatomyRow('child', 'Widget?',
                'Custom title for the tile. Defaults to "About {name}".'),
            _buildAnatomyRow('dense', 'bool?', 'ListTile density toggle.'),
          ],
        ),
      ),
    ],
  );
}

// ===========================================================================
// SECTION 11: PITFALLS PANEL
// ===========================================================================
Widget _buildPitfallsPanel() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildPitfallRow(
        Icons.warning_amber_rounded,
        _kAccentAmber,
        _kAccentAmberSoft,
        'Register before runApp().',
        'addLicense() called after the first build will not show up until '
            'the LicensePage rebuilds. Always seed the registry in main().',
      ),
      _buildPitfallRow(
        Icons.timer_off_outlined,
        _kAccentRed,
        _kAccentRedSoft,
        'Generators run lazily.',
        'The closure you hand to addLicense is invoked when the registry '
            'reads its stream. Heavy I/O is fine, but it delays first paint '
            'of LicensePage.',
      ),
      _buildPitfallRow(
        Icons.merge_type_rounded,
        _kAccentTeal,
        _kAccentTealSoft,
        'Group related packages.',
        'Pass multiple package names to a single LicenseEntry if they '
            'share the same license text. Avoids duplicate scrolling.',
      ),
      _buildPitfallRow(
        Icons.text_fields_rounded,
        _kAccentBlue,
        _kAccentBlueSoft,
        'Mind the line breaks.',
        'LicenseEntryWithLineBreaks treats blank lines as paragraph '
            'separators. Single newlines stay inside the current paragraph.',
      ),
      _buildPitfallRow(
        Icons.format_align_center_rounded,
        _kAccentViolet,
        _kAccentVioletSoft,
        'centeredIndent for titles.',
        'A line whose leading whitespace centres it (more than ~half of '
            'the surrounding text width) is reported as centeredIndent. '
            'Use it to render license headers.',
      ),
      _buildPitfallRow(
        Icons.shield_outlined,
        _kAccentGreen,
        _kAccentGreenSoft,
        'Treat the registry as append-only.',
        'There is no public removeLicense API. If you need to mutate the '
            'set, gate registration on a feature flag before calling '
            'addLicense.',
      ),
      _buildPitfallRow(
        Icons.refresh_rounded,
        _kAccentAmber,
        _kAccentAmberSoft,
        'Hot reload preserves collectors.',
        'In dev mode you may end up with duplicates after a hot reload. '
            'Wrap main() side-effects in an idempotent guard.',
      ),
      _buildPitfallRow(
        Icons.bug_report_outlined,
        _kAccentRed,
        _kAccentRedSoft,
        'Beware long paragraphs.',
        'A single super-long paragraph is rendered as one Text widget. '
            'Pre-wrap aggressively for performance on small screens.',
      ),
    ],
  );
}

Widget _buildPitfallRow(IconData icon, Color accent, Color accentSoft,
    String title, String body) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Container(
      decoration: BoxDecoration(
        color: _kCardBg,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: _kHairline),
      ),
      padding: const EdgeInsets.all(12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 34.0,
            height: 34.0,
            decoration: BoxDecoration(
              color: accentSoft,
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: accent, size: 18.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w700,
                    color: _kInk,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(body, style: _kCardBody),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ===========================================================================
// SECTION 12: CHEAT-SHEET
// ===========================================================================
Widget _buildCheatSheet() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      _buildChipGroup(
        'foundation/licenses.dart',
        const <String>[
          'LicenseEntry',
          'LicenseParagraph',
          'LicenseEntryWithLineBreaks',
          'LicenseRegistry',
          'LicenseEntryCollector',
        ],
        _kAccent,
        _kAccentSoft,
      ),
      const SizedBox(height: 10.0),
      _buildChipGroup(
        'material/about.dart',
        const <String>[
          'AboutListTile',
          'AboutDialog',
          'showAboutDialog',
          'LicensePage',
          'showLicensePage',
        ],
        _kAccentBlue,
        _kAccentBlueSoft,
      ),
      const SizedBox(height: 10.0),
      _buildChipGroup(
        'getters / methods worth memorising',
        const <String>[
          'entry.packages',
          'entry.paragraphs',
          'paragraph.indent',
          'paragraph.text',
          'LicenseParagraph.centeredIndent',
          'LicenseRegistry.addLicense',
          'LicenseRegistry.licenses',
        ],
        _kAccentTeal,
        _kAccentTealSoft,
      ),
      const SizedBox(height: 10.0),
      _buildChipGroup(
        'common app-shell call sites',
        const <String>[
          'main() — addLicense',
          'Drawer — AboutListTile',
          'Settings — showAboutDialog',
          'Help screen — showLicensePage',
        ],
        _kAccentViolet,
        _kAccentVioletSoft,
      ),
    ],
  );
}

Widget _buildChipGroup(
    String title, List<String> items, Color accent, Color accentSoft) {
  final List<Widget> _chips = <Widget>[];
  for (int i = 0; i < items.length; i++) {
    _chips.add(Container(
      margin: const EdgeInsets.only(right: 6.0, bottom: 6.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      decoration: BoxDecoration(
        color: accentSoft,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: accent.withOpacity(0.4), width: 1.0),
      ),
      child: Text(
        items[i],
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w700,
          color: accent,
          fontFamily: 'monospace',
        ),
      ),
    ));
  }
  return Container(
    decoration: BoxDecoration(
      color: _kCardBg,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: _kHairline),
    ),
    padding: const EdgeInsets.all(12.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title.toUpperCase(),
            style: TextStyle(
              fontSize: 11.0,
              color: accent,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.0,
            )),
        const SizedBox(height: 8.0),
        Wrap(children: _chips),
      ],
    ),
  );
}

// ===========================================================================
// FOOTER
// ===========================================================================
Widget _buildFooter(double stampScale) {
  return Container(
    decoration: BoxDecoration(
      color: _kCardDark,
      borderRadius: BorderRadius.circular(12.0),
    ),
    padding: const EdgeInsets.all(18.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Transform.scale(
          scale: stampScale,
          child: Container(
            width: 64.0,
            height: 64.0,
            decoration: BoxDecoration(
              border: Border.all(color: _kStamp, width: 2.0),
              borderRadius: BorderRadius.circular(8.0),
              color: const Color(0x1AB22222),
            ),
            alignment: Alignment.center,
            child: const Text(
              'D4RT\nLICENSE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10.0,
                color: _kStamp,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                height: 1.1,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16.0),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'End of demo',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w800,
                  color: _kInkOnDark,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'This script demonstrates the LicenseEntry / '
                'LicenseRegistry / LicensePage triplet without performing '
                'any registration at evaluation time. Real Tom Framework '
                'apps register their licenses in main() — see the recipe '
                'cards above for the canonical pattern.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: _kInkOnDarkSecondary,
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
