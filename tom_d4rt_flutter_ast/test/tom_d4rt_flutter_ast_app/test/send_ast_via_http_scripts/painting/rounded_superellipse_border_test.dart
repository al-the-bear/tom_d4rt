// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RoundedSuperellipseBorder from painting
// Deep Demo: Visual demonstration of the iOS-style squircle outline,
// comparing with RoundedRectangleBorder and ContinuousRectangleBorder,
// across radii, sides, per-corner variants, real-world mocks and lerps.
import 'package:flutter/material.dart';

// iOS-inspired palette constants used across the demo.
const Color _iosBlue = Color(0xFF007AFF);
const Color _iosOrange = Color(0xFFFF9500);
const Color _iosGray = Color(0xFF8E8E93);
const Color _iosGray2 = Color(0xFFAEAEB2);
const Color _iosGray5 = Color(0xFFE5E5EA);
const Color _iosGray6 = Color(0xFFF2F2F7);
const Color _iosLabel = Color(0xFF1C1C1E);
const Color _iosSecondary = Color(0xFF3C3C43);
const Color _iosGreen = Color(0xFF34C759);
const Color _iosRed = Color(0xFFFF3B30);
const Color _iosPurple = Color(0xFFAF52DE);
const Color _iosTeal = Color(0xFF5AC8FA);

dynamic build(BuildContext context) {
  print('RoundedSuperellipseBorder Deep Demo executing');

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_iosBlue, _iosPurple, _iosOrange],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(28.0),
      boxShadow: [
        BoxShadow(
          color: _iosBlue.withValues(alpha: 0.35),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: _iosPurple.withValues(alpha: 0.25),
          blurRadius: 32.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 96.0,
          height: 96.0,
          decoration: ShapeDecoration(
            shape: RoundedSuperellipseBorder(
              side: BorderSide(color: Colors.white, width: 2.5),
              borderRadius: BorderRadius.circular(28.0),
            ),
            gradient: LinearGradient(
              colors: [Colors.white, _iosGray5],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.rounded_corner,
              size: 56.0,
              color: _iosBlue,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          'RoundedSuperellipseBorder',
          style: TextStyle(
            fontSize: 26.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 0.4,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'iOS-style continuous-corner squircle',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.85),
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.45),
              width: 1.0,
            ),
          ),
          child: Text(
            'extends OutlinedBorder',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created title banner');

  // ============================================================
  // SECTION 2: Anatomy diagram
  // ============================================================
  print('=== Section 2: Anatomy diagram ===');

  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_iosGray6, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _iosGray5, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: _iosBlue.withValues(alpha: 0.06),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Anatomy', _iosBlue, Icons.architecture),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 220.0,
              height: 220.0,
              decoration: ShapeDecoration(
                shape: RoundedSuperellipseBorder(
                  side: BorderSide(color: _iosBlue, width: 4.0),
                  borderRadius: BorderRadius.circular(56.0),
                ),
                gradient: LinearGradient(
                  colors: [
                    _iosBlue.withValues(alpha: 0.10),
                    _iosBlue.withValues(alpha: 0.22),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 8.0,
                    left: 8.0,
                    child: _annotation('borderRadius: 56', _iosBlue),
                  ),
                  Positioned(
                    bottom: 8.0,
                    right: 8.0,
                    child: _annotation('side.width: 4', _iosOrange),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.0,
                        vertical: 8.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.10),
                            blurRadius: 8.0,
                            offset: Offset(0.0, 2.0),
                          ),
                        ],
                      ),
                      child: Text(
                        'squircle',
                        style: TextStyle(
                          color: _iosBlue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(child: _legendChip('side', _iosOrange, 'BorderSide')),
            SizedBox(width: 8.0),
            Expanded(
              child: _legendChip('borderRadius', _iosBlue, 'BorderRadius'),
            ),
          ],
        ),
      ],
    ),
  );
  print('Created anatomy diagram');

  // ============================================================
  // SECTION 3: Six borderRadius size cards
  // ============================================================
  print('=== Section 3: Radius size cards ===');

  final radiusValues = <double>[8.0, 16.0, 24.0, 32.0, 48.0, 64.0];
  final radiusCards = <Widget>[];
  for (final r in radiusValues) {
    print('Radius card: $r');
    radiusCards.add(_radiusCard(r));
  }
  print('Created ${radiusCards.length} radius cards');

  final radiusSection = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, _iosGray6],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _iosGray5, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: _iosOrange.withValues(alpha: 0.05),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Radius progression', _iosOrange, Icons.straighten),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12.0,
          runSpacing: 12.0,
          children: radiusCards,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Comparison vs RoundedRectangleBorder
  // ============================================================
  print('=== Section 4: vs RoundedRectangleBorder ===');

  final vsRoundedRect = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_iosBlue.withValues(alpha: 0.08), Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _iosBlue.withValues(alpha: 0.30), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: _iosBlue.withValues(alpha: 0.10),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('vs RoundedRectangleBorder', _iosBlue, Icons.compare),
        SizedBox(height: 6.0),
        Text(
          'Same radius (32). Notice the gentler curvature transition on the squircle.',
          style: TextStyle(fontSize: 12.0, color: _iosSecondary),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _shapeComparisonTile(
              'RoundedRectangle',
              RoundedRectangleBorder(
                side: BorderSide(color: _iosBlue, width: 3.0),
                borderRadius: BorderRadius.circular(32.0),
              ),
              _iosBlue,
              'circular arcs',
            ),
            _shapeComparisonTile(
              'Superellipse',
              RoundedSuperellipseBorder(
                side: BorderSide(color: _iosOrange, width: 3.0),
                borderRadius: BorderRadius.circular(32.0),
              ),
              _iosOrange,
              'continuous curve',
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: _iosGray6,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: _iosOrange, size: 18.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Squircle removes the tangent discontinuity where straight edges meet the corner arcs.',
                  style: TextStyle(fontSize: 11.5, color: _iosSecondary),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
  print('Created RoundedRectangleBorder comparison');

  // ============================================================
  // SECTION 5: Comparison vs ContinuousRectangleBorder
  // ============================================================
  print('=== Section 5: vs ContinuousRectangleBorder ===');

  final continuousSizes = <double>[80.0, 130.0, 180.0];
  final continuousRows = <Widget>[];
  for (final size in continuousSizes) {
    print('Continuous comparison size: $size');
    continuousRows.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  width: size,
                  height: size,
                  decoration: ShapeDecoration(
                    shape: ContinuousRectangleBorder(
                      side: BorderSide(color: _iosTeal, width: 2.5),
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        _iosTeal.withValues(alpha: 0.10),
                        _iosTeal.withValues(alpha: 0.25),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  'Continuous',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: _iosTeal,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  width: size,
                  height: size,
                  decoration: ShapeDecoration(
                    shape: RoundedSuperellipseBorder(
                      side: BorderSide(color: _iosOrange, width: 2.5),
                      borderRadius: BorderRadius.circular(32.0),
                    ),
                    gradient: LinearGradient(
                      colors: [
                        _iosOrange.withValues(alpha: 0.10),
                        _iosOrange.withValues(alpha: 0.25),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  'Superellipse',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: _iosOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final vsContinuous = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_iosTeal.withValues(alpha: 0.06), Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _iosTeal.withValues(alpha: 0.35), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: _iosTeal.withValues(alpha: 0.12),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel(
          'vs ContinuousRectangleBorder',
          _iosTeal,
          Icons.compare_arrows,
        ),
        SizedBox(height: 6.0),
        Text(
          'Both are squircle-like; the superellipse keeps a stronger flat midline at large sizes.',
          style: TextStyle(fontSize: 12.0, color: _iosSecondary),
        ),
        SizedBox(height: 12.0),
        ...continuousRows,
      ],
    ),
  );
  print('Created ContinuousRectangleBorder comparison');

  // ============================================================
  // SECTION 6: Five BorderSide width cards
  // ============================================================
  print('=== Section 6: BorderSide widths ===');

  final widthValues = <double>[0.5, 1.0, 2.0, 4.0, 8.0];
  final widthCards = <Widget>[];
  for (final w in widthValues) {
    print('Side width card: $w');
    widthCards.add(_widthCard(w));
  }

  final widthSection = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, _iosGray6],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _iosGray5, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: _iosGreen.withValues(alpha: 0.06),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('BorderSide widths', _iosGreen, Icons.line_weight),
        SizedBox(height: 6.0),
        Text(
          'Fixed radius 28; only side.width varies.',
          style: TextStyle(fontSize: 12.0, color: _iosSecondary),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12.0,
          runSpacing: 12.0,
          children: widthCards,
        ),
      ],
    ),
  );
  print('Created ${widthCards.length} width cards');

  // ============================================================
  // SECTION 7: Per-corner BorderRadius variants
  // ============================================================
  print('=== Section 7: Per-corner variants ===');

  final cornerVariants = <Map<String, dynamic>>[
    {
      'label': 'only top-left',
      'radius': BorderRadius.only(topLeft: Radius.circular(40.0)),
    },
    {
      'label': 'only top',
      'radius': BorderRadius.vertical(top: Radius.circular(36.0)),
    },
    {
      'label': 'only diagonal',
      'radius': BorderRadius.only(
        topLeft: Radius.circular(36.0),
        bottomRight: Radius.circular(36.0),
      ),
    },
    {
      'label': 'only bottom-right',
      'radius': BorderRadius.only(bottomRight: Radius.circular(40.0)),
    },
    {
      'label': 'asymmetric',
      'radius': BorderRadius.only(
        topLeft: Radius.circular(8.0),
        topRight: Radius.circular(40.0),
        bottomLeft: Radius.circular(28.0),
        bottomRight: Radius.circular(16.0),
      ),
    },
  ];

  final cornerCards = <Widget>[];
  for (final v in cornerVariants) {
    final label = v['label'] as String;
    final radius = v['radius'] as BorderRadiusGeometry;
    print('Corner variant: $label');
    cornerCards.add(_cornerCard(label, radius));
  }

  final cornerSection = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_iosPurple.withValues(alpha: 0.06), Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(
        color: _iosPurple.withValues(alpha: 0.30),
        width: 1.0,
      ),
      boxShadow: [
        BoxShadow(
          color: _iosPurple.withValues(alpha: 0.10),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Per-corner variants', _iosPurple, Icons.crop_square),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12.0,
          runSpacing: 12.0,
          children: cornerCards,
        ),
      ],
    ),
  );
  print('Created ${cornerCards.length} corner-variant cards');

  // ============================================================
  // SECTION 8: Real-world mocks
  // ============================================================
  print('=== Section 8: Real-world mocks ===');

  // 8a — iOS app icon
  final appIcon = Container(
    width: 120.0,
    height: 120.0,
    decoration: ShapeDecoration(
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(28.0)),
      gradient: LinearGradient(
        colors: [_iosBlue, _iosPurple],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shadows: [
        BoxShadow(
          color: _iosBlue.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Center(
      child: Icon(Icons.cloud, color: Colors.white, size: 56.0),
    ),
  );

  // 8b — Settings card
  final settingsCard = Container(
    decoration: ShapeDecoration(
      shape: RoundedSuperellipseBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(color: _iosGray5, width: 1.0),
      ),
      color: Colors.white,
      shadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.06),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        _settingsRow(Icons.wifi, 'Wi-Fi', 'TomNet', _iosBlue),
        Divider(height: 1.0, color: _iosGray5),
        _settingsRow(Icons.bluetooth, 'Bluetooth', 'On', _iosBlue),
        Divider(height: 1.0, color: _iosGray5),
        _settingsRow(
          Icons.notifications,
          'Notifications',
          '3 apps muted',
          _iosOrange,
        ),
      ],
    ),
  );

  // 8c — Alert dialog frame
  final alertDialog = Container(
    width: 280.0,
    decoration: ShapeDecoration(
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Colors.white,
      shadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.20),
          blurRadius: 30.0,
          offset: Offset(0.0, 14.0),
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Icon(Icons.info_outline, size: 36.0, color: _iosBlue),
          SizedBox(height: 10.0),
          Text(
            'Confirm action',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              color: _iosLabel,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'This dialog uses a squircle frame for a more iOS-native feel.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: _iosSecondary),
          ),
          SizedBox(height: 14.0),
          Row(
            children: [
              Expanded(
                child: Material(
                  shape: RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: _iosGray6,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: _iosLabel,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Material(
                  shape: RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  color: _iosBlue,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Center(
                      child: Text(
                        'Confirm',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  // 8d — Switch container
  final switchContainer = Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: ShapeDecoration(
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(16.0)),
      color: Colors.white,
      shadows: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(Icons.dark_mode, color: _iosPurple, size: 22.0),
        SizedBox(width: 12.0),
        Expanded(
          child: Text(
            'Dark mode',
            style: TextStyle(fontSize: 14.0, color: _iosLabel),
          ),
        ),
        Container(
          width: 50.0,
          height: 30.0,
          decoration: ShapeDecoration(
            shape: RoundedSuperellipseBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: _iosGreen,
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(2.0),
              child: Container(
                width: 26.0,
                height: 26.0,
                decoration: ShapeDecoration(
                  shape: RoundedSuperellipseBorder(
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                  color: Colors.white,
                  shadows: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.18),
                      blurRadius: 3.0,
                      offset: Offset(0.0, 1.0),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // 8e — Action button
  final actionButton = Container(
    decoration: ShapeDecoration(
      shape: RoundedSuperellipseBorder(borderRadius: BorderRadius.circular(14.0)),
      gradient: LinearGradient(
        colors: [_iosOrange, _iosRed],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shadows: [
        BoxShadow(
          color: _iosOrange.withValues(alpha: 0.45),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.bolt, color: Colors.white, size: 18.0),
          SizedBox(width: 8.0),
          Text(
            'Take action',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
        ],
      ),
    ),
  );

  final mocksSection = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_iosGray6, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _iosGray5, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Real-world mocks', _iosLabel, Icons.phone_iphone),
        SizedBox(height: 16.0),
        Center(child: appIcon),
        SizedBox(height: 6.0),
        Center(
          child: Text(
            'iOS-style app icon',
            style: TextStyle(fontSize: 11.0, color: _iosSecondary),
          ),
        ),
        SizedBox(height: 24.0),
        settingsCard,
        SizedBox(height: 6.0),
        Center(
          child: Text(
            'Settings card',
            style: TextStyle(fontSize: 11.0, color: _iosSecondary),
          ),
        ),
        SizedBox(height: 24.0),
        Center(child: alertDialog),
        SizedBox(height: 6.0),
        Center(
          child: Text(
            'Alert dialog frame',
            style: TextStyle(fontSize: 11.0, color: _iosSecondary),
          ),
        ),
        SizedBox(height: 24.0),
        switchContainer,
        SizedBox(height: 6.0),
        Center(
          child: Text(
            'Switch container',
            style: TextStyle(fontSize: 11.0, color: _iosSecondary),
          ),
        ),
        SizedBox(height: 24.0),
        Center(child: actionButton),
        SizedBox(height: 6.0),
        Center(
          child: Text(
            'Action button',
            style: TextStyle(fontSize: 11.0, color: _iosSecondary),
          ),
        ),
      ],
    ),
  );
  print('Created real-world mocks');

  // ============================================================
  // SECTION 9: Lerp showcases
  // ============================================================
  print('=== Section 9: Lerp showcases ===');

  // 9a — RoundedRect → Squircle
  final lerpA = _lerpRow(
    'RoundedRect → Squircle',
    RoundedRectangleBorder(
      side: BorderSide(color: _iosBlue, width: 2.5),
      borderRadius: BorderRadius.circular(8.0),
    ),
    RoundedSuperellipseBorder(
      side: BorderSide(color: _iosOrange, width: 2.5),
      borderRadius: BorderRadius.circular(40.0),
    ),
    _iosBlue,
    _iosOrange,
  );

  // 9b — Squircle → Squircle (different radii)
  final lerpB = _lerpRow(
    'Squircle → Squircle',
    RoundedSuperellipseBorder(
      side: BorderSide(color: _iosGreen, width: 2.5),
      borderRadius: BorderRadius.circular(8.0),
    ),
    RoundedSuperellipseBorder(
      side: BorderSide(color: _iosOrange, width: 2.5),
      borderRadius: BorderRadius.circular(56.0),
    ),
    _iosGreen,
    _iosOrange,
  );

  // 9c — Squircle → ContinuousRect
  final lerpC = _lerpRow(
    'Squircle → ContinuousRect',
    RoundedSuperellipseBorder(
      side: BorderSide(color: _iosOrange, width: 2.5),
      borderRadius: BorderRadius.circular(32.0),
    ),
    ContinuousRectangleBorder(
      side: BorderSide(color: _iosTeal, width: 2.5),
      borderRadius: BorderRadius.circular(32.0),
    ),
    _iosOrange,
    _iosTeal,
  );

  final lerpSection = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_iosBlue.withValues(alpha: 0.05), Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _iosBlue.withValues(alpha: 0.20), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: _iosBlue.withValues(alpha: 0.08),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Lerp showcases', _iosBlue, Icons.timeline),
        SizedBox(height: 6.0),
        Text(
          'Each row shows endpoints (t=0, t=1) and the midpoint produced by ShapeBorder.lerp at t=0.5.',
          style: TextStyle(fontSize: 12.0, color: _iosSecondary),
        ),
        SizedBox(height: 14.0),
        lerpA,
        SizedBox(height: 18.0),
        lerpB,
        SizedBox(height: 18.0),
        lerpC,
      ],
    ),
  );
  print('Created lerp showcases');

  // ============================================================
  // SECTION 10: Footgun cards
  // ============================================================
  print('=== Section 10: Footgun cards ===');

  final footguns = <Map<String, dynamic>>[
    {
      'title': 'Radius capped at half',
      'body':
          'A radius larger than min(width, height)/2 is capped to that value — large radii on small boxes plateau.',
      'icon': Icons.crop_din,
      'color': _iosOrange,
    },
    {
      'title': 'side.width affects path',
      'body':
          'getInnerPath shrinks by the BorderSide width — thick sides noticeably reduce the inner area available for clipping/painting.',
      'icon': Icons.line_weight,
      'color': _iosBlue,
    },
    {
      'title': 'Lerp dissimilar shapes',
      'body':
          'Lerping between RoundedSuperellipseBorder and a non-matching ShapeBorder type falls back to a generic interpolation — corners may pop.',
      'icon': Icons.swap_horiz,
      'color': _iosPurple,
    },
    {
      'title': 'Tiny radius ≈ rounded rect',
      'body':
          'For very small radii the squircle is visually indistinguishable from a circular-arc rounded rectangle.',
      'icon': Icons.zoom_in,
      'color': _iosTeal,
    },
    {
      'title': 'Squircle ≠ ellipse',
      'body':
          'A superellipse is not an ellipse — its higher-order exponent keeps a flatter middle and tighter corner cluster.',
      'icon': Icons.warning_amber,
      'color': _iosRed,
    },
  ];

  final footgunCards = <Widget>[];
  for (final fg in footguns) {
    print('Footgun: ${fg['title']}');
    footgunCards.add(
      _footgunCard(
        fg['title'] as String,
        fg['body'] as String,
        fg['icon'] as IconData,
        fg['color'] as Color,
      ),
    );
  }

  final footgunSection = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_iosRed.withValues(alpha: 0.06), Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: _iosRed.withValues(alpha: 0.30), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: _iosRed.withValues(alpha: 0.10),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Footguns', _iosRed, Icons.report_gmailerrorred),
        SizedBox(height: 12.0),
        ...footgunCards,
      ],
    ),
  );
  print('Created ${footgunCards.length} footgun cards');

  // ============================================================
  // SECTION 11: Recap card
  // ============================================================
  print('=== Section 11: Recap ===');

  final recapCard = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(22.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_iosLabel, _iosSecondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 20.0,
          offset: Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: _iosOrange, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        _recapBullet(
          'OutlinedBorder',
          'Ships the iOS continuous-corner outline as a Flutter ShapeBorder.',
          _iosBlue,
        ),
        _recapBullet(
          'side',
          'BorderSide drawn around the squircle path; defaults to BorderSide.none.',
          _iosOrange,
        ),
        _recapBullet(
          'borderRadius',
          'BorderRadiusGeometry — supports symmetric, per-corner, and directional radii.',
          _iosGreen,
        ),
        _recapBullet(
          'copyWith / lerp*',
          'Compose new instances and animate between borders the standard ShapeBorder way.',
          _iosPurple,
        ),
        _recapBullet(
          'Use it for',
          'iOS-flavoured app icons, settings cards, sheets, dialogs, switches and CTAs.',
          _iosTeal,
        ),
      ],
    ),
  );
  print('Created recap card');

  print('RoundedSuperellipseBorder Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: _iosGray6,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 24.0),
          _sectionHeading('1. Anatomy'),
          anatomyDiagram,
          SizedBox(height: 20.0),
          _sectionHeading('2. Radius progression'),
          radiusSection,
          SizedBox(height: 20.0),
          _sectionHeading('3. vs RoundedRectangleBorder'),
          vsRoundedRect,
          SizedBox(height: 20.0),
          _sectionHeading('4. vs ContinuousRectangleBorder'),
          vsContinuous,
          SizedBox(height: 20.0),
          _sectionHeading('5. BorderSide widths'),
          widthSection,
          SizedBox(height: 20.0),
          _sectionHeading('6. Per-corner BorderRadius'),
          cornerSection,
          SizedBox(height: 20.0),
          _sectionHeading('7. Real-world mocks'),
          mocksSection,
          SizedBox(height: 20.0),
          _sectionHeading('8. Lerp showcases'),
          lerpSection,
          SizedBox(height: 20.0),
          _sectionHeading('9. Footguns'),
          footgunSection,
          SizedBox(height: 20.0),
          _sectionHeading('10. Recap'),
          recapCard,
          SizedBox(height: 32.0),
        ],
      ),
    ),
  );
}

// ============================================================
// Helpers
// ============================================================

// Section heading text used between cards.
Widget _sectionHeading(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 4.0),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: _iosLabel,
        letterSpacing: 0.2,
      ),
    ),
  );
}

// Inline section label with colored icon.
Widget _sectionLabel(String text, Color color, IconData icon) {
  return Row(
    children: [
      Container(
        padding: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(icon, size: 18.0, color: color),
      ),
      SizedBox(width: 10.0),
      Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
        ),
      ),
    ],
  );
}

// Annotation chip used inside the anatomy diagram.
Widget _annotation(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withValues(alpha: 0.6), width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

// Legend chip with type info.
Widget _legendChip(String name, Color color, String typeText) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.45), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8.0),
        Text(
          name,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 11.0,
          ),
        ),
        SizedBox(width: 6.0),
        Text(
          typeText,
          style: TextStyle(
            color: _iosSecondary,
            fontFamily: 'monospace',
            fontSize: 10.0,
          ),
        ),
      ],
    ),
  );
}

// Single radius card showing one borderRadius value.
Widget _radiusCard(double radius) {
  return Container(
    width: 130.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _iosGray5, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: _iosBlue.withValues(alpha: 0.06),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 100.0,
          height: 100.0,
          decoration: ShapeDecoration(
            shape: RoundedSuperellipseBorder(
              side: BorderSide(color: _iosOrange, width: 2.0),
              borderRadius: BorderRadius.circular(radius),
            ),
            gradient: LinearGradient(
              colors: [
                _iosOrange.withValues(alpha: 0.10),
                _iosOrange.withValues(alpha: 0.25),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'radius: ${radius.toInt()}',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: _iosLabel,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

// One-shape comparison tile used in the rounded-rect comparison row.
Widget _shapeComparisonTile(
  String title,
  ShapeBorder shape,
  Color color,
  String tagText,
) {
  return Column(
    children: [
      Container(
        width: 150.0,
        height: 150.0,
        decoration: ShapeDecoration(
          shape: shape,
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.12),
              color.withValues(alpha: 0.28),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shadows: [
            BoxShadow(
              color: color.withValues(alpha: 0.20),
              blurRadius: 12.0,
              offset: Offset(0.0, 6.0),
            ),
          ],
        ),
      ),
      SizedBox(height: 8.0),
      Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      ),
      SizedBox(height: 4.0),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Text(
          tagText,
          style: TextStyle(
            color: color,
            fontFamily: 'monospace',
            fontSize: 10.0,
          ),
        ),
      ),
    ],
  );
}

// Card showing a fixed shape with one BorderSide width.
Widget _widthCard(double width) {
  return Container(
    width: 120.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _iosGray5, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: _iosGreen.withValues(alpha: 0.06),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 90.0,
          height: 90.0,
          decoration: ShapeDecoration(
            shape: RoundedSuperellipseBorder(
              side: BorderSide(color: _iosGreen, width: width),
              borderRadius: BorderRadius.circular(28.0),
            ),
            color: _iosGreen.withValues(alpha: 0.10),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'width: $width',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: _iosLabel,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

// Per-corner variant card.
Widget _cornerCard(String label, BorderRadiusGeometry radius) {
  return Container(
    width: 150.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _iosGray5, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: _iosPurple.withValues(alpha: 0.06),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 110.0,
          height: 110.0,
          decoration: ShapeDecoration(
            shape: RoundedSuperellipseBorder(
              side: BorderSide(color: _iosPurple, width: 2.0),
              borderRadius: radius,
            ),
            gradient: LinearGradient(
              colors: [
                _iosPurple.withValues(alpha: 0.12),
                _iosPurple.withValues(alpha: 0.28),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.5,
            color: _iosPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

// Settings row used inside the settings card mock.
Widget _settingsRow(IconData icon, String label, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
    child: Row(
      children: [
        Container(
          width: 28.0,
          height: 28.0,
          decoration: ShapeDecoration(
            shape: RoundedSuperellipseBorder(
              borderRadius: BorderRadius.circular(7.0),
            ),
            color: color.withValues(alpha: 0.18),
          ),
          child: Center(child: Icon(icon, size: 16.0, color: color)),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Text(
            label,
            style: TextStyle(fontSize: 14.0, color: _iosLabel),
          ),
        ),
        Text(
          value,
          style: TextStyle(fontSize: 13.0, color: _iosGray),
        ),
        SizedBox(width: 4.0),
        Icon(Icons.chevron_right, color: _iosGray2, size: 18.0),
      ],
    ),
  );
}

// Single lerp row: t=0, t=0.5, t=1.
Widget _lerpRow(
  String title,
  ShapeBorder a,
  ShapeBorder b,
  Color colorA,
  Color colorB,
) {
  // Compute the midpoint shape; fall back to either endpoint if lerp returns
  // null (which can happen for some dissimilar shape pairs).
  final ShapeBorder mid = ShapeBorder.lerp(a, b, 0.5) ?? a;
  return Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: _iosGray5, width: 1.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.bold,
            color: _iosLabel,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _lerpTile('t = 0.0', a, colorA),
            _lerpTile('t = 0.5', mid, _iosPurple),
            _lerpTile('t = 1.0', b, colorB),
          ],
        ),
      ],
    ),
  );
}

// Tile used inside a lerp row.
Widget _lerpTile(String label, ShapeBorder shape, Color color) {
  return Column(
    children: [
      Container(
        width: 90.0,
        height: 90.0,
        decoration: ShapeDecoration(
          shape: shape,
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.12),
              color.withValues(alpha: 0.28),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shadows: [
            BoxShadow(
              color: color.withValues(alpha: 0.18),
              blurRadius: 10.0,
              offset: Offset(0.0, 5.0),
            ),
          ],
        ),
      ),
      SizedBox(height: 6.0),
      Text(
        label,
        style: TextStyle(
          color: color,
          fontFamily: 'monospace',
          fontSize: 11.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

// Footgun card describing a pitfall.
Widget _footgunCard(String title, String body, IconData icon, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: color.withValues(alpha: 0.40), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.10),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          decoration: ShapeDecoration(
            shape: RoundedSuperellipseBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            color: color.withValues(alpha: 0.18),
          ),
          child: Center(child: Icon(icon, color: color, size: 20.0)),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: _iosSecondary,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Single recap bullet with a small color swatch.
Widget _recapBullet(String label, String body, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 10.0,
          height: 10.0,
          margin: EdgeInsets.only(top: 6.0),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 12.5, color: Colors.white, height: 1.4),
              children: [
                TextSpan(
                  text: '$label — ',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
                TextSpan(text: body),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
