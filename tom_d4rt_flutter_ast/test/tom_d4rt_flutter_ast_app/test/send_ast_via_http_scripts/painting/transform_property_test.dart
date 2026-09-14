// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: TransformProperty (foundation diagnostics) deep visual demo
// Renders DiagnosticsProperty<Matrix4> alongside the Transform widgets that
// embody each Matrix4. Each section pairs the property with the matrix data,
// the rendered transformation, and an anatomy diagram of the 4x4 matrix.
import 'package:flutter/material.dart';
import 'dart:math' as math;

// ============================================================
// Constant value holders (no-op classes are forbidden; use _Palette
// const collection so we keep one cohesive style across sections).
// ============================================================
class _Palette {
  static const Color identityColor = Color(0xFF607D8B);
  static const Color translateColor = Color(0xFF1E88E5);
  static const Color rotateColor = Color(0xFFE53935);
  static const Color scaleColor = Color(0xFF43A047);
  static const Color skewColor = Color(0xFF8E24AA);
  static const Color perspectiveColor = Color(0xFFFB8C00);
  static const Color composedColor = Color(0xFF00897B);
  static const Color anatomyColor = Color(0xFF3949AB);
  static const Color codeBg = Color(0xFF263238);
  static const Color codeFg = Color(0xFFECEFF1);
}

dynamic build(BuildContext context) {
  print('TransformProperty Deep Demo executing');

  // ============================================================
  // SECTION 1: TransformProperty Anatomy
  // ============================================================
  print('=== Section 1: TransformProperty anatomy ===');
  final anatomyMatrix = Matrix4.identity();
  final anatomyProp = TransformProperty('transform', anatomyMatrix);
  print('property.name        = ${anatomyProp.name}');
  print('property.runtimeType = ${anatomyProp.runtimeType}');
  print('property.value       = ${anatomyProp.value}');
  print('property.showName    = ${anatomyProp.showName}');
  print('property.level       = ${anatomyProp.level}');
  print('property.isFiltered  = ${anatomyProp.isFiltered(DiagnosticLevel.info)}');

  final anatomyHeader = _buildSectionHeader(
    icon: Icons.account_tree_outlined,
    title: '1. TransformProperty anatomy',
    subtitle:
        'A DiagnosticsProperty<Matrix4> that knows how to print a 4x4 matrix',
    color: _Palette.anatomyColor,
  );

  final anatomyDiagram = Container(
    margin: EdgeInsets.only(top: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: _Palette.anatomyColor.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(
        color: _Palette.anatomyColor.withValues(alpha: 0.4),
        width: 1.5,
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TransformProperty(name, value, {ifNull, showName, level})',
          style: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            color: _Palette.anatomyColor,
            fontSize: 13.0,
          ),
        ),
        SizedBox(height: 12.0),
        _buildAnatomyRow(
          'name',
          'String — diagnostic key, printed before the value',
          Icons.label_outline,
        ),
        _buildAnatomyRow(
          'value',
          'Matrix4? — the transform; multi-line pretty printed',
          Icons.grid_4x4,
        ),
        _buildAnatomyRow(
          'ifNull',
          'String? — replacement text when value is null',
          Icons.do_disturb_alt_outlined,
        ),
        _buildAnatomyRow(
          'showName',
          'bool — whether to prefix the printed value with name',
          Icons.visibility_outlined,
        ),
        _buildAnatomyRow(
          'level',
          'DiagnosticLevel — fine, info, hidden, warning, error',
          Icons.tune,
        ),
        SizedBox(height: 12.0),
        Text(
          'TransformProperty extends DiagnosticsProperty<Matrix4>.',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 12.0,
            color: Colors.grey.shade700,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Identity matrix
  // ============================================================
  print('=== Section 2: Identity matrix ===');
  final identityMatrix = Matrix4.identity();
  final identityProp = TransformProperty('identity', identityMatrix);
  print('identityProp.toDescription() = ${identityProp.toDescription()}');

  final identitySection = _buildMatrixSection(
    headerIcon: Icons.crop_din,
    sectionTitle: '2. Identity matrix',
    sectionSubtitle: 'No transformation. The starting point of every chain.',
    color: _Palette.identityColor,
    matrix: identityMatrix,
    property: identityProp,
    code: "Matrix4.identity()\nTransformProperty('identity', m)",
    description:
        'identity() yields a 4x4 with 1.0 on the diagonal and 0.0 elsewhere. '
        'Multiplying any vector by this matrix returns the vector unchanged.',
  );

  // ============================================================
  // SECTION 3: Translation
  // ============================================================
  print('=== Section 3: Translation ===');
  final translationMatrix = Matrix4.translationValues(50.0, 30.0, 0.0);
  final translationProp = TransformProperty(
    'translation',
    translationMatrix,
  );
  print('translationProp.toDescription() = '
      '${translationProp.toDescription()}');

  final translationSection = _buildMatrixSection(
    headerIcon: Icons.open_with,
    sectionTitle: '3. Translation matrix',
    sectionSubtitle:
        'Shifts geometry by (tx, ty, tz). Stored in column 3 (entries [0..2][3]).',
    color: _Palette.translateColor,
    matrix: translationMatrix,
    property: translationProp,
    code: 'Matrix4.translationValues(50, 30, 0)',
    description:
        'A translation lives in the rightmost column of the 4x4. Look for '
        '[3] entries: m14=tx, m24=ty, m34=tz. The Transform widget shifts '
        'its child by those amounts in logical pixels.',
  );

  // ============================================================
  // SECTION 4: Rotation (Z)
  // ============================================================
  print('=== Section 4: Rotation Z ===');
  final rotationZMatrix = Matrix4.rotationZ(0.3);
  final rotationZProp = TransformProperty(
    'rotation_z',
    rotationZMatrix,
    level: DiagnosticLevel.fine,
  );
  print('rotationZProp.level = ${rotationZProp.level}');

  final rotationZSection = _buildMatrixSection(
    headerIcon: Icons.rotate_right,
    sectionTitle: '4. Rotation around Z (~17.2 deg)',
    sectionSubtitle:
        'Z is the screen-perpendicular axis — clockwise/CCW in 2D space.',
    color: _Palette.rotateColor,
    matrix: rotationZMatrix,
    property: rotationZProp,
    code: 'Matrix4.rotationZ(0.3) // radians',
    description:
        'Rotation around Z fills entries m11=cos, m12=-sin, m21=sin, '
        'm22=cos. Pass radians, not degrees — 0.3 rad = ~17.2 deg.',
  );

  // ============================================================
  // SECTION 5: Rotation (X) and Rotation (Y)
  // ============================================================
  print('=== Section 5: Rotation X and Y ===');
  final rotationXMatrix = Matrix4.rotationX(0.2);
  final rotationXProp = TransformProperty('rotation_x', rotationXMatrix);
  final rotationYMatrix = Matrix4.rotationY(0.4);
  final rotationYProp = TransformProperty('rotation_y', rotationYMatrix);
  print('rotationX.toDescription() = ${rotationXProp.toDescription()}');
  print('rotationY.toDescription() = ${rotationYProp.toDescription()}');

  final rotationXYSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _buildSectionHeader(
        icon: Icons.rotate_90_degrees_ccw,
        title: '5. Rotation around X and Y',
        subtitle:
            'X tilts top/bottom, Y tilts left/right. Looks like 3D without perspective.',
        color: _Palette.rotateColor,
      ),
      SizedBox(height: 12.0),
      Row(
        children: [
          Expanded(
            child: _buildSubMatrixCard(
              title: 'rotationX(0.2)',
              matrix: rotationXMatrix,
              property: rotationXProp,
              color: _Palette.rotateColor,
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: _buildSubMatrixCard(
              title: 'rotationY(0.4)',
              matrix: rotationYMatrix,
              property: rotationYProp,
              color: _Palette.rotateColor,
            ),
          ),
        ],
      ),
    ],
  );

  // ============================================================
  // SECTION 6: Scale
  // ============================================================
  print('=== Section 6: Scale ===');
  final scaleMatrix = Matrix4.diagonal3Values(1.5, 1.5, 1.0);
  final scaleProp = TransformProperty('scale', scaleMatrix);
  print('scaleProp.toDescription() = ${scaleProp.toDescription()}');

  final scaleSection = _buildMatrixSection(
    headerIcon: Icons.zoom_out_map,
    sectionTitle: '6. Scale matrix',
    sectionSubtitle:
        'Scaling lives on the main diagonal — sx, sy, sz, then 1 for w.',
    color: _Palette.scaleColor,
    matrix: scaleMatrix,
    property: scaleProp,
    code: 'Matrix4.diagonal3Values(1.5, 1.5, 1.0)',
    description:
        'A uniform x/y scale of 1.5 enlarges the child while keeping z '
        'unchanged. For non-uniform scaling pass differing values; for '
        'mirroring pass negatives (e.g. -1.0 flips horizontally).',
  );

  // ============================================================
  // SECTION 7: Skew + Perspective
  // ============================================================
  print('=== Section 7: Skew + Perspective ===');
  final perspectiveMatrix = Matrix4.identity();
  perspectiveMatrix.setEntry(3, 2, 0.001);
  perspectiveMatrix.rotateY(0.45);
  final perspectiveProp = TransformProperty(
    'perspective_y',
    perspectiveMatrix,
  );
  print('perspectiveProp.toDescription() = '
      '${perspectiveProp.toDescription()}');

  final skewMatrix = Matrix4.identity();
  skewMatrix.setEntry(0, 1, 0.4);
  final skewProp = TransformProperty('skew_x_by_y', skewMatrix);
  print('skewProp.toDescription() = ${skewProp.toDescription()}');

  final perspectiveSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _buildSectionHeader(
        icon: Icons.threed_rotation,
        title: '7. Perspective and skew',
        subtitle:
            'setEntry(3, 2, value) adds depth foreshortening. Skew lives off-diagonal.',
        color: _Palette.perspectiveColor,
      ),
      SizedBox(height: 12.0),
      Row(
        children: [
          Expanded(
            child: _buildSubMatrixCard(
              title: 'perspective + rotateY',
              matrix: perspectiveMatrix,
              property: perspectiveProp,
              color: _Palette.perspectiveColor,
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: _buildSubMatrixCard(
              title: 'skew x by y (0.4)',
              matrix: skewMatrix,
              property: skewProp,
              color: _Palette.skewColor,
            ),
          ),
        ],
      ),
      SizedBox(height: 12.0),
      Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: _Palette.perspectiveColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          'Footgun: a positive entry [3][2] causes the back of the geometry '
          'to recede; a negative one makes it grow. Typical values are tiny '
          '(0.001–0.003) — anything larger looks like a fish-eye lens.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade800),
        ),
      ),
    ],
  );

  // ============================================================
  // SECTION 8: Composed transforms — order matters
  // ============================================================
  print('=== Section 8: Composed transforms ===');
  final translateThenRotate = Matrix4.identity()
    ..translate(60.0, 0.0)
    ..rotateZ(0.4);
  final rotateThenTranslate = Matrix4.identity()
    ..rotateZ(0.4)
    ..translate(60.0, 0.0);
  final fullCombo = Matrix4.identity()
    ..translate(20.0, 0.0)
    ..rotateZ(0.2)
    ..scale(1.2);

  final translateThenRotateProp = TransformProperty(
    'translate_then_rotate',
    translateThenRotate,
  );
  final rotateThenTranslateProp = TransformProperty(
    'rotate_then_translate',
    rotateThenTranslate,
  );
  final fullComboProp = TransformProperty('full_combo', fullCombo);

  print('order matters → comparing translate-then-rotate vs '
      'rotate-then-translate');
  print('A: ${translateThenRotateProp.toDescription()}');
  print('B: ${rotateThenTranslateProp.toDescription()}');
  print('combo: ${fullComboProp.toDescription()}');

  final composedSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _buildSectionHeader(
        icon: Icons.merge_type,
        title: '8. Composed transforms — order matters',
        subtitle:
            'translate-then-rotate is NOT the same as rotate-then-translate.',
        color: _Palette.composedColor,
      ),
      SizedBox(height: 12.0),
      Row(
        children: [
          Expanded(
            child: _buildSubMatrixCard(
              title: 'translate(60,0)·rotateZ(0.4)',
              matrix: translateThenRotate,
              property: translateThenRotateProp,
              color: _Palette.composedColor,
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: _buildSubMatrixCard(
              title: 'rotateZ(0.4)·translate(60,0)',
              matrix: rotateThenTranslate,
              property: rotateThenTranslateProp,
              color: _Palette.composedColor,
            ),
          ),
        ],
      ),
      SizedBox(height: 12.0),
      _buildSubMatrixCard(
        title: 'translate·rotate·scale',
        matrix: fullCombo,
        property: fullComboProp,
        color: _Palette.composedColor,
      ),
    ],
  );

  // ============================================================
  // SECTION 9: Diagnostic levels
  // ============================================================
  print('=== Section 9: Diagnostic levels ===');
  final levelMatrices = <_LevelEntry>[
    _LevelEntry(
      level: DiagnosticLevel.fine,
      label: 'fine',
      description: 'Verbose; usually hidden from default inspector views.',
      color: Colors.blue.shade300,
    ),
    _LevelEntry(
      level: DiagnosticLevel.info,
      label: 'info',
      description: 'Normal — shown in the default Diagnostics tree.',
      color: Colors.green.shade400,
    ),
    _LevelEntry(
      level: DiagnosticLevel.warning,
      label: 'warning',
      description: 'Highlighted; e.g. transform with NaN entries.',
      color: Colors.orange.shade400,
    ),
    _LevelEntry(
      level: DiagnosticLevel.error,
      label: 'error',
      description: 'Red — used for invalid matrices.',
      color: Colors.red.shade400,
    ),
  ];

  final levelCards = <Widget>[];
  for (var i = 0; i < levelMatrices.length; i++) {
    final entry = levelMatrices[i];
    final mat = Matrix4.rotationZ(0.05 * (i + 1));
    final p = TransformProperty(
      'level_${entry.label}',
      mat,
      level: entry.level,
    );
    print('level=${entry.label} → property.level=${p.level}, '
        'isFiltered(info)=${p.isFiltered(DiagnosticLevel.info)}');
    levelCards.add(
      Container(
        width: 180.0,
        margin: EdgeInsets.all(6.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: entry.color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: entry.color, width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.tune, color: entry.color, size: 18.0),
                SizedBox(width: 6.0),
                Text(
                  'level: ${entry.label}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: entry.color,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Text(
              entry.description,
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade800),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                p.toDescription().split('\n').first,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: Colors.grey.shade900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final levelSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _buildSectionHeader(
        icon: Icons.layers_outlined,
        title: '9. DiagnosticLevel filtering',
        subtitle:
            'Level controls whether the property surfaces in inspector tools.',
        color: Colors.deepPurple,
      ),
      SizedBox(height: 12.0),
      Wrap(alignment: WrapAlignment.start, children: levelCards),
    ],
  );

  // ============================================================
  // SECTION 10: showName + ifNull behaviour
  // ============================================================
  print('=== Section 10: showName + ifNull ===');
  final namedProp = TransformProperty(
    'transform',
    Matrix4.rotationZ(0.1),
  );
  final unnamedProp = TransformProperty(
    'transform',
    Matrix4.rotationZ(0.1),
    showName: false,
  );
  final nullProp = TransformProperty(
    'maybe_transform',
    null,
  );
  print('namedProp.toString()   = ${namedProp.toString()}');
  print('unnamedProp.toString() = ${unnamedProp.toString()}');
  print('nullProp.toString()    = ${nullProp.toString()}');
  print('nullProp.isNull        = ${nullProp.value == null}');

  final flagSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _buildSectionHeader(
        icon: Icons.toggle_on_outlined,
        title: '10. showName and ifNull',
        subtitle:
            'Controls how the property serialises into a diagnostics string.',
        color: Colors.teal,
      ),
      SizedBox(height: 12.0),
      _buildFlagRow(
        title: 'showName: true (default)',
        property: namedProp,
        color: Colors.teal,
      ),
      _buildFlagRow(
        title: 'showName: false',
        property: unnamedProp,
        color: Colors.teal,
      ),
      _buildFlagRow(
        title: 'value: null (TransformProperty handles null gracefully)',
        property: nullProp,
        color: Colors.teal,
      ),
    ],
  );

  // ============================================================
  // SECTION 11: Use cases — debugFillProperties
  // ============================================================
  print('=== Section 11: Use cases ===');
  const useCaseCode =
      "class _MyRender extends RenderProxyBox {\n"
      "  Matrix4 _transform = Matrix4.identity();\n"
      "  @override\n"
      "  void debugFillProperties(DiagnosticPropertiesBuilder p) {\n"
      "    super.debugFillProperties(p);\n"
      "    p.add(TransformProperty('transform', _transform));\n"
      "  }\n"
      "}";

  final useCaseList = <_UseCase>[
    _UseCase(
      Icons.bug_report,
      'Debugging hit-testing',
      'When a tap misses, dump the rendered transform with TransformProperty '
          'inside debugFillProperties to see exactly how the geometry has '
          'been moved.',
    ),
    _UseCase(
      Icons.architecture,
      'Custom RenderObject',
      'Subclasses of RenderObject expose transforms via debugFillProperties; '
          'TransformProperty produces multi-line, aligned output.',
    ),
    _UseCase(
      Icons.transform,
      'RenderTransform inspection',
      'RenderTransform itself uses TransformProperty internally — your '
          'wrappers should follow the same pattern for inspector parity.',
    ),
    _UseCase(
      Icons.terminal,
      'CLI dumps with toStringDeep()',
      'When dumping a render tree to a log file, TransformProperty makes '
          'matrices readable instead of one-line scalar lists.',
    ),
  ];

  final useCaseCards = <Widget>[];
  for (final uc in useCaseList) {
    useCaseCards.add(_buildUseCaseCard(uc));
  }

  final useCasesSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _buildSectionHeader(
        icon: Icons.lightbulb_outline,
        title: '11. Use cases',
        subtitle:
            'Where TransformProperty pays off in real Flutter codebases.',
        color: Colors.amber.shade800,
      ),
      SizedBox(height: 12.0),
      _buildCodeBlock(useCaseCode),
      SizedBox(height: 12.0),
      Wrap(children: useCaseCards),
    ],
  );

  // ============================================================
  // SECTION 12: Footguns
  // ============================================================
  print('=== Section 12: Footguns ===');
  final footguns = <_Footgun>[
    _Footgun(
      Icons.swap_calls,
      'Column-major vs row-major',
      'Matrix4 is stored column-major in vector_math, but human notation '
          'is usually row-major. The printed property uses row-major rows '
          'for readability — but storage indexing differs.',
    ),
    _Footgun(
      Icons.merge,
      'Translate-then-rotate ≠ rotate-then-translate',
      'Right-multiplying flips the practical effect. Always test both '
          'orderings; section 8 visualises the difference.',
    ),
    _Footgun(
      Icons.video_camera_back_outlined,
      'Perspective entry is [3][2]',
      'Many 3D tutorials place perspective at [2][3]. In Flutter you must '
          'use setEntry(3, 2, …) — the row index comes first.',
    ),
    _Footgun(
      Icons.warning_amber,
      'Radians, not degrees',
      'rotationZ(45) is 45 radians (~7 full turns), not 45 degrees. Use '
          'math.pi / 4 for an actual 45° rotation.',
    ),
    _Footgun(
      Icons.calculate_outlined,
      'Determinant 0 → invisible',
      'Scaling any axis to zero collapses geometry into a line; '
          'TransformProperty will still print, but the widget vanishes.',
    ),
  ];

  final footgunCards = <Widget>[];
  for (final fg in footguns) {
    footgunCards.add(_buildFootgunCard(fg));
  }

  final footgunSection = Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _buildSectionHeader(
        icon: Icons.report_problem_outlined,
        title: '12. Footguns',
        subtitle: 'Subtle behaviours that bite during real debugging.',
        color: Colors.red.shade700,
      ),
      SizedBox(height: 12.0),
      ...footgunCards,
    ],
  );

  // ============================================================
  // Pi sanity check (also exercises dart:math import)
  // ============================================================
  print('math.pi = ${math.pi}');

  print('TransformProperty Deep Demo completed successfully');

  // ============================================================
  // Compose entire visual layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Hero header
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade700, Colors.deepPurple.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              Icon(
                Icons.grid_4x4,
                size: 56.0,
                color: Colors.white,
              ),
              SizedBox(height: 8.0),
              Text(
                'TransformProperty',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'DiagnosticsProperty<Matrix4> — Deep Visual Demo',
                style: TextStyle(fontSize: 15.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),
        anatomyHeader,
        anatomyDiagram,
        SizedBox(height: 28.0),
        identitySection,
        SizedBox(height: 28.0),
        translationSection,
        SizedBox(height: 28.0),
        rotationZSection,
        SizedBox(height: 28.0),
        rotationXYSection,
        SizedBox(height: 28.0),
        scaleSection,
        SizedBox(height: 28.0),
        perspectiveSection,
        SizedBox(height: 28.0),
        composedSection,
        SizedBox(height: 28.0),
        levelSection,
        SizedBox(height: 28.0),
        flagSection,
        SizedBox(height: 28.0),
        useCasesSection,
        SizedBox(height: 28.0),
        footgunSection,
        SizedBox(height: 24.0),
      ],
    ),
  );
}

// ===============================================================
// Helpers — section header
// ===============================================================
Widget _buildSectionHeader({
  required IconData icon,
  required String title,
  required String subtitle,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color.withValues(alpha: 0.85), color.withValues(alpha: 0.55)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, size: 32.0, color: Colors.white),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                subtitle,
                style: TextStyle(color: Colors.white70, fontSize: 12.0),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===============================================================
// Helpers — full matrix section (header + matrix card)
// ===============================================================
Widget _buildMatrixSection({
  required IconData headerIcon,
  required String sectionTitle,
  required String sectionSubtitle,
  required Color color,
  required Matrix4 matrix,
  required TransformProperty property,
  required String code,
  required String description,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _buildSectionHeader(
        icon: headerIcon,
        title: sectionTitle,
        subtitle: sectionSubtitle,
        color: color,
      ),
      SizedBox(height: 12.0),
      Container(
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Description
            Text(
              description,
              style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800),
            ),
            SizedBox(height: 12.0),
            // Code snippet
            _buildCodeBlock(code),
            SizedBox(height: 12.0),
            // Matrix grid + visual side-by-side
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 3,
                  child: _buildMatrixGrid(matrix, color),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  flex: 2,
                  child: _buildVisualPreview(matrix, color),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            // Property toString
            _buildPropertyDump(property, color),
          ],
        ),
      ),
    ],
  );
}

// ===============================================================
// Helpers — sub-card variant for side-by-side matrices
// ===============================================================
Widget _buildSubMatrixCard({
  required String title,
  required Matrix4 matrix,
  required TransformProperty property,
  required Color color,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 12.0,
          ),
        ),
        SizedBox(height: 8.0),
        _buildMatrixGrid(matrix, color),
        SizedBox(height: 8.0),
        Center(child: _buildVisualPreview(matrix, color)),
        SizedBox(height: 8.0),
        _buildPropertyDump(property, color),
      ],
    ),
  );
}

// ===============================================================
// Helpers — matrix anatomy grid (m11..m44 with values)
// ===============================================================
Widget _buildMatrixGrid(Matrix4 matrix, Color color) {
  // Storage is column-major, so storage index = col * 4 + row.
  // We display rows top-to-bottom for human readability.
  final cells = <Widget>[];
  for (var row = 0; row < 4; row++) {
    final rowCells = <Widget>[];
    for (var col = 0; col < 4; col++) {
      final storageIndex = col * 4 + row;
      final value = matrix.storage[storageIndex];
      final label = 'm${row + 1}${col + 1}';
      rowCells.add(_buildMatrixCell(label, value, color));
    }
    cells.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: rowCells,
        ),
      ),
    );
  }
  return Container(
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anatomy (row, col):',
          style: TextStyle(
            fontSize: 10.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4.0),
        ...cells,
      ],
    ),
  );
}

Widget _buildMatrixCell(String label, double value, Color color) {
  final isDiagonal = label[1] == label[2];
  final cellColor = isDiagonal
      ? color.withValues(alpha: 0.18)
      : Colors.grey.shade100;
  return Container(
    width: 64.0,
    margin: EdgeInsets.symmetric(horizontal: 1.5),
    padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
    decoration: BoxDecoration(
      color: cellColor,
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: color.withValues(alpha: 0.25), width: 0.8),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 8.5,
            color: color.withValues(alpha: 0.8),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          value.toStringAsFixed(2),
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.grey.shade900,
          ),
        ),
      ],
    ),
  );
}

// ===============================================================
// Helpers — visual preview rendering the actual transform
// ===============================================================
Widget _buildVisualPreview(Matrix4 matrix, Color color) {
  return Container(
    height: 160.0,
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    alignment: Alignment.center,
    child: Stack(
      alignment: Alignment.center,
      children: [
        // Reference outline (untransformed)
        Container(
          width: 70.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1.0,
              style: BorderStyle.solid,
            ),
          ),
        ),
        // Transformed visual
        Transform(
          alignment: Alignment.center,
          transform: matrix,
          child: Container(
            width: 70.0,
            height: 50.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.85),
                  color.withValues(alpha: 0.55),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(6.0),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 6.0,
                  offset: Offset(0.0, 3.0),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'T',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// ===============================================================
// Helpers — property dump (toString())
// ===============================================================
Widget _buildPropertyDump(TransformProperty property, Color color) {
  final text = property.toString();
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: _Palette.codeBg,
      borderRadius: BorderRadius.circular(6.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.terminal,
              size: 14.0,
              color: color.withValues(alpha: 0.9),
            ),
            SizedBox(width: 6.0),
            Text(
              'TransformProperty.toString()',
              style: TextStyle(
                color: color.withValues(alpha: 0.9),
                fontWeight: FontWeight.bold,
                fontSize: 10.5,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          text,
          style: TextStyle(
            color: _Palette.codeFg,
            fontFamily: 'monospace',
            fontSize: 10.5,
            height: 1.3,
          ),
        ),
      ],
    ),
  );
}

// ===============================================================
// Helpers — anatomy row (used in section 1)
// ===============================================================
Widget _buildAnatomyRow(String key, String description, IconData icon) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 18.0, color: _Palette.anatomyColor),
        SizedBox(width: 8.0),
        SizedBox(
          width: 80.0,
          child: Text(
            key,
            style: TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: _Palette.anatomyColor,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12.0, color: Colors.grey.shade800),
          ),
        ),
      ],
    ),
  );
}

// ===============================================================
// Helpers — flag row (showName / ifNull)
// ===============================================================
Widget _buildFlagRow({
  required String title,
  required TransformProperty property,
  required Color color,
}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 12.5,
          ),
        ),
        SizedBox(height: 6.0),
        _buildPropertyDump(property, color),
      ],
    ),
  );
}

// ===============================================================
// Helpers — code block
// ===============================================================
Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: _Palette.codeBg,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.5,
        color: _Palette.codeFg,
        height: 1.4,
      ),
    ),
  );
}

// ===============================================================
// Helpers — use case card
// ===============================================================
Widget _buildUseCaseCard(_UseCase uc) {
  return Container(
    width: 260.0,
    margin: EdgeInsets.all(6.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.amber.shade400, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(uc.icon, color: Colors.amber.shade800, size: 20.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                uc.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.amber.shade900,
                  fontSize: 13.0,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          uc.description,
          style: TextStyle(fontSize: 11.5, color: Colors.grey.shade800),
        ),
      ],
    ),
  );
}

// ===============================================================
// Helpers — footgun card
// ===============================================================
Widget _buildFootgunCard(_Footgun fg) {
  return Container(
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.red.shade300, width: 1.0),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(fg.icon, color: Colors.red.shade700, size: 22.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fg.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade900,
                  fontSize: 13.0,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                fg.description,
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade800),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ===============================================================
// Internal lightweight value holders
// ===============================================================
class _LevelEntry {
  final DiagnosticLevel level;
  final String label;
  final String description;
  final Color color;
  const _LevelEntry({
    required this.level,
    required this.label,
    required this.description,
    required this.color,
  });
}

class _UseCase {
  final IconData icon;
  final String title;
  final String description;
  const _UseCase(this.icon, this.title, this.description);
}

class _Footgun {
  final IconData icon;
  final String title;
  final String description;
  const _Footgun(this.icon, this.title, this.description);
}
