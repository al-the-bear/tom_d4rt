# D4rt Bridge Generator Strategies

This document describes the design strategies for the D4rt bridge generator, particularly how it resolves symbols and generates imports.

---

## Symbol Resolution Strategy

### Core Principle

Follow Dart's own resolution logic - the barrel file is the source of truth. No deduplication heuristics needed because Dart itself doesn't allow ambiguity.

### Symbol Identity

A symbol is uniquely identified by: **name + library (source file)**

The same class from the same source file may be reachable through multiple barrels, but it's still ONE class.

### Tracking

For each discovered symbol, track:
1. **Name** - the symbol name
2. **Source library** - source file URI (canonical identity)
3. **Found via barrel** - which barrel + its show/hide clause (for resolution, not for import generation)

---

## Show/Hide Clause Handling

Show/hide clauses appear at two levels and BOTH must be respected:

### Export Statements (in barrel files)

```dart
export 'src/functions/find.dart' show Find, find;  // Only Find and find are public
export 'package:dcli_core/dcli_core.dart' hide internalHelper;
```

Export show/hide determines what's publicly visible from a barrel.

### Import Statements (in source files)

```dart
import 'package:dcli_core/dcli_core.dart' as core show find;  // Only core.find is available
import '../internal.dart' hide _privateImpl;
```

Import show/hide determines what types a source file can reference (affects dependency collection).

---

## Generation Phases

### Phase 1: Parse Primary Barrel

- Start with single barrel (e.g., `package:dcli/dcli.dart`)
- Parse all **export** statements, respecting show/hide
- Follow re-exports recursively, respecting show/hide at each level
- Result: set of visible symbols with their source files

### Phase 2: Collect Public API Surface

For each exported symbol, parse its source file:
- Collect types from public signatures (return types, parameters, fields, etc.)
- Respect **import** show/hide when determining what types are referenceable

### Phase 3: Resolve All Dependencies

- Continue collecting until closure (all referenced types found)
- Follow imports into external packages for missing types
- Always respect show/hide on both imports and exports

### Phase 4: Generate Bridge Imports

**Key insight: Import directly from source files with prefix**

For each source file that has symbols we need:
1. Collect all symbols we need from that file
2. Generate import with:
   - Direct source file path
   - Explicit `show` clause listing exactly those symbols
   - Unique prefix (`as pkgXYZ`)

```dart
import 'package:dcli/src/functions/find.dart' show Find, find, FindProgress as ext_dcli_find;
import 'package:dcli/src/functions/copy.dart' show copy, CopyException as ext_dcli_copy;
import 'package:dcli/src/progress/progress.dart' show Progress as ext_dcli_progress;
```

### Phase 5: Use Prefixed Types in Generated Code

All type references in generated bridge code use the prefix:

```dart
// Function bridge
'find': (visitor, positional, named, typeArgs) {
  final pattern = D4.getRequiredArg<String>(positional, 0, 'pattern', 'find');
  return ext_dcli_find.find(pattern);  // Returns ext_dcli_find.FindProgress
},

// Class bridge
class FindProgressBridge extends BridgedClass<ext_dcli_find.FindProgress> {
  // ...
}
```

---

## Why Direct Source Imports with Prefixes

1. **Explicit** - shows exactly what we need from each file
2. **No collisions** - prefixes guarantee no naming conflicts between different sources
3. **No inherited complexity** - no barrel show/hide chains to track/combine
4. **Self-documenting** - prefix shows origin (e.g., `ext_dcli_find`)
5. **Reliable** - mirrors what Dart compiler sees, with added safety

---

## Deduplication

- Same `(name, sourceLibrary)` found via different paths → same symbol, one import, one prefix
- Different sources → different prefixes, no collision possible

---

## Why No Exclusions Needed

- Export show/hide already filters what's public
- Import show/hide already filters what's referenceable  
- If something passes both filters, it's meant to be accessible
- Only exclude things we deliberately don't WANT to bridge (not for conflict resolution)

---

## Example: DCli's `find()` Function

```
dcli.dart exports: src/functions/find.dart show Find, find
```

Resolution path:
1. We find `find()` → returns `FindProgress`
2. `FindProgress` is in same file, also exported
3. We generate bridge for `find()` with import from source file
4. We generate bridge for `FindProgress` with same import prefix
5. `dcli_core.find()` is NEVER seen because it's not exported from `dcli.dart`

The internal `core.find()` call inside dcli's find() is implementation detail - not in public API surface.

---

## Additional Type Dependencies to Collect

Beyond direct class/function signatures, these additional type dependencies must be collected:

### Extension "On" Types

When an extension is exported, its "on" type must also be collected:

```dart
extension PlatformEx on Platform {
  String get osName => ...;
}
```

The `Platform` type must be collected even if not explicitly exported, because:
- The extension bridge needs to resolve the on-type for method dispatch
- Scripts using `PlatformEx` need `Platform` available

### Mixin Type Restrictions

Mixins can have type restrictions via `on` clauses:

```dart
mixin LoggableMixin on Object {
  void log() => print('$runtimeType');
}

mixin StatefulMixin on Widget {
  State createState();
}
```

The constraint types (`Object`, `Widget`) must be collected.

### Generic Type Bounds

Generic classes and functions can have type parameter bounds:

```dart
class Container<T extends Comparable<T>> { ... }

T maxValue<T extends Comparable<T>>(List<T> items) { ... }
```

The bound type (`Comparable`) must be collected for proper type checking.

### F-Bounded Polymorphism

Self-referential bounds require special handling:

```dart
class Enum<E extends Enum<E>> { ... }  // F-bounded
```

The generator should detect and handle recursive bounds.

---

## Configuration Implications

With this strategy, the buildkit.yaml configuration becomes simpler:

```yaml
- name: dcli
  barrelFiles:
    - package:dcli/dcli.dart    # Single barrel is sufficient
  barrelImport: package:dcli/dcli.dart
  outputPath: lib/src/d4rt_bridges/dcli_bridges.b.dart
```

No need for:
- Multiple barrel files (unless intentionally merging separate APIs)
- Extensive `excludeSourcePatterns` to resolve conflicts
- `followAllReExports` / `skipReExports` logic

The barrel file itself defines what's public - we just follow it.
