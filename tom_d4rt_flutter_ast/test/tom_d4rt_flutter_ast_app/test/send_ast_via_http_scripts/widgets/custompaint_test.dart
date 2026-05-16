// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt test script: Deep Demo - CustomPaint Atelier from widgets
// Theme: "CustomPaint Atelier" - an artistic gallery of CustomPaint that
// exercises Canvas drawing primitives (drawLine, drawCircle, drawRect,
// drawRRect, drawOval, drawArc, drawPath, drawShadow, drawColor, drawPaint),
// Paint configuration (style, strokeWidth, strokeCap, strokeJoin, shader,
// color, blendMode), Path operations (lineTo, quadraticBezierTo, cubicTo,
// arcTo, close), gradient shaders, save/restore/transform layering, and
// creative compositions (mandalas, spirographs, gradient skies, isometric
// panels).
import 'dart:math' as math;
import 'package:flutter/material.dart';

// =============================================================================
// PALETTE CONSTANTS - one signature palette per atelier studio
// =============================================================================

const Color _atelierInk = Color(0xFF1B1B3A);
const Color _atelierInkMid = Color(0xFF2D2D5F);
const Color _atelierInkSoft = Color(0xFFB8B8D6);
const Color _atelierInkPale = Color(0xFFF4F4FB);
const Color _atelierGold = Color(0xFFD4AF37);

const Color _studioPrimStart = Color(0xFFFF6F00);
const Color _studioPrimEnd = Color(0xFFFFB300);
const Color _studioPrimSoft = Color(0xFFFFE0B2);

const Color _studioStyleStart = Color(0xFF00838F);
const Color _studioStyleEnd = Color(0xFF26C6DA);
const Color _studioStyleSoft = Color(0xFFB2EBF2);

const Color _studioPathStart = Color(0xFF4A148C);
const Color _studioPathEnd = Color(0xFF8E24AA);
const Color _studioPathSoft = Color(0xFFE1BEE7);

const Color _studioBezierStart = Color(0xFFBF360C);
const Color _studioBezierEnd = Color(0xFFFF7043);
const Color _studioBezierSoft = Color(0xFFFFCCBC);

const Color _studioGradStart = Color(0xFF1A237E);
const Color _studioGradEnd = Color(0xFF5C6BC0);
const Color _studioGradSoft = Color(0xFFC5CAE9);

const Color _studioBlendStart = Color(0xFFAD1457);
const Color _studioBlendEnd = Color(0xFFEC407A);
const Color _studioBlendSoft = Color(0xFFF8BBD0);

const Color _studioXformStart = Color(0xFF006064);
const Color _studioXformEnd = Color(0xFF00ACC1);
const Color _studioXformSoft = Color(0xFFB2EBF2);

const Color _studioShadowStart = Color(0xFF263238);
const Color _studioShadowEnd = Color(0xFF546E7A);
const Color _studioShadowSoft = Color(0xFFCFD8DC);

const Color _studioGeomStart = Color(0xFF2E7D32);
const Color _studioGeomEnd = Color(0xFF66BB6A);
const Color _studioGeomSoft = Color(0xFFC8E6C9);

const Color _studioPatternStart = Color(0xFF6A1B9A);
const Color _studioPatternEnd = Color(0xFFBA68C8);
const Color _studioPatternSoft = Color(0xFFE1BEE7);

const Color _studioRecipeStart = Color(0xFF3E2723);
const Color _studioRecipeEnd = Color(0xFF8D6E63);
const Color _studioRecipeSoft = Color(0xFFD7CCC8);

// =============================================================================
// MAIN ENTRY POINT
// =============================================================================

dynamic build(BuildContext context) {
  print('[custompaint_test] CustomPaint Atelier launching...');

  // ===========================================================================
  // SECTION 0 DATA: ATELIER OVERVIEW NARRATIVE - the layered story of how
  // CustomPaint binds a CustomPainter to a Canvas inside the render tree.
  // ===========================================================================

  final List<Map<String, String>> overviewSteps = <Map<String, String>>[
    <String, String>{
      'step': '1',
      'op': 'extends CustomPainter',
      'detail': 'Subclass and override paint + shouldRepaint',
    },
    <String, String>{
      'step': '2',
      'op': 'CustomPaint(painter:)',
      'detail': 'Mount painter inside the widget tree',
    },
    <String, String>{
      'step': '3',
      'op': 'paint(canvas, size)',
      'detail': 'Issue draw* calls against the bound canvas',
    },
    <String, String>{
      'step': '4',
      'op': 'shouldRepaint(old)',
      'detail': 'Return true only when the visual changed',
    },
    <String, String>{
      'step': '5',
      'op': 'foregroundPainter',
      'detail': 'Optional overlay painted after child',
    },
    <String, String>{
      'step': '6',
      'op': 'size: Size(w, h)',
      'detail': 'Sizing when there is no child widget',
    },
  ];

  // ===========================================================================
  // SECTION 1 DATA: CANVAS PRIMITIVES ROSTER
  // ===========================================================================

  final List<Map<String, dynamic>> primitiveRoster = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'drawRect',
      'desc': 'Filled rectangle, axis-aligned',
    },
    <String, dynamic>{
      'label': 'drawRRect',
      'desc': 'Rounded rectangle (RRect)',
    },
    <String, dynamic>{
      'label': 'drawCircle',
      'desc': 'Circle by center + radius',
    },
    <String, dynamic>{
      'label': 'drawOval',
      'desc': 'Ellipse fitted to bounding rect',
    },
    <String, dynamic>{
      'label': 'drawLine',
      'desc': 'Single straight segment',
    },
    <String, dynamic>{
      'label': 'drawArc',
      'desc': 'Arc / pie slice from bounds',
    },
  ];

  // ===========================================================================
  // SECTION 2 DATA: PAINT STYLE ROSTER
  // ===========================================================================

  final List<Map<String, dynamic>> styleRoster = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'fill',
      'style': PaintingStyle.fill,
      'stroke': 0.0,
      'color': _studioStyleStart,
    },
    <String, dynamic>{
      'label': 'stroke thin',
      'style': PaintingStyle.stroke,
      'stroke': 1.5,
      'color': _studioStyleEnd,
    },
    <String, dynamic>{
      'label': 'stroke mid',
      'style': PaintingStyle.stroke,
      'stroke': 4.0,
      'color': _studioStyleStart,
    },
    <String, dynamic>{
      'label': 'stroke heavy',
      'style': PaintingStyle.stroke,
      'stroke': 8.0,
      'color': _studioStyleEnd,
    },
  ];

  // ===========================================================================
  // SECTION 3 DATA: PATH KIND ROSTER
  // ===========================================================================

  final List<Map<String, dynamic>> pathRoster = <Map<String, dynamic>>[
    <String, dynamic>{
      'kind': 'pentagon',
      'color': _studioPathStart,
      'style': PaintingStyle.stroke,
      'stroke': 3.0,
      'caption': 'Closed polygon',
    },
    <String, dynamic>{
      'kind': 'star',
      'color': _studioPathEnd,
      'style': PaintingStyle.fill,
      'stroke': 0.0,
      'caption': 'Alternating radii',
    },
    <String, dynamic>{
      'kind': 'heart',
      'color': _studioPathStart,
      'style': PaintingStyle.fill,
      'stroke': 0.0,
      'caption': 'Two cubic lobes',
    },
    <String, dynamic>{
      'kind': 'cog',
      'color': _studioPathEnd,
      'style': PaintingStyle.stroke,
      'stroke': 2.0,
      'caption': 'Toothed wheel',
    },
  ];

  // ===========================================================================
  // SECTION 4 DATA: BEZIER ROSTER
  // ===========================================================================

  final List<Map<String, dynamic>> bezierRoster = <Map<String, dynamic>>[
    <String, dynamic>{
      'kind': 'quadratic',
      'color': _studioBezierStart,
      'caption': 'quadraticBezierTo - 1 control point',
    },
    <String, dynamic>{
      'kind': 'cubic',
      'color': _studioBezierEnd,
      'caption': 'cubicTo - 2 control points',
    },
    <String, dynamic>{
      'kind': 'arcTo',
      'color': _studioBezierStart,
      'caption': 'arcTo - arc inscribed in rect',
    },
  ];

  // ===========================================================================
  // SECTION 5 DATA: GRADIENT SHADER ROSTER
  // ===========================================================================

  final List<Map<String, dynamic>> gradientRoster = <Map<String, dynamic>>[
    <String, dynamic>{
      'kind': 'linear',
      'colors': <Color>[Color(0xFF1A237E), Color(0xFF42A5F5), Color(0xFFE3F2FD)],
      'caption': 'LinearGradient sunrise sky',
    },
    <String, dynamic>{
      'kind': 'radial',
      'colors': <Color>[Color(0xFFFFEB3B), Color(0xFFFF6F00), Color(0xFFBF360C)],
      'caption': 'RadialGradient solar flare',
    },
    <String, dynamic>{
      'kind': 'sweep',
      'colors': <Color>[
        Color(0xFFE91E63),
        Color(0xFF9C27B0),
        Color(0xFF3F51B5),
        Color(0xFF00BCD4),
        Color(0xFF4CAF50),
        Color(0xFFFFEB3B),
        Color(0xFFE91E63),
      ],
      'caption': 'SweepGradient color wheel',
    },
  ];

  // ===========================================================================
  // SECTION 6 DATA: BLEND MODE ROSTER (selected modes)
  // ===========================================================================

  final List<Map<String, dynamic>> blendRoster = <Map<String, dynamic>>[
    <String, dynamic>{
      'mode': BlendMode.srcOver,
      'name': 'srcOver',
      'desc': 'Default - source on top',
    },
    <String, dynamic>{
      'mode': BlendMode.multiply,
      'name': 'multiply',
      'desc': 'Darken overlaps',
    },
    <String, dynamic>{
      'mode': BlendMode.screen,
      'name': 'screen',
      'desc': 'Brighten overlaps',
    },
    <String, dynamic>{
      'mode': BlendMode.overlay,
      'name': 'overlay',
      'desc': 'Contrast-preserving',
    },
    <String, dynamic>{
      'mode': BlendMode.difference,
      'name': 'difference',
      'desc': 'Invert overlap',
    },
    <String, dynamic>{
      'mode': BlendMode.plus,
      'name': 'plus',
      'desc': 'Additive light',
    },
  ];

  // ===========================================================================
  // SECTION 7 DATA: TRANSFORM SCRIPT
  // ===========================================================================

  final List<Map<String, String>> transformScript = <Map<String, String>>[
    <String, String>{
      'op': 'save()',
      'note': 'Push current transform onto the stack',
    },
    <String, String>{
      'op': 'translate(cx, cy)',
      'note': 'Recenter origin at canvas midpoint',
    },
    <String, String>{
      'op': 'rotate(angle)',
      'note': 'Rotate around the moved origin',
    },
    <String, String>{
      'op': 'scale(sx, sy)',
      'note': 'Stretch / squash subsequent draws',
    },
    <String, String>{
      'op': 'drawX(...)',
      'note': 'Geometry painted under the stack',
    },
    <String, String>{
      'op': 'restore()',
      'note': 'Pop, returning to prior transform',
    },
  ];

  // ===========================================================================
  // SECTION 8 DATA: SHADOW + COMPOSITING ROSTER
  // ===========================================================================

  final List<Map<String, dynamic>> shadowRoster = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'soft drop',
      'elevation': 4.0,
      'color': Color(0xFF000000),
      'caption': 'canvas.drawShadow(path, color, 4, true)',
    },
    <String, dynamic>{
      'label': 'mid drop',
      'elevation': 8.0,
      'color': Color(0xFF1A237E),
      'caption': 'Tinted shadow at elevation 8',
    },
    <String, dynamic>{
      'label': 'deep drop',
      'elevation': 16.0,
      'color': Color(0xFF263238),
      'caption': 'Dramatic shadow, occluded=false',
    },
  ];

  // ===========================================================================
  // SECTION 9 DATA: GEOMETRIC COMPOSITION ROSTER
  // ===========================================================================

  final List<Map<String, dynamic>> geometryRoster = <Map<String, dynamic>>[
    <String, dynamic>{
      'kind': 'isometric',
      'caption': 'Isometric cube via 3 parallelograms',
    },
    <String, dynamic>{
      'kind': 'grid',
      'caption': 'Perspective grid floor',
    },
    <String, dynamic>{
      'kind': 'truss',
      'caption': 'Triangulated truss structure',
    },
  ];

  // ===========================================================================
  // SECTION 10 DATA: ARTISTIC PATTERN ROSTER
  // ===========================================================================

  final List<Map<String, dynamic>> patternRoster = <Map<String, dynamic>>[
    <String, dynamic>{
      'kind': 'mandala',
      'caption': '12-fold rotational symmetry',
    },
    <String, dynamic>{
      'kind': 'spirograph',
      'caption': 'Hypotrochoid curve',
    },
    <String, dynamic>{
      'kind': 'concentric',
      'caption': 'Concentric ripple rings',
    },
    <String, dynamic>{
      'kind': 'starburst',
      'caption': 'Radial starburst rays',
    },
  ];

  // ===========================================================================
  // SECTION 11 DATA: RECIPE CARDS
  // ===========================================================================

  final List<Map<String, String>> recipes = <Map<String, String>>[
    <String, String>{
      'title': 'Recipe: keep paint() pure',
      'body':
          'Avoid allocations and side effects inside paint(). Pre-build Paths '
              'and Paints in the constructor when possible so each frame is a '
              'pure replay.',
    },
    <String, String>{
      'title': 'Recipe: shouldRepaint discipline',
      'body':
          'Return true only when fields that affect visuals change. Compare '
              'field-by-field; never return true unconditionally - it forces '
              'a repaint every frame.',
    },
    <String, String>{
      'title': 'Recipe: balance save/restore',
      'body':
          'Every save() must be matched with restore(). Use canvas.save() / '
              'canvas.restore() blocks around any translate/rotate/scale so '
              'the transform stack stays clean.',
    },
    <String, String>{
      'title': 'Recipe: shader on paint',
      'body':
          'Set paint.shader = LinearGradient(...).createShader(rect) for '
              'gradient fills. Remember the shader is in canvas-coordinates, '
              'not paint-local.',
    },
    <String, String>{
      'title': 'Recipe: layered foregroundPainter',
      'body':
          'CustomPaint accepts painter (behind child) AND foregroundPainter '
              '(in front). Use the foreground for badges, watermarks, focus '
              'rings drawn over the content.',
    },
    <String, String>{
      'title': 'Recipe: isComplex + willChange',
      'body':
          'When you mark isComplex: true and willChange: false, Flutter may '
              'cache the layer as a raster image - great for static, expensive '
              'paintings. Combine with painter != null.',
    },
  ];

  // ===========================================================================
  // SECTION 12 DATA: GLOSSARY
  // ===========================================================================

  final List<Map<String, String>> glossary = <Map<String, String>>[
    <String, String>{
      'term': 'CustomPaint',
      'definition':
          'Widget that hosts a CustomPainter under and/or over an optional child.',
    },
    <String, String>{
      'term': 'CustomPainter',
      'definition':
          'Subclass with paint(canvas, size) + shouldRepaint(old) overrides.',
    },
    <String, String>{
      'term': 'Canvas',
      'definition':
          'Drawing surface bound by the framework; receives all draw* calls.',
    },
    <String, String>{
      'term': 'Paint',
      'definition':
          'Style descriptor: color, style, strokeWidth, cap, join, shader, blendMode.',
    },
    <String, String>{
      'term': 'Path',
      'definition':
          'Vector contour built from moveTo / lineTo / cubicTo / arcTo / close.',
    },
    <String, String>{
      'term': 'Shader',
      'definition':
          'Pixel source used by Paint - gradients, image tiles, custom programs.',
    },
    <String, String>{
      'term': 'BlendMode',
      'definition':
          'Compositing rule applied when source pixels meet destination.',
    },
  ];

  // ===========================================================================
  // SECTION 13 DATA: COMPARISON TABLES
  // ===========================================================================

  final List<List<String>> fillVsStrokeRows = <List<String>>[
    <String>['property', 'fill', 'stroke'],
    <String>['draws', 'interior', 'outline'],
    <String>['strokeWidth', 'ignored', 'required'],
    <String>['strokeCap', 'ignored', 'butt/round/square'],
    <String>['strokeJoin', 'ignored', 'miter/round/bevel'],
    <String>['common use', 'shapes/fills', 'borders/lines'],
  ];

  final List<List<String>> strokeCapRows = <List<String>>[
    <String>['cap', 'shape', 'use case'],
    <String>['butt', 'flat at endpoint', 'crisp grids, ticks'],
    <String>['round', 'half-circle past end', 'friendly thick lines'],
    <String>['square', 'half-square past end', 'chunky pixel-art look'],
  ];

  final List<List<String>> blendModeRows = <List<String>>[
    <String>['mode', 'effect', 'when to use'],
    <String>['srcOver', 'default', 'normal layering'],
    <String>['multiply', 'darken overlap', 'shadows, glazes'],
    <String>['screen', 'brighten overlap', 'highlights, lights'],
    <String>['overlay', 'contrast', 'photo blending'],
    <String>['difference', 'invert', 'glitch effects'],
    <String>['plus', 'add', 'glow / fireworks'],
  ];

  print('[custompaint_test] data prepared, building UI...');

  // ===========================================================================
  // RETURN A MaterialApp WITH THE FULL VISUAL ATLAS
  // ===========================================================================

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: _atelierInkPale,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _heroHeader(),
            const SizedBox(height: 20.0),
            _conceptOverview(overviewSteps),
            const SizedBox(height: 20.0),
            _section1Primitives(primitiveRoster),
            const SizedBox(height: 20.0),
            _section2PaintStyles(styleRoster),
            const SizedBox(height: 20.0),
            _section3PathDrawing(pathRoster),
            const SizedBox(height: 20.0),
            _section4BezierCurves(bezierRoster),
            const SizedBox(height: 20.0),
            _section5GradientShaders(gradientRoster),
            const SizedBox(height: 20.0),
            _section6BlendModes(blendRoster),
            const SizedBox(height: 20.0),
            _section7Transforms(transformScript),
            const SizedBox(height: 20.0),
            _section8Shadows(shadowRoster),
            const SizedBox(height: 20.0),
            _section9Geometry(geometryRoster),
            const SizedBox(height: 20.0),
            _section10Patterns(patternRoster),
            const SizedBox(height: 20.0),
            _section11Recipes(recipes),
            const SizedBox(height: 20.0),
            _comparisonSection(
              'Comparison: fill vs stroke',
              fillVsStrokeRows,
              _studioStyleStart,
              _studioStyleSoft,
            ),
            const SizedBox(height: 20.0),
            _comparisonSection(
              'Comparison: StrokeCap variants',
              strokeCapRows,
              _studioPrimStart,
              _studioPrimSoft,
            ),
            const SizedBox(height: 20.0),
            _comparisonSection(
              'Comparison: BlendMode samples',
              blendModeRows,
              _studioBlendStart,
              _studioBlendSoft,
            ),
            const SizedBox(height: 20.0),
            _glossarySection(glossary),
            const SizedBox(height: 20.0),
            _epilogue(),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// =============================================================================
// HERO HEADER
// =============================================================================

Widget _heroHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_atelierInk, _atelierInkMid, _studioPathStart],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: const Color(0x40000000),
          blurRadius: 12.0,
          offset: const Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: _atelierGold,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Icon(Icons.palette, color: _atelierInk, size: 28.0),
            ),
            const SizedBox(width: 14.0),
            const Expanded(
              child: Text(
                'CustomPaint Atelier',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'An artistic gallery of CustomPaint demonstrating canvas '
          'primitives, paint configuration, path operations, gradient '
          'shaders, save/restore layering, and creative compositions.',
          style: TextStyle(fontSize: 14.5, color: _atelierInkSoft, height: 1.5),
        ),
        const SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _heroChip('drawRect'),
            _heroChip('drawCircle'),
            _heroChip('drawPath'),
            _heroChip('drawArc'),
            _heroChip('drawShadow'),
            _heroChip('Gradient'),
            _heroChip('BlendMode'),
            _heroChip('save/restore'),
            _heroChip('Mandala'),
            _heroChip('Spirograph'),
          ],
        ),
        const SizedBox(height: 14.0),
        Container(
          height: 60.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: CustomPaint(painter: _HeroBannerPainter()),
        ),
      ],
    ),
  );
}

Widget _heroChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: const Color(0x33FFFFFF),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: const Color(0x55FFFFFF), width: 1.0),
    ),
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 12.0,
        color: Colors.white,
        fontFamily: 'monospace',
      ),
    ),
  );
}

// =============================================================================
// CONCEPT OVERVIEW
// =============================================================================

Widget _conceptOverview(List<Map<String, String>> steps) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _atelierInkSoft, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: _atelierInkMid,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(Icons.brush, color: Colors.white, size: 18.0),
            ),
            const SizedBox(width: 10.0),
            const Text(
              'CustomPaint Workflow',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: _atelierInk,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text(
          'CustomPaint mounts a CustomPainter into the widget tree. The '
          'painter receives a fresh Canvas + Size each frame and issues '
          'vector drawing calls. Use it for charts, badges, decorative '
          'flourishes, signature pads, and any visual the standard widgets '
          'do not cover.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 12.0),
        for (final Map<String, String> step in steps)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 28.0,
                  height: 28.0,
                  decoration: BoxDecoration(
                    color: _atelierInkMid,
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Center(
                    child: Text(
                      step['step']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        step['op']!,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: _atelierInk,
                        ),
                      ),
                      Text(
                        step['detail']!,
                        style: const TextStyle(
                          fontSize: 12.0,
                          color: Colors.black87,
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

// =============================================================================
// SECTION 1: CANVAS PRIMITIVES
// =============================================================================

Widget _section1Primitives(List<Map<String, dynamic>> roster) {
  return _studioCard(
    headerStart: _studioPrimStart,
    headerEnd: _studioPrimEnd,
    softColor: _studioPrimSoft,
    accentColor: _studioPrimEnd,
    sectionNumber: '1',
    title: 'Canvas Primitives',
    subtitle: 'drawRect / drawRRect / drawCircle / drawOval / drawLine / drawArc',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paintCanvas(height: 180.0, painter: _PrimitivesPainter()),
        const SizedBox(height: 12.0),
        Row(
          children: <Widget>[
            Expanded(
              child: _captionCard(
                height: 140.0,
                painter: _PrimitiveFocusPainter('rect'),
                title: 'drawRect',
                caption: 'Filled axis-aligned rectangle, the workhorse primitive.',
                color: _studioPrimStart,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: _captionCard(
                height: 140.0,
                painter: _PrimitiveFocusPainter('rrect'),
                title: 'drawRRect',
                caption: 'Rounded rectangle via RRect.fromRectAndRadius.',
                color: _studioPrimStart,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            Expanded(
              child: _captionCard(
                height: 140.0,
                painter: _PrimitiveFocusPainter('circle'),
                title: 'drawCircle',
                caption: 'Center + radius. Trivially smooth.',
                color: _studioPrimStart,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: _captionCard(
                height: 140.0,
                painter: _PrimitiveFocusPainter('oval'),
                title: 'drawOval',
                caption: 'Ellipse fitted to bounding rectangle.',
                color: _studioPrimStart,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            Expanded(
              child: _captionCard(
                height: 140.0,
                painter: _PrimitiveFocusPainter('line'),
                title: 'drawLine',
                caption: 'Straight segment between two offsets.',
                color: _studioPrimStart,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: _captionCard(
                height: 140.0,
                painter: _PrimitiveFocusPainter('arc'),
                title: 'drawArc',
                caption: 'Arc / pie slice, useCenter toggles wedge.',
                color: _studioPrimStart,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _legendRow(roster, _studioPrimStart),
      ],
    ),
    recipeTitle: 'Recipe: pre-build Rects',
    recipeBody:
        'Allocate Rect/RRect/Offset constants outside paint() when possible '
            '- they are value types but the construction cost adds up.',
  );
}

// =============================================================================
// SECTION 2: PAINT STYLES
// =============================================================================

Widget _section2PaintStyles(List<Map<String, dynamic>> roster) {
  return _studioCard(
    headerStart: _studioStyleStart,
    headerEnd: _studioStyleEnd,
    softColor: _studioStyleSoft,
    accentColor: _studioStyleEnd,
    sectionNumber: '2',
    title: 'Paint Styles',
    subtitle: 'PaintingStyle.fill vs stroke - thickness, cap, join',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paintCanvas(height: 160.0, painter: _PaintStylePainter(roster)),
        const SizedBox(height: 12.0),
        Row(
          children: <Widget>[
            Expanded(
              child: _captionCard(
                height: 140.0,
                painter: _StrokeCapPainter(),
                title: 'StrokeCap',
                caption: 'butt / round / square endings on thick lines.',
                color: _studioStyleStart,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: _captionCard(
                height: 140.0,
                painter: _StrokeJoinPainter(),
                title: 'StrokeJoin',
                caption: 'miter / round / bevel at path corners.',
                color: _studioStyleStart,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _comparisonTable(
          columns: const <String>['label', 'style', 'stroke'],
          headerColor: _studioStyleStart,
          rowColor: _studioStyleSoft,
          rows: <List<String>>[
            for (final Map<String, dynamic> item in roster)
              <String>[
                item['label'] as String,
                (item['style'] as PaintingStyle).name,
                (item['stroke'] as double).toStringAsFixed(1),
              ],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: cascade Paint setup',
    recipeBody:
        'final p = Paint()..color = c..style = PaintingStyle.stroke'
            '..strokeWidth = 3..strokeCap = StrokeCap.round;',
  );
}

// =============================================================================
// SECTION 3: PATH DRAWING
// =============================================================================

Widget _section3PathDrawing(List<Map<String, dynamic>> roster) {
  return _studioCard(
    headerStart: _studioPathStart,
    headerEnd: _studioPathEnd,
    softColor: _studioPathSoft,
    accentColor: _studioPathEnd,
    sectionNumber: '3',
    title: 'Path Drawing',
    subtitle: 'moveTo / lineTo / close - polygonal contours and beyond',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paintCanvas(height: 180.0, painter: _PathRosterPainter(roster)),
        const SizedBox(height: 10.0),
        for (int i = 0; i < roster.length; i++)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 14.0,
                  height: 14.0,
                  decoration: BoxDecoration(
                    color: roster[i]['color'] as Color,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  '${roster[i]['kind']}',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    roster[i]['caption'] as String,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
    recipeTitle: 'Recipe: closed polygon',
    recipeBody:
        'final p = Path()..moveTo(...)..lineTo(...)..lineTo(...)..close(); '
            'canvas.drawPath(p, paint);',
  );
}

// =============================================================================
// SECTION 4: BEZIER CURVES
// =============================================================================

Widget _section4BezierCurves(List<Map<String, dynamic>> roster) {
  return _studioCard(
    headerStart: _studioBezierStart,
    headerEnd: _studioBezierEnd,
    softColor: _studioBezierSoft,
    accentColor: _studioBezierEnd,
    sectionNumber: '4',
    title: 'Bezier Curves',
    subtitle: 'quadraticBezierTo / cubicTo / arcTo - smooth contours',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: _captionCard(
                height: 150.0,
                painter: _BezierFocusPainter('quadratic'),
                title: 'quadraticBezierTo',
                caption: 'Single control point: smooth half-arc.',
                color: _studioBezierStart,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: _captionCard(
                height: 150.0,
                painter: _BezierFocusPainter('cubic'),
                title: 'cubicTo',
                caption: 'Two control points: S-curves, wave forms.',
                color: _studioBezierStart,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            Expanded(
              child: _captionCard(
                height: 150.0,
                painter: _BezierFocusPainter('arcTo'),
                title: 'arcTo',
                caption: 'Arc inscribed in a rect, by sweep angles.',
                color: _studioBezierStart,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: _captionCard(
                height: 150.0,
                painter: _BezierFocusPainter('signature'),
                title: 'signature',
                caption: 'Chain of cubic segments - handwriting feel.',
                color: _studioBezierStart,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        for (final Map<String, dynamic> entry in roster)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 14.0,
                  height: 14.0,
                  decoration: BoxDecoration(
                    color: entry['color'] as Color,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    entry['caption'] as String,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
    recipeTitle: 'Recipe: smooth signature',
    recipeBody:
        'For ink curves, chain cubicTo segments using the previous tangent '
            'as the first control point. Pair with StrokeCap.round.',
  );
}

// =============================================================================
// SECTION 5: GRADIENT SHADERS
// =============================================================================

Widget _section5GradientShaders(List<Map<String, dynamic>> roster) {
  return _studioCard(
    headerStart: _studioGradStart,
    headerEnd: _studioGradEnd,
    softColor: _studioGradSoft,
    accentColor: _studioGradEnd,
    sectionNumber: '5',
    title: 'Gradient Shaders',
    subtitle: 'LinearGradient / RadialGradient / SweepGradient on Paint',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: _captionCard(
                height: 160.0,
                painter: _LinearGradientPainter(),
                title: 'Linear sunrise',
                caption: 'LinearGradient navy -> blue -> pale, used as shader.',
                color: _studioGradStart,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: _captionCard(
                height: 160.0,
                painter: _RadialGradientPainter(),
                title: 'Radial flare',
                caption: 'RadialGradient yellow -> orange -> deep red.',
                color: _studioGradStart,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            Expanded(
              child: _captionCard(
                height: 160.0,
                painter: _SweepGradientPainter(),
                title: 'Sweep wheel',
                caption: 'SweepGradient color wheel cycling hues.',
                color: _studioGradStart,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: _captionCard(
                height: 160.0,
                painter: _GradientSkyPainter(),
                title: 'Gradient sky',
                caption: 'Layered horizon gradients + silhouette.',
                color: _studioGradStart,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        for (final Map<String, dynamic> entry in roster)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              children: <Widget>[
                Container(
                  width: 14.0,
                  height: 14.0,
                  decoration: BoxDecoration(
                    color: (entry['colors'] as List<Color>).first,
                    borderRadius: BorderRadius.circular(3.0),
                  ),
                ),
                const SizedBox(width: 8.0),
                Text(
                  '${entry['kind']}',
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5,
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    entry['caption'] as String,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
    recipeTitle: 'Recipe: shader on Paint',
    recipeBody:
        'paint.shader = LinearGradient(colors: [...]).createShader('
            'Rect.fromLTWH(0,0,w,h));',
  );
}

// =============================================================================
// SECTION 6: BLEND MODES
// =============================================================================

Widget _section6BlendModes(List<Map<String, dynamic>> roster) {
  return _studioCard(
    headerStart: _studioBlendStart,
    headerEnd: _studioBlendEnd,
    softColor: _studioBlendSoft,
    accentColor: _studioBlendEnd,
    sectionNumber: '6',
    title: 'BlendMode Atlas',
    subtitle: 'How overlapping pixels combine - 6 selected modes',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            for (final Map<String, dynamic> entry in roster)
              SizedBox(
                width: 150.0,
                child: _captionCard(
                  height: 140.0,
                  painter: _BlendModeSamplePainter(entry['mode'] as BlendMode),
                  title: entry['name'] as String,
                  caption: entry['desc'] as String,
                  color: _studioBlendStart,
                ),
              ),
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: layer-scoped blend',
    recipeBody:
        'Wrap blended draws in saveLayer(rect, Paint()..blendMode = X) so the '
            'blend applies only to that sub-tree of geometry.',
  );
}

// =============================================================================
// SECTION 7: TRANSFORMS
// =============================================================================

Widget _section7Transforms(List<Map<String, String>> script) {
  return _studioCard(
    headerStart: _studioXformStart,
    headerEnd: _studioXformEnd,
    softColor: _studioXformSoft,
    accentColor: _studioXformEnd,
    sectionNumber: '7',
    title: 'Transform & Save/Restore',
    subtitle: 'translate / rotate / scale layered with save/restore',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: _captionCard(
                height: 170.0,
                painter: _TransformDemoPainter(),
                title: 'Translate/Rotate/Scale',
                caption: 'Same glyph drawn 5x with stacked transforms.',
                color: _studioXformStart,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: _captionCard(
                height: 170.0,
                painter: _SaveLayerPainter(),
                title: 'saveLayer',
                caption: 'Isolated layer for blend / opacity grouping.',
                color: _studioXformStart,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        for (final Map<String, String> step in script)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 3.0,
                  ),
                  decoration: BoxDecoration(
                    color: _studioXformStart,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    step['op']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    step['note']!,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
    recipeTitle: 'Recipe: balanced stack',
    recipeBody:
        'canvas.save(); canvas.translate(x, y); canvas.rotate(a); '
            'draw...; canvas.restore();',
  );
}

// =============================================================================
// SECTION 8: SHADOWS
// =============================================================================

Widget _section8Shadows(List<Map<String, dynamic>> roster) {
  return _studioCard(
    headerStart: _studioShadowStart,
    headerEnd: _studioShadowEnd,
    softColor: _studioShadowSoft,
    accentColor: _studioShadowEnd,
    sectionNumber: '8',
    title: 'Shadows & Compositing',
    subtitle: 'canvas.drawShadow + layered translucent fills',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paintCanvas(height: 200.0, painter: _ShadowRosterPainter(roster)),
        const SizedBox(height: 10.0),
        for (final Map<String, dynamic> entry in roster)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 3.0,
                  ),
                  decoration: BoxDecoration(
                    color: _studioShadowStart,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    'elev ${(entry['elevation'] as double).toStringAsFixed(0)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    entry['caption'] as String,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
    recipeTitle: 'Recipe: floating card',
    recipeBody:
        'canvas.drawShadow(path, Color(0xFF000000), elevation, transparentOccluder); '
            'canvas.drawPath(path, fillPaint);',
  );
}

// =============================================================================
// SECTION 9: GEOMETRY
// =============================================================================

Widget _section9Geometry(List<Map<String, dynamic>> roster) {
  return _studioCard(
    headerStart: _studioGeomStart,
    headerEnd: _studioGeomEnd,
    softColor: _studioGeomSoft,
    accentColor: _studioGeomEnd,
    sectionNumber: '9',
    title: 'Geometric Compositions',
    subtitle: 'Isometric cubes, perspective grids, triangulated trusses',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: _captionCard(
                height: 170.0,
                painter: _IsoCubePainter(),
                title: 'Isometric cube',
                caption: 'Three parallelograms shaded for depth.',
                color: _studioGeomStart,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: _captionCard(
                height: 170.0,
                painter: _PerspectiveGridPainter(),
                title: 'Perspective floor',
                caption: 'Vanishing point grid floor.',
                color: _studioGeomStart,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            Expanded(
              child: _captionCard(
                height: 170.0,
                painter: _TrussPainter(),
                title: 'Truss',
                caption: 'Triangulated bridge truss in monoline stroke.',
                color: _studioGeomStart,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: _captionCard(
                height: 170.0,
                painter: _HexagonGridPainter(),
                title: 'Hex grid',
                caption: 'Tessellated hexagons - honeycomb pattern.',
                color: _studioGeomStart,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        for (final Map<String, dynamic> entry in roster)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              '• ${entry['kind']}: ${entry['caption']}',
              style: const TextStyle(fontSize: 12.0),
            ),
          ),
      ],
    ),
    recipeTitle: 'Recipe: isometric math',
    recipeBody:
        'Iso projection: screen.x = (x - y) * cos(30); screen.y = (x + y) * '
            'sin(30) - z; - use it for retro-arcade tiles.',
  );
}

// =============================================================================
// SECTION 10: ARTISTIC PATTERNS
// =============================================================================

Widget _section10Patterns(List<Map<String, dynamic>> roster) {
  return _studioCard(
    headerStart: _studioPatternStart,
    headerEnd: _studioPatternEnd,
    softColor: _studioPatternSoft,
    accentColor: _studioPatternEnd,
    sectionNumber: '10',
    title: 'Artistic Patterns',
    subtitle: 'Mandalas, spirographs, ripples, starbursts',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: _captionCard(
                height: 200.0,
                painter: _MandalaPainter(),
                title: 'Mandala',
                caption: '12-fold rotational symmetry, layered petals.',
                color: _studioPatternStart,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: _captionCard(
                height: 200.0,
                painter: _SpirographPainter(),
                title: 'Spirograph',
                caption: 'Hypotrochoid - circle rolling inside circle.',
                color: _studioPatternStart,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            Expanded(
              child: _captionCard(
                height: 200.0,
                painter: _ConcentricRipplePainter(),
                title: 'Concentric ripples',
                caption: 'Translucent rings - radar / sonar feel.',
                color: _studioPatternStart,
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: _captionCard(
                height: 200.0,
                painter: _StarburstPainter(),
                title: 'Starburst',
                caption: 'Radial rays + gradient fade at edges.',
                color: _studioPatternStart,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        for (final Map<String, dynamic> entry in roster)
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              '• ${entry['kind']}: ${entry['caption']}',
              style: const TextStyle(fontSize: 12.0),
            ),
          ),
      ],
    ),
    recipeTitle: 'Recipe: rotational symmetry',
    recipeBody:
        'for (int i = 0; i < n; i++) { canvas.save(); canvas.rotate(2*pi*i/n); '
            'drawPetal(...); canvas.restore(); }',
  );
}

// =============================================================================
// SECTION 11: RECIPE CARDS
// =============================================================================

Widget _section11Recipes(List<Map<String, String>> recipes) {
  return _studioCard(
    headerStart: _studioRecipeStart,
    headerEnd: _studioRecipeEnd,
    softColor: _studioRecipeSoft,
    accentColor: _studioRecipeEnd,
    sectionNumber: '11',
    title: 'Recipe Atlas',
    subtitle: 'Patterns you reach for again and again with CustomPaint',
    body: Column(
      children: <Widget>[
        for (final Map<String, String> recipe in recipes)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: _studioRecipeSoft,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: _studioRecipeEnd, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    recipe['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: _studioRecipeStart,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    recipe['body']!,
                    style: const TextStyle(fontSize: 12.0, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
      ],
    ),
    recipeTitle: 'Recipe: build a cookbook',
    recipeBody:
        'Save your favourite paint() snippets in a personal scratch file. '
            'CustomPaint productivity scales with muscle-memory recipes.',
  );
}

// =============================================================================
// COMPARISON / GLOSSARY / EPILOGUE
// =============================================================================

Widget _comparisonSection(
  String title,
  List<List<String>> rows,
  Color headerColor,
  Color softColor,
) {
  final List<String> columns = rows.first;
  final List<List<String>> dataRows = rows.sublist(1);
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: softColor, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: headerColor,
          ),
        ),
        const SizedBox(height: 10.0),
        _comparisonTable(
          columns: columns,
          headerColor: headerColor,
          rowColor: softColor,
          rows: dataRows,
        ),
      ],
    ),
  );
}

Widget _glossarySection(List<Map<String, String>> glossary) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _atelierInkSoft, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Glossary',
          style: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
            color: _atelierInk,
          ),
        ),
        const SizedBox(height: 10.0),
        for (final Map<String, String> entry in glossary)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 130.0,
                  child: Text(
                    entry['term']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: _atelierInk,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    entry['definition']!,
                    style: const TextStyle(fontSize: 12.5, height: 1.4),
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

Widget _epilogue() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_atelierInkMid, _atelierInk, _studioPathStart],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Atelier Wrap-Up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'You toured every studio in the CustomPaint Atelier: primitive '
          'geometry, paint styling, paths and curves, gradient shaders, blend '
          'modes, transform layering, shadow compositing, geometric '
          'compositions, and artistic patterns. Reach for this script when '
          'you need a runnable cheatsheet for hand-painted Flutter UI.',
          style: TextStyle(color: Colors.white, fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        _summaryRow('Canvas primitives', 'PASS'),
        _summaryRow('Paint styles', 'PASS'),
        _summaryRow('Path drawing', 'PASS'),
        _summaryRow('Bezier curves', 'PASS'),
        _summaryRow('Gradient shaders', 'PASS'),
        _summaryRow('BlendMode atlas', 'PASS'),
        _summaryRow('Transform & save/restore', 'PASS'),
        _summaryRow('Shadows & compositing', 'PASS'),
        _summaryRow('Geometric compositions', 'PASS'),
        _summaryRow('Artistic patterns', 'PASS'),
        _summaryRow('Recipe atlas', 'PASS'),
        const SizedBox(height: 12.0),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0x33FFFFFF),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: const Text(
              'CustomPaint Atelier — All Studios Painted',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _summaryRow(String label, String status) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Row(
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 13.0),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            status,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SHARED CARD / TABLE / CANVAS HELPERS
// =============================================================================

Widget _studioCard({
  required Color headerStart,
  required Color headerEnd,
  required Color softColor,
  required Color accentColor,
  required String sectionNumber,
  required String title,
  required String subtitle,
  required Widget body,
  required String recipeTitle,
  required String recipeBody,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: softColor, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[headerStart, headerEnd],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14.0),
              topRight: Radius.circular(14.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 36.0,
                height: 36.0,
                decoration: BoxDecoration(
                  color: const Color(0x33FFFFFF),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Center(
                  child: Text(
                    sectionNumber,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
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
                      'SECTION $sectionNumber: ${title.toUpperCase()}',
                      style: const TextStyle(
                        color: Color(0xCCFFFFFF),
                        fontSize: 10.0,
                        fontFamily: 'monospace',
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                      ),
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(padding: const EdgeInsets.all(14.0), child: body),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.fromLTRB(14.0, 0.0, 14.0, 14.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: softColor,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: accentColor, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                recipeTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                  color: headerStart,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                recipeBody,
                style: const TextStyle(
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonTable({
  required List<String> columns,
  required Color headerColor,
  required Color rowColor,
  required List<List<String>> rows,
}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: headerColor, width: 1.0),
    ),
    child: Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: headerColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(7.0),
              topRight: Radius.circular(7.0),
            ),
          ),
          child: Row(
            children: <Widget>[
              for (final String col in columns)
                Expanded(
                  child: Text(
                    col,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 11.0,
                    ),
                  ),
                ),
            ],
          ),
        ),
        for (int i = 0; i < rows.length; i++)
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 5.0,
            ),
            decoration: BoxDecoration(
              color: i.isEven ? rowColor : Colors.white,
            ),
            child: Row(
              children: <Widget>[
                for (final String cell in rows[i])
                  Expanded(
                    child: Text(
                      cell,
                      style: const TextStyle(
                        fontSize: 11.0,
                        fontFamily: 'monospace',
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

Widget _paintCanvas({required double height, required CustomPainter painter}) {
  return Container(
    width: double.infinity,
    height: height,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: const Color(0xFFE0E0E0), width: 1.0),
    ),
    child: CustomPaint(painter: painter, size: Size.infinite),
  );
}

Widget _captionCard({
  required double height,
  required CustomPainter painter,
  required String title,
  required String caption,
  required Color color,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: const Color(0xFFE0E0E0), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: height,
          width: double.infinity,
          child: CustomPaint(painter: painter, size: Size.infinite),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.5,
                  color: color,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 2.0),
              Text(
                caption,
                style: const TextStyle(fontSize: 11.0, height: 1.3),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _legendRow(List<Map<String, dynamic>> roster, Color color) {
  return Wrap(
    spacing: 8.0,
    runSpacing: 6.0,
    children: <Widget>[
      for (final Map<String, dynamic> item in roster)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            '${item['label']}: ${item['desc']}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10.5,
              fontFamily: 'monospace',
            ),
          ),
        ),
    ],
  );
}

// =============================================================================
// CUSTOM PAINTERS - top-level subclasses (no Stateful/Stateless widgets)
// =============================================================================

// -----------------------------------------------------------------------------
// HERO BANNER: a quick gradient + arc flourish
// -----------------------------------------------------------------------------
class _HeroBannerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        colors: <Color>[Color(0x66D4AF37), Color(0x22FFFFFF)],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(rect);
    canvas.drawRect(rect, bg);

    final Paint stroke = Paint()
      ..color = const Color(0xCCFFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round;
    final Path wave = Path()..moveTo(0.0, size.height * 0.5);
    for (int i = 0; i < 14; i++) {
      final double x = size.width * i / 14.0;
      final double y = size.height * 0.5 +
          math.sin(i * 0.6) * size.height * 0.25;
      wave.lineTo(x, y);
    }
    canvas.drawPath(wave, stroke);

    final Paint dot = Paint()..color = const Color(0xFFD4AF37);
    for (int i = 0; i < 8; i++) {
      canvas.drawCircle(
        Offset(size.width * (i + 1) / 9.0, size.height * 0.5),
        3.0 + (i % 3) * 1.0,
        dot,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// -----------------------------------------------------------------------------
// SECTION 1: PRIMITIVES OVERVIEW (six primitives in one canvas)
// -----------------------------------------------------------------------------
class _PrimitivesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    // background tint
    final Paint bg = Paint()..color = const Color(0xFFFFF8E1);
    canvas.drawRect(Offset.zero & size, bg);

    // drawRect
    final Paint p1 = Paint()..color = _studioPrimStart;
    canvas.drawRect(Rect.fromLTWH(10.0, 10.0, 70.0, 50.0), p1);

    // drawRRect
    final Paint p2 = Paint()..color = _studioPrimEnd;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(90.0, 10.0, 70.0, 50.0),
        const Radius.circular(12.0),
      ),
      p2,
    );

    // drawCircle
    final Paint p3 = Paint()
      ..color = _studioPrimStart
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;
    canvas.drawCircle(Offset(200.0, 35.0), 22.0, p3);

    // drawOval
    final Paint p4 = Paint()
      ..color = _studioPrimEnd
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawOval(Rect.fromLTWH(240.0, 12.0, 70.0, 45.0), p4);

    // drawLine
    final Paint p5 = Paint()
      ..color = _studioPrimStart
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(10.0, h - 40.0),
      Offset(w * 0.45, h - 80.0),
      p5,
    );

    // drawArc (pie)
    final Paint p6 = Paint()..color = _studioPrimEnd;
    canvas.drawArc(
      Rect.fromLTWH(w * 0.55, h - 90.0, 70.0, 70.0),
      -math.pi / 2,
      math.pi * 1.3,
      true,
      p6,
    );

    // Labels via small ticks (no text drawn on canvas to keep stable)
    final Paint tick = Paint()
      ..color = const Color(0xFF455A64)
      ..strokeWidth = 1.0;
    for (int i = 0; i < 6; i++) {
      canvas.drawLine(
        Offset(10.0 + i * 60.0, h - 10.0),
        Offset(10.0 + i * 60.0, h - 4.0),
        tick,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// -----------------------------------------------------------------------------
// SECTION 1 FOCUS: one primitive per card
// -----------------------------------------------------------------------------
class _PrimitiveFocusPainter extends CustomPainter {
  _PrimitiveFocusPainter(this.kind);
  final String kind;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFFFF3E0);
    canvas.drawRect(Offset.zero & size, bg);

    final Paint fill = Paint()..color = _studioPrimStart;
    final Paint stroke = Paint()
      ..color = _studioPrimEnd
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double cx = size.width * 0.5;
    final double cy = size.height * 0.5;

    switch (kind) {
      case 'rect':
        canvas.drawRect(
          Rect.fromCenter(center: Offset(cx, cy), width: 80.0, height: 50.0),
          fill,
        );
        canvas.drawRect(
          Rect.fromCenter(center: Offset(cx, cy), width: 80.0, height: 50.0),
          stroke,
        );
        break;
      case 'rrect':
        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset(cx, cy), width: 90.0, height: 55.0),
            const Radius.circular(18.0),
          ),
          fill,
        );
        break;
      case 'circle':
        canvas.drawCircle(Offset(cx, cy), 32.0, fill);
        canvas.drawCircle(Offset(cx, cy), 38.0, stroke);
        break;
      case 'oval':
        canvas.drawOval(
          Rect.fromCenter(center: Offset(cx, cy), width: 100.0, height: 50.0),
          fill,
        );
        break;
      case 'line':
        canvas.drawLine(Offset(20.0, cy + 20.0), Offset(size.width - 20.0, cy - 20.0), stroke);
        canvas.drawLine(Offset(20.0, cy - 20.0), Offset(size.width - 20.0, cy + 20.0), stroke);
        break;
      case 'arc':
        canvas.drawArc(
          Rect.fromCenter(center: Offset(cx, cy), width: 80.0, height: 80.0),
          -math.pi / 2,
          math.pi * 1.5,
          true,
          fill,
        );
        break;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// -----------------------------------------------------------------------------
// SECTION 2: PAINT STYLES (fill vs stroke widths)
// -----------------------------------------------------------------------------
class _PaintStylePainter extends CustomPainter {
  _PaintStylePainter(this.roster);
  final List<Map<String, dynamic>> roster;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFE0F7FA);
    canvas.drawRect(Offset.zero & size, bg);

    final double slot = size.width / roster.length;
    for (int i = 0; i < roster.length; i++) {
      final Map<String, dynamic> item = roster[i];
      final Paint p = Paint()
        ..color = item['color'] as Color
        ..style = item['style'] as PaintingStyle
        ..strokeWidth = item['stroke'] as double;
      final double cx = slot * (i + 0.5);
      final double cy = size.height * 0.5;
      canvas.drawCircle(Offset(cx, cy), 40.0, p);
    }

    // Caption strip
    final Paint strip = Paint()..color = const Color(0x22000000);
    canvas.drawRect(
      Rect.fromLTWH(0.0, size.height - 22.0, size.width, 22.0),
      strip,
    );
  }

  @override
  bool shouldRepaint(covariant _PaintStylePainter oldDelegate) {
    return oldDelegate.roster != roster;
  }
}

// -----------------------------------------------------------------------------
// SECTION 2 EXTRA: StrokeCap variations
// -----------------------------------------------------------------------------
class _StrokeCapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFE0F7FA);
    canvas.drawRect(Offset.zero & size, bg);

    final List<StrokeCap> caps = <StrokeCap>[
      StrokeCap.butt,
      StrokeCap.round,
      StrokeCap.square,
    ];
    for (int i = 0; i < caps.length; i++) {
      final Paint p = Paint()
        ..color = i.isEven ? _studioStyleStart : _studioStyleEnd
        ..strokeWidth = 12.0
        ..strokeCap = caps[i];
      final double y = 25.0 + i * 30.0;
      canvas.drawLine(
        Offset(30.0, y),
        Offset(size.width - 30.0, y),
        p,
      );
      // baseline ticks
      final Paint tick = Paint()
        ..color = const Color(0x88000000)
        ..strokeWidth = 1.0;
      canvas.drawLine(Offset(30.0, y - 14.0), Offset(30.0, y + 14.0), tick);
      canvas.drawLine(
        Offset(size.width - 30.0, y - 14.0),
        Offset(size.width - 30.0, y + 14.0),
        tick,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// -----------------------------------------------------------------------------
// SECTION 2 EXTRA: StrokeJoin variations
// -----------------------------------------------------------------------------
class _StrokeJoinPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFE0F7FA);
    canvas.drawRect(Offset.zero & size, bg);

    final List<StrokeJoin> joins = <StrokeJoin>[
      StrokeJoin.miter,
      StrokeJoin.round,
      StrokeJoin.bevel,
    ];
    for (int i = 0; i < joins.length; i++) {
      final Paint p = Paint()
        ..color = i.isEven ? _studioStyleStart : _studioStyleEnd
        ..style = PaintingStyle.stroke
        ..strokeWidth = 8.0
        ..strokeJoin = joins[i];
      final double cx = size.width * (i + 0.5) / 3.0;
      final Path path = Path()
        ..moveTo(cx - 22.0, size.height - 30.0)
        ..lineTo(cx, 30.0)
        ..lineTo(cx + 22.0, size.height - 30.0);
      canvas.drawPath(path, p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// -----------------------------------------------------------------------------
// SECTION 3: PATH ROSTER (pentagon, star, heart, cog)
// -----------------------------------------------------------------------------
class _PathRosterPainter extends CustomPainter {
  _PathRosterPainter(this.roster);
  final List<Map<String, dynamic>> roster;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFF3E5F5);
    canvas.drawRect(Offset.zero & size, bg);

    final double slot = size.width / roster.length;
    for (int i = 0; i < roster.length; i++) {
      final Map<String, dynamic> item = roster[i];
      final String kind = item['kind'] as String;
      canvas.save();
      canvas.translate(slot * (i + 0.5), size.height * 0.5);
      final Paint p = Paint()
        ..color = item['color'] as Color
        ..style = item['style'] as PaintingStyle
        ..strokeWidth = item['stroke'] as double
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round;
      final Path path = _buildPathByKind(kind, 60.0);
      canvas.drawPath(path, p);
      canvas.restore();
    }
  }

  Path _buildPathByKind(String kind, double r) {
    final Path path = Path();
    switch (kind) {
      case 'pentagon':
        for (int i = 0; i < 5; i++) {
          final double a = -math.pi / 2 + i * 2 * math.pi / 5;
          final double x = r * math.cos(a);
          final double y = r * math.sin(a);
          if (i == 0) {
            path.moveTo(x, y);
          } else {
            path.lineTo(x, y);
          }
        }
        path.close();
        break;
      case 'star':
        for (int i = 0; i < 10; i++) {
          final double a = -math.pi / 2 + i * math.pi / 5;
          final double rad = i.isEven ? r : r * 0.45;
          final double x = rad * math.cos(a);
          final double y = rad * math.sin(a);
          if (i == 0) {
            path.moveTo(x, y);
          } else {
            path.lineTo(x, y);
          }
        }
        path.close();
        break;
      case 'heart':
        path.moveTo(0.0, r * 0.6);
        path.cubicTo(
          -r * 1.4, -r * 0.4,
          -r * 0.6, -r * 1.1,
          0.0, -r * 0.2,
        );
        path.cubicTo(
          r * 0.6, -r * 1.1,
          r * 1.4, -r * 0.4,
          0.0, r * 0.6,
        );
        path.close();
        break;
      case 'cog':
        const int teeth = 10;
        for (int i = 0; i < teeth * 2; i++) {
          final double a = i * math.pi / teeth;
          final double rad = i.isEven ? r : r * 0.7;
          final double x = rad * math.cos(a);
          final double y = rad * math.sin(a);
          if (i == 0) {
            path.moveTo(x, y);
          } else {
            path.lineTo(x, y);
          }
        }
        path.close();
        break;
    }
    return path;
  }

  @override
  bool shouldRepaint(covariant _PathRosterPainter oldDelegate) {
    return oldDelegate.roster != roster;
  }
}

// -----------------------------------------------------------------------------
// SECTION 4: BEZIER FOCUS (quadratic, cubic, arcTo, signature)
// -----------------------------------------------------------------------------
class _BezierFocusPainter extends CustomPainter {
  _BezierFocusPainter(this.kind);
  final String kind;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFFFCCBC);
    canvas.drawRect(Offset.zero & size, bg);

    final Paint curve = Paint()
      ..color = _studioBezierStart
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..strokeCap = StrokeCap.round;
    final Paint helper = Paint()
      ..color = const Color(0x88BF360C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    final Paint anchor = Paint()..color = _studioBezierEnd;

    final double w = size.width;
    final double h = size.height;
    final Path path = Path();
    switch (kind) {
      case 'quadratic':
        final Offset a = Offset(20.0, h - 25.0);
        final Offset c = Offset(w * 0.5, 10.0);
        final Offset b = Offset(w - 20.0, h - 25.0);
        path.moveTo(a.dx, a.dy);
        path.quadraticBezierTo(c.dx, c.dy, b.dx, b.dy);
        canvas.drawLine(a, c, helper);
        canvas.drawLine(c, b, helper);
        canvas.drawCircle(c, 4.0, anchor);
        canvas.drawCircle(a, 3.0, anchor);
        canvas.drawCircle(b, 3.0, anchor);
        break;
      case 'cubic':
        final Offset a = Offset(20.0, h - 20.0);
        final Offset c1 = Offset(w * 0.3, 0.0);
        final Offset c2 = Offset(w * 0.7, h);
        final Offset b = Offset(w - 20.0, 20.0);
        path.moveTo(a.dx, a.dy);
        path.cubicTo(c1.dx, c1.dy, c2.dx, c2.dy, b.dx, b.dy);
        canvas.drawLine(a, c1, helper);
        canvas.drawLine(c2, b, helper);
        canvas.drawCircle(c1, 4.0, anchor);
        canvas.drawCircle(c2, 4.0, anchor);
        canvas.drawCircle(a, 3.0, anchor);
        canvas.drawCircle(b, 3.0, anchor);
        break;
      case 'arcTo':
        final Rect r = Rect.fromCenter(
          center: Offset(w * 0.5, h * 0.5),
          width: w * 0.7,
          height: h * 0.65,
        );
        path.moveTo(r.left, r.center.dy);
        path.arcTo(r, math.pi, math.pi, false);
        canvas.drawRect(r, helper);
        break;
      case 'signature':
        path.moveTo(15.0, h * 0.7);
        path.cubicTo(
          w * 0.2, h * 0.1,
          w * 0.35, h * 1.2,
          w * 0.5, h * 0.5,
        );
        path.cubicTo(
          w * 0.65, h * -0.2,
          w * 0.85, h * 1.1,
          w - 15.0, h * 0.4,
        );
        break;
    }
    canvas.drawPath(path, curve);
  }

  @override
  bool shouldRepaint(covariant _BezierFocusPainter oldDelegate) {
    return oldDelegate.kind != kind;
  }
}

// -----------------------------------------------------------------------------
// SECTION 5: GRADIENT PAINTERS
// -----------------------------------------------------------------------------
class _LinearGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint p = Paint()
      ..shader = const LinearGradient(
        colors: <Color>[
          Color(0xFF1A237E),
          Color(0xFF42A5F5),
          Color(0xFFE3F2FD),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(rect);
    canvas.drawRect(rect, p);

    // Sun disc
    final Paint sun = Paint()..color = const Color(0xFFFFEB3B);
    canvas.drawCircle(Offset(size.width * 0.75, size.height * 0.3), 20.0, sun);

    // Horizon line
    final Paint horizon = Paint()
      ..color = const Color(0xFF1A237E)
      ..strokeWidth = 2.0;
    canvas.drawLine(
      Offset(0.0, size.height * 0.7),
      Offset(size.width, size.height * 0.7),
      horizon,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RadialGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint bg = Paint()..color = const Color(0xFF1A0033);
    canvas.drawRect(rect, bg);

    final Paint p = Paint()
      ..shader = RadialGradient(
        colors: const <Color>[
          Color(0xFFFFEB3B),
          Color(0xFFFF6F00),
          Color(0xFFBF360C),
          Color(0x001A0033),
        ],
        stops: const <double>[0.0, 0.4, 0.7, 1.0],
      ).createShader(rect);
    canvas.drawRect(rect, p);

    // Rays
    final Paint ray = Paint()
      ..color = const Color(0x55FFEB3B)
      ..strokeWidth = 1.0;
    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    for (int i = 0; i < 12; i++) {
      final double a = i * math.pi / 6;
      canvas.drawLine(
        center,
        center + Offset(math.cos(a) * size.width, math.sin(a) * size.height),
        ray,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SweepGradientPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint bg = Paint()..color = const Color(0xFFFAFAFA);
    canvas.drawRect(rect, bg);

    final Offset center = Offset(size.width * 0.5, size.height * 0.5);
    final double radius = math.min(size.width, size.height) * 0.4;

    final Paint p = Paint()
      ..shader = const SweepGradient(
        colors: <Color>[
          Color(0xFFE91E63),
          Color(0xFF9C27B0),
          Color(0xFF3F51B5),
          Color(0xFF00BCD4),
          Color(0xFF4CAF50),
          Color(0xFFFFEB3B),
          Color(0xFFE91E63),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, p);

    // Hub
    final Paint hub = Paint()..color = const Color(0xFFFAFAFA);
    canvas.drawCircle(center, radius * 0.35, hub);
    final Paint hubBorder = Paint()
      ..color = const Color(0xFF424242)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(center, radius * 0.35, hubBorder);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GradientSkyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    // Sky
    final Paint sky = Paint()
      ..shader = const LinearGradient(
        colors: <Color>[
          Color(0xFFFF7043),
          Color(0xFFFFB300),
          Color(0xFFFFD54F),
          Color(0xFFE1BEE7),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(rect);
    canvas.drawRect(rect, sky);

    // Sun
    final double sunY = size.height * 0.55;
    final Paint sun = Paint()..color = const Color(0xFFFFF176);
    canvas.drawCircle(Offset(size.width * 0.5, sunY), 22.0, sun);

    // Mountain silhouettes
    final Paint mtn1 = Paint()..color = const Color(0xCC4A148C);
    final Path m1 = Path()
      ..moveTo(0.0, size.height)
      ..lineTo(size.width * 0.2, size.height * 0.65)
      ..lineTo(size.width * 0.4, size.height * 0.85)
      ..lineTo(size.width * 0.6, size.height * 0.6)
      ..lineTo(size.width * 0.85, size.height * 0.8)
      ..lineTo(size.width, size.height * 0.7)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(m1, mtn1);

    final Paint mtn2 = Paint()..color = const Color(0xFF1A237E);
    final Path m2 = Path()
      ..moveTo(0.0, size.height)
      ..lineTo(size.width * 0.15, size.height * 0.78)
      ..lineTo(size.width * 0.35, size.height * 0.92)
      ..lineTo(size.width * 0.55, size.height * 0.75)
      ..lineTo(size.width * 0.8, size.height * 0.9)
      ..lineTo(size.width, size.height * 0.82)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(m2, mtn2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// -----------------------------------------------------------------------------
// SECTION 6: BLEND MODE SAMPLE - two overlapping circles with a given mode
// -----------------------------------------------------------------------------
class _BlendModeSamplePainter extends CustomPainter {
  _BlendModeSamplePainter(this.mode);
  final BlendMode mode;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFFFF1F1);
    canvas.drawRect(Offset.zero & size, bg);

    // saveLayer so blend modes compose against transparent backdrop
    final Rect bounds = Offset.zero & size;
    canvas.saveLayer(bounds, Paint());

    final Paint a = Paint()..color = const Color(0xFFE91E63);
    final Paint b = Paint()
      ..color = const Color(0xFF3F51B5)
      ..blendMode = mode;

    final double cx = size.width * 0.5;
    final double cy = size.height * 0.5;
    canvas.drawCircle(Offset(cx - 18.0, cy), 30.0, a);
    canvas.drawCircle(Offset(cx + 18.0, cy), 30.0, b);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _BlendModeSamplePainter oldDelegate) {
    return oldDelegate.mode != mode;
  }
}

// -----------------------------------------------------------------------------
// SECTION 7: TRANSFORM DEMO (translate/rotate/scale stack)
// -----------------------------------------------------------------------------
class _TransformDemoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFE0F2F1);
    canvas.drawRect(Offset.zero & size, bg);

    // grid
    final Paint grid = Paint()
      ..color = const Color(0xFFB2DFDB)
      ..strokeWidth = 1.0;
    for (double x = 0.0; x <= size.width; x += 20.0) {
      canvas.drawLine(Offset(x, 0.0), Offset(x, size.height), grid);
    }
    for (double y = 0.0; y <= size.height; y += 20.0) {
      canvas.drawLine(Offset(0.0, y), Offset(size.width, y), grid);
    }

    final Paint glyph = Paint()..color = _studioXformStart;

    // Base glyph
    canvas.drawRect(const Rect.fromLTWH(10.0, 10.0, 30.0, 22.0), glyph);

    // Translated
    canvas.save();
    canvas.translate(80.0, 20.0);
    canvas.drawRect(const Rect.fromLTWH(0.0, 0.0, 30.0, 22.0), glyph);
    canvas.restore();

    // Rotated
    canvas.save();
    canvas.translate(size.width * 0.6, 30.0);
    canvas.rotate(0.5);
    canvas.drawRect(const Rect.fromLTWH(0.0, 0.0, 30.0, 22.0), glyph);
    canvas.restore();

    // Scaled
    canvas.save();
    canvas.translate(30.0, size.height * 0.6);
    canvas.scale(1.6, 1.0);
    canvas.drawRect(const Rect.fromLTWH(0.0, 0.0, 30.0, 22.0), glyph);
    canvas.restore();

    // Combined (rotate + scale)
    canvas.save();
    canvas.translate(size.width * 0.65, size.height * 0.7);
    canvas.rotate(-0.6);
    canvas.scale(1.4);
    final Paint hot = Paint()..color = _studioXformEnd;
    canvas.drawRect(const Rect.fromLTWH(0.0, 0.0, 30.0, 22.0), hot);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// -----------------------------------------------------------------------------
// SECTION 7 EXTRA: saveLayer demonstration
// -----------------------------------------------------------------------------
class _SaveLayerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFE0F2F1);
    canvas.drawRect(Offset.zero & size, bg);

    final Rect layerRect = Rect.fromLTWH(20.0, 20.0, size.width - 40.0, size.height - 40.0);

    // Outline of the layer region
    final Paint outline = Paint()
      ..color = _studioXformStart
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawRect(layerRect, outline);

    // saveLayer with opacity paint
    final Paint layerPaint = Paint()..color = const Color(0x88FFFFFF);
    canvas.saveLayer(layerRect, layerPaint);

    final Paint c1 = Paint()..color = _studioXformStart;
    canvas.drawCircle(layerRect.center - const Offset(20.0, 0.0), 35.0, c1);
    final Paint c2 = Paint()..color = _studioXformEnd;
    canvas.drawCircle(layerRect.center + const Offset(20.0, 0.0), 35.0, c2);

    canvas.restore();

    // Decorations outside the layer
    final Paint dot = Paint()..color = _atelierGold;
    for (int i = 0; i < 6; i++) {
      canvas.drawCircle(
        Offset(20.0 + i * 12.0, 10.0),
        3.0,
        dot,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// -----------------------------------------------------------------------------
// SECTION 8: SHADOW ROSTER (drawShadow at multiple elevations)
// -----------------------------------------------------------------------------
class _ShadowRosterPainter extends CustomPainter {
  _ShadowRosterPainter(this.roster);
  final List<Map<String, dynamic>> roster;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFECEFF1);
    canvas.drawRect(Offset.zero & size, bg);

    final double slot = size.width / roster.length;
    for (int i = 0; i < roster.length; i++) {
      final Map<String, dynamic> item = roster[i];
      final double cx = slot * (i + 0.5);
      final double cy = size.height * 0.5;
      final Rect r = Rect.fromCenter(
        center: Offset(cx, cy),
        width: 70.0,
        height: 50.0,
      );
      final Path path = Path()
        ..addRRect(RRect.fromRectAndRadius(r, const Radius.circular(8.0)));
      canvas.drawShadow(
        path,
        item['color'] as Color,
        item['elevation'] as double,
        true,
      );
      final Paint fill = Paint()..color = Colors.white;
      canvas.drawPath(path, fill);
      final Paint border = Paint()
        ..color = _studioShadowStart
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawPath(path, border);
    }
  }

  @override
  bool shouldRepaint(covariant _ShadowRosterPainter oldDelegate) {
    return oldDelegate.roster != roster;
  }
}

// -----------------------------------------------------------------------------
// SECTION 9: GEOMETRY PAINTERS
// -----------------------------------------------------------------------------
class _IsoCubePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFE8F5E9);
    canvas.drawRect(Offset.zero & size, bg);

    final double cx = size.width * 0.5;
    final double cy = size.height * 0.55;
    final double s = 35.0;
    // Iso projection vectors
    final Offset rightVec = Offset(math.cos(-math.pi / 6) * s, math.sin(-math.pi / 6) * s);
    final Offset leftVec = Offset(math.cos(-math.pi * 5 / 6) * s, math.sin(-math.pi * 5 / 6) * s);
    final Offset upVec = const Offset(0.0, -1.0) * s;

    final Offset center = Offset(cx, cy);
    final Offset top = center + upVec * 2;
    final Offset topR = top + rightVec;
    final Offset topL = top + leftVec;
    final Offset topF = top + rightVec + leftVec;
    final Offset bot = center;
    final Offset botR = bot + rightVec;
    final Offset botL = bot + leftVec;

    // Top face (light)
    final Paint topFace = Paint()..color = _studioGeomEnd;
    final Path topPath = Path()
      ..moveTo(top.dx, top.dy)
      ..lineTo(topR.dx, topR.dy)
      ..lineTo(topF.dx, topF.dy)
      ..lineTo(topL.dx, topL.dy)
      ..close();
    canvas.drawPath(topPath, topFace);

    // Right face (mid)
    final Paint rightFace = Paint()..color = _studioGeomStart;
    final Path rightPath = Path()
      ..moveTo(top.dx, top.dy)
      ..lineTo(topR.dx, topR.dy)
      ..lineTo(botR.dx, botR.dy)
      ..lineTo(bot.dx, bot.dy)
      ..close();
    canvas.drawPath(rightPath, rightFace);

    // Left face (dark)
    final Paint leftFace = Paint()..color = const Color(0xFF1B5E20);
    final Path leftPath = Path()
      ..moveTo(top.dx, top.dy)
      ..lineTo(topL.dx, topL.dy)
      ..lineTo(botL.dx, botL.dy)
      ..lineTo(bot.dx, bot.dy)
      ..close();
    canvas.drawPath(leftPath, leftFace);

    // Outline
    final Paint outline = Paint()
      ..color = const Color(0xFF1B5E20)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawPath(topPath, outline);
    canvas.drawPath(rightPath, outline);
    canvas.drawPath(leftPath, outline);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PerspectiveGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        colors: <Color>[Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    final double vpY = size.height * 0.35;
    final double vpX = size.width * 0.5;
    final double baseY = size.height - 10.0;

    final Paint line = Paint()
      ..color = _studioGeomStart
      ..strokeWidth = 1.0;

    // Horizon
    final Paint horizon = Paint()
      ..color = _studioGeomStart
      ..strokeWidth = 2.0;
    canvas.drawLine(Offset(0.0, vpY), Offset(size.width, vpY), horizon);

    // Receding lines
    for (int i = -8; i <= 8; i++) {
      final double startX = vpX + i * 30.0;
      canvas.drawLine(Offset(startX, baseY), Offset(vpX, vpY), line);
    }

    // Transverse lines (closer to viewer get further apart)
    for (int row = 1; row <= 8; row++) {
      final double t = row / 8.0;
      final double y = vpY + (baseY - vpY) * (t * t);
      canvas.drawLine(Offset(0.0, y), Offset(size.width, y), line);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TrussPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFE8F5E9);
    canvas.drawRect(Offset.zero & size, bg);

    final double w = size.width;
    final double h = size.height;
    final double topY = h * 0.3;
    final double botY = h * 0.7;
    const int bays = 6;

    final Paint stroke = Paint()
      ..color = _studioGeomStart
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Chords
    canvas.drawLine(Offset(10.0, topY), Offset(w - 10.0, topY), stroke);
    canvas.drawLine(Offset(10.0, botY), Offset(w - 10.0, botY), stroke);

    // Verticals + diagonals
    final double bayW = (w - 20.0) / bays;
    for (int i = 0; i <= bays; i++) {
      final double x = 10.0 + i * bayW;
      canvas.drawLine(Offset(x, topY), Offset(x, botY), stroke);
    }
    for (int i = 0; i < bays; i++) {
      final double x1 = 10.0 + i * bayW;
      final double x2 = 10.0 + (i + 1) * bayW;
      if (i.isEven) {
        canvas.drawLine(Offset(x1, topY), Offset(x2, botY), stroke);
      } else {
        canvas.drawLine(Offset(x1, botY), Offset(x2, topY), stroke);
      }
    }

    // Joints
    final Paint joint = Paint()..color = _studioGeomEnd;
    for (int i = 0; i <= bays; i++) {
      final double x = 10.0 + i * bayW;
      canvas.drawCircle(Offset(x, topY), 3.5, joint);
      canvas.drawCircle(Offset(x, botY), 3.5, joint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _HexagonGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFE8F5E9);
    canvas.drawRect(Offset.zero & size, bg);

    const double r = 16.0;
    final double dx = r * math.sqrt(3.0);
    final double dy = r * 1.5;

    final Paint fill = Paint()..color = _studioGeomSoft;
    final Paint stroke = Paint()
      ..color = _studioGeomStart
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    for (int row = 0; row * dy < size.height + dy; row++) {
      final double y = row * dy + r;
      final double offsetX = (row.isOdd) ? dx / 2 : 0.0;
      for (int col = 0; col * dx < size.width + dx; col++) {
        final double cx = col * dx + offsetX + r;
        final Path hex = Path();
        for (int i = 0; i < 6; i++) {
          final double a = math.pi / 3 * i - math.pi / 2;
          final double px = cx + r * math.cos(a);
          final double py = y + r * math.sin(a);
          if (i == 0) {
            hex.moveTo(px, py);
          } else {
            hex.lineTo(px, py);
          }
        }
        hex.close();
        canvas.drawPath(hex, fill);
        canvas.drawPath(hex, stroke);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// -----------------------------------------------------------------------------
// SECTION 10: ARTISTIC PATTERN PAINTERS
// -----------------------------------------------------------------------------
class _MandalaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFF3E5F5);
    canvas.drawRect(Offset.zero & size, bg);

    final double cx = size.width * 0.5;
    final double cy = size.height * 0.5;
    final double r = math.min(size.width, size.height) * 0.45;

    canvas.save();
    canvas.translate(cx, cy);

    // outer ring
    final Paint ring = Paint()
      ..color = _studioPatternStart
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawCircle(Offset.zero, r, ring);
    canvas.drawCircle(Offset.zero, r * 0.7, ring);
    canvas.drawCircle(Offset.zero, r * 0.4, ring);

    const int petals = 12;
    for (int i = 0; i < petals; i++) {
      canvas.save();
      canvas.rotate(2 * math.pi * i / petals);
      final Paint petal = Paint()
        ..color = (i.isEven ? _studioPatternStart : _studioPatternEnd).withOpacity(0.7)
        ..style = PaintingStyle.fill;
      final Path p = Path()
        ..moveTo(0.0, 0.0)
        ..quadraticBezierTo(r * 0.2, -r * 0.3, 0.0, -r * 0.7)
        ..quadraticBezierTo(-r * 0.2, -r * 0.3, 0.0, 0.0)
        ..close();
      canvas.drawPath(p, petal);
      final Paint petalEdge = Paint()
        ..color = _atelierInk
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawPath(p, petalEdge);
      canvas.restore();
    }

    // Inner star
    final Paint inner = Paint()..color = _atelierGold;
    final Path star = Path();
    for (int i = 0; i < 16; i++) {
      final double a = -math.pi / 2 + i * math.pi / 8;
      final double rad = i.isEven ? r * 0.3 : r * 0.12;
      final double x = rad * math.cos(a);
      final double y = rad * math.sin(a);
      if (i == 0) {
        star.moveTo(x, y);
      } else {
        star.lineTo(x, y);
      }
    }
    star.close();
    canvas.drawPath(star, inner);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _SpirographPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = const Color(0xFFF3E5F5);
    canvas.drawRect(Offset.zero & size, bg);

    final double cx = size.width * 0.5;
    final double cy = size.height * 0.5;
    final double R = math.min(size.width, size.height) * 0.4;
    const double r = 17.0;
    const double d = 30.0;

    final Path path = Path();
    bool first = true;
    for (int i = 0; i <= 720; i++) {
      final double t = i * math.pi / 180;
      final double x = (R - r) * math.cos(t) + d * math.cos((R - r) / r * t);
      final double y = (R - r) * math.sin(t) - d * math.sin((R - r) / r * t);
      final double px = cx + x;
      final double py = cy + y;
      if (first) {
        path.moveTo(px, py);
        first = false;
      } else {
        path.lineTo(px, py);
      }
    }

    final Paint stroke = Paint()
      ..color = _studioPatternStart
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, stroke);

    final Paint outer = Paint()
      ..color = const Color(0x44BA68C8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawCircle(Offset(cx, cy), R, outer);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ConcentricRipplePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = const RadialGradient(
        colors: <Color>[Color(0xFF1A237E), Color(0xFF000000)],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    final double cx = size.width * 0.5;
    final double cy = size.height * 0.5;
    final double maxR = math.min(size.width, size.height) * 0.5;
    const int rings = 9;
    for (int i = 0; i < rings; i++) {
      final double t = i / (rings - 1);
      final double r = maxR * (0.15 + t * 0.85);
      final Paint p = Paint()
        ..color = Color.fromRGBO(
          (0xBA + (0xFF - 0xBA) * (1 - t)).toInt(),
          (0x68 + (0xFF - 0x68) * (1 - t)).toInt(),
          (0xC8 + (0xFF - 0xC8) * (1 - t)).toInt(),
          1.0 - t * 0.85,
        )
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;
      canvas.drawCircle(Offset(cx, cy), r, p);
    }

    // Center pulse
    final Paint pulse = Paint()..color = const Color(0xFFFFEB3B);
    canvas.drawCircle(Offset(cx, cy), 6.0, pulse);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StarburstPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint bg = Paint()
      ..shader = const RadialGradient(
        colors: <Color>[Color(0xFFFFFFFF), Color(0xFFF3E5F5), Color(0xFF6A1B9A)],
        stops: <double>[0.0, 0.5, 1.0],
      ).createShader(rect);
    canvas.drawRect(rect, bg);

    final double cx = size.width * 0.5;
    final double cy = size.height * 0.5;
    final double rMax = math.min(size.width, size.height) * 0.45;

    canvas.save();
    canvas.translate(cx, cy);
    const int rays = 36;
    for (int i = 0; i < rays; i++) {
      final double a = i * 2 * math.pi / rays;
      final Paint p = Paint()
        ..color = (i.isEven ? _studioPatternStart : _studioPatternEnd).withOpacity(0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = i.isEven ? 2.0 : 1.0
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(
        Offset.zero,
        Offset(math.cos(a) * rMax, math.sin(a) * rMax),
        p,
      );
    }
    canvas.restore();

    // central jewel
    final Paint jewel = Paint()..color = _atelierGold;
    canvas.drawCircle(Offset(cx, cy), 14.0, jewel);
    final Paint jewelEdge = Paint()
      ..color = _atelierInk
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(Offset(cx, cy), 14.0, jewelEdge);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
