// ignore_for_file: avoid_print
// D4rt deep-demo: Physics Simulation classes — Ocean / Reef theme, prefix ph
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

// ── Helpers ──────────────────────────────────────────────────────
Widget phSectionHeader(String title, IconData icon) {
  return Padding(
    padding: EdgeInsets.only(top: 20.0, bottom: 8.0),
    child: Row(
      children: [
        Icon(icon, color: Color(0xFF1A6B8A), size: 22.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF264653),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget phChip(String label, Color bg) {
  return Container(
    margin: EdgeInsets.only(right: 6.0, bottom: 6.0),
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Text(label, style: TextStyle(fontSize: 11.0, color: Colors.white)),
  );
}

Widget phInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120.0,
          child: Text(label,
              style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF264653))),
        ),
        Expanded(
          child: Text(value,
              style: TextStyle(fontSize: 12.0, color: Color(0xFF457B8C))),
        ),
      ],
    ),
  );
}

Widget phSimCard(String title, IconData icon, Color accent,
    List<Widget> children) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 10.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: accent, width: 4.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: accent, size: 22.0),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(title,
                  style: TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF264653))),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        ...children,
      ],
    ),
  );
}

// ── build ────────────────────────────────────────────────────────
dynamic build(BuildContext context) {
  print('Physics Simulation Deep Demo executing');
  print('=' * 60);

  // Create simulation instances
  final phSpring = SpringSimulation(
    SpringDescription(mass: 1.0, stiffness: 100.0, damping: 10.0),
    0.0,
    1.0,
    0.0,
  );
  final phFriction = FrictionSimulation(0.135, 100.0, 200.0);
  final phGravity = GravitySimulation(9.8, 0.0, 0.0, 500.0);
  final phClamped = ClampedSimulation(phSpring, xMin: 0.0, xMax: 0.8);

  // ── Section 1: Title ─────────────────────────────────────────
  print('\n[1] Physics Simulation Overview');
  print('  Simulation is the abstract base class');
  print('  Models position x(t) and velocity dx(t) over time');

  final phTitleSection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF264653), Color(0xFF1A6B8A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.science, color: Colors.white, size: 28.0),
            SizedBox(width: 10.0),
            Expanded(
              child: Text('Physics Simulations',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
            'Abstract Simulation base class and concrete implementations: '
            'SpringSimulation, FrictionSimulation, GravitySimulation, '
            'ClampedSimulation',
            style: TextStyle(fontSize: 13.0, color: Color(0xFFA0D4DA))),
        SizedBox(height: 6.0),
        Row(
          children: [
            phChip('Spring', Color(0xFF2A9D8F)),
            phChip('Friction', Color(0xFF1A6B8A)),
            phChip('Gravity', Color(0xFF457B8C)),
            phChip('Clamped', Color(0xFF6BA3B0)),
          ],
        ),
      ],
    ),
  );

  // ── Section 2: Simulation Base Class ─────────────────────────
  print('\n[2] Simulation Abstract Base Class');
  print('  x(double time) → position at t');
  print('  dx(double time) → velocity at t');
  print('  isDone(double time) → completion check');

  final phBaseSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF0F8F6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DDD8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Simulation (abstract)',
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF264653))),
        SizedBox(height: 8.0),
        _phApiRow(Icons.location_on, 'x(double time)',
            'Position at time t', Color(0xFF2A9D8F)),
        _phApiRow(Icons.speed, 'dx(double time)',
            'Velocity at time t', Color(0xFF1A6B8A)),
        _phApiRow(Icons.check_circle, 'isDone(double time)',
            'Whether simulation has reached equilibrium',
            Color(0xFF457B8C)),
        _phApiRow(Icons.tune, 'tolerance',
            'Tolerance for done determination', Color(0xFF6BA3B0)),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'abstract class Simulation {\n'
            '  double x(double time);\n'
            '  double dx(double time);\n'
            '  bool isDone(double time);\n'
            '  Tolerance tolerance;\n'
            '}',
            style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: Color(0xFF264653)),
          ),
        ),
      ],
    ),
  );

  // ── Section 3: SpringSimulation ──────────────────────────────
  print('\n[3] SpringSimulation');
  print('  x(0.0) = ${phSpring.x(0.0).toStringAsFixed(4)}');
  print('  x(0.5) = ${phSpring.x(0.5).toStringAsFixed(4)}');
  print('  x(1.0) = ${phSpring.x(1.0).toStringAsFixed(4)}');

  final phSpringSection = phSimCard(
    'SpringSimulation',
    Icons.waves,
    Color(0xFF2A9D8F),
    [
      phInfoRow('Type:', 'Damped harmonic oscillator'),
      phInfoRow('Parameters:', 'SpringDescription, start, end, velocity'),
      phInfoRow('Behavior:', 'Oscillates toward target, damping reduces'),
      SizedBox(height: 8.0),
      _phValueTable('Time', 'x(t)', 'dx(t)', [
        ['0.0', phSpring.x(0.0), phSpring.dx(0.0)],
        ['0.25', phSpring.x(0.25), phSpring.dx(0.25)],
        ['0.5', phSpring.x(0.5), phSpring.dx(0.5)],
        ['0.75', phSpring.x(0.75), phSpring.dx(0.75)],
        ['1.0', phSpring.x(1.0), phSpring.dx(1.0)],
      ], Color(0xFF2A9D8F)),
    ],
  );

  // ── Section 4: SpringDescription ─────────────────────────────
  print('\n[4] SpringDescription');
  print('  mass=1.0, stiffness=100.0, damping=10.0');

  final phSpringDescSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF0F8F6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DDD8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('SpringDescription Parameters',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF264653))),
        SizedBox(height: 8.0),
        _phParamCard('mass', '1.0',
            'Mass of the object on the spring. Higher mass = slower oscillation.',
            Color(0xFF2A9D8F)),
        _phParamCard('stiffness', '100.0',
            'Spring constant (k). Higher stiffness = stronger pull toward target.',
            Color(0xFF1A6B8A)),
        _phParamCard('damping', '10.0',
            'Damping coefficient. Higher = faster settling, less oscillation.',
            Color(0xFF457B8C)),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Damping Types:',
                  style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF264653))),
              SizedBox(height: 4.0),
              _phDampingRow('Under-damped', 'Oscillates past target',
                  Color(0xFFCC7766)),
              _phDampingRow('Critically damped', 'Fastest settle, no overshoot',
                  Color(0xFF5A9A6E)),
              _phDampingRow('Over-damped', 'Slow approach, no oscillation',
                  Color(0xFF6B8FC4)),
            ],
          ),
        ),
      ],
    ),
  );

  // ── Section 5: FrictionSimulation ────────────────────────────
  print('\n[5] FrictionSimulation');
  print('  drag=0.135, pos=100.0, vel=200.0');
  print('  x(0.0) = ${phFriction.x(0.0).toStringAsFixed(4)}');
  print('  x(1.0) = ${phFriction.x(1.0).toStringAsFixed(4)}');

  final phFrictionSection = phSimCard(
    'FrictionSimulation',
    Icons.drag_indicator,
    Color(0xFF1A6B8A),
    [
      phInfoRow('Type:', 'Exponential decay from friction'),
      phInfoRow('Parameters:', 'drag, position, velocity'),
      phInfoRow('Behavior:', 'Velocity decreases exponentially'),
      SizedBox(height: 8.0),
      _phValueTable('Time', 'x(t)', 'dx(t)', [
        ['0.0', phFriction.x(0.0), phFriction.dx(0.0)],
        ['0.5', phFriction.x(0.5), phFriction.dx(0.5)],
        ['1.0', phFriction.x(1.0), phFriction.dx(1.0)],
        ['2.0', phFriction.x(2.0), phFriction.dx(2.0)],
        ['5.0', phFriction.x(5.0), phFriction.dx(5.0)],
      ], Color(0xFF1A6B8A)),
    ],
  );

  // ── Section 6: GravitySimulation ─────────────────────────────
  print('\n[6] GravitySimulation');
  print('  accel=9.8, dist=0.0, endDist=500.0, vel=0.0');
  print('  x(0.0) = ${phGravity.x(0.0).toStringAsFixed(4)}');
  print('  x(5.0) = ${phGravity.x(5.0).toStringAsFixed(4)}');

  final phGravitySection = phSimCard(
    'GravitySimulation',
    Icons.south,
    Color(0xFF457B8C),
    [
      phInfoRow('Type:', 'Constant acceleration (free fall)'),
      phInfoRow('Parameters:', 'acceleration, distance, endDistance, velocity'),
      phInfoRow('Formula:', 'x(t) = x0 + v0*t + 0.5*a*t^2'),
      SizedBox(height: 8.0),
      _phValueTable('Time', 'x(t)', 'dx(t)', [
        ['0.0', phGravity.x(0.0), phGravity.dx(0.0)],
        ['1.0', phGravity.x(1.0), phGravity.dx(1.0)],
        ['3.0', phGravity.x(3.0), phGravity.dx(3.0)],
        ['5.0', phGravity.x(5.0), phGravity.dx(5.0)],
        ['7.0', phGravity.x(7.0), phGravity.dx(7.0)],
      ], Color(0xFF457B8C)),
    ],
  );

  // ── Section 7: ClampedSimulation ─────────────────────────────
  print('\n[7] ClampedSimulation');
  print('  Wraps spring, xMin=0.0, xMax=0.8');
  print('  x(0.5) = ${phClamped.x(0.5).toStringAsFixed(4)}');

  final phClampedSection = phSimCard(
    'ClampedSimulation',
    Icons.compress,
    Color(0xFF6BA3B0),
    [
      phInfoRow('Type:', 'Wrapper that clamps x(t) and dx(t)'),
      phInfoRow('Parameters:', 'simulation, xMin, xMax, dxMin, dxMax'),
      phInfoRow('Behavior:', 'Limits position and velocity ranges'),
      SizedBox(height: 8.0),
      Container(
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Color(0xFFF0F8F6),
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Raw spring vs Clamped (xMax=0.8):',
                style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF264653))),
            SizedBox(height: 4.0),
            ...['0.0', '0.25', '0.5', '0.75', '1.0'].map((t) {
              final tv = double.parse(t);
              final raw = phSpring.x(tv);
              final clamped = phClamped.x(tv);
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 1.0),
                child: Row(
                  children: [
                    SizedBox(
                        width: 40.0,
                        child: Text('t=$t',
                            style: TextStyle(
                                fontSize: 9.0, color: Color(0xFF457B8C)))),
                    SizedBox(
                        width: 80.0,
                        child: Text('raw: ${raw.toStringAsFixed(3)}',
                            style: TextStyle(
                                fontSize: 9.0, color: Color(0xFF2A9D8F)))),
                    Text('clamped: ${clamped.toStringAsFixed(3)}',
                        style: TextStyle(
                            fontSize: 9.0,
                            fontWeight: clamped != raw
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: clamped != raw
                                ? Color(0xFFCC7766)
                                : Color(0xFF457B8C))),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    ],
  );

  // ── Section 8: Live Value Comparison ─────────────────────────
  print('\n[8] Position Comparison x(t)');
  for (final t in [0.0, 0.5, 1.0, 2.0]) {
    print('  t=$t  spring=${phSpring.x(t).toStringAsFixed(2)}'
        '  friction=${phFriction.x(t).toStringAsFixed(2)}'
        '  gravity=${phGravity.x(t).toStringAsFixed(2)}');
  }

  final phComparisonSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF0F8F6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DDD8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Position x(t) Comparison',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF264653))),
        SizedBox(height: 8.0),
        // Header
        Row(
          children: [
            SizedBox(
                width: 36.0,
                child: Text('t',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10.0,
                        color: Color(0xFF264653)))),
            Expanded(
                child: Text('Spring',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10.0,
                        color: Color(0xFF2A9D8F)))),
            Expanded(
                child: Text('Friction',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10.0,
                        color: Color(0xFF1A6B8A)))),
            Expanded(
                child: Text('Gravity',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10.0,
                        color: Color(0xFF457B8C)))),
          ],
        ),
        Divider(color: Color(0xFFC0DDD8)),
        ...[0.0, 0.25, 0.5, 1.0, 2.0, 3.0].map((t) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                children: [
                  SizedBox(
                      width: 36.0,
                      child: Text(t.toString(),
                          style: TextStyle(
                              fontSize: 10.0, color: Color(0xFF264653)))),
                  Expanded(
                      child: Text(
                          phSpring.x(t).toStringAsFixed(3),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10.0, color: Color(0xFF2A9D8F)))),
                  Expanded(
                      child: Text(
                          phFriction.x(t).toStringAsFixed(1),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10.0, color: Color(0xFF1A6B8A)))),
                  Expanded(
                      child: Text(
                          phGravity.x(t).toStringAsFixed(1),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10.0, color: Color(0xFF457B8C)))),
                ],
              ),
            )),
      ],
    ),
  );

  // ── Section 9: Velocity Comparison ───────────────────────────
  print('\n[9] Velocity Comparison dx(t)');
  for (final t in [0.0, 0.5, 1.0]) {
    print('  t=$t  spring=${phSpring.dx(t).toStringAsFixed(2)}'
        '  friction=${phFriction.dx(t).toStringAsFixed(2)}'
        '  gravity=${phGravity.dx(t).toStringAsFixed(2)}');
  }

  final phVelocitySection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFE0F4F0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DDD8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Velocity dx(t) Comparison',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF264653))),
        SizedBox(height: 8.0),
        Row(
          children: [
            SizedBox(
                width: 36.0,
                child: Text('t',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10.0,
                        color: Color(0xFF264653)))),
            Expanded(
                child: Text('Spring',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10.0,
                        color: Color(0xFF2A9D8F)))),
            Expanded(
                child: Text('Friction',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10.0,
                        color: Color(0xFF1A6B8A)))),
            Expanded(
                child: Text('Gravity',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 10.0,
                        color: Color(0xFF457B8C)))),
          ],
        ),
        Divider(color: Color(0xFFC0DDD8)),
        ...[0.0, 0.25, 0.5, 1.0, 2.0, 3.0].map((t) => Padding(
              padding: EdgeInsets.symmetric(vertical: 2.0),
              child: Row(
                children: [
                  SizedBox(
                      width: 36.0,
                      child: Text(t.toString(),
                          style: TextStyle(
                              fontSize: 10.0, color: Color(0xFF264653)))),
                  Expanded(
                      child: Text(
                          phSpring.dx(t).toStringAsFixed(3),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10.0, color: Color(0xFF2A9D8F)))),
                  Expanded(
                      child: Text(
                          phFriction.dx(t).toStringAsFixed(2),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10.0, color: Color(0xFF1A6B8A)))),
                  Expanded(
                      child: Text(
                          phGravity.dx(t).toStringAsFixed(2),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10.0, color: Color(0xFF457B8C)))),
                ],
              ),
            )),
      ],
    ),
  );

  // ── Section 10: isDone Behavior ──────────────────────────────
  print('\n[10] isDone Behavior');
  for (final t in [0.5, 1.0, 5.0, 10.0]) {
    print('  t=$t  spring=${phSpring.isDone(t)}'
        '  friction=${phFriction.isDone(t)}'
        '  gravity=${phGravity.isDone(t)}');
  }

  final phDoneSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF0F8F6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DDD8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('isDone(t) — When Simulations Complete',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF264653))),
        SizedBox(height: 8.0),
        ...[0.5, 1.0, 2.0, 5.0, 10.0, 20.0].map((t) {
          final sDone = phSpring.isDone(t);
          final fDone = phFriction.isDone(t);
          final gDone = phGravity.isDone(t);
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                SizedBox(
                    width: 50.0,
                    child: Text('t=${t.toStringAsFixed(1)}',
                        style: TextStyle(
                            fontSize: 10.0, color: Color(0xFF264653)))),
                Expanded(child: _phDoneChip('Spring', sDone)),
                Expanded(child: _phDoneChip('Friction', fDone)),
                Expanded(child: _phDoneChip('Gravity', gDone)),
              ],
            ),
          );
        }),
        SizedBox(height: 6.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'isDone() returns true when the simulation has reached '
            'equilibrium within the tolerance. Spring settles when '
            'near target with low velocity. Friction when stopped. '
            'Gravity when past end distance.',
            style: TextStyle(
                fontSize: 10.0,
                fontStyle: FontStyle.italic,
                color: Color(0xFF457B8C)),
          ),
        ),
      ],
    ),
  );

  // ── Section 11: Tolerance ────────────────────────────────────
  print('\n[11] Tolerance');
  print('  Default: Tolerance.defaultTolerance');
  print('  distance: ${Tolerance.defaultTolerance.distance}');
  print('  velocity: ${Tolerance.defaultTolerance.velocity}');
  print('  time: ${Tolerance.defaultTolerance.time}');

  final phToleranceSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFE0F4F0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DDD8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tolerance Configuration',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF264653))),
        SizedBox(height: 8.0),
        phInfoRow('distance:', '${Tolerance.defaultTolerance.distance}'),
        phInfoRow('velocity:', '${Tolerance.defaultTolerance.velocity}'),
        phInfoRow('time:', '${Tolerance.defaultTolerance.time}'),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'Tolerance(\n'
            '  distance: 0.001,  // position tolerance\n'
            '  velocity: 0.001,  // velocity tolerance\n'
            '  time: 0.001,      // time tolerance\n'
            ')\n\n'
            '// Assign custom tolerance:\n'
            'simulation.tolerance = Tolerance(\n'
            '  distance: 0.01,\n'
            '  velocity: 0.01,\n'
            ');',
            style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: Color(0xFF264653)),
          ),
        ),
      ],
    ),
  );

  // ── Section 12: AnimationController Integration ──────────────
  print('\n[12] AnimationController Integration');
  print('  controller.animateWith(simulation)');
  print('  Drives animation using physics model');

  final phAnimSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF0F8F6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DDD8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('AnimationController.animateWith()',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF264653))),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            '// Spring-based animation\n'
            'final spring = SpringSimulation(\n'
            '  SpringDescription(\n'
            '    mass: 1.0,\n'
            '    stiffness: 100.0,\n'
            '    damping: 10.0,\n'
            '  ),\n'
            '  controller.value, // start\n'
            '  targetValue,       // end\n'
            '  currentVelocity,   // velocity\n'
            ');\n'
            'controller.animateWith(spring);',
            style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: Color(0xFF264653)),
          ),
        ),
        SizedBox(height: 8.0),
        _phUsageRow(Icons.animation, 'Spring bounce',
            'Bouncy animations, drag gestures', Color(0xFF2A9D8F)),
        _phUsageRow(Icons.swipe, 'Friction decelerate',
            'Fling gestures, scroll momentum', Color(0xFF1A6B8A)),
        _phUsageRow(Icons.arrow_downward, 'Gravity drop',
            'Falling objects, toss effects', Color(0xFF457B8C)),
      ],
    ),
  );

  // ── Section 13: Scroll Physics Connection ────────────────────
  print('\n[13] Scroll Physics Connection');
  print('  ScrollPhysics creates simulations for scroll behavior');
  print('  BouncingScrollPhysics → SpringSimulation');
  print('  ClampingScrollPhysics → FrictionSimulation');

  final phScrollSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFE0F4F0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DDD8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Scroll Physics ↔ Simulation',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF264653))),
        SizedBox(height: 10.0),
        _phScrollCard('BouncingScrollPhysics', 'iOS-style bounce',
            'Creates SpringSimulation for overscroll recovery',
            Color(0xFF2A9D8F)),
        _phScrollCard('ClampingScrollPhysics', 'Android clamp',
            'Creates FrictionSimulation for momentum',
            Color(0xFF1A6B8A)),
        _phScrollCard('NeverScrollableScrollPhysics', 'Disabled',
            'No simulation created — scroll locked',
            Color(0xFF6BA3B0)),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'The fling velocity from a drag gesture is passed to the '
            'physics simulation. The simulation computes position over '
            'time, updating the scroll offset each frame until isDone.',
            style: TextStyle(
                fontSize: 10.0,
                fontStyle: FontStyle.italic,
                color: Color(0xFF457B8C)),
          ),
        ),
      ],
    ),
  );

  // ── Section 14: Visual Timeline ──────────────────────────────
  print('\n[14] Visual Position Timeline');
  print('  Visual bars showing x(t) progression');

  final phTimelineSection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF0F8F6),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DDD8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Spring Position x(t) Timeline',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF264653))),
        Text('Target: 1.0, showing approach and possible overshoot',
            style: TextStyle(
                fontSize: 10.0,
                fontStyle: FontStyle.italic,
                color: Color(0xFF457B8C))),
        SizedBox(height: 8.0),
        ...[0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.8, 1.0, 1.5, 2.0]
            .map((t) {
          final pos = phSpring.x(t).clamp(0.0, 1.5);
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: Row(
              children: [
                SizedBox(
                    width: 36.0,
                    child: Text(t.toStringAsFixed(1),
                        style: TextStyle(
                            fontSize: 9.0, color: Color(0xFF264653)))),
                Expanded(
                  child: SizedBox(
                    height: 14.0,
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFE0F4F0),
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                        ),
                        FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: (pos / 1.5).clamp(0.0, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFF2A9D8F),
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 4.0),
                SizedBox(
                    width: 40.0,
                    child: Text(phSpring.x(t).toStringAsFixed(3),
                        style: TextStyle(
                            fontSize: 9.0, color: Color(0xFF457B8C)))),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ── Section 15: Type Hierarchy ───────────────────────────────
  print('\n[15] Type Hierarchy');
  print('  Simulation (abstract)');
  print('    ├─ SpringSimulation');
  print('    ├─ FrictionSimulation');
  print('    ├─ GravitySimulation');
  print('    ├─ ClampedSimulation');
  print('    └─ BouncingScrollSimulation');

  final hierarchyItems = <Map<String, dynamic>>[
    {
      'name': 'Simulation',
      'desc': 'Abstract base — x(t), dx(t), isDone(t)',
      'color': Color(0xFF264653),
      'indent': 0,
    },
    {
      'name': 'SpringSimulation',
      'desc': 'Damped harmonic oscillator',
      'color': Color(0xFF2A9D8F),
      'indent': 1,
    },
    {
      'name': 'ScrollSpringSimulation',
      'desc': 'Spring with clamping for scroll',
      'color': Color(0xFF2A9D8F),
      'indent': 2,
    },
    {
      'name': 'FrictionSimulation',
      'desc': 'Exponential velocity decay',
      'color': Color(0xFF1A6B8A),
      'indent': 1,
    },
    {
      'name': 'GravitySimulation',
      'desc': 'Constant acceleration',
      'color': Color(0xFF457B8C),
      'indent': 1,
    },
    {
      'name': 'ClampedSimulation',
      'desc': 'Wraps another with min/max clamp',
      'color': Color(0xFF6BA3B0),
      'indent': 1,
    },
    {
      'name': 'BouncingScrollSimulation',
      'desc': 'Combines friction + spring for iOS scroll',
      'color': Color(0xFF2A9D8F),
      'indent': 1,
    },
  ];

  final phHierarchySection = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFE0F4F0),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFC0DDD8)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Simulation Class Hierarchy',
            style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF264653))),
        SizedBox(height: 10.0),
        ...hierarchyItems.map((h) {
          final indent = (h['indent'] as int) * 20.0;
          return Padding(
            padding: EdgeInsets.only(left: indent, bottom: 6.0),
            child: Row(
              children: [
                Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: h['color'] as Color,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 6.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(h['name'] as String,
                          style: TextStyle(
                              fontSize: 11.0,
                              fontWeight: FontWeight.w700,
                              color: h['color'] as Color)),
                      Text(h['desc'] as String,
                          style: TextStyle(
                              fontSize: 9.0,
                              color: Color(0xFF457B8C))),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ── Section 16: Summary Dashboard ────────────────────────────
  print('\n[16] Summary Dashboard');
  print('  4 concrete simulation types demonstrated');
  print('  Key: x(t), dx(t), isDone(t)');

  final phSummarySection = Container(
    width: double.infinity,
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF1A6B8A), Color(0xFF264653)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text('Physics Simulation Dashboard',
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Text('4',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA0D4DA))),
                Text('Concrete types',
                    style: TextStyle(
                        fontSize: 11.0, color: Color(0xFF7AB8C4))),
              ],
            ),
            Column(
              children: [
                Text('3',
                    style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA0D4DA))),
                Text('API methods',
                    style: TextStyle(
                        fontSize: 11.0, color: Color(0xFF7AB8C4))),
              ],
            ),
            Column(
              children: [
                Icon(Icons.science, color: Color(0xFFA0D4DA), size: 28.0),
                Text('Physics core',
                    style: TextStyle(
                        fontSize: 11.0, color: Color(0xFF7AB8C4))),
              ],
            ),
          ],
        ),
        SizedBox(height: 10.0),
        Wrap(
          spacing: 6.0,
          alignment: WrapAlignment.center,
          children: [
            phChip('Spring', Color(0xFF2A9D8F)),
            phChip('Friction', Color(0xFF1A6B8A)),
            phChip('Gravity', Color(0xFF457B8C)),
            phChip('Clamped', Color(0xFF6BA3B0)),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
            'spring.x(1.0)=${phSpring.x(1.0).toStringAsFixed(4)}  '
            'friction.x(1.0)=${phFriction.x(1.0).toStringAsFixed(1)}  '
            'gravity.x(1.0)=${phGravity.x(1.0).toStringAsFixed(1)}',
            style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: Color(0xFFA0D4DA))),
      ],
    ),
  );

  print('\nPhysics Simulation Deep Demo complete');

  // ── Assemble ─────────────────────────────────────────────────
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1 Title
        phTitleSection,
        SizedBox(height: 16.0),
        // 2 Base Class
        phSectionHeader('Simulation Base Class', Icons.account_tree),
        phBaseSection,
        // 3 Spring
        phSectionHeader('SpringSimulation', Icons.waves),
        phSpringSection,
        // 4 SpringDescription
        phSectionHeader('SpringDescription Parameters', Icons.tune),
        phSpringDescSection,
        // 5 Friction
        phSectionHeader('FrictionSimulation', Icons.drag_indicator),
        phFrictionSection,
        // 6 Gravity
        phSectionHeader('GravitySimulation', Icons.south),
        phGravitySection,
        // 7 Clamped
        phSectionHeader('ClampedSimulation', Icons.compress),
        phClampedSection,
        // 8 Position
        phSectionHeader('Position Comparison', Icons.compare_arrows),
        phComparisonSection,
        // 9 Velocity
        phSectionHeader('Velocity Comparison', Icons.speed),
        phVelocitySection,
        // 10 isDone
        phSectionHeader('isDone Behavior', Icons.check_circle),
        phDoneSection,
        // 11 Tolerance
        phSectionHeader('Tolerance', Icons.thermostat),
        phToleranceSection,
        // 12 Animation
        phSectionHeader('AnimationController', Icons.animation),
        phAnimSection,
        // 13 Scroll
        phSectionHeader('Scroll Physics', Icons.swap_vert),
        phScrollSection,
        // 14 Timeline
        phSectionHeader('Position Timeline', Icons.timeline),
        phTimelineSection,
        // 15 Hierarchy
        phSectionHeader('Type Hierarchy', Icons.schema),
        phHierarchySection,
        // 16 Summary
        SizedBox(height: 8.0),
        phSummarySection,
      ],
    ),
  );
}

// ── Top-level helpers ───────────────────────────────────────────
Widget _phApiRow(IconData icon, String name, String desc, Color accent) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: accent, size: 16.0),
        SizedBox(width: 6.0),
        SizedBox(
          width: 120.0,
          child: Text(name,
              style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'monospace',
                  color: Color(0xFF264653))),
        ),
        Expanded(
          child: Text(desc,
              style: TextStyle(fontSize: 10.0, color: Color(0xFF457B8C))),
        ),
      ],
    ),
  );
}

Widget _phValueTable(String colT, String colX, String colDx,
    List<List<dynamic>> rows, Color accent) {
  return Column(
    children: [
      Row(
        children: [
          SizedBox(
              width: 36.0,
              child: Text(colT,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 10.0,
                      color: Color(0xFF264653)))),
          Expanded(
              child: Text(colX,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 10.0,
                      color: accent))),
          Expanded(
              child: Text(colDx,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 10.0,
                      color: accent))),
        ],
      ),
      Divider(color: Color(0xFFC0DDD8)),
      ...rows.map((r) => Padding(
            padding: EdgeInsets.symmetric(vertical: 1.0),
            child: Row(
              children: [
                SizedBox(
                    width: 36.0,
                    child: Text(r[0] as String,
                        style: TextStyle(
                            fontSize: 9.0, color: Color(0xFF264653)))),
                Expanded(
                    child: Text((r[1] as double).toStringAsFixed(4),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 9.0, color: Color(0xFF457B8C)))),
                Expanded(
                    child: Text((r[2] as double).toStringAsFixed(4),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 9.0, color: Color(0xFF457B8C)))),
              ],
            ),
          )),
    ],
  );
}

Widget _phParamCard(String name, String value, String desc, Color accent) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 6.0),
    padding: EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6.0),
      border: Border(left: BorderSide(color: accent, width: 3.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(name,
                style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'monospace',
                    color: Color(0xFF264653))),
            SizedBox(width: 8.0),
            phChip(value, accent),
          ],
        ),
        SizedBox(height: 4.0),
        Text(desc,
            style: TextStyle(fontSize: 10.0, color: Color(0xFF457B8C))),
      ],
    ),
  );
}

Widget _phDampingRow(String label, String desc, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        Container(
          width: 10.0,
          height: 10.0,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6.0),
        SizedBox(
            width: 100.0,
            child: Text(label,
                style: TextStyle(
                    fontSize: 10.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF264653)))),
        Expanded(
            child: Text(desc,
                style: TextStyle(
                    fontSize: 10.0, color: Color(0xFF457B8C)))),
      ],
    ),
  );
}

Widget _phDoneChip(String label, bool done) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 2.0),
    padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
    decoration: BoxDecoration(
      color: done ? Color(0xFFD4EAE2) : Color(0xFFEAD4D4),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Text(
      done ? 'done' : 'running',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 8.0,
          fontWeight: FontWeight.w600,
          color: done ? Color(0xFF2A7A5A) : Color(0xFF9A4A4A)),
    ),
  );
}

Widget _phUsageRow(IconData icon, String title, String desc, Color color) {
  return Padding(
    padding: EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 16.0),
        SizedBox(width: 6.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF264653))),
            Text(desc,
                style: TextStyle(
                    fontSize: 10.0, color: Color(0xFF457B8C))),
          ],
        ),
      ],
    ),
  );
}

Widget _phScrollCard(String name, String tag, String desc, Color accent) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(bottom: 8.0),
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      border: Border(left: BorderSide(color: accent, width: 3.0)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(name,
                      style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF264653))),
                  SizedBox(width: 6.0),
                  phChip(tag, accent),
                ],
              ),
              SizedBox(height: 4.0),
              Text(desc,
                  style: TextStyle(
                      fontSize: 10.0, color: Color(0xFF457B8C))),
            ],
          ),
        ),
      ],
    ),
  );
}
