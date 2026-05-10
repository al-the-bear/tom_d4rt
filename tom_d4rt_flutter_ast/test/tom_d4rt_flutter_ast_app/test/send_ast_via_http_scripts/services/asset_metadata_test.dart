// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';

// ============================================================================
// AssetMetadata — Visual Deep Demo
// ============================================================================
//
// This file is a long-form, hand-authored visual study of the
// `AssetMetadata` value class from `package:flutter/services.dart`,
// re-exported via `package:flutter/material.dart`.
//
// AssetMetadata is the small but pivotal record that the asset bundle
// machinery uses to describe a single physical asset variant on disk.
// It carries three pieces of information:
//
//   • key                       — the asset path (e.g. "assets/2.0x/logo.png")
//   • targetDevicePixelRatio    — the DPR this variant is optimised for
//   • main                      — whether this is the "main" declared asset
//                                 (i.e. the one listed in pubspec.yaml) or
//                                 a supplemental variant discovered next to
//                                 it (e.g. the 2.0x or 3.0x folder).
//
// In this demo we render — declaratively, without any state, controllers,
// timers, or futures — a layered visual encyclopedia covering:
//
//   1. Hero header
//   2. Anatomy of AssetMetadata fields
//   3. Sample AssetMetadata records as cards
//   4. targetDevicePixelRatio resolution table
//   5. AssetManifest tree visualization
//   6. Variant resolution algorithm pseudo-code card
//   7. Relationship to AssetImage and AssetBundle
//   8. The `main` flag — bundled vs supplemental
//   9. Pitfalls and gotchas
//  10. A glossary
//  11. A footer
//
// Everything is built from primitive widgets and color tokens. There is
// no interactive surface — the goal is to pack as much information as
// possible into a single, reproducible build() pass.
// ============================================================================

// ----------------------------------------------------------------------------
// Section A: Color tokens
// ----------------------------------------------------------------------------
//
// We use a deliberately small palette tuned for "documentation surface"
// rendering: a neutral parchment, a couple of accent inks, and a small
// set of badge backgrounds.

const Color _inkPrimary = Color(0xFF1B2735);
const Color _inkSecondary = Color(0xFF425466);
const Color _inkMuted = Color(0xFF8A94A6);
const Color _parchment = Color(0xFFF7F6F2);
const Color _parchmentEdge = Color(0xFFEDEAE0);
const Color _accentTeal = Color(0xFF1F7A8C);
const Color _accentMagenta = Color(0xFFB5179E);
const Color _accentAmber = Color(0xFFE9B44C);
const Color _accentForest = Color(0xFF2E7D32);
const Color _accentRust = Color(0xFFC0392B);
const Color _badgeBlue = Color(0xFF3F51B5);
const Color _badgeIndigo = Color(0xFF283593);
const Color _badgeSlate = Color(0xFF546E7A);
const Color _surfaceCard = Color(0xFFFFFFFF);
const Color _surfaceCardEdge = Color(0xFFE0DDD2);
const Color _codeBg = Color(0xFF1E1E2E);
const Color _codeFg = Color(0xFFCDD6F4);
const Color _codeKey = Color(0xFFCBA6F7);
const Color _codeStr = Color(0xFFA6E3A1);
const Color _codeNum = Color(0xFFFAB387);
const Color _codeCom = Color(0xFF7F849C);

// ----------------------------------------------------------------------------
// Section B: Light primitives
// ----------------------------------------------------------------------------
//
// The following helpers build small pieces of UI. They are pure functions
// returning Widgets; they never read from state.

Widget _gap(double height) {
  return SizedBox(height: height);
}

Widget _gapW(double width) {
  return SizedBox(width: width);
}

Widget _divider({Color color = _parchmentEdge, double thickness = 1}) {
  return Container(
    height: thickness,
    color: color,
  );
}

Widget _pill({
  required String label,
  Color background = _badgeBlue,
  Color foreground = Colors.white,
  double fontSize = 11,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(999),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: foreground,
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _chip({
  required String label,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      border: Border.all(color: color.withValues(alpha: 0.5)),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _sectionTitle(String number, String title, {String? subtitle}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(4, 28, 4, 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: _accentTeal,
            borderRadius: BorderRadius.circular(8),
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
        ),
        _gapW(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: _inkPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.2,
                ),
              ),
              if (subtitle != null)
                Padding(
                  padding: EdgeInsets.only(top: 2),
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      color: _inkMuted,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w500,
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

Widget _codeLine(List<_Tok> tokens) {
  return RichText(
    text: TextSpan(
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 12.5,
        height: 1.5,
        color: _codeFg,
      ),
      children: tokens.map((t) => t.toSpan()).toList(),
    ),
  );
}

class _Tok {
  final String text;
  final Color color;
  final FontWeight? weight;
  const _Tok(this.text, this.color, {this.weight});

  TextSpan toSpan() {
    return TextSpan(
      text: text,
      style: TextStyle(color: color, fontWeight: weight),
    );
  }
}

_Tok _tk(String s) => _Tok(s, _codeFg);
_Tok _tkKey(String s) => _Tok(s, _codeKey, weight: FontWeight.w600);
_Tok _tkStr(String s) => _Tok(s, _codeStr);
_Tok _tkNum(String s) => _Tok(s, _codeNum);
_Tok _tkCom(String s) => _Tok(s, _codeCom);

// ----------------------------------------------------------------------------
// Section C: AssetMetadata sample records
// ----------------------------------------------------------------------------
//
// We define a small in-file mirror of AssetMetadata so we can render
// example data as illustrative cards. The real class lives in
// package:flutter/services.dart; this is purely a documentation prop.

class _DemoAssetMetadata {
  final String key;
  final double? targetDevicePixelRatio;
  final bool main;
  const _DemoAssetMetadata({
    required this.key,
    required this.targetDevicePixelRatio,
    required this.main,
  });
}

const List<_DemoAssetMetadata> _samples = <_DemoAssetMetadata>[
  _DemoAssetMetadata(
    key: 'assets/images/logo.png',
    targetDevicePixelRatio: null,
    main: true,
  ),
  _DemoAssetMetadata(
    key: 'assets/images/2.0x/logo.png',
    targetDevicePixelRatio: 2.0,
    main: false,
  ),
  _DemoAssetMetadata(
    key: 'assets/images/3.0x/logo.png',
    targetDevicePixelRatio: 3.0,
    main: false,
  ),
  _DemoAssetMetadata(
    key: 'assets/icons/star.png',
    targetDevicePixelRatio: 1.0,
    main: true,
  ),
];

// ----------------------------------------------------------------------------
// Section D: DPR resolution rows
// ----------------------------------------------------------------------------

class _DprRow {
  final double dpr;
  final String device;
  final String chosenVariant;
  final double? chosenTargetDpr;
  const _DprRow({
    required this.dpr,
    required this.device,
    required this.chosenVariant,
    required this.chosenTargetDpr,
  });
}

const List<_DprRow> _dprRows = <_DprRow>[
  _DprRow(
    dpr: 1.0,
    device: 'Older phone, low-DPI desktop',
    chosenVariant: 'assets/images/logo.png',
    chosenTargetDpr: null,
  ),
  _DprRow(
    dpr: 1.5,
    device: 'Some Android tablets',
    chosenVariant: 'assets/images/2.0x/logo.png',
    chosenTargetDpr: 2.0,
  ),
  _DprRow(
    dpr: 2.0,
    device: 'iPhone @2x',
    chosenVariant: 'assets/images/2.0x/logo.png',
    chosenTargetDpr: 2.0,
  ),
  _DprRow(
    dpr: 2.625,
    device: 'Pixel 5 @2.625x',
    chosenVariant: 'assets/images/3.0x/logo.png',
    chosenTargetDpr: 3.0,
  ),
  _DprRow(
    dpr: 3.0,
    device: 'iPhone @3x',
    chosenVariant: 'assets/images/3.0x/logo.png',
    chosenTargetDpr: 3.0,
  ),
  _DprRow(
    dpr: 4.0,
    device: 'High-DPI device, no 4x variant',
    chosenVariant: 'assets/images/3.0x/logo.png',
    chosenTargetDpr: 3.0,
  ),
];

// ----------------------------------------------------------------------------
// Section E: Manifest tree nodes
// ----------------------------------------------------------------------------

class _TreeNode {
  final String name;
  final String? annotation;
  final bool isFile;
  final List<_TreeNode> children;
  final Color accent;
  const _TreeNode({
    required this.name,
    required this.isFile,
    this.annotation,
    this.children = const [],
    this.accent = _inkSecondary,
  });
}

const _TreeNode _manifestTree = _TreeNode(
  name: 'assets/',
  isFile: false,
  accent: _accentTeal,
  children: <_TreeNode>[
    _TreeNode(
      name: 'images/',
      isFile: false,
      accent: _accentTeal,
      children: <_TreeNode>[
        _TreeNode(
          name: 'logo.png',
          isFile: true,
          annotation: 'main · DPR: null (1.0 nominal)',
          accent: _accentForest,
        ),
        _TreeNode(
          name: '2.0x/',
          isFile: false,
          accent: _accentAmber,
          children: <_TreeNode>[
            _TreeNode(
              name: 'logo.png',
              isFile: true,
              annotation: 'variant · DPR: 2.0',
              accent: _accentAmber,
            ),
          ],
        ),
        _TreeNode(
          name: '3.0x/',
          isFile: false,
          accent: _accentMagenta,
          children: <_TreeNode>[
            _TreeNode(
              name: 'logo.png',
              isFile: true,
              annotation: 'variant · DPR: 3.0',
              accent: _accentMagenta,
            ),
          ],
        ),
      ],
    ),
    _TreeNode(
      name: 'icons/',
      isFile: false,
      accent: _accentTeal,
      children: <_TreeNode>[
        _TreeNode(
          name: 'star.png',
          isFile: true,
          annotation: 'main · DPR: 1.0',
          accent: _accentForest,
        ),
      ],
    ),
    _TreeNode(
      name: 'data/',
      isFile: false,
      accent: _accentTeal,
      children: <_TreeNode>[
        _TreeNode(
          name: 'config.json',
          isFile: true,
          annotation: 'main · non-image asset',
          accent: _accentForest,
        ),
      ],
    ),
  ],
);

// ----------------------------------------------------------------------------
// Section F: Pitfalls
// ----------------------------------------------------------------------------

class _Pitfall {
  final String title;
  final String body;
  final IconData icon;
  final Color color;
  const _Pitfall({
    required this.title,
    required this.body,
    required this.icon,
    required this.color,
  });
}

const List<_Pitfall> _pitfalls = <_Pitfall>[
  _Pitfall(
    title: 'Stale AssetManifest',
    body: 'Adding a file under assets/2.0x/ but forgetting hot restart leaves '
        'the manifest cached. AssetMetadata for the new variant will be '
        'missing and AssetImage will silently fall back to main.',
    icon: Icons.refresh,
    color: _accentAmber,
  ),
  _Pitfall(
    title: 'Missing variant on high-DPR device',
    body: 'If only the 1.0 main asset exists, a 3x device upscales it. '
        'AssetImage picks the best available, but visual fidelity drops. '
        'Always ship at least 2x for icons used on phones.',
    icon: Icons.broken_image_outlined,
    color: _accentRust,
  ),
  _Pitfall(
    title: 'Wrong folder name format',
    body: 'Variant folders MUST match the regex /^[0-9]+(\\.[0-9]+)?x\$/ — '
        'e.g. 2.0x, 1.5x, 3x. A folder named "@2x/" or "x2/" is treated as '
        'a regular path; AssetMetadata for it gets DPR null.',
    icon: Icons.text_fields,
    color: _accentMagenta,
  ),
  _Pitfall(
    title: 'Non-image variants',
    body: 'Variant resolution is enabled for all asset types, but only '
        'images (and a few others) are typically authored at multiple DPRs. '
        'A 2.0x/config.json is technically valid yet semantically meaningless.',
    icon: Icons.help_outline,
    color: _accentTeal,
  ),
  _Pitfall(
    title: 'main flag misread',
    body: 'A common mental bug: assuming main=true means "the chosen one '
        'for this device". It does not. main=true means "this entry was '
        'declared in pubspec.yaml" — independent of DPR selection.',
    icon: Icons.flag_outlined,
    color: _accentForest,
  ),
  _Pitfall(
    title: 'Per-bundle resolution',
    body: 'AssetMetadata is interpreted by an AssetBundle; different '
        'bundles (rootBundle, NetworkAssetBundle, custom) may surface '
        'different sets of variants. Don\'t assume the manifest is global.',
    icon: Icons.layers_outlined,
    color: _badgeIndigo,
  ),
];

// ----------------------------------------------------------------------------
// Section G: Glossary entries
// ----------------------------------------------------------------------------

class _Glossary {
  final String term;
  final String definition;
  const _Glossary({required this.term, required this.definition});
}

const List<_Glossary> _glossary = <_Glossary>[
  _Glossary(
    term: 'AssetBundle',
    definition: 'Abstract source of byte data for assets; rootBundle is the '
        'app-wide default, backed by the platform asset reader.',
  ),
  _Glossary(
    term: 'AssetManifest',
    definition: 'Index of every asset (and its variants) declared in '
        'pubspec.yaml. Built at compile time, served by the bundle.',
  ),
  _Glossary(
    term: 'AssetMetadata',
    definition: 'Per-variant description: key, targetDevicePixelRatio, main.',
  ),
  _Glossary(
    term: 'AssetImage',
    definition: 'ImageProvider that resolves a logical asset key into the '
        'best variant for the current devicePixelRatio.',
  ),
  _Glossary(
    term: 'devicePixelRatio',
    definition: 'Physical pixels per logical pixel for the current view.',
  ),
  _Glossary(
    term: 'main asset',
    definition: 'The asset entry literally listed in pubspec.yaml; '
        'discovered variants are non-main siblings.',
  ),
  _Glossary(
    term: 'variant',
    definition: 'A DPR-tagged copy of a main asset, sitting in an N.Nx '
        'subfolder next to the main file.',
  ),
];

// ============================================================================
// build()  —  the entrypoint required by the demo harness
// ============================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'AssetMetadata Visual Deep Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      primaryColor: _accentTeal,
      scaffoldBackgroundColor: _parchment,
      fontFamily: 'Roboto',
    ),
    home: Scaffold(
      backgroundColor: _parchment,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(28, 24, 28, 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _heroBanner(),
              _gap(12),
              _tableOfContents(),
              _sectionTitle('1', 'What is AssetMetadata?',
                  subtitle:
                      'A tiny value type with a giant role in asset routing.'),
              _whatIsCard(),
              _sectionTitle('2', 'Anatomy of the fields',
                  subtitle: 'Three fields, three responsibilities.'),
              _anatomyCard(),
              _sectionTitle('3', 'Sample records as cards',
                  subtitle: 'Concrete examples of AssetMetadata instances.'),
              _samplesGrid(),
              _sectionTitle('4', 'targetDevicePixelRatio resolution',
                  subtitle: 'Which variant gets picked for each device DPR.'),
              _dprTable(),
              _sectionTitle('5', 'AssetManifest tree',
                  subtitle: 'The on-disk layout that produces the manifest.'),
              _manifestTreeCard(),
              _sectionTitle('6', 'Variant resolution algorithm',
                  subtitle: 'How AssetImage chooses among AssetMetadata rows.'),
              _algorithmCard(),
              _sectionTitle('7', 'Relationship to AssetImage / AssetBundle',
                  subtitle: 'Where AssetMetadata sits in the pipeline.'),
              _relationshipCard(),
              _sectionTitle('8', 'The `main` flag',
                  subtitle: 'Bundled vs supplemental; declaration vs choice.'),
              _mainFlagCard(),
              _sectionTitle('9', 'Pitfalls and gotchas',
                  subtitle: 'Sharp corners worth memorising.'),
              _pitfallsList(),
              _sectionTitle('10', 'Glossary',
                  subtitle: 'Terms used throughout this demo.'),
              _glossaryList(),
              _sectionTitle('11', 'Mental model summary',
                  subtitle: 'One picture worth a thousand bytes.'),
              _mentalModelCard(),
              _gap(40),
              _footer(),
            ],
          ),
        ),
      ),
    ),
  );
}

// ----------------------------------------------------------------------------
// Hero banner
// ----------------------------------------------------------------------------

Widget _heroBanner() {
  return Container(
    padding: EdgeInsets.fromLTRB(28, 28, 28, 28),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          _inkPrimary,
          Color(0xFF243447),
          _accentTeal,
        ],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _inkPrimary.withValues(alpha: 0.25),
          blurRadius: 30,
          offset: Offset(0, 14),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _pill(
              label: 'package:flutter/services.dart',
              background: Colors.white.withValues(alpha: 0.18),
            ),
            _gapW(8),
            _pill(
              label: 'value-class · @immutable',
              background: _accentAmber,
              foreground: _inkPrimary,
            ),
            _gapW(8),
            _pill(
              label: 'since Flutter 3.10+',
              background: Colors.white.withValues(alpha: 0.18),
            ),
          ],
        ),
        _gap(18),
        Text(
          'AssetMetadata',
          style: TextStyle(
            color: Colors.white,
            fontSize: 44,
            fontWeight: FontWeight.w900,
            letterSpacing: -1.0,
            height: 1.05,
          ),
        ),
        _gap(6),
        Text(
          'Per-variant description used by AssetBundle and AssetImage.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        _gap(18),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.16),
            ),
          ),
          child: _codeLine(<_Tok>[
            _tkKey('class '),
            _Tok('AssetMetadata ', _codeFg, weight: FontWeight.w700),
            _tk('{ '),
            _tkKey('final '),
            _Tok('String ', _codeNum),
            _tk('key; '),
            _tkKey('final '),
            _Tok('double? ', _codeNum),
            _tk('targetDevicePixelRatio; '),
            _tkKey('final '),
            _Tok('bool ', _codeNum),
            _tk('main; }'),
          ]),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Table of contents
// ----------------------------------------------------------------------------

Widget _tableOfContents() {
  final List<List<String>> rows = <List<String>>[
    <String>['1', 'What is AssetMetadata?'],
    <String>['2', 'Anatomy of the fields'],
    <String>['3', 'Sample records as cards'],
    <String>['4', 'targetDevicePixelRatio resolution'],
    <String>['5', 'AssetManifest tree'],
    <String>['6', 'Variant resolution algorithm'],
    <String>['7', 'Relationship to AssetImage / AssetBundle'],
    <String>['8', 'The `main` flag'],
    <String>['9', 'Pitfalls and gotchas'],
    <String>['10', 'Glossary'],
    <String>['11', 'Mental model summary'],
  ];
  return Container(
    padding: EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _surfaceCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _surfaceCardEdge),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.menu_book_outlined,
                size: 18, color: _accentTeal),
            _gapW(8),
            Text(
              'Contents',
              style: TextStyle(
                color: _inkPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        _gap(10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: rows.map<Widget>((List<String> r) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _parchment,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: _parchmentEdge),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      color: _accentTeal.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      r[0],
                      style: TextStyle(
                        color: _accentTeal,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  _gapW(8),
                  Text(
                    r[1],
                    style: TextStyle(
                      color: _inkSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 1: What is AssetMetadata?
// ----------------------------------------------------------------------------

Widget _whatIsCard() {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: _surfaceCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _surfaceCardEdge),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'AssetMetadata is the smallest possible value-object capable of '
          'describing one physical asset variant on disk in a way that '
          'AssetImage and the AssetManifest can consume to make resolution '
          'decisions.',
          style: TextStyle(
            color: _inkPrimary,
            fontSize: 14,
            height: 1.55,
            fontWeight: FontWeight.w500,
          ),
        ),
        _gap(12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _miniFact(
                  icon: Icons.fingerprint,
                  color: _badgeBlue,
                  title: 'Identity',
                  body:
                      'The `key` is the canonical asset path — the same string '
                      'you would pass to AssetImage("…")'),
            ),
            _gapW(12),
            Expanded(
              child: _miniFact(
                  icon: Icons.zoom_in,
                  color: _accentAmber,
                  title: 'DPR target',
                  body:
                      '`targetDevicePixelRatio` (nullable double) tells the '
                      'resolver which screen density this file is sharpest at.'),
            ),
            _gapW(12),
            Expanded(
              child: _miniFact(
                  icon: Icons.flag,
                  color: _accentForest,
                  title: 'Origin',
                  body: '`main` is true if the file appears literally in '
                      'pubspec.yaml; false if it is an auto-discovered '
                      'sibling variant.'),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _miniFact({
  required IconData icon,
  required Color color,
  required String title,
  required String body,
}) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, size: 18, color: color),
            _gapW(6),
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        _gap(8),
        Text(
          body,
          style: TextStyle(
            color: _inkSecondary,
            fontSize: 12.5,
            height: 1.5,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 2: Anatomy of the fields
// ----------------------------------------------------------------------------

Widget _anatomyCard() {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: _surfaceCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _surfaceCardEdge),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _anatomyRow(
          field: 'key',
          type: 'String',
          color: _accentTeal,
          icon: Icons.vpn_key_outlined,
          examples: const <String>[
            '"assets/images/logo.png"',
            '"assets/icons/star.png"',
            '"assets/data/config.json"',
          ],
          note:
              'The asset path as it appears in the manifest. Always relative '
              'to the project root. Used directly as a lookup key in the '
              'rootBundle (or any AssetBundle).',
        ),
        _gap(14),
        _divider(),
        _gap(14),
        _anatomyRow(
          field: 'targetDevicePixelRatio',
          type: 'double?',
          color: _accentAmber,
          icon: Icons.zoom_in,
          examples: const <String>[
            'null    // unspecified / nominal 1.0',
            '1.0     // explicit 1x asset',
            '2.0     // 2x variant',
            '3.0     // 3x variant',
            '1.5     // some Android devices',
          ],
          note: 'Nullable. When null, the asset has no advertised DPR — '
              'it is treated as the "default" representation. Otherwise it '
              'represents the DPR at which this file matches 1 logical px '
              '= 1 device px.',
        ),
        _gap(14),
        _divider(),
        _gap(14),
        _anatomyRow(
          field: 'main',
          type: 'bool',
          color: _accentForest,
          icon: Icons.flag_outlined,
          examples: const <String>[
            'true    // listed in pubspec.yaml',
            'false   // auto-discovered variant',
          ],
          note: 'Tells you whether the asset entry was declared by the '
              'developer or discovered by the build. Useful when you want '
              'to enumerate "all top-level assets" without including their '
              '2x/3x duplicates.',
        ),
      ],
    ),
  );
}

Widget _anatomyRow({
  required String field,
  required String type,
  required Color color,
  required IconData icon,
  required List<String> examples,
  required String note,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: color, size: 26),
      ),
      _gapW(16),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  field,
                  style: TextStyle(
                    color: _inkPrimary,
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
                _gapW(10),
                _chip(label: type, color: color),
              ],
            ),
            _gap(6),
            Text(
              note,
              style: TextStyle(
                color: _inkSecondary,
                fontSize: 13,
                height: 1.55,
                fontWeight: FontWeight.w500,
              ),
            ),
            _gap(10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: _codeBg,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: examples.map<Widget>((String e) {
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 1),
                    child: Text(
                      e,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        color: _codeFg,
                        fontSize: 12.5,
                        height: 1.45,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

// ----------------------------------------------------------------------------
// Section 3: Sample records as cards
// ----------------------------------------------------------------------------

Widget _samplesGrid() {
  return Wrap(
    spacing: 14,
    runSpacing: 14,
    children: _samples.map<Widget>(_sampleCard).toList(),
  );
}

Widget _sampleCard(_DemoAssetMetadata m) {
  final Color tint = m.main
      ? _accentForest
      : (m.targetDevicePixelRatio == 2.0 ? _accentAmber : _accentMagenta);
  return Container(
    width: 290,
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _surfaceCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _surfaceCardEdge),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _inkPrimary.withValues(alpha: 0.04),
          blurRadius: 14,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: tint,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                m.main ? 'MAIN' : 'VARIANT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
            ),
            Spacer(),
            Text(
              m.targetDevicePixelRatio == null
                  ? 'DPR: —'
                  : 'DPR: ${m.targetDevicePixelRatio!.toStringAsFixed(1)}',
              style: TextStyle(
                color: _inkMuted,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        _gap(10),
        Text(
          m.key,
          style: TextStyle(
            color: _inkPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
        ),
        _gap(10),
        _divider(),
        _gap(10),
        _kv('key', '"${m.key}"', _accentTeal),
        _gap(4),
        _kv(
            'targetDevicePixelRatio',
            m.targetDevicePixelRatio == null
                ? 'null'
                : m.targetDevicePixelRatio!.toString(),
            _accentAmber),
        _gap(4),
        _kv('main', m.main.toString(), _accentForest),
      ],
    ),
  );
}

Widget _kv(String k, String v, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      SizedBox(
        width: 130,
        child: Text(
          k,
          style: TextStyle(
            color: color,
            fontSize: 11.5,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
      ),
      Expanded(
        child: Text(
          v,
          style: TextStyle(
            color: _inkPrimary,
            fontSize: 12,
            fontFamily: 'monospace',
          ),
        ),
      ),
    ],
  );
}

// ----------------------------------------------------------------------------
// Section 4: DPR resolution table
// ----------------------------------------------------------------------------

Widget _dprTable() {
  return Container(
    decoration: BoxDecoration(
      color: _surfaceCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _surfaceCardEdge),
    ),
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: _inkPrimary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(13),
              topRight: Radius.circular(13),
            ),
          ),
          child: Row(
            children: <Widget>[
              _hCell('Device DPR', flex: 2, light: true),
              _hCell('Example device', flex: 4, light: true),
              _hCell('Chosen variant', flex: 6, light: true),
              _hCell('targetDPR', flex: 2, light: true),
            ],
          ),
        ),
        ..._dprRows.map<Widget>(_dprRowWidget),
      ],
    ),
  );
}

Widget _hCell(String s, {required int flex, bool light = false}) {
  return Expanded(
    flex: flex,
    child: Text(
      s,
      style: TextStyle(
        color: light ? Colors.white : _inkPrimary,
        fontSize: 12,
        fontWeight: FontWeight.w800,
        letterSpacing: 0.4,
      ),
    ),
  );
}

Widget _dprRowWidget(_DprRow r) {
  final Color rowAccent = (r.chosenTargetDpr == null)
      ? _accentForest
      : (r.chosenTargetDpr == 2.0 ? _accentAmber : _accentMagenta);
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      border: Border(top: BorderSide(color: _parchmentEdge)),
    ),
    child: Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: rowAccent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              r.dpr.toStringAsFixed(r.dpr.truncateToDouble() == r.dpr ? 1 : 3),
              style: TextStyle(
                color: rowAccent,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
        _gapW(10),
        Expanded(
          flex: 4,
          child: Text(
            r.device,
            style: TextStyle(
              color: _inkSecondary,
              fontSize: 12.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Text(
            r.chosenVariant,
            style: TextStyle(
              color: _inkPrimary,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            r.chosenTargetDpr == null
                ? '—'
                : r.chosenTargetDpr!.toStringAsFixed(1),
            style: TextStyle(
              color: rowAccent,
              fontSize: 12,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 5: Manifest tree
// ----------------------------------------------------------------------------

Widget _manifestTreeCard() {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: _surfaceCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _surfaceCardEdge),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.account_tree_outlined,
                color: _accentTeal, size: 18),
            _gapW(8),
            Text(
              'On-disk asset layout (project root)',
              style: TextStyle(
                color: _inkPrimary,
                fontSize: 14,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        _gap(12),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _codeBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _flattenTree(_manifestTree, 0),
          ),
        ),
        _gap(12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _legendDot(_accentForest, 'main asset (in pubspec.yaml)'),
            _legendDot(_accentAmber, '2.0x variant folder'),
            _legendDot(_accentMagenta, '3.0x variant folder'),
            _legendDot(_accentTeal, 'directory'),
          ],
        ),
        _gap(12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _accentTeal.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _accentTeal.withValues(alpha: 0.25)),
          ),
          child: Text(
            'The build pipeline scans this layout, normalises every leaf into '
            'an AssetMetadata row, and serialises the result into '
            'AssetManifest.bin (formerly AssetManifest.json). Each leaf '
            'becomes one AssetMetadata; each main asset accumulates its '
            'variants as siblings the resolver later considers.',
            style: TextStyle(
              color: _accentTeal,
              fontSize: 12.5,
              height: 1.55,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

List<Widget> _flattenTree(_TreeNode node, int depth) {
  final List<Widget> out = <Widget>[_treeLine(node, depth)];
  for (final _TreeNode child in node.children) {
    out.addAll(_flattenTree(child, depth + 1));
  }
  return out;
}

Widget _treeLine(_TreeNode node, int depth) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 1.5),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: depth * 16.0),
        Text(
          node.isFile ? '──── ' : '┐ ',
          style: TextStyle(
            fontFamily: 'monospace',
            color: _codeCom,
            fontSize: 12,
          ),
        ),
        Icon(
          node.isFile ? Icons.insert_drive_file_outlined : Icons.folder_outlined,
          size: 14,
          color: node.accent,
        ),
        _gapW(6),
        Text(
          node.name,
          style: TextStyle(
            fontFamily: 'monospace',
            color: node.isFile ? _codeFg : node.accent,
            fontSize: 12.5,
            fontWeight: node.isFile ? FontWeight.w500 : FontWeight.w800,
          ),
        ),
        if (node.annotation != null) _gapW(10),
        if (node.annotation != null)
          Text(
            '// ${node.annotation!}',
            style: TextStyle(
              fontFamily: 'monospace',
              color: _codeCom,
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
            ),
          ),
      ],
    ),
  );
}

Widget _legendDot(Color c, String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: c.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: c.withValues(alpha: 0.4)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: c,
            shape: BoxShape.circle,
          ),
        ),
        _gapW(6),
        Text(
          label,
          style: TextStyle(
            color: c,
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 6: Algorithm card
// ----------------------------------------------------------------------------

Widget _algorithmCard() {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: _surfaceCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _surfaceCardEdge),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Pseudo-code: how AssetImage picks a variant',
          style: TextStyle(
            color: _inkPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        _gap(10),
        Container(
          padding: EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _codeBg,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _codeLine(<_Tok>[
                _tkCom('// Inputs: assetKey, deviceDpr, all metadata rows.'),
              ]),
              _codeLine(<_Tok>[
                _tkKey('AssetMetadata '),
                _tk('pickBest('),
                _Tok('String', _codeNum),
                _tk(' assetKey, '),
                _Tok('double', _codeNum),
                _tk(' deviceDpr,'),
              ]),
              _codeLine(<_Tok>[
                _tk('                       '),
                _Tok('List<AssetMetadata>', _codeNum),
                _tk(' rows) {'),
              ]),
              _codeLine(<_Tok>[
                _tk('  '),
                _tkKey('final '),
                _tk('candidates = rows.where((r) =>'),
              ]),
              _codeLine(<_Tok>[
                _tk('      r.key == assetKey || _isVariantOf(r.key, assetKey));'),
              ]),
              _codeLine(<_Tok>[
                _tk('  '),
                _tkKey('if '),
                _tk('(candidates.isEmpty) '),
                _tkKey('throw '),
                _Tok('FlutterError', _codeNum),
                _tk('(...);'),
              ]),
              _codeLine(<_Tok>[
                _tk('  '),
                _tkCom('// Sort: prefer rows with non-null targetDPR >= deviceDpr.'),
              ]),
              _codeLine(<_Tok>[
                _tk('  candidates.sort((a, b) => _scoreFor(deviceDpr, a)'),
              ]),
              _codeLine(<_Tok>[
                _tk('      .compareTo(_scoreFor(deviceDpr, b)));'),
              ]),
              _codeLine(<_Tok>[
                _tk('  '),
                _tkKey('return '),
                _tk('candidates.first;'),
              ]),
              _codeLine(<_Tok>[_tk('}')]),
              _gap(8),
              _codeLine(<_Tok>[
                _tkCom('// _scoreFor prefers the smallest variant whose'),
              ]),
              _codeLine(<_Tok>[
                _tkCom('// targetDevicePixelRatio is >= deviceDpr; falls back'),
              ]),
              _codeLine(<_Tok>[
                _tkCom('// to the largest available variant if none qualifies.'),
              ]),
              _codeLine(<_Tok>[
                _Tok('double', _codeNum),
                _tk(' _scoreFor('),
                _Tok('double', _codeNum),
                _tk(' dpr, '),
                _Tok('AssetMetadata', _codeNum),
                _tk(' m) {'),
              ]),
              _codeLine(<_Tok>[
                _tk('  '),
                _tkKey('final '),
                _tk('t = m.targetDevicePixelRatio ?? '),
                _tkNum('1.0'),
                _tk(';'),
              ]),
              _codeLine(<_Tok>[
                _tk('  '),
                _tkKey('return '),
                _tk('t >= dpr ? (t - dpr) : ('),
                _tkNum('100.0'),
                _tk(' - t);'),
              ]),
              _codeLine(<_Tok>[_tk('}')]),
            ],
          ),
        ),
        _gap(12),
        _calloutBox(
          color: _badgeIndigo,
          icon: Icons.lightbulb_outline,
          title: 'Key insight',
          body:
              'AssetMetadata is read-only fuel. The selection algorithm is '
              'pure: given the same manifest and the same DPR, it always '
              'returns the same row. There is no caching subtlety inside '
              'AssetMetadata itself — caching happens one layer up, at '
              'AssetBundle / ImageProvider.',
        ),
      ],
    ),
  );
}

Widget _calloutBox({
  required Color color,
  required IconData icon,
  required String title,
  required String body,
}) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: color, size: 20),
        _gapW(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                ),
              ),
              _gap(4),
              Text(
                body,
                style: TextStyle(
                  color: _inkSecondary,
                  fontSize: 12.5,
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

// ----------------------------------------------------------------------------
// Section 7: Relationship diagram
// ----------------------------------------------------------------------------

Widget _relationshipCard() {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: _surfaceCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _surfaceCardEdge),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Pipeline view',
          style: TextStyle(
            color: _inkPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
        _gap(12),
        _pipelineNode(
          color: _accentTeal,
          icon: Icons.folder_special_outlined,
          title: 'pubspec.yaml + assets/ folder',
          body:
              'Source of truth. Developer declares "assets/images/logo.png"; '
              'the build looks for sibling N.Nx folders.',
        ),
        _arrowDown(),
        _pipelineNode(
          color: _badgeIndigo,
          icon: Icons.build_circle_outlined,
          title: 'flutter build  →  AssetManifest.bin',
          body:
              'For every leaf the build emits one AssetMetadata row '
              '(key, targetDevicePixelRatio, main).',
        ),
        _arrowDown(),
        _pipelineNode(
          color: _accentAmber,
          icon: Icons.inventory_2_outlined,
          title: 'AssetBundle.loadStructuredBinaryData(...)  /  AssetManifest',
          body:
              'At runtime AssetManifest.loadFromAssetBundle reads the binary '
              'into a list of AssetMetadata grouped by main key.',
        ),
        _arrowDown(),
        _pipelineNode(
          color: _accentMagenta,
          icon: Icons.image_outlined,
          title: 'AssetImage(key).resolve(ImageConfiguration)',
          body:
              'Picks the best AssetMetadata for ImageConfiguration.devicePixelRatio, '
              'then asks the bundle for the bytes at that key.',
        ),
        _arrowDown(),
        _pipelineNode(
          color: _accentForest,
          icon: Icons.image,
          title: 'Image / DecoratedBox / etc. paint',
          body:
              'The ui.Image is decoded once per (key, scale) and cached in '
              'the ImageCache. AssetMetadata is no longer involved at this '
              'point — it has done its job.',
        ),
      ],
    ),
  );
}

Widget _pipelineNode({
  required Color color,
  required IconData icon,
  required String title,
  required String body,
}) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.35)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: Colors.white, size: 20),
        ),
        _gapW(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: _inkPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
              ),
              _gap(4),
              Text(
                body,
                style: TextStyle(
                  color: _inkSecondary,
                  fontSize: 12.5,
                  height: 1.55,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _arrowDown() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Center(
      child: Icon(Icons.arrow_downward,
          color: _inkMuted, size: 18),
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 8: main flag explainer
// ----------------------------------------------------------------------------

Widget _mainFlagCard() {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: _surfaceCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _surfaceCardEdge),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _mainFlagPanel(
                title: 'main: true',
                color: _accentForest,
                bullets: const <String>[
                  'Listed verbatim in pubspec.yaml under `assets:`',
                  'Used by the developer-facing API (AssetManifest.listAssets)',
                  'Treated as the "logical" identity of the resource',
                  'Always present at least once per declared asset',
                ],
                code: const <String>[
                  '# pubspec.yaml',
                  'flutter:',
                  '  assets:',
                  '    - assets/images/logo.png   # → main: true',
                  '    - assets/icons/star.png    # → main: true',
                ],
              ),
            ),
            _gapW(14),
            Expanded(
              child: _mainFlagPanel(
                title: 'main: false',
                color: _accentMagenta,
                bullets: const <String>[
                  'Auto-discovered next to a main asset',
                  'Lives in an N.Nx subfolder',
                  'Carries a non-null targetDevicePixelRatio',
                  'Never appears in pubspec.yaml directly',
                ],
                code: const <String>[
                  'assets/images/logo.png       # main: true,  DPR: null',
                  'assets/images/2.0x/logo.png  # main: false, DPR: 2.0',
                  'assets/images/3.0x/logo.png  # main: false, DPR: 3.0',
                ],
              ),
            ),
          ],
        ),
        _gap(14),
        _calloutBox(
          color: _badgeBlue,
          icon: Icons.info_outline,
          title: 'Why the distinction matters',
          body:
              'When you call AssetManifest.listAssets() you get only main '
              'entries — the high-level inventory. When you ask AssetImage '
              'for "assets/images/logo.png" on a 3x device, it transparently '
              'walks across non-main siblings to pick assets/images/3.0x/logo.png.',
        ),
      ],
    ),
  );
}

Widget _mainFlagPanel({
  required String title,
  required Color color,
  required List<String> bullets,
  required List<String> code,
}) {
  return Container(
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.07),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: color,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            fontFamily: 'monospace',
          ),
        ),
        _gap(10),
        ...bullets.map<Widget>((String b) => Padding(
              padding: EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 5),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  _gapW(8),
                  Expanded(
                    child: Text(
                      b,
                      style: TextStyle(
                        color: _inkSecondary,
                        fontSize: 12.5,
                        height: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            )),
        _gap(6),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: _codeBg,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: code
                .map<Widget>((String l) => Text(
                      l,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        color: _codeFg,
                        fontSize: 11.5,
                        height: 1.5,
                      ),
                    ))
                .toList(),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 9: Pitfalls list
// ----------------------------------------------------------------------------

Widget _pitfallsList() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: _pitfalls.map<Widget>(_pitfallCard).toList(),
  );
}

Widget _pitfallCard(_Pitfall p) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _surfaceCard,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _surfaceCardEdge),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: p.color.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: p.color.withValues(alpha: 0.45)),
          ),
          alignment: Alignment.center,
          child: Icon(p.icon, color: p.color, size: 22),
        ),
        _gapW(14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    p.title,
                    style: TextStyle(
                      color: _inkPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  _gapW(8),
                  _chip(label: 'PITFALL', color: p.color),
                ],
              ),
              _gap(6),
              Text(
                p.body,
                style: TextStyle(
                  color: _inkSecondary,
                  fontSize: 12.5,
                  height: 1.55,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 10: Glossary
// ----------------------------------------------------------------------------

Widget _glossaryList() {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: _surfaceCard,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _surfaceCardEdge),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _glossary
          .expand<Widget>((_Glossary g) => <Widget>[
                _glossaryRow(g),
                if (g != _glossary.last) _divider(),
              ])
          .toList(),
    ),
  );
}

Widget _glossaryRow(_Glossary g) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 200,
          child: Text(
            g.term,
            style: TextStyle(
              color: _accentTeal,
              fontSize: 13.5,
              fontWeight: FontWeight.w800,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            g.definition,
            style: TextStyle(
              color: _inkSecondary,
              fontSize: 13,
              height: 1.55,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Section 11: Mental model card
// ----------------------------------------------------------------------------

Widget _mentalModelCard() {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          _accentTeal.withValues(alpha: 0.08),
          _accentMagenta.withValues(alpha: 0.06),
        ],
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _accentTeal.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'One-line summary',
          style: TextStyle(
            color: _inkMuted,
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
        _gap(8),
        Text(
          'AssetMetadata = (path, screen-density-tag, was-it-declared?)',
          style: TextStyle(
            color: _inkPrimary,
            fontSize: 22,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.4,
            fontFamily: 'monospace',
          ),
        ),
        _gap(14),
        Text(
          'Everything else — variant resolution, AssetImage scale, AssetBundle '
          'fetch — is built on top of this triple. Internalise the triple, and '
          'the rest of the asset pipeline becomes mechanical.',
          style: TextStyle(
            color: _inkSecondary,
            fontSize: 13.5,
            height: 1.6,
            fontWeight: FontWeight.w500,
          ),
        ),
        _gap(16),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: <Widget>[
            _pill(
              label: 'KEY  →  identity',
              background: _accentTeal,
            ),
            _pill(
              label: 'targetDevicePixelRatio  →  acuity',
              background: _accentAmber,
              foreground: _inkPrimary,
            ),
            _pill(
              label: 'main  →  provenance',
              background: _accentForest,
            ),
          ],
        ),
      ],
    ),
  );
}

// ----------------------------------------------------------------------------
// Footer
// ----------------------------------------------------------------------------

Widget _footer() {
  return Container(
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: _inkPrimary,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.menu_book, color: Colors.white, size: 18),
            _gapW(8),
            Text(
              'AssetMetadata — visual deep demo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        _gap(8),
        Text(
          'Hand-authored, stateless, single-build-pass documentation surface. '
          'No setState, no controllers, no async — every pixel here is a '
          'function of the constants defined at the top of this file.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.78),
            fontSize: 12.5,
            height: 1.55,
            fontWeight: FontWeight.w500,
          ),
        ),
        _gap(12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: <Widget>[
            _pill(
              label: 'Flutter Material',
              background: Colors.white.withValues(alpha: 0.16),
            ),
            _pill(
              label: 'Stateless · Pure',
              background: Colors.white.withValues(alpha: 0.16),
            ),
            _pill(
              label: 'AssetMetadata',
              background: _accentAmber,
              foreground: _inkPrimary,
            ),
          ],
        ),
      ],
    ),
  );
}
