// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Simulation subclasses from flutter/physics
// Deep Demo: Visual demonstration of physics simulations — gravity, friction,
// spring (under/critical/over-damped), scroll spring, bouncing scroll, and
// clamping scroll. Computes real .x(t)/.dx(t)/.isDone(t) values and plots
// them as bar charts, line indicators and comparison panels.
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

dynamic build(BuildContext context) {
  print('Physics Simulations Deep Demo executing');

  // ============================================================
  // SECTION 1: Physics Simulations Overview
  // ============================================================
  print('=== Section 1: Physics Simulations Overview ===');

  final overviewCards = <Widget>[];

  // Concept 1: Gravity
  overviewCards.add(
    Container(
      width: 170.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade50, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.indigo.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.arrow_downward, size: 40.0, color: Colors.indigo),
          SizedBox(height: 10.0),
          Text(
            'GravitySimulation',
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Constant acceleration\nuntil endDistance is reached',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.5, color: Colors.indigo.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 2: Friction
  overviewCards.add(
    Container(
      width: 170.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.orange.shade50, Colors.amber.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.orange.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.air, size: 40.0, color: Colors.orange),
          SizedBox(height: 10.0),
          Text(
            'FrictionSimulation',
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Exponential drag\non a moving particle',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.5, color: Colors.orange.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 3: Spring
  overviewCards.add(
    Container(
      width: 170.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade50, Colors.cyan.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.teal.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.waves, size: 40.0, color: Colors.teal),
          SizedBox(height: 10.0),
          Text(
            'SpringSimulation',
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Mass-spring-damper\nF = -kx - cv',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.5, color: Colors.teal.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 4: Scroll Spring
  overviewCards.add(
    Container(
      width: 170.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade50, Colors.pink.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.purple.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.swap_vert, size: 40.0, color: Colors.purple),
          SizedBox(height: 10.0),
          Text(
            'Scroll Simulations',
            style: TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.bold,
              color: Colors.purple.shade900,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Bouncing, clamping\nand spring scroll',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10.5, color: Colors.purple.shade700),
          ),
        ],
      ),
    ),
  );
  print('Created ${overviewCards.length} overview cards');

  // ============================================================
  // SECTION 2: GravitySimulation — Free Fall
  // ============================================================
  print('=== Section 2: GravitySimulation ===');

  // Earth-like gravity: 9.8 m/s^2, start at 0, target 100m, no initial velocity
  final earthGravity = GravitySimulation(9.8, 0.0, 100.0, 0.0);
  print('GravitySimulation(accel=9.8, distance=0, endDistance=100, vel=0):');

  // Sample positions across the fall
  final gravityTimes = <double>[0.0, 0.5, 1.0, 1.5, 2.0, 2.5, 3.0, 4.0, 5.0];
  final gravitySamples = <Map<String, dynamic>>[];
  for (final t in gravityTimes) {
    final x = earthGravity.x(t);
    final dx = earthGravity.dx(t);
    final done = earthGravity.isDone(t);
    print(
      '  t=$t: x=${x.toStringAsFixed(3)}, dx=${dx.toStringAsFixed(3)}, isDone=$done',
    );
    gravitySamples.add({'t': t, 'x': x, 'dx': dx, 'isDone': done});
  }

  // Tossed upward: negative initial velocity
  final tossUp = GravitySimulation(9.8, 0.0, 100.0, -25.0);
  print('GravitySimulation(accel=9.8, dist=0, end=100, vel=-25):');
  final tossSamples = <Map<String, dynamic>>[];
  for (final t in <double>[0.0, 0.5, 1.0, 1.5, 2.0, 3.0, 4.0]) {
    final x = tossUp.x(t);
    final dx = tossUp.dx(t);
    print('  t=$t: x=${x.toStringAsFixed(3)}, dx=${dx.toStringAsFixed(3)}');
    tossSamples.add({'t': t, 'x': x, 'dx': dx});
  }

  // Build a position bar chart for the earth-gravity case
  final gravityBarChart = <Widget>[];
  for (final s in gravitySamples) {
    final x = s['x'] as double;
    final t = s['t'] as double;
    final done = s['isDone'] as bool;
    final h = (x.clamp(0.0, 100.0) / 100.0) * 110.0 + 6.0;
    gravityBarChart.add(
      Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                x.toStringAsFixed(0),
                style: TextStyle(
                  fontSize: 9.0,
                  color: Colors.indigo.shade900,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 2.0),
              Container(
                height: h,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: done
                        ? [Colors.grey.shade400, Colors.grey.shade600]
                        : [Colors.indigo.shade300, Colors.indigo.shade700],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                't=${t.toStringAsFixed(1)}',
                style: TextStyle(fontSize: 9.0, color: Colors.indigo.shade700),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final gravityPanel = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.indigo.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.arrow_downward, color: Colors.indigo, size: 20.0),
            SizedBox(width: 6.0),
            Text(
              'Free Fall — accel=9.8, target=100',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        SizedBox(
          height: 150.0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: gravityBarChart,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Each bar = x(t) clamped to endDistance. Grey bars mark isDone=true.',
          style: TextStyle(fontSize: 11.0, color: Colors.indigo.shade700),
        ),
      ],
    ),
  );

  // Toss-up velocity arrows
  final tossRows = <Widget>[];
  for (final s in tossSamples) {
    final t = s['t'] as double;
    final x = s['x'] as double;
    final dx = s['dx'] as double;
    final goingUp = dx < 0.0;
    tossRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 12.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: goingUp ? Colors.red.shade50 : Colors.green.shade50,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            color: goingUp ? Colors.red.shade200 : Colors.green.shade200,
          ),
        ),
        child: Row(
          children: [
            Icon(
              goingUp ? Icons.arrow_upward : Icons.arrow_downward,
              size: 16.0,
              color: goingUp ? Colors.red : Colors.green,
            ),
            SizedBox(width: 8.0),
            SizedBox(
              width: 60.0,
              child: Text(
                't=${t.toStringAsFixed(1)}s',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'x=${x.toStringAsFixed(2)}  dx=${dx.toStringAsFixed(2)}',
                style: TextStyle(fontFamily: 'monospace', fontSize: 11.0),
              ),
            ),
            Text(
              goingUp ? 'rising' : 'falling',
              style: TextStyle(
                fontSize: 10.5,
                color: goingUp ? Colors.red.shade700 : Colors.green.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: FrictionSimulation — Drag Decay
  // ============================================================
  print('=== Section 3: FrictionSimulation ===');

  // Three drag coefficients for the same initial velocity
  final frictionCases = <Map<String, dynamic>>[
    {
      'label': 'Weak drag (0.02)',
      'sim': FrictionSimulation(0.02, 0.0, 200.0),
      'color': Colors.cyan,
    },
    {
      'label': 'Standard drag (0.135)',
      'sim': FrictionSimulation(0.135, 0.0, 200.0),
      'color': Colors.orange,
    },
    {
      'label': 'Strong drag (0.5)',
      'sim': FrictionSimulation(0.5, 0.0, 200.0),
      'color': Colors.red,
    },
  ];

  final frictionPanels = <Widget>[];
  for (final fc in frictionCases) {
    final sim = fc['sim'] as FrictionSimulation;
    final color = fc['color'] as Color;
    final label = fc['label'] as String;

    print('$label:');
    final samples = <Map<String, double>>[];
    final times = <double>[0.0, 0.25, 0.5, 0.75, 1.0, 1.5, 2.0, 3.0, 5.0];
    for (final t in times) {
      final x = sim.x(t);
      final dx = sim.dx(t);
      print(
        '  t=$t: x=${x.toStringAsFixed(3)}, dx=${dx.toStringAsFixed(3)}',
      );
      samples.add({'t': t, 'x': x, 'dx': dx});
    }

    // Max x for normalization
    double maxX = 0.0;
    for (final s in samples) {
      if (s['x']! > maxX) maxX = s['x']!;
    }
    if (maxX <= 0.0) maxX = 1.0;

    // Velocity decay bars
    double maxV = 0.0;
    for (final s in samples) {
      final v = s['dx']!.abs();
      if (v > maxV) maxV = v;
    }
    if (maxV <= 0.0) maxV = 1.0;

    final positionBars = <Widget>[];
    final velocityBars = <Widget>[];
    for (final s in samples) {
      final t = s['t']!;
      final x = s['x']!;
      final dx = s['dx']!.abs();
      positionBars.add(
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.0),
            child: Container(
              height: (x / maxX).clamp(0.0, 1.0) * 70.0 + 4.0,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.85),
                borderRadius: BorderRadius.vertical(top: Radius.circular(2.5)),
              ),
            ),
          ),
        ),
      );
      velocityBars.add(
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 1.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: (dx / maxV).clamp(0.0, 1.0) * 50.0 + 3.0,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(2.5),
                    ),
                  ),
                ),
                SizedBox(height: 3.0),
                Text(
                  t.toStringAsFixed(1),
                  style: TextStyle(fontSize: 8.0, color: Colors.grey.shade700),
                ),
              ],
            ),
          ),
        ),
      );
    }

    frictionPanels.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 14.0,
                  height: 14.0,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8.0),
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 13.0,
                  ),
                ),
                SizedBox(width: 12.0),
                Text(
                  'final x=${sim.finalX.toStringAsFixed(1)}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Text(
              'position x(t)',
              style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600),
            ),
            SizedBox(height: 4.0),
            SizedBox(
              height: 80.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: positionBars,
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              '|velocity dx(t)|',
              style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600),
            ),
            SizedBox(height: 4.0),
            SizedBox(
              height: 75.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: velocityBars,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // FrictionSimulation.through — must reach a specific endpoint
  final throughSim = FrictionSimulation.through(0.0, 500.0, 100.0, 10.0);
  print('FrictionSimulation.through(0, 500, 100, 10):');
  final throughRows = <Widget>[];
  for (final t in <double>[0.0, 0.25, 0.5, 0.75, 1.0, 1.5, 2.0]) {
    final x = throughSim.x(t);
    final dx = throughSim.dx(t);
    final done = throughSim.isDone(t);
    print(
      '  t=$t: x=${x.toStringAsFixed(3)}, dx=${dx.toStringAsFixed(3)}, isDone=$done',
    );
    throughRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: done ? Colors.green.shade50 : Colors.amber.shade50,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(
            color: done ? Colors.green.shade300 : Colors.amber.shade300,
          ),
        ),
        child: Row(
          children: [
            Icon(
              done ? Icons.check_circle : Icons.timelapse,
              size: 16.0,
              color: done ? Colors.green : Colors.amber.shade800,
            ),
            SizedBox(width: 8.0),
            SizedBox(
              width: 70.0,
              child: Text(
                't=${t.toStringAsFixed(2)}s',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: LinearProgressIndicator(
                value: (x / 500.0).clamp(0.0, 1.0),
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(
                  done ? Colors.green : Colors.amber.shade700,
                ),
                minHeight: 8.0,
              ),
            ),
            SizedBox(width: 10.0),
            SizedBox(
              width: 110.0,
              child: Text(
                'x=${x.toStringAsFixed(1)} dx=${dx.toStringAsFixed(1)}',
                style: TextStyle(fontFamily: 'monospace', fontSize: 10.5),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 4: SpringSimulation — Damping Comparison
  // ============================================================
  print('=== Section 4: SpringSimulation Damping ===');

  final underSpring = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 100.0,
    ratio: 0.3,
  );
  final critSpring = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 100.0,
    ratio: 1.0,
  );
  final overSpring = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 100.0,
    ratio: 2.0,
  );

  final springCases = <Map<String, dynamic>>[
    {
      'label': 'Underdamped (ratio=0.3)',
      'desc': 'Overshoots, oscillates back',
      'sim': SpringSimulation(underSpring, 0.0, 1.0, 0.0),
      'color': Colors.blue,
      'icon': Icons.waves,
    },
    {
      'label': 'Critically damped (ratio=1.0)',
      'desc': 'Fastest no-overshoot return',
      'sim': SpringSimulation(critSpring, 0.0, 1.0, 0.0),
      'color': Colors.green,
      'icon': Icons.show_chart,
    },
    {
      'label': 'Overdamped (ratio=2.0)',
      'desc': 'Slow, sluggish approach',
      'sim': SpringSimulation(overSpring, 0.0, 1.0, 0.0),
      'color': Colors.deepOrange,
      'icon': Icons.trending_flat,
    },
  ];

  final springPanels = <Widget>[];
  for (final sc in springCases) {
    final label = sc['label'] as String;
    final desc = sc['desc'] as String;
    final sim = sc['sim'] as SpringSimulation;
    final color = sc['color'] as Color;
    final icon = sc['icon'] as IconData;

    print('$label:');
    final times = <double>[];
    for (int i = 0; i <= 24; i++) {
      times.add(i * 0.125);
    }
    final samples = <Map<String, double>>[];
    for (final t in times) {
      final x = sim.x(t);
      samples.add({'t': t, 'x': x});
    }
    // Print only headline samples
    for (final t in <double>[0.0, 0.25, 0.5, 0.75, 1.0, 1.5, 2.0, 3.0]) {
      print('  t=$t: x=${sim.x(t).toStringAsFixed(4)}');
    }

    final bars = <Widget>[];
    for (final s in samples) {
      final x = s['x']!;
      // Map x in roughly [-0.4, 1.4] to height around midline
      final centered = x - 0.5; // -0.9..0.9
      final h = centered.clamp(-1.0, 1.0) * 50.0;
      final positive = h >= 0;
      bars.add(
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.6),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 110.0,
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide.none,
                      bottom: BorderSide.none,
                      left: BorderSide.none,
                      right: BorderSide.none,
                    ),
                  ),
                ),
                Align(
                  alignment: positive
                      ? Alignment.bottomCenter
                      : Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                      bottom: positive ? 55.0 : 0.0,
                      top: positive ? 0.0 : 55.0,
                    ),
                    height: h.abs(),
                    decoration: BoxDecoration(
                      color: positive
                          ? color.withValues(alpha: 0.85)
                          : color.withValues(alpha: 0.4),
                    ),
                  ),
                ),
                Container(
                  height: 1.0,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ),
      );
    }

    // Headline numbers
    final headline = <double>[0.0, 0.25, 0.5, 0.75, 1.0];
    final numberChips = <Widget>[];
    for (final t in headline) {
      final x = sim.x(t);
      numberChips.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: color.withValues(alpha: 0.4)),
          ),
          child: Column(
            children: [
              Text(
                't=${t.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 9.5,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                x.toStringAsFixed(3),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      );
    }

    springPanels.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        padding: EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withValues(alpha: 0.06),
              color.withValues(alpha: 0.02),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 22.0),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        label,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: color,
                        ),
                      ),
                      Text(
                        desc,
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            SizedBox(
              height: 110.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: bars,
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'x(t) sampled at 25 points across t=[0..3]; horizontal line = target=0.5',
              style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
            ),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: numberChips,
            ),
          ],
        ),
      ),
    );
  }

  // Direct SpringDescription (mass, stiffness, damping) construction
  final directSpring = SpringDescription(
    mass: 1.0,
    stiffness: 100.0,
    damping: 10.0,
  );
  final directSim = SpringSimulation(directSpring, 0.0, 1.0, 0.0);
  print('SpringDescription direct: mass=${directSpring.mass}, '
      'stiffness=${directSpring.stiffness}, damping=${directSpring.damping}');
  for (final t in <double>[0.0, 0.25, 0.5, 1.0, 2.0]) {
    print('  direct t=$t: x=${directSim.x(t).toStringAsFixed(4)}');
  }

  // Spring with initial velocity
  final kickedSim = SpringSimulation(directSpring, 0.0, 1.0, 5.0);
  print('SpringSimulation with initial velocity=5:');
  for (final t in <double>[0.0, 0.1, 0.25, 0.5, 1.0]) {
    print('  kicked t=$t: x=${kickedSim.x(t).toStringAsFixed(4)}');
  }

  // ============================================================
  // SECTION 5: Scroll Simulations — Real-World Fling
  // ============================================================
  print('=== Section 5: Scroll Simulations ===');

  // ScrollSpringSimulation (spring back to a position)
  final scrollSpring = SpringDescription(
    mass: 0.5,
    stiffness: 100.0,
    damping: 15.0,
  );
  final springBack = ScrollSpringSimulation(scrollSpring, 250.0, 0.0, -200.0);
  print('ScrollSpringSimulation (snap back): start=250, end=0, vel=-200');
  final scrollSpringSamples = <Map<String, double>>[];
  for (final t in <double>[0.0, 0.1, 0.2, 0.4, 0.7, 1.0, 1.5, 2.0]) {
    final x = springBack.x(t);
    final dx = springBack.dx(t);
    print(
      '  t=$t: x=${x.toStringAsFixed(3)}, dx=${dx.toStringAsFixed(3)}, '
      'isDone=${springBack.isDone(t)}',
    );
    scrollSpringSamples.add({'t': t, 'x': x, 'dx': dx});
  }

  // BouncingScrollSimulation — iOS-style fling
  final bouncingSpring = SpringDescription(
    mass: 0.5,
    stiffness: 100.0,
    damping: 15.0,
  );
  final bouncing = BouncingScrollSimulation(
    position: 0.0,
    velocity: 1500.0,
    leadingExtent: 0.0,
    trailingExtent: 1000.0,
    spring: bouncingSpring,
  );
  print('BouncingScrollSimulation: pos=0, vel=1500, range=[0..1000]');
  final bouncingSamples = <Map<String, double>>[];
  for (final t in <double>[0.0, 0.1, 0.2, 0.4, 0.7, 1.0, 1.5, 2.0, 3.0]) {
    final x = bouncing.x(t);
    final dx = bouncing.dx(t);
    print(
      '  t=$t: x=${x.toStringAsFixed(2)}, dx=${dx.toStringAsFixed(2)}, '
      'isDone=${bouncing.isDone(t)}',
    );
    bouncingSamples.add({'t': t, 'x': x, 'dx': dx});
  }

  // ClampingScrollSimulation — Android-style fling
  final clamping = ClampingScrollSimulation(
    position: 0.0,
    velocity: 1500.0,
    friction: 0.015,
  );
  print('ClampingScrollSimulation: pos=0, vel=1500, friction=0.015');
  final clampingSamples = <Map<String, double>>[];
  for (final t in <double>[0.0, 0.1, 0.2, 0.4, 0.7, 1.0, 1.5, 2.0, 3.0]) {
    final x = clamping.x(t);
    final dx = clamping.dx(t);
    print(
      '  t=$t: x=${x.toStringAsFixed(2)}, dx=${dx.toStringAsFixed(2)}, '
      'isDone=${clamping.isDone(t)}',
    );
    clampingSamples.add({'t': t, 'x': x, 'dx': dx});
  }

  Widget buildScrollPanel(
    String title,
    String desc,
    IconData icon,
    Color color,
    List<Map<String, double>> samples,
    double normalize,
  ) {
    final pillRow = <Widget>[];
    for (final s in samples) {
      final t = s['t']!;
      final x = s['x']!;
      pillRow.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14.0),
              border: Border.all(color: color.withValues(alpha: 0.4)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  't=${t.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 10.0, color: color),
                ),
                SizedBox(width: 6.0),
                Text(
                  x.toStringAsFixed(1),
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final progressBars = <Widget>[];
    for (final s in samples) {
      final x = s['x']!;
      progressBars.add(
        Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: [
              SizedBox(
                width: 50.0,
                child: Text(
                  't=${s['t']!.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontFamily: 'monospace',
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: (x / normalize).clamp(0.0, 1.0),
                  backgroundColor: Colors.grey.shade200,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                  minHeight: 8.0,
                ),
              ),
              SizedBox(width: 8.0),
              SizedBox(
                width: 55.0,
                child: Text(
                  x.toStringAsFixed(1),
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10.5,
                    color: Colors.grey.shade800,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20.0),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                        color: color,
                      ),
                    ),
                    Text(
                      desc,
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Wrap(children: pillRow),
          SizedBox(height: 10.0),
          ...progressBars,
        ],
      ),
    );
  }

  final scrollPanels = <Widget>[
    buildScrollPanel(
      'ScrollSpringSimulation',
      'Snap back from 250 with vel=-200',
      Icons.replay,
      Colors.purple,
      scrollSpringSamples,
      260.0,
    ),
    buildScrollPanel(
      'BouncingScrollSimulation',
      'iOS-style fling, vel=1500, range [0..1000]',
      Icons.compare_arrows,
      Colors.pink,
      bouncingSamples,
      1100.0,
    ),
    buildScrollPanel(
      'ClampingScrollSimulation',
      'Android-style fling, vel=1500, friction=0.015',
      Icons.straighten,
      Colors.brown,
      clampingSamples,
      Tolerance.defaultTolerance.distance > 0
          ? (clamping.x(3.0) + 50.0)
          : 1500.0,
    ),
  ];

  // Comparison table BouncingScroll vs ClampingScroll
  final compareRows = <Widget>[];
  compareRows.add(
    Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 56.0,
            child: Text(
              't',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0),
            ),
          ),
          Expanded(
            child: Text(
              'Bouncing x',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.0,
                color: Colors.pink.shade800,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Clamping x',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11.0,
                color: Colors.brown.shade800,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'Diff',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11.0),
            ),
          ),
        ],
      ),
    ),
  );
  final compareTimes = <double>[0.0, 0.2, 0.4, 0.7, 1.0, 1.5, 2.0, 3.0];
  for (int i = 0; i < compareTimes.length; i++) {
    final t = compareTimes[i];
    final bx = bouncing.x(t);
    final cx = clamping.x(t);
    final diff = bx - cx;
    compareRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: i.isEven ? Colors.grey.shade50 : Colors.white,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 56.0,
              child: Text(
                t.toStringAsFixed(2),
                style: TextStyle(fontFamily: 'monospace', fontSize: 11.0),
              ),
            ),
            Expanded(
              child: Text(
                bx.toStringAsFixed(2),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.pink.shade800,
                ),
              ),
            ),
            Expanded(
              child: Text(
                cx.toStringAsFixed(2),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Colors.brown.shade800,
                ),
              ),
            ),
            Expanded(
              child: Text(
                diff.toStringAsFixed(2),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: diff >= 0 ? Colors.green.shade800 : Colors.red.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final comparisonTable = Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(children: compareRows),
  );

  // ============================================================
  // SECTION 6: Custom Tolerance & Code Patterns
  // ============================================================
  print('=== Section 6: Tolerance & Code Patterns ===');

  final tightTol = Tolerance(distance: 0.001, time: 0.001, velocity: 0.001);
  final looseTol = Tolerance(distance: 1.0, time: 0.1, velocity: 1.0);
  final tightSim = SpringSimulation(
    directSpring,
    0.0,
    1.0,
    0.0,
    tolerance: tightTol,
  );
  final looseSim = SpringSimulation(
    directSpring,
    0.0,
    1.0,
    0.0,
    tolerance: looseTol,
  );

  final toleranceRows = <Widget>[];
  for (final t in <double>[0.5, 1.0, 1.5, 2.0, 3.0, 5.0]) {
    final tightDone = tightSim.isDone(t);
    final looseDone = looseSim.isDone(t);
    toleranceRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 3.0),
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 60.0,
              child: Text(
                't=${t.toStringAsFixed(1)}',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Icon(
                    tightDone ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: tightDone ? Colors.green : Colors.grey,
                    size: 16.0,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    'tight: ${tightDone ? "done" : "running"}',
                    style: TextStyle(fontSize: 11.0),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Icon(
                    looseDone ? Icons.check_circle : Icons.radio_button_unchecked,
                    color: looseDone ? Colors.green : Colors.grey,
                    size: 16.0,
                  ),
                  SizedBox(width: 4.0),
                  Text(
                    'loose: ${looseDone ? "done" : "running"}',
                    style: TextStyle(fontSize: 11.0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final tolerancePanel = Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.amber.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.amber.shade300, width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.tune, color: Colors.amber.shade800, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Tolerance Comparison',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: Colors.amber.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'tight = (d=0.001, t=0.001, v=0.001)    loose = (d=1, t=0.1, v=1)',
          style: TextStyle(
            fontSize: 10.5,
            fontFamily: 'monospace',
            color: Colors.amber.shade800,
          ),
        ),
        SizedBox(height: 10.0),
        ...toleranceRows,
      ],
    ),
  );

  // Code panels for construction patterns
  Widget codeBlock(String label, String code, Color labelColor) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 11.0,
              color: labelColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade200,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  final codePanel = Container(
    margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade300, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Construction Patterns',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        codeBlock(
          '// GravitySimulation',
          'final fall = GravitySimulation(\n'
              '  9.8,    // acceleration\n'
              '  0.0,    // distance\n'
              '  100.0,  // endDistance\n'
              '  0.0,    // velocity\n'
              ');',
          Colors.indigo.shade200,
        ),
        codeBlock(
          '// FrictionSimulation',
          'final fling = FrictionSimulation(\n'
              '  0.135,  // drag\n'
              '  0.0,    // position\n'
              '  500.0,  // initial velocity\n'
              ');\n'
              '// or reach a specific endpoint:\n'
              'FrictionSimulation.through(0, 500, 100, 10);',
          Colors.orange.shade200,
        ),
        codeBlock(
          '// SpringSimulation',
          'final desc = SpringDescription.withDampingRatio(\n'
              '  mass: 1.0, stiffness: 100.0, ratio: 1.0);\n'
              'final spring = SpringSimulation(desc, 0.0, 1.0, 0.0);\n'
              'spring.x(0.25);   // position\n'
              'spring.dx(0.25);  // velocity\n'
              'spring.isDone(2); // settled?',
          Colors.teal.shade200,
        ),
        codeBlock(
          '// Scroll simulations',
          'BouncingScrollSimulation(\n'
              '  position: 0, velocity: 1500,\n'
              '  leadingExtent: 0, trailingExtent: 1000,\n'
              '  spring: SpringDescription(\n'
              '    mass: .5, stiffness: 100, damping: 15));\n\n'
              'ClampingScrollSimulation(\n'
              '  position: 0, velocity: 1500,\n'
              '  friction: 0.015);',
          Colors.pink.shade200,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Summary Panel
  // ============================================================
  print('=== Section 7: Summary ===');

  final summaryItems = <Widget>[
    _buildSummaryItem(
      Icons.arrow_downward,
      'GravitySimulation',
      'Constant accel; isDone once endDistance is passed.',
      Colors.indigo,
    ),
    SizedBox(height: 8.0),
    _buildSummaryItem(
      Icons.air,
      'FrictionSimulation',
      'Exponential drag; .through() to land exactly on an endpoint.',
      Colors.orange,
    ),
    SizedBox(height: 8.0),
    _buildSummaryItem(
      Icons.waves,
      'SpringSimulation',
      'Damping ratio < 1 oscillates, =1 fastest settle, >1 sluggish.',
      Colors.teal,
    ),
    SizedBox(height: 8.0),
    _buildSummaryItem(
      Icons.swap_vert,
      'Scroll variants',
      'Bouncing for iOS overscroll, Clamping for Android decel.',
      Colors.purple,
    ),
    SizedBox(height: 8.0),
    _buildSummaryItem(
      Icons.tune,
      'Tolerance',
      'Tight tolerances delay isDone; loose tolerances finish early.',
      Colors.amber,
    ),
    SizedBox(height: 8.0),
    _buildSummaryItem(
      Icons.functions,
      'API surface',
      '.x(t), .dx(t), .isDone(t) — pure math, no controllers required.',
      Colors.blue,
    ),
  ];

  final summaryPanel = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.purple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 14.0),
        ...summaryItems,
      ],
    ),
  );

  print('Physics Simulations Deep Demo completed successfully');

  // ============================================================
  // Compose the final layout
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header banner
            Container(
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.deepPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.indigo.withValues(alpha: 0.4),
                    blurRadius: 12.0,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(Icons.science, size: 56.0, color: Colors.white),
                  SizedBox(height: 8.0),
                  Text(
                    'flutter/physics — Simulations',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'Gravity • Friction • Spring • Scroll',
                    style: TextStyle(fontSize: 13.0, color: Colors.white70),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),

            // Section 1
            Text(
              '1. Simulation Family Overview',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(alignment: WrapAlignment.center, children: overviewCards),
            SizedBox(height: 32.0),

            // Section 2
            Text(
              '2. GravitySimulation — Free Fall',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            gravityPanel,
            SizedBox(height: 12.0),
            Text(
              'Tossed up (negative initial velocity)',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 6.0),
            ...tossRows,
            SizedBox(height: 32.0),

            // Section 3
            Text(
              '3. FrictionSimulation — Drag Decay',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            ...frictionPanels,
            SizedBox(height: 12.0),
            Text(
              'FrictionSimulation.through() — landing exactly on a target',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 6.0),
            ...throughRows,
            SizedBox(height: 32.0),

            // Section 4
            Text(
              '4. SpringSimulation — Damping Comparison',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            ...springPanels,
            SizedBox(height: 32.0),

            // Section 5
            Text(
              '5. Scroll Simulations — Fling Behaviour',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            ...scrollPanels,
            SizedBox(height: 8.0),
            Text(
              'Bouncing vs Clamping — same initial velocity, different platforms',
              style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 6.0),
            comparisonTable,
            SizedBox(height: 32.0),

            // Section 6
            Text(
              '6. Tolerance & Construction Patterns',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            tolerancePanel,
            codePanel,
            SizedBox(height: 32.0),

            // Section 7
            Text(
              '7. Summary',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            summaryPanel,
            SizedBox(height: 24.0),
          ],
        ),
      ),
    ),
  );
}

// Helper: Build a summary line item.
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.75),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 13.0,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
