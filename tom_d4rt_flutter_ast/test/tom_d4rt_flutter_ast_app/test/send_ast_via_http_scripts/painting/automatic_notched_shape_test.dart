// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AutomaticNotchedShape Deep Demo executing');

  // ============================================================
  // SECTION 1: Title Banner
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final titleBanner = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF1E293B),
          Color(0xFF334155),
          Color(0xFF0F766E),
        ],
        stops: [0.0, 0.55, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF0F766E).withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: Color(0xFF1E293B).withValues(alpha: 0.55),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Color(0xFFFBBF24).withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Color(0xFFFBBF24).withValues(alpha: 0.7),
                  width: 1.5,
                ),
              ),
              child: Icon(
                Icons.architecture,
                color: Color(0xFFFBBF24),
                size: 32.0,
              ),
            ),
            SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AutomaticNotchedShape',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/painting.dart',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF99F6E4),
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.18),
              width: 1.0,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.crop_square,
                color: Color(0xFFFBBF24),
                size: 18.0,
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Notched outline derived from a guest\'s bounding rectangle',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          children: [
            _chip('implements NotchedShape', Color(0xFF14B8A6)),
            SizedBox(width: 8.0),
            _chip('axis-aligned', Color(0xFFFBBF24)),
            SizedBox(width: 8.0),
            _chip('host - guest.bounds', Color(0xFF818CF8)),
          ],
        ),
      ],
    ),
  );
  print('Title banner built');

  // ============================================================
  // SECTION 2: Anatomy Diagram
  // ============================================================
  print('=== Section 2: Anatomy Diagram ===');

  final anatomyDiagram = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFF8FAFC),
          Color(0xFFE2E8F0),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFCBD5E1), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF1E293B).withValues(alpha: 0.08),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anatomy: host vs. guest',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          height: 220.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Stack(
            children: [
              // Host rectangle (the bar)
              Positioned(
                left: 20.0,
                right: 20.0,
                top: 110.0,
                bottom: 30.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFF14B8A6).withValues(alpha: 0.18),
                    border: Border.all(
                      color: Color(0xFF0F766E),
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      'HOST  (Rect)',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F766E),
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
              ),
              // Guest bounding rectangle (dashed-look)
              Positioned(
                left: 130.0,
                top: 60.0,
                width: 80.0,
                height: 80.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFBBF24).withValues(alpha: 0.22),
                    border: Border.all(
                      color: Color(0xFFB45309),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Center(
                    child: Text(
                      'GUEST\nbounds',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFB45309),
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ),
              ),
              // The actual guest shape inside the bounds
              Positioned(
                left: 145.0,
                top: 75.0,
                width: 50.0,
                height: 50.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFBBF24),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFB45309).withValues(alpha: 0.4),
                        blurRadius: 6.0,
                        offset: Offset(0.0, 2.0),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'FAB',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              // Annotation arrows (text labels)
              Positioned(
                left: 230.0,
                top: 70.0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFB45309),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    'guest.bounds is what carves the notch',
                    style: TextStyle(
                      fontSize: 9.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 30.0,
                top: 178.0,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFF0F766E),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    'host outline minus guest.bounds',
                    style: TextStyle(
                      fontSize: 9.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'AutomaticNotchedShape uses the guest\'s axis-aligned bounding '
          'rectangle, not its actual outline. A circle, star, or hexagon '
          'all produce the same rectangular notch when their bounds match.',
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFF475569),
            height: 1.4,
          ),
        ),
      ],
    ),
  );
  print('Anatomy diagram built');

  // ============================================================
  // SECTION 3: Live BottomAppBar mock with FAB notch (3 hosts)
  // ============================================================
  print('=== Section 3: Live BottomAppBar mock ===');

  final hostVariantsLive = <Map<String, dynamic>>[
    {
      'name': 'RoundedRectangleBorder(8)',
      'shape': RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      'color': Color(0xFF0F766E),
    },
    {
      'name': 'StadiumBorder',
      'shape': StadiumBorder(),
      'color': Color(0xFFB45309),
    },
    {
      'name': 'BeveledRectangleBorder(12)',
      'shape': BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      'color': Color(0xFF6366F1),
    },
  ];

  final liveMocks = <Widget>[];
  for (var i = 0; i < hostVariantsLive.length; i++) {
    final v = hostVariantsLive[i];
    final hostShape = v['shape'] as ShapeBorder;
    final color = v['color'] as Color;
    final notched = AutomaticNotchedShape(hostShape, CircleBorder());
    print('Live mock ${v['name']} -> ${notched.runtimeType}');

    liveMocks.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.06),
              color.withValues(alpha: 0.18),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(
            color: color.withValues(alpha: 0.6),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.18),
              blurRadius: 10.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.bolt, color: color, size: 16.0),
                SizedBox(width: 6.0),
                Text(
                  v['name'] as String,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 60.0,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: _NotchedBarPainter(
                      shape: notched,
                      fill: color,
                      guestRadius: 28.0,
                    ),
                  ),
                ),
                Positioned(
                  top: -22.0,
                  child: Container(
                    width: 56.0,
                    height: 56.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFFBBF24),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFB45309).withValues(alpha: 0.5),
                          blurRadius: 10.0,
                          offset: Offset(0.0, 4.0),
                        ),
                      ],
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: 28.0),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  print('Built ${liveMocks.length} live mocks');

  // ============================================================
  // SECTION 4: Four host-shape variants (same guest = CircleBorder)
  // ============================================================
  print('=== Section 4: Four host-shape variants ===');

  final hostVariants4 = <Map<String, dynamic>>[
    {
      'name': 'RoundedRectangleBorder',
      'shape': RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      'desc': 'right-angled corners with optional rounding',
      'color': Color(0xFF0F766E),
    },
    {
      'name': 'StadiumBorder',
      'shape': StadiumBorder(),
      'desc': 'fully-rounded ends, like a pill / stadium',
      'color': Color(0xFFB45309),
    },
    {
      'name': 'BeveledRectangleBorder',
      'shape': BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      'desc': 'flat-cut corners; angular, faceted look',
      'color': Color(0xFF6366F1),
    },
    {
      'name': 'ContinuousRectangleBorder',
      'shape': ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      'desc': 'iOS-style superellipse, smoother than circular',
      'color': Color(0xFF0EA5E9),
    },
  ];

  final hostVariantCards = <Widget>[];
  for (var i = 0; i < hostVariants4.length; i++) {
    final v = hostVariants4[i];
    final shape = v['shape'] as ShapeBorder;
    final color = v['color'] as Color;
    final notched = AutomaticNotchedShape(shape, CircleBorder());
    print('Host variant ${v['name']} -> notched ${notched.runtimeType}');

    hostVariantCards.add(
      Container(
        width: 300.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              color.withValues(alpha: 0.08),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color.withValues(alpha: 0.5), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.15),
              blurRadius: 8.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                '${i + 1}. ${v['name']}',
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 56.0,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: _NotchedBarPainter(
                      shape: notched,
                      fill: color,
                      guestRadius: 26.0,
                    ),
                  ),
                ),
                Positioned(
                  top: -20.0,
                  child: Container(
                    width: 52.0,
                    height: 52.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFFBBF24),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: color.withValues(alpha: 0.4),
                          blurRadius: 8.0,
                          offset: Offset(0.0, 3.0),
                        ),
                      ],
                    ),
                    child: Icon(Icons.add, color: Colors.white, size: 24.0),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              v['desc'] as String,
              style: TextStyle(
                fontSize: 11.0,
                color: Color(0xFF475569),
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Built ${hostVariantCards.length} host variant cards');

  // ============================================================
  // SECTION 5: Guest position cards (left, center, right)
  // ============================================================
  print('=== Section 5: Guest position cards ===');

  final positions = <Map<String, dynamic>>[
    {
      'name': 'LEFT',
      'alignment': 0.12,
      'color': Color(0xFF0F766E),
      'desc': 'guest near left edge of host',
    },
    {
      'name': 'CENTER',
      'alignment': 0.5,
      'color': Color(0xFFB45309),
      'desc': 'guest centered (Material standard)',
    },
    {
      'name': 'RIGHT',
      'alignment': 0.88,
      'color': Color(0xFF6366F1),
      'desc': 'guest near right edge of host',
    },
  ];

  final positionCards = <Widget>[];
  for (var i = 0; i < positions.length; i++) {
    final p = positions[i];
    final color = p['color'] as Color;
    final notched = AutomaticNotchedShape(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      CircleBorder(),
    );
    print('Position ${p['name']} created notched ${notched.runtimeType}');

    positionCards.add(
      Container(
        width: 300.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.05),
              color.withValues(alpha: 0.16),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color.withValues(alpha: 0.55), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.18),
              blurRadius: 8.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: color, size: 18.0),
                SizedBox(width: 6.0),
                Text(
                  'Guest position: ${p['name']}',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            SizedBox(
              height: 90.0,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    top: 32.0,
                    child: SizedBox(
                      height: 56.0,
                      child: CustomPaint(
                        painter: _NotchedBarPainter(
                          shape: notched,
                          fill: color,
                          guestRadius: 26.0,
                          guestCenterFraction: p['alignment'] as double,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(
                      (p['alignment'] as double) * 2.0 - 1.0,
                      -0.3,
                    ),
                    child: Container(
                      width: 52.0,
                      height: 52.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFFBBF24),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.4),
                            blurRadius: 6.0,
                            offset: Offset(0.0, 3.0),
                          ),
                        ],
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 24.0),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              p['desc'] as String,
              style: TextStyle(
                fontSize: 11.0,
                color: Color(0xFF475569),
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Built ${positionCards.length} position cards');

  // ============================================================
  // SECTION 6: Guest size cards (40, 56, 72)
  // ============================================================
  print('=== Section 6: Guest size cards ===');

  final sizes = <Map<String, dynamic>>[
    {
      'name': 'SMALL',
      'size': 40.0,
      'color': Color(0xFF0F766E),
      'note': 'compact notch, minimal disturbance',
    },
    {
      'name': 'MEDIUM',
      'size': 56.0,
      'color': Color(0xFFB45309),
      'note': 'standard FAB diameter (Material 3)',
    },
    {
      'name': 'LARGE',
      'size': 72.0,
      'color': Color(0xFF6366F1),
      'note': 'oversized FAB, dominant notch',
    },
  ];

  final sizeCards = <Widget>[];
  for (var i = 0; i < sizes.length; i++) {
    final s = sizes[i];
    final color = s['color'] as Color;
    final size = s['size'] as double;
    final notched = AutomaticNotchedShape(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      CircleBorder(),
    );
    print(
      'Size ${s['name']} = ${size.toStringAsFixed(0)}px -> ${notched.runtimeType}',
    );

    sizeCards.add(
      Container(
        width: 300.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              color.withValues(alpha: 0.10),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14.0),
          border: Border.all(color: color.withValues(alpha: 0.55), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.18),
              blurRadius: 8.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.aspect_ratio, color: color, size: 18.0),
                SizedBox(width: 6.0),
                Text(
                  '${s['name']}  (${size.toStringAsFixed(0)}x${size.toStringAsFixed(0)})',
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            SizedBox(
              height: size * 0.6 + 60.0,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    bottom: 0.0,
                    child: SizedBox(
                      height: 60.0,
                      child: CustomPaint(
                        painter: _NotchedBarPainter(
                          shape: notched,
                          fill: color,
                          guestRadius: size * 0.5,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 60.0 - size * 0.5,
                    child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        color: Color(0xFFFBBF24),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: color.withValues(alpha: 0.4),
                            blurRadius: 8.0,
                            offset: Offset(0.0, 3.0),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: size * 0.45,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              s['note'] as String,
              style: TextStyle(
                fontSize: 11.0,
                color: Color(0xFF475569),
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Built ${sizeCards.length} size cards');

  // ============================================================
  // SECTION 7: AutomaticNotchedShape vs CircularNotchedRectangle
  // ============================================================
  print('=== Section 7: Comparison panel ===');

  final compareNotchedAuto = AutomaticNotchedShape(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    CircleBorder(),
  );
  final compareNotchedCircular = CircularNotchedRectangle();
  print('Compare: ${compareNotchedAuto.runtimeType} vs ${compareNotchedCircular.runtimeType}');

  final comparisonPanel = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFFFEF3C7),
          Color(0xFFFDE68A),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFFB45309), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFB45309).withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Automatic vs Circular',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF78350F),
          ),
        ),
        SizedBox(height: 12.0),
        // Comparison table
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            children: [
              _tableRow(
                'Aspect',
                'AutomaticNotchedShape',
                'CircularNotchedRectangle',
                isHeader: true,
              ),
              _tableRow(
                'Notch shape',
                'rectangular bounds',
                'curved circular arc',
              ),
              _tableRow(
                'Inputs',
                'host + guest shapes',
                'no inputs',
              ),
              _tableRow(
                'Best for',
                'non-circular FAB',
                'standard CircleBorder FAB',
              ),
              _tableRow(
                'Visual effect',
                'rect cut-out',
                'smooth curved cut-out',
              ),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        // Side-by-side mini-mocks
        Row(
          children: [
            Expanded(
              child: _miniMock(
                'Automatic',
                compareNotchedAuto,
                Color(0xFF0F766E),
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: _miniMock(
                'Circular',
                compareNotchedCircular,
                Color(0xFF6366F1),
              ),
            ),
          ],
        ),
      ],
    ),
  );
  print('Comparison panel built');

  // ============================================================
  // SECTION 8: Real-world Scaffold mock
  // ============================================================
  print('=== Section 8: Real-world Scaffold mock ===');

  final scaffoldNotch = AutomaticNotchedShape(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(18.0)),
    ),
    CircleBorder(),
  );
  print('Scaffold notch: ${scaffoldNotch.runtimeType}');

  final realWorldMock = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF1E293B).withValues(alpha: 0.18),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: SizedBox(
        height: 360.0,
        child: Stack(
          children: [
            // Mock body: gradient fill
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFE0F2FE),
                      Color(0xFFFEF3C7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            // Mock AppBar
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                height: 56.0,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF0F766E),
                      Color(0xFF14B8A6),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF0F766E).withValues(alpha: 0.3),
                      blurRadius: 6.0,
                      offset: Offset(0.0, 2.0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(Icons.menu, color: Colors.white, size: 22.0),
                    SizedBox(width: 14.0),
                    Text(
                      'Notched Scaffold',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.search, color: Colors.white, size: 20.0),
                    SizedBox(width: 12.0),
                    Icon(Icons.more_vert, color: Colors.white, size: 20.0),
                  ],
                ),
              ),
            ),
            // Mock body content
            Positioned(
              top: 76.0,
              left: 16.0,
              right: 16.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Color(0xFF0F766E),
                          size: 18.0,
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Text(
                            'Body content scrolls here. The bottom bar uses '
                            'AutomaticNotchedShape to host the FAB.',
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.0),
                  for (var i = 0; i < 3; i++)
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 4.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32.0,
                            height: 32.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFFBBF24).withValues(alpha: 0.4),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(
                                '${i + 1}',
                                style: TextStyle(
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFB45309),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            'List item ${i + 1}',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            // Mock BottomAppBar with notch
            Positioned(
              left: 0.0,
              right: 0.0,
              bottom: 0.0,
              child: SizedBox(
                height: 64.0,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CustomPaint(
                        painter: _NotchedBarPainter(
                          shape: scaffoldNotch,
                          fill: Color(0xFF0F172A),
                          guestRadius: 28.0,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 18.0),
                        Icon(Icons.home, color: Colors.white, size: 22.0),
                        SizedBox(width: 28.0),
                        Icon(
                          Icons.search,
                          color: Colors.white70,
                          size: 20.0,
                        ),
                        Spacer(),
                        Icon(
                          Icons.notifications_none,
                          color: Colors.white70,
                          size: 20.0,
                        ),
                        SizedBox(width: 22.0),
                        Icon(
                          Icons.account_circle,
                          color: Colors.white70,
                          size: 22.0,
                        ),
                        SizedBox(width: 18.0),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // FAB sitting in the notch
            Positioned(
              bottom: 36.0,
              left: 0.0,
              right: 0.0,
              child: Center(
                child: Container(
                  width: 56.0,
                  height: 56.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFFFBBF24),
                        Color(0xFFB45309),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFFB45309).withValues(alpha: 0.5),
                        blurRadius: 10.0,
                        offset: Offset(0.0, 4.0),
                      ),
                    ],
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 28.0),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  print('Real-world Scaffold mock built');

  // ============================================================
  // SECTION 9: Footgun cards
  // ============================================================
  print('=== Section 9: Footgun cards ===');

  final footguns = <Map<String, dynamic>>[
    {
      'title': 'Rect notch ignores guest curvature',
      'detail':
          'The notch is the guest\'s axis-aligned bounding rectangle. A '
              'circle, star, and hexagon with the same bounds yield the same '
              'rect notch. Use CircularNotchedRectangle for a curved notch.',
      'icon': Icons.crop_square,
    },
    {
      'title': 'Guest must intersect host',
      'detail':
          'If guest is entirely outside the host rect, you\'ll see the host '
              'outline unchanged. The notch only appears where guest.bounds '
              'crosses the host\'s top edge.',
      'icon': Icons.layers,
    },
    {
      'title': 'Null guest = plain host outline',
      'detail':
          'getOuterPath(host, null) returns just host.getOuterPath(host). '
              'Always pass a real Rect when you actually want a notch.',
      'icon': Icons.help_outline,
    },
    {
      'title': 'Tight notch can clip FAB shadow',
      'detail':
          'AutomaticNotchedShape gives a hard rectangle. The FAB\'s soft '
              'drop shadow may bleed past the notch edges. Add a small '
              'guestPadding or use Scaffold.floatingActionButtonLocation '
              'docked variants.',
      'icon': Icons.warning_amber,
    },
    {
      'title': 'Performance: rebuilding shape',
      'detail':
          'Constructing a new AutomaticNotchedShape on every build allocates '
              'fresh shape borders. Hoist it to a top-level final or store '
              'in a const-like cache when host/guest are static.',
      'icon': Icons.speed,
    },
  ];

  final footgunCards = <Widget>[];
  for (var i = 0; i < footguns.length; i++) {
    final f = footguns[i];
    footgunCards.add(
      Container(
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFEE2E2),
              Color(0xFFFECACA),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Color(0xFFDC2626), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Color(0xFFDC2626).withValues(alpha: 0.15),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color(0xFFDC2626),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                Icons.warning_amber,
                color: Colors.white,
                size: 18.0,
              ),
            ),
            SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${i + 1}. ${f['title']}',
                    style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7F1D1D),
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    f['detail'] as String,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Color(0xFF7F1D1D),
                      height: 1.35,
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
  print('Built ${footgunCards.length} footgun cards');

  // ============================================================
  // SECTION 10: Recap card
  // ============================================================
  print('=== Section 10: Recap card ===');

  final recapEntries = <Map<String, String>>[
    {
      'n': '1',
      'title': 'Class purpose',
      'text': 'Wraps a host ShapeBorder with an axis-aligned rect notch '
          'derived from a guest\'s bounds.',
    },
    {
      'n': '2',
      'title': 'Constructor',
      'text': 'AutomaticNotchedShape(host, [guest]) — both are ShapeBorders.',
    },
    {
      'n': '3',
      'title': 'Method',
      'text': 'getOuterPath(host, guest) returns Path of host minus '
          'guest.bounds.',
    },
    {
      'n': '4',
      'title': 'Use case',
      'text': 'BottomAppBar.shape with non-circular FloatingActionButtons.',
    },
    {
      'n': '5',
      'title': 'Alternative',
      'text': 'CircularNotchedRectangle for curved notches with circular FABs.',
    },
    {
      'n': '6',
      'title': 'Hard rule',
      'text': 'Notch is always rectangular; guest curvature is discarded.',
    },
  ];

  final recapCard = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF312E81),
          Color(0xFF0F766E),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF312E81).withValues(alpha: 0.4),
          blurRadius: 16.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Color(0xFFFBBF24), size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        for (var i = 0; i < recapEntries.length; i++)
          Container(
            margin: EdgeInsets.only(bottom: 8.0),
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.18),
                width: 1.0,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 26.0,
                  height: 26.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFBBF24),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      recapEntries[i]['n']!,
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recapEntries[i]['title']!,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFFBBF24),
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        recapEntries[i]['text']!,
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.white,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
  print('Recap card built');

  // ============================================================
  // Demo: actually call getOuterPath to confirm runtime behavior
  // ============================================================
  print('=== Demo: getOuterPath calls ===');

  final demoHostRect = Rect.fromLTWH(0.0, 0.0, 400.0, 56.0);
  final demoGuestRect = Rect.fromCircle(
    center: Offset(200.0, 28.0),
    radius: 28.0,
  );
  final demoShape = AutomaticNotchedShape(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    CircleBorder(),
  );
  final demoPath = demoShape.getOuterPath(demoHostRect, demoGuestRect);
  print(
    'Demo getOuterPath(host=$demoHostRect, guest=$demoGuestRect) -> '
    'path runtimeType ${demoPath.runtimeType}',
  );
  final nullGuestPath = demoShape.getOuterPath(demoHostRect, null);
  print('Demo getOuterPath(host, null) -> ${nullGuestPath.runtimeType}');

  print('AutomaticNotchedShape Deep Demo completed');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: Color(0xFFF1F5F9),
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleBanner,
          SizedBox(height: 8.0),

          _sectionLabel('1. Anatomy: host vs. guest', Color(0xFF0F766E)),
          anatomyDiagram,
          SizedBox(height: 16.0),

          _sectionLabel(
            '2. Live BottomAppBar mocks (3 hosts)',
            Color(0xFF0F766E),
          ),
          ...liveMocks,
          SizedBox(height: 16.0),

          _sectionLabel(
            '3. Four host-shape variants (same guest)',
            Color(0xFFB45309),
          ),
          Wrap(alignment: WrapAlignment.center, children: hostVariantCards),
          SizedBox(height: 16.0),

          _sectionLabel(
            '4. Guest position: left / center / right',
            Color(0xFF6366F1),
          ),
          Wrap(alignment: WrapAlignment.center, children: positionCards),
          SizedBox(height: 16.0),

          _sectionLabel(
            '5. Guest size: small / medium / large',
            Color(0xFF0EA5E9),
          ),
          Wrap(alignment: WrapAlignment.center, children: sizeCards),
          SizedBox(height: 16.0),

          _sectionLabel(
            '6. AutomaticNotchedShape vs CircularNotchedRectangle',
            Color(0xFFB45309),
          ),
          comparisonPanel,
          SizedBox(height: 16.0),

          _sectionLabel('7. Real-world Scaffold mock', Color(0xFF0F766E)),
          realWorldMock,
          SizedBox(height: 16.0),

          _sectionLabel('8. Footguns (5)', Color(0xFFDC2626)),
          ...footgunCards,
          SizedBox(height: 16.0),

          _sectionLabel('9. Recap', Color(0xFF312E81)),
          recapCard,
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// ---------- Helpers ----------

Widget _chip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.18),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.65), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
        color: color,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _sectionLabel(String text, Color color) {
  return Container(
    margin: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 6.0),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          color.withValues(alpha: 0.18),
          color.withValues(alpha: 0.05),
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: color, width: 4.0)),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: 0.2,
      ),
    ),
  );
}

Widget _tableRow(
  String a,
  String b,
  String c, {
  bool isHeader = false,
}) {
  final bg = isHeader
      ? Color(0xFFB45309).withValues(alpha: 0.15)
      : Colors.transparent;
  final style = TextStyle(
    fontSize: 11.0,
    fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
    color: isHeader ? Color(0xFF78350F) : Color(0xFF1E293B),
    fontFamily: isHeader ? null : 'monospace',
  );
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: bg,
      border: Border(
        bottom: BorderSide(
          color: Color(0xFFB45309).withValues(alpha: 0.2),
          width: 1.0,
        ),
      ),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90.0,
          child: Text(
            a,
            style: style.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(child: Text(b, style: style)),
        Expanded(child: Text(c, style: style)),
      ],
    ),
  );
}

Widget _miniMock(String label, NotchedShape shape, Color color) {
  // Wrap the NotchedShape in an AutomaticNotchedShape-compatible material
  // by using ShapeDecoration via a fallback rounded shape only if needed.
  // Both subjects implement NotchedShape, but Material.shape needs
  // ShapeBorder. We render the bar with a manual notch illustration.
  return Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.12),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 8.0),
        SizedBox(
          height: 70.0,
          child: CustomPaint(
            size: Size(double.infinity, 70.0),
            painter: _NotchPainter(shape: shape, color: color),
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          shape.runtimeType.toString(),
          style: TextStyle(
            fontSize: 9.0,
            color: Color(0xFF475569),
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

class _NotchedBarPainter extends CustomPainter {
  final NotchedShape shape;
  final Color fill;
  final double guestRadius;
  final double guestCenterFraction;

  _NotchedBarPainter({
    required this.shape,
    required this.fill,
    this.guestRadius = 28.0,
    this.guestCenterFraction = 0.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final host = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
    final guestCenterX = size.width * guestCenterFraction;
    final guest = Rect.fromCircle(
      center: Offset(guestCenterX, 0.0),
      radius: guestRadius,
    );
    final path = shape.getOuterPath(host, guest);
    final fillPaint = Paint()
      ..color = fill
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fillPaint);
  }

  @override
  bool shouldRepaint(covariant _NotchedBarPainter oldDelegate) =>
      oldDelegate.shape != shape ||
      oldDelegate.fill != fill ||
      oldDelegate.guestRadius != guestRadius ||
      oldDelegate.guestCenterFraction != guestCenterFraction;
}

class _NotchPainter extends CustomPainter {
  final NotchedShape shape;
  final Color color;

  _NotchPainter({required this.shape, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final host = Rect.fromLTWH(0.0, 30.0, size.width, 40.0);
    final guest = Rect.fromCircle(
      center: Offset(size.width / 2.0, 30.0),
      radius: 22.0,
    );
    final path = shape.getOuterPath(host, guest);
    final fill = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fill);
    final stroke = Paint()
      ..color = color.withValues(alpha: 0.85)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, stroke);
    // FAB indicator
    final fabPaint = Paint()..color = Color(0xFFFBBF24);
    canvas.drawCircle(
      Offset(size.width / 2.0, 30.0),
      18.0,
      fabPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _NotchPainter oldDelegate) =>
      oldDelegate.shape != shape || oldDelegate.color != color;
}
