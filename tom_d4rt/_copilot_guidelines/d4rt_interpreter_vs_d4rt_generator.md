# D4rt Interpreter vs Generator Boundary

Which code in the interpreter packages is **generator support code** — it lives
there because every generated bridge calls it — and which is **pure interpreter
logic**. The distinction decides where a bug is tracked, and who has to be told.

This is the maintained copy. `tom_d4rt_exec/_copilot_guidelines/` and the
workspace's `_copilot_guidelines/d4rt/` carry pointers to it.

---

## The packages involved

| Package | What it is | Path |
| ------- | ---------- | ---- |
| `tom_d4rt` | The analyzer-based interpreter, and the reference | `tom_ai/d4rt/tom_d4rt` |
| `tom_d4rt_ast` | Its analyzer-free twin; every file named below has a mirror under `lib/src/runtime/` except `script_execution.dart` and `module_loader.dart`, which read source and so have no analyzer-free counterpart | `tom_ai/d4rt/tom_d4rt_ast` |
| `tom_d4rt_generator` | The bridge generator — writes the `*.b.dart` files that call into the code below | `tom_ai/d4rt/tom_d4rt_generator` |

Generator support code sits in the INTERPRETER packages, not in the generator,
because it runs inside the interpreter at execution time: generated bridges
call it. That is also why a fix to it is an interpreter fix for release and
mirroring purposes — it lands in both `tom_d4rt` and `tom_d4rt_ast` (see
`_copilot_guidelines/d4rt/mirror_maintenance.md`) — while being a generator
concern for tracking purposes.

---

## Where a bug is tracked

| The defect is in | Track it in |
| ---------------- | ----------- |
| Generator support code (below), or the shape of generated bridge code | `tom_d4rt_generator/doc/issues.md` |
| Pure interpreter logic (below) | `tom_d4rt/doc/issues.md`, or `tom_d4rt/doc/d4rt_limitations.md` for a documented limitation |
| A failure seen in the Flutter bridge corpus | `tom_d4rt_flutter_ast/doc/interpreter_issues.md` (the cluster log), whichever side the cause turns out to be on |

Typical generator-support defects: an argument extractor in `D4` that does not
coerce a value a script legitimately passes (a numeric promotion, a collection
of a bridged element type, a record); a user-bridge annotation the generator's
scanner misreads. Check `tom_d4rt_generator/doc/issues.md` for what is open —
this guide deliberately carries no list of current issues, because one written
here went stale while the code it described was being fixed.

---

## Generator support code

In `tom_d4rt/lib/src/generator/`, mirrored at
`tom_d4rt_ast/lib/src/runtime/generator/`.

### `generator/d4.dart` — the `D4` helper class

Static helpers that all generated bridge code calls:

```dart
// In generated bridge code:
final t = D4.validateTarget<MyClass>(target, 'MyClass');
final name = D4.getRequiredArg<String>(positional, 0, 'name', 'MyClass');
final items = D4.coerceList<Item>(positional[0], 'items');
```

| Method | Purpose |
| ------ | ------- |
| `D4.validateTarget<T>()` | Validate an instance method's target type |
| `D4.getRequiredArg<T>()` / `D4.getOptionalArg<T>()` | Extract a positional argument with type checking |
| `D4.getNamedArg<T>()` | Extract a named argument |
| `D4.coerceList<T>()` / `D4.coerceMap<K,V>()` | Coerce `List<Object?>` / `Map<Object?,Object?>` to the typed collection |
| `D4.requireMinArgs()` / `D4.requireExactArgs()` | Validate the argument count |
| `D4.extractBridgedArg<T>()` | Extract a bridged argument, unwrapping and coercing it |

### `generator/d4rt_user_bridge_annotation.dart`

Annotations for hand-written bridge overrides, which the generator's scanner
picks up:

| Annotation | Purpose |
| ---------- | ------- |
| `@D4rtUserBridge(libraryPath)` | Mark a class as a user bridge override |
| `@D4rtGlobalsUserBridge(libraryPath)` | Mark a class as a globals bridge override |
| `D4UserBridge` | Base class for user bridge implementations |

---

## Bridge type infrastructure

Types that generated code and the interpreter both use. A defect here is
usually an interpreter defect, because the interpreter is what gives these
types their behaviour; track it by where the cause is.

### `bridge/registration.dart`

Adapter typedefs: `BridgedConstructorCallable`, `BridgedMethodAdapter`,
`BridgedStaticMethodAdapter`, `BridgedInstanceGetterAdapter`,
`BridgedInstanceSetterAdapter`, `BridgedStaticGetterAdapter`,
`BridgedStaticSetterAdapter`.

### `bridge/bridged_types.dart`

`BridgedClass` (the definition of a bridged native class), `BridgedInstance`
(the runtime wrapper for a bridged object), `BridgedMixin`, `BridgedExtension`.

### `bridge/bridged_enum.dart`

`BridgedEnum` (the definition of a bridged enum) and `BridgedEnumValue` (the
runtime wrapper for one of its values).

---

## Script execution support

`script_execution.dart` provides file-based script execution, mainly for tests:
`executeFile()` (fresh interpreter state), `executeFileContinued()` (the
current environment), `resolveImportsRecursively()` (relative imports of a
multi-file script), and `ScriptExecutionResult`.

---

## Pure interpreter logic

Everything else in `lib/src/`:

| File | Purpose |
| ---- | ------- |
| `interpreter_visitor.dart` | AST evaluation |
| `runtime_types.dart` | Interpreted class and function types |
| `environment.dart` | Variable binding and scope |
| `callable.dart` | Function and method invocation, the async state machine |
| `declaration_visitor.dart` | Declaration processing |
| `module_loader.dart` | Imports and exports |
| `stdlib/` | The standard-library bridges |

---

## See also

- Generator issues: `tom_d4rt_generator/doc/issues.md`
- Interpreter issues: `tom_d4rt/doc/issues.md`
- Documented limitations: `tom_d4rt/doc/d4rt_limitations.md`
- Keeping the twins in step: `_copilot_guidelines/d4rt/mirror_maintenance.md`
