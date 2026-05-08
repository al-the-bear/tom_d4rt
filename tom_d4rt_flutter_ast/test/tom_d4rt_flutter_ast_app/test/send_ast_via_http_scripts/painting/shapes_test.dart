// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RoundedRectangleBorder, CircleBorder, StadiumBorder,
// BeveledRectangleBorder, ContinuousRectangleBorder, OvalBorder and their
// abstract parents OutlinedBorder and ShapeBorder.
//
// Deep Demo theme: "The Die-Cutter's Tooling Chest"
// Every concrete shape is presented as a steel cutting die from a master
// die-cutter's chest. The "side" is the steel rim of the die, the
// "borderRadius" is the curvature dial set into the die, the lerp API is
// the chest's morphing jig that slowly reshapes one die into another, and
// scale/copyWith/getOuterPath are the bench tools used to dress the dies
// before each pressing.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=========================================================');
  print('THE DIE-CUTTER\'S TOOLING CHEST  -  Shapes Deep Demo');
  print('=========================================================');
  print('Opening the chest...  six cutting dies, two abstract parents.');

  // Master palette for the chest: warm steel + walnut + brass.
  final steel = Color(0xFF6F7F8C);
  final brass = Color(0xFFB08D57);
  final walnut = Color(0xFF5B3A1A);
  final paper = Color(0xFFFBF5E9);
  final inkBlue = Color(0xFF1E3A5F);
  final inkRed = Color(0xFF8B1E1E);
  final inkGreen = Color(0xFF2F5E2A);
  final inkPurple = Color(0xFF5A2A6E);
  final inkTeal = Color(0xFF1F6E6E);
  final inkOrange = Color(0xFFB8581E);

  // ============================================================
  // SECTION 1: Chest opening - hero banner
  // ============================================================
  print('=== Section 1: Hero - opening the chest ===');

  final hero = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [walnut, Color(0xFF3A240F)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.55),
          blurRadius: 24.0,
          spreadRadius: 2.0,
          offset: Offset(0.0, 12.0),
        ),
        BoxShadow(
          color: brass.withValues(alpha: 0.25),
          blurRadius: 8.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
      border: Border.all(color: brass, width: 2.0),
    ),
    child: Column(
      children: [
        Container(
          width: 96.0,
          height: 96.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [brass, Color(0xFF6E5430)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.6),
                blurRadius: 12.0,
                offset: Offset(0.0, 6.0),
              ),
            ],
            border: Border.all(color: paper.withValues(alpha: 0.8), width: 2.0),
          ),
          child: Icon(Icons.crop_square, size: 56.0, color: paper),
        ),
        SizedBox(height: 16.0),
        Text(
          "The Die-Cutter's Chest",
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
            color: paper,
            letterSpacing: 1.5,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'six steel dies  -  two abstract jigs  -  one lerp morphing bench',
          style: TextStyle(
            fontSize: 14.0,
            fontStyle: FontStyle.italic,
            color: brass,
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: paper.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(20.0),
            border: Border.all(color: brass.withValues(alpha: 0.6), width: 1.0),
          ),
          child: Text(
            'package:flutter/material.dart  >  painting/borders',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: paper,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Hierarchy diagram - ShapeBorder > OutlinedBorder > 6 dies
  // ============================================================
  print('=== Section 2: Hierarchy diagram ===');
  print('ShapeBorder is the abstract jig - any path that bounds a region.');
  print('OutlinedBorder adds a uniform `side` rim to that path.');
  print('Six concrete dies inherit from OutlinedBorder.');

  Widget hierarchyNode(String label, String subtitle, Color color, double w) {
    return Container(
      width: w,
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color.withValues(alpha: 0.15), color.withValues(alpha: 0.3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.25),
            blurRadius: 6.0,
            offset: Offset(0.0, 3.0),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          SizedBox(height: 2.0),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 9.0,
              color: color.withValues(alpha: 0.8),
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget downArrow(Color color) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Icon(Icons.arrow_downward, color: color, size: 22.0),
    );
  }

  final concreteDies = <List<dynamic>>[
    ['RoundedRectangleBorder', 'rounded corners', inkBlue],
    ['CircleBorder', 'perfect disc', inkRed],
    ['StadiumBorder', 'pill / capsule', inkGreen],
    ['BeveledRectangleBorder', 'chamfered corners', inkOrange],
    ['ContinuousRectangleBorder', 'squircle / superellipse', inkPurple],
    ['OvalBorder', 'inscribed ellipse', inkTeal],
  ];

  final hierarchyChildren = <Widget>[];
  hierarchyChildren.add(
    hierarchyNode('ShapeBorder', 'abstract  -  any path', steel, 200.0),
  );
  hierarchyChildren.add(downArrow(steel));
  hierarchyChildren.add(
    hierarchyNode('OutlinedBorder', 'abstract  +  uniform side', brass, 220.0),
  );
  hierarchyChildren.add(downArrow(brass));
  final dieRow = <Widget>[];
  for (int i = 0; i < concreteDies.length; i = i + 1) {
    final entry = concreteDies[i];
    dieRow.add(
      Padding(
        padding: EdgeInsets.all(4.0),
        child: hierarchyNode(
          entry[0] as String,
          entry[1] as String,
          entry[2] as Color,
          150.0,
        ),
      ),
    );
  }
  hierarchyChildren.add(
    Wrap(alignment: WrapAlignment.center, children: dieRow),
  );

  final hierarchy = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [paper, Color(0xFFEEDFC0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: walnut.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: walnut.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(children: hierarchyChildren),
  );

  // ============================================================
  // SECTION 3: Anatomy of a cutting die
  // ============================================================
  print('=== Section 3: Anatomy of a cutting die ===');
  print('side    -> the steel rim, a BorderSide(color, width, style).');
  print('borderRadius -> the curvature dial, a BorderRadiusGeometry.');
  print('getOuterPath -> the cut line through the dough.');
  print('getInnerPath -> the inset line for the embossed shoulder.');

  final anatomy = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: paper,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: walnut.withValues(alpha: 0.4), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: walnut.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anatomy of a Cutting Die',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: walnut,
          ),
        ),
        SizedBox(height: 16.0),
        Center(
          child: Container(
            width: 260.0,
            height: 180.0,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
                side: BorderSide(color: steel, width: 6.0),
              ),
              gradient: LinearGradient(
                colors: [Color(0xFFF6E7C1), Color(0xFFE2C98C)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shadows: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  blurRadius: 10.0,
                  offset: Offset(0.0, 6.0),
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 6.0,
                  left: 12.0,
                  child: Text(
                    'side: BorderSide(width: 6.0)',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                      color: steel,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 6.0,
                  right: 12.0,
                  child: Text(
                    'borderRadius: 28.0',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                      color: walnut,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.touch_app, color: walnut, size: 32.0),
                      Text(
                        'getOuterPath()',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.0,
                          color: walnut,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'getInnerPath() = outer.deflate(side.width)',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 9.0,
                          color: walnut.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.amber.shade50,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.shade300, width: 1.0),
          ),
          child: Text(
            "A die's outer path is what stamps through the dough; the inner "
            "path is the same shape contracted by side.width on every edge - "
            "Flutter uses it to clip child content so the rim isn't covered.",
            style: TextStyle(fontSize: 12.0, color: Colors.brown.shade900),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: RoundedRectangleBorder gallery - the workhorse die
  // ============================================================
  print('=== Section 4: RoundedRectangleBorder ===');

  final roundedSamples = <Map<String, dynamic>>[
    {'r': 0.0, 'w': 2.0, 'label': 'r=0  (sharp)', 'color': inkBlue},
    {'r': 8.0, 'w': 2.0, 'label': 'r=8', 'color': inkBlue},
    {'r': 20.0, 'w': 3.0, 'label': 'r=20', 'color': inkBlue},
    {'r': 36.0, 'w': 4.0, 'label': 'r=36', 'color': inkBlue},
    {'r': 60.0, 'w': 5.0, 'label': 'r=60  (almost stadium)', 'color': inkBlue},
  ];

  final roundedTiles = <Widget>[];
  for (int i = 0; i < roundedSamples.length; i = i + 1) {
    final s = roundedSamples[i];
    final r = s['r'] as double;
    final w = s['w'] as double;
    final color = s['color'] as Color;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(r),
      side: BorderSide(color: color, width: w),
    );
    print('RoundedRectangleBorder r=$r w=$w  -> side=${shape.side}');
    roundedTiles.add(
      Container(
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: 110.0,
              height: 80.0,
              decoration: ShapeDecoration(
                shape: shape,
                gradient: LinearGradient(
                  colors: [
                    color.withValues(alpha: 0.15),
                    color.withValues(alpha: 0.35),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shadows: [
                  BoxShadow(
                    color: color.withValues(alpha: 0.35),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              s['label'] as String,
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: CircleBorder gallery - the cookie cutter
  // ============================================================
  print('=== Section 5: CircleBorder ===');

  final circleWidths = <double>[1.0, 2.0, 4.0, 6.0, 10.0];
  final circleTiles = <Widget>[];
  for (int i = 0; i < circleWidths.length; i = i + 1) {
    final w = circleWidths[i];
    final shape = CircleBorder(side: BorderSide(color: inkRed, width: w));
    print('CircleBorder side.width=$w  -> dimensions ${shape.dimensions}');
    circleTiles.add(
      Container(
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: 90.0,
              height: 90.0,
              decoration: ShapeDecoration(
                shape: shape,
                gradient: RadialGradient(
                  colors: [
                    Colors.white,
                    inkRed.withValues(alpha: 0.4),
                  ],
                ),
                shadows: [
                  BoxShadow(
                    color: inkRed.withValues(alpha: 0.35),
                    blurRadius: 8.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'w=$w',
              style: TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                color: inkRed,
              ),
            ),
          ],
        ),
      ),
    );
  }
  // CircleBorder also supports an `eccentricity` knob (0..1).
  final eccentricSamples = <double>[0.0, 0.3, 0.6, 0.9];
  final eccentricTiles = <Widget>[];
  for (int i = 0; i < eccentricSamples.length; i = i + 1) {
    final e = eccentricSamples[i];
    final shape = CircleBorder(
      side: BorderSide(color: inkRed, width: 3.0),
      eccentricity: e,
    );
    print('CircleBorder eccentricity=$e');
    eccentricTiles.add(
      Container(
        margin: EdgeInsets.all(6.0),
        child: Column(
          children: [
            Container(
              width: 110.0,
              height: 70.0,
              decoration: ShapeDecoration(
                shape: shape,
                color: inkRed.withValues(alpha: 0.15),
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'e=$e',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: inkRed,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 6: StadiumBorder - the pill press
  // ============================================================
  print('=== Section 6: StadiumBorder ===');

  final stadiumWidths = <double>[1.0, 2.0, 4.0, 6.0];
  final stadiumTiles = <Widget>[];
  for (int i = 0; i < stadiumWidths.length; i = i + 1) {
    final w = stadiumWidths[i];
    final shape = StadiumBorder(side: BorderSide(color: inkGreen, width: w));
    print('StadiumBorder w=$w');
    stadiumTiles.add(
      Container(
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: 160.0,
              height: 56.0,
              decoration: ShapeDecoration(
                shape: shape,
                gradient: LinearGradient(
                  colors: [
                    inkGreen.withValues(alpha: 0.15),
                    inkGreen.withValues(alpha: 0.35),
                  ],
                ),
                shadows: [
                  BoxShadow(
                    color: inkGreen.withValues(alpha: 0.3),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'StadiumBorder w=$w',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                    color: inkGreen,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Stadium = RoundedRect with radius == shortestSide / 2.
  final stadiumNote = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: inkGreen.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: inkGreen.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Text(
      'Bench note: a StadiumBorder is mathematically a RoundedRectangleBorder '
      'whose corner radius equals shortestSide/2 - the pill is just the '
      'workhorse die taken to its limit.',
      style: TextStyle(
        fontSize: 12.0,
        color: inkGreen,
        fontStyle: FontStyle.italic,
      ),
    ),
  );

  // ============================================================
  // SECTION 7: BeveledRectangleBorder - the chamfered die
  // ============================================================
  print('=== Section 7: BeveledRectangleBorder ===');

  final beveledSamples = <Map<String, dynamic>>[
    {'r': 6.0, 'w': 2.0, 'label': 'r=6'},
    {'r': 14.0, 'w': 3.0, 'label': 'r=14'},
    {'r': 24.0, 'w': 4.0, 'label': 'r=24'},
    {'r': 40.0, 'w': 5.0, 'label': 'r=40'},
  ];
  final beveledTiles = <Widget>[];
  for (int i = 0; i < beveledSamples.length; i = i + 1) {
    final s = beveledSamples[i];
    final r = s['r'] as double;
    final w = s['w'] as double;
    final shape = BeveledRectangleBorder(
      borderRadius: BorderRadius.circular(r),
      side: BorderSide(color: inkOrange, width: w),
    );
    print('BeveledRectangleBorder r=$r w=$w');
    beveledTiles.add(
      Container(
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: 120.0,
              height: 80.0,
              decoration: ShapeDecoration(
                shape: shape,
                gradient: LinearGradient(
                  colors: [
                    inkOrange.withValues(alpha: 0.15),
                    inkOrange.withValues(alpha: 0.4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shadows: [
                  BoxShadow(
                    color: inkOrange.withValues(alpha: 0.35),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              s['label'] as String,
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: inkOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 8: ContinuousRectangleBorder - the squircle press
  // ============================================================
  print('=== Section 8: ContinuousRectangleBorder ===');

  final continuousSamples = <Map<String, dynamic>>[
    {'r': 8.0, 'w': 2.0, 'label': 'r=8'},
    {'r': 18.0, 'w': 3.0, 'label': 'r=18'},
    {'r': 32.0, 'w': 4.0, 'label': 'r=32'},
    {'r': 56.0, 'w': 5.0, 'label': 'r=56'},
  ];
  final continuousTiles = <Widget>[];
  for (int i = 0; i < continuousSamples.length; i = i + 1) {
    final s = continuousSamples[i];
    final r = s['r'] as double;
    final w = s['w'] as double;
    final shape = ContinuousRectangleBorder(
      borderRadius: BorderRadius.circular(r),
      side: BorderSide(color: inkPurple, width: w),
    );
    print('ContinuousRectangleBorder r=$r w=$w');
    continuousTiles.add(
      Container(
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: 120.0,
              height: 80.0,
              decoration: ShapeDecoration(
                shape: shape,
                gradient: LinearGradient(
                  colors: [
                    inkPurple.withValues(alpha: 0.15),
                    inkPurple.withValues(alpha: 0.4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shadows: [
                  BoxShadow(
                    color: inkPurple.withValues(alpha: 0.35),
                    blurRadius: 8.0,
                    offset: Offset(0.0, 4.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              s['label'] as String,
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: inkPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
  final squircleNote = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: inkPurple.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: inkPurple.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Text(
      'Bench note: ContinuousRectangleBorder is the iOS squircle press - '
      'curvature flows continuously into the straight edge instead of jumping '
      'from arc to line. Compare the corner against RoundedRectangleBorder '
      'at matching radius.',
      style: TextStyle(
        fontSize: 12.0,
        color: inkPurple,
        fontStyle: FontStyle.italic,
      ),
    ),
  );

  // ============================================================
  // SECTION 9: OvalBorder - the egg mold
  // ============================================================
  print('=== Section 9: OvalBorder ===');

  final ovalSamples = <Map<String, dynamic>>[
    {'w': 1.5, 'aspect': 0.6, 'label': 'tall  w=1.5'},
    {'w': 3.0, 'aspect': 1.0, 'label': 'square  w=3'},
    {'w': 4.0, 'aspect': 1.6, 'label': 'wide  w=4'},
    {'w': 6.0, 'aspect': 2.2, 'label': 'extra-wide  w=6'},
  ];
  final ovalTiles = <Widget>[];
  for (int i = 0; i < ovalSamples.length; i = i + 1) {
    final s = ovalSamples[i];
    final w = s['w'] as double;
    final aspect = s['aspect'] as double;
    final shape = OvalBorder(side: BorderSide(color: inkTeal, width: w));
    print('OvalBorder w=$w aspect=$aspect');
    ovalTiles.add(
      Container(
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: 60.0 * aspect + 40.0,
              height: 80.0,
              decoration: ShapeDecoration(
                shape: shape,
                gradient: RadialGradient(
                  colors: [
                    Colors.white,
                    inkTeal.withValues(alpha: 0.35),
                  ],
                ),
                shadows: [
                  BoxShadow(
                    color: inkTeal.withValues(alpha: 0.3),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              s['label'] as String,
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: inkTeal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 10: BorderSide gallery - rim styles
  // ============================================================
  print('=== Section 10: BorderSide gallery ===');

  final sideSamples = <Map<String, dynamic>>[
    {
      'side': BorderSide(color: inkBlue, width: 1.0),
      'label': 'thin steel  w=1',
    },
    {
      'side': BorderSide(color: inkBlue, width: 3.0),
      'label': 'medium steel  w=3',
    },
    {
      'side': BorderSide(color: inkBlue, width: 6.0),
      'label': 'thick steel  w=6',
    },
    {'side': BorderSide.none, 'label': 'BorderSide.none (no rim)'},
  ];
  final sideTiles = <Widget>[];
  for (int i = 0; i < sideSamples.length; i = i + 1) {
    final s = sideSamples[i];
    final side = s['side'] as BorderSide;
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
      side: side,
    );
    print('side ${side.color} width=${side.width} style=${side.style}');
    sideTiles.add(
      Container(
        margin: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              width: 130.0,
              height: 64.0,
              decoration: ShapeDecoration(
                shape: shape,
                gradient: LinearGradient(
                  colors: [Colors.white, paper],
                ),
                shadows: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 4.0,
                    offset: Offset(0.0, 2.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              s['label'] as String,
              style: TextStyle(fontSize: 10.0, color: walnut),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 11: lerp() - the morphing bench
  // ============================================================
  print('=== Section 11: lerp interpolation ===');
  print('The chest has a morphing jig: ShapeBorder.lerp(a, b, t).');
  print('Every concrete die also implements lerpFrom / lerpTo.');

  // Path A: RoundedRectangleBorder -> CircleBorder
  final lerpStepsAB = <double>[0.0, 0.2, 0.4, 0.6, 0.8, 1.0];
  final shapeA = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
    side: BorderSide(color: inkBlue, width: 3.0),
  );
  final shapeB = CircleBorder(side: BorderSide(color: inkRed, width: 3.0));

  final lerpAbTiles = <Widget>[];
  for (int i = 0; i < lerpStepsAB.length; i = i + 1) {
    final t = lerpStepsAB[i];
    final morphed = ShapeBorder.lerp(shapeA, shapeB, t);
    print('lerp(RoundedRect -> Circle, t=$t) -> ${morphed.runtimeType}');
    lerpAbTiles.add(
      Container(
        margin: EdgeInsets.all(6.0),
        child: Column(
          children: [
            Container(
              width: 80.0,
              height: 80.0,
              decoration: ShapeDecoration(
                shape: morphed!,
                gradient: LinearGradient(
                  colors: [
                    Color.lerp(
                      inkBlue.withValues(alpha: 0.3),
                      inkRed.withValues(alpha: 0.3),
                      t,
                    )!,
                    Color.lerp(
                      inkBlue.withValues(alpha: 0.5),
                      inkRed.withValues(alpha: 0.5),
                      t,
                    )!,
                  ],
                ),
                shadows: [
                  BoxShadow(
                    color: Color.lerp(inkBlue, inkRed, t)!.withValues(
                      alpha: 0.35,
                    ),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              't=$t',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Color.lerp(inkBlue, inkRed, t),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Path B: BeveledRectangleBorder -> ContinuousRectangleBorder
  final shapeC = BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(28.0),
    side: BorderSide(color: inkOrange, width: 3.0),
  );
  final shapeD = ContinuousRectangleBorder(
    borderRadius: BorderRadius.circular(28.0),
    side: BorderSide(color: inkPurple, width: 3.0),
  );
  final lerpCdTiles = <Widget>[];
  for (int i = 0; i < lerpStepsAB.length; i = i + 1) {
    final t = lerpStepsAB[i];
    final morphed = ShapeBorder.lerp(shapeC, shapeD, t);
    print('lerp(Beveled -> Continuous, t=$t) -> ${morphed.runtimeType}');
    lerpCdTiles.add(
      Container(
        margin: EdgeInsets.all(6.0),
        child: Column(
          children: [
            Container(
              width: 84.0,
              height: 84.0,
              decoration: ShapeDecoration(
                shape: morphed!,
                gradient: LinearGradient(
                  colors: [
                    Color.lerp(
                      inkOrange.withValues(alpha: 0.3),
                      inkPurple.withValues(alpha: 0.3),
                      t,
                    )!,
                    Color.lerp(
                      inkOrange.withValues(alpha: 0.5),
                      inkPurple.withValues(alpha: 0.5),
                      t,
                    )!,
                  ],
                ),
                shadows: [
                  BoxShadow(
                    color: Color.lerp(inkOrange, inkPurple, t)!.withValues(
                      alpha: 0.35,
                    ),
                    blurRadius: 6.0,
                    offset: Offset(0.0, 3.0),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              't=$t',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Color.lerp(inkOrange, inkPurple, t),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Path C: StadiumBorder -> OvalBorder via OutlinedBorder.lerp
  final shapeE = StadiumBorder(side: BorderSide(color: inkGreen, width: 3.0));
  final shapeF = OvalBorder(side: BorderSide(color: inkTeal, width: 3.0));
  final lerpEfTiles = <Widget>[];
  for (int i = 0; i < lerpStepsAB.length; i = i + 1) {
    final t = lerpStepsAB[i];
    final morphed = ShapeBorder.lerp(shapeE, shapeF, t);
    print('lerp(Stadium -> Oval, t=$t) -> ${morphed.runtimeType}');
    lerpEfTiles.add(
      Container(
        margin: EdgeInsets.all(6.0),
        child: Column(
          children: [
            Container(
              width: 110.0,
              height: 64.0,
              decoration: ShapeDecoration(
                shape: morphed!,
                color: Color.lerp(
                  inkGreen.withValues(alpha: 0.25),
                  inkTeal.withValues(alpha: 0.25),
                  t,
                ),
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              't=$t',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Color.lerp(inkGreen, inkTeal, t),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget lerpTimeline(String title, Color color, List<Widget> tiles) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
      ),
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
          SizedBox(height: 8.0),
          Wrap(alignment: WrapAlignment.center, children: tiles),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 12: scale() - the ratio wheel
  // ============================================================
  print('=== Section 12: scale operator ===');
  print('OutlinedBorder.scale(t) returns a copy with side*t and radius*t.');

  final scaleFactors = <double>[0.5, 1.0, 1.5, 2.0];
  final scaleBaseRect = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(12.0),
    side: BorderSide(color: inkBlue, width: 2.0),
  );
  final scaleBaseBevel = BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(16.0),
    side: BorderSide(color: inkOrange, width: 2.0),
  );

  final scaleRectTiles = <Widget>[];
  final scaleBevelTiles = <Widget>[];
  for (int i = 0; i < scaleFactors.length; i = i + 1) {
    final t = scaleFactors[i];
    final scaledRect = scaleBaseRect.scale(t) as RoundedRectangleBorder;
    final scaledBevel = scaleBaseBevel.scale(t) as BeveledRectangleBorder;
    print('scale($t) rounded -> side.width=${scaledRect.side.width}');
    print('scale($t) beveled -> side.width=${scaledBevel.side.width}');

    scaleRectTiles.add(
      Padding(
        padding: EdgeInsets.all(6.0),
        child: Column(
          children: [
            Container(
              width: 90.0,
              height: 60.0,
              decoration: ShapeDecoration(
                shape: scaledRect,
                color: inkBlue.withValues(alpha: 0.18),
              ),
            ),
            Text(
              'x$t',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: inkBlue,
              ),
            ),
          ],
        ),
      ),
    );
    scaleBevelTiles.add(
      Padding(
        padding: EdgeInsets.all(6.0),
        child: Column(
          children: [
            Container(
              width: 90.0,
              height: 60.0,
              decoration: ShapeDecoration(
                shape: scaledBevel,
                color: inkOrange.withValues(alpha: 0.18),
              ),
            ),
            Text(
              'x$t',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: inkOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 13: copyWith() - the bench dressing pattern
  // ============================================================
  print('=== Section 13: copyWith pattern ===');

  final baseDie = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16.0),
    side: BorderSide(color: inkBlue, width: 2.0),
  );
  final reSided = baseDie.copyWith(
    side: BorderSide(color: inkRed, width: 5.0),
  );
  final reRounded = baseDie.copyWith(borderRadius: BorderRadius.circular(40.0));
  final reBoth = baseDie.copyWith(
    side: BorderSide(color: inkGreen, width: 4.0),
    borderRadius: BorderRadius.circular(0.0),
  );
  print('copyWith re-sided -> ${reSided.side}');
  print('copyWith re-rounded -> ${reRounded.borderRadius}');
  print('copyWith both -> ${reBoth.side}, r=${reBoth.borderRadius}');

  Widget copyTile(String label, RoundedRectangleBorder die, Color color) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            width: 130.0,
            height: 70.0,
            decoration: ShapeDecoration(
              shape: die,
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.15),
                  color.withValues(alpha: 0.35),
                ],
              ),
              shadows: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 6.0,
                  offset: Offset(0.0, 3.0),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.0),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  final copyGrid = Wrap(
    alignment: WrapAlignment.center,
    children: [
      copyTile('base', baseDie, inkBlue),
      copyTile('copyWith(side:..)', reSided, inkRed),
      copyTile('copyWith(radius:40)', reRounded, inkBlue),
      copyTile('both replaced', reBoth, inkGreen),
    ],
  );

  // ============================================================
  // SECTION 14: Composition - ShapeDecoration + Material(shape:)
  // ============================================================
  print('=== Section 14: Composition with ShapeDecoration / Material ===');

  final compositionShapes = <Map<String, dynamic>>[
    {
      'shape': RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(color: inkBlue, width: 2.0),
      ),
      'color': inkBlue,
      'label': 'RoundedRect',
    },
    {
      'shape': StadiumBorder(side: BorderSide(color: inkGreen, width: 2.0)),
      'color': inkGreen,
      'label': 'Stadium',
    },
    {
      'shape': BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
        side: BorderSide(color: inkOrange, width: 2.0),
      ),
      'color': inkOrange,
      'label': 'Beveled',
    },
    {
      'shape': ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(28.0),
        side: BorderSide(color: inkPurple, width: 2.0),
      ),
      'color': inkPurple,
      'label': 'Continuous',
    },
    {
      'shape': CircleBorder(side: BorderSide(color: inkRed, width: 2.0)),
      'color': inkRed,
      'label': 'Circle',
    },
    {
      'shape': OvalBorder(side: BorderSide(color: inkTeal, width: 2.0)),
      'color': inkTeal,
      'label': 'Oval',
    },
  ];

  final shapeDecorationTiles = <Widget>[];
  final materialTiles = <Widget>[];
  for (int i = 0; i < compositionShapes.length; i = i + 1) {
    final entry = compositionShapes[i];
    final shape = entry['shape'] as ShapeBorder;
    final color = entry['color'] as Color;
    final label = entry['label'] as String;

    shapeDecorationTiles.add(
      Padding(
        padding: EdgeInsets.all(6.0),
        child: SizedBox(
          width: 110.0,
          height: 80.0,
          child: Container(
            decoration: ShapeDecoration(
              shape: shape,
              gradient: LinearGradient(
                colors: [
                  color.withValues(alpha: 0.2),
                  color.withValues(alpha: 0.5),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shadows: [
                BoxShadow(
                  color: color.withValues(alpha: 0.35),
                  blurRadius: 8.0,
                  offset: Offset(0.0, 4.0),
                ),
              ],
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ),
        ),
      ),
    );

    materialTiles.add(
      Padding(
        padding: EdgeInsets.all(6.0),
        child: SizedBox(
          width: 110.0,
          height: 80.0,
          child: Material(
            shape: shape,
            color: color.withValues(alpha: 0.18),
            elevation: 4.0,
            shadowColor: color.withValues(alpha: 0.6),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 15: getOuterPath / getInnerPath narrative
  // ============================================================
  print('=== Section 15: getOuterPath / getInnerPath narrative ===');
  print('Both paths take a Rect.  Outer = stamping silhouette.');
  print('Inner = the same silhouette deflated by side.width.');
  print('Flutter calls them when clipping children & painting the rim.');

  final pathNarrative = Container(
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFEFE4CC), Color(0xFFD9C49A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: walnut.withValues(alpha: 0.5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: walnut.withValues(alpha: 0.2),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: walnut, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Path API on every die',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: walnut,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _pathRow(
          'getOuterPath(rect, textDirection)',
          'returns the stamping silhouette - what a CustomClipper sees',
          inkBlue,
        ),
        _pathRow(
          'getInnerPath(rect, textDirection)',
          'returns outer.deflate(side.strokeInset) - the inset clip region',
          inkGreen,
        ),
        _pathRow(
          'paint(canvas, rect, textDirection)',
          'walks the side stroke around the outer path',
          inkOrange,
        ),
        _pathRow(
          'preferredSize / dimensions',
          'reports EdgeInsets.all(side.strokeInset)',
          inkPurple,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 16: Code examples
  // ============================================================
  print('=== Section 16: Code examples ===');

  final codeBlock = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFF1B1B1B),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: brass, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Bench cookbook',
              style: TextStyle(
                color: brass,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _codeChip(
          '// Workhorse rounded die\n'
          'final r = RoundedRectangleBorder(\n'
          '  borderRadius: BorderRadius.circular(16),\n'
          '  side: BorderSide(color: Colors.indigo, width: 2),\n'
          ');',
          Colors.lightBlue.shade200,
        ),
        SizedBox(height: 8.0),
        _codeChip(
          '// Pill-shaped chip\n'
          'final pill = StadiumBorder(\n'
          '  side: BorderSide(color: Colors.green, width: 2),\n'
          ');',
          Colors.lightGreen.shade200,
        ),
        SizedBox(height: 8.0),
        _codeChip(
          '// Morph rounded -> circle on a frame:\n'
          'final frame = ShapeBorder.lerp(r, CircleBorder(), 0.4);\n'
          '// frame is the bench-jig output - never call lerp inside paint!',
          Colors.amber.shade200,
        ),
        SizedBox(height: 8.0),
        _codeChip(
          '// Dress an existing die\n'
          'final dressed = r.copyWith(\n'
          '  side: BorderSide(color: Colors.red, width: 4),\n'
          ');',
          Colors.redAccent.shade100,
        ),
        SizedBox(height: 8.0),
        _codeChip(
          '// Scale the entire die uniformly\n'
          'final big = (r.scale(2.0)) as RoundedRectangleBorder;',
          Colors.orange.shade200,
        ),
        SizedBox(height: 8.0),
        _codeChip(
          '// Compose with Material\n'
          'Material(\n'
          '  shape: ContinuousRectangleBorder(\n'
          '    borderRadius: BorderRadius.circular(28),\n'
          '  ),\n'
          '  color: Colors.purple.shade50,\n'
          '  elevation: 4,\n'
          '  child: ...,\n'
          ');',
          Colors.purple.shade200,
        ),
      ],
    ),
  );

  print('=========================================================');
  print('Closing the chest.  All six dies, two parents, lerp, scale,');
  print('copyWith, getOuterPath narrative and code recipes presented.');
  print('=========================================================');

  // ============================================================
  // Final layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        hero,
        SizedBox(height: 24.0),

        _sectionTitle('1. ShapeBorder hierarchy', walnut),
        SizedBox(height: 8.0),
        hierarchy,
        SizedBox(height: 24.0),

        _sectionTitle('2. Anatomy of a cutting die', walnut),
        SizedBox(height: 8.0),
        anatomy,
        SizedBox(height: 24.0),

        _sectionTitle('3. RoundedRectangleBorder gallery', inkBlue),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: inkBlue.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: inkBlue.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: roundedTiles,
          ),
        ),
        SizedBox(height: 24.0),

        _sectionTitle('4. CircleBorder gallery', inkRed),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: inkRed.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: inkRed.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                children: circleTiles,
              ),
              SizedBox(height: 12.0),
              Text(
                'eccentricity knob (0.0 = circle, 1.0 = squashed)',
                style: TextStyle(
                  fontSize: 11.0,
                  color: inkRed,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 8.0),
              Wrap(
                alignment: WrapAlignment.center,
                children: eccentricTiles,
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        _sectionTitle('5. StadiumBorder gallery', inkGreen),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: inkGreen.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: inkGreen.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                children: stadiumTiles,
              ),
              stadiumNote,
            ],
          ),
        ),
        SizedBox(height: 24.0),

        _sectionTitle('6. BeveledRectangleBorder gallery', inkOrange),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: inkOrange.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: inkOrange.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: beveledTiles,
          ),
        ),
        SizedBox(height: 24.0),

        _sectionTitle('7. ContinuousRectangleBorder gallery', inkPurple),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: inkPurple.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: inkPurple.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Column(
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                children: continuousTiles,
              ),
              squircleNote,
            ],
          ),
        ),
        SizedBox(height: 24.0),

        _sectionTitle('8. OvalBorder gallery', inkTeal),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: inkTeal.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: inkTeal.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: ovalTiles,
          ),
        ),
        SizedBox(height: 24.0),

        _sectionTitle('9. BorderSide rim styles', walnut),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: walnut.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: walnut.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Wrap(
            alignment: WrapAlignment.center,
            children: sideTiles,
          ),
        ),
        SizedBox(height: 24.0),

        _sectionTitle('10. lerp() morphing bench', walnut),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [paper, Color(0xFFE9DCB7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(14.0),
            border: Border.all(
              color: walnut.withValues(alpha: 0.4),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: walnut.withValues(alpha: 0.18),
                blurRadius: 6.0,
                offset: Offset(0.0, 3.0),
              ),
            ],
          ),
          child: Column(
            children: [
              lerpTimeline(
                'RoundedRectangleBorder  ->  CircleBorder',
                inkBlue,
                lerpAbTiles,
              ),
              lerpTimeline(
                'BeveledRectangleBorder  ->  ContinuousRectangleBorder',
                inkOrange,
                lerpCdTiles,
              ),
              lerpTimeline(
                'StadiumBorder  ->  OvalBorder',
                inkGreen,
                lerpEfTiles,
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        _sectionTitle('11. scale() ratio wheel', inkBlue),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: inkBlue.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: inkBlue.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Column(
            children: [
              Text(
                'RoundedRectangleBorder.scale(t) - radius and side both scale',
                style: TextStyle(
                  fontSize: 11.0,
                  color: inkBlue,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 6.0),
              Wrap(
                alignment: WrapAlignment.center,
                children: scaleRectTiles,
              ),
              SizedBox(height: 14.0),
              Text(
                'BeveledRectangleBorder.scale(t)',
                style: TextStyle(
                  fontSize: 11.0,
                  color: inkOrange,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 6.0),
              Wrap(
                alignment: WrapAlignment.center,
                children: scaleBevelTiles,
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        _sectionTitle('12. copyWith() bench dressing', inkRed),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: inkRed.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: inkRed.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: copyGrid,
        ),
        SizedBox(height: 24.0),

        _sectionTitle('13. ShapeDecoration composition', inkPurple),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: inkPurple.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: inkPurple.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Column(
            children: [
              Text(
                'Container( decoration: ShapeDecoration(shape: ...) )',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: inkPurple,
                ),
              ),
              SizedBox(height: 8.0),
              Wrap(
                alignment: WrapAlignment.center,
                children: shapeDecorationTiles,
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),

        _sectionTitle('14. Material(shape:) composition', inkGreen),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: inkGreen.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: inkGreen.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Column(
            children: [
              Text(
                'Material(shape: ..., elevation: 4)',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: inkGreen,
                ),
              ),
              SizedBox(height: 8.0),
              Wrap(
                alignment: WrapAlignment.center,
                children: materialTiles,
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        _sectionTitle('15. getOuterPath / getInnerPath', walnut),
        SizedBox(height: 8.0),
        pathNarrative,
        SizedBox(height: 24.0),

        _sectionTitle('16. Bench cookbook', brass),
        SizedBox(height: 8.0),
        codeBlock,
        SizedBox(height: 32.0),

        // Closing strip
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [walnut, Color(0xFF3A240F)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
                blurRadius: 12.0,
                offset: Offset(0.0, 6.0),
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(Icons.lock_outline, color: brass, size: 36.0),
              SizedBox(height: 8.0),
              Text(
                'Chest closed.  Dies oiled, jigs aligned.',
                style: TextStyle(
                  color: paper,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'six concrete OutlinedBorders ready for tomorrow\'s pressing',
                style: TextStyle(
                  color: brass,
                  fontStyle: FontStyle.italic,
                  fontSize: 11.0,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------- Helpers (top-level) ----------------

Widget _sectionTitle(String title, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
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
      title,
      style: TextStyle(
        fontSize: 17.0,
        fontWeight: FontWeight.bold,
        color: color,
        letterSpacing: 0.5,
      ),
    ),
  );
}

Widget _pathRow(String head, String body, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.only(top: 6.0, right: 8.0),
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                head,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              Text(
                body,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.brown.shade900,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _codeChip(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF2A2A2A),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: textColor.withValues(alpha: 0.3), width: 1.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
        height: 1.4,
      ),
    ),
  );
}
