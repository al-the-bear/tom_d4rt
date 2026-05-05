// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt visual demo: PictureLayer (package:flutter/rendering.dart)
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  // ---------------------------------------------------------------------------
  // Palette: "graphite plum" — slate base, plum accents, amber highlights.
  // ---------------------------------------------------------------------------
  const Color cBg = Color(0xFF101218);
  const Color cPanel = Color(0xFF1A1D27);
  const Color cPanelAlt = Color(0xFF222633);
  const Color cBorder = Color(0xFF323748);
  const Color cInk = Color(0xFFE8EAF2);
  const Color cInkDim = Color(0xFFA9B0C2);
  const Color cPlum = Color(0xFF9E5FB3);
  const Color cAmber = Color(0xFFE0A83C);
  const Color cTeal = Color(0xFF3FB6A8);
  const Color cRose = Color(0xFFD86A7A);
  const Color cSlate = Color(0xFF526177);

  // ---------------------------------------------------------------------------
  // Try a real PictureLayer with a recorded ui.Picture.
  // ---------------------------------------------------------------------------
  PictureLayer? createdLayer;
  ui.Picture? recordedPicture;
  String layerCreationLog = 'pending';
  String pictureRecordLog = 'pending';
  Rect bounds = const Rect.fromLTWH(0, 0, 240, 160);

  try {
    createdLayer = PictureLayer(bounds);
    layerCreationLog = 'PictureLayer created with bounds $bounds';
  } catch (e) {
    layerCreationLog = 'PictureLayer ctor threw: $e';
  }

  try {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder, bounds);
    final Paint bgPaint = Paint()..color = cPanelAlt;
    canvas.drawRect(bounds, bgPaint);
    final Paint circlePaint = Paint()..color = cPlum;
    canvas.drawCircle(const Offset(60, 80), 32, circlePaint);
    final Paint rectPaint = Paint()..color = cAmber;
    canvas.drawRect(const Rect.fromLTWH(110, 40, 80, 50), rectPaint);
    final Path triPath = Path()
      ..moveTo(180, 130)
      ..lineTo(220, 90)
      ..lineTo(220, 130)
      ..close();
    final Paint triPaint = Paint()..color = cTeal;
    canvas.drawPath(triPath, triPaint);
    recordedPicture = recorder.endRecording();
    if (createdLayer != null) {
      createdLayer.picture = recordedPicture;
    }
    pictureRecordLog =
        'Recorded ui.Picture and assigned to layer.picture (non-null).';
  } catch (e) {
    pictureRecordLog = 'Picture record threw: $e';
  }

  // Inspect layer hints when available.
  bool isComplex = false;
  bool willChange = false;
  String layerToString = 'n/a';
  if (createdLayer != null) {
    isComplex = createdLayer.isComplexHint;
    willChange = createdLayer.willChangeHint;
    try {
      layerToString = createdLayer.toString();
    } catch (_) {
      layerToString = 'toString failed';
    }
  }

  // ---------------------------------------------------------------------------
  // Console narration.
  // ---------------------------------------------------------------------------
  print('=== PictureLayer visual demo ===');
  print(layerCreationLog);
  print(pictureRecordLog);
  print('isComplexHint: $isComplex  willChangeHint: $willChange');
  print('layer.toString -> $layerToString');

  // ---------------------------------------------------------------------------
  // Reusable section header.
  // ---------------------------------------------------------------------------
  Widget header(String tag, String title, Color accent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      margin: const EdgeInsets.only(top: 18, bottom: 10),
      decoration: BoxDecoration(
        color: cPanel,
        border: Border(left: BorderSide(color: accent, width: 4)),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(6),
          bottomRight: Radius.circular(6),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.2),
              border: Border.all(color: accent, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              tag,
              style: TextStyle(
                color: accent,
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: cInk,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Code snippet card.
  // ---------------------------------------------------------------------------
  Widget snippet(String code, Color accent) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(11),
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF0B0D13),
        border: Border.all(color: accent.withValues(alpha: 0.5)),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        code,
        style: const TextStyle(
          color: cInk,
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.45,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Hero header.
  // ---------------------------------------------------------------------------
  final Widget hero = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [cPlum.withValues(alpha: 0.35), cPanel],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: cPlum, width: 2),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: cAmber.withValues(alpha: 0.18),
                border: Border.all(color: cAmber, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'PL',
                  style: TextStyle(
                    color: cAmber,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PictureLayer',
                    style: TextStyle(
                      color: cInk,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'package:flutter/rendering.dart  -  leaf compositing layer',
                    style: TextStyle(
                      color: cInkDim,
                      fontSize: 12,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'A leaf Layer that holds a recorded ui.Picture. The compositor draws '
          'this picture into the scene at the position determined by ancestor '
          'OffsetLayer / TransformLayer nodes.',
          style: TextStyle(color: cInk, fontSize: 13, height: 1.5),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Section 1: Layer hierarchy diagram.
  // ---------------------------------------------------------------------------
  Widget node(String label, Color accent, {double width = 170}) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      margin: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
        color: cPanelAlt,
        border: Border.all(color: accent, width: 1.4),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: cInk,
          fontFamily: 'monospace',
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget arrow() => Container(
        margin: const EdgeInsets.symmetric(vertical: 1),
        child: const Text(
          '|',
          style: TextStyle(color: cSlate, fontSize: 14, fontFamily: 'monospace'),
        ),
      );

  final Widget hierarchyDiagram = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cPanel,
      border: Border.all(color: cBorder),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        node('Layer (abstract)', cInkDim, width: 220),
        arrow(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                node('ContainerLayer', cTeal),
                arrow(),
                node('OffsetLayer', cTeal),
                node('TransformLayer', cTeal),
                node('ClipRectLayer', cTeal),
                node('OpacityLayer', cTeal),
              ],
            ),
            Column(
              children: [
                node('PictureLayer', cAmber),
                node('TextureLayer', cRose),
                node('PerformanceOverlay', cRose, width: 200),
                node('PlatformViewLayer', cRose, width: 200),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          'Left branch = container/group layers. Right branch = leaf layers.',
          style: TextStyle(color: cInkDim, fontSize: 11),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Section 2: PictureLayer anatomy chips.
  // ---------------------------------------------------------------------------
  Widget anatomyChip(String name, String type, String desc, Color accent) {
    return Container(
      width: 250,
      padding: const EdgeInsets.all(11),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: cPanelAlt,
        border: Border.all(color: accent, width: 1.4),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: TextStyle(
                  color: accent,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                type,
                style: const TextStyle(
                  color: cInkDim,
                  fontFamily: 'monospace',
                  fontSize: 11,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            desc,
            style: const TextStyle(color: cInk, fontSize: 12, height: 1.35),
          ),
        ],
      ),
    );
  }

  final Widget anatomy = Wrap(
    children: [
      anatomyChip(
        'canvasBounds',
        'Rect',
        'Cull rect for the recorded picture; passed to the Canvas constructor '
            'and may help skip offscreen draw ops.',
        cAmber,
      ),
      anatomyChip(
        'picture',
        'ui.Picture?',
        'The recorded immutable drawing. Initially null; assigned after '
            'recording with a PictureRecorder.',
        cPlum,
      ),
      anatomyChip(
        'isComplexHint',
        'bool',
        'Hint to the compositor that this picture is expensive to rasterize, '
            'so caching is worthwhile.',
        cTeal,
      ),
      anatomyChip(
        'willChangeHint',
        'bool',
        'Hint that the picture will change soon; caching may be skipped to '
            'avoid wasted GPU work.',
        cRose,
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 3: Live recording. Render via RawImage if conversion succeeds,
  // otherwise show the layer.toString() and properties.
  // ---------------------------------------------------------------------------
  final Widget liveRecord = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cPanel,
      border: Border.all(color: cBorder),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recorded picture summary',
          style: TextStyle(
            color: cInk,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: bounds.width,
          height: bounds.height,
          decoration: BoxDecoration(
            color: cPanelAlt,
            border: Border.all(color: cPlum, width: 1.4),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 28,
                top: 48,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: cPlum,
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
              ),
              Positioned(
                left: 110,
                top: 40,
                child: Container(width: 80, height: 50, color: cAmber),
              ),
              const Positioned(
                right: 12,
                bottom: 12,
                child: Text(
                  'mock of recorded shapes',
                  style: TextStyle(
                    color: cInk,
                    fontSize: 10,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        snippet(
          '// recorded operations\n'
          'canvas.drawRect(bounds, bgPaint);\n'
          'canvas.drawCircle(Offset(60,80), 32, circlePaint);\n'
          'canvas.drawRect(Rect.fromLTWH(110,40,80,50), rectPaint);\n'
          'canvas.drawPath(triPath, triPaint);\n'
          'final picture = recorder.endRecording();\n'
          'layer.picture = picture;',
          cAmber,
        ),
        const SizedBox(height: 8),
        Text('layer.toString -> $layerToString',
            style: const TextStyle(
                color: cInkDim, fontFamily: 'monospace', fontSize: 11)),
        Text('record log -> $pictureRecordLog',
            style: const TextStyle(
                color: cInkDim, fontFamily: 'monospace', fontSize: 11)),
        Text(
            'picture is null? '
            '${recordedPicture == null}',
            style: const TextStyle(
                color: cInkDim, fontFamily: 'monospace', fontSize: 11)),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Section 4: Performance hints panel.
  // ---------------------------------------------------------------------------
  Widget hintCard(
      String name, bool value, String when, String effect, Color accent) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: cPanelAlt,
        border: Border.all(color: accent, width: 1.4),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                name,
                style: TextStyle(
                  color: accent,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Text(
                  '$value',
                  style: TextStyle(
                    color: accent,
                    fontFamily: 'monospace',
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text('when: $when',
              style: const TextStyle(color: cInk, fontSize: 12)),
          const SizedBox(height: 3),
          Text('effect: $effect',
              style: const TextStyle(color: cInkDim, fontSize: 12)),
        ],
      ),
    );
  }

  final Widget hintsPanel = Wrap(
    children: [
      hintCard(
        'isComplexHint',
        isComplex,
        'paint involves heavy gradients, shadows, many primitives',
        'compositor caches raster output between frames',
        cTeal,
      ),
      hintCard(
        'willChangeHint',
        willChange,
        'content is animating or about to change',
        'skip raster cache to avoid invalidation churn',
        cRose,
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 5: Container vs Leaf comparison table.
  // ---------------------------------------------------------------------------
  Widget compareRow(String aspect, String container, String leaf) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: Text(aspect,
                style: const TextStyle(
                    color: cAmber,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: Text(container,
                style: const TextStyle(color: cInk, fontSize: 12)),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: Text(leaf,
                style: const TextStyle(color: cInk, fontSize: 12)),
          ),
        ),
      ],
    );
  }

  final List<Widget> compareRows = <Widget>[];
  final List<List<String>> compareData = <List<String>>[
    <String>['role', 'groups child layers', 'holds drawn pixels'],
    <String>['has children', 'yes (firstChild/lastChild)', 'no — leaf'],
    <String>['typical', 'OffsetLayer, TransformLayer', 'PictureLayer, TextureLayer'],
    <String>['paint output', 'recursive composite', 'embedded ui.Picture'],
    <String>['cull bounds', 'depends on subtree', 'canvasBounds field'],
  ];
  for (int i = 0; i < compareData.length; i++) {
    final List<String> row = compareData[i];
    compareRows.add(compareRow(row[0], row[1], row[2]));
    if (i < compareData.length - 1) {
      compareRows.add(const Divider(color: cBorder, height: 1));
    }
  }

  final Widget comparison = Container(
    decoration: BoxDecoration(
      color: cPanel,
      border: Border.all(color: cBorder),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          decoration: const BoxDecoration(
            color: cPanelAlt,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
          child: Row(
            children: const [
              Expanded(
                  flex: 2,
                  child: Text('aspect',
                      style: TextStyle(
                          color: cInkDim,
                          fontFamily: 'monospace',
                          fontSize: 11))),
              Expanded(
                  flex: 3,
                  child: Text('ContainerLayer',
                      style: TextStyle(
                          color: cTeal,
                          fontFamily: 'monospace',
                          fontSize: 11))),
              Expanded(
                  flex: 3,
                  child: Text('PictureLayer (leaf)',
                      style: TextStyle(
                          color: cAmber,
                          fontFamily: 'monospace',
                          fontSize: 11))),
            ],
          ),
        ),
        Column(children: compareRows),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Section 6: Layer subclass reference list.
  // ---------------------------------------------------------------------------
  Widget subclassRow(String name, String kind, String summary, Color accent) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: cPanelAlt,
        border: Border(left: BorderSide(color: accent, width: 3)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 170,
            child: Text(name,
                style: TextStyle(
                    color: accent,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            width: 80,
            child: Text(kind,
                style: const TextStyle(
                    color: cInkDim, fontFamily: 'monospace', fontSize: 11)),
          ),
          Expanded(
            child: Text(summary,
                style: const TextStyle(color: cInk, fontSize: 12)),
          ),
        ],
      ),
    );
  }

  final List<List<String>> subclasses = <List<String>>[
    <String>['ContainerLayer', 'group', 'Generic parent that holds child layers.'],
    <String>['OffsetLayer', 'group', 'Translates its subtree by an offset; root of a render.'],
    <String>['TransformLayer', 'group', 'Applies a 4x4 matrix to its subtree.'],
    <String>['ClipRectLayer', 'group', 'Clips children to a rectangle.'],
    <String>['ClipRRectLayer', 'group', 'Clips children to a rounded rect.'],
    <String>['ClipPathLayer', 'group', 'Clips children to an arbitrary path.'],
    <String>['OpacityLayer', 'group', 'Applies alpha to child subtree.'],
    <String>['ShaderMaskLayer', 'group', 'Applies a shader mask over children.'],
    <String>['BackdropFilterLayer', 'group', 'Applies an image filter to backdrop.'],
    <String>['PictureLayer', 'leaf', 'Embeds a recorded ui.Picture (this demo).'],
    <String>['TextureLayer', 'leaf', 'Embeds a platform texture (e.g. video).'],
    <String>['PlatformViewLayer', 'leaf', 'Embeds a native platform view.'],
    <String>['PerformanceOverlayLayer', 'leaf', 'Renders the perf overlay HUD.'],
  ];
  final List<Widget> subRows = <Widget>[];
  for (int i = 0; i < subclasses.length; i++) {
    final List<String> r = subclasses[i];
    final Color acc = r[1] == 'group' ? cTeal : cAmber;
    subRows.add(subclassRow(r[0], r[1], r[2], acc));
  }

  // ---------------------------------------------------------------------------
  // Section 7: Canvas operation samples.
  // ---------------------------------------------------------------------------
  Widget opCard(String name, String code, String note, Color accent) {
    return Container(
      width: 320,
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: cPanelAlt,
        border: Border.all(color: accent, width: 1.3),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(name,
              style: TextStyle(
                  color: accent,
                  fontFamily: 'monospace',
                  fontSize: 13,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          snippet(code, accent),
          const SizedBox(height: 4),
          Text(note,
              style: const TextStyle(color: cInkDim, fontSize: 11)),
        ],
      ),
    );
  }

  final Widget opSamples = Wrap(
    children: [
      opCard(
        'drawRect',
        'canvas.drawRect(\n  Rect.fromLTWH(10,10,80,40),\n  Paint()..color = Color(0xFF9E5FB3),\n);',
        'Solid rectangle — cheap; commonly used for backgrounds.',
        cPlum,
      ),
      opCard(
        'drawCircle',
        'canvas.drawCircle(\n  Offset(50,50), 20,\n  Paint()..color = Color(0xFFE0A83C),\n);',
        'Anti-aliased circle. Useful for marker badges.',
        cAmber,
      ),
      opCard(
        'drawPath',
        'final p = Path()\n  ..moveTo(0,0)\n  ..lineTo(40,0)\n  ..lineTo(20,30)\n  ..close();\ncanvas.drawPath(p, Paint());',
        'Arbitrary closed/open paths; can mark isComplexHint=true.',
        cTeal,
      ),
      opCard(
        'drawParagraph',
        'final pb = ui.ParagraphBuilder(\n  ui.ParagraphStyle(textDirection: ui.TextDirection.ltr));\npb.addText(\'hello\');\ncanvas.drawParagraph(\n  pb.build()..layout(ui.ParagraphConstraints(width:120)),\n  Offset.zero,\n);',
        'Draws shaped text; expensive — set isComplexHint when used a lot.',
        cRose,
      ),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 8: Edge cases.
  // ---------------------------------------------------------------------------
  Widget edge(String label, String detail, Color accent) {
    return Container(
      width: 290,
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: cPanelAlt,
        border: Border.all(color: accent.withValues(alpha: 0.7), width: 1.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  color: accent,
                  fontFamily: 'monospace',
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(detail,
              style: const TextStyle(color: cInk, fontSize: 12, height: 1.4)),
        ],
      ),
    );
  }

  // Probe edge cases.
  String emptyBoundsLog;
  try {
    final PictureLayer empty = PictureLayer(Rect.zero);
    emptyBoundsLog = 'Rect.zero accepted; bounds=${empty.canvasBounds}';
  } catch (e) {
    emptyBoundsLog = 'Rect.zero ctor threw: $e';
  }

  String nullPictureLog;
  try {
    final PictureLayer nl = PictureLayer(bounds);
    final ui.Picture? p = nl.picture;
    nullPictureLog = 'New layer.picture starts as: $p';
  } catch (e) {
    nullPictureLog = 'null-picture probe threw: $e';
  }

  String hugeBoundsLog;
  try {
    final PictureLayer huge =
        PictureLayer(const Rect.fromLTWH(0, 0, 1.0e9, 1.0e9));
    hugeBoundsLog =
        'Huge bounds accepted: width=${huge.canvasBounds.width.toStringAsExponential(1)}';
  } catch (e) {
    hugeBoundsLog = 'huge bounds threw: $e';
  }

  final Widget edgeCases = Wrap(
    children: [
      edge('empty bounds', emptyBoundsLog, cAmber),
      edge('null picture', nullPictureLog, cPlum),
      edge('very large bounds', hugeBoundsLog, cTeal),
      edge('reassign picture',
          'Assigning a new ui.Picture replaces the previous one; the old picture is GC-eligible.',
          cRose),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 9: RepaintBoundary explainer.
  // ---------------------------------------------------------------------------
  final Widget repaintBoundary = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cPanel,
      border: Border.all(color: cBorder),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How a PictureLayer enters the tree',
          style: TextStyle(
              color: cInk, fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        const Text(
          'RenderObject.paint(PaintingContext context, Offset offset) calls '
          'context.canvas.drawXxx(...). Internally PaintingContext lazily '
          'creates a PictureLayer and a Canvas backed by a PictureRecorder. '
          'When a RepaintBoundary or transform/opacity is encountered, the '
          'context closes the current PictureLayer and pushes a new container '
          'layer (e.g. OffsetLayer / TransformLayer / OpacityLayer) before '
          'continuing.',
          style: TextStyle(color: cInk, fontSize: 12, height: 1.5),
        ),
        const SizedBox(height: 10),
        snippet(
          '// pseudo-code inside the framework\n'
          'final recorder = ui.PictureRecorder();\n'
          'final canvas   = Canvas(recorder, estimatedBounds);\n'
          '// renderObject.paint(canvas) draws here\n'
          'final picture  = recorder.endRecording();\n'
          'final layer    = PictureLayer(estimatedBounds);\n'
          'layer.picture  = picture;\n'
          'parentContainerLayer.append(layer);',
          cTeal,
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Section 10: Inspector / live values.
  // ---------------------------------------------------------------------------
  final List<List<String>> inspectorRows = <List<String>>[
    <String>['runtimeType', '${createdLayer?.runtimeType}'],
    <String>['canvasBounds', '${createdLayer?.canvasBounds}'],
    <String>['picture set?', '${createdLayer?.picture != null}'],
    <String>['isComplexHint', '$isComplex'],
    <String>['willChangeHint', '$willChange'],
    <String>['recordedPicture null?', '${recordedPicture == null}'],
  ];
  final List<Widget> inspectorWidgets = <Widget>[];
  for (int i = 0; i < inspectorRows.length; i++) {
    final List<String> ir = inspectorRows[i];
    inspectorWidgets.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 170,
            child: Text(ir[0],
                style: const TextStyle(
                    color: cAmber,
                    fontFamily: 'monospace',
                    fontSize: 12)),
          ),
          Expanded(
            child: Text(ir[1],
                style: const TextStyle(
                    color: cInk, fontFamily: 'monospace', fontSize: 12)),
          ),
        ],
      ),
    ));
  }

  final Widget inspector = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cPanel,
      border: Border.all(color: cBorder),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: inspectorWidgets,
    ),
  );

  // ---------------------------------------------------------------------------
  // Section 11: Paint pipeline timeline.
  // ---------------------------------------------------------------------------
  Widget timelineStep(int n, String phase, String detail, Color accent) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: cPanelAlt,
        border: Border(left: BorderSide(color: accent, width: 4)),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(5),
          bottomRight: Radius.circular(5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.25),
              border: Border.all(color: accent, width: 1.4),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                '$n',
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  phase,
                  style: TextStyle(
                    color: accent,
                    fontFamily: 'monospace',
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  detail,
                  style: const TextStyle(
                    color: cInk,
                    fontSize: 12,
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

  final List<List<String>> timelineData = <List<String>>[
    <String>[
      'build',
      'WidgetTree builds Elements; RenderObjects are created or updated.'
    ],
    <String>[
      'layout',
      'RenderObject.performLayout sizes each render box bottom-up.'
    ],
    <String>[
      'paint (record)',
      'PaintingContext.canvas.drawXxx(...) records into a PictureRecorder.'
    ],
    <String>[
      'closeRecorder',
      'PictureRecorder.endRecording() returns an immutable ui.Picture.'
    ],
    <String>[
      'wrap in PictureLayer',
      'Framework constructs PictureLayer(estimatedBounds) and assigns picture.'
    ],
    <String>[
      'append to parent',
      'PictureLayer is appended to a ContainerLayer (Offset/Transform/...).'
    ],
    <String>[
      'compositing',
      'Engine walks the layer tree and rasterizes each PictureLayer.'
    ],
    <String>[
      'present',
      'Composited surface is handed to the platform for display.'
    ],
  ];
  final List<Color> timelineAccents = <Color>[
    cTeal,
    cAmber,
    cPlum,
    cRose,
    cTeal,
    cAmber,
    cPlum,
    cRose,
  ];
  final List<Widget> timelineWidgets = <Widget>[];
  for (int i = 0; i < timelineData.length; i++) {
    timelineWidgets.add(timelineStep(
      i + 1,
      timelineData[i][0],
      timelineData[i][1],
      timelineAccents[i % timelineAccents.length],
    ));
  }
  final Widget timeline = Column(children: timelineWidgets);

  // ---------------------------------------------------------------------------
  // Section 12: ui.Picture vs ui.Image vs PictureLayer.
  // ---------------------------------------------------------------------------
  Widget compTriColumn(String title, Color accent, List<String> bullets) {
    final List<Widget> items = <Widget>[];
    for (int i = 0; i < bullets.length; i++) {
      items.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('-  ',
                style: TextStyle(
                    color: accent, fontFamily: 'monospace', fontSize: 12)),
            Expanded(
              child: Text(
                bullets[i],
                style: const TextStyle(color: cInk, fontSize: 12, height: 1.4),
              ),
            ),
          ],
        ),
      ));
    }
    return Container(
      width: 290,
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: cPanelAlt,
        border: Border.all(color: accent, width: 1.4),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: accent,
                fontFamily: 'monospace',
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          Column(children: items),
        ],
      ),
    );
  }

  final Widget tripleCompare = Wrap(
    children: [
      compTriColumn('ui.Picture', cTeal, <String>[
        'Immutable list of recorded canvas ops.',
        'Created from a PictureRecorder.',
        'Replayable; rasterized lazily by engine.',
        'Has dispose() — release recorder memory.',
      ]),
      compTriColumn('ui.Image', cAmber, <String>[
        'Decoded raster pixel grid.',
        'Created from codec or Picture.toImage.',
        'Has fixed width/height in pixels.',
        'Lives on GPU once uploaded.',
      ]),
      compTriColumn('PictureLayer', cPlum, <String>[
        'Compositing tree node holding a Picture.',
        'Carries canvasBounds + hint flags.',
        'Inserted by PaintingContext / RepaintBoundary.',
        'Owned by parent ContainerLayer.',
      ]),
    ],
  );

  // ---------------------------------------------------------------------------
  // Section 13: Raster cache explainer.
  // ---------------------------------------------------------------------------
  final Widget rasterCache = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cPanel,
      border: Border.all(color: cBorder),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Raster cache and the hint flags',
          style: TextStyle(
              color: cInk, fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 6),
        const Text(
          'The Flutter engine maintains a raster cache of pre-rasterized '
          'PictureLayers and ContainerLayers. A PictureLayer is a candidate '
          'for caching when isComplexHint is true and willChangeHint is '
          'false. The cache stores GPU textures keyed by layer identity and '
          'transform; on subsequent frames the engine blits the texture '
          'instead of replaying the picture.',
          style: TextStyle(color: cInk, fontSize: 12, height: 1.5),
        ),
        const SizedBox(height: 10),
        snippet(
          '// Heuristic used by the engine (simplified)\n'
          'shouldCache(PictureLayer l) =>\n'
          '    l.isComplexHint == true\n'
          '    && l.willChangeHint == false\n'
          '    && pictureCost(l.picture) > threshold;',
          cAmber,
        ),
        const SizedBox(height: 8),
        const Text(
          'RepaintBoundary widgets force their subtree into a separate '
          'PictureLayer (or container layer subtree), making this caching '
          'decision local to the boundary instead of the whole screen.',
          style: TextStyle(color: cInkDim, fontSize: 12, height: 1.5),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Section 14: Lifecycle and disposal.
  // ---------------------------------------------------------------------------
  Widget lifeRow(String stage, String desc, Color accent) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: cPanelAlt,
        border: Border(left: BorderSide(color: accent, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              stage,
              style: TextStyle(
                color: accent,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(desc,
                style: const TextStyle(
                    color: cInk, fontSize: 12, height: 1.45)),
          ),
        ],
      ),
    );
  }

  final List<List<String>> lifeData = <List<String>>[
    <String>[
      'construct',
      'PictureLayer(canvasBounds) — bounds passed for cull / cache key.'
    ],
    <String>[
      'attach',
      'Layer.attach is called when the layer joins a live tree (owner != null).'
    ],
    <String>[
      'set picture',
      'layer.picture = recorder.endRecording(); replaces previous picture.'
    ],
    <String>[
      'addToScene',
      'During flushPaint, addToScene(SceneBuilder) emits this picture.'
    ],
    <String>[
      'detach',
      'When removed, Layer.detach drops the owner reference.'
    ],
    <String>[
      'dispose',
      'Layer.dispose / picture.dispose release engine-side memory.'
    ],
  ];
  final List<Color> lifeAccents = <Color>[
    cTeal,
    cAmber,
    cPlum,
    cRose,
    cTeal,
    cAmber
  ];
  final List<Widget> lifeWidgets = <Widget>[];
  for (int i = 0; i < lifeData.length; i++) {
    lifeWidgets.add(
        lifeRow(lifeData[i][0], lifeData[i][1], lifeAccents[i % lifeAccents.length]));
  }
  final Widget lifecycle = Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cPanel,
      border: Border.all(color: cBorder),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(children: lifeWidgets),
  );

  // ---------------------------------------------------------------------------
  // Section 15: Common pitfalls.
  // ---------------------------------------------------------------------------
  final List<List<String>> pitfallData = <List<String>>[
    <String>[
      'using Canvas after endRecording',
      'After recorder.endRecording(), the Canvas is finalized. Calling drawXxx '
          'is undefined. Always treat the Canvas as scoped to a single record.'
    ],
    <String>[
      'forgetting to assign picture',
      'A PictureLayer with picture==null contributes nothing to the scene. '
          'Make sure to call layer.picture = recorder.endRecording().'
    ],
    <String>[
      'wrong canvasBounds',
      'Bounds smaller than the actual draw area cause clipping; far larger '
          'bounds defeat culling. Match the visible region.'
    ],
    <String>[
      'mutating after attach',
      'Reassigning picture on a layer in a live tree should be followed by '
          'markNeedsAddToScene; the framework handles this, but custom code '
          'must too.'
    ],
    <String>[
      'manual disposal',
      'PictureLayer holds the ui.Picture; dispose the Picture only when the '
          'layer is no longer used to avoid use-after-free at composite time.'
    ],
  ];
  final List<Widget> pitfallWidgets = <Widget>[];
  for (int i = 0; i < pitfallData.length; i++) {
    pitfallWidgets.add(Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: cPanelAlt,
        border: Border.all(color: cRose.withValues(alpha: 0.7), width: 1.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 22,
            height: 22,
            margin: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: cRose.withValues(alpha: 0.25),
              border: Border.all(color: cRose, width: 1.2),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Center(
              child: Text(
                '!',
                style: TextStyle(
                  color: cRose,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(pitfallData[i][0],
                    style: const TextStyle(
                        color: cRose,
                        fontFamily: 'monospace',
                        fontSize: 12,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 3),
                Text(pitfallData[i][1],
                    style: const TextStyle(
                        color: cInk, fontSize: 12, height: 1.45)),
              ],
            ),
          ),
        ],
      ),
    ));
  }
  final Widget pitfalls = Column(children: pitfallWidgets);

  // ---------------------------------------------------------------------------
  // Section 16: Imports / API quick reference.
  // ---------------------------------------------------------------------------
  final Widget apiRef = Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: cPanel,
      border: Border.all(color: cBorder),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'API quick reference',
          style: TextStyle(
              color: cInk, fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        snippet(
          "import 'dart:ui' as ui;\n"
          "import 'package:flutter/rendering.dart';\n\n"
          '// ctor\n'
          'PictureLayer(Rect canvasBounds);\n\n'
          '// fields\n'
          'Rect get canvasBounds;\n'
          'ui.Picture? picture;\n'
          'bool isComplexHint;\n'
          'bool willChangeHint;\n\n'
          '// inherited from Layer\n'
          'Object? get owner;\n'
          'Layer? get parent;\n'
          'Layer? get nextSibling;\n'
          'Layer? get previousSibling;\n'
          'void remove();\n'
          'void markNeedsAddToScene();',
          cTeal,
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Section 17: Glossary of related types.
  // ---------------------------------------------------------------------------
  final List<List<String>> glossary = <List<String>>[
    <String>['ui.Picture', 'Immutable recorded sequence of canvas operations.'],
    <String>['ui.PictureRecorder', 'Factory for ui.Picture; pairs with a Canvas.'],
    <String>['Canvas', 'Mutable drawing target backed by a recorder or surface.'],
    <String>['SceneBuilder', 'Builds a Scene from a tree of EngineLayer handles.'],
    <String>['Scene', 'Engine-side composited frame ready for present.'],
    <String>['Layer', 'Abstract base of all compositing nodes.'],
    <String>['ContainerLayer', 'Abstract base of layers that have child layers.'],
    <String>['PaintingContext', 'Helper that wires Canvas, recorders, layers.'],
    <String>['RepaintBoundary', 'Widget that forces its subtree into its own layer.'],
    <String>['RenderRepaintBoundary', 'RenderObject form; manages an OffsetLayer.'],
  ];
  final List<Widget> glossaryWidgets = <Widget>[];
  for (int i = 0; i < glossary.length; i++) {
    glossaryWidgets.add(Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: cPanelAlt,
        border: Border(left: BorderSide(color: cSlate, width: 3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 200,
            child: Text(glossary[i][0],
                style: const TextStyle(
                    color: cAmber,
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text(glossary[i][1],
                style: const TextStyle(
                    color: cInk, fontSize: 12, height: 1.45)),
          ),
        ],
      ),
    ));
  }
  final Widget glossaryWidget = Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cPanel,
      border: Border.all(color: cBorder),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(children: glossaryWidgets),
  );

  // ---------------------------------------------------------------------------
  // Footer.
  // ---------------------------------------------------------------------------
  final Widget footer = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cPanelAlt,
      border: Border.all(color: cSlate),
      borderRadius: BorderRadius.circular(6),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PictureLayer — leaf of the rendering layer tree',
          style: TextStyle(
              color: cInk, fontSize: 13, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 4),
        Text(
          'Hand-author demo for d4rt: instantiate PictureLayer, record a '
          'ui.Picture via PictureRecorder, assign it to layer.picture, and '
          'inspect canvasBounds / hint flags. No subclassing of Layer; the '
          'concrete PictureLayer constructor is wrapped in try/catch.',
          style: TextStyle(color: cInkDim, fontSize: 11, height: 1.5),
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------------------
  // Compose the page.
  // ---------------------------------------------------------------------------
  return Scaffold(
    backgroundColor: cBg,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          hero,
          header('1', 'Layer class hierarchy', cTeal),
          hierarchyDiagram,
          header('2', 'PictureLayer anatomy', cAmber),
          anatomy,
          header('3', 'Live PictureRecorder demo', cPlum),
          liveRecord,
          header('4', 'Performance hints', cRose),
          hintsPanel,
          header('5', 'Container vs leaf layers', cTeal),
          comparison,
          header('6', 'All Layer subclasses', cAmber),
          Column(children: subRows),
          header('7', 'Canvas operation samples', cPlum),
          opSamples,
          header('8', 'Edge cases', cRose),
          edgeCases,
          header('9', 'RepaintBoundary and PaintingContext', cTeal),
          repaintBoundary,
          header('10', 'Live inspector', cAmber),
          inspector,
          header('11', 'Paint pipeline timeline', cPlum),
          timeline,
          header('12', 'Picture vs Image vs PictureLayer', cTeal),
          tripleCompare,
          header('13', 'Raster cache and hint flags', cAmber),
          rasterCache,
          header('14', 'Layer lifecycle', cRose),
          lifecycle,
          header('15', 'Common pitfalls', cPlum),
          pitfalls,
          header('16', 'API quick reference', cTeal),
          apiRef,
          header('17', 'Glossary of related types', cAmber),
          glossaryWidget,
          const SizedBox(height: 18),
          footer,
        ],
      ),
    ),
  );
}
