// SCC6: exec's suite is supposed to mirror tom_d4rt's, so that a behavioural
// divergence between the analyzer-based and the analyzer-free interpreter shows
// up as a test failure. Nothing enforced the mirror, and a missing file cannot
// fail — so the gap was invisible from inside exec's own green suite and grew
// by whatever nobody happened to notice.
//
// This file is that enforcement. It compares three trees:
//
//   * `../tom_d4rt/test`      the reference — the analyzer-based interpreter
//   * `test/`                 this package — the only runner that can execute a
//                             *script* against the analyzer-free interpreter
//   * `../tom_d4rt_ast/test`  the third leg — native, registration-level tests
//                             that cover the analyzer-free line without any
//                             exec port existing
//
// THE THIRD LEG IS WHY A TWO-WAY CHECK WOULD HAVE BEEN USELESS. Twenty-three of
// the forty-five files absent from exec already have a twin under
// `tom_d4rt_ast/test`. A two-way check reports all of them, its first run reads
// as noise, and it gets deleted. A tom_d4rt test is uncovered only when it has a
// twin in NEITHER tree.
//
// WHY THIS IS A RATCHET AND NOT A HARD FAIL. The obvious design — fail listing
// every uncovered file — makes this suite red on the day it lands and red for as
// long as the backlog takes to clear, and a permanently red guard is exactly as
// informative as the script nobody ran. So the KNOWN state is recorded below and
// the test fails on CHANGE:
//
//   * a new uncovered file appears           -> the gap grew, fail
//   * a recorded gap gains a counterpart     -> baseline stale, shrink it, fail
//   * a shared file starts differing         -> real content drift, fail
//   * a pinned known gap loses a copy        -> a fix will go red here, fail
//
// The last of those (F-SCC6-5, SCC15) is not about files at all but about the
// assertions inside them, and it is the one case where being listed in
// `_divergentBaseline` grants no exemption. See the comment above
// `_markerPattern`.
//
// That is what the guard was actually for: nothing detected *additions*. The
// existing backlog is a separate, owned remediation, and porting it is how these
// lists shrink — never by relaxing the comparison.
//
// Those figures are a snapshot for orientation only — the BASELINES below are the
// authority, because they are the thing a failing test forces someone to update.
// A count in a comment is exactly the artifact this guard exists to replace. So
// this header no longer carries one: the earlier snapshot ("40 absent, 27 covered
// elsewhere, 13 uncovered, 30 divergent") was already wrong by six files when
// SCC14 read it, having gone stale within a week of being written, and a stale
// count is worse than none because it reads as current. Run the suite.
//
// WHAT THE BASELINES BELOW ARE NOT. `_uncoveredBaseline` shrinking to nothing
// would not mean the two interpreters agree — it would mean every reference test
// has a counterpart that RUNS. Whether it passes is the suite's job, and whether
// it passes against the interpreter anyone actually ships is DGUC6's: exec
// resolves `tom_d4rt_ast` from pub.dev, so several entries here are pinned not on
// a defect but on a publish. Measured 2026-09-04, the published 0.20.1 differs
// from the 0.25.0 working tree in 32 library files. Confirm that gap before
// reading any port failure as a migration bug.
//
// EQUIVALENCES ARE RECORDED, NEVER INFERRED. A normaliser that matched
// `dfub1_*` to `dgub3_*` would be right; one that matched `dfub1_*` to nothing
// would be wrong; and one that matched `stdlib/x_test.dart` to `stdlib_x_test.dart`
// is right only because ast happens to use that prefix. None of that is
// derivable from the names — each pairing below was confirmed by reading both
// files, and a wrong pairing silently exempts a file forever.

import 'dart:io';

import 'package:test/test.dart';

/// Why a reference file with no same-path exec counterpart is nevertheless
/// covered, and where that coverage lives.
///
/// [where] is `exec:<path>` or `ast:<path>`, relative to that package's `test/`.
/// [refCases] and [twinCases] are `test(` counts; when the twin carries fewer,
/// the coverage is PARTIAL and the deficit is reported by its own case below
/// rather than being rounded up to "covered".
class _Coverage {
  const _Coverage(
    this.where,
    this.why, {
    this.refCases = 0,
    this.twinCases = 0,
  });

  final String where;
  final String why;
  final int refCases;
  final int twinCases;

  bool get isPartial => twinCases < refCases;
}

/// The analyzer-free line is covered natively by a tom_d4rt_ast test of the same
/// name.
///
/// These are registration-level rather than script-level, and they measure the
/// WORKING TREE where an exec port measures the PUBLISHED package (DGUC6) — a
/// real difference in kind, not a formality. But they do execute the mirrored
/// code, so the reference file is not a hole. This is also why porting a file
/// does not retire its ast twin: while the two versions differ, which is the
/// normal state, the twin is the only coverage of the code being edited.
const _astTwin = 'tom_d4rt_ast carries a same-named native twin under test/';

/// ast renames stdlib ports with a `stdlib_` prefix, flattening the directory
/// into the filename. The pairing is by convention, not by path.
const _astStdlibPrefix =
    'ast port of the same stdlib suite, renamed with its `stdlib_` prefix';

/// How many entries in [_coveredElsewhere] may be partial twins (F-SCC6-3).
///
/// A ratchet, not a target: raising it is a deliberate edit that says "this new
/// partial is the right shape, not a shortfall", and the entry's own comment has
/// to say why. Raised from 6 to 7 for `scc28_typed_undefined_member_test.dart`,
/// whose six-case deficit is not coverage a second copy could add: the
/// reference file's uncovered cases are a source scan over two files this
/// package does not own, plus seven script cases that need a type the published
/// tom_d4rt_ast does not yet export.
const _partialTwinBudget = 7;

const Map<String, _Coverage> _coveredElsewhere = {
  // ---- Renamed on the exec side -------------------------------------------
  // exec folded three tom_d4rt filesystem suites into one file, and says so in
  // its own header: "the exec-side mirror of dfub1_filesystem_import_basepath_test
  // and the read-gate half of dfub2_filesystem_import_permission_test". Cases
  // F-DGUB3-1..3 are DFUB1's three with the id prefix and date rewritten; -4 is
  // DFUB2's permission gate; -3 is DFUB3's nested-relative canonicalisation.
  'dfub1_filesystem_import_basepath_test.dart': _Coverage(
    'exec:dgub3_filesystem_import_basepath_test.dart',
    'F-DGUB3-1..3 are these three cases verbatim, id prefix and date aside',
    refCases: 3,
    twinCases: 7,
  ),
  'dfub2_filesystem_import_permission_test.dart': _Coverage(
    'exec:dgub3_filesystem_import_basepath_test.dart',
    'read-gate half only, as F-DGUB3-4; the write-side gate is DFUB11, which '
        'exec has at its own path',
    refCases: 4,
    twinCases: 7,
  ),
  'dfub3_filesystem_module_identity_test.dart': _Coverage(
    'exec:dgub3_filesystem_import_basepath_test.dart',
    'nested-relative canonicalisation, as F-DGUB3-3',
    refCases: 2,
    twinCases: 7,
  ),
  // Same basename, different directory: exec files this under extensions/.
  'dfub4_extension_type_method_dispatch_test.dart': _Coverage(
    'exec:extensions/dfub4_extension_type_method_dispatch_test.dart',
    'same suite, filed under extensions/ in this tree',
    refCases: 9,
    twinCases: 6,
  ),

  // ---- Renamed on the ast side ---------------------------------------------
  'open_issues/b12_native_accumulator_reset_test.dart': _Coverage(
    'ast:runtime/native_accumulator_reset_test.dart',
    'same six cases; ast drops the `b12_` issue prefix and the open_issues/ dir',
    refCases: 6,
    twinCases: 6,
  ),

  // ---- Native ast twins, same basename ------------------------------------
  'bridge/extract_bridged_arg_diagnostics_test.dart': _Coverage(
    'ast:runtime/extract_bridged_arg_diagnostics_test.dart',
    _astTwin,
    refCases: 3,
    twinCases: 3,
  ),
  'bridge/facade_user_registration_test.dart': _Coverage(
    'ast:runtime/facade_user_registration_test.dart',
    _astTwin,
    refCases: 5,
    twinCases: 5,
  ),
  'bridge/unwrap_as_test.dart': _Coverage(
    'ast:runtime/unwrap_as_test.dart',
    _astTwin,
    refCases: 12,
    twinCases: 12,
  ),
  'bridge/usage_log_test.dart': _Coverage(
    'ast:runtime/usage_log_test.dart',
    _astTwin,
    refCases: 9,
    twinCases: 9,
  ),
  'bridge_retention_test.dart': _Coverage(
    'ast:runtime/bridge_retention_test.dart',
    _astTwin,
    refCases: 3,
    twinCases: 3,
  ),
  'bridged_enum_memo_test.dart': _Coverage(
    'ast:bridged_enum_memo_test.dart',
    _astTwin,
    refCases: 3,
    twinCases: 3,
  ),
  'bridged_module_env_cache_test.dart': _Coverage(
    'ast:runtime/bridged_module_env_cache_test.dart',
    _astTwin,
    refCases: 3,
    twinCases: 3,
  ),
  // SCC24's native-name sweep. The ast copy is byte-identical apart from the
  // import prefix — the file was written script-free precisely so it could be,
  // since ast has no parser. Recorded here rather than ported because its
  // subject is a bridge REGISTRY, and exec has no registry of its own: it would
  // build the same `Environment` from the same `tom_d4rt_ast` registrars the
  // twin already sweeps, so a third copy measures nothing new.
  //
  // Porting it was tried and measured before this entry was written (DGUC6):
  // against the published 0.20.1 that exec resolves, 7 of the 9 cases pass and
  // the 2 that fail are exactly the gaps this todo fixed in the 0.30.0 tree.
  // That is the version gap, not a migration defect — which is the whole reason
  // the pairing belongs on the ast side, where the code being edited lives.
  'scc24_native_name_coverage_test.dart': _Coverage(
    'ast:scc24_native_name_coverage_test.dart',
    _astTwin,
    refCases: 9,
    twinCases: 9,
  ),
  'dgub5_filesystem_permission_symlink_test.dart': _Coverage(
    'ast:runtime/dgub5_filesystem_permission_symlink_test.dart',
    _astTwin,
    refCases: 6,
    twinCases: 3,
  ),
  'environment_lazy_bridge_test.dart': _Coverage(
    'ast:environment_lazy_bridge_test.dart',
    _astTwin,
    refCases: 17,
    twinCases: 17,
  ),
  'environment_lookup_test.dart': _Coverage(
    'ast:runtime/environment_lookup_test.dart',
    _astTwin,
    refCases: 8,
    twinCases: 8,
  ),
  'extension_hook_test.dart': _Coverage(
    'ast:runtime/extension_hook_test.dart',
    _astTwin,
    refCases: 7,
    twinCases: 7,
  ),
  'extension_once_per_process_test.dart': _Coverage(
    'ast:runtime/extension_once_per_process_test.dart',
    _astTwin,
    refCases: 3,
    twinCases: 3,
  ),
  'phase1_uri_registration_test.dart': _Coverage(
    'ast:runtime/phase1_uri_registration_test.dart',
    _astTwin,
    refCases: 4,
    twinCases: 4,
  ),
  'pool_security_test.dart': _Coverage(
    'ast:runtime/pool_security_test.dart',
    _astTwin,
    refCases: 4,
    twinCases: 4,
  ),
  'profiler_disabled_test.dart': _Coverage(
    'ast:profiler_disabled_test.dart',
    _astTwin,
    refCases: 2,
    twinCases: 2,
  ),
  'reuse_across_runs_toggle_test.dart': _Coverage(
    'ast:runtime/reuse_across_runs_toggle_test.dart',
    _astTwin,
    refCases: 3,
    twinCases: 3,
  ),
  'scb10_sdk_shaped_errors_test.dart': _Coverage(
    'ast:runtime/scb10_sdk_shaped_errors_test.dart',
    _astTwin,
    refCases: 18,
    twinCases: 4,
  ),
  // The deficit is 6, and it is not a shortfall to close by porting. The
  // reference file's primary guard (F-SCC28-1) is a SOURCE SCAN that reads both
  // mirrored visitors from one process, so a second copy of it here would assert
  // the identical thing about the identical two files — a duplicate failure, not
  // a second measurement. Its six behavioural cases run scripts, which is the
  // half exec could add value to, but they cannot run yet: they exercise
  // `UndefinedMemberD4rtException`, absent from the published tom_d4rt_ast
  // 0.20.1 this package resolves (working tree: 0.35.0), so a verbatim port does
  // not compile. Measured, not predicted — the type is not in the pub-cache copy.
  // The ast twin pins the half the scan cannot see: that the signal survives
  // being re-wrapped. Revisit on the next publish (SCD88).
  'scc28_typed_undefined_member_test.dart': _Coverage(
    'ast:runtime/scc28_typed_undefined_member_test.dart',
    _astTwin,
    refCases: 9,
    twinCases: 3,
  ),
  'stdlib/bridge_arity_test.dart': _Coverage(
    'ast:runtime/bridge_arity_test.dart',
    _astTwin,
    refCases: 13,
    twinCases: 8,
  ),
  'warm_parent_lazy_class_test.dart': _Coverage(
    'ast:runtime/warm_parent_lazy_class_test.dart',
    _astTwin,
    refCases: 1,
    twinCases: 1,
  ),

  // ---- Native ast twins, `stdlib_`-prefixed --------------------------------
  'stdlib/convert/convert_hierarchy_test.dart': _Coverage(
    'ast:runtime/stdlib_convert_hierarchy_test.dart',
    _astStdlibPrefix,
    refCases: 15,
    twinCases: 11,
  ),
  'stdlib/io/io_reexport_visibility_test.dart': _Coverage(
    'ast:runtime/stdlib_io_reexport_visibility_test.dart',
    _astStdlibPrefix,
    refCases: 10,
    twinCases: 6,
  ),
  'stdlib/io/string_sink_collision_test.dart': _Coverage(
    'ast:runtime/stdlib_string_sink_collision_test.dart',
    _astStdlibPrefix,
    refCases: 4,
    twinCases: 4,
  ),
};

/// Reference files with a twin in NEITHER exec nor tom_d4rt_ast: the real gap.
///
/// This is a BASELINE, not an allowlist — every entry is a hole that should be
/// closed by porting, and the case count is the size of the hole. Removing an
/// entry is only correct once the file has a counterpart; the test then confirms
/// it. Adding an entry is only correct for a file that genuinely cannot be
/// ported.
///
/// SCC14 closed nine entries and found the first two files that are NOT portable
/// in principle, which is why the paragraph above no longer claims all of them
/// are. Both are marked `NOT PORTABLE` below with the reason inline; the reason
/// is the entry's whole value, because without it the next reader's only
/// available move is to try the port again.
///
/// SCC14 is also the todo that proves porting is worth doing rather than merely
/// tidy: `bridge/is_operator_on_unwrapped_native_test.dart` failed on arrival
/// with `Undefined variable: Beep`, and the cause was a real defect in this
/// package's loader — `_fetchModuleSource` returned a preloaded `sources` entry
/// before ever checking whether the same URI had a registered bridge, so the
/// documented "register a bridge, pass an empty stub so the import resolves"
/// pattern produced an empty module. tom_d4rt and tom_d4rt_ast both resolve
/// bridged content first. Nine files of assertions had been sitting in the
/// reference tree for months describing behaviour this package did not have.
///
/// SCC7 closed five entries at once (`html_escape`, `stdio_type`,
/// `typed_list_inherited_members`, `member_gap` and the
/// `scb7_bridged_collection_supertype_is` matrix), and the way it did so is the
/// precondition worth knowing before closing any of the rest: it first confirmed
/// that the PUBLISHED `tom_d4rt_ast` was byte-identical to the working tree
/// (`diff -rq ~/.pub-cache/hosted/pub.dev/tom_d4rt_ast-VERSION/lib
/// ../tom_d4rt_ast/lib`). exec resolves that package from pub.dev (DGUC6), so a
/// port made while the trees differ certifies a version nobody is running and
/// fails for reasons that read as migration bugs. Run the diff first.
/// The three SCC11 entries below are the first added under that precondition
/// rather than in spite of it. Each was ported, analysed clean, and then
/// REMOVED again: every member they assert (the seven static validation
/// helpers, the `castFrom` family, the long tail) exists only in the working
/// tree, so all 46 cases fail against the published `tom_d4rt_ast` — not as a
/// migration bug but because the members are genuinely absent from the version
/// exec resolves. Porting them now would have made the exec suite red for a
/// reason no reader could act on.
///
/// Their flip condition is the same one the [_divergentBaseline] header names:
/// the next `tom_d4rt_ast` publish. Port all three and delete these entries in
/// that same commit.
const Map<String, int> _uncoveredBaseline = {
  // NOT PORTABLE — a throughput probe, not a conformance assertion. Its single
  // case measures how long a Conway generation takes; run on two interpreters
  // with different performance characteristics it yields a flaky failure rather
  // than information. There is nothing here for exec to agree or disagree with.
  '_conway_perf_probe_test.dart': 1,
  // NOT PORTABLE — SCC13's standing member-coverage audit. It imports
  // `../../tool/stdlib_member_diff.dart`, a `dart:mirrors` tool that reflects
  // over *tom_d4rt's own* bridge registry, and compares against a baseline
  // generated from it. exec has no such tool and its subject would be a
  // different registry, so a copy here would measure the reference tree while
  // pretending to measure this one. The analyzer-free line's equivalent has to
  // be built against tom_d4rt_ast's registry, not ported.
  'stdlib/member_coverage_baseline_test.dart': 4,
  // NOT PORTABLE — SCC17's release-hygiene guard. Its subject is the repo, not
  // an interpreter: it walks git history and reads the pubspec and CHANGELOG of
  // all three published packages, *including this one*. A copy here would ask
  // the same questions about the same three files and answer them identically,
  // so the second copy could only ever add a duplicate failure. Coverage of
  // exec's own release hygiene is F-SCC17-1/2/3 `tom_d4rt_exec`, which already
  // run in the reference tree.
  'release_hygiene_test.dart': 10,
  // Pinned on the next `tom_d4rt_ast` publish — see the paragraph above. Ported,
  // measured, removed again: the SCC12 fix that makes `await` inside `finally`
  // resume is in the working tree only, and against the published interpreter the
  // run reaches `F-SCC12-4` and never terminates. A hang is the worst of the
  // three outcomes — worse than a failure, because it takes the whole suite with
  // it and reads as a broken machine rather than a pinned expectation. Port it
  // and delete this entry in the same commit as that publish.
  'scc12_await_in_finally_test.dart': 11,
  // Pinned on the next `tom_d4rt_ast` publish, same as the entries above and
  // measured the same way: ported, run, removed again. SCC18 taught typed
  // patterns to evaluate their type, and the fix is in the working tree only —
  // against the published interpreter 11 of the 12 cases fail, each of them
  // reporting the very bug the file was written to pin. Keeping it would make
  // the exec suite red in a way that reads as a migration defect rather than as
  // a version lag. The one case that passes either way is `F-SCC18-9`, which
  // asserts that an UNTYPED pattern still matches anything.
  'scc18_typed_pattern_type_test.dart': 12,
  // Pinned on the next `tom_d4rt_ast` publish, and the measurement is worth
  // recording because the two halves of the file answer differently. SCC19 made
  // `BridgedClass.isSubtypeOf` read the FULL supertype closure instead of
  // stopping one hop past the direct supertypes. Ported and run against the
  // published interpreter: `F-SCC19-2` and `F-SCC19-3` fail — those assert three
  // and four hops on a synthetic chain, which is precisely the fix. The three
  // stdlib cases PASS, but trivially and for the old reason: the published copy
  // still carries the hand-flattened hierarchy blocks, so its deep answers come
  // from restated direct edges. Porting now would therefore pin two genuine
  // failures alongside three assertions that are not yet asserting anything.
  // Port it and delete this entry in the same commit as that publish.
  'scc19_supertype_registry_depth_test.dart': 9,
  // Pinned on the next `tom_d4rt_ast` publish, but read the measurement before
  // porting it there: ONE of its failures does NOT flip on that publish. SCC20
  // folded the catch clause into the shared `_valueHasType`, and against the
  // published interpreter 9 of the 25 cases fail. Eight are the fold itself —
  // `on Exception` / `on Error` missing a script class that implements them
  // (F-SCC20-1, -3), `on List<int>` and `on Box<int>` catching the wrong type
  // argument (-5, -8), `on int Function(int)` and `on (int, String)` rejected as
  // unsupported nodes (-10, -11), and the two exception-hierarchy cases the fold
  // exposed (-22, -25, which need `ExceptionHierarchyCore`).
  //
  // The ninth is F-SCC20-18, and it is a finding about THIS package rather than
  // a version lag: `on void` is a syntax error that tom_d4rt reports as a
  // `SourceCodeD4rtException`, while exec parses the script and runs it, so the
  // clause merely fails to match. exec's front end does not surface analyzer
  // syntax diagnostics — measured directly, `main() { this is not dart ]]] }`
  // reaches the interpreter and fails there as a RUNTIME error instead. Publishing
  // `tom_d4rt_ast` cannot change that, because the gap is in exec's own parse
  // pipeline. Tracked as SCD69; when porting this file, expect F-SCC20-18 to be
  // the one case still needing an answer.
  'scc20_catch_clause_type_test.dart': 25,
  // Pinned on the next `tom_d4rt_ast` publish, and the measurement is the
  // cleanest of this group: ported, run, removed again — 13 of 17 cases PASS,
  // and the 4 that fail are exactly the fix that is working-tree-only. SCC22
  // fixed an empty `catch (e) {}` abandoning the rest of an async function, and
  // F-SCC22-13/-14/-15/-16 each reproduce it against the published interpreter
  // (`['after']` comes back as `null`, or as `1` — the value of the last
  // `await`). F-SCC22-17 passes because a NON-empty catch was never broken.
  //
  // The other 13 tell us something worth writing down. The nine io arity cases
  // (F-SCC22-1..9) pass against the published copy, which confirms SCB9's
  // `errorHandlerArgs` shipped and that this file's loopback harness is not
  // measuring a working-tree-only helper. The three structural cases
  // (F-SCC22-10..12) also pass — but they read the two sibling trees' `lib/src`
  // off disk, so from here they ask the identical question the reference tree's
  // copy already answers, about the identical files. That half is NOT PORTABLE
  // for the same reason `release_hygiene_test.dart` below it is not: a second
  // copy could only ever produce a duplicate failure. Port the file on the next
  // publish for the behavioural cases; the structural group stays a single copy
  // in `tom_d4rt`.
  'scc22_io_error_handler_arity_test.dart': 17,
  // Pinned on the next `tom_d4rt_ast` publish. Unlike the four entries above,
  // this one did not get as far as a behavioural measurement: ported verbatim,
  // it does not COMPILE. `D4rt.onUncaughtError` — the hook SCC23 added so an
  // embedder can observe an error thrown from a callback the platform invoked
  // (a `Stream.listen` body, a `handleError` handler, a `Timer`) — does not
  // exist on this package's `D4rt` at all, and all 16 cases set it.
  //
  // Landing it here is a two-part job, and the second part is the reason this
  // is pinned rather than half-done:
  //   * `executeBundle` forwards to the inner [D4rtRunner], whose
  //     `onUncaughtError` only exists in the working tree. This package
  //     resolves `tom_d4rt_ast` from pub.dev (DGUC6), so the forwarder cannot
  //     be written until that publish.
  //   * The classic `execute()` path does NOT go through the runner — this
  //     package carries its own third copy of `_executeInEnvironment`
  //     (`lib/src/d4rt_base.dart`), so the zone seam has to be mirrored into it
  //     separately. That copy needs nothing unpublished and could be done now.
  //
  // Doing only the half that compiles would ship a hook that fires for
  // `execute()` and silently does not for `executeBundle()` — the "looks
  // covered" failure this file exists to catch, in the public API rather than
  // in the suite. Tracked as SCD74; port this file and delete this entry in the
  // same commit that lands both halves.
  'scc23_uncaught_callback_error_test.dart': 16,
  // Pinned on the next `tom_d4rt_ast` publish, and — like SCC22 above — the
  // measurement was taken before this entry was written, not predicted. Ported
  // verbatim and run against the 0.20.1 this package resolves (working tree:
  // 0.31.0), the split is 4 PASS / 3 FAIL, and the three failures are not
  // merely "the fix is missing": they reproduce, one for one, the drift table
  // SCC25's header records as the pre-fix behaviour.
  //
  //   F-SCC25-3 ServerSocket      type 'Null' is not a subtype of
  //   F-SCC25-4 RawDatagramSocket   type 'InterpretedFunction' in type cast
  //   F-SCC25-5 HttpServer        Runtime Error: listen requires an onData callback.
  //
  // F-SCC25-1/-2 (Stream, Socket) PASS against the published copy, which is the
  // control: those two adapters were already SDK-faithful before the fix, so
  // their passing confirms the loopback harness works here and that the three
  // failures are the version gap rather than a broken port.
  //
  // F-SCC25-6/-7, the two source guards, also pass — but only because they read
  // the two SIBLING trees off disk, so from here they ask the identical
  // question the reference tree's copy already answers about the identical
  // files. That half is NOT PORTABLE, for the same reason SCC22's structural
  // group is not: a second copy could only ever produce a duplicate failure.
  // Port the five behavioural cases on the next publish; the structural pair
  // stays a single copy in `tom_d4rt`. Tracked as SCD79.
  'scc25_listen_adapter_test.dart': 7,
  // Pinned on the next `tom_d4rt_ast` publish, and measured the same way as the
  // entries above: ported verbatim, run, removed again. SCC27 made `execute()`
  // rethrow an `Error`/`Exception` as itself instead of relabelling it, so a
  // host `catch` can name what a script raised. Ported verbatim the file does
  // not COMPILE — `isInterpreterControlFlowSignal` (F-SCC27-8) is the new
  // predicate the rule is built on and exists only in the working tree. With
  // that one case removed the behavioural split is 2 PASS / 6 FAIL, and the
  // split is informative rather than uniform:
  //
  //   F-SCC27-4 PASS  the four SCB10 types already escape — exec carries the
  //                   carve-out in its own `d4rt_base.dart` (scc82's subject,
  //                   landed by 25b4d764c), so this is the control.
  //   F-SCC27-6 PASS  an interpreted `throw` is unwrapped one clause earlier
  //                   and never reached the catch-all in either tree.
  //   F-SCC27-1/2/3/5/9 FAIL  a native callee's error still arrives inside the
  //                   `Native error during …` wrapper the bridged call site
  //                   builds. Measured: `Runtime Error: Native error during
  //                   bridged method call 'boom' on Detonator: …`.
  //   F-SCC27-7 FAIL  for the same reason and worth reading closely — it
  //                   asserts the "Unexpected error:" prefix SURVIVES for a
  //                   value in neither hierarchy, and it fails because the
  //                   value never reaches the boundary that would apply it.
  //
  // Landing it here is a two-part job, like SCC23's entry above. exec's classic
  // `execute()` does not go through [D4rtRunner] — this package carries its own
  // third copy of `_executeInEnvironment` — so both the runner forwarder and
  // that copy have to adopt `throwAsHostFacingError`, and the helper lives in
  // the unpublished `tom_d4rt_ast`. Tracked as SCD84; port this file and delete
  // this entry in the same commit that lands both halves.
  'scc27_host_error_fidelity_test.dart': 9,
  // BLOCKED ON A PUBLISH, not on a design question. SCC29 checks a caller's
  // argument against the declared parameter type at binding time, in
  // `InterpretedFunction._prepareExecutionEnvironment`. The fix is in both
  // mirrored interpreters, but the check itself is what the cases assert, and
  // DGUC6 puts it out of exec's reach: exec resolves `tom_d4rt_ast` 0.20.1 from
  // pub.dev, which binds arguments unchecked. A verbatim port compiles and then
  // fails every throwing case — the file would report the published
  // interpreter's behaviour while reading as a migration bug.
  //
  // Nothing else has to land first: the check is self-contained, uses only
  // `RuntimeType.isSubtypeOf` and `D4rtTypeError`, and needs no new exec-side
  // plumbing. Tracked as SCD89; port this file and delete this entry in the
  // commit that raises exec's `tom_d4rt_ast` floor past 0.36.0.
  'scc29_parameter_type_check_test.dart': 26,
  // BLOCKED ON THE SAME PUBLISH as the entry above. SCC30 deleted the
  // hand-written zero-divisor guards so `~/` and `%` reach the SDK operators
  // and raise `IntegerDivisionByZeroException`, and registered that type as a
  // bridge so `on IntegerDivisionByZeroException` resolves. Both halves are in
  // the mirrored interpreters and neither is in exec's published
  // `tom_d4rt_ast` 0.20.1, which still throws a `RuntimeD4rtException` here —
  // so a verbatim port would fail every throwing case and read as a migration
  // bug rather than a version gap.
  //
  // Nothing else has to land first. Port this file and delete this entry in
  // the commit that raises exec's `tom_d4rt_ast` floor past 0.37.0; tracked
  // together with SCC29 as SCD89.
  'scc30_division_by_zero_test.dart': 21,
  // BLOCKED ON THE SAME PUBLISH as the two entries above. SCC31 raises an
  // undefined name as `UndefinedNameD4rtException` and has both catch-dispatch
  // sites decline to match any clause against it, so a typo escapes to the host
  // instead of being swallowed by a bare `catch (e)`. Every behavioural case
  // there asserts that escape; exec's published `tom_d4rt_ast` 0.20.1 still
  // swallows, so a verbatim port fails all of them and reads as a migration bug
  // rather than a version gap. The type it names is not in the published API
  // either, so the port does not even compile until the floor moves.
  //
  // The last two cases (F-SCC31-17/18) are source scans over both trees rather
  // than script runs, and they belong to `tom_d4rt` only — the port should drop
  // them instead of duplicating a whole-repo assertion in a third suite.
  //
  // Nothing else has to land first. Port this file and delete this entry in
  // the commit that raises exec's `tom_d4rt_ast` floor past 0.38.0; tracked
  // together with SCC29 and SCC30 as SCD89.
  'scc31_undefined_name_uncatchable_test.dart': 18,
  // BLOCKED ON THE SAME PUBLISH. SCC32 makes a bridged value a value key rather
  // than an identity key — `BridgedInstance` delegates `==`/`hashCode` to its
  // native, and hash keys are normalized to the native at storage. Exec's
  // published `tom_d4rt_ast` 0.20.1 still hashes by wrapper identity, so a
  // verbatim port fails the map, set and list cases and reads as a migration bug
  // rather than a version gap.
  //
  // The last two cases (F-SCC32-20/21) are source scans over both trees rather
  // than script runs, and belong to `tom_d4rt` only — the port should drop them,
  // for the same reason as F-SCC31-17/18 above.
  //
  // Nothing else has to land first. Port this file and delete this entry in the
  // commit that raises exec's `tom_d4rt_ast` floor past 0.39.0; tracked together
  // with SCC29, SCC30 and SCC31 as SCD89.
  'scc32_bridged_value_key_test.dart': 21,
  'stdlib/cast_from_family_test.dart': 6,
  'stdlib/convert/json_named_constructors_test.dart': 13,
  'stdlib/core/error_validation_helpers_test.dart': 18,
  'stdlib/static_long_tail_test.dart': 22,
};

/// Files present in BOTH trees whose content differs by more than the one
/// import line the port recipe rewrites.
///
/// A divergent file is as much of a hole as a missing one and worse in one
/// respect: it looks covered. The name is on both sides, both suites are green,
/// and the two trees are being asserted to behave differently.
///
/// Also a baseline, for the same reason as [_uncoveredBaseline] — too many files
/// diverge for a hard failure to be useful, and only a handful have a known
/// cause. The value is that the NEXT one fails. Each entry is a per-file
/// question — is the reference tree right, or is exec? — and answering one means
/// deleting its entry, not annotating it.
///
/// Three causes are known and are NOT defects:
///   * `interpreter_test.dart` is each package's own helper over its own
///     interpreter, so it MUST differ. It is the one permanent entry.
///   * `stdlib/typed_data/byte_data_test.dart` used to differ only in a comment
///     naming which interpreter it exercises. SCC27 added a real divergence on
///     top of that — see the publish-pinned list below.
///   * `stdlib/intentionally_unbridged_test.dart` records what each tree
///     deliberately does not bridge, which is not the same set.
///
/// SCC7 converged three entries and one of them went the UNEXPECTED WAY, which
/// is worth knowing before assuming the reference tree wins: exec's
/// `unmodifiable_map_view` asserted MORE than tom_d4rt's — four values including
/// the `source is Map` supertype edge against tom_d4rt's three — so it was
/// mirrored UPSTREAM into tom_d4rt rather than overwritten. Two others
/// (`unmodifiable_list_view`, `async/stream_consumer`) were exec copies
/// deliberately pinned to pre-publish behaviour and were overwritten from
/// tom_d4rt once the publish made the newer assertions true. Direction is a
/// per-file finding, not a rule.
///
/// Eleven entries currently share ONE flip condition — the next `tom_d4rt_ast`
/// publish — because exec resolves that package from pub.dev, so this suite
/// certifies the PUBLISHED interpreter and not the working tree. Unpin all
/// eleven there and remove their entries in the same commit.
///
///   * `stdlib/io/socket_test.dart` — SCC14 ported the reference copy and
///     measured it: `F-SCC12-1` fails with `Failed host lookup:
///     'InternetAddress('127.0.0.1', IPv4)'`, because the published
///     `ServerSocket.bind` bridge stringifies its `address` argument and the fix
///     that passes an `InternetAddress` through is working-tree only.
///     `F-SCC12-2`, the host-string form that always worked, passes — so the
///     divergence is exactly the two cases SCC12 added and nothing else.
///   * `stdlib/collection/linked_list_test.dart` — the working-tree LinkedList
///     bridge dropped `removeFirst` and gained `addAll` / `addFirst`.
///   * `stdlib/typed_data/typed_list_inherited_members_test.dart` — the
///     working-tree typed-data bridges coerce their element argument instead of
///     casting it, so the twin's 45 new cases need a published interpreter that
///     does the same.
///   * `stdlib/collection/queue_test.dart` and
///     `stdlib/collection/list_queue_test.dart` — the working-tree Queue bridge
///     gained `remove` / `removeWhere` / `retainWhere` and the static
///     `castFrom`; ListQueue reaches two of them through its `-> Queue` edge.
///   * `stdlib/collection/splay_tree_map_test.dart` — gained `firstKeyAfter` /
///     `lastKeyBefore`, and its `I-COLL-78` still asserts that `firstKey()` on an
///     empty map THROWS. That assertion is wrong about Dart but TRUE of the
///     published interpreter, which still carries the invented guard the working
///     tree removed. Pinning it is not endorsing it: the corrected case comes
///     over with the publish.
///   * `operator_improvements_test.dart` — the working-tree interpreter
///     implements `bool`'s `& | ^` and `&= |= ^=`; the published one still
///     throws `Unsupported binary operator`.
///   * `bridge/bridged_class_test.dart`, `stdlib/core/list_test.dart`,
///     `stdlib/typed_data/uint8_list_test.dart` and
///     `stdlib/typed_data/byte_data_test.dart` — the SCC27 realignment. Each
///     had cases asserting `isA<RuntimeD4rtException>()` on the wrapper a
///     bridged call site builds; in the reference tree they now name the type
///     the native callee actually raised (`ArgumentError`, `StateError`,
///     `RangeError`, `IndexError`). Both halves are correct about their own
///     interpreter, which is why this is a divergence and not a failure. They
///     converge with `scc27_host_error_fidelity_test.dart` in
///     [_uncoveredBaseline]: same publish, same commit. `bridged_class_test`
///     and `byte_data_test` were already listed here for other reasons — for
///     those two, removing the SCC27 divergence is necessary but not sufficient
///     to delete the entry.
///   * `eval_method_test.dart` — the SCC29 realignment. Its `I-MISC-29` is named
///     "Should throw error for type mismatches" and, in this tree, asserts that
///     `int add(int a, int b)` called with two Strings returns `'helloworld'`.
///     That is what the published interpreter does — nothing checked the
///     arguments, and `+` happens to be defined on String — so the case is a
///     correct measurement of it. The reference tree's copy now asserts the
///     `TypeError` its own name always demanded. Converges with
///     `scc29_parameter_type_check_test.dart` in [_uncoveredBaseline]: same
///     publish, same commit. The same file also carries the SCC30 realignment:
///     `I-MISC-31` asserted `throwsA(anything)` under a comment naming
///     `IntegerDivisionByZeroException`, which certified nothing on either
///     interpreter; the reference copy now asserts the type. Both realignments
///     clear on the same publish, so the file needs only this one entry.
///   * `scb11_symbol_literal_test.dart` — the SCC32 realignment. Its
///     `F-SCB11-7` deliberately left out the mixed spelling `m[Symbol('alpha')]`
///     (insert by literal, look up by the explicit constructor) and said so in a
///     comment, because the constructor's `BridgedInstance` wrapper hashed by
///     identity and the lookup missed. SCC32 fixed that at the bridged-value
///     level, so the reference copy now asserts the case and the stale comment
///     is gone. The published interpreter still hashes by wrapper identity, so
///     this copy's narrower assertion is a correct measurement of it. Converges
///     with `scc32_bridged_value_key_test.dart` in [_uncoveredBaseline]: same
///     publish, same commit.
const Set<String> _divergentBaseline = {
  '_c21_null_short_test.dart',
  '_plan_e2_static_in_closure_test.dart',
  'block_frame_collapse_test.dart',
  'bound_method_tearoff_cache_test.dart',
  'bridge/bridged_class_test.dart',
  'bridge/bridged_enum_test.dart',
  'bridge/extension_on_stdlib_type_test.dart',
  'bridge/same_name_bridge_sourceuri_test.dart',
  'cluster_a_top_level_build_resolution_test.dart',
  'const_expressions_test.dart',
  'dfub10_circular_module_load_test.dart',
  'dfub11_filesystem_operation_permission_test.dart',
  'dfub13_import_export_diagnostics_test.dart',
  'dfub5_function_record_runtime_type_test.dart',
  'dfub6_applied_generic_runtime_types_test.dart',
  'dfub7_bridged_typeparameter_subtype_test.dart',
  'dfub8_super_parameter_default_forwarding_test.dart',
  'dfub9_extension_type_operator_dispatch_test.dart',
  'dgub4_filesystem_import_scope_boundary_test.dart',
  'eval_method_test.dart',
  'instance_field_shadows_global_test.dart',
  'interpreter_test.dart',
  'late_test.dart',
  'object_universal_members_test.dart',
  'open_issues/b11_warmup_test.dart',
  'open_issues/b1_redirecting_factory_test.dart',
  'open_issues/b5_bridged_exception_catch_test.dart',
  'open_issues/b9_static_field_sibling_write_test.dart',
  'operator_improvements_test.dart',
  'scb11_symbol_literal_test.dart',
  'stdlib/collection/linked_list_test.dart',
  'stdlib/collection/list_queue_test.dart',
  'stdlib/collection/queue_test.dart',
  'stdlib/collection/splay_tree_map_test.dart',
  'stdlib/core/list_test.dart',
  'stdlib/intentionally_unbridged_test.dart',
  'stdlib/io/socket_test.dart',
  'stdlib/typed_data/byte_data_test.dart',
  'stdlib/typed_data/uint8_list_test.dart',
  'stdlib/typed_data/typed_list_inherited_members_test.dart',
  'warm_parent_package_pool_test.dart',
};

/// The direct interpreter-package imports the port recipe legitimately rewrites,
/// mapped to a shared token so a correctly-ported file compares equal.
///
/// The `interpreter_test.dart` HELPER import needs no entry: each package has its
/// own helper at the same relative depth exposing the same `execute()`, and
/// because this check only ever compares files at the SAME relative path, the
/// depth prefix is identical on both sides by construction.
///
/// Normalise, do not ignore. A whole-file hash would flag every ported file
/// forever and the check would be switched off within a week; dropping import
/// lines entirely would hide a file that imports the wrong interpreter.
///
/// FORMATTING IS DELIBERATELY *NOT* NORMALISED, and the reason is the recipe.
/// A port is defined as a byte-for-byte copy with the import rewritten, so a
/// byte comparison is precisely the check that enforces it — running
/// `dart format` over a port makes it no longer verbatim, and being told so is
/// correct rather than a false positive.
///
/// The cost of that choice is that the line counts here are not a measure of
/// semantic distance. Measured 2026-09-03: `dart format`-ing both sides before
/// comparing takes `interpreter_test.dart` from 653 differing lines to 46, and
/// moves `instance_field_shadows_global_test.dart` the other way, 35 to 150. All
/// but one entry below still differ after formatting, so the divergence is real —
/// but do not rank the triage by the raw numbers, because they measure wrapping
/// as much as they measure assertions.
/// The pattern behind the pairs below is worth stating because it predicts the
/// next one: a `src/` import resolves against `tom_d4rt_ast` under
/// `src/runtime/`, while the public library import resolves against
/// `tom_d4rt_exec` — because exec owns the parsing front end and ast owns the
/// runtime. A reference test importing `package:tom_d4rt/src/<x>.dart` therefore
/// ports to `package:tom_d4rt_ast/src/runtime/<x>.dart`, and a new such import
/// needs a pair here rather than an exemption anywhere else.
/// A `KNOWN-GAP(<todo-id>):` or `WONT-FIX:` marker, as written in the comment
/// directly above a test case that PINS broken behaviour.
///
/// SCC15: the corpus used to carry two opposite conventions for recording a
/// known gap, and they need opposite handling when a fix lands.
///
///   * assert-the-correct-behaviour — the case FAILS until the gap closes, then
///     goes green by itself. No cleanup, but the suite carries a permanent red,
///     and a suite with a sanctioned red cannot gate regressions: the real one
///     is indistinguishable from the expected one without a hand diff.
///   * pin-the-broken-value — the case PASSES until the gap closes, then goes
///     RED and must be deleted by hand. The suite stays green, at the price of a
///     deletion someone has to remember.
///
/// The second is the adopted convention, and this check is what makes the price
/// payable: a pin names who deletes it, and every copy of it is accounted for.
/// The defect that prompted the rule is concrete — scb7 shipped a pin and its
/// FIX step named only the tom_d4rt copy, so landing that fix would have turned
/// the exec twin red on a tree nobody was looking at.
final RegExp _markerPattern = RegExp(
  r'^//\s*(KNOWN-GAP\([^)]*\)|WONT-FIX)\s*:',
);

/// Every marker in [source], as `KNOWN-GAP(<id>)` or `WONT-FIX`.
///
/// Line-based, and a `///` doc comment is deliberately not a marker: the
/// convention is documented by writing the syntax out, and a doc comment that
/// counted as a use would make every file explaining the rule look like a file
/// applying it.
List<String> _markers(String source) => [
  for (final line in source.split('\n'))
    if (_markerPattern.firstMatch(line.trimLeft()) case final m?) m.group(1)!,
];

String _normalise(String source) => source
    .replaceAll('package:tom_d4rt/d4rt.dart', '@INTERPRETER@')
    .replaceAll('package:tom_d4rt_exec/d4rt.dart', '@INTERPRETER@')
    .replaceAll('package:tom_d4rt/src/exceptions.dart', '@EXCEPTIONS@')
    .replaceAll(
      'package:tom_d4rt_ast/src/runtime/exceptions.dart',
      '@EXCEPTIONS@',
    )
    // SCC14: `bridge/d4_helpers_test.dart` reaches the D4 helpers directly.
    .replaceAll('package:tom_d4rt/src/generator/d4.dart', '@D4@')
    .replaceAll('package:tom_d4rt_ast/src/runtime/generator/d4.dart', '@D4@');

Map<String, File> _testFiles(Directory root) {
  final prefix = '${root.path}${Platform.pathSeparator}';
  final result = <String, File>{};
  for (final entity in root.listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('_test.dart')) continue;
    result[entity.path
            .substring(prefix.length)
            .replaceAll(Platform.pathSeparator, '/')] =
        entity;
  }
  return result;
}

void main() {
  // Relative paths out of the package are justified exactly here: the guard's
  // subject IS the repo layout, not the package. A published consumer has no
  // sibling checkout, so the whole file skips rather than failing — item (2).
  final execTests = Directory('test');
  final refTests = Directory('../tom_d4rt/test');
  final astTests = Directory('../tom_d4rt_ast/test');

  final haveSiblings = refTests.existsSync() && astTests.existsSync();
  final skipReason = haveSiblings
      ? null
      : 'needs the sibling checkouts ../tom_d4rt and ../tom_d4rt_ast; this '
            'guard is about the repo layout and cannot run from a published '
            'tom_d4rt_exec on its own';

  group('SCC6: the conformance corpora agree', () {
    late Map<String, File> ref;
    late Map<String, File> exec;
    late Map<String, _Coverage> unmatched;

    setUp(() {
      ref = _testFiles(refTests);
      exec = _testFiles(execTests);
      // Coverage is resolved ONLY from the recorded map, never by matching
      // basenames against the ast tree at runtime. That is deliberate: an
      // inferred match is unreviewed, and one wrong inference exempts a file
      // permanently and silently. A new file with an ast twin is therefore
      // *supposed* to fail here until someone records the pairing.
      unmatched = {
        for (final path in ref.keys.where((k) => !exec.containsKey(k)))
          path:
              _coveredElsewhere[path] ??
              const _Coverage('', 'no twin in either tree'),
      };
    });

    test(
      'F-SCC6-1: every recorded coverage claim still resolves to a real file '
      '[2026-09-03] (PASS)',
      () {
        final execPaths = _testFiles(execTests).keys.toSet();
        final astPaths = _testFiles(astTests).keys.toSet();
        final broken = <String>[];
        _coveredElsewhere.forEach((refPath, coverage) {
          final where = coverage.where;
          final target = where.substring(where.indexOf(':') + 1);
          final exists = where.startsWith('exec:')
              ? execPaths.contains(target)
              : astPaths.contains(target);
          if (!exists) broken.add('$refPath -> $where');
        });
        expect(
          broken,
          isEmpty,
          reason:
              'A coverage claim points at a file that no longer exists. '
              'Either the twin was renamed — update the entry — or it was '
              'deleted, in which case the reference file is now a real gap and '
              'belongs in _uncoveredBaseline.\n${broken.join('\n')}',
        );
      },
    );

    test('F-SCC6-2: no reference test has appeared without a counterpart '
        '[2026-09-03] (PASS)', () {
      final uncovered = unmatched.entries
          .where((e) => e.value.where.isEmpty)
          .map((e) => e.key)
          .toSet();
      final appeared = uncovered.difference(_uncoveredBaseline.keys.toSet());
      final closed = _uncoveredBaseline.keys.toSet().difference(uncovered);

      expect(
        appeared,
        isEmpty,
        reason:
            'A tom_d4rt test has no recorded counterpart. That is the '
            'drift this guard exists to catch. One of three things is true, '
            'and all three are a deliberate edit here:\n'
            '  * it is a genuine gap -> port it, copying verbatim and '
            'rewriting only a direct interpreter-package import;\n'
            '  * it already has a twin under a different name or path -> '
            'record the pairing in _coveredElsewhere, having READ both files;\n'
            '  * it cannot be ported -> add it to _uncoveredBaseline with the '
            'reason.\n${appeared.join('\n')}',
      );
      expect(
        closed,
        isEmpty,
        reason:
            'These files now have a counterpart but are still listed in '
            '_uncoveredBaseline. Remove them: a stale baseline is how the '
            'ratchet loosens.\n${closed.join('\n')}',
      );
    });

    test('F-SCC6-3: partial twins are reported with their case deficit '
        '[2026-09-03] (PASS)', () {
      // Deliberately informational. A partial twin IS coverage of the subject
      // — enough that reporting it as a missing file would be wrong — but the
      // case counts do not match, so some assertions run against only one
      // interpreter. Recording the deficit keeps that visible instead of
      // rounding it up to "covered", which is what a presence-only check does.
      final partials = _coveredElsewhere.entries
          .where((e) => e.value.isPartial)
          .toList();
      var deficit = 0;
      for (final e in partials) {
        deficit += e.value.refCases - e.value.twinCases;
      }
      printOnFailure(
        partials
            .map(
              (e) =>
                  '${e.key}: ${e.value.refCases} cases vs '
                  '${e.value.twinCases} in ${e.value.where}',
            )
            .join('\n'),
      );
      expect(
        partials.length,
        lessThanOrEqualTo(_partialTwinBudget),
        reason:
            'More files are now only PARTIALLY covered than the budget of '
            '$_partialTwinBudget allows (currently ${partials.length} files, '
            '$deficit cases short). A partial twin passes the presence check '
            'while leaving assertions unrun on the analyzer-free line.',
      );
    });

    test('F-SCC6-4: no shared file has started diverging in content '
        '[2026-09-03] (PASS)', () {
      final divergent = <String>{};
      for (final path in ref.keys.where(exec.containsKey)) {
        if (_normalise(ref[path]!.readAsStringSync()) !=
            _normalise(exec[path]!.readAsStringSync())) {
          divergent.add(path);
        }
      }
      final appeared = divergent.difference(_divergentBaseline);
      final converged = _divergentBaseline.difference(divergent);

      expect(
        appeared,
        isEmpty,
        reason:
            'A file present in both trees has started asserting different '
            'things. This is the case a presence check cannot see: the name is '
            'on both sides and both suites are green. Either mirror the change '
            'into the other tree, or — if the divergence is deliberate — add '
            'it to _divergentBaseline with the reason in the comment '
            'above.\n${appeared.join('\n')}',
      );
      expect(
        converged,
        isEmpty,
        reason:
            'These files no longer diverge. Remove them from '
            '_divergentBaseline so the next real divergence is not absorbed '
            'by a stale entry.\n${converged.join('\n')}',
      );
    });

    test('F-SCC6-5: every pinned known gap names an owner and exists in both '
        'copies [2026-09-04] (PASS)', () {
      // Part one — shape. A `KNOWN-GAP()` with nothing between the brackets
      // is the marker equivalent of a bare `// TODO`: it records that someone
      // noticed, and nothing else. `WONT-FIX` carries its own decision and
      // needs no id.
      final unowned = <String>[];
      for (final tree in [ref, exec]) {
        tree.forEach((path, file) {
          for (final marker in _markers(file.readAsStringSync())) {
            if (marker.startsWith('KNOWN-GAP') &&
                marker.substring(10, marker.length - 1).trim().isEmpty) {
              unowned.add('$path: $marker');
            }
          }
        });
      }
      expect(
        unowned,
        isEmpty,
        reason:
            'A pinned gap does not name the todo that will delete it. '
            'Name one, or — if nothing will ever fix it — say so with '
            'WONT-FIX and the reason.\n${unowned.join('\n')}',
      );

      // Part two — parity, and the half that catches the scb7 defect. Note it
      // takes NO exemption from _divergentBaseline: those files are allowed to
      // differ in their assertions, but a pin is a maintenance obligation
      // rather than an assertion, and a divergent file is exactly where a
      // one-sided deletion hides. For the non-divergent files F-SCC6-4 already
      // implies this; for the divergent ones only this check does.
      final mismatched = <String>[];
      for (final path in ref.keys.where(exec.containsKey)) {
        final refMarkers = (_markers(
          ref[path]!.readAsStringSync(),
        )..sort()).join(', ');
        final execMarkers = (_markers(
          exec[path]!.readAsStringSync(),
        )..sort()).join(', ');
        if (refMarkers != execMarkers) {
          mismatched.add(
            '$path: tom_d4rt [$refMarkers] vs exec [$execMarkers]',
          );
        }
      }
      expect(
        mismatched,
        isEmpty,
        reason:
            'A pinned gap exists in one tree and not the other. A pin has '
            'to be deleted by hand when the gap closes, so a missing copy '
            'means the fix lands green here and red there — or the reverse. '
            'Mirror it.\n${mismatched.join('\n')}',
      );
    });
  }, skip: skipReason);
}
