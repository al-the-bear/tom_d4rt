// D4rt test script: Deep Demo - Transform widget from widgets
// Comprehensive visual exploration of the Transform widget family, covering
// every constructor variant (Transform, Transform.rotate, Transform.scale,
// Transform.translate, Transform.flip) plus Matrix4 composition, alignment,
// origin, hit testing, filter quality, and full 3D perspective projections.
//
// This script is interpreted by D4rt; there is no main() and no runApp() —
// only a single top-level build(BuildContext) returning a Scaffold tree.
import 'package:flutter/material.dart';
import 'dart:math' as math;

// ---------------------------------------------------------------------------
// Visual palette — a single source of truth for the demo's chromatic identity.
// Picked once at the top so every section can compose against a consistent set
// of warm/cool pairs. These are plain Color literals so D4rt never has to walk
// across a ColorScheme lookup.
// ---------------------------------------------------------------------------
const Color kInkDeep = Color(0xFF1A1F36);
const Color kInkSoft = Color(0xFF5A6178);
const Color kPaperWarm = Color(0xFFFDF6EC);
const Color kPaperCool = Color(0xFFEEF3FB);
const Color kAccentMagenta = Color(0xFFD81E5B);
const Color kAccentAmber = Color(0xFFF4A261);
const Color kAccentTeal = Color(0xFF2A9D8F);
const Color kAccentIndigo = Color(0xFF3A4CB1);
const Color kAccentMint = Color(0xFF7FD8BE);
const Color kAccentRose = Color(0xFFE76F51);
const Color kAccentSky = Color(0xFF4CC9F0);
const Color kAccentGrape = Color(0xFF7209B7);
const Color kAccentLime = Color(0xFFB7E4C7);
const Color kGridLine = Color(0xFFD8DEEA);

dynamic build(BuildContext context) {
  // =========================================================================
  // PROLOGUE
  // -------------------------------------------------------------------------
  // The Transform widget is one of Flutter's most quietly powerful rendering
  // tools. Where Container/Padding/Align move things in layout-space, Transform
  // applies a pure paint-time affine (or projective) matrix to its child. The
  // layout slot the widget occupies does not change — only the bits that get
  // painted into it. That separation is what lets you rotate, skew, mirror,
  // and project widgets without disturbing the rest of the layout pipeline.
  // =========================================================================

  // -------------------------------------------------------------------------
  // Reusable atoms. We build these once so every section can compose them
  // without inflating widget construction inside the section bodies.
  // -------------------------------------------------------------------------

  // A labeled swatch — a colored square with a caption underneath. Used in
  // the palette section to introduce the demo's color vocabulary.
  Widget swatch(Color color, String label) {
    return Column(
      children: <Widget>[
        Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: kInkDeep.withValues(alpha: 0.15),
                blurRadius: 6.0,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          label,
          style: const TextStyle(fontSize: 10.0, color: kInkSoft),
        ),
      ],
    );
  }

  // A section header with a numbered chip on the left. Each major section
  // begins with one of these so the demo reads top-to-bottom like a tutorial.
  Widget sectionHeader(int number, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 44.0,
            height: 44.0,
            decoration: const BoxDecoration(
              color: kInkDeep,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              number.toString().padLeft(2, '0'),
              style: const TextStyle(
                color: kPaperWarm,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
          const SizedBox(width: 14.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                    color: kInkDeep,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13.0,
                    color: kInkSoft,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // A narrative paragraph block. We use this for every long-form explanation.
  Widget narrative(String body) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        body,
        style: const TextStyle(
          fontSize: 13.5,
          color: kInkDeep,
          height: 1.55,
        ),
      ),
    );
  }

  // A small inline code chip — used for inline `Transform.rotate` mentions.
  Widget codeChip(String code) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: kInkDeep.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: kInkDeep.withValues(alpha: 0.15)),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontSize: 12.0,
          color: kInkDeep,
          fontFamily: 'monospace',
        ),
      ),
    );
  }

  // A "mini-frame" — a captioned bordered tile that holds one transformed
  // sample child plus a before/after label pair. This is the workhorse of
  // the demo, repeated many times with different transforms inside.
  Widget miniFrame(String caption, String detail, Widget child) {
    return Container(
      width: 150.0,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: kPaperCool,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: kGridLine, width: 1.0),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 110.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            alignment: Alignment.center,
            child: child,
          ),
          const SizedBox(height: 8.0),
          Text(
            caption,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: kInkDeep,
            ),
          ),
          const SizedBox(height: 2.0),
          Text(
            detail,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 10.0, color: kInkSoft),
          ),
        ],
      ),
    );
  }

  // A token-style child — a tiny square the transforms operate on. Built so
  // every mini-frame visually reuses the same "before" baseline. The token
  // is intentionally non-square in content (it has a top tab) so rotation,
  // flip, and skew are immediately readable as transforms.
  Widget token(Color color, String label) {
    return SizedBox(
      width: 64.0,
      height: 64.0,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6.0),
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            left: 26.0,
            child: Container(
              width: 12.0,
              height: 8.0,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.75),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(3.0),
                  bottomRight: Radius.circular(3.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================================
  // SECTION 1: TITLE + PALETTE
  // =========================================================================

  final Widget titleBanner = Container(
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[kInkDeep, kAccentIndigo],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kInkDeep.withValues(alpha: 0.3),
          blurRadius: 14.0,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.threed_rotation, color: kAccentMint, size: 32.0),
            const SizedBox(width: 12.0),
            const Text(
              'Transform — Deep Visual Demo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        Text(
          'A guided tour through Flutter\'s paint-time transform pipeline: '
          'rotate, scale, translate, flip, Matrix4, alignment, origin, hit '
          'testing, filter quality, and 3D perspective.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 13.0,
            height: 1.5,
          ),
        ),
      ],
    ),
  );

  final Widget paletteStrip = Wrap(
    spacing: 14.0,
    runSpacing: 14.0,
    children: <Widget>[
      swatch(kAccentMagenta, 'Magenta'),
      swatch(kAccentAmber, 'Amber'),
      swatch(kAccentTeal, 'Teal'),
      swatch(kAccentIndigo, 'Indigo'),
      swatch(kAccentMint, 'Mint'),
      swatch(kAccentRose, 'Rose'),
      swatch(kAccentSky, 'Sky'),
      swatch(kAccentGrape, 'Grape'),
      swatch(kAccentLime, 'Lime'),
    ],
  );

  // =========================================================================
  // SECTION 2: CONCEPT CARDS — what a Transform actually is
  // =========================================================================

  final Widget conceptPaintVsLayout = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: kPaperWarm,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kAccentAmber.withValues(alpha: 0.4), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.layers, color: kAccentAmber, size: 26.0),
            SizedBox(width: 8.0),
            Text(
              'Paint-time, not layout-time',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: kInkDeep,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'Transform sits between the layout phase and the compositing phase. '
          'Its child receives layout constraints as if Transform were absent, '
          'reports its size unchanged to the parent, and only then the matrix '
          'is applied to the painted pixels. That is why a rotated 100x100 box '
          'still occupies a 100x100 slot in the parent — the rotation is in '
          'the painted output, not the geometric footprint.',
          style: TextStyle(fontSize: 12.5, height: 1.5, color: kInkDeep),
        ),
      ],
    ),
  );

  final Widget conceptMatrix4 = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: kPaperCool,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kAccentSky.withValues(alpha: 0.4), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.grid_4x4, color: kAccentSky, size: 26.0),
            SizedBox(width: 8.0),
            Text(
              'The 4x4 truth',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: kInkDeep,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'All five constructors ultimately build a 4x4 Matrix4. '
          'Transform.rotate composes a rotation-around-Z matrix; '
          'Transform.scale builds a diagonal scaling matrix; '
          'Transform.translate writes the translation column; '
          'Transform.flip is a diagonal scale of -1 along one axis. '
          'Knowing this lets you reason about every variant uniformly.',
          style: TextStyle(fontSize: 12.5, height: 1.5, color: kInkDeep),
        ),
      ],
    ),
  );

  final Widget conceptOriginAlignment = Container(
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: kPaperWarm,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: kAccentRose.withValues(alpha: 0.4), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: const <Widget>[
            Icon(Icons.gps_fixed, color: kAccentRose, size: 26.0),
            SizedBox(width: 8.0),
            Text(
              'Where the pivot lives',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: kInkDeep,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        const Text(
          'A rotation always happens around some point. Transform exposes '
          'two ways to set it: `origin` (absolute offset in the child\'s '
          'local coordinate space) and `alignment` (relative — '
          'Alignment.center, Alignment.topLeft, etc.). They compose: the '
          'final pivot is alignment-resolved-against-the-child-size plus '
          'origin. Most of the time you pick one or the other.',
          style: TextStyle(fontSize: 12.5, height: 1.5, color: kInkDeep),
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 3: TRANSFORM.ROTATE — angle sweep
  // =========================================================================
  // We build a row of mini-frames showing the same token rotated through
  // a sweep of angles. The angles are deliberately chosen so the difference
  // between adjacent frames is visible without being a full quarter turn.
  // -------------------------------------------------------------------------

  final List<double> rotateAngles = <double>[
    0.0,
    math.pi / 12, // 15 deg
    math.pi / 6, // 30 deg
    math.pi / 4, // 45 deg
    math.pi / 3, // 60 deg
    math.pi / 2, // 90 deg
    2 * math.pi / 3, // 120 deg
    math.pi, // 180 deg
  ];

  final List<String> rotateLabels = <String>[
    '0°', '15°', '30°', '45°', '60°', '90°', '120°', '180°',
  ];

  // Use List.generate (not a for-loop) because we capture `i` in a callback
  // when building, and a normal Dart for-loop's index variable is shared
  // across iterations under D4rt — every closure would see the last value.
  final List<Widget> rotateSweep = List<Widget>.generate(
    rotateAngles.length,
    (int i) {
      final double angle = rotateAngles[i];
      final String label = rotateLabels[i];
      return miniFrame(
        'rotate $label',
        'angle: ${angle.toStringAsFixed(2)} rad',
        Transform.rotate(
          angle: angle,
          child: token(kAccentMagenta, label),
        ),
      );
    },
  );

  // =========================================================================
  // SECTION 4: TRANSFORM.ROTATE — alignment vs origin
  // =========================================================================

  final Widget rotateAlignTopLeft = miniFrame(
    'alignment: topLeft',
    'pivot at the upper-left corner',
    Transform.rotate(
      angle: math.pi / 6,
      alignment: Alignment.topLeft,
      child: token(kAccentTeal, 'TL'),
    ),
  );

  final Widget rotateAlignCenter = miniFrame(
    'alignment: center',
    'default — pivot at midpoint',
    Transform.rotate(
      angle: math.pi / 6,
      child: token(kAccentTeal, 'C'),
    ),
  );

  final Widget rotateAlignBottomRight = miniFrame(
    'alignment: bottomRight',
    'pivot at lower-right corner',
    Transform.rotate(
      angle: math.pi / 6,
      alignment: Alignment.bottomRight,
      child: token(kAccentTeal, 'BR'),
    ),
  );

  final Widget rotateOriginAbsolute = miniFrame(
    'origin: (32,32)',
    'absolute offset in child space',
    Transform.rotate(
      angle: math.pi / 6,
      origin: const Offset(32.0, 32.0),
      child: token(kAccentTeal, 'O'),
    ),
  );

  // =========================================================================
  // SECTION 5: TRANSFORM.SCALE — uniform and per-axis
  // =========================================================================

  final List<double> uniformScales = <double>[0.5, 0.75, 1.0, 1.25, 1.5, 1.75];

  final List<Widget> scaleSweep = List<Widget>.generate(
    uniformScales.length,
    (int i) {
      final double s = uniformScales[i];
      return miniFrame(
        'scale ${s}x',
        'uniform — same on X and Y',
        Transform.scale(
          scale: s,
          child: token(kAccentAmber, '${s}x'),
        ),
      );
    },
  );

  // Per-axis: a non-uniform scale stretches a square into a rectangle. We
  // pick a handful of (sx, sy) combinations that explore the corners of the
  // design space — thinner, taller, squashed, and exaggerated.
  final List<List<double>> nonUniformScales = <List<double>>[
    <double>[2.0, 0.5],
    <double>[0.5, 2.0],
    <double>[1.5, 1.5],
    <double>[1.2, 0.8],
    <double>[0.8, 1.2],
    <double>[2.0, 2.0],
  ];

  final List<Widget> nonUniformWidgets = List<Widget>.generate(
    nonUniformScales.length,
    (int i) {
      final List<double> pair = nonUniformScales[i];
      final double sx = pair[0];
      final double sy = pair[1];
      return miniFrame(
        'sx:$sx sy:$sy',
        'Transform.scale per-axis',
        Transform.scale(
          scaleX: sx,
          scaleY: sy,
          child: token(kAccentGrape, '${sx}x$sy'),
        ),
      );
    },
  );

  // =========================================================================
  // SECTION 6: TRANSFORM.TRANSLATE — vector offsets
  // =========================================================================

  final List<Offset> translateOffsets = <Offset>[
    Offset.zero,
    const Offset(20.0, 0.0),
    const Offset(-20.0, 0.0),
    const Offset(0.0, 20.0),
    const Offset(0.0, -20.0),
    const Offset(20.0, 20.0),
    const Offset(-20.0, -20.0),
    const Offset(15.0, -15.0),
  ];

  final List<Widget> translateWidgets = List<Widget>.generate(
    translateOffsets.length,
    (int i) {
      final Offset o = translateOffsets[i];
      return miniFrame(
        'translate',
        'dx:${o.dx.toStringAsFixed(0)}  dy:${o.dy.toStringAsFixed(0)}',
        Transform.translate(
          offset: o,
          child: token(kAccentRose, 'T'),
        ),
      );
    },
  );

  // =========================================================================
  // SECTION 7: TRANSFORM.FLIP — mirroring across each axis
  // =========================================================================

  final Widget flipNone = miniFrame(
    'flip — none',
    'baseline reference',
    token(kAccentSky, 'F'),
  );

  final Widget flipX = miniFrame(
    'flip — flipX',
    'mirrored horizontally',
    Transform.flip(
      flipX: true,
      child: token(kAccentSky, 'F'),
    ),
  );

  final Widget flipY = miniFrame(
    'flip — flipY',
    'mirrored vertically',
    Transform.flip(
      flipY: true,
      child: token(kAccentSky, 'F'),
    ),
  );

  final Widget flipBoth = miniFrame(
    'flip — both',
    'X and Y simultaneously',
    Transform.flip(
      flipX: true,
      flipY: true,
      child: token(kAccentSky, 'F'),
    ),
  );

  // =========================================================================
  // SECTION 8: MATRIX4 — manually composed transforms
  // =========================================================================
  // These are the gnarly cases that none of the named constructors can
  // express directly: shear, mixed rotation+scale, and full 3D pose.
  // -------------------------------------------------------------------------

  // Shear along X — moves top edge right, bottom edge left (parallelogram).
  final Matrix4 shearXMatrix = Matrix4.identity()..setEntry(0, 1, 0.35);

  // Shear along Y — moves right edge down, left edge up.
  final Matrix4 shearYMatrix = Matrix4.identity()..setEntry(1, 0, 0.35);

  // Pure Matrix4 rotation around Z, equivalent to Transform.rotate.
  final Matrix4 rotZMatrix = Matrix4.rotationZ(math.pi / 5);

  // A composed transform: translate then rotate then scale. Multiplication
  // is read right-to-left in math, so the *child* sees scale first.
  final Matrix4 composedMatrix = Matrix4.identity()
    ..translateByDouble(8.0, 4.0, 0.0, 1.0)
    ..rotateZ(math.pi / 8)
    ..scaleByDouble(1.15, 1.15, 1.0, 1.0);

  // Skew constructors. Matrix4.skewX(angle) takes radians.
  final Matrix4 skewXMatrix = Matrix4.skewX(0.25);
  final Matrix4 skewYMatrix = Matrix4.skewY(0.25);

  // Translation matrix — equivalent to Transform.translate(Offset(dx, dy)).
  final Matrix4 translationMatrix = Matrix4.translationValues(12.0, -6.0, 0.0);

  // Diagonal scale matrix — equivalent to Transform.scale, with the extra
  // freedom of a Z scale (which has no visual effect in 2D but matters
  // when you go 3D).
  final Matrix4 diagonalMatrix = Matrix4.diagonal3Values(1.4, 0.9, 1.0);

  final List<Map<String, Object>> matrixSamples = <Map<String, Object>>[
    <String, Object>{
      'title': 'shearX',
      'detail': 'entry(0,1) = 0.35',
      'matrix': shearXMatrix,
      'color': kAccentMint,
    },
    <String, Object>{
      'title': 'shearY',
      'detail': 'entry(1,0) = 0.35',
      'matrix': shearYMatrix,
      'color': kAccentMint,
    },
    <String, Object>{
      'title': 'rotationZ',
      'detail': 'Matrix4.rotationZ(π/5)',
      'matrix': rotZMatrix,
      'color': kAccentIndigo,
    },
    <String, Object>{
      'title': 'composed',
      'detail': 'translate · rotateZ · scale',
      'matrix': composedMatrix,
      'color': kAccentGrape,
    },
    <String, Object>{
      'title': 'skewX',
      'detail': 'Matrix4.skewX(0.25)',
      'matrix': skewXMatrix,
      'color': kAccentRose,
    },
    <String, Object>{
      'title': 'skewY',
      'detail': 'Matrix4.skewY(0.25)',
      'matrix': skewYMatrix,
      'color': kAccentRose,
    },
    <String, Object>{
      'title': 'translation',
      'detail': 'translationValues(12,-6,0)',
      'matrix': translationMatrix,
      'color': kAccentTeal,
    },
    <String, Object>{
      'title': 'diagonal3',
      'detail': 'diagonal3Values(1.4,0.9,1)',
      'matrix': diagonalMatrix,
      'color': kAccentTeal,
    },
  ];

  final List<Widget> matrixGallery = List<Widget>.generate(
    matrixSamples.length,
    (int i) {
      final Map<String, Object> sample = matrixSamples[i];
      final String title = sample['title'] as String;
      final String detail = sample['detail'] as String;
      final Matrix4 m = sample['matrix'] as Matrix4;
      final Color c = sample['color'] as Color;
      return miniFrame(
        title,
        detail,
        Transform(
          transform: m,
          alignment: Alignment.center,
          child: token(c, title.substring(0, 1).toUpperCase()),
        ),
      );
    },
  );

  // =========================================================================
  // SECTION 9: 3D PERSPECTIVE
  // =========================================================================
  // The famous incantation `Matrix4.identity()..setEntry(3, 2, 0.001)`
  // makes a 4x4 matrix that performs a perspective divide. The bigger the
  // number, the more aggressive the foreshortening. Below we sweep both the
  // perspective strength and the Y rotation to give a flavor for how the
  // two interact.
  // -------------------------------------------------------------------------

  Matrix4 makePerspective({
    required double persp,
    required double rotX,
    required double rotY,
    required double rotZ,
  }) {
    final Matrix4 m = Matrix4.identity();
    m.setEntry(3, 2, persp);
    m.rotateX(rotX);
    m.rotateY(rotY);
    m.rotateZ(rotZ);
    return m;
  }

  final List<double> ySweep = <double>[
    -math.pi / 3,
    -math.pi / 6,
    -math.pi / 12,
    0.0,
    math.pi / 12,
    math.pi / 6,
    math.pi / 3,
  ];

  final List<String> ySweepLabels = <String>[
    '-60°', '-30°', '-15°', '0°', '+15°', '+30°', '+60°',
  ];

  final List<Widget> perspectiveYRow = List<Widget>.generate(
    ySweep.length,
    (int i) {
      return miniFrame(
        'rotY ${ySweepLabels[i]}',
        'persp 0.001',
        Transform(
          transform: makePerspective(
            persp: 0.001,
            rotX: 0.0,
            rotY: ySweep[i],
            rotZ: 0.0,
          ),
          alignment: Alignment.center,
          child: token(kAccentSky, 'Y'),
        ),
      );
    },
  );

  final List<Widget> perspectiveXRow = List<Widget>.generate(
    ySweep.length,
    (int i) {
      return miniFrame(
        'rotX ${ySweepLabels[i]}',
        'persp 0.001',
        Transform(
          transform: makePerspective(
            persp: 0.001,
            rotX: ySweep[i],
            rotY: 0.0,
            rotZ: 0.0,
          ),
          alignment: Alignment.center,
          child: token(kAccentIndigo, 'X'),
        ),
      );
    },
  );

  // Perspective strength sweep — same rotation, escalating depth.
  final List<double> perspSweep = <double>[0.0, 0.0005, 0.001, 0.002, 0.004];

  final List<Widget> perspectiveStrengthRow = List<Widget>.generate(
    perspSweep.length,
    (int i) {
      final double p = perspSweep[i];
      return miniFrame(
        'persp ${p.toStringAsFixed(4)}',
        'rotY 45°  rotX 25°',
        Transform(
          transform: makePerspective(
            persp: p,
            rotX: math.pi / 7,
            rotY: math.pi / 4,
            rotZ: 0.0,
          ),
          alignment: Alignment.center,
          child: token(kAccentGrape, 'P'),
        ),
      );
    },
  );

  // A single hero "card" — a larger 3D pose to show what production usage
  // tends to look like (flip-card, perspective covers, etc).
  final Widget heroCard = Container(
    height: 220.0,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: kPaperCool,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: kGridLine),
    ),
    alignment: Alignment.center,
    child: Transform(
      transform: makePerspective(
        persp: 0.0015,
        rotX: math.pi / 9,
        rotY: -math.pi / 5,
        rotZ: 0.0,
      ),
      alignment: Alignment.center,
      child: Container(
        width: 200.0,
        height: 130.0,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: <Color>[kAccentMagenta, kAccentGrape],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: kAccentGrape.withValues(alpha: 0.45),
              blurRadius: 22.0,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const <Widget>[
            Text(
              '3D Card',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Matrix4 setEntry(3,2,0.0015)\nrotateX(π/9)  rotateY(-π/5)',
              style: TextStyle(color: Colors.white70, fontSize: 11.0),
            ),
          ],
        ),
      ),
    ),
  );

  // =========================================================================
  // SECTION 10: COMPOSED TRANSFORMS (NESTED)
  // =========================================================================

  final Widget composedRotateScale = miniFrame(
    'rotate ∘ scale',
    'outer rotates, inner scales',
    Transform.rotate(
      angle: math.pi / 8,
      child: Transform.scale(
        scale: 1.2,
        child: token(kAccentTeal, 'RS'),
      ),
    ),
  );

  final Widget composedScaleRotate = miniFrame(
    'scale ∘ rotate',
    'outer scales, inner rotates',
    Transform.scale(
      scale: 1.2,
      child: Transform.rotate(
        angle: math.pi / 8,
        child: token(kAccentTeal, 'SR'),
      ),
    ),
  );

  final Widget composedFlipRotate = miniFrame(
    'flip ∘ rotate',
    'mirror then spin',
    Transform.flip(
      flipX: true,
      child: Transform.rotate(
        angle: math.pi / 6,
        child: token(kAccentRose, 'FR'),
      ),
    ),
  );

  final Widget composedTripleStack = miniFrame(
    'translate ∘ rotate ∘ scale',
    'all three named ops layered',
    Transform.translate(
      offset: const Offset(-8.0, -8.0),
      child: Transform.rotate(
        angle: math.pi / 10,
        child: Transform.scale(
          scale: 0.95,
          child: token(kAccentAmber, 'TRS'),
        ),
      ),
    ),
  );

  final Widget composedMatrixVsNested = miniFrame(
    'matrix == nested?',
    'multiplication order matters',
    Transform(
      transform: Matrix4.identity()
        ..translateByDouble(-8.0, -8.0, 0.0, 1.0)
        ..rotateZ(math.pi / 10)
        ..scaleByDouble(0.95, 0.95, 1.0, 1.0),
      alignment: Alignment.center,
      child: token(kAccentAmber, 'M'),
    ),
  );

  // =========================================================================
  // SECTION 11: HIT TESTS
  // =========================================================================
  // transformHitTests is true by default. Setting it false makes the touch
  // surface obey the *original* layout slot, even though the painted pixels
  // have moved. We render the two cases side-by-side with GestureDetectors
  // wired to a local "log" Text so the difference is something you can feel
  // when you tap, not just read about.
  // -------------------------------------------------------------------------

  // We model the "log" as a stateless display string — D4rt scripts are
  // typically built once per call, and the SendTestRunner harness re-runs
  // the build function on each event, so we keep this side effect free.
  const String hitTestExplanation =
      'A rotated GestureDetector with transformHitTests:true responds where '
      'you see it. With transformHitTests:false the hit area sits where the '
      'child would have been without the rotation.';

  final Widget hitTestPair = Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      miniFrame(
        'transformHitTests: true',
        'tap follows pixels',
        Transform.rotate(
          angle: math.pi / 4,
          transformHitTests: true,
          child: GestureDetector(
            onTap: () {},
            child: token(kAccentMint, '✓'),
          ),
        ),
      ),
      miniFrame(
        'transformHitTests: false',
        'tap stays in layout slot',
        Transform.rotate(
          angle: math.pi / 4,
          transformHitTests: false,
          child: GestureDetector(
            onTap: () {},
            child: token(kAccentMint, '×'),
          ),
        ),
      ),
    ],
  );

  // =========================================================================
  // SECTION 12: FILTER QUALITY
  // =========================================================================
  // FilterQuality affects how the rasterized child is sampled when the
  // transform doesn't land on integer pixel positions. The four values are
  // none, low, medium, high. The visual difference is most visible on
  // diagonal text or thin strokes; we use a chunky token here so the demo
  // remains legible at small sizes.
  // -------------------------------------------------------------------------

  final List<FilterQuality> filterQualities = <FilterQuality>[
    FilterQuality.none,
    FilterQuality.low,
    FilterQuality.medium,
    FilterQuality.high,
  ];

  final List<String> filterLabels = <String>[
    'none', 'low', 'medium', 'high',
  ];

  final List<Widget> filterRow = List<Widget>.generate(
    filterQualities.length,
    (int i) {
      return miniFrame(
        'filter: ${filterLabels[i]}',
        'FilterQuality.${filterLabels[i]}',
        Transform.rotate(
          angle: math.pi / 8,
          filterQuality: filterQualities[i],
          child: token(kAccentIndigo, filterLabels[i].substring(0, 1)),
        ),
      );
    },
  );

  // =========================================================================
  // SECTION 13: ROTATEDBOX vs TRANSFORM.ROTATE
  // =========================================================================
  // RotatedBox is the layout-time sibling of Transform.rotate. It rotates
  // in quarter-turns *and* swaps the layout slot dimensions, so a horizontal
  // 200x40 bar rotated by RotatedBox becomes a 40x200 vertical bar in the
  // parent's eyes. Transform.rotate cannot do that — its layout slot stays
  // 200x40 even when the painted bar is vertical.
  // -------------------------------------------------------------------------

  final Widget rotatedBoxDemo = Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: kPaperWarm,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: kGridLine),
    ),
    child: Column(
      children: <Widget>[
        const Text(
          'Same child — three rotations',
          style: TextStyle(fontWeight: FontWeight.bold, color: kInkDeep),
        ),
        const SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  width: 140.0,
                  height: 60.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kAccentTeal,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: const Text(
                    'baseline',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 6.0),
                const Text('no rotation', style: TextStyle(fontSize: 10.0)),
              ],
            ),
            Column(
              children: <Widget>[
                SizedBox(
                  width: 140.0,
                  height: 60.0,
                  child: Transform.rotate(
                    angle: math.pi / 2,
                    child: Container(
                      width: 140.0,
                      height: 60.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: kAccentMagenta,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: const Text(
                        'Transform',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 6.0),
                const Text(
                  'Transform.rotate(π/2)\nlayout slot unchanged',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10.0),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                RotatedBox(
                  quarterTurns: 1,
                  child: Container(
                    width: 140.0,
                    height: 60.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: kAccentGrape,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: const Text(
                      'RotatedBox',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 6.0),
                const Text(
                  'RotatedBox(1)\nlayout slot swaps W/H',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10.0),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // =========================================================================
  // SECTION 14: MATRIX4 OPERATIONS REFERENCE
  // =========================================================================

  final List<Map<String, String>> matrix4Reference = <Map<String, String>>[
    <String, String>{
      'op': 'Matrix4.identity()',
      'desc': 'No-op transform. The neutral element of composition.',
    },
    <String, String>{
      'op': 'Matrix4.rotationX(rad)',
      'desc': 'Rotates around the X axis (tilts forward/backward).',
    },
    <String, String>{
      'op': 'Matrix4.rotationY(rad)',
      'desc': 'Rotates around the Y axis (turns left/right).',
    },
    <String, String>{
      'op': 'Matrix4.rotationZ(rad)',
      'desc': 'Rotates around the Z axis — the 2D rotation.',
    },
    <String, String>{
      'op': 'Matrix4.translationValues(x,y,z)',
      'desc': 'Pure translation; equivalent to Transform.translate in 2D.',
    },
    <String, String>{
      'op': 'Matrix4.diagonal3Values(sx,sy,sz)',
      'desc': 'Uniform or per-axis scale; -1 on an axis is a flip.',
    },
    <String, String>{
      'op': 'Matrix4.skewX(rad)',
      'desc': 'Shears by writing into the (0,1) entry.',
    },
    <String, String>{
      'op': 'Matrix4.skewY(rad)',
      'desc': 'Shears by writing into the (1,0) entry.',
    },
    <String, String>{
      'op': 'm..setEntry(3, 2, 0.001)',
      'desc': 'Adds perspective foreshortening to a 3D pose.',
    },
    <String, String>{
      'op': 'm..rotateX(rad)',
      'desc': 'Composes an X rotation onto an existing matrix.',
    },
    <String, String>{
      'op': 'm..rotateY(rad)',
      'desc': 'Composes a Y rotation; right-to-left in math notation.',
    },
    <String, String>{
      'op': 'm..rotateZ(rad)',
      'desc': 'Composes a Z rotation onto an existing matrix.',
    },
    <String, String>{
      'op': 'm..translate(x,y,z)',
      'desc': 'Composes a translation onto an existing matrix.',
    },
    <String, String>{
      'op': 'm..scale(sx,sy,sz)',
      'desc': 'Composes a scale onto an existing matrix.',
    },
    <String, String>{
      'op': 'a.multiplied(b)',
      'desc': 'Returns a new matrix equal to a · b without mutating a.',
    },
    <String, String>{
      'op': 'a..multiply(b)',
      'desc': 'In-place multiply: a becomes a · b.',
    },
  ];

  final List<Widget> matrixReferenceRows = List<Widget>.generate(
    matrix4Reference.length,
    (int i) {
      final Map<String, String> entry = matrix4Reference[i];
      final Color stripe = i.isEven ? kPaperCool : Colors.white;
      return Container(
        color: stripe,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 200.0,
              child: Text(
                entry['op'] ?? '',
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  color: kAccentGrape,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Text(
                entry['desc'] ?? '',
                style: const TextStyle(fontSize: 12.0, color: kInkDeep),
              ),
            ),
          ],
        ),
      );
    },
  );

  // =========================================================================
  // SECTION 15: TRANSFORM CHEATSHEET
  // =========================================================================

  final List<Map<String, String>> cheatsheet = <Map<String, String>>[
    <String, String>{
      'when': 'rotate by an angle',
      'use': 'Transform.rotate(angle: ...)',
    },
    <String, String>{
      'when': 'rotate by 90/180/270 AND resize layout',
      'use': 'RotatedBox(quarterTurns: ...)',
    },
    <String, String>{
      'when': 'uniform shrink/grow',
      'use': 'Transform.scale(scale: ...)',
    },
    <String, String>{
      'when': 'different X and Y scale',
      'use': 'Transform.scale(scaleX: ..., scaleY: ...)',
    },
    <String, String>{
      'when': 'mirror horizontally',
      'use': 'Transform.flip(flipX: true)',
    },
    <String, String>{
      'when': 'mirror vertically',
      'use': 'Transform.flip(flipY: true)',
    },
    <String, String>{
      'when': 'offset paint output',
      'use': 'Transform.translate(offset: Offset(dx, dy))',
    },
    <String, String>{
      'when': 'animate offset cheaply (no relayout)',
      'use': 'Transform.translate inside AnimatedBuilder',
    },
    <String, String>{
      'when': 'shear / skew',
      'use': 'Transform(transform: Matrix4.skewX(rad))',
    },
    <String, String>{
      'when': '3D card flip / cover flow',
      'use': 'Transform(transform: ..setEntry(3,2,0.001)..rotateY(rad))',
    },
    <String, String>{
      'when': 'composed transform reused in multiple places',
      'use': 'Build a Matrix4 once, pass it to Transform(transform: m)',
    },
    <String, String>{
      'when': 'high-quality rotation of a photo',
      'use': 'Transform.rotate(filterQuality: FilterQuality.high)',
    },
    <String, String>{
      'when': 'pivot at a corner instead of center',
      'use': 'Transform.rotate(alignment: Alignment.topLeft)',
    },
    <String, String>{
      'when': 'pivot at an exact pixel offset',
      'use': 'Transform.rotate(origin: Offset(x, y))',
    },
    <String, String>{
      'when': 'touch follows visible pixels',
      'use': 'transformHitTests: true (the default)',
    },
    <String, String>{
      'when': 'touch stays in layout slot',
      'use': 'transformHitTests: false',
    },
  ];

  final List<Widget> cheatsheetRows = List<Widget>.generate(
    cheatsheet.length,
    (int i) {
      final Map<String, String> row = cheatsheet[i];
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Icon(Icons.arrow_right, size: 16.0, color: kAccentTeal),
            const SizedBox(width: 6.0),
            SizedBox(
              width: 220.0,
              child: Text(
                row['when'] ?? '',
                style: const TextStyle(
                  fontSize: 12.0,
                  color: kInkDeep,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(child: codeChip(row['use'] ?? '')),
          ],
        ),
      );
    },
  );

  // =========================================================================
  // SECTION 16: EPILOGUE
  // =========================================================================

  final Widget epilogue = Container(
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: <Color>[kAccentTeal, kAccentIndigo],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Row(
          children: <Widget>[
            Icon(Icons.flag, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'Takeaways',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        Text(
          '• Transform is a paint-time affine. The child\'s layout slot does '
          'not move.\n'
          '• All five constructors build a Matrix4; learn that and you have '
          'them all.\n'
          '• Use Transform.rotate/scale/translate/flip for readability; drop '
          'to Transform(transform: Matrix4) for composition or 3D.\n'
          '• alignment vs origin: alignment is relative to child size, origin '
          'is an absolute offset. They add.\n'
          '• transformHitTests defaults to true — touch follows pixels.\n'
          '• Perspective is a single matrix entry: setEntry(3, 2, ~0.001).\n'
          '• When you need layout to actually rotate (slot W/H swap), reach '
          'for RotatedBox instead of Transform.rotate.',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.92),
            fontSize: 13.0,
            height: 1.7,
          ),
        ),
      ],
    ),
  );

  // =========================================================================
  // ASSEMBLY — Scaffold + SingleChildScrollView column
  // =========================================================================

  return Scaffold(
    backgroundColor: kPaperWarm,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // ----- Title -----
            titleBanner,
            const SizedBox(height: 22.0),

            // ----- Palette -----
            sectionHeader(
              1,
              'Palette',
              'The colors every following section composes against. '
                  'Picked once, reused everywhere.',
            ),
            paletteStrip,
            const SizedBox(height: 8.0),

            // ----- Concept cards -----
            sectionHeader(
              2,
              'What a Transform actually is',
              'Three concept cards: paint vs layout, the 4x4 matrix '
                  'underneath every constructor, and where the pivot lives.',
            ),
            conceptPaintVsLayout,
            const SizedBox(height: 12.0),
            conceptMatrix4,
            const SizedBox(height: 12.0),
            conceptOriginAlignment,

            // ----- Rotation sweep -----
            sectionHeader(
              3,
              'Transform.rotate — angle sweep',
              'The same token rotated through eight angles between 0 and π. '
                  'Watch how the layout slot stays a fixed 64x64 even as the '
                  'painted token spins.',
            ),
            narrative(
              'Transform.rotate takes an angle in radians, not degrees. Use '
              'math.pi to convert: a 30° rotation is math.pi / 6, a 45° '
              'rotation is math.pi / 4. The named constructor is just sugar '
              'on top of Matrix4.rotationZ.',
            ),
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              alignment: WrapAlignment.start,
              children: rotateSweep,
            ),

            // ----- Alignment vs origin -----
            sectionHeader(
              4,
              'alignment vs origin',
              'Same 30° rotation, four different pivot configurations. '
                  'Alignment is relative; origin is absolute.',
            ),
            narrative(
              'The pivot point determines where the rotation "happens". '
              'Setting alignment to topLeft makes the child swing out and to '
              'the right; bottomRight makes it swing the opposite way. The '
              'origin parameter is added on top of the alignment-resolved '
              'pivot — it is the escape hatch for when alignment cannot '
              'express what you need.',
            ),
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: <Widget>[
                rotateAlignTopLeft,
                rotateAlignCenter,
                rotateAlignBottomRight,
                rotateOriginAbsolute,
              ],
            ),

            // ----- Scale sweep -----
            sectionHeader(
              5,
              'Transform.scale — uniform',
              'Same token, six uniform scale factors. Note: scale 0.5 '
                  'shrinks the painted output but the layout slot stays the '
                  'same as the unscaled child.',
            ),
            narrative(
              'Uniform scale is the simplest path to a hover/press effect: '
              'wrap a child in Transform.scale and animate the factor '
              'between 0.95 and 1.05. Because the layout slot is unchanged, '
              'neighbors do not reflow as the scale animates.',
            ),
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: scaleSweep,
            ),

            // ----- Non-uniform scale -----
            sectionHeader(
              6,
              'Transform.scale — per-axis',
              'When scaleX and scaleY diverge, you get stretches, squashes, '
                  'and the cartoon-style "anticipation" pose.',
            ),
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: nonUniformWidgets,
            ),

            // ----- Translate -----
            sectionHeader(
              7,
              'Transform.translate',
              'Paint the child at an offset without disturbing layout. '
                  'Useful for parallax, bobs, and animated nudges.',
            ),
            narrative(
              'Transform.translate is the cheapest way to animate position '
              'because it does no layout work. The layout slot stays put; '
              'only the painted offset moves. Compare against AnimatedAlign '
              'or Positioned which both trigger layout passes.',
            ),
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: translateWidgets,
            ),

            // ----- Flip -----
            sectionHeader(
              8,
              'Transform.flip',
              'Mirror across one or both axes. Implemented as a diagonal '
                  'scale matrix with -1 entries.',
            ),
            narrative(
              'Transform.flip with flipX:true is mathematically identical to '
              'Transform.scale(scaleX: -1, scaleY: 1) — the named '
              'constructor exists purely for readability.',
            ),
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: <Widget>[flipNone, flipX, flipY, flipBoth],
            ),

            // ----- Matrix4 gallery -----
            sectionHeader(
              9,
              'Matrix4 — the full toolbox',
              'Shears, manual rotations, composed translations, diagonal '
                  'scales. Every one of these uses the raw Transform(...) '
                  'constructor with a hand-built Matrix4.',
            ),
            narrative(
              'When the named constructors are not enough — or when you '
              'want to bake a complex transform once and reuse it — drop '
              'down to a Matrix4 and pass it via the unnamed Transform '
              'constructor. The cascade syntax (..rotateZ(..)..scale(..)) '
              'makes multi-step composition concise.',
            ),
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: matrixGallery,
            ),

            // ----- 3D perspective sweep -----
            sectionHeader(
              10,
              '3D perspective — Y axis sweep',
              'Same perspective strength (0.001), seven different Y '
                  'rotations. The token tips towards and away from the '
                  'camera.',
            ),
            narrative(
              'The line setEntry(3, 2, 0.001) is the magic. It writes a '
              'small number into the matrix\'s perspective row, which makes '
              'the GPU do a perspective divide during compositing. Smaller '
              'values give subtle 3D; larger values exaggerate it.',
            ),
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: perspectiveYRow,
            ),

            // ----- X axis sweep -----
            sectionHeader(
              11,
              '3D perspective — X axis sweep',
              'Now rotating around the X axis instead. The token tilts '
                  'forward and back.',
            ),
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: perspectiveXRow,
            ),

            // ----- Strength sweep -----
            sectionHeader(
              12,
              '3D perspective — strength sweep',
              'Same rotation, escalating perspective values. Higher = more '
                  'dramatic foreshortening.',
            ),
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: perspectiveStrengthRow,
            ),

            const SizedBox(height: 18.0),
            heroCard,

            // ----- Composed transforms -----
            sectionHeader(
              13,
              'Composed transforms',
              'Nesting Transform widgets is equivalent to multiplying their '
                  'matrices — outer transforms apply last.',
            ),
            narrative(
              'Two nested Transforms compose the same way two matrix '
              'multiplications do: outer · inner. That means swapping which '
              'one is on the outside changes the result. The last frame '
              'shows the same composition done as a single Matrix4 — the '
              'result is identical, but a hand-built Matrix4 avoids one '
              'layer of Transform widget overhead per frame.',
            ),
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: <Widget>[
                composedRotateScale,
                composedScaleRotate,
                composedFlipRotate,
                composedTripleStack,
                composedMatrixVsNested,
              ],
            ),

            // ----- Hit tests -----
            sectionHeader(
              14,
              'transformHitTests',
              'Where the touch surface lives after a rotation.',
            ),
            narrative(hitTestExplanation),
            hitTestPair,

            // ----- Filter quality -----
            sectionHeader(
              15,
              'filterQuality',
              'How sampling behaves when the transform produces sub-pixel '
                  'positions.',
            ),
            narrative(
              'For static transforms this rarely matters. For animated '
              'rotations of high-detail content (photos, icons, glyphs at '
              'odd sizes) bumping filterQuality up to medium or high can '
              'reduce shimmer at the cost of a small per-frame GPU expense.',
            ),
            Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              children: filterRow,
            ),

            // ----- RotatedBox vs Transform.rotate -----
            sectionHeader(
              16,
              'RotatedBox vs Transform.rotate',
              'The crucial layout-versus-paint difference, side by side.',
            ),
            narrative(
              'If you have ever wondered why your rotated Text suddenly '
              'started getting clipped, this is usually the answer. '
              'Transform.rotate keeps the original layout slot — a '
              'horizontal 200x40 bar still asks the parent for 200x40 even '
              'when painted vertically, so the painted vertical bar is '
              'taller than its slot and the top and bottom get cropped. '
              'RotatedBox swaps the slot dimensions, so the parent makes '
              'room for the rotated bar.',
            ),
            rotatedBoxDemo,

            // ----- Matrix4 reference -----
            sectionHeader(
              17,
              'Matrix4 operation reference',
              'A quick lookup for the operations that come up the most when '
                  'building transforms by hand.',
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: kGridLine),
              ),
              child: Column(children: matrixReferenceRows),
            ),

            // ----- Cheatsheet -----
            sectionHeader(
              18,
              'Cheatsheet',
              'Pick the right constructor for the job.',
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: cheatsheetRows,
            ),

            // ----- Epilogue -----
            const SizedBox(height: 24.0),
            epilogue,
            const SizedBox(height: 32.0),
          ],
        ),
      ),
    ),
  );
}
