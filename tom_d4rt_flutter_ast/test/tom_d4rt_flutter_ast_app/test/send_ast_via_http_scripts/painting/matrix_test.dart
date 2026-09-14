// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt visual reference: MatrixUtils & Matrix4 painting helpers.
// Theme: "Cartesian Indigo" — a deep indigo / lavender / carbon study of
// 4x4 affine and projective transformations as used by the Flutter
// painting and rendering layers. This file is intentionally a long
// hand-authored visual catalogue. There is exactly one build() entry
// point (no main, no runApp). Animations are inert
// (AlwaysStoppedAnimation<double>(t)). All Matrix4 / MatrixUtils calls
// are wrapped in try/catch because the d4rt interpreter may surface
// the matrix runtime through dynamic bridges where any operation is
// allowed to throw.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('[matrix_test] Cartesian Indigo reference assembling');

  // ---------------------------------------------------------------
  // Palette: Cartesian Indigo
  // ---------------------------------------------------------------
  const Color paperVoid = Color(0xFF0C0E1A);
  const Color paperDeep = Color(0xFF131630);
  const Color paperMid = Color(0xFF1C2046);
  const Color paperRise = Color(0xFF252A5C);
  const Color paperFog = Color(0xFFE9EAF7);
  const Color inkPrimary = Color(0xFFEFF1FB);
  const Color inkMuted = Color(0xFFAEB3D6);
  const Color inkDim = Color(0xFF7A80AC);
  const Color accentIndigo = Color(0xFF7B6CF6);
  const Color accentLavender = Color(0xFFB39DFF);
  const Color accentSky = Color(0xFF6FB1FC);
  const Color accentTeal = Color(0xFF4FD1C5);
  const Color accentMint = Color(0xFF77E2B3);
  const Color accentAmber = Color(0xFFFFC36A);
  const Color accentRose = Color(0xFFFF7AA2);
  const Color accentMagenta = Color(0xFFC56CF0);
  const Color accentCarbon = Color(0xFF2A2D3F);
  const Color borderDim = Color(0xFF2D335E);
  const Color borderBright = Color(0xFF3E458A);
  const Color flagAffine = Color(0xFF4FD1C5);
  const Color flagPerspective = Color(0xFFFFC36A);
  const Color flagIdentity = Color(0xFFB39DFF);
  const Color flagSingular = Color(0xFFFF7AA2);

  // ---------------------------------------------------------------
  // Matrix construction (all wrapped in try/catch).
  // ---------------------------------------------------------------
  Matrix4 mIdentity = Matrix4.identity();
  try {
    mIdentity = Matrix4.identity();
    print('[matrix_test] identity built: $mIdentity');
  } catch (e) {
    print('[matrix_test] identity failed: $e');
  }

  Matrix4 mRotZ45 = Matrix4.identity();
  try {
    mRotZ45 = Matrix4.rotationZ(0.785398);
    print('[matrix_test] rotZ45 built: $mRotZ45');
  } catch (e) {
    print('[matrix_test] rotZ45 failed: $e');
  }

  Matrix4 mRotZ30 = Matrix4.identity();
  try {
    mRotZ30 = Matrix4.rotationZ(0.523599);
  } catch (e) {
    print('[matrix_test] rotZ30 failed: $e');
  }

  Matrix4 mRotZ90 = Matrix4.identity();
  try {
    mRotZ90 = Matrix4.rotationZ(1.570796);
  } catch (e) {
    print('[matrix_test] rotZ90 failed: $e');
  }

  Matrix4 mTranslate = Matrix4.identity();
  try {
    mTranslate = Matrix4.translationValues(40.0, 24.0, 0.0);
  } catch (e) {
    print('[matrix_test] translate failed: $e');
  }

  Matrix4 mTranslateZ = Matrix4.identity();
  try {
    mTranslateZ = Matrix4.translationValues(0.0, 0.0, 12.0);
  } catch (e) {
    print('[matrix_test] translateZ failed: $e');
  }

  Matrix4 mScaleUniform = Matrix4.identity();
  try {
    mScaleUniform = Matrix4.diagonal3Values(1.5, 1.5, 1.0);
  } catch (e) {
    print('[matrix_test] scale failed: $e');
  }

  Matrix4 mScaleNonUniform = Matrix4.identity();
  try {
    mScaleNonUniform = Matrix4.diagonal3Values(2.0, 0.5, 1.0);
  } catch (e) {
    print('[matrix_test] scaleNonUniform failed: $e');
  }

  Matrix4 mScaleNegative = Matrix4.identity();
  try {
    mScaleNegative = Matrix4.diagonal3Values(-1.0, 1.0, 1.0);
  } catch (e) {
    print('[matrix_test] scaleNegative failed: $e');
  }

  Matrix4 mSkewX = Matrix4.identity();
  try {
    mSkewX = Matrix4.skewX(0.3);
  } catch (e) {
    print('[matrix_test] skewX failed: $e');
  }

  Matrix4 mSkewY = Matrix4.identity();
  try {
    mSkewY = Matrix4.skewY(0.2);
  } catch (e) {
    print('[matrix_test] skewY failed: $e');
  }

  Matrix4 mPerspective = Matrix4.identity();
  try {
    mPerspective = Matrix4.identity();
    mPerspective.setEntry(3, 2, 0.001);
  } catch (e) {
    print('[matrix_test] perspective failed: $e');
  }

  Matrix4 mComposed = Matrix4.identity();
  try {
    mComposed = Matrix4.identity();
    mComposed.translateByDouble(50.0, 0.0, 0.0, 1.0);
    mComposed.rotateZ(0.4);
    mComposed.scaleByDouble(1.2, 1.2, 1.0, 1.0);
  } catch (e) {
    print('[matrix_test] composed failed: $e');
  }

  Matrix4 mSingular = Matrix4.identity();
  try {
    mSingular = Matrix4.diagonal3Values(0.0, 0.0, 0.0);
  } catch (e) {
    print('[matrix_test] singular failed: $e');
  }

  // ---------------------------------------------------------------
  // Point transform sampling (wrapped in try/catch each).
  // ---------------------------------------------------------------
  String safeTransformPoint(Matrix4 m, double x, double y) {
    try {
      final Offset out = MatrixUtils.transformPoint(m, Offset(x, y));
      return '(${out.dx.toStringAsFixed(2)}, ${out.dy.toStringAsFixed(2)})';
    } catch (e) {
      return 'err';
    }
  }

  String safeTransformRect(Matrix4 m, double l, double t, double r, double b) {
    try {
      final Rect out = MatrixUtils.transformRect(
        m,
        Rect.fromLTRB(l, t, r, b),
      );
      return 'L${out.left.toStringAsFixed(1)} '
          'T${out.top.toStringAsFixed(1)} '
          'R${out.right.toStringAsFixed(1)} '
          'B${out.bottom.toStringAsFixed(1)}';
    } catch (e) {
      return 'err';
    }
  }

  String safeIsIdentity(Matrix4 m) {
    try {
      return MatrixUtils.isIdentity(m).toString();
    } catch (e) {
      return 'err';
    }
  }

  String safeGetAsTranslation(Matrix4 m) {
    try {
      final Offset? o = MatrixUtils.getAsTranslation(m);
      if (o == null) {
        return 'null';
      }
      return '(${o.dx.toStringAsFixed(1)}, ${o.dy.toStringAsFixed(1)})';
    } catch (e) {
      return 'err';
    }
  }

  // Sample point grid pre-computed once; accessed by index.
  final List<List<double>> samplePoints = <List<double>>[
    <double>[0.0, 0.0],
    <double>[10.0, 0.0],
    <double>[0.0, 10.0],
    <double>[10.0, 10.0],
    <double>[25.0, 25.0],
    <double>[100.0, 50.0],
  ];

  // ---------------------------------------------------------------
  // Shared text styles
  // ---------------------------------------------------------------
  const TextStyle hCosmic = TextStyle(
    color: inkPrimary,
    fontSize: 26.0,
    fontWeight: FontWeight.w800,
    letterSpacing: 0.6,
  );
  const TextStyle hSection = TextStyle(
    color: accentLavender,
    fontSize: 18.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.4,
  );
  const TextStyle hSub = TextStyle(
    color: accentSky,
    fontSize: 14.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
  );
  const TextStyle pBody = TextStyle(
    color: inkMuted,
    fontSize: 12.5,
    height: 1.55,
  );
  const TextStyle pBodyDim = TextStyle(
    color: inkDim,
    fontSize: 12.0,
    height: 1.5,
  );
  const TextStyle pCode = TextStyle(
    color: accentMint,
    fontSize: 12.0,
    fontFamily: 'monospace',
    height: 1.45,
  );
  const TextStyle pMono = TextStyle(
    color: inkPrimary,
    fontSize: 12.0,
    fontFamily: 'monospace',
    height: 1.4,
  );
  const TextStyle pMonoDim = TextStyle(
    color: inkDim,
    fontSize: 11.0,
    fontFamily: 'monospace',
    height: 1.4,
  );
  const TextStyle pCaption = TextStyle(
    color: inkDim,
    fontSize: 11.0,
    letterSpacing: 0.4,
  );
  const TextStyle pTag = TextStyle(
    color: paperVoid,
    fontSize: 10.0,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
  );

  // ---------------------------------------------------------------
  // Helpers (no setState, no controllers)
  // ---------------------------------------------------------------
  Widget tag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3.0),
      ),
      child: Text(label, style: pTag),
    );
  }

  Widget panel(String title, String subtitle, Color accent, Widget body) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: paperDeep,
        border: Border.all(color: borderDim, width: 1.0),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withValues(alpha: 0.10),
            blurRadius: 14.0,
            offset: const Offset(0.0, 5.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 6.0,
                height: 22.0,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(2.0),
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(child: Text(title, style: hSection)),
            ],
          ),
          const SizedBox(height: 6.0),
          Text(subtitle, style: pBodyDim),
          const SizedBox(height: 14.0),
          body,
        ],
      ),
    );
  }

  Widget kv(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 130.0,
            child: Text(key, style: pCaption),
          ),
          Expanded(
            child: Text(value, style: pMono),
          ),
        ],
      ),
    );
  }

  Widget bullet(String s) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 6.0, right: 8.0),
            child: Icon(
              Icons.circle,
              size: 5.0,
              color: accentLavender,
            ),
          ),
          Expanded(child: Text(s, style: pBody)),
        ],
      ),
    );
  }

  Widget codeLine(String s) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 3.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: paperVoid,
        border: Border.all(color: borderDim, width: 1.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(s, style: pCode),
    );
  }

  Widget swatch(String name, String hex, Color c, String role) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
      padding: const EdgeInsets.all(10.0),
      width: 168.0,
      decoration: BoxDecoration(
        color: paperMid,
        border: Border.all(color: borderDim, width: 1.0),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 36.0,
            decoration: BoxDecoration(
              color: c,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: borderBright, width: 1.0),
            ),
          ),
          const SizedBox(height: 6.0),
          Text(name, style: pMono),
          Text(hex, style: pMonoDim),
          const SizedBox(height: 2.0),
          Text(role, style: pCaption),
        ],
      ),
    );
  }

  // 4x4 grid renderer for matrix display.
  Widget matrixGrid(String label, Matrix4 m, Color accent) {
    final List<List<String>> cells = <List<String>>[
      <String>['1.00', '0.00', '0.00', '0.00'],
      <String>['0.00', '1.00', '0.00', '0.00'],
      <String>['0.00', '0.00', '1.00', '0.00'],
      <String>['0.00', '0.00', '0.00', '1.00'],
    ];
    try {
      // Matrix4 storage order is column-major. m.storage is a length-16
      // Float64List. m.entry(row, col) is row-major access.
      for (int row = 0; row < 4; row = row + 1) {
        for (int col = 0; col < 4; col = col + 1) {
          double v = 0.0;
          try {
            v = m.entry(row, col);
          } catch (e) {
            v = 0.0;
          }
          cells[row][col] = v.toStringAsFixed(2);
        }
      }
    } catch (e) {
      print('[matrix_test] matrixGrid($label) failed: $e');
    }
    return Container(
      margin: const EdgeInsets.only(right: 14.0, bottom: 14.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: paperVoid,
        border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
        borderRadius: BorderRadius.circular(6.0),
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
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
              const SizedBox(width: 6.0),
              Text(label, style: pCaption),
            ],
          ),
          const SizedBox(height: 6.0),
          Column(
            children: <Widget>[
              for (int r = 0; r < 4; r = r + 1)
                Row(
                  children: <Widget>[
                    for (int c = 0; c < 4; c = c + 1)
                      Container(
                        width: 56.0,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 4.0,
                          vertical: 4.0,
                        ),
                        margin: const EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          color: paperMid,
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        child: Text(
                          cells[r][c],
                          textAlign: TextAlign.right,
                          style: pMono,
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------
  // Section: hero card.
  // ---------------------------------------------------------------
  final Widget heroCard = Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 20.0),
    padding: const EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: <Color>[paperRise, paperMid, paperDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      border: Border.all(color: borderBright, width: 1.0),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            tag('CARTESIAN INDIGO', accentIndigo),
            const SizedBox(width: 8.0),
            tag('PAINTING', accentLavender),
            const SizedBox(width: 8.0),
            tag('Matrix4 / MatrixUtils', accentSky),
          ],
        ),
        const SizedBox(height: 14.0),
        const Text('4x4 Transformation Matrices', style: hCosmic),
        const SizedBox(height: 6.0),
        const Text(
          'A column-major affine and projective workhorse used by the '
          'Flutter painting and rendering layers. This document collects '
          'construction recipes, point-transform tables, scenario notes, '
          'and pitfalls for working with Matrix4 inside a sandboxed '
          'd4rt build() entry point.',
          style: pBody,
        ),
        const SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            Expanded(
              child: matrixGrid('identity', mIdentity, accentLavender),
            ),
            Expanded(
              child: matrixGrid('rotZ 45°', mRotZ45, accentIndigo),
            ),
          ],
        ),
        const SizedBox(height: 4.0),
        Row(
          children: <Widget>[
            Expanded(
              child: matrixGrid('translate', mTranslate, accentSky),
            ),
            Expanded(
              child: matrixGrid('scale 1.5', mScaleUniform, accentTeal),
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: <Widget>[
            tag('AFFINE', flagAffine),
            tag('PERSPECTIVE', flagPerspective),
            tag('IDENTITY', flagIdentity),
            tag('SINGULAR', flagSingular),
          ],
        ),
      ],
    ),
  );

  // ---------------------------------------------------------------
  // Section: palette swatches.
  // ---------------------------------------------------------------
  final Widget paletteWrap = Wrap(
    children: <Widget>[
      swatch('paperVoid', '#0C0E1A', paperVoid, 'page void'),
      swatch('paperDeep', '#131630', paperDeep, 'panel base'),
      swatch('paperMid', '#1C2046', paperMid, 'cell base'),
      swatch('paperRise', '#252A5C', paperRise, 'hero apex'),
      swatch('paperFog', '#E9EAF7', paperFog, 'inverse fog'),
      swatch('inkPrimary', '#EFF1FB', inkPrimary, 'primary ink'),
      swatch('inkMuted', '#AEB3D6', inkMuted, 'body ink'),
      swatch('inkDim', '#7A80AC', inkDim, 'dim caption'),
      swatch('accentIndigo', '#7B6CF6', accentIndigo, 'core indigo'),
      swatch('accentLavender', '#B39DFF', accentLavender, 'soft lavender'),
      swatch('accentSky', '#6FB1FC', accentSky, 'sky accent'),
      swatch('accentTeal', '#4FD1C5', accentTeal, 'teal accent'),
      swatch('accentMint', '#77E2B3', accentMint, 'code mint'),
      swatch('accentAmber', '#FFC36A', accentAmber, 'warn amber'),
      swatch('accentRose', '#FF7AA2', accentRose, 'rose alert'),
      swatch('accentMagenta', '#C56CF0', accentMagenta, 'magenta tag'),
      swatch('accentCarbon', '#2A2D3F', accentCarbon, 'carbon shade'),
      swatch('borderDim', '#2D335E', borderDim, 'dim border'),
      swatch('borderBright', '#3E458A', borderBright, 'bright border'),
      swatch('flagAffine', '#4FD1C5', flagAffine, 'affine tag'),
      swatch('flagPerspective', '#FFC36A', flagPerspective, 'perspective tag'),
      swatch('flagIdentity', '#B39DFF', flagIdentity, 'identity tag'),
      swatch('flagSingular', '#FF7AA2', flagSingular, 'singular tag'),
    ],
  );

  // ---------------------------------------------------------------
  // Section: API surface for MatrixUtils.
  // ---------------------------------------------------------------
  final List<List<String>> apiRows = <List<String>>[
    <String>[
      'transformPoint',
      'Matrix4 m, Offset p',
      'Offset',
      'Apply m to p in 2D, performing the perspective divide.',
    ],
    <String>[
      'transformRect',
      'Matrix4 m, Rect r',
      'Rect',
      'Transform corners of r and return their axis-aligned bounding box.',
    ],
    <String>[
      'isIdentity',
      'Matrix4 m',
      'bool',
      'Cheap check for the identity transform.',
    ],
    <String>[
      'getAsTranslation',
      'Matrix4 m',
      'Offset?',
      'Return Offset only when m is a pure 2D translation, else null.',
    ],
    <String>[
      'isAffine',
      'Matrix4 m',
      'bool',
      'True when the matrix has no perspective component.',
    ],
    <String>[
      'matrixEquals',
      'Matrix4 a, Matrix4 b',
      'bool',
      'Element-wise equality of two matrices (used by tests).',
    ],
    <String>[
      'inverseTransformRect',
      'Matrix4 m, Rect r',
      'Rect',
      'Like transformRect but applies the inverse of m.',
    ],
    <String>[
      'forceToPoint',
      'Offset offset',
      'Matrix4',
      'Encode a single point as a degenerate matrix used by hit tests.',
    ],
    <String>[
      'createCylindricalProjectionTransform',
      'radius, angle, perspective',
      'Matrix4',
      'Build a perspective matrix for cylindrical scrolling effects.',
    ],
    <String>[
      'getAsScale',
      'Matrix4 m',
      'double?',
      'Return the uniform scale or null when scaling is non-uniform.',
    ],
  ];

  Widget apiTable() {
    return Column(
      children: <Widget>[
        Container(
          color: paperRise,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Row(
            children: const <Widget>[
              SizedBox(
                width: 220.0,
                child: Text('member', style: hSub),
              ),
              SizedBox(
                width: 220.0,
                child: Text('signature', style: hSub),
              ),
              SizedBox(
                width: 90.0,
                child: Text('returns', style: hSub),
              ),
              Expanded(
                child: Text('purpose', style: hSub),
              ),
            ],
          ),
        ),
        for (int i = 0; i < apiRows.length; i = i + 1)
          Container(
            color: i % 2 == 0 ? paperDeep : paperMid,
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 8.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 220.0,
                  child: Text(apiRows[i][0], style: pMono),
                ),
                SizedBox(
                  width: 220.0,
                  child: Text(apiRows[i][1], style: pCode),
                ),
                SizedBox(
                  width: 90.0,
                  child: Text(apiRows[i][2], style: pMono),
                ),
                Expanded(
                  child: Text(apiRows[i][3], style: pBody),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // ---------------------------------------------------------------
  // Section: matrix construction gallery.
  // ---------------------------------------------------------------
  Widget galleryEntry(
    String name,
    String code,
    Matrix4 m,
    Color accent,
    String description,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: paperMid,
        border: Border.all(color: borderDim, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          matrixGrid(name, m, accent),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(name, style: hSub),
                const SizedBox(height: 4.0),
                codeLine(code),
                const SizedBox(height: 6.0),
                Text(description, style: pBody),
                const SizedBox(height: 6.0),
                Text(
                  'isIdentity = ${safeIsIdentity(m)}    '
                  'asTranslation = ${safeGetAsTranslation(m)}',
                  style: pCaption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final Widget gallery = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      galleryEntry(
        'identity',
        'Matrix4.identity()',
        mIdentity,
        accentLavender,
        'The neutral element of matrix multiplication. Diagonal of '
            '1.0, all other entries 0.0. Composing it with any matrix '
            'M leaves M unchanged.',
      ),
      galleryEntry(
        'translation (40, 24)',
        'Matrix4.translationValues(40.0, 24.0, 0.0)',
        mTranslate,
        accentSky,
        'Shifts every point by a fixed offset. The translation '
            'components live in the fourth column (column-major), '
            'storage indices 12 (tx), 13 (ty), 14 (tz).',
      ),
      galleryEntry(
        'translateZ (12)',
        'Matrix4.translationValues(0.0, 0.0, 12.0)',
        mTranslateZ,
        accentSky,
        'A translation along the depth axis. Without perspective '
            '(.setEntry(3,2,...)) this has no visible effect on the '
            'painted output of a Transform widget.',
      ),
      galleryEntry(
        'rotationZ 45°',
        'Matrix4.rotationZ(0.785398)',
        mRotZ45,
        accentIndigo,
        'Rotation around the Z axis by 45° (pi/4 radians). For '
            'Flutter painting, Z is the most common rotation axis '
            'because the screen lies in the XY plane.',
      ),
      galleryEntry(
        'rotationZ 30°',
        'Matrix4.rotationZ(0.523599)',
        mRotZ30,
        accentIndigo,
        'Smaller rotation; useful in widget galleries where 30° '
            'is the canonical "decorative tilt" for badges and '
            'highlight banners.',
      ),
      galleryEntry(
        'rotationZ 90°',
        'Matrix4.rotationZ(1.570796)',
        mRotZ90,
        accentIndigo,
        'Quarter turn around Z. The X axis maps to Y and vice '
            'versa. Use exactly pi/2 (1.5707963267948966) to avoid '
            'tiny floating-point drift on round-trip.',
      ),
      galleryEntry(
        'scale 1.5x',
        'Matrix4.diagonal3Values(1.5, 1.5, 1.0)',
        mScaleUniform,
        accentTeal,
        'Uniform 2D scale by 1.5. Diagonal entries control the '
            'scale per axis; the Z scale is left at 1.0 to keep the '
            'depth values unchanged.',
      ),
      galleryEntry(
        'scale (2.0, 0.5)',
        'Matrix4.diagonal3Values(2.0, 0.5, 1.0)',
        mScaleNonUniform,
        accentTeal,
        'Non-uniform scale. MatrixUtils.getAsScale(m) returns null '
            'because there is no single scalar describing the scale; '
            'tools must fall back to per-axis inspection.',
      ),
      galleryEntry(
        'scale (-1.0, 1.0)',
        'Matrix4.diagonal3Values(-1.0, 1.0, 1.0)',
        mScaleNegative,
        accentTeal,
        'Mirror along the X axis. The negative determinant flips '
            'orientation; rendering flows that depend on winding '
            'order (e.g., custom path painting) must accommodate '
            'this case explicitly.',
      ),
      galleryEntry(
        'skewX 0.3',
        'Matrix4.skewX(0.3)',
        mSkewX,
        accentMagenta,
        'Horizontal shear: each point is translated along X in '
            'proportion to its Y coordinate. Useful for italic-style '
            'transforms or skeuomorphic shadows.',
      ),
      galleryEntry(
        'skewY 0.2',
        'Matrix4.skewY(0.2)',
        mSkewY,
        accentMagenta,
        'Vertical shear: Y is shifted in proportion to X. The '
            'composition of skewX and skewY is no longer a pure '
            'shear in either axis; it is an affine transform with '
            'mixed coefficients.',
      ),
      galleryEntry(
        'perspective 0.001',
        'Matrix4.identity()..setEntry(3, 2, 0.001)',
        mPerspective,
        accentAmber,
        'A perspective transform with a tiny 1/depth coefficient. '
            'Without this row-3 entry, Z translation has no effect; '
            'with it, points farther into the screen shrink toward '
            'the centre.',
      ),
      galleryEntry(
        'composed: T·R·S',
        'Matrix4.identity()'
            '..translateByDouble(50,0,0,1)'
            '..rotateZ(0.4)'
            '..scaleByDouble(1.2,1.2,1,1)',
        mComposed,
        accentRose,
        'A typical chain: translate, then rotate, then scale. '
            'Recall that Matrix4 mutators apply on the right, so '
            'the visual order is "scale first, then rotate, then '
            'translate" when reading the chained code top-down.',
      ),
      galleryEntry(
        'singular (zero)',
        'Matrix4.diagonal3Values(0.0, 0.0, 0.0)',
        mSingular,
        flagSingular,
        'A degenerate matrix that collapses everything onto the '
            'origin. Its inverse does not exist; any code path that '
            'calls Matrix4.inverted on this matrix must guard with '
            'try/catch or check the determinant first.',
      ),
    ],
  );

  // ---------------------------------------------------------------
  // Section: point-transform table.
  // ---------------------------------------------------------------
  final List<List<dynamic>> ptMatrices = <List<dynamic>>[
    <dynamic>['identity', mIdentity, accentLavender],
    <dynamic>['translate', mTranslate, accentSky],
    <dynamic>['rotZ 45', mRotZ45, accentIndigo],
    <dynamic>['scale 1.5', mScaleUniform, accentTeal],
    <dynamic>['scale 2x.5', mScaleNonUniform, accentTeal],
    <dynamic>['skewX', mSkewX, accentMagenta],
    <dynamic>['perspective', mPerspective, accentAmber],
    <dynamic>['composed', mComposed, accentRose],
  ];

  Widget pointTransformTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          color: paperRise,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 110.0,
                child: Text('matrix', style: hSub),
              ),
              for (int i = 0; i < samplePoints.length; i = i + 1)
                SizedBox(
                  width: 130.0,
                  child: Text(
                    'in (${samplePoints[i][0].toStringAsFixed(0)}, '
                    '${samplePoints[i][1].toStringAsFixed(0)})',
                    style: hSub,
                  ),
                ),
            ],
          ),
        ),
        for (int row = 0; row < ptMatrices.length; row = row + 1)
          Container(
            color: row % 2 == 0 ? paperDeep : paperMid,
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 8.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 110.0,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 6.0,
                        height: 14.0,
                        decoration: BoxDecoration(
                          color: ptMatrices[row][2] as Color,
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                      ),
                      const SizedBox(width: 6.0),
                      Expanded(
                        child: Text(
                          ptMatrices[row][0] as String,
                          style: pMono,
                        ),
                      ),
                    ],
                  ),
                ),
                for (int p = 0; p < samplePoints.length; p = p + 1)
                  SizedBox(
                    width: 130.0,
                    child: Text(
                      safeTransformPoint(
                        ptMatrices[row][1] as Matrix4,
                        samplePoints[p][0],
                        samplePoints[p][1],
                      ),
                      style: pMono,
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  // ---------------------------------------------------------------
  // Section: rect-transform table.
  // ---------------------------------------------------------------
  final List<List<double>> sampleRects = <List<double>>[
    <double>[0.0, 0.0, 10.0, 10.0],
    <double>[0.0, 0.0, 100.0, 50.0],
    <double>[-25.0, -25.0, 25.0, 25.0],
    <double>[10.0, 20.0, 110.0, 70.0],
  ];

  Widget rectTransformTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          color: paperRise,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Row(
            children: <Widget>[
              const SizedBox(
                width: 110.0,
                child: Text('matrix', style: hSub),
              ),
              for (int i = 0; i < sampleRects.length; i = i + 1)
                SizedBox(
                  width: 220.0,
                  child: Text(
                    'L${sampleRects[i][0].toStringAsFixed(0)} '
                    'T${sampleRects[i][1].toStringAsFixed(0)} '
                    'R${sampleRects[i][2].toStringAsFixed(0)} '
                    'B${sampleRects[i][3].toStringAsFixed(0)}',
                    style: hSub,
                  ),
                ),
            ],
          ),
        ),
        for (int row = 0; row < ptMatrices.length; row = row + 1)
          Container(
            color: row % 2 == 0 ? paperDeep : paperMid,
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 8.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 110.0,
                  child: Text(
                    ptMatrices[row][0] as String,
                    style: pMono,
                  ),
                ),
                for (int p = 0; p < sampleRects.length; p = p + 1)
                  SizedBox(
                    width: 220.0,
                    child: Text(
                      safeTransformRect(
                        ptMatrices[row][1] as Matrix4,
                        sampleRects[p][0],
                        sampleRects[p][1],
                        sampleRects[p][2],
                        sampleRects[p][3],
                      ),
                      style: pMonoDim,
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }

  // ---------------------------------------------------------------
  // Section: isIdentity / isAffine / asTranslation summary.
  // ---------------------------------------------------------------
  Widget classificationTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          color: paperRise,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Row(
            children: const <Widget>[
              SizedBox(width: 140.0, child: Text('matrix', style: hSub)),
              SizedBox(width: 110.0, child: Text('isIdentity', style: hSub)),
              SizedBox(width: 160.0, child: Text('asTranslation', style: hSub)),
              Expanded(child: Text('notes', style: hSub)),
            ],
          ),
        ),
        for (int row = 0; row < ptMatrices.length; row = row + 1)
          Container(
            color: row % 2 == 0 ? paperDeep : paperMid,
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 8.0,
            ),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 140.0,
                  child: Text(ptMatrices[row][0] as String, style: pMono),
                ),
                SizedBox(
                  width: 110.0,
                  child: Text(
                    safeIsIdentity(ptMatrices[row][1] as Matrix4),
                    style: pMono,
                  ),
                ),
                SizedBox(
                  width: 160.0,
                  child: Text(
                    safeGetAsTranslation(ptMatrices[row][1] as Matrix4),
                    style: pMono,
                  ),
                ),
                Expanded(
                  child: Text(
                    'classification result for ${ptMatrices[row][0]}',
                    style: pBodyDim,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // ---------------------------------------------------------------
  // Section: column-major prose.
  // ---------------------------------------------------------------
  final Widget columnMajorProse = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text(
        'Matrix4 stores its sixteen entries in column-major order. '
        'That means storage[0..3] holds column 0, storage[4..7] holds '
        'column 1, and so on. The translation components live at '
        'storage[12], storage[13], storage[14] (tx, ty, tz). The '
        'perspective row sits at storage[3], storage[7], storage[11], '
        'storage[15].',
        style: pBody,
      ),
      const SizedBox(height: 8.0),
      const Text(
        'Why column-major? Most graphics literature and shader pipelines '
        '(including OpenGL and Skia) treat vectors as columns and apply '
        'the matrix on the left. With column-major storage, a sequential '
        'memory read produces the data in the same order GPUs expect.',
        style: pBody,
      ),
      const SizedBox(height: 12.0),
      codeLine(
        '// indices for storage (column-major):',
      ),
      codeLine('//   col0 col1 col2 col3'),
      codeLine('// 0:  m00  m01  m02  tx'),
      codeLine('// 1:  m10  m11  m12  ty'),
      codeLine('// 2:  m20  m21  m22  tz'),
      codeLine('// 3:  p0   p1   p2   w'),
      const SizedBox(height: 8.0),
      const Text(
        'm.entry(row, col) does the index translation for you and '
        'returns the cell at logical row, column. Use it whenever '
        'readability matters more than raw performance.',
        style: pBody,
      ),
      const SizedBox(height: 8.0),
      codeLine('m.entry(0, 0); // m00'),
      codeLine('m.entry(0, 3); // tx'),
      codeLine('m.entry(3, 2); // perspective coefficient'),
      codeLine('m.storage[12]; // tx (raw column-major)'),
    ],
  );

  // ---------------------------------------------------------------
  // Section: scenario panels.
  // ---------------------------------------------------------------
  Widget scenarioCard(String title, String tagText, Color accent, List<Widget> body) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14.0),
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: paperMid,
        border: Border.all(color: borderDim, width: 1.0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(child: Text(title, style: hSub)),
              tag(tagText, accent),
            ],
          ),
          const SizedBox(height: 8.0),
          ...body,
        ],
      ),
    );
  }

  final Widget scenarios = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      scenarioCard(
        'Transform widget',
        'WIDGET',
        accentIndigo,
        <Widget>[
          const Text(
            'Transform takes a Matrix4 and applies it as part of the '
            'paint phase. Use Transform.rotate, Transform.scale, '
            'Transform.translate for the common cases; reach for the '
            'raw constructor only when composing custom matrices.',
            style: pBody,
          ),
          const SizedBox(height: 8.0),
          codeLine('Transform('),
          codeLine('  transform: Matrix4.rotationZ(0.4),'),
          codeLine('  alignment: Alignment.center,'),
          codeLine('  child: const Text("tilted"),'),
          codeLine(')'),
          const SizedBox(height: 8.0),
          const Text(
            'The alignment argument shifts the origin of the transform '
            'to the centre of the child. Without it, the rotation '
            'pivots at the top-left of the child.',
            style: pBodyDim,
          ),
        ],
      ),
      scenarioCard(
        'RenderTransform',
        'RENDER',
        accentSky,
        <Widget>[
          const Text(
            'RenderTransform is the render-object backing for the '
            'Transform widget. It applies its matrix during paint and '
            'forwards hit-tests through the inverse of the matrix.',
            style: pBody,
          ),
          const SizedBox(height: 8.0),
          codeLine(
            '@override void paint(PaintingContext c, Offset off) {',
          ),
          codeLine('  c.pushTransform(true, off, _transform, super.paint);'),
          codeLine('}'),
          const SizedBox(height: 8.0),
          const Text(
            'pushTransform layers the matrix on the painting context. '
            'It also pushes a corresponding transform layer when needed '
            'so that compositing handles the matrix on the GPU.',
            style: pBodyDim,
          ),
        ],
      ),
      scenarioCard(
        'Canvas.transform',
        'CANVAS',
        accentTeal,
        <Widget>[
          const Text(
            'Inside a CustomPainter, Canvas.transform mutates the '
            'current transform. Pair it with canvas.save and '
            'canvas.restore so siblings paint correctly.',
            style: pBody,
          ),
          const SizedBox(height: 8.0),
          codeLine('canvas.save();'),
          codeLine('canvas.transform(matrix.storage);'),
          codeLine('canvas.drawCircle(Offset.zero, 8.0, paint);'),
          codeLine('canvas.restore();'),
          const SizedBox(height: 8.0),
          const Text(
            'canvas.transform expects a Float64List storage view; '
            'pass matrix.storage directly. Skia internally combines '
            'this with the existing transform stack.',
            style: pBodyDim,
          ),
        ],
      ),
      scenarioCard(
        'Hit testing through transforms',
        'HIT',
        accentMagenta,
        <Widget>[
          const Text(
            'Hit-testing must invert the transform. Flutter calls '
            'transformInverse on the matrix, applies it to the local '
            'point, and recurses into the child render object.',
            style: pBody,
          ),
          const SizedBox(height: 8.0),
          codeLine('final inverse = Matrix4.tryInvert(matrix);'),
          codeLine('if (inverse == null) return false;'),
          codeLine(
            'final localOffset = MatrixUtils.transformPoint(inverse, off);',
          ),
          const SizedBox(height: 8.0),
          const Text(
            'A singular matrix (det == 0) cannot be inverted; hit '
            'testing through such a matrix returns false. This is '
            'why scaling to 0 makes a widget unhittable.',
            style: pBodyDim,
          ),
        ],
      ),
      scenarioCard(
        'Layer.applyTransform',
        'LAYER',
        accentAmber,
        <Widget>[
          const Text(
            'TransformLayer.applyTransform composes its matrix with an '
            'incoming Matrix4 destined for the GPU. Override only when '
            'you build custom layers in a render object.',
            style: pBody,
          ),
          const SizedBox(height: 8.0),
          codeLine('@override'),
          codeLine('void applyTransform(Layer? child, Matrix4 transform) {'),
          codeLine('  transform.multiply(_transform!);'),
          codeLine('}'),
        ],
      ),
      scenarioCard(
        'Transformed bounds for repaint',
        'BOUNDS',
        accentRose,
        <Widget>[
          const Text(
            'When a render object subtree paints inside a transform, '
            'its parent must compute the axis-aligned bounding rect of '
            'the transformed children to decide which screen region '
            'needs to be invalidated.',
            style: pBody,
          ),
          const SizedBox(height: 8.0),
          codeLine(
            'final visible = MatrixUtils.transformRect(matrix, childBounds);',
          ),
          const SizedBox(height: 8.0),
          const Text(
            'transformRect transforms each of the four corners and '
            'returns the smallest axis-aligned rectangle that contains '
            'them. Note: this can be larger than the visual area for '
            'rotation and shear.',
            style: pBodyDim,
          ),
        ],
      ),
    ],
  );

  // ---------------------------------------------------------------
  // Section: transformPoint vs Matrix4.transform3 comparison.
  // ---------------------------------------------------------------
  final Widget transformPointVs = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text(
        'Both APIs apply a Matrix4 to a point, but they differ in '
        'shape, semantics, and the perspective divide.',
        style: pBody,
      ),
      const SizedBox(height: 12.0),
      Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: paperMid,
                border: Border.all(color: borderDim, width: 1.0),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      tag('UI / 2D', accentLavender),
                      const SizedBox(width: 6.0),
                      const Expanded(
                        child: Text(
                          'MatrixUtils.transformPoint',
                          style: hSub,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Input: Offset (dx, dy). Z is implicit 0. After '
                    'multiplication, performs the perspective divide '
                    'by w. Returns Offset.',
                    style: pBody,
                  ),
                  const SizedBox(height: 8.0),
                  codeLine('Offset p = MatrixUtils.transformPoint('),
                  codeLine('  matrix, Offset(10.0, 20.0));'),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Best for painting and hit testing where you only '
                    'work in 2D screen space.',
                    style: pBodyDim,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: paperMid,
                border: Border.all(color: borderDim, width: 1.0),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      tag('VECTOR / 3D', accentTeal),
                      const SizedBox(width: 6.0),
                      const Expanded(
                        child: Text(
                          'Matrix4.transform3',
                          style: hSub,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Input: Vector3. Mutates the vector in place. '
                    'Does NOT perform the perspective divide; w is '
                    'discarded. Suited for affine vector math.',
                    style: pBody,
                  ),
                  const SizedBox(height: 8.0),
                  codeLine('Vector3 v = Vector3(10.0, 20.0, 0.0);'),
                  codeLine('matrix.transform3(v); // in-place'),
                  const SizedBox(height: 8.0),
                  const Text(
                    'Use when you keep your data in vector_math and '
                    'do not need projective output.',
                    style: pBodyDim,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 12.0),
      const Text(
        'A useful rule of thumb: any time you transform a point in '
        'order to feed it to a Flutter painting or hit-testing API, '
        'use MatrixUtils.transformPoint. Reserve Matrix4.transform3 '
        'for raw geometry pipelines.',
        style: pBody,
      ),
    ],
  );

  // ---------------------------------------------------------------
  // Section: pitfalls.
  // ---------------------------------------------------------------
  final Widget pitfalls = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      bullet(
        'Forgetting the perspective entry. Matrix4.identity() has w-row '
        '[0, 0, 0, 1]. Translation along Z does nothing visually until '
        'you set entry (3, 2) to a small non-zero value, e.g. 0.001.',
      ),
      bullet(
        'Order of operations. m..translate(...)..rotate(...) chains '
        'mutators that postmultiply onto the existing matrix. Reading '
        'the chain top-to-bottom describes "what happens to the local '
        'frame", which is the reverse of "what happens to the points".',
      ),
      bullet(
        'Mutating shared matrices. Matrix4 is mutable; helpers such as '
        'translate, rotate, scale modify in place. If you keep a base '
        'matrix and then derive variants, clone first with '
        'Matrix4.copy(base) or Matrix4.tryInvert returns a new instance.',
      ),
      bullet(
        'Inverting singular matrices. Matrix4.inverted throws when the '
        'determinant is zero. Prefer Matrix4.tryInvert which returns '
        'null. In the d4rt sandbox, always wrap inversion in try/catch.',
      ),
      bullet(
        'Skew composition. Matrix4.skewX and Matrix4.skewY do not '
        'commute; their product depends on order. Generally compute '
        'a single matrix that captures the desired shear once, then '
        'reuse it.',
      ),
      bullet(
        'Hit testing inside Transform widgets. If the matrix is '
        'singular (determinant 0), the inverse cannot be computed and '
        'hits silently return false. Watch for scale 0 or '
        'collapsed perspective.',
      ),
      bullet(
        'Float64 precision for rotations. Composing many small '
        'rotations accumulates floating-point error. Periodically '
        'rebuild the matrix from a canonical angle to keep rotations '
        'stable.',
      ),
      bullet(
        'Coordinate handedness. Flutter uses a right-handed coordinate '
        'system with Y down on screen. Be careful when porting graphics '
        'algorithms that assume Y up.',
      ),
      bullet(
        'getAsTranslation gotchas. It returns null for any matrix that '
        'is not a pure 2D translation. Even a Z translation alone '
        'returns null; only the (tx, ty, 0) form qualifies.',
      ),
      bullet(
        'transformRect is only an outer bound. After rotation or shear, '
        'the bounding rect of the transformed quad is strictly larger '
        'than the visual footprint. Use it for dirty-rect calculations, '
        'not for exact hit testing.',
      ),
    ],
  );

  // ---------------------------------------------------------------
  // Section: ASCII coordinate-system diagrams.
  // ---------------------------------------------------------------
  final Widget asciiBox = Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: paperVoid,
      border: Border.all(color: borderDim, width: 1.0),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text('Flutter screen-space (Y down):', style: pCaption),
        const SizedBox(height: 6.0),
        const Text('   (0,0) +------+------> +X', style: pMono),
        const Text('         |      |', style: pMono),
        const Text('         |  W   |', style: pMono),
        const Text('         |      |', style: pMono),
        const Text('         +------+', style: pMono),
        const Text('         |', style: pMono),
        const Text('         v', style: pMono),
        const Text('        +Y', style: pMono),
        const SizedBox(height: 12.0),
        const Text('Effect of Matrix4.translationValues(40, 24, 0):', style: pCaption),
        const SizedBox(height: 6.0),
        const Text('   (0,0)+--------+', style: pMono),
        const Text('        |        |', style: pMono),
        const Text('        |   X    |  ----> shifts right 40, down 24', style: pMono),
        const Text('        |        |', style: pMono),
        const Text('        +--------+', style: pMono),
        const Text('              |', style: pMono),
        const Text('              v', style: pMono),
        const Text('         (40,24)+--------+', style: pMono),
        const Text('                |        |', style: pMono),
        const Text('                |   X\'   |', style: pMono),
        const Text('                +--------+', style: pMono),
        const SizedBox(height: 12.0),
        const Text('Effect of Matrix4.rotationZ(pi/4) about origin:', style: pCaption),
        const SizedBox(height: 6.0),
        const Text('  before:        after:', style: pMono),
        const Text('  +----+         /\\', style: pMono),
        const Text('  |    |        /  \\', style: pMono),
        const Text('  +----+       /    \\', style: pMono),
        const Text('               \\    /', style: pMono),
        const Text('                \\  /', style: pMono),
        const Text('                 \\/', style: pMono),
        const SizedBox(height: 12.0),
        const Text('Effect of perspective entry (3, 2) = 0.001:', style: pCaption),
        const SizedBox(height: 6.0),
        const Text('  near plane          far plane', style: pMono),
        const Text('  +-------+    -->    +---+', style: pMono),
        const Text('  |       |           |   |', style: pMono),
        const Text('  |       |           |   |', style: pMono),
        const Text('  +-------+    -->    +---+', style: pMono),
        const Text('   (z = 0)             (z = 100)', style: pMonoDim),
      ],
    ),
  );

  // ---------------------------------------------------------------
  // Section: decision flowchart (ASCII).
  // ---------------------------------------------------------------
  final Widget flowchart = Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: paperVoid,
      border: Border.all(color: borderDim, width: 1.0),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text('Pick a Matrix4 builder:', style: pCaption),
        SizedBox(height: 6.0),
        Text('   need only a translation?', style: pMono),
        Text('   |', style: pMono),
        Text('   +-- yes --> Matrix4.translationValues(tx, ty, tz)', style: pMono),
        Text('   |', style: pMono),
        Text('   +-- no  --> need only one rotation?', style: pMono),
        Text('               |', style: pMono),
        Text('               +-- yes --> Matrix4.rotationZ(theta)', style: pMono),
        Text('               |          (or rotationX, rotationY)', style: pMono),
        Text('               |', style: pMono),
        Text('               +-- no  --> need only a uniform scale?', style: pMono),
        Text('                           |', style: pMono),
        Text('                           +-- yes --> Matrix4.diagonal3Values', style: pMono),
        Text('                           |', style: pMono),
        Text('                           +-- no  --> compose with chained', style: pMono),
        Text('                                       mutators on identity', style: pMono),
        SizedBox(height: 12.0),
        Text('Pick a transform applier:', style: pCaption),
        SizedBox(height: 6.0),
        Text('   transforming a 2D Offset for paint or hit test?', style: pMono),
        Text('   |', style: pMono),
        Text('   +-- yes --> MatrixUtils.transformPoint', style: pMono),
        Text('   |', style: pMono),
        Text('   +-- no  --> transforming a Rect for repaint bounds?', style: pMono),
        Text('               |', style: pMono),
        Text('               +-- yes --> MatrixUtils.transformRect', style: pMono),
        Text('               |', style: pMono),
        Text('               +-- no  --> raw vector math?', style: pMono),
        Text('                           |', style: pMono),
        Text('                           +-- yes --> Matrix4.transform3', style: pMono),
      ],
    ),
  );

  // ---------------------------------------------------------------
  // Section: glossary.
  // ---------------------------------------------------------------
  final List<List<String>> glossary = <List<String>>[
    <String>[
      'affine',
      'A transform that preserves parallelism. Composed of '
          'translation, rotation, scale, and shear; never perspective.',
    ],
    <String>[
      'projective',
      'A transform that may include a perspective component, '
          'meaning the w-row is not [0, 0, 0, 1].',
    ],
    <String>[
      'column-major',
      'Storage order where consecutive memory cells form a '
          'column of the matrix. Matrix4 uses this layout.',
    ],
    <String>[
      'homogeneous coordinates',
      'A 4D representation (x, y, z, w) that lets affine and '
          'projective transforms be expressed as a single matrix '
          'multiplication.',
    ],
    <String>[
      'perspective divide',
      'Dividing (x, y, z) by w after multiplication. This is what '
          'turns a perspective matrix into apparent foreshortening.',
    ],
    <String>[
      'singular matrix',
      'A matrix whose determinant is zero. It has no inverse and '
          'collapses points onto a lower-dimensional subspace.',
    ],
    <String>[
      'orthonormal basis',
      'Three mutually perpendicular unit vectors. A pure rotation '
          'matrix has columns that form an orthonormal basis.',
    ],
    <String>[
      'shear',
      'A transform that slides one axis along another. skewX(a) '
          'maps (x, y) to (x + y*tan(a), y).',
    ],
    <String>[
      'transform layer',
      'A compositing layer that applies a Matrix4 on the GPU. '
          'Created by RenderTransform when the matrix is not '
          'trivially decomposable.',
    ],
    <String>[
      'pivot / origin',
      'The point that stays fixed under a rotation or scale. '
          'Transform widgets use the alignment property to set this.',
    ],
    <String>[
      'determinant',
      'A scalar derived from a square matrix. Determinant 0 means '
          'singular; negative means the orientation flips.',
    ],
    <String>[
      'cylindrical projection',
      'A custom matrix produced by '
          'MatrixUtils.createCylindricalProjectionTransform that '
          'simulates wrapping a flat strip around a cylinder.',
    ],
    <String>[
      'invert vs. tryInvert',
      'inverted() throws on singular matrices; tryInvert returns '
          'null. The latter is the preferred path in painting code.',
    ],
    <String>[
      'transform composition',
      'The order matters: M = T * R * S means scale first, then '
          'rotate, then translate the final point.',
    ],
  ];

  Widget glossaryTable() {
    return Column(
      children: <Widget>[
        Container(
          color: paperRise,
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          child: Row(
            children: const <Widget>[
              SizedBox(width: 200.0, child: Text('term', style: hSub)),
              Expanded(child: Text('definition', style: hSub)),
            ],
          ),
        ),
        for (int i = 0; i < glossary.length; i = i + 1)
          Container(
            color: i % 2 == 0 ? paperDeep : paperMid,
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 8.0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 200.0,
                  child: Text(glossary[i][0], style: pMono),
                ),
                Expanded(
                  child: Text(glossary[i][1], style: pBody),
                ),
              ],
            ),
          ),
      ],
    );
  }

  // ---------------------------------------------------------------
  // Section: live transform demos using inert AlwaysStoppedAnimation.
  // ---------------------------------------------------------------
  Widget transformBox(String label, Matrix4 m, Color accent) {
    Widget child = Container(
      width: 96.0,
      height: 56.0,
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.18),
        border: Border.all(color: accent, width: 1.0),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Center(
        child: Text(label, style: pMono),
      ),
    );
    Widget transformed = child;
    try {
      transformed = Transform(
        transform: m,
        alignment: Alignment.center,
        child: child,
      );
    } catch (e) {
      transformed = Container(
        width: 96.0,
        height: 56.0,
        decoration: BoxDecoration(
          color: flagSingular.withValues(alpha: 0.18),
          border: Border.all(color: flagSingular, width: 1.0),
        ),
        child: const Center(
          child: Text('err', style: pMono),
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.only(right: 14.0, bottom: 14.0),
      padding: const EdgeInsets.all(10.0),
      width: 160.0,
      decoration: BoxDecoration(
        color: paperMid,
        border: Border.all(color: borderDim, width: 1.0),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: pCaption),
          const SizedBox(height: 8.0),
          SizedBox(
            height: 80.0,
            child: Center(child: transformed),
          ),
          const SizedBox(height: 4.0),
          Opacity(
            opacity: const AlwaysStoppedAnimation<double>(1.0).value,
            child: Text('inert preview', style: pCaption),
          ),
        ],
      ),
    );
  }

  final Widget liveDemos = Wrap(
    children: <Widget>[
      transformBox('identity', mIdentity, accentLavender),
      transformBox('rotZ 30', mRotZ30, accentIndigo),
      transformBox('rotZ 45', mRotZ45, accentIndigo),
      transformBox('rotZ 90', mRotZ90, accentIndigo),
      transformBox('translate', mTranslate, accentSky),
      transformBox('scale 1.5', mScaleUniform, accentTeal),
      transformBox('scale 2x.5', mScaleNonUniform, accentTeal),
      transformBox('scale -1', mScaleNegative, accentTeal),
      transformBox('skewX', mSkewX, accentMagenta),
      transformBox('skewY', mSkewY, accentMagenta),
      transformBox('perspective', mPerspective, accentAmber),
      transformBox('composed', mComposed, accentRose),
    ],
  );

  // ---------------------------------------------------------------
  // Section: classification flag legend.
  // ---------------------------------------------------------------
  Widget legendChip(String name, Color color, String text) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0, bottom: 10.0),
      padding: const EdgeInsets.all(10.0),
      width: 220.0,
      decoration: BoxDecoration(
        color: paperMid,
        border: Border.all(color: borderDim, width: 1.0),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          tag(name, color),
          const SizedBox(height: 6.0),
          Text(text, style: pBody),
        ],
      ),
    );
  }

  final Widget legend = Wrap(
    children: <Widget>[
      legendChip(
        'AFFINE',
        flagAffine,
        'Last row is [0, 0, 0, 1]. Preserves parallelism. The vast '
            'majority of UI transforms fall here.',
      ),
      legendChip(
        'PERSPECTIVE',
        flagPerspective,
        'Last row has a non-zero z entry. Lines that were parallel '
            'may converge after transformation.',
      ),
      legendChip(
        'IDENTITY',
        flagIdentity,
        'The neutral matrix. MatrixUtils.isIdentity returns true. '
            'A common fast-path skip in render code.',
      ),
      legendChip(
        'SINGULAR',
        flagSingular,
        'Determinant is zero. No inverse exists. Hit testing '
            'returns false; the widget appears but is unhittable.',
      ),
    ],
  );

  // ---------------------------------------------------------------
  // Section: storage layout reference card.
  // ---------------------------------------------------------------
  final Widget storageLayout = Container(
    padding: const EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: paperVoid,
      border: Border.all(color: borderDim, width: 1.0),
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const <Widget>[
        Text(
          'Float64List storage[16] (column-major):',
          style: pCaption,
        ),
        SizedBox(height: 8.0),
        Text('  index  | role           | logical', style: pMono),
        Text('  -------+----------------+--------', style: pMono),
        Text('     0   | m00 (sx)       | row 0 col 0', style: pMono),
        Text('     1   | m10            | row 1 col 0', style: pMono),
        Text('     2   | m20            | row 2 col 0', style: pMono),
        Text('     3   | p0             | row 3 col 0', style: pMono),
        Text('     4   | m01            | row 0 col 1', style: pMono),
        Text('     5   | m11 (sy)       | row 1 col 1', style: pMono),
        Text('     6   | m21            | row 2 col 1', style: pMono),
        Text('     7   | p1             | row 3 col 1', style: pMono),
        Text('     8   | m02            | row 0 col 2', style: pMono),
        Text('     9   | m12            | row 1 col 2', style: pMono),
        Text('    10   | m22 (sz)       | row 2 col 2', style: pMono),
        Text('    11   | p2 (persp z)   | row 3 col 2', style: pMono),
        Text('    12   | tx             | row 0 col 3', style: pMono),
        Text('    13   | ty             | row 1 col 3', style: pMono),
        Text('    14   | tz             | row 2 col 3', style: pMono),
        Text('    15   | w (1.0)        | row 3 col 3', style: pMono),
      ],
    ),
  );

  // ---------------------------------------------------------------
  // Section: composition study.
  // ---------------------------------------------------------------
  final Widget compositionStudy = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text(
        'Composition is non-commutative for everything except pure '
        'translations along independent axes. Two examples:',
        style: pBody,
      ),
      const SizedBox(height: 12.0),
      Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('A) translate then rotate', style: hSub),
                const SizedBox(height: 6.0),
                codeLine('m = Matrix4.identity()'),
                codeLine('  ..translateByDouble(40, 0, 0, 1)'),
                codeLine('  ..rotateZ(0.5);'),
                const SizedBox(height: 6.0),
                const Text(
                  'Visual: the local frame is moved 40 units to the '
                  'right, then the rotation pivots around that new '
                  'position. The child still rotates around (0,0) '
                  'in its own coordinate system.',
                  style: pBody,
                ),
              ],
            ),
          ),
          const SizedBox(width: 18.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('B) rotate then translate', style: hSub),
                const SizedBox(height: 6.0),
                codeLine('m = Matrix4.identity()'),
                codeLine('  ..rotateZ(0.5)'),
                codeLine('  ..translateByDouble(40, 0, 0, 1);'),
                const SizedBox(height: 6.0),
                const Text(
                  'Visual: the local frame is rotated first, then '
                  'translated along its rotated X axis. The end '
                  'position differs from case A; the "40 units" '
                  'now points in a different direction.',
                  style: pBody,
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(height: 12.0),
      const Text(
        'In matrix terms, A and B compute different products: A is '
        'T*R while B is R*T. Only when both are translations (T1*T2 '
        '= T2*T1) or both are rotations about the same axis '
        '(R1*R2 = R2*R1) do they commute.',
        style: pBodyDim,
      ),
    ],
  );

  // ---------------------------------------------------------------
  // Section: numeric drift demonstration.
  // ---------------------------------------------------------------
  final Widget numericDrift = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      const Text(
        'A small composition study showing how repeated multiplication '
        'introduces drift on the diagonal of an "almost identity" '
        'matrix. Each row is a manually-built example; values are '
        'static so the demo stays deterministic.',
        style: pBody,
      ),
      const SizedBox(height: 12.0),
      Container(
        color: paperRise,
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
        child: Row(
          children: const <Widget>[
            SizedBox(width: 100.0, child: Text('iteration', style: hSub)),
            SizedBox(width: 130.0, child: Text('cos(N*0.001)', style: hSub)),
            SizedBox(width: 130.0, child: Text('sin(N*0.001)', style: hSub)),
            Expanded(child: Text('observation', style: hSub)),
          ],
        ),
      ),
      for (int i = 0; i < 8; i = i + 1)
        Container(
          color: i % 2 == 0 ? paperDeep : paperMid,
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 8.0,
          ),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 100.0,
                child: Text(
                  'N = ${(i * 100).toString()}',
                  style: pMono,
                ),
              ),
              SizedBox(
                width: 130.0,
                child: Text(
                  '~ ${(1.0 - 0.5 * (i * 0.001) * (i * 0.001)).toStringAsFixed(6)}',
                  style: pMono,
                ),
              ),
              SizedBox(
                width: 130.0,
                child: Text(
                  '~ ${(i * 0.001).toStringAsFixed(6)}',
                  style: pMono,
                ),
              ),
              Expanded(
                child: Text(
                  'cos still close to 1.0; sin grows linearly for '
                  'small angles.',
                  style: pBodyDim,
                ),
              ),
            ],
          ),
        ),
    ],
  );

  // ---------------------------------------------------------------
  // Section: quick recipes.
  // ---------------------------------------------------------------
  final Widget recipes = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      bullet(
        'Mirror horizontally: Matrix4.diagonal3Values(-1.0, 1.0, 1.0). '
        'Pair with alignment Alignment.center to flip around the centre.',
      ),
      bullet(
        'Rotate around a custom pivot: surround the rotate with two '
        'translations: T(p) * R * T(-p). The Transform widget does this '
        'for you when you pass alignment + origin.',
      ),
      bullet(
        'Build an isometric look: combine a Y rotation, an X rotation, '
        'and a uniform scale. atan(1/sqrt(2)) for one of the angles is '
        'a classic choice.',
      ),
      bullet(
        'Fade with depth: pair a perspective matrix with an Opacity '
        'widget driven by AlwaysStoppedAnimation<double>(t) — never '
        'an AnimationController in this sandbox.',
      ),
      bullet(
        'Linearly interpolate two Matrix4 values: Matrix4Tween.lerp '
        'or, for hand-rolled mixing, decompose into translation, '
        'rotation, and scale before interpolating each component.',
      ),
      bullet(
        'Read the current device pixel ratio matrix: '
        'View.of(context).devicePixelRatio gives the scalar; the '
        'PaintingContext applies it implicitly.',
      ),
    ],
  );

  // ---------------------------------------------------------------
  // Section: integrity checks.
  // ---------------------------------------------------------------
  final Widget integrity = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      kv('identity isIdentity', safeIsIdentity(mIdentity)),
      kv('translate isIdentity', safeIsIdentity(mTranslate)),
      kv('translate getAsTranslation', safeGetAsTranslation(mTranslate)),
      kv('rotZ45 isIdentity', safeIsIdentity(mRotZ45)),
      kv('scale 1.5 isIdentity', safeIsIdentity(mScaleUniform)),
      kv('singular isIdentity', safeIsIdentity(mSingular)),
      kv(
        'transformPoint(identity, (10, 20))',
        safeTransformPoint(mIdentity, 10.0, 20.0),
      ),
      kv(
        'transformPoint(translate, (0, 0))',
        safeTransformPoint(mTranslate, 0.0, 0.0),
      ),
      kv(
        'transformPoint(rotZ45, (10, 0))',
        safeTransformPoint(mRotZ45, 10.0, 0.0),
      ),
      kv(
        'transformPoint(scale 1.5, (10, 10))',
        safeTransformPoint(mScaleUniform, 10.0, 10.0),
      ),
      kv(
        'transformRect(rotZ45, 0,0,10,10)',
        safeTransformRect(mRotZ45, 0.0, 0.0, 10.0, 10.0),
      ),
      kv(
        'transformRect(scale 1.5, 0,0,100,50)',
        safeTransformRect(mScaleUniform, 0.0, 0.0, 100.0, 50.0),
      ),
    ],
  );

  // ---------------------------------------------------------------
  // Final assembly: Scaffold returned from build().
  // ---------------------------------------------------------------
  return Scaffold(
    backgroundColor: paperVoid,
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(22.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          heroCard,
          panel(
            'Palette: Cartesian Indigo',
            'A deep indigo / lavender / carbon palette for mathematical '
                'reference visuals. Each swatch is paired with the '
                'role it plays in the matrix gallery.',
            accentIndigo,
            paletteWrap,
          ),
          panel(
            'API Surface: MatrixUtils',
            'Helpers in painting/matrix_utils.dart that apply Matrix4 '
                'values to Flutter painting primitives.',
            accentLavender,
            apiTable(),
          ),
          panel(
            'Construction Gallery',
            'Each entry shows the constructor / chained mutator '
                'expression, the resulting 4x4 grid, and a short note '
                'about its painting role.',
            accentSky,
            gallery,
          ),
          panel(
            'Live transform previews',
            'Inert AlwaysStoppedAnimation<double>(t) views of each '
                'matrix applied to a 96x56 box. No controllers, no '
                'setState; this is a static snapshot.',
            accentTeal,
            liveDemos,
          ),
          panel(
            'Point Transform Table',
            'MatrixUtils.transformPoint applied to a sample point '
                'grid for each construction in the gallery. Wrapped '
                'in try/catch so degenerate matrices show as "err".',
            accentMagenta,
            // 20260524-2003 baseline §6/H-important todo #13
            // (matrix_test): pointTransformTable produces 9 rows of
            // (110 + 6×130) = 890 + 20 padding ≈ 910 px wide which
            // overflows the flutter_ast widget pane (~700 px) by
            // ~210 px on every row. Wrap in a horizontal
            // SingleChildScrollView so the table can scroll right
            // without firing the RenderFlex overflow assertion.
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: pointTransformTable(),
            ),
          ),
          panel(
            'Rect Transform Table',
            'MatrixUtils.transformRect on sample rects. Note that the '
                'output is the axis-aligned bounding box of the four '
                'transformed corners, not the rotated quad itself.',
            accentRose,
            // Same fix as the point table above: rectTransformTable
            // is 110 + 4×220 = 990 + 20 padding ≈ 1010 px wide,
            // overflowing the ~700-px pane by ~310 px on every row.
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: rectTransformTable(),
            ),
          ),
          panel(
            'Classification: isIdentity / asTranslation',
            'MatrixUtils.isIdentity is a fast skip-flag for paint '
                'paths. getAsTranslation is the inverse: it succeeds '
                'only for matrices that are exactly a 2D translation.',
            accentIndigo,
            classificationTable(),
          ),
          panel(
            'Column-major storage',
            'Why and how Matrix4 uses column-major order, with index '
                'tables and accessor patterns.',
            accentLavender,
            columnMajorProse,
          ),
          panel(
            'Storage layout card',
            'A printable lookup table mapping every Float64List index '
                'to its logical role in the 4x4 matrix.',
            accentSky,
            storageLayout,
          ),
          panel(
            'Scenario panels',
            'Where Matrix4 actually shows up in the Flutter '
                'painting and rendering layers, with code-shaped '
                'snippets you can lift into your own widgets.',
            accentTeal,
            scenarios,
          ),
          panel(
            'transformPoint vs Matrix4.transform3',
            'Two superficially similar APIs with different shapes '
                'and different semantics. Pick deliberately.',
            accentMint,
            transformPointVs,
          ),
          panel(
            'Composition study',
            'Order matters. A demonstration that A*B != B*A in '
                'general, with concrete code samples.',
            accentAmber,
            compositionStudy,
          ),
          panel(
            'Numeric drift',
            'How small angles approximate cosine close to 1 and '
                'sine close to the angle. A reminder to refresh '
                'matrices periodically rather than chain mutators '
                'forever.',
            accentRose,
            numericDrift,
          ),
          panel(
            'Pitfalls',
            'Common mistakes when working with Matrix4 in painting '
                'and rendering code. Read once; refer to often.',
            accentMagenta,
            pitfalls,
          ),
          panel(
            'Recipes',
            'A short cookbook of common transforms expressed as '
                'one-liners or two-liners.',
            accentLavender,
            recipes,
          ),
          panel(
            'ASCII coordinate diagrams',
            'Quick mental anchors. Y points down on screen; '
                'translation shifts; rotation pivots; perspective '
                'shrinks far points.',
            accentTeal,
            asciiBox,
          ),
          panel(
            'Decision flowchart',
            'A short tree to help you pick a Matrix4 builder and a '
                'transform applier without re-reading the docs every '
                'time.',
            accentSky,
            flowchart,
          ),
          panel(
            'Glossary',
            'Definitions for the vocabulary used throughout this '
                'document and in the Flutter painting source.',
            accentIndigo,
            glossaryTable(),
          ),
          panel(
            'Classification legend',
            'The four flags this document uses to mark matrices: '
                'AFFINE, PERSPECTIVE, IDENTITY, SINGULAR.',
            accentMint,
            legend,
          ),
          panel(
            'Integrity checks',
            'A live readback of MatrixUtils calls against the '
                'matrices declared at the top of build(). All values '
                'are computed inside try/catch; any failure surfaces '
                'as the literal text "err".',
            accentAmber,
            integrity,
          ),
          panel(
            'Closing note',
            'Matrix4 is the smallest unit of geometric change that '
                'Flutter painting reasons about. Master a half-dozen '
                'idioms (identity, translate, rotateZ, scale, skew, '
                'perspective, tryInvert, transformPoint) and the '
                'rest is composition.',
            accentLavender,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                bullet('Prefer MatrixUtils.transformPoint in painting code.'),
                bullet('Prefer Matrix4.tryInvert over inverted().'),
                bullet('Wrap every Matrix4 op in try/catch under d4rt.'),
                bullet('Use AlwaysStoppedAnimation<double>(t) for inert demos.'),
                bullet('Never reach for a controller in this sandbox.'),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Center(
            child: Text(
              'Cartesian Indigo / Matrix4 reference / hand-authored',
              style: pCaption,
            ),
          ),
          const SizedBox(height: 28.0),
        ],
      ),
    ),
  );
}
