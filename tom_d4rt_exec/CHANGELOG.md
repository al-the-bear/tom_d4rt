## 1.16.0

### Fixed — an error keeps its type when it leaves `execute()` (scc35)

`lib/src/d4rt_base.dart` is exec's own copy of the execute boundary, and it
still called `isSdkShapedError`, which SCC27 deleted upstream. It compiled only
because the dependency pin held `tom_d4rt_ast` at 0.20.1 — so the pub.dev
resolution hazard was hiding a *compile break* here, not merely stale
behaviour. Both boundary sites now call `throwAsHostFacingError`, and the host
receives the type the callee actually raised.

The explicit type list those sites used to carry is deliberately not
reinstated. `D4rtException implements Exception`, so the general rule — an
`Error` or an `Exception` that is not an interpreter control-flow signal
escapes as itself — already admits every diagnostic type the list enumerated,
and unlike the list it does not need editing when a new one is added.

### Fixed — source that does not parse is rejected instead of partly run (scc35)

`_parseSourceToAst` returns a unit with `hasParseErrors` set rather than
throwing, because the expression paths try several parses in turn and need to
inspect a failed one before falling through to the next. Code on its way to the
interpreter has no next strategy, and nothing rejected the unit on its behalf —
so a script with a syntax error ran the fragment the parser salvaged and
reported success for a program the author never wrote.

`_parseExecutableSource` now performs that rejection for the three entry points
that execute source and for the module loader, raising
`SourceCodeD4rtException` with one formatted line per diagnostic, each naming
its line and column. Three cases in `interpreter_test.dart` had recorded the
old behaviour as a property of the serialized-AST pipeline; they assert the
parser diagnostic again, matching `tom_d4rt`, and the file is now a verbatim
port of the reference copy.

## 1.15.1

### Changed — formatted the tree once, at the aligned language version (scc26)

Follows 1.15.0, which raised this package's SDK floor to `^3.10.4`. Raising the
floor changes what `dart format` produces here, so leaving the tree unformatted
would have left a latent trap: the next person to format any single file would
have rewritten it wholesale. Formatting once removes it.

This commit contains the formatter's output and nothing else. That it is inert
was not assumed — `git diff -w` cannot establish it, because the tall style
*splits* lines and a whitespace-insensitive diff still counts a moved line
boundary as a change. What was checked instead is the token stream: strip all
whitespace and the two revisions of every changed file are either identical
(153 files) or identical once trailing commas are also stripped (893 files),
commas being pure formatting punctuation in Dart. Zero files carried an edit
that survived both passes.

## 1.15.0

### Changed — the declared SDK floor now matches the one pub can actually reach (scc26)

`environment.sdk` said `^3.5.0` while this package's own dependency
`tom_d4rt_ast` declares `^3.10.4`, so the floor was unreachable in exactly the
way `tom_d4rt`'s was. It is now `^3.10.4`.

The floor is not only a resolution constraint: `dart format` takes its style
from the language version, and the tall style begins at 3.7. Leaving a
deliberately low floor in place means the formatter produces a different layout
here than in the packages this one is built from — which is the divergence
scc26 exists to remove.

No lint fallout and no behaviour changes.

## 1.14.0

### Fixed — a preloaded source stub shadowed the bridge registered at the same URI (scc14)

`ModuleLoader._fetchModuleSource` returned a `sources` entry as soon as the URI
matched, before it ever asked whether that URI had bridged content. The
documented way to expose a bridge to a multi-source script is to register it
under a URI and pass an empty entry for the same URI in `sources` so the import
resolves — and that empty entry won: the module loaded as an empty library and
every bridged name in it was undefined.

```dart
interpreter.registerBridgedClass(beepBridge, 'test:beep');
interpreter.execute(
  library: 'main',
  sources: {'main': "import 'test:beep';\n…", 'test:beep': ''},
  name: 'run',
); // Runtime Error: Undefined variable: Beep
```

The single-source form (`execute(source: …)`) was unaffected, as was the
multi-source form with no stub entry, which is why this survived: the failing
shape is the one the reference suite uses and this package had no test for.

A registered bridge now wins, which is what `tom_d4rt` and `tom_d4rt_ast` have
always done — both resolve bridged content before consulting sources. There is
no legitimate case for the other precedence: a URI cannot be both a native
library and an interpreted one.

### Added — eleven conformance suites ported from tom_d4rt (scc14)

`bridge/bridged_setter_unwrap`, `bridge/d4_helpers`,
`bridge/enum_map_arg_and_roundtrip`, `bridge/is_operator_on_unwrapped_native`,
`bridge/usage_log_runner`, `environment_bridge_cache`,
`null_safety/null_propagating_operators`, `scb9_error_handler_arity`,
`scb11_symbol_literal`, `scb14_await_receiver_position` and
`scb17_map_set_inherited_surface` — 107 cases that had only ever run against the
analyzer-based interpreter. The `is`-operator suite is the one that found the
loader defect above; the other ten passed on arrival.

`test/conformance_drift_test.dart`'s recipe gained a third import remap
(`package:tom_d4rt/src/generator/d4.dart` →
`package:tom_d4rt_ast/src/runtime/generator/d4.dart`). The rule behind all three:
a `src/` import resolves against `tom_d4rt_ast` under `src/runtime/`, while the
public library import resolves against `tom_d4rt_exec`.

## 1.13.0

### Fixed — the stdlib on-type probe was still reported as an error (tccc5)

1.12.0 fixed the on-type probe that runs *before* the stdlib fallback. The probe
*inside* it is a second call site with the same defect, and it is the noisier of
the two: `_resolveTypeForExtension` registers one stdlib module at a time and
asks whether the on-type has appeared, so every module that does not carry it
misses by construction, and an on-type that resolves nowhere misses in all of
them. It used the throwing `Environment.get` inside a `try`/`on
RuntimeD4rtException` that discarded the exception — but constructing one
already registers it with the `ErrorReporter`, so each miss left an `Undefined
variable: <Type>` behind.

An unresolvable on-type is not a runtime error: the loader's contract is to warn
and skip the extension (and, under `validateRegistrations`, return one collected
message). Importing a bridge library whose on-type is not itself bridged — a
crypto package's `Digest` — was therefore enough to fail a REPL `-test` run with
four errors while every assertion in it passed.

The probe now uses the non-throwing `Environment.lookup` and the `try`/`catch`
is gone: there is no longer an exception to swallow.

## 1.12.0

### Fixed — a handled on-type lookup miss was still reported as an error (tccc5)

Mirrors the `tom_d4rt` 1.28.0 fix. Registering a bridged extension probes the
global environment for its on-type and falls back to
`_resolveTypeForExtension` when the importing script has not also imported the
on-type's own library. The probe used the throwing `Environment.get`, whose
exception registers itself with the `ErrorReporter`; the loader caught it and
never revoked it, so every routine miss left a phantom
`Undefined variable: <Type>` behind and failed hosts that treat reported errors
as their pass/fail signal.

The probe now uses the non-throwing `Environment.lookup`.

## 1.11.0

### `basePath` / `allowFileSystemImports` are no longer dead parameters (DGUB3)

**`execute()`, `executeAsync()` and `validateRegistrations()` have always
ACCEPTED `basePath` and `allowFileSystemImports`, but `_initModule` dropped both
on the floor** — it never passed them to the `ModuleLoader`, which did not
declare them. Any filesystem import therefore failed with "Base URI not defined
in ModuleLoader" no matter what the caller passed. This is the exact
dead-parameter defect DFUB1 fixed in `tom_d4rt`; it was never mirrored here.

- `ModuleLoader` gains `basePath` + `allowFileSystemImports`, and `D4rt` threads
  both through. A relative import in an inline `source:` now resolves against
  `basePath`, and a root `library:` may live on disk rather than in the
  preloaded `sources` map.
- Nested relative imports resolve correctly: module URIs are canonicalized to a
  single absolute `file:` spelling before use (DFUB3's
  `_canonicalizeModuleUri`), so a module reached relatively resolves its *own*
  relative imports against its real location rather than against `basePath`. The
  module cache and the in-flight (cycle) registry are keyed by a
  symlink-resolved identity, so different spellings of one file load exactly
  once.
- **Every on-disk module read is gated by `FilesystemPermission`** (DFUB2's
  `_checkFileSystemSourceReadPermission`), which throws before any bytes are
  read.
- Missing-source errors now name the actual reason instead of blaming the
  stdlib: filesystem imports disabled, or not found with the *resolved path* the
  loader looked at. `package:` guidance is unchanged.
- New conformance suite `test/dgub3_filesystem_import_basepath_test.dart`
  (7 tests), the exec-side mirror of `dfub1_filesystem_import_basepath_test` and
  the read-gate half of `dfub2_filesystem_import_permission_test`.

**Known boundary (unchanged, now pinned):** `executeFile()` reaches module
sources by a different route — `resolveImportsRecursively`, a regex pre-walk in
`script_execution.dart` that reads every transitive import off disk with **no**
permission check and folds them into `sources` before the interpreter runs. That
path predates this change and its reads stay ungated; F-DGUB3-7 pins the
boundary so the gap stays visible. Closing it is tracked as dguc1.

`AstModuleLoader` in `tom_d4rt_ast` is deliberately untouched — it stays
lookup-only and free of `dart:io` so it remains usable where there is no
filesystem.

### Record type annotations resolve to their real shape (DGUB8)

Requires `tom_d4rt_ast >=0.14.0` and `tom_ast_generator >=0.1.5`. The fix itself
is upstream — this package has no record resolver of its own — but the constraint
bump is what delivers it, and the behaviour change is visible here.

Previously a record type annotation reached the interpreter carrying only its
ARITY: every field type became `dynamic`, and every named key became a synthetic
`$named0`, `$named1`, … Because the record VALUE side derives its runtime type
from the actual record, it carried the real key, so:

- a record with ANY named field matched nothing in either direction —
  `(42, label: 'answer') is (int, {String label})` answered **false** and now
  answers **true**;
- a positional-only record matched on arity while IGNORING field types —
  `(1, 'a') is (String, int)` answered **true**, unsoundly, and now answers
  **false**;
- consequently a record return-type mismatch was accepted unchecked.
  `(int, String) f() => ('wrong', 'shape');` **now throws** "can't be returned".

**The second and third are tightenings**: code that relied on a record `is` or a
record return type being accepted where the field types do not actually match
will start being rejected. Matching records are unaffected.

`test/dfub5_function_record_runtime_type_test.dart`'s five record cases were
pinned to the degraded answers while the fix was unpublished; they are now
tightened to the analyzer-tree expectations and the group no longer calls itself
degraded.

### Filesystem permission scopes are symlink-aware (DGUB5)

Also delivered by the `tom_d4rt_ast >=0.14.0` bump, and also a tightening.
`FilesystemPermission` now compares the grant and the requested path on their
REAL paths, with symlinks resolved, instead of on their literal spellings:

- **A grant on a resolved path now admits an unresolved spelling of the same
  location** — on macOS `Directory.systemTemp` hands back `/var/folders/...`,
  itself a symlink to `/private/var/folders/...`, so granting one and reading
  through the other used to be denied for no visible reason.
- **A symlink inside a granted directory no longer reaches outside it.** This is
  the security-relevant half: `<sandbox>/link_to_elsewhere/x` used to satisfy a
  `<sandbox>` grant because it was lexically in scope, while actually reading
  from wherever the link pointed.

**So this can deny operations that previously succeeded** — specifically, any
access that relied on a symlink to leave its granted directory. Grants that name
the location the operation really touches are unaffected, whichever way either
side is spelled. Paths that do not exist yet are still matched (resolution walks
up to the deepest existing ancestor and re-appends the remainder), and resolution
failures fall back to the literal spelling rather than throwing.

### Stdlib bridges from the SDK gap audit (SC1–SC11)

The same bump carries twenty-five previously unbridged `dart:core`,
`dart:async`, `dart:collection` and `dart:convert` classes, none of which had
ever been published: `Stopwatch`, `UriData`/`Uri.data`, `LinkedHashSet`,
`SplayTreeSet`, `UnmodifiableMapView`, `UnmodifiableSetView`, `StreamConsumer`,
seven catchable `dart:core` error types (`NoSuchMethodError`,
`ConcurrentModificationError`, `IndexError`, `TypeError`, `AssertionError`,
`StackOverflowError`, `OutOfMemoryError`), `StreamView`, `AsyncError`,
`StreamTransformerBase`, `DoubleLinkedQueue`/`DoubleLinkedQueueEntry`,
`BytesBuilder`, `JsonUtf8Encoder` and `ClosableStringSink`, plus the interpreter
fixes that made them reachable (`is` without `isAssignable`, catch-clause
matching against the new error hierarchy, a broadened `Stream.transform`, and a
queue supertype block that also repairs the already-shipped `ListQueue`). These
are additions, not tightenings.

## 1.10.0

### Security — scoped `FilesystemPermission` grants are now actually enforced (DFUB11)

**This is a behavioural tightening. Scripts that relied on the previous, laxer
matching will now be denied — hence the minor bump rather than a patch.**

- Consume `tom_d4rt_ast >=0.2.0`, which carries the per-operation filesystem
  gate and the canonical, segment-boundary scope matcher. A grant scoped to one
  directory used to behave exactly like `FilesystemPermission.any` once
  `dart:io` was importable: the import gate established only that *some*
  filesystem permission existed, and no bridged file/directory operation
  re-checked the path. Every read/write entry point in the `dart:io` bridges now
  checks the path BEFORE the native call, so a denial leaves the filesystem
  untouched.
- Scope matching is canonical: `..` segments are normalized away before the
  comparison (so `/allowed/../etc/passwd` no longer escapes a `/allowed` grant),
  and the prefix test lands on a path-segment boundary (so `/allowed_sneaky` is
  no longer treated as inside `/allowed`).
- This package's own `dart:io` import gate now asks the path-agnostic question
  (`{'type': 'filesystem', 'pathAgnostic': true}`). Without this, tightening the
  matcher would have turned every *scoped* grant into an import denial — the
  gate has no path to offer, so it must not be measured against a scoped grant's
  path. `pathAgnostic` waives the PATH check only; the read/write/execute flags
  are still enforced.
- New conformance suite `test/dfub11_filesystem_operation_permission_test.dart`
  (16 tests), the executable twin of the same suite in `tom_d4rt`.

## 1.9.0

### Dependencies
- Consume `tom_d4rt_ast ^0.1.9` for the import-optimization API: the
  process-global package pool (`providePackage` / `allowedPackages`),
  once-per-process bridge-extension hooks (`registerExtensions` /
  `finalizeBridges` / `warmup`), warm-parent reuse across executes, and
  `executeBundleAs<T>` result unwrapping. The `D4rt` wrapper exposes these
  through its inner `D4rtRunner`. Additive and backward compatible — existing
  `execute()` / `eval()` call sites are unaffected.

## 1.8.6

### Fixes
- Consume `tom_d4rt_ast ^0.1.8` (B2 "MarkdownParser clash" fix). The module
  loader no longer errors on same-name/different-source bridged class
  duplicates — it registers both and relies on the AST runtime's shadow
  fallback, matching the tolerant per-module behaviour of the tom_d4rt and
  tom_d4rt_ast runtimes.

## 1.8.5

- Housekeeping: test artifacts now live in a gitignored `testlog/` folder; `doc/` no longer ships machine-generated baselines or last_testrun.json. No code changes.

## 1.8.4

- Picks up `tom_d4rt_ast 0.1.6` (instance/bridged shadowing fix, implicit-
  `this` read fix, interpreter performance work) via the existing
  `^0.1.5` constraint.
- Documentation: BRIDGING_GUIDE, advanced/standard user guides, and
  limitations updated; README aligned with the source-primary documentation
  reframe.

## 1.8.3

### Dependencies
- Require `tom_d4rt_ast ^0.1.5` / `tom_ast_generator ^0.1.1` to pick up the
  `StaticResolver` slot-resolution pipeline (`resolvedSlot` / `declSlot`):
  parsed source is converted to a mirror AST whose resolved reads bind to
  frame slots, and the AST-driven interpreter serves them without name-map
  walks.

## 1.8.2

### Features
- Support extensible dart: library bridges - unknown dart: URIs now check for bridged content before throwing an error
- Allows external packages to register bridges for dart:ui and other dart: libraries

## 1.8.1

### Bug Fixes
- **GEN-056**: Fixed extension on-type resolution for stdlib and bridge types in the interpreter
- **G-DCLI-05/07/08/11/12/13/14**: All DCli bridge issues resolved — proper handling of DCli-specific bridged methods and types

### Tests
- **Flaky file IO tests**: Fixed race condition where all file IO tests (I-FILE-144 through I-FILE-159) shared a hardcoded `/tmp/test.txt` path. Under concurrent execution, one test's `deleteSync()` would remove the file while another was still using it. Each test now uses a unique filename (`/test_{ID}.txt`).
- 1680 tests pass (2 known I-BUG-14a/14b intentional failures excluded)

## 1.7.0

### Bug Fixes
- **G-GNRC-7**: Fixed `runtimeType` comparison with type identifiers. When comparing `runtimeType` (which returns a native `Type`) against type identifiers like `int` (which resolve to `BridgedClass`), the interpreter now correctly compares via `BridgedClass.nativeType`. This fixes F-bounded polymorphism tests involving `Comparable<T>` sort operations.

## 1.6.1

### Documentation
- **Advanced Bridging User Guide**: New comprehensive guide for the D4 helper class covering type coercion, argument extraction, target validation, and global function bridging
- **Example suite**: Added 5 runnable examples demonstrating D4 class usage patterns:
  - `d4_type_coercion_example.dart` - List and Map coercion
  - `d4_argument_extraction_example.dart` - Positional and named arguments
  - `d4_target_validation_example.dart` - Target validation and inheritance
  - `d4_globals_example.dart` - Global functions and variables
  - `d4_complete_bridge_example.dart` - Complete realistic example with enums, factories, and complex signatures

## 1.6.0

### Features
- **Comprehensive Dart language coverage**: All 20 areas of the Dart language now pass the dart_overview test suite
- **Extension types (Dart 3.3+)**: Full support for inline classes / extension types
- **sync* generators**: Fixed infinite loop issues with sync* generators (lazy evaluation now works correctly)
- **Improved extension support**: Extensions on bridged types and imported extensions now work correctly
- **Enhanced pattern matching**: Full support for logical OR patterns, when guards, record patterns with named fields and shorthand syntax

### Bug Fixes (99 total bugs tracked, 97 fixed)

#### Interpreter Core
- **Bug-93**: Int not implicitly promoted to double return type - fixed auto-promotion in return statements
- **Bug-94**: Cascade index assignment on property (`..headers['key'] = value`) now works correctly
- **Bug-96**: `super.name` constructor parameter forwarding now correctly passes values to super constructor
- **Bug-97**: `num` now recognized as satisfying `Comparable<num>` type bound
- **Bug-98**: Extension getters on bridged List resolved correctly, including accessing other extension members via implicit `this`
- **Bug-99**: `Stream.handleError` callback arity detection - callbacks with 1 or 2 parameters both work correctly
- **Bug-95**: `List.forEach` with native function tear-offs (like `print`) now works
- **Bug-79-92**: Various fixes for switch expressions, cascades, patterns, and class modifiers

#### Pattern Matching
- **Bug-81**: Pattern with `when` guard now works (`case String s when s.isNotEmpty`)
- **Bug-88**: Record pattern with `:name` shorthand syntax works
- **Bug-66, Bug-67**: Record patterns with named fields and if-case with int patterns fixed

#### Class System
- **Bug-84, Bug-85**: Mixin abstract method satisfaction and extending abstract final classes
- **Bug-72**: Bridged mixins properly resolved during class declaration
- **Bug-51**: Mixing in bridged mixins works correctly

#### Async/Stream
- **Bug-44**: Async generators completion detection
- **Bug-48**: `await for` stream iteration
- **Bug-73, Bug-74**: Async nested loops and return type handling

#### Standard Library
- **Bug-89**: `Enum.values.byName` (via List.byName extension) bridged
- **Bug-82, Bug-83**: Function.call and nullable function?.call() support
- **Bug-65**: Map.from constructor bridged

### Known Limitations (Won't Fix)
- **Lim-3**: Isolate execution with interpreted closures - fundamental limitation due to Dart's isolate serialization requirements
- **Bug-14**: Records with named fields or >9 positional fields return InterpretedRecord (Dart doesn't support dynamic record type creation)

### Test Coverage
- **1620 tests passing** (3 expected failures for "Won't Fix" limitations)
- **21 dart_overview_bugs_test** tests all passing
- All 20 Dart language areas demonstrated in dart_overview scripts

### Documentation
- Consolidated BRIDGING_GUIDE.md to single location in `doc/` folder
- Moved dart_overview and d4rt_bugs test scripts to tom_d4rt/example folder
- Updated documentation to reflect current capabilities

---

## 1.5.0

### Features
- **Script execution module**: New `ScriptExecutionResult` and file-based script execution with automatic import resolution
- **Bridge deduplication**: Complete deduplication system with `sourceUri` tracking to prevent duplicate registrations across packages
- **D4rtConfiguration enhancement**: Added library info support for better multi-package configurations
- **Unary operator fix**: Fixed unary operators (e.g., `-x`) on bridged instances

### Bug Fixes
- Fixed typedef callback wrapping in bridge registration
- Fixed type resolution for bridges with complex generics

### Internal
- Added shared script_execution module for D4rt-based CLI tools
- Improved error aggregation for bridge registration failures

## 1.4.0

### Features
- **Global getter lazy evaluation**: Added `GlobalGetter` wrapper class for lazy evaluation of top-level getters
- **registerGlobalGetter method**: New D4rt method `registerGlobalGetter(name, getter)` for registering getters that are evaluated at access time rather than registration time
- Essential for singleton patterns and values that may not be initialized at registration time

### Documentation
- Added "Global Variables and Getters" section to BRIDGING_GUIDE.md
- Documented when to use `registerGlobalVariable` vs `registerGlobalGetter`

## 1.3.1
- **Repository reorganization**: Moved to tom_module_d4rt repository as part of modular workspace structure
- Updated repository URL to https://github.com/al-the-bear/tom_module_d4rt

## 1.3.0
- **Operator bridging support**: BridgedInstance now supports all Dart operators
  - Arithmetic: +, -, *, /, ~/, %
  - Comparison: <, >, <=, >=, ==
  - Bitwise: &, |, ^, ~, <<, >>, >>>
  - Index: [], []=
  - Unary: - (negation)
- Added operator override documentation for UserBridge classes
- Added bridged_operators_test.dart with comprehensive operator tests

## 1.2.0
- Added D4 bridge helpers class for generated bridge code
  - Type coercion helpers (coerceList, coerceMap)
  - Argument extraction helpers (getRequiredArg, getOptionalArg, etc.)
  - Target validation for instance methods
  - Argument count validation
- D4 class moved from tom_dartscript_core to tom_d4rt

## 1.1.0
- Updated analyzer dependency to ^8.0.0 (from fixed 8.0.0)
- Bridge generator improvements and cleanup

## 1.0.4
- Changed dependency of analyzer to version 8.0.0

## 0.1.9
- **feat:positionalArgs and namedArgs** - Pass arguments directly to functions via execute()
  - Add `positionalArgs` parameter to D4rt.execute() for passing positional arguments
  - Add `namedArgs` parameter to D4rt.execute() for passing named arguments
  - Support complex data types (List, Map, nested structures) as arguments
  - Support function callbacks and async functions as arguments
  - Add 33 comprehensive test cases covering all argument passing patterns
  - Add parameter introspection methods: `positionalParameterNames` and `namedParameterNames` getters

- **feat: Introspection API** - Analyze code structure and get metadata at runtime
  - Add `analyze()` method to D4rt for code analysis without execution
  - Create IntrospectionResult with metadata about functions, classes, enums, variables, and extensions
  - Extract function signatures including parameter names, types, and default values
  - Extract class information: inheritance, mixins, interfaces, constructors, methods
  - Extract enum values and variants
  - Extract variable declarations and initializers
  - Extract extension definitions and extended types
  - Use AST-based analysis for accurate metadata extraction
  - Add 38 comprehensive test cases covering all declaration types and complex scenarios

- **feat: eval() method** - Dynamically execute code with current execution state
  - Add `eval()` method to D4rt for dynamic code execution
  - Preserve execution environment across eval calls
  - Support access to previously defined variables and functions
  - Support complex expressions and statements in eval
  - Support async/await in eval expressions
  - Add 39 comprehensive test cases covering expression evaluation and statement execution

- **fix: Environment import handling** - Tolerate duplicate imports with identical values
  - Allow re-importing the same symbol if the value is identical (same reference)
  - Use `identical()` comparison for duplicate detection
  - Support imports via multiple paths without conflict errors

## 0.1.8
- fix: security sandboxing with permission checks for file, process, and network operations; add platform access control

## 0.1.7
- **feat: Security sandboxing system** - Comprehensive permission-based security system to restrict dangerous operations
  - Implement modular permission system with `FilesystemPermission`, `NetworkPermission`, `ProcessRunPermission`, `IsolatePermission`
  - Block access to dangerous modules (`dart:io`, `dart:isolate`) by default unless explicitly granted
  - Add `d4rt.grant()`, `d4rt.revoke()`, `d4rt.hasPermission()` methods for permission management
  - Integrate permission checking into module loading and import directives
  - Support fine-grained permissions (specific paths, commands, network hosts)
  - Add comprehensive security tests to prevent malicious code execution
  - Enable safe execution environment for untrusted code

## 0.1.6
- fix: Nested for-in loops in async contexts now work correctly
- fix: Async nested for-in loops with await for streams works
- feat: enhance async execution state to support nested await-for loops and improve iterator management; add comprehensive tests for complex async scenarios
- **feat: Compound super operators** - Support for compound assignment operators on super properties (+=, -=, *=, /=, ~/=, %=, &=, |=, ^=, <<=, >>=, >>>=)
  - Implement proper lookup and evaluation of super properties in compound assignments
  - Support for both interpreted and bridged superclass properties
  - Add 6 comprehensive test cases covering all operator types and nested inheritance
- **feat: Bridged static methods as values** - Bridged static methods can now be treated as first-class function values
  - Support for accessing bridged static methods as callable values (e.g., `int.parse`)
  - Enable passing bridged static methods to higher-order functions
  - Store bridged static methods in collections and variables
  - Add 5 test cases for static method value usage patterns
- **feat: Complex generic type checking** - Enhanced runtime type checking for generic collections with type parameters
  - Support `is` operator with parameterized types (List<int>, Map<String, int>, etc.)
  - Runtime validation of generic type constraints
  - Proper handling of nested generic types and null safety
  - Add 10 comprehensive test cases for various generic type checking scenarios
- **feat: Complex await assignments** - Advanced await expression support in various contexts
  - Support await in conditional expressions (ternary operator)
  - Support await in list/map literals and collection operations
  - Support await in compound assignments and complex expressions
  - Support await in constructor arguments and method chains
  - Add 10 test cases covering complex async assignment patterns
- **feat: Stream transformers** - Complete implementation of StreamTransformer and stream manipulation
  - Implement `StreamTransformer.fromHandlers` with handleData, handleError, handleDone
  - Support stream transformation with custom logic
  - Implement bidirectional stream transformers
  - Support stream event handling and error propagation
  - Add 10 comprehensive test cases for stream transformation patterns
- **feat: Const expressions complexes** - Enhanced support for const expressions in various contexts
  - Support const List and Map literals with type parameters
  - Support const expressions in field initializers and default parameters
  - Support nested const collections and complex const expressions
  - Proper compile-time evaluation of const expressions
  - Add 15 test cases covering const expression usage patterns
- **feat: Feature #7 - Enhanced enums with mixins** - Enums can now use mixins to add functionality
  - Support `enum Name with Mixin` syntax
  - Mixins can add methods, getters, and properties to enum values
  - Support multiple mixins on a single enum
  - Full integration with enum values (index, name, toString)
  - Add 15 comprehensive test cases for enum-mixin combinations
- **feat: Extensions statiques** - Extensions can now declare static members (methods, getters, setters, fields)
  - Implement static member storage in `InterpretedExtension` class
  - Add static member access via `Extension.member` syntax
  - Support static method calls, property access, and assignments
  - Add support for prefix/postfix increment/decrement operators on static extension fields
  - Add 15 comprehensive test cases covering all static extension member types
- **feat: Enhance compound super assignments for bridged classes** - Full support for compound assignments on properties inherited from bridged superclasses
  - Fix `visitAssignmentExpression` to handle bridged superclass getters/setters in compound `super` assignments
  - Fix `InterpretedInstance.get()` to properly traverse bridged superclass hierarchy at each inheritance level
  - Fix `InterpretedInstance.set()` to properly handle bridged superclass setters at each inheritance level
  - Support nested inheritance chains (Interpreted → Interpreted → Bridged)
  - Add 5 comprehensive test cases for bridged super compound assignments
- **Total test count: 1269 tests passing** - All 8 planned features fully implemented with comprehensive test coverage

## 0.1.5
- feat: implement handling of factory constructors in InterpreterVisitor; add comprehensive tests for factory constructor behavior
- feat: enhance async execution state and interpreter visitor to support break/continue handling; add comprehensive tests for nested async loops
- feat: enhance async execution state and interpreter visitor to support async* generators; add comprehensive tests for generator behavior and control flow

## 0.1.4
- feat: add methods to find and retrieve bridged enum values in Environment and InterpreterVisitor; enhance handling of bridged enums in property access and binary expressions
- feat: enhance documentation across multiple files; add examples and clarify class functionalities in D4rt interpreter
## 0.1.3
- Implement complete `late` variable support with lazy initialization and proper error handling
- Add comprehensive late variable test coverage (33 test cases) including static fields, instance fields, final constraints, and error conditions
- Add LateVariable class with proper uninitialized access detection and assignment validation
- Enhance interpreter visitor to handle late variables in all contexts (local, static, instance)
- Fix nullable variable handling in interpreted class instances
- Add ComparableCore bridge to core standard library for better type comparison support
- Update documentation and project description for better clarity

## 0.1.2+1
- update project description in pubspec.yaml
- docs: minor updates to documentation in README.md

## 0.1.2
- Implement complete Isolate API with Capability, IsolateSpawnException, Isolate, SendPort, ReceivePort, RawReceivePort, RemoteError, and TransferableTypedData classes
- Add comprehensive isolate communication and message passing support
- Enhance async capabilities with Timer functionality and improved error handling
- Add UnawaitedAsync and TimeoutExceptionAsync classes for better async error management
- Implement additional HTTP methods and error handling in HttpClientIo
- Add toString method to DirectoryIo for better debugging
- Enhance FileSystemEntity with parentOf method and FileStat improvements
- Add FileSystemEvent static getters and methods
- Implement RawSocket and additional Socket classes for network programming
- Enhance Stream and Socket classes with additional utility methods
- Add IOSink, ProcessIo, and StringSink classes for improved I/O operations
- Implement Comparable interface for better type comparison support
- Add comprehensive test coverage for isolate, socket, and I/O functionality
- Update core typed data classes (Uint8List, Int16List, Float32List) with enhanced functionality
- Add list extension utilities for better collection manipulation

## 0.1.1
- Implement await for-in loop support for streams in interpreter
- Enhance pattern matching with support for rest elements in lists and maps
- Add support for await expressions in function and constructor arguments
- BREAKING CHANGE: BridgedClassDefinition has been removed and replaced with BridgedClass

## 0.1.0
- Added runtime checks for generic type constraints.
- Added support for compound bitwise assignment operators (&=, |=, etc.).
- Introduced Int16List and Float32List in typed_data.

## 0.0.9
- full support (generic classes/functions, type constraints, runtime validation)
- use BridgedClassDefinition for all Stdlib
- Support adjacent string literals in interpreter
- add operators support for InterpretedClass
- more features

## 0.0.8
- expose visitor getter
- add support for bridged mixins
- enhance async execution state with nested loop support 

## 0.0.7
- fix: support null safety

## 0.0.6
- Update docs

## 0.0.5
- minor fix

## 0.0.4
- Add 'import/export' directive support, support for 'show' and 'hide' combinators 
- Add some dart:collection & dart:typed_data
- Support for ParenthesizedExpression property access in simpleIdentifier in async state

## 0.0.3
- Fix infinite loop when using rethrow in try catch in async state

## 0.0.2
- Support web
- Fix return nativeValue for BridgedEnumValue to BridgedInstance argument

## 0.0.1

- Initial version.