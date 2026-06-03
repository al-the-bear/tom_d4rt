/// Analyzer-free D4rt runtime API surface for generated bridge packages.
///
/// This barrel mirrors the import shape that the D4rt bridge generator and
/// hand-written bridge packages expect (`package:<pkg>/d4rt.dart`), but it
/// resolves entirely within `tom_d4rt_ast` — the zero-dependency,
/// analyzer-free core. It carries **no** dependency on `tom_d4rt_exec`,
/// `tom_ast_generator`, or the `analyzer` package, so any consumer that only
/// needs to *run* pre-compiled `AstBundle`s (e.g. a Flutter app, including on
/// web) can depend on it without pulling in `dart:io`.
///
/// For source parsing (`String` → `AstBundle`), use `tom_d4rt_exec`, which is
/// a build-time/host concern and is intentionally kept out of this surface.
library;

// `import` (in addition to `export`) so the `D4rt` typedef below can resolve
// `D4rtRunner` within this library — a bare `export` re-exposes the name to
// consumers but does not bring it into this file's own scope.
import 'runtime.dart';

export 'runtime.dart';

/// Canonical interpreter type name used by generated bridge files.
///
/// The bridge generator emits registration methods typed against `D4rt`
/// (e.g. `static void register([D4rt? interpreter])`,
/// `registerBridges(D4rt interpreter, ...)`). In the analyzer-free runtime the
/// concrete interpreter is [D4rtRunner]; this alias lets generated bridges
/// target it without any reference to the analyzer-based `D4rt` front-end in
/// `tom_d4rt_exec`.
typedef D4rt = D4rtRunner;
