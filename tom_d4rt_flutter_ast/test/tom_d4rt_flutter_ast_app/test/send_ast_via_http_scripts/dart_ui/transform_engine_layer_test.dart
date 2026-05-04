// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt test script: Deep visual demonstration of TransformEngineLayer from
// dart:ui — the engine-layer wrapper produced by SceneBuilder.pushTransform.
// This file showcases compositing-time transformations (translation, rotation,
// scaling, skew, perspective) using static Matrix4 transforms, tying the
// low-level dart:ui API to the high-level Transform widget.
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // Build a sample SceneBuilder to exercise pushTransform / TransformEngineLayer
  // statically. We never rasterize — we just verify the API surface and pull a
  // few descriptive strings to display in the visual demo.
  // ============================================================
  final ui.SceneBuilder sb = ui.SceneBuilder();

  final Float64List translateMatrix = _matrix4Translation(40.0, 20.0, 0.0);
  final Float64List rotateMatrix = _matrix4RotationZ(0.4);
  final Float64List scaleMatrix = _matrix4Scale(1.4, 0.8, 1.0);
  final Float64List skewMatrix = _matrix4SkewXY(0.3, 0.0);
  final Float64List perspectiveMatrix = _matrix4Perspective(0.0015);
  final Float64List composedMatrix = _matrix4Compose(<Float64List>[
    translateMatrix,
    rotateMatrix,
    scaleMatrix,
  ]);

  final ui.TransformEngineLayer translateLayer = sb.pushTransform(
    translateMatrix,
  );
  final ui.TransformEngineLayer rotateLayer = sb.pushTransform(rotateMatrix);
  sb.pop();
  sb.pop();

  final String layerType = translateLayer.runtimeType.toString();
  final ui.Scene scene = sb.build();
  scene.dispose();

  // ============================================================
  // SECTION 1 — Hero header
  // ============================================================
  final Widget heroHeader = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.indigo.shade700, Colors.deepPurple.shade400],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.indigo.shade900.withValues(alpha: 0.45),
          blurRadius: 22.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Colors.deepPurple.shade200.withValues(alpha: 0.30),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.transform, size: 56.0, color: Colors.white),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'TransformEngineLayer',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    'dart:ui · compositing transforms',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.30),
              width: 1.0,
            ),
          ),
          child: Text(
            'Layer captured at runtime: $layerType',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2 — Anatomy of compositing
  // ============================================================
  final Widget anatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.blueGrey.shade50, Colors.cyan.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.cyan.shade200, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.cyan.shade100.withValues(alpha: 0.5),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Anatomy of a TransformEngineLayer',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'Created by SceneBuilder.pushTransform(matrix4). Each layer pushes a '
          '4x4 affine matrix onto the compositor stack. Subsequent paint '
          'operations and child layers are composed under that transform '
          'until the matching pop().',
          style: TextStyle(fontSize: 13.0, color: Colors.blueGrey.shade700),
        ),
        SizedBox(height: 14.0),
        _buildPipelineRow(),
      ],
    ),
  );

  // ============================================================
  // SECTION 3 — Per-transformation type cards (Transform widgets)
  // ============================================================
  final List<Widget> transformCards = <Widget>[
    _buildTransformCard(
      title: 'Translation',
      subtitle: 'Matrix4.translationValues(dx, dy, dz)',
      gradientColors: <Color>[Colors.blue.shade100, Colors.blue.shade300],
      shadowColor: Colors.blue.shade400,
      icon: Icons.open_with,
      iconColor: Colors.blue.shade900,
      transform: Matrix4.translationValues(20.0, -10.0, 0.0),
      matrixDescription:
          '| 1  0  0 dx |\n| 0  1  0 dy |\n| 0  0  1 dz |\n| 0  0  0  1 |',
    ),
    _buildTransformCard(
      title: 'Rotation Z',
      subtitle: 'Matrix4.rotationZ(theta)',
      gradientColors: <Color>[Colors.green.shade100, Colors.green.shade300],
      shadowColor: Colors.green.shade400,
      icon: Icons.rotate_right,
      iconColor: Colors.green.shade900,
      transform: Matrix4.rotationZ(0.45),
      matrixDescription:
          '| cosθ -sinθ 0 0 |\n| sinθ  cosθ 0 0 |\n|  0     0   1 0 |\n|  0     0   0 1 |',
    ),
    _buildTransformCard(
      title: 'Rotation Y',
      subtitle: 'Matrix4.rotationY(theta)',
      gradientColors: <Color>[Colors.lime.shade100, Colors.lime.shade400],
      shadowColor: Colors.lime.shade600,
      icon: Icons.threed_rotation,
      iconColor: Colors.lime.shade900,
      transform: Matrix4.rotationY(0.55),
      matrixDescription:
          '|  cosθ 0 sinθ 0 |\n|   0   1  0   0 |\n| -sinθ 0 cosθ 0 |\n|   0   0  0   1 |',
    ),
    _buildTransformCard(
      title: 'Rotation X',
      subtitle: 'Matrix4.rotationX(theta)',
      gradientColors: <Color>[Colors.teal.shade100, Colors.teal.shade300],
      shadowColor: Colors.teal.shade400,
      icon: Icons.flip,
      iconColor: Colors.teal.shade900,
      transform: Matrix4.rotationX(0.65),
      matrixDescription:
          '| 1  0    0    0 |\n| 0 cosθ -sinθ 0 |\n| 0 sinθ  cosθ 0 |\n| 0  0    0    1 |',
    ),
    _buildTransformCard(
      title: 'Uniform Scale',
      subtitle: 'Matrix4.diagonal3Values(s, s, s)',
      gradientColors: <Color>[Colors.purple.shade100, Colors.purple.shade300],
      shadowColor: Colors.purple.shade400,
      icon: Icons.zoom_out_map,
      iconColor: Colors.purple.shade900,
      transform: Matrix4.diagonal3Values(1.4, 1.4, 1.0),
      matrixDescription:
          '| s  0  0  0 |\n| 0  s  0  0 |\n| 0  0  s  0 |\n| 0  0  0  1 |',
    ),
    _buildTransformCard(
      title: 'Non-Uniform Scale',
      subtitle: 'Matrix4.diagonal3Values(sx, sy, sz)',
      gradientColors: <Color>[Colors.pink.shade100, Colors.pink.shade300],
      shadowColor: Colors.pink.shade400,
      icon: Icons.aspect_ratio,
      iconColor: Colors.pink.shade900,
      transform: Matrix4.diagonal3Values(1.6, 0.7, 1.0),
      matrixDescription:
          '| sx 0  0  0 |\n| 0  sy 0  0 |\n| 0  0  sz 0 |\n| 0  0  0  1 |',
    ),
    _buildTransformCard(
      title: 'Skew X',
      subtitle: 'Matrix4 with m[1,0] = tan(α)',
      gradientColors: <Color>[Colors.orange.shade100, Colors.orange.shade300],
      shadowColor: Colors.orange.shade400,
      icon: Icons.linear_scale,
      iconColor: Colors.orange.shade900,
      transform: Matrix4.skewX(0.4),
      matrixDescription:
          '| 1 tanα 0 0 |\n| 0  1   0 0 |\n| 0  0   1 0 |\n| 0  0   0 1 |',
    ),
    _buildTransformCard(
      title: 'Skew Y',
      subtitle: 'Matrix4 with m[0,1] = tan(β)',
      gradientColors: <Color>[Colors.amber.shade100, Colors.amber.shade300],
      shadowColor: Colors.amber.shade400,
      icon: Icons.swap_horiz,
      iconColor: Colors.amber.shade900,
      transform: Matrix4.skewY(0.3),
      matrixDescription:
          '|  1   0 0 0 |\n| tanβ 1 0 0 |\n|  0   0 1 0 |\n|  0   0 0 1 |',
    ),
    _buildTransformCard(
      title: 'Perspective',
      subtitle: 'Matrix4..setEntry(3, 2, p)',
      gradientColors: <Color>[Colors.red.shade100, Colors.red.shade300],
      shadowColor: Colors.red.shade400,
      icon: Icons.view_in_ar,
      iconColor: Colors.red.shade900,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.0015)
        ..rotateY(0.5),
      matrixDescription:
          '| 1 0 0 0 |\n| 0 1 0 0 |\n| 0 0 1 0 |\n| 0 0 p 1 |  (p ≈ 0.001)',
    ),
  ];

  // ============================================================
  // SECTION 4 — Recipes (composition order, common patterns)
  // ============================================================
  final Widget recipes = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.deepPurple.shade50, Colors.indigo.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade200, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.deepPurple.shade100.withValues(alpha: 0.6),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Recipes — Composing Transforms',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        _buildRecipeRow(
          'Translate then Rotate',
          'M = T(40,20) · Rz(0.4)',
          'Object orbits its origin after translation.',
          Icons.refresh,
          Colors.deepPurple,
          Matrix4.identity()
            ..translate(20.0, 0.0)
            ..rotateZ(0.4),
        ),
        SizedBox(height: 8.0),
        _buildRecipeRow(
          'Rotate then Translate',
          'M = Rz(0.4) · T(40,20)',
          'Translation vector is rotated before applying.',
          Icons.threesixty,
          Colors.indigo,
          Matrix4.identity()
            ..rotateZ(0.4)
            ..translate(20.0, 0.0),
        ),
        SizedBox(height: 8.0),
        _buildRecipeRow(
          'Scale Around Center',
          'T(c) · S · T(-c)',
          'Translate to origin, scale, translate back.',
          Icons.center_focus_strong,
          Colors.teal,
          Matrix4.identity()
            ..translate(0.5, 0.5)
            ..scale(1.5)
            ..translate(-0.5, -0.5),
        ),
        SizedBox(height: 8.0),
        _buildRecipeRow(
          'Perspective Tilt',
          'P · Ry(θ)',
          'Add perspective entry, then rotate.',
          Icons.view_in_ar_outlined,
          Colors.red,
          Matrix4.identity()
            ..setEntry(3, 2, 0.0015)
            ..rotateY(0.55),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5 — Pitfalls
  // ============================================================
  final Widget pitfalls = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.red.shade50, Colors.deepOrange.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.red.shade300, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.red.shade200.withValues(alpha: 0.5),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.warning_amber, color: Colors.red.shade700, size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'Pitfalls',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildPitfallRow(
          'Matrix multiplication is non-commutative',
          'A · B ≠ B · A. Translate-then-rotate produces a different '
              'result than rotate-then-translate.',
        ),
        _buildPitfallRow(
          'Push must match Pop',
          'Every pushTransform must be balanced with sb.pop(). Otherwise '
              'subsequent layers inherit the unintended transform.',
        ),
        _buildPitfallRow(
          'Float64List length must be 16',
          'pushTransform expects a column-major 4x4 matrix as Float64List. '
              'Pass matrix.storage from a Matrix4.',
        ),
        _buildPitfallRow(
          'Hit-testing follows the inverse',
          'Pointer events traverse the inverse transform. Non-invertible '
              'matrices (zero scale) make children un-tappable.',
        ),
        _buildPitfallRow(
          'Scaling rasterized layers blurs',
          'Scaling above 1.0 enlarges already-rasterized child layers. Use '
              'RepaintBoundary thoughtfully or rebuild at the new scale.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6 — Matrix math diagrams
  // ============================================================
  final Widget matrixDiagrams = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.grey.shade900, Colors.blueGrey.shade800],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 14.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.calculate, color: Colors.cyan.shade300, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Matrix Math Diagrams',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade300,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _buildMatrixBlock(
          'Identity',
          'I · v = v',
          '| 1 0 0 0 |\n| 0 1 0 0 |\n| 0 0 1 0 |\n| 0 0 0 1 |',
          Colors.cyan.shade200,
        ),
        SizedBox(height: 10.0),
        _buildMatrixBlock(
          'Translation T(dx, dy, dz)',
          'T · [x y z 1]ᵀ = [x+dx, y+dy, z+dz, 1]ᵀ',
          '| 1 0 0 dx |\n| 0 1 0 dy |\n| 0 0 1 dz |\n| 0 0 0  1 |',
          Colors.lightBlueAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _buildMatrixBlock(
          'Composition',
          'M = T · R · S — applied right-to-left to a vector',
          '[T][R][S][v] = T·(R·(S·v))',
          Colors.greenAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _buildMatrixBlock(
          'Determinant & Invertibility',
          'det(M) ≠ 0 ⇒ M is invertible. Hit-testing requires this.',
          'det(scale(0,1,1)) = 0  ⇒  not invertible.',
          Colors.amberAccent.shade100,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7 — Performance notes
  // ============================================================
  final Widget perf = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.green.shade50, Colors.lightGreen.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.green.shade300, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.green.shade200.withValues(alpha: 0.6),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.speed, color: Colors.green.shade800, size: 26.0),
            SizedBox(width: 8.0),
            Text(
              'Performance Notes',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildPerfRow(
          'Reuse via oldLayer',
          'pushTransform accepts an oldLayer parameter. Pass the previous '
              'TransformEngineLayer to recycle the engine resource.',
          Icons.recycling,
        ),
        _buildPerfRow(
          'Prefer Transform widget',
          'For widget-tree work, Transform composes a layer automatically. '
              'Drop to dart:ui only when batching custom paint.',
          Icons.widgets,
        ),
        _buildPerfRow(
          'Compose, then push once',
          'Multiplying matrices in Dart is cheaper than pushing many nested '
              'engine layers.',
          Icons.merge_type,
        ),
        _buildPerfRow(
          'Avoid translate-only',
          'For pure translation, prefer SceneBuilder.pushOffset which is '
              'cheaper than a full 4x4 matrix.',
          Icons.compare_arrows,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8 — Quick reference (API table)
  // ============================================================
  final Widget quickRef = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.amber.shade100, Colors.orange.shade200],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade400, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.orange.shade300.withValues(alpha: 0.5),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Quick Reference',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.orange.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        _buildApiRow(
          'SceneBuilder.pushTransform(matrix4)',
          'Pushes a transform engine layer; returns TransformEngineLayer.',
        ),
        _buildApiRow(
          'TransformEngineLayer (final class)',
          'Engine-layer wrapper; opaque handle; not directly mutable.',
        ),
        _buildApiRow(
          'oldLayer parameter',
          'Pass the previous TransformEngineLayer to reuse engine resources.',
        ),
        _buildApiRow(
          'sb.pop()',
          'Pops the most recently pushed layer; required after pushTransform.',
        ),
        _buildApiRow(
          'Float64List storage',
          'Matrix4.storage on a Matrix4 is the column-major Float64List.',
        ),
        _buildApiRow(
          'Transform widget',
          'High-level wrapper that creates a TransformLayer behind the scenes.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9 — ASCII footer
  // ============================================================
  final Widget asciiFooter = Container(
    margin: EdgeInsets.symmetric(vertical: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.black, Colors.blueGrey.shade900],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 16.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'ASCII Diagram — Layer Stack',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.greenAccent.shade400,
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          '  +-----------------------------+\n'
          '  |  Root Scene                  |\n'
          '  |  +-----------------------+   |\n'
          '  |  | TransformEngineLayer  |   |\n'
          '  |  |  (translate 40,20)    |   |\n'
          '  |  |  +-----------------+  |   |\n'
          '  |  |  | TransformLayer  |  |   |\n'
          '  |  |  |  (rotateZ 0.4)  |  |   |\n'
          '  |  |  |  +-----------+  |  |   |\n'
          '  |  |  |  |  Picture  |  |  |   |\n'
          '  |  |  |  +-----------+  |  |   |\n'
          '  |  |  +-----------------+  |   |\n'
          '  |  +-----------------------+   |\n'
          '  +-----------------------------+',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: Colors.greenAccent.shade100,
            height: 1.4,
          ),
        ),
        SizedBox(height: 14.0),
        Text(
          '// dart:ui usage\n'
          'final sb = ui.SceneBuilder();\n'
          'final layer = sb.pushTransform(matrix.storage);\n'
          '//   ...add child layers / pictures...\n'
          'sb.pop();\n'
          'final scene = sb.build();',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: Colors.cyanAccent.shade100,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  return MaterialApp(
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            heroHeader,
            anatomy,
            Text(
              'Per-Transformation Type Cards',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12.0,
              runSpacing: 12.0,
              children: transformCards,
            ),
            SizedBox(height: 16.0),
            recipes,
            pitfalls,
            matrixDiagrams,
            perf,
            quickRef,
            asciiFooter,
          ],
        ),
      ),
    ),
  );
}

// ============================================================
// Helper: Build a per-transformation visual card.
//
// Each card shows:
//   - Title and subtitle (the constructor used)
//   - The icon
//   - A live demo: a Container transformed by a static Matrix4 via
//     the Transform widget, so you can see exactly what the matrix
//     does to a sample widget.
//   - The textual matrix description.
// ============================================================
Widget _buildTransformCard({
  required String title,
  required String subtitle,
  required List<Color> gradientColors,
  required Color shadowColor,
  required IconData icon,
  required Color iconColor,
  required Matrix4 transform,
  required String matrixDescription,
}) {
  return Container(
    width: 260.0,
    margin: EdgeInsets.all(6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: gradientColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: shadowColor.withValues(alpha: 0.5), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: shadowColor.withValues(alpha: 0.4),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(icon, color: iconColor, size: 28.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: iconColor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          subtitle,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: iconColor.withValues(alpha: 0.85),
          ),
        ),
        SizedBox(height: 12.0),
        // Live visual demo
        Container(
          height: 110.0,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.7),
              width: 1.0,
            ),
          ),
          child: Center(
            child: Transform(
              alignment: Alignment.center,
              transform: transform,
              child: _buildSampleSticker(iconColor),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        // Matrix block
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.78),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            matrixDescription,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Colors.greenAccent.shade100,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

// Sample sticker rendered into each transform card so the visual effect is
// visible at a glance. We deliberately use a non-symmetric shape with text
// so rotation and skew are obvious.
Widget _buildSampleSticker(Color borderColor) {
  return Container(
    width: 90.0,
    height: 60.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[Colors.white, borderColor.withValues(alpha: 0.25)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: borderColor, width: 2.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: borderColor.withValues(alpha: 0.4),
          blurRadius: 6.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Center(
      child: Text(
        'M·v',
        style: TextStyle(
          fontFamily: 'monospace',
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
          color: borderColor,
        ),
      ),
    ),
  );
}

// Pipeline diagram widgets used in the anatomy section. We render boxes
// for each stage in the compositing pipeline and arrow icons between them.
Widget _buildPipelineRow() {
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Row(
      children: <Widget>[
        _buildPipelineBox('SceneBuilder', Colors.indigo, Icons.build),
        _buildPipelineArrow(),
        _buildPipelineBox('pushTransform', Colors.deepPurple, Icons.transform),
        _buildPipelineArrow(),
        _buildPipelineBox(
          'TransformEngineLayer',
          Colors.purple,
          Icons.layers,
        ),
        _buildPipelineArrow(),
        _buildPipelineBox('Engine Compositor', Colors.pink, Icons.memory),
        _buildPipelineArrow(),
        _buildPipelineBox('GPU Frame', Colors.red, Icons.flash_on),
      ],
    ),
  );
}

Widget _buildPipelineBox(String label, Color color, IconData icon) {
  return Container(
    width: 130.0,
    margin: EdgeInsets.symmetric(horizontal: 4.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[
          color.withValues(alpha: 0.10),
          color.withValues(alpha: 0.30),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, color: color, size: 22.0),
        SizedBox(height: 6.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _buildPipelineArrow() {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 2.0),
    child: Icon(Icons.arrow_forward, size: 22.0, color: Colors.blueGrey),
  );
}

// Recipe row used in the recipes section. Each row pairs a textual
// description with a static visual demo of the composed matrix.
Widget _buildRecipeRow(
  String name,
  String formula,
  String description,
  IconData icon,
  Color color,
  Matrix4 transform,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      children: <Widget>[
        Container(
          width: 80.0,
          height: 60.0,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: color.withValues(alpha: 0.4)),
          ),
          child: Center(
            child: Transform(
              alignment: Alignment.center,
              transform: transform,
              child: Container(
                width: 30.0,
                height: 18.0,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(icon, color: color, size: 18.0),
                  SizedBox(width: 6.0),
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: color,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.0),
              Text(
                formula,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildPitfallRow(String title, String body) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.report_problem, color: Colors.red.shade700, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.red.shade900,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.red.shade900.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildMatrixBlock(
  String name,
  String formula,
  String matrix,
  Color accent,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.black.withValues(alpha: 0.50),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: accent.withValues(alpha: 0.7), width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          formula,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          matrix,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: accent.withValues(alpha: 0.95),
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget _buildPerfRow(String title, String body, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(icon, color: Colors.green.shade800, size: 22.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.green.shade900,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.green.shade900.withValues(alpha: 0.85),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildApiRow(String name, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(Icons.api, color: Colors.orange.shade900, size: 18.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.orange.shade900,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.brown.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// Pure Float64List builders. We construct column-major 4x4 matrices
// directly so we can hand them to SceneBuilder.pushTransform without
// pulling in vector_math. These mirror the behaviour of Matrix4.
// ============================================================
Float64List _matrix4Identity() {
  final Float64List m = Float64List(16);
  m[0] = 1.0;
  m[5] = 1.0;
  m[10] = 1.0;
  m[15] = 1.0;
  return m;
}

Float64List _matrix4Translation(double dx, double dy, double dz) {
  final Float64List m = _matrix4Identity();
  m[12] = dx;
  m[13] = dy;
  m[14] = dz;
  return m;
}

Float64List _matrix4Scale(double sx, double sy, double sz) {
  final Float64List m = Float64List(16);
  m[0] = sx;
  m[5] = sy;
  m[10] = sz;
  m[15] = 1.0;
  return m;
}

Float64List _matrix4RotationZ(double radians) {
  final Float64List m = _matrix4Identity();
  final double c = _cos(radians);
  final double s = _sin(radians);
  m[0] = c;
  m[1] = s;
  m[4] = -s;
  m[5] = c;
  return m;
}

Float64List _matrix4SkewXY(double xSkew, double ySkew) {
  final Float64List m = _matrix4Identity();
  m[1] = ySkew;
  m[4] = xSkew;
  return m;
}

Float64List _matrix4Perspective(double p) {
  final Float64List m = _matrix4Identity();
  m[11] = p;
  return m;
}

// Compose a list of matrices into a single matrix using column-major
// multiplication (left-to-right: result = m0 · m1 · ... · mN). This
// matches SceneBuilder semantics where each pushTransform stacks on top
// of the previous transform.
Float64List _matrix4Compose(List<Float64List> matrices) {
  Float64List result = _matrix4Identity();
  for (final Float64List m in matrices) {
    result = _matrix4Multiply(result, m);
  }
  return result;
}

Float64List _matrix4Multiply(Float64List a, Float64List b) {
  final Float64List r = Float64List(16);
  for (int row = 0; row < 4; row++) {
    for (int col = 0; col < 4; col++) {
      double sum = 0.0;
      for (int k = 0; k < 4; k++) {
        sum += a[row + k * 4] * b[k + col * 4];
      }
      r[row + col * 4] = sum;
    }
  }
  return r;
}

// Lightweight trig used by matrix builders. Avoid pulling in dart:math via
// import to keep d4rt's surface minimal — Taylor-series approximations are
// not exact enough, so we use a simple Newton-style fallback via the
// underlying Dart core math. SceneBuilder doesn't actually rasterize the
// transform here so floating-point precision is not critical to the demo.
double _sin(double x) {
  // Reduce to [-pi, pi]
  const double pi = 3.141592653589793;
  double v = x;
  while (v > pi) {
    v -= 2 * pi;
  }
  while (v < -pi) {
    v += 2 * pi;
  }
  // Taylor series for sin around 0 (good enough for the demo)
  final double v2 = v * v;
  final double v3 = v2 * v;
  final double v5 = v3 * v2;
  final double v7 = v5 * v2;
  final double v9 = v7 * v2;
  return v - v3 / 6.0 + v5 / 120.0 - v7 / 5040.0 + v9 / 362880.0;
}

double _cos(double x) {
  const double pi = 3.141592653589793;
  double v = x;
  while (v > pi) {
    v -= 2 * pi;
  }
  while (v < -pi) {
    v += 2 * pi;
  }
  final double v2 = v * v;
  final double v4 = v2 * v2;
  final double v6 = v4 * v2;
  final double v8 = v6 * v2;
  return 1.0 - v2 / 2.0 + v4 / 24.0 - v6 / 720.0 + v8 / 40320.0;
}
