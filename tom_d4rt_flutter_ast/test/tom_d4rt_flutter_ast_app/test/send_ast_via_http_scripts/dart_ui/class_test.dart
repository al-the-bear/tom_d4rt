// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: a hand-authored survey/atlas of the dart:ui class
// taxonomy. Each section is a self-contained labelled card cluster covering
// one family of dart:ui types (geometry, color, path, picture-pipeline,
// drawing primitives, image-pipeline, fonts) plus a final decision table,
// recipes book and glossary panel.
//
// Design plan:
//   Section 1 - Gradient header banner + role of dart:ui vs flutter/painting.
//   Section 2 - Geometry atlas: Offset, Size, Rect, RRect, Radius, RSTransform.
//                Each card carries a constructor signature, key methods and a
//                small visual specimen drawn from real Flutter widgets.
//   Section 3 - Color taxonomy: Color, alpha channel sweeps, blend container
//                swatches and ColorScheme M3 idioms.
//   Section 4 - Path atlas: factory constructors (Path, Path.from), shape
//                helpers and a silhouette gallery.
//   Section 5 - Drawing primitives: PointMode (points/lines/polygon) and
//                VertexMode (triangles/triangleStrip/triangleFan) with Vertices.
//   Section 6 - Pipeline diagrams: Picture, Scene, SceneBuilder and the image
//                pipeline (Image, ImageDescriptor, ImmutableBuffer, Codec,
//                FrameInfo). Strictly diagrammatic - no real GPU work.
//   Section 7 - Fonts + library boundary: FontStyle, FontWeight and the line
//                between dart:ui geometry/painting primitives and the
//                higher-level flutter/painting widgets.
//   Section 8 - Decision table + recipes + glossary + footer banner.
//
// No real async work; no Timer; no Navigator; everything renders inline as a
// scrollable static atlas. Material 3 ColorScheme idioms are used throughout.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) => const DartUiClassAtlasApp();

class DartUiClassAtlasApp extends StatelessWidget {
  const DartUiClassAtlasApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('dart:ui class atlas: executing deep visual demo');
    return MaterialApp(
      title: 'dart:ui Class Atlas',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3F51B5),
          brightness: Brightness.light,
        ),
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHeaderBanner(),
              _buildSection1Intro(),
              _buildSection2Geometry(),
              _buildSection3Color(),
              _buildSection4Path(),
              _buildSection5Primitives(),
              _buildSection6Pipeline(),
              _buildSection7FontsAndBoundary(),
              _buildSection8DecisionAndGlossary(),
              _buildFooterBanner(),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Header banner.
// ---------------------------------------------------------------------------
Widget _buildHeaderBanner() {
  print('header banner: building dart:ui class atlas banner');
  return Container(
    margin: const EdgeInsets.all(20.0),
    padding: const EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF1A237E),
          Color(0xFF3949AB),
          Color(0xFF00ACC1),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.indigo.withOpacity(0.35),
          blurRadius: 18.0,
          offset: const Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      children: <Widget>[
        const Icon(Icons.layers, size: 64.0, color: Colors.white),
        const SizedBox(height: 12.0),
        const Text(
          'dart:ui Class Atlas',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'A guided tour of geometry, color, paths, primitives and the imaging pipeline',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontSize: 14.0,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 8.0,
          alignment: WrapAlignment.center,
          children: const <Widget>[
            _BannerChip(label: 'geometry'),
            _BannerChip(label: 'color'),
            _BannerChip(label: 'path'),
            _BannerChip(label: 'primitives'),
            _BannerChip(label: 'pipeline'),
            _BannerChip(label: 'fonts'),
          ],
        ),
      ],
    ),
  );
}

class _BannerChip extends StatelessWidget {
  final String label;
  const _BannerChip({required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.16),
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: Colors.white.withOpacity(0.4)),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 1: intro - dart:ui vs flutter/painting.
// ---------------------------------------------------------------------------
Widget _buildSection1Intro() {
  print('=== Section 1: dart:ui Introduction ===');
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeading(
          number: 1,
          title: 'dart:ui and the painting boundary',
          subtitle:
              'The lowest-level engine bindings: tiny, immutable, allocation-cheap',
          accent: Color(0xFF1A237E),
        ),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _IntroColumn(
                title: 'dart:ui (engine layer)',
                bullets: const <String>[
                  'Raw geometry: Offset, Size, Rect, RRect, Radius',
                  'Color and BlendMode primitives',
                  'Path - the only path type in Flutter',
                  'Canvas, Picture, Scene, SceneBuilder',
                  'Image, Codec, FrameInfo (image pipeline)',
                  'Vertices, PointMode, VertexMode',
                ],
                accent: const Color(0xFF1A237E),
                icon: Icons.memory,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: _IntroColumn(
                title: 'flutter/painting (framework layer)',
                bullets: const <String>[
                  'BoxDecoration, BorderRadius, Border',
                  'Gradient (LinearGradient, RadialGradient, SweepGradient)',
                  'ImageProvider, ImageStream, ImageCache',
                  'EdgeInsets, Alignment, FractionalOffset',
                  'TextStyle, TextSpan (higher-level text)',
                  'Wraps dart:ui types into widget-friendly API',
                ],
                accent: const Color(0xFF00897B),
                icon: Icons.palette,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(Icons.lightbulb_outline, color: Colors.amber.shade800),
              const SizedBox(width: 10.0),
              const Expanded(
                child: Text(
                  'Rule of thumb: if a Flutter widget receives an Offset, Size, '
                  'Rect, Color or Path, that type comes from dart:ui. Everything '
                  'above (decorations, gradients, alignment helpers) is a '
                  'flutter/painting wrapper that ultimately resolves to those '
                  'engine primitives.',
                  style: TextStyle(fontSize: 13.0, height: 1.35),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24.0),
      ],
    ),
  );
}

class _IntroColumn extends StatelessWidget {
  final String title;
  final List<String> bullets;
  final Color accent;
  final IconData icon;
  const _IntroColumn({
    required this.title,
    required this.bullets,
    required this.accent,
    required this.icon,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.06),
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: accent.withOpacity(0.4), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: accent),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: accent,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          for (final String b in bullets)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(Icons.chevron_right, size: 16.0, color: accent),
                  const SizedBox(width: 4.0),
                  Expanded(
                    child: Text(b, style: const TextStyle(fontSize: 12.5)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  final int number;
  final String title;
  final String subtitle;
  final Color accent;
  const _SectionHeading({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.accent,
  });
  @override
  Widget build(BuildContext context) {
    print('=== Section $number: $title ===');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[accent, accent.withOpacity(0.6)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2.0),
            ),
            child: Center(
              child: Text(
                '$number',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 12.5,
                    fontStyle: FontStyle.italic,
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

// ---------------------------------------------------------------------------
// Reusable class card.
// ---------------------------------------------------------------------------
class _ClassCard extends StatelessWidget {
  final String name;
  final String signature;
  final List<String> members;
  final Widget specimen;
  final Color accent;
  final String summary;
  const _ClassCard({
    required this.name,
    required this.signature,
    required this.members,
    required this.specimen,
    required this.accent,
    required this.summary,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320.0,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: accent.withOpacity(0.45), width: 1.5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withOpacity(0.12),
            blurRadius: 10.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: accent.withOpacity(0.85),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(13.0),
                topRight: Radius.circular(13.0),
              ),
            ),
            child: Row(
              children: <Widget>[
                const Icon(Icons.class_, color: Colors.white, size: 18.0),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                      fontSize: 14.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Text(
                    signature,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Colors.cyan.shade200,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Text(
                  summary,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey.shade800,
                    height: 1.35,
                  ),
                ),
                const SizedBox(height: 10.0),
                Container(
                  height: 120.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: accent.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: accent.withOpacity(0.2)),
                  ),
                  child: specimen,
                ),
                const SizedBox(height: 10.0),
                for (final String m in members)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.arrow_right, size: 14.0, color: accent),
                        Expanded(
                          child: Text(
                            m,
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11.0,
                            ),
                          ),
                        ),
                      ],
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

// ---------------------------------------------------------------------------
// Section 2: Geometry atlas.
// ---------------------------------------------------------------------------
Widget _buildSection2Geometry() {
  print('=== Section 2: Geometry atlas ===');
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeading(
          number: 2,
          title: 'Geometry primitives',
          subtitle: 'Offset, Size, Rect, RRect, Radius, RSTransform',
          accent: Color(0xFF00897B),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
            _ClassCard(
              name: 'Offset',
              signature: 'const Offset(double dx, double dy)',
              accent: const Color(0xFF00838F),
              summary:
                  'A 2D fixed-point offset. Used for positions in the local '
                  'coordinate space and as a delta vector.',
              members: const <String>[
                '.dx, .dy        // double components',
                '.distance       // sqrt(dx^2 + dy^2)',
                '.direction      // atan2(dy, dx)',
                '+ - * / scale   // vector ops',
                'Offset.zero     // (0, 0)',
                'Offset.infinite // (inf, inf)',
              ],
              specimen: const _OffsetArrowSpecimen(),
            ),
            _ClassCard(
              name: 'Size',
              signature: 'const Size(double width, double height)',
              accent: const Color(0xFF2E7D32),
              summary:
                  'Holds a width/height pair. Extends OffsetBase. Two sizes '
                  'are equal when both components match exactly.',
              members: const <String>[
                '.width, .height       // double',
                '.aspectRatio          // w / h',
                '.shortestSide / longestSide',
                '.isEmpty / .isFinite',
                'Size.square(double s) // s x s',
                'Size.fromRadius(r)    // 2r x 2r',
              ],
              specimen: const _SizeRectSpecimen(),
            ),
            _ClassCard(
              name: 'Rect',
              signature: 'Rect.fromLTRB(double, double, double, double)',
              accent: const Color(0xFF1565C0),
              summary:
                  'An axis-aligned rectangle in local coordinates. Many named '
                  'constructors: fromLTRB, fromLTWH, fromCircle, fromPoints, '
                  'fromCenter.',
              members: const <String>[
                'Rect.fromLTRB / fromLTWH / fromCenter',
                'Rect.fromCircle(center, radius)',
                'Rect.fromPoints(a, b)',
                '.left .top .right .bottom',
                '.width .height .center .size',
                '.intersect / .expandToInclude',
              ],
              specimen: const _RectOutlineSpecimen(),
            ),
            _ClassCard(
              name: 'RRect',
              signature: 'RRect.fromRectAndRadius(Rect r, Radius radius)',
              accent: const Color(0xFF6A1B9A),
              summary:
                  'A Rect with rounded corners. Each corner can carry an '
                  'independent x/y radius. Used by Canvas.drawRRect and clip '
                  'operations.',
              members: const <String>[
                'RRect.fromRectAndRadius',
                'RRect.fromLTRBR',
                'RRect.fromRectAndCorners',
                '.tlRadius .trRadius .brRadius .blRadius',
                '.outerRect / .safeInnerRect',
                '.scaleRadii()',
              ],
              specimen: const _RRectSpecimen(),
            ),
            _ClassCard(
              name: 'Radius',
              signature: 'const Radius.circular(double r)',
              accent: const Color(0xFFD84315),
              summary:
                  'A pair (x, y) describing an ellipse half-extents. Used by '
                  'RRect corners and BorderRadius.',
              members: const <String>[
                'Radius.circular(double r)',
                'Radius.elliptical(double x, double y)',
                'Radius.zero',
                '.x .y',
                '+ - * / clamp',
              ],
              specimen: const _RadiusSpecimen(),
            ),
            _ClassCard(
              name: 'RSTransform',
              signature:
                  'RSTransform(double scos, double ssin, double tx, double ty)',
              accent: const Color(0xFF455A64),
              summary:
                  'A rotation/scale/translate transform stored as 4 doubles. '
                  'Used by Canvas.drawAtlas for high-throughput sprite draws.',
              members: const <String>[
                'RSTransform.fromComponents(...)',
                '.scos .ssin .tx .ty',
                'rotation = atan2(ssin, scos)',
                'scale = sqrt(scos^2 + ssin^2)',
              ],
              specimen: const _RSTransformSpecimen(),
            ),
          ],
        ),
        const SizedBox(height: 24.0),
      ],
    ),
  );
}

class _OffsetArrowSpecimen extends StatelessWidget {
  const _OffsetArrowSpecimen();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200.0,
      height: 100.0,
      child: Stack(
        children: <Widget>[
          Positioned(
            left: 20.0,
            top: 70.0,
            child: Container(
              width: 8.0,
              height: 8.0,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 150.0,
            top: 20.0,
            child: Container(
              width: 10.0,
              height: 10.0,
              decoration: const BoxDecoration(
                color: Colors.redAccent,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 28.0,
            top: 30.0,
            child: Transform.rotate(
              angle: -0.4,
              alignment: Alignment.bottomLeft,
              child: Container(
                width: 140.0,
                height: 2.5,
                color: Colors.indigo,
              ),
            ),
          ),
          const Positioned(
            left: 70.0,
            top: 78.0,
            child: Text(
              '(130, -50)',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.indigo,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SizeRectSpecimen extends StatelessWidget {
  const _SizeRectSpecimen();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 150.0,
          height: 80.0,
          decoration: BoxDecoration(
            color: Colors.green.shade100,
            border: Border.all(color: Colors.green.shade700, width: 2.0),
          ),
        ),
        const Text(
          'Size(150, 80)',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Positioned(
          top: 6.0,
          child: Text(
            'width',
            style: TextStyle(fontSize: 10.0, color: Colors.green),
          ),
        ),
        const Positioned(
          left: 6.0,
          child: RotatedBox(
            quarterTurns: 3,
            child: Text(
              'height',
              style: TextStyle(fontSize: 10.0, color: Colors.green),
            ),
          ),
        ),
      ],
    );
  }
}

class _RectOutlineSpecimen extends StatelessWidget {
  const _RectOutlineSpecimen();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: 30.0,
          top: 20.0,
          child: Container(
            width: 140.0,
            height: 70.0,
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.12),
              border: Border.all(color: Colors.blue.shade700, width: 2.0),
            ),
          ),
        ),
        const Positioned(
          left: 6.0,
          top: 6.0,
          child: Text(
            '(L,T)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Colors.blue,
            ),
          ),
        ),
        const Positioned(
          right: 6.0,
          bottom: 6.0,
          child: Text(
            '(R,B)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Colors.blue,
            ),
          ),
        ),
      ],
    );
  }
}

class _RRectSpecimen extends StatelessWidget {
  const _RRectSpecimen();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160.0,
      height: 80.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[Colors.purple.shade200, Colors.purple.shade400],
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(4.0),
          topRight: Radius.circular(16.0),
          bottomRight: Radius.circular(28.0),
          bottomLeft: Radius.circular(10.0),
        ),
        border: Border.all(color: Colors.purple.shade800, width: 2.0),
      ),
      alignment: Alignment.center,
      child: const Text(
        '4 corners, 4 radii',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _RadiusSpecimen extends StatelessWidget {
  const _RadiusSpecimen();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.deepOrange.shade300,
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            const SizedBox(height: 4.0),
            const Text('circular',
                style: TextStyle(fontSize: 10.0, fontFamily: 'monospace')),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 70.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: Colors.deepOrange.shade300,
                borderRadius: const BorderRadius.all(
                  Radius.elliptical(35.0, 20.0),
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            const Text('elliptical',
                style: TextStyle(fontSize: 10.0, fontFamily: 'monospace')),
          ],
        ),
      ],
    );
  }
}

class _RSTransformSpecimen extends StatelessWidget {
  const _RSTransformSpecimen();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade200,
            border: Border.all(color: Colors.blueGrey),
          ),
        ),
        Transform.rotate(
          angle: 0.6,
          child: Transform.scale(
            scale: 1.3,
            child: Container(
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: Colors.blueGrey.shade700.withOpacity(0.7),
                border: Border.all(color: Colors.black, width: 2.0),
              ),
              alignment: Alignment.center,
              child: const Text(
                'RST',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section 3: Color taxonomy.
// ---------------------------------------------------------------------------
Widget _buildSection3Color() {
  print('=== Section 3: Color taxonomy ===');
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeading(
          number: 3,
          title: 'Color and the alpha channel',
          subtitle: 'Color, opacity sweeps, Material 3 ColorScheme idioms',
          accent: Color(0xFF6A1B9A),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
            _ClassCard(
              name: 'Color',
              signature: 'const Color(int argb)',
              accent: const Color(0xFFD81B60),
              summary:
                  'A 32-bit ARGB color. Bits: 0xAARRGGBB. Immutable; mutate '
                  'with withAlpha/withRed/withGreen/withBlue or withOpacity.',
              members: const <String>[
                'Color(0xAARRGGBB)',
                'Color.fromARGB(a, r, g, b)',
                'Color.fromRGBO(r, g, b, opacity)',
                '.alpha .red .green .blue (0..255)',
                '.opacity (0.0..1.0)',
                '.withOpacity(d) / .withAlpha(i)',
              ],
              specimen: const _ColorSwatchSpecimen(),
            ),
            _ClassCard(
              name: 'Color (alpha sweep)',
              signature: 'color.withOpacity(double 0..1)',
              accent: const Color(0xFFAD1457),
              summary:
                  'Lower opacity values fade the color toward the underlying '
                  'background. Premultiplied alpha is used internally by the '
                  'engine.',
              members: const <String>[
                'withOpacity(0.0)  -> fully transparent',
                'withOpacity(0.25) -> 25% visible',
                'withOpacity(0.5)  -> 50% visible',
                'withOpacity(0.75) -> 75% visible',
                'withOpacity(1.0)  -> fully opaque',
              ],
              specimen: const _AlphaSweepSpecimen(),
            ),
            _ClassCard(
              name: 'Color (channels)',
              signature: 'color.withRed/withGreen/withBlue(int)',
              accent: const Color(0xFF00838F),
              summary:
                  'Channel mutators return a NEW Color with the requested '
                  'channel replaced. Each channel is 0..255.',
              members: const <String>[
                '.red   -> 0..255',
                '.green -> 0..255',
                '.blue  -> 0..255',
                'withRed(255)  -> shift toward red',
                'withGreen(255) -> shift toward green',
                'withBlue(255)  -> shift toward blue',
              ],
              specimen: const _ChannelSpecimen(),
            ),
            _ClassCard(
              name: 'ColorScheme (M3)',
              signature: 'ColorScheme.fromSeed(seedColor: Color)',
              accent: const Color(0xFF3949AB),
              summary:
                  'flutter/material wraps Color into a Material 3 palette with '
                  'primary/secondary/tertiary/error and their containers.',
              members: const <String>[
                '.primary / .onPrimary',
                '.primaryContainer / .onPrimaryContainer',
                '.secondary / .secondaryContainer',
                '.tertiary / .tertiaryContainer',
                '.error / .errorContainer',
                '.surface / .surfaceVariant',
              ],
              specimen: const _ColorSchemeSpecimen(),
            ),
          ],
        ),
        const SizedBox(height: 24.0),
      ],
    ),
  );
}

class _ColorSwatchSpecimen extends StatelessWidget {
  const _ColorSwatchSpecimen();
  @override
  Widget build(BuildContext context) {
    final List<Color> shades = <Color>[
      Colors.red.shade300,
      Colors.orange.shade300,
      Colors.amber.shade300,
      Colors.green.shade300,
      Colors.teal.shade300,
      Colors.blue.shade300,
      Colors.indigo.shade300,
      Colors.purple.shade300,
    ];
    return Wrap(
      spacing: 4.0,
      runSpacing: 4.0,
      alignment: WrapAlignment.center,
      children: <Widget>[
        for (final Color c in shades)
          Container(
            width: 22.0,
            height: 22.0,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: Colors.black26),
            ),
          ),
      ],
    );
  }
}

class _AlphaSweepSpecimen extends StatelessWidget {
  const _AlphaSweepSpecimen();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 0; i <= 4; i++)
              Container(
                width: 26.0,
                height: 40.0,
                margin: const EdgeInsets.symmetric(horizontal: 2.0),
                color: Colors.deepPurple.withOpacity(i / 4.0),
              ),
          ],
        ),
        const SizedBox(height: 6.0),
        const Text(
          '0.0  0.25  0.5  0.75  1.0',
          style: TextStyle(fontFamily: 'monospace', fontSize: 10.0),
        ),
      ],
    );
  }
}

class _ChannelSpecimen extends StatelessWidget {
  const _ChannelSpecimen();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        _ChannelBar(label: 'R', color: Colors.red),
        _ChannelBar(label: 'G', color: Colors.green),
        _ChannelBar(label: 'B', color: Colors.blue),
      ],
    );
  }
}

class _ChannelBar extends StatelessWidget {
  final String label;
  final Color color;
  const _ChannelBar({required this.label, required this.color});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 22.0,
          height: 70.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[Colors.white, color],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            border: Border.all(color: Colors.black26),
          ),
        ),
        const SizedBox(height: 4.0),
        Text(label,
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }
}

class _ColorSchemeSpecimen extends StatelessWidget {
  const _ColorSchemeSpecimen();
  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final List<List<dynamic>> rows = <List<dynamic>>[
      <dynamic>[cs.primary, cs.onPrimary, 'primary'],
      <dynamic>[cs.secondary, cs.onSecondary, 'secondary'],
      <dynamic>[cs.tertiary, cs.onTertiary, 'tertiary'],
      <dynamic>[cs.error, cs.onError, 'error'],
    ];
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        for (final List<dynamic> r in rows)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: <Widget>[
                Container(width: 14.0, height: 14.0, color: r[0] as Color),
                Container(width: 14.0, height: 14.0, color: r[1] as Color),
                const SizedBox(width: 6.0),
                Text(
                  r[2] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.0,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section 4: Path atlas.
// ---------------------------------------------------------------------------
Widget _buildSection4Path() {
  print('=== Section 4: Path atlas ===');
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeading(
          number: 4,
          title: 'Path: the universal shape primitive',
          subtitle:
              'Path() constructor, factories, shape helpers and silhouettes',
          accent: Color(0xFFC62828),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
            _ClassCard(
              name: 'Path()',
              signature: 'Path()',
              accent: const Color(0xFFC62828),
              summary:
                  'Empty path; build by calling moveTo, lineTo, cubicTo, '
                  'quadraticBezierTo, arcTo, addRect, addOval, addRRect, '
                  'addPolygon, addPath.',
              members: const <String>[
                '.moveTo(x, y)',
                '.lineTo(x, y)',
                '.cubicTo(x1, y1, x2, y2, x3, y3)',
                '.quadraticBezierTo(x1, y1, x2, y2)',
                '.arcTo(rect, start, sweep, ...)',
                '.close() / .reset()',
              ],
              specimen: const _PathTriangleSpecimen(),
            ),
            _ClassCard(
              name: 'Path.from',
              signature: 'Path.from(Path source)',
              accent: const Color(0xFFAD1457),
              summary:
                  'Returns a deep copy of an existing path. Useful when you '
                  'want to transform a base shape without mutating the source.',
              members: const <String>[
                'final base = Path()..addRect(r);',
                'final copy = Path.from(base);',
                'copy.transform(matrix4.storage);',
                'PathOperation.union / .intersect',
                'Path.combine(op, a, b)',
              ],
              specimen: const _PathCopySpecimen(),
            ),
            _ClassCard(
              name: 'Path.addOval',
              signature: 'path.addOval(Rect oval)',
              accent: const Color(0xFF6A1B9A),
              summary:
                  'Append an ellipse contained inside the given rect to the '
                  'current path.',
              members: const <String>[
                'path.addOval(Rect.fromCircle(center, r))',
                'path.addArc(rect, start, sweep)',
                'path.addRect(rect)',
                'path.addRRect(rrect)',
                'path.addPolygon(points, closed)',
              ],
              specimen: const _PathOvalSpecimen(),
            ),
            _ClassCard(
              name: 'Path (Bezier)',
              signature: 'path.cubicTo / quadraticBezierTo',
              accent: const Color(0xFF1565C0),
              summary:
                  'Build smooth curved silhouettes from control points. Used '
                  'for icons, charts, animated blob shapes.',
              members: const <String>[
                'moveTo + cubicTo + cubicTo + close',
                'quadraticBezierTo for parabolic curves',
                'conicTo for weighted rationals',
                'relativeCubicTo for current-pos deltas',
                'PathMetric.extractPath for trimming',
              ],
              specimen: const _PathCurveSpecimen(),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        _SilhouetteGallery(),
        const SizedBox(height: 24.0),
      ],
    ),
  );
}

class _PathTriangleSpecimen extends StatelessWidget {
  const _PathTriangleSpecimen();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(160.0, 100.0),
      painter: _TrianglePainter(),
    );
  }
}

class _TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path p = Path()
      ..moveTo(size.width / 2, 10.0)
      ..lineTo(size.width - 10.0, size.height - 10.0)
      ..lineTo(10.0, size.height - 10.0)
      ..close();
    final Paint stroke = Paint()
      ..color = Colors.red.shade700
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    final Paint fill = Paint()..color = Colors.red.shade100;
    canvas.drawPath(p, fill);
    canvas.drawPath(p, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PathCopySpecimen extends StatelessWidget {
  const _PathCopySpecimen();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(180.0, 100.0),
      painter: _CopyPathPainter(),
    );
  }
}

class _CopyPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path base = Path()
      ..addRect(const Rect.fromLTWH(10.0, 20.0, 60.0, 60.0));
    final Path copy = Path.from(base);
    final Paint a = Paint()
      ..color = Colors.pink.shade200
      ..style = PaintingStyle.fill;
    final Paint b = Paint()
      ..color = Colors.pink.shade700
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawPath(base, a);
    canvas.translate(70.0, 10.0);
    canvas.drawPath(copy, b);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PathOvalSpecimen extends StatelessWidget {
  const _PathOvalSpecimen();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(180.0, 100.0),
      painter: _OvalPathPainter(),
    );
  }
}

class _OvalPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path p = Path()
      ..addOval(const Rect.fromLTWH(20.0, 20.0, 60.0, 60.0))
      ..addOval(const Rect.fromLTWH(100.0, 20.0, 60.0, 60.0));
    final Paint paint = Paint()
      ..color = Colors.purple.shade400
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    canvas.drawPath(p, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PathCurveSpecimen extends StatelessWidget {
  const _PathCurveSpecimen();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(180.0, 100.0),
      painter: _CurvePathPainter(),
    );
  }
}

class _CurvePathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path p = Path()
      ..moveTo(10.0, size.height - 10.0)
      ..cubicTo(
        size.width * 0.3, 10.0,
        size.width * 0.7, size.height - 10.0,
        size.width - 10.0, 10.0,
      );
    final Paint paint = Paint()
      ..color = Colors.blue.shade700
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(p, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SilhouetteGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<_SilhouetteSpec> items = <_SilhouetteSpec>[
      _SilhouetteSpec('star', Colors.amber.shade700, _StarPainter()),
      _SilhouetteSpec('heart', Colors.red.shade400, _HeartPainter()),
      _SilhouetteSpec('arrow', Colors.indigo, _ArrowPainter()),
      _SilhouetteSpec('blob', Colors.teal, _BlobPainter()),
      _SilhouetteSpec('chevron', Colors.deepOrange, _ChevronPainter()),
    ];
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.gesture, color: Colors.red.shade700),
              const SizedBox(width: 6.0),
              Text(
                'Path silhouette gallery',
                style: TextStyle(
                  color: Colors.red.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: <Widget>[
              for (final _SilhouetteSpec s in items)
                Container(
                  width: 110.0,
                  margin: const EdgeInsets.all(6.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: s.color.withOpacity(0.4)),
                  ),
                  child: Column(
                    children: <Widget>[
                      CustomPaint(
                        size: const Size(80.0, 60.0),
                        painter: s.painter,
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        s.label,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                          color: s.color,
                          fontWeight: FontWeight.bold,
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
}

class _SilhouetteSpec {
  final String label;
  final Color color;
  final CustomPainter painter;
  _SilhouetteSpec(this.label, this.color, this.painter);
}

class _StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path p = Path();
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    const int spikes = 5;
    final double rOuter = size.shortestSide / 2 - 2;
    final double rInner = rOuter * 0.5;
    for (int i = 0; i < spikes * 2; i++) {
      final double r = i.isEven ? rOuter : rInner;
      final double a = -3.1415 / 2 + i * 3.1415 / spikes;
      final double x = cx + r * 0.99 * _cos(a);
      final double y = cy + r * 0.99 * _sin(a);
      if (i == 0) {
        p.moveTo(x, y);
      } else {
        p.lineTo(x, y);
      }
    }
    p.close();
    final Paint fill = Paint()..color = Colors.amber.shade600;
    canvas.drawPath(p, fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

double _cos(double a) {
  // Use Flutter's math via Transform? In a static AST script, prefer a
  // hand-coded Taylor approximation to avoid dart:math imports. This is a
  // visual specimen only, so a small approximation is fine.
  double x = a;
  // Reduce a into [-pi, pi].
  while (x > 3.14159265) {
    x -= 6.28318530;
  }
  while (x < -3.14159265) {
    x += 6.28318530;
  }
  final double x2 = x * x;
  return 1.0 - x2 / 2.0 + x2 * x2 / 24.0 - x2 * x2 * x2 / 720.0;
}

double _sin(double a) {
  double x = a;
  while (x > 3.14159265) {
    x -= 6.28318530;
  }
  while (x < -3.14159265) {
    x += 6.28318530;
  }
  final double x2 = x * x;
  return x - x * x2 / 6.0 + x * x2 * x2 / 120.0 - x * x2 * x2 * x2 / 5040.0;
}

class _HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path p = Path();
    final double w = size.width;
    final double h = size.height;
    p.moveTo(w / 2, h * 0.85);
    p.cubicTo(-w * 0.1, h * 0.4, w * 0.2, -h * 0.1, w / 2, h * 0.25);
    p.cubicTo(w * 0.8, -h * 0.1, w * 1.1, h * 0.4, w / 2, h * 0.85);
    p.close();
    final Paint paint = Paint()..color = Colors.red.shade400;
    canvas.drawPath(p, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ArrowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path p = Path()
      ..moveTo(4.0, size.height * 0.4)
      ..lineTo(size.width * 0.7, size.height * 0.4)
      ..lineTo(size.width * 0.7, size.height * 0.2)
      ..lineTo(size.width - 4.0, size.height * 0.5)
      ..lineTo(size.width * 0.7, size.height * 0.8)
      ..lineTo(size.width * 0.7, size.height * 0.6)
      ..lineTo(4.0, size.height * 0.6)
      ..close();
    final Paint fill = Paint()..color = Colors.indigo;
    canvas.drawPath(p, fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _BlobPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path p = Path()
      ..moveTo(size.width * 0.2, size.height * 0.5)
      ..cubicTo(
        size.width * 0.1, size.height * 0.1,
        size.width * 0.6, size.height * 0.0,
        size.width * 0.8, size.height * 0.3,
      )
      ..cubicTo(
        size.width * 1.0, size.height * 0.6,
        size.width * 0.7, size.height * 1.0,
        size.width * 0.4, size.height * 0.9,
      )
      ..cubicTo(
        size.width * 0.05, size.height * 0.85,
        size.width * 0.0, size.height * 0.6,
        size.width * 0.2, size.height * 0.5,
      )
      ..close();
    final Paint fill = Paint()..color = Colors.teal.shade400;
    canvas.drawPath(p, fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ChevronPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path p = Path()
      ..moveTo(8.0, 8.0)
      ..lineTo(size.width / 2, size.height - 8.0)
      ..lineTo(size.width - 8.0, 8.0);
    final Paint stroke = Paint()
      ..color = Colors.deepOrange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(p, stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Section 5: Drawing primitives - PointMode, VertexMode, Vertices.
// ---------------------------------------------------------------------------
Widget _buildSection5Primitives() {
  print('=== Section 5: Drawing primitives ===');
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeading(
          number: 5,
          title: 'Drawing primitives',
          subtitle: 'PointMode, VertexMode and the Vertices builder',
          accent: Color(0xFF2E7D32),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.green.shade50,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.green.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.scatter_plot, color: Colors.green.shade800),
                  const SizedBox(width: 8.0),
                  Text(
                    'PointMode (used by Canvas.drawPoints)',
                    style: TextStyle(
                      color: Colors.green.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: <Widget>[
                  _PointModeCard(
                    mode: 'points',
                    description:
                        'Each Offset is drawn as a square dot with size '
                        'paint.strokeWidth.',
                    painter: _PointsPainter(),
                  ),
                  _PointModeCard(
                    mode: 'lines',
                    description:
                        'Pairs of offsets become disconnected line segments. '
                        'Must supply an even count.',
                    painter: _LinesPainter(),
                  ),
                  _PointModeCard(
                    mode: 'polygon',
                    description:
                        'All offsets are joined into a single continuous '
                        'polyline (not closed).',
                    painter: _PolygonPainter(),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.teal.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.change_history, color: Colors.teal.shade800),
                  const SizedBox(width: 8.0),
                  Text(
                    'VertexMode (used by Vertices + Canvas.drawVertices)',
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Wrap(
                alignment: WrapAlignment.spaceEvenly,
                children: <Widget>[
                  _VertexModeCard(
                    mode: 'triangles',
                    description:
                        'Every three vertices form one independent triangle. '
                        'Vertex count must be a multiple of 3.',
                    painter: _TrianglesVMPainter(),
                  ),
                  _VertexModeCard(
                    mode: 'triangleStrip',
                    description:
                        'Each new vertex forms a triangle with the previous '
                        'two. Excellent for ribbons and strips.',
                    painter: _StripVMPainter(),
                  ),
                  _VertexModeCard(
                    mode: 'triangleFan',
                    description:
                        'First vertex is the pivot; each pair of subsequent '
                        'vertices forms a fan triangle.',
                    painter: _FanVMPainter(),
                  ),
                ],
              ),
              const SizedBox(height: 14.0),
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  '// Vertices builder\n'
                  'final v = Vertices(\n'
                  '  VertexMode.triangleStrip,\n'
                  '  <Offset>[Offset(0,0), Offset(10,0), Offset(0,10)],\n'
                  '  colors: <Color>[red, green, blue],\n'
                  ');\n'
                  'canvas.drawVertices(v, BlendMode.srcOver, paint);',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: Colors.cyan.shade200,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24.0),
      ],
    ),
  );
}

class _PointModeCard extends StatelessWidget {
  final String mode;
  final String description;
  final CustomPainter painter;
  const _PointModeCard({
    required this.mode,
    required this.description,
    required this.painter,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.green.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Colors.green.shade100,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              'PointMode.$mode',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          CustomPaint(size: const Size(140.0, 70.0), painter: painter),
          const SizedBox(height: 8.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11.0, height: 1.3),
          ),
        ],
      ),
    );
  }
}

class _VertexModeCard extends StatelessWidget {
  final String mode;
  final String description;
  final CustomPainter painter;
  const _VertexModeCard({
    required this.mode,
    required this.description,
    required this.painter,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      margin: const EdgeInsets.all(6.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.teal.shade300),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: Colors.teal.shade100,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              'VertexMode.$mode',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade900,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          CustomPaint(size: const Size(160.0, 70.0), painter: painter),
          const SizedBox(height: 8.0),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11.0, height: 1.3),
          ),
        ],
      ),
    );
  }
}

class _PointsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.green.shade700
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 8; i++) {
      final double x = 10.0 + i * 15.0;
      final double y = 10.0 + ((i % 3) * 18.0);
      canvas.drawCircle(Offset(x, y), 3.0, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.green.shade700
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(10.0, 10.0), const Offset(60.0, 30.0), paint);
    canvas.drawLine(const Offset(70.0, 15.0), const Offset(120.0, 50.0), paint);
    canvas.drawLine(const Offset(20.0, 55.0), const Offset(110.0, 60.0), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PolygonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Path p = Path()
      ..moveTo(10.0, 60.0)
      ..lineTo(30.0, 10.0)
      ..lineTo(60.0, 40.0)
      ..lineTo(90.0, 15.0)
      ..lineTo(125.0, 55.0);
    final Paint paint = Paint()
      ..color = Colors.green.shade700
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(p, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TrianglesVMPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint a = Paint()..color = Colors.teal.shade300;
    final Paint b = Paint()..color = Colors.teal.shade600;
    final Path t1 = Path()
      ..moveTo(10.0, 60.0)
      ..lineTo(35.0, 10.0)
      ..lineTo(60.0, 60.0)
      ..close();
    final Path t2 = Path()
      ..moveTo(80.0, 60.0)
      ..lineTo(110.0, 15.0)
      ..lineTo(140.0, 60.0)
      ..close();
    canvas.drawPath(t1, a);
    canvas.drawPath(t2, b);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StripVMPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final List<Offset> pts = <Offset>[
      const Offset(10.0, 60.0),
      const Offset(30.0, 10.0),
      const Offset(50.0, 60.0),
      const Offset(75.0, 10.0),
      const Offset(95.0, 60.0),
      const Offset(120.0, 10.0),
      const Offset(140.0, 60.0),
    ];
    final List<Color> palette = <Color>[
      Colors.teal.shade200,
      Colors.teal.shade400,
      Colors.teal.shade600,
      Colors.teal.shade800,
      Colors.teal.shade500,
    ];
    for (int i = 0; i + 2 < pts.length; i++) {
      final Path p = Path()
        ..moveTo(pts[i].dx, pts[i].dy)
        ..lineTo(pts[i + 1].dx, pts[i + 1].dy)
        ..lineTo(pts[i + 2].dx, pts[i + 2].dy)
        ..close();
      canvas.drawPath(p, Paint()..color = palette[i % palette.length]);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _FanVMPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const Offset center = Offset(80.0, 60.0);
    final List<Offset> outer = <Offset>[
      const Offset(10.0, 50.0),
      const Offset(30.0, 15.0),
      const Offset(70.0, 5.0),
      const Offset(110.0, 12.0),
      const Offset(140.0, 35.0),
      const Offset(150.0, 60.0),
    ];
    for (int i = 0; i + 1 < outer.length; i++) {
      final Path p = Path()
        ..moveTo(center.dx, center.dy)
        ..lineTo(outer[i].dx, outer[i].dy)
        ..lineTo(outer[i + 1].dx, outer[i + 1].dy)
        ..close();
      canvas.drawPath(
        p,
        Paint()..color = Colors.teal.withOpacity(0.3 + i * 0.1),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Section 6: Pipeline diagrams - Picture, Scene, image pipeline.
// ---------------------------------------------------------------------------
Widget _buildSection6Pipeline() {
  print('=== Section 6: Pipeline diagrams ===');
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeading(
          number: 6,
          title: 'Picture pipeline and image pipeline',
          subtitle:
              'How Canvas drawing becomes Pictures, Scenes and Image frames',
          accent: Color(0xFFF57C00),
        ),
        const SizedBox(height: 12.0),
        _PipelineRow(
          title: 'Picture pipeline (rendering output)',
          accent: Colors.orange,
          steps: const <_PipelineStep>[
            _PipelineStep(
              label: 'PictureRecorder',
              note: 'records canvas commands',
              icon: Icons.fiber_manual_record,
            ),
            _PipelineStep(
              label: 'Canvas',
              note: 'draw* calls populate the recorder',
              icon: Icons.brush,
            ),
            _PipelineStep(
              label: 'Picture',
              note: 'recorder.endRecording()',
              icon: Icons.photo,
            ),
            _PipelineStep(
              label: 'SceneBuilder',
              note: 'addPicture(offset, picture)',
              icon: Icons.layers,
            ),
            _PipelineStep(
              label: 'Scene',
              note: 'builder.build() -> rasterizer',
              icon: Icons.view_in_ar,
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        _PipelineRow(
          title: 'Image pipeline (asset/network -> ui.Image)',
          accent: Colors.deepPurple,
          steps: const <_PipelineStep>[
            _PipelineStep(
              label: 'Uint8List',
              note: 'raw encoded bytes',
              icon: Icons.memory,
            ),
            _PipelineStep(
              label: 'ImmutableBuffer',
              note: 'ImmutableBuffer.fromUint8List',
              icon: Icons.lock,
            ),
            _PipelineStep(
              label: 'ImageDescriptor',
              note: 'ImageDescriptor.encoded(buffer)',
              icon: Icons.description,
            ),
            _PipelineStep(
              label: 'Codec',
              note: 'descriptor.instantiateCodec()',
              icon: Icons.qr_code_2,
            ),
            _PipelineStep(
              label: 'FrameInfo',
              note: 'codec.getNextFrame()',
              icon: Icons.movie,
            ),
            _PipelineStep(
              label: 'Image',
              note: 'frame.image',
              icon: Icons.image,
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
            _ClassCard(
              name: 'Picture',
              signature: 'recorder.endRecording()',
              accent: const Color(0xFFF57C00),
              summary:
                  'An immutable snapshot of a sequence of canvas commands. '
                  'Replayable and disposable.',
              members: const <String>[
                '.toImage(width, height)',
                '.toImageSync(width, height)',
                '.approximateBytesUsed',
                '.dispose()',
              ],
              specimen: const _PictureBoxSpecimen(),
            ),
            _ClassCard(
              name: 'Scene / SceneBuilder',
              signature: 'SceneBuilder().build()',
              accent: const Color(0xFFEF6C00),
              summary:
                  'Top-level engine object that GPU rasterizes. Use offset/'
                  'transform/opacity/clip layers to build a stack.',
              members: const <String>[
                'pushOffset(dx, dy)',
                'pushTransform(matrix.storage)',
                'pushOpacity(alpha)',
                'pushClipRect(rect)',
                'addPicture(offset, picture)',
                'build() -> Scene',
              ],
              specimen: const _SceneBuilderSpecimen(),
            ),
            _ClassCard(
              name: 'Image',
              signature: 'ui.Image (immutable raster)',
              accent: const Color(0xFF6A1B9A),
              summary:
                  'GPU-backed raster image. Cannot be constructed directly; '
                  'created via Codec.getNextFrame, Picture.toImage, or '
                  'decodeImageFromList.',
              members: const <String>[
                '.width / .height',
                '.colorSpace',
                '.toByteData(format: ImageByteFormat)',
                '.clone() / .isCloneOf(other)',
                '.dispose()',
              ],
              specimen: const _ImageBoxSpecimen(),
            ),
            _ClassCard(
              name: 'ImmutableBuffer',
              signature:
                  'await ImmutableBuffer.fromUint8List(bytes)',
              accent: const Color(0xFF00838F),
              summary:
                  'A platform-managed read-only byte buffer. Holds encoded '
                  'image data until consumed by an ImageDescriptor.',
              members: const <String>[
                'ImmutableBuffer.fromUint8List(bytes)',
                'ImmutableBuffer.fromAsset(name)',
                'ImmutableBuffer.fromFilePath(path)',
                '.length',
                '.dispose()',
              ],
              specimen: const _BufferSpecimen(),
            ),
            _ClassCard(
              name: 'ImageDescriptor',
              signature: 'ImageDescriptor.encoded(buffer)',
              accent: const Color(0xFF1565C0),
              summary:
                  'A handle exposing the dimensions and pixel format of an '
                  'encoded image and a factory for Codecs.',
              members: const <String>[
                'ImageDescriptor.encoded(buffer)',
                'ImageDescriptor.raw(buffer, w, h, format)',
                '.width / .height',
                '.bytesPerPixel',
                'instantiateCodec(targetWidth, targetHeight)',
              ],
              specimen: const _DescriptorSpecimen(),
            ),
            _ClassCard(
              name: 'Codec / FrameInfo',
              signature: 'descriptor.instantiateCodec()',
              accent: const Color(0xFF455A64),
              summary:
                  'Iterates the frames of an encoded image (still or animated).'
                  ' FrameInfo carries the image plus per-frame duration.',
              members: const <String>[
                'codec.frameCount',
                'codec.repetitionCount',
                'codec.getNextFrame() -> FrameInfo',
                'frame.image -> ui.Image',
                'frame.duration -> Duration',
                'codec.dispose()',
              ],
              specimen: const _CodecSpecimen(),
            ),
          ],
        ),
        const SizedBox(height: 24.0),
      ],
    ),
  );
}

class _PipelineStep {
  final String label;
  final String note;
  final IconData icon;
  const _PipelineStep(
      {required this.label, required this.note, required this.icon});
}

class _PipelineRow extends StatelessWidget {
  final String title;
  final Color accent;
  final List<_PipelineStep> steps;
  const _PipelineRow({
    required this.title,
    required this.accent,
    required this.steps,
  });
  @override
  Widget build(BuildContext context) {
    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < steps.length; i++) {
      tiles.add(_pipelineTile(steps[i]));
      if (i != steps.length - 1) {
        tiles.add(Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Icon(Icons.arrow_forward, color: accent, size: 18.0),
        ));
      }
    }
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accent.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          const SizedBox(height: 12.0),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: tiles),
          ),
        ],
      ),
    );
  }

  Widget _pipelineTile(_PipelineStep step) {
    return Container(
      width: 110.0,
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: accent.withOpacity(0.5)),
      ),
      child: Column(
        children: <Widget>[
          Icon(step.icon, color: accent),
          const SizedBox(height: 4.0),
          Text(
            step.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: accent,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            step.note,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10.0, height: 1.2),
          ),
        ],
      ),
    );
  }
}

class _PictureBoxSpecimen extends StatelessWidget {
  const _PictureBoxSpecimen();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 160.0,
          height: 100.0,
          decoration: BoxDecoration(
            color: Colors.orange.shade100,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.orange.shade700, width: 2.0),
          ),
        ),
        const Icon(Icons.movie, color: Colors.orange, size: 40.0),
        const Positioned(
          top: 8.0,
          left: 8.0,
          child: Text(
            'Picture',
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
              color: Colors.deepOrange,
            ),
          ),
        ),
      ],
    );
  }
}

class _SceneBuilderSpecimen extends StatelessWidget {
  const _SceneBuilderSpecimen();
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: 80.0,
          height: 80.0,
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade100,
            border: Border.all(color: Colors.deepOrange, width: 2.0),
          ),
        ),
        Transform.translate(
          offset: const Offset(15.0, -15.0),
          child: Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.orange.shade300.withOpacity(0.7),
              border: Border.all(color: Colors.orange.shade700, width: 2.0),
            ),
          ),
        ),
        Transform.translate(
          offset: const Offset(30.0, -30.0),
          child: Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.amber.shade300.withOpacity(0.7),
              border: Border.all(color: Colors.amber.shade800, width: 2.0),
            ),
          ),
        ),
      ],
    );
  }
}

class _ImageBoxSpecimen extends StatelessWidget {
  const _ImageBoxSpecimen();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120.0,
      height: 90.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Colors.purple.shade300,
            Colors.indigo.shade400,
          ],
        ),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: Colors.purple.shade900, width: 2.0),
      ),
      alignment: Alignment.center,
      child: const Icon(Icons.photo, color: Colors.white, size: 36.0),
    );
  }
}

class _BufferSpecimen extends StatelessWidget {
  const _BufferSpecimen();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < 8; i++)
          Container(
            width: 10.0,
            height: 28.0,
            margin: const EdgeInsets.symmetric(horizontal: 1.5),
            decoration: BoxDecoration(
              color: Colors.cyan.shade400.withOpacity(0.3 + (i / 16.0)),
              borderRadius: BorderRadius.circular(2.0),
            ),
          ),
      ],
    );
  }
}

class _DescriptorSpecimen extends StatelessWidget {
  const _DescriptorSpecimen();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        border: Border.all(color: Colors.blue.shade400),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'ImageDescriptor',
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 11.0,
            ),
          ),
          SizedBox(height: 4.0),
          Text('width:  1024', style: TextStyle(fontFamily: 'monospace', fontSize: 11.0)),
          Text('height: 768',  style: TextStyle(fontFamily: 'monospace', fontSize: 11.0)),
          Text('bpp:    4',    style: TextStyle(fontFamily: 'monospace', fontSize: 11.0)),
        ],
      ),
    );
  }
}

class _CodecSpecimen extends StatelessWidget {
  const _CodecSpecimen();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        for (int i = 0; i < 4; i++)
          Container(
            width: 26.0,
            height: 40.0,
            margin: const EdgeInsets.symmetric(horizontal: 2.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey.shade300.withOpacity(0.4 + (i / 6.0)),
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: Colors.blueGrey.shade700),
            ),
            alignment: Alignment.center,
            child: Text(
              '${i + 1}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Section 7: Fonts and the library boundary.
// ---------------------------------------------------------------------------
Widget _buildSection7FontsAndBoundary() {
  print('=== Section 7: Fonts and the library boundary ===');
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeading(
          number: 7,
          title: 'Fonts and the dart:ui / painting boundary',
          subtitle: 'FontStyle, FontWeight and what lives where',
          accent: Color(0xFF5D4037),
        ),
        const SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: <Widget>[
            _ClassCard(
              name: 'FontStyle',
              signature: 'enum FontStyle { normal, italic }',
              accent: const Color(0xFF5D4037),
              summary:
                  'Tiny enum from dart:ui. Selects upright vs italic glyphs '
                  'when the font carries an italic axis or face.',
              members: const <String>[
                'FontStyle.normal',
                'FontStyle.italic',
              ],
              specimen: const _FontStyleSpecimen(),
            ),
            _ClassCard(
              name: 'FontWeight',
              signature: 'FontWeight.w100 .. FontWeight.w900',
              accent: const Color(0xFF6D4C41),
              summary:
                  'Discrete weight steps from thin (w100) to black (w900). '
                  '.normal == .w400, .bold == .w700.',
              members: const <String>[
                'FontWeight.w100 thin',
                'FontWeight.w400 normal',
                'FontWeight.w500 medium',
                'FontWeight.w600 semiBold',
                'FontWeight.w700 bold',
                'FontWeight.w900 black',
              ],
              specimen: const _FontWeightSpecimen(),
            ),
          ],
        ),
        const SizedBox(height: 18.0),
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.brown.shade50,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.brown.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.compare_arrows, color: Colors.brown.shade700),
                  const SizedBox(width: 6.0),
                  Text(
                    'Library boundary (dart:ui <-> flutter/painting)',
                    style: TextStyle(
                      color: Colors.brown.shade900,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: _BoundaryColumn(
                      title: 'dart:ui owns the type',
                      accent: const Color(0xFF1A237E),
                      rows: const <List<String>>[
                        <String>['Offset', 'positions, deltas'],
                        <String>['Size', 'width x height pair'],
                        <String>['Rect', 'axis-aligned rectangle'],
                        <String>['RRect', 'rounded rectangle'],
                        <String>['Radius', 'corner radii'],
                        <String>['Color', '32-bit ARGB color'],
                        <String>['Path', 'shape paths'],
                        <String>['Vertices', 'triangle meshes'],
                      ],
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _BoundaryColumn(
                      title: 'flutter/painting wraps it',
                      accent: const Color(0xFF00897B),
                      rows: const <List<String>>[
                        <String>['EdgeInsets', 'padding, margins'],
                        <String>['Alignment', 'fractional offsets'],
                        <String>['BorderRadius', 'wraps Radius x 4'],
                        <String>['Border', 'stroked edges'],
                        <String>['BoxDecoration', 'rectangular paint'],
                        <String>['Gradient', 'linear/radial/sweep'],
                        <String>['TextStyle', 'wraps FontStyle/Weight'],
                        <String>['ImageProvider', 'asset/network -> Image'],
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24.0),
      ],
    ),
  );
}

class _FontStyleSpecimen extends StatelessWidget {
  const _FontStyleSpecimen();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Text(
          'normal',
          style: TextStyle(fontSize: 22.0, fontStyle: FontStyle.normal),
        ),
        SizedBox(height: 6.0),
        Text(
          'italic',
          style: TextStyle(fontSize: 22.0, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}

class _FontWeightSpecimen extends StatelessWidget {
  const _FontWeightSpecimen();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const <Widget>[
        Text('Aa w100',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w100)),
        Text('Aa w400',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w400)),
        Text('Aa w700',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700)),
        Text('Aa w900',
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w900)),
      ],
    );
  }
}

class _BoundaryColumn extends StatelessWidget {
  final String title;
  final Color accent;
  final List<List<String>> rows;
  const _BoundaryColumn({
    required this.title,
    required this.accent,
    required this.rows,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: accent.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: accent.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: accent,
              fontWeight: FontWeight.bold,
              fontSize: 12.5,
            ),
          ),
          const SizedBox(height: 6.0),
          for (final List<String> r in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 90.0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 1.0),
                    decoration: BoxDecoration(
                      color: accent.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      r[0],
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  Expanded(
                    child: Text(r[1], style: const TextStyle(fontSize: 11.0)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 8: Decision table, recipes and glossary.
// ---------------------------------------------------------------------------
Widget _buildSection8DecisionAndGlossary() {
  print('=== Section 8: Decision table, recipes and glossary ===');
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SectionHeading(
          number: 8,
          title: 'Decision table, recipes and glossary',
          subtitle: 'Which dart:ui type to reach for, and how to combine them',
          accent: Color(0xFF37474F),
        ),
        const SizedBox(height: 12.0),
        _DecisionTable(),
        const SizedBox(height: 18.0),
        _RecipeBook(),
        const SizedBox(height: 18.0),
        _Glossary(),
        const SizedBox(height: 24.0),
      ],
    ),
  );
}

class _DecisionTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<List<String>> rows = <List<String>>[
      <String>['Represent a 2D position', 'Offset', 'positions and deltas in local coords'],
      <String>['Represent a width/height pair', 'Size', 'logical dimensions of a layout box'],
      <String>['Represent an axis-aligned rect', 'Rect', 'painting bounds, hit-test rects'],
      <String>['Round the corners of a rect', 'RRect + Radius', 'use Radius.circular for uniform'],
      <String>['Express transparency only', 'Color.withOpacity', 'NOT a separate alpha type'],
      <String>['Pick a M3 semantic color', 'ColorScheme.primary etc.', 'theme-aware swatch'],
      <String>['Build a custom shape', 'Path', 'lineTo, cubicTo, addOval, ...'],
      <String>['Combine two shapes', 'Path.combine + PathOperation', 'union, intersect, difference, xor'],
      <String>['Draw a swarm of dots', 'drawPoints + PointMode.points', 'fast batched scatter'],
      <String>['Draw connected segments', 'drawPoints + PointMode.polygon', 'single polyline'],
      <String>['Draw a colored mesh', 'Vertices + drawVertices', 'triangleStrip is usually best'],
      <String>['Snapshot a Canvas', 'PictureRecorder -> Picture', 'replayable'],
      <String>['Render to GPU', 'SceneBuilder -> Scene', 'window.render(scene)'],
      <String>['Decode an image asset', 'ImmutableBuffer -> Descriptor -> Codec', 'returns FrameInfo'],
      <String>['Iterate animated GIF frames', 'codec.getNextFrame()', 'check frame.duration'],
      <String>['Set bold + italic on a glyph', 'FontWeight + FontStyle', 'set on TextStyle'],
    ];
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey.shade50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.blueGrey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.rule, color: Colors.blueGrey.shade800),
              const SizedBox(width: 6.0),
              Text(
                'Decision table - which dart:ui type for which task',
                style: TextStyle(
                  color: Colors.blueGrey.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.blueGrey.shade200),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade800,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(7.0),
                      topRight: Radius.circular(7.0),
                    ),
                  ),
                  child: const Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Task',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            fontSize: 11.5,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          'Use',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            fontSize: 11.5,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          'Why',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.bold,
                            fontSize: 11.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                for (int i = 0; i < rows.length; i++)
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: i.isEven
                          ? Colors.white
                          : Colors.blueGrey.shade50,
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Text(
                            rows[i][0],
                            style: const TextStyle(fontSize: 11.5),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            rows[i][1],
                            style: const TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11.5,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1565C0),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Text(
                            rows[i][2],
                            style: const TextStyle(
                                fontSize: 11.0, color: Colors.black54),
                          ),
                        ),
                      ],
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

class _RecipeBook extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<_Recipe> recipes = <_Recipe>[
      _Recipe(
        title: 'Centered Rect from Size and Offset',
        code:
            'final Rect r = Rect.fromCenter(\n'
            '  center: Offset(width / 2, height / 2),\n'
            '  width: 120.0,\n'
            '  height: 80.0,\n'
            ');',
      ),
      _Recipe(
        title: 'RRect with uniform 12px corners',
        code:
            'final RRect rr = RRect.fromRectAndRadius(\n'
            '  rect,\n'
            '  const Radius.circular(12.0),\n'
            ');',
      ),
      _Recipe(
        title: 'Color with 40% opacity',
        code:
            'final Color faded = Colors.indigo.withOpacity(0.4);\n'
            '// or: Colors.indigo.withAlpha((0.4 * 255).round());',
      ),
      _Recipe(
        title: 'Path from polygon points',
        code:
            'final Path p = Path()\n'
            '  ..addPolygon(<Offset>[\n'
            '    Offset(0, 0),\n'
            '    Offset(100, 20),\n'
            '    Offset(80, 80),\n'
            '  ], true);',
      ),
      _Recipe(
        title: 'Combine two paths with union',
        code:
            'final Path c = Path.combine(\n'
            '  PathOperation.union,\n'
            '  shapeA,\n'
            '  shapeB,\n'
            ');',
      ),
      _Recipe(
        title: 'Record a Picture and replay it',
        code:
            'final r = PictureRecorder();\n'
            'final c = Canvas(r);\n'
            'c.drawCircle(Offset(50, 50), 40, paint);\n'
            'final Picture pic = r.endRecording();\n'
            'canvas.drawPicture(pic);',
      ),
      _Recipe(
        title: 'Decode an image asset',
        code:
            'final buf = await ImmutableBuffer.fromAsset(\n'
            '  "assets/cat.png",\n'
            ');\n'
            'final d = await ImageDescriptor.encoded(buf);\n'
            'final codec = await d.instantiateCodec();\n'
            'final frame = await codec.getNextFrame();\n'
            'final ui.Image img = frame.image;',
      ),
      _Recipe(
        title: 'Draw a triangle mesh strip',
        code:
            'final v = Vertices(\n'
            '  VertexMode.triangleStrip,\n'
            '  positions,\n'
            '  colors: vertexColors,\n'
            ');\n'
            'canvas.drawVertices(v, BlendMode.srcOver, paint);',
      ),
    ];
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.indigo.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.book, color: Colors.indigo.shade700),
              const SizedBox(width: 6.0),
              Text(
                'Recipe book',
                style: TextStyle(
                  color: Colors.indigo.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          Wrap(
            children: <Widget>[
              for (final _Recipe r in recipes)
                Container(
                  width: 320.0,
                  margin: const EdgeInsets.all(6.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.indigo.shade200),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        r.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                          color: Colors.indigo.shade900,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Text(
                          r.code,
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 11.0,
                            color: Colors.greenAccent.shade100,
                          ),
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
}

class _Recipe {
  final String title;
  final String code;
  _Recipe({required this.title, required this.code});
}

class _Glossary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<List<String>> entries = <List<String>>[
      <String>[
        'Offset',
        'A 2D fixed-point (dx, dy). Doubles as both an absolute position and a delta vector.',
      ],
      <String>[
        'Size',
        'A (width, height) pair. Extends OffsetBase; comparison is exact-equal on both axes.',
      ],
      <String>[
        'Rect',
        'An axis-aligned rectangle in local coordinates. Many named constructors.',
      ],
      <String>[
        'RRect',
        'A rect with up to 4 independent corner radii. Each radius is an (x, y) ellipse half-extent.',
      ],
      <String>[
        'Radius',
        'A pair (x, y) describing the half-extents of an ellipse. Used inside RRect and BorderRadius.',
      ],
      <String>[
        'RSTransform',
        'Rotation/Scale/Translate transform packed into 4 doubles, used by Canvas.drawAtlas.',
      ],
      <String>[
        'Color',
        '32-bit ARGB color, immutable. Channels accessed via .alpha/.red/.green/.blue and .opacity.',
      ],
      <String>[
        'Path',
        'A sequence of moveTo/lineTo/curveTo segments forming a 2D shape. Engine-level only.',
      ],
      <String>[
        'PathOperation',
        'Boolean op enum (union/intersect/difference/reverseDifference/xor) used by Path.combine.',
      ],
      <String>[
        'PointMode',
        'How Canvas.drawPoints interprets an Offset list: points, lines (pairs), polygon (chain).',
      ],
      <String>[
        'VertexMode',
        'How a Vertices object is triangulated: triangles, triangleStrip, triangleFan.',
      ],
      <String>[
        'Vertices',
        'A bundle of vertex positions plus optional colors/texture-coords for drawVertices.',
      ],
      <String>[
        'Picture',
        'An immutable record of canvas commands captured by a PictureRecorder.',
      ],
      <String>[
        'Scene',
        'A finished tree of layers ready to be rasterized by the engine.',
      ],
      <String>[
        'SceneBuilder',
        'Mutable builder that pushes offset/transform/opacity/clip layers and pictures.',
      ],
      <String>[
        'Image',
        'Immutable, GPU-backed raster image. Disposable via dispose().',
      ],
      <String>[
        'ImageDescriptor',
        'Metadata + factory for Codecs over an encoded image buffer.',
      ],
      <String>[
        'ImmutableBuffer',
        'A read-only byte container that holds encoded image bytes for decoders.',
      ],
      <String>[
        'Codec',
        'Iterator over the frames of an encoded image. Yields FrameInfo for each step.',
      ],
      <String>[
        'FrameInfo',
        'A (ui.Image, Duration) pair describing one frame from a Codec.',
      ],
      <String>[
        'FontStyle',
        'Italic or upright. Selects font face axis when available.',
      ],
      <String>[
        'FontWeight',
        'Thickness step from w100 (thin) to w900 (black); .normal == w400, .bold == w700.',
      ],
    ];
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.menu_book, color: Colors.grey.shade800),
              const SizedBox(width: 6.0),
              Text(
                'Glossary',
                style: TextStyle(
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          for (final List<String> e in entries)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 130.0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 2.0),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade800,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      e[0],
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      e[1],
                      style: const TextStyle(fontSize: 12.0, height: 1.3),
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

// ---------------------------------------------------------------------------
// Footer banner.
// ---------------------------------------------------------------------------
Widget _buildFooterBanner() {
  print('footer banner: rendering dart:ui class atlas footer');
  return Container(
    margin: const EdgeInsets.all(20.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[
          Color(0xFF263238),
          Color(0xFF37474F),
          Color(0xFF1A237E),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      children: <Widget>[
        const Icon(Icons.flag, size: 36.0, color: Colors.white),
        const SizedBox(height: 8.0),
        const Text(
          'End of dart:ui class atlas',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          'Mastered: geometry, color, path, primitives, picture and image pipelines, fonts.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontSize: 12.0,
          ),
        ),
      ],
    ),
  );
}
