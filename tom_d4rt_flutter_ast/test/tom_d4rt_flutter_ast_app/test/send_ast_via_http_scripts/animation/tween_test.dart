// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep visual demo for the Tween<T> family in flutter/animation.
//
// DESIGN PLAN
// -----------
// The Tween family in Flutter is the language of interpolation. Each subtype
// teaches a slightly different lesson about what it means to "blend" between
// two values. This script renders each lesson visually instead of merely
// describing it in prose: every sample of Tween.lerp(t) at t in
// {0.0, 0.25, 0.5, 0.75, 1.0} becomes a real Flutter widget rendered inline
// so a human reviewing the AST output can see the geometry, colour, and text
// of the interpolation. The script is laid out as ten numbered sections:
//   1. Gradient banner introducing the Tween mental model.
//   2. Tween<double> base case + IntTween rounding behaviour.
//   3. ColorTween swatches (linear blend in sRGB space).
//   4. SizeTween + RectTween geometric interpolation.
//   5. AlignmentTween directional grid.
//   6. EdgeInsetsTween + BorderRadiusTween padding/corner morphs.
//   7. BorderTween + TextStyleTween + Matrix4Tween typography & transforms.
//   8. ConstantTween + ReverseTween + CurveTween mechanics.
//   9. .chain() and .animate() pipeline diagrams.
//  10. Recipe deck + glossary of every Tween subtype.
// The root widget is stateless and renders a single scrolling Column so the
// AST runner can capture the entire diagram in one frame.

import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const TweenDemoApp());

// ---------------------------------------------------------------------------
// Root widget
// ---------------------------------------------------------------------------
class TweenDemoApp extends StatelessWidget {
  const TweenDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('Tween Deep Demo executing');
    final ColorScheme scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF4F46E5),
      brightness: Brightness.light,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tween Family Deep Demo',
      theme: ThemeData(useMaterial3: true, colorScheme: scheme),
      home: Scaffold(
        backgroundColor: scheme.surface,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const HeaderBanner(),
              const SizedBox(height: 28.0),
              SectionDoubleAndInt(scheme: scheme),
              const SizedBox(height: 36.0),
              SectionColorTween(scheme: scheme),
              const SizedBox(height: 36.0),
              SectionSizeAndRect(scheme: scheme),
              const SizedBox(height: 36.0),
              SectionAlignmentTween(scheme: scheme),
              const SizedBox(height: 36.0),
              SectionEdgeAndRadius(scheme: scheme),
              const SizedBox(height: 36.0),
              SectionBorderTextStyleMatrix(scheme: scheme),
              const SizedBox(height: 36.0),
              SectionConstantReverseCurve(scheme: scheme),
              const SizedBox(height: 36.0),
              SectionChainAndAnimate(scheme: scheme),
              const SizedBox(height: 36.0),
              SectionRecipesAndGlossary(scheme: scheme),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Shared helpers
// ---------------------------------------------------------------------------
const List<double> kSamples = <double>[0.0, 0.25, 0.5, 0.75, 1.0];

/// Heading bar printed for each section. Also prints the section banner to
/// the script stdout so the AST runner can verify section ordering.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.number,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.scheme,
  });

  final int number;
  final String title;
  final String subtitle;
  final IconData icon;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    // Side-effect: log the section banner to the AST runner console.
    print('=== Section $number: $title ===');
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: scheme.primary, width: 1.5),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 48.0,
            height: 48.0,
            decoration: BoxDecoration(
              color: scheme.primary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '$number',
              style: TextStyle(
                color: scheme.onPrimary,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 14.0),
          Icon(icon, color: scheme.onPrimaryContainer, size: 28.0),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: scheme.onPrimaryContainer,
                  ),
                ),
                const SizedBox(height: 2.0),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: scheme.onPrimaryContainer.withValues(alpha: 0.78),
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

/// Card surrounding the lerp samples for one Tween instance, with a title and
/// the begin/end summary printed at the top.
class SampleCard extends StatelessWidget {
  const SampleCard({
    super.key,
    required this.title,
    required this.beginLabel,
    required this.endLabel,
    required this.children,
    required this.scheme,
    this.accent,
  });

  final String title;
  final String beginLabel;
  final String endLabel;
  final List<Widget> children;
  final ColorScheme scheme;
  final Color? accent;

  @override
  Widget build(BuildContext context) {
    final Color band = accent ?? scheme.secondary;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: scheme.outlineVariant, width: 1.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.05),
            blurRadius: 6.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 14.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: band.withValues(alpha: 0.12),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14.0),
                topRight: Radius.circular(14.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                Container(
                  width: 8.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    color: band,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  ),
                ),
                Text(
                  '$beginLabel  ->  $endLabel',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

/// A single column under a SampleCard showing one t value and its rendered
/// preview underneath.
class SampleColumn extends StatelessWidget {
  const SampleColumn({
    super.key,
    required this.t,
    required this.label,
    required this.preview,
    required this.scheme,
  });

  final double t;
  final String label;
  final Widget preview;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 8.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: scheme.secondaryContainer,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            't = ${t.toStringAsFixed(2)}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: scheme.onSecondaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        preview,
        const SizedBox(height: 6.0),
        SizedBox(
          width: 76.0,
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: scheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Header banner
// ---------------------------------------------------------------------------
class HeaderBanner extends StatelessWidget {
  const HeaderBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[
            Color(0xFF4F46E5),
            Color(0xFF7C3AED),
            Color(0xFFEC4899),
          ],
          stops: <double>[0.0, 0.5, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF4F46E5).withValues(alpha: 0.35),
            blurRadius: 18.0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.timeline, color: Colors.white, size: 36.0),
              SizedBox(width: 12.0),
              Text(
                'The Tween Family',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12.0),
          const Text(
            'Tween<T> describes how to interpolate between two values of type T.',
            style: TextStyle(color: Colors.white, fontSize: 14.0),
          ),
          const SizedBox(height: 6.0),
          const Text(
            'Every subtype answers one question: "what does halfway look like?"',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 13.0,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 14.0),
          Wrap(
            spacing: 8.0,
            runSpacing: 6.0,
            children: const <Widget>[
              _BannerPill(text: 'Tween<T>'),
              _BannerPill(text: 'IntTween'),
              _BannerPill(text: 'ColorTween'),
              _BannerPill(text: 'SizeTween'),
              _BannerPill(text: 'RectTween'),
              _BannerPill(text: 'AlignmentTween'),
              _BannerPill(text: 'EdgeInsetsTween'),
              _BannerPill(text: 'BorderRadiusTween'),
              _BannerPill(text: 'BorderTween'),
              _BannerPill(text: 'TextStyleTween'),
              _BannerPill(text: 'Matrix4Tween'),
              _BannerPill(text: 'ConstantTween'),
              _BannerPill(text: 'ReverseTween'),
              _BannerPill(text: 'CurveTween'),
            ],
          ),
        ],
      ),
    );
  }
}

class _BannerPill extends StatelessWidget {
  const _BannerPill({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.white.withValues(alpha: 0.45)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontFamily: 'monospace',
          fontSize: 11.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 1: Tween<double> base case + IntTween rounding
// ---------------------------------------------------------------------------
class SectionDoubleAndInt extends StatelessWidget {
  const SectionDoubleAndInt({super.key, required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final Tween<double> dt = Tween<double>(begin: 0.0, end: 200.0);
    final IntTween it = IntTween(begin: 0, end: 100);
    final Tween<double> reversed =
        Tween<double>(begin: 100.0, end: -50.0);

    print('Tween<double>(0, 200) midpoint = ${dt.transform(0.5)}');
    print('IntTween(0, 100) at 0.27 = ${it.transform(0.27)}');

    final List<Widget> dblColumns = <Widget>[];
    for (final double t in kSamples) {
      final double v = dt.transform(t);
      dblColumns.add(SampleColumn(
        t: t,
        label: v.toStringAsFixed(2),
        scheme: scheme,
        preview: _Bar(value: v / 200.0, color: scheme.primary),
      ));
    }

    final List<Widget> intColumns = <Widget>[];
    for (final double t in kSamples) {
      final int v = it.transform(t);
      intColumns.add(SampleColumn(
        t: t,
        label: v.toString(),
        scheme: scheme,
        preview: Container(
          width: 56.0,
          height: 56.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: scheme.tertiaryContainer,
            border: Border.all(color: scheme.tertiary, width: 1.5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '$v',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: scheme.onTertiaryContainer,
            ),
          ),
        ),
      ));
    }

    final List<Widget> reversedColumns = <Widget>[];
    for (final double t in kSamples) {
      final double v = reversed.transform(t);
      reversedColumns.add(SampleColumn(
        t: t,
        label: v.toStringAsFixed(1),
        scheme: scheme,
        preview: _Bar(
          value: (v + 50.0) / 150.0,
          color: scheme.error,
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SectionHeader(
          number: 1,
          title: 'Tween<double> and IntTween',
          subtitle:
              'The base case: linear interpolation between two scalar values.',
          icon: Icons.straighten,
          scheme: scheme,
        ),
        const SizedBox(height: 12.0),
        SampleCard(
          title: 'Tween<double>(begin: 0, end: 200)',
          beginLabel: '0.0',
          endLabel: '200.0',
          scheme: scheme,
          children: dblColumns,
        ),
        SampleCard(
          title: 'IntTween(begin: 0, end: 100)  // rounds with .round()',
          beginLabel: '0',
          endLabel: '100',
          accent: scheme.tertiary,
          scheme: scheme,
          children: intColumns,
        ),
        SampleCard(
          title: 'Tween<double>(begin: 100, end: -50)  // descending range',
          beginLabel: '100.0',
          endLabel: '-50.0',
          accent: scheme.error,
          scheme: scheme,
          children: reversedColumns,
        ),
        const SizedBox(height: 8.0),
        _NoteBox(
          icon: Icons.lightbulb_outline,
          color: scheme.tertiary,
          text:
              'IntTween rounds the lerped double back to an int via .round(); '
              'use it when consumers like indexes require discrete values.',
        ),
      ],
    );
  }
}

class _Bar extends StatelessWidget {
  const _Bar({required this.value, required this.color});
  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final double clamped = value.clamp(0.0, 1.0);
    return Container(
      width: 24.0,
      height: 80.0,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        border: Border.all(color: color.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(4.0),
      ),
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 80.0 * clamped,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4.0),
        ),
      ),
    );
  }
}

class _NoteBox extends StatelessWidget {
  const _NoteBox({
    required this.icon,
    required this.color,
    required this.text,
  });
  final IconData icon;
  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: color, size: 20.0),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 12.0, color: color),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 2: ColorTween
// ---------------------------------------------------------------------------
class SectionColorTween extends StatelessWidget {
  const SectionColorTween({super.key, required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<List<Color>> palettes = <List<Color>>[
      <Color>[const Color(0xFFEF4444), const Color(0xFF22C55E)],
      <Color>[const Color(0xFF0EA5E9), const Color(0xFFFACC15)],
      <Color>[const Color(0xFF111827), const Color(0xFFFAFAFA)],
      <Color>[const Color(0xFFEC4899), const Color(0xFF4F46E5)],
    ];

    final List<Widget> cards = <Widget>[];
    for (int i = 0; i < palettes.length; i++) {
      final ColorTween ct =
          ColorTween(begin: palettes[i][0], end: palettes[i][1]);
      print('ColorTween palette $i: ${palettes[i][0]} -> ${palettes[i][1]}');
      final List<Widget> cols = <Widget>[];
      for (final double t in kSamples) {
        final Color c = ct.transform(t) ?? const Color(0x00000000);
        cols.add(SampleColumn(
          t: t,
          label: _hex(c),
          scheme: scheme,
          preview: Container(
            width: 64.0,
            height: 64.0,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: scheme.outline.withValues(alpha: 0.5),
                width: 1.0,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: c.withValues(alpha: 0.45),
                  blurRadius: 6.0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
        ));
      }

      final Color a = palettes[i][0];
      final Color b = palettes[i][1];
      cards.add(SampleCard(
        title: 'ColorTween (palette ${i + 1})',
        beginLabel: _hex(a),
        endLabel: _hex(b),
        scheme: scheme,
        accent: a,
        children: cols,
      ));
    }

    // Null-handling demonstration.
    final ColorTween nullTween =
        ColorTween(begin: null, end: const Color(0xFF10B981));
    final List<Widget> nullCols = <Widget>[];
    for (final double t in kSamples) {
      final Color? c = nullTween.transform(t);
      nullCols.add(SampleColumn(
        t: t,
        label: c == null ? 'null' : _hex(c),
        scheme: scheme,
        preview: Container(
          width: 64.0,
          height: 64.0,
          decoration: BoxDecoration(
            color: c ?? Colors.transparent,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: scheme.outline,
              width: c == null ? 2.0 : 1.0,
            ),
          ),
          alignment: Alignment.center,
          child: c == null
              ? Icon(
                  Icons.block,
                  color: scheme.error,
                  size: 28.0,
                )
              : null,
        ),
      ));
    }
    cards.add(SampleCard(
      title: 'ColorTween(begin: null, end: 0xFF10B981)',
      beginLabel: 'null',
      endLabel: '#10B981',
      scheme: scheme,
      accent: scheme.error,
      children: nullCols,
    ));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SectionHeader(
          number: 2,
          title: 'ColorTween',
          subtitle: 'Blends sRGB channel values, alpha included.',
          icon: Icons.palette_outlined,
          scheme: scheme,
        ),
        const SizedBox(height: 12.0),
        ...cards,
        _NoteBox(
          icon: Icons.warning_amber,
          color: scheme.error,
          text:
              'ColorTween treats null as fully transparent. Always provide a '
              'concrete end colour if you want a meaningful blend at t=1.0.',
        ),
      ],
    );
  }

  String _hex(Color c) =>
      '#${(c.value & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
}

// ---------------------------------------------------------------------------
// Section 3: SizeTween + RectTween
// ---------------------------------------------------------------------------
class SectionSizeAndRect extends StatelessWidget {
  const SectionSizeAndRect({super.key, required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final SizeTween st =
        SizeTween(begin: const Size(20.0, 20.0), end: const Size(96.0, 56.0));
    final RectTween rt = RectTween(
      begin: const Rect.fromLTWH(0.0, 0.0, 30.0, 30.0),
      end: const Rect.fromLTWH(60.0, 20.0, 70.0, 50.0),
    );
    print('SizeTween midpoint = ${st.transform(0.5)}');
    print('RectTween midpoint = ${rt.transform(0.5)}');

    final List<Widget> sizeCols = <Widget>[];
    for (final double t in kSamples) {
      final Size s = st.transform(t) ?? Size.zero;
      sizeCols.add(SampleColumn(
        t: t,
        label: '${s.width.toStringAsFixed(0)}x${s.height.toStringAsFixed(0)}',
        scheme: scheme,
        preview: SizedBox(
          width: 100.0,
          height: 70.0,
          child: Center(
            child: Container(
              width: s.width,
              height: s.height,
              decoration: BoxDecoration(
                color: scheme.primary.withValues(alpha: 0.15),
                border: Border.all(color: scheme.primary, width: 2.0),
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
          ),
        ),
      ));
    }

    final List<Widget> rectCols = <Widget>[];
    for (final double t in kSamples) {
      final Rect r = rt.transform(t) ?? Rect.zero;
      rectCols.add(SampleColumn(
        t: t,
        label: 'L${r.left.toStringAsFixed(0)} T${r.top.toStringAsFixed(0)}',
        scheme: scheme,
        preview: SizedBox(
          width: 130.0,
          height: 80.0,
          child: CustomPaint(
            painter: _RectPainter(rect: r, color: scheme.secondary),
          ),
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SectionHeader(
          number: 3,
          title: 'SizeTween and RectTween',
          subtitle:
              'Geometric blending: width/height and left/top/right/bottom.',
          icon: Icons.crop_din,
          scheme: scheme,
        ),
        const SizedBox(height: 12.0),
        SampleCard(
          title: 'SizeTween(20x20 -> 96x56)',
          beginLabel: '20x20',
          endLabel: '96x56',
          scheme: scheme,
          accent: scheme.primary,
          children: sizeCols,
        ),
        SampleCard(
          title: 'RectTween(LTWH 0,0,30,30 -> 60,20,70,50)',
          beginLabel: 'small',
          endLabel: 'wide',
          scheme: scheme,
          accent: scheme.secondary,
          children: rectCols,
        ),
        _NoteBox(
          icon: Icons.info_outline,
          color: scheme.primary,
          text:
              'SizeTween treats null as Size.zero. RectTween morphs each edge '
              'independently, so an off-axis Rect translates AND grows at once.',
        ),
      ],
    );
  }
}

class _RectPainter extends CustomPainter {
  _RectPainter({required this.rect, required this.color});
  final Rect rect;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fill = Paint()..color = color.withValues(alpha: 0.18);
    final Paint stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8;
    canvas.drawRect(rect, fill);
    canvas.drawRect(rect, stroke);
  }

  @override
  bool shouldRepaint(_RectPainter oldDelegate) =>
      oldDelegate.rect != rect || oldDelegate.color != color;
}

// ---------------------------------------------------------------------------
// Section 4: AlignmentTween
// ---------------------------------------------------------------------------
class SectionAlignmentTween extends StatelessWidget {
  const SectionAlignmentTween({super.key, required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<List<Alignment>> pairs = <List<Alignment>>[
      <Alignment>[Alignment.topLeft, Alignment.bottomRight],
      <Alignment>[Alignment.centerLeft, Alignment.centerRight],
      <Alignment>[Alignment.topCenter, Alignment.bottomCenter],
      <Alignment>[Alignment.bottomLeft, Alignment.topRight],
    ];

    final List<Widget> cards = <Widget>[];
    for (int i = 0; i < pairs.length; i++) {
      final AlignmentTween at =
          AlignmentTween(begin: pairs[i][0], end: pairs[i][1]);
      print('AlignmentTween $i mid = ${at.transform(0.5)}');
      final List<Widget> cols = <Widget>[];
      for (final double t in kSamples) {
        final Alignment a = at.transform(t);
        cols.add(SampleColumn(
          t: t,
          label: '(${a.x.toStringAsFixed(2)}, ${a.y.toStringAsFixed(2)})',
          scheme: scheme,
          preview: Container(
            width: 72.0,
            height: 72.0,
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              border: Border.all(color: scheme.outline, width: 1.0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Align(
              alignment: a,
              child: Container(
                width: 14.0,
                height: 14.0,
                decoration: BoxDecoration(
                  color: scheme.tertiary,
                  shape: BoxShape.circle,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: scheme.tertiary.withValues(alpha: 0.5),
                      blurRadius: 4.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
      }
      cards.add(SampleCard(
        title: 'AlignmentTween pair ${i + 1}',
        beginLabel: _aLabel(pairs[i][0]),
        endLabel: _aLabel(pairs[i][1]),
        scheme: scheme,
        accent: scheme.tertiary,
        children: cols,
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SectionHeader(
          number: 4,
          title: 'AlignmentTween',
          subtitle: 'Directional interpolation in the [-1,1] x [-1,1] cube.',
          icon: Icons.align_horizontal_center,
          scheme: scheme,
        ),
        const SizedBox(height: 12.0),
        ...cards,
      ],
    );
  }

  String _aLabel(Alignment a) =>
      '(${a.x.toStringAsFixed(0)},${a.y.toStringAsFixed(0)})';
}

// ---------------------------------------------------------------------------
// Section 5: EdgeInsetsTween + BorderRadiusTween
// ---------------------------------------------------------------------------
class SectionEdgeAndRadius extends StatelessWidget {
  const SectionEdgeAndRadius({super.key, required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final EdgeInsetsTween eit = EdgeInsetsTween(
      begin: const EdgeInsets.all(2.0),
      end: const EdgeInsets.fromLTRB(24.0, 4.0, 4.0, 28.0),
    );
    final BorderRadiusTween brt = BorderRadiusTween(
      begin: BorderRadius.zero,
      end: const BorderRadius.only(
        topLeft: Radius.circular(36.0),
        bottomRight: Radius.circular(36.0),
        topRight: Radius.circular(6.0),
        bottomLeft: Radius.circular(6.0),
      ),
    );
    print('EdgeInsetsTween mid = ${eit.transform(0.5)}');
    print('BorderRadiusTween mid = ${brt.transform(0.5)}');

    final List<Widget> eiCols = <Widget>[];
    for (final double t in kSamples) {
      final EdgeInsets e = eit.transform(t);
      eiCols.add(SampleColumn(
        t: t,
        label: 'L${e.left.toStringAsFixed(0)} '
            'B${e.bottom.toStringAsFixed(0)}',
        scheme: scheme,
        preview: Container(
          width: 76.0,
          height: 76.0,
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.10),
            border: Border.all(color: scheme.primary.withValues(alpha: 0.4)),
            borderRadius: BorderRadius.circular(6.0),
          ),
          padding: e,
          child: Container(
            decoration: BoxDecoration(
              color: scheme.primary,
              borderRadius: BorderRadius.circular(4.0),
            ),
          ),
        ),
      ));
    }

    final List<Widget> brCols = <Widget>[];
    for (final double t in kSamples) {
      final BorderRadius b = brt.transform(t) ?? BorderRadius.zero;
      brCols.add(SampleColumn(
        t: t,
        label: 'TL ${b.topLeft.x.toStringAsFixed(0)} '
            'BR ${b.bottomRight.x.toStringAsFixed(0)}',
        scheme: scheme,
        preview: Container(
          width: 76.0,
          height: 60.0,
          decoration: BoxDecoration(
            color: scheme.secondary,
            borderRadius: b,
          ),
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SectionHeader(
          number: 5,
          title: 'EdgeInsetsTween and BorderRadiusTween',
          subtitle:
              'Padding and corner radii each interpolate side by side, '
              'independently.',
          icon: Icons.rounded_corner,
          scheme: scheme,
        ),
        const SizedBox(height: 12.0),
        SampleCard(
          title: 'EdgeInsetsTween(all:2 -> LTRB 24,4,4,28)',
          beginLabel: 'all:2',
          endLabel: '24/4/4/28',
          scheme: scheme,
          accent: scheme.primary,
          children: eiCols,
        ),
        SampleCard(
          title: 'BorderRadiusTween(zero -> mixed corners)',
          beginLabel: 'zero',
          endLabel: 'mixed',
          scheme: scheme,
          accent: scheme.secondary,
          children: brCols,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section 6: BorderTween + TextStyleTween + Matrix4Tween
// ---------------------------------------------------------------------------
class SectionBorderTextStyleMatrix extends StatelessWidget {
  const SectionBorderTextStyleMatrix({super.key, required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final BorderTween bt = BorderTween(
      begin: Border.all(color: scheme.primary, width: 1.0),
      end: Border.all(color: scheme.error, width: 6.0),
    );
    final TextStyleTween tst = TextStyleTween(
      begin: const TextStyle(
        fontSize: 12.0,
        color: Color(0xFF111827),
        fontWeight: FontWeight.w300,
        letterSpacing: 0.0,
      ),
      end: const TextStyle(
        fontSize: 24.0,
        color: Color(0xFFEC4899),
        fontWeight: FontWeight.w900,
        letterSpacing: 2.0,
      ),
    );
    final Matrix4Tween m4t = Matrix4Tween(
      begin: Matrix4.identity(),
      end: Matrix4.identity()
        ..rotateZ(math.pi / 4.0)
        ..scale(1.4, 1.4),
    );
    print('BorderTween midpoint = ${bt.transform(0.5)}');
    print('TextStyleTween midpoint = ${tst.transform(0.5)}');
    print('Matrix4Tween midpoint = ${m4t.transform(0.5)}');

    final List<Widget> borderCols = <Widget>[];
    for (final double t in kSamples) {
      final Border b = bt.transform(t) ?? const Border();
      borderCols.add(SampleColumn(
        t: t,
        label: 'w ${b.top.width.toStringAsFixed(1)}',
        scheme: scheme,
        preview: Container(
          width: 64.0,
          height: 64.0,
          decoration: BoxDecoration(
            color: scheme.surface,
            border: b,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ));
    }

    final List<Widget> styleCols = <Widget>[];
    for (final double t in kSamples) {
      final TextStyle s = tst.transform(t);
      styleCols.add(SampleColumn(
        t: t,
        label: '${s.fontSize?.toStringAsFixed(0) ?? '-'} pt',
        scheme: scheme,
        preview: SizedBox(
          width: 96.0,
          height: 56.0,
          child: Center(
            child: Text('Tween', style: s),
          ),
        ),
      ));
    }

    final List<Widget> matrixCols = <Widget>[];
    for (final double t in kSamples) {
      final Matrix4 m = m4t.transform(t);
      matrixCols.add(SampleColumn(
        t: t,
        label: 'mat[0,0]=${m.entry(0, 0).toStringAsFixed(2)}',
        scheme: scheme,
        preview: SizedBox(
          width: 80.0,
          height: 80.0,
          child: Center(
            child: Transform(
              alignment: Alignment.center,
              transform: m,
              child: Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: scheme.tertiary,
                  borderRadius: BorderRadius.circular(6.0),
                ),
              ),
            ),
          ),
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SectionHeader(
          number: 6,
          title: 'BorderTween, TextStyleTween, Matrix4Tween',
          subtitle:
              'Visual decoration tweens: stroke widths, typography, transforms.',
          icon: Icons.brush_outlined,
          scheme: scheme,
        ),
        const SizedBox(height: 12.0),
        SampleCard(
          title: 'BorderTween(primary 1px -> error 6px)',
          beginLabel: 'thin',
          endLabel: 'thick',
          scheme: scheme,
          accent: scheme.error,
          children: borderCols,
        ),
        SampleCard(
          title: 'TextStyleTween(small light -> large pink heavy)',
          beginLabel: '12 w300',
          endLabel: '24 w900',
          scheme: scheme,
          accent: scheme.secondary,
          children: styleCols,
        ),
        SampleCard(
          title: 'Matrix4Tween(identity -> rotate 45deg + scale 1.4)',
          beginLabel: 'I',
          endLabel: 'R45 S1.4',
          scheme: scheme,
          accent: scheme.tertiary,
          children: matrixCols,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section 7: ConstantTween + ReverseTween + CurveTween
// ---------------------------------------------------------------------------
class SectionConstantReverseCurve extends StatelessWidget {
  const SectionConstantReverseCurve({super.key, required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final ConstantTween<double> kt = ConstantTween<double>(0.42);
    final Tween<double> base = Tween<double>(begin: 0.0, end: 100.0);
    final ReverseTween<double> rt = ReverseTween<double>(base);
    final CurveTween easeIn = CurveTween(curve: Curves.easeIn);
    final CurveTween easeOut = CurveTween(curve: Curves.easeOut);
    final CurveTween elasticOut = CurveTween(curve: Curves.elasticOut);

    print('ConstantTween at every t: ${kt.transform(0.0)} '
        '${kt.transform(0.5)} ${kt.transform(1.0)}');
    print('ReverseTween at 0.0 = ${rt.transform(0.0)} '
        '/ at 1.0 = ${rt.transform(1.0)}');

    final List<Widget> constCols = <Widget>[];
    for (final double t in kSamples) {
      final double v = kt.transform(t);
      constCols.add(SampleColumn(
        t: t,
        label: v.toStringAsFixed(2),
        scheme: scheme,
        preview: _Bar(value: v, color: scheme.primary),
      ));
    }

    final List<Widget> revCols = <Widget>[];
    for (final double t in kSamples) {
      final double v = rt.transform(t);
      revCols.add(SampleColumn(
        t: t,
        label: v.toStringAsFixed(0),
        scheme: scheme,
        preview: _Bar(value: v / 100.0, color: scheme.error),
      ));
    }

    Widget curveCard(CurveTween c, String name, Color colour) {
      final List<Widget> cols = <Widget>[];
      for (final double t in kSamples) {
        final double v = c.transform(t);
        cols.add(SampleColumn(
          t: t,
          label: v.toStringAsFixed(2),
          scheme: scheme,
          preview: SizedBox(
            width: 64.0,
            height: 64.0,
            child: CustomPaint(
              painter: _CurveDotPainter(value: v, color: colour),
            ),
          ),
        ));
      }
      return SampleCard(
        title: 'CurveTween(curve: $name)',
        beginLabel: 't=0',
        endLabel: 't=1',
        scheme: scheme,
        accent: colour,
        children: cols,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SectionHeader(
          number: 7,
          title: 'ConstantTween, ReverseTween, CurveTween',
          subtitle:
              'The three "meta" tweens: hold, flip, and remap the t value.',
          icon: Icons.shuffle,
          scheme: scheme,
        ),
        const SizedBox(height: 12.0),
        SampleCard(
          title: 'ConstantTween<double>(0.42)  // ignores t',
          beginLabel: '0.42',
          endLabel: '0.42',
          scheme: scheme,
          accent: scheme.primary,
          children: constCols,
        ),
        SampleCard(
          title: 'ReverseTween(Tween(0 -> 100))  // swaps direction',
          beginLabel: '100',
          endLabel: '0',
          scheme: scheme,
          accent: scheme.error,
          children: revCols,
        ),
        curveCard(easeIn, 'easeIn', scheme.primary),
        curveCard(easeOut, 'easeOut', scheme.secondary),
        curveCard(elasticOut, 'elasticOut', scheme.tertiary),
        _NoteBox(
          icon: Icons.psychology,
          color: scheme.tertiary,
          text:
              'CurveTween remaps t through a Curve; combine via .chain() with '
              'a value Tween to build "ease the colour, not the time".',
        ),
      ],
    );
  }
}

class _CurveDotPainter extends CustomPainter {
  _CurveDotPainter({required this.value, required this.color});
  final double value;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint axis = Paint()
      ..color = color.withValues(alpha: 0.25)
      ..strokeWidth = 1.0;
    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), axis);
    canvas.drawLine(const Offset(0, 0), Offset(0, size.height), axis);

    final Paint diag = Paint()
      ..color = color.withValues(alpha: 0.35)
      ..strokeWidth = 1.0;
    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, 0), diag);

    final double x = value * size.width;
    final double y = size.height - (value * size.height);
    final Paint dot = Paint()..color = color;
    canvas.drawCircle(Offset(x, y), 5.0, dot);
  }

  @override
  bool shouldRepaint(_CurveDotPainter old) =>
      old.value != value || old.color != color;
}

// ---------------------------------------------------------------------------
// Section 8: .chain() and .animate()
// ---------------------------------------------------------------------------
class SectionChainAndAnimate extends StatelessWidget {
  const SectionChainAndAnimate({super.key, required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    // .chain() composes the LHS with another Animatable on the RHS.
    final Tween<double> valueTween = Tween<double>(begin: 0.0, end: 100.0);
    final Animatable<double> chained =
        valueTween.chain(CurveTween(curve: Curves.easeInOutCubic));
    print('chained value at 0.5 = ${chained.transform(0.5)}');

    final List<Widget> chainCols = <Widget>[];
    for (final double t in kSamples) {
      final double linear = valueTween.transform(t);
      final double curved = chained.transform(t);
      chainCols.add(SampleColumn(
        t: t,
        label: 'lin ${linear.toStringAsFixed(0)} / cur '
            '${curved.toStringAsFixed(0)}',
        scheme: scheme,
        preview: SizedBox(
          width: 88.0,
          height: 80.0,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: _Bar(value: linear / 100.0, color: scheme.primary),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: _Bar(value: curved / 100.0, color: scheme.tertiary),
              ),
            ],
          ),
        ),
      ));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SectionHeader(
          number: 8,
          title: '.chain() and .animate()',
          subtitle:
              'Compose tweens and bind them to an Animation<double>.',
          icon: Icons.account_tree_outlined,
          scheme: scheme,
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: scheme.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'The pipeline',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: scheme.onSurface,
                ),
              ),
              const SizedBox(height: 12.0),
              _PipelineRow(
                steps: const <String>[
                  'AnimationController',
                  'CurveTween',
                  'Tween<double>',
                  'Animation<double>',
                ],
                scheme: scheme,
              ),
              const SizedBox(height: 12.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: scheme.inverseSurface,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  '// Compose a curved value pipeline\n'
                  'final Animatable<double> curvy = Tween<double>(\n'
                  '  begin: 0.0, end: 100.0,\n'
                  ').chain(CurveTween(curve: Curves.easeInOutCubic));\n\n'
                  '// Bind to a controller as an Animation<double>\n'
                  'final Animation<double> anim = curvy.animate(controller);',
                  style: TextStyle(
                    color: scheme.onInverseSurface,
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ),
        SampleCard(
          title: 'Linear vs Tween.chain(CurveTween(easeInOutCubic))',
          beginLabel: 'linear',
          endLabel: 'curved',
          scheme: scheme,
          accent: scheme.tertiary,
          children: chainCols,
        ),
      ],
    );
  }
}

class _PipelineRow extends StatelessWidget {
  const _PipelineRow({required this.steps, required this.scheme});
  final List<String> steps;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    for (int i = 0; i < steps.length; i++) {
      children.add(Expanded(
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 8.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: scheme.primary.withValues(alpha: 0.12),
            border: Border.all(color: scheme.primary),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            steps[i],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
              color: scheme.primary,
            ),
          ),
        ),
      ));
      if (i != steps.length - 1) {
        children.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Icon(Icons.arrow_forward, color: scheme.primary, size: 18.0),
        ));
      }
    }
    return Row(children: children);
  }
}

// ---------------------------------------------------------------------------
// Section 9: Recipes + Glossary
// ---------------------------------------------------------------------------
class SectionRecipesAndGlossary extends StatelessWidget {
  const SectionRecipesAndGlossary({super.key, required this.scheme});
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<_Recipe> recipes = <_Recipe>[
      const _Recipe(
        icon: Icons.opacity,
        title: 'Cross-fade colours',
        body: 'Wrap a ColorTween(begin: a, end: b) in .animate(controller) '
            'and feed result into AnimatedBuilder.',
      ),
      const _Recipe(
        icon: Icons.zoom_out_map,
        title: 'Hero-like resize',
        body: 'Combine SizeTween and EdgeInsetsTween in parallel via two '
            'AnimatedBuilders sharing one controller.',
      ),
      const _Recipe(
        icon: Icons.rotate_90_degrees_ccw,
        title: 'Spin and grow',
        body: 'Matrix4Tween rotating + scaling identity to a target matrix '
            'gives a single composed transform for AnimatedBuilder.',
      ),
      const _Recipe(
        icon: Icons.compare_arrows,
        title: 'Reverse without flipping the controller',
        body: 'Wrap any Tween in ReverseTween to keep controller forward but '
            'swap begin/end semantics.',
      ),
      const _Recipe(
        icon: Icons.timer,
        title: 'Hold a static value mid-animation',
        body: 'Use ConstantTween<T>(v) when one segment of a TweenSequence '
            'should be motionless.',
      ),
      const _Recipe(
        icon: Icons.show_chart,
        title: 'Curve the value, not the time',
        body: 'tween.chain(CurveTween(curve: easeOutCubic)) applies the curve '
            'in value-space, leaving the controller linear.',
      ),
    ];

    final List<_GlossaryEntry> entries = <_GlossaryEntry>[
      const _GlossaryEntry(
        name: 'Tween<T>',
        body: 'Base class. lerp(t) returns the interpolated value.',
      ),
      const _GlossaryEntry(
        name: 'IntTween',
        body: 'Tween<int> that rounds the interpolated double via .round().',
      ),
      const _GlossaryEntry(
        name: 'ColorTween',
        body: 'Tween<Color?>; null acts as fully transparent.',
      ),
      const _GlossaryEntry(
        name: 'SizeTween',
        body: 'Tween<Size?>; null acts as Size.zero.',
      ),
      const _GlossaryEntry(
        name: 'RectTween',
        body: 'Tween<Rect?>; linearly lerps each of the four edges.',
      ),
      const _GlossaryEntry(
        name: 'AlignmentTween',
        body: 'Tween<Alignment>; interpolates the x and y in [-1,1].',
      ),
      const _GlossaryEntry(
        name: 'EdgeInsetsTween',
        body: 'Tween<EdgeInsets?>; per-side linear interpolation.',
      ),
      const _GlossaryEntry(
        name: 'BorderRadiusTween',
        body: 'Tween<BorderRadius?>; per-corner Radius interpolation.',
      ),
      const _GlossaryEntry(
        name: 'BorderTween',
        body: 'Tween<Border?>; interpolates BorderSide per edge.',
      ),
      const _GlossaryEntry(
        name: 'TextStyleTween',
        body: 'Tween<TextStyle>; defers to TextStyle.lerp.',
      ),
      const _GlossaryEntry(
        name: 'Matrix4Tween',
        body: 'Tween<Matrix4>; decomposes into translate/rotate/scale.',
      ),
      const _GlossaryEntry(
        name: 'ConstantTween<T>',
        body: 'Always returns its single value, regardless of t.',
      ),
      const _GlossaryEntry(
        name: 'ReverseTween<T>',
        body: 'Wraps another Tween and swaps begin/end.',
      ),
      const _GlossaryEntry(
        name: 'CurveTween',
        body: 'Maps t through a Curve. Use with .chain() to ease values.',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SectionHeader(
          number: 9,
          title: 'Recipes and Glossary',
          subtitle: 'Patterns and a one-line summary of every subtype.',
          icon: Icons.menu_book_outlined,
          scheme: scheme,
        ),
        const SizedBox(height: 12.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: <Widget>[
            for (final _Recipe r in recipes)
              SizedBox(
                width: 260.0,
                child: _RecipeCard(recipe: r, scheme: scheme),
              ),
          ],
        ),
        const SizedBox(height: 20.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: scheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: scheme.tertiary),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.list_alt, color: scheme.onTertiaryContainer),
                  const SizedBox(width: 8.0),
                  Text(
                    'Glossary',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: scheme.onTertiaryContainer,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              for (final _GlossaryEntry g in entries)
                _GlossaryRow(entry: g, scheme: scheme),
            ],
          ),
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: scheme.errorContainer,
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(color: scheme.error),
          ),
          child: Row(
            children: <Widget>[
              Icon(Icons.flag, color: scheme.onErrorContainer, size: 28.0),
              const SizedBox(width: 12.0),
              Expanded(
                child: Text(
                  'Demo finished. Every Tween subtype above was sampled at '
                  'five values of t and rendered as a real widget; print() '
                  'logs the begin/midpoint/end for each one to stdout so the '
                  'AST runner can verify the structure.',
                  style: TextStyle(
                    color: scheme.onErrorContainer,
                    fontSize: 12.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Recipe {
  const _Recipe({
    required this.icon,
    required this.title,
    required this.body,
  });
  final IconData icon;
  final String title;
  final String body;
}

class _RecipeCard extends StatelessWidget {
  const _RecipeCard({required this.recipe, required this.scheme});
  final _Recipe recipe;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: scheme.secondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: scheme.secondary.withValues(alpha: 0.25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  recipe.icon,
                  color: scheme.onSecondaryContainer,
                  size: 22.0,
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  recipe.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: scheme.onSecondaryContainer,
                    fontSize: 14.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            recipe.body,
            style: TextStyle(
              color: scheme.onSecondaryContainer,
              fontSize: 12.0,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _GlossaryEntry {
  const _GlossaryEntry({required this.name, required this.body});
  final String name;
  final String body;
}

class _GlossaryRow extends StatelessWidget {
  const _GlossaryRow({required this.entry, required this.scheme});
  final _GlossaryEntry entry;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150.0,
            child: Text(
              entry.name,
              style: TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
                color: scheme.onTertiaryContainer,
                fontSize: 12.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              entry.body,
              style: TextStyle(
                fontSize: 12.0,
                color: scheme.onTertiaryContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
