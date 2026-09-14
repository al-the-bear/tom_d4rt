// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

// =====================================================================
// TEXT PAINTER FIELD MANUAL
// ---------------------------------------------------------------------
// A long-form, hand-drawn study of `TextPainter` from the
// `package:flutter/painting.dart` library. This file is a static demo:
// it exposes a single `dynamic build(BuildContext)` entry point that
// returns a MaterialApp with a long, scrollable visual essay made of
// section cards, diagrams, CustomPaint widgets, gradients and shadows.
//
// The dossier walks through:
//   1. A stylized "TextPainter" wordmark with multi-color RichText.
//   2. The anatomy of a TextPainter constructor and its labelled fields.
//   3. The layout lifecycle: construct -> layout -> paint -> dispose.
//   4. A live measurement gallery driven by a CustomPainter that owns
//      a real TextPainter and overlays measurement boxes.
//   5. LineMetrics deconstruction with horizontal guides for ascent,
//      descent and leading.
//   6. TextSpan-tree visualization with overlay arrows pointing at the
//      contributing span for each visible chunk of text.
//   7. An ellipsis behaviour gallery comparing maxLines/ellipsis combos.
//   8. A 2x2 text-direction x text-alignment matrix.
//   9. Strut style demonstration: default vs. forceStrutHeight.
//  10. Pitfalls and instructive notes (dispose, post-layout metrics,
//      TextScaler vs textScaleFactor).
//  11. Glossary and end card.
//
// Palette (used consistently throughout):
//   ink      -> deep indigo, primary text and outlines
//   parch    -> warm cream paper, page surfaces
//   coral    -> warm rose, accents and arrows
//   teal     -> measurement guides, math callouts
//   amber    -> highlights and warnings
//   slate    -> secondary text, axis labels
//
// All `CustomPainter` subclasses are private (`_PrivatePainter`) and
// their `shouldRepaint` methods compare relevant fields. `TextPainter`
// instances are constructed inside `paint(Canvas, Size)` and disposed
// before the method returns -- exactly mirroring real-world usage.
// =====================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TextPainter Field Manual',
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFFFF8EC),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(
          color: Color(0xFF1F2547),
          fontSize: 14.0,
          height: 1.45,
        ),
      ),
    ),
    home: const _TextPainterManualPage(),
  );
}

// =====================================================================
// PALETTE CONSTANTS
// =====================================================================

const Color _kInk = Color(0xFF1F2547);
const Color _kInkSoft = Color(0xFF35406B);
const Color _kParch = Color(0xFFFFF6E0);
const Color _kParchDeep = Color(0xFFF1E4BD);
const Color _kCoral = Color(0xFFE85A6B);
const Color _kCoralDeep = Color(0xFFB23A4A);
const Color _kTeal = Color(0xFF1F8C8C);
const Color _kTealDeep = Color(0xFF105E5E);
const Color _kAmber = Color(0xFFE5A23B);
const Color _kAmberDeep = Color(0xFFB47420);
const Color _kSlate = Color(0xFF5A6178);
const Color _kSlateSoft = Color(0xFF8A93AB);
const Color _kViolet = Color(0xFF5B3F8A);
const Color _kSage = Color(0xFF3E7A55);

// =====================================================================
// TOP-LEVEL PAGE
// =====================================================================

class _TextPainterManualPage extends StatelessWidget {
  const _TextPainterManualPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: _ManualHeaderBar(),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(28, 28, 28, 56),
        children: const <Widget>[
          _HeroWordmarkSection(),
          SizedBox(height: 36),
          _AnatomySection(),
          SizedBox(height: 36),
          _LifecycleSection(),
          SizedBox(height: 36),
          _MeasurementGallerySection(),
          SizedBox(height: 36),
          _LineMetricsSection(),
          SizedBox(height: 36),
          _SpanTreeSection(),
          SizedBox(height: 36),
          _EllipsisGallerySection(),
          SizedBox(height: 36),
          _DirectionAlignMatrixSection(),
          SizedBox(height: 36),
          _StrutStyleSection(),
          SizedBox(height: 36),
          _PitfallsSection(),
          SizedBox(height: 36),
          _GlossarySection(),
          SizedBox(height: 24),
          _EndCard(),
        ],
      ),
    );
  }
}

// =====================================================================
// HEADER BAR
// =====================================================================

class _ManualHeaderBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF1F2547), Color(0xFF5B3F8A), Color(0xFFE5A23B)],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.35),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: _kAmber.withValues(alpha: 0.18),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      alignment: Alignment.centerLeft,
      child: Row(
        children: <Widget>[
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: _kParch,
              borderRadius: BorderRadius.circular(10),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _kInk.withValues(alpha: 0.4),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Text(
              'Tp',
              style: TextStyle(
                color: _kInk,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'TextPainter Field Manual',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  'package:flutter/painting.dart  -  measure, paint, dispose.',
                  style: TextStyle(
                    color: Color(0xFFFFE9B8),
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _kCoral,
              borderRadius: BorderRadius.circular(20),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _kCoralDeep.withValues(alpha: 0.5),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Text(
              'v1.0',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// REUSABLE: SECTION HEADER
// =====================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.index,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final String index;
  final String title;
  final String subtitle;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[accent, accent.withValues(alpha: 0.6)],
            ),
            borderRadius: BorderRadius.circular(14),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: accent.withValues(alpha: 0.45),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            index,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 22,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _kSlate,
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// REUSABLE: PARCHMENT CARD
// =====================================================================

class _ParchmentCard extends StatelessWidget {
  const _ParchmentCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_kParch, _kParchDeep],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kInk.withValues(alpha: 0.12), width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.08),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

// =====================================================================
// SECTION 1: HERO WORDMARK
// =====================================================================

class _HeroWordmarkSection extends StatelessWidget {
  const _HeroWordmarkSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF1F2547),
            Color(0xFF35406B),
            Color(0xFF5B3F8A),
            Color(0xFFB23A4A),
          ],
          stops: <double>[0.0, 0.4, 0.7, 1.0],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.5),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            color: _kCoral.withValues(alpha: 0.25),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            index: '01',
            title: 'Wordmark Hero',
            subtitle: 'A single Text.rich orchestrates an entire title.',
            accent: _kAmber,
          ),
          const SizedBox(height: 24),
          // The wordmark itself: multi-color RichText built from a TextSpan
          // tree. Each glyph cluster has a distinct style. This is exactly
          // the kind of input a TextPainter consumes.
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(
                fontSize: 56,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
                height: 1.0,
              ),
              children: <InlineSpan>[
                TextSpan(text: 'T', style: TextStyle(color: Color(0xFFFFE9B8))),
                TextSpan(text: 'e', style: TextStyle(color: Color(0xFFE85A6B))),
                TextSpan(text: 'x', style: TextStyle(color: Color(0xFF1F8C8C))),
                TextSpan(text: 't', style: TextStyle(color: Color(0xFFFFE9B8))),
                TextSpan(text: 'P', style: TextStyle(color: Color(0xFFE5A23B))),
                TextSpan(text: 'a', style: TextStyle(color: Color(0xFFFFE9B8))),
                TextSpan(text: 'i', style: TextStyle(color: Color(0xFFE85A6B))),
                TextSpan(text: 'n', style: TextStyle(color: Color(0xFF1F8C8C))),
                TextSpan(text: 't', style: TextStyle(color: Color(0xFFFFE9B8))),
                TextSpan(text: 'e', style: TextStyle(color: Color(0xFFE5A23B))),
                TextSpan(text: 'r', style: TextStyle(color: Color(0xFFFFE9B8))),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 80,
                height: 2,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[Colors.transparent, Color(0xFFFFE9B8)],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFE85A6B),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 80,
                height: 2,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: <Color>[Color(0xFFFFE9B8), Colors.transparent],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Center(
            child: Text(
              'a paragraph painter for Flutter',
              style: TextStyle(
                color: const Color(0xFFFFE9B8).withValues(alpha: 0.85),
                fontSize: 18,
                fontStyle: FontStyle.italic,
                letterSpacing: 1.0,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.15),
                width: 1,
              ),
            ),
            child: const Text.rich(
              TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 13, height: 1.5),
                children: <InlineSpan>[
                  TextSpan(text: 'TextPainter '),
                  TextSpan(
                    text: 'lays out paragraphs',
                    style: TextStyle(
                      color: Color(0xFFFFE9B8),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(text: ' built from a tree of '),
                  TextSpan(
                    text: 'InlineSpan',
                    style: TextStyle(
                      color: Color(0xFFFFC9D1),
                      fontFamily: 'monospace',
                    ),
                  ),
                  TextSpan(text: 's, then paints them on a '),
                  TextSpan(
                    text: 'Canvas',
                    style: TextStyle(
                      color: Color(0xFFAEEAE0),
                      fontFamily: 'monospace',
                    ),
                  ),
                  TextSpan(text: '. It is the silent workhorse below '),
                  TextSpan(
                    text: 'Text',
                    style: TextStyle(
                      color: Color(0xFFFFC07A),
                      fontFamily: 'monospace',
                    ),
                  ),
                  TextSpan(text: ', '),
                  TextSpan(
                    text: 'RichText',
                    style: TextStyle(
                      color: Color(0xFFFFC07A),
                      fontFamily: 'monospace',
                    ),
                  ),
                  TextSpan(text: ' and any custom-painted typography.'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 2: ANATOMY
// =====================================================================

class _AnatomySection extends StatelessWidget {
  const _AnatomySection();

  @override
  Widget build(BuildContext context) {
    return _ParchmentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            index: '02',
            title: 'Constructor Anatomy',
            subtitle: 'Every parameter labelled, with a one-paragraph note.',
            accent: _kCoral,
          ),
          const SizedBox(height: 20),
          // Pseudo-code of the constructor with overlay arrows.
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: _kInk,
              borderRadius: BorderRadius.circular(12),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _kInk.withValues(alpha: 0.4),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Text.rich(
              TextSpan(
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  height: 1.65,
                  color: Color(0xFFE6EAF8),
                ),
                children: <InlineSpan>[
                  TextSpan(text: 'final '),
                  TextSpan(
                    text: 'painter',
                    style: TextStyle(color: Color(0xFFFFE9B8)),
                  ),
                  TextSpan(text: ' = '),
                  TextSpan(
                    text: 'TextPainter',
                    style: TextStyle(
                      color: Color(0xFFE85A6B),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(text: '(\n'),
                  TextSpan(
                    text: '  text:',
                    style: TextStyle(color: Color(0xFFAEEAE0)),
                  ),
                  TextSpan(text: ' const TextSpan(text: "hello"),\n'),
                  TextSpan(
                    text: '  textDirection:',
                    style: TextStyle(color: Color(0xFFAEEAE0)),
                  ),
                  TextSpan(text: ' TextDirection.ltr,\n'),
                  TextSpan(
                    text: '  textAlign:',
                    style: TextStyle(color: Color(0xFFAEEAE0)),
                  ),
                  TextSpan(text: ' TextAlign.start,\n'),
                  TextSpan(
                    text: '  maxLines:',
                    style: TextStyle(color: Color(0xFFAEEAE0)),
                  ),
                  TextSpan(text: ' 3,\n'),
                  TextSpan(
                    text: '  ellipsis:',
                    style: TextStyle(color: Color(0xFFAEEAE0)),
                  ),
                  TextSpan(text: ' "\u2026",\n'),
                  TextSpan(
                    text: '  textScaler:',
                    style: TextStyle(color: Color(0xFFAEEAE0)),
                  ),
                  TextSpan(text: ' TextScaler.linear(1.0),\n'),
                  TextSpan(
                    text: '  strutStyle:',
                    style: TextStyle(color: Color(0xFFAEEAE0)),
                  ),
                  TextSpan(text: ' const StrutStyle(),\n'),
                  TextSpan(text: ');'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 22),
          const _AnatomyRow(
            label: 'text',
            color: _kCoral,
            description:
                'The InlineSpan tree to lay out. May be a single TextSpan with raw text or a deeply nested tree mixing TextSpan and PlaceholderSpan children. This is the only required field.',
          ),
          const _AnatomyRow(
            label: 'textDirection',
            color: _kTeal,
            description:
                'Resolves bidirectional text and the meaning of TextAlign.start / .end. Required before calling layout(); a missing value throws an assertion in debug.',
          ),
          const _AnatomyRow(
            label: 'textAlign',
            color: _kAmber,
            description:
                'Horizontal alignment within the layout width. Only takes effect when the laid-out width is wider than the longest line.',
          ),
          const _AnatomyRow(
            label: 'maxLines',
            color: _kViolet,
            description:
                'Hard cap on the number of visual lines. Combined with ellipsis, lines beyond the cap are truncated; without ellipsis they are simply dropped.',
          ),
          const _AnatomyRow(
            label: 'ellipsis',
            color: _kCoralDeep,
            description:
                'String drawn at the truncation point. Typically a single character such as the horizontal ellipsis. Only applied when overflow occurs.',
          ),
          const _AnatomyRow(
            label: 'textScaler',
            color: _kSage,
            description:
                'Replaces the deprecated textScaleFactor. Carries non-linear curves (system accessibility settings) that linearly multiplied factors cannot express.',
          ),
          const _AnatomyRow(
            label: 'strutStyle',
            color: _kSlate,
            description:
                'A vertical scaffold for line height. With forceStrutHeight: true, every line uses the strut metrics regardless of inline TextStyle heights -- crucial for grid-aligned typography.',
          ),
        ],
      ),
    );
  }
}

class _AnatomyRow extends StatelessWidget {
  const _AnatomyRow({
    required this.label,
    required this.color,
    required this.description,
  });

  final String label;
  final Color color;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: color, width: 5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              description,
              style: const TextStyle(
                color: _kInkSoft,
                fontSize: 13,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 3: LIFECYCLE
// =====================================================================

class _LifecycleSection extends StatelessWidget {
  const _LifecycleSection();

  @override
  Widget build(BuildContext context) {
    return _ParchmentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            index: '03',
            title: 'Layout Lifecycle',
            subtitle: 'construct  ->  layout()  ->  paint()  ->  dispose()',
            accent: _kTeal,
          ),
          const SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: const <Widget>[
                _LifecycleCard(
                  step: '1',
                  title: 'Construct',
                  body:
                      'Allocate the painter with the InlineSpan tree, the resolved TextDirection and any optional align/maxLines/ellipsis settings.',
                  color: _kCoral,
                  icon: Icons.build_outlined,
                ),
                _LifecycleArrow(color: _kCoral),
                _LifecycleCard(
                  step: '2',
                  title: 'layout()',
                  body:
                      'Run the line breaker against minWidth and maxWidth. After this call the metrics size, width, height and didExceedMaxLines are valid.',
                  color: _kAmber,
                  icon: Icons.straighten,
                ),
                _LifecycleArrow(color: _kAmber),
                _LifecycleCard(
                  step: '3',
                  title: 'paint()',
                  body:
                      'Walk the laid-out paragraph and emit glyph runs onto the supplied Canvas at the chosen Offset. Cheap relative to layout().',
                  color: _kTeal,
                  icon: Icons.brush_outlined,
                ),
                _LifecycleArrow(color: _kTeal),
                _LifecycleCard(
                  step: '4',
                  title: 'dispose()',
                  body:
                      'Release the underlying engine paragraph. Required for painters held longer than a single paint() call -- otherwise a leak warning fires in debug builds.',
                  color: _kViolet,
                  icon: Icons.delete_outline,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _kAmber.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kAmber.withValues(alpha: 0.5)),
            ),
            child: const Text.rich(
              TextSpan(
                style: TextStyle(color: _kInkSoft, fontSize: 13, height: 1.55),
                children: <InlineSpan>[
                  TextSpan(
                    text: 'Rule of thumb: ',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                  TextSpan(
                    text:
                        'never read width / height / size / computeDistanceToActualBaseline before calling layout(). The painter answers with assertions if you do.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LifecycleCard extends StatelessWidget {
  const _LifecycleCard({
    required this.step,
    required this.title,
    required this.body,
    required this.color,
    required this.icon,
  });

  final String step;
  final String title;
  final String body;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            color.withValues(alpha: 0.18),
            color.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.2),
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
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  step,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(icon, color: color, size: 18),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w800,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              color: _kInkSoft,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _LifecycleArrow extends StatelessWidget {
  const _LifecycleArrow({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 200,
      alignment: Alignment.center,
      child: Icon(Icons.arrow_forward, color: color, size: 28),
    );
  }
}

// =====================================================================
// SECTION 4: MEASUREMENT GALLERY
// =====================================================================

class _MeasurementGallerySection extends StatelessWidget {
  const _MeasurementGallerySection();

  @override
  Widget build(BuildContext context) {
    return _ParchmentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            index: '04',
            title: 'Live Measurement Gallery',
            subtitle:
                'Real TextPainters laid out inside CustomPainter.paint(), measurement boxes overlaid.',
            accent: _kViolet,
          ),
          const SizedBox(height: 20),
          // Six phrases with different TextStyles.
          const _MeasurementCard(
            phrase: 'Hello, painter!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: _kInk,
            ),
            align: TextAlign.start,
            note: 'Bold serif-like style, default alignment.',
          ),
          SizedBox(height: 12),
          const _MeasurementCard(
            phrase: 'subtle italic whisper',
            style: TextStyle(
              fontSize: 22,
              fontStyle: FontStyle.italic,
              color: _kCoral,
            ),
            align: TextAlign.center,
            note: 'Italic, centered. Notice baseline under the descenders.',
          ),
          SizedBox(height: 12),
          const _MeasurementCard(
            phrase: 'WIDE & THIN',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w300,
              letterSpacing: 6.0,
              color: _kTeal,
            ),
            align: TextAlign.start,
            note: 'Letter-spacing pushes the painter width well past glyph sum.',
          ),
          SizedBox(height: 12),
          const _MeasurementCard(
            phrase: 'q descender j tail y',
            style: TextStyle(
              fontSize: 24,
              color: _kViolet,
            ),
            align: TextAlign.start,
            note:
                'Letters with descenders demonstrate the gap between baseline and descent.',
          ),
          SizedBox(height: 12),
          const _MeasurementCard(
            phrase: 'tall-x  small-x  TALL-X',
            style: TextStyle(
              fontSize: 30,
              color: _kAmber,
              fontWeight: FontWeight.w900,
            ),
            align: TextAlign.center,
            note: 'Mixed case shows how ascent height varies with caps.',
          ),
          SizedBox(height: 12),
          const _MeasurementCard(
            phrase: 'monospaced metrics',
            style: TextStyle(
              fontSize: 22,
              fontFamily: 'monospace',
              color: _kSage,
              fontWeight: FontWeight.w600,
            ),
            align: TextAlign.start,
            note:
                'Monospace fonts make per-glyph width predictable -- handy for column tools.',
          ),
        ],
      ),
    );
  }
}

class _MeasurementCard extends StatelessWidget {
  const _MeasurementCard({
    required this.phrase,
    required this.style,
    required this.align,
    required this.note,
  });

  final String phrase;
  final TextStyle style;
  final TextAlign align;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kInk.withValues(alpha: 0.1)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 90,
            width: double.infinity,
            child: CustomPaint(
              painter: _MeasurementPainter(
                phrase: phrase,
                style: style,
                align: align,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            note,
            style: const TextStyle(
              color: _kSlate,
              fontSize: 11,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _MeasurementPainter extends CustomPainter {
  _MeasurementPainter({
    required this.phrase,
    required this.style,
    required this.align,
  });

  final String phrase;
  final TextStyle style;
  final TextAlign align;

  @override
  void paint(Canvas canvas, Size size) {
    // Construct, layout, paint, then dispose. Strict lifecycle.
    final TextPainter painter = TextPainter(
      text: TextSpan(text: phrase, style: style),
      textDirection: TextDirection.ltr,
      textAlign: align,
      maxLines: 1,
    );
    painter.layout(minWidth: 0, maxWidth: size.width - 16);

    final double textWidth = painter.width;
    final double textHeight = painter.height;
    final double baseline =
        painter.computeDistanceToActualBaseline(TextBaseline.alphabetic);

    // Choose an offset based on the alignment field.
    double dx;
    switch (align) {
      case TextAlign.center:
        dx = (size.width - textWidth) / 2;
        break;
      case TextAlign.end:
      case TextAlign.right:
        dx = size.width - textWidth - 8;
        break;
      case TextAlign.start:
      case TextAlign.left:
      case TextAlign.justify:
        dx = 8;
        break;
    }
    final double dy = (size.height - textHeight) / 2;

    // Draw a subtle background lattice.
    final Paint lattice = Paint()
      ..color = _kSlateSoft.withValues(alpha: 0.18)
      ..strokeWidth = 0.5;
    for (double y = 10; y < size.height; y += 16) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), lattice);
    }

    // Bounding box for total painter size.
    final Rect bbox = Rect.fromLTWH(dx, dy, textWidth, textHeight);
    final Paint bboxPaint = Paint()
      ..color = _kCoral.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRect(bbox, bboxPaint);

    // Baseline guide.
    final double baselineY = dy + baseline;
    final Paint baselinePaint = Paint()
      ..color = _kTeal
      ..strokeWidth = 1.2;
    canvas.drawLine(
      Offset(dx - 6, baselineY),
      Offset(dx + textWidth + 6, baselineY),
      baselinePaint,
    );

    // Paint the actual text.
    painter.paint(canvas, Offset(dx, dy));

    // Width caliper across the bottom.
    final Paint caliper = Paint()
      ..color = _kAmberDeep
      ..strokeWidth = 1.0;
    final double caliperY = dy + textHeight + 8;
    canvas.drawLine(Offset(dx, caliperY), Offset(dx + textWidth, caliperY), caliper);
    canvas.drawLine(Offset(dx, caliperY - 4), Offset(dx, caliperY + 4), caliper);
    canvas.drawLine(
      Offset(dx + textWidth, caliperY - 4),
      Offset(dx + textWidth, caliperY + 4),
      caliper,
    );

    // Width label.
    final TextPainter widthLabel = TextPainter(
      text: TextSpan(
        text: 'w=${textWidth.toStringAsFixed(1)}',
        style: const TextStyle(
          color: _kAmberDeep,
          fontSize: 10,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    widthLabel.layout();
    widthLabel.paint(
      canvas,
      Offset(dx + textWidth / 2 - widthLabel.width / 2, caliperY + 4),
    );
    widthLabel.dispose();

    // Height caliper down the side.
    final double hx = dx + textWidth + 14;
    canvas.drawLine(Offset(hx, dy), Offset(hx, dy + textHeight), caliper);
    canvas.drawLine(Offset(hx - 4, dy), Offset(hx + 4, dy), caliper);
    canvas.drawLine(Offset(hx - 4, dy + textHeight), Offset(hx + 4, dy + textHeight), caliper);

    final TextPainter heightLabel = TextPainter(
      text: TextSpan(
        text: 'h=${textHeight.toStringAsFixed(1)}',
        style: const TextStyle(
          color: _kAmberDeep,
          fontSize: 10,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    heightLabel.layout();
    heightLabel.paint(canvas, Offset(hx + 6, dy + textHeight / 2 - heightLabel.height / 2));
    heightLabel.dispose();

    // Baseline label.
    final TextPainter baselineLabel = TextPainter(
      text: TextSpan(
        text: 'baseline=${baseline.toStringAsFixed(1)}',
        style: const TextStyle(
          color: _kTealDeep,
          fontSize: 10,
          fontFamily: 'monospace',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    baselineLabel.layout();
    baselineLabel.paint(canvas, Offset(dx + textWidth + 32, baselineY - 6));
    baselineLabel.dispose();

    // Important: dispose the main painter.
    painter.dispose();
  }

  @override
  bool shouldRepaint(covariant _MeasurementPainter old) {
    return old.phrase != phrase || old.style != style || old.align != align;
  }
}

// =====================================================================
// SECTION 5: LINE METRICS
// =====================================================================

class _LineMetricsSection extends StatelessWidget {
  const _LineMetricsSection();

  @override
  Widget build(BuildContext context) {
    const String paragraph =
        'TextPainter exposes computeLineMetrics() once layout() has run. '
        'Each LineMetrics record carries ascent, descent, leading, baseline, '
        'hardBreak and lineNumber. We draw the paragraph and overlay coloured '
        'guides for each row of metrics.';

    return _ParchmentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            index: '05',
            title: 'LineMetrics Deconstruction',
            subtitle: 'Ascent, descent, leading and hardBreak laid bare.',
            accent: _kSage,
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 160,
            width: double.infinity,
            child: CustomPaint(
              painter: _LineMetricsPainter(
                paragraph: paragraph,
                style: const TextStyle(
                  fontSize: 16,
                  color: _kInk,
                  height: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 14,
            runSpacing: 8,
            children: const <Widget>[
              _MetricLegendChip(color: _kCoral, label: 'ascent'),
              _MetricLegendChip(color: _kTeal, label: 'baseline'),
              _MetricLegendChip(color: _kAmber, label: 'descent'),
              _MetricLegendChip(color: _kViolet, label: 'leading'),
              _MetricLegendChip(color: _kSlate, label: 'lineBreak'),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  _kSage.withValues(alpha: 0.18),
                  _kTeal.withValues(alpha: 0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Ascent climbs above the baseline; descent drops below; leading is the small extra '
              'space the font requests above ascent. Hard breaks (\\n) end a paragraph fragment, '
              'soft breaks come from the line breaker.',
              style: TextStyle(color: _kInkSoft, fontSize: 13, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricLegendChip extends StatelessWidget {
  const _MetricLegendChip({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: color,
            fontFamily: 'monospace',
            fontSize: 12,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _LineMetricsPainter extends CustomPainter {
  _LineMetricsPainter({required this.paragraph, required this.style});

  final String paragraph;
  final TextStyle style;

  @override
  void paint(Canvas canvas, Size size) {
    final TextPainter painter = TextPainter(
      text: TextSpan(text: paragraph, style: style),
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.start,
    );
    painter.layout(minWidth: 0, maxWidth: size.width - 24);

    const double dx = 12;
    const double dy = 8;
    painter.paint(canvas, const Offset(dx, dy));

    final List<ui.LineMetrics> lines = painter.computeLineMetrics();
    final Paint ascentPaint = Paint()
      ..color = _kCoral.withValues(alpha: 0.55)
      ..strokeWidth = 0.8;
    final Paint baselinePaint = Paint()
      ..color = _kTeal
      ..strokeWidth = 1.0;
    final Paint descentPaint = Paint()
      ..color = _kAmber.withValues(alpha: 0.6)
      ..strokeWidth = 0.8;
    final Paint leadingPaint = Paint()
      ..color = _kViolet.withValues(alpha: 0.5)
      ..strokeWidth = 0.8;
    final Paint hardBreakPaint = Paint()
      ..color = _kSlate
      ..strokeWidth = 1.5;

    double yCursor = dy;
    for (int i = 0; i < lines.length; i++) {
      final ui.LineMetrics line = lines[i];
      final double topAscent = yCursor + line.unscaledAscent - line.ascent;
      final double baselineY = yCursor + line.ascent;
      final double descentY = baselineY + line.descent;
      final double leadingY = topAscent;

      // Top ascent line.
      canvas.drawLine(
        Offset(dx, topAscent + 0.5),
        Offset(dx + line.width, topAscent + 0.5),
        ascentPaint,
      );
      // Baseline.
      canvas.drawLine(
        Offset(dx, baselineY),
        Offset(dx + line.width, baselineY),
        baselinePaint,
      );
      // Descent.
      canvas.drawLine(
        Offset(dx, descentY),
        Offset(dx + line.width, descentY),
        descentPaint,
      );
      // Leading marker (vertical tick at the start).
      canvas.drawLine(
        Offset(dx - 4, leadingY),
        Offset(dx - 4, baselineY),
        leadingPaint,
      );

      // Hard break marker.
      if (line.hardBreak) {
        canvas.drawLine(
          Offset(dx + line.width + 4, baselineY - 5),
          Offset(dx + line.width + 4, baselineY + 5),
          hardBreakPaint,
        );
      }

      // Line number gutter.
      final TextPainter num = TextPainter(
        text: TextSpan(
          text: '${line.lineNumber}',
          style: const TextStyle(
            color: _kSlate,
            fontFamily: 'monospace',
            fontSize: 10,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      num.layout();
      num.paint(canvas, Offset(dx - 24, baselineY - num.height / 2));
      num.dispose();

      yCursor = leadingY + line.height;
    }

    painter.dispose();
  }

  @override
  bool shouldRepaint(covariant _LineMetricsPainter old) {
    return old.paragraph != paragraph || old.style != style;
  }
}

// =====================================================================
// SECTION 6: SPAN TREE VISUALIZATION
// =====================================================================

class _SpanTreeSection extends StatelessWidget {
  const _SpanTreeSection();

  @override
  Widget build(BuildContext context) {
    return _ParchmentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            index: '06',
            title: 'TextSpan Tree Visualization',
            subtitle:
                'Mixed-style RichText with overlay arrows pointing at each contributing TextSpan.',
            accent: _kAmber,
          ),
          const SizedBox(height: 18),
          SizedBox(
            width: double.infinity,
            height: 220,
            child: CustomPaint(
              painter: _SpanTreePainter(),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kInk.withValues(alpha: 0.08)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                _SpanRow(color: _kInk, label: 'root', detail: 'TextSpan(style: 18px regular ink)'),
                _SpanRow(color: _kCoral, label: 'bold', detail: 'TextSpan(style: bold coral)'),
                _SpanRow(color: _kTeal, label: 'italic', detail: 'TextSpan(style: italic teal)'),
                _SpanRow(color: _kViolet, label: 'mono', detail: 'TextSpan(style: monospace violet)'),
                _SpanRow(color: _kAmber, label: 'amber', detail: 'TextSpan(style: amber underline)'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SpanRow extends StatelessWidget {
  const _SpanRow({
    required this.color,
    required this.label,
    required this.detail,
  });

  final Color color;
  final String label;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          Container(
            width: 14,
            height: 14,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              detail,
              style: const TextStyle(
                color: _kSlate,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpanTreePainter extends CustomPainter {
  _SpanTreePainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Build the rich span manually so we know which substring belongs to
    // which span.
    const TextStyle baseStyle =
        TextStyle(fontSize: 18, color: _kInk, height: 1.5);

    final TextSpan root = TextSpan(
      style: baseStyle,
      children: <InlineSpan>[
        const TextSpan(text: 'The '),
        TextSpan(
          text: 'TextPainter ',
          style: baseStyle.merge(
            const TextStyle(color: _kCoral, fontWeight: FontWeight.w800),
          ),
        ),
        const TextSpan(text: 'consumes a '),
        TextSpan(
          text: 'tree ',
          style: baseStyle.merge(
            const TextStyle(color: _kTeal, fontStyle: FontStyle.italic),
          ),
        ),
        const TextSpan(text: 'of '),
        TextSpan(
          text: 'InlineSpan',
          style: baseStyle.merge(
            const TextStyle(color: _kViolet, fontFamily: 'monospace'),
          ),
        ),
        const TextSpan(text: 's, layered like '),
        TextSpan(
          text: 'leaves',
          style: baseStyle.merge(
            const TextStyle(
              color: _kAmberDeep,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        const TextSpan(text: ' in autumn.'),
      ],
    );

    final TextPainter painter = TextPainter(
      text: root,
      textDirection: TextDirection.ltr,
    );
    painter.layout(minWidth: 0, maxWidth: size.width - 24);

    const double dx = 12;
    const double dy = 24;
    painter.paint(canvas, const Offset(dx, dy));

    // Use getOffsetForCaret to anchor arrow heads at the visual start of each
    // styled span (text offsets are known from the literal strings above).
    final List<_SpanAnchor> anchors = <_SpanAnchor>[
      _SpanAnchor(start: 4, label: 'bold', color: _kCoral, dy: -28),
      _SpanAnchor(start: 27, label: 'italic', color: _kTeal, dy: -28),
      _SpanAnchor(start: 36, label: 'mono', color: _kViolet, dy: 60),
      _SpanAnchor(start: 60, label: 'amber', color: _kAmberDeep, dy: 60),
    ];

    for (final _SpanAnchor anchor in anchors) {
      final Offset caret = painter.getOffsetForCaret(
        TextPosition(offset: anchor.start),
        Rect.zero,
      );
      final Offset target = Offset(dx + caret.dx + 4, dy + caret.dy + 12);
      final Offset label = Offset(target.dx + 18, target.dy + anchor.dy);

      final Paint line = Paint()
        ..color = anchor.color
        ..strokeWidth = 1.4
        ..style = PaintingStyle.stroke;
      canvas.drawLine(target, label, line);

      // Arrow head.
      final Paint head = Paint()..color = anchor.color;
      final Path arrow = Path()
        ..moveTo(target.dx, target.dy)
        ..lineTo(target.dx - 5, target.dy - 5)
        ..lineTo(target.dx - 5, target.dy + 5)
        ..close();
      canvas.drawPath(arrow, head);

      // Label pill.
      final TextPainter pill = TextPainter(
        text: TextSpan(
          text: anchor.label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      pill.layout();
      final Rect pillRect = Rect.fromLTWH(
        label.dx,
        label.dy - pill.height / 2 - 3,
        pill.width + 12,
        pill.height + 6,
      );
      final RRect pillRRect = RRect.fromRectAndRadius(
        pillRect,
        const Radius.circular(6),
      );
      canvas.drawRRect(pillRRect, Paint()..color = anchor.color);
      pill.paint(canvas, Offset(pillRect.left + 6, pillRect.top + 3));
      pill.dispose();
    }

    painter.dispose();
  }

  @override
  bool shouldRepaint(covariant _SpanTreePainter old) {
    // Painter holds no fields; always idempotent.
    return false;
  }
}

class _SpanAnchor {
  const _SpanAnchor({
    required this.start,
    required this.label,
    required this.color,
    required this.dy,
  });

  final int start;
  final String label;
  final Color color;
  final double dy;
}

// =====================================================================
// SECTION 7: ELLIPSIS GALLERY
// =====================================================================

class _EllipsisGallerySection extends StatelessWidget {
  const _EllipsisGallerySection();

  @override
  Widget build(BuildContext context) {
    const String long =
        'When ink runs across a fixed paragraph the painter must decide where to clip, '
        'where to break, and how to soften the cut with a single closing glyph.';

    return _ParchmentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            index: '07',
            title: 'Ellipsis Behaviour Gallery',
            subtitle: 'Four cards covering maxLines and ellipsis combinations.',
            accent: _kCoralDeep,
          ),
          const SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 1.7,
            children: const <Widget>[
              _EllipsisCard(
                label: 'maxLines: 1, ellipsis: "..."',
                text: long,
                maxLines: 1,
                ellipsis: '...',
                accent: _kCoral,
              ),
              _EllipsisCard(
                label: 'maxLines: 2, ellipsis: "..."',
                text: long,
                maxLines: 2,
                ellipsis: '...',
                accent: _kTeal,
              ),
              _EllipsisCard(
                label: 'maxLines: 1, no ellipsis',
                text: long,
                maxLines: 1,
                ellipsis: null,
                accent: _kAmber,
              ),
              _EllipsisCard(
                label: 'maxLines: 3, no ellipsis',
                text: long,
                maxLines: 3,
                ellipsis: null,
                accent: _kViolet,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: _kCoral.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _kCoral.withValues(alpha: 0.3)),
            ),
            child: const Text(
              'Without an ellipsis, the painter simply drops lines beyond maxLines '
              'and reports didExceedMaxLines == true. With an ellipsis, the last '
              'remaining line ends with the configured glyph(s).',
              style: TextStyle(color: _kInkSoft, fontSize: 13, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _EllipsisCard extends StatelessWidget {
  const _EllipsisCard({
    required this.label,
    required this.text,
    required this.maxLines,
    required this.ellipsis,
    required this.accent,
  });

  final String label;
  final String text;
  final int maxLines;
  final String? ellipsis;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            accent.withValues(alpha: 0.15),
            accent.withValues(alpha: 0.03),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.4)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: accent,
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: 220,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              text,
              maxLines: maxLines,
              overflow: ellipsis != null ? TextOverflow.ellipsis : TextOverflow.clip,
              style: const TextStyle(
                color: _kInk,
                fontSize: 12,
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
// SECTION 8: DIRECTION x ALIGNMENT MATRIX
// =====================================================================

class _DirectionAlignMatrixSection extends StatelessWidget {
  const _DirectionAlignMatrixSection();

  @override
  Widget build(BuildContext context) {
    const String sample =
        'painters obey direction & alignment together.';

    return _ParchmentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            index: '08',
            title: 'Direction x Alignment Matrix',
            subtitle: 'Identical content rendered four ways.',
            accent: _kTealDeep,
          ),
          const SizedBox(height: 18),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 2.4,
            children: const <Widget>[
              _MatrixCell(
                label: 'ltr / start',
                direction: TextDirection.ltr,
                align: TextAlign.start,
                sample: sample,
                accent: _kCoral,
              ),
              _MatrixCell(
                label: 'ltr / end',
                direction: TextDirection.ltr,
                align: TextAlign.end,
                sample: sample,
                accent: _kAmber,
              ),
              _MatrixCell(
                label: 'rtl / start',
                direction: TextDirection.rtl,
                align: TextAlign.start,
                sample: sample,
                accent: _kTeal,
              ),
              _MatrixCell(
                label: 'rtl / end',
                direction: TextDirection.rtl,
                align: TextAlign.end,
                sample: sample,
                accent: _kViolet,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  _kTeal.withValues(alpha: 0.15),
                  _kTealDeep.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'TextAlign.start binds to the leading edge in the chosen direction. '
              'In RTL, "start" is the right edge and "end" is the left edge -- the '
              'painter handles the swap automatically.',
              style: TextStyle(color: _kInkSoft, fontSize: 13, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _MatrixCell extends StatelessWidget {
  const _MatrixCell({
    required this.label,
    required this.direction,
    required this.align,
    required this.sample,
    required this.accent,
  });

  final String label;
  final TextDirection direction;
  final TextAlign align;
  final String sample;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            accent.withValues(alpha: 0.18),
            accent.withValues(alpha: 0.05),
          ],
        ),
        border: Border.all(color: accent.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: TextStyle(
              color: accent,
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                sample,
                textDirection: direction,
                textAlign: align,
                style: const TextStyle(
                  color: _kInk,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 9: STRUT STYLE
// =====================================================================

class _StrutStyleSection extends StatelessWidget {
  const _StrutStyleSection();

  @override
  Widget build(BuildContext context) {
    const String mixed =
        'A paragraph mixing tiny and giant glyphs needs a strut to prevent line-height jitter.';

    return _ParchmentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            index: '09',
            title: 'StrutStyle Demonstration',
            subtitle: 'Same paragraph, default strut vs. forceStrutHeight.',
            accent: _kViolet,
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _StrutCard(
                  label: 'default strut',
                  description:
                      'Each line is sized by the tallest glyph in the line.',
                  accent: _kCoral,
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: _kInk, fontSize: 14),
                      children: <InlineSpan>[
                        const TextSpan(text: 'A '),
                        TextSpan(
                          text: 'GIANT ',
                          style: const TextStyle(fontSize: 28),
                        ),
                        const TextSpan(text: 'word and '),
                        TextSpan(
                          text: 'tiny ',
                          style: const TextStyle(fontSize: 9),
                        ),
                        const TextSpan(text: 'fragment juggle line height. '),
                        const TextSpan(text: mixed),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: _StrutCard(
                  label: 'forceStrutHeight: true, height: 2.0',
                  description:
                      'Strut locks the baseline grid; mixed glyphs no longer push the line.',
                  accent: _kTeal,
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: _kInk, fontSize: 14),
                      children: <InlineSpan>[
                        const TextSpan(text: 'A '),
                        TextSpan(
                          text: 'GIANT ',
                          style: const TextStyle(fontSize: 28),
                        ),
                        const TextSpan(text: 'word and '),
                        TextSpan(
                          text: 'tiny ',
                          style: const TextStyle(fontSize: 9),
                        ),
                        const TextSpan(text: 'fragment juggle line height. '),
                        const TextSpan(text: mixed),
                      ],
                    ),
                    strutStyle: const StrutStyle(
                      forceStrutHeight: true,
                      height: 2.0,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  _kViolet.withValues(alpha: 0.16),
                  _kViolet.withValues(alpha: 0.04),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Strut style is the painter\'s vertical scaffold. Set forceStrutHeight: true '
              'and the painter ignores per-glyph height variations -- every line uses the '
              'strut metrics. This is essential for grid-aligned typography (cards, tables, '
              'editor gutters).',
              style: TextStyle(color: _kInkSoft, fontSize: 13, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _StrutCard extends StatelessWidget {
  const _StrutCard({
    required this.label,
    required this.description,
    required this.child,
    required this.accent,
  });

  final String label;
  final String description;
  final Widget child;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withValues(alpha: 0.5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: const TextStyle(
              color: _kSlate,
              fontSize: 11,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 10: PITFALLS
// =====================================================================

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return _ParchmentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            index: '10',
            title: 'Pitfalls & Instructive Notes',
            subtitle: 'Read these before shipping a custom paragraph painter.',
            accent: _kCoralDeep,
          ),
          const SizedBox(height: 16),
          const _PitfallTile(
            color: _kCoral,
            icon: Icons.delete_forever,
            title: 'Don\'t forget to dispose()',
            body:
                'A TextPainter held across paint() calls owns an underlying ui.Paragraph. '
                'Failing to call dispose() leaks engine memory and trips the leak detector '
                'in debug builds. If the painter is recreated each paint(), dispose it before '
                'returning from paint().',
          ),
          _PitfallTile(
            color: _kAmber,
            icon: Icons.warning_amber,
            title: 'Computed metrics are stable only after layout()',
            body:
                'Reading width, height, size, didExceedMaxLines or computeLineMetrics() '
                'before calling layout() throws an assertion in debug. After every change '
                'to text, textDirection, textScaler etc., layout() must run again.',
          ),
          _PitfallTile(
            color: _kTeal,
            icon: Icons.straighten,
            title: 'TextScaler vs textScaleFactor',
            body:
                'textScaleFactor (now deprecated) was a single double. TextScaler can carry '
                'non-linear scaling curves -- system accessibility settings on Android and iOS '
                'apply per-size step adjustments that no single multiplier captures.',
          ),
          _PitfallTile(
            color: _kViolet,
            icon: Icons.crop_free,
            title: 'maxWidth must be finite',
            body:
                'TextPainter.layout(maxWidth: double.infinity) is allowed, but combined with '
                'TextAlign.center / .end the painter has no width to align against, so the '
                'paragraph collapses to its longest line. Constrain explicitly when alignment matters.',
          ),
          _PitfallTile(
            color: _kSage,
            icon: Icons.timer_outlined,
            title: 'Caching across frames',
            body:
                'For widgets that call paint() many times with stable text, create the '
                'TextPainter in the constructor and dispose it from the owning widget\'s '
                'dispose(). Inside RenderObjects, recreate when the inputs change but reuse '
                'between identical paint() calls.',
          ),
          _PitfallTile(
            color: _kSlate,
            icon: Icons.translate,
            title: 'Locale and font fallback',
            body:
                'Locale on TextStyle (and on the painter via locale: ...) drives font fallback '
                'for CJK and other scripts. Without it, glyph fallback may differ between '
                'rendered Text widgets and your hand-painted paragraphs.',
          ),
        ],
      ),
    );
  }
}

class _PitfallTile extends StatelessWidget {
  const _PitfallTile({
    required this.color,
    required this.icon,
    required this.title,
    required this.body,
  });

  final Color color;
  final IconData icon;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: color, width: 5),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    color: _kInkSoft,
                    fontSize: 13,
                    height: 1.45,
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
// SECTION 11: GLOSSARY
// =====================================================================

class _GlossarySection extends StatelessWidget {
  const _GlossarySection();

  @override
  Widget build(BuildContext context) {
    return _ParchmentCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionHeader(
            index: '11',
            title: 'Glossary',
            subtitle: 'Vocabulary used throughout this dossier.',
            accent: _kSlate,
          ),
          const SizedBox(height: 16),
          const _GlossaryEntry(
            term: 'InlineSpan',
            definition:
                'Abstract base for content placed inline within a paragraph. The two concrete subclasses are TextSpan (text) and PlaceholderSpan (e.g. WidgetSpan).',
          ),
          _GlossaryEntry(
            term: 'TextSpan',
            definition:
                'A subtree of styled text. Carries its own TextStyle, optional GestureRecognizer, and a list of children that inherit the parent style.',
          ),
          _GlossaryEntry(
            term: 'TextStyle',
            definition:
                'An immutable bundle of typographic properties: fontSize, color, fontWeight, fontStyle, height, letterSpacing, decoration, etc. Merges flow from parent to child spans.',
          ),
          _GlossaryEntry(
            term: 'StrutStyle',
            definition:
                'A vertical scaffold that influences line height. With forceStrutHeight: true the painter ignores per-glyph height variations.',
          ),
          _GlossaryEntry(
            term: 'TextScaler',
            definition:
                'Modern replacement for textScaleFactor. Encodes the curve that maps unscaled font sizes to scaled sizes -- often non-linear on accessibility-aware platforms.',
          ),
          _GlossaryEntry(
            term: 'LineMetrics',
            definition:
                'Per-line record returned by computeLineMetrics(): ascent, descent, unscaledAscent, baseline, height, width, left, hardBreak, lineNumber.',
          ),
          _GlossaryEntry(
            term: 'TextBaseline',
            definition:
                'Either alphabetic or ideographic. computeDistanceToActualBaseline reports how far below the painter top the baseline of the first line sits.',
          ),
          _GlossaryEntry(
            term: 'didExceedMaxLines',
            definition:
                'Boolean flag set by layout(). True when the laid-out paragraph contains more lines than maxLines (regardless of whether ellipsis is set).',
          ),
        ],
      ),
    );
  }
}

class _GlossaryEntry extends StatelessWidget {
  const _GlossaryEntry({required this.term, required this.definition});

  final String term;
  final String definition;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 140,
            child: Text(
              term,
              style: const TextStyle(
                color: _kViolet,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w800,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Text(
              definition,
              style: const TextStyle(
                color: _kInkSoft,
                fontSize: 13,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// END CARD
// =====================================================================

class _EndCard extends StatelessWidget {
  const _EndCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF1F2547),
            Color(0xFF105E5E),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.4),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
          BoxShadow(
            color: _kTeal.withValues(alpha: 0.2),
            blurRadius: 28,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1.5,
              ),
            ),
            alignment: Alignment.center,
            child: const Icon(Icons.check_circle_outline,
                color: Color(0xFFFFE9B8), size: 28),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'End of dossier.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'TextPainter is rarely the prettiest API in painting.dart -- '
                  'but it is the one every higher-level Text widget eventually leans on. '
                  'Construct, layout, paint, dispose. Repeat with intent.',
                  style: TextStyle(
                    color: Color(0xFFD4DCEF),
                    fontSize: 13,
                    height: 1.5,
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
