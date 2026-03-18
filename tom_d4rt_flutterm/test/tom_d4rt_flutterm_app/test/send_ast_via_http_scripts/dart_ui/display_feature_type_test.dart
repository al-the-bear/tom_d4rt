// D4rt test script: Deep Demo for DisplayFeatureType from dart:ui
// DisplayFeatureType describes the type of physical display feature on a device
// Used with DisplayFeature to categorize cutouts, folds, and hinges
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== DisplayFeatureType Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ALL ENUM VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  final allTypes = ui.DisplayFeatureType.values;
  print('DisplayFeatureType.values (${allTypes.length}):');
  for (final type in allTypes) {
    print('  ${type.name} (index=${type.index})');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: INDIVIDUAL VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  final unknown = ui.DisplayFeatureType.unknown;
  final fold = ui.DisplayFeatureType.fold;
  final hinge = ui.DisplayFeatureType.hinge;
  final cutout = ui.DisplayFeatureType.cutout;

  print('unknown: name=${unknown.name}, index=${unknown.index}');
  print('fold: name=${fold.name}, index=${fold.index}');
  print('hinge: name=${hinge.name}, index=${hinge.index}');
  print('cutout: name=${cutout.name}, index=${cutout.index}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: EQUALITY
  // ═══════════════════════════════════════════════════════════════════════════

  print('unknown == unknown: ${unknown == unknown}');
  print('fold == fold: ${fold == fold}');
  print('fold == hinge: ${fold == hinge}');
  print('hinge == cutout: ${hinge == cutout}');
  print('identical(fold, DisplayFeatureType.fold): ${identical(fold, ui.DisplayFeatureType.fold)}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: FEATURE CHARACTERISTICS
  // ═══════════════════════════════════════════════════════════════════════════

  for (final type in allTypes) {
    final obstructsContent = type == ui.DisplayFeatureType.hinge ||
                             type == ui.DisplayFeatureType.cutout;
    final separatesScreens = type == ui.DisplayFeatureType.fold ||
                              type == ui.DisplayFeatureType.hinge;
    print('${type.name}: obstructs=$obstructsContent, separates=$separatesScreens');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: STRING AND HASH
  // ═══════════════════════════════════════════════════════════════════════════

  for (final type in allTypes) {
    print('${type.name}: toString=${type.toString()}, hashCode=${type.hashCode}');
  }

  print('DisplayFeatureType demo complete');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  final typeInfos = <_TypeInfo>[
    _TypeInfo(
      type: unknown,
      label: 'unknown',
      description: 'An unrecognized or unsupported display feature type',
      icon: Icons.help_outline,
      color: Color(0xFF757575),
      obstructs: false,
      separates: false,
      example: 'Future device types not yet categorized',
    ),
    _TypeInfo(
      type: fold,
      label: 'fold',
      description: 'A flexible fold in the display surface itself — content can render across it',
      icon: Icons.auto_stories,
      color: Color(0xFF1565C0),
      obstructs: false,
      separates: true,
      example: 'Samsung Galaxy Z Fold inner display crease',
    ),
    _TypeInfo(
      type: hinge,
      label: 'hinge',
      description: 'A physical hinge with a gap between two separate display panels',
      icon: Icons.menu_book,
      color: Color(0xFF6A1B9A),
      obstructs: true,
      separates: true,
      example: 'Microsoft Surface Duo hinge gap',
    ),
    _TypeInfo(
      type: cutout,
      label: 'cutout',
      description: 'A display cutout (notch, hole-punch) where content cannot be rendered',
      icon: Icons.crop_free,
      color: Color(0xFFE65100),
      obstructs: true,
      separates: false,
      example: 'Camera notch, hole-punch camera, pill-shaped cutout',
    ),
  ];

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
                    colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 12, offset: Offset(0, 6)),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.devices, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text('DisplayFeatureType',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                        color: Colors.white)),
                    SizedBox(height: 6),
                    Text('Physical display feature categories',
                      style: TextStyle(fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.85))),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text('${allTypes.length} values',
                        style: TextStyle(fontSize: 12, color: Colors.white)),
                    ),
                  ],
                ),
              ),

              // ── Section 1: Type Cards ──
              _sectionTitle('1. ENUM VALUES'),
              ...typeInfos.map((info) => _typeCard(info)),

              // ── Section 2: Feature Comparison Matrix ──
              _sectionTitle('2. COMPARISON MATRIX'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    // Header row
                    Row(
                      children: [
                        SizedBox(width: 80, child: Text('Feature',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))),
                        Expanded(child: Center(child: Text('Obstructs',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)))),
                        Expanded(child: Center(child: Text('Separates',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)))),
                        Expanded(child: Center(child: Text('Flexible',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11)))),
                      ],
                    ),
                    Divider(height: 16),
                    _matrixRow('unknown', false, false, false, Color(0xFF757575)),
                    _matrixRow('fold', false, true, true, Color(0xFF1565C0)),
                    _matrixRow('hinge', true, true, false, Color(0xFF6A1B9A)),
                    _matrixRow('cutout', true, false, false, Color(0xFFE65100)),
                  ],
                ),
              ),

              // ── Section 3: Visual Display Feature ──
              _sectionTitle('3. DEVICE CROSS-SECTIONS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _crossSection('Fold', Color(0xFF1565C0), _foldCrossSection()),
                    SizedBox(height: 16),
                    _crossSection('Hinge', Color(0xFF6A1B9A), _hingeCrossSection()),
                    SizedBox(height: 16),
                    _crossSection('Cutout', Color(0xFFE65100), _cutoutCrossSection()),
                  ],
                ),
              ),

              // ── Section 4: Layout Implications ──
              _sectionTitle('4. LAYOUT IMPLICATIONS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _implicationRow('fold',
                      'Content CAN span the fold area. Visual crease may be visible.',
                      Icons.check_circle, Color(0xFF1565C0)),
                    Divider(height: 20),
                    _implicationRow('hinge',
                      'Content CANNOT span the gap. Must split into two panes.',
                      Icons.cancel, Color(0xFF6A1B9A)),
                    Divider(height: 20),
                    _implicationRow('cutout',
                      'Content CANNOT render behind cutout. Use SafeArea to avoid.',
                      Icons.cancel, Color(0xFFE65100)),
                    Divider(height: 20),
                    _implicationRow('unknown',
                      'Treat conservatively — assume content may be affected.',
                      Icons.warning, Color(0xFF757575)),
                  ],
                ),
              ),

              // ── Section 5: Equality ──
              _sectionTitle('5. EQUALITY & IDENTITY'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _equalityRow('unknown == unknown', true),
                    _equalityRow('fold == fold', true),
                    _equalityRow('fold == hinge', false),
                    _equalityRow('hinge == cutout', false),
                    _equalityRow('cutout == cutout', true),
                  ],
                ),
              ),

              // ── Section 6: API Usage ──
              _sectionTitle('6. API USAGE PATTERN'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _codeStep(1, 'Get display features',
                      'MediaQuery.displayFeatures', Color(0xFF1565C0)),
                    SizedBox(height: 10),
                    _codeStep(2, 'Check type of each',
                      'feature.type == DisplayFeatureType.hinge', Color(0xFF6A1B9A)),
                    SizedBox(height: 10),
                    _codeStep(3, 'Access bounds',
                      'feature.bounds → Rect of the feature area', Color(0xFF2E7D32)),
                    SizedBox(height: 10),
                    _codeStep(4, 'Adapt layout',
                      'Split panes around hinge, avoid cutouts', Color(0xFFE65100)),
                    SizedBox(height: 16),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'TwoPane and similar widgets use DisplayFeatureType '
                        'to automatically compute split positions.',
                        style: TextStyle(fontSize: 11, color: Color(0xFF1565C0)),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 7: Device Examples ──
              _sectionTitle('7. REAL DEVICE EXAMPLES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _deviceRow('Galaxy Z Fold', 'fold', Color(0xFF1565C0),
                      'Single flexible OLED with center crease'),
                    _deviceRow('Surface Duo', 'hinge', Color(0xFF6A1B9A),
                      'Two separate OLED panels with 360° hinge'),
                    _deviceRow('iPhone 14 Pro', 'cutout', Color(0xFFE65100),
                      'Dynamic Island pill-shaped camera cutout'),
                    _deviceRow('Pixel 8', 'cutout', Color(0xFFE65100),
                      'Hole-punch front camera cutout'),
                    _deviceRow('Standard phone', 'none', Color(0xFF757575),
                      'No display features reported'),
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

// ─── DATA CLASS ─────────────────────────────────────────────────────────────

class _TypeInfo {
  final ui.DisplayFeatureType type;
  final String label;
  final String description;
  final IconData icon;
  final Color color;
  final bool obstructs;
  final bool separates;
  final String example;

  _TypeInfo({
    required this.type,
    required this.label,
    required this.description,
    required this.icon,
    required this.color,
    required this.obstructs,
    required this.separates,
    required this.example,
  });
}

// ─── HELPERS ────────────────────────────────────────────────────────────────

Widget _sectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
    child: Text(title, style: TextStyle(
      fontSize: 13, fontWeight: FontWeight.w700,
      color: Color(0xFF455A64), letterSpacing: 1.0,
    )),
  );
}

Widget _typeCard(_TypeInfo info) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
    padding: EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: info.color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(
            color: info.color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(info.icon, color: info.color, size: 26),
        ),
        SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(info.label, style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 14)),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: info.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('idx ${info.type.index}',
                      style: TextStyle(fontSize: 9, color: info.color)),
                  ),
                  SizedBox(width: 4),
                  if (info.obstructs)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFEBEE), borderRadius: BorderRadius.circular(4)),
                      child: Text('obstructs', style: TextStyle(fontSize: 8, color: Color(0xFFC62828))),
                    ),
                  if (info.separates) ...[
                    SizedBox(width: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                      decoration: BoxDecoration(
                        color: Color(0xFFE3F2FD), borderRadius: BorderRadius.circular(4)),
                      child: Text('separates', style: TextStyle(fontSize: 8, color: Color(0xFF1565C0))),
                    ),
                  ],
                ],
              ),
              SizedBox(height: 3),
              Text(info.description, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
              SizedBox(height: 2),
              Text(info.example, style: TextStyle(fontSize: 10,
                fontStyle: FontStyle.italic, color: Colors.grey[500])),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _matrixRow(String label, bool obstructs, bool separates, bool flexible, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(width: 80,
          child: Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: color))),
        Expanded(child: Center(child: _boolIcon(obstructs))),
        Expanded(child: Center(child: _boolIcon(separates))),
        Expanded(child: Center(child: _boolIcon(flexible))),
      ],
    ),
  );
}

Widget _boolIcon(bool value) {
  return Icon(
    value ? Icons.check_circle : Icons.cancel,
    color: value ? Color(0xFF2E7D32) : Color(0xFFBDBDBD),
    size: 18,
  );
}

Widget _crossSection(String label, Color color, Widget diagram) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: color)),
      SizedBox(height: 8),
      diagram,
    ],
  );
}

Widget _foldCrossSection() {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFBBDEFB),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
            ),
            child: Center(child: Text('Screen A', style: TextStyle(fontSize: 10))),
          ),
        ),
        Container(
          width: 4,
          color: Color(0xFF1565C0),
          child: Center(child: Text('┃', style: TextStyle(fontSize: 10, color: Colors.white))),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFBBDEFB),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
            ),
            child: Center(child: Text('Screen B', style: TextStyle(fontSize: 10))),
          ),
        ),
      ],
    ),
  );
}

Widget _hingeCrossSection() {
  return Container(
    height: 50,
    child: Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFE1BEE7),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
            ),
            child: Center(child: Text('Panel A', style: TextStyle(fontSize: 10))),
          ),
        ),
        Container(
          width: 24,
          decoration: BoxDecoration(
            color: Color(0xFF6A1B9A).withValues(alpha: 0.3),
            border: Border.symmetric(
              vertical: BorderSide(color: Color(0xFF6A1B9A), width: 2)),
          ),
          child: Center(child: Text('Gap', style: TextStyle(fontSize: 9, color: Color(0xFF6A1B9A)))),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFE1BEE7),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
            ),
            child: Center(child: Text('Panel B', style: TextStyle(fontSize: 10))),
          ),
        ),
      ],
    ),
  );
}

Widget _cutoutCrossSection() {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      color: Color(0xFFFFF3E0),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        Center(child: Text('Display Surface', style: TextStyle(fontSize: 10))),
        Positioned(
          top: 0,
          child: Container(
            width: 60, height: 18,
            decoration: BoxDecoration(
              color: Color(0xFFE65100),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            ),
            child: Center(child: Text('Cutout', style: TextStyle(
              fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold))),
          ),
        ),
      ],
    ),
  );
}

Widget _implicationRow(String label, String desc, IconData icon, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 30, height: 30,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(6)),
        child: Icon(icon, color: color, size: 18),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: color)),
            Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          ],
        ),
      ),
    ],
  );
}

Widget _equalityRow(String expression, bool result) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Expanded(child: Text(expression, style: TextStyle(fontSize: 12, fontFamily: 'monospace'))),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: result ? Color(0xFFE8F5E9) : Color(0xFFFFEBEE),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(result ? 'true' : 'false',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold,
              color: result ? Color(0xFF2E7D32) : Color(0xFFC62828))),
        ),
      ],
    ),
  );
}

Widget _codeStep(int step, String label, String code, Color color) {
  return Row(
    children: [
      Container(
        width: 24, height: 24,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(child: Text('$step', style: TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12))),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
            Text(code, style: TextStyle(fontSize: 10, fontFamily: 'monospace',
              color: Colors.grey[600])),
          ],
        ),
      ),
    ],
  );
}

Widget _deviceRow(String device, String type, Color color, String detail) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(type, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: color)),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(device, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
              Text(detail, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
            ],
          ),
        ),
      ],
    ),
  );
}
