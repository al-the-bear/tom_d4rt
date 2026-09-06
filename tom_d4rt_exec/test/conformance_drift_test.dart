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
// a defect but on a publish. Measured 2026-09-05, immediately after SCC35
// published 0.40.0, `diff -rq` reports the published `lib` as BYTE-IDENTICAL to
// the working tree — so for once nothing here is pinned on a version gap, and a
// port failure right now IS a real finding. That state is temporary and decays
// with the next `lib/` commit: re-run the diff before reading any port failure
// as a migration bug, rather than trusting this paragraph.
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
///
/// Raised from 7 to 8 for `scc33_unhandled_node_test.dart`. Its two-case deficit
/// is the SHAPE of the twin rather than a shortfall: the reference file asserts
/// the backstop by calling `visitNode` with an analyzer node, which is not a
/// port target but a different call — the analyzer-free visitor takes an
/// `SAstNode` — so the ast twin asserts it natively and does so with two cases
/// where the reference spends one. The deficit is on the other side: four
/// script-level cases collapse into one unit case, because ast has no parser.
/// Only exec can run those, and only after a publish; see the entry's comment.
const _partialTwinBudget = 8;

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
  // The deficit is 6, and HALF of it is not a shortfall to close by porting.
  // The reference file's primary guard (F-SCC28-1) is a SOURCE SCAN that reads
  // both mirrored visitors from one process, so a second copy of it here would
  // assert the identical thing about the identical two files — a duplicate
  // failure, not a second measurement. That half stays where it is.
  //
  // The other half — six behavioural cases that run scripts — was blocked on a
  // publish, and THAT BLOCK IS GONE. It was recorded here as `UndefinedMember`
  // `D4rtException` being absent from the resolved tom_d4rt_ast, measured at
  // 0.20.1. Re-measured 2026-09-05: this package resolves 0.40.0, whose
  // `lib/src/runtime/exceptions.dart:298` declares the class, and that copy is
  // byte-identical to the working tree. So a verbatim port now compiles and the
  // six cases are portable. SCD88 already owns that port and its trigger — "the
  // next ast publish" — has now fired. Until it lands the ast twin pins the half
  // the scan cannot see, that the signal survives being re-wrapped, and this
  // entry records a real, closable gap rather than a structural one.
  'scc28_typed_undefined_member_test.dart': _Coverage(
    'ast:runtime/scc28_typed_undefined_member_test.dart',
    _astTwin,
    refCases: 9,
    twinCases: 3,
  ),
  // Both files read before pairing. The twin is FULL — six cases against six —
  // but it is not a port, and the reason is the one SCC24 first recorded: the
  // reference cases drive scripts through `D4rt.execute`, and `tom_d4rt_ast`
  // has no parser, so the twin asks `Environment.toBridgedInstance` directly
  // instead (`F-SCC49-AST-1..6` against `F-SCC49-1..6`). That is the stronger
  // probe, not a weaker one: a script only sees "threw" or "did not throw",
  // while the resolver can be asked WHICH bridge answered — which is what the
  // suffix-overlap pair is about. An exec port would run the reference form,
  // but it is publish-blocked on top of that: the `EventSink -> Sink` edge and
  // the structural pass ship in tom_d4rt_ast 0.43.0 and exec resolves 0.42.0.
  // Note the top-level `ast:` path — this twin sits at `tom_d4rt_ast/test/`,
  // not under `test/runtime/` where most of the entries above live.
  'scc49_structural_native_dispatch_test.dart': _Coverage(
    'ast:scc49_structural_native_dispatch_test.dart',
    _astTwin,
    refCases: 6,
    twinCases: 6,
  ),
  // Both files read before pairing, and this one is a genuine full twin: the
  // same eight case ids, `F-SCC51-1..8`, asserting the same thing on each side.
  // It can be native because the subject is a native-side harness — it walks
  // every shadowed collection adapter and compares it against the `Iterable`
  // one it shadows — so it never needed a parser and did not have to be
  // reshaped to lose it. An exec port is publish-blocked: SCC51 ships in
  // tom_d4rt_ast 0.44.0 and exec resolves 0.42.0, which is the same gap the six
  // `stdlib/collection` and `stdlib/async` skips in [_divergentBaseline] pin.
  'scc51_shadowed_adapter_test.dart': _Coverage(
    'ast:scc51_shadowed_adapter_test.dart',
    _astTwin,
    refCases: 8,
    twinCases: 8,
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
///
/// **THAT FLIP CONDITION HAS FIRED, AND MOST ENTRIES BELOW HAVE NOT BEEN
/// RE-MEASURED SINCE.** Several comments in this map state, as present tense,
/// that "exec resolves `tom_d4rt_ast` 0.20.1". It does not: measured 2026-09-05,
/// this package resolves 0.40.0, and that copy is byte-identical to the working
/// tree. Every split those comments record — SCC25's 4 PASS / 3 FAIL, SCC27's
/// 2 PASS / 6 FAIL, and the "does not compile" claims for SCC28/29/30/31 — was
/// taken against 0.20.1 and describes an interpreter nobody now runs. Two have
/// already been re-measured and moved out: `scc28`'s blocker is gone (SCD88 owns
/// the port) and `scc33`'s cases now pass 5/5, so its entry became a
/// `_divergentBaseline` line instead.
///
/// Read every remaining "0.20.1" and every "blocked on a publish" below as a
/// question to re-ask, not as a fact. The [_divergentBaseline] header already
/// records the lesson from the last time this happened: the flip made the
/// entries REVIEWABLE, not automatically stale — five converged and the rest did
/// not, each for its own reason. Re-measuring the set is SCD107.
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
  // (`scc29_parameter_type_check_test.dart`, `scc30_division_by_zero_test.dart`,
  // `scc31_undefined_name_uncatchable_test.dart` and
  // `scc32_bridged_value_key_test.dart` were all here, each blocked on a
  // different `tom_d4rt_ast` publish — floors 0.36.0, 0.37.0, 0.38.0 and
  // 0.39.0. All four have landed. SCC32 came over with SCC35's 0.40.0 publish;
  // the other three did NOT, and sat here unported while the floor moved past
  // every one of their stated conditions. SCC43 found them and ported all
  // three — 65 cases green against published 0.40.0, no interpreter work
  // needed, exactly as their entries had predicted years of review-time
  // earlier.
  //
  // THAT LAG IS THE FINDING, and it is why [_pinnedInterpreterFloors] below
  // now exists. Every one of those entries named its flip condition in prose,
  // and prose is checked only by whoever happens to reread it. Nothing was
  // wrong with the analysis; the failure was that a due obligation stayed
  // invisible. F-SCC43-1 makes the same declaration machine-checked: an entry
  // records the floor it waits on, and the guard goes red the moment exec's
  // pubspec passes it. Add the floor there whenever you add a publish-blocked
  // entry to either baseline, and prose alone will not be load-bearing again.
  //
  // SCC31 is ported MINUS its F-SCC31-17/18 source-scan group, as its own
  // entry instructed; the omission is now a `_divergentBaseline` entry.
  'stdlib/cast_from_family_test.dart': 6,
  'stdlib/convert/json_named_constructors_test.dart': 13,
  'stdlib/core/error_validation_helpers_test.dart': 18,
  'stdlib/static_long_tail_test.dart': 22,
};

/// Why a [_divergentBaseline] entry is allowed to stand.
///
/// SCC44 replaced a flat `Set<String>` with this, and the replacement is the
/// finding rather than the tidy-up. A path in a set says a file diverges and
/// nothing about whether that is a verdict or an oversight — which made the set
/// indistinguishable from an unexamined list, and 32 of its 38 entries turned
/// out to be exactly that. They converged the moment someone copied the
/// reference file over the exec one and ran it.
///
/// The todo's four categories collapse to two once the work is actually done.
/// (c) COSMETIC — a divergence that is only prose — is not a verdict but a
/// deferred convergence, so it has no member here: a comment that reads
/// differently in each tree can be written symmetrically instead, naming both
/// trees without asserting which one you are standing in, at which point the
/// copies are byte-identical. And (d) UNCLASSIFIED is the state this enum
/// exists to make unrepresentable.
enum _Divergence {
  /// CANNOT converge. The two copies exercise different API surfaces, or one
  /// depends on a fact true only inside its own package. Overwriting either
  /// side deletes coverage with nowhere else to live.
  ///
  /// Where the exec-only coverage is separable, prefer splitting it into its
  /// own file over claiming this category — `_c21_null_short_bundle_test.dart`
  /// and its two siblings are the pattern. The shared-name file then stays a
  /// verbatim port and the guard keeps covering it.
  necessary,

  /// COULD converge textually but MUST NOT. Either un-skipping would assert
  /// something the PUBLISHED interpreter fails (DGUC6 — see
  /// [_pinnedInterpreterFloors]), or the divergence is a deliberate subtraction
  /// whose reason is recorded above the entry.
  deliberate,
}

/// Files present in BOTH trees whose content differs by more than the one
/// import line the port recipe rewrites, each with the reason it is allowed to.
///
/// A divergent file is as much of a hole as a missing one and worse in one
/// respect: it looks covered. The name is on both sides, both suites are green,
/// and the two trees are being asserted to behave differently.
///
/// The value of the baseline is that the NEXT divergence fails. That only holds
/// while the set is small and every member is justified, because AN ENTRY
/// ABSORBS EVERY FUTURE DRIFT IN ITS FILE FOR AS LONG AS IT STANDS — which is
/// why converging a merely-cosmetic divergence is worth doing rather than
/// annotating it, and why F-SCC44-1 insists each survivor carry a written
/// reason.
///
/// DIRECTION IS A PER-FILE FINDING, NOT A RULE, and assuming the reference tree
/// wins has been wrong more than once. SCC7's `unmodifiable_map_view` asserted
/// MORE here than in `tom_d4rt` — four values including the `source is Map`
/// supertype edge against three — and was mirrored UPSTREAM rather than
/// overwritten. SCC44 found the mirror image: `dfub5`, `dfub6` and `dfub13`
/// carried exec-side explanations the reference lacked (the `SAstNode` tree has
/// no parent pointers, so the applied return type is captured at declaration
/// time; `tom_ast_generator` used to flatten `RecordTypeAnnotationField`;
/// `tom_d4rt_exec` owns a third copy of the module loader). Those paragraphs
/// were folded into the reference headers BEFORE the ports were taken, so
/// convergence added knowledge to both trees instead of deleting it from one.
///
/// A PUBLISH MAKES ENTRIES REVIEWABLE, NOT AUTOMATICALLY STALE — and the
/// converse trap is the one SCC44 walked into. Seven entries were pinned on
/// `tom_d4rt_ast` reaching 0.40.0; SCC35 published exactly that, and when all
/// seven were finally re-measured on 2026-09-05, six already passed. They had
/// been recorded from prose rather than from a run, and the pins outlived their
/// cause by a full release. [_pinnedInterpreterFloors] and F-SCC43-1 exist to
/// make the flip condition machine-checkable; re-measuring is still manual, so
/// re-measure the whole register when the floor moves, not the entry you
/// happened to be reading.
const Map<String, _Divergence> _divergentBaseline = {
  // The reference copy's four `(legacy)` cases reach into the analyzer `D4rt`'s
  // own environment chain — `enclosing`, the static warm-parent cache keyed on
  // the allowed-set signature — and measured here they fail, because the exec
  // `D4rt` is a WRAPPER that forwards `providePackage` / `allowedPackages` to
  // an inner `D4rtRunner` and holds no chain of its own. What this copy pins is
  // therefore a different contract: that the forwards expose the runner's
  // behaviour faithfully through the wrapper. Neither copy can be the other.
  'warm_parent_package_pool_test.dart': _Divergence.necessary,
  // Each copy reads its OWN package's `doc/d4rt_limitations.md` and asserts the
  // set of names that package deliberately does not bridge. The two sets are
  // not the same set, and the reference copy does not even run here — exec has
  // no such doc, so F-SCB30-3/-5 die on a missing file. Convergence would
  // require one shared document, which would then be wrong about both trees.
  'stdlib/intentionally_unbridged_test.dart': _Divergence.necessary,
  // The only entry whose divergence is a set of SKIPS rather than a content
  // difference, and the only publish-pin left standing after SCC44 re-measured
  // all seven. SCC40 made the await-resumption slot per-await-site, so
  // `(await a) + (await b)` stops yielding `'AA'`; the reference tree runs
  // F-SCB14-9/-10/-11/-12 green. This copy skips exactly those four, because
  // exec resolves `tom_d4rt_ast` from pub.dev at 0.40.0 (DGUC6) and the fix
  // landed after it — re-measured 2026-09-05 against the published copy and
  // still failing, with the observed values recorded in
  // [_pinnedInterpreterFloors]. Un-skip the four and delete this entry in the
  // commit that raises exec's floor past 0.40.0; tracked as SCD120.
  'scb14_await_receiver_position_test.dart': _Divergence.deliberate,
  // Ported by SCC43 minus the twin's F-SCC31-17/18, which scan every mirrored
  // tree's sources for the guard rather than running a script. A second copy
  // would read the same files and reach the same verdict, so a dropped guard
  // would turn two suites red for one cause and the extra red would say
  // nothing the first did not. Permanent, not a shortfall.
  'scc31_undefined_name_uncatchable_test.dart': _Divergence.deliberate,
  // The same deliberate subtraction, for the same reason: F-SCC32-20/21 are a
  // source scan over both mirrored trees rather than script runs.
  'scc32_bridged_value_key_test.dart': _Divergence.deliberate,
  // Also a subtraction, but for a reason no publish can clear. The reference
  // file's F-SCC33-5 hands an analyzer `ArgumentList` to `visitNode`; this
  // line's visitor takes an `SAstNode`, so no import rewrite turns one call
  // into the other. It is not lost — `tom_d4rt_ast` pins the same contract
  // natively (F-SCC33-AST-1/2) against its own node type, which is the only
  // place it can be pinned. The five behavioural cases are verbatim.
  'scc33_unhandled_node_test.dart': _Divergence.deliberate,
  // The five `stdlib/collection` entries below are ONE finding recorded five
  // times, and they were measured rather than predicted: each file was re-ported
  // verbatim from the reference tree first, run, and only the cases that
  // actually failed were skipped. SCC51 stopped the collection bridges shadowing
  // `Iterable`'s delegating `first`/`last`/`single`, so the SDK's own
  // `StateError` now reaches the script where a hand-written
  // `RuntimeD4rtException` used to; the reference tree asserts `StateError` and
  // runs green. exec resolves `tom_d4rt_ast` from pub.dev at 0.42.0 (DGUC6) and
  // SCC51 ships in 0.44.0, so here the pre-fix family is still thrown.
  //
  // SKIPPED, NOT RE-PINNED TO THE OLD FAMILY, against the SCC15 default. A pin
  // would keep the suite green and then need a hand deletion nobody is watching
  // for — and F-SCC6-5 requires a `KNOWN-GAP` marker in BOTH trees, which the
  // reference copy cannot carry because it has no gap to mark. The
  // `scb14_await_receiver_position_test.dart` entry above is the precedent.
  //
  // Un-skip the six cases across these five files and delete all five entries in
  // the commit that raises exec's floor past 0.43.0; the skip constants name
  // themselves `_scc51Skip` in each file so the deletion is greppable.
  'stdlib/collection/list_queue_test.dart': _Divergence.deliberate,
  // Second of the five. `F-SC2-19` skipped: `SplayTreeSet().first` on an empty
  // set. Same SCC51 cause and the same flip condition as the entry above — the
  // commit that raises exec's floor past 0.43.0 un-skips it and deletes this.
  'stdlib/collection/splay_tree_set_test.dart': _Divergence.deliberate,
  // Third of the five. `F-SC2-9` skipped: it asserts `first` on an empty
  // `LinkedHashSet` AND `single` on a two-element one, so it is the case that
  // covers both shadowed getters. Flip at floor past 0.43.0 with the rest.
  'stdlib/collection/linked_hash_set_test.dart': _Divergence.deliberate,
  // Fourth of the five. `I-COLL-44` skipped: `LinkedList.first` when empty.
  // `LinkedList` is not an `Iterable` subclass in the bridge graph the way the
  // others are, so it is worth keeping distinct rather than folded into one
  // entry — its shadowing came from SCC8's own hand-written surface. Flip at
  // floor past 0.43.0.
  'stdlib/collection/linked_list_test.dart': _Divergence.deliberate,
  // Fifth of the five and the only one with two skipped cases: `I-COLL-71`
  // (`first` on an empty `Queue`) and `I-COLL-62` (`last` on the same). Both
  // observe the pre-SCC51 `RuntimeD4rtException` against the published 0.42.0
  // where the reference tree observes `StateError`. Flip at floor past 0.43.0.
  'stdlib/collection/queue_test.dart': _Divergence.deliberate,
  // The same shape one release earlier. SCC49 registered the `EventSink -> Sink`
  // supertype edge, which ships in tom_d4rt_ast 0.43.0; exec resolves 0.42.0, so
  // F-SCC49-7 returns `false` and F-SCC49-8 `[false, true, true]` — the two
  // links below `Sink` are already registered and only the last is missing,
  // which is exactly the version gap and not a migration defect. Its sibling
  // F-SCC49-9 is left RUNNING deliberately: it asserts certain values are NOT
  // sinks, which an interpreter missing the edge satisfies vacuously, so it
  // covers nothing here until the two skips lift but costs nothing to keep.
  // Un-skip both and delete this entry in the commit that raises exec's floor
  // past 0.42.0.
  'stdlib/async/stream_consumer_test.dart': _Divergence.deliberate,
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
/// comparing took `interpreter_test.dart` from 653 differing lines to 46, and
/// moved `instance_field_shadows_global_test.dart` the other way, 35 to 150. All
/// but one entry below still differed after formatting, so the divergence is
/// real — but do not rank the triage by the raw numbers, because they measure
/// wrapping as much as they measure assertions.
///
/// `interpreter_test.dart` is no longer an entry, and how it left is the point
/// of the paragraph above. It was described here as "the one permanent entry",
/// on the reasoning that each package's helper import forces it to differ — but
/// the helper import is normalised by construction (see [_normalise]), so the
/// permanence was asserted, never measured. What actually kept it divergent was
/// three cases claiming the serialized-AST pipeline could not raise a parser
/// diagnostic. SCC35 made `execute()` reject source that does not parse, the
/// claim became false, and the file converged. Read "permanent" here as
/// "nobody has re-measured it".
/// The pattern behind the pairs below is worth stating because it predicts the
/// next one: a `src/` import resolves against `tom_d4rt_ast` under
/// `src/runtime/`, while the public library import resolves against
/// `tom_d4rt_exec` — because exec owns the parsing front end and ast owns the
/// runtime. A reference test importing `package:tom_d4rt/src/<x>.dart` therefore
/// ports to `package:tom_d4rt_ast/src/runtime/<x>.dart`, and a new such import
/// needs a pair here rather than an exemption anywhere else.
/// The `tom_d4rt_ast` version each publish-blocked baseline entry is waiting to
/// see passed, keyed by the entry's path in [_uncoveredBaseline] or
/// [_divergentBaseline].
///
/// WHY A MACHINE-READABLE REGISTER AND NOT JUST THE PROSE. Every entry in both
/// baselines already explains itself, and the publish-blocked ones already
/// stated their flip condition precisely — "delete this entry in the commit
/// that raises exec's `tom_d4rt_ast` floor past 0.36.0". Three of them then sat
/// unported while the floor went to 0.40.0, because a condition written in a
/// comment is evaluated only by whoever happens to reread the comment, and the
/// natural moment to reread it — the publish — is the one moment nobody is
/// looking at this file. The entries were not wrong and nobody was careless;
/// the obligation was simply invisible at the time it came due.
///
/// So the flip condition moves out of the prose and into a value the suite can
/// evaluate. [F-SCC43-1] reads exec's own `pubspec.yaml`, compares its
/// `tom_d4rt_ast` floor against every version recorded here, and fails with the
/// list of entries whose publish has landed. Raising the floor therefore
/// *produces the re-port checklist* instead of relying on someone to reconstruct
/// it, and the checklist arrives in the same commit that makes the work possible.
///
/// TO ADD AN ENTRY: whenever you write a baseline comment saying an entry is
/// blocked on an interpreter publish, record the version here too. The guard
/// enforces that pairing in both directions — a key that no longer names a live
/// baseline entry fails as a stale register, and a baseline comment naming a
/// floor without a key here fails as an unregistered obligation. Neither half
/// is optional, because a register that is allowed to drift from the prose is
/// back to being prose.
///
/// A PIN IS A PREDICTION UNTIL SOMEBODY RUNS IT. SCC44 re-measured all seven
/// entries this register held and six of them already passed — the six were
/// recorded from prose ("the working-tree interpreter coerces a typed-data list
/// where the published one does not") rather than from a run against the
/// published copy, and they outlived their cause by a full release. `queue`,
/// `list_queue`, `splay_tree_map`, `typed_list_inherited_members` and
/// `operator_improvements` converged verbatim on 2026-09-05 at floor 0.40.0 and
/// left both this register and [_divergentBaseline].
///
/// So the register's guard is necessary and not sufficient: F-SCC43-1 tells you
/// WHEN an entry becomes reviewable, and only a run tells you whether it is
/// still true. When the floor moves, re-measure every entry here, not the one
/// you happened to be reading — the six that had gone stale were stale for the
/// same reason, and reading any one of them would not have revealed the other
/// five.
const Map<String, String> _pinnedInterpreterFloors = {
  // SCC40 made the await-resumption slot per-await-site. The reference tree
  // runs F-SCB14-9/-10/-11/-12 green; this copy skips exactly those four.
  // The one pin SCC44 re-measured and found still true: against the published
  // 0.40.0 interpreter F-SCB14-9 gives `'1,2|1,2'` for an expected
  // `'1,2|3,4'`, -11 gives `'1|1'` for `'1|3'`, -12 gives `'AA'` for `'AB'`,
  // and -10 fails with `Undefined variable: out`. Tracked as SCD120.
  'scb14_await_receiver_position_test.dart': '0.40.0',
  // SCC51 (tom_d4rt_ast 0.44.0) stopped the collection bridges shadowing
  // `Iterable`'s delegating `first`/`last`/`single`. Measured 2026-09-06 against
  // the published 0.42.0: each of the six cases below still receives a
  // `RuntimeD4rtException` carrying the bridge's own message where the reference
  // tree receives the SDK's `StateError`. One case per file except `queue`,
  // which has two (`I-COLL-71` first, `I-COLL-62` last).
  'stdlib/collection/list_queue_test.dart': '0.43.0',
  'stdlib/collection/splay_tree_set_test.dart': '0.43.0',
  'stdlib/collection/linked_hash_set_test.dart': '0.43.0',
  'stdlib/collection/linked_list_test.dart': '0.43.0',
  'stdlib/collection/queue_test.dart': '0.43.0',
  // SCC49 (tom_d4rt_ast 0.43.0) added the `EventSink -> Sink` supertype edge.
  // Measured 2026-09-06 against the published 0.42.0: F-SCC49-7 returns `false`
  // for `c.sink is Sink` and F-SCC49-8 `[false, true, true]` — the `EventSink`
  // and `StreamSink` links answer, the `Sink` one does not.
  'stdlib/async/stream_consumer_test.dart': '0.42.0',
};

/// The `tom_d4rt_ast` floor exec's own `pubspec.yaml` currently declares.
///
/// Read from the file rather than hard-coded, because the whole point is to
/// notice the moment somebody edits that line — a copy here would have to be
/// updated by the same person, at the same moment, and would then be checking
/// their memory against itself.
String _execAstFloor() {
  final pubspec = File('pubspec.yaml').readAsStringSync();
  final match = RegExp(
    r'''tom_d4rt_ast:\s*["']?>=\s*(\d+\.\d+\.\d+)''',
  ).firstMatch(pubspec);
  if (match == null) {
    fail(
      'Could not read the tom_d4rt_ast floor from pubspec.yaml. The register '
      'below is evaluated against it, so an unreadable constraint silently '
      'disarms every pinned entry — hence a hard failure rather than a skip.',
    );
  }
  return match.group(1)!;
}

/// Whether [a] is strictly greater than [b], both `x.y.z`.
bool _versionExceeds(String a, String b) {
  final left = a.split('.').map(int.parse).toList();
  final right = b.split('.').map(int.parse).toList();
  for (var i = 0; i < 3; i++) {
    if (left[i] != right[i]) return left[i] > right[i];
  }
  return false;
}

/// Baseline entries in this file whose comment declares an interpreter floor,
/// as `<entry path> -> <version>`.
///
/// Attribution is by the comment run immediately above an entry line, which is
/// exactly how both baselines are written. This exists so the prose and
/// [_pinnedInterpreterFloors] cannot disagree.
///
/// The entry pattern accepts any single-value right-hand side rather than just
/// an integer, because the two baselines no longer have the same shape:
/// [_uncoveredBaseline] maps to a case count and [_divergentBaseline] to a
/// [_Divergence]. A pattern that only matched digits would have silently
/// stopped attributing every divergent entry the moment SCC44 changed that map
/// — including the one publish-pin still standing — and a scanner that finds
/// nothing passes.
Map<String, String> _floorsDeclaredInComments() {
  final lines = File('test/conformance_drift_test.dart').readAsLinesSync();
  final floorPattern = RegExp(r'floor past (\d+\.\d+\.\d+)');
  final entryPattern = RegExp(r"^\s*'([^']+)'\s*(?::\s*[^,]+)?,\s*$");
  final declared = <String, String>{};
  var pending = <String>[];
  for (final line in lines) {
    final trimmed = line.trimLeft();
    if (trimmed.startsWith('//')) {
      pending.add(trimmed);
      continue;
    }
    if (entryPattern.firstMatch(line) case final m?) {
      for (final comment in pending) {
        if (floorPattern.firstMatch(comment) case final f?) {
          declared[m.group(1)!] = f.group(1)!;
          break;
        }
      }
    }
    pending = <String>[];
  }
  return declared;
}

/// The comment run written directly above each [_divergentBaseline] entry, as
/// `<entry path> -> <joined comment text>`.
///
/// Entries with no comment above them are absent from the result rather than
/// present with an empty value, which is what lets F-SCC44-1 distinguish "this
/// entry has no reason" from "the scanner did not reach it".
Map<String, String> _divergentEntryComments() {
  final lines = File('test/conformance_drift_test.dart').readAsLinesSync();
  final entryPattern = RegExp(r"^\s*'([^']+)'\s*:\s*_Divergence\.\w+,\s*$");
  final reasons = <String, String>{};
  var inMap = false;
  var pending = <String>[];
  for (final line in lines) {
    if (!inMap) {
      inMap = line.startsWith(
        'const Map<String, _Divergence> _divergentBaseline = {',
      );
      continue;
    }
    if (line.startsWith('};')) break;
    final trimmed = line.trimLeft();
    if (trimmed.startsWith('//')) {
      pending.add(trimmed.substring(2).trim());
      continue;
    }
    if (entryPattern.firstMatch(line) case final m? when pending.isNotEmpty) {
      reasons[m.group(1)!] = pending.join(' ');
    }
    pending = <String>[];
  }
  return reasons;
}

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
    .replaceAll('package:tom_d4rt_ast/src/runtime/generator/d4.dart', '@D4@')
    // SCC35: `bridge/bridged_class_test.dart` reaches the InterpretedInstance
    // extension directly. Once its SCC27 divergence cleared, this import was
    // the ONLY thing still separating the two copies — a permanent difference
    // in where each package puts the file, not a difference in what either
    // asserts. Left un-normalised it would have needed a standing
    // `_divergentBaseline` entry, and that entry would then have absorbed any
    // real drift in the file for as long as it stood.
    .replaceAll(
      'package:tom_d4rt/src/utils/extensions/interpreted_instance.dart',
      '@INTERPRETED_INSTANCE@',
    )
    .replaceAll(
      'package:tom_d4rt_ast/src/runtime/utils/extensions/interpreted_instance.dart',
      '@INTERPRETED_INSTANCE@',
    )
    // SCC52: `scc46_native_enum_runtime_type_test.dart` builds a
    // `BridgedEnumDefinition` directly, which neither package re-exports from
    // its public library. Same shape as the two pairs above and the same
    // reason for normalising rather than baselining: the import is the only
    // thing that can differ, so an entry would buy a permanent exemption for a
    // file whose assertions are identical.
    .replaceAll('package:tom_d4rt/src/bridge/bridged_enum.dart', '@ENUM@')
    .replaceAll(
      'package:tom_d4rt_ast/src/runtime/bridge/bridged_enum.dart',
      '@ENUM@',
    );

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
      final baseline = _divergentBaseline.keys.toSet();
      final appeared = divergent.difference(baseline);
      final converged = baseline.difference(divergent);

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

  group('SCC43: publish-blocked entries flip when the publish lands', () {
    test('F-SCC43-1: no pinned entry is waiting on a publish that already '
        'happened [2026-09-05] (PASS)', () {
      final floor = _execAstFloor();

      // Part one — no stale keys. An entry that has already been re-ported
      // leaves the baselines but not necessarily this register, and a register
      // holding paths that no longer exist reads as unfinished work that isn't.
      final live = {..._uncoveredBaseline.keys, ..._divergentBaseline.keys};
      final stale = _pinnedInterpreterFloors.keys
          .where((path) => !live.contains(path))
          .toList();
      expect(
        stale,
        isEmpty,
        reason:
            'These paths are registered as waiting on an interpreter publish '
            'but are no longer in either baseline, so the wait is over and the '
            'register was not updated with the port. Delete '
            'them from _pinnedInterpreterFloors:\n${stale.join('\n')}',
      );

      // Part two — the register agrees with the prose. The observed failure
      // mode was an entry whose flip condition lived only in a comment; this
      // makes writing the comment insufficient on its own.
      final unregistered = <String>[];
      _floorsDeclaredInComments().forEach((path, version) {
        if (!live.contains(path)) return;
        final registered = _pinnedInterpreterFloors[path];
        if (registered == null) {
          unregistered.add('$path: comment says $version, not registered');
        } else if (registered != version) {
          unregistered.add(
            '$path: comment says $version, register says $registered',
          );
        }
      });
      expect(
        unregistered,
        isEmpty,
        reason:
            'A baseline comment names an interpreter floor that '
            '_pinnedInterpreterFloors does not carry, or carries differently. '
            'A flip condition that exists only in prose is checked only when '
            'somebody rereads the prose, which is how scc29/scc30/scc31 stayed '
            'unported through four publishes. Record it in both '
            'places:\n${unregistered.join('\n')}',
      );

      // Part three — the point of the whole register. Everything whose publish
      // has landed is now due, and the failure message IS the checklist.
      final due = <String>[];
      _pinnedInterpreterFloors.forEach((path, waitingOn) {
        if (_versionExceeds(floor, waitingOn)) {
          due.add('$path — waited on a publish past $waitingOn');
        }
      });
      expect(
        due,
        isEmpty,
        reason:
            "exec's tom_d4rt_ast floor is now $floor, which passes the version "
            'these entries were waiting for. The interpreter behaviour they '
            'were pinned to is published, so each one can be re-ported now: '
            'copy the twin from ../tom_d4rt/test over the exec copy, rewrite '
            'the interpreter import, run it, and delete both the baseline '
            'entry and its line in _pinnedInterpreterFloors. If one of them '
            'turns out still to fail, that is a real finding and needs a fresh '
            'entry saying so — do not re-pin it to the next version without '
            'measuring.\n${due.join('\n')}',
      );
    });
  }, skip: skipReason);

  group('SCC44: every standing divergence is justified in writing', () {
    test('F-SCC44-1: each _divergentBaseline entry carries a reason '
        '[2026-09-05] (PASS)', () {
      // The category alone is not the justification. `_Divergence.necessary`
      // says a claim was made; it does not say what makes the two copies
      // un-mergeable, and the next reader cannot re-derive that from a path and
      // an enum. SCC44 found 32 of 38 entries in the predecessor `Set` were
      // never verdicts at all — they converged the moment anyone ran them —
      // and the thing that made them indistinguishable from real findings was
      // exactly this missing sentence. An entry absorbs every future drift in
      // its file for as long as it stands, so the cost of an unexamined one is
      // paid indefinitely.
      final reasons = _divergentEntryComments();

      // Part one — the scanner reached the map. A source scan that matches
      // nothing passes every assertion built on it, which is the failure mode
      // that had already disarmed the floor scanner when SCC44 changed this
      // map's shape. Assert coverage before asserting content.
      expect(
        reasons.keys.toSet(),
        equals(_divergentBaseline.keys.toSet()),
        reason:
            'The comment scan did not pair up with the map it scans. Either an '
            'entry has no comment run above it, or the entry syntax changed '
            'and _divergentEntryComments no longer recognises it — and in the '
            'second case every check below silently stops testing anything.',
      );

      // Part two — the reason is a reason. A length floor cannot tell prose
      // from padding, but it does separate a written explanation from a
      // restated filename, which is the observed degenerate case.
      final thin = reasons.entries
          .where((e) => e.value.length < 80)
          .map((e) => '${e.key}: "${e.value}"')
          .toList();
      expect(
        thin,
        isEmpty,
        reason:
            'These entries carry a comment too short to explain anything. The '
            'reason has to say what the two copies assert differently and why '
            'that difference has to stand — for _Divergence.necessary, what '
            'coverage overwriting either side would delete; for '
            '_Divergence.deliberate, what makes converging wrong rather than '
            'merely undone.\n${thin.join('\n')}',
      );
    });
  }, skip: skipReason);
}
