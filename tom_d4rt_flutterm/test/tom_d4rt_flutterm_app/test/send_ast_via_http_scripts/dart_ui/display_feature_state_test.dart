// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for DisplayFeatureState from dart:ui
// DisplayFeatureState describes the posture or state of a foldable device display feature
// Used with DisplayFeature to describe how a hinge or fold is currently positioned
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== DisplayFeatureState Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ALL ENUM VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  final allStates = ui.DisplayFeatureState.values;
  print('DisplayFeatureState.values (${allStates.length}):');
  for (final state in allStates) {
    print('  ${state.name} (index=${state.index})');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: INDIVIDUAL VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  final unknown = ui.DisplayFeatureState.unknown;
  final postureFlat = ui.DisplayFeatureState.postureFlat;
  final postureHalfOpened = ui.DisplayFeatureState.postureHalfOpened;

  print('unknown: name=${unknown.name}, index=${unknown.index}');
  print('postureFlat: name=${postureFlat.name}, index=${postureFlat.index}');
  print(
    'postureHalfOpened: name=${postureHalfOpened.name}, index=${postureHalfOpened.index}',
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: EQUALITY AND IDENTITY
  // ═══════════════════════════════════════════════════════════════════════════

  print('unknown == unknown: ${unknown == unknown}');
  print('unknown == postureFlat: ${unknown == postureFlat}');
  print('postureFlat == postureFlat: ${postureFlat == postureFlat}');
  print(
    'postureHalfOpened == postureHalfOpened: ${postureHalfOpened == postureHalfOpened}',
  );
  print(
    'identical(unknown, DisplayFeatureState.unknown): ${identical(unknown, ui.DisplayFeatureState.unknown)}',
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: COMPARISONS
  // ═══════════════════════════════════════════════════════════════════════════

  final sorted = List.of(allStates)..sort((a, b) => a.index.compareTo(b.index));
  print('Sorted by index: ${sorted.map((s) => s.name).join(', ')}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: TYPICAL USE WITH DisplayFeature
  // ═══════════════════════════════════════════════════════════════════════════

  // DisplayFeature uses state to describe foldable posture
  // Checking state in conditional logic:
  for (final state in allStates) {
    final isKnown = state != ui.DisplayFeatureState.unknown;
    final isOpen = state == ui.DisplayFeatureState.postureHalfOpened;
    print('${state.name}: isKnown=$isKnown, isHalfOpened=$isOpen');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: STRING AND HASH
  // ═══════════════════════════════════════════════════════════════════════════

  for (final state in allStates) {
    print(
      '${state.name}: toString=${state.toString()}, hashCode=${state.hashCode}',
    );
  }

  print('DisplayFeatureState demo complete');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  final stateInfos = <_StateInfo>[
    _StateInfo(
      state: unknown,
      label: 'unknown',
      description:
          'Posture of the foldable device is not known or not applicable',
      icon: Icons.help_outline,
      color: Color(0xFF757575),
      angle: 0,
      scenario: 'Non-foldable device or unsupported sensor',
    ),
    _StateInfo(
      state: postureFlat,
      label: 'postureFlat',
      description:
          'The foldable device is fully opened flat with no angle between screens',
      icon: Icons.tablet_mac,
      color: Color(0xFF2E7D32),
      angle: 180,
      scenario: 'Device used as a tablet, both screens flush',
    ),
    _StateInfo(
      state: postureHalfOpened,
      label: 'postureHalfOpened',
      description:
          'The foldable device is partially folded with screens at an angle',
      icon: Icons.laptop,
      color: Color(0xFF1565C0),
      angle: 120,
      scenario: 'Laptop posture, book posture, tent mode',
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
                    colors: [Color(0xFF37474F), Color(0xFF78909C)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueGrey.withValues(alpha: 0.3),
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
                      'DisplayFeatureState',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Foldable device posture states',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${allStates.length} values',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 1: State Cards ──
              _sectionTitle('1. ENUM VALUES'),
              ...stateInfos.map((info) => _stateCard(info)),

              // ── Section 2: Foldable Device Visualization ──
              _sectionTitle('2. DEVICE POSTURE VISUALIZATION'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _devicePosture('Unknown', 0, Color(0xFF757575)),
                    _devicePosture('Flat', 180, Color(0xFF2E7D32)),
                    _devicePosture('Half', 120, Color(0xFF1565C0)),
                  ],
                ),
              ),

              // ── Section 3: State Transitions ──
              _sectionTitle('3. STATE TRANSITIONS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _transitionRow(
                      'unknown',
                      'postureFlat',
                      'Device opened fully',
                      Color(0xFF757575),
                      Color(0xFF2E7D32),
                    ),
                    SizedBox(height: 12),
                    _transitionRow(
                      'postureFlat',
                      'postureHalfOpened',
                      'User folds device',
                      Color(0xFF2E7D32),
                      Color(0xFF1565C0),
                    ),
                    SizedBox(height: 12),
                    _transitionRow(
                      'postureHalfOpened',
                      'postureFlat',
                      'User opens fully',
                      Color(0xFF1565C0),
                      Color(0xFF2E7D32),
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
                            Icons.info_outline,
                            size: 16,
                            color: Color(0xFFF57F17),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Transitions are determined by device hardware sensors. '
                              'The OS reports state changes to Flutter.',
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

              // ── Section 4: Angle Visualization ──
              _sectionTitle('4. HINGE ANGLE RANGES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _angleBar('unknown', '?°', 0.0, Color(0xFF757575)),
                    SizedBox(height: 12),
                    _angleBar('postureFlat', '~180°', 1.0, Color(0xFF2E7D32)),
                    SizedBox(height: 12),
                    _angleBar(
                      'postureHalfOpened',
                      '~90°-170°',
                      0.65,
                      Color(0xFF1565C0),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '0° (closed)',
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                        Text(
                          '180° (flat)',
                          style: TextStyle(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
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
                    _equalityRow('unknown == postureFlat', false),
                    _equalityRow('postureFlat == postureFlat', true),
                    _equalityRow(
                      'postureHalfOpened == postureHalfOpened',
                      true,
                    ),
                    _equalityRow('postureFlat == postureHalfOpened', false),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Enum singletons: identical() and == behave the same.',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF1565C0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 6: Use Cases ──
              _sectionTitle('6. USE CASES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _useCaseRow(
                      Icons.auto_fix_high,
                      'Adaptive layouts',
                      'Switch between single/dual pane based on posture',
                      Color(0xFF1565C0),
                    ),
                    Divider(height: 20),
                    _useCaseRow(
                      Icons.rotate_90_degrees_cw,
                      'Orientation handling',
                      'Adjust content rotation for tent or laptop mode',
                      Color(0xFF6A1B9A),
                    ),
                    Divider(height: 20),
                    _useCaseRow(
                      Icons.gamepad,
                      'Game controls',
                      'Half-opened: top screen = viewport, bottom = controls',
                      Color(0xFF2E7D32),
                    ),
                    Divider(height: 20),
                    _useCaseRow(
                      Icons.video_call,
                      'Video conferencing',
                      'Tent mode with camera facing user, screen as display',
                      Color(0xFFE65100),
                    ),
                  ],
                ),
              ),

              // ── Section 7: Affected Devices ──
              _sectionTitle('7. AFFECTED DEVICES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _deviceRow(
                      'Samsung Galaxy Z Fold',
                      'Foldable phone/tablet',
                      Color(0xFF1565C0),
                    ),
                    _deviceRow(
                      'Microsoft Surface Duo',
                      'Dual-screen hinged',
                      Color(0xFF2E7D32),
                    ),
                    _deviceRow(
                      'Lenovo ThinkPad X1 Fold',
                      'Foldable laptop',
                      Color(0xFF6A1B9A),
                    ),
                    _deviceRow(
                      'Non-foldable phones',
                      'Always reports unknown',
                      Color(0xFF757575),
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Color(0xFFF3E5F5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'MediaQuery.displayFeatures provides the current state. '
                        'Non-foldable devices report an empty list.',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF6A1B9A),
                        ),
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

// ─── DATA CLASS ─────────────────────────────────────────────────────────────

class _StateInfo {
  final ui.DisplayFeatureState state;
  final String label;
  final String description;
  final IconData icon;
  final Color color;
  final int angle;
  final String scenario;

  _StateInfo({
    required this.state,
    required this.label,
    required this.description,
    required this.icon,
    required this.color,
    required this.angle,
    required this.scenario,
  });
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

Widget _stateCard(_StateInfo info) {
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
          width: 48,
          height: 48,
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
                  Text(
                    info.label,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: info.color.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'idx ${info.state.index}',
                      style: TextStyle(fontSize: 9, color: info.color),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2),
              Text(
                info.description,
                style: TextStyle(fontSize: 11, color: Colors.grey[600]),
              ),
              SizedBox(height: 4),
              Text(
                'Scenario: ${info.scenario}',
                style: TextStyle(
                  fontSize: 10,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _devicePosture(String label, int angle, Color color) {
  return Column(
    children: [
      Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Left panel
            Positioned(
              left: 8,
              top: 12,
              child: Container(
                width: 22,
                height: 46,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            // Right panel
            Positioned(
              right: 8,
              top: angle == 180 ? 12.0 : 18.0,
              child: Container(
                width: 22,
                height: 46,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
            // Hinge line
            Positioned(
              left: 33,
              top: 8,
              bottom: 8,
              child: Container(
                width: 4,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 6),
      Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: color,
        ),
      ),
      Text('$angle°', style: TextStyle(fontSize: 10, color: Colors.grey)),
    ],
  );
}

Widget _transitionRow(
  String from,
  String to,
  String trigger,
  Color fromColor,
  Color toColor,
) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: fromColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: fromColor.withValues(alpha: 0.3)),
        ),
        child: Text(
          from,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: fromColor,
          ),
        ),
      ),
      SizedBox(width: 6),
      Expanded(
        child: Column(
          children: [
            Icon(Icons.arrow_forward, color: Colors.grey, size: 14),
            Text(
              trigger,
              style: TextStyle(fontSize: 9, color: Colors.grey[500]),
            ),
          ],
        ),
      ),
      SizedBox(width: 6),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: toColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: toColor.withValues(alpha: 0.3)),
        ),
        child: Text(
          to,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: toColor,
          ),
        ),
      ),
    ],
  );
}

Widget _angleBar(String name, String angleLabel, double fraction, Color color) {
  return Row(
    children: [
      SizedBox(
        width: 110,
        child: Text(
          name,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
      Expanded(
        child: Container(
          height: 16,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: FractionallySizedBox(
            widthFactor: fraction,
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ),
      SizedBox(width: 8),
      Text(
        angleLabel,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: color,
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
        Expanded(
          child: Text(
            expression,
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

Widget _useCaseRow(IconData icon, String title, String desc, Color color) {
  return Row(
    children: [
      Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            Text(desc, style: TextStyle(fontSize: 11, color: Colors.grey[600])),
          ],
        ),
      ),
    ],
  );
}

Widget _deviceRow(String name, String desc, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
