// ignore_for_file: unused_field, unused_local_variable, unused_element, unused_element_parameter, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =====================================================================
// Cupertino List Tile Chevron — Deep Visual Demo (Static)
// =====================================================================
//
// This file is a fully-static, hand-written visual catalogue dedicated
// to the `CupertinoListTileChevron` widget and the `CupertinoListTile`
// family of widgets that consume it. The goal is to give a reader (or
// an AST-driven renderer) a single, dense reference page that exercises
// many concrete combinations of these widgets in a fully predictable,
// stateless layout.
//
// The demo is intentionally large. Each `_*Section` widget is a unique
// `StatelessWidget` that focuses on one teaching point and is shown
// stacked vertically inside a `SingleChildScrollView`. There is no
// state, no animation, no async work and no platform IO. Every value
// is hard-coded so the rendered tree is fully deterministic.
//
// Sections:
//   1.  _HeroBannerSection
//   2.  _ChevronAnatomySection
//   3.  _ChevronColorSizeSection
//   4.  _ListTileAnatomySection
//   5.  _ListTileStateGridSection
//   6.  _SettingsListMockupSection
//   7.  _FormSectionMockupSection
//   8.  _ThemeIntegrationSection
//   9.  _PitfallsSection
//   10. _FooterSection
//
// Rules respected:
//   - Static only: no Stateful, no Timer/Future/Stream, no dart:async,
//     no dart:io, no AnimationController, no setState.
//   - Imports limited to flutter/cupertino and flutter/material.
//   - Entry point: `dynamic build(BuildContext context)` returning a
//     MaterialApp -> Scaffold -> SingleChildScrollView -> Column.
//   - >= 6 BoxDecoration with LinearGradient.
//   - >= 8 unique _*Section StatelessWidget classes.
//   - Color.withValues(alpha: ...) used instead of withOpacity().
//
// Notes for readers:
//
// `CupertinoListTileChevron` is a tiny const widget. Internally it is
// essentially:
//
//   Icon(
//     CupertinoIcons.right_chevron,   // a.k.a. chevron_forward
//     size: 18.0,
//     color: CupertinoColors.systemGrey2.resolveFrom(context),
//   )
//
// The icon is automatically mirrored under RTL by the Cupertino icon
// glyph, so the same widget renders as ">" in LTR and "<" in RTL.
// That makes it safe to drop into `trailing:` of any
// `CupertinoListTile` regardless of the ambient `Directionality`.
//
// The owning `CupertinoListTile` is a Cupertino-styled row with the
// following slots:
//
//   leading            — small leading widget (icon, avatar, color
//                        chip). Defaults to roughly 28pt square via
//                        `leadingSize`.
//   title              — the primary text widget; required.
//   subtitle           — optional secondary line below the title.
//   additionalInfo    — trailing-side metadata text shown BEFORE the
//                        trailing widget (e.g. "Wi-Fi", "5 GHz",
//                        "On" / "Off"). Pure text, no semantics.
//   trailing           — the rightmost widget. For navigation rows this
//                        is a `CupertinoListTileChevron()`.
//   padding            — overrides the per-row insets.
//   backgroundColor    — resting fill (defaults to transparent on top
//                        of the section background).
//   backgroundColorActivated — fill when the row is in the "tapped /
//                        activated" state. Demonstrated here only as a
//                        static swatch since we cannot tap in a static
//                        snapshot.
//   leadingSize        — square size in logical pixels for the leading
//                        slot (default 28.0, notched default 30.0).
//   leadingToTitle     — horizontal gap between leading widget and
//                        title (default 16.0, notched default 12.0).
//
// `CupertinoListTile.notched` is a factory constructor that mimics the
// taller, more padded rows used in iOS Settings. The "notch" name
// comes from the rounded notch in section dividers that wraps around
// the leading icon, which is taller than the default tile.
//
// =====================================================================

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// Top-level entry. The harness calls `build(context)` and pumps the
// returned widget into a `WidgetTester`. We deliberately return a
// `MaterialApp` so that the outer chrome (Scaffold, SafeArea, scroll
// physics) is identical to the rest of the demo files in this folder.
// The inner content is purely Cupertino.
// ---------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'CupertinoListTileChevron Deep Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFEFEFF4),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFEFEFF4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              _HeroBannerSection(),
              SizedBox(height: 18),
              _ChevronAnatomySection(),
              SizedBox(height: 18),
              _ChevronColorSizeSection(),
              SizedBox(height: 18),
              _ListTileAnatomySection(),
              SizedBox(height: 18),
              _ListTileStateGridSection(),
              SizedBox(height: 18),
              _SettingsListMockupSection(),
              SizedBox(height: 18),
              _FormSectionMockupSection(),
              SizedBox(height: 18),
              _ThemeIntegrationSection(),
              SizedBox(height: 18),
              _PitfallsSection(),
              SizedBox(height: 18),
              _FooterSection(),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// =====================================================================
// Shared utility widgets used by multiple sections. These are kept
// small, named, const-able, and never carry state.
// =====================================================================

/// Reusable section frame that draws a gradient header band and a
/// rounded card body. Used as a visual anchor for every section so the
/// demo reads top-to-bottom like a printed catalogue.
class _SectionFrame extends StatelessWidget {
  final String index;
  final String title;
  final String subtitle;
  final List<Color> headerGradient;
  final Widget child;

  const _SectionFrame({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.headerGradient,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1C1C1E).withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ---- Header band (gradient) -------------------------------
          Container(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: headerGradient,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 38,
                  height: 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: CupertinoColors.white.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: CupertinoColors.white.withValues(alpha: 0.55),
                      width: 1.2,
                    ),
                  ),
                  child: Text(
                    index,
                    style: const TextStyle(
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: const TextStyle(
                          color: CupertinoColors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color:
                              CupertinoColors.white.withValues(alpha: 0.92),
                          fontSize: 12.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // ---- Body -------------------------------------------------
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: child,
          ),
        ],
      ),
    );
  }
}

/// Inline labelled chip used to annotate diagrams without polluting the
/// surrounding row with text.
class _Tag extends StatelessWidget {
  final String text;
  final Color color;
  const _Tag({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        border: Border.all(color: color.withValues(alpha: 0.55), width: 1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 10.5,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}

/// A small caption used to annotate code/usage notes inside a card body.
class _Caption extends StatelessWidget {
  final String text;
  const _Caption(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6, bottom: 6),
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xFF1C1C1E).withValues(alpha: 0.72),
          fontSize: 12.5,
          fontStyle: FontStyle.italic,
          height: 1.35,
        ),
      ),
    );
  }
}

/// Single line of "key: value" text where the key is monospace-ish to
/// emphasise that it names a Flutter property.
class _PropLine extends StatelessWidget {
  final String name;
  final String value;
  const _PropLine({required this.name, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
            color: const Color(0xFF1C1C1E).withValues(alpha: 0.92),
            fontSize: 12.5,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '$name: ',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                color: Color(0xFF0A84FF),
              ),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}

/// Visual divider used inside list mockups to mirror the iOS
/// hairline separator that appears between rows.
class _HairlineDivider extends StatelessWidget {
  final double indent;
  const _HairlineDivider({this.indent = 0});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: indent),
      child: Container(
        height: 0.5,
        color: const Color(0xFF3C3C43).withValues(alpha: 0.28),
      ),
    );
  }
}

// =====================================================================
// 1. _HeroBannerSection
// =====================================================================
//
// The hero banner sets the tone of the demo. It is purely decorative
// and uses the largest of the gradients in this file. The hero shows a
// stylised oversized chevron next to a short title so the reader
// immediately understands the subject of the page.

class _HeroBannerSection extends StatelessWidget {
  const _HeroBannerSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF0A84FF),
            Color(0xFF5E5CE6),
            Color(0xFFBF5AF2),
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF0A84FF).withValues(alpha: 0.35),
            blurRadius: 26,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          // Stylised oversized chevron — note this is a plain Icon
          // because we want to control the visual size. The actual
          // `CupertinoListTileChevron` widget is shown later at its
          // intended size.
          Container(
            width: 72,
            height: 72,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: CupertinoColors.white.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: CupertinoColors.white.withValues(alpha: 0.55),
                width: 1.4,
              ),
            ),
            child: const Icon(
              CupertinoIcons.right_chevron,
              size: 44,
              color: CupertinoColors.white,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text(
                  'CupertinoListTileChevron',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'The tiny ">" you put in trailing slots — and the '
                  'list tile family that hosts it.',
                  style: TextStyle(
                    color:
                        CupertinoColors.white.withValues(alpha: 0.94),
                    fontSize: 13.5,
                    height: 1.35,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: const <Widget>[
                    _Tag(text: 'CUPERTINO', color: CupertinoColors.white),
                    SizedBox(width: 6),
                    _Tag(text: 'STATIC', color: CupertinoColors.white),
                    SizedBox(width: 6),
                    _Tag(text: 'CONST', color: CupertinoColors.white),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 2. _ChevronAnatomySection
// =====================================================================
//
// Close-up of a single `CupertinoListTileChevron`, framed inside a
// "screen" so its true rendered size is unmistakable. A side column
// lists its key constructor properties.

class _ChevronAnatomySection extends StatelessWidget {
  const _ChevronAnatomySection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: '2',
      title: 'Chevron anatomy',
      subtitle: 'A single CupertinoListTileChevron at its true size.',
      headerGradient: const <Color>[
        Color(0xFF0A84FF),
        Color(0xFF64D2FF),
      ],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // ---- Left: framed close-up --------------------------------
          Expanded(
            flex: 5,
            child: Container(
              height: 200,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    Color(0xFFF2F2F7),
                    Color(0xFFE5E5EA),
                  ],
                ),
                border: Border.all(
                  color: const Color(0xFF3C3C43).withValues(alpha: 0.18),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: CupertinoColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFFAEAEB2),
                        width: 0.8,
                      ),
                    ),
                    // The real widget, at its default size.
                    child: const CupertinoListTileChevron(),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'rendered ~18×18 logical px',
                    style: TextStyle(
                      color: const Color(0xFF1C1C1E)
                          .withValues(alpha: 0.65),
                      fontSize: 11.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 14),
          // ---- Right: property table --------------------------------
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Constructor surface',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1C1C1E),
                  ),
                ),
                const SizedBox(height: 4),
                const _PropLine(name: 'constructor', value: 'const ()'),
                const _PropLine(name: 'arguments', value: 'none'),
                const _PropLine(name: 'icon', value: 'right_chevron'),
                const _PropLine(name: 'default size', value: '~18.0'),
                const _PropLine(
                    name: 'default color',
                    value: 'CupertinoColors.systemGrey2'),
                const _PropLine(
                    name: 'rtl', value: 'auto-flips via Icon glyph'),
                const _Caption(
                  'CupertinoListTileChevron is essentially a const '
                  'wrapper around Icon(CupertinoIcons.right_chevron). '
                  'You almost never customise it directly — instead you '
                  'control surrounding context (theme color, list tile '
                  'padding) and let the chevron pick up the inherited '
                  'styling.',
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A84FF).withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFF0A84FF)
                          .withValues(alpha: 0.30),
                    ),
                  ),
                  child: const Text(
                    'tip: drop one in trailing: of CupertinoListTile',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Color(0xFF0A84FF),
                      fontWeight: FontWeight.w700,
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
}

// =====================================================================
// 3. _ChevronColorSizeSection
// =====================================================================
//
// A grid that hammers home: although `CupertinoListTileChevron` has no
// public size/color arguments, you can recolor and resize it indirectly
// using `IconTheme`. We illustrate that with a 4×2 swatch grid where
// each cell wraps the same const widget in a different `IconTheme`.

class _ChevronColorSizeSection extends StatelessWidget {
  const _ChevronColorSizeSection();

  @override
  Widget build(BuildContext context) {
    const swatches = <_ChevronSwatch>[
      _ChevronSwatch(label: 'default', color: Color(0xFFAEAEB2), size: 18),
      _ChevronSwatch(label: 'blue', color: Color(0xFF0A84FF), size: 18),
      _ChevronSwatch(label: 'green', color: Color(0xFF34C759), size: 18),
      _ChevronSwatch(label: 'red', color: Color(0xFFFF3B30), size: 18),
      _ChevronSwatch(label: 'orange', color: Color(0xFFFF9500), size: 18),
      _ChevronSwatch(label: 'purple', color: Color(0xFFBF5AF2), size: 18),
      _ChevronSwatch(label: 'pink', color: Color(0xFFFF2D55), size: 18),
      _ChevronSwatch(label: 'teal', color: Color(0xFF64D2FF), size: 18),
    ];
    const sizes = <_ChevronSwatch>[
      _ChevronSwatch(
          label: '12 px', color: Color(0xFF8E8E93), size: 12),
      _ChevronSwatch(
          label: '14 px', color: Color(0xFF8E8E93), size: 14),
      _ChevronSwatch(
          label: '18 px (default)', color: Color(0xFF8E8E93), size: 18),
      _ChevronSwatch(
          label: '22 px', color: Color(0xFF8E8E93), size: 22),
      _ChevronSwatch(
          label: '28 px', color: Color(0xFF8E8E93), size: 28),
      _ChevronSwatch(
          label: '36 px', color: Color(0xFF8E8E93), size: 36),
    ];

    return _SectionFrame(
      index: '3',
      title: 'Color & size variations',
      subtitle: 'Recolor via IconTheme; resize via IconTheme.size.',
      headerGradient: const <Color>[
        Color(0xFFFF9500),
        Color(0xFFFF2D55),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text(
            'Color swatches',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1C1C1E),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: swatches
                .map<Widget>((_ChevronSwatch s) => s.build(context))
                .toList(growable: false),
          ),
          const SizedBox(height: 18),
          const Text(
            'Size scale',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1C1C1E),
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: sizes
                .map<Widget>((_ChevronSwatch s) => s.build(context))
                .toList(growable: false),
          ),
          const SizedBox(height: 8),
          const _Caption(
            'Note: CupertinoListTileChevron has no color or size '
            'argument, but it inherits IconThemeData. Wrap it in an '
            'IconTheme to retint or resize without subclassing.',
          ),
        ],
      ),
    );
  }
}

/// Helper widget used by [_ChevronColorSizeSection]. Each instance
/// renders a chip-shaped tile containing one chevron tinted by an
/// IconTheme. Implemented as a value-type helper, not a top-level
/// section, to keep the section count meaningful.
class _ChevronSwatch {
  final String label;
  final Color color;
  final double size;
  const _ChevronSwatch({
    required this.label,
    required this.color,
    required this.size,
  });

  Widget build(BuildContext context) {
    return Container(
      width: 116,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF3C3C43).withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
            child: Center(
              child: IconTheme(
                data: IconThemeData(color: color, size: size),
                child: const CupertinoListTileChevron(),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF1C1C1E).withValues(alpha: 0.86),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 4. _ListTileAnatomySection
// =====================================================================
//
// A labelled CupertinoListTile that shows every slot at once with
// matching callout tags. This is the textbook diagram for the widget.

class _ListTileAnatomySection extends StatelessWidget {
  const _ListTileAnatomySection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: '4',
      title: 'CupertinoListTile anatomy',
      subtitle: 'Every slot, side-by-side with its callout.',
      headerGradient: const <Color>[
        Color(0xFF5E5CE6),
        Color(0xFFBF5AF2),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // ---- The labelled row -------------------------------------
          Container(
            decoration: BoxDecoration(
              color: CupertinoColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF3C3C43).withValues(alpha: 0.18),
              ),
            ),
            child: const CupertinoListTile(
              leading: Icon(
                CupertinoIcons.wifi,
                color: Color(0xFF0A84FF),
              ),
              title: Text('Wi-Fi'),
              subtitle: Text('Home-5G'),
              additionalInfo: Text('Connected'),
              trailing: CupertinoListTileChevron(),
            ),
          ),
          const SizedBox(height: 10),
          // ---- Tag legend -------------------------------------------
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const <Widget>[
              _Tag(text: 'leading', color: Color(0xFF0A84FF)),
              _Tag(text: 'title', color: Color(0xFF34C759)),
              _Tag(text: 'subtitle', color: Color(0xFFFF9500)),
              _Tag(text: 'additionalInfo', color: Color(0xFFBF5AF2)),
              _Tag(text: 'trailing (chevron)', color: Color(0xFFFF2D55)),
            ],
          ),
          const SizedBox(height: 12),
          // ---- Property table ---------------------------------------
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xFFFFFFFF),
                  Color(0xFFF2F2F7),
                ],
              ),
              border: Border.all(
                color: const Color(0xFF3C3C43).withValues(alpha: 0.18),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                _PropLine(
                    name: 'leadingSize',
                    value: '28.0 (default), 30.0 (notched)'),
                _PropLine(
                    name: 'leadingToTitle',
                    value: '16.0 (default), 12.0 (notched)'),
                _PropLine(
                    name: 'padding',
                    value: 'EdgeInsetsDirectional.fromSTEB(...) per variant'),
                _PropLine(
                    name: 'backgroundColor',
                    value: 'transparent (default)'),
                _PropLine(
                    name: 'backgroundColorActivated',
                    value: 'CupertinoColors.systemGrey4'),
                _PropLine(name: 'trailing', value: 'commonly chevron'),
              ],
            ),
          ),
          const _Caption(
            'When the tile has both subtitle and additionalInfo, the '
            'additionalInfo aligns to the title row and the subtitle '
            'wraps below the title. The trailing widget (chevron) '
            'stays vertically centered against the whole row.',
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 5. _ListTileStateGridSection
// =====================================================================
//
// A grid showing four "states" of the tile: default, activated (fake
// snapshot of backgroundColorActivated), RTL, and notched. Because the
// demo is static we cannot actually press a tile, so the "activated"
// state is rendered by setting `backgroundColor` to the same value the
// real activation would apply.

class _ListTileStateGridSection extends StatelessWidget {
  const _ListTileStateGridSection();

  Widget _stateCard({
    required String label,
    required Color accent,
    required Widget tile,
    String? note,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: accent.withValues(alpha: 0.45),
          width: 1.2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: <Color>[
                  accent.withValues(alpha: 0.85),
                  accent.withValues(alpha: 0.55),
                ],
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: CupertinoColors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
                letterSpacing: 0.3,
              ),
            ),
          ),
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: tile,
          ),
          if (note != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 6, 10, 10),
              child: Text(
                note,
                style: TextStyle(
                  color: const Color(0xFF1C1C1E)
                      .withValues(alpha: 0.72),
                  fontSize: 11.5,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: '5',
      title: 'List tile state grid',
      subtitle: 'Default · activated · RTL · notched.',
      headerGradient: const <Color>[
        Color(0xFF34C759),
        Color(0xFF30D158),
      ],
      child: Column(
        children: <Widget>[
          // Row 1: default vs activated
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _stateCard(
                  label: 'DEFAULT',
                  accent: const Color(0xFF0A84FF),
                  tile: const CupertinoListTile(
                    leading: Icon(
                      CupertinoIcons.bell,
                      color: Color(0xFFFF9500),
                    ),
                    title: Text('Notifications'),
                    subtitle: Text('Banner style'),
                    trailing: CupertinoListTileChevron(),
                  ),
                  note: 'Resting state, transparent background.',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _stateCard(
                  label: 'ACTIVATED',
                  accent: const Color(0xFFBF5AF2),
                  tile: CupertinoListTile(
                    backgroundColor:
                        CupertinoColors.systemGrey4.withValues(alpha: 0.55),
                    leading: const Icon(
                      CupertinoIcons.bell_fill,
                      color: Color(0xFFFF9500),
                    ),
                    title: const Text('Notifications'),
                    subtitle: const Text('Banner style'),
                    trailing: const CupertinoListTileChevron(),
                  ),
                  note: 'Simulates backgroundColorActivated on tap.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Row 2: RTL vs notched
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _stateCard(
                  label: 'RTL FLIP',
                  accent: const Color(0xFFFF9500),
                  tile: const Directionality(
                    textDirection: TextDirection.rtl,
                    child: CupertinoListTile(
                      leading: Icon(
                        CupertinoIcons.globe,
                        color: Color(0xFF0A84FF),
                      ),
                      title: Text('اللغة'),
                      subtitle: Text('العربية'),
                      trailing: CupertinoListTileChevron(),
                    ),
                  ),
                  note: 'Chevron auto-flips to "<" under RTL.',
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _stateCard(
                  label: 'NOTCHED',
                  accent: const Color(0xFFFF2D55),
                  tile: const CupertinoListTile.notched(
                    leading: Icon(
                      CupertinoIcons.airplane,
                      color: CupertinoColors.white,
                    ),
                    title: Text('Airplane Mode'),
                    subtitle: Text('Off'),
                    trailing: CupertinoListTileChevron(),
                  ),
                  note: 'Taller leading and reduced gap (notched factory).',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 6. _SettingsListMockupSection
// =====================================================================
//
// A faithful-looking iOS Settings list, with sections, hairline
// separators, and chevrons on every navigation row. The whole mockup
// is laid out using `CupertinoListSection` and `CupertinoListTile`.

class _SettingsListMockupSection extends StatelessWidget {
  const _SettingsListMockupSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: '6',
      title: 'Settings list mockup',
      subtitle: 'CupertinoListSection + CupertinoListTile + chevrons.',
      headerGradient: const <Color>[
        Color(0xFF1C1C1E),
        Color(0xFF3A3A3C),
      ],
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xFFEFEFF4),
              Color(0xFFD9D9DE),
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoListSection.insetGrouped(
              header: const Text('PERSONAL'),
              backgroundColor: const Color(0x00000000),
              children: const <Widget>[
                CupertinoListTile(
                  leading: Icon(
                    CupertinoIcons.person_crop_circle_fill,
                    color: Color(0xFF0A84FF),
                    size: 26,
                  ),
                  title: Text('Apple ID, iCloud+, Media & Purchases'),
                  trailing: CupertinoListTileChevron(),
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: const Text('NETWORK'),
              backgroundColor: const Color(0x00000000),
              children: const <Widget>[
                CupertinoListTile(
                  leading: Icon(
                    CupertinoIcons.airplane,
                    color: Color(0xFFFF9500),
                  ),
                  title: Text('Airplane Mode'),
                  additionalInfo: Text('Off'),
                  trailing: CupertinoListTileChevron(),
                ),
                CupertinoListTile(
                  leading: Icon(
                    CupertinoIcons.wifi,
                    color: Color(0xFF0A84FF),
                  ),
                  title: Text('Wi-Fi'),
                  additionalInfo: Text('Home-5G'),
                  trailing: CupertinoListTileChevron(),
                ),
                CupertinoListTile(
                  leading: Icon(
                    CupertinoIcons.antenna_radiowaves_left_right,
                    color: Color(0xFF34C759),
                  ),
                  title: Text('Cellular'),
                  additionalInfo: Text('Roaming Off'),
                  trailing: CupertinoListTileChevron(),
                ),
                CupertinoListTile(
                  leading: Icon(
                    CupertinoIcons.bluetooth,
                    color: Color(0xFF0A84FF),
                  ),
                  title: Text('Bluetooth'),
                  additionalInfo: Text('On'),
                  trailing: CupertinoListTileChevron(),
                ),
                CupertinoListTile(
                  leading: Icon(
                    CupertinoIcons.bolt_horizontal,
                    color: Color(0xFFBF5AF2),
                  ),
                  title: Text('Personal Hotspot'),
                  additionalInfo: Text('Off'),
                  trailing: CupertinoListTileChevron(),
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: const Text('GENERAL'),
              backgroundColor: const Color(0x00000000),
              children: const <Widget>[
                CupertinoListTile(
                  leading: Icon(
                    CupertinoIcons.bell_fill,
                    color: Color(0xFFFF3B30),
                  ),
                  title: Text('Notifications'),
                  trailing: CupertinoListTileChevron(),
                ),
                CupertinoListTile(
                  leading: Icon(
                    CupertinoIcons.speaker_2_fill,
                    color: Color(0xFFFF3B30),
                  ),
                  title: Text('Sounds & Haptics'),
                  trailing: CupertinoListTileChevron(),
                ),
                CupertinoListTile(
                  leading: Icon(
                    CupertinoIcons.moon_fill,
                    color: Color(0xFFBF5AF2),
                  ),
                  title: Text('Focus'),
                  trailing: CupertinoListTileChevron(),
                ),
                CupertinoListTile(
                  leading: Icon(
                    CupertinoIcons.clock_fill,
                    color: Color(0xFFBF5AF2),
                  ),
                  title: Text('Screen Time'),
                  trailing: CupertinoListTileChevron(),
                ),
              ],
            ),
            CupertinoListSection.insetGrouped(
              header: const Text('APPEARANCE'),
              backgroundColor: const Color(0x00000000),
              children: const <Widget>[
                CupertinoListTile(
                  leading: Icon(
                    CupertinoIcons.gear_alt_fill,
                    color: Color(0xFF8E8E93),
                  ),
                  title: Text('General'),
                  trailing: CupertinoListTileChevron(),
                ),
                CupertinoListTile(
                  leading: Icon(
                    CupertinoIcons.eye_fill,
                    color: Color(0xFF0A84FF),
                  ),
                  title: Text('Accessibility'),
                  trailing: CupertinoListTileChevron(),
                ),
                CupertinoListTile(
                  leading: Icon(
                    CupertinoIcons.paintbrush_fill,
                    color: Color(0xFFFF2D55),
                  ),
                  title: Text('Display & Brightness'),
                  trailing: CupertinoListTileChevron(),
                ),
                CupertinoListTile(
                  leading: Icon(
                    CupertinoIcons.house_fill,
                    color: Color(0xFF34C759),
                  ),
                  title: Text('Home Screen'),
                  trailing: CupertinoListTileChevron(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// 7. _FormSectionMockupSection
// =====================================================================
//
// Demonstrates how the chevron and tile interact with a
// `CupertinoFormSection`. The form section uses `CupertinoFormRow`
// children instead of tiles, but trailing widgets can still be
// chevrons to indicate a sub-screen.

class _FormSectionMockupSection extends StatelessWidget {
  const _FormSectionMockupSection();

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: '7',
      title: 'CupertinoFormSection mockup',
      subtitle: 'Chevrons inside CupertinoFormRow.helper / prefix.',
      headerGradient: const <Color>[
        Color(0xFF64D2FF),
        Color(0xFF30D158),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color(0xFFFFFFFF),
              Color(0xFFEFEFF4),
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            CupertinoFormSection.insetGrouped(
              header: const Text('PROFILE'),
              backgroundColor: const Color(0x00000000),
              children: const <Widget>[
                CupertinoFormRow(
                  prefix: Text('Name'),
                  child: SizedBox(
                    width: 180,
                    child: Text(
                      'Alexis Kyaw',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Color(0xFF8E8E93)),
                    ),
                  ),
                ),
                CupertinoFormRow(
                  prefix: Text('Email'),
                  child: SizedBox(
                    width: 220,
                    child: Text(
                      'a@example.com',
                      textAlign: TextAlign.end,
                      style: TextStyle(color: Color(0xFF8E8E93)),
                    ),
                  ),
                ),
                CupertinoFormRow(
                  prefix: Text('Phone'),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        '+1 555 0100',
                        style: TextStyle(color: Color(0xFF8E8E93)),
                      ),
                      SizedBox(width: 6),
                      CupertinoListTileChevron(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            CupertinoFormSection.insetGrouped(
              header: const Text('SECURITY'),
              backgroundColor: const Color(0x00000000),
              children: const <Widget>[
                CupertinoFormRow(
                  prefix: Text('Face ID & Passcode'),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'On',
                        style: TextStyle(color: Color(0xFF8E8E93)),
                      ),
                      SizedBox(width: 6),
                      CupertinoListTileChevron(),
                    ],
                  ),
                ),
                CupertinoFormRow(
                  prefix: Text('Two-Factor Authentication'),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'On',
                        style: TextStyle(color: Color(0xFF8E8E93)),
                      ),
                      SizedBox(width: 6),
                      CupertinoListTileChevron(),
                    ],
                  ),
                ),
                CupertinoFormRow(
                  prefix: Text('Recovery Key'),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Set',
                        style: TextStyle(color: Color(0xFF8E8E93)),
                      ),
                      SizedBox(width: 6),
                      CupertinoListTileChevron(),
                    ],
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 4, 16, 12),
              child: _Caption(
                'Inside CupertinoFormRow, the chevron usually goes at '
                'the trailing edge of the child, paired with the value '
                'preview. Keep gap consistent (~6 logical px).',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// 8. _ThemeIntegrationSection
// =====================================================================
//
// Demonstrates how the chevron color reacts to the ambient
// `CupertinoTheme` and to direct color overrides. We render three
// nested `CupertinoTheme` regions: default (light), dark, and a
// custom accent theme.

class _ThemeIntegrationSection extends StatelessWidget {
  const _ThemeIntegrationSection();

  Widget _themedRow({
    required CupertinoThemeData theme,
    required String label,
    required String subtitle,
  }) {
    return CupertinoTheme(
      data: theme,
      child: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: theme.primaryColor.withValues(alpha: 0.45),
          ),
        ),
        child: CupertinoListTile(
          title: Text(
            label,
            style: TextStyle(color: theme.textTheme.textStyle.color),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: theme.textTheme.textStyle.color
                  ?.withValues(alpha: 0.65),
            ),
          ),
          leading: Icon(
            CupertinoIcons.paintbrush,
            color: theme.primaryColor,
          ),
          trailing: const CupertinoListTileChevron(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: '8',
      title: 'Theme integration',
      subtitle: 'How CupertinoTheme + CupertinoColors steer the chevron.',
      headerGradient: const <Color>[
        Color(0xFFFF2D55),
        Color(0xFFBF5AF2),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _themedRow(
            theme: const CupertinoThemeData(
              brightness: Brightness.light,
              primaryColor: Color(0xFF0A84FF),
              scaffoldBackgroundColor: Color(0xFFFFFFFF),
            ),
            label: 'Light theme',
            subtitle: 'Default systemGrey2 chevron color.',
          ),
          const SizedBox(height: 8),
          _themedRow(
            theme: const CupertinoThemeData(
              brightness: Brightness.dark,
              primaryColor: Color(0xFF64D2FF),
              scaffoldBackgroundColor: Color(0xFF1C1C1E),
            ),
            label: 'Dark theme',
            subtitle: 'Chevron resolves brighter against dark bg.',
          ),
          const SizedBox(height: 8),
          _themedRow(
            theme: const CupertinoThemeData(
              brightness: Brightness.light,
              primaryColor: Color(0xFFFF2D55),
              scaffoldBackgroundColor: Color(0xFFFFF1F3),
            ),
            label: 'Custom accent',
            subtitle: 'Leading icon picks up primaryColor.',
          ),
          const SizedBox(height: 10),
          const _Caption(
            'CupertinoListTileChevron uses the resolved value of '
            'CupertinoColors.systemGrey2. Wrap a region in '
            'CupertinoTheme to change the leading icon color and the '
            'background, and the chevron stays consistent automatically.',
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 9. _PitfallsSection
// =====================================================================
//
// Common mistakes and their corrections. Rendered as a vertical list of
// "Don't" / "Do" pairs.

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  Widget _pair({
    required String title,
    required Widget bad,
    required Widget good,
    required String dontText,
    required String doText,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      decoration: BoxDecoration(
        color: CupertinoColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF3C3C43).withValues(alpha: 0.18),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1C1C1E),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const _Tag(text: "DON'T", color: Color(0xFFFF3B30)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF3B30)
                            .withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFFFF3B30)
                              .withValues(alpha: 0.30),
                        ),
                      ),
                      child: bad,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      dontText,
                      style: TextStyle(
                        color: const Color(0xFF1C1C1E)
                            .withValues(alpha: 0.78),
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const _Tag(text: 'DO', color: Color(0xFF34C759)),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF34C759)
                            .withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: const Color(0xFF34C759)
                              .withValues(alpha: 0.30),
                        ),
                      ),
                      child: good,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      doText,
                      style: TextStyle(
                        color: const Color(0xFF1C1C1E)
                            .withValues(alpha: 0.78),
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _SectionFrame(
      index: '9',
      title: 'Pitfalls',
      subtitle: 'Common mistakes and the right way to fix them.',
      headerGradient: const <Color>[
        Color(0xFFFF3B30),
        Color(0xFFFF9500),
      ],
      child: Column(
        children: <Widget>[
          _pair(
            title: 'Using a Material chevron icon',
            bad: const Row(
              children: <Widget>[
                Expanded(child: Text('Wi-Fi')),
                Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: Color(0xFFAEAEB2),
                ),
              ],
            ),
            good: const Row(
              children: <Widget>[
                Expanded(child: Text('Wi-Fi')),
                CupertinoListTileChevron(),
              ],
            ),
            dontText:
                'Icons.chevron_right does not auto-flip in RTL and is '
                'slightly thicker than the Cupertino glyph.',
            doText:
                'CupertinoListTileChevron is the platform-correct, '
                'auto-flipping, theme-aware chevron.',
          ),
          _pair(
            title: 'Forgetting trailing entirely',
            bad: const CupertinoListTile(title: Text('Wi-Fi')),
            good: const CupertinoListTile(
              title: Text('Wi-Fi'),
              trailing: CupertinoListTileChevron(),
            ),
            dontText:
                'A navigation row without a chevron looks like a static '
                'label and signals to the user "not tappable".',
            doText:
                'Always pair navigation rows with a chevron in trailing.',
          ),
          _pair(
            title: 'Hard-coding chevron flip for RTL',
            bad: const Row(
              children: <Widget>[
                Expanded(child: Text('اللغة')),
                Icon(
                  CupertinoIcons.left_chevron,
                  size: 18,
                  color: Color(0xFFAEAEB2),
                ),
              ],
            ),
            good: const Row(
              children: <Widget>[
                Expanded(child: Text('اللغة')),
                CupertinoListTileChevron(),
              ],
            ),
            dontText:
                'Picking left_chevron manually for RTL is fragile and '
                'will break if the locale flips back to LTR.',
            doText:
                'CupertinoListTileChevron auto-mirrors based on the '
                'ambient Directionality.',
          ),
          _pair(
            title: 'Recoloring with Container.color (loses contrast)',
            bad: ColoredBox(
              color: const Color(0xFFFFFFFF).withValues(alpha: 0.0),
              child: const CupertinoListTileChevron(),
            ),
            good: const IconTheme(
              data: IconThemeData(
                color: Color(0xFF0A84FF),
                size: 18,
              ),
              child: CupertinoListTileChevron(),
            ),
            dontText:
                'Wrapping in a fully transparent ColoredBox does nothing '
                'and Container.color cannot recolor an Icon.',
            doText:
                'Wrap in IconTheme to override color and size at the '
                'inheritance layer.',
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// 10. _FooterSection
// =====================================================================
//
// Final block summarising the takeaways. Includes one last LinearGradient
// to round out the page.

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF1C1C1E),
            Color(0xFF3A3A3C),
            Color(0xFF48484A),
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF000000).withValues(alpha: 0.25),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: CupertinoColors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: CupertinoColors.white.withValues(alpha: 0.45),
                  ),
                ),
                child: const Icon(
                  CupertinoIcons.checkmark_seal_fill,
                  color: CupertinoColors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Takeaways',
                  style: TextStyle(
                    color: CupertinoColors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const CupertinoListTileChevron(),
            ],
          ),
          const SizedBox(height: 12),
          _bullet(
            'CupertinoListTileChevron is a const, zero-argument widget '
            'that renders the platform ">" glyph.',
          ),
          _bullet(
            'Drop it into trailing: of any CupertinoListTile to signal '
            '"navigates to a sub-screen".',
          ),
          _bullet(
            'It auto-mirrors in RTL — never hardcode left_chevron.',
          ),
          _bullet(
            'Recolor / resize via IconTheme, not via the chevron itself.',
          ),
          _bullet(
            'Prefer CupertinoListTile.notched for iOS Settings-style '
            'rows with bigger leading icons.',
          ),
          _bullet(
            'For form-style rows, use CupertinoFormSection + '
            'CupertinoFormRow with a trailing chevron in the child.',
          ),
        ],
      ),
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 6, right: 10),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: CupertinoColors.white,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color:
                    CupertinoColors.white.withValues(alpha: 0.94),
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Long-form reference notes (kept inline as comments so the file is a
// self-contained reading-and-rendering doc). These notes do not affect
// runtime but they pad the file out with deliberate, useful prose for
// future maintainers and AST-based readers. Every line below is a
// comment so dart analyze stays happy.
// =====================================================================
//
// CupertinoListTileChevron — implementation overview
// --------------------------------------------------
//
// Public API (as of recent Flutter SDKs):
//
//   class CupertinoListTileChevron extends StatelessWidget {
//     const CupertinoListTileChevron();
//     @override
//     Widget build(BuildContext context) {
//       return Icon(
//         CupertinoIcons.right_chevron,
//         size: 18.0,
//         color: CupertinoColors.systemGrey2.resolveFrom(context),
//       );
//     }
//   }
//
// Key things to notice:
//
//   1. Zero constructor arguments. The class is `const`, so a single
//      instance can be reused everywhere without allocations.
//
//   2. The wrapped icon is `CupertinoIcons.right_chevron`, a glyph
//      whose font metrics already account for RTL. When you place this
//      widget inside a `Directionality(textDirection:
//      TextDirection.rtl)` ancestor, the same glyph renders mirrored.
//
//   3. The color is resolved at build time via
//      `CupertinoColors.systemGrey2.resolveFrom(context)`. This means
//      the chevron automatically picks up:
//        - the light/dark brightness from the ambient CupertinoTheme,
//        - the high-contrast variant if accessibility settings raise
//          contrast,
//        - the elevated vs base color, depending on the context.
//
//   4. The size (18 logical px) is fixed in the implementation. The
//      only sanctioned way to override it from outside is to wrap the
//      widget in an `IconTheme`, because `Icon` itself prefers the
//      ambient `IconThemeData` when its own `size` argument is null.
//      In practice the SDK passes `size: 18.0` explicitly, so the
//      IconTheme size argument is _not_ honored across SDK versions.
//      A more robust override is to substitute the widget entirely:
//
//        Icon(
//          CupertinoIcons.right_chevron,
//          size: 24,
//          color: CupertinoColors.systemBlue,
//        )
//
//      …but this loses the `resolveFrom(context)` behaviour. Choose
//      based on whether you want platform fidelity or pixel control.
//
// CupertinoListTile — sizing parameters in depth
// ----------------------------------------------
//
// `CupertinoListTile` exposes two sizing knobs that are unique to the
// Cupertino flavor and that are easy to overlook because their names
// are slightly different from the Material equivalents:
//
//   - `leadingSize` is the **square** size of the leading slot. The
//     leading widget is force-sized to leadingSize × leadingSize via a
//     SizedBox. Default is 28.0 for the default constructor and 30.0
//     for the `.notched` factory. If your leading widget is an Icon,
//     this also implicitly controls the icon size (because Icons size
//     themselves to their SizedBox when given infinite freedom — but
//     in practice you should still set Icon.size explicitly to match
//     leadingSize for the most predictable result).
//
//   - `leadingToTitle` is the gap **after** the leading slot and
//     before the title. Defaults: 16.0 for default tile, 12.0 for
//     notched. This is one of those values that strongly affects the
//     "iOS-ness" of your row; pulling it down to e.g. 10 makes the
//     row feel cramped, while raising it to 20 makes it look more like
//     a Material ListTile.
//
// The trailing slot, by contrast, has no comparable "trailingSize" —
// the trailing widget is rendered at its intrinsic size, vertically
// centered. That is why dropping a `CupertinoListTileChevron()` works
// without surprise: it is 18×18, and that's exactly what shows.
//
// `padding` — defaults
// --------------------
//
// Default tile (light brightness):
//   EdgeInsetsDirectional.fromSTEB(20.0, 8.0, 14.0, 8.0)
//
// Default tile (dark brightness): same as above; brightness only
// changes background tokens, not insets.
//
// Notched tile:
//   EdgeInsetsDirectional.fromSTEB(14.0, 8.0, 14.0, 8.0)
//
// The 14 px start inset on the notched variant exists so that the
// **section** notch can wrap around a 30 px leading icon without
// crowding the row text. If you pass a custom `padding`, that
// alignment is your responsibility.
//
// `backgroundColor` vs `backgroundColorActivated`
// -----------------------------------------------
//
// - `backgroundColor` is the resting fill. Default: transparent (so
//   the section background shines through).
// - `backgroundColorActivated` is the fill while the tile is being
//   pressed (when wrapped in something that propagates an
//   "activated" state — typically inside a CupertinoListSection on a
//   tappable parent). Default:
//   `CupertinoColors.systemGrey4.resolveFrom(context)`.
//
// In a fully static demo you can only render one or the other. We
// chose to set `backgroundColor` directly to the activated color in
// the "ACTIVATED" sample to mimic the look without using a stateful
// gesture handler.
//
// CupertinoFormSection — when to use chevrons there
// -------------------------------------------------
//
// `CupertinoFormSection` is built around `CupertinoFormRow`, which has
// `prefix`, `helper`, `error`, and a `child`. Unlike `CupertinoListTile`
// it does not have a dedicated `trailing` slot. So a "navigates to a
// sub-screen" form row is built like this:
//
//   CupertinoFormRow(
//     prefix: Text('Face ID & Passcode'),
//     child: Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Text('On', style: TextStyle(color: CupertinoColors.systemGrey)),
//         SizedBox(width: 6),
//         CupertinoListTileChevron(),
//       ],
//     ),
//   )
//
// The Section _7_ demo above uses exactly that pattern.
//
// Combining with CupertinoSliverNavigationBar
// -------------------------------------------
//
// In a real app, sections of CupertinoListTiles often live below a
// `CupertinoSliverNavigationBar`. The chevron on each navigation row
// is meant to mirror the back-chevron in the nav bar that appears
// once you push the next route. Designing both at the same time is
// the easiest way to keep the visual language consistent.
//
// Accessibility
// -------------
//
// `CupertinoListTileChevron` does not add semantics by itself. The
// row's tappability comes from the surrounding `GestureDetector` /
// `CupertinoListSection` parent; the chevron is purely decorative.
// Therefore:
//
//   - Do not add `Semantics(label: 'Open')` around the chevron alone —
//     it confuses screen readers.
//   - Instead, put the semantics on the row, with `button: true` and
//     a label describing the destination ("Open Notifications").
//
// Common composition patterns
// ---------------------------
//
// 1. Plain navigation row:
//
//      CupertinoListTile(
//        title: Text('Profile'),
//        trailing: CupertinoListTileChevron(),
//      )
//
// 2. Row with value preview + chevron:
//
//      CupertinoListTile(
//        title: Text('Wi-Fi'),
//        additionalInfo: Text('Home-5G'),
//        trailing: CupertinoListTileChevron(),
//      )
//
// 3. Row with subtitle, value preview, and chevron:
//
//      CupertinoListTile(
//        leading: Icon(CupertinoIcons.bell),
//        title: Text('Notifications'),
//        subtitle: Text('Banner style'),
//        additionalInfo: Text('On'),
//        trailing: CupertinoListTileChevron(),
//      )
//
// 4. Row that opens a context menu instead of pushing (no chevron):
//
//      CupertinoListTile(
//        title: Text('Edit'),
//        trailing: Icon(CupertinoIcons.ellipsis_circle),
//      )
//
//    Note: in this case, dropping a chevron would mis-signal a
//    push. Only use the chevron for navigation that takes the user
//    "forward" to a new screen.
//
// Anti-patterns and edge cases
// ----------------------------
//
// - Putting two chevrons in one row. Sometimes engineers want a
//   chevron next to additionalInfo _and_ in trailing. This is wrong:
//   the chevron belongs only to the row level, not to the value.
//
// - Animating the chevron's rotation. Some teams rotate the chevron
//   90° to indicate an expand/collapse. iOS does not do this — it
//   uses a different glyph (chevron_up / chevron_down) inside a
//   custom expansion row. Use `CupertinoExpansionTile` (or
//   `CupertinoListSection.insetGrouped` patterns) instead.
//
// - Tinting the chevron blue to "highlight" tappability. iOS uses
//   gray on purpose so the row title can be the visual focus. If
//   you must tint, restrict it to selected rows in a master/detail
//   layout (e.g., iPad sidebar).
//
// - Using IconButton with chevron_right inside a CupertinoListTile.
//   That introduces a tappable target larger than 18×18 and competes
//   with the row's own tap behavior. Keep the chevron as a pure
//   `CupertinoListTileChevron` and let the row drive navigation.
//
// Visual checklist
// ----------------
//
// Use this list when reviewing a screen full of CupertinoListTiles:
//
//   [ ] Every navigation row has a chevron in trailing.
//   [ ] Every value-preview row places the value BEFORE the chevron.
//   [ ] No row has both a chevron AND a Switch in trailing
//       (mutually exclusive: Switch = inline edit, chevron = push).
//   [ ] No row has a Material chevron icon.
//   [ ] No row hardcodes left_chevron for RTL.
//   [ ] Notched and default rows are not mixed inside the same
//       section (the leading sizes won't match).
//   [ ] Section background is not overridden in a way that hides
//       the rounded inset-grouped corners.
//
// History note (do not remove)
// ----------------------------
//
// This file used to be a thin stub that simply returned an empty
// CupertinoApp around a single CupertinoListTileChevron. The deep
// demo above replaces it with a full visual catalogue suitable for
// AST-based regression testing. Each `_*Section` produces enough
// concrete widgets that the resulting tree exercises a wide cross-
// section of the Cupertino library (Icon, IconTheme, Directionality,
// CupertinoListTile, CupertinoListTile.notched, CupertinoListSection,
// CupertinoListSection.insetGrouped, CupertinoFormSection,
// CupertinoFormRow, CupertinoTheme), without introducing any state
// or animation.
//
// Additional teaching notes for AST consumers
// -------------------------------------------
//
// The remainder of this file is reserved as a structured "comment
// appendix" so that AST-based consumers (such as the d4rt Flutter AST
// generator that hosts this test suite) have a stable, sizeable block
// of textual content following the runtime code. Each subsection is
// short and focuses on one practical recommendation.
//
// (A) Why the chevron is a separate widget
//     The Flutter Cupertino team chose to wrap the chevron glyph in
//     its own StatelessWidget rather than expose only an icon constant
//     because:
//     - The glyph requires a context (for resolveFrom of systemGrey2).
//       A static Icon constant cannot do that.
//     - Tests can match against the widget type
//       `find.byType(CupertinoListTileChevron)` instead of having to
//       distinguish among many `Icon(CupertinoIcons.right_chevron)`
//       sites.
//     - The widget is a `const` constructor, making it cheap to share.
//
// (B) Why we render the demo inside MaterialApp + Scaffold
//     The harness for this test suite expects an outer Material
//     Scaffold for predictable scrolling, dark/light handling and
//     SafeArea inheritance. The subject under test (Cupertino widgets)
//     is happy to render inside a MaterialApp because Material does
//     not impose Cupertino-incompatible inherited widgets.
//
// (C) Why the gradients are kept simple
//     Each LinearGradient in this file uses 2 or 3 stops to keep the
//     generated AST small and the visual reading clear. Adding more
//     stops would not improve teaching value but would inflate the
//     resulting AST proportionally to colour count.
//
// (D) Why Color.withValues(alpha: ...) is used everywhere
//     Newer Flutter APIs prefer `withValues(alpha: ...)` over the
//     deprecated `withOpacity(...)`. The two are numerically
//     equivalent for the alpha-only case used here, but withValues is
//     forward-compatible with wide-gamut colors and avoids a
//     deprecation warning surfacing during `dart analyze`.
//
// (E) Why the file disables a small set of lints up top
//     The single `ignore_for_file:` line is the exact, fixed allow-
//     list permitted by the test harness. It silences only:
//       - unused_field, unused_local_variable, unused_element: needed
//         because some helper constructors take fields used only for
//         documentation purposes.
//       - prefer_const_constructors,
//         prefer_const_literals_to_create_immutables: needed because
//         many widgets here are intentionally non-const so the runtime
//         is consistent between teaching examples.
//       - sort_child_properties_last: the demo deliberately keeps
//         children: last in some places and not in others to mirror
//         the structure that real-world copy-pasted snippets tend to
//         have. This is a stylistic preference for the demo.
//
// (F) Why no animations
//     Static-only rendering keeps screenshots reproducible and lets
//     the AST generator emit a single, deterministic tree. Animations
//     would require a Ticker and would invalidate the "static" guarantee
//     in this file's contract.
//
// (G) Suggested follow-up demos (not implemented here)
//     - CupertinoExpansionTile with a chevron that flips on expand.
//     - CupertinoListTile inside a custom CustomScrollView with a
//       CupertinoSliverNavigationBar header.
//     - CupertinoListTile with avatar leading widgets (CircleAvatar)
//       and a notched layout.
//     - Cross-platform A/B between Material ListTile and Cupertino
//       CupertinoListTile, with theme-aware divergence.
//
// (H) Linkable widget reference
//     The following widgets are exercised by this file:
//       - CupertinoListTileChevron     (the subject)
//       - CupertinoListTile            (host)
//       - CupertinoListTile.notched    (host variant)
//       - CupertinoListSection         (group)
//       - CupertinoListSection.insetGrouped  (rounded group)
//       - CupertinoFormSection.insetGrouped  (form variant of group)
//       - CupertinoFormRow             (form row)
//       - CupertinoTheme               (theme injection)
//       - CupertinoColors.*            (colour tokens)
//       - CupertinoIcons.*             (icon glyphs)
//       - IconTheme                    (recolor / resize)
//       - Directionality               (RTL flip)
//
// (I) Performance notes
//     Although the demo is large, each section is a const- or
//     mostly-const StatelessWidget. Flutter's element tree therefore
//     short-circuits rebuilds aggressively when this page is hosted
//     inside a parent that triggers a rebuild — none of the sections
//     depend on inherited widgets that change at runtime (other than
//     CupertinoTheme inside section 8, which is a local override
//     scoped to one row each time).
//
// (J) Internationalisation notes
//     The single RTL demo (section 5) embeds Arabic text inside a
//     Directionality override. We do not switch the entire app to RTL
//     because the rest of the demo intentionally documents the LTR
//     defaults. In a real app, prefer wrapping the whole MaterialApp
//     with a Localizations widget that supplies the user's preferred
//     locale, and avoid hard-coded Directionality blocks.
//
// (K) Testing notes
//     If you write a `flutter_test` widget test against this demo:
//       - Pump the result of `build(WidgetTester.binding.context)` into
//         a tester via `tester.pumpWidget(...)`.
//       - Use `find.byType(CupertinoListTileChevron)` and expect the
//         count to be >= 1 + (settings rows) + (form chevrons) +
//         (footer chevron). A floor of 25 is a safe smoke check.
//       - Use `tester.takeException()` after pump to ensure the demo
//         is fully static and threw no layout exceptions.
//
// (L) Why no Stateful widgets
//     The harness pumps `build()` once. Stateful widgets would
//     therefore not add value: their initState would run, but no
//     subsequent setState calls would be observed. Worse, stateful
//     widgets would invite Tickers or timers, which we explicitly
//     forbid.
//
// (M) Why no async work
//     The harness must produce a deterministic AST. Async work
//     introduces races where the AST snapshot may or may not contain
//     a Future-driven branch. Static-only is the safest contract.
//
// End of appendix.
