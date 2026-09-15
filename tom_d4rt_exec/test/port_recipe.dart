/// The import rewrites that turn a `tom_d4rt` test into its `tom_d4rt_exec`
/// port, in one place, because two things need them and must not disagree.
///
/// A port is defined as a byte-for-byte copy of the reference file with its
/// interpreter imports rewritten. Two pieces of machinery act on that
/// definition from opposite ends:
///
///   * `conformance_drift_test.dart`'s `_normalise` collapses BOTH spellings to
///     a shared token, so a correctly-ported file compares equal to its twin;
///   * `tool/remeasure_pins.dart` rewrites the reference spelling INTO the exec
///     one, so a twin can be run here against the published interpreter.
///
/// Those are the same table read in two directions. Kept apart they drift, and
/// the drift is invisible in the worst way: the guard would keep calling a file
/// a valid port while the tool produced something that does not compile, or the
/// reverse. SCD124 moved the table here rather than copying it.
///
/// THE PATTERN THE TABLE ENCODES, because it predicts the next entry: a `src/`
/// import resolves against `tom_d4rt_ast` under `src/runtime/`, while the public
/// library import resolves against `tom_d4rt_exec` — exec owns the parsing front
/// end and ast owns the runtime. So a reference test importing
/// `package:tom_d4rt/src/<x>.dart` ports to
/// `package:tom_d4rt_ast/src/runtime/<x>.dart`, and only `d4rt.dart` itself
/// ports to `package:tom_d4rt_exec/`.
///
/// ADDING A PAIR IS NOT FREE. Each one is a declaration that the two spellings
/// name the same thing, so a wrong pair silently exempts a real difference —
/// which is why the entries carry the case that needed them rather than just the
/// two strings.
library;

/// One interpreter import, in both spellings, plus the token they collapse to.
class PortImport {
  const PortImport(this.token, this.reference, this.exec);

  /// The placeholder both spellings normalise to. Only its uniqueness matters.
  final String token;

  /// How a `tom_d4rt` test writes the import.
  final String reference;

  /// How its `tom_d4rt_exec` port must write it.
  final String exec;
}

/// Every interpreter import a port legitimately rewrites.
///
/// Order is irrelevant: no reference string is a substring of another, and
/// `package:tom_d4rt_ast/` does not start with `package:tom_d4rt/`, so the
/// replacements cannot interfere.
const List<PortImport> portImports = <PortImport>[
  PortImport(
    '@INTERPRETER@',
    'package:tom_d4rt/d4rt.dart',
    'package:tom_d4rt_exec/d4rt.dart',
  ),
  PortImport(
    '@EXCEPTIONS@',
    'package:tom_d4rt/src/exceptions.dart',
    'package:tom_d4rt_ast/src/runtime/exceptions.dart',
  ),
  // SCC14: `bridge/d4_helpers_test.dart` reaches the D4 helpers directly.
  PortImport(
    '@D4@',
    'package:tom_d4rt/src/generator/d4.dart',
    'package:tom_d4rt_ast/src/runtime/generator/d4.dart',
  ),
  // SCC35: `bridge/bridged_class_test.dart` reaches the InterpretedInstance
  // extension directly. Once its SCC27 divergence cleared, this import was the
  // ONLY thing still separating the two copies — a permanent difference in
  // where each package puts the file, not a difference in what either asserts.
  // Left un-normalised it would have needed a standing `_divergentBaseline`
  // entry, and that entry would then have absorbed any real drift in the file
  // for as long as it stood.
  PortImport(
    '@INTERPRETED_INSTANCE@',
    'package:tom_d4rt/src/utils/extensions/interpreted_instance.dart',
    'package:tom_d4rt_ast/src/runtime/utils/extensions/interpreted_instance.dart',
  ),
  // SCC52: `scc46_native_enum_runtime_type_test.dart` builds a
  // `BridgedEnumDefinition` directly, which neither package re-exports from its
  // public library. Same shape as the two pairs above and the same reason for
  // normalising rather than baselining: the import is the only thing that can
  // differ, so an entry would buy a permanent exemption for a file whose
  // assertions are identical.
  PortImport(
    '@ENUM@',
    'package:tom_d4rt/src/bridge/bridged_enum.dart',
    'package:tom_d4rt_ast/src/runtime/bridge/bridged_enum.dart',
  ),
  // SCD153: `bridge/d4_helpers_test.dart` reaches the core stdlib registrar
  // directly, to register `int` / `String` before exercising the D4 helpers
  // against them. The same `src/` pattern as the four pairs above, and the same
  // reason for normalising rather than baselining — with the import pair in
  // place the two copies are byte-identical, so an entry would have bought a
  // standing exemption for a file that asserts exactly the same things.
  //
  // The file needed one other change to become a port, which is worth recording
  // because it is the shape a reader will meet again: exec's copy was importing
  // `package:tom_d4rt_ast/runtime.dart` plus an explicit `generator/d4.dart`,
  // where the reference imports the public `d4rt.dart` alone. Exec's own public
  // library re-exports `D4`, so reaching past it was never necessary — and a
  // port that imports a DIFFERENT public surface from its reference is not
  // measuring the same thing.
  PortImport(
    '@CORE_STDLIB@',
    'package:tom_d4rt/src/stdlib/core.dart',
    'package:tom_d4rt_ast/src/runtime/stdlib/core.dart',
  ),
  // SCD188: `stdlib/io/scd188_stdin_audit_reason_expiry_test.dart` reaches the
  // `Stdin` bridge definition directly — it asserts which members that bridge
  // declares, which is not a question the public library can be asked. Same
  // `src/` pattern as the pairs above and the same reason for normalising:
  // with the pair in place the two copies are byte-identical, and a
  // `_divergentBaseline` entry would instead grant a standing exemption to a
  // file whose assertions are the same on both sides.
  PortImport(
    '@STDIO_STDLIB@',
    'package:tom_d4rt/src/stdlib/io/stdio.dart',
    'package:tom_d4rt_ast/src/runtime/stdlib/io/stdio.dart',
  ),
];

/// [source] with every interpreter import collapsed to its token, so the two
/// spellings of one import compare equal.
///
/// Normalise, do not ignore. A whole-file hash would flag every ported file
/// forever and the check would be switched off within a week; dropping import
/// lines entirely would hide a file that imports the wrong interpreter.
String normalisePortImports(String source) {
  var result = source;
  for (final import in portImports) {
    result = result
        .replaceAll(import.reference, import.token)
        .replaceAll(import.exec, import.token);
  }
  return result;
}

/// [source] with every REFERENCE interpreter import rewritten to its exec
/// spelling — the port recipe applied in the direction that produces a runnable
/// file.
String rewriteReferenceImports(String source) {
  var result = source;
  for (final import in portImports) {
    result = result.replaceAll(import.reference, import.exec);
  }
  return result;
}
