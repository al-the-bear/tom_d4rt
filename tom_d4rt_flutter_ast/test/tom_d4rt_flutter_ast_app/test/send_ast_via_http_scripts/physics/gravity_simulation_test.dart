// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests GravitySimulation from package:flutter/physics.dart
// Deep Demo: Galileo's Inclined-Plane Observatory --- a static visualization
// of constant-acceleration motion through trajectory dots, anatomy diagrams,
// and a tour of the Simulation family that powers Flutter's physics-based
// animations and scroll behavior.
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

dynamic build(BuildContext context) {
  print('GravitySimulation Deep Demo executing');
  print('=' * 60);

  // ============================================================
  // PHYSICS PRELUDE: pre-compute several trajectories for graphs
  // ============================================================
  print('=== Prelude: pre-computing trajectories ===');

  // The flagship "Tower of Pisa" simulation: an apple falling 100 m
  // under Earth gravity (positive acceleration moves x toward endDistance).
  final towerSim = GravitySimulation(9.8, 0.0, 100.0, 0.0);
  print('Tower simulation: a=9.8, d=0.0, end=100.0, v=0.0');

  // A Moon-gravity drop --- same start/end but slower fall.
  final moonSim = GravitySimulation(1.62, 0.0, 100.0, 0.0);
  print('Moon simulation: a=1.62, d=0.0, end=100.0, v=0.0');

  // An "upward toss" with a head-start velocity (still positive a, so the
  // object accelerates downward; the negative v just delays the moment when
  // x reaches endDistance).  Constructor is (a, d, end, v).
  final tossSim = GravitySimulation(9.8, 0.0, 200.0, -30.0);
  print('Toss simulation: a=9.8, d=0.0, end=200.0, v=-30.0');

  // A heavy projectile started already in motion at d = 20 m.
  final heavySim = GravitySimulation(15.0, 20.0, 250.0, 5.0);
  print('Heavy simulation: a=15.0, d=20.0, end=250.0, v=5.0');

  // Print actual computed values so the chat trail shows real physics.
  for (var i = 0; i < 6; i++) {
    final t = i * 1.0;
    print(
      'tower t=$t -> x=${towerSim.x(t).toStringAsFixed(2)} '
      'dx=${towerSim.dx(t).toStringAsFixed(2)} '
      'done=${towerSim.isDone(t)}',
    );
  }
  for (var i = 0; i < 6; i++) {
    final t = i * 1.5;
    print(
      'moon  t=${t.toStringAsFixed(1)} -> '
      'x=${moonSim.x(t).toStringAsFixed(2)} '
      'dx=${moonSim.dx(t).toStringAsFixed(2)}',
    );
  }
  for (var i = 0; i < 6; i++) {
    final t = i * 1.0;
    print(
      'toss  t=$t -> x=${tossSim.x(t).toStringAsFixed(2)} '
      'dx=${tossSim.dx(t).toStringAsFixed(2)}',
    );
  }
  for (var i = 0; i < 6; i++) {
    final t = i * 0.8;
    print(
      'heavy t=${t.toStringAsFixed(1)} -> '
      'x=${heavySim.x(t).toStringAsFixed(2)} '
      'dx=${heavySim.dx(t).toStringAsFixed(2)}',
    );
  }

  // ============================================================
  // SECTION 1: Hero header --- the observatory plate
  // ============================================================
  print('=== Section 1: Hero header ===');

  final hero = Container(
    padding: EdgeInsets.all(24.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF0B1E3F),
          Color(0xFF1E3A8A),
          Color(0xFF312E81),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.45),
          blurRadius: 18.0,
          offset: Offset(0.0, 10.0),
        ),
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 72.0,
              height: 72.0,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  colors: [Colors.amber.shade200, Colors.deepOrange.shade700],
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.amber.withValues(alpha: 0.5),
                    blurRadius: 24.0,
                    spreadRadius: 4.0,
                  ),
                ],
              ),
              child: Icon(
                Icons.public,
                color: Colors.white,
                size: 40.0,
              ),
            ),
            SizedBox(width: 18.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GravitySimulation',
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    "Galileo's Inclined-Plane Observatory",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.amber.shade200,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Colors.amber.withValues(alpha: 0.3),
              width: 1.0,
            ),
          ),
          child: Text(
            'A constant-acceleration Simulation that moves a 1-D point from '
            'distance d toward endDistance with initial velocity v under '
            'acceleration a. Drives drop animations, ballistic toys, and '
            'underpins parts of the scroll-physics family.',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.92),
              fontSize: 13.0,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Constructor anatomy
  // ============================================================
  print('=== Section 2: Constructor anatomy ===');

  final constructorAnatomy = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.2),
          blurRadius: 10.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.construction, color: Colors.deepOrange, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'GravitySimulation(a, d, end, v)',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 12.0,
          children: [
            _paramCard(
              'acceleration',
              'a',
              'Constant rate of velocity change (m/s\u00B2). Positive values '
                  'pull x toward larger numbers --- the canonical "down".',
              Colors.red.shade400,
              Icons.arrow_downward,
            ),
            _paramCard(
              'distance',
              'd',
              'Initial position at t = 0. The trajectory starts here and '
                  'evolves under constant acceleration.',
              Colors.blue.shade400,
              Icons.place,
            ),
            _paramCard(
              'endDistance',
              'end',
              'Goal position. isDone(t) becomes true once x(t) reaches or '
                  'passes endDistance (must be \u2265 d in practice).',
              Colors.green.shade400,
              Icons.flag,
            ),
            _paramCard(
              'velocity',
              'v',
              'Initial velocity at t = 0. Combine with acceleration to '
                  'pre-bias the motion (head-start, backward toss, ...).',
              Colors.purple.shade400,
              Icons.speed,
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.orange.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Equations of motion',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.deepOrange.shade900,
                ),
              ),
              SizedBox(height: 8.0),
              _equationLine('x(t)  =  d + v\u00B7t + \u00BD\u00B7a\u00B7t\u00B2'),
              SizedBox(height: 4.0),
              _equationLine('dx(t) =  v + a\u00B7t'),
              SizedBox(height: 4.0),
              _equationLine('isDone(t) =  x(t) \u2265 end'),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Position-vs-time graph (Stack of Positioned dots)
  // ============================================================
  print('=== Section 3: Position-vs-time graph ===');

  // Sample 60 points along the tower simulation up to t = 5 s.
  const samples = 60;
  const totalTime = 5.0;
  const graphWidth = 320.0;
  const graphHeight = 180.0;
  const dotSize = 6.0;

  final towerDots = <Widget>[];
  for (var i = 0; i < samples; i++) {
    final t = (i / (samples - 1)) * totalTime;
    final x = towerSim.x(t);
    // Map x in [0, 122.5] (5 s tower fall) onto vertical pixel space, with 0
    // at the top so falling reads visually as descent.
    final maxX = towerSim.x(totalTime);
    final px = (i / (samples - 1)) * (graphWidth - dotSize);
    final py = (x / maxX) * (graphHeight - dotSize);
    towerDots.add(
      Positioned(
        left: px,
        top: py,
        child: Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.deepOrange.shade400,
            boxShadow: [
              BoxShadow(
                color: Colors.deepOrange.withValues(alpha: 0.5),
                blurRadius: 3.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  final positionGraph = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.blue.shade100],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.15),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Position x(t) --- Tower of Pisa drop',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Parabola opens "downward" in screen space because acceleration '
              'pushes x from 0 toward endDistance.',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.indigo.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          width: graphWidth,
          height: graphHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Stack(
            children: [
              // gridlines
              for (var i = 1; i < 5; i++)
                Positioned(
                  left: (i * graphWidth / 5),
                  top: 0.0,
                  bottom: 0.0,
                  child: Container(width: 1.0, color: Colors.grey.shade200),
                ),
              for (var i = 1; i < 4; i++)
                Positioned(
                  top: (i * graphHeight / 4),
                  left: 0.0,
                  right: 0.0,
                  child: Container(height: 1.0, color: Colors.grey.shade200),
                ),
              ...towerDots,
              Positioned(
                left: 4.0,
                top: 4.0,
                child: Text(
                  'x = 0',
                  style: TextStyle(
                    fontSize: 9.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Positioned(
                right: 4.0,
                bottom: 4.0,
                child: Text(
                  't = 5 s',
                  style: TextStyle(
                    fontSize: 9.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        _readoutRow('x(0.0)', towerSim.x(0.0)),
        _readoutRow('x(1.0)', towerSim.x(1.0)),
        _readoutRow('x(2.0)', towerSim.x(2.0)),
        _readoutRow('x(3.0)', towerSim.x(3.0)),
        _readoutRow('x(5.0)', towerSim.x(5.0)),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Velocity-vs-time graph
  // ============================================================
  print('=== Section 4: Velocity-vs-time graph ===');

  final velocityDots = <Widget>[];
  final maxV = towerSim.dx(totalTime).abs();
  for (var i = 0; i < samples; i++) {
    final t = (i / (samples - 1)) * totalTime;
    final v = towerSim.dx(t);
    final px = (i / (samples - 1)) * (graphWidth - dotSize);
    final py = (graphHeight - dotSize) -
        (v.abs() / maxV) * (graphHeight - dotSize);
    velocityDots.add(
      Positioned(
        left: px,
        top: py,
        child: Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.teal.shade500,
            boxShadow: [
              BoxShadow(
                color: Colors.teal.withValues(alpha: 0.5),
                blurRadius: 3.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  final velocityGraph = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.teal.shade50, Colors.cyan.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Velocity dx(t) --- linear in time',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            color: Colors.teal.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'A straight line whose slope is the constant acceleration. '
              'The integral underneath equals the total displacement.',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.teal.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          width: graphWidth,
          height: graphHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.teal.shade200),
          ),
          child: Stack(
            children: [
              for (var i = 1; i < 5; i++)
                Positioned(
                  left: (i * graphWidth / 5),
                  top: 0.0,
                  bottom: 0.0,
                  child: Container(width: 1.0, color: Colors.grey.shade200),
                ),
              for (var i = 1; i < 4; i++)
                Positioned(
                  top: (i * graphHeight / 4),
                  left: 0.0,
                  right: 0.0,
                  child: Container(height: 1.0, color: Colors.grey.shade200),
                ),
              ...velocityDots,
              Positioned(
                left: 4.0,
                bottom: 4.0,
                child: Text(
                  'v = 0',
                  style: TextStyle(
                    fontSize: 9.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              Positioned(
                right: 4.0,
                top: 4.0,
                child: Text(
                  'v = ${towerSim.dx(totalTime).toStringAsFixed(1)} m/s',
                  style: TextStyle(
                    fontSize: 9.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        _readoutRow('dx(0.0)', towerSim.dx(0.0)),
        _readoutRow('dx(1.0)', towerSim.dx(1.0)),
        _readoutRow('dx(2.0)', towerSim.dx(2.0)),
        _readoutRow('dx(3.0)', towerSim.dx(3.0)),
        _readoutRow('dx(5.0)', towerSim.dx(5.0)),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: isDone boundary visualization
  // ============================================================
  print('=== Section 5: isDone boundary ===');

  // Find the time when x first reaches endDistance for the tower sim.
  final boundaryDots = <Widget>[];
  final boundaryStripes = <Widget>[];
  var tDone = -1.0;
  for (var i = 0; i < 80; i++) {
    final t = (i / 79.0) * 6.0;
    final done = towerSim.isDone(t);
    final x = towerSim.x(t).clamp(0.0, 150.0);
    final px = (i / 79.0) * (graphWidth - dotSize);
    final py = (x / 150.0) * (graphHeight - dotSize);
    final color = done ? Colors.red.shade400 : Colors.lightBlue.shade400;
    boundaryDots.add(
      Positioned(
        left: px,
        top: py,
        child: Container(
          width: dotSize,
          height: dotSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ),
    );
    if (done && tDone < 0) {
      tDone = t;
    }
  }
  // Horizontal "ground" line at endDistance (100 / 150 in pixel terms).
  boundaryStripes.add(
    Positioned(
      left: 0.0,
      right: 0.0,
      top: (100.0 / 150.0) * (graphHeight - dotSize),
      child: Container(
        height: 2.0,
        color: Colors.red.shade300,
      ),
    ),
  );

  print('Tower isDone first true at t \u2248 ${tDone.toStringAsFixed(2)} s');

  final boundaryCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.pink.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.red.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.15),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'isDone(t) --- the ground line',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15.0,
            color: Colors.red.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Blue dots: still in flight. Red dots: simulation has completed. '
              'The horizontal stripe is x = endDistance.',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.red.shade700,
            fontStyle: FontStyle.italic,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          width: graphWidth,
          height: graphHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.red.shade200),
          ),
          child: Stack(
            children: [
              ...boundaryStripes,
              ...boundaryDots,
              Positioned(
                right: 4.0,
                top: 4.0,
                child: Text(
                  't_done \u2248 ${tDone.toStringAsFixed(2)} s',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),
        _isDoneRow(towerSim, 0.0),
        _isDoneRow(towerSim, 2.0),
        _isDoneRow(towerSim, 4.0),
        _isDoneRow(towerSim, 4.5),
        _isDoneRow(towerSim, 5.0),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Four parametric simulations side by side
  // ============================================================
  print('=== Section 6: Parametric trajectories ===');

  final simRow = Wrap(
    spacing: 16.0,
    runSpacing: 16.0,
    alignment: WrapAlignment.center,
    children: [
      _miniTrajectoryCard(
        title: 'Earth (Pisa)',
        formula: 'a=9.8, d=0, end=100, v=0',
        color: Colors.deepOrange,
        sim: towerSim,
        totalTime: 5.0,
        rangeMax: 130.0,
      ),
      _miniTrajectoryCard(
        title: 'Moon drop',
        formula: 'a=1.62, d=0, end=100, v=0',
        color: Colors.blueGrey,
        sim: moonSim,
        totalTime: 12.0,
        rangeMax: 130.0,
      ),
      _miniTrajectoryCard(
        title: 'Backward toss',
        formula: 'a=9.8, d=0, end=200, v=-30',
        color: Colors.purple,
        sim: tossSim,
        totalTime: 9.0,
        rangeMax: 220.0,
      ),
      _miniTrajectoryCard(
        title: 'Heavy projectile',
        formula: 'a=15, d=20, end=250, v=5',
        color: Colors.brown,
        sim: heavySim,
        totalTime: 6.0,
        rangeMax: 280.0,
      ),
    ],
  );

  // ============================================================
  // SECTION 7: Type hierarchy --- the Simulation family tree
  // ============================================================
  print('=== Section 7: Simulation family ===');

  final familyTree = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade50, Colors.indigo.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.deepPurple.shade200),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_tree, color: Colors.deepPurple, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'The Simulation family',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        _classNode(
          'Simulation',
          'abstract base: x(t), dx(t), isDone(t), tolerance',
          Colors.deepPurple,
          isAbstract: true,
        ),
        _treeBranch(),
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            _classNode(
              'GravitySimulation',
              'constant acceleration',
              Colors.deepOrange,
            ),
            _classNode(
              'SpringSimulation',
              'damped harmonic motion',
              Colors.green,
            ),
            _classNode(
              'FrictionSimulation',
              'exponential decay',
              Colors.brown,
            ),
            _classNode(
              'BouncingScrollSimulation',
              'overscroll + spring',
              Colors.teal,
            ),
            _classNode(
              'ClampingScrollSimulation',
              'iOS-style clamp',
              Colors.blue,
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.deepPurple.shade100),
          ),
          child: Text(
            'GravitySimulation is internally combined inside ScrollPhysics '
            "for fling gestures: the AnimationController's ticker calls x(t) "
            'every frame and stops when isDone(t) returns true.',
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.deepPurple.shade900,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Tolerance card --- precision in simulations
  // ============================================================
  print('=== Section 8: Tolerance ===');

  // Tolerance is the per-Simulation precision spec used to decide whether
  // values are "close enough" to be considered at rest.
  final tol = Tolerance(distance: 0.01, velocity: 0.05, time: 0.001);
  print(
    'Tolerance: distance=${tol.distance} '
    'velocity=${tol.velocity} time=${tol.time}',
  );

  final toleranceCard = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.lime.shade100, Colors.green.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.green.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.18),
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
            Icon(Icons.precision_manufacturing,
                color: Colors.green.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Tolerance --- when "good enough" is good enough',
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Wrap(
          spacing: 10.0,
          runSpacing: 10.0,
          children: [
            _tolerancePill('distance', tol.distance, 'units of x'),
            _tolerancePill('velocity', tol.velocity, 'units of dx'),
            _tolerancePill('time', tol.time, 'seconds'),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Tolerance.defaultTolerance is what most Simulations adopt when no '
          'value is supplied; you almost never need to override it unless '
          'you are matching a specific UX feel (e.g. springy bottom sheets).',
          style: TextStyle(
            fontSize: 11.5,
            color: Colors.green.shade900,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Comparison panel --- gravity vs spring vs friction
  // ============================================================
  print('=== Section 9: Comparison ===');

  final comparisonPanel = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      border: Border.all(color: Colors.cyan.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.18),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choosing a Simulation',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade900,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.blue.shade100),
          ),
          child: Column(
            children: [
              _comparisonRow(
                'Gravity',
                'Drop, throw, ballistic motion',
                'a, d, end, v',
                Colors.deepOrange,
                isHeader: false,
              ),
              _comparisonRow(
                'Spring',
                'Bouncy snap-to-rest',
                'desc, start, end, v',
                Colors.green,
                isHeader: false,
              ),
              _comparisonRow(
                'Friction',
                'Fling deceleration',
                'drag, position, velocity',
                Colors.brown,
                isHeader: false,
              ),
              _comparisonRow(
                'Scroll',
                'List/ListView fling',
                'platform-specific',
                Colors.teal,
                isHeader: false,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Inclined-plane illustration & sample stack
  // ============================================================
  print('=== Section 10: Inclined plane ===');

  // Render the Tower simulation as a stack of "ball" positions every 0.5 s,
  // arranged along a diagonal "inclined plane" by mapping t -> px and x -> py.
  final inclineDots = <Widget>[];
  for (var i = 0; i < 10; i++) {
    final t = i * 0.5;
    final x = towerSim.x(t).clamp(0.0, 130.0);
    final px = i * 32.0;
    final py = (x / 130.0) * 220.0;
    inclineDots.add(
      Positioned(
        left: px,
        top: py,
        child: Container(
          width: 18.0,
          height: 18.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [Colors.amber.shade300, Colors.deepOrange.shade700],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.deepOrange.withValues(alpha: 0.4),
                blurRadius: 6.0,
                offset: Offset(0.0, 2.0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              '$i',
              style: TextStyle(
                color: Colors.white,
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  final inclinedPlane = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.brown.shade100, Colors.amber.shade50],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.brown.shade300),
      boxShadow: [
        BoxShadow(
          color: Colors.brown.withValues(alpha: 0.2),
          blurRadius: 10.0,
          offset: Offset(0.0, 5.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: Colors.brown.shade800, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              "Galileo's inclined-plane snapshot",
              style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.brown.shade900,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        Text(
          'Bronze ball positions sampled every 0.5 s; spacing widens '
              'quadratically --- the signature fingerprint of constant a.',
          style: TextStyle(
            fontSize: 11.0,
            fontStyle: FontStyle.italic,
            color: Colors.brown.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          width: 320.0,
          height: 240.0,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.brown.shade200),
          ),
          child: Stack(
            children: [
              // Inclined plane bar
              Positioned(
                left: 0.0,
                top: 0.0,
                child: Container(
                  width: 320.0,
                  height: 4.0,
                  color: Colors.brown.shade400,
                ),
              ),
              ...inclineDots,
              Positioned(
                left: 8.0,
                bottom: 6.0,
                child: Text(
                  'Numbers are tick indices (t = i \u00B7 0.5 s)',
                  style: TextStyle(
                    fontSize: 9.0,
                    color: Colors.brown.shade600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 11: Code-snippet block --- scroll-physics integration
  // ============================================================
  print('=== Section 11: Code snippet ===');

  final codeBlock = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFF0F172A),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
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
            Icon(Icons.code, color: Colors.cyan.shade300, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Typical usage',
              style: TextStyle(
                color: Colors.cyan.shade300,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _codeBlock(
          '// Drop a card 480 px under Earth gravity.\n'
          'final sim = GravitySimulation(\n'
          '  9800.0,  // px/s^2 (acceleration)\n'
          '  0.0,     // distance  (start position)\n'
          '  480.0,   // endDistance (ground)\n'
          '  0.0,     // velocity (at rest)\n'
          ');\n'
          'controller.animateWith(sim);',
          Colors.greenAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// Custom ScrollPhysics fling using GravitySimulation.\n'
          'class GravityScroll extends ScrollPhysics {\n'
          '  Simulation? createBallisticSimulation(\n'
          '      ScrollMetrics m, double v) {\n'
          '    return GravitySimulation(\n'
          '      980.0, m.pixels, m.maxScrollExtent, v);\n'
          '  }\n'
          '}',
          Colors.amberAccent.shade100,
        ),
        SizedBox(height: 10.0),
        _codeBlock(
          '// isDone gates the per-frame ticker.\n'
          'while (!sim.isDone(t)) {\n'
          '  paintBall(sim.x(t));\n'
          '  t += dt;\n'
          '}',
          Colors.pinkAccent.shade100,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 12: Summary footer
  // ============================================================
  print('=== Section 12: Summary footer ===');

  final summaryFooter = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade700, Colors.purple.shade700],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(14.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.4),
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
            Icon(Icons.bookmark, color: Colors.amber.shade200, size: 22.0),
            SizedBox(width: 8.0),
            Text(
              'Takeaways',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _bullet(
          'GravitySimulation is the simplest concrete Simulation: pure '
              'constant acceleration with closed-form x(t) and dx(t).',
        ),
        _bullet(
          'Constructor order is (acceleration, distance, endDistance, '
              'velocity) --- easy to swap accidentally; keep parameters named '
              'in your own helpers when possible.',
        ),
        _bullet(
          'isDone(t) compares x(t) to endDistance; once true the controller '
              'stops calling x(t) further --- no manual stopping needed.',
        ),
        _bullet(
          'Reach for SpringSimulation when you need overshoot, '
              'FrictionSimulation when you need exponential decay, and '
              'gravity when you literally mean "drop something".',
        ),
        _bullet(
          'Scroll physics (BouncingScrollSimulation, '
              'ClampingScrollSimulation) compose Simulations internally; '
              'GravitySimulation is rarely used directly inside ScrollPhysics, '
              'but it is the easiest stand-in for ballistic learning code.',
        ),
      ],
    ),
  );

  print('GravitySimulation Deep Demo completed successfully');
  print('=' * 60);

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
        Text(
          '1. Constructor anatomy',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        constructorAnatomy,
        SizedBox(height: 24.0),
        Text(
          '2. Position vs time',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        positionGraph,
        SizedBox(height: 24.0),
        Text(
          '3. Velocity vs time',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        velocityGraph,
        SizedBox(height: 24.0),
        Text(
          '4. isDone boundary',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        boundaryCard,
        SizedBox(height: 24.0),
        Text(
          '5. Parametric simulations',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        simRow,
        SizedBox(height: 24.0),
        Text(
          '6. The Simulation family',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        familyTree,
        SizedBox(height: 24.0),
        Text(
          '7. Tolerance',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        toleranceCard,
        SizedBox(height: 24.0),
        Text(
          '8. Choosing a Simulation',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        comparisonPanel,
        SizedBox(height: 24.0),
        Text(
          "9. Galileo's inclined plane",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        inclinedPlane,
        SizedBox(height: 24.0),
        Text(
          '10. Code snippets',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        codeBlock,
        SizedBox(height: 24.0),
        summaryFooter,
      ],
    ),
  );
}

// ============================================================
// Helpers (top-level so the build function stays focused)
// ============================================================

Widget _paramCard(
  String name,
  String shortName,
  String description,
  Color color,
  IconData icon,
) {
  return Container(
    width: 220.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, color.withValues(alpha: 0.08)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
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
            Icon(icon, color: color, size: 18.0),
            SizedBox(width: 6.0),
            Text(
              name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: color,
              ),
            ),
            SizedBox(width: 6.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                shortName,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.0,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          description,
          style: TextStyle(fontSize: 11.0, height: 1.35),
        ),
      ],
    ),
  );
}

Widget _equationLine(String text) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: Colors.orange.shade50,
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: Colors.orange.shade200, width: 0.8),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 13.0,
        color: Colors.deepOrange.shade900,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _readoutRow(String label, double value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        SizedBox(
          width: 80.0,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            value.toStringAsFixed(3),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.indigo.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _isDoneRow(GravitySimulation sim, double t) {
  final done = sim.isDone(t);
  final x = sim.x(t);
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        SizedBox(
          width: 70.0,
          child: Text(
            't = ${t.toStringAsFixed(1)} s',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Container(
          width: 100.0,
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: Colors.red.shade50,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'x = ${x.toStringAsFixed(2)}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.red.shade900,
            ),
          ),
        ),
        SizedBox(width: 8.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: done ? Colors.red.shade200 : Colors.lightBlue.shade100,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            done ? 'DONE' : 'in flight',
            style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.bold,
              color: done ? Colors.red.shade900 : Colors.lightBlue.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _miniTrajectoryCard({
  required String title,
  required String formula,
  required Color color,
  required GravitySimulation sim,
  required double totalTime,
  required double rangeMax,
}) {
  const w = 220.0;
  const h = 150.0;
  const dot = 5.0;
  final dots = <Widget>[];
  for (var i = 0; i < 40; i++) {
    final t = (i / 39.0) * totalTime;
    final x = sim.x(t).clamp(0.0, rangeMax);
    final px = (i / 39.0) * (w - dot);
    final py = (x / rangeMax) * (h - dot);
    dots.add(
      Positioned(
        left: px,
        top: py,
        child: Container(
          width: dot,
          height: dot,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
      ),
    );
  }

  // Endpoint marker.
  final xEnd = sim.x(totalTime).clamp(0.0, rangeMax);
  dots.add(
    Positioned(
      left: w - dot - 2.0,
      top: (xEnd / rangeMax) * (h - dot),
      child: Container(
        width: 10.0,
        height: 10.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(color: Colors.white, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.5),
              blurRadius: 4.0,
            ),
          ],
        ),
      ),
    ),
  );

  return Container(
    width: 240.0,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.white, color.withValues(alpha: 0.08)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.2),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
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
        SizedBox(height: 2.0),
        Text(
          formula,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: Colors.grey.shade700,
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          width: w,
          height: h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: color.withValues(alpha: 0.4)),
          ),
          child: Stack(children: dots),
        ),
        SizedBox(height: 6.0),
        Row(
          children: [
            _miniStat('x(end)', sim.x(totalTime), color),
            SizedBox(width: 6.0),
            _miniStat('dx(end)', sim.dx(totalTime), color),
          ],
        ),
      ],
    ),
  );
}

Widget _miniStat(String label, double value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      '$label: ${value.toStringAsFixed(1)}',
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 10.0,
        color: color,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _classNode(String name, String description, Color color,
    {bool isAbstract = false}) {
  return Container(
    width: 170.0,
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: isAbstract
            ? [color.withValues(alpha: 0.2), color.withValues(alpha: 0.4)]
            : [Colors.white, color.withValues(alpha: 0.12)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: color,
        width: isAbstract ? 2.5 : 1.5,
        style: isAbstract ? BorderStyle.solid : BorderStyle.solid,
      ),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      children: [
        if (isAbstract)
          Container(
            margin: EdgeInsets.only(bottom: 4.0),
            padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 1.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'abstract',
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            color: color,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 4.0),
        Text(
          description,
          style: TextStyle(
            fontSize: 10.0,
            color: Colors.grey.shade700,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _treeBranch() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    child: Column(
      children: [
        Container(width: 2.0, height: 16.0, color: Colors.deepPurple.shade300),
        Container(
          width: 220.0,
          height: 2.0,
          color: Colors.deepPurple.shade300,
        ),
        SizedBox(height: 6.0),
        Icon(Icons.expand_more,
            color: Colors.deepPurple.shade400, size: 18.0),
      ],
    ),
  );
}

Widget _tolerancePill(String label, double value, String unit) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: Colors.green.shade400),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.15),
          blurRadius: 4.0,
          offset: Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.straighten, color: Colors.green.shade700, size: 14.0),
        SizedBox(width: 6.0),
        Text(
          '$label = ',
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.green.shade900,
          ),
        ),
        Text(
          value.toString(),
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.green.shade900,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(width: 4.0),
        Text(
          unit,
          style: TextStyle(
            fontSize: 9.0,
            color: Colors.grey.shade600,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonRow(
  String name,
  String description,
  String params,
  Color color, {
  required bool isHeader,
}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.grey.shade200),
      ),
    ),
    child: Row(
      children: [
        Container(
          width: 8.0,
          height: 32.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        SizedBox(width: 10.0),
        SizedBox(
          width: 80.0,
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 11.0),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            params,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: color,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _codeBlock(String code, Color textColor) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFF1E293B),
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      code,
      style: TextStyle(
        fontFamily: 'monospace',
        fontSize: 11.0,
        color: textColor,
        height: 1.45,
      ),
    ),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 4.0),
          child: Icon(
            Icons.circle,
            size: 8.0,
            color: Colors.amber.shade200,
          ),
        ),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.0,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}
