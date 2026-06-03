# tom_d4rt_flutter

> Source-based D4rt interpreter with the full Flutter Material bridge surface —
> renders interpreted Dart UI against **real Flutter widgets**.

`tom_d4rt_flutter` is the reusable library at the centre of the Flutter-facing
D4rt stack. It exposes `SourceFlutterD4rt`: a `tom_d4rt` interpreter pre-loaded
with the full generated Flutter Material bridge surface (17 generated bridge
files under `lib/src/bridges/`) plus hand-written runtime registrations
(interface proxies, type relaxers, generic factories) and the
`d4rt_user_bridges/` overrides. Feed it raw Dart source and it returns a live
`Widget`.

This package declares `publish_to: 'none'` — it lives inside the D4rt monorepo
and is consumed via path dependency by the demo/test application
(`tom_d4rt_flutter_test`) and the HTTP harness.

---

## Public API

```dart
import 'package:tom_d4rt_flutter/tom_d4rt_flutter.dart';

final runner = SourceFlutterD4rt();
final widget = runner.build(source, context); // interpret + render
```

The barrel (`lib/tom_d4rt_flutter.dart`) exports:

- `SourceFlutterD4rt` / `SourceFlutterD4rtException` — the interpreter runner.
- The sample-source types (`SampleProgram`, `SampleSource`, `createSampleSource`,
  `DiskSampleSource`, `AssetSampleSource`, `buildDiskProgram`, …) used to load
  multi-file sample apps; `SourceFlutterD4rt.buildMultiFile` builds these
  directly.

---

## Where it sits in the D4rt ecosystem

| Package | Role | Relationship |
|---------|------|--------------|
| **`tom_d4rt`** | Analyzer-based, source-driven D4rt interpreter. | **Path dependency** (`../tom_d4rt`) — the interpreter this library drives. |
| **`tom_d4rt_generator`** | The `d4rtgen` bridge generator. | **Dev path dependency** — regenerates `lib/src/bridges/*.b.dart`. |
| **`tom_d4rt_flutter_ast`** | AST/bundle parallel (`FlutterD4rt`). | Sibling. Shares the conformance script corpus (see *Testing*). |
| **`tom_d4rt_flutter_test`** | Interactive demo/test application. | Downstream consumer — depends on this library via `../tom_d4rt_flutter`. |

---

## Regenerating the bridges

The `lib/src/bridges/*.b.dart` files are generated from `buildkit.yaml`. Never
hand-edit them — fix the generator (`tom_d4rt_generator`) or the
`buildkit.yaml`/user-bridge sources, then regenerate:

```bash
dart run tool/regenerate_bridges.dart
```

`buildkit.yaml` retargets the analyzer-based `tom_d4rt` runner and sets
`generateTestRunner: false` (playback is driven by the consumers, not a
generated HTTP stub).

---

## Testing

The bridge conformance suite lives under `test/`. It drives a Flutter HTTP
harness app (`test/tom_d4rt_flutter_test_app/`, port `4248`) over HTTP: each
test POSTs raw Dart source to `/build` and asserts on the rendered widget,
captured `print()` output, and framework errors. The harness is launched and
recycled automatically by `test/send_test_runner.dart`.

The test scripts are the **shared corpus** in the sibling `tom_d4rt_flutter_ast`
package
(`../tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts`),
so the source-based and AST-based suites run identical scripts. The sibling
package must be checked out alongside this one.

```bash
# All HTTP-server tests share one local server — run serially (concurrency: 1).
flutter test test/essential_classes_test.dart
flutter test test/important_classes_test.dart
```

Suites, in rough order of coverage breadth: `essential_classes_test`,
`important_classes_test`, `secondary_classes_test`,
`hardly_relevant_classes_{1..5}_test`, plus the interpreter-issue,
cluster-repro, blocking, timeout, interactive, and suspicious-rewrite suites.
