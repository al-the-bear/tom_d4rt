# Test Priority: physics

The hand-maintained tiers of the bridged classes, the input of `tool/testplan_report.dart`. Every row names a class the bridges register (the guard `test/testplan_fresh_test.dart` checks it); a bridged class no priority file names is Hardly Relevant. The counts and coverage are measured in the generated `testplan_*.md` files.

## Essential
Core classes used commonly in Flutter applications.

| Class | Description |
|-------|-------------|
| SpringDescription | Spring physics parameters |
| Tolerance | Simulation tolerance |

## Important
Commonly used classes for physics-based animations.

| Class | Description |
|-------|-------------|
| SpringSimulation | Spring physics simulation |
| ScrollSpringSimulation | Scroll spring physics |
| FrictionSimulation | Friction deceleration |
| Simulation | Base simulation class |

## Secondary
Specialized classes for advanced physics.

| Class | Description |
|-------|-------------|
| GravitySimulation | Gravity physics |
| ClampedSimulation | Clamped simulation |

## Hardly Relevant
Internal/specialized classes.

| Class | Description |
|-------|-------------|
| BoundedFrictionSimulation | Bounded friction |
