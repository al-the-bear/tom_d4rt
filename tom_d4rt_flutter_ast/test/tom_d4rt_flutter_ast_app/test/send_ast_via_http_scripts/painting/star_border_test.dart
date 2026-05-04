// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Visual Demo of StarBorder from painting
// Demonstrates the OutlinedBorder that paints star or polygon shapes,
// covering points, innerRadiusRatio, pointRounding, valleyRounding,
// rotation, squash, and the StarBorder.polygon() factory.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StarBorder Deep Demo executing');

  // ============================================================
  // Palette: gold / amber / orange tones used across sections.
  // ============================================================
  final Color goldDeep = Color(0xFFB8860B);
  final Color goldBright = Color(0xFFFFD700);
  final Color amberDeep = Color(0xFFFF8F00);
  final Color amberLight = Color(0xFFFFC107);
  final Color orangeDeep = Color(0xFFE65100);
  final Color creamLight = Color(0xFFFFF8E1);

  // ============================================================
  // SECTION 1: Title banner — gold/amber gradient
  // ============================================================
  print('=== Section 1: Title Banner ===');

  final Widget titleBanner = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [goldBright, amberDeep, orangeDeep],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: orangeDeep.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 10.0),
          spreadRadius: 2.0,
        ),
        BoxShadow(
          color: goldBright.withValues(alpha: 0.35),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 88.0,
          height: 88.0,
          decoration: ShapeDecoration(
            shape: StarBorder(
              points: 5,
              innerRadiusRatio: 0.4,
              pointRounding: 0.1,
              side: BorderSide(color: Colors.white, width: 3.0),
            ),
            color: goldBright,
            shadows: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 10.0,
                offset: Offset(0.0, 4.0),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),
        Text(
          'StarBorder',
          style: TextStyle(
            fontSize: 32.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2.0,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'OutlinedBorder painting stars and polygons',
          style: TextStyle(fontSize: 14.0, color: Colors.white70),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            'package:flutter/painting.dart',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
  print('Created title banner');

  // ============================================================
  // SECTION 2: Anatomy of a star
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final Widget anatomySection = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [creamLight, Color(0xFFFFE082)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: amberLight, width: 2.0),
      boxShadow: [
        BoxShadow(
          color: amberDeep.withValues(alpha: 0.25),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Text(
          'Anatomy of a 5-Point Star',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: goldDeep,
          ),
        ),
        SizedBox(height: 16.0),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 220.0,
              height: 220.0,
              decoration: ShapeDecoration(
                shape: StarBorder(
                  points: 5,
                  innerRadiusRatio: 0.4,
                  side: BorderSide(color: goldDeep, width: 3.0),
                ),
                gradient: RadialGradient(
                  colors: [goldBright, amberDeep],
                  center: Alignment.center,
                  radius: 0.7,
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              child: _anatomyLabel('point (outer radius)', orangeDeep),
            ),
            Positioned(
              right: 8.0,
              top: 70.0,
              child: _anatomyLabel('valley (inner radius)', amberDeep),
            ),
            Positioned(
              bottom: 0.0,
              child: _anatomyLabel('rotation 0° = top', goldDeep),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          alignment: WrapAlignment.center,
          children: [
            _anatomyChip('points: 5', goldDeep),
            _anatomyChip('innerRadiusRatio: 0.4', amberDeep),
            _anatomyChip('pointRounding: 0', orangeDeep),
            _anatomyChip('valleyRounding: 0', goldDeep),
            _anatomyChip('rotation: 0°', amberDeep),
            _anatomyChip('squash: 0', orangeDeep),
          ],
        ),
      ],
    ),
  );
  print('Created anatomy diagram');

  // ============================================================
  // SECTION 3: points parameter showcase (3, 4, 5, 6, 8, 12)
  // ============================================================
  print('=== Section 3: points showcase ===');

  final pointsValues = <int>[3, 4, 5, 6, 8, 12];
  final List<Widget> pointsCards = <Widget>[];
  for (final p in pointsValues) {
    final star = StarBorder(points: p.toDouble(), innerRadiusRatio: 0.4);
    print(
      'StarBorder(points: $p) -> innerRadiusRatio=${star.innerRadiusRatio}',
    );
    pointsCards.add(
      _shapeCard(
        title: '$p points',
        subtitle: 'points: $p',
        shape: StarBorder(
          points: p.toDouble(),
          innerRadiusRatio: 0.4,
          side: BorderSide(color: goldDeep, width: 2.0),
        ),
        accent: goldDeep,
        secondary: goldBright,
      ),
    );
  }
  print('Created ${pointsCards.length} points cards');

  // ============================================================
  // SECTION 4: innerRadiusRatio showcase (0.1, 0.25, 0.4, 0.6, 0.8)
  // ============================================================
  print('=== Section 4: innerRadiusRatio showcase ===');

  final ratioValues = <double>[0.1, 0.25, 0.4, 0.6, 0.8];
  final List<Widget> ratioCards = <Widget>[];
  for (final r in ratioValues) {
    print('StarBorder(innerRadiusRatio: $r)');
    final String desc;
    if (r <= 0.15) {
      desc = 'razor-thin spikes';
    } else if (r <= 0.3) {
      desc = 'classic skinny';
    } else if (r <= 0.5) {
      desc = 'balanced star';
    } else if (r <= 0.7) {
      desc = 'fat / bold';
    } else {
      desc = 'almost polygon';
    }
    ratioCards.add(
      _shapeCard(
        title: 'ratio ${r.toStringAsFixed(2)}',
        subtitle: desc,
        shape: StarBorder(
          points: 5,
          innerRadiusRatio: r,
          side: BorderSide(color: amberDeep, width: 2.0),
        ),
        accent: amberDeep,
        secondary: amberLight,
      ),
    );
  }
  print('Created ${ratioCards.length} innerRadiusRatio cards');

  // ============================================================
  // SECTION 5: pointRounding & valleyRounding showcase
  // ============================================================
  print('=== Section 5: rounding showcase ===');

  final roundingCards = <Widget>[
    _shapeCard(
      title: 'sharp',
      subtitle: 'point: 0, valley: 0',
      shape: StarBorder(
        points: 5,
        innerRadiusRatio: 0.4,
        pointRounding: 0.0,
        valleyRounding: 0.0,
        side: BorderSide(color: orangeDeep, width: 2.0),
      ),
      accent: orangeDeep,
      secondary: amberLight,
    ),
    _shapeCard(
      title: 'rounded points',
      subtitle: 'point: 0.5',
      shape: StarBorder(
        points: 5,
        innerRadiusRatio: 0.4,
        pointRounding: 0.5,
        valleyRounding: 0.0,
        side: BorderSide(color: orangeDeep, width: 2.0),
      ),
      accent: orangeDeep,
      secondary: amberLight,
    ),
    _shapeCard(
      title: 'rounded valleys',
      subtitle: 'valley: 0.5',
      shape: StarBorder(
        points: 5,
        innerRadiusRatio: 0.4,
        pointRounding: 0.0,
        valleyRounding: 0.5,
        side: BorderSide(color: orangeDeep, width: 2.0),
      ),
      accent: orangeDeep,
      secondary: amberLight,
    ),
    _shapeCard(
      title: 'soft star',
      subtitle: 'both: 0.5',
      shape: StarBorder(
        points: 5,
        innerRadiusRatio: 0.4,
        pointRounding: 0.5,
        valleyRounding: 0.5,
        side: BorderSide(color: orangeDeep, width: 2.0),
      ),
      accent: orangeDeep,
      secondary: amberLight,
    ),
  ];
  print('Created ${roundingCards.length} rounding cards');

  // ============================================================
  // SECTION 6: rotation showcase (0°, 36°, 90°, 180°)
  // ============================================================
  print('=== Section 6: rotation showcase ===');

  final rotations = <double>[0.0, 36.0, 90.0, 180.0];
  final List<Widget> rotationCards = <Widget>[];
  for (final deg in rotations) {
    print('StarBorder(rotation: $deg°)');
    final String note;
    if (deg == 0.0) {
      note = 'point up (default)';
    } else if (deg == 36.0) {
      note = 'half segment';
    } else if (deg == 90.0) {
      note = 'point right';
    } else {
      note = 'point down';
    }
    rotationCards.add(
      _shapeCard(
        title: '${deg.toInt()}°',
        subtitle: note,
        shape: StarBorder(
          points: 5,
          innerRadiusRatio: 0.4,
          rotation: deg,
          side: BorderSide(color: goldDeep, width: 2.0),
        ),
        accent: goldDeep,
        secondary: goldBright,
      ),
    );
  }
  print('Created ${rotationCards.length} rotation cards');

  // ============================================================
  // SECTION 7: squash showcase (0, 0.5, 1)
  // ============================================================
  print('=== Section 7: squash showcase ===');

  final squashValues = <double>[0.0, 0.5, 1.0];
  final List<Widget> squashCards = <Widget>[];
  for (final s in squashValues) {
    print('StarBorder(squash: $s)');
    final String note;
    if (s == 0.0) {
      note = 'circular';
    } else if (s == 0.5) {
      note = 'partial squash';
    } else {
      note = 'fully squashed';
    }
    squashCards.add(
      _shapeCard(
        title: 'squash ${s.toStringAsFixed(1)}',
        subtitle: note,
        shape: StarBorder(
          points: 5,
          innerRadiusRatio: 0.4,
          squash: s,
          side: BorderSide(color: amberDeep, width: 2.0),
        ),
        accent: amberDeep,
        secondary: amberLight,
      ),
    );
  }
  print('Created ${squashCards.length} squash cards');

  // ============================================================
  // SECTION 8: StarBorder.polygon() factory
  // ============================================================
  print('=== Section 8: polygon factory ===');

  final polygonData = <Map<String, Object>>[
    {'sides': 3, 'name': 'triangle'},
    {'sides': 4, 'name': 'square'},
    {'sides': 6, 'name': 'hexagon'},
    {'sides': 8, 'name': 'octagon'},
    {'sides': 12, 'name': 'dodecagon'},
  ];
  final List<Widget> polygonCards = <Widget>[];
  for (final entry in polygonData) {
    final int sides = entry['sides'] as int;
    final String name = entry['name'] as String;
    final poly = StarBorder.polygon(sides: sides.toDouble());
    print('StarBorder.polygon(sides: $sides) -> ${poly.runtimeType}');
    polygonCards.add(
      _shapeCard(
        title: name,
        subtitle: '$sides sides',
        shape: StarBorder.polygon(
          sides: sides.toDouble(),
          side: BorderSide(color: orangeDeep, width: 2.5),
        ),
        accent: orangeDeep,
        secondary: amberLight,
      ),
    );
  }
  print('Created ${polygonCards.length} polygon cards');

  // ============================================================
  // SECTION 9: Real-world mocks
  // ============================================================
  print('=== Section 9: Real-world mocks ===');

  // Mock 1: Gold rating star (classic favourite icon)
  final Widget mockRatingStar = Container(
    width: 130.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [creamLight, Color(0xFFFFE0B2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: amberDeep.withValues(alpha: 0.3),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 76.0,
          height: 76.0,
          decoration: ShapeDecoration(
            shape: StarBorder(
              points: 5,
              innerRadiusRatio: 0.38,
              pointRounding: 0.05,
              side: BorderSide(color: goldDeep, width: 2.0),
            ),
            gradient: RadialGradient(
              colors: [goldBright, amberDeep],
              center: Alignment(-0.3, -0.3),
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Rating',
          style: TextStyle(fontWeight: FontWeight.bold, color: goldDeep),
        ),
        Text(
          '4.9 / 5.0',
          style: TextStyle(fontSize: 11.0, color: amberDeep),
        ),
      ],
    ),
  );

  // Mock 2: Badge medal (8 points)
  final Widget mockMedal = Container(
    width: 130.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF3E0), Color(0xFFFFCC80)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: orangeDeep.withValues(alpha: 0.35),
          blurRadius: 12.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 76.0,
          height: 76.0,
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            shape: StarBorder(
              points: 8,
              innerRadiusRatio: 0.7,
              pointRounding: 0.2,
              valleyRounding: 0.4,
              side: BorderSide(color: orangeDeep, width: 2.5),
            ),
            color: amberDeep,
          ),
          child: Text(
            '1st',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Champion',
          style: TextStyle(fontWeight: FontWeight.bold, color: orangeDeep),
        ),
        Text(
          'Award',
          style: TextStyle(fontSize: 11.0, color: amberDeep),
        ),
      ],
    ),
  );

  // Mock 3: 4-point compass
  final Widget mockCompass = Container(
    width: 130.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [creamLight, goldBright],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: goldDeep.withValues(alpha: 0.3),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 76.0,
          height: 76.0,
          decoration: ShapeDecoration(
            shape: StarBorder(
              points: 4,
              innerRadiusRatio: 0.2,
              side: BorderSide(color: Color(0xFF5D4037), width: 2.5),
            ),
            color: goldDeep,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Compass',
          style: TextStyle(fontWeight: FontWeight.bold, color: goldDeep),
        ),
        Text(
          'N · E · S · W',
          style: TextStyle(fontSize: 11.0, color: amberDeep),
        ),
      ],
    ),
  );

  // Mock 4: Hexagon avatar (polygon)
  final Widget mockHexAvatar = Container(
    width: 130.0,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFE082), Color(0xFFFFB74D)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: amberDeep.withValues(alpha: 0.3),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 76.0,
          height: 76.0,
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            shape: StarBorder.polygon(
              sides: 6,
              side: BorderSide(color: goldDeep, width: 3.0),
            ),
            color: orangeDeep,
          ),
          child: Text(
            'AK',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
            ),
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Avatar',
          style: TextStyle(fontWeight: FontWeight.bold, color: orangeDeep),
        ),
        Text(
          'hexagon',
          style: TextStyle(fontSize: 11.0, color: amberDeep),
        ),
      ],
    ),
  );

  final Widget realWorldRow = Wrap(
    spacing: 12.0,
    runSpacing: 12.0,
    alignment: WrapAlignment.center,
    children: [mockRatingStar, mockMedal, mockCompass, mockHexAvatar],
  );
  print('Created real-world mock row');

  // ============================================================
  // SECTION 10: Footguns
  // ============================================================
  print('=== Section 10: Footguns ===');

  final List<Map<String, String>> footguns = <Map<String, String>>[
    {
      'icon': 'side.width',
      'title': 'side.width pulls in geometry',
      'detail':
          'Increasing side.width inflates the stroke inward, shrinking the '
          'apparent radius. Compensate by oversizing the container or by '
          'reducing innerRadiusRatio when using thick borders.',
    },
    {
      'icon': 'points',
      'title': 'points must be ≥ 2',
      'detail':
          'StarBorder(points: 1) or 0 throws an assertion. For a circle use '
          'CircleBorder. For a single triangle use StarBorder.polygon('
          'sides: 3).',
    },
    {
      'icon': 'rotation',
      'title': 'rotation is in degrees, not radians',
      'detail':
          'Unlike Transform.rotate() which uses radians, StarBorder.rotation '
          'expects degrees. 90 means quarter turn. Multiply radians by '
          '180/pi if porting code.',
    },
    {
      'icon': 'innerRadiusRatio',
      'title': 'innerRadiusRatio is ignored on .polygon()',
      'detail':
          'The polygon factory hard-pins innerRadiusRatio to 1.0, so passing '
          'it has no effect. Use the default StarBorder constructor when '
          'you need spiky shapes.',
    },
    {
      'icon': 'squash',
      'title': 'squash flattens vertically only',
      'detail':
          'squash: 1 collapses the y-axis to roughly half. To squash on x '
          'instead, wrap in a Transform.scale or rotate the StarBorder by '
          '90°.',
    },
  ];
  final List<Widget> footgunCards = <Widget>[];
  for (final fg in footguns) {
    footgunCards.add(_footgunCard(
      label: fg['icon']!,
      title: fg['title']!,
      detail: fg['detail']!,
      accent: orangeDeep,
      bg: creamLight,
    ));
  }
  print('Created ${footgunCards.length} footgun cards');

  // ============================================================
  // Section labels (gradient banners reused for each block)
  // ============================================================
  Widget sectionLabel(String number, String title, Color a, Color b) {
    return Container(
      margin: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 8.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [a, b],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: a.withValues(alpha: 0.35),
            blurRadius: 8.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.25),
              shape: BoxShape.circle,
            ),
            child: Text(
              number,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  print('StarBorder Deep Demo completed successfully');

  // ============================================================
  // Final composition: Scaffold > SingleChildScrollView > Column
  // ============================================================
  return Scaffold(
    backgroundColor: Color(0xFFFFFDF7),
    body: SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Section 1
          titleBanner,

          // Section 2
          sectionLabel('2', 'Anatomy of a Star', goldDeep, amberDeep),
          anatomySection,

          // Section 3
          sectionLabel('3', 'points Parameter (3 → 12)', amberDeep, orangeDeep),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              alignment: WrapAlignment.center,
              children: pointsCards,
            ),
          ),

          // Section 4
          sectionLabel(
            '4',
            'innerRadiusRatio (0.1 → 0.8)',
            orangeDeep,
            goldDeep,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              alignment: WrapAlignment.center,
              children: ratioCards,
            ),
          ),

          // Section 5
          sectionLabel(
            '5',
            'pointRounding & valleyRounding',
            goldDeep,
            orangeDeep,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              alignment: WrapAlignment.center,
              children: roundingCards,
            ),
          ),

          // Section 6
          sectionLabel('6', 'rotation (degrees)', amberDeep, goldDeep),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              alignment: WrapAlignment.center,
              children: rotationCards,
            ),
          ),

          // Section 7
          sectionLabel('7', 'squash', orangeDeep, amberDeep),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              alignment: WrapAlignment.center,
              children: squashCards,
            ),
          ),

          // Section 8
          sectionLabel(
            '8',
            'StarBorder.polygon() factory',
            goldDeep,
            amberDeep,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Wrap(
              spacing: 12.0,
              runSpacing: 12.0,
              alignment: WrapAlignment.center,
              children: polygonCards,
            ),
          ),

          // Section 9
          sectionLabel('9', 'Real-world mocks', amberDeep, orangeDeep),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: realWorldRow,
          ),

          // Section 10
          sectionLabel('10', 'Footguns & gotchas', orangeDeep, goldDeep),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: footgunCards,
            ),
          ),

          // Footer summary
          Container(
            margin: EdgeInsets.all(16.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [goldDeep, orangeDeep],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: [
                BoxShadow(
                  color: orangeDeep.withValues(alpha: 0.4),
                  blurRadius: 16.0,
                  offset: Offset(0.0, 8.0),
                ),
              ],
            ),
            child: Column(
              children: [
                Icon(Icons.star, color: Colors.white, size: 36.0),
                SizedBox(height: 8.0),
                Text(
                  'StarBorder Deep Demo · End',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.0),
                Text(
                  'StarBorder · StarBorder.polygon · ShapeDecoration',
                  style: TextStyle(color: Colors.white70, fontSize: 12.0),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0),
        ],
      ),
    ),
  );
}

// ============================================================
// Helper widgets
// ============================================================

// A single labelled chip used in the anatomy section.
Widget _anatomyLabel(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.9),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.0),
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

// A small chip listing parameter values.
Widget _anatomyChip(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

// Reusable card that renders a Container shaped by the given StarBorder.
Widget _shapeCard({
  required String title,
  required String subtitle,
  required ShapeBorder shape,
  required Color accent,
  required Color secondary,
}) {
  return Container(
    width: 130.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          accent.withValues(alpha: 0.08),
          secondary.withValues(alpha: 0.18),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: accent.withValues(alpha: 0.4), width: 1.0),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          width: 80.0,
          height: 80.0,
          decoration: ShapeDecoration(
            shape: shape,
            gradient: RadialGradient(
              colors: [secondary, accent],
              center: Alignment(-0.2, -0.2),
              radius: 0.85,
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
            color: accent,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10.0,
            color: accent.withValues(alpha: 0.8),
          ),
        ),
      ],
    ),
  );
}

// A footgun card: warning icon, title, descriptive paragraph.
Widget _footgunCard({
  required String label,
  required String title,
  required String detail,
  required Color accent,
  required Color bg,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12.0),
      border: Border(
        left: BorderSide(color: accent, width: 4.0),
        top: BorderSide(color: accent.withValues(alpha: 0.2), width: 1.0),
        right: BorderSide(color: accent.withValues(alpha: 0.2), width: 1.0),
        bottom: BorderSide(color: accent.withValues(alpha: 0.2), width: 1.0),
      ),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.15),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40.0,
          height: 40.0,
          alignment: Alignment.center,
          decoration: ShapeDecoration(
            shape: StarBorder(
              points: 5,
              innerRadiusRatio: 0.4,
              pointRounding: 0.2,
            ),
            color: accent,
          ),
          child: Icon(Icons.warning_amber, color: Colors.white, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: accent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                detail,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.black54,
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
