// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: the layer tree - compositor's stacked cel sheets.
// Each section profiles a layer type through the widget that produces it,
// alongside an ASCII stacked-cel diagram of the resulting layer tree.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

// ============================================================================
// PALETTE - "Compositor pipeline / animation cel sheets"
// ============================================================================
// near-black studio  : #0B0D10
// studio panel       : #14181D
// cel sheet (glass)  : #1F252C
// warm amber light   : #FFB347
// amber deep         : #C97A20
// electric cyan      : #29E6F2
// cyan deep          : #0E96A6
// dust on glass      : #6E7682
// ink                : #E8EDF2
// muted ink          : #95A1AD
// danger crimson     : #E04A4A
// success teal       : #2BB897
// gridline           : #232A33

const Color cBlack = Color(0xFF0B0D10);
const Color cPanel = Color(0xFF14181D);
const Color cGlass = Color(0xFF1F252C);
const Color cGlassLight = Color(0xFF2A323B);
const Color cAmber = Color(0xFFFFB347);
const Color cAmberDeep = Color(0xFFC97A20);
const Color cCyan = Color(0xFF29E6F2);
const Color cCyanDeep = Color(0xFF0E96A6);
const Color cDust = Color(0xFF6E7682);
const Color cInk = Color(0xFFE8EDF2);
const Color cMuted = Color(0xFF95A1AD);
const Color cDanger = Color(0xFFE04A4A);
const Color cSuccess = Color(0xFF2BB897);
const Color cGrid = Color(0xFF232A33);
const Color cGlassEdge = Color(0xFF3A4450);

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: cBlack,
      fontFamily: 'monospace',
    ),
    home: Scaffold(
      backgroundColor: cBlack,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildHero(),
            SizedBox(height: 28.0),
            _buildConceptOverview(),
            SizedBox(height: 28.0),
            _buildFamilyDiagram(),
            SizedBox(height: 28.0),
            _buildOffsetLayer(),
            SizedBox(height: 28.0),
            _buildClipRectLayer(),
            SizedBox(height: 28.0),
            _buildClipRRectLayer(),
            SizedBox(height: 28.0),
            _buildClipPathLayer(),
            SizedBox(height: 28.0),
            _buildOpacityLayer(),
            SizedBox(height: 28.0),
            _buildShaderMaskLayer(),
            SizedBox(height: 28.0),
            _buildColorFilterLayer(),
            SizedBox(height: 28.0),
            _buildImageFilterLayer(),
            SizedBox(height: 28.0),
            _buildTransformLayer(),
            SizedBox(height: 28.0),
            _buildBackdropFilterLayer(),
            SizedBox(height: 28.0),
            _buildLeaderFollowerLayer(),
            SizedBox(height: 28.0),
            _buildAnnotatedRegionLayer(),
            SizedBox(height: 28.0),
            _buildPictureLayer(),
            SizedBox(height: 28.0),
            _buildTextureAndPlatformView(),
            SizedBox(height: 28.0),
            _buildRepaintBoundarySection(),
            SizedBox(height: 28.0),
            _buildLayerTreeVisualisation(),
            SizedBox(height: 28.0),
            _buildRecipeCards(),
            SizedBox(height: 28.0),
            _buildComparisonTable(),
            SizedBox(height: 28.0),
            _buildPitfalls(),
            SizedBox(height: 28.0),
            _buildGlossary(),
            SizedBox(height: 28.0),
            _buildEpilogue(),
            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// SECTION 1: HERO HEADER
// ============================================================================
Widget _buildHero() {
  return Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[cPanel, cBlack, Color(0xFF1A1108)],
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: cAmberDeep, width: 1.2),
      boxShadow: <BoxShadow>[
        BoxShadow(color: Color(0x44FFB347), blurRadius: 28.0, spreadRadius: 1.0),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 56.0,
              height: 56.0,
              decoration: BoxDecoration(
                color: cGlass,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: cAmber, width: 1.4),
              ),
              child: Center(
                child: Text(
                  '\u25A4',
                  style: TextStyle(color: cAmber, fontSize: 28.0),
                ),
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'LAYER TREE',
                    style: TextStyle(
                      color: cAmber,
                      fontSize: 13.0,
                      letterSpacing: 6.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Text(
                    "the compositor's stack",
                    style: TextStyle(
                      color: cInk,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
            _heroBadge('rendering'),
            SizedBox(width: 6.0),
            _heroBadge('compositor'),
          ],
        ),
        SizedBox(height: 18.0),
        Container(height: 1.0, color: cGlassEdge),
        SizedBox(height: 14.0),
        Text(
          'Each cel sheet is a Layer; the engine stacks them above a light '
          'table to produce a frame. Below: every concrete Layer profiled '
          'through the widget that synthesises it.',
          style: TextStyle(color: cMuted, fontSize: 14.0, height: 1.5),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            _heroChip('18 layer types'),
            _heroChip('23 sections'),
            _heroChip('cel-sheet diagrams'),
            _heroChip('cost classes'),
            _heroChip('6 recipes'),
            _heroChip('15+ glossary terms'),
          ],
        ),
      ],
    ),
  );
}

Widget _heroBadge(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: cGlass,
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: cCyanDeep, width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: cCyan,
        fontSize: 10.0,
        letterSpacing: 2.0,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}

Widget _heroChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Color(0x22FFB347),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: cAmberDeep, width: 0.8),
    ),
    child: Text(
      label,
      style: TextStyle(color: cAmber, fontSize: 11.0, fontWeight: FontWeight.w600),
    ),
  );
}

// ============================================================================
// COMMON SECTION FRAME
// ============================================================================
Widget _section(String number, String title, String subtitle, Widget body) {
  return Container(
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      color: cPanel,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: cGlassEdge, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                color: cAmber,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                number,
                style: TextStyle(
                  color: cBlack,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      color: cInk,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if (subtitle.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 2.0),
                      child: Text(
                        subtitle,
                        style: TextStyle(color: cMuted, fontSize: 12.0),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(height: 1.0, color: cGrid),
        SizedBox(height: 16.0),
        body,
      ],
    ),
  );
}

Widget _anatomyCard({
  required String name,
  required String oneLiner,
  required List<List<String>> rows,
  Color accent = cCyan,
}) {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: cGlass,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: accent.withOpacity(0.45), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 8.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: accent,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              name,
              style: TextStyle(
                color: accent,
                fontSize: 14.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          oneLiner,
          style: TextStyle(color: cMuted, fontSize: 12.0, height: 1.4),
        ),
        SizedBox(height: 10.0),
        Container(height: 1.0, color: cGrid),
        SizedBox(height: 10.0),
        ...rows.map(_anatomyRow),
      ],
    ),
  );
}

Widget _anatomyRow(List<String> row) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 120.0,
          child: Text(
            row[0],
            style: TextStyle(
              color: cCyan,
              fontSize: 11.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ),
        Expanded(
          child: Text(
            row.length > 1 ? row[1] : '',
            style: TextStyle(color: cInk, fontSize: 11.5, height: 1.45),
          ),
        ),
      ],
    ),
  );
}

Widget _celDiagram(List<_Cel> cels) {
  return Container(
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      color: cBlack,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: cAmberDeep, width: 0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              '\u25A4 STACKED CEL DIAGRAM',
              style: TextStyle(
                color: cAmber,
                fontSize: 10.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 2.0,
              ),
            ),
            Spacer(),
            Text(
              'top \u2191',
              style: TextStyle(color: cDust, fontSize: 10.0),
            ),
          ],
        ),
        SizedBox(height: 10.0),
        ..._stackCels(cels),
        SizedBox(height: 6.0),
        Row(
          children: <Widget>[
            Text(
              'light table',
              style: TextStyle(color: cDust, fontSize: 10.0),
            ),
            SizedBox(width: 6.0),
            Expanded(
              child: Container(
                height: 4.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[Color(0x66FFB347), Color(0x22FFB347), Color(0x66FFB347)],
                  ),
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

List<Widget> _stackCels(List<_Cel> cels) {
  final List<Widget> widgets = <Widget>[];
  for (int i = 0; i < cels.length; i++) {
    final _Cel cel = cels[i];
    final double indent = i * 8.0;
    widgets.add(
      Padding(
        padding: EdgeInsets.only(left: indent, top: i == 0 ? 0.0 : 4.0),
        child: _celRow(cel, i, cels.length),
      ),
    );
  }
  return widgets;
}

Widget _celRow(_Cel cel, int index, int total) {
  final Color border = cel.color;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: cGlass,
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: border, width: 1.0),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 22.0,
          height: 22.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: border.withOpacity(0.18),
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Text(
            '${total - index}',
            style: TextStyle(
              color: border,
              fontSize: 11.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Text(
          cel.layer,
          style: TextStyle(
            color: cInk,
            fontSize: 12.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            cel.note,
            style: TextStyle(color: cMuted, fontSize: 11.0),
          ),
        ),
      ],
    ),
  );
}

class _Cel {
  final String layer;
  final String note;
  final Color color;
  const _Cel(this.layer, this.note, this.color);
}

Widget _specimenFrame({required String title, required Widget child, String? caption}) {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: cGlass,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: cAmberDeep, width: 0.8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 6.0,
              height: 14.0,
              decoration: BoxDecoration(
                color: cAmber,
                borderRadius: BorderRadius.circular(1.5),
              ),
            ),
            SizedBox(width: 8.0),
            Text(
              title,
              style: TextStyle(
                color: cAmber,
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.4,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Center(child: child),
        if (caption != null) ...<Widget>[
          SizedBox(height: 10.0),
          Text(
            caption,
            style: TextStyle(color: cMuted, fontSize: 11.0, height: 1.4),
          ),
        ],
      ],
    ),
  );
}

Widget _codeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: cBlack,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: cGrid, width: 1.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        color: cCyan,
        fontSize: 11.5,
        height: 1.55,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _paragraph(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 8.0),
    child: Text(
      text,
      style: TextStyle(color: cInk, fontSize: 13.0, height: 1.55),
    ),
  );
}

// ============================================================================
// SECTION 2: CONCEPT OVERVIEW
// ============================================================================
Widget _buildConceptOverview() {
  return _section(
    '02',
    'Widget vs RenderObject vs Layer',
    'three tiers of the rendering pipeline',
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(child: _conceptTier(
              tier: 'WIDGET',
              role: 'configuration',
              detail: 'Immutable description of a UI element. Cheap to '
                  'create and discard. Rebuilt frequently from setState '
                  'and InheritedWidgets.',
              color: cCyan,
              icon: '\u25C7',
            )),
            SizedBox(width: 12.0),
            Expanded(child: _conceptTier(
              tier: 'RENDEROBJECT',
              role: 'layout + paint',
              detail: 'Mutable, retained, holds layout constraints and '
                  'size. Each frame: layout pass, paint pass into a '
                  'PaintingContext. Rare to recreate.',
              color: cAmber,
              icon: '\u25A3',
            )),
            SizedBox(width: 12.0),
            Expanded(child: _conceptTier(
              tier: 'LAYER',
              role: 'composition',
              detail: 'A node in the layer tree, output of painting. The '
                  'engine composites layers via SceneBuilder to produce '
                  'the final raster.',
              color: cSuccess,
              icon: '\u25A4',
            )),
          ],
        ),
        SizedBox(height: 18.0),
        Container(height: 1.0, color: cGrid),
        SizedBox(height: 14.0),
        Text(
          'When are layers created?',
          style: TextStyle(
            color: cAmber,
            fontSize: 13.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
        SizedBox(height: 8.0),
        _paragraph(
          'Not every RenderObject creates a Layer. A Layer is added only '
          'when the painting needs an isolated boundary or a saveLayer-style '
          'compositing operation:',
        ),
        _bullet('RepaintBoundary forces an OffsetLayer cut so its subtree '
            'can repaint independently'),
        _bullet('Opacity below 1.0 forces an OpacityLayer (saveLayer)'),
        _bullet('ClipRect / ClipRRect / ClipPath produce a Clip*Layer'),
        _bullet('Transform with a non-axis-aligned matrix forces a TransformLayer'),
        _bullet('BackdropFilter forces a BackdropFilterLayer that samples '
            'the underlying scene'),
        _bullet('CustomPaint without RepaintBoundary records into the '
            'parent PictureLayer'),
        SizedBox(height: 14.0),
        _codeBlock(
          'PaintingContext.paintChild(child, offset);\n'
          '// Internally:\n'
          '//   if (child.isRepaintBoundary)\n'
          '//     _compositeChild(child, offset);\n'
          '//   else\n'
          '//     child._paintWithContext(this, offset);\n'
          '\n'
          'PaintingContext.pushOpacity(offset, alpha, painter);\n'
          'PaintingContext.pushClipRect(needsCompositing, offset, rect, painter);\n'
          'PaintingContext.pushTransform(needsCompositing, offset, matrix, painter);',
        ),
        SizedBox(height: 12.0),
        Text(
          'Why minimise layer count?',
          style: TextStyle(
            color: cAmber,
            fontSize: 13.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
        SizedBox(height: 8.0),
        _paragraph(
          'Each composited layer is a separate render target on the GPU. '
          'saveLayer / restore pairs allocate an offscreen surface that must '
          'be allocated, drawn into, then composited back. On mobile GPUs '
          'with tile-based rendering this can be expensive. Aim for a layer '
          'tree as flat as your effects allow.',
        ),
      ],
    ),
  );
}

Widget _conceptTier({
  required String tier,
  required String role,
  required String detail,
  required Color color,
  required String icon,
}) {
  return Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: cGlass,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withOpacity(0.5), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(
              icon,
              style: TextStyle(color: color, fontSize: 22.0),
            ),
            SizedBox(width: 10.0),
            Text(
              tier,
              style: TextStyle(
                color: color,
                fontSize: 13.0,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          role,
          style: TextStyle(color: cMuted, fontSize: 11.0, fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 10.0),
        Text(
          detail,
          style: TextStyle(color: cInk, fontSize: 12.0, height: 1.5),
        ),
      ],
    ),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.0, left: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 4.0, right: 8.0),
          child: Container(
            width: 5.0,
            height: 5.0,
            decoration: BoxDecoration(color: cAmber, shape: BoxShape.circle),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: cInk, fontSize: 12.5, height: 1.45),
          ),
        ),
      ],
    ),
  );
}
// ============================================================================
// SECTION 3: LAYER FAMILY DIAGRAM
// ============================================================================
Widget _buildFamilyDiagram() {
  return _section(
    '03',
    'Layer family',
    'inheritance tree of the concrete Layer types',
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: cBlack,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: cGlassEdge, width: 1.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _familyRoot('Layer', 'abstract base'),
              SizedBox(height: 8.0),
              _familyBranch(0, 'ContainerLayer', 'has children'),
              _familyBranch(1, 'PictureLayer', 'leaf, holds a Picture'),
              _familyBranch(1, 'TextureLayer', 'leaf, GPU texture handle'),
              _familyBranch(1, 'PlatformViewLayer', 'leaf, native view embed'),
              SizedBox(height: 8.0),
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text(
                  'ContainerLayer descendants:',
                  style: TextStyle(color: cMuted, fontSize: 11.0),
                ),
              ),
              _familyBranch(2, 'OffsetLayer', 'translation + RepaintBoundary cut'),
              _familyBranch(3, 'ClipRectLayer', 'axis-aligned rectangular clip'),
              _familyBranch(3, 'ClipRRectLayer', 'rounded-rect clip'),
              _familyBranch(3, 'ClipPathLayer', 'arbitrary path clip'),
              _familyBranch(3, 'OpacityLayer', 'alpha composite (saveLayer)'),
              _familyBranch(3, 'ShaderMaskLayer', 'shader-masked composite'),
              _familyBranch(3, 'ColorFilterLayer', 'color matrix / mode'),
              _familyBranch(3, 'ImageFilterLayer', 'blur, dilate, erode...'),
              _familyBranch(3, 'TransformLayer', '4x4 matrix transform'),
              _familyBranch(3, 'BackdropFilterLayer', 'samples scene below'),
              _familyBranch(3, 'LeaderLayer', 'anchor point for followers'),
              _familyBranch(3, 'FollowerLayer', 'positioned relative to a leader'),
              _familyBranch(3, 'AnnotatedRegionLayer<T>', 'attaches metadata to a region'),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: <Widget>[
            _familyLegend('Container', cAmber),
            _familyLegend('Leaf', cCyan),
            _familyLegend('Effect', cSuccess),
            _familyLegend('Positional', cAmberDeep),
          ],
        ),
      ],
    ),
  );
}

Widget _familyRoot(String name, String tag) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: cAmber,
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Row(
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            color: cBlack,
            fontSize: 14.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(width: 12.0),
        Text(
          tag,
          style: TextStyle(
            color: Color(0xCC0B0D10),
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _familyBranch(int depth, String name, String tag) {
  final String indent = '  ' * depth;
  final String prefix = '$indent\u2514\u2500 ';
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Text.rich(
      TextSpan(
        children: <InlineSpan>[
          TextSpan(
            text: prefix,
            style: TextStyle(color: cDust, fontSize: 12.0),
          ),
          TextSpan(
            text: name,
            style: TextStyle(
              color: cCyan,
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(
            text: '   $tag',
            style: TextStyle(color: cMuted, fontSize: 11.0),
          ),
        ],
      ),
    ),
  );
}

Widget _familyLegend(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: cGlass,
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: color, width: 1.0),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(width: 8.0, height: 8.0, color: color),
        SizedBox(width: 6.0),
        Text(label, style: TextStyle(color: cInk, fontSize: 11.0)),
      ],
    ),
  );
}
// ============================================================================
// SECTION 4: OFFSETLAYER
// ============================================================================
Widget _buildOffsetLayer() {
  return _section(
    '04',
    'OffsetLayer',
    'translation + the RepaintBoundary cut',
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _anatomyCard(
                name: 'OffsetLayer',
                oneLiner: 'A ContainerLayer subclass that translates its '
                    'children by an Offset. This is also the layer type '
                    'inserted at every RepaintBoundary cut.',
                rows: <List<String>>[
                  <String>['extends', 'ContainerLayer'],
                  <String>['offset', 'Offset to translate child rasters'],
                  <String>['scrollOffset', 'optional viewport scroll correction'],
                  <String>['produced by', 'RepaintBoundary, root render view'],
                  <String>['cost class', 'cheap (no saveLayer)'],
                  <String>['stops backdrop?', 'no'],
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              flex: 1,
              child: _celDiagram(<_Cel>[
                _Cel('OffsetLayer', 'translated subtree', cAmber),
                _Cel('PictureLayer', 'translated child paints', cCyan),
              ]),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _specimenFrame(
          title: 'SPECIMEN  RepaintBoundary + Transform.translate',
          caption: 'The RepaintBoundary inserts an OffsetLayer; the '
              'Transform.translate also produces an OffsetLayer when its '
              'matrix collapses to a pure translation.',
          child: Container(
            height: 180.0,
            width: 360.0,
            decoration: BoxDecoration(
              color: cBlack,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: cGrid),
            ),
            child: Stack(
              children: <Widget>[
                Positioned.fill(child: _gridBackground()),
                Center(
                  child: RepaintBoundary(
                    child: Transform.translate(
                      offset: Offset(40.0, -20.0),
                      child: Container(
                        width: 110.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: cAmber,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'OFFSET',
                          style: TextStyle(
                            color: cBlack,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 14.0),
        _codeBlock(
          'RepaintBoundary(\n'
          '  child: Transform.translate(\n'
          '    offset: Offset(40, -20),\n'
          '    child: child,\n'
          '  ),\n'
          ');\n'
          '// layer tree:\n'
          '//   OffsetLayer  (RepaintBoundary cut)\n'
          '//     OffsetLayer  (Transform.translate, axis-aligned)\n'
          '//       PictureLayer  (Container paints)',
        ),
      ],
    ),
  );
}

Widget _gridBackground() {
  return CustomPaint(
    painter: _GridPainter(),
  );
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = cGrid
      ..strokeWidth = 0.6;
    const double step = 16.0;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), p);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), p);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
// ============================================================================
// SECTION 5: CLIPRECTLAYER
// ============================================================================
Widget _buildClipRectLayer() {
  return _section(
    '05',
    'ClipRectLayer',
    'axis-aligned rectangular clip',
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _anatomyCard(
                name: 'ClipRectLayer',
                oneLiner: 'Clips its children to a rectangle. The cheapest '
                    'clip operation in the engine.',
                rows: <List<String>>[
                  <String>['extends', 'ContainerLayer'],
                  <String>['clipRect', 'Rect in parent-coordinate space'],
                  <String>['clipBehavior', 'antiAlias / hardEdge / antiAliasWithSaveLayer'],
                  <String>['produced by', 'ClipRect, OverflowBox, Viewport'],
                  <String>['cost class', 'cheap'],
                  <String>['stops backdrop?', 'no (unless saveLayer mode)'],
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _celDiagram(<_Cel>[
                _Cel('ClipRectLayer', 'clipRect: Rect.fromLTWH(...)', cAmber),
                _Cel('PictureLayer', 'oversized child clipped to box', cCyan),
              ]),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _specimenFrame(
          title: 'SPECIMEN  ClipRect around oversized content',
          caption: 'The inner Container is 240 wide but only 140 is visible; '
              'the rest is clipped by the ClipRectLayer.',
          child: ClipRect(
            child: SizedBox(
              width: 140.0,
              height: 90.0,
              child: OverflowBox(
                maxWidth: 240.0,
                child: Container(
                  width: 240.0,
                  height: 90.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[cAmber, cDanger, cCyan],
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'clipped by ClipRect \u2192',
                    style: TextStyle(color: cBlack, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
// ============================================================================
// SECTION 6: CLIPRRECTLAYER
// ============================================================================
Widget _buildClipRRectLayer() {
  return _section(
    '06',
    'ClipRRectLayer',
    'rounded-rectangle clip',
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _anatomyCard(
                name: 'ClipRRectLayer',
                oneLiner: 'Clips its children to a rounded rectangle. '
                    'The compositor uses fast hardware rounded-rect masking.',
                rows: <List<String>>[
                  <String>['extends', 'ContainerLayer'],
                  <String>['clipRRect', 'RRect with per-corner radii'],
                  <String>['clipBehavior', 'antiAlias is the default'],
                  <String>['produced by', 'ClipRRect, Material(shape:)'],
                  <String>['cost class', 'cheap-to-moderate'],
                  <String>['stops backdrop?', 'no'],
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _celDiagram(<_Cel>[
                _Cel('ClipRRectLayer', 'rounded mask', cAmber),
                _Cel('PictureLayer', 'card paints, corners hidden', cCyan),
              ]),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _specimenFrame(
          title: 'SPECIMEN  three corner-radius regimes',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _rrSpecimen(BorderRadius.circular(6.0), 'r=6'),
              _rrSpecimen(BorderRadius.circular(20.0), 'r=20'),
              _rrSpecimen(
                BorderRadius.only(
                  topLeft: Radius.circular(24.0),
                  bottomRight: Radius.circular(24.0),
                ),
                'asymmetric',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _rrSpecimen(BorderRadius radius, String label) {
  return Column(
    children: <Widget>[
      ClipRRect(
        borderRadius: radius,
        child: Container(
          width: 90.0,
          height: 90.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[cAmber, cAmberDeep],
            ),
          ),
          alignment: Alignment.center,
          child: Text(
            'clipped',
            style: TextStyle(color: cBlack, fontWeight: FontWeight.w700, fontSize: 11.0),
          ),
        ),
      ),
      SizedBox(height: 6.0),
      Text(label, style: TextStyle(color: cMuted, fontSize: 10.0)),
    ],
  );
}
// ============================================================================
// SECTION 7: CLIPPATHLAYER
// ============================================================================
Widget _buildClipPathLayer() {
  return _section(
    '07',
    'ClipPathLayer',
    'arbitrary-path clipping (more expensive)',
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _anatomyCard(
                name: 'ClipPathLayer',
                oneLiner: 'Clips to a general Path. The engine cannot use '
                    'simple hardware masking - the path is tessellated and '
                    'applied as a stencil.',
                rows: <List<String>>[
                  <String>['extends', 'ContainerLayer'],
                  <String>['clipPath', 'a ui.Path of any shape'],
                  <String>['produced by', 'ClipPath with a CustomClipper<Path>'],
                  <String>['cost class', 'moderate-to-expensive'],
                  <String>['stops backdrop?', 'no'],
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _celDiagram(<_Cel>[
                _Cel('ClipPathLayer', 'arbitrary stencil', cAmber),
                _Cel('PictureLayer', 'star-shaped paints', cCyan),
              ]),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _specimenFrame(
          title: 'SPECIMEN  star + diamond clip',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ClipPath(
                clipper: _StarClipper(),
                child: Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[cAmber, cCyan],
                    ),
                  ),
                ),
              ),
              ClipPath(
                clipper: _DiamondClipper(),
                child: Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[cCyan, cAmberDeep],
                    ),
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

class _StarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    final double cx = size.width / 2.0;
    final double cy = size.height / 2.0;
    final double outer = math.min(cx, cy);
    final double inner = outer * 0.45;
    const int points = 5;
    for (int i = 0; i < points * 2; i++) {
      final double r = i.isEven ? outer : inner;
      final double a = -math.pi / 2.0 + i * math.pi / points;
      final double x = cx + r * math.cos(a);
      final double y = cy + r * math.sin(a);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _DiamondClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.moveTo(size.width / 2.0, 0);
    path.lineTo(size.width, size.height / 2.0);
    path.lineTo(size.width / 2.0, size.height);
    path.lineTo(0, size.height / 2.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
// ============================================================================
// SECTION 8: OPACITYLAYER
// ============================================================================
Widget _buildOpacityLayer() {
  return _section(
    '08',
    'OpacityLayer',
    'alpha compositing via saveLayer',
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _anatomyCard(
                name: 'OpacityLayer',
                oneLiner: 'Composites its subtree with a uniform alpha. '
                    'Allocates an offscreen surface (saveLayer) which is '
                    'expensive: prefer alpha on a single Paint when possible.',
                rows: <List<String>>[
                  <String>['extends', 'ContainerLayer'],
                  <String>['alpha', 'int 0..255'],
                  <String>['produced by', 'Opacity, FadeTransition, AnimatedOpacity'],
                  <String>['cost class', 'expensive (saveLayer)'],
                  <String>['stops backdrop?', 'no'],
                  <String>['tip', 'use Color.withOpacity on a single paint '
                      'in preference to wrapping subtrees in Opacity'],
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _celDiagram(<_Cel>[
                _Cel('OpacityLayer', 'alpha=0.5 saveLayer', cAmber),
                _Cel('PictureLayer', 'normally-painted subtree', cCyan),
              ]),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _specimenFrame(
          title: 'SPECIMEN  5 alpha frames',
          caption: 'Each Opacity wrap triggers a fresh OpacityLayer. Notice '
              'the curve is perceptual: from 0.0 (fully gone) to 1.0 (fully '
              'composited).',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _opacityCell(0.0),
              _opacityCell(0.25),
              _opacityCell(0.5),
              _opacityCell(0.75),
              _opacityCell(1.0),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _opacityCell(double alpha) {
  return Column(
    children: <Widget>[
      Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
          color: cBlack,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: cGrid),
        ),
        alignment: Alignment.center,
        child: Opacity(
          opacity: alpha,
          child: Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              color: cAmber,
              borderRadius: BorderRadius.circular(4.0),
            ),
            alignment: Alignment.center,
            child: Text(
              alpha.toStringAsFixed(2),
              style: TextStyle(color: cBlack, fontSize: 11.0, fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
      SizedBox(height: 6.0),
      Text(
        '\u03B1=${alpha.toStringAsFixed(2)}',
        style: TextStyle(color: cMuted, fontSize: 10.0),
      ),
    ],
  );
}
// ============================================================================
// SECTION 9: SHADERMASKLAYER
// ============================================================================
Widget _buildShaderMaskLayer() {
  return _section(
    '09',
    'ShaderMaskLayer',
    'gradient and shader-based masking',
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _anatomyCard(
                name: 'ShaderMaskLayer',
                oneLiner: 'Multiplies the subtree against a shader (often a '
                    'gradient) to produce fade-outs, sweeping highlights, '
                    'or colour-coded overlays.',
                rows: <List<String>>[
                  <String>['extends', 'ContainerLayer'],
                  <String>['shader', 'a ui.Shader (Gradient.createShader)'],
                  <String>['blendMode', 'srcIn, modulate, dstIn, etc.'],
                  <String>['maskRect', 'Rect to apply the shader within'],
                  <String>['produced by', 'ShaderMask widget'],
                  <String>['cost class', 'moderate (saveLayer + shader)'],
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _celDiagram(<_Cel>[
                _Cel('ShaderMaskLayer', 'gradient * subtree', cAmber),
                _Cel('PictureLayer', 'text / images', cCyan),
              ]),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _specimenFrame(
          title: 'SPECIMEN  fade-out text via ShaderMask',
          child: SizedBox(
            width: 360.0,
            height: 80.0,
            child: ShaderMask(
              blendMode: BlendMode.dstIn,
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Colors.white,
                    Colors.white,
                    Colors.transparent,
                  ],
                  stops: <double>[0.0, 0.55, 1.0],
                ).createShader(bounds);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[cAmber, cAmberDeep],
                  ),
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Text(
                  'FADING EDGE \u2192 \u2192 \u2192',
                  style: TextStyle(
                    color: cBlack,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
// ============================================================================
// SECTION 10: COLORFILTERLAYER
// ============================================================================
Widget _buildColorFilterLayer() {
  return _section(
    '10',
    'ColorFilterLayer',
    'mode and matrix colour transforms',
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _anatomyCard(
                name: 'ColorFilterLayer',
                oneLiner: 'Applies a per-pixel colour transform across the '
                    'whole subtree: blend modes, 4x5 colour matrices, '
                    'srgbToLinear conversions.',
                rows: <List<String>>[
                  <String>['extends', 'ContainerLayer'],
                  <String>['colorFilter', 'ColorFilter.mode / matrix / linearToSrgbGamma'],
                  <String>['produced by', 'ColorFiltered widget'],
                  <String>['cost class', 'cheap-to-moderate'],
                  <String>['stops backdrop?', 'no'],
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _celDiagram(<_Cel>[
                _Cel('ColorFilterLayer', 'per-pixel colour transform', cAmber),
                _Cel('PictureLayer', 'original-colour child', cCyan),
              ]),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _specimenFrame(
          title: 'SPECIMEN  4 colour-filter regimes',
          child: Wrap(
            spacing: 12.0,
            runSpacing: 12.0,
            alignment: WrapAlignment.spaceEvenly,
            children: <Widget>[
              _colourFilteredCell('mode (50% red over)', ColorFilter.mode(
                Color(0x88E04A4A),
                BlendMode.srcATop,
              )),
              _colourFilteredCell('grayscale matrix', _grayscaleFilter()),
              _colourFilteredCell('sepia matrix', _sepiaFilter()),
              _colourFilteredCell('srcIn cyan tint', ColorFilter.mode(
                cCyan,
                BlendMode.srcIn,
              )),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _colourFilteredCell(String label, ColorFilter filter) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      ColorFiltered(
        colorFilter: filter,
        child: Container(
          width: 110.0,
          height: 80.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[cAmber, cCyan, cAmberDeep],
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          alignment: Alignment.center,
          child: Text(
            'spectrum',
            style: TextStyle(color: cBlack, fontWeight: FontWeight.w800),
          ),
        ),
      ),
      SizedBox(height: 6.0),
      Text(
        label,
        style: TextStyle(color: cMuted, fontSize: 10.0),
      ),
    ],
  );
}

ColorFilter _grayscaleFilter() {
  return ColorFilter.matrix(<double>[
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0.2126, 0.7152, 0.0722, 0, 0,
    0, 0, 0, 1, 0,
  ]);
}

ColorFilter _sepiaFilter() {
  return ColorFilter.matrix(<double>[
    0.393, 0.769, 0.189, 0, 0,
    0.349, 0.686, 0.168, 0, 0,
    0.272, 0.534, 0.131, 0, 0,
    0, 0, 0, 1, 0,
  ]);
}
// ============================================================================
// SECTION 11: IMAGEFILTERLAYER
// ============================================================================
Widget _buildImageFilterLayer() {
  return _section(
    '11',
    'ImageFilterLayer',
    'pixel-shader effects: blur, dilate, erode, matrix',
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _anatomyCard(
                name: 'ImageFilterLayer',
                oneLiner: 'Applies a ui.ImageFilter to the rasterised '
                    'subtree. Blur is the canonical example, but matrix '
                    'and morphology filters are also supported.',
                rows: <List<String>>[
                  <String>['extends', 'ContainerLayer'],
                  <String>['imageFilter', 'ui.ImageFilter.blur / matrix / dilate'],
                  <String>['produced by', 'ImageFiltered widget'],
                  <String>['cost class', 'expensive (full subtree resample)'],
                  <String>['stops backdrop?', 'no (unlike BackdropFilterLayer)'],
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _celDiagram(<_Cel>[
                _Cel('ImageFilterLayer', 'blur sigma=5', cAmber),
                _Cel('PictureLayer', 'sharp source paints', cCyan),
              ]),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _specimenFrame(
          title: 'SPECIMEN  blur(5,5) over a gradient',
          caption: 'The ImageFiltered widget blurs its own subtree, '
              'unlike BackdropFilter which blurs whatever is behind.',
          child: ImageFiltered(
            imageFilter: ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              width: 240.0,
              height: 110.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[cAmber, cCyan, cDanger],
                ),
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.center,
              child: Text(
                'BLUR sigma=5',
                style: TextStyle(
                  color: cBlack,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
// ============================================================================
// SECTION 12: TRANSFORMLAYER
// ============================================================================
Widget _buildTransformLayer() {
  return _section(
    '12',
    'TransformLayer',
    '4x4 affine and perspective transforms',
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _anatomyCard(
                name: 'TransformLayer',
                oneLiner: 'Applies a Matrix4 to its subtree. Axis-aligned '
                    'translations collapse to a cheap OffsetLayer; full '
                    'transforms allocate a TransformLayer.',
                rows: <List<String>>[
                  <String>['extends', 'OffsetLayer'],
                  <String>['transform', 'Matrix4 (4x4 row-major)'],
                  <String>['produced by', 'Transform.rotate/scale/translate, Transform(matrix:)'],
                  <String>['cost class', 'cheap when no saveLayer'],
                  <String>['stops backdrop?', 'no'],
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _celDiagram(<_Cel>[
                _Cel('TransformLayer', 'matrix4 applied during composite', cAmber),
                _Cel('PictureLayer', 'untransformed child paints', cCyan),
              ]),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _specimenFrame(
          title: 'SPECIMEN  rotate / scale / translate / perspective',
          child: Wrap(
            spacing: 14.0,
            runSpacing: 14.0,
            alignment: WrapAlignment.spaceEvenly,
            children: <Widget>[
              _transformCell('rotate(.4)', Transform.rotate(
                angle: 0.4,
                child: _transformBox('R'),
              )),
              _transformCell('scale(.8)', Transform.scale(
                scale: 0.8,
                child: _transformBox('S'),
              )),
              _transformCell('translate(10,-12)', Transform.translate(
                offset: Offset(10.0, -12.0),
                child: _transformBox('T'),
              )),
              _transformCell('perspective 4x4', Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.0015)
                  ..rotateY(0.5),
                child: _transformBox('P'),
              )),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _transformBox(String letter) {
  return Container(
    width: 80.0,
    height: 80.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[cAmber, cAmberDeep],
      ),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: cCyan, width: 1.0),
    ),
    alignment: Alignment.center,
    child: Text(
      letter,
      style: TextStyle(
        color: cBlack,
        fontSize: 28.0,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}

Widget _transformCell(String label, Widget child) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      SizedBox(
        width: 110.0,
        height: 110.0,
        child: Center(child: child),
      ),
      Text(
        label,
        style: TextStyle(color: cMuted, fontSize: 10.0),
      ),
    ],
  );
}
// ============================================================================
// SECTION 13: BACKDROPFILTERLAYER
// ============================================================================
Widget _buildBackdropFilterLayer() {
  return _section(
    '13',
    'BackdropFilterLayer',
    'samples the already-composited scene below',
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _anatomyCard(
                name: 'BackdropFilterLayer',
                oneLiner: 'Unlike ImageFilterLayer (which filters its own '
                    'subtree), BackdropFilterLayer reads back the scene '
                    'composed so far and applies a filter to it.',
                rows: <List<String>>[
                  <String>['extends', 'ContainerLayer'],
                  <String>['filter', 'ui.ImageFilter (usually blur)'],
                  <String>['blendMode', 'BlendMode.srcOver by default'],
                  <String>['produced by', 'BackdropFilter widget'],
                  <String>['cost class', 'very expensive'],
                  <String>['stops backdrop?', 'YES - all layers below are read back'],
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _celDiagram(<_Cel>[
                _Cel('BackdropFilterLayer', 'reads scene-so-far', cAmber),
                _Cel('PictureLayer', 'frosted-panel paint', cCyan),
                _Cel('PictureLayer', 'background image / gradient', cSuccess),
              ]),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _specimenFrame(
          title: 'SPECIMEN  frosted glass panel',
          caption: 'A ClipRRect + BackdropFilter creates the iOS-style '
              'frosted panel. The cost: every frame the GPU resamples the '
              'underlying scene through the blur filter.',
          child: SizedBox(
            width: 360.0,
            height: 220.0,
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[cDanger, cAmber, cCyan, cAmberDeep],
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                Positioned(
                  left: 40.0,
                  top: 40.0,
                  child: _colorDisc(cCyan, 50.0),
                ),
                Positioned(
                  right: 30.0,
                  bottom: 30.0,
                  child: _colorDisc(cAmberDeep, 80.0),
                ),
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
                      child: Container(
                        width: 220.0,
                        height: 110.0,
                        decoration: BoxDecoration(
                          color: Color(0x33FFFFFF),
                          borderRadius: BorderRadius.circular(16.0),
                          border: Border.all(color: Color(0x66FFFFFF)),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'frosted backdrop',
                          style: TextStyle(
                            color: cInk,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _colorDisc(Color color, double size) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.circle,
    ),
  );
}
// ============================================================================
// SECTION 14: LEADER / FOLLOWER LAYER
// ============================================================================
Widget _buildLeaderFollowerLayer() {
  return _section(
    '14',
    'LeaderLayer & FollowerLayer',
    'remote-anchor positioning - hero, tooltip, attached overlay',
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _anatomyCard(
                name: 'LeaderLayer',
                oneLiner: 'Anchors a point in the scene with a LayerLink. '
                    'Other parts of the tree (Followers) can position '
                    'themselves relative to this anchor.',
                accent: cCyan,
                rows: <List<String>>[
                  <String>['extends', 'ContainerLayer'],
                  <String>['link', 'LayerLink that Followers reference'],
                  <String>['offset', 'anchor position in parent space'],
                  <String>['produced by', 'CompositedTransformTarget'],
                  <String>['cost class', 'cheap'],
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _anatomyCard(
                name: 'FollowerLayer',
                oneLiner: 'Reads the linked LeaderLayer position and uses '
                    'it to transform its own subtree, possibly with an '
                    'additional offset.',
                accent: cAmber,
                rows: <List<String>>[
                  <String>['extends', 'ContainerLayer'],
                  <String>['link', 'matched LayerLink'],
                  <String>['showWhenUnlinked', 'fallback positioning'],
                  <String>['linkedOffset', 'offset relative to leader'],
                  <String>['produced by', 'CompositedTransformFollower'],
                  <String>['cost class', 'cheap-to-moderate'],
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _celDiagram(<_Cel>[
          _Cel('FollowerLayer', 'positioned by link', cAmber),
          _Cel('LeaderLayer', 'declares anchor point', cCyan),
          _Cel('TransformLayer', 'common ancestor scope', cSuccess),
          _Cel('PictureLayer', 'page contents', cAmberDeep),
        ]),
        SizedBox(height: 14.0),
        _specimenFrame(
          title: 'SPECIMEN  static leader/follower diagram',
          caption: 'A live link requires a controller; in this script the '
              'two widgets are shown side by side with their conceptual '
              'connection drawn between them.',
          child: SizedBox(
            width: 420.0,
            height: 160.0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(child: _leaderBox()),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(height: 1.0, color: cCyan),
                      SizedBox(height: 4.0),
                      Text(
                        'LayerLink',
                        style: TextStyle(
                          color: cCyan,
                          fontSize: 11.0,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Container(height: 1.0, color: cAmber),
                    ],
                  ),
                ),
                Expanded(child: _followerBox()),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _leaderBox() {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: cGlass,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: cCyan, width: 1.2),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'LEADER',
          style: TextStyle(
            color: cCyan,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
            fontSize: 12.0,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'CompositedTransformTarget',
          style: TextStyle(color: cMuted, fontSize: 10.0),
        ),
      ],
    ),
  );
}

Widget _followerBox() {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: cGlass,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: cAmber, width: 1.2),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'FOLLOWER',
          style: TextStyle(
            color: cAmber,
            fontWeight: FontWeight.w800,
            letterSpacing: 2.0,
            fontSize: 12.0,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'CompositedTransformFollower',
          style: TextStyle(color: cMuted, fontSize: 10.0),
        ),
      ],
    ),
  );
}
// ============================================================================
// SECTION 15: ANNOTATEDREGIONLAYER
// ============================================================================
Widget _buildAnnotatedRegionLayer() {
  return _section(
    '15',
    'AnnotatedRegionLayer<T>',
    'metadata attached to a screen region',
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _anatomyCard(
                name: 'AnnotatedRegionLayer<T>',
                oneLiner: 'A layer that does not draw anything but attaches '
                    'a value of type T to a rectangular region. The engine '
                    'queries this when it needs region metadata.',
                rows: <List<String>>[
                  <String>['extends', 'ContainerLayer'],
                  <String>['value', 'metadata payload (e.g. SystemUiOverlayStyle)'],
                  <String>['size', 'optional explicit size'],
                  <String>['produced by', 'AnnotatedRegion<T> widget'],
                  <String>['cost class', 'free (no drawing)'],
                  <String>['common T', 'SystemUiOverlayStyle, MouseCursor'],
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _celDiagram(<_Cel>[
                _Cel('AnnotatedRegionLayer', 'metadata only, no draw', cAmber),
                _Cel('PictureLayer', 'visible content', cCyan),
              ]),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _specimenFrame(
          title: 'SPECIMEN  AnnotatedRegion<SystemUiOverlayStyle>',
          caption: 'The annotated region tells the OS to render the system '
              'status bar with light icons over this section. The visible '
              'panel itself is just a regular Container.',
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Container(
              width: 320.0,
              height: 90.0,
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: cGlass,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: cAmber, width: 1.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'annotated region',
                    style: TextStyle(
                      color: cAmber,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'SystemUiOverlayStyle.light',
                    style: TextStyle(color: cMuted, fontSize: 11.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
// ============================================================================
// SECTION 16: PICTURELAYER
// ============================================================================
Widget _buildPictureLayer() {
  return _section(
    '16',
    'PictureLayer',
    'the leaf that actually holds drawing commands',
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _anatomyCard(
                name: 'PictureLayer',
                oneLiner: 'A leaf layer that records a ui.Picture: the '
                    'actual drawing commands (drawRect, drawPath, drawText). '
                    'Almost every visible thing ends up inside a PictureLayer.',
                rows: <List<String>>[
                  <String>['extends', 'Layer (leaf)'],
                  <String>['picture', 'ui.Picture - immutable command list'],
                  <String>['canvasBounds', 'cull rect'],
                  <String>['produced by', 'every non-composited RenderObject'],
                  <String>['cost class', 'cheap to composite, but recording costs CPU'],
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _celDiagram(<_Cel>[
                _Cel('PictureLayer', 'drawRect, drawPath, drawText, ...', cCyan),
              ]),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _specimenFrame(
          title: 'SPECIMEN  CustomPaint',
          caption: 'CustomPaint records draw calls directly into the parent '
              'PictureLayer (unless wrapped in a RepaintBoundary).',
          child: SizedBox(
            width: 300.0,
            height: 140.0,
            child: CustomPaint(
              painter: _SpectraPainter(),
            ),
          ),
        ),
      ],
    ),
  );
}

class _SpectraPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = cGlass;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(6.0),
      ),
      bg,
    );
    final Paint stroke = Paint()
      ..color = cAmber
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    final Path path = Path();
    for (int i = 0; i <= 60; i++) {
      final double x = (i / 60.0) * size.width;
      final double y = size.height / 2.0 +
          math.sin(i * 0.45) * (size.height / 3.0);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, stroke);

    final Paint dot = Paint()..color = cCyan;
    for (int i = 0; i < 10; i++) {
      final double x = (i / 9.0) * size.width;
      final double y = size.height / 2.0 + math.cos(i * 0.7) * 24.0;
      canvas.drawCircle(Offset(x, y), 4.0, dot);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
// ============================================================================
// SECTION 17: TEXTURE / PLATFORMVIEW LAYERS
// ============================================================================
Widget _buildTextureAndPlatformView() {
  return _section(
    '17',
    'TextureLayer & PlatformViewLayer',
    'platform-bridge leaves - typically not synthesised in script',
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _anatomyCard(
                name: 'TextureLayer',
                accent: cCyan,
                oneLiner: 'A leaf that references a GPU texture managed by '
                    'the embedder. Used to render video frames, camera '
                    'preview, or any externally-produced surface.',
                rows: <List<String>>[
                  <String>['extends', 'Layer (leaf)'],
                  <String>['textureId', 'int handle from embedder'],
                  <String>['rect', 'where to draw the texture'],
                  <String>['produced by', 'Texture widget'],
                  <String>['cost class', 'cheap composite, native ownership'],
                  <String>['note', 'lifecycle owned by embedder'],
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _anatomyCard(
                name: 'PlatformViewLayer',
                accent: cAmber,
                oneLiner: 'Embeds a native platform view (UIKit, Android '
                    'View, native HTML element) into the Flutter scene. '
                    'Hybrid composition is what makes this work.',
                rows: <List<String>>[
                  <String>['extends', 'Layer (leaf)'],
                  <String>['viewId', 'int handle of the native view'],
                  <String>['rect', 'screen rectangle'],
                  <String>['produced by', 'AndroidView, UiKitView, HtmlElementView'],
                  <String>['cost class', 'expensive (out-of-pipeline composite)'],
                  <String>['note', 'forces a raster cut before & after'],
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _celDiagram(<_Cel>[
          _Cel('PlatformViewLayer', 'native view embedding', cAmber),
          _Cel('TextureLayer', 'external GPU surface', cCyan),
          _Cel('PictureLayer', 'Flutter-drawn UI', cSuccess),
        ]),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: cGlass,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: cGlassEdge),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Why these are not synthesised here',
                style: TextStyle(
                  color: cAmber,
                  fontSize: 12.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 6.0),
              _paragraph(
                'Both TextureLayer and PlatformViewLayer depend on the '
                'embedder providing a real texture id or platform view id. '
                'In a pure-Dart D4rt script we have neither, so they appear '
                'in the catalogue but not as live specimens.',
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
// ============================================================================
// SECTION 18: REPAINTBOUNDARY
// ============================================================================
Widget _buildRepaintBoundarySection() {
  return _section(
    '18',
    "RepaintBoundary's role",
    'force an OffsetLayer cut to isolate repaints',
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _anatomyCard(
                name: 'RepaintBoundary',
                oneLiner: 'A widget whose RenderObject forces an OffsetLayer '
                    'at its position in the layer tree. The subtree below '
                    'paints into its own retained PictureLayer, isolated '
                    'from the rest of the scene.',
                rows: <List<String>>[
                  <String>['produces', 'OffsetLayer (cut)'],
                  <String>['why', 'subtree repaints alone, parent repaints alone'],
                  <String>['cost when good', 'fewer pictures re-recorded per frame'],
                  <String>['cost when bad', 'extra raster cache entries'],
                  <String>['rule of thumb', 'place around expensive subtrees '
                      'that animate independently'],
                ],
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _celDiagram(<_Cel>[
                _Cel('OffsetLayer', 'RepaintBoundary cut', cAmber),
                _Cel('PictureLayer', 'subtree paints into own picture', cCyan),
                _Cel('PictureLayer', 'parent paints continue here', cSuccess),
              ]),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            Expanded(child: _repaintSpecimen(
              title: 'WITHOUT RepaintBoundary',
              detail: 'parent and child re-record on every frame',
              accent: cDanger,
            )),
            SizedBox(width: 12.0),
            Expanded(child: _repaintSpecimen(
              title: 'WITH RepaintBoundary',
              detail: 'subtree paints into a retained PictureLayer',
              accent: cSuccess,
            )),
            SizedBox(width: 12.0),
            Expanded(child: _repaintSpecimen(
              title: 'WITH RepaintBoundary on the animated child',
              detail: 'animation re-records, surroundings cached',
              accent: cAmber,
            )),
          ],
        ),
      ],
    ),
  );
}

Widget _repaintSpecimen({
  required String title,
  required String detail,
  required Color accent,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: cGlass,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: accent, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            color: accent,
            fontSize: 11.0,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.0,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          detail,
          style: TextStyle(color: cMuted, fontSize: 11.0, height: 1.4),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 60.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[accent.withOpacity(0.2), accent.withOpacity(0.05)],
            ),
            borderRadius: BorderRadius.circular(4.0),
          ),
          alignment: Alignment.center,
          child: Text(
            'specimen',
            style: TextStyle(color: accent, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    ),
  );
}
// ============================================================================
// SECTION 19: LAYER TREE VISUALISATION
// ============================================================================
Widget _buildLayerTreeVisualisation() {
  return _section(
    '19',
    'A real example',
    'widget tree \u2192 layer tree',
    Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: cGlass,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: cCyan),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'WIDGET TREE',
                      style: TextStyle(
                        color: cCyan,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    _treeLine(0, 'Stack'),
                    _treeLine(1, 'ClipRRect(borderRadius: 12)'),
                    _treeLine(2, 'Opacity(opacity: 0.85)'),
                    _treeLine(3, 'Transform.rotate(angle: 0.1)'),
                    _treeLine(4, 'Image / Container'),
                    _treeLine(1, 'Positioned(top: 8, right: 8)'),
                    _treeLine(2, 'BackdropFilter(blur: 8)'),
                    _treeLine(3, 'Container(label badge)'),
                  ],
                ),
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: cGlass,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: cAmber),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'LAYER TREE',
                      style: TextStyle(
                        color: cAmber,
                        fontSize: 11.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 2.0,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    _treeLine(0, 'TransformLayer  (root)'),
                    _treeLine(1, 'OffsetLayer  (RepaintBoundary)'),
                    _treeLine(2, 'ClipRRectLayer'),
                    _treeLine(3, 'OpacityLayer'),
                    _treeLine(4, 'TransformLayer'),
                    _treeLine(5, 'PictureLayer  (image/container)'),
                    _treeLine(2, 'BackdropFilterLayer'),
                    _treeLine(3, 'PictureLayer  (badge)'),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _celDiagram(<_Cel>[
          _Cel('BackdropFilterLayer', 'badge blurs scene below', cAmber),
          _Cel('PictureLayer', 'badge paint', cCyan),
          _Cel('TransformLayer', 'rotated image', cSuccess),
          _Cel('OpacityLayer', '0.85 saveLayer', cAmberDeep),
          _Cel('ClipRRectLayer', 'rounded card mask', cDanger),
          _Cel('OffsetLayer', 'RepaintBoundary cut', cDust),
          _Cel('TransformLayer', 'root view', cInk),
        ]),
      ],
    ),
  );
}

Widget _treeLine(int depth, String label) {
  final String indent = '  ' * (depth == 0 ? 0 : depth - 1);
  final String prefix = depth == 0 ? '' : '$indent\u2514\u2500 ';
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Text(
      '$prefix$label',
      style: TextStyle(
        color: cInk,
        fontSize: 12.0,
        fontFamily: 'monospace',
        height: 1.4,
      ),
    ),
  );
}
// ============================================================================
// SECTION 20: RECIPE CARDS
// ============================================================================
Widget _buildRecipeCards() {
  final List<List<String>> recipes = <List<String>>[
    <String>[
      'RepaintBoundary on a heavy animation',
      'Wrap an animating subtree in RepaintBoundary so its repaints do '
          'not cascade into its parent. Best when the parent does not '
          'animate but the child does.',
      'RepaintBoundary(child: AnimatedBuilder(...));',
    ],
    <String>[
      'Frosted glass via BackdropFilter',
      'ClipRRect for the rounded outline, BackdropFilter to blur the '
          'scene below, then a translucent Container on top. The '
          'BackdropFilter is the expensive part.',
      'ClipRRect(child: BackdropFilter(filter: blur(10,10), child: ...));',
    ],
    <String>[
      'Rounded card via ClipRRect',
      'ClipRRect with a borderRadius is far cheaper than ClipPath and '
          'lets you keep child content unaware of the clip.',
      'ClipRRect(borderRadius: BorderRadius.circular(12), child: Image(...));',
    ],
    <String>[
      'Fading edge via ShaderMask',
      'A LinearGradient from opaque to transparent applied with '
          'BlendMode.dstIn produces a clean fade-out at any orientation.',
      'ShaderMask(shaderCallback: gradient.createShader, blendMode: dstIn);',
    ],
    <String>[
      'Greyscale via ColorFiltered',
      'A 4x5 ColorFilter.matrix flattens R, G, B to a luminance value. '
          'Cheap and reversible (alpha untouched).',
      'ColorFiltered(colorFilter: ColorFilter.matrix(luma), child: ...);',
    ],
    <String>[
      'Tooltip via Leader/Follower',
      'CompositedTransformTarget marks the anchor, CompositedTransform'
          'Follower positions a tooltip relative to it. Survives '
          'layout changes without manual recompute.',
      'CompositedTransformTarget(link: link, child: target);',
    ],
  ];
  return _section(
    '20',
    'Recipe cards',
    'six common patterns built from layers',
    Column(
      children: <Widget>[
        for (int i = 0; i < recipes.length; i += 2)
          Padding(
            padding: EdgeInsets.only(bottom: 12.0),
            // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #70, P1):
            // the Row uses CrossAxisAlignment.stretch to equalise the two
            // _recipeCard heights, but the root is a SingleChildScrollView
            // (unbounded vertical), so stretch would force the children
            // to infinite height. Wrap in IntrinsicHeight so stretch
            // resolves against the max intrinsic height of the cards.
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(child: _recipeCard(i + 1, recipes[i])),
                  SizedBox(width: 12.0),
                  if (i + 1 < recipes.length)
                    Expanded(child: _recipeCard(i + 2, recipes[i + 1]))
                  else
                    Expanded(child: SizedBox.shrink()),
                ],
              ),
            ),
          ),
      ],
    ),
  );
}

Widget _recipeCard(int n, List<String> r) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: cGlass,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: cAmberDeep, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 28.0,
              height: 28.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: cAmber,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                '$n',
                style: TextStyle(
                  color: cBlack,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                r[0],
                style: TextStyle(
                  color: cInk,
                  fontWeight: FontWeight.w800,
                  fontSize: 13.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          r[1],
          style: TextStyle(color: cMuted, fontSize: 11.5, height: 1.5),
        ),
        SizedBox(height: 10.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: cBlack,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: cGrid),
          ),
          child: Text(
            r[2],
            style: TextStyle(
              color: cCyan,
              fontSize: 11.0,
              fontFamily: 'monospace',
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}
// ============================================================================
// SECTION 21: COMPARISON TABLE
// ============================================================================
Widget _buildComparisonTable() {
  final List<List<String>> rows = <List<String>>[
    <String>['Layer', 'Widget', 'Cost', 'Backdrop?'],
    <String>['OffsetLayer', 'RepaintBoundary / Transform.translate', 'cheap', 'no'],
    <String>['ClipRectLayer', 'ClipRect', 'cheap', 'no'],
    <String>['ClipRRectLayer', 'ClipRRect', 'cheap-mod', 'no'],
    <String>['ClipPathLayer', 'ClipPath', 'moderate', 'no'],
    <String>['OpacityLayer', 'Opacity / FadeTransition', 'expensive', 'no'],
    <String>['ShaderMaskLayer', 'ShaderMask', 'moderate', 'no'],
    <String>['ColorFilterLayer', 'ColorFiltered', 'cheap-mod', 'no'],
    <String>['ImageFilterLayer', 'ImageFiltered', 'expensive', 'no'],
    <String>['TransformLayer', 'Transform', 'cheap', 'no'],
    <String>['BackdropFilterLayer', 'BackdropFilter', 'very expensive', 'YES'],
    <String>['LeaderLayer', 'CompositedTransformTarget', 'cheap', 'no'],
    <String>['FollowerLayer', 'CompositedTransformFollower', 'cheap-mod', 'no'],
    <String>['AnnotatedRegionLayer', 'AnnotatedRegion<T>', 'free', 'no'],
    <String>['PictureLayer', '(implicit) any drawing', 'cheap', 'no'],
    <String>['TextureLayer', 'Texture', 'cheap', 'no'],
    <String>['PlatformViewLayer', 'AndroidView / UiKitView', 'expensive', 'YES'],
  ];
  return _section(
    '21',
    'Comparison',
    'layer x producing-widget x cost x backdrop-stop',
    Container(
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: cBlack,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: cGlassEdge),
      ),
      child: Column(
        children: <Widget>[
          for (int i = 0; i < rows.length; i++)
            _tableRow(rows[i], header: i == 0),
        ],
      ),
    ),
  );
}

Widget _tableRow(List<String> cells, {bool header = false}) {
  final TextStyle style = TextStyle(
    color: header ? cAmber : cInk,
    fontSize: 11.5,
    fontWeight: header ? FontWeight.w800 : FontWeight.w500,
    letterSpacing: header ? 1.0 : 0.2,
  );
  final TextStyle styleAccent = TextStyle(
    color: cCyan,
    fontSize: 11.5,
    fontWeight: FontWeight.w700,
  );
  return Container(
    padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: cGrid, width: 0.6),
      ),
    ),
    child: Row(
      children: <Widget>[
        Expanded(flex: 3, child: Text(cells[0], style: header ? style : styleAccent)),
        Expanded(flex: 4, child: Text(cells[1], style: style)),
        Expanded(flex: 2, child: Text(cells[2], style: style)),
        Expanded(flex: 2, child: Text(cells[3], style: style)),
      ],
    ),
  );
}
// ============================================================================
// SECTION 22: PITFALLS
// ============================================================================
Widget _buildPitfalls() {
  final List<List<String>> pitfalls = <List<String>>[
    <String>[
      'Too many RepaintBoundaries',
      'Every RepaintBoundary allocates a retained PictureLayer. On a list '
          'of thousands of items, blindly wrapping each tile balloons the '
          'raster cache and hurts memory more than it helps painting.',
    ],
    <String>[
      'saveLayer cost (Opacity)',
      'Opacity < 1.0 triggers saveLayer / restore. Prefer applying alpha '
          'on a single Paint or via AnimatedOpacity with alwaysIncludeSemantics '
          'tuned off, or use Color.fromARGB on the decoration.',
    ],
    <String>[
      'ImageFilter is expensive',
      'Blur and matrix filters resample the entire subtree on every '
          'frame. Pair with RepaintBoundary so the filter operates on a '
          'cached bitmap when the source is static.',
    ],
    <String>[
      'ClipPath requires path computation',
      'A general path must be tessellated by the rasteriser. Prefer '
          'ClipRect or ClipRRect when shape allows, and cache CustomClipper '
          'instances so the shouldReclip shortcut fires.',
    ],
    <String>[
      'BackdropFilter blocks the pipeline',
      'A BackdropFilter forces the GPU to flush prior work and resample. '
          'Many overlapping BackdropFilters compound this cost. Use one '
          'large blurred panel rather than many small ones.',
    ],
    <String>[
      'PlatformView interleaving',
      'Each PlatformViewLayer is composited out-of-band, forcing a raster '
          'cut before and after. Avoid them in deep, animated trees.',
    ],
  ];
  return _section(
    '22',
    'Pitfalls',
    'sharp edges to avoid',
    Column(
      children: <Widget>[
        for (final List<String> p in pitfalls)
          Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: cGlass,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: cDanger.withOpacity(0.55)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      color: cDanger,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '\u26A0',
                      style: TextStyle(
                        color: cBlack,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          p[0],
                          style: TextStyle(
                            color: cDanger,
                            fontWeight: FontWeight.w800,
                            fontSize: 13.0,
                          ),
                        ),
                        SizedBox(height: 6.0),
                        Text(
                          p[1],
                          style: TextStyle(
                            color: cInk,
                            fontSize: 12.0,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    ),
  );
}
// ============================================================================
// SECTION 23: GLOSSARY
// ============================================================================
Widget _buildGlossary() {
  final List<List<String>> terms = <List<String>>[
    <String>['Layer', 'A node in the layer tree. Concrete subclasses '
        'describe compositing operations or hold a leaf payload.'],
    <String>['ContainerLayer', 'A Layer with children. The base class for '
        'every Layer that contains other Layers.'],
    <String>['OffsetLayer', 'A ContainerLayer that translates its '
        'children by an Offset; also the layer produced at every '
        'RepaintBoundary cut.'],
    <String>['PictureLayer', 'A leaf layer that holds a ui.Picture, the '
        'recorded list of drawing commands.'],
    <String>['RepaintBoundary', 'A widget whose RenderObject forces an '
        'OffsetLayer, isolating its subtree from the rest of the '
        'painting work.'],
    <String>['saveLayer', 'A Canvas operation that allocates an offscreen '
        'surface, draws into it, and composites the result with a '
        'specified Paint. Underpins Opacity, ShaderMask and others.'],
    <String>['compositor', 'The engine subsystem that consumes the layer '
        'tree and produces the final scene by walking layers and '
        'invoking SceneBuilder.'],
    <String>['scene', 'The product of one composition pass; submitted '
        'to the platform window for display.'],
    <String>['SceneBuilder', 'Engine API used by layers to add their '
        'commands (pushOffset, pushClipRect, pushPicture) when '
        'building the final scene.'],
    <String>['PaintingContext', 'The Flutter framework wrapper around a '
        'Canvas/SceneBuilder, exposed to RenderObject.paint to record '
        'drawing or push a child layer.'],
    <String>['raster cache', 'A GPU-side cache of rasterised PictureLayer '
        'or OffsetLayer contents. Keyed by a stable identity.'],
    <String>['retained mode', 'A rendering model where the system stores '
        'an explicit tree of drawables (layers) and re-uses retained '
        'rasters frame to frame.'],
    <String>['paint pass', 'The walk over the RenderObject tree calling '
        'paint() on each, recording into the layer tree.'],
    <String>['composite pass', 'The walk over the layer tree producing a '
        'scene via the SceneBuilder.'],
    <String>['hybrid composition', 'A mode where platform views are '
        'interleaved with Flutter pictures, used by PlatformViewLayer.'],
    <String>['LayerLink', 'An object shared between LeaderLayer and '
        'FollowerLayer so the follower can read the leader\u2019s '
        'transform.'],
    <String>['needsCompositing', 'A RenderObject flag that is true when '
        'the subtree must allocate a Layer (clip, transform, opacity, etc.).'],
  ];
  return _section(
    '23',
    'Glossary',
    'terms across the rendering pipeline',
    Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: cGlass,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: cGlassEdge),
      ),
      child: Column(
        children: <Widget>[
          for (final List<String> t in terms)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 6.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 170.0,
                    child: Text(
                      t[0],
                      style: TextStyle(
                        color: cAmber,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      t[1],
                      style: TextStyle(
                        color: cInk,
                        fontSize: 11.5,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}
// ============================================================================
// SECTION 24: EPILOGUE
// ============================================================================
Widget _buildEpilogue() {
  return Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[cPanel, cBlack],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: cAmberDeep, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 40.0,
              height: 40.0,
              decoration: BoxDecoration(
                color: cAmber,
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.center,
              child: Text(
                '\u25A4',
                style: TextStyle(color: cBlack, fontSize: 20.0),
              ),
            ),
            SizedBox(width: 12.0),
            Text(
              'EPILOGUE',
              style: TextStyle(
                color: cAmber,
                fontSize: 14.0,
                letterSpacing: 4.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Text(
          'The layer tree is the quiet companion to every Flutter widget '
          'tree. Most days you can ignore it; on optimisation days it is '
          'the level at which performance lives. The cel-sheet metaphor '
          'helps: every saveLayer is another sheet on the light table, '
          'and the GPU pays the toll for every one.',
          style: TextStyle(color: cInk, fontSize: 13.5, height: 1.6),
        ),
        SizedBox(height: 14.0),
        Text(
          'Build less by understanding what each widget compiles to in '
          'layers, and where the engine inserts its own cuts. A handful '
          'of well-placed RepaintBoundaries beats a forest of them.',
          style: TextStyle(color: cMuted, fontSize: 13.0, height: 1.6),
        ),
        SizedBox(height: 18.0),
        Container(height: 1.0, color: cGlassEdge),
        SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            _epilogueChip('18 layer types'),
            SizedBox(width: 8.0),
            _epilogueChip('1 light table'),
            SizedBox(width: 8.0),
            _epilogueChip('0 main()'),
            Spacer(),
            Text(
              'deep visual demo \u00B7 layer tree',
              style: TextStyle(
                color: cDust,
                fontSize: 11.0,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _epilogueChip(String label) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: cGlass,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: cCyanDeep),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: cCyan,
        fontSize: 11.0,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
