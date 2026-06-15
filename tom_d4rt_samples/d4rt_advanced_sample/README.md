# D4rt Advanced Sample — bridging a native library with the generator

> The introduction sample ran *pure* scripts: everything the program touched was
> built into the interpreter. This sample crosses the first boundary. It exposes
> **your own compiled Dart library** — a small geometry/physics engine — to D4rt
> scripts using the **bridge generator** (`tom_d4rt_generator`). Scripts then
> construct your native classes, call their methods, use their operators, and get
> native objects back, all while reading like ordinary Dart.

A D4rt script can only use types the interpreter knows about. Out of the box that
means `dart:core`, `dart:math`, and the other standard libraries. To let a script
say `PhysicsWorld()` and have it build a *real* instance of your compiled
`PhysicsWorld` class, the interpreter needs a **bridge**: a small adapter that
maps interpreted constructor/method/getter calls onto the native class. Writing
those adapters by hand is tedious and error-prone, so `tom_d4rt_generator`
generates them from your source.

This article walks through **one** example in depth — `physics_sim`, a script
that drives a stateful native physics world — and explains *how the bridge
generator works*: what it reads, what it emits, and how a call travels from
interpreted code into compiled code and back. The other two examples are
summarised at the end.

---

## Table of contents

1. [The problem bridges solve](#1-the-problem-bridges-solve)
2. [Project layout](#2-project-layout)
3. [Running it](#3-running-it)
4. [The native library](#4-the-native-library)
5. [The generator configuration: `buildkit.yaml`](#5-the-generator-configuration-buildkityaml)
6. [Running the generator](#6-running-the-generator)
7. [What the generator emits](#7-what-the-generator-emits)
8. [Registering the bridges in the runner](#8-registering-the-bridges-in-the-runner)
9. [The focus example: `physics_sim`](#9-the-focus-example-physics_sim)
10. [How a call crosses the boundary](#10-how-a-call-crosses-the-boundary)
11. [A real limitation, and how to read the error](#11-a-real-limitation-and-how-to-read-the-error)
12. [The other examples](#12-the-other-examples)
13. [Where to go next](#13-where-to-go-next)

---

## 1. The problem bridges solve

Consider this script:

```dart
import 'package:d4rt_advanced_sample/d4rt_advanced_sample.dart';

void main() {
  final world = PhysicsWorld(gravity: Vector2(0, -9.81));
  world.addBody(Vector2(0, 0), Vector2(5, 20));
  world.step(0.1);
}
```

`PhysicsWorld`, `Vector2`, `addBody`, `step` — none of these exist in the
interpreter. They are classes in *your* compiled library. For the interpreter to
execute this script it needs, for each type, a registered description that says:

- "`PhysicsWorld` has a constructor taking a named `gravity` of type `Vector2`;
  here is a function that, given the interpreted arguments, builds a native
  `PhysicsWorld` and returns it."
- "`PhysicsWorld` has a method `step(double)`; here is a function that, given the
  native target and the interpreted argument, calls `target.step(dt)`."
- …and so on for every constructor, method, getter, setter, and operator.

That description is a `BridgedClass`, and the bundle of `BridgedClass` objects for
a whole library is what "bridges" means. The generator produces them so you do
not have to.

---

## 2. Project layout

```
d4rt_advanced_sample/
├── pubspec.yaml                       # tom_d4rt + tom_d4rt_generator (dev)
├── buildkit.yaml                      # generator configuration
├── README.md                          # this article
├── run_example.sh / run_example.ps1   # runners (generate bridges if missing)
├── bin/
│   └── run_example.dart               # registers bridges, loads & runs a script
├── lib/
│   ├── d4rt_advanced_sample.dart      # the public barrel (HAND-WRITTEN)
│   ├── src/geometry/
│   │   ├── vector2.dart               # native Vector2          (HAND-WRITTEN)
│   │   ├── shapes.dart                # native Shape/Circle/Rect (HAND-WRITTEN)
│   │   └── physics_world.dart         # native PhysicsWorld/Body (HAND-WRITTEN)
│   ├── dartscript.b.dart              # registration class       (GENERATED)
│   ├── d4rt_bridges.b.dart            # bridge barrel            (GENERATED)
│   └── src/d4rt_bridges/
│       ├── geometry_bridges.b.dart    # the BridgedClass defs    (GENERATED)
│       └── relaxers.b.dart            # generics relaxers (empty) (GENERATED)
└── example/
    ├── physics_sim/main.dart + run.sh # the focus example
    ├── geometry_calc/main.dart + run.sh
    └── shape_report/main.dart + run.sh
```

The single most important distinction: **`*.b.dart` files are generated**. You
never edit them. If a bridge is wrong, you fix the generator's *input* (the
native source or `buildkit.yaml`) and regenerate. (When a bridge genuinely needs
hand-tuning, you write a *user bridge* — that is the subject of the
`d4rt_userbridges_sample`, not this one.)

---

## 3. Running it

From the package root:

```sh
./run_example.sh physics_sim     # the focus example
./run_example.sh geometry_calc
./run_example.sh shape_report
```

The runner generates the bridges automatically on first run if they are missing.
To regenerate them by hand at any time:

```sh
dart run tom_d4rt_generator:d4rtgen
```

Expected output for `./run_example.sh physics_sim` (abridged):

```
Simulating 2 bodies under gravity Vector2(0.00, -9.81)

t=0.1s
  body 0: pos=Vector2(0.50, 1.90)  speed=19.67
  body 1: pos=Vector2(0.80, 0.90)  speed=12.06
...
Highest body is now at y=8.53
```

---

## 4. The native library

The library is ordinary compiled Dart — nothing about it knows it will be
bridged. Three files, all under `lib/src/geometry/`:

**`vector2.dart`** — an immutable 2D vector with operators and a getter:

```dart
class Vector2 {
  final double x;
  final double y;
  const Vector2(this.x, this.y);
  const Vector2.zero() : x = 0, y = 0;

  Vector2 operator +(Vector2 other) => Vector2(x + other.x, y + other.y);
  Vector2 operator *(double scalar) => Vector2(x * scalar, y * scalar);
  double get magnitude => math.sqrt(x * x + y * y);
  Vector2 normalized() { /* ... */ }
  double dot(Vector2 other) => x * other.x + y * other.y;
}
```

**`shapes.dart`** — an abstract `Shape` with concrete `Circle` and `Rect`,
demonstrating that the generator bridges a polymorphic hierarchy.

**`physics_world.dart`** — a *stateful* service, `PhysicsWorld`, plus a `Body`
data class. This is the interesting one: it has a named-parameter constructor, a
method that takes two `Vector2`s and returns a `Body`, a `step` that mutates
internal state, and getters that return native objects and lists of native
objects.

The crucial bit of plumbing is the **barrel**, `lib/d4rt_advanced_sample.dart`:

```dart
export 'src/geometry/vector2.dart';
export 'src/geometry/shapes.dart';
export 'src/geometry/physics_world.dart';
```

The generator does not scan your whole package; it follows the barrel(s) you
point it at and bridges everything reachable through their exports. The barrel is
therefore your *public API surface for scripts*: export a type and scripts can
use it; keep it un-exported and it stays internal.

---

## 5. The generator configuration: `buildkit.yaml`

`buildkit.yaml` tells the generator what to bridge and where to put the output:

```yaml
d4rtgen:
  name: d4rt_advanced_sample
  helpersImport: package:tom_d4rt/tom_d4rt.dart
  generateBarrel: true
  barrelPath: lib/d4rt_bridges.b.dart
  generateDartscript: true
  dartscriptPath: lib/dartscript.b.dart
  registrationClass: AdvancedSampleBridges
  modules:
    - name: geometry
      barrelFiles:
        - lib/d4rt_advanced_sample.dart
      barrelImport: package:d4rt_advanced_sample/d4rt_advanced_sample.dart
      outputPath: lib/src/d4rt_bridges/geometry_bridges.b.dart
```

Reading it top to bottom:

- **`name`** — the package the bridges belong to.
- **`helpersImport`** — where the generated code imports its runtime helpers
  (`D4`, the bridge typedefs) from.
- **`generateDartscript` / `dartscriptPath` / `registrationClass`** — ask the
  generator to also emit a single convenience class (`AdvancedSampleBridges`)
  with a `register(d4rt)` method that wires up *every* module at once. This is
  what the runner calls.
- **`modules`** — one entry per logical group of bridges. Each module names the
  **`barrelFiles`** to follow, the **`barrelImport`** URI scripts will use to
  import them, and the **`outputPath`** for the generated `BridgedClass`
  definitions.

One module, one barrel, is all this sample needs. Larger surfaces (the
flutter-material bridges, for instance) declare many modules.

---

## 6. Running the generator

```sh
dart run tom_d4rt_generator:d4rtgen
```

The generator reads `buildkit.yaml`, resolves your package and its dependencies,
analyses the barrel's exported types with the Dart analyzer, and writes the
`*.b.dart` files listed above. It is deterministic: running it again over
unchanged input produces byte-identical output. You commit the generated files so
the project is browsable and runnable without a generation step, and regenerate
whenever the native library changes.

---

## 7. What the generator emits

Three generated artifacts matter here.

**`lib/src/d4rt_bridges/geometry_bridges.b.dart`** — the heart of it. For each
exported type it contains a `BridgedClass` with adapter lambdas. Conceptually,
the `PhysicsWorld.step` method becomes something like:

```dart
// (illustrative shape of generated code — do not hand-write this)
'step': (visitor, target, positionalArgs, namedArgs) {
  final world = target as PhysicsWorld;       // unwrap native target
  final dt = positionalArgs[0] as double;     // coerce interpreted arg
  world.step(dt);                              // call the real method
  return null;
},
```

Multiply that by every constructor, method, getter, setter, and operator across
`Vector2`, `Shape`, `Circle`, `Rect`, `PhysicsWorld`, and `Body`, and that file
is the complete adapter layer.

**`lib/dartscript.b.dart`** — the registration class named in the config:

```dart
class AdvancedSampleBridges {
  static void register([D4rt? interpreter]) {
    final d4rt = interpreter ?? D4rt();
    geometry_bridges.GeometryBridge.registerBridges(
      d4rt, 'package:d4rt_advanced_sample/d4rt_advanced_sample.dart');
    // ... also registers under sub-package barrels for direct imports
  }
}
```

This is the one symbol your host program imports. Calling `register(d4rt)`
installs every bridged type under the barrel URI, which is exactly the URI the
scripts import.

**`lib/src/d4rt_bridges/relaxers.b.dart`** — here it is an empty stub. It only
contains content when the library has generic types whose type arguments need
"relaxing" so the interpreter can pass them around. The geometry library has no
such generics, so the generator emits a stub and logs `No generic extraction
sites collected` — that warning is expected and harmless for this sample.

---

## 8. Registering the bridges in the runner

The runner is the introduction sample's runner plus one line. It loads the
example folder into a `sources` map (so multi-file scripts still work) and, before
executing, registers the generated bridges:

```dart
import 'package:tom_d4rt/d4rt.dart';
import 'package:d4rt_advanced_sample/dartscript.b.dart';   // the generated class

void _execute({required String source, String? library, Map<String, String>? sources, ...}) {
  final d4rt = D4rt();
  AdvancedSampleBridges.register(d4rt);     // <-- make the native library visible
  final result = d4rt.execute(source: source, library: library, sources: sources, ...);
  // ...
}
```

That single `register` call is the whole integration. After it, any script the
interpreter runs can `import
'package:d4rt_advanced_sample/d4rt_advanced_sample.dart';` and use the library.

---

## 9. The focus example: `physics_sim`

The script reads like plain Dart, but every object it touches is native:

```dart
import 'package:d4rt_advanced_sample/d4rt_advanced_sample.dart';

void main(List<String> args) {
  final world = PhysicsWorld(gravity: Vector2(0, -9.81));   // native ctor, named arg
  world.addBody(Vector2(0, 0), Vector2(5, 20), mass: 1.0);  // returns a native Body
  world.addBody(Vector2(0, 0), Vector2(8, 10), mass: 2.0);

  const dt = 0.1;
  for (var step = 1; step <= 5; step++) {
    world.step(dt);                                         // mutates native state
    for (var i = 0; i < world.bodies.length; i++) {
      final body = world.bodies[i];                         // native Body
      final speed = body.velocity.magnitude.toStringAsFixed(2); // bridged getter
      print('  body $i: pos=${body.position}  speed=$speed');
    }
  }
  // ... find the highest body ...
}
```

Notice the variety of bridged operations in play:

- **A named-parameter constructor** — `PhysicsWorld(gravity: ...)`.
- **A method returning a native object** — `addBody(...)` returns a `Body`.
- **State mutation across calls** — each `world.step(dt)` advances the *same*
  native world; the interpreter holds a reference to one compiled instance.
- **A getter returning a list of native objects** — `world.bodies`.
- **A bridged getter on a returned native object** — `body.velocity.magnitude`.
- **A bridged operator inside the engine** — `step` uses `Vector2`'s `+` and `*`,
  which run as compiled code; the script never sees them but benefits from them.

The script orchestrates; the physics runs natively.

---

## 10. How a call crosses the boundary

Trace `body.velocity.magnitude`:

1. The interpreter evaluates `body` to a **bridged instance** wrapping a native
   `Body`.
2. It looks up the getter `velocity` in `Body`'s `BridgedClass`, calls the
   generated adapter, which returns `target.velocity` — a native `Vector2`,
   re-wrapped as a bridged instance.
3. It looks up `magnitude` in `Vector2`'s `BridgedClass`, calls that adapter,
   which returns `target.magnitude` — a native `double`.
4. A `double` is a value type the interpreter handles directly, so it flows back
   into the script as an ordinary number.

Native objects are passed around **by reference, wrapped**; primitive values are
**unwrapped**. You never manage the wrapping — the generated adapters do it on
every crossing.

---

## 11. A real limitation, and how to read the error

While writing `physics_sim` you might reach for:

```dart
final highest = world.bodies.reduce((a, b) => a.position.y >= b.position.y ? a : b);
```

That throws:

```
Native error during bridged method call 'reduce' on List:
type '(dynamic, dynamic) => Object?' is not a subtype of
type '(Body, Body) => Body' of 'combine'
```

This is worth understanding rather than papering over. `reduce` on a native
`List<Body>` expects a combine function typed `(Body, Body) => Body`. The
interpreter builds the closure you pass as `(dynamic, dynamic) => Object?` —
its functions are dynamically typed — and the native `List.reduce` rejects it at
the type check. This is the kind of **generics/type-relaxation** gap the
generator's relaxer machinery exists to close for *bridged* generic types, but
`List` is a core type and the typed-combine case is a known edge.

The fix in script code is simply to not lean on the typed callback — a plain loop
is clearer and always works:

```dart
var highest = world.bodies.first;
for (final body in world.bodies) {
  if (body.position.y > highest.position.y) highest = body;
}
```

The lesson is the general one for interpreted code: when a native API insists on
a precisely-typed function argument, prefer an explicit loop, or push the typed
operation down into the native library where it runs as compiled code.

---

## 12. The other examples

- **`geometry_calc`** — exercises `Vector2`'s bridged operators (`+`, `-`, `*`),
  getter (`.magnitude`), and methods (`.dot`, `.normalized`) in isolation. The
  shortest demonstration that operators bridge just like methods. Run it with
  `./run_example.sh geometry_calc`.

- **`shape_report`** — builds a `List<Shape>` of mixed `Circle`/`Rect` and treats
  them polymorphically (`area`, `contains`, `describe`). Shows that an abstract
  base class plus subclasses bridges cleanly and that virtual dispatch works
  across the boundary. Run it with `./run_example.sh shape_report`.

The complete, runnable source — native library, `buildkit.yaml`, generated
bridges, runner, and all three scripts — lives in this repository under
`tom_d4rt_samples/d4rt_advanced_sample/`.

---

## 13. Where to go next

You can now expose any compiled Dart library to scripts. The remaining samples
build on this one:

- **`d4rt_dcli_sample`** — registers the **dcli** shell-scripting library
  alongside your own bridges, so scripts gain file/dir/process powers.
- **`d4rt_userbridges_sample`** — what to do when the generated bridge is *wrong*
  or incomplete: hand-written **user bridges** and advanced `buildkit.yaml`
  configuration knobs.
- **`d4rt_flutter_sample`** — the same bridging idea applied to Flutter widgets,
  rendering a UI described by a script.
