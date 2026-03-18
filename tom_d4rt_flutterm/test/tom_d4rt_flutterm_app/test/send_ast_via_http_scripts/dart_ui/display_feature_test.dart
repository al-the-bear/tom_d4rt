// D4rt test script: Deep Demo for DisplayFeature from dart:ui
// DisplayFeature describes a physical feature on the display surface
// (folds, hinges, cutouts) with bounds, type, and state
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== DisplayFeature Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CONSTRUCTORS
  // ═══════════════════════════════════════════════════════════════════════════

  final feature1 = ui.DisplayFeature(
    bounds: Rect.fromLTWH(380, 0, 8, 800),
    type: ui.DisplayFeatureType.hinge,
    state: ui.DisplayFeatureState.postureFlat,
  );
  print(
    'Feature 1 (hinge): bounds=${feature1.bounds}, type=${feature1.type}, state=${feature1.state}',
  );

  final feature2 = ui.DisplayFeature(
    bounds: Rect.fromLTWH(0, 0, 120, 30),
    type: ui.DisplayFeatureType.cutout,
    state: ui.DisplayFeatureState.unknown,
  );
  print('Feature 2 (cutout): bounds=${feature2.bounds}, type=${feature2.type}');

  final feature3 = ui.DisplayFeature(
    bounds: Rect.fromLTWH(540, 0, 4, 900),
    type: ui.DisplayFeatureType.fold,
    state: ui.DisplayFeatureState.postureHalfOpened,
  );
  print('Feature 3 (fold): bounds=${feature3.bounds}, state=${feature3.state}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: PROPERTIES
  // ═══════════════════════════════════════════════════════════════════════════

  print('Feature 1 properties:');
  print('  bounds: ${feature1.bounds}');
  print('  bounds.width: ${feature1.bounds.width}');
  print('  bounds.height: ${feature1.bounds.height}');
  print('  type: ${feature1.type}');
  print('  state: ${feature1.state}');
  print('  hashCode: ${feature1.hashCode}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: EQUALITY
  // ═══════════════════════════════════════════════════════════════════════════

  final feature1Copy = ui.DisplayFeature(
    bounds: Rect.fromLTWH(380, 0, 8, 800),
    type: ui.DisplayFeatureType.hinge,
    state: ui.DisplayFeatureState.postureFlat,
  );
  print('feature1 == feature1Copy: ${feature1 == feature1Copy}');
  print('feature1 == feature2: ${feature1 == feature2}');
  print(
    'feature1.hashCode == feature1Copy.hashCode: ${feature1.hashCode == feature1Copy.hashCode}',
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: USE WITH MediaQuery
  // ═══════════════════════════════════════════════════════════════════════════

  // In a real app: MediaQuery.of(context).displayFeatures
  print('Typical usage:');
  print('  final features = MediaQuery.of(context).displayFeatures;');
  print('  for (final f in features) {');
  print('    if (f.type == DisplayFeatureType.hinge) { split layout }');
  print('    if (f.type == DisplayFeatureType.cutout) { add padding }');
  print('  }');

  print('DisplayFeature demo complete');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  final features = [feature1, feature2, feature3];

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF0F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ──
              Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1A237E), Color(0xFF5C6BC0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.devices_fold, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'DisplayFeature',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Physical display feature with bounds, type, and state',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 1: Feature Cards ──
              _sectionTitle('1. DISPLAY FEATURES'),
              ...features.asMap().entries.map(
                (e) => _featureCard(e.key + 1, e.value),
              ),

              // ── Section 2: Device Mockup ──
              _sectionTitle('2. DEVICE MOCKUP WITH FEATURES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: _deviceMockup(features),
              ),

              // ── Section 3: Properties Table ──
              _sectionTitle('3. CONSTRUCTOR PARAMETERS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _paramRow(
                      'bounds',
                      'Rect',
                      'Physical area of the feature on screen',
                      Color(0xFF1A237E),
                    ),
                    _paramRow(
                      'type',
                      'DisplayFeatureType',
                      'Category: fold, hinge, cutout, unknown',
                      Color(0xFF2E7D32),
                    ),
                    _paramRow(
                      'state',
                      'DisplayFeatureState',
                      'Posture: flat, halfOpened, unknown',
                      Color(0xFFE65100),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFE8EAF6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'All three parameters are required. Bounds are in physical '
                        'pixels (not logical). Use devicePixelRatio for conversion.',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF1A237E),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 4: Equality ──
              _sectionTitle('4. EQUALITY'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _equalityRow(
                      'feature1 == feature1Copy',
                      feature1 == feature1Copy,
                    ),
                    _equalityRow('feature1 == feature2', feature1 == feature2),
                    _equalityRow('feature1 == feature3', feature1 == feature3),
                    _equalityRow(
                      'hashCode match',
                      feature1.hashCode == feature1Copy.hashCode,
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Value equality: two DisplayFeatures are equal if bounds, type, '
                        'and state are all equal.',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF2E7D32),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 5: Type × State Matrix ──
              _sectionTitle('5. TYPE × STATE MATRIX'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _matrixHeader(),
                    _matrixDataRow('fold', [true, true, true]),
                    _matrixDataRow('hinge', [true, true, true]),
                    _matrixDataRow('cutout', [true, false, false]),
                    _matrixDataRow('unknown', [true, false, false]),
                  ],
                ),
              ),

              // ── Section 6: Bounds Comparison ──
              _sectionTitle('6. BOUNDS COMPARISON'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _boundsBar('Hinge', feature1.bounds, Color(0xFF1A237E)),
                    SizedBox(height: 10),
                    _boundsBar('Cutout', feature2.bounds, Color(0xFFBF360C)),
                    SizedBox(height: 10),
                    _boundsBar('Fold', feature3.bounds, Color(0xFF2E7D32)),
                    SizedBox(height: 16),
                    Text(
                      'Bounds in physical pixels',
                      style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),

              // ── Section 7: MediaQuery Integration ──
              _sectionTitle('7. MEDIAQUERY INTEGRATION'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _integrationStep(
                      1,
                      'Query features',
                      'MediaQuery.displayFeaturesOf(context)',
                      Icons.search,
                      Color(0xFF1A237E),
                    ),
                    _arrow(),
                    _integrationStep(
                      2,
                      'Filter by type',
                      'features.where((f) => f.type == hinge)',
                      Icons.filter_list,
                      Color(0xFF2E7D32),
                    ),
                    _arrow(),
                    _integrationStep(
                      3,
                      'Read bounds',
                      'feature.bounds → Rect of feature area',
                      Icons.crop,
                      Color(0xFFE65100),
                    ),
                    _arrow(),
                    _integrationStep(
                      4,
                      'Adapt layout',
                      'Split panes, add padding, avoid cutouts',
                      Icons.dashboard,
                      Color(0xFF6A1B9A),
                    ),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFF8E1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.lightbulb,
                            color: Color(0xFFF57F17),
                            size: 16,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Flutter TwoPane widget handles this automatically '
                              'for Surface Duo and similar devices.',
                              style: TextStyle(
                                fontSize: 11,
                                color: Color(0xFFF57F17),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// ─── HELPERS ────────────────────────────────────────────────────────────────

Widget _sectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Color(0xFF455A64),
        letterSpacing: 1.0,
      ),
    ),
  );
}

Color _typeColor(ui.DisplayFeatureType type) {
  switch (type) {
    case ui.DisplayFeatureType.fold:
      return Color(0xFF2E7D32);
    case ui.DisplayFeatureType.hinge:
      return Color(0xFF1A237E);
    case ui.DisplayFeatureType.cutout:
      return Color(0xFFBF360C);
    default:
      return Color(0xFF757575);
  }
}

Widget _featureCard(int index, ui.DisplayFeature feature) {
  final color = _typeColor(feature.type);
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              '#$index',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color,
                fontSize: 14,
              ),
            ),
          ),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      feature.type.name,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                  SizedBox(width: 6),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      feature.state.name,
                      style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Text(
                'Bounds: ${feature.bounds.left.toInt()},${feature.bounds.top.toInt()} → '
                '${feature.bounds.right.toInt()},${feature.bounds.bottom.toInt()} '
                '(${feature.bounds.width.toInt()}×${feature.bounds.height.toInt()})',
                style: TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _deviceMockup(List<ui.DisplayFeature> features) {
  return Container(
    height: 180,
    decoration: BoxDecoration(
      color: Color(0xFFECEFF1),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Color(0xFF455A64), width: 3),
    ),
    child: Stack(
      children: [
        // Screen areas
        Positioned.fill(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(0xFFBBDEFB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Screen A',
                      style: TextStyle(
                        color: Color(0xFF1565C0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(0xFFC8E6C9),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Screen B',
                      style: TextStyle(
                        color: Color(0xFF2E7D32),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Show hinge in center
        Center(
          child: Container(
            width: 8,
            height: 180,
            decoration: BoxDecoration(
              color: Color(0xFF1A237E).withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        // Cutout in top-left
        Positioned(
          top: 4,
          left: 20,
          child: Container(
            width: 40,
            height: 14,
            decoration: BoxDecoration(
              color: Color(0xFFBF360C),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Center(
              child: Text(
                'cam',
                style: TextStyle(
                  fontSize: 7,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _paramRow(String name, String type, String desc, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 60,
          child: Text(
            name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(type, style: TextStyle(fontSize: 9, color: color)),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
        ),
      ],
    ),
  );
}

Widget _equalityRow(String expr, bool result) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Expanded(
          child: Text(
            expr,
            style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: result ? Color(0xFFE8F5E9) : Color(0xFFFFEBEE),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            result ? 'true' : 'false',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: result ? Color(0xFF2E7D32) : Color(0xFFC62828),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _matrixHeader() {
  return Padding(
    padding: EdgeInsets.only(bottom: 6),
    child: Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            'Type',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'unknown',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'flat',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              'halfOpen',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _matrixDataRow(String type, List<bool> values) {
  final color = type == 'fold'
      ? Color(0xFF2E7D32)
      : type == 'hinge'
      ? Color(0xFF1A237E)
      : type == 'cutout'
      ? Color(0xFFBF360C)
      : Color(0xFF757575);
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            type,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
        ...values.map(
          (v) => Expanded(
            child: Center(
              child: Icon(
                v ? Icons.check_circle : Icons.remove_circle_outline,
                color: v ? Color(0xFF2E7D32) : Color(0xFFBDBDBD),
                size: 18,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _boundsBar(String label, Rect bounds, Color color) {
  return Row(
    children: [
      SizedBox(
        width: 60,
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
        ),
      ),
      Expanded(
        child: Container(
          height: 20,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(4),
          ),
          child: Stack(
            children: [
              Positioned(
                left: bounds.left / 10,
                child: Container(
                  width: (bounds.width + 4).clamp(4, 80),
                  height: 20,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(width: 8),
      Text(
        '${bounds.width.toInt()}×${bounds.height.toInt()}',
        style: TextStyle(fontSize: 10, fontFamily: 'monospace', color: color),
      ),
    ],
  );
}

Widget _integrationStep(
  int step,
  String label,
  String code,
  IconData icon,
  Color color,
) {
  return Row(
    children: [
      Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(
          child: Text(
            '$step',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            Text(
              code,
              style: TextStyle(
                fontSize: 10,
                fontFamily: 'monospace',
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
      Icon(icon, color: color, size: 18),
    ],
  );
}

Widget _arrow() {
  return Padding(
    padding: EdgeInsets.only(left: 12),
    child: Icon(Icons.arrow_downward, color: Colors.grey[400], size: 14),
  );
}
