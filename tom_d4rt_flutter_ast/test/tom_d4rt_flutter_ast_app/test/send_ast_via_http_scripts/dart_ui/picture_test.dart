// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element
// D4rt test script: Deep Demo - Picture Recorder Studio from dart:ui
// Theme: "Picture Recorder Studio" - a workshop tour of how Flutter records,
// composes, and replays vector drawings via PictureRecorder, Canvas, Paint and
// Path. Every section paints something real with CustomPainter so reviewers can
// see the API surface in action instead of merely reading about it.
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// =============================================================================
// PALETTE CONSTANTS - one signature palette per workshop bench
// =============================================================================

const Color _inkDeep = Color(0xFF1A237E);
const Color _inkMid = Color(0xFF303F9F);
const Color _inkSoft = Color(0xFFC5CAE9);
const Color _inkPale = Color(0xFFE8EAF6);

const Color _benchRectStart = Color(0xFFB71C1C);
const Color _benchRectEnd = Color(0xFFF44336);
const Color _benchRectSoft = Color(0xFFFFCDD2);

const Color _benchCircleStart = Color(0xFF1565C0);
const Color _benchCircleEnd = Color(0xFF42A5F5);
const Color _benchCircleSoft = Color(0xFFBBDEFB);

const Color _benchOvalStart = Color(0xFF6A1B9A);
const Color _benchOvalEnd = Color(0xFFAB47BC);
const Color _benchOvalSoft = Color(0xFFE1BEE7);

const Color _benchLineStart = Color(0xFF2E7D32);
const Color _benchLineEnd = Color(0xFF66BB6A);
const Color _benchLineSoft = Color(0xFFC8E6C9);

const Color _benchArcStart = Color(0xFFE65100);
const Color _benchArcEnd = Color(0xFFFFB74D);
const Color _benchArcSoft = Color(0xFFFFE0B2);

const Color _benchPathStart = Color(0xFF00695C);
const Color _benchPathEnd = Color(0xFF26A69A);
const Color _benchPathSoft = Color(0xFFB2DFDB);

const Color _benchPaintStart = Color(0xFF4527A0);
const Color _benchPaintEnd = Color(0xFF7E57C2);
const Color _benchPaintSoft = Color(0xFFD1C4E9);

const Color _benchTransformStart = Color(0xFFAD1457);
const Color _benchTransformEnd = Color(0xFFEC407A);
const Color _benchTransformSoft = Color(0xFFF8BBD0);

const Color _benchCloseStart = Color(0xFF263238);
const Color _benchCloseEnd = Color(0xFF546E7A);
const Color _benchCloseSoft = Color(0xFFCFD8DC);

// =============================================================================
// MAIN ENTRY POINT
// =============================================================================

dynamic build(BuildContext context) {
  print('[picture_test] Picture Recorder Studio launching...');

  // ===========================================================================
  // SECTION 0: PICTURE RECORDER WORKFLOW NARRATIVE - we exercise the actual
  // PictureRecorder + Canvas + Picture trio once at the top so the rest of the
  // demo can refer back to the values we capture here.
  // ===========================================================================

  final ui.PictureRecorder workshopRecorder = ui.PictureRecorder();
  final bool recordingBefore = workshopRecorder.isRecording;
  final Canvas workshopCanvas = Canvas(workshopRecorder);

  final Paint bannerFill = Paint()
    ..color = _benchRectEnd
    ..style = PaintingStyle.fill;
  workshopCanvas.drawRect(
    Rect.fromLTWH(4.0, 4.0, 60.0, 40.0),
    bannerFill,
  );

  final Paint bannerStroke = Paint()
    ..color = _benchCircleStart
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;
  workshopCanvas.drawCircle(const Offset(40.0, 40.0), 18.0, bannerStroke);

  final ui.Picture workshopPicture = workshopRecorder.endRecording();
  final bool recordingAfter = workshopRecorder.isRecording;
  final String pictureType = workshopPicture.runtimeType.toString();
  final String canvasType = workshopCanvas.runtimeType.toString();
  final String recorderType = workshopRecorder.runtimeType.toString();

  final List<Map<String, String>> workflowSteps = <Map<String, String>>[
    <String, String>{
      'step': '1',
      'op': 'PictureRecorder()',
      'detail': 'Allocates a recording surface',
    },
    <String, String>{
      'step': '2',
      'op': 'Canvas(recorder)',
      'detail': 'Binds a canvas to that recorder',
    },
    <String, String>{
      'step': '3',
      'op': 'canvas.drawX(...)',
      'detail': 'Queues vector ops into the recorder',
    },
    <String, String>{
      'step': '4',
      'op': 'recorder.endRecording()',
      'detail': 'Materializes an immutable Picture',
    },
    <String, String>{
      'step': '5',
      'op': 'picture.toImage(w, h)',
      'detail': 'Rasterizes (async) into a ui.Image',
    },
    <String, String>{
      'step': '6',
      'op': 'picture.dispose()',
      'detail': 'Releases the native handle',
    },
  ];

  // ===========================================================================
  // SECTION 1: drawRect / drawRRect ROSTER - record sample geometry data the
  // CustomPainter will replay. The painter itself lives at module scope.
  // ===========================================================================

  final List<Map<String, dynamic>> rectRoster = <Map<String, dynamic>>[
    <String, dynamic>{
      'label': 'Solid fill',
      'rect': const Rect.fromLTWH(8.0, 8.0, 60.0, 40.0),
      'color': _benchRectEnd,
      'style': PaintingStyle.fill,
      'stroke': 0.0,
    },
    <String, dynamic>{
      'label': 'Stroked',
      'rect': const Rect.fromLTWH(80.0, 8.0, 60.0, 40.0),
      'color': _benchRectStart,
      'style': PaintingStyle.stroke,
      'stroke': 3.0,
    },
    <String, dynamic>{
      'label': 'Rounded',
      'rect': const Rect.fromLTWH(8.0, 60.0, 60.0, 40.0),
      'color': _benchRectEnd,
      'style': PaintingStyle.fill,
      'stroke': 0.0,
      'radius': 10.0,
    },
    <String, dynamic>{
      'label': 'Outline',
      'rect': const Rect.fromLTWH(80.0, 60.0, 60.0, 40.0),
      'color': _benchRectStart,
      'style': PaintingStyle.stroke,
      'stroke': 4.0,
      'radius': 14.0,
    },
  ];

  // ===========================================================================
  // SECTION 2: drawCircle ROSTER
  // ===========================================================================

  final List<Map<String, dynamic>> circleRoster = <Map<String, dynamic>>[
    <String, dynamic>{
      'cx': 30.0,
      'cy': 50.0,
      'r': 20.0,
      'color': _benchCircleStart,
      'style': PaintingStyle.fill,
      'stroke': 0.0,
    },
    <String, dynamic>{
      'cx': 80.0,
      'cy': 50.0,
      'r': 24.0,
      'color': _benchCircleEnd,
      'style': PaintingStyle.stroke,
      'stroke': 3.0,
    },
    <String, dynamic>{
      'cx': 130.0,
      'cy': 50.0,
      'r': 18.0,
      'color': _benchCircleStart,
      'style': PaintingStyle.stroke,
      'stroke': 6.0,
    },
    <String, dynamic>{
      'cx': 180.0,
      'cy': 50.0,
      'r': 22.0,
      'color': _benchCircleEnd,
      'style': PaintingStyle.fill,
      'stroke': 0.0,
    },
  ];

  // ===========================================================================
  // SECTION 3: drawOval ROSTER
  // ===========================================================================

  final List<Map<String, dynamic>> ovalRoster = <Map<String, dynamic>>[
    <String, dynamic>{
      'rect': const Rect.fromLTWH(8.0, 16.0, 80.0, 40.0),
      'color': _benchOvalStart,
      'style': PaintingStyle.fill,
      'stroke': 0.0,
    },
    <String, dynamic>{
      'rect': const Rect.fromLTWH(100.0, 16.0, 80.0, 40.0),
      'color': _benchOvalEnd,
      'style': PaintingStyle.stroke,
      'stroke': 3.0,
    },
    <String, dynamic>{
      'rect': const Rect.fromLTWH(8.0, 70.0, 80.0, 30.0),
      'color': _benchOvalEnd,
      'style': PaintingStyle.fill,
      'stroke': 0.0,
    },
    <String, dynamic>{
      'rect': const Rect.fromLTWH(100.0, 70.0, 80.0, 30.0),
      'color': _benchOvalStart,
      'style': PaintingStyle.stroke,
      'stroke': 5.0,
    },
  ];

  // ===========================================================================
  // SECTION 4: drawLine ROSTER with strokeCap variations
  // ===========================================================================

  final List<Map<String, dynamic>> lineRoster = <Map<String, dynamic>>[
    <String, dynamic>{
      'from': const Offset(10.0, 20.0),
      'to': const Offset(210.0, 20.0),
      'color': _benchLineStart,
      'stroke': 2.0,
      'cap': StrokeCap.butt,
      'capName': 'butt',
    },
    <String, dynamic>{
      'from': const Offset(10.0, 50.0),
      'to': const Offset(210.0, 50.0),
      'color': _benchLineEnd,
      'stroke': 6.0,
      'cap': StrokeCap.round,
      'capName': 'round',
    },
    <String, dynamic>{
      'from': const Offset(10.0, 80.0),
      'to': const Offset(210.0, 80.0),
      'color': _benchLineStart,
      'stroke': 6.0,
      'cap': StrokeCap.square,
      'capName': 'square',
    },
    <String, dynamic>{
      'from': const Offset(10.0, 110.0),
      'to': const Offset(210.0, 110.0),
      'color': _benchLineEnd,
      'stroke': 10.0,
      'cap': StrokeCap.round,
      'capName': 'round (thick)',
    },
  ];

  // ===========================================================================
  // SECTION 5: drawArc ROSTER
  // ===========================================================================

  final List<Map<String, dynamic>> arcRoster = <Map<String, dynamic>>[
    <String, dynamic>{
      'rect': const Rect.fromLTWH(8.0, 8.0, 70.0, 70.0),
      'start': 0.0,
      'sweep': 3.14159,
      'useCenter': false,
      'color': _benchArcStart,
      'style': PaintingStyle.stroke,
      'stroke': 4.0,
      'label': 'Half (stroke)',
    },
    <String, dynamic>{
      'rect': const Rect.fromLTWH(88.0, 8.0, 70.0, 70.0),
      'start': -1.5708,
      'sweep': 4.7124,
      'useCenter': true,
      'color': _benchArcEnd,
      'style': PaintingStyle.fill,
      'stroke': 0.0,
      'label': 'Pie (fill)',
    },
    <String, dynamic>{
      'rect': const Rect.fromLTWH(168.0, 8.0, 70.0, 70.0),
      'start': 0.7854,
      'sweep': 2.3562,
      'useCenter': false,
      'color': _benchArcStart,
      'style': PaintingStyle.stroke,
      'stroke': 6.0,
      'label': 'Quadrant arc',
    },
  ];

  // ===========================================================================
  // SECTION 6: drawPath ROSTER - distinct path types built ahead of time so
  // they can be enumerated and replayed by the CustomPainter.
  // ===========================================================================

  final List<Map<String, dynamic>> pathRoster = <Map<String, dynamic>>[
    <String, dynamic>{
      'kind': 'triangle',
      'color': _benchPathStart,
      'style': PaintingStyle.stroke,
      'stroke': 3.0,
    },
    <String, dynamic>{
      'kind': 'star',
      'color': _benchPathEnd,
      'style': PaintingStyle.fill,
      'stroke': 0.0,
    },
    <String, dynamic>{
      'kind': 'wave',
      'color': _benchPathStart,
      'style': PaintingStyle.stroke,
      'stroke': 2.0,
    },
    <String, dynamic>{
      'kind': 'arrow',
      'color': _benchPathEnd,
      'style': PaintingStyle.fill,
      'stroke': 0.0,
    },
  ];

  // ===========================================================================
  // SECTION 7: PAINT PROPERTY MATRIX - sample paint cards we'll dump in a
  // comparison table after rendering.
  // ===========================================================================

  final List<Map<String, dynamic>> paintMatrix = <Map<String, dynamic>>[
    <String, dynamic>{
      'name': 'paintFillSolid',
      'color': '0xFF7E57C2',
      'style': 'fill',
      'strokeWidth': 0.0,
      'cap': 'butt',
      'join': 'miter',
      'blend': 'srcOver',
    },
    <String, dynamic>{
      'name': 'paintStrokeThin',
      'color': '0xFF4527A0',
      'style': 'stroke',
      'strokeWidth': 1.5,
      'cap': 'butt',
      'join': 'miter',
      'blend': 'srcOver',
    },
    <String, dynamic>{
      'name': 'paintStrokeRoundCap',
      'color': '0xFF7E57C2',
      'style': 'stroke',
      'strokeWidth': 6.0,
      'cap': 'round',
      'join': 'round',
      'blend': 'srcOver',
    },
    <String, dynamic>{
      'name': 'paintStrokeBevel',
      'color': '0xFF4527A0',
      'style': 'stroke',
      'strokeWidth': 4.0,
      'cap': 'square',
      'join': 'bevel',
      'blend': 'srcOver',
    },
    <String, dynamic>{
      'name': 'paintMultiplyTint',
      'color': '0xCC7E57C2',
      'style': 'fill',
      'strokeWidth': 0.0,
      'cap': 'butt',
      'join': 'miter',
      'blend': 'multiply',
    },
    <String, dynamic>{
      'name': 'paintScreenGlow',
      'color': '0xCCAB47BC',
      'style': 'fill',
      'strokeWidth': 0.0,
      'cap': 'butt',
      'join': 'miter',
      'blend': 'screen',
    },
  ];

  // Materialize real Paint objects so the painter can use them and so we get
  // a runtime sanity-check that the constructor and cascade APIs all work.
  final List<Paint> paintObjects = <Paint>[
    Paint()
      ..color = _benchPaintEnd
      ..style = PaintingStyle.fill,
    Paint()
      ..color = _benchPaintStart
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5,
    Paint()
      ..color = _benchPaintEnd
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round,
    Paint()
      ..color = _benchPaintStart
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.square
      ..strokeJoin = StrokeJoin.bevel,
    Paint()
      ..color = _benchPaintEnd
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.multiply,
    Paint()
      ..color = _benchOvalEnd
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.screen,
  ];

  // ===========================================================================
  // SECTION 8: TRANSFORM RECIPE - we describe save/restore/translate/rotate
  // /scale as a numbered choreography that the painter will replay verbatim.
  // ===========================================================================

  final List<Map<String, String>> transformScript = <Map<String, String>>[
    <String, String>{
      'op': 'save()',
      'note': 'Snapshot transform stack',
    },
    <String, String>{
      'op': 'translate(40, 30)',
      'note': 'Origin moves down-right',
    },
    <String, String>{
      'op': 'rotate(0.4)',
      'note': '~23 degrees clockwise',
    },
    <String, String>{
      'op': 'scale(1.4, 0.9)',
      'note': 'Wider, slightly squashed',
    },
    <String, String>{
      'op': 'drawRect(...)',
      'note': 'Geometry painted under stack',
    },
    <String, String>{
      'op': 'restore()',
      'note': 'Reverts to pre-save state',
    },
  ];

  // ===========================================================================
  // SECTION 9: PATH BUILDER GLOSSARY - we exercise every Path operation
  // mentioned in the brief once so the runtime can verify they exist.
  // ===========================================================================

  final Path glossaryPath = Path()
    ..moveTo(10.0, 80.0)
    ..lineTo(40.0, 20.0)
    ..quadraticBezierTo(70.0, 80.0, 100.0, 20.0)
    ..cubicTo(130.0, 80.0, 150.0, 20.0, 180.0, 60.0)
    ..addArc(
      const Rect.fromLTWH(180.0, 40.0, 30.0, 30.0),
      0.0,
      3.14159,
    )
    ..close();

  final List<Map<String, String>> pathGlossary = <Map<String, String>>[
    <String, String>{
      'op': 'moveTo(x, y)',
      'effect': 'Lifts the pen, sets new origin',
    },
    <String, String>{
      'op': 'lineTo(x, y)',
      'effect': 'Straight segment to target',
    },
    <String, String>{
      'op': 'quadraticBezierTo(cx, cy, x, y)',
      'effect': 'Smooth curve with one control',
    },
    <String, String>{
      'op': 'cubicTo(c1x, c1y, c2x, c2y, x, y)',
      'effect': 'Smooth curve with two controls',
    },
    <String, String>{
      'op': 'addArc(rect, start, sweep)',
      'effect': 'Appends an elliptical arc',
    },
    <String, String>{
      'op': 'close()',
      'effect': 'Connects last point to start',
    },
  ];

  // ===========================================================================
  // SECTION 10: ENUMS - inventory PointMode, BlendMode, StrokeCap, StrokeJoin
  // and PaintingStyle. Some lists are filtered to a handful of useful members.
  // ===========================================================================

  final List<Map<String, dynamic>> pointModeRoster = <Map<String, dynamic>>[];
  for (final ui.PointMode mode in ui.PointMode.values) {
    pointModeRoster.add(<String, dynamic>{
      'name': mode.name,
      'index': mode.index,
    });
  }

  final List<Map<String, dynamic>> strokeCapRoster = <Map<String, dynamic>>[];
  for (final StrokeCap cap in StrokeCap.values) {
    strokeCapRoster.add(<String, dynamic>{
      'name': cap.name,
      'index': cap.index,
    });
  }

  final List<Map<String, dynamic>> strokeJoinRoster = <Map<String, dynamic>>[];
  for (final StrokeJoin join in StrokeJoin.values) {
    strokeJoinRoster.add(<String, dynamic>{
      'name': join.name,
      'index': join.index,
    });
  }

  final List<Map<String, dynamic>> paintingStyleRoster =
      <Map<String, dynamic>>[];
  for (final PaintingStyle style in PaintingStyle.values) {
    paintingStyleRoster.add(<String, dynamic>{
      'name': style.name,
      'index': style.index,
    });
  }

  final List<Map<String, dynamic>> selectedBlendModes = <Map<String, dynamic>>[
    <String, dynamic>{'name': 'srcOver', 'use': 'default compositing'},
    <String, dynamic>{'name': 'multiply', 'use': 'darken overlap regions'},
    <String, dynamic>{'name': 'screen', 'use': 'brighten overlap regions'},
    <String, dynamic>{'name': 'overlay', 'use': 'contrast-preserving blend'},
    <String, dynamic>{'name': 'difference', 'use': 'invert overlap colors'},
    <String, dynamic>{'name': 'plus', 'use': 'additive light'},
  ];

  // ===========================================================================
  // SECTION 11: RECIPE CARDS - rendered down in the UI as how-to snippets.
  // ===========================================================================

  final List<Map<String, String>> recipes = <Map<String, String>>[
    <String, String>{
      'title': 'Recipe: record once, paint many',
      'body':
          'Build a PictureRecorder, render expensive vector content into its '
              'Canvas, call endRecording() and then drawPicture() on every '
              'frame instead of re-tracing the same geometry.',
    },
    <String, String>{
      'title': 'Recipe: rasterize for caching',
      'body':
          'After endRecording(), call picture.toImage(w, h) (async) to get a '
              'ui.Image you can blit with canvas.drawImage. Ideal for static '
              'thumbnails and tile caches.',
    },
    <String, String>{
      'title': 'Recipe: layered transforms',
      'body':
          'Wrap every translate/rotate/scale block in save()/restore() so the '
              'transform stack stays balanced. Use canvas.getSaveCount() in '
              'debug builds to verify symmetry.',
    },
    <String, String>{
      'title': 'Recipe: avoid leaks',
      'body':
          'Always call picture.dispose() once you no longer need it. Pictures '
              'hold native resources that the Dart GC alone will not free '
              'promptly.',
    },
  ];

  // ===========================================================================
  // SECTION 12: EPILOGUE GLOSSARY ROWS
  // ===========================================================================

  final List<Map<String, String>> glossary = <Map<String, String>>[
    <String, String>{
      'term': 'PictureRecorder',
      'definition':
          'Captures canvas drawing operations into an immutable Picture.',
    },
    <String, String>{
      'term': 'Canvas',
      'definition':
          'The drawing surface bound to a recorder; exposes draw* methods.',
    },
    <String, String>{
      'term': 'Picture',
      'definition':
          'A replayable, immutable record of drawing operations.',
    },
    <String, String>{
      'term': 'Paint',
      'definition':
          'Style descriptor (color, stroke, cap, join, blendMode, ...).',
    },
    <String, String>{
      'term': 'Path',
      'definition':
          'Vector contour built from move/line/curve/arc primitives.',
    },
  ];

  print('[picture_test] workflow recorder type: $recorderType');
  print('[picture_test] workflow canvas type: $canvasType');
  print('[picture_test] workflow picture type: $pictureType');
  print('[picture_test] recordingBefore=$recordingBefore '
      'recordingAfter=$recordingAfter');

  // ===========================================================================
  // RETURN A MaterialApp WITH THE FULL VISUAL ATLAS
  // ===========================================================================

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: _inkPale,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _heroHeader(),
            const SizedBox(height: 20.0),
            _conceptOverview(),
            const SizedBox(height: 20.0),
            _workflowSection(
              steps: workflowSteps,
              recorderType: recorderType,
              canvasType: canvasType,
              pictureType: pictureType,
              recordingBefore: recordingBefore,
              recordingAfter: recordingAfter,
            ),
            const SizedBox(height: 20.0),
            _section1Rect(rectRoster),
            const SizedBox(height: 20.0),
            _section2Circle(circleRoster),
            const SizedBox(height: 20.0),
            _section3Oval(ovalRoster),
            const SizedBox(height: 20.0),
            _section4Line(lineRoster),
            const SizedBox(height: 20.0),
            _section5Arc(arcRoster),
            const SizedBox(height: 20.0),
            _section6Path(pathRoster),
            const SizedBox(height: 20.0),
            _section7Paint(paintMatrix),
            const SizedBox(height: 20.0),
            _section8Transform(transformScript),
            const SizedBox(height: 20.0),
            _section9PathGlossary(pathGlossary, glossaryPath),
            const SizedBox(height: 20.0),
            _section10Enums(
              pointModeRoster,
              strokeCapRoster,
              strokeJoinRoster,
              paintingStyleRoster,
              selectedBlendModes,
            ),
            const SizedBox(height: 20.0),
            _section11Recipes(recipes),
            const SizedBox(height: 20.0),
            _section12Glossary(glossary),
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
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_inkDeep, _inkMid],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Picture Recorder Studio',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6.0),
        const Text(
          'A guided workshop through dart:ui Picture, PictureRecorder, '
          'Canvas, Paint and Path.',
          style: TextStyle(fontSize: 14.0, color: _inkSoft),
        ),
        const SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _heroChip('PictureRecorder'),
            _heroChip('Canvas'),
            _heroChip('Paint'),
            _heroChip('Path'),
            _heroChip('toImage'),
            _heroChip('save / restore'),
          ],
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
    ),
    child: Text(
      label,
      style: const TextStyle(fontSize: 12.0, color: Colors.white),
    ),
  );
}

// =============================================================================
// CONCEPT OVERVIEW
// =============================================================================

Widget _conceptOverview() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _inkSoft, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: _inkMid,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Icon(Icons.brush, color: Colors.white, size: 18.0),
            ),
            const SizedBox(width: 10.0),
            const Text(
              'Concept Overview',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: _inkDeep,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text(
          'A PictureRecorder is a write-once recorder for vector ops. You bind '
          'a Canvas to it, issue draw* calls, then materialize an immutable '
          'Picture. Pictures can be replayed cheaply, rasterized via toImage, '
          'or composed inside other canvases.',
          style: TextStyle(fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Demo benches:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
        ),
        const SizedBox(height: 6.0),
        _bulletText('Workflow narrative - the recorder/canvas/picture trio'),
        _bulletText('drawRect / drawRRect roster'),
        _bulletText('drawCircle roster'),
        _bulletText('drawOval roster'),
        _bulletText('drawLine roster with strokeCap variations'),
        _bulletText('drawArc roster'),
        _bulletText('drawPath roster with custom contours'),
        _bulletText('Paint property matrix (color/style/cap/join/blend)'),
        _bulletText('Transform recipe (save / translate / rotate / scale)'),
        _bulletText('Path builder glossary'),
        _bulletText('Enums: PointMode, StrokeCap, StrokeJoin, PaintingStyle'),
        _bulletText('Recipes, glossary, epilogue'),
      ],
    ),
  );
}

Widget _bulletText(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('  • ', style: TextStyle(fontSize: 13.0)),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 13.0))),
      ],
    ),
  );
}

// =============================================================================
// WORKFLOW SECTION (NUMBERED 0)
// =============================================================================

Widget _workflowSection({
  required List<Map<String, String>> steps,
  required String recorderType,
  required String canvasType,
  required String pictureType,
  required bool recordingBefore,
  required bool recordingAfter,
}) {
  return _benchCard(
    headerColorStart: _inkDeep,
    headerColorEnd: _inkMid,
    softColor: _inkPale,
    accentColor: _inkSoft,
    sectionNumber: '0',
    title: 'PictureRecorder workflow narrative',
    subtitle: 'The recorder/canvas/picture trio in action',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final Map<String, String> step in steps)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 26.0,
                  height: 26.0,
                  decoration: BoxDecoration(
                    color: _inkMid,
                    borderRadius: BorderRadius.circular(13.0),
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
                          color: _inkDeep,
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
        const SizedBox(height: 10.0),
        _comparisonTable(
          columns: const <String>['key', 'value'],
          headerColor: _inkMid,
          rowColor: _inkPale,
          rows: <List<String>>[
            <String>['PictureRecorder type', recorderType],
            <String>['Canvas type', canvasType],
            <String>['Picture type', pictureType],
            <String>['isRecording before endRecording', '$recordingBefore'],
            <String>['isRecording after endRecording', '$recordingAfter'],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: hand-rolled offscreen picture',
    recipeBody:
        'final r = PictureRecorder(); final c = Canvas(r); c.drawRect(...); '
            'final p = r.endRecording(); display.drawPicture(p);',
  );
}

// =============================================================================
// SECTION 1: drawRect / drawRRect
// =============================================================================

Widget _section1Rect(List<Map<String, dynamic>> roster) {
  return _benchCard(
    headerColorStart: _benchRectStart,
    headerColorEnd: _benchRectEnd,
    softColor: _benchRectSoft,
    accentColor: _benchRectEnd,
    sectionNumber: '1',
    title: 'drawRect / drawRRect bench',
    subtitle: 'Rectangles and rounded rectangles, fill and stroke',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paintCanvas(
          height: 120.0,
          painter: _RectBenchPainter(roster),
        ),
        const SizedBox(height: 10.0),
        _comparisonTable(
          columns: const <String>['label', 'style', 'stroke'],
          headerColor: _benchRectStart,
          rowColor: _benchRectSoft,
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
    recipeTitle: 'Recipe: snappy panels',
    recipeBody:
        'canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(8)), '
            'Paint()..color = brand);',
  );
}

// =============================================================================
// SECTION 2: drawCircle
// =============================================================================

Widget _section2Circle(List<Map<String, dynamic>> roster) {
  return _benchCard(
    headerColorStart: _benchCircleStart,
    headerColorEnd: _benchCircleEnd,
    softColor: _benchCircleSoft,
    accentColor: _benchCircleEnd,
    sectionNumber: '2',
    title: 'drawCircle bench',
    subtitle: 'Filled, thin stroke, thick stroke - all four flavors side by side',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paintCanvas(
          height: 110.0,
          painter: _CircleBenchPainter(roster),
        ),
        const SizedBox(height: 10.0),
        _comparisonTable(
          columns: const <String>['center', 'r', 'style', 'stroke'],
          headerColor: _benchCircleStart,
          rowColor: _benchCircleSoft,
          rows: <List<String>>[
            for (final Map<String, dynamic> item in roster)
              <String>[
                '(${(item['cx'] as double).toStringAsFixed(0)}, '
                    '${(item['cy'] as double).toStringAsFixed(0)})',
                (item['r'] as double).toStringAsFixed(0),
                (item['style'] as PaintingStyle).name,
                (item['stroke'] as double).toStringAsFixed(1),
              ],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: glowing knob',
    recipeBody:
        'canvas.drawCircle(c, r + 4, Paint()..color = soft); '
            'canvas.drawCircle(c, r, Paint()..color = hard);',
  );
}

// =============================================================================
// SECTION 3: drawOval
// =============================================================================

Widget _section3Oval(List<Map<String, dynamic>> roster) {
  return _benchCard(
    headerColorStart: _benchOvalStart,
    headerColorEnd: _benchOvalEnd,
    softColor: _benchOvalSoft,
    accentColor: _benchOvalEnd,
    sectionNumber: '3',
    title: 'drawOval bench',
    subtitle: 'Ellipses fitted to bounding rectangles',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paintCanvas(
          height: 120.0,
          painter: _OvalBenchPainter(roster),
        ),
        const SizedBox(height: 10.0),
        _comparisonTable(
          columns: const <String>['bounds', 'style', 'stroke'],
          headerColor: _benchOvalStart,
          rowColor: _benchOvalSoft,
          rows: <List<String>>[
            for (final Map<String, dynamic> item in roster)
              <String>[
                _formatRect(item['rect'] as Rect),
                (item['style'] as PaintingStyle).name,
                (item['stroke'] as double).toStringAsFixed(1),
              ],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: pill shapes',
    recipeBody:
        'Use drawOval with a wide rect, or drawRRect with stadium radius - '
            'pick the cheaper one for very wide shapes.',
  );
}

// =============================================================================
// SECTION 4: drawLine
// =============================================================================

Widget _section4Line(List<Map<String, dynamic>> roster) {
  return _benchCard(
    headerColorStart: _benchLineStart,
    headerColorEnd: _benchLineEnd,
    softColor: _benchLineSoft,
    accentColor: _benchLineEnd,
    sectionNumber: '4',
    title: 'drawLine bench',
    subtitle: 'Thickness and strokeCap influence the line endings',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paintCanvas(
          height: 140.0,
          painter: _LineBenchPainter(roster),
        ),
        const SizedBox(height: 10.0),
        _comparisonTable(
          columns: const <String>['from', 'to', 'cap', 'stroke'],
          headerColor: _benchLineStart,
          rowColor: _benchLineSoft,
          rows: <List<String>>[
            for (final Map<String, dynamic> item in roster)
              <String>[
                _formatOffset(item['from'] as Offset),
                _formatOffset(item['to'] as Offset),
                item['capName'] as String,
                (item['stroke'] as double).toStringAsFixed(1),
              ],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: tickmarks',
    recipeBody:
        'Use StrokeCap.round on thick lines to get a friendly look; switch to '
            'StrokeCap.butt for crisp 1-pixel grids.',
  );
}

// =============================================================================
// SECTION 5: drawArc
// =============================================================================

Widget _section5Arc(List<Map<String, dynamic>> roster) {
  return _benchCard(
    headerColorStart: _benchArcStart,
    headerColorEnd: _benchArcEnd,
    softColor: _benchArcSoft,
    accentColor: _benchArcEnd,
    sectionNumber: '5',
    title: 'drawArc bench',
    subtitle: 'Slice-of-pie and stroke-only arcs share an API',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paintCanvas(
          height: 110.0,
          painter: _ArcBenchPainter(roster),
        ),
        const SizedBox(height: 10.0),
        _comparisonTable(
          columns: const <String>['label', 'sweep', 'useCenter', 'style'],
          headerColor: _benchArcStart,
          rowColor: _benchArcSoft,
          rows: <List<String>>[
            for (final Map<String, dynamic> item in roster)
              <String>[
                item['label'] as String,
                (item['sweep'] as double).toStringAsFixed(3),
                '${item['useCenter']}',
                (item['style'] as PaintingStyle).name,
              ],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: progress ring',
    recipeBody:
        'canvas.drawArc(rect, -pi/2, 2*pi*progress, false, ringPaint); - '
            'sweep grows with progress, useCenter stays false.',
  );
}

// =============================================================================
// SECTION 6: drawPath
// =============================================================================

Widget _section6Path(List<Map<String, dynamic>> roster) {
  return _benchCard(
    headerColorStart: _benchPathStart,
    headerColorEnd: _benchPathEnd,
    softColor: _benchPathSoft,
    accentColor: _benchPathEnd,
    sectionNumber: '6',
    title: 'drawPath bench',
    subtitle: 'Triangle, star, wave and arrow contours via Path',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paintCanvas(
          height: 150.0,
          painter: _PathBenchPainter(roster),
        ),
        const SizedBox(height: 10.0),
        _comparisonTable(
          columns: const <String>['kind', 'style', 'stroke'],
          headerColor: _benchPathStart,
          rowColor: _benchPathSoft,
          rows: <List<String>>[
            for (final Map<String, dynamic> item in roster)
              <String>[
                item['kind'] as String,
                (item['style'] as PaintingStyle).name,
                (item['stroke'] as double).toStringAsFixed(1),
              ],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: closed contour',
    recipeBody:
        'final p = Path()..moveTo(...)..lineTo(...)..lineTo(...)..close(); '
            'canvas.drawPath(p, paint);',
  );
}

// =============================================================================
// SECTION 7: PAINT MATRIX
// =============================================================================

Widget _section7Paint(List<Map<String, dynamic>> matrix) {
  return _benchCard(
    headerColorStart: _benchPaintStart,
    headerColorEnd: _benchPaintEnd,
    softColor: _benchPaintSoft,
    accentColor: _benchPaintEnd,
    sectionNumber: '7',
    title: 'Paint property matrix',
    subtitle: 'color / style / strokeWidth / cap / join / blendMode',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paintCanvas(
          height: 130.0,
          painter: _PaintMatrixPainter(),
        ),
        const SizedBox(height: 10.0),
        _comparisonTable(
          columns: const <String>['name', 'style', 'cap', 'join', 'blend'],
          headerColor: _benchPaintStart,
          rowColor: _benchPaintSoft,
          rows: <List<String>>[
            for (final Map<String, dynamic> item in matrix)
              <String>[
                item['name'] as String,
                item['style'] as String,
                item['cap'] as String,
                item['join'] as String,
                item['blend'] as String,
              ],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: paint reuse',
    recipeBody:
        'Allocate Paint once outside paint() and mutate fields between draws '
            'to avoid per-frame allocations.',
  );
}

// =============================================================================
// SECTION 8: TRANSFORM CHOREOGRAPHY
// =============================================================================

Widget _section8Transform(List<Map<String, String>> script) {
  return _benchCard(
    headerColorStart: _benchTransformStart,
    headerColorEnd: _benchTransformEnd,
    softColor: _benchTransformSoft,
    accentColor: _benchTransformEnd,
    sectionNumber: '8',
    title: 'Transform choreography',
    subtitle: 'save / translate / rotate / scale / restore',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paintCanvas(
          height: 160.0,
          painter: _TransformBenchPainter(),
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
                    color: _benchTransformStart,
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
    recipeTitle: 'Recipe: balanced transforms',
    recipeBody:
        'Every save() must be paired with exactly one restore(). When unsure, '
            'log canvas.getSaveCount() at frame boundaries.',
  );
}

// =============================================================================
// SECTION 9: PATH BUILDER GLOSSARY (with a custom rendered demo path)
// =============================================================================

Widget _section9PathGlossary(
  List<Map<String, String>> glossary,
  Path demoPath,
) {
  return _benchCard(
    headerColorStart: _benchPaintEnd,
    headerColorEnd: _benchOvalEnd,
    softColor: _benchPaintSoft,
    accentColor: _benchOvalEnd,
    sectionNumber: '9',
    title: 'Path builder glossary',
    subtitle: 'moveTo / lineTo / quadraticBezierTo / cubicTo / addArc / close',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _paintCanvas(
          height: 120.0,
          painter: _GlossaryPathPainter(demoPath),
        ),
        const SizedBox(height: 10.0),
        _comparisonTable(
          columns: const <String>['op', 'effect'],
          headerColor: _benchPaintStart,
          rowColor: _benchPaintSoft,
          rows: <List<String>>[
            for (final Map<String, String> entry in glossary)
              <String>[entry['op']!, entry['effect']!],
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: smooth signature curve',
    recipeBody:
        'Combine cubicTo segments through the user touch samples and use '
            'StrokeCap.round to get an inky feel.',
  );
}

// =============================================================================
// SECTION 10: ENUM PANELS
// =============================================================================

Widget _section10Enums(
  List<Map<String, dynamic>> pointMode,
  List<Map<String, dynamic>> strokeCap,
  List<Map<String, dynamic>> strokeJoin,
  List<Map<String, dynamic>> paintingStyle,
  List<Map<String, dynamic>> blendModes,
) {
  return _benchCard(
    headerColorStart: _benchCircleStart,
    headerColorEnd: _benchCircleEnd,
    softColor: _benchCircleSoft,
    accentColor: _benchCircleEnd,
    sectionNumber: '10',
    title: 'Enum atlas',
    subtitle: 'PointMode, StrokeCap, StrokeJoin, PaintingStyle, BlendMode',
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _enumGroupTitle('PointMode'),
        _enumChips(pointMode, _benchCircleStart),
        const SizedBox(height: 10.0),
        _enumGroupTitle('StrokeCap'),
        _enumChips(strokeCap, _benchLineStart),
        const SizedBox(height: 10.0),
        _enumGroupTitle('StrokeJoin'),
        _enumChips(strokeJoin, _benchOvalStart),
        const SizedBox(height: 10.0),
        _enumGroupTitle('PaintingStyle'),
        _enumChips(paintingStyle, _benchPaintStart),
        const SizedBox(height: 10.0),
        _enumGroupTitle('Selected BlendModes'),
        Column(
          children: <Widget>[
            for (final Map<String, dynamic> entry in blendModes)
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
                        color: _benchPaintStart,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        entry['name'] as String,
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
                        entry['use'] as String,
                        style: const TextStyle(fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    ),
    recipeTitle: 'Recipe: enum probing',
    recipeBody:
        'Enumerate <Enum>.values once at startup and cache index/name pairs '
            'for diagnostic panels.',
  );
}

Widget _enumGroupTitle(String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 13.0,
        color: _inkDeep,
      ),
    ),
  );
}

Widget _enumChips(List<Map<String, dynamic>> entries, Color color) {
  return Wrap(
    spacing: 6.0,
    runSpacing: 6.0,
    children: <Widget>[
      for (final Map<String, dynamic> entry in entries)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            '${entry['name']} [${entry['index']}]',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.0,
              fontFamily: 'monospace',
            ),
          ),
        ),
    ],
  );
}

// =============================================================================
// SECTION 11: RECIPE CARDS
// =============================================================================

Widget _section11Recipes(List<Map<String, String>> recipes) {
  return _benchCard(
    headerColorStart: _benchCloseStart,
    headerColorEnd: _benchCloseEnd,
    softColor: _benchCloseSoft,
    accentColor: _benchCloseEnd,
    sectionNumber: '11',
    title: 'Recipes',
    subtitle: 'Snippet patterns you will reach for again and again',
    body: Column(
      children: <Widget>[
        for (final Map<String, String> recipe in recipes)
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: _benchCloseSoft,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: _benchCloseEnd, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    recipe['title']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: _benchCloseStart,
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
    recipeTitle: 'Recipe: keep a library',
    recipeBody:
        'Drop snippets into a personal "vector cookbook" file - the muscle '
            'memory pays off when prototyping bespoke chrome.',
  );
}

// =============================================================================
// SECTION 12: GLOSSARY PANEL
// =============================================================================

Widget _section12Glossary(List<Map<String, String>> glossary) {
  return _benchCard(
    headerColorStart: _benchTransformStart,
    headerColorEnd: _benchTransformEnd,
    softColor: _benchTransformSoft,
    accentColor: _benchTransformEnd,
    sectionNumber: '12',
    title: 'Glossary',
    subtitle: 'Quick reference for the core types',
    body: Column(
      children: <Widget>[
        for (final Map<String, String> entry in glossary)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 140.0,
                  child: Text(
                    entry['term']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13.0,
                      color: _benchTransformStart,
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
    recipeTitle: 'Recipe: name your things',
    recipeBody:
        'Give Paint instances semantic names (ringPaint, glowPaint) - your '
            'future self reads the paint() body like a sentence.',
  );
}

// =============================================================================
// EPILOGUE
// =============================================================================

Widget _epilogue() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[_inkMid, _inkDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Studio Wrap-Up',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        const Text(
          'You toured every workbench in the Picture Recorder Studio: the '
          'recorder/canvas/picture trio, fill and stroke geometry, paths and '
          'paints, transform choreography, and the supporting enums. Reach for '
          'this script when you need a runnable cheatsheet for dart:ui '
          'vector drawing.',
          style: TextStyle(color: Colors.white, fontSize: 13.5, height: 1.5),
        ),
        const SizedBox(height: 14.0),
        _summaryRow('PictureRecorder workflow', 'PASS'),
        _summaryRow('drawRect / drawRRect', 'PASS'),
        _summaryRow('drawCircle', 'PASS'),
        _summaryRow('drawOval', 'PASS'),
        _summaryRow('drawLine + strokeCap', 'PASS'),
        _summaryRow('drawArc', 'PASS'),
        _summaryRow('drawPath', 'PASS'),
        _summaryRow('Paint property matrix', 'PASS'),
        _summaryRow('Transform stack', 'PASS'),
        _summaryRow('Path builder glossary', 'PASS'),
        _summaryRow('Enum atlas', 'PASS'),
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
              'Picture Recorder Studio — All Benches Verified',
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

Widget _benchCard({
  required Color headerColorStart,
  required Color headerColorEnd,
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
              colors: <Color>[headerColorStart, headerColorEnd],
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
                  color: headerColorStart,
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

String _formatRect(Rect r) {
  return '(${r.left.toStringAsFixed(0)},${r.top.toStringAsFixed(0)}) '
      '${r.width.toStringAsFixed(0)}x${r.height.toStringAsFixed(0)}';
}

String _formatOffset(Offset o) {
  return '(${o.dx.toStringAsFixed(0)},${o.dy.toStringAsFixed(0)})';
}

// =============================================================================
// CUSTOM PAINTERS - top-level subclasses (not Stateful/Stateless widgets)
// =============================================================================

class _RectBenchPainter extends CustomPainter {
  _RectBenchPainter(this.roster);

  final List<Map<String, dynamic>> roster;

  @override
  void paint(Canvas canvas, Size size) {
    for (final Map<String, dynamic> item in roster) {
      final Paint paint = Paint()
        ..color = item['color'] as Color
        ..style = item['style'] as PaintingStyle
        ..strokeWidth = item['stroke'] as double;
      final Rect rect = item['rect'] as Rect;
      final double? radius = item['radius'] as double?;
      if (radius != null) {
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, Radius.circular(radius)),
          paint,
        );
      } else {
        canvas.drawRect(rect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _RectBenchPainter oldDelegate) {
    return oldDelegate.roster != roster;
  }
}

class _CircleBenchPainter extends CustomPainter {
  _CircleBenchPainter(this.roster);

  final List<Map<String, dynamic>> roster;

  @override
  void paint(Canvas canvas, Size size) {
    for (final Map<String, dynamic> item in roster) {
      final Paint paint = Paint()
        ..color = item['color'] as Color
        ..style = item['style'] as PaintingStyle
        ..strokeWidth = item['stroke'] as double;
      canvas.drawCircle(
        Offset(item['cx'] as double, item['cy'] as double),
        item['r'] as double,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _CircleBenchPainter oldDelegate) {
    return oldDelegate.roster != roster;
  }
}

class _OvalBenchPainter extends CustomPainter {
  _OvalBenchPainter(this.roster);

  final List<Map<String, dynamic>> roster;

  @override
  void paint(Canvas canvas, Size size) {
    for (final Map<String, dynamic> item in roster) {
      final Paint paint = Paint()
        ..color = item['color'] as Color
        ..style = item['style'] as PaintingStyle
        ..strokeWidth = item['stroke'] as double;
      canvas.drawOval(item['rect'] as Rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _OvalBenchPainter oldDelegate) {
    return oldDelegate.roster != roster;
  }
}

class _LineBenchPainter extends CustomPainter {
  _LineBenchPainter(this.roster);

  final List<Map<String, dynamic>> roster;

  @override
  void paint(Canvas canvas, Size size) {
    for (final Map<String, dynamic> item in roster) {
      final Paint paint = Paint()
        ..color = item['color'] as Color
        ..strokeWidth = item['stroke'] as double
        ..strokeCap = item['cap'] as StrokeCap;
      canvas.drawLine(
        item['from'] as Offset,
        item['to'] as Offset,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _LineBenchPainter oldDelegate) {
    return oldDelegate.roster != roster;
  }
}

class _ArcBenchPainter extends CustomPainter {
  _ArcBenchPainter(this.roster);

  final List<Map<String, dynamic>> roster;

  @override
  void paint(Canvas canvas, Size size) {
    for (final Map<String, dynamic> item in roster) {
      final Paint paint = Paint()
        ..color = item['color'] as Color
        ..style = item['style'] as PaintingStyle
        ..strokeWidth = item['stroke'] as double;
      canvas.drawArc(
        item['rect'] as Rect,
        item['start'] as double,
        item['sweep'] as double,
        item['useCenter'] as bool,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ArcBenchPainter oldDelegate) {
    return oldDelegate.roster != roster;
  }
}

class _PathBenchPainter extends CustomPainter {
  _PathBenchPainter(this.roster);

  final List<Map<String, dynamic>> roster;

  @override
  void paint(Canvas canvas, Size size) {
    // Tile each path kind into its own slot along the width.
    const double slotWidth = 100.0;
    const double slotHeight = 130.0;
    for (int i = 0; i < roster.length; i++) {
      final Map<String, dynamic> item = roster[i];
      final double x = 10.0 + i * (slotWidth + 6.0);
      canvas.save();
      canvas.translate(x, 8.0);
      final Path path = _buildKindPath(
        item['kind'] as String,
        slotWidth,
        slotHeight,
      );
      final Paint paint = Paint()
        ..color = item['color'] as Color
        ..style = item['style'] as PaintingStyle
        ..strokeWidth = item['stroke'] as double
        ..strokeJoin = StrokeJoin.round
        ..strokeCap = StrokeCap.round;
      canvas.drawPath(path, paint);
      canvas.restore();
    }
  }

  Path _buildKindPath(String kind, double w, double h) {
    final Path path = Path();
    switch (kind) {
      case 'triangle':
        path.moveTo(w * 0.5, 8.0);
        path.lineTo(w - 10.0, h - 14.0);
        path.lineTo(10.0, h - 14.0);
        path.close();
        break;
      case 'star':
        final double cx = w * 0.5;
        final double cy = h * 0.5;
        final double outer = h * 0.4;
        final double inner = h * 0.18;
        for (int i = 0; i < 10; i++) {
          final double angle = -1.5708 + i * 0.6283;
          final double radius = i.isEven ? outer : inner;
          final double px = cx + radius * _cos(angle);
          final double py = cy + radius * _sin(angle);
          if (i == 0) {
            path.moveTo(px, py);
          } else {
            path.lineTo(px, py);
          }
        }
        path.close();
        break;
      case 'wave':
        path.moveTo(8.0, h - 30.0);
        path.quadraticBezierTo(
          w * 0.25,
          h - 70.0,
          w * 0.5,
          h - 30.0,
        );
        path.quadraticBezierTo(
          w * 0.75,
          h - 5.0,
          w - 8.0,
          h - 30.0,
        );
        break;
      case 'arrow':
        path.moveTo(10.0, h * 0.5);
        path.lineTo(w * 0.65, h * 0.5);
        path.lineTo(w * 0.65, h * 0.25);
        path.lineTo(w - 10.0, h * 0.5);
        path.lineTo(w * 0.65, h * 0.75);
        path.lineTo(w * 0.65, h * 0.5);
        path.close();
        break;
      default:
        path.addRect(Rect.fromLTWH(10.0, 10.0, w - 20.0, h - 20.0));
    }
    return path;
  }

  @override
  bool shouldRepaint(covariant _PathBenchPainter oldDelegate) {
    return oldDelegate.roster != roster;
  }
}

class _PaintMatrixPainter extends CustomPainter {
  _PaintMatrixPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Fill background swatch
    final Paint background = Paint()..color = const Color(0xFFF3E5F5);
    canvas.drawRect(
      Rect.fromLTWH(0.0, 0.0, size.width, size.height),
      background,
    );

    // Sample 1: solid fill rectangle
    final Paint solid = Paint()
      ..color = _benchPaintEnd
      ..style = PaintingStyle.fill;
    canvas.drawRect(const Rect.fromLTWH(10.0, 10.0, 60.0, 40.0), solid);

    // Sample 2: thin stroke
    final Paint thinStroke = Paint()
      ..color = _benchPaintStart
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawRect(const Rect.fromLTWH(80.0, 10.0, 60.0, 40.0), thinStroke);

    // Sample 3: thick round stroke open path
    final Paint roundStroke = Paint()
      ..color = _benchPaintEnd
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final Path zigzag = Path()
      ..moveTo(150.0, 18.0)
      ..lineTo(170.0, 42.0)
      ..lineTo(190.0, 18.0)
      ..lineTo(210.0, 42.0);
    canvas.drawPath(zigzag, roundStroke);

    // Sample 4: square cap, bevel join, jagged
    final Paint bevelStroke = Paint()
      ..color = _benchPaintStart
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.square
      ..strokeJoin = StrokeJoin.bevel;
    final Path jagged = Path()
      ..moveTo(10.0, 80.0)
      ..lineTo(30.0, 100.0)
      ..lineTo(50.0, 70.0)
      ..lineTo(70.0, 100.0);
    canvas.drawPath(jagged, bevelStroke);

    // Sample 5: multiply blend overlap
    final Paint multiplyA = Paint()
      ..color = const Color(0xCC7E57C2)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.multiply;
    canvas.drawCircle(const Offset(110.0, 90.0), 18.0, multiplyA);
    canvas.drawCircle(const Offset(125.0, 90.0), 18.0, multiplyA);

    // Sample 6: screen blend overlap
    final Paint screenA = Paint()
      ..color = const Color(0xCCAB47BC)
      ..style = PaintingStyle.fill
      ..blendMode = BlendMode.screen;
    canvas.drawCircle(const Offset(180.0, 90.0), 18.0, screenA);
    canvas.drawCircle(const Offset(195.0, 90.0), 18.0, screenA);
  }

  @override
  bool shouldRepaint(covariant _PaintMatrixPainter oldDelegate) => false;
}

class _TransformBenchPainter extends CustomPainter {
  _TransformBenchPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Backdrop grid (untransformed reference)
    final Paint grid = Paint()
      ..color = const Color(0xFFF8BBD0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    for (double x = 0.0; x <= size.width; x += 20.0) {
      canvas.drawLine(Offset(x, 0.0), Offset(x, size.height), grid);
    }
    for (double y = 0.0; y <= size.height; y += 20.0) {
      canvas.drawLine(Offset(0.0, y), Offset(size.width, y), grid);
    }

    // Reference axes
    final Paint axisPaint = Paint()
      ..color = _benchTransformStart
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawLine(
      Offset(0.0, size.height * 0.5),
      Offset(size.width, size.height * 0.5),
      axisPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.5, 0.0),
      Offset(size.width * 0.5, size.height),
      axisPaint,
    );

    // Untransformed glyph (top-left)
    final Paint base = Paint()
      ..color = _benchTransformEnd
      ..style = PaintingStyle.fill;
    canvas.drawRect(const Rect.fromLTWH(20.0, 20.0, 40.0, 30.0), base);

    // Translated glyph
    canvas.save();
    canvas.translate(80.0, 30.0);
    canvas.drawRect(const Rect.fromLTWH(0.0, 0.0, 40.0, 30.0), base);
    canvas.restore();

    // Rotated glyph
    canvas.save();
    canvas.translate(180.0, 40.0);
    canvas.rotate(0.4);
    canvas.drawRect(const Rect.fromLTWH(0.0, 0.0, 40.0, 30.0), base);
    canvas.restore();

    // Scaled glyph
    canvas.save();
    canvas.translate(40.0, 90.0);
    canvas.scale(1.4, 0.9);
    canvas.drawRect(const Rect.fromLTWH(0.0, 0.0, 40.0, 30.0), base);
    canvas.restore();

    // Combined transform glyph
    canvas.save();
    canvas.translate(160.0, 100.0);
    canvas.rotate(-0.5);
    canvas.scale(1.2);
    canvas.drawRect(const Rect.fromLTWH(0.0, 0.0, 40.0, 30.0), base);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _TransformBenchPainter oldDelegate) => false;
}

class _GlossaryPathPainter extends CustomPainter {
  _GlossaryPathPainter(this.path);

  final Path path;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fill = Paint()
      ..color = _benchPaintSoft
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fill);

    final Paint stroke = Paint()
      ..color = _benchPaintStart
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(path, stroke);
  }

  @override
  bool shouldRepaint(covariant _GlossaryPathPainter oldDelegate) {
    return oldDelegate.path != path;
  }
}

// =============================================================================
// MINIMAL TRIG HELPERS (no dart:math import to keep the interpreter happy on
// platforms where math constants may not be bridged. Taylor series truncated
// to ~6 terms — accurate enough for visual demo angles in [-pi, pi]).
// =============================================================================

double _cos(double x) {
  // Reduce to [-pi, pi]
  double t = x;
  const double twoPi = 6.283185307179586;
  while (t > 3.141592653589793) {
    t -= twoPi;
  }
  while (t < -3.141592653589793) {
    t += twoPi;
  }
  final double t2 = t * t;
  final double t4 = t2 * t2;
  final double t6 = t4 * t2;
  final double t8 = t4 * t4;
  final double t10 = t8 * t2;
  return 1.0 -
      t2 / 2.0 +
      t4 / 24.0 -
      t6 / 720.0 +
      t8 / 40320.0 -
      t10 / 3628800.0;
}

double _sin(double x) {
  double t = x;
  const double twoPi = 6.283185307179586;
  while (t > 3.141592653589793) {
    t -= twoPi;
  }
  while (t < -3.141592653589793) {
    t += twoPi;
  }
  final double t2 = t * t;
  final double t3 = t2 * t;
  final double t5 = t3 * t2;
  final double t7 = t5 * t2;
  final double t9 = t7 * t2;
  final double t11 = t9 * t2;
  return t -
      t3 / 6.0 +
      t5 / 120.0 -
      t7 / 5040.0 +
      t9 / 362880.0 -
      t11 / 39916800.0;
}
