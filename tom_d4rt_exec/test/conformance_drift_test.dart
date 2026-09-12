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

import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:test/test.dart';

/// Why a reference file with no same-path exec counterpart is nevertheless
/// covered, and where that coverage lives.
///
/// [where] is `exec:<path>` or `ast:<path>`, relative to that package's `test/`.
/// [refCases] and [twinCases] are `test(` counts; when the twin carries fewer,
/// the coverage is PARTIAL and the deficit is reported by its own case below
/// rather than being rounded up to "covered".
/// Which LAYER a reference suite exercises, and therefore what a twin of it can
/// and cannot certify.
///
/// SCD20. The guard's three-way rule — a tom_d4rt test is uncovered only when
/// it has a twin in NEITHER exec nor tom_d4rt_ast — is what dropped the
/// apparent gap from 46 files to 18, and it is sound for what it claims. What
/// it is silent about is that the two kinds of twin certify different things.
///
/// An exec test hands SOURCE to the analyzer, has `tom_ast_generator` copy the
/// analyzer AST into the mirror node-for-node, and interprets the result. A
/// tom_d4rt_ast test constructs or loads a mirror AST and interprets it. The
/// copy step is exec's alone, it is roughly a thousand nodes of transcription,
/// and a node whose fields are copied wrongly yields a mirror tree that
/// interprets CONSISTENTLY AND WRONGLY. No ast twin can see that, because it
/// never had an analyzer AST to copy from.
///
/// So a [script] suite exempted by an `ast:` twin leaves the copier untested
/// for whatever constructs its source uses, and a [registration] suite does
/// not — there is no source, so there is nothing to copy. That is the whole
/// distinction this enum records, and why it is on every entry rather than
/// only on the ones that look interesting.
enum _Layer {
  /// The reference suite runs SOURCE and asserts behaviour. An `ast:` twin of
  /// one of these cannot exercise the analyzer-to-mirror copy.
  script,

  /// The reference suite asserts bridge wiring — registries, lookups,
  /// retention, name resolution — without running a script. Here the ast twin
  /// is not a substitute for an exec test; it is the BETTER test, closer to
  /// the code it exercises.
  registration,
}

class _Coverage {
  const _Coverage(
    this.where,
    this.why, {
    required this.layer,
    this.refCases = 0,
    this.twinCases = 0,
    this.whyPartial,
  });

  final String where;
  final String why;

  /// Which layer the REFERENCE suite exercises. Required, so a new entry
  /// cannot be added without the author deciding — the classification is a
  /// reading of the file, and a default would be a guess wearing a fact's
  /// clothes.
  final _Layer layer;
  final int refCases;
  final int twinCases;

  /// Why this twin is legitimately SMALLER than its reference, or null when
  /// the shortfall has not been examined.
  ///
  /// SCD19 added this. Before it, the only way to accept a partial was to raise
  /// [_partialTwinBudget] and explain the raise in that constant's doc comment
  /// — which put the reasoning in a global counter rather than on the entry it
  /// described, and left the budget saying "eight partials are fine" without
  /// binding WHICH eight. An entry carrying its own reason cannot drift away
  /// from the thing it excuses.
  ///
  /// Set it only for a twin that is a DIFFERENT KIND of test, never for one
  /// that is the same kind with cases missing. The distinction is the whole
  /// point: `dfub4` looked exactly like this and was three dropped cases.
  final String? whyPartial;

  bool get isPartial => twinCases < refCases;

  /// Whether exec's analyzer-to-mirror copier is unexercised for this suite.
  ///
  /// True exactly when a source-running suite is exempted by a twin that never
  /// sees source. Derived rather than declared: it follows from [layer] and
  /// [where], and a hand-maintained duplicate of a derivable fact is one more
  /// thing to drift.
  bool get copierUncovered =>
      layer == _Layer.script && where.startsWith('ast:');

  /// A shortfall nobody has explained — what F-SCC6-3 is counting.
  bool get isUnexplainedPartial => isPartial && whyPartial == null;
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

/// How many partial twins may go UNEXPLAINED (F-SCC6-3).
///
/// A ratchet, not a target -- but SCD19 changed what it counts. It used to count
/// every partial, so accepting one meant raising the number and explaining the
/// raise in this comment: the reasoning lived on a global counter rather than on
/// the entry it described, and "eight partials are fine" bound none of the eight
/// to anything. A partial whose entry carries a [_Coverage.whyPartial] is now
/// simply not counted here, and its reason sits where a reader meets it.
///
/// Which leaves the shortfalls nobody has explained. There is one:
/// `scc28_typed_undefined_member_test.dart`, six cases short, and its entry
/// records that the block on porting them is gone and SCD88 owns the port. That
/// is a closable gap with an owner, NOT a twin that is legitimately smaller, so
/// giving it a `whyPartial` would be a lie of exactly the kind that field
/// invites -- see the field's own doc.
///
/// Lower it when SCD88 lands. Raising it needs a new unexplained shortfall
/// somebody has decided to tolerate, which should be rare enough to argue about.
const _partialTwinBudget = 1;

/// How many script-level suites may rest on an `ast:` twin alone (F-SCC6-7).
///
/// SCD20. Each of these is a suite that runs SOURCE, exempted by a twin that
/// never sees source, so exec's analyzer-to-mirror copier is unexercised for
/// whatever constructs that suite uses. They are ACCEPTED, not defects — the
/// alternative the todo explicitly ruled out is porting all of them, which buys
/// copier coverage by doubling a corpus that DGUC6 already makes hard to reason
/// about, since exec measures the PUBLISHED tom_d4rt_ast rather than the tree
/// being edited.
///
/// The number is therefore a ratchet on a known, deliberate gap rather than a
/// target of zero. Lowering it is what a targeted port achieves; raising it
/// needs a new script-level suite that somebody decided not to port, and the
/// entry should say why.
///
/// What actually closes this is node-family coverage, not file count: a handful
/// of exec tests spanning patterns, records, extension types, generic
/// constructor invocation and the directive forms exercises more of the copy
/// surface than fourteen ports chosen by which files happen to have ast twins.
/// That census is sce62.
///
/// The fourteen were classified by asking whether the REFERENCE file runs
/// source, with comments stripped first. That is not pedantry:
/// `bridged_enum_memo_test.dart`'s only `execute(` is inside a comment, and a
/// naive search files it as script-level and inflates this budget to fifteen.
const _copierGapBudget = 14;

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
    layer: _Layer.script,
    refCases: 3,
    twinCases: 7,
  ),
  'dfub2_filesystem_import_permission_test.dart': _Coverage(
    'exec:dgub3_filesystem_import_basepath_test.dart',
    'read-gate half only, as F-DGUB3-4; the write-side gate is DFUB11, which '
        'exec has at its own path',
    layer: _Layer.script,
    refCases: 4,
    twinCases: 7,
  ),
  'dfub3_filesystem_module_identity_test.dart': _Coverage(
    'exec:dgub3_filesystem_import_basepath_test.dart',
    'nested-relative canonicalisation, as F-DGUB3-3',
    layer: _Layer.script,
    refCases: 2,
    twinCases: 7,
  ),
  // Same basename, different directory: exec files this under extensions/.
  'dfub4_extension_type_method_dispatch_test.dart': _Coverage(
    'exec:extensions/dfub4_extension_type_method_dispatch_test.dart',
    'same suite, filed under extensions/ in this tree',
    layer: _Layer.script,
    refCases: 9,
    // SCD19 ported F-DFUB4-5, -6 and -8, which had no counterpart here. They
    // are script-level dispatch cases like the six that were already present —
    // loops, conditionals, a method calling a method — so nothing about them
    // needed the analyzer, and their absence was a shortfall rather than a
    // difference in kind. All three pass, so no defect was hiding behind the
    // gap; what was hiding was the gap itself, which read as covered because
    // the filename matched.
    twinCases: 9,
  ),

  // ---- Renamed on the ast side ---------------------------------------------
  'open_issues/b12_native_accumulator_reset_test.dart': _Coverage(
    'ast:runtime/native_accumulator_reset_test.dart',
    'same six cases; ast drops the `b12_` issue prefix and the open_issues/ dir',
    layer: _Layer.script,
    refCases: 6,
    twinCases: 6,
  ),

  // ---- Native ast twins, same basename ------------------------------------
  'bridge/extract_bridged_arg_diagnostics_test.dart': _Coverage(
    'ast:runtime/extract_bridged_arg_diagnostics_test.dart',
    _astTwin,
    layer: _Layer.registration,
    refCases: 3,
    twinCases: 3,
  ),
  'bridge/facade_user_registration_test.dart': _Coverage(
    'ast:runtime/facade_user_registration_test.dart',
    _astTwin,
    layer: _Layer.registration,
    refCases: 5,
    twinCases: 5,
  ),
  'bridge/unwrap_as_test.dart': _Coverage(
    'ast:runtime/unwrap_as_test.dart',
    _astTwin,
    layer: _Layer.registration,
    refCases: 12,
    twinCases: 12,
  ),
  'bridge/usage_log_test.dart': _Coverage(
    'ast:runtime/usage_log_test.dart',
    _astTwin,
    layer: _Layer.registration,
    refCases: 9,
    twinCases: 9,
  ),
  'bridge_retention_test.dart': _Coverage(
    'ast:runtime/bridge_retention_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 3,
    twinCases: 3,
  ),
  'bridged_enum_memo_test.dart': _Coverage(
    'ast:bridged_enum_memo_test.dart',
    _astTwin,
    layer: _Layer.registration,
    refCases: 3,
    twinCases: 3,
  ),
  'bridged_module_env_cache_test.dart': _Coverage(
    'ast:runtime/bridged_module_env_cache_test.dart',
    _astTwin,
    layer: _Layer.script,
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
    layer: _Layer.registration,
    refCases: 9,
    twinCases: 9,
  ),
  'dgub5_filesystem_permission_symlink_test.dart': _Coverage(
    'ast:runtime/dgub5_filesystem_permission_symlink_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 6,
    twinCases: 3,
    whyPartial:
        'the twin covers the three cases that are about the permission object '
        '(F-DGUB5-4..6: allows() equating symlinked and real spellings, a '
        'not-yet-created path, and one under a symlinked ancestor). The three '
        'it omits — F-DGUB5-1..3 — assert what an IMPORT is allowed to read, '
        'which needs module resolution over source, and tom_d4rt_ast has no '
        'parser. Only exec can run those, and it does, at its own path.',
  ),
  'environment_lazy_bridge_test.dart': _Coverage(
    'ast:environment_lazy_bridge_test.dart',
    _astTwin,
    // SCD19: both sides had grown from 17 to 24 since these were written, in
    // step, so the pair was never partial and nothing reported the drift. The
    // numbers were simply no longer true, which is why F-SCC6-6 now checks
    // them against the files.
    layer: _Layer.registration,
    refCases: 24,
    twinCases: 24,
  ),
  'environment_lookup_test.dart': _Coverage(
    'ast:runtime/environment_lookup_test.dart',
    _astTwin,
    layer: _Layer.registration,
    refCases: 8,
    twinCases: 8,
  ),
  'extension_hook_test.dart': _Coverage(
    'ast:runtime/extension_hook_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 7,
    twinCases: 7,
  ),
  'extension_once_per_process_test.dart': _Coverage(
    'ast:runtime/extension_once_per_process_test.dart',
    _astTwin,
    layer: _Layer.registration,
    refCases: 3,
    twinCases: 3,
  ),
  'phase1_uri_registration_test.dart': _Coverage(
    'ast:runtime/phase1_uri_registration_test.dart',
    _astTwin,
    layer: _Layer.registration,
    refCases: 4,
    twinCases: 4,
  ),
  'pool_security_test.dart': _Coverage(
    'ast:runtime/pool_security_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 4,
    twinCases: 4,
  ),
  'profiler_disabled_test.dart': _Coverage(
    'ast:profiler_disabled_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 2,
    twinCases: 2,
  ),
  'reuse_across_runs_toggle_test.dart': _Coverage(
    'ast:runtime/reuse_across_runs_toggle_test.dart',
    _astTwin,
    layer: _Layer.script,
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
    layer: _Layer.script,
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
    layer: _Layer.script,
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
    layer: _Layer.script,
    refCases: 8,
    twinCases: 8,
  ),
  'warm_parent_lazy_class_test.dart': _Coverage(
    'ast:runtime/warm_parent_lazy_class_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 1,
    twinCases: 1,
  ),

  // ---- Native ast twins, `stdlib_`-prefixed --------------------------------
  'stdlib/convert/convert_hierarchy_test.dart': _Coverage(
    'ast:runtime/stdlib_convert_hierarchy_test.dart',
    _astStdlibPrefix,
    layer: _Layer.script,
    refCases: 15,
    twinCases: 11,
    whyPartial:
        'not a subset — a different decomposition of the same subject. The '
        'reference asserts the hierarchy through `is` checks in interpreted '
        'script; the twin asserts it against the REGISTRATIONS (that '
        'JsonCodec extends Codec directly, that the type test and the member '
        'walk agree about depth, that Encoding declares decodeStream). It '
        'even carries a case the reference has none of, F-SCB23-AST-8. What '
        'it cannot assert is the handful of script-level behaviours — fuse '
        'resolving on both halves, leaf members winning over inherited ones — '
        'which need an interpreter run over source. Comparing case COUNTS '
        'across two decompositions measures nothing; the count is kept only so '
        'a future drop is visible.',
  ),
  'stdlib/io/io_reexport_visibility_test.dart': _Coverage(
    'ast:runtime/stdlib_io_reexport_visibility_test.dart',
    _astStdlibPrefix,
    // SCD19: recorded as 10 -> 6 and reported as a four-case deficit for five
    // weeks. Measured, it is 8 -> 11: the twin OVER-covers, and the reference
    // shrank. The deficit was an artefact of numbers nobody re-read.
    layer: _Layer.script,
    refCases: 8,
    twinCases: 11,
  ),
  'stdlib/io/string_sink_collision_test.dart': _Coverage(
    'ast:runtime/stdlib_string_sink_collision_test.dart',
    _astStdlibPrefix,
    layer: _Layer.registration,
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
/// fails for reasons that read as migration bugs.
///
/// SCD21 MOVED THAT PRECONDITION OUT OF THIS PARAGRAPH. F-SCC80-3 performs the
/// comparison, so it is announced by every run rather than depending on the
/// next person reading this and remembering. The paragraph is kept because it
/// records WHY the precondition exists, which a failure message has no room
/// for — but the check is the check, and prose asking someone to run a diff is
/// not one.
/// The three SCC11 entries below are the first added under that precondition
/// rather than in spite of it. Each was ported, analysed clean, and then
/// REMOVED again: every member they assert (the seven static validation
/// helpers, the `castFrom` family, the long tail) exists only in the working
/// tree, so all 46 cases fail against the published `tom_d4rt_ast` — not as a
/// migration bug but because the members are genuinely absent from the version
/// exec resolves. Porting them now would have made the exec suite red for a
/// reason no reader could act on.
///
/// Their flip condition was the same one the [_divergentBaseline] header names:
/// the next `tom_d4rt_ast` publish.
///
/// **THAT WHOLE CLASS OF ENTRY IS NOW GONE.** The map used to be mostly
/// publish-pinned, and those pins went unre-measured across four publishes while
/// their prose kept asserting, in the present tense, that exec resolved 0.20.1.
/// Measured 2026-09-06 (the floor and lock numbers below have since moved —
/// `^0.55.0` and 0.55.0 as of 2026-09-07; F-SCC80-1 prints the live pair on
/// every run, so read that rather than this paragraph): exec's pubspec floor
/// was `>=0.40.0`, the lockfile
/// resolved 0.42.0, and `diff -rq` of that hosted copy against the working tree
/// returns twelve files — all of them `src/runtime/stdlib/collection/*` plus
/// `environment.dart` and `stdlib/async/stream.dart`, i.e. exactly the
/// unpublished SCC49 and SCC51 work. **The interpreter core is byte-identical
/// between published and working tree**, so a publish pin on anything other
/// than a collection or stream bridge is, today, a claim about nothing.
///
/// Every entry was therefore re-ported and re-run under that precondition, and
/// eight of the twelve pinned files went green on the published interpreter with
/// no interpreter work at all: `scc12` (11/11), `scc18` (12/12), `scc19` (9/9),
/// `scc20` (25/25 — including F-SCC20-18, which the entry had predicted could
/// never flip), and the four SCC11 stdlib files (6, 13, 18 and 22 cases). All
/// eight are now ported and their entries are deleted; 116 cases of reference
/// coverage moved into this suite in one pass.
///
/// **A publish-blocked entry here must register its floor in
/// [_pinnedInterpreterFloors] in the same edit.** SCC44's sweep left this map
/// with none — the survivors of that pass are blocked on exec-local work or are
/// structurally un-portable, and neither condition is fixed by publishing — and
/// for a while that read as an invariant of the map itself. It is not, and
/// treating it as one would be the same mistake in a new place: a reference test
/// whose subject is an interpreter change that has not shipped belongs HERE,
/// with a floor, not deleted and not ported-and-skipped. `core_hierarchy` is the
/// first such entry since, and it is the shape to copy. What must never come
/// back is the entry that states its flip condition in prose ALONE, because the
/// prose is read only by whoever happens to reread it and never by the publish.
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
  // SCC75. The SDK-completeness guard reads the SDK source with the analyzer
  // and diffs it against the registered bridge set — and it skips members
  // annotated `@Since` a version above THE READING PACKAGE'S OWN SDK FLOOR,
  // taken from its `pubspec.yaml`. That rule is what keeps it from turning red
  // on every SDK upgrade, and it is also why the file cannot be shared: the
  // reference tree declares `^3.9.0` and this one `^3.10.4`, so the two
  // legitimately disagree about which members are in scope.
  //
  // Ported experimentally on 2026-09-06 it reported one member,
  // `Future.syncValue` (`@Since("3.10")`) — correctly, and the finding is real
  // rather than an artefact: `tom_d4rt_ast` also declares `^3.10.4`, so it
  // could bridge it today and does not, purely because the mirror ties it to
  // `tom_d4rt`'s lower floor. `tom_d4rt` is in fact the only package in the
  // repo below 3.10.4, lower than every one of its own consumers. Aligning the
  // floors and bridging the member is SCD191; porting this file becomes
  // possible in the same change, because the disagreement disappears with the
  // floor gap.
  'scc73_sdk_member_completeness_test.dart': 4,
  'stdlib/member_coverage_baseline_test.dart': 4,
  // NOT PORTABLE — SCC17's release-hygiene guard. Its subject is the repo, not
  // an interpreter: it walks git history and reads the pubspec and CHANGELOG of
  // all three published packages, *including this one*. A copy here would ask
  // the same questions about the same three files and answer them identically,
  // so the second copy could only ever add a duplicate failure. Coverage of
  // exec's own release hygiene is F-SCC17-1/2/3 `tom_d4rt_exec`, which already
  // run in the reference tree.
  'release_hygiene_test.dart': 10,
  // PARTLY PORTABLE, and the reason it is still whole here is a decision this
  // map cannot make on its own. Re-measured 2026-09-06 against published
  // 0.42.0: 14 of 17 cases PASS. The four async-catch cases this entry was
  // written to pin (F-SCC22-13..16) are among them — SCC22's fix for an empty
  // `catch (e) {}` abandoning the rest of an async function shipped, so the
  // publish pin this entry used to carry is discharged.
  //
  // What fails is the group the old text predicted would pass: the three
  // structural cases F-SCC22-10/-11/-12. They read the two sibling trees'
  // `lib/src` off disk with paths relative to the package they run in, so from
  // `tom_d4rt_exec/test` they resolve to exec's own `lib`, which carries no
  // stdlib error-handler adapters at all. The reference copy already walks BOTH
  // trees and answers the question correctly for both; a copy here can only ever
  // restate it against the wrong subject.
  //
  // So the file splits 14 portable / 3 structurally single-copy, and porting the
  // portable half means a subtraction port — a `_divergentBaseline` entry whose
  // blanket then absorbs every future divergence in the file (SCD154). That
  // trade is a design call, not a census outcome, so it is SCD157 rather than
  // something this pass improvised.
  //
  // RE-MEASURED 2026-09-12 against published 0.65.0 (scd25_aida), which is 23
  // releases past the 0.42.0 the numbers above were taken at: UNCHANGED, case
  // for case. scc22 is still 14/17 with F-SCC22-10/-11/-12 failing, scc25 still
  // 5/7 with F-SCC25-6/-7, scc27 still 8/9 with F-SCC27-9, and scc23 still does
  // not compile for the same five `undefined_setter` errors. So none of these
  // four is a stale pin waiting on a publish that already happened — the
  // residual failures are source scans over files exec does not own, plus the
  // one behavioural gap scc27's own note names.
  'scc22_io_error_handler_arity_test.dart': 17,
  // BLOCKED ON EXEC-LOCAL WORK — no longer on a publish, and the correction is
  // the finding. Ported verbatim 2026-09-06 it still does not COMPILE: five
  // `undefined_setter` errors, because all 16 cases set `D4rt.onUncaughtError`
  // and this package's `D4rt` has no such member. But the reason recorded here
  // for years — "the forwarder cannot be written until `tom_d4rt_ast`
  // publishes" — is now false. `onUncaughtError` IS in published 0.42.0, on
  // `D4rtRunner` in `lib/src/runtime/d4rt_runner.dart`; grep both the pub cache
  // copy and the working tree and they agree.
  //
  // Both halves of the two-part job are therefore unblocked today:
  //   * `executeBundle` forwards to the inner [D4rtRunner] — a one-line
  //     forwarder alongside the twenty others in `lib/src/d4rt_base.dart`.
  //   * The classic `execute()` path does NOT go through the runner (this
  //     package carries its own third copy of `_executeInEnvironment`), so the
  //     zone seam has to be mirrored into it separately.
  //
  // Doing only one half would ship a hook that fires for `execute()` and
  // silently does not for `executeBundle()` — the "looks covered" failure this
  // file exists to catch, in the public API rather than in the suite. That is
  // still the rule; what changed is that waiting is no longer a reason. SCD74
  // owns it, and it is an API addition with its own test cycle rather than
  // census work.
  //
  // RE-MEASURED 2026-09-12 against published 0.65.0 (scd25_aida), which is 23
  // releases past the 0.42.0 the numbers above were taken at: UNCHANGED, case
  // for case. scc22 is still 14/17 with F-SCC22-10/-11/-12 failing, scc25 still
  // 5/7 with F-SCC25-6/-7, scc27 still 8/9 with F-SCC27-9, and scc23 still does
  // not compile for the same five `undefined_setter` errors. So none of these
  // four is a stale pin waiting on a publish that already happened — the
  // residual failures are source scans over files exec does not own, plus the
  // one behavioural gap scc27's own note names.
  'scc23_uncaught_callback_error_test.dart': 16,
  // PARTLY PORTABLE, for exactly SCC22's reason and with the same shape of
  // correction. Re-measured 2026-09-06 against published 0.42.0: 5 of 7 cases
  // PASS. The three listen-adapter failures this entry recorded against 0.20.1
  // (F-SCC25-3 ServerSocket, -4 RawDatagramSocket, -5 HttpServer) are gone —
  // SCC25's fix shipped, so the five behavioural cases now all agree with the
  // reference tree.
  //
  // What fails is the source-guard pair F-SCC25-6/-7, which the old text
  // correctly called un-portable but expected to pass: they scan the sibling
  // trees' stdlib for a privately redefined `_runAction` and for hand-rolled
  // onError/onDone wrapper trios, and from exec's directory the scan subject is
  // exec's own `lib`, which contains neither. The reference copy already asks
  // this of both trees.
  //
  // 5 portable / 2 structurally single-copy. Same subtraction-port trade as
  // SCC22 above, tracked together as SCD157. SCD79 remains the record of the
  // adapter work itself.
  //
  // RE-MEASURED 2026-09-12 against published 0.65.0 (scd25_aida), which is 23
  // releases past the 0.42.0 the numbers above were taken at: UNCHANGED, case
  // for case. scc22 is still 14/17 with F-SCC22-10/-11/-12 failing, scc25 still
  // 5/7 with F-SCC25-6/-7, scc27 still 8/9 with F-SCC27-9, and scc23 still does
  // not compile for the same five `undefined_setter` errors. So none of these
  // four is a stale pin waiting on a publish that already happened — the
  // residual failures are source scans over files exec does not own, plus the
  // one behavioural gap scc27's own note names.
  'scc25_listen_adapter_test.dart': 7,
  // ONE CASE SHORT, and it is the only entry left here that names a real
  // behavioural gap in this package. Re-measured 2026-09-06 against published
  // 0.42.0: 8 of 9 cases PASS. Everything the old text recorded as blocked has
  // landed — `isInterpreterControlFlowSignal` is in published `exceptions.dart`
  // so F-SCC27-8 compiles and passes, `throwAsHostFacingError` is published AND
  // already adopted by exec's own `lib/src/d4rt_base.dart`, and the five
  // `Native error during …` wrapper failures (F-SCC27-1/2/3/5/7) are fixed.
  //
  // The survivor is F-SCC27-9, "an error from an async main reaches the host as
  // itself". Measured: the reference tree throws a `FormatException` out of
  // `execute()`; here `execute()` returns a `Future<dynamic>` that later
  // completes with `RuntimeD4rtException: Native error during static bridged
  // method call 'parse' on int: FormatException: …`. Two divergences at once —
  // the error arrives asynchronously instead of synchronously, and it arrives
  // wrapped. The async half is structural (exec's async main genuinely returns
  // a future); the wrapping half is the `throwAsHostFacingError` seam not being
  // applied on the async completion path, which is exec-local work in the third
  // `_executeInEnvironment` copy. SCD84 owns it; port the file and delete this
  // entry in the commit that closes that seam.
  //
  // RE-MEASURED 2026-09-12 against published 0.65.0 (scd25_aida), which is 23
  // releases past the 0.42.0 the numbers above were taken at: UNCHANGED, case
  // for case. scc22 is still 14/17 with F-SCC22-10/-11/-12 failing, scc25 still
  // 5/7 with F-SCC25-6/-7, scc27 still 8/9 with F-SCC27-9, and scc23 still does
  // not compile for the same five `undefined_setter` errors. So none of these
  // four is a stale pin waiting on a publish that already happened — the
  // residual failures are source scans over files exec does not own, plus the
  // one behavioural gap scc27's own note names.
  'scc27_host_error_fidelity_test.dart': 9,
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

/// Which tree supplied the surviving assertions when a divergent pair was
/// converged.
///
/// SCD22. "Converged" without a direction is unreviewable: the pair agrees, the
/// guard goes quiet, and whether the stronger file won or the weaker one was
/// copied over it is no longer recoverable from anything but a diff nobody will
/// run. Recording the direction is the only part of the decision procedure that
/// leaves evidence.
enum _Direction {
  /// The REFERENCE copy in `tom_d4rt` was the stronger one and was mirrored
  /// down into exec. The obvious direction, and presumably the common one.
  ///
  /// Unused, which is worth stating rather than suppressing quietly: of the
  /// four convergences whose direction is documented anywhere, NONE went this
  /// way. Two possible readings — either the pairs that needed a written
  /// justification were exactly the counter-intuitive ones, or the obvious
  /// direction is rarer than it looks. The register is too small to tell, and
  /// sce64 is where that gets answered. Keeping the value is the point: an
  /// enum with only the surprising cases in it would make the surprising case
  /// look like the rule.
  // ignore: unused_field
  downstream,

  /// The EXEC copy was the stronger one and was mirrored up into `tom_d4rt`.
  /// Not rare, and the case the obvious rule destroys: exec's suite is where
  /// the analyzer-free line's gaps were characterised, so when a gap CLOSED the
  /// exec copy is the one that got the sharper assertion.
  upstream,

  /// Each side asserted something the other lacked, and the converged file
  /// asserts BOTH. Step (3) of the rule — union, not choice.
  union,
}

/// One convergence, and why it went the way it did.
class _Convergence {
  const _Convergence(this.direction, this.why);

  final _Direction direction;
  final String why;
}

/// Pairs that were divergent and are now converged, with the direction taken.
///
/// F-SCC44-2 checks that every entry is still TRUE — the file exists in both
/// trees, is not in [_divergentBaseline], and the two copies still agree. A log
/// of convergences that have since drifted apart again would be worse than no
/// log, because it reads as a record of settled questions.
///
/// This register starts part-full, and honestly so. Roughly twenty-six pairs
/// converged between SCC44 and SCD22 with no direction recorded anywhere;
/// reconstructing those from diffs would be inventing a finding rather than
/// recording one, so only the four whose direction is documented in the
/// paragraph above [_divergentBaseline] are listed. New convergences add an
/// entry; sce64 covers reconstructing what can still be established.
const Map<String, _Convergence> _convergenceLog = {
  'stdlib/collection/unmodifiable_map_view_test.dart': _Convergence(
    _Direction.upstream,
    'exec F-SC3-9 asserted four expressions including `source is Map` — the '
    'SUPERTYPE edge, which resolves through a registered hierarchy edge '
    'rather than by name-matching, so a different mechanism from the '
    'exact-type check beside it. The reference copy asserted three and did '
    'not cover the supertype on the wrapped map. Copying the reference '
    'over the twin would have deleted a real assertion and left the weaker '
    'file in BOTH trees, with the guard reporting the pair converged.',
  ),
  'dfub5_function_record_runtime_type_test.dart': _Convergence(
    _Direction.union,
    'the exec copy carried an explanation the reference lacked — the SAstNode '
    'tree has no parent pointers, so the applied return type is captured '
    'at declaration time. Folded into the reference header BEFORE the port '
    'was taken, so convergence added knowledge to both trees instead of '
    'deleting it from one.',
  ),
  'dfub6_applied_generic_runtime_types_test.dart': _Convergence(
    _Direction.union,
    'same shape as dfub5: the exec copy recorded that tom_ast_generator used '
    'to flatten RecordTypeAnnotationField, which the reference header did '
    'not say. Folded upstream first, then ported.',
  ),
  'dfub13_import_export_diagnostics_test.dart': _Convergence(
    _Direction.union,
    'same shape again: the exec copy recorded that tom_d4rt_exec owns a third '
    'copy of the module loader. Folded upstream first, then ported.',
  ),
};

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
/// THE PROCEDURE, because the principle above is not one. SCD22 wrote it down
/// after the direction question had been answered ad hoc three times. Before
/// converging a pair:
///
///   1. Diff it and read what each side ASSERTS, not which tree it lives in.
///   2. Where one side asserts strictly more, THAT SIDE WINS regardless of
///      tree.
///   3. Where they assert different things, the converged file asserts BOTH.
///      Union, not choice.
///   4. Where they genuinely contradict, that is a behaviour question. The
///      answer goes in a todo, not into a test edit.
///   5. Record the direction in [_convergenceLog]. "Converged" without a
///      direction is unreviewable.
///
/// The anti-pattern this blocks is the one the workspace rules already name
/// from the other side — never adapt a test to match buggy behaviour, never
/// loosen an assertion to make a pair agree. Bulk-converging by tree precedence
/// is that same move wearing a tidy-up's clothes: no individual step looks like
/// weakening a test, and the aggregate quietly does.
///
/// THE GUARD CANNOT CATCH THAT. [_divergentBaseline] fails on CHANGE, so it
/// fires when a converged pair drifts apart again and has no view of whether
/// the convergence kept the stronger assertions. That judgement is
/// unautomatable, which is why this is a procedure with a written record rather
/// than a test. F-SCC44-2 checks the record is still true, which is the part a
/// machine can do.
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
///
/// EMPTY AS OF 2026-09-06, and the emptiness is the register working rather
/// than the register being unused. SCC75 published `tom_d4rt_ast` 0.55.0 and
/// raised exec's floor to it; F-SCC43-1 then produced the re-port checklist —
/// all eighteen entries this map held — and every one of them passed when
/// ported. Not one had gone stale, which is the opposite of what SCC44 found
/// and is worth recording: SCC44's six stale pins had been written from prose,
/// while these eighteen were each measured against the published copy before
/// being pinned. Measure before pinning and the pin survives; infer it and it
/// rots.
const Map<String, String> _pinnedInterpreterFloors = <String, String>{};

/// The `tom_d4rt_ast` floor exec's own `pubspec.yaml` currently declares.
///
/// Read from the file rather than hard-coded, because the whole point is to
/// notice the moment somebody edits that line — a copy here would have to be
/// updated by the same person, at the same moment, and would then be checking
/// their memory against itself.
///
/// Accepts `^x.y.z` as well as `>=x.y.z`. SCC80 tightened this package's
/// constraint to a caret, and a reader that understood only `>=` would have
/// answered with `fail()` — disarming F-SCC43-1 on the very edit meant to
/// harden it.
String _execAstFloor() {
  final pubspec = File('pubspec.yaml').readAsStringSync();
  final match = RegExp(
    r'''tom_d4rt_ast:\s*["']?(?:>=|\^)\s*(\d+\.\d+\.\d+)''',
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

/// The `tom_d4rt_ast` version exec's `pubspec.lock` actually RESOLVES.
///
/// This is the interpreter every test in this package exercises, and it is not
/// the same number as [_execAstFloor]. A constraint moves only when somebody
/// edits it; a resolved version moves on every `pub upgrade`. The gap between
/// them is what SCC80 was filed about — a lock frozen five minors behind the
/// published interpreter, certifying a version no fresh checkout could obtain.
///
/// `pubspec.lock` is gitignored here (this is a package, not an app), so the
/// number is per-machine and invisible in any diff or review. That is exactly
/// why it has to be read at run time and printed, rather than written down.
String _execAstResolved() {
  final lock = File('pubspec.lock');
  if (!lock.existsSync()) {
    fail(
      'No pubspec.lock, so which interpreter this suite measures is unknown. '
      'Run `dart pub upgrade` before measuring exec conformance.',
    );
  }
  final match = RegExp(
    '^  tom_d4rt_ast:\\n(?:.*\\n)*?    version: "([^"]+)"',
    multiLine: true,
  ).firstMatch(lock.readAsStringSync());
  if (match == null) {
    fail(
      'Could not read the resolved tom_d4rt_ast version from pubspec.lock. An '
      'unreadable lock means the suite cannot say what it certified.',
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
  // The value part is optional AND may be absent entirely, because `dart
  // format` wraps an entry whose key and value do not fit in 80 columns onto
  // two lines — leaving a key line that ends in a bare `:`. A pattern that only
  // matched the one-line form would stop attributing such an entry the moment
  // the formatter ran, and an unattributed entry reads here as a floor declared
  // in prose with no register key: a failure whose cause is a line wrap.
  final entryPattern = RegExp(r"^\s*'([^']+)'\s*(?::\s*[^,]*)?,?\s*$");
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
  // The `_Divergence.x,` tail is optional for the reason given in
  // [_floorsDeclaredInComments]: the formatter puts it on its own line whenever
  // the key is long enough, and the resulting bare `'path':` is still an entry.
  final entryPattern = RegExp(
    r"^\s*'([^']+)'\s*:\s*(?:_Divergence\.\w+,)?\s*$",
  );
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
/// Shared guideline files that are NOT expected to match, and why.
///
/// SCD55. One entry, and it is permanent: `index.md` lists each package's own
/// contents, so the two copies describe different file sets by construction.
const Map<String, String> _guidelineExempt = {
  'index.md':
      'each package indexes its own folder — tom_d4rt has '
      'sync_with_tom_d4rt_ast.md and exec has hosted_drift.md, so the two '
      'lists are different documents about different things',
};

/// Guideline FILES that legitimately exist in one tree only.
///
/// Without this the comparison walks only the shared names, so deleting a
/// guideline from one tree says nothing at all — the same forgotten-mirror
/// shape the section check exists for, one level up.
const Map<String, String> _guidelineOneSidedFiles = {
  'sync_with_tom_d4rt_ast.md':
      'tom_d4rt only — it describes keeping the analyzer-based interpreter in '
      'step with its analyzer-free twin, which exec does not do',
  'hosted_drift.md':
      'exec only — DGUC6, the hazard of resolving the interpreter from '
      'pub.dev, which the other packages do not',
};

/// Headings that legitimately appear in ONE copy of a shared guideline.
///
/// Recorded, never inferred — the same discipline as [_coveredElsewhere] and
/// [_divergentBaseline]. A section appearing on one side only is exactly what
/// a forgotten mirror looks like, so it has to be a deliberate entry here
/// rather than something the comparison quietly tolerates.
const Map<String, Map<String, String>> _guidelineOneSided = {
  'testing.md': {
    '### Before measuring exec conformance: upgrade, then record the version':
        'DGUC6 is an exec-only hazard: exec resolves tom_d4rt_ast from '
        'pub.dev with a gitignored lock, so which interpreter a run measured '
        'is per-machine state. tom_d4rt resolves nothing and the section '
        'would be false there.',
  },
};

/// Every `_copilot_guidelines/*.md` in [packageRoot], keyed by file name.
///
/// The guidelines are flat, so a name is enough — unlike the test corpora,
/// which need relative paths.
Map<String, File> _guidelineFiles(Directory packageRoot) {
  final dir = Directory('${packageRoot.path}/_copilot_guidelines');
  if (!dir.existsSync()) return {};
  return {
    for (final f in dir.listSync().whereType<File>())
      if (f.path.endsWith('.md')) f.uri.pathSegments.last: f,
  };
}

/// Rewrites the package self-reference so the two copies can be compared.
///
/// Deliberately NOT [_normalise]: that one maps specific library paths a test
/// imports, and a guideline quotes the package by PREFIX in prose and fenced
/// examples — `package:tom_d4rt/tom_d4rt.dart` among them, which `_normalise`
/// does not carry. Widening `_normalise` to cover it would change what
/// `F-SCC6-4` considers identical, which is a different guard's question.
String _normaliseGuideline(String source) => source
    .replaceAll('package:tom_d4rt_exec/', '@PKG@/')
    .replaceAll('package:tom_d4rt/', '@PKG@/');

/// Splits markdown into `heading -> section text`, the preamble under `''`.
///
/// FENCED BLOCKS ARE NOT SCANNED FOR HEADINGS. A `#` at the start of a line
/// inside a ``` fence is a shell comment, and `testing.md` is full of them —
/// the first version of this splitter read `# Run tests with dart test
/// directly` out of a bash example as a level-1 heading, which shifted every
/// section boundary after it and made the guard report a divergence that did
/// not exist. It reported it on its very first run, which is the only reason
/// it was caught before being written down as a finding.
Map<String, String> _sections(String source) {
  final out = <String, String>{};
  var heading = '';
  var inFence = false;
  final body = StringBuffer();
  for (final line in source.split('\n')) {
    if (line.trimLeft().startsWith('```')) inFence = !inFence;
    if (!inFence && line.startsWith('#')) {
      out[heading] = body.toString();
      body.clear();
      heading = line;
    } else {
      body.writeln(line);
    }
  }
  out[heading] = body.toString();
  return {for (final e in out.entries) e.key: _trimSectionTail(e.value)};
}

/// Drops trailing blank lines and a trailing `---` from a section body.
///
/// A horizontal rule is punctuation between sections, not instruction, and it
/// belongs to whichever section happens to come last before it. Inserting a
/// new section therefore MOVES the rule from one section to another without
/// anything having been edited — which is exactly what exec's DGUC6 section
/// did to `## Running Tests`, and the only difference the comparison found
/// there. Trailing only: a rule in the middle of a body is left alone, and so
/// is anything inside a fence, because a fence is never at a section's tail.
String _trimSectionTail(String body) {
  final lines = body.split('\n');
  while (lines.isNotEmpty &&
      (lines.last.trim().isEmpty || lines.last.trim() == '---')) {
    lines.removeLast();
  }
  return lines.join('\n');
}

final RegExp _markerPattern = RegExp(
  r'^//\s*(KNOWN-GAP\([^)]*\)|WONT-FIX)\s*:',
);

/// Collects `test(...)` / `group(...)` names that claim an expected failure.
///
/// SCD53 / F-SCC6-6. Two different rules, and the asymmetry is measured rather
/// than stylistic:
///
///   * `(FAIL)` is the outcome suffix and is rejected in EITHER kind of name.
///   * `SHOULD FAIL` only means something in a GROUP name. A test described
///     "... should fail gracefully" is prose about what the code under test
///     does, and `I-TYPE-29` in the reference tree is exactly that — an early
///     version of this check flagged it.
class _ExpectedFailureCollector extends RecursiveAstVisitor<void> {
  _ExpectedFailureCollector(this.file);
  final String file;
  final labelled = <String>[];
  int namesRead = 0;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final kind = node.methodName.name;
    if (kind == 'test' || kind == 'group') {
      final args = node.argumentList.arguments;
      if (args.isNotEmpty && args.first is StringLiteral) {
        // `stringValue` joins adjacent literals — which is how most names here
        // are written — and returns null for an interpolated one.
        final value = (args.first as StringLiteral).stringValue;
        if (value != null) {
          namesRead++;
          if (value.contains('(FAIL)') ||
              (kind == 'group' &&
                  value.toUpperCase().contains('SHOULD FAIL'))) {
            labelled.add('$file\n      $kind: $value');
          }
        }
      }
    }
    super.visitMethodInvocation(node);
  }
}

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

/// Files under `tom_d4rt_ast/lib` that differ between the PUBLISHED copy exec
/// resolves and the sibling working tree, and why that is currently accepted.
///
/// SCD21. Keyed by the path relative to `lib/`. An entry is a statement that
/// the difference cannot change what this suite measures; anything else belongs
/// in a publish, not here. F-SCC80-3 fails on drift that is not listed AND on
/// an entry that no longer differs, so the register cannot quietly outlive its
/// cause the way the pinned floors in [_divergentBaseline] once did.
const Map<String, String> _astWorkingTreeDrift = {
  // scd14_aicx rewrote two barrel docstrings: `tom_d4rt_ast.dart` claimed the
  // barrel "adds the D4rt runtime" when it re-exports the model alone, and
  // `ast.dart` pointed readers at an `ast_converter.dart` this package does not
  // have. Both are doc comments — no export list, no declaration and no body
  // changed — so nothing an interpreter does differs between the two copies.
  // The change was deliberately not published: it is prose, and a release adds
  // a version every twin's lock then falls behind. These entries retire
  // themselves at the next tom_d4rt_ast release, and this case says so by
  // failing if they are still listed once the copies agree.
  'ast.dart': 'doc comment only (scd14_aicx), unpublished',
  'tom_d4rt_ast.dart': 'doc comment only (scd14_aicx), unpublished',
};

/// The directory exec's own package config resolves `tom_d4rt_ast` to.
///
/// The package CONFIG rather than `pubspec.lock`: the lock records what a
/// resolve decided, the config is what the runtime actually loads, and a path
/// dependency or a `pubspec_overrides.yaml` moves the second without the first
/// saying anything this file could notice.
Directory? _resolvedAstRoot() {
  final config = File('.dart_tool/package_config.json');
  if (!config.existsSync()) return null;
  final decoded = jsonDecode(config.readAsStringSync()) as Map<String, dynamic>;
  for (final entry in (decoded['packages'] as List<dynamic>)) {
    final package = entry as Map<String, dynamic>;
    if (package['name'] != 'tom_d4rt_ast') continue;
    final rootUri = package['rootUri'] as String;
    final uri = Uri.parse(rootUri);
    final path = uri.hasScheme
        ? uri.toFilePath()
        : File('.dart_tool/$rootUri').absolute.path;
    return Directory(Directory(path).absolute.path);
  }
  return null;
}

/// Every file under [root], keyed by its path relative to [root].
Map<String, File> _filesUnder(Directory root) {
  final prefix = '${root.path}${Platform.pathSeparator}';
  final result = <String, File>{};
  if (!root.existsSync()) return result;
  for (final entity in root.listSync(recursive: true)) {
    if (entity is! File) continue;
    result[entity.path
            .substring(prefix.length)
            .replaceAll(Platform.pathSeparator, '/')] =
        entity;
  }
  return result;
}

/// `test(` declarations in [source], ignoring comments.
///
/// Deliberately not a bare `test(` search: prose in a doc comment matches one,
/// and the first version of F-SCC6-6 reported a 5/4 partial in
/// `pool_security_test.dart` whose fifth "case" was the sentence "The security
/// test (b) therefore probes the warm parent's real exposure surface". Anchoring
/// to the start of a line after stripping comments is enough — every case in
/// both corpora is written that way, and a declaration that is not would be
/// unreadable for other reasons.
int _countCases(String source) {
  final withoutBlocks = source.replaceAll(
    RegExp(r'/\*.*?\*/', dotAll: true),
    '',
  );
  final withoutLines = withoutBlocks
      .split('\n')
      .map((line) => line.replaceAll(RegExp(r'//.*'), ''))
      .join('\n');
  return RegExp(
    r'^\s*test\s*\(',
    multiLine: true,
  ).allMatches(withoutLines).length;
}

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
              // The sentinel for a file with no twin at all. Its `layer` is
              // inert — `copierUncovered` reads `where`, which is empty here,
              // so it is false whatever this says — but the field is required
              // and a required field wants a deliberate value. `script` is the
              // conservative one: if it ever stopped being inert it would
              // over-report rather than hide a gap.
              const _Coverage(
                '',
                'no twin in either tree',
                layer: _Layer.script,
              ),
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
      final unexplained = _coveredElsewhere.entries
          .where((e) => e.value.isUnexplainedPartial)
          .toList();
      var deficit = 0;
      for (final e in unexplained) {
        deficit += e.value.refCases - e.value.twinCases;
      }
      printOnFailure(
        _coveredElsewhere.entries
            .where((e) => e.value.isPartial)
            .map(
              (e) =>
                  '${e.key}: ${e.value.refCases} cases vs '
                  '${e.value.twinCases} in ${e.value.where}'
                  '${e.value.whyPartial == null ? '"'
                            "'  <- UNEXPLAINED'"
                            '"' : '"'
                            "''"
                            '"'}',
            )
            .join('\n'),
      );
      expect(
        unexplained.length,
        lessThanOrEqualTo(_partialTwinBudget),
        reason:
            'More twins are short by an UNEXPLAINED margin than the budget '
            'of $_partialTwinBudget allows (currently ${unexplained.length} '
            'files, $deficit cases short). A partial twin passes the presence '
            'check while leaving assertions unrun on the analyzer-free line. '
            'Either port the missing cases, or -- if the twin is a different '
            'KIND of test rather than the same one with cases dropped -- give '
            'its entry a `whyPartial` saying so. Do not equalise the counts: a '
            'count edited to silence this is a lie the next reader cannot '
            'detect, which is what F-SCC6-6 checks.',
      );
    });

    test('F-SCC6-6: the recorded case counts still match the files '
        '[2026-09-12] (PASS)', () {
      // F-SCC6-3 reasons entirely from `refCases` / `twinCases`, which are
      // hand-written. Nothing re-read them for five weeks and two had rotted:
      // `environment_lazy_bridge` said 17/17 while both sides had grown to
      // 24/24, and `io_reexport_visibility` said 10/6 — reported as a
      // four-case deficit — while the files said 8/11, the twin OVER-covering.
      // A deficit computed from stale numbers is not a measurement, and the
      // todo that prompted this warned that an edited count is "a lie the next
      // reader cannot detect". So the numbers are now checked against the code
      // they describe.
      //
      // Counting is `^\s*test(` over the source with comments stripped, which
      // is fussier than it looks: a plain `test(` search counts the prose in
      // `pool_security_test.dart`'s header ("The security test (b) therefore
      // probes...") and reports a 5/4 partial that does not exist. A checker
      // whose first finding is imaginary gets switched off.
      final drift = <String>[];
      for (final entry in _coveredElsewhere.entries) {
        final coverage = entry.value;
        if (coverage.refCases == 0 && coverage.twinCases == 0) continue;

        final refFile = File('${refTests.path}/${entry.key}');
        final parts = coverage.where.split(':');
        final twinFile = File(
          parts.first == 'exec'
              ? '${execTests.path}/${parts.last}'
              : '${astTests.path}/${parts.last}',
        );
        if (!refFile.existsSync() || !twinFile.existsSync()) {
          drift.add('${entry.key}: a file named by this entry does not exist');
          continue;
        }
        final actualRef = _countCases(refFile.readAsStringSync());
        final actualTwin = _countCases(twinFile.readAsStringSync());
        if (actualRef != coverage.refCases ||
            actualTwin != coverage.twinCases) {
          drift.add(
            '${entry.key}: recorded ${coverage.refCases}/${coverage.twinCases}, '
            'files say $actualRef/$actualTwin (${coverage.where})',
          );
        }
      }

      expect(
        drift,
        isEmpty,
        reason:
            'These entries describe case counts the files no longer have, so '
            'every deficit computed from them is guesswork:\n'
            '${drift.join('\n')}\n\n'
            'Update the numbers to what the files say. If that turns an entry '
            'partial, decide which kind it is — port the cases, or record a '
            '`whyPartial` — rather than leaving the count wrong to keep '
            'F-SCC6-3 quiet.',
      );
    });

    test('F-SCC6-7: script-level suites resting on an ast twin are named '
        '[2026-09-12] (PASS)', () {
      // Informational, like F-SCC6-3. The exemptions are sound for what they
      // claim — the ast twin really does exercise the interpreter — and silent
      // about the one layer exec alone owns. Naming them keeps that silence
      // visible instead of letting `covered elsewhere` read as covered
      // everywhere.
      final gaps = _coveredElsewhere.entries
          .where((e) => e.value.copierUncovered)
          .toList();
      printOnFailure(
        gaps.map((e) => '${e.key} -> ${e.value.where}').join('\n'),
      );
      expect(
        gaps.length,
        lessThanOrEqualTo(_copierGapBudget),
        reason:
            'More script-level suites now rest on an ast twin alone than the '
            'budget of $_copierGapBudget allows (currently ${gaps.length}). '
            'Each runs source, so its twin cannot exercise the '
            'analyzer-to-mirror copy — a node copied wrongly yields a mirror '
            'tree that interprets consistently and wrongly, which no ast test '
            'can see. Port one, or raise the budget and say in the entry why '
            'this suite is not worth porting.',
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

    test('F-SCC6-5: every pinned known gap names an owner and exists in every '
        'recorded copy [2026-09-04] (PASS)', () {
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

      // Part three — the RECORDED pairings (SCD54). Part two compares files at
      // the same relative path in tom_d4rt and exec, which misses two kinds of
      // twin entirely:
      //
      //   * a twin in `tom_d4rt_ast`. This guard's own header names that tree
      //     as one of the three it compares, and `_coveredElsewhere` records
      //     reference files whose ONLY counterpart is an ast one — sometimes
      //     under a different name. A pin in such a reference file had a twin
      //     nothing looked at, in either direction.
      //   * a RENAMED exec twin. `dfub1_filesystem_import_basepath_test.dart`
      //     is covered by `exec:dgub3_filesystem_import_basepath_test.dart`;
      //     different path, so part two never pairs them either.
      //
      // This is the scb7 defect one tree wider: that pin shipped naming only
      // the tom_d4rt copy, and would have turned its exec twin red. The same
      // mistake against a recorded twin was invisible.
      //
      // PARTIAL TWINS ARE NOT TREATED AS FULL ONES, and the asymmetry is the
      // design. A partial twin carries fewer CASES by definition, so a pin the
      // reference has and it does not may be perfectly correct — the case it
      // describes is one of the ones the twin never carried. The counts in the
      // entry cannot say WHICH cases are missing, so demanding an exact match
      // would fail on legitimate entries. So:
      //
      //   twin has a marker the reference lacks   -> always wrong, always fails
      //   full twin missing the reference's pin   -> wrong, fails
      //   partial twin missing it                 -> allowed, but only if the
      //                                              entry says why it is small
      //
      // The last line reuses `whyPartial` rather than inventing a budget,
      // which is the same argument SCD19 made when it added that field: a
      // reason living on the entry cannot drift away from the thing it
      // excuses, and a global counter saying "eight partials are fine" does
      // not bind which eight.
      //
      // EVERY BRANCH WAS WATCHED FAIL, and here that is not a formality: the
      // repo holds exactly ONE pin today (a `WONT-FIX` in
      // `limitations_and_bugs_test.dart`, present in both tom_d4rt and exec,
      // and in no recorded pairing), and `tom_d4rt_ast` holds none at all. So
      // this code lands green over an empty corpus and the controls are the
      // only evidence it works. Measured 2026-09-12 by injecting a
      // `KNOWN-GAP(scd54-control)` marker:
      //
      //   | Injected into                                  | Fires            |
      //   | ---------------------------------------------- | ---------------- |
      //   | ref of a full ast pairing (`unwrap_as`)         | pinned only in tom_d4rt |
      //   | TWIN of that pairing                            | pinned only in the twin |
      //   | ref of a RENAMED exec pairing (`dfub1`)         | pinned only in tom_d4rt |
      //   | ref of a partial with no `whyPartial` (`scc28`) | shortfall, with counts |
      //   | ref of a partial WITH `whyPartial` (`dgub5`)    | nothing          |
      //
      // The first row also confirms what SCD54 asked for specifically: the
      // message names BOTH files, so a reader knows where to put the mirror.
      // The last row is the design: `dgub5` carries 3 of its reference's 6
      // cases and says why, so a pin it does not have is not a finding.
      final pairMismatched = <String>[];
      final unexplainedShortfall = <String>[];
      final execByPath = _testFiles(execTests);
      final astByPath = _testFiles(astTests);

      _coveredElsewhere.forEach((refPath, coverage) {
        final refFile = ref[refPath];
        // A reference file that is gone, or a claim pointing nowhere, is
        // F-SCC6-1's and F-SCC6-7's finding. Reporting it here too would name
        // one event twice with two different remedies.
        if (refFile == null) return;
        final where = coverage.where;
        final target = where.substring(where.indexOf(':') + 1);
        final twinFile = where.startsWith('exec:')
            ? execByPath[target]
            : astByPath[target];
        if (twinFile == null) return;

        // Sets, not lists: the question is which pins EXIST on each side, and
        // two copies of one marker in a file is not a distinction this guard
        // has any opinion about.
        final refMarkers = _markers(refFile.readAsStringSync()).toSet();
        final twinMarkers = _markers(twinFile.readAsStringSync()).toSet();

        final onlyTwin = (twinMarkers.difference(refMarkers).toList())..sort();
        final onlyRef = (refMarkers.difference(twinMarkers).toList())..sort();

        if (onlyTwin.isNotEmpty) {
          pairMismatched.add(
            '$refPath -> $where: pinned only in the twin '
            '[${onlyTwin.join(', ')}]',
          );
        }
        if (onlyRef.isEmpty) return;
        if (!coverage.isPartial) {
          pairMismatched.add(
            '$refPath -> $where: pinned only in tom_d4rt '
            '[${onlyRef.join(', ')}]',
          );
        } else if (coverage.whyPartial == null) {
          unexplainedShortfall.add(
            '$refPath -> $where (${coverage.twinCases} of '
            '${coverage.refCases} cases): [${onlyRef.join(', ')}]',
          );
        }
      });
      pairMismatched.sort();
      unexplainedShortfall.sort();

      expect(
        pairMismatched,
        isEmpty,
        reason:
            'A pinned gap exists on one side of a recorded pairing and not '
            'the other:\n  ${pairMismatched.join('\n  ')}\n\n'
            'These files are twins by record, not by path, so nothing else '
            'compares them. Mirror the pin, or delete it from both sides in '
            'the same change.',
      );

      expect(
        unexplainedShortfall,
        isEmpty,
        reason:
            'A partial twin is missing a pin its reference carries, and the '
            '_coveredElsewhere entry does not say why it is smaller:\n'
            '  ${unexplainedShortfall.join('\n  ')}\n\n'
            'If the twin never carried the case the pin describes, set '
            '`whyPartial` on the entry saying so — that is what the field is '
            'for, and it puts the reason where a reader of the entry will '
            'find it. If the twin DOES carry the case, the pin is simply '
            'missing: mirror it.',
      );
    });

    test('F-SCC6-8: no test name claims it is expected to fail '
        '[2026-09-12] (PASS)', () {
      // SCD53. Numbered 8 rather than 6: SCD53 asked for "F-SCC6-6", but 6 and
      // 7 were taken between the todo being written and being executed, and an
      // id that already means something else is worse than a gap in the
      // sequence.
      //
      // The id convention encodes the EXPECTED outcome in the name, and
      // under the convention SCC15 adopted no case in these suites is expected
      // to fail: a pinned gap PASSES, by asserting the broken behaviour. So the
      // `(FAIL)` suffix has no legitimate use and is rejected outright.
      //
      // It was not rejected before, and the labels rotted exactly as you would
      // expect. Measured 2026-09-12: 204 names still carried the suffix across
      // four packages while every one of those suites ran green — 46 in
      // `tom_d4rt_exec`, 120 in `tom_d4rt_generator`, 38 in
      // `tom_ast_generator`. Not one of the 204 was failing, so all 204 labels
      // were false. (SCC15 found the same defect in three file pairs and fixed
      // it there; SCD50 cleared `tom_d4rt` and `tom_d4rt_ast`, which is why
      // they are at zero.)
      //
      // NOT COSMETIC: testkit parses the suffix into `testlog/baseline_*.csv`,
      // so a stale label makes a healthy case read as a sanctioned failure to
      // anyone reading the baseline instead of running the suite.
      //
      // WHY IT PARSES RATHER THAN GREPS. A text scan cannot tell a label from
      // a mention, and both exist here: this very comment writes the suffix a
      // dozen times, and `scd50_no_expected_failures_test.dart` in the
      // reference tree contains `contains('(FAIL)')` as CODE. An anchored
      // regex — suffix followed by a closing quote — still matches that
      // second case, which is how the sweep nearly disarmed SCD50's guard.
      // Reading the argument of `test(...)` / `group(...)` cannot.
      //
      // THE FOUR TREES ARE NOT THE USUAL TWO. The rest of this group compares
      // the reference and exec corpora; this walks the generator packages as
      // well, because that is where 158 of the 204 lived. They are siblings in
      // the same repository, so the reach costs nothing and a guard covering
      // 23% of the corpus it was written for would be decorative.
      //
      // IF A CASE REALLY PINS BROKEN BEHAVIOUR, it needs a
      // `KNOWN-GAP(<todo-id>)` or `WONT-FIX` marker in the comment above it —
      // which F-SCC6-5 above then holds to both trees — not a label in the
      // name saying the opposite of what the case does.
      final labelled = <String>[];
      var namesRead = 0;
      for (final root in const [
        'test',
        '../tom_d4rt/test',
        '../tom_d4rt_generator/test',
        '../tom_ast_generator/test',
      ]) {
        final dir = Directory(root);
        if (!dir.existsSync()) continue;
        for (final file
            in dir
                .listSync(recursive: true)
                .whereType<File>()
                .where((f) => f.path.endsWith('.dart'))) {
          final unit = parseString(
            content: file.readAsStringSync(),
            featureSet: FeatureSet.latestLanguageVersion(),
            throwIfDiagnostics: false,
          ).unit;
          final collector = _ExpectedFailureCollector(file.path);
          unit.accept(collector);
          namesRead += collector.namesRead;
          labelled.addAll(collector.labelled);
        }
      }
      labelled.sort();

      // The floor. Every assertion below is an emptiness check, and a walk
      // that parsed nothing satisfies it — the same trap F-SCB24-2 exists for,
      // where a scan read 0 of 205 names and its guard passed. Measured
      // 2026-09-12 at 9674 names across the four trees — read off a
      // deliberately-broken floor rather than added up from a scan, which is
      // how the first figure written here came out one short: the scan
      // predated this very test, and a `test(...)` is itself a name.
      //
      // EACH BRANCH HAS BEEN SEEN TO FAIL. The Fires column is observed:
      //
      //   | Injected fault                                        | Fires   |
      //   | ----------------------------------------------------- | ------- |
      //   | a `(PASS)` flipped back in exec                        | yes     |
      //   | ... in `tom_d4rt_generator`                            | yes     |
      //   | ... in `tom_ast_generator`                             | yes     |
      //   | a group renamed to `SHOULD FAIL` in `tom_d4rt`         | yes     |
      //   | a TEST named "... should fail gracefully" (I-TYPE-29)  | no      |
      //   | the floor raised above the corpus                      | yes     |
      //
      // The fifth row is the one worth keeping: it is real, it is in the
      // reference tree, and an earlier version of this check flagged it.
      expect(
        namesRead,
        greaterThan(3000),
        reason:
            'Read only $namesRead test/group names across the four trees, '
            'which is too few to be the real corpus — so the emptiness check '
            'below is not saying anything. The likeliest cause is that '
            '`test(...)` stopped parsing as a MethodInvocation with a literal '
            'first argument.',
      );

      expect(
        labelled,
        isEmpty,
        reason:
            'These names claim the case is expected to fail:\n'
            '  ${labelled.join('\n  ')}\n\n'
            'If the case PASSES, the label is stale — relabel it `(PASS)`. '
            'That is what 204 of them were on 2026-09-12.\n'
            'If it genuinely pins broken behaviour it passes for that reason, '
            'and belongs behind a `KNOWN-GAP(<todo-id>)` or `WONT-FIX` marker '
            'in the comment above it, not behind a label in its name.',
      );
    });

    test('F-SCC6-9: the shared guideline files still agree '
        '[2026-09-12] (PASS)', () {
      // SCD55. `F-SCC6-4` byte-compares every `_test.dart` present in both
      // trees, so a hand-edit to one copy fails loudly. The guideline
      // documents sitting next to them have the same shape and had no check
      // at all — they were kept in step by memory, and SCC15 mirrored its
      // second copy with `sed` precisely because nothing would have caught
      // forgetting.
      //
      // THE FAILURE MODE IS WORSE HERE THAN FOR TESTS, not better: a stale
      // test at least runs, while a stale guideline is read as instruction
      // and produces wrong work from it.
      //
      // COMPARED BY SECTION, not by file. SCD55 measured the six shared files
      // on 2026-09-04 and found five identical modulo one import line; by
      // 2026-09-12 `testing.md` had grown a 33-line exec-only section about
      // DGUC6, which is correct content that the file-level comparison the
      // todo proposed would have had to exempt wholesale — losing the guard
      // on the most-edited file of the six. Sections present on one side only
      // are therefore listed in [_guidelineOneSided] with their reason, and
      // everything else must match.
      //
      // EVERY BRANCH WAS WATCHED FAIL. The Fires column is observed:
      //
      //   | Injected fault                                  | Fires          |
      //   | ------------------------------------------------ | -------------- |
      //   | a shared section edited in one tree only          | sections differ|
      //   | a NEW one-sided section, unrecorded               | one tree only  |
      //   | a recorded one-sided section mirrored into both   | record stale   |
      //   | a recorded heading present in neither tree        | record stale   |
      //   | a NEW one-sided FILE, unrecorded                  | files one-sided|
      //   | a shared file DELETED from one tree               | files one-sided|
      //   | a recorded one-sided FILE mirrored into both      | record stale   |
      //   | the guidelines folder pointed at a missing path   | floor          |
      //
      // The "shared file deleted" row is why the file-level check exists at
      // all. SCD55 asked only for the shared files to be compared, which walks
      // the names present in BOTH — so deleting `build.md` from one tree would
      // have said nothing. That is the same forgotten-mirror shape the section
      // check catches, one level up, and it costs a two-entry record.
      //
      // IT ALSO FAILED TWICE ON ITS OWN BUGS BEFORE IT PASSED, both of which
      // are now handled and commented where they bit: `#` inside a fenced
      // block is a shell comment and not a heading, and a trailing `---` is
      // punctuation that MOVES when a section is inserted above it. Both
      // produced a confident report of drift that did not exist, which is the
      // failure mode a guard like this has to be most careful about — a false
      // report here sends someone to edit a document that was correct.
      final mismatched = <String>[];
      final unrecorded = <String>[];
      final staleRecord = <String>[];

      final refGuides = _guidelineFiles(Directory('../tom_d4rt'));
      final execGuides = _guidelineFiles(Directory('.'));

      // The floor. Everything below is an emptiness check over a walk, and a
      // walk that found no files satisfies all of them.
      expect(
        refGuides.keys.where(execGuides.containsKey).length,
        greaterThanOrEqualTo(4),
        reason:
            'Found only ${refGuides.keys.where(execGuides.containsKey).length} '
            'shared guideline files. That is not a finding about drift — the '
            'walk did not run. Measured 2026-09-12 at 6 shared of 7 and 7.',
      );

      final oneSidedFiles = <String>[];
      for (final name in {...refGuides.keys, ...execGuides.keys}) {
        final inRef = refGuides.containsKey(name);
        final inExec = execGuides.containsKey(name);
        if (inRef && inExec) continue;
        if (_guidelineOneSidedFiles.containsKey(name)) continue;
        oneSidedFiles.add('$name (only in ${inRef ? 'tom_d4rt' : 'exec'})');
      }
      for (final name in _guidelineOneSidedFiles.keys) {
        if (refGuides.containsKey(name) && execGuides.containsKey(name)) {
          staleRecord.add(
            '$name: recorded as one-sided, present in both trees',
          );
        } else if (!refGuides.containsKey(name) &&
            !execGuides.containsKey(name)) {
          staleRecord.add('$name: recorded as one-sided, present in neither');
        }
      }
      oneSidedFiles.sort();
      expect(
        oneSidedFiles,
        isEmpty,
        reason:
            'These guideline files exist in one tree only:\n'
            '  ${oneSidedFiles.join('\n  ')}\n\n'
            'A guideline deleted from one copy, or added to one copy, is the '
            'same forgotten mirror the section check catches — one level up. '
            'Mirror the file, or record it in _guidelineOneSidedFiles with '
            'the reason it is true of one package only.',
      );

      for (final name in refGuides.keys.where(execGuides.containsKey)) {
        if (_guidelineExempt.containsKey(name)) continue;
        final refSections = _sections(
          _normaliseGuideline(refGuides[name]!.readAsStringSync()),
        );
        final execSections = _sections(
          _normaliseGuideline(execGuides[name]!.readAsStringSync()),
        );
        final recorded = _guidelineOneSided[name] ?? const <String, String>{};

        for (final heading in {...refSections.keys, ...execSections.keys}) {
          final inRef = refSections.containsKey(heading);
          final inExec = execSections.containsKey(heading);
          if (inRef && inExec) {
            if (refSections[heading] != execSections[heading]) {
              mismatched.add(
                '$name ${heading.isEmpty ? '(preamble)' : heading}',
              );
            }
            if (recorded.containsKey(heading)) {
              staleRecord.add(
                '$name $heading: recorded as one-sided, present in both',
              );
            }
          } else if (!recorded.containsKey(heading)) {
            unrecorded.add(
              '$name ${heading.isEmpty ? '(preamble)' : heading} '
              '(only in ${inRef ? 'tom_d4rt' : 'exec'})',
            );
          }
        }
        for (final heading in recorded.keys) {
          if (!refSections.containsKey(heading) &&
              !execSections.containsKey(heading)) {
            staleRecord.add('$name $heading: recorded, present in neither');
          }
        }
      }
      mismatched.sort();
      unrecorded.sort();
      staleRecord.sort();

      expect(
        mismatched,
        isEmpty,
        reason:
            'These guideline sections exist in both trees and differ:\n'
            '  ${mismatched.join('\n  ')}\n\n'
            'The two copies are hand-maintained twins. Mirror the edit. Do '
            'NOT reach for a sync script — copying one line is not the part '
            'that needs automating, noticing is, and that is this test.',
      );

      expect(
        unrecorded,
        isEmpty,
        reason:
            'These guideline sections exist in one tree only:\n'
            '  ${unrecorded.join('\n  ')}\n\n'
            'That is what a forgotten mirror looks like, so it is not '
            'tolerated by default. Either mirror the section, or — if it is '
            'genuinely true of one package only, as the DGUC6 section is of '
            'exec — add it to _guidelineOneSided with the reason.',
      );

      expect(
        staleRecord,
        isEmpty,
        reason:
            'These _guidelineOneSided entries no longer describe reality:\n'
            '  ${staleRecord.join('\n  ')}\n\n'
            'A section recorded as one-sided that is now in both trees, or in '
            'neither, is a record outliving its cause — delete the entry. '
            'Without this the list would only ever grow, and an exemption '
            'nobody prunes stops being an exception and becomes a hole.',
      );
    });
  }, skip: skipReason);

  group('SCC80: the suite records which interpreter it measured', () {
    test('F-SCC80-1: the resolved tom_d4rt_ast version is readable, printed '
        'and not behind the declared floor [2026-09-07]', () {
      final floor = _execAstFloor();
      final resolved = _execAstResolved();

      // The whole point of this case, and the load-bearing half of it. Every
      // exec conformance run now carries the number it certified in its own
      // log, so no future baseline can be read as a statement about "the
      // interpreter" in the abstract.
      //
      // The expect() below is a backstop, not the guard: measured 2026-09-07 by
      // rewriting the lock to a stale 0.42.0, `dart test` re-resolved it back
      // to 0.55.0 before this file ran, so pub repairs the fault before the
      // assertion can see it. With a caret constraint it cannot fire at all.
      // Do not read a green F-SCC80-1 as evidence the lock was checked — read
      // the printed number.
      // ignore: avoid_print
      print(
        'exec conformance measured against tom_d4rt_ast $resolved '
        '(pubspec floor $floor)',
      );

      expect(
        _versionExceeds(floor, resolved),
        isFalse,
        reason:
            'pubspec.lock resolves tom_d4rt_ast $resolved, which is BEHIND the '
            '$floor this package declares. Every result in this run therefore '
            'describes an interpreter the constraint itself calls too old. Run '
            '`dart pub upgrade`.',
      );
    });

    test('F-SCC80-3: the interpreter exec resolves is the one in the working '
        'tree [2026-09-12] (PASS)', () {
      // DGUC6 in one assertion. Exec resolves tom_d4rt_ast FROM PUB.DEV, so
      // every green run here certifies the PUBLISHED interpreter — and every
      // port into this suite, and every result quoted as evidence that a
      // mirrored fix works, is conditional on the published copy and the tree
      // being edited being the same bytes.
      //
      // That condition used to be checked by a person remembering to run
      // `diff -rq` and by a paragraph asking the next person to do the same.
      // When the trees agree a port means what it claims; when they do not, the
      // same port lands, passes, and certifies a version nobody runs. The two
      // outcomes are indistinguishable in the output, which is exactly the
      // failure a guard is meant to remove rather than document.
      final resolved = _resolvedAstRoot();
      expect(
        resolved,
        isNotNull,
        reason:
            'Could not read tom_d4rt_ast out of '
            '.dart_tool/package_config.json, so which interpreter this suite '
            'measures is unknown. Run `dart pub get`.',
      );

      final sibling = Directory('../tom_d4rt_ast');
      if (!sibling.existsSync()) {
        // A consumer checkout, or CI without the monorepo. Absence is not
        // drift, and failing here would make the suite unusable exactly where
        // there is nothing to compare against.
        markTestSkipped(
          'no sibling ../tom_d4rt_ast to compare against; this case is about '
          'the monorepo layout',
        );
        return;
      }

      final resolvedPath = resolved!.absolute.path;
      final siblingPath = sibling.absolute.path;
      expect(
        resolvedPath,
        isNot(equals(siblingPath)),
        reason:
            'tom_d4rt_ast resolves to the sibling working tree, not to a '
            'published package. That makes this case green by making the whole '
            'suite measure the tree being edited, which ERASES the distinction '
            'it exists to expose — exec is supposed to certify what a consumer '
            'gets. A `pubspec_overrides.yaml` or a path dependency is how this '
            'happens, and the workspace rule forbids both: "NEVER fix '
            'missing-API dependency errors with path overrides or '
            'pubspec_overrides.yaml. Always publish the dependency to pub.dev '
            'first, then update the version constraint."',
      );

      final published = _filesUnder(Directory('$resolvedPath/lib'));
      final working = _filesUnder(Directory('$siblingPath/lib'));

      final differing = <String>{};
      for (final path in {...published.keys, ...working.keys}) {
        final a = published[path];
        final b = working[path];
        if (a == null || b == null) {
          differing.add('$path (present in only one copy)');
          continue;
        }
        if (a.readAsStringSync() != b.readAsStringSync()) differing.add(path);
      }

      final accepted = _astWorkingTreeDrift.keys.toSet();
      final unexplained = differing.difference(accepted).toList()..sort();
      final settled = accepted.difference(differing).toList()..sort();

      expect(
        settled,
        isEmpty,
        reason:
            'These files are listed in _astWorkingTreeDrift but no longer '
            'differ, so the register describes a drift that is gone — probably '
            'because tom_d4rt_ast was published. Remove them; a baseline '
            'nobody prunes is how a ratchet loosens.\n'
            '${settled.join('\n')}',
      );

      expect(
        unexplained,
        isEmpty,
        reason:
            'The tom_d4rt_ast this suite RESOLVES and the one in the working '
            'tree have drifted, so every result in this run describes an '
            'interpreter that is not the one being edited:\n'
            '${unexplained.join('\n')}\n\n'
            'THE REMEDY IS TO PUBLISH tom_d4rt_ast and raise this package\'s '
            'constraint. It is NOT a `pubspec_overrides.yaml` and NOT a path '
            'dependency: either makes this case green by making the suite '
            'measure the working tree, which is the one thing exec exists not '
            'to do. The workspace rule is explicit — "NEVER fix missing-API '
            'dependency errors with path overrides or pubspec_overrides.yaml. '
            'Always publish the dependency to pub.dev first, then update the '
            'version constraint."\n\n'
            'If a difference genuinely cannot change what this suite measures '
            '(a doc comment, say), add it to _astWorkingTreeDrift with the '
            'reason — and expect to remove it at the next release.',
      );
    });

    test('F-SCC80-2: the tom_d4rt_ast constraint is upper-bounded, not '
        'lower-bound-only [2026-09-07]', () {
      final pubspec = File('pubspec.yaml').readAsStringSync();
      final constraint = RegExp(
        'tom_d4rt_ast:[ ]*[\'"]?([^\'"\\n]+)',
      ).firstMatch(pubspec)?.group(1)?.trim();

      expect(
        constraint,
        isNotNull,
        reason: 'tom_d4rt_ast is not declared in pubspec.yaml.',
      );
      expect(
        constraint!.startsWith('>='),
        isFalse,
        reason:
            'tom_d4rt_ast is constrained as "$constraint" — lower-bound-only. '
            'That is the exact shape SCC80 was filed about: a pre-existing '
            'pubspec.lock satisfies such a constraint forever, so the suite '
            'keeps certifying an interpreter no fresh checkout resolves and a '
            'new publish never becomes visible here at all. Use a caret bound '
            'on the version actually certified, so moving onto a new '
            'interpreter is a deliberate edit. SCC45 is the general statement.',
      );
    });
  });

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
    test('F-SCC44-2: every recorded convergence is still true [2026-09-12] '
        '(PASS)', () {
      // SCD22 item (5). The direction a pair converged in is a finding, and a
      // finding that is not checked rots like any other. This does not — and
      // cannot — verify that the STRONGER side won: that judgement is
      // unautomatable, which is why the rule is a procedure rather than code.
      // What it verifies is that the record still describes reality, so an
      // entry cannot quietly become a statement about a pair that has since
      // drifted apart again.
      // `ref` / `exec` belong to the SCC6 group; this is a sibling group, so
      // the maps are built here rather than reached for.
      final refFiles = _testFiles(refTests);
      final execFiles = _testFiles(execTests);

      final wrong = <String>[];
      for (final entry in _convergenceLog.entries) {
        final path = entry.key;
        final refFile = refFiles[path];
        final execFile = execFiles[path];
        if (refFile == null || execFile == null) {
          wrong.add('$path: logged as converged but missing from one tree');
          continue;
        }
        if (_divergentBaseline.containsKey(path)) {
          wrong.add(
            '$path: logged as converged AND listed in _divergentBaseline — '
            'the two registers contradict each other',
          );
          continue;
        }
        if (_normalise(refFile.readAsStringSync()) !=
            _normalise(execFile.readAsStringSync())) {
          wrong.add(
            '$path: logged as converged (${entry.value.direction.name}) but '
            'the copies differ again',
          );
        }
      }

      expect(
        wrong,
        isEmpty,
        reason:
            'The convergence log no longer describes the corpus:\n'
            '${wrong.join('\n')}\n\n'
            'A pair that has drifted apart again is a NEW divergence, not a '
            'settled one: remove its log entry and either converge it afresh '
            'under the direction rule or add it to _divergentBaseline with a '
            'reason. Leaving the entry makes the pair read as a settled '
            'question.',
      );
    });
  }, skip: skipReason);
}
