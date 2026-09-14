// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Gradient from painting
// Deep Demo: Visual demonstration of LinearGradient, RadialGradient,
// SweepGradient, TileMode, color stops, lerp, scale, and footguns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Gradient Deep Demo executing');

  // ============================================================
  // SECTION 1: Title banner
  // ============================================================
  print('=== Section 1: Title banner ===');

  final titleBanner = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.green,
          Colors.blue,
          Colors.indigo,
          Colors.purple,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 8.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.gradient, size: 64.0, color: Colors.white),
        SizedBox(height: 8.0),
        Text(
          'Gradient',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 2.0,
          ),
        ),
        Text(
          'Linear · Radial · Sweep',
          style: TextStyle(fontSize: 16.0, color: Colors.white70),
        ),
        SizedBox(height: 4.0),
        Text(
          'package:flutter/painting.dart',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.white60,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
  print('Title banner created');

  // ============================================================
  // SECTION 2: Anatomy of a gradient
  // ============================================================
  print('=== Section 2: Anatomy ===');

  final anatomyColors = [
    Colors.red,
    Colors.amber,
    Colors.green,
    Colors.blue,
    Colors.purple,
  ];
  final anatomyStops = [0.0, 0.25, 0.5, 0.75, 1.0];

  final anatomyStrip = Container(
    height: 70.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: anatomyColors,
        stops: anatomyStops,
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.2),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
  );

  final anatomyChips = Wrap(
    spacing: 6.0,
    runSpacing: 6.0,
    children: [
      _buildAxisChip('begin: centerLeft', Colors.indigo),
      _buildAxisChip('end: centerRight', Colors.indigo),
      _buildAxisChip('5 colors', Colors.teal),
      _buildAxisChip('5 stops', Colors.teal),
      _buildAxisChip('tileMode: clamp', Colors.brown),
    ],
  );

  final anatomyCard = Container(
    margin: EdgeInsets.symmetric(vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Anatomy: colors + stops + axis',
          style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        anatomyStrip,
        SizedBox(height: 8.0),
        // Stops scale
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final s in anatomyStops)
              Text(
                s.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 10.0,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade700,
                ),
              ),
          ],
        ),
        SizedBox(height: 12.0),
        anatomyChips,
      ],
    ),
  );
  print('Anatomy card created');

  // ============================================================
  // SECTION 3: LinearGradient constructor — 6 examples
  // ============================================================
  print('=== Section 3: LinearGradient ===');

  final linearExamples = <Widget>[];
  final linearConfigs = [
    {
      'label': 'topLeft → bottomRight',
      'begin': Alignment.topLeft,
      'end': Alignment.bottomRight,
      'colors': [Colors.red, Colors.yellow],
    },
    {
      'label': 'topRight → bottomLeft',
      'begin': Alignment.topRight,
      'end': Alignment.bottomLeft,
      'colors': [Colors.green, Colors.blue],
    },
    {
      'label': 'topCenter → bottomCenter',
      'begin': Alignment.topCenter,
      'end': Alignment.bottomCenter,
      'colors': [Colors.indigo, Colors.purple, Colors.pink],
    },
    {
      'label': 'centerLeft → centerRight',
      'begin': Alignment.centerLeft,
      'end': Alignment.centerRight,
      'colors': [Colors.cyan, Colors.lightBlue, Colors.blue],
    },
    {
      'label': '(-1,-1) → (1,1) custom',
      'begin': Alignment(-1.0, -1.0),
      'end': Alignment(1.0, 1.0),
      'colors': [Colors.orange, Colors.deepOrange, Colors.red],
    },
    {
      'label': '(0,-1) → (0,1) vertical',
      'begin': Alignment(0.0, -1.0),
      'end': Alignment(0.0, 1.0),
      'colors': [Colors.teal, Colors.lime, Colors.amber],
    },
  ];

  for (final cfg in linearConfigs) {
    final label = cfg['label'] as String;
    final begin = cfg['begin'] as Alignment;
    final end = cfg['end'] as Alignment;
    final colors = cfg['colors'] as List<Color>;
    print('LinearGradient $label colors=${colors.length}');

    linearExamples.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 100.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: colors,
                  begin: begin,
                  end: end,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade900,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Wrap(
                    spacing: 4.0,
                    runSpacing: 4.0,
                    children: [
                      for (final c in colors) _buildSwatch(c),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${linearExamples.length} LinearGradient examples');

  // ============================================================
  // SECTION 4: RadialGradient constructor — 6 examples
  // ============================================================
  print('=== Section 4: RadialGradient ===');

  final radialExamples = <Widget>[];
  final radialConfigs = [
    {
      'label': 'center, r=0.5',
      'center': Alignment.center,
      'radius': 0.5,
      'focal': null,
      'focalRadius': 0.0,
      'colors': [Colors.yellow, Colors.orange, Colors.red],
    },
    {
      'label': 'topLeft, r=1.0',
      'center': Alignment.topLeft,
      'radius': 1.0,
      'focal': null,
      'focalRadius': 0.0,
      'colors': [Colors.white, Colors.lightBlue, Colors.blue],
    },
    {
      'label': 'bottomRight, r=0.8',
      'center': Alignment.bottomRight,
      'radius': 0.8,
      'focal': null,
      'focalRadius': 0.0,
      'colors': [Colors.pink.shade100, Colors.purple, Colors.indigo],
    },
    {
      'label': 'focal off-center',
      'center': Alignment.center,
      'radius': 0.7,
      'focal': Alignment(-0.5, -0.5),
      'focalRadius': 0.05,
      'colors': [Colors.white, Colors.amber, Colors.deepOrange],
    },
    {
      'label': 'tight r=0.3',
      'center': Alignment.center,
      'radius': 0.3,
      'focal': null,
      'focalRadius': 0.0,
      'colors': [Colors.greenAccent, Colors.green.shade900],
    },
    {
      'label': 'wide r=1.5',
      'center': Alignment.center,
      'radius': 1.5,
      'focal': null,
      'focalRadius': 0.0,
      'colors': [Colors.cyan, Colors.teal, Colors.blueGrey.shade900],
    },
  ];

  for (final cfg in radialConfigs) {
    final label = cfg['label'] as String;
    final center = cfg['center'] as Alignment;
    final radius = cfg['radius'] as double;
    final focal = cfg['focal'] as Alignment?;
    final focalRadius = cfg['focalRadius'] as double;
    final colors = cfg['colors'] as List<Color>;
    print('RadialGradient $label r=$radius');

    radialExamples.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 110.0,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: colors,
                  center: center,
                  radius: radius,
                  focal: focal,
                  focalRadius: focalRadius,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple.shade700,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'r=$radius  focal=${focal == null ? "—" : "off"}',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Wrap(
                    spacing: 4.0,
                    runSpacing: 4.0,
                    children: [
                      for (final c in colors) _buildSwatch(c),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${radialExamples.length} RadialGradient examples');

  // ============================================================
  // SECTION 5: SweepGradient constructor — 6 examples
  // ============================================================
  print('=== Section 5: SweepGradient ===');

  final sweepExamples = <Widget>[];
  final sweepConfigs = [
    {
      'label': 'full sweep 0..2π',
      'startAngle': 0.0,
      'endAngle': 6.283185,
      'center': Alignment.center,
      'colors': [
        Colors.red,
        Colors.yellow,
        Colors.green,
        Colors.cyan,
        Colors.blue,
        Colors.purple,
        Colors.red,
      ],
    },
    {
      'label': 'half sweep 0..π',
      'startAngle': 0.0,
      'endAngle': 3.141592,
      'center': Alignment.center,
      'colors': [Colors.orange, Colors.deepOrange, Colors.red],
    },
    {
      'label': 'quarter 0..π/2',
      'startAngle': 0.0,
      'endAngle': 1.570796,
      'center': Alignment.center,
      'colors': [Colors.lightGreen, Colors.green, Colors.teal],
    },
    {
      'label': 'rotated π/4..5π/4',
      'startAngle': 0.785398,
      'endAngle': 3.926990,
      'center': Alignment.center,
      'colors': [Colors.pink, Colors.purple, Colors.indigo],
    },
    {
      'label': 'centered top, sweep',
      'startAngle': 0.0,
      'endAngle': 6.283185,
      'center': Alignment.topCenter,
      'colors': [Colors.amber, Colors.yellow, Colors.amber],
    },
    {
      'label': 'mood ring sweep',
      'startAngle': 0.0,
      'endAngle': 6.283185,
      'center': Alignment.center,
      'colors': [
        Colors.blue,
        Colors.purple,
        Colors.pink,
        Colors.orange,
        Colors.yellow,
        Colors.green,
        Colors.blue,
      ],
    },
  ];

  for (final cfg in sweepConfigs) {
    final label = cfg['label'] as String;
    final startAngle = cfg['startAngle'] as double;
    final endAngle = cfg['endAngle'] as double;
    final center = cfg['center'] as Alignment;
    final colors = cfg['colors'] as List<Color>;
    print('SweepGradient $label start=$startAngle end=$endAngle');

    sweepExamples.add(
      Container(
        width: 220.0,
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 8.0,
              offset: Offset(0.0, 4.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 130.0,
              decoration: BoxDecoration(
                gradient: SweepGradient(
                  colors: colors,
                  startAngle: startAngle,
                  endAngle: endAngle,
                  center: center,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12.0),
                  topRight: Radius.circular(12.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink.shade700,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Δ=${(endAngle - startAngle).toStringAsFixed(2)} rad',
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 6.0),
                  Wrap(
                    spacing: 4.0,
                    runSpacing: 4.0,
                    children: [
                      for (final c in colors) _buildSwatch(c),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${sweepExamples.length} SweepGradient examples');

  // ============================================================
  // SECTION 6: TileMode catalogue — 4 cards
  // ============================================================
  print('=== Section 6: TileMode catalogue ===');

  final tileModeCards = <Widget>[];
  final tileModes = [
    {
      'mode': TileMode.clamp,
      'name': 'clamp',
      'description': 'Edge colors extend',
      'color': Colors.blue,
    },
    {
      'mode': TileMode.repeated,
      'name': 'repeated',
      'description': 'Pattern repeats',
      'color': Colors.green,
    },
    {
      'mode': TileMode.mirror,
      'name': 'mirror',
      'description': 'Pattern mirrors',
      'color': Colors.purple,
    },
    {
      'mode': TileMode.decal,
      'name': 'decal',
      'description': 'Outside is transparent',
      'color': Colors.orange,
    },
  ];

  for (final tm in tileModes) {
    final mode = tm['mode'] as TileMode;
    final name = tm['name'] as String;
    final description = tm['description'] as String;
    final color = tm['color'] as Color;
    print('TileMode.$name');

    tileModeCards.add(
      Container(
        width: 230.0,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: color, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.25),
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
                Icon(Icons.texture, color: color, size: 20.0),
                SizedBox(width: 6.0),
                Text(
                  'TileMode.$name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: color,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Container(
              height: 70.0,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                gradient: LinearGradient(
                  colors: [color, Colors.white],
                  stops: [0.0, 0.25],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  tileMode: mode,
                ),
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              description,
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${tileModeCards.length} TileMode cards');

  // ============================================================
  // SECTION 7: Color stops — uniform / weighted / exact
  // ============================================================
  print('=== Section 7: Color stops ===');

  final stopsCards = <Widget>[];
  final stopsConfigs = [
    {
      'label': 'uniform stops',
      'colors': [Colors.red, Colors.green, Colors.blue],
      'stops': [0.0, 0.5, 1.0],
      'description': 'Even spacing, soft blends',
    },
    {
      'label': 'weighted toward end',
      'colors': [Colors.red, Colors.green, Colors.blue],
      'stops': [0.0, 0.85, 1.0],
      'description': 'Last color barely shows',
    },
    {
      'label': 'weighted toward start',
      'colors': [Colors.red, Colors.green, Colors.blue],
      'stops': [0.0, 0.15, 1.0],
      'description': 'First color barely shows',
    },
    {
      'label': 'hard stops (bands)',
      'colors': [
        Colors.red,
        Colors.red,
        Colors.yellow,
        Colors.yellow,
        Colors.green,
        Colors.green,
      ],
      'stops': [0.0, 0.33, 0.33, 0.66, 0.66, 1.0],
      'description': 'Repeated stop = sharp band',
    },
    {
      'label': 'exact-coloured 4 bands',
      'colors': [
        Colors.cyan,
        Colors.cyan,
        Colors.blue,
        Colors.blue,
        Colors.indigo,
        Colors.indigo,
        Colors.purple,
        Colors.purple,
      ],
      'stops': [0.0, 0.25, 0.25, 0.5, 0.5, 0.75, 0.75, 1.0],
      'description': '4 hard-edged colour bands',
    },
  ];

  for (final cfg in stopsConfigs) {
    final label = cfg['label'] as String;
    final colors = cfg['colors'] as List<Color>;
    final stops = cfg['stops'] as List<double>;
    final description = cfg['description'] as String;
    print('Stops: $label (${stops.length} stops)');

    stopsCards.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade300, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
                color: Colors.indigo.shade900,
              ),
            ),
            SizedBox(height: 6.0),
            Container(
              height: 48.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: colors,
                  stops: stops,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(6.0),
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              'stops: ${stops.map((s) => s.toStringAsFixed(2)).join(", ")}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: Colors.grey.shade700,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              description,
              style: TextStyle(
                fontSize: 10.0,
                color: Colors.grey.shade600,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${stopsCards.length} stops cards');

  // ============================================================
  // SECTION 8: Combining gradients — layered foreground/background
  // ============================================================
  print('=== Section 8: Combining gradients ===');

  final combinedTopBg = LinearGradient(
    colors: [Colors.indigo.shade900, Colors.deepPurple.shade700],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final combinedTopFg = RadialGradient(
    colors: [
      Colors.amberAccent.withValues(alpha: 0.6),
      Colors.transparent,
    ],
    center: Alignment(-0.4, -0.6),
    radius: 0.7,
  );

  final combinedCard = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(0.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.4),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14.0),
      child: Stack(
        children: [
          Container(
            height: 160.0,
            decoration: BoxDecoration(gradient: combinedTopBg),
          ),
          Container(
            height: 160.0,
            decoration: BoxDecoration(gradient: combinedTopFg),
          ),
          Positioned(
            left: 16.0,
            bottom: 16.0,
            child: Text(
              'Layered: linear under radial highlight',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Second composite: sweep base + linear vignette
  final combinedTwoBg = SweepGradient(
    colors: [
      Colors.pink,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.pink,
    ],
    center: Alignment.center,
  );
  final combinedTwoFg = RadialGradient(
    colors: [
      Colors.transparent,
      Colors.black.withValues(alpha: 0.55),
    ],
    center: Alignment.center,
    radius: 0.95,
  );

  final combinedCard2 = Container(
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.pink.withValues(alpha: 0.35),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(14.0),
      child: Stack(
        children: [
          Container(
            height: 160.0,
            decoration: BoxDecoration(gradient: combinedTwoBg),
          ),
          Container(
            height: 160.0,
            decoration: BoxDecoration(gradient: combinedTwoFg),
          ),
          Positioned(
            left: 16.0,
            bottom: 16.0,
            child: Text(
              'Sweep + radial vignette',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  print('Combined gradient cards created');

  // ============================================================
  // SECTION 9: Real-world mocks
  // ============================================================
  print('=== Section 9: Real-world mocks ===');

  // Hero banner
  final heroBanner = Container(
    height: 140.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple, Colors.pink, Colors.orange],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.4),
          blurRadius: 12.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(Icons.rocket_launch, color: Colors.white, size: 48.0),
        SizedBox(width: 16.0),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hero Banner',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Tri-stop sunset gradient',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13.0,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // Button highlight
  final buttonHighlight = Container(
    margin: EdgeInsets.all(8.0),
    height: 56.0,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.lightBlueAccent, Colors.blue, Colors.indigo],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(28.0),
      boxShadow: [
        BoxShadow(
          color: Colors.blue.withValues(alpha: 0.45),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Center(
      child: Text(
        'GRADIENT BUTTON',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14.0,
          letterSpacing: 1.5,
        ),
      ),
    ),
  );

  // Progress meter
  final progressMeter = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progress meter (0 → 100%)',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          height: 18.0,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(9.0),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.72,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.red, Colors.orange, Colors.yellow, Colors.green],
                  stops: [0.0, 0.4, 0.7, 1.0],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(9.0),
              ),
            ),
          ),
        ),
      ],
    ),
  );

  // Mood ring
  final moodRing = Container(
    width: 140.0,
    height: 140.0,
    margin: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      gradient: SweepGradient(
        colors: [
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.green,
          Colors.blue,
          Colors.indigo,
          Colors.purple,
          Colors.red,
        ],
        center: Alignment.center,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Center(
      child: Container(
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Center(
          child: Icon(Icons.mood, color: Colors.deepPurple, size: 36.0),
        ),
      ),
    ),
  );

  print('Real-world mocks created');

  // ============================================================
  // SECTION 10: lerp(a, b, t) interpolation
  // ============================================================
  print('=== Section 10: lerp(a, b, t) ===');

  final lerpA = LinearGradient(
    colors: [Colors.red, Colors.yellow],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final lerpB = LinearGradient(
    colors: [Colors.blue, Colors.purple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  final lerpTs = [0.0, 0.25, 0.5, 0.75, 1.0];
  final lerpCards = <Widget>[];

  for (final t in lerpTs) {
    final lerped = LinearGradient.lerp(lerpA, lerpB, t);
    print('LinearGradient.lerp(t=$t)');

    lerpCards.add(
      Container(
        width: 130.0,
        margin: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 80.0,
              decoration: BoxDecoration(
                gradient: lerped,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    't = ${t.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo.shade900,
                    ),
                  ),
                  SizedBox(height: 2.0),
                  Text(
                    t == 0.0
                        ? 'pure A'
                        : t == 1.0
                            ? 'pure B'
                            : 'mix',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey.shade600,
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
  print('Created ${lerpCards.length} lerp cards');

  // ============================================================
  // SECTION 11: scale(t) for opacity-style fade
  // ============================================================
  print('=== Section 11: scale(t) ===');

  final scaleBase = LinearGradient(
    colors: [Colors.green, Colors.teal, Colors.blue],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  final scaleTs = [1.0, 0.8, 0.6, 0.4, 0.2, 0.0];
  final scaleCards = <Widget>[];

  for (final t in scaleTs) {
    final scaled = scaleBase.scale(t);
    print('scale($t)');

    scaleCards.add(
      Container(
        width: 110.0,
        margin: EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.grey.shade300, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 70.0,
              decoration: BoxDecoration(
                gradient: scaled,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'scale(${t.toStringAsFixed(1)})',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${scaleCards.length} scale cards');

  // ============================================================
  // SECTION 12: Footguns
  // ============================================================
  print('=== Section 12: Footguns ===');

  final footgunsCard = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.red.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
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
            Icon(Icons.warning_amber, color: Colors.red.shade700, size: 22.0),
            SizedBox(width: 6.0),
            Text(
              'Footguns',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: Colors.red.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildFootgun(
          'stops length mismatch',
          'stops.length must equal colors.length, otherwise '
              'the gradient throws at paint time.',
          Colors.red,
        ),
        _buildFootgun(
          'begin/end outside [-1, 1]',
          'AlignmentGeometry uses -1..1 for the box. Values '
              'outside still work but extrapolate the start/end '
              'points beyond the box.',
          Colors.deepOrange,
        ),
        _buildFootgun(
          'TileMode.repeated needs a periodic palette',
          'A 2-colour gradient with TileMode.repeated produces '
              'visible seams. Use a palindrome (A,B,A) or '
              'TileMode.mirror.',
          Colors.amber.shade800,
        ),
        _buildFootgun(
          'SweepGradient performance',
          'Sweep gradients are more expensive than linear and can '
              'jank during animation. Cache shaders or pre-render '
              'into an image when possible.',
          Colors.purple,
        ),
        _buildFootgun(
          'Transparent stops produce grey',
          'Lerping through transparent stops blends towards rgba(0,0,0,0). '
              'Use a transparent version of the *neighbouring* colour, '
              'e.g. red.withValues(alpha: 0).',
          Colors.indigo,
        ),
      ],
    ),
  );
  print('Footguns card created');

  // ============================================================
  // SECTION 13: Recap card
  // ============================================================
  print('=== Section 13: Recap ===');

  final recapCard = Container(
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.purple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.15),
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
            Icon(Icons.menu_book, color: Colors.indigo.shade700, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Recap',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildRecapBullet('Gradient is the abstract base of '
            'LinearGradient, RadialGradient and SweepGradient.'),
        _buildRecapBullet('All three accept colors, stops, transform '
            'and tileMode.'),
        _buildRecapBullet('LinearGradient: begin & end alignments.'),
        _buildRecapBullet('RadialGradient: center, radius, focal, '
            'focalRadius.'),
        _buildRecapBullet('SweepGradient: center, startAngle, endAngle.'),
        _buildRecapBullet('TileMode controls behaviour outside [0,1]: '
            'clamp, repeated, mirror, decal.'),
        _buildRecapBullet('createShader(Rect) builds a dart:ui Shader.'),
        _buildRecapBullet('lerp(a, b, t) interpolates between two '
            'gradients of the same kind.'),
        _buildRecapBullet('scale(t) returns a copy with each color '
            'multiplied by t — useful for fade-outs.'),
        _buildRecapBullet('Use BoxDecoration(gradient: ...) for the '
            'easiest path; or paint manually with a Paint and Shader.'),
      ],
    ),
  );
  print('Recap card created');

  print('Gradient Deep Demo completed successfully');

  // ============================================================
  // Final layout
  // ============================================================
  return Scaffold(
    backgroundColor: Colors.grey.shade100,
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Title banner
          titleBanner,
          SizedBox(height: 24.0),

          // Section 2: Anatomy
          _buildSectionHeader('1. Anatomy of a gradient', Colors.teal),
          anatomyCard,
          SizedBox(height: 24.0),

          // Section 3: LinearGradient
          _buildSectionHeader('2. LinearGradient', Colors.indigo),
          Wrap(
            alignment: WrapAlignment.center,
            children: linearExamples,
          ),
          SizedBox(height: 24.0),

          // Section 4: RadialGradient
          _buildSectionHeader('3. RadialGradient', Colors.deepPurple),
          Wrap(
            alignment: WrapAlignment.center,
            children: radialExamples,
          ),
          SizedBox(height: 24.0),

          // Section 5: SweepGradient
          _buildSectionHeader('4. SweepGradient', Colors.pink),
          Wrap(
            alignment: WrapAlignment.center,
            children: sweepExamples,
          ),
          SizedBox(height: 24.0),

          // Section 6: TileMode
          _buildSectionHeader('5. TileMode catalogue', Colors.brown),
          Wrap(
            alignment: WrapAlignment.center,
            children: tileModeCards,
          ),
          SizedBox(height: 24.0),

          // Section 7: Color stops
          _buildSectionHeader('6. Color stops', Colors.green),
          ...stopsCards,
          SizedBox(height: 24.0),

          // Section 8: Combining
          _buildSectionHeader('7. Combining gradients', Colors.orange),
          combinedCard,
          combinedCard2,
          SizedBox(height: 24.0),

          // Section 9: Real-world mocks
          _buildSectionHeader('8. Real-world mocks', Colors.purple),
          heroBanner,
          buttonHighlight,
          progressMeter,
          Center(child: moodRing),
          SizedBox(height: 24.0),

          // Section 10: lerp
          _buildSectionHeader('9. lerp(a, b, t)', Colors.cyan),
          Wrap(
            alignment: WrapAlignment.center,
            children: lerpCards,
          ),
          SizedBox(height: 24.0),

          // Section 11: scale
          _buildSectionHeader('10. scale(t) opacity-style fade', Colors.teal),
          Wrap(
            alignment: WrapAlignment.center,
            children: scaleCards,
          ),
          SizedBox(height: 24.0),

          // Section 12: Footguns
          _buildSectionHeader('11. Footguns', Colors.red),
          footgunsCard,
          SizedBox(height: 24.0),

          // Section 13: Recap
          _buildSectionHeader('12. Recap', Colors.indigo),
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

// Helper: Build a section header
Widget _buildSectionHeader(String text, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 12.0, top: 8.0),
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: color, width: 4.0),
      ),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    ),
  );
}

// Helper: Build a small color swatch
Widget _buildSwatch(Color color) {
  return Container(
    width: 18.0,
    height: 18.0,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: Colors.black26, width: 0.5),
    ),
  );
}

// Helper: Build an axis chip
Widget _buildAxisChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.withValues(alpha: 0.5), width: 1.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 10.0,
        fontFamily: 'monospace',
        color: color,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

// Helper: Build a footgun row
Widget _buildFootgun(String title, String description, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border(
        left: BorderSide(color: color, width: 4.0),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            color: color,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.grey.shade800,
          ),
        ),
      ],
    ),
  );
}

// Helper: Build a recap bullet
Widget _buildRecapBullet(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: Icon(
            Icons.check_circle,
            size: 14.0,
            color: Colors.indigo.shade400,
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade800,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
