// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, dead_code, unnecessary_import, no_leading_underscores_for_local_identifiers
// D4rt test script: Deep visual demo of advanced package:flutter/foundation.dart.
//
// This file is part of the D4rt flutter-test corpus and is executed by an
// analyzer-free, sandboxed Dart interpreter. The script exports exactly one
// top-level entry point - `dynamic build(BuildContext)` - which the runtime
// invokes a single time. The returned widget tree is then handed straight
// to the host app's renderer.
//
// The rendered output is a long, static poster that walks through the
// advanced corners of `package:flutter/foundation.dart`. Ten thematic
// sections cover:
//
//   1. Hero intro - what foundation.dart contains, framing of the layer.
//   2. TargetPlatform constants matrix - every value (android, fuchsia,
//      iOS, linux, macOS, windows) plus defaultTargetPlatform and
//      debugDefaultTargetPlatformOverride, drawn as a six-tile grid.
//   3. TargetPlatformVariant explainer card - what it is, where it lives
//      (flutter_test only), and how it composes over TargetPlatform.
//   4. Build-mode constants panel - kReleaseMode, kDebugMode, kProfileMode,
//      kIsWeb, kIsWasm; each shown with its current value at script run.
//   5. ChangeNotifier / ValueNotifier / Listenable.merge lifecycle diagram
//      CustomPainter - listener-set, hasListeners gate, dispose, merge fan-in.
//   6. Diagnosticable tree CustomPainter - DiagnosticsNode, DiagnosticsProperty
//      subclasses (Int/Double/Flag/Enum), DiagnosticPropertiesBuilder, and
//      the toDiagnosticsNode/toString chain.
//   7. debugPrint vs print comparison - throttling pump, sync vs flushed.
//   8. Foundation utility cards - BitField, clampDouble, Endian,
//      precisionErrorTolerance, Factory<T>, flagProperty (the helper),
//      with annotated code samples.
//   9. Recipe cards - idiomatic foundation snippets (e.g. read defaultTarget
//      Platform once, dispose ValueNotifier, build flagProperty).
//  10. Pitfalls panel + cheat-sheet footer.
//
// Build-time discipline: no `setState`, no `Timer`, no `Future`, no
// `Stream`, no `async`, no live `AnimationController`, no for-in over a
// BridgedInstance handed back by a Flutter API, and no `Tween.animate(...)
// .value` reads. The script may construct `ChangeNotifier`/`ValueNotifier`
// instances purely to inspect their static fields (`hasListeners` etc.);
// they are never wired to listeners because there is no second build pass.
import 'dart:math' as math;
import 'dart:ui' show FontFeature;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

// ---------------------------------------------------------------------------
// COLOUR & TYPOGRAPHY CONSTANTS
// ---------------------------------------------------------------------------
// Literal ARGB so the poster is theme-independent. The palette borrows from
// a "graphite on porcelain" mood: foundation.dart is the cool, structural
// layer that the rest of Flutter is built on, so a steel-blue accent fits.
const Color _kCanvas = Color(0xFFF3F4F8);
const Color _kCardBg = Color(0xFFFFFFFF);
const Color _kCardSoft = Color(0xFFF7F8FC);
const Color _kCardDark = Color(0xFF161826);
const Color _kHairline = Color(0x14000000);
const Color _kHairlineDark = Color(0x33FFFFFF);
const Color _kInk = Color(0xFF181A24);
const Color _kInkSecondary = Color(0xFF424657);
const Color _kInkTertiary = Color(0xFF8C90A1);
const Color _kInkOnDark = Color(0xFFEDEEF5);
const Color _kInkOnDarkSecondary = Color(0xFFA3A6B8);
const Color _kAccent = Color(0xFF1D4ED8); // steel blue
const Color _kAccentSoft = Color(0xFFE0E7FF);
const Color _kAccentBlue = Color(0xFF2563EB);
const Color _kAccentTeal = Color(0xFF0D9488);
const Color _kAccentGreen = Color(0xFF15803D);
const Color _kAccentAmber = Color(0xFFB45309);
const Color _kAccentRose = Color(0xFFBE123C);
const Color _kAccentViolet = Color(0xFF7C3AED);
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
// Top-level private functions returning Widgets. Keeping helpers outside
// StatelessWidget subclasses lets the file be read top-to-bottom.

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

Widget _bulletList(List<String> items) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      for (final String item in items)
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(top: 6.0, right: 8.0),
                child: SizedBox(
                  width: 5.0,
                  height: 5.0,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: _kAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Expanded(child: Text(item, style: _kBodyStyle)),
            ],
          ),
        ),
    ],
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
        colors: <Color>[Color(0xFF0F172A), Color(0xFF1D4ED8), Color(0xFF6D28D9)],
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x330F172A),
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
                'package:flutter/foundation.dart',
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
                'advanced',
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
          'Foundation - Advanced',
          style: TextStyle(
            color: Color(0xFFFFFFFF),
            fontSize: 30.0,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'TargetPlatform, build-mode constants, Listenable + '
          'ChangeNotifier, Diagnosticable, debugPrint, BitField, Endian, '
          'Factory<T> and friends - in one static poster.',
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
            _pill('TargetPlatform', colour: const Color(0xFFFDE68A)),
            _pill('kReleaseMode', colour: const Color(0xFF93C5FD)),
            _pill('ChangeNotifier', colour: const Color(0xFFA7F3D0)),
            _pill('Diagnosticable', colour: const Color(0xFFFBCFE8)),
            _pill('BitField', colour: const Color(0xFFFCD34D)),
            _pill('Endian', colour: const Color(0xFFC4B5FD)),
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
          'What is foundation.dart?',
          subtitle: 'The lowest Flutter-specific layer. Pure Dart, no '
              'rendering, no widgets. It hosts platform detection, build-mode '
              'constants, the Listenable family, Diagnosticable, and a '
              'handful of math / byte helpers (clampDouble, Endian, BitField).',
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
            'Rule of thumb: if a symbol can be used from a pure-Dart '
            'package (no Material/Cupertino, no rendering), it almost '
            'certainly lives in foundation. The widgets / painting / '
            'rendering libraries depend on foundation, never the other '
            'way round.',
            style: TextStyle(
              fontSize: 13.5,
              height: 1.5,
              color: _kInk,
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        _bulletList(const <String>[
          'TargetPlatform: the host OS, exposed as a 6-value enum.',
          'kReleaseMode / kDebugMode / kProfileMode: compile-time const bools.',
          'kIsWeb / kIsWasm: const bools, true on the web/wasm targets.',
          'ChangeNotifier / ValueNotifier / Listenable.merge: tiny obs API.',
          'Diagnosticable + DiagnosticPropertiesBuilder: structured toString.',
          'BitField / clampDouble / Endian / precisionErrorTolerance: math.',
          'Factory<T>: late-binding marker for plugin authors.',
          'debugPrint: throttled, IDE-friendly replacement for print.',
        ]),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 2 - TARGETPLATFORM MATRIX
// ---------------------------------------------------------------------------
// Every value of the TargetPlatform enum (android, fuchsia, iOS, linux,
// macOS, windows) gets its own tile. Each tile shows:
//   - the constant name
//   - its index (matches enum declaration order)
//   - a glyph-style icon
//   - whether it is the current `defaultTargetPlatform`.
//
// `defaultTargetPlatform` is read once at build time. We intentionally
// avoid changing `debugDefaultTargetPlatformOverride` - tests should set
// that, not poster scripts.

class _PlatformTileSpec {
  const _PlatformTileSpec({
    required this.platform,
    required this.glyph,
    required this.colour,
    required this.tagline,
  });

  final TargetPlatform platform;
  final String glyph;
  final Color colour;
  final String tagline;
}

const List<_PlatformTileSpec> _kPlatformTiles = <_PlatformTileSpec>[
  _PlatformTileSpec(
    platform: TargetPlatform.android,
    glyph: 'And',
    colour: _kAccentGreen,
    tagline: 'Mobile + tablet, Material 3 default.',
  ),
  _PlatformTileSpec(
    platform: TargetPlatform.fuchsia,
    glyph: 'Fuc',
    colour: _kAccentViolet,
    tagline: 'Google\'s research OS, rare in practice.',
  ),
  _PlatformTileSpec(
    platform: TargetPlatform.iOS,
    glyph: 'iOS',
    colour: _kAccentBlue,
    tagline: 'iPhone / iPad. Cupertino lives here.',
  ),
  _PlatformTileSpec(
    platform: TargetPlatform.linux,
    glyph: 'Lin',
    colour: _kAccentAmber,
    tagline: 'Desktop Linux distros.',
  ),
  _PlatformTileSpec(
    platform: TargetPlatform.macOS,
    glyph: 'mac',
    colour: _kAccentSlate,
    tagline: 'Apple Silicon + Intel desktops.',
  ),
  _PlatformTileSpec(
    platform: TargetPlatform.windows,
    glyph: 'Win',
    colour: _kAccentTeal,
    tagline: 'Windows desktop, Win32 shell.',
  ),
];

Widget _platformTile(_PlatformTileSpec spec, bool isDefault) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _kCardSoft,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: isDefault ? spec.colour : _kHairline,
        width: isDefault ? 2.0 : 1.0,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 36.0,
              height: 36.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: spec.colour.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                spec.glyph,
                style: TextStyle(
                  color: spec.colour,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'TargetPlatform.${spec.platform.name}',
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: _kInk,
                      fontFamily: 'monospace',
                    ),
                  ),
                  Text(
                    'index ${spec.platform.index}',
                    style: _kCaptionStyle,
                  ),
                ],
              ),
            ),
            if (isDefault) _pill('default', colour: spec.colour),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(spec.tagline, style: _kBodySoftStyle),
      ],
    ),
  );
}

Widget _platformMatrix() {
  final TargetPlatform current = defaultTargetPlatform;
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'TargetPlatform - the 6 constants',
          subtitle: 'Use it for cosmetic branching only. Do not gate features '
              'on it - prefer capability checks.',
        ),
        const SizedBox(height: 14.0),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double w = constraints.maxWidth;
            final int columns = w >= 720.0 ? 3 : (w >= 480.0 ? 2 : 1);
            final double tileWidth =
                (w - (columns - 1) * 10.0) / columns;
            return Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: <Widget>[
                for (final _PlatformTileSpec spec in _kPlatformTiles)
                  SizedBox(
                    width: tileWidth,
                    child: _platformTile(spec, spec.platform == current),
                  ),
              ],
            );
          },
        ),
        const SizedBox(height: 14.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _kvRow('defaultTargetPlatform', current.toString()),
              _kvRow(
                'debugDefaultTargetPlatformOverride',
                debugDefaultTargetPlatformOverride?.toString() ?? '<null>',
              ),
              _kvRow(
                'TargetPlatform.values.length',
                '${TargetPlatform.values.length}',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 3 - TARGETPLATFORMVARIANT
// ---------------------------------------------------------------------------
// TargetPlatformVariant is exported by flutter_test, NOT foundation.dart -
// but it composes directly over the foundation TargetPlatform enum, so it
// lives logically next door. The card below explains the relationship.
Widget _platformVariantCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'TargetPlatformVariant',
          subtitle: 'A flutter_test TestVariant<TargetPlatform> that runs the '
              'same testWidgets body once per TargetPlatform value.',
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: _kAccentSoft,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: _kAccent.withOpacity(0.25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Constructors',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: _kAccent,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    _kvRow('TargetPlatformVariant.all()',
                        'every TargetPlatform value'),
                    _kvRow('TargetPlatformVariant.only(p)',
                        'a single platform'),
                    _kvRow('TargetPlatformVariant.desktop()',
                        'linux + macOS + windows'),
                    _kvRow('TargetPlatformVariant.mobile()',
                        'android + iOS + fuchsia'),
                    _kvRow('TargetPlatformVariant({...})',
                        'an explicit set'),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: _kCardSoft,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: _kHairline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Wiring',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: _kInkSecondary,
                        letterSpacing: 0.3,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    _kvRow('setUp', 'override defaultTargetPlatform'),
                    _kvRow('tearDown', 'restore previous override'),
                    _kvRow('variant.values', 'Iterable<TargetPlatform>'),
                    _kvRow('variant.describeValue', 'human label'),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _codeBlock(
          'testWidgets(\n'
          '  \'renders chrome per platform\',\n'
          '  (WidgetTester tester) async {\n'
          '    await tester.pumpWidget(const MyApp());\n'
          '    expect(find.byType(MyChrome), findsOneWidget);\n'
          '  },\n'
          '  variant: TargetPlatformVariant.all(),\n'
          ');',
          title: '// flutter_test usage',
        ),
        const SizedBox(height: 4.0),
        const Text(
          'Note: TargetPlatformVariant lives in package:flutter_test, not '
          'foundation, so it cannot be imported from a D4rt poster script. '
          'The poster references it conceptually only.',
          style: _kBodySoftStyle,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 4 - BUILD-MODE CONSTANTS PANEL
// ---------------------------------------------------------------------------
// Compile-time const bools the framework uses to strip dev-only code in
// release builds. Each row pulls the *actual* value of the constant at
// script run time, so the poster doubles as a quick "what mode am I in?"
// indicator.
class _ModeRow {
  const _ModeRow(this.symbol, this.value, this.summary);
  final String symbol;
  final bool value;
  final String summary;
}

Widget _modePill(bool value) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: value
          ? _kAccentGreen.withOpacity(0.15)
          : _kInkTertiary.withOpacity(0.15),
      borderRadius: BorderRadius.circular(999.0),
      border: Border.all(
        color: value
            ? _kAccentGreen.withOpacity(0.4)
            : _kInkTertiary.withOpacity(0.4),
      ),
    ),
    child: Text(
      value ? 'true' : 'false',
      style: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w700,
        color: value ? _kAccentGreen : _kInkTertiary,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _buildModePanel() {
  final List<_ModeRow> rows = <_ModeRow>[
    _ModeRow('kReleaseMode', kReleaseMode,
        'true when the binary was compiled with --release.'),
    _ModeRow('kDebugMode', kDebugMode,
        'true in dev builds; assertions are enabled here.'),
    _ModeRow('kProfileMode', kProfileMode,
        'true when --profile was used; timeline data is collected.'),
    _ModeRow('kIsWeb', kIsWeb,
        'true when the script targets dart2js or dart2wasm on the web.'),
    _ModeRow('kIsWasm', kIsWasm,
        'true when compiled to WebAssembly specifically.'),
  ];
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Build-mode constants',
          subtitle: 'Compile-time const bools. The dart compiler tree-shakes '
              'branches gated on `if (kReleaseMode)` etc.',
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            children: <Widget>[
              for (int i = 0; i < rows.length; i++) ...<Widget>[
                if (i > 0)
                  Container(
                    height: 1.0,
                    color: _kHairline,
                    margin: const EdgeInsets.symmetric(vertical: 6.0),
                  ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 130.0,
                      child: Text(
                        rows[i].symbol,
                        style: const TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.w700,
                          color: _kInk,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    _modePill(rows[i].value),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Text(rows[i].summary, style: _kBodySoftStyle),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        _codeBlock(
          'if (kDebugMode) {\n'
          '  debugPrint(\'expensive trace: \$state\');\n'
          '}\n'
          '\n'
          'if (!kIsWeb) {\n'
          '  // safe to import dart:io here\n'
          '}',
          title: '// tree-shaken in release',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 5 - LISTENABLE / CHANGENOTIFIER / VALUENOTIFIER LIFECYCLE
// ---------------------------------------------------------------------------
// Drawn as a CustomPainter so we can show the three classes side by side
// with the listener flow between them, then a small text panel under the
// painting summarising lifecycle obligations.

class _NotifierDiagramPainter extends CustomPainter {
  const _NotifierDiagramPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint hairline = Paint()
      ..color = _kHairline
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    final Paint accent = Paint()
      ..color = _kAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    final Paint accentSoft = Paint()
      ..color = _kAccentSoft
      ..style = PaintingStyle.fill;

    // Background grid.
    for (double x = 0.0; x <= size.width; x += 24.0) {
      canvas.drawLine(
        Offset(x, 0.0),
        Offset(x, size.height),
        Paint()..color = const Color(0x0A000000),
      );
    }
    for (double y = 0.0; y <= size.height; y += 24.0) {
      canvas.drawLine(
        Offset(0.0, y),
        Offset(size.width, y),
        Paint()..color = const Color(0x0A000000),
      );
    }

    // Box positions.
    final Rect listenable = Rect.fromLTWH(20.0, 30.0, 180.0, 70.0);
    final Rect changeNotifier =
        Rect.fromLTWH(20.0, 130.0, 180.0, 70.0);
    final Rect valueNotifier =
        Rect.fromLTWH(20.0, 230.0, 180.0, 70.0);
    final Rect mergedFanIn =
        Rect.fromLTWH(260.0, 130.0, 200.0, 70.0);
    final Rect listener =
        Rect.fromLTWH(520.0, 130.0, 180.0, 70.0);

    void _drawBox(Rect r, String title, String subtitle, Color colour) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(10.0)),
        Paint()..color = colour.withOpacity(0.10),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(10.0)),
        Paint()
          ..color = colour
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.4,
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          children: <InlineSpan>[
            TextSpan(
              text: '$title\n',
              style: TextStyle(
                color: colour,
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
            TextSpan(
              text: subtitle,
              style: const TextStyle(
                color: _kInkSecondary,
                fontSize: 11.0,
                height: 1.3,
              ),
            ),
          ],
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: r.width - 16.0);
      tp.paint(canvas, Offset(r.left + 8.0, r.top + 8.0));
    }

    _drawBox(listenable, 'Listenable',
        'addListener / removeListener\nbase interface', _kAccent);
    _drawBox(changeNotifier, 'ChangeNotifier',
        'mixin, hasListeners,\nnotifyListeners()', _kAccentBlue);
    _drawBox(valueNotifier, 'ValueNotifier<T>',
        'wraps a value,\nfires on T mutation', _kAccentTeal);
    _drawBox(mergedFanIn, 'Listenable.merge([a, b])',
        'fan-in adapter, no\nstate of its own', _kAccentViolet);
    _drawBox(listener, 'VoidCallback',
        'addListener(cb)\nnever throws',
        _kAccentGreen);

    // Arrows.
    final Paint arrowPaint = Paint()
      ..color = _kInkTertiary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    Path arrow(Offset a, Offset b) {
      final Path p = Path()
        ..moveTo(a.dx, a.dy)
        ..lineTo(b.dx, b.dy);
      const double size = 6.0;
      final double dx = b.dx - a.dx;
      final double dy = b.dy - a.dy;
      final double angle = math.atan2(dy, dx);
      final Offset tip = b;
      p.moveTo(
        tip.dx - size * math.cos(angle - math.pi / 6),
        tip.dy - size * math.sin(angle - math.pi / 6),
      );
      p.lineTo(tip.dx, tip.dy);
      p.lineTo(
        tip.dx - size * math.cos(angle + math.pi / 6),
        tip.dy - size * math.sin(angle + math.pi / 6),
      );
      return p;
    }

    // inheritance: Listenable -> ChangeNotifier
    canvas.drawPath(
      arrow(listenable.bottomCenter, changeNotifier.topCenter),
      arrowPaint,
    );
    // inheritance: ChangeNotifier -> ValueNotifier
    canvas.drawPath(
      arrow(changeNotifier.bottomCenter, valueNotifier.topCenter),
      arrowPaint,
    );
    // ChangeNotifier -> merged fan-in
    canvas.drawPath(
      arrow(changeNotifier.centerRight, mergedFanIn.centerLeft),
      arrowPaint,
    );
    // ValueNotifier -> merged fan-in
    canvas.drawPath(
      arrow(
        Offset(valueNotifier.right - 10.0, valueNotifier.top + 20.0),
        Offset(mergedFanIn.left, mergedFanIn.bottom - 10.0),
      ),
      arrowPaint,
    );
    // merged fan-in -> listener
    canvas.drawPath(
      arrow(mergedFanIn.centerRight, listener.centerLeft),
      Paint()
        ..color = _kAccent
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.8,
    );

    // Caption.
    final TextPainter caption = TextPainter(
      text: const TextSpan(
        text:
            'Listenable.merge collapses many sources into one Listenable;\n'
            'a single addListener fires when any input notifies.',
        style: TextStyle(
          color: _kInkSecondary,
          fontSize: 11.5,
          height: 1.35,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 40.0);
    caption.paint(canvas, const Offset(20.0, 310.0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _notifierDiagram() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'ChangeNotifier / ValueNotifier / Listenable.merge',
          subtitle:
              'The tiny obs API that Flutter is built on. addListener, '
              'notifyListeners, dispose.',
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 360.0,
          child: CustomPaint(
            painter: const _NotifierDiagramPainter(),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 12.0),
        _bulletList(const <String>[
          'A Listenable is anything with addListener / removeListener.',
          'ChangeNotifier is the standard implementation; mix it in.',
          'hasListeners is protected - it tells you whether to do work.',
          'Forgetting dispose() leaks the notifier and any captured state.',
          'ValueNotifier<T> exposes .value; setting it notifies if !=.',
          'Listenable.merge([...]) builds a single Listenable from many.',
        ]),
        const SizedBox(height: 8.0),
        _codeBlock(
          'class CounterStore extends ChangeNotifier {\n'
          '  int _n = 0;\n'
          '  int get n => _n;\n'
          '  void inc() {\n'
          '    _n += 1;\n'
          '    notifyListeners();\n'
          '  }\n'
          '}\n'
          '\n'
          'final ValueNotifier<bool> dirty = ValueNotifier<bool>(false);\n'
          'final Listenable both = Listenable.merge(<Listenable?>[\n'
          '  counterStore,\n'
          '  dirty,\n'
          ']);',
          title: '// notifier idioms',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 6 - DIAGNOSTICABLE TREE
// ---------------------------------------------------------------------------
// A CustomPainter that shows how DiagnosticPropertiesBuilder, the
// individual DiagnosticsProperty subclasses, and toDiagnosticsNode interact
// to produce a human-readable toString.
class _DiagnosticableTreePainter extends CustomPainter {
  const _DiagnosticableTreePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Paint background = Paint()
      ..color = const Color(0xFFFAFAFB)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & size, background);

    void _drawBox(Rect r, String title, Color colour, {String? sub}) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(8.0)),
        Paint()..color = colour.withOpacity(0.12),
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(8.0)),
        Paint()
          ..color = colour
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2,
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          children: <InlineSpan>[
            TextSpan(
              text: title,
              style: TextStyle(
                color: colour,
                fontSize: 11.5,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
            if (sub != null)
              TextSpan(
                text: '\n$sub',
                style: const TextStyle(
                  color: _kInkSecondary,
                  fontSize: 10.0,
                  height: 1.25,
                ),
              ),
          ],
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: r.width - 10.0);
      tp.paint(canvas, Offset(r.left + 6.0, r.top + 6.0));
    }

    // Root: Diagnosticable
    final Rect root = Rect.fromLTWH(20.0, 20.0, 200.0, 60.0);
    _drawBox(root, 'Diagnosticable',
        _kAccent,
        sub: 'mixin: toString,\ntoStringShort,\ntoDiagnosticsNode');

    // Builder
    final Rect builder = Rect.fromLTWH(260.0, 20.0, 220.0, 60.0);
    _drawBox(builder, 'DiagnosticPropertiesBuilder', _kAccentBlue,
        sub: '.add(prop)\n.properties: List<...>');

    // DiagnosticsNode
    final Rect node = Rect.fromLTWH(520.0, 20.0, 200.0, 60.0);
    _drawBox(node, 'DiagnosticsNode', _kAccentViolet,
        sub: 'name + value + style\ntoDescription()');

    // Property subclasses row
    final List<MapEntry<String, String>> props =
        <MapEntry<String, String>>[
      MapEntry('IntProperty', 'int'),
      MapEntry('DoubleProperty', 'double, units'),
      MapEntry('FlagProperty', 'bool, ifTrue/False'),
      MapEntry('EnumProperty', 'enum value'),
      MapEntry('StringProperty', 'String, quoted'),
      MapEntry('IterableProperty', 'Iterable<T>'),
    ];
    for (int i = 0; i < props.length; i++) {
      final int col = i % 3;
      final int row = i ~/ 3;
      final Rect r = Rect.fromLTWH(
        20.0 + col * 240.0,
        130.0 + row * 70.0,
        220.0,
        60.0,
      );
      _drawBox(r, props[i].key, _kAccentTeal, sub: props[i].value);
    }

    // Arrows
    final Paint arrowPaint = Paint()
      ..color = _kInkTertiary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    canvas.drawLine(root.centerRight, builder.centerLeft, arrowPaint);
    canvas.drawLine(builder.centerRight, node.centerLeft, arrowPaint);

    // From builder down to props.
    final Paint downPaint = Paint()
      ..color = _kAccentBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    for (int i = 0; i < 3; i++) {
      final double x = 20.0 + i * 240.0 + 110.0;
      canvas.drawLine(
        Offset(builder.left + 100.0, builder.bottom),
        Offset(x, 130.0),
        downPaint,
      );
    }

    final TextPainter caption = TextPainter(
      text: const TextSpan(
        text:
            'debugFillProperties(DiagnosticPropertiesBuilder b) builds a node\n'
            'tree that toString and devtools both consume.',
        style: TextStyle(
          color: _kInkSecondary,
          fontSize: 11.0,
          height: 1.35,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: size.width - 40.0);
    caption.paint(canvas, const Offset(20.0, 280.0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _diagnosticableSection() {
  // Build a couple of DiagnosticsProperty instances so the card can show
  // them rendered next to the diagram. They are constructed once; we never
  // attach them to a builder more than once.
  final DiagnosticsProperty<String> nameProp =
      DiagnosticsProperty<String>('label', 'Button A');
  final IntProperty widthProp = IntProperty('width', 240);
  final DoubleProperty opacityProp = DoubleProperty('opacity', 0.85);
  final FlagProperty visibleProp = FlagProperty(
    'visible',
    value: true,
    ifTrue: 'VISIBLE',
    ifFalse: 'HIDDEN',
  );
  final EnumProperty<TargetPlatform> platformProp =
      EnumProperty<TargetPlatform>('platform', TargetPlatform.iOS);
  final DiagnosticsNode messageNode =
      DiagnosticsNode.message('A static message diagnostic');
  final DiagnosticPropertiesBuilder builder = DiagnosticPropertiesBuilder()
    ..add(nameProp)
    ..add(widthProp)
    ..add(opacityProp)
    ..add(visibleProp)
    ..add(platformProp);

  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Diagnosticable, DiagnosticsNode, DiagnosticsProperty',
          subtitle:
              'Structured toString plumbing that powers devtools and the '
              'Flutter inspector.',
        ),
        const SizedBox(height: 12.0),
        SizedBox(
          height: 320.0,
          child: CustomPaint(
            painter: const _DiagnosticableTreePainter(),
            size: Size.infinite,
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Built-in properties (sample values)',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w700,
                  color: _kInkSecondary,
                  letterSpacing: 0.3,
                ),
              ),
              const SizedBox(height: 8.0),
              _kvRow('DiagnosticsNode.message', messageNode.toString()),
              _kvRow('DiagnosticsProperty<String>', nameProp.toString()),
              _kvRow('IntProperty', widthProp.toString()),
              _kvRow('DoubleProperty', opacityProp.toString()),
              _kvRow('FlagProperty', visibleProp.toString()),
              _kvRow('EnumProperty<TargetPlatform>', platformProp.toString()),
              _kvRow('builder.properties.length',
                  '${builder.properties.length}'),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        _codeBlock(
          'class MyButton extends StatelessWidget with Diagnosticable {\n'
          '  const MyButton({super.key, required this.label});\n'
          '  final String label;\n'
          '\n'
          '  @override\n'
          '  void debugFillProperties(DiagnosticPropertiesBuilder p) {\n'
          '    super.debugFillProperties(p);\n'
          '    p.add(StringProperty(\'label\', label));\n'
          '    p.add(FlagProperty(\'enabled\',\n'
          '        value: true, ifTrue: \'ON\', ifFalse: \'OFF\'));\n'
          '  }\n'
          '\n'
          '  @override\n'
          '  Widget build(BuildContext context) =>\n'
          '      Text(label);\n'
          '}',
          title: '// debugFillProperties recipe',
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 7 - debugPrint vs print
// ---------------------------------------------------------------------------
Widget _debugPrintSection() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'debugPrint vs print',
          subtitle:
              'debugPrint is the framework\'s throttled, IDE-friendly '
              'replacement for dart:core print.',
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: _kCardSoft,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: _kHairline),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _pill('print', colour: _kInkTertiary),
                        const SizedBox(width: 8.0),
                        const Text(
                          'dart:core',
                          style: _kCaptionStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    _kvRow('throttled', 'no'),
                    _kvRow('synchronous', 'yes'),
                    _kvRow('can be silenced', 'no (Zone hack only)'),
                    _kvRow('drops in release', 'no'),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: _kAccentSoft,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: _kAccent.withOpacity(0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _pill('debugPrint', colour: _kAccent),
                        const SizedBox(width: 8.0),
                        const Text(
                          'foundation',
                          style: _kCaptionStyle,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    _kvRow('throttled', 'yes (rate-limited)'),
                    _kvRow('synchronous', 'no, may chunk'),
                    _kvRow('can be silenced', 'yes - reassign debugPrint'),
                    _kvRow('drops in release', 'no, but assert-only paths do'),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        _codeBlock(
          '// quiet a noisy test:\n'
          'debugPrint = (String? message, {int? wrapWidth}) {\n'
          '  // swallow\n'
          '};\n'
          '\n'
          '// or keep but reformat:\n'
          'debugPrint = debugPrintSynchronously;',
          title: '// reassigning the function',
        ),
        const SizedBox(height: 8.0),
        const Text(
          'In a release binary `kReleaseMode` is true, so guarded '
          '`if (kDebugMode) debugPrint(...)` lines are stripped by the '
          'compiler. Use that pattern when the message would be expensive '
          'to format.',
          style: _kBodyStyle,
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// SECTION 8 - UTILITY POSTER (BitField, clampDouble, Endian, ...)
// ---------------------------------------------------------------------------
// One card per cluster. Each card has a title, a one-line tagline, a
// key/value block of sample values, and a tiny code snippet.

Widget _bitFieldCard() {
  // A BitField<TargetPlatform> built and read once at build time. We never
  // mutate it across frames, so this stays well inside the no-state rule.
  final BitField<TargetPlatform> bf =
      BitField<TargetPlatform>(TargetPlatform.values.length)
        ..[TargetPlatform.android] = true
        ..[TargetPlatform.iOS] = true;
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'BitField<T>',
          subtitle:
              'Compact bit-set of enum values, backed by a single int. '
              'Capped at 62 entries.',
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _kvRow('android bit', '${bf[TargetPlatform.android]}'),
              _kvRow('iOS bit', '${bf[TargetPlatform.iOS]}'),
              _kvRow('linux bit', '${bf[TargetPlatform.linux]}'),
              _kvRow('macOS bit', '${bf[TargetPlatform.macOS]}'),
              _kvRow('windows bit', '${bf[TargetPlatform.windows]}'),
              _kvRow('fuchsia bit', '${bf[TargetPlatform.fuchsia]}'),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        _codeBlock(
          'final BitField<TargetPlatform> mobile =\n'
          '    BitField<TargetPlatform>(TargetPlatform.values.length)\n'
          '      ..[TargetPlatform.android] = true\n'
          '      ..[TargetPlatform.iOS] = true;\n'
          '// mobile[TargetPlatform.macOS] => false',
          title: '// BitField',
        ),
      ],
    ),
  );
}

Widget _clampDoubleCard() {
  final double sample = clampDouble(1.42, 0.0, 1.0);
  final double nanSample = clampDouble(double.nan, 0.0, 1.0);
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'clampDouble + precisionErrorTolerance',
          subtitle:
              'A NaN-safe, branch-free double clamp; plus the framework '
              'epsilon used by isApproximately.',
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _kvRow('clampDouble(1.42, 0, 1)', '$sample'),
              _kvRow('clampDouble(NaN, 0, 1)', '$nanSample'),
              _kvRow('precisionErrorTolerance', '$precisionErrorTolerance'),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        _codeBlock(
          'final double t = clampDouble(progress, 0.0, 1.0);\n'
          'if ((a - b).abs() < precisionErrorTolerance) {\n'
          '  // treat as equal\n'
          '}',
          title: '// numeric helpers',
        ),
      ],
    ),
  );
}

Widget _endianCard() {
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Endian',
          subtitle:
              'Byte order constant from dart:typed_data, re-exported by '
              'foundation for binary protocol code.',
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _kvRow('Endian.big', '${Endian.big}'),
              _kvRow('Endian.little', '${Endian.little}'),
              _kvRow('Endian.host', '${Endian.host}'),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        _codeBlock(
          'final ByteData bd = ByteData(4);\n'
          'bd.setUint32(0, 0xDEADBEEF, Endian.big);\n'
          'final int n = bd.getUint32(0, Endian.little);\n'
          '// n == 0xEFBEADDE',
          title: '// Endian',
        ),
      ],
    ),
  );
}

Widget _factoryCard() {
  // Factory<T> is a const-friendly thunk used by plugins so the framework
  // can defer constructing T until the host knows which subclass to use.
  const Factory<String> stringFactory =
      Factory<String>(_makeGreeting);
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Factory<T>',
          subtitle:
              'A const wrapper around `T Function()`. Used by gesture '
              'recognizers and PlatformView so callers can supply types '
              'instead of instances.',
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _kvRow('factory.type', '${stringFactory.type}'),
              _kvRow('factory.constructor()', stringFactory.constructor()),
              _kvRow('factory.toString()', stringFactory.toString()),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        _codeBlock(
          'const Factory<OneSequenceGestureRecognizer> tap =\n'
          '    Factory<OneSequenceGestureRecognizer>(\n'
          '      TapGestureRecognizer.new,\n'
          '    );\n'
          '\n'
          '// passed by type, instantiated later:\n'
          'final OneSequenceGestureRecognizer r = tap.constructor();',
          title: '// Factory',
        ),
      ],
    ),
  );
}

String _makeGreeting() => 'hello from a Factory<String>';

Widget _flagPropertyCard() {
  // Two flagProperty variants - one rendered, one suppressed by
  // showName: false - so the difference is visible side-by-side.
  final FlagProperty visible = FlagProperty(
    'visible',
    value: true,
    ifTrue: 'VISIBLE',
    ifFalse: 'HIDDEN',
  );
  final FlagProperty enabled = FlagProperty(
    'enabled',
    value: false,
    ifTrue: 'ENABLED',
    ifFalse: 'DISABLED',
    showName: false,
  );
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'FlagProperty / flagProperty',
          subtitle:
              'DiagnosticsProperty subclass dedicated to booleans. Hides '
              'noisy defaults and lets you supply human labels for both '
              'sides.',
        ),
        const SizedBox(height: 10.0),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _kCardSoft,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: _kHairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _kvRow('visible.toString()', visible.toString()),
              _kvRow('enabled.toString()', enabled.toString()),
              _kvRow('enabled.showName', '${enabled.showName}'),
              _kvRow('enabled.value', '${enabled.value}'),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        _codeBlock(
          'p.add(FlagProperty(\n'
          '  \'autofocus\',\n'
          '  value: widget.autofocus,\n'
          '  ifTrue: \'AUTOFOCUS\',\n'
          '));\n'
          '// rendered only when true; quiet by default.',
          title: '// debugFillProperties bool',
        ),
      ],
    ),
  );
}

Widget _utilityPoster() {
  return Column(
    children: <Widget>[
      _bitFieldCard(),
      _clampDoubleCard(),
      _endianCard(),
      _factoryCard(),
      _flagPropertyCard(),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 9 - RECIPE CARDS
// ---------------------------------------------------------------------------
Widget _recipeCards() {
  return Column(
    children: <Widget>[
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardTitle(
              'Recipe: branch on platform without leaking',
              subtitle:
                  'Read defaultTargetPlatform once into a local; switch on '
                  'it; do not call it inside tight loops.',
            ),
            const SizedBox(height: 10.0),
            _codeBlock(
              'final TargetPlatform p = defaultTargetPlatform;\n'
              'final EdgeInsets gutter = switch (p) {\n'
              '  TargetPlatform.iOS || TargetPlatform.macOS =>\n'
              '      const EdgeInsets.all(16.0),\n'
              '  TargetPlatform.android || TargetPlatform.fuchsia =>\n'
              '      const EdgeInsets.all(12.0),\n'
              '  TargetPlatform.linux || TargetPlatform.windows =>\n'
              '      const EdgeInsets.all(8.0),\n'
              '};',
              title: '// platform-aware gutter',
            ),
          ],
        ),
      ),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardTitle(
              'Recipe: dispose a ValueNotifier',
              subtitle:
                  'Pair every `new ValueNotifier(...)` with a dispose; use '
                  'ValueListenableBuilder to consume reactively.',
            ),
            const SizedBox(height: 10.0),
            _codeBlock(
              'class _MyForm extends State<MyForm> {\n'
              '  final ValueNotifier<bool> dirty =\n'
              '      ValueNotifier<bool>(false);\n'
              '\n'
              '  @override\n'
              '  void dispose() {\n'
              '    dirty.dispose();\n'
              '    super.dispose();\n'
              '  }\n'
              '\n'
              '  @override\n'
              '  Widget build(BuildContext context) {\n'
              '    return ValueListenableBuilder<bool>(\n'
              '      valueListenable: dirty,\n'
              '      builder: (_, bool d, __) =>\n'
              '          Text(d ? \'unsaved\' : \'clean\'),\n'
              '    );\n'
              '  }\n'
              '}',
              title: '// ValueNotifier lifecycle',
            ),
          ],
        ),
      ),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardTitle(
              'Recipe: structured toString',
              subtitle:
                  'Override debugFillProperties; never override toString '
                  'directly on widgets.',
            ),
            const SizedBox(height: 10.0),
            _codeBlock(
              '@override\n'
              'void debugFillProperties(DiagnosticPropertiesBuilder p) {\n'
              '  super.debugFillProperties(p);\n'
              '  p.add(StringProperty(\'route\', _route, quoted: false));\n'
              '  p.add(IntProperty(\'depth\', _depth));\n'
              '  p.add(EnumProperty<Direction>(\'dir\', _dir));\n'
              '  p.add(FlagProperty(\'isLeaf\',\n'
              '      value: _isLeaf, ifTrue: \'LEAF\'));\n'
              '}',
              title: '// debugFillProperties',
            ),
          ],
        ),
      ),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardTitle(
              'Recipe: merge two notifiers',
              subtitle:
                  'When two unrelated streams should rebuild the same '
                  'AnimatedBuilder, fan them in with Listenable.merge.',
            ),
            const SizedBox(height: 10.0),
            _codeBlock(
              'final Listenable both = Listenable.merge(<Listenable?>[\n'
              '  scrollController,\n'
              '  textController,\n'
              ']);\n'
              '\n'
              'AnimatedBuilder(\n'
              '  animation: both,\n'
              '  builder: (BuildContext ctx, Widget? child) =>\n'
              '      _composeChrome(ctx, scrollController, textController),\n'
              ');',
              title: '// Listenable.merge',
            ),
          ],
        ),
      ),
      _card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _cardTitle(
              'Recipe: silence debugPrint in tests',
              subtitle:
                  'Replace the global function; restore in tearDown.',
            ),
            const SizedBox(height: 10.0),
            _codeBlock(
              'setUp(() {\n'
              '  debugPrint = (String? _, {int? wrapWidth}) {};\n'
              '});\n'
              'tearDown(() {\n'
              '  debugPrint = debugPrintThrottled;\n'
              '});',
              title: '// quiet test logs',
            ),
          ],
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// SECTION 10 - PITFALLS PANEL
// ---------------------------------------------------------------------------
class _Pitfall {
  const _Pitfall(this.title, this.body, this.colour);
  final String title;
  final String body;
  final Color colour;
}

Widget _pitfallTile(_Pitfall p) {
  return Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: p.colour.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: p.colour.withOpacity(0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.warning_amber_rounded, color: p.colour, size: 16.0),
            const SizedBox(width: 6.0),
            Expanded(
              child: Text(
                p.title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  color: p.colour,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Text(p.body, style: _kBodySoftStyle),
      ],
    ),
  );
}

Widget _pitfallsPanel() {
  const List<_Pitfall> pitfalls = <_Pitfall>[
    _Pitfall(
      'defaultTargetPlatform inside build',
      'It is fine to read it once - but do not branch on it for layout '
          'capability. The Flutter inspector also rewrites it under you in '
          'devtools, which can confuse golden tests.',
      _kAccentAmber,
    ),
    _Pitfall(
      'kIsWeb && dart:io',
      'dart:io throws at import time on web. Guard the import with a '
          'conditional import file, not just `if (kIsWeb)` at the call '
          'site - the compiler still parses the body.',
      _kAccentRose,
    ),
    _Pitfall(
      'kDebugMode and side effects',
      '`if (kDebugMode)` blocks are tree-shaken in release, but only the '
          'block body itself - not symbols the body references. Keep '
          'expensive helpers inside the if.',
      _kAccentBlue,
    ),
    _Pitfall(
      'ChangeNotifier without dispose',
      'If you new it up in initState, dispose it in dispose. Otherwise the '
          'listener set holds your widget alive and stops it being GCd '
          'after Navigator.pop.',
      _kAccentViolet,
    ),
    _Pitfall(
      'BitField max length',
      'BitField is backed by an int, so it caps at ~62 entries. Larger '
          'enums need a SplayTreeSet or a typed Uint8List.',
      _kAccentTeal,
    ),
    _Pitfall(
      'precisionErrorTolerance vs ==',
      '`a == b` on doubles is almost always a bug. Compare with '
          '`(a - b).abs() < precisionErrorTolerance` (and only inside an '
          'assert if it is a sanity check).',
      _kAccentGreen,
    ),
  ];
  return _card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _cardTitle(
          'Pitfalls',
          subtitle: 'Six things that bite people when they first reach for '
              'foundation symbols.',
        ),
        const SizedBox(height: 12.0),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final double w = constraints.maxWidth;
            final int columns = w >= 720.0 ? 3 : (w >= 480.0 ? 2 : 1);
            final double tileWidth =
                (w - (columns - 1) * 10.0) / columns;
            return Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: <Widget>[
                for (final _Pitfall p in pitfalls)
                  SizedBox(width: tileWidth, child: _pitfallTile(p)),
              ],
            );
          },
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// FOOTER - CHEAT-SHEET CHIPS
// ---------------------------------------------------------------------------
Widget _cheatSheetFooter() {
  return _card(
    background: _kCardDark,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Cheat-sheet',
          style: TextStyle(
            color: _kInkOnDark,
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(height: 4.0),
        const Text(
          'A flat list of every symbol the poster touches.',
          style: TextStyle(
            color: _kInkOnDarkSecondary,
            fontSize: 12.5,
          ),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _pill('TargetPlatform.android', colour: const Color(0xFFA7F3D0)),
            _pill('TargetPlatform.fuchsia', colour: const Color(0xFFC4B5FD)),
            _pill('TargetPlatform.iOS', colour: const Color(0xFF93C5FD)),
            _pill('TargetPlatform.linux', colour: const Color(0xFFFDE68A)),
            _pill('TargetPlatform.macOS', colour: const Color(0xFFCBD5E1)),
            _pill('TargetPlatform.windows', colour: const Color(0xFF99F6E4)),
            _pill('defaultTargetPlatform', colour: const Color(0xFFFBCFE8)),
            _pill('debugDefaultTargetPlatformOverride',
                colour: const Color(0xFFFCD34D)),
            _pill('kReleaseMode', colour: const Color(0xFFFCA5A5)),
            _pill('kDebugMode', colour: const Color(0xFF93C5FD)),
            _pill('kProfileMode', colour: const Color(0xFFA7F3D0)),
            _pill('kIsWeb', colour: const Color(0xFFFDBA74)),
            _pill('kIsWasm', colour: const Color(0xFFFCD34D)),
            _pill('debugPrint', colour: const Color(0xFFC4B5FD)),
            _pill('debugPrintThrottled', colour: const Color(0xFFA7F3D0)),
            _pill('precisionErrorTolerance', colour: const Color(0xFF93C5FD)),
            _pill('clampDouble', colour: const Color(0xFFFDE68A)),
            _pill('BitField', colour: const Color(0xFFFBCFE8)),
            _pill('Endian.big', colour: const Color(0xFFA7F3D0)),
            _pill('Endian.little', colour: const Color(0xFF93C5FD)),
            _pill('Endian.host', colour: const Color(0xFFC4B5FD)),
            _pill('ChangeNotifier', colour: const Color(0xFFFCA5A5)),
            _pill('ValueNotifier', colour: const Color(0xFFFDBA74)),
            _pill('Listenable.merge', colour: const Color(0xFFA7F3D0)),
            _pill('Factory<T>', colour: const Color(0xFFFDE68A)),
            _pill('flagProperty', colour: const Color(0xFFFBCFE8)),
            _pill('Diagnosticable', colour: const Color(0xFFC4B5FD)),
            _pill('DiagnosticsNode', colour: const Color(0xFF93C5FD)),
            _pill('DiagnosticPropertiesBuilder',
                colour: const Color(0xFFA7F3D0)),
            _pill('IntProperty', colour: const Color(0xFFFCA5A5)),
            _pill('DoubleProperty', colour: const Color(0xFFFDBA74)),
            _pill('FlagProperty', colour: const Color(0xFFFCD34D)),
            _pill('EnumProperty', colour: const Color(0xFFA7F3D0)),
            _pill('StringProperty', colour: const Color(0xFF93C5FD)),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          height: 1.0,
          color: _kHairlineDark,
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Generated once at build(). No setState, no Timer, no async. '
          'foundation symbols are read at script-run time and rendered '
          'as static text + CustomPainter drawings.',
          style: TextStyle(
            color: _kInkOnDarkSecondary,
            fontSize: 11.5,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// ENTRY POINT
// ---------------------------------------------------------------------------
dynamic build(BuildContext context) {
  // Optional console trace - useful when piping the poster through the
  // D4rt host's stdout. Wrapped in `if (kDebugMode)` so a release host
  // strips it. (kDebugMode is itself a foundation constant.)
  if (kDebugMode) {
    debugPrint('foundation_misc_adv: building static poster');
    debugPrint('  defaultTargetPlatform = $defaultTargetPlatform');
    debugPrint('  kReleaseMode=$kReleaseMode kDebugMode=$kDebugMode '
        'kProfileMode=$kProfileMode kIsWeb=$kIsWeb');
  }

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: _kCanvas,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _heroBanner(),
              _sectionHeader(
                1,
                'Foundation, in one paragraph',
                'A pure-Dart layer under widgets / painting / rendering.',
              ),
              _heroIntroCard(),
              _sectionDivider(),
              _sectionHeader(
                2,
                'TargetPlatform',
                'Every constant, drawn as a tile.',
              ),
              _platformMatrix(),
              _sectionDivider(),
              _sectionHeader(
                3,
                'TargetPlatformVariant',
                'flutter_test helper that fans out over TargetPlatform.',
              ),
              _platformVariantCard(),
              _sectionDivider(),
              _sectionHeader(
                4,
                'Build-mode constants',
                'kDebugMode / kProfileMode / kReleaseMode / kIsWeb / kIsWasm.',
              ),
              _buildModePanel(),
              _sectionDivider(),
              _sectionHeader(
                5,
                'Listenable family',
                'ChangeNotifier, ValueNotifier, Listenable.merge.',
              ),
              _notifierDiagram(),
              _sectionDivider(),
              _sectionHeader(
                6,
                'Diagnosticable',
                'DiagnosticsNode, DiagnosticsProperty, '
                    'DiagnosticPropertiesBuilder.',
              ),
              _diagnosticableSection(),
              _sectionDivider(),
              _sectionHeader(
                7,
                'debugPrint vs print',
                'Throttled, reassignable, IDE-friendly logging.',
              ),
              _debugPrintSection(),
              _sectionDivider(),
              _sectionHeader(
                8,
                'Utility cards',
                'BitField, clampDouble, Endian, precisionErrorTolerance, '
                    'Factory<T>, FlagProperty.',
              ),
              _utilityPoster(),
              _sectionDivider(),
              _sectionHeader(
                9,
                'Recipes',
                'Five idiomatic foundation snippets.',
              ),
              _recipeCards(),
              _sectionDivider(),
              _sectionHeader(
                10,
                'Pitfalls',
                'Six things that bite people first.',
              ),
              _pitfallsPanel(),
              _sectionDivider(),
              _cheatSheetFooter(),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    ),
  );
}
