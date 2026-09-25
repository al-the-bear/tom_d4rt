// REPO-WIDE GUARD (tom_d4rt_exec) — exec's suite still mirrors tom_d4rt's, file for file and case for case.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt_exec's suite
// runs and a session working elsewhere in the repo reaches none of it. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
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

import 'port_recipe.dart';
import 'sibling_trees.dart';

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
/// The original fourteen were classified by asking whether the REFERENCE file
/// runs source, with comments stripped first. That is not pedantry:
/// `bridged_enum_memo_test.dart`'s only `execute(` is inside a comment, and a
/// naive search files it as script-level and inflates this budget.
///
/// 23 -> 29: SCD200 added six at once, which is a bigger step than this ratchet
/// has taken before and needs saying why rather than just how many. They were
/// not six decisions — they were six files F-SCC6-2 had been reporting as
/// UNRECORDED, in some cases since 2026-09-06, because a red guard names its
/// backlog in the same colour whether the backlog is four files or twenty-four.
/// Recording them is what turns the census green; it does not add a gap, it
/// stops one being invisible.
///
/// Four are publish-blocked in the ordinary way — measured 2026-09-15, each
/// PASSES against the 0.113.0 working tree and fails against the 0.65.0 exec
/// resolves:
///
///   `scd70_list_coercion_test.dart`               list literals to native
///                                                 `List<int>` parameters
///   `scd64_grouping_and_null_patterns_test.dart`  parenthesised, `?` and `!`
///                                                 patterns in every context
///   `scd63_foreach_type_test.dart`                typed for-in loop variables
///   `scd62_nullable_is_test.dart`                 `is T?` and its pattern forms
///
/// The copier surface those would add is patterns and for-in — the one place
/// this list is genuinely thin, because a pattern is the construct the mirror
/// AST models most elaborately. That is an argument for sce62's node-family
/// census, not for four ports whose assertions would be made against an
/// interpreter that does not have the behaviour.
///
/// Two are NOT publish-blocked and could never be ported:
/// `scd136_closure_vs_bridged_typedef_test.dart` and
/// `scd145_unbridged_native_diagnostic_test.dart` reach their fixtures through
/// a `package:` import resolved FROM THE FILESYSTEM, and the analyzer-free line
/// has no filesystem module loader by construction — it resolves modules from a
/// pre-built bundle. Measured against the working tree they report "Filesystem
/// imports are disabled" rather than anything about the behaviour under test.
/// Their copier surface is a directive form exec's front end genuinely cannot
/// reach this way, so a port would not buy it either.
///
/// 22 -> 23: SCD121 added `scd121_var_decl_multi_await_test.dart`, which runs
/// source to ask how many times a script's `next()` is called while a
/// multi-await initializer resumes. Exec resolves tom_d4rt_ast 0.65.0 against a
/// 0.94.0 tree, so a port would assert the fix against an interpreter that
/// binds the first awaited value and drops the rest. The copier surface it
/// would have added is a variable declaration with a binary or interpolated
/// initializer over awaits, which the corpus copies on every run.
///
/// 21 -> 22: SCD119 added `bridge/scd119_interpreted_proxy_binding_test.dart`,
/// which runs source to ask whether a native proxy binds to a parameter
/// declared as the interpreted class it stands for. Exec resolves tom_d4rt_ast
/// 0.65.0 against a 0.93.0 tree, so a port would assert the fix against an
/// interpreter that rejects it. The copier surface it would have added is a
/// class declaration with an `extends` clause, a typed simple formal parameter
/// and an instance creation — all of which the corpus copies on every run, and
/// all of which the hand-built ast twin constructs directly.
///
/// 20 -> 21: SCD100 added `scd100_type_alias_resolution_test.dart`. Exec
/// resolves tom_d4rt_ast from pub.dev, where a typedef still binds nothing, so
/// a port would assert alias resolution against an interpreter without it.
///
/// 19 -> 20: SCD99 added `scd99_runtimetype_reporting_test.dart`. Exec resolves
/// tom_d4rt_ast from pub.dev, which still answers `false` for
/// `x.runtimeType == SomeType`, so a port would assert the fix against an
/// interpreter that does not have it.
///
/// 18 -> 19: SCD98 added `scd98_bridged_value_representation_test.dart`. Exec
/// resolves tom_d4rt_ast from pub.dev, which still wraps constructor results,
/// so a port would assert the converged representation against an interpreter
/// that has not converged.
///
/// 17 -> 18: SCD96 added `scd96_host_facing_error_unwrap_test.dart`. Exec's
/// lock holds tom_d4rt_ast 0.65.0 against a 0.89.0 tree, so a port would state
/// the fixed behaviour against an interpreter that does not have the fix.
///
/// 16 -> 17: SCD94 added `scd94_sdk_type_nameability_test.dart`. Two of its
/// cases scan both trees' `core/error.dart`, which exec does not have -- it
/// resolves the twin from pub.dev -- so a port here could not make the
/// comparison at all, let alone make it against the working tree.
///
/// 15 -> 16: SCD93 added `scd93_native_operator_guards_test.dart`, which runs
/// source to compare what d4rt throws against what the SDK throws. Same reason
/// as SCD92 below: a copy here would state the swept behaviour against the
/// PUBLISHED tom_d4rt_ast. The copier surface it would have added is binary
/// expressions and index expressions over literals, which the corpus copies on
/// every run.
///
/// 14 -> 15: SCD92 added `scd92_applied_parameter_type_test.dart`, which runs
/// source to ask which programs a binding check accepts. Porting it would state
/// the new behaviour against the PUBLISHED tom_d4rt_ast, so it would go red
/// until the release carrying the fix lands and then measure the release rather
/// than the tree — the same reason its own entry gives. The copier surface it
/// would have added is list, set and map literals with type arguments, which
/// the corpus already copies on every run.
///
/// 32 -> 33: SCE67 added `sce67_missing_member_catchable_test.dart`, which runs
/// source to ask what an interpreted `on NoSuchMethodError` clause catches.
/// Porting it CANNOT pass today: it asserts the fix that makes a missing getter
/// catchable, and exec resolves the 0.65.0 that predates it — so the port would
/// go red until the release lands and then measure the release rather than the
/// tree. Its ast twin holds the half that does not need a parser. The copier
/// surface a port would have added is member access and try/catch over string
/// literals, which the corpus copies on every run.
/// 33 -> 34: SCE113 added `sce113_function_apply_symbol_keys_test.dart`, which
/// runs source to ask which key type `Function.apply` accepts for its named
/// arguments. Exec resolves tom_d4rt_ast from pub.dev, where the adapter still
/// reads `Map<String, Object?>`, so a port would assert the SDK's Symbol keys
/// against an interpreter that rejects them. Its ast twin holds the mechanism.
/// The copier surface a port would have added is symbol literals as map keys,
/// which nothing else here covers — the corpus copies map literals on every
/// run, but not with a `SymbolLiteral` key.
///
/// 34 -> 35: SCE114 added `sce114_transform_argument_test.dart`, which runs
/// source to ask which argument shapes the four `transform` adapters accept.
/// Exec resolves tom_d4rt_ast from pub.dev, where both socket adapters still
/// cast, so a port would assert the shared resolver against an interpreter
/// that does not have it. Its ast twin holds the resolver half. The copier
/// surface a port would have added is a class with a method whose body maps a
/// stream, plus loopback socket and HTTP setup — the class and the closure the
/// corpus copies on every run, the io calls it does not, and neither is a
/// construct the mirror AST lacks.
///
/// 35 -> 36: SCE116 added `sce116_enum_and_extension_tostring_test.dart`, which
/// runs source to ask what an enum value and an extension-type instance render
/// as. Exec resolves tom_d4rt_ast from pub.dev, where neither dispatches to an
/// override and an extension type still renders `<instance of X>`, so a port
/// would assert the fix against an interpreter that does not have it. Its ast
/// twin holds the dispatch half. The copier surface a port would have added is
/// an enum declaration with members and an extension-type declaration with a
/// representation — both of which the corpus copies on every run, and both of
/// which the hand-built twin constructs directly.
///
/// 36 -> 37: SCE117 added `sce117_handle_error_unwrapping_test.dart`, which
/// runs source to ask what a no-hook embedder receives from a `handleError`
/// handler. A port is not blocked by the interpreter here — exec's front end
/// carries its own copy of the zone specification and got the same fix — but
/// by the in-script matrix, which measures the interpreter's async machinery;
/// exec resolves tom_d4rt_ast from pub.dev, so thirteen rows would be asserted
/// against a different one. Its ast twin holds the seam. The copier surface a
/// port would have added is stream and future chains over closures, which the
/// corpus copies on every run.
///
/// 37 -> 38: SCE120 added `sce120_linked_list_subclass_test.dart`, which runs
/// source to ask whether a script subclass of `LinkedListEntry` survives a
/// round trip through a `LinkedList`. Exec resolves tom_d4rt_ast from pub.dev,
/// where the entry bridge is still the value-wrapper shape that rejects the
/// idiom outright, so a port would assert the fix against an interpreter whose
/// constructor refuses the script's `super()`. Its ast twin holds the proxy
/// half. The copier surface a port would have added is a class with an
/// `extends` clause carrying a type argument, a field formal parameter and a
/// `toString` override — all of which the corpus copies on every run.
///
/// 38 -> 39: SCE121 added `sce121_is_function_test.dart`, which runs source to
/// ask what `is Function` answers for each callable shape. Exec resolves
/// tom_d4rt_ast from pub.dev, where the `Function` bridge declares no
/// `isAssignable`, so a port would assert the fix against an interpreter that
/// still answers false for every native callable. Its ast twin holds the
/// mechanism. The copier surface a port would have added is `is` expressions
/// over property accesses and closures, which the corpus copies on every run.
///
/// 39 -> 40: SCE125 added `sce125_bare_static_write_test.dart`, which runs
/// source to ask where a bare write from an instance method lands. Exec
/// resolves tom_d4rt_ast from pub.dev, where the write still mints a
/// per-instance shadow, so a port would assert the fix against an interpreter
/// that does not have it. Its ast twin holds the mechanism. The copier surface
/// a port would have added is a class with a static field and a compound
/// assignment to a bare name, both of which the corpus copies on every run.
///
/// 40 -> 41: SCE126 added `sce126_stdlib_guard_sweep_test.dart`, which runs
/// source to compare what the stdlib bridges raise against what real Dart
/// raises. Exec resolves tom_d4rt_ast from pub.dev, where `String.fromCharCodes`
/// still casts to `List`, so a port would assert the widened domain against a
/// bridge that rejects it. Its ast twin holds that case. The copier surface a
/// port would have added is set literals and `.where(…)` over list literals,
/// which the corpus copies on every run.
///
const _copierGapBudget = 41;

const Map<String, _Coverage> _coveredElsewhere = {
  'sce126_stdlib_guard_sweep_test.dart': _Coverage(
    'ast:runtime/sce126_stdlib_guard_sweep_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 3,
    twinCases: 2,
    whyPartial:
        'the twin pins the one DIVERGENCE the sweep found and its control. '
        'The stdlib trees are code-identical (F-SCD49-2), so the cast is the '
        'same source; what the twin adds is that this tree\'s own set literal '
        'and closures produce an argument the widened cast accepts. The '
        'reference\'s third case is the 63-expression agreement table, which '
        'is a REAL-DART comparison rather than a property of either '
        'interpreter — restating it as bundles would assert the SDK against '
        'itself.',
  ),
  'sce125_bare_static_write_test.dart': _Coverage(
    'ast:runtime/sce125_bare_static_write_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 6,
    twinCases: 3,
    whyPartial:
        'the twin pins the MECHANISM and its rail — the static updated and '
        'seen from a second instance, and a non-static field staying '
        'per-instance — which is what only that tree can answer, since '
        '`visitAssignmentExpression` and the class-chain walk it mirrors are '
        'its own copies. The three the reference adds vary the SPELLING '
        '(plain vs compound, bare vs qualified read-back, local and parameter '
        'shadowing, the counter idiom, an inherited static), and each row is '
        'another hand-built bundle over a decision the same short-circuit '
        'already made.',
  ),
  'sce121_is_function_test.dart': _Coverage(
    'ast:runtime/sce121_is_function_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 4,
    twinCases: 3,
    whyPartial:
        'the twin pins the MECHANISM — that this tree\'s own `_valueHasType` '
        'reaches the bridge\'s `isAssignable` at all — plus both rails. The '
        'bridge file is code-identical between the trees (F-SCD49-2), so the '
        'rule is the same source; what differs is the type-test path that has '
        'to consult it. The reference\'s fourth case is the two halves left '
        'standing (`is String Function(int)` and `runtimeType`), which are '
        'documented in `doc/d4rt_limitations.md` Lim-11 and are the same '
        'answer in both trees because neither has a function type to give.',
  ),
  'sce120_linked_list_subclass_test.dart': _Coverage(
    'ast:runtime/sce120_linked_list_subclass_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 5,
    twinCases: 2,
    whyPartial:
        'the twin pins the two MECHANISMS only this tree can answer for '
        'itself — the `D4InterpretedProxy` unwrap that makes `l.first.v` the '
        'script\'s field, and the `toString` this commit fixed. The bridge '
        'file is code-identical between the trees (F-SCD49-2), so nothing '
        'about `_OwnedLinkedListEntry` differs; what differs is the '
        'interpreter consulting it. The three the reference adds sweep the '
        'SDK surface — addAll/addFirst/remove/unlink/contains/map/toList, '
        'iteration, and the two gaps left standing — and each row is another '
        'hand-built bundle over a question the same proxy already answered.',
  ),
  'sce117_handle_error_unwrapping_test.dart': _Coverage(
    'ast:runtime/sce117_handle_error_unwrapping_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 3,
    twinCases: 1,
    whyPartial:
        'the twin pins the SEAM, which is the whole of what it can uniquely '
        'answer: `D4rtRunner` carries its own copy of the zone '
        'specification, and nothing in the reference suite runs a line of it. '
        'The two the reference adds are CONTROLS over the seam\'s blast '
        'radius — a thirteen-row in-script matrix, and a non-interpreter '
        'error being delegated rather than repackaged — and neither is a '
        'property of one tree: they are about what `Zone.errorCallback` does '
        'to errors it was not aimed at, which is SDK behaviour both trees '
        'inherit identically. Thirteen hand-built bundles would restate it, '
        'not test it.',
  ),
  'sce116_enum_and_extension_tostring_test.dart': _Coverage(
    'ast:runtime/sce116_enum_and_extension_tostring_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 9,
    twinCases: 4,
    whyPartial:
        'the twin pins the four MECHANISMS — an enum override reaching the '
        'host, an enum default unchanged, an extension-type override, and the '
        'representation as the default. Each needs the `declaringVisitor` '
        'wiring that tree assigns in its own `visitEnumDeclaration` / '
        '`visitExtensionTypeDeclaration`, which is what only this side can '
        'answer. The five the reference adds are the CONTRACT rather than the '
        'dispatch — in-script interpolation, a mixin-supplied override, the '
        'host path degrading on a throw, the in-script path still propagating, '
        'and SCD72 re-asked after its mechanism moved — and each is another '
        'hand-built bundle for a question whose answer is the same code.',
  ),
  'sce114_transform_argument_test.dart': _Coverage(
    'ast:runtime/sce114_transform_argument_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 6,
    twinCases: 3,
    whyPartial:
        'the twin pins the RESOLVER, which is the code the fix moved and the '
        'part only an analyzer-free interpreter can answer for itself — '
        'reading `bind` off an `InterpretedInstance` and calling it through '
        '`runAction`. Three of the reference\'s cases are the socket '
        'adapters (`Socket.transform`, `ServerSocket.transform`) and the '
        'HttpClientResponse round trip, each of which needs a live loopback '
        'server AND a parsed script; a hand-built bundle that binds a socket '
        'and awaits a connection buys the same resolver assertion at several '
        'hundred nodes.',
  ),
  'sce113_function_apply_symbol_keys_test.dart': _Coverage(
    'ast:runtime/sce113_function_apply_symbol_keys_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 9,
    twinCases: 5,
    whyPartial:
        'the twin pins the mechanism — Symbol keys reaching the named '
        'parameter, several of them in either order, a String key rejected '
        'with the legal spelling in the message, and both argument lists '
        'accepting null. The four the reference adds are a second route to '
        'the same key (`Symbol(\'b\')` rather than `#b`), the non-Symbol '
        'key types, the neighbours that were already Symbol-keyed '
        '(`Invocation`, and the interpreter\'s own noSuchMethod path), and '
        'the unknown-name error surviving the translation. Each is a further '
        'script, and the twin pays a hand-built bundle for every one.',
  ),
  'sce67_missing_member_catchable_test.dart': _Coverage(
    'ast:sce67_missing_member_catchable_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 4,
    twinCases: 3,
    whyPartial:
        'the twin asserts the HIERARCHY (F-SCE67-AST-1..3: '
        'UndefinedMemberD4rtException is a NoSuchMethodError, is still a '
        'RuntimeD4rtException, and the deliberately-uncatchable types are not) '
        'rather than running scripts, because tom_d4rt_ast has no parser. That '
        'is the half worth holding there: it is the tree a Flutter app ships, '
        'so the hierarchy being right in THAT copy is what decides whether an '
        "app's catch clause works. The reference case it omits is F-SCE67-2, "
        'which asks what an interpreted `on NoSuchMethodError` clause catches '
        'and needs a real script to ask. Porting that to exec is what the '
        '_uncoveredBaseline entry defers, not this.',
  ),
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
    // 9 -> 10 with SCD77's declaration-direction sweep (F-SCD77-4), added to
    // both copies in the same commit. The sweep it joins reads member VALUES,
    // which cannot see a method registered as a getter once a `Function` bridge
    // exists to resolve the tear-off.
    //
    // 10 -> 14 with SCD197's group, also added to both copies together: which
    // bridges are never a resolution answer AND no heir falls through to. It
    // belongs beside the native-name sweep because both need the same fully
    // registered environment and the same canonical-instance table, and a
    // third copy of either would measure nothing new.
    refCases: 14,
    twinCases: 14,
  ),
  // SCD121 made a variable declaration keep every `await` in its initializer,
  // and made `a + b` stop evaluating `b` while `a` is suspended. The reference
  // file counts CALLS as well as values, because the defect evaluated the
  // discarded operands — a repair that gets the sum right by evaluating an
  // operand twice passes a value-only test and is still wrong, which the first
  // attempt at the fix did.
  //
  // An exec port is publish-blocked: the fix ships in tom_d4rt_ast 0.94.0 and
  // exec resolves 0.65.0, so a port would assert it against an interpreter that
  // binds `1`. Revisit when the floor moves — sce137 carries the publish.
  'scd121_var_decl_multi_await_test.dart': _Coverage(
    'ast:runtime/scd121_var_decl_multi_await_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 5,
    twinCases: 2,
    whyPartial:
        'the twin carries the claim at two arities (F-SCD121-AST-1/-2: two and '
        'three awaits in one initializer, each with its call count), which is '
        'what separates the fix from the near-miss that compounded with arity. '
        'The three it omits need more hand-built bundles for less: the '
        'interpolation shape is the same defect wearing a different symptom, '
        'the one-await case is the fast path the reference already guards, and '
        'the loop control needs a for-statement in `SAstNode` form. The twin '
        'does pin one thing the reference cannot reach — its two await sites '
        'are structurally identical and resolve to different values, which is '
        'the identity-keying claim `scc40_per_await_site_resumption_test.dart` '
        'names and leaves unpinned.',
  ),
  // SCD119 repaired the binding check so a native `D4InterpretedProxy` binds to
  // a parameter declared as the interpreted class it stands for — the corpus's
  // `type 'ThemeExtension' is not a subtype of type 'BrandColors' of 'brand'`.
  // The twin is a HAND-BUILT BUNDLE, which is the only script-level form this
  // line can take, and the smaller count is what that costs: building a class
  // that extends a bridged class, a typed parameter and a native round trip out
  // of `SAstNode` constructors is ~200 lines for the pair of cases below.
  //
  // An exec port would be the cheaper form and is publish-blocked on top of
  // that: the fix ships in tom_d4rt_ast 0.93.0 and exec resolves 0.65.0, so the
  // port would assert behaviour nobody here is running (DGUC6). Revisit when
  // the floor moves — sce137 carries the publish.
  // SCF26: three cases either side, byte-identical apart from the interpreter
  // import and the `-AST-` in the two control ids. The twin is a full port
  // rather than a partial one because the subject is `Environment` itself: the
  // frames are built by hand, so nothing about the AST line makes a case
  // unreachable.
  'sce178_stream_override_resolution_test.dart': _Coverage(
    'ast:runtime/sce178_stream_override_resolution_test.dart',
    _astTwin,
    // REGISTRATION, not script: no script runs. The live registry is asked
    // which bridge claims two private SDK names, via stand-in classes that
    // borrow the names; the ast twin asks its own live registry the same.
    layer: _Layer.registration,
    refCases: 2,
    twinCases: 2,
  ),
  'sce160_stream_transformer_resolution_test.dart': _Coverage(
    'ast:runtime/sce160_stream_transformer_resolution_test.dart',
    _astTwin,
    // REGISTRATION, not script: no script runs. The real Stream and
    // StreamTransformer stdlib bridges are defined in a bare Environment and
    // `toBridgedClass` is asked which one claims each SDK transformer type.
    // The defect was visible only on the analyzer-free line, so the ast twin
    // is the better test rather than a substitute for an exec one.
    layer: _Layer.registration,
    refCases: 2,
    twinCases: 2,
  ),
  'bridge/scf26_suffix_match_ordering_test.dart': _Coverage(
    'ast:runtime/scf26_suffix_match_ordering_test.dart',
    _astTwin,
    // REGISTRATION, not script: no script runs. The frames are built directly
    // and `toBridgedClass` is asked which bridge claims a native type, so the
    // ast twin is the better test rather than a substitute for an exec one.
    layer: _Layer.registration,
    refCases: 4,
    twinCases: 4,
  ),
  'bridge/scd119_interpreted_proxy_binding_test.dart': _Coverage(
    'ast:runtime/scd119_interpreted_proxy_binding_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 7,
    twinCases: 4,
    whyPartial:
        'the twin carries each claim and the one control that can go wrong '
        'beside it: F-SCD119-AST-1 (a proxy binds to a parameter declared as '
        'the script class it wraps) with F-SCD119-AST-2, and SCE161\'s '
        'F-SCE161-AST-1 (a LIST of proxies binds to a parameter declared as a '
        'list of that class) with F-SCE161-AST-2. The list pair was worth two '
        'more hand-built bundles where the others were not, because it is the '
        'shape the flutter corpus actually hits and the only one that reached '
        'an assertion. The three it omits are the reference tree\'s '
        'F-SCD119-2, which round-trips the bound value through a second native '
        'boundary, F-SCD119-4, which checks a NON-proxy native value is still '
        'refused by the base check, and F-SCE161-2, the declared-LOCAL site of '
        'the same binding path — all reachable only by writing more bundles '
        'for branches the four already pin.',
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
    // This entry has now rotted twice the same way: 17 to 24, caught by SCD19
    // once F-SCC6-6 existed to check the numbers against the files, and 24 to
    // 30, caught by it again. Both sides grew IN STEP each time, so the pair
    // was never partial and no deficit was ever computed wrongly — which is
    // exactly why nothing but F-SCC6-6 would report it. A count that is only
    // ever read to compute a deficit goes unexamined while it agrees with its
    // twin, and silently stops being true.
    layer: _Layer.registration,
    refCases: 30,
    twinCases: 30,
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
  // SCD90's top-type matrix. Registration-level by nature — it constructs
  // `RuntimeType` implementations directly and asks them a predicate question,
  // so it needs no parser and the twin runs the identical file. Not ported to
  // exec on purpose: this package resolves `tom_d4rt_ast` from pub.dev, so a
  // copy here would measure the published predicate rather than the fixed one,
  // and would go red until the release lands (DGUC6). The twin is where the
  // code under test lives.
  'scd90_top_type_subtyping_test.dart': _Coverage(
    'ast:runtime/scd90_top_type_subtyping_test.dart',
    _astTwin,
    layer: _Layer.registration,
    refCases: 4,
    twinCases: 4,
  ),
  // SCD100's type-alias resolution. Script-level. Not ported to exec because
  // exec resolves `tom_d4rt_ast` from pub.dev, where a typedef still has no
  // runtime representation -- a port would go red until the release lands
  // (DGUC6).
  'scd100_type_alias_resolution_test.dart': _Coverage(
    'ast:runtime/scd100_type_alias_resolution_test.dart',
    _astTwin,
    layer: _Layer.script,
    // 10 -> 16 / 3 -> 6: SCE130 closed the first of the two limits this file
    // recorded -- a generic BOUND written through an alias. The reference
    // gains six cases (the shape itself, enforcement, every alias target, the
    // class and method parameter, an anti-vacuity control for a genuinely
    // undefined bound, and declaration order); the twin gains the claim, the
    // enforcement discriminator and the control.
    refCases: 16,
    twinCases: 6,
    whyPartial:
        'the twin is a different KIND of test, not this one with cases '
        'dropped. The reference file walks the measured SHAPES across sixteen '
        'cases -- `is`, `as`, parameters, return types, collection literals, '
        'alias chains, generic bounds on functions, classes and methods -- '
        'which are one line each when you can run source and a couple of '
        'dozen when every case is a hand-built bundle. The twin carries the '
        'six that cannot pass by accident: `is` answering BOTH ways, the '
        'fixpoint that makes declaration order irrelevant, the non-alias '
        'control for the `as` change, a bound through an alias running, that '
        'bound being ENFORCED rather than swallowed, and an undefined bound '
        'still being reported.',
  ),
  // SCD99's runtimeType reporting. Script-level. The defect lived in shared
  // interpreter code (`visitBinaryExpression`), so the twin is what says the
  // analyzer-free line has it too. Not ported to exec because exec resolves
  // `tom_d4rt_ast` from pub.dev and still answers `false` for
  // `x.runtimeType == SomeType` -- a port would go red until the release lands
  // (DGUC6).
  'scd99_runtimetype_reporting_test.dart': _Coverage(
    'ast:runtime/scd99_runtimetype_reporting_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 8,
    twinCases: 3,
    whyPartial:
        'the twin is a different KIND of test, not this one with cases '
        'dropped. Five of the reference cases sweep SHAPES -- four primitive '
        'and bridged types, both operand orders, `!=`, a generic type '
        'argument, and equality on six other receiver kinds -- which are one '
        'line each when you can run source and a couple of dozen when every '
        'case is a hand-built bundle. The twin carries the comparison that was '
        'actually wrong, the name that must not break while fixing it, and the '
        'ordinary-receiver control for the hoist.',
  ),
  // SCD98's bridged-value representation. Script-level, and its twin earns its
  // place: the split lived in the SHARED interpreter code, so the reference
  // tree's evidence says nothing about the analyzer-free line on its own. Not
  // ported to exec because exec resolves `tom_d4rt_ast` from pub.dev and still
  // constructs wrappers -- a port would go red until the release lands
  // (DGUC6).
  'scd98_bridged_value_representation_test.dart': _Coverage(
    'ast:runtime/scd98_bridged_value_representation_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 6,
    twinCases: 3,
    whyPartial:
        'the twin is a different KIND of test, not this one with cases '
        'dropped. The reference file spends three of its six cases on the '
        'measured wrapping TABLE -- every production route, the four '
        'observations the todo names, and the typed-data boundary -- which are '
        'one line each when you can run source and a couple of dozen when '
        'every case is a hand-built bundle. The twin carries the case that '
        'actually detects a wrapper (a native container deduplicating in BOTH '
        'orders) plus the two that say the fix did not break ordinary '
        'bridging.',
  ),
  // SCD96's host-facing unwrap. Script-level, and its twin is the POINT rather
  // than a concession: `executeBundle` is the analyzer-free line's entry point,
  // and the split the fix closed was between the synchronous and asynchronous
  // halves of that API. Not ported to exec because exec resolves
  // `tom_d4rt_ast` from pub.dev and still shows the pre-fix behaviour --
  // measured 2026-09-14, exec's lock holds 0.65.0 against a 0.89.0 tree, and a
  // port would go red until the release lands (DGUC6).
  'scd96_host_facing_error_unwrap_test.dart': _Coverage(
    'ast:runtime/scd96_host_facing_error_unwrap_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 7,
    twinCases: 4,
    whyPartial:
        'the twin is a different KIND of test, not this one with cases '
        'dropped. The reference file walks seven SHAPES through one entry '
        'point, which is three lines each when you can run source. The twin '
        'cannot run source at all -- every case is a hand-built bundle -- so '
        'it spends its budget on the axis the reference tree cannot reach: '
        'all THREE bundle entry points agreeing, which is where the defect '
        'actually was.',
  ),
  // SCD94's `on`-clause nameability guard. Script-level: it runs a `try`/`on`
  // per SDK type and asserts the clause is ENTERED. Not ported to exec on
  // purpose, and for a sharper reason than the usual one: two of its nine cases
  // are SOURCE SCANS of the reference and twin `core/error.dart`, which exec
  // has no copy of at all — it resolves `tom_d4rt_ast` from pub.dev, so the
  // registration it would scan lives in the pub cache rather than in a tree
  // anybody edits (DGUC6). The twin carries the three cases that cannot pass
  // by accident, hand-built as bundles.
  'scd94_sdk_type_nameability_test.dart': _Coverage(
    'ast:runtime/scd94_sdk_type_nameability_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 9,
    twinCases: 3,
    whyPartial:
        'the twin is a different KIND of test, not this one with cases '
        'dropped. Four of the reference cases walk TABLES of sixteen SDK types '
        'through a `try`/`on`, which is three lines each when you can run '
        'source and a couple of dozen when every case is a hand-built bundle; '
        'two more are source scans over both trees, which the twin cannot make '
        'from inside one of them. The twin carries the claim itself -- a '
        'registered name is reached, an unregistered one is not, and the '
        'supertype chain is walked -- which is what the reference tree cannot '
        'prove about the analyzer-free interpreter.',
  ),
  // SCD93's native-operator-guard sweep. Script-level: it runs source and
  // compares what d4rt throws against what the SDK throws for the same
  // one-liner, across five guard families. Not ported to exec on purpose: this
  // package resolves `tom_d4rt_ast` from pub.dev, so a copy here would measure
  // the published guards rather than the swept ones, and would go red until the
  // release lands (DGUC6). The twin carries the four cases that cannot pass by
  // accident, hand-built as bundles.
  'scd93_native_operator_guards_test.dart': _Coverage(
    'ast:runtime/scd93_native_operator_guards_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 18,
    twinCases: 4,
    whyPartial:
        'the twin is a different KIND of test, not this one with cases '
        'dropped. The reference file compares d4rt against the SDK for '
        'eighteen one-line PROGRAMS, which is three lines each when you can '
        'run source. The twin cannot run source at all: every case is a '
        'hand-built bundle, so it carries the four that cannot pass by '
        'accident -- the bitwise TypeError, the fast arm it fronts, the list '
        'RangeError worded `(length)` (a wording only delegation produces, so '
        'a corrected hand-written guard still fails it) and the read that must '
        'still land. The other fourteen re-ask the same delegation question of '
        'operators whose arms are one shared fallback.',
  ),
  // SCD92's applied-parameter matrix. Script-level: it runs source and asserts
  // which programs a binding check accepts, so most of its value is in the
  // twenty-two shapes the reference tree can spell cheaply. Not ported to exec
  // on purpose: this package resolves `tom_d4rt_ast` from pub.dev, so a copy
  // here would measure the published check rather than the fixed one, and
  // would go red until the release lands (DGUC6). The twin carries the four
  // cases that cannot pass by accident, hand-built as bundles.
  'scd92_applied_parameter_type_test.dart': _Coverage(
    'ast:runtime/scd92_applied_parameter_type_test.dart',
    _astTwin,
    layer: _Layer.script,
    // 22 -> 27 / 4 -> 6: SCE129 added the ALL-NULL collection to the
    // permissive set on both sides. The reference gains four shapes (list,
    // set, both halves of a map, a local declaration) plus an anti-vacuity
    // control; the twin gains the claim and its control, which is the split
    // `whyPartial` already describes.
    refCases: 27,
    twinCases: 6,
    whyPartial:
        'the twin is a different KIND of test, not this one with cases '
        'dropped. The reference file spells twenty-seven SHAPES -- empty, '
        'all-null, heterogeneous, top-type, unbound and bound type '
        'parameters, covariance, numeric widening -- because running source '
        'makes each one three lines. The twin cannot run source at all: '
        'every case is a hand-built bundle costing a couple of dozen lines, '
        'so it carries the six that cannot pass by accident (mismatch '
        'throws, match binds, empty stays permissive, raw annotation admits '
        'anything, all-null stays permissive, a wrong type still throws). '
        'Porting the other twenty-one would restate boundary arithmetic the '
        'shared `ResolvedBinding._checkTypeArguments` decides in one place, '
        'at a cost of some 500 lines of bundle construction.',
  ),
  'scc28_typed_undefined_member_test.dart': _Coverage(
    'ast:runtime/scc28_typed_undefined_member_test.dart',
    _astTwin,
    layer: _Layer.script,
    // 9 -> 13: SCD86 added three cases naming the static signal, SCD87 one
    // asserting the receiver survives a rewrap. The twin stays at three — its
    // F-SCC28-AST-2 gained the receiver assertion rather than a fourth case,
    // because it is the same seam and the twin's value here is that it can
    // check it without a parser.
    refCases: 13,
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
  // same case ids on each side — `F-SCC51-1..8`, `F-SCD152-1` and, since
  // SCE185 widened the walk to every shadowing bridge, `F-SCE185-1..7`, and
  // `F-SCE195-1` —
  // asserting the same thing. SCE185's `2..5` are scripts in the reference
  // and adapter calls in the twin, the same split `F-SCC51-1..7` has.
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
    refCases: 17,
    twinCases: 17,
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
  // SCD200's second batch. The first pass resolved the twenty-four files the
  // failure message DISPLAYED; the matcher had elided the rest, and the real
  // backlog was forty. That is worth knowing for the next person who reads a
  // set out of a `expect` failure: print it, do not count it.
  'scd132_prefix_match_corroboration_test.dart': _Coverage(
    'ast:runtime/scd132_prefix_match_corroboration_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 4,
    twinCases: 4,
  ),
  'scd68_format_exception_args_test.dart': _Coverage(
    'ast:runtime/scd68_format_exception_args_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 4,
    twinCases: 4,
  ),
  // Registration-level, and unportable for the `Environment` reason the three
  // entries above give: it imports eight `package:tom_d4rt/src/stdlib/*.dart`
  // registrars, whose port spelling names the twin package, and a program
  // cannot hold both registries.
  'scd175_class_shaped_binding_test.dart': _Coverage(
    'ast:runtime/scd175_class_shaped_binding_test.dart',
    _astTwin,
    layer: _Layer.registration,
    refCases: 4,
    twinCases: 4,
  ),
  // Publish-blocked for seven of its nine; the other two cannot be ported at
  // all, for the filesystem-module reason scd136 and scd145 give above.
  // Measured 2026-09-15 against 0.113.0: F-SCD137-8 and -9, both marked SCRIPT
  // level in their own names, drive a fixture through a `package:` import
  // resolved from disk and report "Filesystem imports are disabled".
  'scd137_typedef_arity_test.dart': _Coverage(
    'ast:runtime/scd137_typedef_arity_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 9,
    twinCases: 7,
    whyPartial:
        'the two the twin omits are the reference\'s F-SCD137-8 and -9, which '
        'bind a callback declared in a fixture PACKAGE imported from the '
        'filesystem — the one thing the analyzer-free line does not do, since '
        'it resolves modules from a pre-built bundle. The seven it carries are '
        'the arity rule itself, asked of bundles it constructs directly.',
  ),
  // SCD200. The nine below were reported by F-SCC6-2 with no recorded
  // counterpart, and every one was RUN before being written here — hosted
  // first, then against the working tree with
  // `tom_d4rt_flutter_ast/tool/prepublish_overrides.dart --set`, which is what
  // separates "publish-blocked" from "divergent" rather than leaving it to
  // prose. The verdicts are on each entry.
  //
  // Three are registration-level and cannot be ported at all: they import
  // `package:tom_d4rt/src/stdlib/*.dart`, whose port spelling is
  // `package:tom_d4rt_ast/src/runtime/...`, and the resulting file imports
  // `Environment` from both packages. That is not a missing pair in
  // `port_recipe.dart` — it is a file that names the reference registry AND the
  // twin registry in one program, which no rewrite can reconcile. The ast twin
  // is the only place the question can be asked of the analyzer-free line.
  'scc76_bridge_name_collision_test.dart': _Coverage(
    'ast:scc76_bridge_name_collision_test.dart',
    _astTwin,
    layer: _Layer.registration,
    refCases: 7,
    twinCases: 7,
  ),
  'scb24_unregistered_bridge_test.dart': _Coverage(
    'ast:runtime/scb24_unregistered_bridge_test.dart',
    _astTwin,
    layer: _Layer.registration,
    refCases: 3,
    twinCases: 2,
    whyPartial:
        'the twin is a native re-expression, not a port — its cases are '
        'F-SCB24-AST-1 and -2, the registration sweep and its anti-vacuity '
        'control, over tom_d4rt_ast\'s own bridge sources. The reference\'s '
        'third case, F-SCB24-2, asserts that the SOURCE SCAN read a bridge '
        'name for every declaration it found; the twin folds that question '
        'into its own control because its scan is over a different tree with a '
        'different file layout, and two scans of two trees cannot share one '
        'assertion about what either read.',
  ),
  'stdlib/scd196_member_map_disjointness_test.dart': _Coverage(
    'ast:runtime/scd196_member_map_disjointness_test.dart',
    _astTwin,
    layer: _Layer.registration,
    refCases: 3,
    twinCases: 2,
    whyPartial:
        'the twin carries F-SCD196-1 and its control, which is the whole of '
        'the registration-level question — no bridge declares one member in '
        'two maps. The reference\'s third case, F-SCD196-3, runs a SCRIPT to '
        'assert `MapEntry.hashCode` evaluates rather than tearing off, which '
        'is the behavioural consequence of the defect rather than the defect. '
        'A bundle-driven equivalent is writable and is sce239.',
  ),
  // The six below are script-level and publish-blocked, which is the shape
  // already recorded for scd99/scd100/scd119/scd121 above. Each one PASSES
  // against the working tree and fails against the 0.65.0 exec resolves, so
  // the entry records a release that has not happened rather than a
  // disagreement between the two interpreters. Re-measured 2026-09-15; sce237
  // carries the publish.
  'scd70_list_coercion_test.dart': _Coverage(
    'ast:runtime/scd70_list_coercion_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 6,
    twinCases: 5,
    whyPartial:
        'the twin is a native re-expression with its own ids (F-SCD70-AST-1..5) '
        'and its own choice of natives — it folds the reference\'s two socket '
        'cases, F-SCD70-1 and -2, into one because the annotated and bare '
        'spellings reach the same coercion, and reaches '
        '`RandomAccessFile.writeFromSync` where the reference reaches '
        '`RawDatagramSocket.send`. Same mechanism, five bundles instead of six '
        'scripts.',
  ),
  'scd64_grouping_and_null_patterns_test.dart': _Coverage(
    'ast:runtime/scd64_grouping_and_null_patterns_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 8,
    twinCases: 4,
    whyPartial:
        'the twin pins the four MECHANISMS — `(p)` transparency, `p?` missing '
        'on null, `p!` throwing on null, and `p!` not being "always throw" — '
        'where the reference additionally sweeps all four pattern contexts '
        'plus for-each and assignment (F-SCD64-6), re-checks the twelve '
        'already-working pattern kinds (F-SCD64-7) and records the cast '
        'divergence (F-SCD64-8). Those three are corpus sweeps over hand-built '
        'bundles, which is the cost the mirror AST imposes on a table-driven '
        'case.',
  ),
  'scd63_foreach_type_test.dart': _Coverage(
    'ast:runtime/scd63_foreach_type_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 13,
    twinCases: 4,
    whyPartial:
        'the reference is a thirteen-row table over element/annotation '
        'combinations; the twin pins the four that are distinct as MECHANISMS '
        '— a mismatch raising TypeError, a match binding, an unannotated '
        'variable admitting anything, and `double` widening an `int`. The '
        'other nine rows vary the types inside the same code path, and a '
        'hand-built bundle per row buys repetition rather than coverage.',
  ),
  'scd62_nullable_is_test.dart': _Coverage(
    'ast:runtime/scd62_nullable_is_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 8,
    twinCases: 3,
    whyPartial:
        'the twin pins the `is` operator itself — the nullable suffix '
        'accepting null, the bare form rejecting it, and `Object?` against '
        '`Object`. Five of the reference\'s cases are the same question asked '
        'through PATTERN syntax (a switch arm, `if (v case String? _)`, a '
        'binding `case String? s:`), which the analyzer-free line reaches '
        'through the same runtime type check and which cost a bundle each.',
  ),
  // These two also fail against the WORKING TREE, and for a reason that is not
  // a publish: both drive their fixtures through a `package:` import resolved
  // from the filesystem, and the analyzer-free line has no filesystem module
  // loader by construction — it resolves modules from a pre-built bundle, which
  // is the whole point of it. Ported they report "Filesystem imports are
  // disabled; enable allowFileSystemImports or preload the module source"
  // rather than anything about the behaviour under test. Measured 2026-09-15
  // against 0.113.0.
  'scd136_closure_vs_bridged_typedef_test.dart': _Coverage(
    'ast:runtime/scd136_closure_vs_bridged_typedef_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 6,
    twinCases: 4,
    whyPartial:
        'the reference\'s F-SCD136-4 and -5 are its two SCRIPT-level cases and '
        'they are the two that need a filesystem-resolved fixture package; the '
        'twin covers the rule itself — a closure type satisfying a bridged '
        'typedef, a non-Function native still doing so, and the rule subsuming '
        'the dart:core name test — at the level where no module loader is '
        'involved.',
  ),
  'scd145_unbridged_native_diagnostic_test.dart': _Coverage(
    'ast:runtime/scd145_unbridged_native_diagnostic_test.dart',
    _astTwin,
    layer: _Layer.script,
    refCases: 10,
    twinCases: 3,
    whyPartial:
        'the reference reaches an unbridged native by importing a fixture '
        'package from disk, which the analyzer-free line cannot do. The twin '
        'asks the same question of the diagnostic directly — a native no '
        'bridge claims earns the clause, a bridged one earns nothing, and an '
        'interpreter-internal value earns nothing — which is three controls '
        'where the reference has one, and no fixture package at all. SCE176 '
        'added five reference cases through the same fixture: the clause on '
        'indexing, operators, both assignment forms and calls, a call on a '
        'non-function that must throw, and the callable-object rule for '
        'interpreted classes. The call sites they exercise are held '
        'code-identical in the two trees by F-SCD183-2 and F-SCD199-2, which '
        'is the AST line\'s evidence until exec resolves a tom_d4rt_ast that '
        'carries the change.',
  ),
};

/// The two case counts an [_uncoveredBaseline] entry records.
///
/// A record rather than a bare `int` because the single number this map used
/// to hold had two incompatible jobs: it is the pin a publish re-measures
/// against, AND it was the only thing a guard could have compared to the file.
/// Those want different measurements — see the map's own comment — so they are
/// now two fields, and only one of them is machine-checkable.
typedef _CaseCounts = ({int ran, int declared});

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
/// WHAT THE NUMBERS ARE. Each entry records TWO counts, because one number
/// cannot be both the pin and the thing a cheap guard checks (SCD61).
///
///   * `ran` — a RUNTIME measurement: how many cases actually ran when the
///     file was executed. That is what makes it useful on a publish — "port it
///     and confirm the count" is how you notice the reference side moved after
///     the pin was taken. Confirming it is a RUN, so nothing here checks it,
///     and it is never edited without one.
///   * `declared` — `test(` declarations in the reference source, as
///     [_countCases] counts them. [F-SCC6-10] checks it on every entry, every
///     run, for the price of reading 40 files.
///
/// THE TWO DIVERGE for any file that generates its cases in a loop, and that
/// divergence is why the second number had to be ADDED rather than the first
/// simply checked. Measured 2026-09-22, 14 of the 40 entries differ —
/// `stdlib/sce74_sdk_error_type_parity_test.dart` most sharply, 61 cases from
/// two declarations. A guard over `ran` alone would have verified the 26
/// entries whose counts cannot drift and exempted the 14 that do: not a weak
/// guard but an INVERTED one, green precisely where the drift lives. That is
/// also why [F-SCC6-6] checks [_coveredElsewhere] and stops there — its counts
/// are static-comparable and need no second number.
///
/// WHAT [F-SCC6-10] CATCHES is a reference file gaining or losing a case while
/// its entry stands. That is most of the drift and it happens at an ordinary
/// working rate. What it does not catch is a loop whose iteration count moved
/// with the source untouched; `ran` is the only witness to that, and only a
/// run produces it. An entry whose two numbers are EQUAL says more than the
/// others: nothing in it generates cases, so a change in `declared` means
/// `ran` is stale by the same amount.
///
/// HOW TO CONFIRM A COUNT, and it is one command from `tom_d4rt_exec`:
///
///     dart run tool/remeasure_pins.dart --uncovered
///
/// It copies, rewrites and runs every entry against the resolved interpreter
/// and prints RECORDED against RAN per entry, naming every mismatch and — a
/// different finding — every entry whose count could not be confirmed at all
/// (SCE143). The comparison used to be advice in this header that the tool had
/// the numbers for and never made.
///
/// RE-MEASURED IN FULL, 2026-09-22 (SCE143), all 49 entries against resolved
/// 0.65.0. **No count had drifted**: every one of the 35 entries that ran
/// matched its recorded `ran` exactly. That is the register working — sce141
/// had re-recorded the two that HAD drifted (`typed_list_family_parity` and
/// `coerce_arguments`) the same day, and `release_hygiene_test.dart`, the
/// example the todo was written around, had since moved to
/// [_anchoredBaseline].
///
/// FOURTEEN ENTRIES COULD NOT BE COUNTED, which is the standing finding rather
/// than a failure: their ports do not compile against the published
/// interpreter, so their recorded `ran` is a HISTORICAL figure from whenever
/// the file last built. Each now says so directly above its number, because a
/// figure that reads as measured and cannot be is the shape of defect this
/// register exists to prevent.
///
/// TWO ENTRIES PASS, and both are correctly overridden by a judgement the
/// experiment cannot make: `_conway_perf_probe` is a timing assertion and
/// `sce76_generic_function_parameter_census` measures nothing in a package that
/// registers no bridges. Both entries said so in advance; both now record the
/// measurement as well, so the next run meets a note rather than a surprise.
///
/// The older record below is kept because it is the run that established the
/// ratio, not because it describes today's register — four of the nine entries
/// it names have since left the map:
///
/// RE-MEASURED IN FULL, 2026-09-15 (SCD126), with
/// `dart run tool/remeasure_pins.dart --uncovered` — the same copy-rewrite-run
/// SCC44 did by hand on the other map, against resolved 0.65.0:
///
///     scd95_static_name_report_test.dart         does-not-compile
///     _conway_perf_probe_test.dart               PASSES
///     scc73_sdk_member_completeness_test.dart    does-not-compile
///     stdlib/member_coverage_baseline_test.dart  does-not-compile
///     release_hygiene_test.dart                  runs, 31/32
///     scc22_io_error_handler_arity_test.dart     14/17   (as recorded; SCD157
///                                                 then split the 3 out and
///                                                 ported the 14 — the entry
///                                                 here is now the guard file)
///     scd72_instance_tostring_test.dart          2/7     (as recorded)
///     scd73_no_hook_unwrapping_test.dart         does-not-compile
///     scc25_listen_duplication_guard_test.dart   0/2     (as recorded)
///
/// SCC44'S RATIO DID NOT REPRODUCE, and that is the result rather than a
/// disappointment. On `_divergentBaseline` 32 of 38 entries converged on the
/// spot because they had never been measured; here every recorded count came
/// back exactly, because SCD25, SCD74, SCD79 and SCD157 had already worked this
/// map entry by entry. A ratchet that has been maintained looks like this, and
/// the way to know which kind you have is to run the experiment.
///
/// THE ONE THAT PASSES IS NOT A PORT WAITING TO BE TAKEN. `_conway_perf_probe`
/// passes here and its entry already says why porting it would still be wrong:
/// it measures how long a Conway generation takes, so on a second interpreter
/// with different performance characteristics it yields a flaky failure rather
/// than information. That is a judgement the experiment cannot make — which is
/// exactly why step one of a re-measurement is to READ THE ENTRY, and only then
/// to run anything.
///
/// `release_hygiene_test.dart` runs here and reaches 31 of 32, which confirms
/// its entry rather than contradicting it: the reason it is not ported is that
/// a copy would ask the same questions about the same three packages and add a
/// second red for one cause, not that it cannot run.
const Map<String, _CaseCounts> _uncoveredBaseline = {
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.154.0.
  // SCE127 made an `on` clause naming an unresolvable type FAIL instead of
  // falling through; the published 0.65.0 still logs a warning and answers
  // `false`, so -1 and -2 would assert the diagnostic against an interpreter
  // that produces none. -3 and -4 would pass there, which is exactly why they
  // are the safety evidence rather than the subject.
  'sce127_dead_on_clause_test.dart': (ran: 4, declared: 4),
  // PUBLISH-PIN(sce160_aioc-publish-scd136-and-record-the-corpus-run)
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.157.0.
  // SCE139 stopped the return and invocation resumption routes re-evaluating
  // their node inside `_determineNextNodeAfterAwait`, which ran every
  // not-yet-resolved await twice and ate the value the second site should have
  // had. Measured 2026-09-22: 11 of 11 fail against 0.65.0, 0 of 11 against the
  // 0.157.0 working tree. ALL ELEVEN, including the two cases written as
  // controls — 0.65.0 predates SCD121 as well, so the declaration route it
  // holds fixed is not fixed there either. That is a fact about how far behind
  // exec's floor is, not a sign the controls are mis-chosen: they discriminate
  // against the tree this change was made in, which is where they run.
  'sce139_multi_await_resumption_test.dart': (ran: 11, declared: 11),
  // NOT PORTABLE, and not blocked on a publish. It compares what FIVE host
  // boundaries hand over for one script failure, and two of them — `invoke`
  // and `eval`'s statement form — are `tom_d4rt` API that exec's front end
  // exposes with a different established context (`_interpretedInstance` is
  // set by a `main` returning an instance, which exec's own suite already
  // covers elsewhere). The defect it pins is in `_tryFunction`, which exec
  // HAS and which was fixed in the same commit; what cannot travel is the
  // five-way comparison, not the fix.
  // pin-registered: n/a - nothing a publish can change.
  'sce118_host_error_shape_test.dart': (ran: 5, declared: 5),
  // SCE21's batch: the four async state-machine fixes closed on 2026-09-18,
  // measured BOTH ways with `tool/remeasure_pins.dart --candidates` before
  // being pinned — against the 0.65.0 exec resolves, and against the 0.120.0
  // working tree through SCD66's pre-publish override, which was restored
  // before anything here was written.
  //
  // Every one of them is a silent WRONG ANSWER rather than a crash, which is
  // why the failing-case counts below are worth reading: the cases that pass
  // against 0.65.0 are the shapes that were already right, and they are in each
  // file deliberately as controls.
  //
  // PUBLISH-PIN(sce160_aioc-publish-scd136-and-record-the-corpus-run)
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.117.0.
  // Measured 2026-09-18: 6 of 10 fail against 0.65.0, 0 of 10 against 0.120.0.
  'sce17_await_in_expression_body_test.dart': (ran: 10, declared: 10),
  // PUBLISH-PIN(sce160_aioc-publish-scd136-and-record-the-corpus-run)
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.118.0.
  // Measured 2026-09-18: 4 of 9 fail against 0.65.0, 0 of 9 against 0.120.0.
  'sce18_finally_on_abrupt_exit_test.dart': (ran: 9, declared: 9),
  // PUBLISH-PIN(sce160_aioc-publish-scd136-and-record-the-corpus-run)
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.119.0.
  // Measured 2026-09-18: 5 of 9 fail against 0.65.0, 0 of 9 against 0.120.0.
  'sce19_do_while_first_body_run_test.dart': (ran: 9, declared: 9),
  // PUBLISH-PIN(sce160_aioc-publish-scd136-and-record-the-corpus-run)
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.120.0.
  // Measured 2026-09-18: 7 of 9 fail against 0.65.0, 0 of 9 against 0.120.0.
  'sce20_braceless_if_else_test.dart': (ran: 9, declared: 9),
  // SCD200's second batch, measured the same way — ported into ztmp and run
  // against 0.65.0 and then against the 0.113.0 working tree.
  //
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.113.0.
  // Measured 2026-09-15: 10 of 12 fail against 0.65.0, 0 of 12 against 0.113.0.
  'stdlib/convert/chunked_sink_arg_adaptation_test.dart': (
    ran: 12,
    declared: 5,
  ),
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.113.0.
  // Measured 2026-09-15: 11 of 22 fail against 0.65.0, 0 of 22 against 0.113.0.
  'stdlib/typed_data/buffer_is_a_getter_test.dart': (ran: 22, declared: 2),
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.113.0.
  // Measured 2026-09-15: 8 of 13 fail against 0.65.0, 0 of 13 against 0.113.0.
  'stdlib/typed_data/float_int_literal_test.dart': (ran: 13, declared: 8),
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.113.0.
  // Measured 2026-09-15: 17 of 25 fail against 0.65.0, 0 of 25 against 0.113.0.
  // RE-MEASURED 2026-09-22 (sce141, `tool/remeasure_pins.dart`): 24 of 32 fail
  // against 0.65.0. The reference file gained seven cases since the pin was
  // taken and every one of them fails too, so the entry stood while its
  // evidence went seven cases out of date — the absorption property this
  // register's header describes, caught by a run rather than by reading.
  'stdlib/typed_data/typed_list_family_parity_test.dart': (
    ran: 32,
    declared: 6,
  ),
  // PUBLISH-BLOCKED, and the port needs `tls_fixture.dart` copied beside it —
  // it is a sibling helper, not an interpreter import, so `port_recipe.dart`
  // has nothing to say about it and a port without it reads as
  // does-not-compile. Re-port when a publish raises exec's floor past 0.113.0.
  // Measured 2026-09-15: 6 of 6 fail against 0.65.0, 0 of 8 against 0.113.0 —
  // the case count itself moves, because two of the eight are skipped against
  // the older interpreter rather than failing.
  // RE-MEASURED 2026-09-22 (sce141): the tool reports does-not-compile, which
  // CONFIRMS the sentence above rather than contradicting it — the tool copies
  // one file and knows nothing about `tls_fixture.dart`, so its verdict here is
  // about the recipe's blind spot, not about the interpreter. The 6-of-6 figure
  // was taken with the fixture placed by hand and is the one to trust.
  // `ran` IS HISTORICAL: this file does not compile against the resolved interpreter,
  // so the number above cannot be confirmed here (measured 2026-09-22, sce143).
  'scd171_tls_bridges_test.dart': (ran: 6, declared: 9),
  // NOT PORTABLE, and not blocked on anything: `dart:mirrors` over *tom_d4rt's
  // own* bridge registry, checking that a constructor adapter reading
  // `namedArgs['x']` is claiming a named parameter the SDK actually declares.
  // exec has a different registry, so a copy would reflect over the reference
  // tree while pretending to measure this one — the same family as the three
  // `stdlib_member_diff.dart` entries below.
  // `ran` IS HISTORICAL: this file does not compile against the resolved interpreter,
  // so the number above cannot be confirmed here (measured 2026-09-22, sce143).
  'scd68_constructor_named_args_test.dart': (ran: 3, declared: 3),
  // NOT PORTABLE, same tool and same reason as the entries above: all three
  // import `tool/stdlib_member_diff.dart`, the `dart:mirrors` reflector over
  // tom_d4rt's registry. Measured 2026-09-15: does-not-compile against both
  // 0.65.0 and 0.113.0, which is what an absent tool looks like from here.
  // `ran` IS HISTORICAL: this file does not compile against the resolved interpreter,
  // so the number above cannot be confirmed here (measured 2026-09-22, sce143).
  'doc/gap_audit_figures_test.dart': (ran: 5, declared: 5),
  // NOT PORTABLE — `tool/stdlib_member_diff.dart`, as above.
  // `ran` IS HISTORICAL: this file does not compile against the resolved interpreter,
  // so the number above cannot be confirmed here (measured 2026-09-22, sce143).
  'scd39_operator_probe_operands_test.dart': (ran: 5, declared: 5),
  // NOT PORTABLE — `tool/stdlib_member_diff.dart` again, and here the tool is
  // the SUBJECT rather than an instrument: the cases render the two baseline
  // sources from synthetic input and analyze the result, and drive the tool as
  // a process to check that `--only` with `--baseline` refuses. exec has
  // neither the tool nor the baselines it writes. pin-registered: n/a —
  // nothing a publish can change.
  // `ran` IS HISTORICAL: this file does not compile against the resolved interpreter,
  // so the number above cannot be confirmed here (measured 2026-09-22, sce143).
  'stdlib/sce86_baseline_renderer_test.dart': (ran: 6, declared: 6),
  // NOT PORTABLE — `tool/stdlib_member_diff.dart`, as above.
  // `ran` IS HISTORICAL: this file does not compile against the resolved interpreter,
  // so the number above cannot be confirmed here (measured 2026-09-22, sce143).
  'stdlib/typed_data/scd167_variant_parity_test.dart': (ran: 4, declared: 4),
  // SCD200's nine, and none of them is a guess: each was ported into ztmp and
  // RUN twice — against the 0.65.0 exec resolves, and against the working tree
  // via `tom_d4rt_flutter_ast/tool/prepublish_overrides.dart --set`. The second
  // run is what makes "publish-blocked" a measurement. Six of them pass
  // completely against the tree and fail against 0.65.0, which is the
  // definition of the condition and is what the pins below record.
  //
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.169.0.
  // Measured 2026-09-15: 1 of 5 fail against 0.65.0, 0 of 5 against 0.113.0.
  // SCE179 added three cases for the value-level entry; they need the release
  // that carries it (0.169.0), which is why the floor moved from 0.113.0.
  'scd147_interpreter_owned_boundary_test.dart': (ran: 8, declared: 6),
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.113.0.
  // Measured 2026-09-15: 2 of 3 fail against 0.65.0, 0 of 3 against 0.113.0.
  'bridge/scd138_native_callback_proxy_binding_test.dart': (
    ran: 3,
    declared: 3,
  ),
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.113.0.
  // Measured 2026-09-15: 1 of 8 fail against 0.65.0, 0 of 8 against 0.113.0.
  'scd176_enum_supertype_test.dart': (ran: 8, declared: 4),
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.113.0.
  // Measured 2026-09-15: 6 of 15 fail against 0.65.0, 0 of 15 against 0.113.0.
  'stdlib/collection/queue_empty_state_error_test.dart': (ran: 15, declared: 2),
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.113.0.
  // Measured 2026-09-15: 8 of 10 fail against 0.65.0, 0 of 10 against 0.113.0.
  // RE-MEASURED 2026-09-22 (sce141): 13 of 20 fail against 0.65.0 — the file
  // doubled in size since the pin and the pin absorbed all of it silently.
  'stdlib/coerce_arguments_test.dart': (ran: 20, declared: 18),
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.113.0.
  // Measured 2026-09-15: 4 of 5 fail against 0.65.0, 0 of 5 against 0.113.0.
  'stdlib/io/internet_address_type_test.dart': (ran: 5, declared: 3),
  // PUBLISH-BLOCKED, AND THE RE-PORT NEEDS A SPLIT FIRST. Re-port when a
  // publish raises exec's floor past 0.113.0. Measured 2026-09-15: 17 of 20
  // fail against 0.65.0, and 1 of 20 still fails against 0.113.0 — F-SCD170-1,
  // which is not a behaviour case at all. It reads
  // `lib/src/stdlib/io/socket.dart` to check that every socket-acquiring native
  // call has a permission gate above it, so ported it resolves that path
  // against a package with no stdlib and dies with PathNotFoundException.
  //
  // So this file is nineteen portable behaviour cases plus one structurally
  // single-copy source scan, and the remedy is SCD157's: split the scan into
  // its own guard, anchor it with `requirePackage('tom_d4rt')`, and port the
  // nineteen. Doing the split NOW would leave nineteen cases that cannot be
  // ported until the publish anyway, so it is recorded here rather than done —
  // but it must happen in the same pass as the re-port, or the re-port will
  // look like a divergence and get baselined as one.
  'scd170_network_permission_gate_test.dart': (ran: 20, declared: 7),
  // NOT PORTABLE, and not blocked on anything. Both of these import
  // `tool/stdlib_member_diff.dart`, the `dart:mirrors` tool that reflects over
  // *tom_d4rt's own* bridge registry — the same reason already recorded above
  // for `stdlib/member_coverage_baseline_test.dart`, which is the third member
  // of this family. exec has no such tool and its subject would be a different
  // registry, so a copy here would measure the reference tree while pretending
  // to measure this one. Measured 2026-09-15: does-not-compile against both
  // 0.65.0 and 0.113.0, which is what "the tool is absent" looks like from
  // here and is why no pin belongs on either.
  // `ran` IS HISTORICAL: this file does not compile against the resolved interpreter,
  // so the number above cannot be confirmed here (measured 2026-09-22, sce143).
  'scd36_return_type_pass_test.dart': (ran: 5, declared: 5),
  // NOT PORTABLE, same tool and same reason as the entry above — SCC13's
  // hierarchy baseline is generated by `tool/stdlib_member_diff.dart` from
  // tom_d4rt's registry, and exec has neither the tool nor that registry.
  // `ran` IS HISTORICAL: this file does not compile against the resolved interpreter,
  // so the number above cannot be confirmed here (measured 2026-09-22, sce143).
  'stdlib/hierarchy_baseline_test.dart': (ran: 6, declared: 6),
  // NOT PORTABLE YET, and the reason is the thing it tests. SCD173's four cases
  // pass a map literal to `ContentType`, `HeaderValue` and
  // `findProxyFromEnvironment`; the coercion that makes those work landed under
  // SCD70 and is NOT PUBLISHED, so against the interpreter this package
  // resolves all four fail with exactly the error they exist to prevent —
  // `type '_Map<Object?, Object?>' is not a subtype of type
  // 'Map<String, String?>?' in type cast`, thrown from
  // `tom_d4rt_ast/src/runtime/stdlib/io/http.dart`.
  //
  // Measured, not assumed: the copy was written, run here, and removed. That
  // failure is the evidence in sce209 that the defect is live in every shipped
  // interpreter, so this entry is a dated record of an unreleased fix rather
  // than a gap in the suite. It comes across when the floor moves.
  'stdlib/io/scd173_collection_args_test.dart': (ran: 4, declared: 4),
  // NOT PORTABLE — and uniquely so: the subject itself cannot exist on the
  // analyzer-free line. `static_name_report.dart` resolves names over the
  // ANALYZER AST, which `tom_d4rt_ast` has no access to by construction, so
  // there is no twin to write rather than one nobody has written yet. The
  // analyzer-free line would get this check at BUNDLE-BUILD time instead (in
  // `tom_ast_generator`, which does have the analyzer), which is arguably the
  // better home for it — a bundle is compiled once on a server and shipped.
  // That is recorded in sce128 rather than assumed here.
  //
  // Exec DOES have an analyzer front end, so a port is possible in principle.
  // It is not written because the pass is REPORT-ONLY: it changes no observable
  // behaviour, so a port would assert that a function exec never calls returns
  // the same list. When the enforcing half lands it changes what `execute()`
  // does, and that is when exec has something to conform about.
  // 11 -> 12: SCE128 added F-SCD95-12 and F-SCD95-13 (a label reference and
  // an extension type's representation are not undefined reads). Both
  // numbers move together because nothing ran: re-measured 2026-09-22
  // against resolved tom_d4rt_ast 0.65.0 by `tool/remeasure_pins.dart
  // --uncovered`, the port still DOES NOT COMPILE — it imports
  // `src/static_name_report.dart`, which resolves over the analyzer AST and
  // has no counterpart in the published interpreter.
  // `ran` IS HISTORICAL: this file does not compile against the resolved interpreter,
  // so the number above cannot be confirmed here (measured 2026-09-22, sce143).
  'scd95_static_name_report_test.dart': (ran: 12, declared: 12),
  // NOT PORTABLE — a throughput probe, not a conformance assertion. Its single
  // case measures how long a Conway generation takes; run on two interpreters
  // with different performance characteristics it yields a flaky failure rather
  // than information. There is nothing here for exec to agree or disagree with.
  //
  // MEASURED 2026-09-15 against resolved 0.65.0: it PASSES. That is not a
  // reason to port it — it is the reason this entry has to be a judgement and
  // not a verdict. The experiment says "portable"; the entry says the port
  // would be a timing assertion on a second interpreter, which is a flake
  // waiting for a slow machine. Keep it, and keep the sentence above, because a
  // future re-measurement will report PASSES again.
  '_conway_perf_probe_test.dart': (ran: 1, declared: 1),
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
  // THE FLOOR DISAGREEMENT IS GONE. SCD186 raised `tom_d4rt` to `^3.10.4` —
  // the version this package, `tom_d4rt_ast` and every other in the repo
  // already declared — and bridged the one member the gap was hiding,
  // `Future.syncValue`. The two packages no longer disagree about which SDK
  // members are in scope, so the reason this file could not be shared has
  // expired.
  //
  // WHAT REMAINS IS THE PUBLISH, and it is a different blocker rather than the
  // same one restated. The file diffs the SDK source against the REGISTERED
  // bridge set, and the set this package gets is whatever `tom_d4rt_ast`
  // published — 0.65.0, which has no `Future.syncValue`. A port today would
  // correctly report a member that exists in the tree and not in the release.
  // Measured 2026-09-15 with `dart run tool/remeasure_pins.dart --uncovered`:
  // does-not-compile against the resolved interpreter, so the port is blocked
  // for its own reason too and not only by the missing member.
  //
  // Re-port when a publish raises exec's floor past 0.108.0.
  // `ran` IS HISTORICAL: this file does not compile against the resolved interpreter,
  // so the number above cannot be confirmed here (measured 2026-09-22, sce143).
  'scc73_sdk_member_completeness_test.dart': (ran: 4, declared: 3),
  // SCD186 bridged `Future.syncValue`, the one SDK member the floor gap was
  // hiding, and this file is its behaviour cover. It cannot be ported yet for
  // the same reason as the entry above: exec measures the PUBLISHED
  // `tom_d4rt_ast`, and 0.65.0 does not have the member.
  //
  // Measured 2026-09-15 with `dart run tool/remeasure_pins.dart --uncovered`:
  // still failing 4 of 5. The one that passes is F-SCD186-4, the CONTROL —
  // it asserts what `Future.value` does and needs no new member. That split is
  // worth having recorded: a future re-port showing 5 of 5 failing would mean
  // something else broke, and showing 1 of 5 would mean only the control ran.
  //
  // Re-port when a publish raises exec's floor past 0.108.0.
  'stdlib/async/scd186_future_sync_value_test.dart': (ran: 5, declared: 5),
  // SCD187 deleted the `HttpClientResponse.transform` stub that was shadowing
  // the working inherited `Stream.transform`. This file is its cover, and it
  // cannot be ported until the deletion ships: exec measures the PUBLISHED
  // `tom_d4rt_ast`, where the stub is still present.
  //
  // Measured 2026-09-15 with `dart run tool/remeasure_pins.dart --uncovered`:
  // still failing 4 of 5 — the same split as the SCD186 entry above, and for
  // the same reason. The one that passes is F-SCD187-4, the CONTROL, which
  // reads the body by folding chunks and never touches `transform`. A later
  // re-port showing 5 of 5 failing would mean the fold broke too.
  //
  // Re-port when a publish raises exec's floor past 0.109.0.
  'stdlib/io/scd187_http_response_transform_test.dart': (ran: 5, declared: 5),
  // SCD189's member-kind parity guard. It reads the SDK with the ANALYZER and
  // diffs it against the registered bridge set — a different registry here, so
  // a port would measure the analyzer-free line's bridges against the same SDK
  // and is a legitimate second measurement rather than a copy. It is blocked
  // on the publish either way: the six kind fixes it was written for
  // (StreamSubscription.onData/onDone/onError as methods, and the three
  // fabricated methods) are in the tree and not in any release, so a port
  // today would report them all.
  //
  // Measured 2026-09-15 with `dart run tool/remeasure_pins.dart --uncovered`:
  // does-not-compile against the resolved interpreter — it imports the stdlib
  // registrars by same-package path, and the port rewrite does not yet carry
  // every one of them. That is a second thing to settle at the re-port, beyond
  // the six findings.
  //
  // Re-port when a publish raises exec's floor past 0.110.0.
  // `ran` IS HISTORICAL: this file does not compile against the resolved interpreter,
  // so the number above cannot be confirmed here (measured 2026-09-22, sce143).
  'stdlib/scd189_member_kind_parity_test.dart': (ran: 3, declared: 3),
  // SCD198 drives scripts through `D4rt.execute` to ask what a bare class name
  // evaluates to. Its three fixes — `BridgedClass` equality and hashing, the
  // hash-key normalisation, and the `is Type` arm — are all in the tree and in
  // no release, so a port would report every case it was written for.
  //
  // Measured 2026-09-15 with `dart run tool/remeasure_pins.dart --uncovered`:
  // still failing 4 of 7. The three that pass are the ones the fix did not
  // change — the `==` reconciliation that already worked, the interpreted
  // path, and `toString`. That split is worth having recorded: at the re-port,
  // 0 of 7 is the expected result and 3 of 7 would mean only the old
  // behaviour still holds.
  //
  // Re-port when a publish raises exec's floor past 0.113.0.
  'scd198_class_name_as_type_value_test.dart': (ran: 7, declared: 7),

  // NOT PORTABLE, and confirmed FROM THE SOURCE rather than by a run — SCD126's
  // first rule, because a structural reason is cheaper to read than to measure
  // and a run would only have restated it. This file imports
  // `../../tool/stdlib_member_diff.dart` and `member_coverage_baseline.dart`;
  // neither exists in this package, and the tool is `dart:mirrors` over
  // `package:tom_d4rt`'s OWN registry (`src/bridge/bridged_types.dart`,
  // `src/unbridged_reasons.dart`, `src/stdlib/core.dart`). exec has no stdlib at
  // all, so a copy here would reflect over the reference tree while presenting
  // the answer as this one's.
  //
  // Same structural reason as `scc73_sdk_member_completeness_test.dart` above,
  // and the same remedy: the analyzer-free line's equivalent has to be BUILT
  // against `tom_d4rt_ast`'s registry, not ported. [2026-09-15]
  // `ran` IS HISTORICAL: this file does not compile against the resolved interpreter,
  // so the number above cannot be confirmed here (measured 2026-09-22, sce143).
  'stdlib/member_coverage_baseline_test.dart': (ran: 4, declared: 13),
  // BLOCKED ON A PUBLISH, and measured rather than inferred — the register above
  // says a pin written from prose rots, so both of these were ported into
  // `test/` and run against published 0.65.0 before being recorded.
  //
  // scd72 needs `InterpretedClass.declaringVisitor`, which lands in published
  // 0.81.0. Ported today: 2 of 7 PASS, and which two is the useful part —
  // F-SCD72-3 (the no-override rail) and -5 (Dart's in-script semantics) hold
  // because they assert behaviour that predates the fix. The five that fail are
  // exactly the five the fix bought.
  //
  // Re-port when a publish raises exec's floor past 0.81.0.
  'scd72_instance_tostring_test.dart': (ran: 7, declared: 7),
  // scd73 does not COMPILE against 0.65.0: six `undefined_function` errors for
  // `unwrapScriptError`, which SCD73 made a public top-level and which lands in
  // published 0.82.0. It cannot be worked around from here: `d4rt.dart`
  // re-exports `package:tom_d4rt_ast/runtime.dart`, so a local public function
  // of that name would become an ambiguous export the day the publish lands.
  // This package's own seam DOES carry SCD73 (SCD74 mirrored it into the third
  // copy of `_executeInEnvironment`), so the behaviour is present here — it is
  // only the helper the test calls that is missing.
  //
  // Re-port when a publish raises exec's floor past 0.82.0.
  // `ran` IS HISTORICAL: this file does not compile against the resolved interpreter,
  // so the number above cannot be confirmed here (measured 2026-09-22, sce143).
  'scd73_no_hook_unwrapping_test.dart': (ran: 8, declared: 8),
  // NOT PORTABLE — `tool/stdlib_member_diff.dart` again, and this file is the
  // one that tests the tool's own classifier. Its four cases plant a wording at
  // a throw site and assert the audit notices, so its subject is the reference
  // tree's tool rather than either interpreter. pin-registered: n/a — nothing
  // a publish can change.
  // `ran` IS HISTORICAL: this file does not compile against the resolved interpreter,
  // so the number above cannot be confirmed here (measured 2026-09-22, sce143).
  'sce77_resolution_throw_sites_test.dart': (ran: 4, declared: 4),
  // NOT PORTABLE — a census over the SDK's own sources, asked on behalf of
  // *tom_d4rt's* bridge registry: it finds every SDK member carrying a generic
  // function parameter (a shape SCD37 established no bridge can honour) and
  // checks the set against the reasons recorded in this tree's stdlib. Copied
  // here it would re-assert the same SDK facts about a package that registers
  // no bridges, which passes and measures nothing. pin-registered: n/a — its
  // subject is not the interpreter.
  //
  // MEASURED 2026-09-22 against resolved 0.65.0: it PASSES, exactly as the
  // sentence above predicts — "which passes and measures nothing" is what a
  // `PASSES NOW` verdict here means, not an available port. Recorded so the
  // next re-measurement meets a note rather than a surprise, which is the same
  // service `_conway_perf_probe`'s entry does.
  'sce76_generic_function_parameter_census_test.dart': (ran: 2, declared: 2),
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.129.0.
  // Measured 2026-09-21: 9 of 61 fail against the 0.65.0 exec resolves — the
  // nine `Queue` / `ListQueue` / `DoubleLinkedQueue` cases where an empty
  // receiver's IndexError or StateError arrives as something no script can
  // catch. The other 52 pass against 0.65.0 and are in the file as controls.
  'stdlib/sce74_sdk_error_type_parity_test.dart': (ran: 61, declared: 2),
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.136.0.
  // Measured 2026-09-21: 6 of 7 fail against the 0.65.0 exec resolves, each
  // with `Undefined static member` for the member it exists to reach —
  // `HttpHeaders.acceptRangesHeader`, `generalHeaders`,
  // `RawSocketOption.levelIPv4`, `Platform.lineTerminator` and
  // `ConnectionTask.fromSocket`. The seventh is F-SCE82-3, which asserts the
  // seventeen constants that were ALREADY bridged and so passes everywhere.
  //
  // THE TREE SIDE COULD NOT BE MEASURED, and the reason is worth carrying
  // here because it blocks the re-port of both entries: under SCD66's
  // pre-publish override exec resolves the 0.136.0 tree and exec's OWN
  // `lib/src/d4rt_base.dart:783` stops compiling — `D4rtRunner.functionTypedefs`
  // returns a wider record in the tree (`requiredPositional` / `maxPositional`,
  // added with the typedef-arity work) than exec's forwarding getter declares.
  // So the publish that frees these two entries also breaks exec until its
  // getter is widened, which cannot be done before the floor moves. Recorded
  // as scf20 rather than as a surprise for whoever runs the next publish.
  'stdlib/io/sce82_header_constants_test.dart': (ran: 7, declared: 7),
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.137.0.
  // SCE83 made `stream.transform(utf8.decoder)` work for a stream a SCRIPT
  // built: those are `Stream<dynamic>` carrying `List<Object?>` chunks, so a
  // decoder rejected them with a host `TypeError` naming an interpreter
  // internal. Measured 2026-09-21: 4 of 7 fail against the 0.65.0 exec
  // resolves, each with `type '_MultiStream<dynamic>' is not a subtype of type
  // 'Stream<List<int>>'` or its `_ControllerStream` / `Stream<String>`
  // variants. The three that pass are the controls — a dart:io stream, a
  // script-defined transformer, and the argument diagnostic — which is what
  // they are for.
  'stdlib/async/sce83_transform_element_coercion_test.dart': (
    ran: 7,
    declared: 7,
  ),
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.138.0.
  // SCE84's behaviour suite: a script declaring the `LinkedListEntry` subclass
  // the SDK requires, which is the only way `LinkedList` is usable at all.
  // Measured 2026-09-21: 11 of 12 fail against the 0.65.0 exec resolves — ten
  // in the implicit `super()` itself, and F-SCE84-12 because the removed
  // `LinkedListEntry(value)` dialect is still accepted there. The twelfth,
  // F-SCE84-11, passes either way: it is the control that hands `add` a
  // string, which is refused by both interpreters.
  'stdlib/collection/sce84_linked_list_subclass_test.dart': (
    ran: 12,
    declared: 12,
  ),
  // SCE101-SCE104: four interpreter fixes made in one session, each measured
  // with `tool/remeasure_pins.dart --candidates` against the resolved 0.65.0
  // before being recorded here. Every one is a silent WRONG ANSWER rather than
  // a crash on the published copy, which is why the failing-case counts are
  // worth reading: the cases that pass against 0.65.0 are the CONTROLS each
  // file carries deliberately, and they pass on both sides by construction.
  //
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.139.0.
  // Measured 2026-09-22: 4 of 9 fail against 0.65.0 - F-SCE101-1, -2, -4 and
  // the -9 agreement case. The element predicate answered `Null`, `dynamic`,
  // `Type` and a wrapped bridged value differently from `is`.
  'sce101_element_type_test.dart': (ran: 9, declared: 9),
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.140.0.
  // Measured 2026-09-22: 7 of 11 fail against 0.65.0. An empty loop body ended
  // the FUNCTION, so the published copy answers null after a for-in and the
  // CONDITION after a C-style for - which is why -2 reports `true` and -3
  // reports the stream's contents rather than both reporting null.
  'sce102_empty_loop_body_async_test.dart': (ran: 11, declared: 11),
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.141.0.
  // Measured 2026-09-22: 6 of 10 fail against 0.65.0. Five are the unchecked
  // typed local; the sixth is F-SCE103-6, which fails with "Bridged class
  // 'Map' has no instance method named 'add'" - the empty-`{}`-in-a-Set-context
  // defect that check surfaced, and independent evidence that it predates the
  // check rather than being caused by it.
  //
  // 10 -> 13: SCE131 added the shapes SCE103 decided about but did not pin -
  // an uninitialised declaration (-11, the exemption; -12, the type it still
  // records), and `final` / `const` / multi-name lists (-13). Re-measured the
  // same day with `tool/remeasure_pins.dart --uncovered`: 8 of 13 fail against
  // 0.65.0, the two new failures being -12 and -13, which is what a published
  // interpreter with no local check should say.
  'sce103_typed_local_test.dart': (ran: 13, declared: 13),
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.142.0.
  // Measured 2026-09-22: 5 of 8 fail against 0.65.0. A failing cast pattern
  // MISSED rather than throwing, so F-SCE104-3 answers 'miss' where the fix
  // binds 'HIT:1.0', and the -4 agreement case reports the cast pattern and
  // the cast expression disagreeing on the very first row.
  'sce104_cast_pattern_test.dart': (ran: 8, declared: 8),
  // NOT PORTABLE, and not blocked on anything: it reads
  // `lib/src/interpreter_visitor.dart` - tom_d4rt's OWN dispatch source - and
  // parses the analyzer's `DartPattern` hierarchy to check every kind has a
  // branch. exec has no such file, so the port dies with
  // `PathNotFoundException` (measured 2026-09-22, 3 of 3). The analyzer-free
  // side of the same question is asked by
  // `tom_d4rt_ast/test/runtime/sce105_pattern_kind_coverage_test.dart`, which
  // derives its kinds from `tom_ast_model` instead - so the gap here is about
  // which tree owns a dispatch, not missing coverage.
  // pin-registered: n/a - nothing a publish can change.
  'sce105_pattern_kind_coverage_test.dart': (ran: 3, declared: 3),
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.143.0.
  // Measured 2026-09-22 with `tool/remeasure_pins.dart --candidates`: 4 of 6
  // fail against 0.65.0. -1 and -2 answer 'fell through' because the published
  // copy raises a `RuntimeD4rtException` the `on` clause cannot select; -6
  // throws the generic-orElse error this fixed; and -5 is the one worth
  // noticing — it fails because the published message still REPLACES the
  // native error rather than leading with it, which is the same divergence
  // `stdlib/bridge_arity_test.dart` records from the other side.
  'sce109_sdk_error_types_test.dart': (ran: 6, declared: 6),
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
  /// down into exec.
  ///
  /// THE COMMON DIRECTION BY A LONG WAY, measured rather than assumed. This
  /// doc comment used to pose a question — none of the four recorded
  /// convergences had gone this way, and the register could not say whether
  /// that meant downstream was rare or merely never worth writing down. SCE64
  /// walked every revision of [_divergentBaseline]: 50 entries have been
  /// removed across five commits, and each of those commits states a
  /// direction. Roughly 45 went downstream, 1 upstream
  /// (`unmodifiable_map_view`), 3 were unions folded up before the port
  /// (`dfub5`/`dfub6`/`dfub13`), and 1 was neither (`bridged_class`, where the
  /// normaliser was fixed instead of either file).
  ///
  /// So the FIRST reading was right: the pairs that needed a written
  /// justification were exactly the counter-intuitive ones, and the empty
  /// downstream column was selection bias, not a finding. Two commits carry
  /// the bulk — SCC44 converged 32 "the moment the reference file was copied
  /// over the exec one", and SCC75 ported 18 at a publish where "ALL EIGHTEEN
  /// PASSED".
  ///
  /// WHAT THAT MEANS FOR THE RULE'S STEP (2), which is why the question was
  /// asked: copying the reference over exec is right about nine times in ten,
  /// and checking is still worth it, because the tenth deleted a real
  /// assertion. SCC7 is the case to keep in mind — one commit, three files,
  /// two of them downstream and one upstream, decided file by file.
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

/// Words a convergence reason shares with no other kind of sentence — the
/// identifiers, type names and file names that say WHICH pair it is about.
///
/// SCE142. `_convergenceLog` records a direction and a reason, and two of its
/// entries once had their reasons written against each other's file. Both were
/// true sentences about SOME file, both entries passed every guard here, and a
/// reader who does not open both reference headers has no way to notice. That
/// is prose standing unchecked in the one register whose whole purpose is to
/// make a decision reviewable.
///
/// WHAT IS EXTRACTED, and it is deliberately narrow: backticked identifiers,
/// anything with an internal capital (`SAstNode`, `RecordTypeAnnotationField`),
/// anything with an underscore (`tom_ast_generator`, `_normalise`), and `.dart`
/// file names. Ordinary English carries none of those, so a reason written in
/// plain prose yields NO terms and is reported as unscoreable rather than as a
/// miss — those are different findings and collapsing them is how a check like
/// this starts firing on correct entries and gets deleted.
///
/// The stop list removes the register's own vocabulary. Without it every reason
/// scores on words like `converged` that say nothing about which pair it is.
const Set<String> _reasonStopWords = {
  'the',
  'and',
  'that',
  'this',
  'these',
  'those',
  'with',
  'from',
  'were',
  'been',
  'being',
  'have',
  'does',
  'file',
  'files',
  'copy',
  'copies',
  'entry',
  'entries',
  'reference',
  'exec',
  'both',
  'side',
  'sides',
  'tree',
  'trees',
  'converged',
  'convergence',
  'ported',
  'port',
  'taken',
  'header',
  'headers',
  'same',
  'shape',
  'reason',
  'which',
  'what',
  'when',
  'whose',
};

Set<String> _distinctiveTerms(String reason) {
  final out = <String>{};
  void add(String w) {
    if (w.length > 3 && !_reasonStopWords.contains(w.toLowerCase())) out.add(w);
  }

  for (final m in RegExp(r'`([^`]+)`').allMatches(reason)) {
    for (final w in RegExp(
      r'[A-Za-z_][A-Za-z0-9_.]*',
    ).allMatches(m.group(1)!)) {
      add(w.group(0)!);
    }
  }
  for (final m in RegExp(
    r'\b[A-Za-z_][A-Za-z0-9_]*(?:\.dart)?\b',
  ).allMatches(reason)) {
    final w = m.group(0)!;
    if (w.endsWith('.dart') ||
        w.contains('_') ||
        RegExp(r'[a-z][A-Z]').hasMatch(w)) {
      add(w);
    }
  }
  return out;
}

/// What fraction of [reason]'s distinctive terms appear in [file], or null when
/// the reason has no distinctive terms and the question cannot be asked.
double? _reasonOverlap(String reason, File file) {
  final terms = _distinctiveTerms(reason);
  if (terms.isEmpty) return null;
  final source = file.readAsStringSync();
  return terms.where(source.contains).length / terms.length;
}

/// Pairs that were divergent and are now converged, with the direction taken.
///
/// F-SCC44-2 checks that every entry is still TRUE — the file exists in both
/// trees, is not in [_divergentBaseline], and the two copies still agree. A log
/// of convergences that have since drifted apart again would be worse than no
/// log, because it reads as a record of settled questions.
///
/// THIS REGISTER IS PART-FULL ON PURPOSE, and the arithmetic behind that is
/// worth stating because the first version of it was wrong. It read "roughly
/// twenty-six pairs converged between SCC44 and SCD22"; walking every revision
/// of [_divergentBaseline] gives 50 removals from a register that opened at 33
/// and stands at 12 — entries have been added and removed repeatedly, so no
/// subtraction of two snapshots recovers the count.
///
/// Every one of those 50 has a direction, because all five convergence commits
/// state one. What only SOME have is a per-FILE citation: ten are named
/// individually and are listed here. The other forty are covered by a group
/// sentence ("32 ... converged the moment the reference file was copied over
/// the exec one", "ALL EIGHTEEN PASSED when ported") which establishes the
/// direction for the batch but names no file, and several of them have since
/// re-diverged and sit in [_divergentBaseline] again. Nothing is recorded here
/// from a diff: a converged file looks the same whichever side won, so reading
/// the outcome cannot recover the decision. New convergences add an
/// entry; sce64 covers reconstructing what can still be established.
///
/// THE REASON IS CHECKED AGAINST THE FILE IT NAMES (SCE142), which is the one
/// thing about this register that was prose standing alone. F-SCE142-1 fails
/// when NONE of a reason's distinctive terms — backticked identifiers,
/// CamelCase, underscored names, `.dart` file names — appears in the reference
/// file the entry is keyed by, and names the entry whose file they do appear
/// in.
///
/// THE OVERLAP ACROSS THE WHOLE REGISTER, measured 2026-09-22 before the check
/// was written, because a guard that fires on correct entries gets deleted:
/// five entries score 1.00, three score 0.50, six yield no distinctive term at
/// all and are unscoreable. The three at 0.50 are correct and their misses are
/// each legitimate — `d4_helpers` quotes exec's imports, `stream_consumer`
/// deliberately names a sibling entry, `bridged_class` names this guard's own
/// `_normalise` — so ZERO is the only gate that does not accuse them.
///
/// AND IT RANKS THE DEFECT IT WAS WRITTEN FOR, which is what the measurement
/// was for. Against the pre-SCD125 text each swapped reason scores 0.00 on the
/// entry it was attached to and 1.00 on the entry it belongs to: not merely
/// detectable but localisable. F-SCE142-2 pins that with the two reasons
/// verbatim, so the control can never become vacuous.
const Map<String, _Convergence> _convergenceLog = {
  // SCE64 reconstructed the entries below from the commits that converged
  // them. Only convergences whose direction the COMMIT MESSAGE states are
  // here; the rule's own hazard is that a converged file looks identical
  // whichever side won, so nothing was read back from the resulting file.
  //
  // A TERMINOLOGY TRAP, recorded because it inverts the answer if missed. The
  // commit prose calls `tom_d4rt` "upstream" — it is upstream in the
  // dependency sense. This enum calls the same event [_Direction.downstream],
  // because the reference is mirrored DOWN into exec. "Taking upstream's
  // wording" in a commit message therefore means `downstream` here.
  // SCE138. The five SCD153 (e9c37c1b1) converged rather than baselined, out
  // of the nine unregistered content divergences it opened exec to find. The
  // classification was already done and measured there — "THE NINE WERE
  // MEASURED, NOT ASSUMED. Each was ported against the resolved interpreter
  // before being classified" — but none reached this register, which is the
  // one place a later reader looks to ask which way a settled question went.
  //
  // ALL FIVE ARE `downstream`, and the commit states it rather than the files
  // implying it: the reference copy was PORTED into exec's spelling and passed,
  // so exec's copy was the one replaced. That distinction matters here because
  // a converged file looks identical whichever side won — this register's own
  // stated hazard — so nothing below was read back from the resulting file.
  'scd69_syntax_rejection_test.dart': _Convergence(
    _Direction.downstream,
    'SCD153 (e9c37c1b1): one of the four that "passed when ported and are '
    'converged rather than baselined". SCE111 (a16fc3afc) later edited both '
    'copies together, which is why this pair is the only one of the five '
    'whose reference side has moved since.',
  ),
  'object_universal_members_test.dart': _Convergence(
    _Direction.downstream,
    'SCD153 (e9c37c1b1): named in the same sentence as scd69 — ported against '
    'the resolved interpreter, passed, converged.',
  ),
  'doc/doc_anchors_test.dart': _Convergence(
    _Direction.downstream,
    'SCD153 (e9c37c1b1): named in the same sentence as scd69 — ported against '
    'the resolved interpreter, passed, converged.',
  ),
  'scc46_native_enum_runtime_type_test.dart': _Convergence(
    _Direction.downstream,
    'SCD153 (e9c37c1b1): the fourth of that sentence. Absent from the nine '
    'sce138 listed, because its divergence was found by the same opening of '
    'exec rather than by the earlier count.',
  ),
  'bridge/d4_helpers_test.dart': _Convergence(
    _Direction.downstream,
    'SCD153 (e9c37c1b1), and the one with a cause of its own: it "converged '
    'once its port recipe gained the core-stdlib import pair", and exec\'s '
    'copy "had also been reaching past the public library to '
    'tom_d4rt_ast/runtime.dart plus an explicit d4.dart, which exec\'s own '
    'd4rt.dart re-exports". A port that imports a different public surface '
    'from its reference is not measuring the same thing — so the repair was '
    'on the exec side, which is what makes this downstream too.',
  ),
  'stdlib/collection/unmodifiable_list_view_test.dart': _Convergence(
    _Direction.downstream,
    'SCC7 (756e47e12) names it: the copy "takes tom_d4rt\'s newer assertions '
    '(the delegating mutators)", whose header had said to flip it at exactly '
    'the publish that commit landed. The reference was the stronger copy.',
  ),
  'stdlib/async/stream_consumer_test.dart': _Convergence(
    _Direction.downstream,
    'SCC7 (756e47e12), the same sentence: this copy took the reference\'s '
    "F-SC4-8 unary onError handler. Named beside unmodifiable_map_view, "
    'which went the other way — one commit, both directions, which is why '
    'a per-file record is worth more than a per-commit one.',
  ),
  'interpreter_test.dart': _Convergence(
    _Direction.downstream,
    'SCC35 (4116884d7) names it: three cases had recorded the OLD behaviour '
    'as a property of the serialized-AST pipeline ("the analyzer\'s parse '
    'error is not thrown"). It is thrown; they assert the diagnostic again '
    "taking the reference's wording, and the file converges to a verbatim "
    'port. Its entry had been described as "the one permanent entry".',
  ),
  'scb11_symbol_literal_test.dart': _Convergence(
    _Direction.downstream,
    'SCC35 (4116884d7) names it: "widened to the reference form".',
  ),
  'bridge/bridged_class_test.dart': _Convergence(
    _Direction.union,
    'NEITHER SIDE WON, and the log has no value for that. SCC35 (7aa21f302): '
    'it "converged once _normalise learned the interpreted_instance.dart '
    'pair, a permanent path-shape difference that would otherwise have '
    'needed a standing entry able to absorb real drift". The files were '
    'never edited — the COMPARISON was wrong. Recorded as union because both '
    'copies survived intact, which is the outcome union describes, but the '
    'mechanism is a third one: the guard was fixed, not the pair.',
  ),
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
  // SCD125 read both headers while mirroring them into tom_d4rt_ast and found
  // these two reasons written against each other's entry. Corrected, and worth
  // noticing rather than quietly fixing: nothing checks the PROSE of a
  // convergence reason, so a swap survives every guard in this file — the log
  // exists to make a direction reviewable, and a reason attached to the wrong
  // file is unreviewable in the most convincing way.
  'dfub5_function_record_runtime_type_test.dart': _Convergence(
    _Direction.union,
    'the exec copy carried an explanation the reference lacked — '
    'tom_ast_generator used to flatten RecordTypeAnnotationField, so a record '
    'ANNOTATION reached the mirror tree carrying only its arity. Folded into '
    'the reference header BEFORE the port was taken, so convergence added '
    'knowledge to both trees instead of deleting it from one.',
  ),
  'dfub6_applied_generic_runtime_types_test.dart': _Convergence(
    _Direction.union,
    'same shape as dfub5: the exec copy recorded that an SAstNode carries no '
    'parent pointer, so the applied return type is captured at declaration '
    'time rather than read back at return time. Folded upstream first, then '
    'ported.',
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
  // `scd146`: SCE177 pruned 85 redundant stdlib `nativeNames` entries, so the
  // reference census now expects 24 entries and asserts that every surviving
  // redundant one is kept for a stated reason (F-SCE177-1). The published
  // interpreter this package resolves still carries all 106, so here the old
  // floor and no F-SCE177-1 stay. SCE178 then removed the Stream bridge's two
  // override entries and emptied `_knownDuplicates`, which the published
  // interpreter still has too, so this copy keeps the old F-SCD146-3/-4
  // expectations as well. Converges at a floor past 0.168.0.
  'scd146_native_names_census_test.dart': _Divergence.deliberate,
  // `scd77`: SCE121 made `is Function` true for every value the interpreter
  // can call — a bridged tear-off included — by giving the `Function` bridge
  // an `isAssignable` that answers with the interpreter's own `Callable`
  // interface. The reference copy's F-SCD77-2 asserts the new `true`; the
  // published interpreter's `Function` bridge declares no `isAssignable`, so
  // here it is still `false` and this copy keeps the old expectation with a
  // PUBLISH-PIN on it. Converges at a floor past 0.151.0.
  'scd77_uri_is_scheme_test.dart': _Divergence.deliberate,
  // SCD153 found these five by opening this suite after three turns that had
  // no reason to — the lag this file's reference-side twin
  // (`tom_d4rt/test/scd153_conformance_drift_mirror_test.dart`) now closes.
  // Every one was PORTED and RUN against the resolved interpreter before being
  // recorded, per the discipline [_pinnedInterpreterFloors] demands; four of
  // the nine unbaselined divergences SCD153 measured passed when ported and
  // were converged instead of landing here.
  //
  // `scc20`: TWO sanctioned differences now. SCE127 added the second — the
  // reference copy's F-SCC20-16 asserts that an unresolvable `on` type is an
  // ERROR naming the type and the exception in flight, while the published
  // interpreter still logs a warning and lets the clause MISS, so this copy
  // keeps `equals('fell-through')`. Converges at a floor past 0.154.0, the
  // same publish the `_uncoveredBaseline` entry for
  // `sce127_dead_on_clause_test.dart` waits on, and the floor this entry
  // is registered at because it is the LATER of the two. The first
  // difference, which converges at 0.79.0:
  // the reference copy asserts `['bad', 'src', 2]` from a caught
  // `FormatException`; the published interpreter answers `['bad', null, null]`
  // because its bridge reads `source` and `offset` out of namedArgs while the
  // SDK constructor takes all three positionally. SCD68 fixed the adapter.
  // Converges at a floor past 0.79.0.
  'scc20_catch_clause_type_test.dart': _Divergence.deliberate,
  // `list_queue`: the reference copy expects the SDK's `StateError` from
  // `removeFirst` on an empty queue; the published interpreter still throws
  // `RuntimeD4rtException: Cannot removeFirst from an empty ListQueue.`, the
  // hand-written message SCD30 removed. A script written `on StateError` does
  // not catch it there. Converges at a floor past 0.68.0.
  'stdlib/collection/list_queue_test.dart': _Divergence.deliberate,
  // `queue`: the same SCD30 retarget on the `Queue` bridge — published answers
  // `RuntimeD4rtException: Cannot removeFirst from an empty queue.` where the
  // reference copy expects `StateError` containing 'No element'. Converges at a
  // floor past 0.68.0.
  'stdlib/collection/queue_test.dart': _Divergence.deliberate,
  // `cast_from_family`: the reference copy carries SCD37's whole `newSet`
  // section — 111 lines this copy has never had — asserting that the one
  // bridged member taking a GENERIC function argument rejects it rather than
  // accepting and ignoring it. Ported, its first case answers false against the
  // published interpreter. Converges at a floor past 0.70.0.
  'stdlib/cast_from_family_test.dart': _Divergence.deliberate,
  // `scc12`: the only one of the five that does not fail — it HANGS. Ported and
  // run, it span at 100% CPU for twelve minutes before being killed, so the
  // published interpreter does not merely answer differently about `await` in a
  // `finally`, it does not terminate. That makes this the most expensive entry
  // to re-port carelessly: `dart test` has no wall-clock kill for a
  // non-yielding isolate, and the run has to be killed by hand. Converges at a
  // floor past 0.103.0.
  //
  // SCE141 CONFIRMED THE HANG and stopped it costing a whole run. A full
  // re-measurement of `_pinnedInterpreterFloors` on 2026-09-22 stalled HERE for
  // eighteen minutes with twenty entries still to go, because the tool inherited
  // the same absence of a wall-clock kill this entry describes. It now imposes
  // its own four-minute per-entry deadline and reports `HANGS` — a verdict of
  // its own, deliberately not folded into `does-not-compile`, because nothing
  // was measured. This entry is the reason that deadline exists.
  //
  // SCD168 widened the gap on purpose. The reference copy gained F-SCD168-1..4,
  // four cases asserting that an `on String` clause in an ASYNC body does not
  // catch a `FormatException` — the one shape SCD41's eleven cases do not
  // reach, since every one of those dispatches on an `Error` subclass. They sit
  // beside the SCD41 group they extend rather than in a file of their own,
  // because a new reference file with no counterpart here would cost an
  // `_uncoveredBaseline` entry, and this file is already the entry that says
  // why it cannot be ported yet. Nothing was added to this copy: the whole
  // point of the entry above is that running this file against the published
  // interpreter does not terminate.
  //
  // SCD169 widened it again, by eight cases, and this time the gap is not a
  // choice: the fix they pin landed in `tom_d4rt_ast` 0.103.0 and this package
  // resolves the published interpreter, on which those scripts SPIN. Porting
  // them now would not fail here, it would hang the suite with no Dart-level
  // timeout able to stop it — the precise hazard the entry above already
  // describes, made worse. They come across with the rest of this file when
  // the floor moves.
  //
  // SCE78 widened it a third time, by eight cases, for the same reason and not
  // as a choice. They pin `try { throw X } finally { return 5; }`, which the
  // published interpreter does not answer wrongly — it HANGS, because the
  // machine jumped back to the top of the finally that had just issued the
  // return and did it again. Porting them now would wedge this suite exactly
  // as the SCD169 batch would. The fix landed in `tom_d4rt_ast` 0.132.0.
  //
  // SCE79 widened it a fourth time, by ten cases, and these would FAIL here
  // rather than hang: the published interpreter binds a catch clause's
  // exception variable in the FUNCTION's environment, so it outlives the block
  // and overwrites a caller's local of the same name. That is the defect they
  // pin, and it is still present in 0.65.0. The fix landed in `tom_d4rt_ast`
  // 0.133.0.
  //
  // SCE80 widened it a fifth time, by fifteen cases, and these would also FAIL
  // here rather than hang: the published interpreter stores an
  // `AsyncSuspensionRequest` as the element for every `await` in a collection
  // literal, so the assertions about CONTENTS are exactly what it cannot
  // satisfy. The fix landed in `tom_d4rt_ast` 0.134.0.
  //
  // SCE81 widened it a sixth time, by ten cases, and these would FAIL here too:
  // the published interpreter cannot give a cascade section an awaited
  // argument at all — it raises `type 'AsyncSuspensionRequest' is not a
  // subtype of type '(List<Object?>, Map<String, Object?>)'`, an internal cast
  // error. The fix landed in `tom_d4rt_ast` 0.135.0.
  'scc12_await_in_finally_test.dart': _Divergence.deliberate,
  // `scd4_await_for_break`: SCE16 made `await for` lazy in the reference tree —
  // one `StreamIterator.moveNext()` per element, with the iterator cancelled
  // when the loop is left — and added two cases the published interpreter
  // cannot pass. F-SCE16-1 loops over `Stream.periodic`, which under the old
  // `stream.toList()` implementation never completes, so that case does not
  // fail against 0.65.0, it HANGS; F-SCE16-2 asserts the body runs between
  // elements rather than after all of them. Converges at a floor past 0.116.0,
  // the version the commit carrying SCE16 declares — a publish sce162 blocks.
  // Registered in [_pinnedInterpreterFloors] so F-SCC43-1 can retire it when
  // that lands; before SCE68 it was pinned here in prose and nowhere else.
  'scd4_await_for_break_test.dart': _Divergence.deliberate,
  // The reference copy's four `(legacy)` cases reach into the analyzer `D4rt`'s
  // own environment chain — `enclosing`, the static warm-parent cache keyed on
  // the allowed-set signature — and measured here they fail, because the exec
  // `D4rt` is a WRAPPER that forwards `providePackage` / `allowedPackages` to
  // an inner `D4rtRunner` and holds no chain of its own. What this copy pins is
  // therefore a different contract: that the forwards expose the runner's
  // behaviour faithfully through the wrapper. Neither copy can be the other.
  'warm_parent_package_pool_test.dart': _Divergence.necessary,
  // SCD171 changed the reference copy's F-SCC65-23: bridging `X509Certificate`
  // made a parameter annotation naming it start being CHECKED, so the case's
  // fabricated `'cert'` string no longer type-matches and the script now passes
  // a null through a nullable annotation. That is a divergence in the same
  // direction as the one below — each copy describes its own package — and it
  // moves this entry's fingerprint without changing why the entry exists.
  //
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
  // SCD119 found this one SELF-INFLICTED and registered it the same day. The
  // two copies were byte-identical until SCD92 (tom_d4rt_ast 0.87.0) tightened
  // the binding check to compare declared TYPE ARGUMENTS, not just base types.
  // F-SCC29-21 pinned the old limit — `f(List<String> xs)` accepting `f([1])`
  // and returning 1 — so the reference copy had to be rewritten to expect a
  // `TypeError`, and the exec copy was not.
  //
  // That asymmetry is correct rather than an oversight to repair by copying:
  // this tree runs the PUBLISHED interpreter (0.65.0 today), where the
  // permissive result really is what happens, and the exec copy PASSES
  // asserting it. Porting the reference version now would make a green suite
  // red about a behaviour nobody is running — DGUC6. The entry in
  // [_pinnedInterpreterFloors] is what makes the flip condition
  // machine-checkable instead of remembered.
  //
  // MEASURED 2026-09-14 against resolved 0.65.0 by
  // `dart run tool/remeasure_pins.dart`: 25 of 26 pass, and the one that fails
  // is F-SCC29-21 — `expected throws TypeError, returned 1`, which is the
  // permissive result this copy asserts. So the pin is a measurement, not a
  // restatement.
  //
  // Re-port when a publish raises exec's floor past 0.87.0.
  'scc29_parameter_type_check_test.dart': _Divergence.deliberate,
  // SCE73 re-pointed `I-MISC-335` (tear-off of an ABSENT INSTANCE METHOD)
  // from the invented `RuntimeD4rtException` to the SDK type real Dart
  // raises for it, asserted the way a script would — an interpreted
  // `try` / `on NoSuchMethodError` whose recovery path returns a value the
  // test reads. `I-MISC-336`, the static tear-off one word away, became its
  // control and asserts `isNot(isA<NoSuchMethodError>())`: a missing static
  // is a COMPILE error in Dart, so SCE67 withheld the supertype there on
  // purpose and the two cases must keep landing on opposite sides.
  //
  // Ported and RUN against the resolved 0.65.0 before being recorded, per the
  // discipline the header demands. The script-level case answers `escaped`
  // rather than `caught`, and the host-side throw is an
  // `UndefinedMemberD4rtException` with `is NoSuchMethodError` false — SCE67's
  // supertype is in the working tree and has not shipped, so this copy cannot
  // assert it yet. The control half already passes there and is not what
  // pins this.
  //
  // Re-port when a publish raises exec's floor past 0.125.0.
  'interpreter2_test.dart': _Divergence.deliberate,
  // SCE84 made `LinkedListEntry` subclassable — the SDK's implicit
  // zero-argument constructor in place of a value-taking one — and removed the
  // `LinkedListEntry(value)` constructor and the `value` getter, neither of
  // which the SDK has. Every script in both reference files now declares
  // `class E extends LinkedListEntry<E>`, which is the only way the SDK type
  // is usable; against the interpreter this package resolves, that declaration
  // fails in its own implicit `super()`.
  //
  // Measured 2026-09-21 against the resolved 0.65.0 by porting each file with
  // `tool/remeasure_pins.dart --candidates`: 11 of 13 cases fail in
  // `linked_list_test`, every one with `Error during implicit bridged super
  // constructor: Constructor LinkedListEntry(value) expects one positional
  // argument`, and 3 of 13 in `scc74_member_axis_gaps` — that file's other ten
  // cases are about unrelated classes and pass either way.
  //
  // PUBLISH-BLOCKED, and expect the exec copies to need the same rewrite
  // rather than a plain copy: their text asserts a dialect that will no longer
  // exist.
  //
  // 11 of 13 cases here fail when ported, every one with `Error during
  // implicit bridged super constructor`. Re-port when a publish raises exec's
  // floor past 0.138.0.
  'stdlib/collection/linked_list_test.dart': _Divergence.deliberate,
  // 3 of 13 cases here fail when ported — this file's other ten are about
  // unrelated classes and pass either way. Re-port when a publish raises
  // exec's floor past 0.138.0.
  'stdlib/scc74_member_axis_gaps_test.dart': _Divergence.deliberate,
  // SCE91. The reference asserts that `sub.onError(handler)` runs the handler,
  // which it does in the working tree. This package resolves `tom_d4rt_ast`
  // 0.65.0, where `onError` is registered as a SETTER rather than a method —
  // SCD189 moved it, landing in 0.110.0 — so the call fails with "has no
  // instance method named 'onError'" and the ported case asserted a behaviour
  // the published interpreter does not have.
  //
  // Pinned as the published behaviour rather than skipped: it goes red at the
  // publish that fixes it and prompts the re-port, where a skip would measure
  // nothing and sit here indefinitely. The case name in the exec copy says
  // what that copy asserts — a name claiming the reference's outcome over the
  // opposite assertion is the defect SCD50 and SCE89 exist to stop.
  //
  // PUBLISH-BLOCKED. Re-port when a publish raises exec's floor past 0.110.0.
  'scb9_error_handler_arity_test.dart': _Divergence.deliberate,
  // SCE109: `stdlib/bridge_arity_test.dart`. SCB28's five too-few cases assert
  // `isNot(contains('RangeError'))` here, and the reference copy now asserts
  // the opposite. Both are right about the interpreter they run against: SCB28
  // restated an adapter's short-argument `RangeError` as an arity failure AND
  // replaced its TYPE, which is what the published copy still does; SCE109 kept
  // the restatement and preserved the type, because the two readings are
  // indistinguishable at the dispatch boundary and losing the type stopped
  // `on RangeError` catching a script's own out-of-range read.
  //
  // F-SCB28-5 is NOT part of the divergence and is identical on both sides —
  // it reaches a per-adapter guard, so no native error was ever raised there to
  // preserve. Re-port when a publish raises exec's floor past 0.143.0.
  'stdlib/bridge_arity_test.dart': _Divergence.deliberate,
};

/// The difference each [_divergentBaseline] entry actually sanctions.
///
/// SCD154. Keyed by the same path, one entry each, and F-SCC6-4 asserts the two
/// key sets are equal — so a new baseline entry cannot arrive without a
/// fingerprint, which is the only thing that makes the exemption specific.
///
/// WHY A PARALLEL MAP RATHER THAN A SECOND FIELD ON THE VALUE, since the todo
/// asked for the latter. The entry syntax `'path': _Divergence.kind,` is parsed
/// as TEXT by three things: [_entryComments] here (which F-SCC44-2 asserts
/// against the declared map), [_floorsDeclaredInComments], and
/// `tom_d4rt/test/scd153_conformance_drift_mirror_test.dart`, which reads this
/// map from the other package. Widening the value to a constructor call moves
/// it onto its own line under the formatter and silently disarms every one of
/// them — which is the exact failure F-SCC44-2 exists to catch, introduced by
/// the change meant to tighten the map. A parallel map with an asserted key set
/// is the same guarantee at none of that risk.
///
/// TO RECOMPUTE ONE: run this suite. F-SCC6-4 prints the observed fingerprint
/// beside the recorded one and you paste it in — deliberately the same
/// mechanism [_pinnedInterpreterFloors] uses, and deliberately an act, because
/// an exemption that widens itself for free is what SCD154 was filed about.
/// Recomputing without reading the new difference is the failure mode; the
/// message says so.
const Map<String, String> _divergenceFingerprints = <String, String>{
  'scd146_native_names_census_test.dart': '132f7b21983f99e4',
  'scd77_uri_is_scheme_test.dart': '7157029405e6bfda',
  'scb9_error_handler_arity_test.dart': 'd880f1617d543ff7',
  'scc20_catch_clause_type_test.dart': '1f778a50235ef954',
  'stdlib/collection/list_queue_test.dart': '927a588334725bb2',
  'stdlib/collection/queue_test.dart': '19eee099a23916a8',
  'stdlib/cast_from_family_test.dart': 'c7a32ccddec5a069',
  'scd4_await_for_break_test.dart': '9d8fdd67890791db',
  'scc12_await_in_finally_test.dart': '38e7d44709353640',
  'warm_parent_package_pool_test.dart': '971b6ff19185f442',
  'stdlib/intentionally_unbridged_test.dart': 'a11036cda720efcf',
  'scc31_undefined_name_uncatchable_test.dart': '5cbda0053357426b',
  'scc32_bridged_value_key_test.dart': '0a2b0b334d6eedaf',
  'scc33_unhandled_node_test.dart': '1be2b48d0784ff46',
  'scc29_parameter_type_check_test.dart': 'a4c38e44ee9853e1',
  // SCE84's two, recorded with the entries in `_divergentBaseline` above.
  'stdlib/collection/linked_list_test.dart': 'a29fd59a29499657',
  'stdlib/scc74_member_axis_gaps_test.dart': 'ff858ca3ac01f2c4',
  'interpreter2_test.dart': '072dd1096b1d280c',
  'stdlib/bridge_arity_test.dart': '51056fbde720e4dd',
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
/// TO ADD AN ENTRY: record the version here, AND write the condition in a `//`
/// comment run immediately above the baseline entry itself, in this form:
///
///     // Re-port when a publish raises exec's floor past 0.87.0.
///     'scc29_parameter_type_check_test.dart': _Divergence.deliberate,
///
/// The wording around it is free; `floor past X.Y.Z` is what
/// [_floorsDeclaredInComments] reads. ABOVE THE ENTRY is the load-bearing part
/// — the same sentence in this header doc comment is narrative, attributable to
/// no entry, and therefore unchecked.
///
/// The guard enforces the pairing in three directions, and SCD122 added the
/// third because the other two could both hold over nothing. A key that no
/// longer names a live baseline entry fails as a stale register; a comment
/// naming a floor with no key here fails as an unregistered obligation; and a
/// key whose entry carries no such comment fails as an invisible one. That last
/// direction is what makes the scan non-empty, and a scan that finds nothing
/// passes every assertion built on it — which is exactly what this block was
/// doing until SCD122 measured it. None of the three is optional: a register
/// allowed to drift from the prose is back to being prose, and prose nobody can
/// attribute to an entry is back to being invisible.
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
/// THE RUN IS A COMMAND (SCD124), because at seven entries a five-step manual
/// recipe per entry is enough friction not to do, and not doing it is how the
/// six went stale:
///
///     dart run tool/remeasure_pins.dart
///
/// It ports each twin against the RESOLVED interpreter in a scratch copy under
/// the workspace `ztmp` — never in the tree — and prints `still-failing`,
/// `does-not-compile` or `PASSES NOW` per entry, with the failing case ids and
/// their observed-vs-expected values. Paste those into the entry comment: a pin
/// carrying a measurement is re-checkable, a pin carrying a restatement is how
/// this register went stale the first time.
///
/// NON-EMPTY AGAIN SINCE 2026-09-13 (SCD74), holding the two entries SCD72 and
/// SCD73 created in the sibling tree. Both were ported and RUN against the
/// published copy before being recorded, which is the discipline the paragraph
/// above demands; scd72 splits 2/7 and scd73 does not compile at all.
///
/// It was EMPTY AS OF 2026-09-06, and that emptiness was the register working
/// rather than the register being unused. SCC75 published `tom_d4rt_ast` 0.55.0 and
/// raised exec's floor to it; F-SCC43-1 then produced the re-port checklist —
/// all eighteen entries this map held — and every one of them passed when
/// ported. Not one had gone stale, which is the opposite of what SCC44 found
/// and is worth recording: SCC44's six stale pins had been written from prose,
/// while these eighteen were each measured against the published copy before
/// being pinned. Measure before pinning and the pin survives; infer it and it
/// rots.
/// A pinned baseline entry: the interpreter release that will make it
/// re-portable, and the release its verdict was last MEASURED against.
///
/// SCE141. [floor] alone answers WHEN an entry becomes reviewable, and
/// F-SCC43-1 fires the moment exec's floor passes it. It cannot answer whether
/// the entry was ever TRUE — SCC44 found six of seven pins that had been
/// passing for a full release, each written from prose describing a
/// working-tree behaviour that had in fact already shipped, and the floor never
/// moved for any of them.
///
/// Only a run answers that, `tool/remeasure_pins.dart` is that run, and it
/// takes minutes — so it stays manual and what becomes machine-checkable is the
/// AGE OF ITS EVIDENCE. [measured] is the resolved interpreter the verdict was
/// taken against; F-SCE141-1 fails when the suite resolves something newer,
/// which is the same move SCC43 made for the flip condition one level down.
///
/// WHY A RECORD HERE WHEN [_divergenceFingerprints] IS A PARALLEL MAP. That
/// decision is recorded a few hundred lines above and its reasoning is sound,
/// so the divergence is worth stating rather than leaving to look like an
/// oversight: widening `_divergentBaseline`'s value would have moved its
/// entries onto two lines under the formatter and silently disarmed THREE text
/// parsers that read that map — [_entryComments], [_floorsDeclaredInComments],
/// and `tom_d4rt/test/scd153_conformance_drift_mirror_test.dart` from the other
/// package.
///
/// This map has ONE text reader, `tool/remeasure_pins.dart`, and it was edited
/// in the same change — its pattern now crosses the newline the formatter
/// inserts, and it was confirmed to parse all 47 entries afterwards.
/// [_floorsDeclaredInComments] reads the KEY line and ignores everything after
/// it, by construction and for exactly this reason, so it is unaffected. A
/// parallel map would have bought nothing here and cost a second key set to
/// keep in step — which is the trade that paragraph makes in the other
/// direction, on a map with three readers instead of one.
typedef _Pin = ({String floor, String measured});

/// RE-MEASURED IN FULL 2026-09-22 (sce141), against the resolved 0.65.0 — the
/// first complete run of this register since it grew past three entries, and
/// the answer that matters is a NEGATIVE one: 42 still-failing, 4
/// does-not-compile, 1 HANGS, and **zero PASSES NOW**. Not one pin was stale.
/// That is worth recording precisely because SCC44 found the opposite ratio
/// (six of seven) on the register's predecessor: the discipline of measuring an
/// entry before writing it, which this file has demanded since, is holding.
///
/// TWO ENTRIES HAD DRIFTED ANYWAY, in the way a floor check cannot see: their
/// reference files had grown and the pins absorbed the new cases silently.
/// `typed_list_family_parity` went 17-of-25 to 24-of-32 and `coerce_arguments`
/// 8-of-10 to 13-of-20 — still wholly failing, so still justified, but their
/// recorded evidence was seven and ten cases out of date. Both are re-stamped
/// above their entries in `_uncoveredBaseline`.
const Map<String, _Pin> _pinnedInterpreterFloors = <String, _Pin>{
  // SCE177, pinned at the release carrying the prune.
  'scd146_native_names_census_test.dart': (
    floor: '0.168.0',
    measured: '0.65.0',
  ),
  'sce127_dead_on_clause_test.dart': (floor: '0.154.0', measured: '0.65.0'),
  // SCE139, pinned at the release carrying the fix rather than at a later
  // working-tree version.
  'sce139_multi_await_resumption_test.dart': (
    floor: '0.157.0',
    measured: '0.65.0',
  ),
  // SCE121 gave the `Function` bridge an `isAssignable` that answers with
  // the interpreter's own `Callable`, so `is Function` is true for a bridged
  // tear-off from this release on.
  'scd77_uri_is_scheme_test.dart': (floor: '0.151.0', measured: '0.65.0'),
  // SCE91, pinned at the release that moved `StreamSubscription.onError` from
  // a setter to a method rather than at a working-tree version.
  'scb9_error_handler_arity_test.dart': (floor: '0.110.0', measured: '0.65.0'),
  // SCE21's batch. Unlike SCD200's, these are pinned at the version each fix
  // ACTUALLY landed in rather than at one conservative working-tree version:
  // the four commits are known (0.117.0, 0.118.0, 0.119.0, 0.120.0), so the
  // earliest release carrying each is not a guess here. A pin that is later
  // than it needs to be keeps an available port out of reach.
  // SCE16's `await for` laziness, pinned by SCE68 — it was PROSE-pinned in
  // `_divergentBaseline` ("Converges when the interpreter carrying SCE16
  // publishes") and registered nowhere, which is the gap F-SCE68-1 closes.
  // 0.116.0 is the version the commit carrying SCE16 declares, not a
  // conservative guess.
  'scd4_await_for_break_test.dart': (floor: '0.116.0', measured: '0.65.0'),
  'sce17_await_in_expression_body_test.dart': (
    floor: '0.117.0',
    measured: '0.65.0',
  ),
  'sce18_finally_on_abrupt_exit_test.dart': (
    floor: '0.118.0',
    measured: '0.65.0',
  ),
  'sce19_do_while_first_body_run_test.dart': (
    floor: '0.119.0',
    measured: '0.65.0',
  ),
  'sce20_braceless_if_else_test.dart': (floor: '0.120.0', measured: '0.65.0'),
  // SCE73's re-point. 0.125.0 is the version the commit giving
  // `UndefinedMemberD4rtException` its `NoSuchMethodError` supertype
  // declares, confirmed against the commit before it, not a conservative
  // working-tree guess.
  'interpreter2_test.dart': (floor: '0.125.0', measured: '0.65.0'),
  // SCD200's second batch, all measured against the working tree before
  // pinning, all at the same 0.113.0 for the same conservative reason.
  'stdlib/convert/chunked_sink_arg_adaptation_test.dart': (
    floor: '0.113.0',
    measured: '0.65.0',
  ),
  'stdlib/typed_data/buffer_is_a_getter_test.dart': (
    floor: '0.113.0',
    measured: '0.65.0',
  ),
  'stdlib/typed_data/float_int_literal_test.dart': (
    floor: '0.113.0',
    measured: '0.65.0',
  ),
  'stdlib/typed_data/typed_list_family_parity_test.dart': (
    floor: '0.113.0',
    measured: '0.65.0',
  ),
  'scd171_tls_bridges_test.dart': (floor: '0.113.0', measured: '0.65.0'),
  // SCD200's six clean publish blocks plus scd170, all measured against the
  // working tree before pinning: each PASSES there and fails against the
  // 0.65.0 exec resolves. 0.113.0 is the working-tree version rather than the
  // earliest release containing each fix, which this pass did not determine —
  // the conservative choice, for the reason the SCD153 entries above give.
  // scd170 is pinned with them and carries one extra condition on its baseline
  // entry: a source-scanning case has to be split out before the re-port.
  'scd147_interpreter_owned_boundary_test.dart': (
    floor: '0.169.0',
    measured: '0.65.0',
  ),
  'bridge/scd138_native_callback_proxy_binding_test.dart': (
    floor: '0.113.0',
    measured: '0.65.0',
  ),
  'scd176_enum_supertype_test.dart': (floor: '0.113.0', measured: '0.65.0'),
  'stdlib/collection/queue_empty_state_error_test.dart': (
    floor: '0.113.0',
    measured: '0.65.0',
  ),
  'stdlib/coerce_arguments_test.dart': (floor: '0.113.0', measured: '0.65.0'),
  'stdlib/io/internet_address_type_test.dart': (
    floor: '0.113.0',
    measured: '0.65.0',
  ),
  'scd170_network_permission_gate_test.dart': (
    floor: '0.113.0',
    measured: '0.65.0',
  ),
  // SCD153's five, all measured against the resolved interpreter before being
  // pinned — and RE-PINNED by SCE107 at the release each fix actually landed
  // in. They stood at 0.100.0, the working-tree version of the day, which that
  // todo recorded as the conservative choice because it had not determined the
  // real ones. They ARE determinable: each divergence names the todo that
  // closed it, and `tom_d4rt_ast/CHANGELOG.md` says which version heading that
  // todo sits under.
  //
  //     scc20             scd68        0.79.0
  //     list_queue        scd30_aidb   0.68.0
  //     queue             scd30_aidb   0.68.0
  //     cast_from_family  scd37_aidc   0.70.0
  //     scc12             scd169       0.103.0
  //
  // FOUR WERE TOO LATE AND ONE WAS TOO EARLY, which is why this was worth
  // measuring rather than leaving conservative. The paragraph this replaces
  // named both costs — a late pin delays the checklist by a release, an early
  // one "produces a checklist that fails and teaches the next reader to
  // distrust the register" — and `scc12` was the second kind: its fix landed
  // in 0.103.0, so at any publish between 0.100.0 and 0.103.0 the checklist
  // would have called for a re-port that does not fail but HANGS, for twelve
  // minutes, with no Dart-level timeout. The entry's own prose already said
  // 0.103.0; only the register disagreed.
  //
  // The two queue entries are what SCE107 was about. At 0.100.0, any publish
  // from 0.68.0 up would have carried exec past the behaviour change WITHOUT
  // producing a checklist, and the two tests would have gone red with nothing
  // saying why — which is precisely the outcome that todo existed to prevent.
  // TWO differences since SCE127; the LATER floor is the binding one,
  // because the entry can only retire when both have converged. The
  // SCD68 half converges at 0.79.0.
  'scc20_catch_clause_type_test.dart': (floor: '0.154.0', measured: '0.65.0'),
  'stdlib/collection/list_queue_test.dart': (
    floor: '0.68.0',
    measured: '0.65.0',
  ),
  'stdlib/collection/queue_test.dart': (floor: '0.68.0', measured: '0.65.0'),
  'stdlib/cast_from_family_test.dart': (floor: '0.70.0', measured: '0.65.0'),
  // Re-port this one LAST and expect to babysit it: ported against 0.65.0 it
  // hangs rather than failing, so a green checklist run cannot be assumed.
  'scc12_await_in_finally_test.dart': (floor: '0.103.0', measured: '0.65.0'),
  // SCD74 measured both of these against published 0.65.0 before pinning them.
  // When the floor reaches either version, F-SCC43-1 produces the re-port
  // checklist — and re-measure BOTH, not just the one that came due.
  'scd72_instance_tostring_test.dart': (floor: '0.81.0', measured: '0.65.0'),
  'scd73_no_hook_unwrapping_test.dart': (floor: '0.82.0', measured: '0.65.0'),
  // SCD186 raised `tom_d4rt`'s SDK floor to `^3.10.4`, removing the
  // disagreement that made this file unshareable, and bridged the member the
  // gap was hiding. What is left is the publish: the file diffs the SDK against
  // the REGISTERED bridge set, and 0.65.0 has no `Future.syncValue`. Measured
  // does-not-compile against the resolved interpreter on 2026-09-15 before
  // being pinned. 0.108.0 is the working-tree version carrying the member —
  // the conservative choice, per the SCD153 entries above.
  'scc73_sdk_member_completeness_test.dart': (
    floor: '0.108.0',
    measured: '0.65.0',
  ),
  // Same publish, same floor: this is SCD186's behaviour cover for the member
  // 0.108.0 adds. Recorded together so the re-port checklist produces both.
  'stdlib/async/scd186_future_sync_value_test.dart': (
    floor: '0.108.0',
    measured: '0.65.0',
  ),
  // SCD187's cover for the stub deletion — same publish family, one release
  // later because the deletion landed after the floor raise.
  'stdlib/io/scd187_http_response_transform_test.dart': (
    floor: '0.109.0',
    measured: '0.65.0',
  ),
  // SCD189's six kind fixes ship in 0.110.0; its guard reports every one of
  // them against anything older.
  'stdlib/scd189_member_kind_parity_test.dart': (
    floor: '0.110.0',
    measured: '0.65.0',
  ),
  // SCD198's three fixes ship in 0.113.0.
  'scd198_class_name_as_type_value_test.dart': (
    floor: '0.113.0',
    measured: '0.65.0',
  ),
  // SCD92 shipped the applied-type-argument check in 0.87.0. At that floor,
  // re-port F-SCC29-21 from the reference copy (it expects a `TypeError`), and
  // check whether `scd92_applied_parameter_type_test.dart` should come with it
  // — the reference file has no counterpart here at all, which is F-SCC6-2's
  // business rather than this register's.
  'scc29_parameter_type_check_test.dart': (floor: '0.87.0', measured: '0.65.0'),
  // SCE74 and SCE82, each pinned at the release its fix actually landed in
  // rather than at a conservative working-tree version: SCE74's narrowing of
  // the `ArgumentError` catch in `BridgedMethodCallable` is 0.129.0, and
  // SCE82's static-member bridging is 0.136.0. Both measured against the
  // resolved 0.65.0 with `tool/remeasure_pins.dart --candidates` before being
  // written here.
  'stdlib/sce74_sdk_error_type_parity_test.dart': (
    floor: '0.129.0',
    measured: '0.65.0',
  ),
  'stdlib/io/sce82_header_constants_test.dart': (
    floor: '0.136.0',
    measured: '0.65.0',
  ),
  // SCE84, pinned at the release carrying the fix rather than at a
  // conservative working-tree version, and all three measured against the
  // resolved 0.65.0 before being written here.
  'stdlib/collection/linked_list_test.dart': (
    floor: '0.138.0',
    measured: '0.65.0',
  ),
  'stdlib/scc74_member_axis_gaps_test.dart': (
    floor: '0.138.0',
    measured: '0.65.0',
  ),
  'stdlib/collection/sce84_linked_list_subclass_test.dart': (
    floor: '0.138.0',
    measured: '0.65.0',
  ),
  // SCE83, owed from the todo before it and measured the same way.
  'stdlib/async/sce83_transform_element_coercion_test.dart': (
    floor: '0.137.0',
    measured: '0.65.0',
  ),
  // SCE101-SCE104, each pinned at the release its fix ACTUALLY landed in
  // rather than at one conservative working-tree version - the versions are
  // known because each fix bumped the interpreter in its own commit.
  'sce101_element_type_test.dart': (floor: '0.139.0', measured: '0.65.0'),
  'sce102_empty_loop_body_async_test.dart': (
    floor: '0.140.0',
    measured: '0.65.0',
  ),
  'sce103_typed_local_test.dart': (floor: '0.141.0', measured: '0.65.0'),
  'sce104_cast_pattern_test.dart': (floor: '0.142.0', measured: '0.65.0'),
  'stdlib/bridge_arity_test.dart': (floor: '0.143.0', measured: '0.65.0'),
  'sce109_sdk_error_types_test.dart': (floor: '0.143.0', measured: '0.65.0'),
};

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
/// How `pubspec.lock` says tom_d4rt_ast was resolved — `hosted` normally,
/// `path` under SCD66's pre-publish pass (a gitignored `pubspec_overrides.yaml`
/// pointing at the working tree) — or null when the entry is unreadable.
String? _execAstSource() {
  final lock = File('pubspec.lock');
  if (!lock.existsSync()) return null;
  return RegExp(
    '^  tom_d4rt_ast:\\n(?:    .*\\n|      .*\\n)*?    source: (\\w+)',
    multiLine: true,
  ).firstMatch(lock.readAsStringSync())?.group(1);
}

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

/// What a pinned floor means now, given the two versions that describe this
/// package's interpreter.
///
/// SCD159. F-SCC43-1 used to ask one question — has the DECLARED floor passed
/// the pin — and the declared floor is not what the suite runs. The constraint
/// moves only when somebody edits `pubspec.yaml`; the resolved version moves on
/// every `pub upgrade`, and a caret bound admits every release up to the next
/// major. So between a publish and the constraint bump that follows it, a pin is
/// actionable while the register reports it as waiting, which is precisely the
/// failure SCC43 exists to prevent, recurring inside the mechanism meant to
/// prevent it.
///
/// THE TWO SIGNALS ARE DIFFERENT CLAIMS and are worth reporting apart:
///
///   * [due] — the interpreter this suite is RUNNING is already past the pin.
///     The entry can be re-ported today, and the run that proves it is the one
///     happening now.
///   * [floorRaised] — the CONSTRAINT is past the pin too, so the entry is not
///     merely re-portable, it is stale: nothing in this package can resolve an
///     interpreter old enough to justify it.
///
/// `floorRaised` implies `due` — F-SCC80-1 asserts the lock is never behind the
/// floor — so it is checked first and the weaker answer never masks the stronger
/// one.
enum _PinVerdict { waiting, due, floorRaised }

_PinVerdict _pinVerdict(
  String waitingOn, {
  required String floor,
  required String resolved,
}) {
  if (_versionExceeds(floor, waitingOn)) return _PinVerdict.floorRaised;
  if (_versionExceeds(resolved, waitingOn)) return _PinVerdict.due;
  return _PinVerdict.waiting;
}

// ---------------------------------------------------------------------------
// SCE140 — THE SOURCE SCANS IN THIS FILE, AND WHAT STOPS EACH PASSING OVER
// NOTHING.
//
// This guard reads source — its own, the two corpora's, the guidelines', the
// quest todo file's — and derives maps and sets from what it finds. A source
// scan has one silent failure mode: it matches nothing, and every assertion
// built on it passes. That has happened TWICE here, both times found by hand:
// SCC44 changed `_divergentBaseline`'s value type and disarmed the floor
// scanner; SCD122 found the same scanner returning the empty map because the
// last entry written in the syntax it read had been converged away.
//
// So every scan is audited below and every row is confirmed by ABLATION —
// break the pattern, run the suite, record what goes red. Reading the code is
// not evidence; the two historical cases were both readable.
//
// | scan                        | subject set it must cover        | asserted by |
// | --------------------------- | -------------------------------- | ----------- |
// | _floorsDeclaredInComments   | _pinnedInterpreterFloors ∩ live  | F-SCC43-1 part two |
// | _divergentEntryComments     | _divergentBaseline.keys          | F-SCC44-1 part one |
// | _uncoveredEntryComments     | _uncoveredBaseline.keys          | F-SCD126-1 part one |
// | _baselineEntriesWithComments| both registers' keys             | F-SCE68-1 part zero |
// | _selfAnchored               | _anchoredBaseline                | F-SCE88-1, control F-SCE88-2 |
// | _markers / _parityMarkers / _publishPins | _inlineMarkerCensus | F-SCE140-1 |
// | _sections                   | _guidelineOneSided's headings    | F-SCC6-9 stale-record arm |
// | _countCases                 | the recorded `declared` numbers  | F-SCC6-6, F-SCC6-10 |
// | _questTodoStatus            | every pin id and _astPublishBlock| F-SCD103-1, F-SCC80-3 |
// | _execAstFloor/_execAstResolved | n/a — `fail()` on a miss      | itself |
// | _guidelineFiles             | _guidelineOneSidedFiles          | F-SCC6-9 |
// | _filesUnder                 | _astWorkingTreeDrift + the block | F-SCC80-3 |
// | _distinctiveTerms/_reasonOverlap | _convergenceLog's reasons   | F-SCE142-1, control F-SCE142-2 |
//
// ABLATION MATRIX, measured 2026-09-22. Each row: the edit, and every case
// that went red. A scan whose row reads NOTHING WENT RED is a finding.
//
// | edit                                   | red                              |
// | -------------------------------------- | -------------------------------- |
// | _markerPattern stops matching (BEFORE)  | NOTHING                          |
// | _markerPattern stops matching (after)   | F-SCE140-1                       |
// | a PUBLISH-PIN is deleted from a file    | F-SCE140-1                       |
// | a marker is added to tom_d4rt_ast       | F-SCE140-1                       |
// | _uncoveredBaseline's opener moves       | F-SCE68-1, F-SCD126-1            |
// | _floorsDeclaredInComments' floorPattern | F-SCC43-1                        |
// | _entryComments' entryPattern            | F-SCC44-1, F-SCD126-1            |
// | _anchorCall                             | F-SCC6-2, F-SCE88-1, F-SCE88-2   |
// | _sections stops seeing headings         | F-SCC6-9                         |
// | _countCases returns 0                   | F-SCC6-6, F-SCC6-10              |
// | _questTodoStatus' status regex          | F-SCD103-1, F-SCC80-3            |
// | _execAstFloor's pattern                 | F-SCC43-1, F-SCC80-1             |
// | _guidelineFiles finds nothing           | F-SCC6-9                         |
// | the pre-SCD125 reason swap, restored    | F-SCE142-1 (and NOTHING else)    |
// | _distinctiveTerms stops matching        | F-SCE142-1, F-SCE142-2           |
//
// THE ONE ROW THAT WAS EMPTY, and why it was the one. Breaking the marker
// pattern left F-SCC6-5, F-SCD103-1 and F-SCD103-2 all green — three cases,
// including the RATCHET that retires a publish pin when its todo closes. The
// corpus holds seven markers, so the scan was not vacuous for want of
// subjects; nothing simply asked whether it had reached them. F-SCE140-1 and
// [_inlineMarkerCensus] close that, and closing it was worth more than the
// other twelve rows put together: sce119 and sce162 are open todos whose
// closure is meant to turn six pins red, and until now a pattern change would
// have deleted that consequence without deleting the pins.
//
// TWO ROWS WITH NO NAMED SET, recorded as findings rather than waved through:
//
//   * [_sections]. There is no register of the headings each guideline pair
//     ought to share — only [_guidelineOneSided], which names the ones that
//     legitimately exist on one side, and covers `testing.md` alone today. The
//     scan is nonetheless fail-safe BY CONSTRUCTION rather than by assertion:
//     it always emits at least a `''` preamble section, so a splitter that
//     stops seeing headings compares the two files WHOLE, and the two copies
//     differ. The ablation confirms it. What that costs is that the guarantee
//     rests on the files differing — were two guideline copies ever byte
//     identical, a broken splitter over them would be green and empty.
//   * [_markers] part one, the `KNOWN-GAP()`-with-no-owner branch. The corpus
//     holds no `KNOWN-GAP` marker of any kind (measured 2026-09-22), so that
//     branch has no subject at all. It is kept for the first real use, and
//     F-SCE140-1 now proves the scan underneath it is alive even while the
//     branch itself is vacuous — which is the distinction that was missing.
//
// WHAT THIS AUDIT IS NOT. It is not a claim that every scan is correct, only
// that a scan which stops SEEING its subject is now visible. A pattern that
// matches the wrong thing, or a register that records a false fact, is the
// business of the case that reads it.
// ---------------------------------------------------------------------------

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
  // Everything after the key is ignored, and that width is load-bearing twice
  // over. `dart format` wraps an entry whose key and value do not fit in 80
  // columns, leaving a key line that ends in a bare `:` or `: (` — so a
  // pattern anchored to the one-line form stops attributing that entry the
  // moment the formatter runs. And the value itself may contain commas:
  // [_uncoveredBaseline] holds a [_CaseCounts] record, which an earlier
  // `[^,]*` could not cross, so 22 of its 40 entries went unattributed and
  // F-SCC43-1 reported every one as a floor declared in prose with no register
  // key. Both failures have the same shape — a scanner that stops seeing an
  // entry blames the entry — so the key is the only thing this reads.
  final entryPattern = RegExp(r"^\s*'([^']+)'\s*(?::.*)?$");
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

/// The comment run written directly above each entry of the baseline map whose
/// literal opens with [mapOpener], as `<entry path> -> <joined comment text>`.
///
/// Entries with no comment above them are absent from the result rather than
/// present with an empty value, which is what lets the callers distinguish "this
/// entry has no reason" from "the scanner did not reach it".
///
/// [valueTail] is the entry's right-hand side — `_Divergence.x,` for one map, a
/// case count for the other. It is optional in both for the reason given in
/// [_floorsDeclaredInComments]: the formatter puts the value on its own line
/// whenever the key is long enough, and the resulting bare `'path':` is still an
/// entry.
///
/// SCD126 made this take the map rather than naming one. Both baselines have the
/// same absorption property — an entry stands until somebody re-measures it, and
/// absorbs every change to its file meanwhile — so both need the same "is there
/// a reason" guarantee, and two copies of this scanner would have been two
/// things to keep in step.
Map<String, String> _entryComments(String mapOpener, String valueTail) {
  final lines = File('test/conformance_drift_test.dart').readAsLinesSync();
  final entryPattern = RegExp("^\\s*'([^']+)'\\s*:\\s*(?:$valueTail)?\\s*\$");
  final reasons = <String, String>{};
  var inMap = false;
  var pending = <String>[];
  for (final line in lines) {
    if (!inMap) {
      inMap = line.startsWith(mapOpener);
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

/// The reason written above each [_divergentBaseline] entry.
Map<String, String> _divergentEntryComments() => _entryComments(
  'const Map<String, _Divergence> _divergentBaseline = {',
  r'_Divergence\.\w+,',
);

/// The reason written above each [_uncoveredBaseline] entry.
Map<String, String> _uncoveredEntryComments() => _entryComments(
  'const Map<String, _CaseCounts> _uncoveredBaseline = {',
  // Either the whole record, or the bare `(` the formatter leaves on the key
  // line when the entry does not fit in 80 columns.
  r'\(ran: \d+, declared: \d+\),|\(',
);

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
  r'^//\s*(KNOWN-GAP\([^)]*\)|WONT-FIX|PUBLISH-PIN\([^)]*\))\s*:',
);

/// Every file in the three corpora that carries an inline marker, and how
/// many, keyed `<tree>/<path relative to that tree's test/>`.
///
/// SCE140. THIS IS A COVERAGE REGISTER, not a policy one — it exists so that
/// the three cases built on [_markers] cannot pass over nothing. All three are
/// emptiness assertions over a derived set, and the corpus is small enough
/// that a scanner which had stopped matching would look exactly like a corpus
/// with no markers in it:
///
///   * [F-SCC6-5] part one reports `KNOWN-GAP()` with no owner. Measured
///     2026-09-22: the corpus holds NO `KNOWN-GAP` marker of any kind, so that
///     branch is vacuous today and is kept for the first real use.
///   * [F-SCC6-5] parts two and three, and the recorded-pairing parity that
///     follows, compare [_parityMarkers] between two copies. Two empty lists
///     are equal, so a broken pattern is green.
///   * [F-SCD103-1] is the RATCHET that retires a publish pin when its todo
///     closes. It is the one that matters most and the one a silent scan
///     disarms most completely — it iterates the pins it finds, so finding
///     none is a full pass.
///
/// WHY AN EXACT CENSUS RATHER THAN A FLOOR. A floor ("at least six markers")
/// answers "is the scanner alive"; it does not answer "did the scanner reach
/// the files whose pins are load-bearing". Those are different questions, and
/// the second is the one SCD122 found answered wrongly for the sibling floor
/// scan: that map was going to be non-empty again as soon as any other entry
/// was written, and was empty only for the entries that mattered.
///
/// WHAT MAKES THIS GO RED, and all three are the deliberate edit they should
/// be: adding a pin, deleting one — which is what closing sce119 or sce162
/// means — or a change to [_markerPattern] or the comment syntax that stops
/// the scan seeing a file it used to.
///
/// NOTE THAT `conformance_drift_test.dart` IS NOT HERE even though it contains
/// the string five times over. Those are `// PUBLISH-PIN(<id>)` lines above
/// baseline entries, with no trailing colon, and [_markerPattern] requires one
/// — the register and the inline marker are two different mechanisms and this
/// is the line between them. A reader who greps will find eleven hits and
/// should expect this register to name seven.
const Map<String, int> _inlineMarkerCensus = {
  'tom_d4rt/limitations_and_bugs_test.dart': 1,
  'exec/limitations_and_bugs_test.dart': 1,
  'exec/scd74_hook_covers_both_paths_test.dart': 1,
  'exec/scd77_uri_is_scheme_test.dart': 1,
  'exec/scd101_host_boundary_single_rule_test.dart': 1,
  'exec/scd104_boundary_contract_test.dart': 2,
  'exec/sce62_copier_node_family_test.dart': 1,
  // tom_d4rt_ast carries none, and its absence from this map is the claim.
};

/// SCD103: markers that must MATCH across the two trees.
///
/// `KNOWN-GAP` and `WONT-FIX` mean "the behaviour is wrong in this tree", which
/// genuinely should be true of both copies — F-SCC6-5 part two holds them to
/// that, taking no exemption from [_divergentBaseline].
///
/// `PUBLISH-PIN` means something else: "this tree runs an OLDER PUBLISHED
/// interpreter". That is true of exec and false of the reference tree by
/// construction (DGUC6), so parity is the wrong question for it — and asking it
/// anyway is what made the corpus's most common pin inexpressible. Marking only
/// the exec copy failed parity; marking the reference copy too would have been
/// a false statement, because there is no gap on that side.
List<String> _parityMarkers(String source) => [
  for (final marker in _markers(source))
    if (!marker.startsWith('PUBLISH-PIN')) marker,
];

/// The `PUBLISH-PIN(<todo-id>)` markers in [source], as their todo ids.
List<String> _publishPins(String source) => [
  for (final marker in _markers(source))
    if (marker.startsWith('PUBLISH-PIN'))
      marker.substring('PUBLISH-PIN('.length, marker.length - 1).trim(),
];

/// The quest todo file this repository's pins name.
///
/// Read rather than mirrored: a copy of the id list here would have to be
/// updated by the same person at the same moment, and would then be checking
/// their memory against itself — the argument [_execAstFloor] already makes.
File _questTodoFile() => File('../../../_ai/quests/d4rt/todos.d4rt.todo.yaml');

/// Every file a quest todo can be declared in, live first.
///
/// A COMPLETED todo does not stay in `todos.d4rt.todo.yaml` — archiving MOVES
/// it to the `-archived` sibling, and the live file holds no `completed` entry
/// at all. Reading only the live file therefore cannot distinguish "this id
/// was never real" from "this id is done", which are opposite diagnoses: the
/// first says a pin was mistyped, the second says the publish it waited for
/// has landed and the weakened assertion can be restored.
///
/// F-SCD103-1 read the live file alone and so could never take its own
/// COMPLETED branch — the branch its comment describes as the whole point of
/// the case. Cancelled and deleted todos are read for the same reason: a pin
/// whose reason was abandoned is as stale as one whose reason was finished.
List<File> _questTodoSources() => [
  _questTodoFile(),
  File('../../../_ai/quests/d4rt/todos-archived.d4rt.todo.yaml'),
  File('../../../_ai/quests/d4rt/todos-deleted.d4rt.todo.yaml'),
];

/// The `status:` of quest todo [id], or `null` when no such todo is declared.
///
/// The id as written may be a PREFIX of the qualified todo id, which is how
/// both callers cite one: a `PUBLISH-PIN` marker and
/// [_astPublishBlock] name the stem a reader can grep for rather than the full
/// slug. The block a status is read from runs to the next `  - id:`.
///
/// Extracted from F-SCD103-1 when [_astPublishBlock] became its second caller.
/// The two ask the same question — "is the todo that justifies this weakening
/// still open?" — and a pin that answered it differently from a block would be
/// the defect both cases exist to prevent.
String? _questTodoStatus(String id, [String? todoSource]) {
  if (id.isEmpty) return null;
  if (todoSource == null) {
    for (final file in _questTodoSources()) {
      if (!file.existsSync()) continue;
      final found = _questTodoStatus(id, file.readAsStringSync());
      if (found != null) return found;
    }
    return null;
  }
  final declared = RegExp(
    '^  - id: ${RegExp.escape(id)}',
    multiLine: true,
  ).firstMatch(todoSource);
  if (declared == null) return null;
  final start = declared.start;
  final next = RegExp(
    r'^  - id: ',
    multiLine: true,
  ).firstMatch(todoSource.substring(start + 10));
  final block = next == null
      ? todoSource.substring(start)
      : todoSource.substring(start, start + 10 + next.start);
  return RegExp(
    r'^    status: (.*)$',
    multiLine: true,
  ).firstMatch(block)?.group(1)?.trim();
}

/// Statuses that mean a todo will not be acted on again.
const Set<String> _closedTodoStatuses = {'completed', 'cancelled'};

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

/// [source] with both spellings of every interpreter import collapsed to one
/// token, so a correctly-ported file compares equal to its twin.
///
/// SCD124 moved the table itself to `port_recipe.dart`, because
/// `tool/remeasure_pins.dart` reads the SAME pairs in the other direction to
/// produce a runnable port. Two copies of that table drift silently in the
/// worst way: this guard would go on calling a file a valid port while the tool
/// produced something that does not compile, or the reverse. The rationale for
/// each pair, and for normalising rather than baselining, lives there with it.
String _normalise(String source) => normalisePortImports(source);

/// A fingerprint of the difference a [_divergentBaseline] entry sanctions.
///
/// SCD154. Membership in that map is by PATH, so an entry exempts its file from
/// ALL future drift for as long as it stands — the map's own header names the
/// hazard and the guard then implemented exactly it. That was tolerable while
/// the six original entries were structural and permanent. It stopped being
/// tolerable when SCC52 and SCD153 added nine more of a different kind: live
/// ports that differ only by a publish-pinned expectation, which will keep
/// receiving reference-side edits, every one of which landed unchecked. The
/// entry that says "this file still expects the old StateError" silently also
/// said "and anything else you like".
///
/// POSITION-INDEPENDENT ON PURPOSE. The todo proposed "the sorted set of
/// differing line numbers plus a hash of the differing lines". Line numbers are
/// the brittle half: inserting a comment anywhere above a divergence shifts
/// every number below it, so the fingerprint would demand a deliberate
/// recomputation for an edit that changed nothing about what the two copies
/// assert. What this hashes instead is the multiset of lines each side has that
/// the other does not, sorted — which moves when the CONTENT of the divergence
/// moves and stays still when it only slides down the file.
///
/// A mirrored edit — the same line added to both copies — does not move the
/// fingerprint either, which is the case that matters most: it is what a
/// correctly-maintained port looks like.
///
/// The hash is FNV-1a/64 written out rather than `package:crypto`, because this
/// package does not depend on it and a guard is not worth a dependency. Nothing
/// here is adversarial: the input is two files in the same repository.
String _divergenceFingerprint(String refSource, String execSource) {
  final ref = _normalise(refSource).split('\n');
  final exec = _normalise(execSource).split('\n');
  final onlyRef = _linesNotIn(ref, exec)..sort();
  final onlyExec = _linesNotIn(exec, ref)..sort();
  return _fnv1a('${onlyRef.join('\n')}\n@@SIDE@@\n${onlyExec.join('\n')}');
}

/// The lines of [a] that [b] does not also contain, counting duplicates.
List<String> _linesNotIn(List<String> a, List<String> b) {
  final remaining = <String, int>{};
  for (final line in b) {
    remaining[line] = (remaining[line] ?? 0) + 1;
  }
  final out = <String>[];
  for (final line in a) {
    final left = remaining[line] ?? 0;
    if (left > 0) {
      remaining[line] = left - 1;
    } else {
      out.add(line);
    }
  }
  return out;
}

String _fnv1a(String input) {
  var hash = BigInt.parse('cbf29ce484222325', radix: 16);
  final mask = (BigInt.one << 64) - BigInt.one;
  final prime = BigInt.parse('100000001b3', radix: 16);
  for (final unit in utf8.encode(input)) {
    hash = (hash ^ BigInt.from(unit)) * prime & mask;
  }
  return hash.toRadixString(16).padLeft(16, '0');
}

/// The reference tests that declare themselves single-copy, pinned.
///
/// SCE88. [_selfAnchored] is SUBTRACTED from the missing-port census before
/// F-SCC6-2 compares it against [_uncoveredBaseline], which is right — a test
/// that resolves its paths against the package it runs in cannot be ported
/// here. It also means ANCHORING A FILE REMOVES IT FROM THE CENSUS, with no
/// entry, no reason and no case firing anywhere.
///
/// Measured rather than reasoned: a new reference test with no exec
/// counterpart turns F-SCC6-2 red and demands one of its three remedies; the
/// same file with `requirePackage('tom_d4rt', subject: 'nothing at all')`
/// added is green everywhere. Nothing reads the subject string, so the
/// cheapest way out of the census was to claim the exemption rather than to
/// record why the port is missing.
///
/// So the set is pinned, and entering it is an edit here exactly as entering
/// [_uncoveredBaseline] is. The per-file REASON is deliberately not
/// duplicated: it is the `subject:` each file already passes, and `tom_d4rt`'s
/// `scd158_structural_guard_anchoring_test.dart` requires that to be present
/// and to say something. This register records WHICH files claim the
/// exemption; that one records that each claim states what it is about.
const _anchoredBaseline = <String>{
  'release_hygiene_test.dart',
  'scc22_error_handler_site_guard_test.dart',
  'scc25_listen_duplication_guard_test.dart',
  'scd110_doc_holds_no_runner_output_test.dart',
  'scd129_repo_wide_guard_index_test.dart',
  'scd134_barrel_surface_parity_test.dart',
  'scd153_conformance_drift_mirror_test.dart',
  'scd156_public_surface_parity_test.dart',
  'scd158_structural_guard_anchoring_test.dart',
  'scd165_overview_figures_test.dart',
  'scd183_mirror_source_sync_test.dart',
  'scd187_no_unimplemented_stubs_test.dart',
  'scd199_mirror_body_agreement_test.dart',
  'scd34_constructor_trace_forwarding_test.dart',
  'scd35_bridged_tearoff_as_callback_test.dart',
  'scd49_stdlib_twin_sync_test.dart',
  'scd51_member_gap_parity_test.dart',
  'scd67_hierarchy_edges_test.dart',
  'scd70_no_container_arg_casts_test.dart',
  'scd94_sdk_type_nameability_test.dart',
  'sce155_dead_surface_removal_test.dart',
  'sce156_public_type_nameability_test.dart',
  'sce166_permission_enforcement_parity_test.dart',
  'sce45_todo_count_stamps_test.dart',
  'sce89_skip_tag_agreement_test.dart',
  'stdlib/io/sce87_permission_gate_null_handle_test.dart',
  'stdlib/scd204_surplus_arity_guard_test.dart',
  'stdlib/stdlib_d4_boundary_test.dart',
};

/// Reference tests that DECLARE they must run in `tom_d4rt`, and are therefore
/// structurally single-copy.
///
/// SCD158. A test that asserts something about the interpreter SOURCE resolves
/// its paths relative to the package it runs in. Ported here, `lib/src/stdlib`
/// becomes exec's own `lib` — a parsing front end with no stdlib adapters — and
/// the test walks an unrelated file set WITHOUT erroring. SCC22's three cases
/// failed that way, which is how the category was noticed, but that was luck: an
/// emptiness check over the wrong tree passes.
///
/// The category used to be recorded here one file at a time, in the prose above
/// whichever `_uncoveredBaseline` entry the last person to port something had
/// written — the prose-only mechanism SCD107 and F-SCC43-1 exist because of. It
/// is now DERIVED, from a marker the file itself carries: `requirePackage(
/// 'tom_d4rt', ...)` as the first statement of `main()`, which aborts at load
/// time if the file is ever run anywhere else.
///
/// READING THE DECLARATION RATHER THAN INFERRING FROM A PATH is the half of this
/// that matters. A path literal says a file MENTIONS a sibling tree; the call
/// says its author decided the file belongs to one package. The two are kept in
/// step from the other side:
/// `tom_d4rt/test/scd158_structural_guard_anchoring_test.dart` fails when a test
/// whose code names a sibling tree does not carry the call, so the marker cannot
/// be quietly omitted — and it fails in the tree where such a file is written,
/// which is SCD153's lesson applied.
Set<String> _selfAnchored(Map<String, File> reference) => {
  for (final entry in reference.entries)
    if (_anchorCall.hasMatch(entry.value.readAsStringSync())) entry.key,
};

final RegExp _anchorCall = RegExp(r"requirePackage\(\s*'tom_d4rt'");

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

/// The difference each [_astWorkingTreeDrift] entry actually sanctions.
///
/// SCE187. Without it the register exempted by PATH, the blanket SCD154 removed
/// from [_divergentBaseline]: once a file was listed, F-SCC80-3 stopped looking
/// at it, so a SOURCE change landing in either barrel would have been absorbed
/// by an entry asserting "doc comment only". Here the hazard is sharper than
/// there — an entry absorbs drift in the interpreter the whole suite measures,
/// not in one test — and the claim each entry makes is exactly the kind a
/// fingerprint can hold still. F-SCE187-1 asserts the key sets are equal and
/// that each listed file's difference is still the one recorded.
///
/// The algorithm is [_divergenceFingerprint]'s, reused rather than restated,
/// with the PUBLISHED copy on the left and the working tree on the right. A
/// parallel map for the reason [_divergenceFingerprints] is one.
///
/// THE LIFECYCLE DIFFERS FROM [_divergenceFingerprints], and in the direction
/// that costs nothing. Those move only when somebody edits a file. These are
/// computed against a PUBLISHED artifact, so a release changes their left-hand
/// side — but a release of the working tree also makes the file stop
/// differing, and F-SCC80-3 then fails until the entry is deleted, which the
/// key-set check here turns into deleting its fingerprint too. So a publish
/// RETIRES these rather than re-blessing them. The only entry that would ever
/// be recomputed is one that still differs AFTER a publish, and that is a new
/// difference to read, not an old one to refresh.
///
/// TO RECOMPUTE ONE: run this suite; F-SCE187-1 prints recorded beside
/// observed. Read the new difference first — `diff` the pub-cache copy against
/// `../tom_d4rt_ast/lib/<path>` — and paste only if it is still what the
/// entry's reason says.
const Map<String, String> _astDriftFingerprints = <String, String>{
  // Read 2026-09-25 against published 0.65.0: both differences are `///`
  // lines only, as the entries say.
  'ast.dart': '3d3f4f561aba2a6b',
  'tom_d4rt_ast.dart': 'e7fbb21bbb249a5c',
};

/// The todo blocking the `tom_d4rt_ast` publish that would clear F-SCC80-3,
/// or `null` when nothing blocks it.
///
/// WHY A WHOLE-SUITE BLOCK RATHER THAN 91 [_astWorkingTreeDrift] ENTRIES.
/// That register means one specific thing — "this file differs, and nothing an
/// interpreter DOES differs between the copies" — which is why its only two
/// members are barrel docstrings. Listing `interpreter_visitor.dart`,
/// `environment.dart` and `callable.dart` there would assert something false
/// to make a case green, and would keep asserting it after the publish landed.
/// The drift here is 58 minors of real interpreter work; it is not explainable
/// file by file, only datable.
///
/// WHY NOT SIMPLY LEAVE THE CASE RED. A red that stands for weeks stops being
/// read: scd15_aicx recorded exactly that decay for the reflector performance
/// test, and this file's own SCD103 machinery was built because pins written
/// as prose went unfollowed. A reader hitting a red here cannot tell a stale
/// resolution from a regression without re-deriving the cause — and the cause
/// is a decision already taken and written down elsewhere.
///
/// SO IT IS PINNED, NOT SILENCED, and it self-retires in both directions:
/// F-SCC80-3 fails when the named todo is missing or closed, and fails when
/// the drift is gone while a block is still declared. The block cannot outlive
/// its reason, and it cannot hide a publish that has already happened.
/// F-SCC80-1 still PRINTS the resolved version on every run, so "which
/// interpreter did this measure" is answered whether or not a block is in
/// force.
// SCE162 CLEARED THE REGRESSIONS; IT DID NOT DO THE PUBLISH. These pins were
// keyed on sce162, and closing it read to F-SCD103-1 and F-SCC80-3 as "the
// publish landed" — which it has not. What they are actually waiting on is the
// publish, which is sce160's, so they now name it. The distinction is the one
// the pin machinery exists to keep: a pin names the todo that will DELETE it.
// The type is the contract — `null` is how "nothing blocks the publish" is
// expressed, and that is the state this constant returns to. The lint reasons
// from today's value alone.
// ignore: unnecessary_nullable_for_final_variable_declarations
const String? _astPublishBlock =
    'sce160_aioc-publish-scd136-and-record-the-corpus-run';

/// One baseline entry and the comment block written directly above it.
typedef _BaselineEntry = ({String path, String comment});

/// Every entry of [register] in this file's source, with its leading comment.
///
/// Reads the SOURCE rather than the parsed map because the thing being checked
/// is the PROSE, and a `const Map` keeps none of it. The block above an entry
/// runs back to the previous entry, so a header comment introducing a batch is
/// attached to the first entry of that batch — which is where a batch-wide
/// "PUBLISH-BLOCKED" note is written.
List<_BaselineEntry> _baselineEntriesWithComments(String register) {
  final source = File('test/conformance_drift_test.dart').readAsStringSync();
  final start = source.indexOf('$register = ');
  if (start < 0) return const [];
  final end = source.indexOf('\n};', start);
  final body = source.substring(start, end);
  final entryLine = RegExp(r"^\s*'([^']+)'\s*:", multiLine: true);

  final out = <_BaselineEntry>[];
  final buffer = StringBuffer();
  for (final line in body.split('\n').skip(1)) {
    final match = entryLine.firstMatch(line);
    if (match == null) {
      buffer.writeln(line);
      continue;
    }
    out.add((path: match.group(1)!, comment: buffer.toString()));
    buffer.clear();
  }
  return out;
}

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
  // SCE191: this guard resolves its subject relative to the package it
  // runs in, so a copy anywhere else measures a different tree in silence.
  requirePackage(
    'tom_d4rt_exec',
    subject:
        "exec's suite still mirrors tom_d4rt's, file for file and case for case",
  );

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

    test('F-SCE88-1: the single-copy exemption is a recorded set '
        '[2026-09-21] (PASS)', () {
      // THE ONE WAY A FILE LEAVES THE CENSUS WITHOUT SAYING ANYTHING.
      // F-SCC6-2 below subtracts the self-anchored files before comparing,
      // which is correct — a test resolving its paths against the package it
      // runs in cannot be ported here. The cost is that ADDING the anchor is
      // an alternative to recording a missing port, and a cheaper one:
      // measured, a new reference test with no counterpart turns F-SCC6-2 red
      // and demands a decision, while the same file carrying
      // `requirePackage('tom_d4rt', subject: 'nothing at all')` is green in
      // every case here.
      //
      // Pinning the set makes claiming the exemption an edit in this file,
      // the same act as recording an uncovered port. It does not judge
      // whether a claim is right — `tom_d4rt`'s scd158 guard owns that, and
      // the header above says which half is where.
      final anchored = _selfAnchored(ref);
      final claimed = anchored.difference(_anchoredBaseline);
      final released = _anchoredBaseline.difference(anchored);

      expect(
        claimed,
        isEmpty,
        reason:
            'These reference tests now declare themselves single-copy, which '
            'removes them from the missing-port census. That may be right — '
            'but it is the same decision as an _uncoveredBaseline entry and '
            'is recorded the same way. Add them to _anchoredBaseline, having '
            'read WHY each cannot be ported; the reason belongs in the '
            "`subject:` the file passes.\n${claimed.join('\n')}",
      );
      expect(
        released,
        isEmpty,
        reason:
            'These are listed as single-copy but no longer declare it, so '
            'they are back in the census — or they were deleted. Remove them '
            'from _anchoredBaseline; a register naming files that do not '
            'claim the exemption reads as a larger exemption than exists.\n'
            "${released.join('\n')}",
      );
    });

    test('F-SCE88-2 (control): the exemption set is non-empty and smaller '
        'than the corpus [2026-09-21] (PASS)', () {
      // Anti-vacuity for the case above, which is two emptiness assertions
      // over derived sets: a `_selfAnchored` that matched nothing, or matched
      // everything, satisfies neither direction visibly. 24 of 319 reference
      // files were anchored when this was written.
      final anchored = _selfAnchored(ref);
      expect(
        anchored.length,
        greaterThanOrEqualTo(10),
        reason:
            'Only ${anchored.length} files were detected as self-anchored, '
            'against 24 measured on 2026-09-21. The marker scan has probably '
            'stopped matching, which makes F-SCE88-1 pass over nothing and '
            'silently returns every anchored file to the census.',
      );
      expect(
        anchored.length,
        lessThan(ref.length ~/ 2),
        reason:
            '${anchored.length} of ${ref.length} reference files claim to be '
            'single-copy. At that fraction the census is measuring very '
            'little, whatever the other cases say.',
      );
    });

    test('F-SCE186-3: the reference-side parse of the coverage registers '
        'reads exactly their keys [2026-09-25] (PASS)', () {
      // `tom_d4rt`'s scd153 guard asks F-SCC6-2's question in the tree where a
      // new reference test is written, reading `_coveredElsewhere`,
      // `_uncoveredBaseline` and `_anchoredBaseline` out of THIS file as text
      // (an import would be a compile-time dependency on a sibling checkout).
      // A text parse can drift from the declaration it reads — a key the
      // formatter wraps differently, a register retyped — and there it would
      // either miss an entry or invent one. This is the one place both the
      // text and the consts are visible, so the parse is checked here, the
      // same arrangement F-SCC44-2 has for `_divergentBaseline`.
      //
      // The declaration lines and the key pattern are copies of
      // `_coverageRegisters` / `_registerKey` there; keep them identical.
      final lines = File('test/conformance_drift_test.dart').readAsLinesSync();
      final key = RegExp(r"^  '([^']+)'\s*[:,]");
      Set<String> parse(String declaration) {
        final start = lines.indexOf(declaration);
        expect(start, isNot(-1), reason: 'not found: $declaration');
        final keys = <String>{};
        for (final line in lines.skip(start + 1)) {
          if (line.startsWith('};')) break;
          if (key.firstMatch(line) case final m?) keys.add(m.group(1)!);
        }
        return keys;
      }

      expect(
        parse('const Map<String, _Coverage> _coveredElsewhere = {'),
        _coveredElsewhere.keys.toSet(),
      );
      expect(
        parse('const Map<String, _CaseCounts> _uncoveredBaseline = {'),
        _uncoveredBaseline.keys.toSet(),
      );
      expect(parse('const _anchoredBaseline = <String>{'), _anchoredBaseline);
    });

    test('F-SCC6-2: no reference test has appeared without a counterpart '
        '[2026-09-03] (PASS)', () {
      // SCD158. A reference test that declares it must run in `tom_d4rt` is
      // structurally single-copy: ported here it would resolve its paths
      // against exec and measure a different tree. Subtracted rather than
      // listed, so the category stops being rediscovered one file at a time by
      // whoever ports the next one.
      final anchored = _selfAnchored(ref);
      final uncovered = unmatched.entries
          .where((e) => e.value.where.isEmpty)
          .map((e) => e.key)
          .toSet()
          .difference(anchored);
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

    test('F-SCC6-10: every _uncoveredBaseline entry declares the number '
        'of cases its file has [2026-09-22] (PASS)', () {
      // The sibling of F-SCC6-6, arriving late because the obvious version of
      // it is inverted and had to be rejected first. `_uncoveredBaseline` held
      // ONE number, a runtime count, and 14 of the 40 files generate cases in
      // a loop — so comparing that number to the source would have passed on
      // the 26 entries that cannot drift and reported a permanent, expected
      // mismatch on the 14 that do. Green where nothing moves, noisy where
      // everything does.
      //
      // The entries now carry both counts, and this checks the half that is a
      // property of the file. It cannot see a loop whose iteration count
      // changed on its own; that is stated on the map rather than papered
      // over, because a guard read as covering more than it does is how the
      // counts went unchecked in the first place.
      //
      // ABLATED, all three against `scd68_constructor_named_args_test.dart`,
      // whose two numbers are equal:
      //
      //   set the entry's `declared` to 99      -> fails, names both numbers
      //   add a `test(` to the reference file   -> fails, and adds the
      //                                            equal-pair note below
      //   set the entry's `ran` to 77           -> PASSES
      //
      // The third is the one worth keeping: it is the control that proves this
      // checks only the half a file can answer for. If it ever starts failing,
      // someone has quietly made `ran` machine-checkable without measuring it.
      final drift = <String>[];
      for (final entry in _uncoveredBaseline.entries) {
        final file = File('${refTests.path}/${entry.key}');
        if (!file.existsSync()) {
          // F-SCC6-2 owns "this path is gone"; saying it twice would report
          // one deletion as two findings.
          continue;
        }
        final declared = _countCases(file.readAsStringSync());
        if (declared != entry.value.declared) {
          drift.add(
            '${entry.key}: entry says declared ${entry.value.declared}, '
            'the file has $declared'
            '${entry.value.ran == entry.value.declared ? " — and its two "
                      "numbers were equal, so `ran` is stale by the same amount" : ""}',
          );
        }
      }

      expect(
        _uncoveredBaseline.length,
        greaterThanOrEqualTo(20),
        reason:
            'Anti-vacuity: this is a loop over the baseline, so an empty map '
            'would satisfy it while checking nothing. 40 entries when it was '
            'written.',
      );
      expect(
        drift,
        isEmpty,
        reason:
            'These entries describe files that have since gained or lost '
            'cases:\n${drift.join('\n')}\n\n'
            'Set `declared` to what the file says. Do NOT touch `ran` to '
            'match it — that number is a measurement, and the way to change '
            'it is to re-run the port (`tool/remeasure_pins.dart '
            '--uncovered`). Where the note above says the two were equal, the '
            'file generates no cases and `ran` has drifted too, so the '
            're-measurement is owed rather than optional.',
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

      // SCD154. Membership above is by PATH, so everything up to here treats an
      // entry as a blanket: once a file is listed, the check stops looking at
      // it, and the second divergence in an already-listed file is invisible.
      // The fingerprint makes the entry pin the DIFFERENCE instead.
      expect(
        _divergenceFingerprints.keys.toSet(),
        equals(baseline),
        reason:
            'Every _divergentBaseline entry needs a fingerprint and every '
            'fingerprint needs an entry. A path in one map and not the other '
            'is an exemption with no recorded shape — which is the blanket '
            'this pairing exists to replace. Assert coverage before asserting '
            'content: without this the check below silently skips whichever '
            'entries have no fingerprint.',
      );

      final widened = <String>[];
      for (final path in baseline.intersection(divergent)) {
        final observed = _divergenceFingerprint(
          ref[path]!.readAsStringSync(),
          exec[path]!.readAsStringSync(),
        );
        if (observed != _divergenceFingerprints[path]) {
          widened.add(
            '$path\n      recorded: ${_divergenceFingerprints[path]}\n'
            '      observed: $observed',
          );
        }
      }
      expect(
        widened,
        isEmpty,
        reason:
            'These files still diverge, but NOT in the way their entry '
            'sanctions — something else in them has changed on one side only. '
            'The entry was a statement about one difference; it is not a '
            'licence for the next one.\n\n'
            'READ THE NEW DIFFERENCE BEFORE TOUCHING THE FINGERPRINT. Diff the '
            'pair, decide whether the new divergence is a missed mirror (fix '
            'it — the fingerprint then goes back by itself) or a second '
            'sanctioned difference (extend the comment above the entry to say '
            'what it is, THEN paste the observed value). Pasting first turns '
            'this back into the blanket it replaced.\n${widened.join('\n')}',
      );
    });

    test('F-SCE140-1: the inline-marker scan still reaches every file that '
        'carries one [2026-09-22] (PASS)', () {
      // COVERAGE BEFORE CONTENT, for the three cases below. Each of them is an
      // emptiness assertion over what [_markers] returns, and this file has
      // twice shipped a source scan that matched nothing and passed — SCC44's
      // value-type change disarming the floor scanner, and the empty floor map
      // SCD122 found. Both were found by hand. This is the same guarantee
      // F-SCC44-1 part one and F-SCD126-1 part one give the two comment scans,
      // for the scan that had none.
      //
      // ALL THREE TREES, because the marker cases read all three: part two
      // compares tom_d4rt against exec at the same path, part three follows
      // `_coveredElsewhere` into tom_d4rt_ast, and F-SCD103-1 walks tom_d4rt
      // and exec. A tree the scan stopped reaching would take its pins out of
      // the ratchet silently.
      final found = <String, int>{};
      for (final (tree, files) in [
        ('tom_d4rt', ref),
        ('exec', exec),
        ('tom_d4rt_ast', _testFiles(astTests)),
      ]) {
        files.forEach((path, file) {
          final count = _markers(file.readAsStringSync()).length;
          if (count > 0) found['$tree/$path'] = count;
        });
      }

      expect(
        found,
        equals(_inlineMarkerCensus),
        reason:
            'The inline-marker census does not match what the scan found. '
            'Three things produce this, and they want opposite responses:\n'
            '  * a marker was ADDED — record it here, which is the same '
            'deliberate edit as recording a baseline entry;\n'
            '  * a marker was DELETED, which is what closing the todo a '
            'PUBLISH-PIN names looks like — delete the line here too, in the '
            'same change;\n'
            '  * neither, in which case _markerPattern or the comment syntax '
            'has moved and F-SCC6-5, F-SCD103-1 and F-SCD103-2 are all '
            'passing over nothing.',
      );
    });

    test('F-SCC6-5: every pinned known gap names an owner and exists in every '
        'recorded copy [2026-09-04] (PASS)', () {
      // WHAT THIS GUARDS, MEASURED 2026-09-21, because three branches over a
      // near-empty population invite the question and silence is a poor
      // answer. Across all five packages the convention has seven uses:
      // `WONT-FIX` once (the named-field record gap, in this file's reference
      // twin and its port here), and `PUBLISH-PIN` six times, all DGUC6
      // publish gaps naming sce119 and sce162. That count is now kept in
      // [_inlineMarkerCensus] rather than here: it was written as five on
      // 2026-09-21 and was six a day later, which is a prose census doing what
      // a prose census does. `KNOWN-GAP(<todo-id>)` has
      // ZERO uses anywhere.
      //
      // SCE93 then asked the only question that makes that worth acting on:
      // are gaps being pinned WITHOUT a marker? It read the 44 sites in the
      // repo where a comment suggesting a limitation sits within eighteen
      // lines of a negative assertion. Every one is a contract or a
      // correction being held in place — the word "pinned" is used in this
      // corpus for "asserted so it cannot silently change", not for "this is
      // broken". The three that read otherwise resolve the same way on
      // inspection: `F-SCC30-4` asserts the SDK's own bare
      // `IntegerDivisionByZeroException`, which is parity rather than
      // degradation; `F-SCB20-5` asserts that `BytesBuilder` is not
      // `TypedData`, which is true in real Dart; and `F-SCD93-12` records a
      // message-wording difference whose type and catchability already match,
      // with no owner to name — and a marker there would invite the next
      // reader to delete a live assertion.
      //
      // So the answer is nil, and it is the finding rather than a wasted
      // afternoon: the convention is genuinely rare in this corpus, and this
      // guard is ready for the first real use rather than over-built for it.
      // The place a pin WOULD have hidden was checked first and is recorded
      // in `dart_overview_failures2_test.dart`, which held stale prose
      // instead — seven limitations described as live that had all been
      // fixed.
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
        // SCD103: `_parityMarkers` drops `PUBLISH-PIN`, which asserts something
        // true of one tree only. The other two kinds are still held to parity.
        final refMarkers = (_parityMarkers(
          ref[path]!.readAsStringSync(),
        )..sort()).join(', ');
        final execMarkers = (_parityMarkers(
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
        // SCD103: recorded-pairing parity, same exemption as part two — a
        // `PUBLISH-PIN` is about which interpreter a tree RESOLVES, so it has
        // no business matching across trees.
        final refMarkers = _parityMarkers(refFile.readAsStringSync()).toSet();
        final twinMarkers = _parityMarkers(twinFile.readAsStringSync()).toSet();

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

    test('F-SCD103-1: every PUBLISH-PIN names a todo that exists and is still '
        'open [2026-09-14] (PASS)', () {
      // SCC15 gave a weakened assertion an inline owner so a reader of the FILE
      // could see the pin. F-SCC6-5 then held those markers to parity between
      // the trees — which made the corpus's most common pin inexpressible.
      //
      // That pin is: the reference tree asserts the FIXED behaviour, because it
      // carries the fix; exec asserts the PUBLISHED interpreter's, because it
      // resolves `tom_d4rt_ast` from pub.dev (DGUC6). Marking only the exec
      // copy failed parity. Marking the reference copy too would have been a
      // false statement — there is no gap on that side. So the pins were
      // written as prose, or not written at all, and the accounting lived only
      // in this file. `PUBLISH-PIN` is the kind that says "this tree runs an
      // older published interpreter", and `_parityMarkers` exempts it by
      // construction.
      //
      // THIS CASE IS THE RATCHET, and it is what earns the new kind over a
      // comment. A pin whose todo is COMPLETE has outlived its reason: the
      // publish it waited for has landed, the assertion it weakened can be
      // restored, and nothing else would have said so. When sce119 closes,
      // every file below goes red and names itself.
      final problems = <String>[];

      for (final tree in [ref, exec]) {
        tree.forEach((path, file) {
          for (final id in _publishPins(file.readAsStringSync())) {
            if (id.isEmpty) {
              problems.add('$path: PUBLISH-PIN() names no todo');
              continue;
            }
            // The id as written may be a prefix of the qualified todo id.
            final status = _questTodoStatus(id);
            if (status == null) {
              problems.add('$path: PUBLISH-PIN($id) names no todo that exists');
              continue;
            }
            if (_closedTodoStatuses.contains(status)) {
              problems.add(
                '$path: PUBLISH-PIN($id) — that todo is $status, so the '
                'publish it waited for has landed and this assertion can be '
                'restored',
              );
            }
          }
        });
      }

      expect(
        problems,
        isEmpty,
        reason:
            'PUBLISH-PIN problems:\n  ${problems.join('\n  ')}\n\n'
            'A PUBLISH-PIN names the todo that will delete it. An id that does '
            'not exist cannot be followed; an id that is already COMPLETE '
            'means the pin is obsolete and the weakened assertion should be '
            'restored in the same change that closes it.',
      );
    });

    test('F-SCD103-2: a PUBLISH-PIN on a PORTED file is recorded centrally '
        'too [2026-09-14] (PASS)', () {
      // The half that turns two accountings into one ratchet. A pin on a file
      // that exists in BOTH trees says its copies differ, and that difference
      // has to be in `_divergentBaseline` — otherwise F-SCC6-4 would already
      // be red, or the maps and the file disagree about whether a divergence
      // exists.
      //
      // An EXEC-ONLY file is exempt, and the exemption is not a loophole:
      // there is no reference copy to be divergent from, so no central entry
      // could exist to match. Both of today's real pins are that shape — they
      // pin what the PUBLISHED interpreter does at a boundary exec owns.
      final unrecorded = <String>[];
      exec.forEach((path, file) {
        if (_publishPins(file.readAsStringSync()).isEmpty) return;
        if (!ref.containsKey(path)) {
          return; // exec-only: nothing to diverge from
        }
        if (_divergentBaseline.containsKey(path)) return;
        unrecorded.add(path);
      });
      expect(
        unrecorded,
        isEmpty,
        reason:
            'These ported files carry a PUBLISH-PIN but no _divergentBaseline '
            'entry:\n  ${unrecorded.join('\n  ')}\n\n'
            'A pin on a ported file claims its two copies differ. Record that '
            'in _divergentBaseline, or delete the pin — the inline marker and '
            'the central map are two views of one fact and must not disagree.',
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
    test('F-SCE187-1: every accepted working-tree drift is still the '
        'difference its entry describes [2026-09-25] (PASS)', () {
      // Runs whatever [_astPublishBlock] says. The block excuses the
      // UNEXPLAINED drift F-SCC80-3 reports while a publish is pending; it
      // does not excuse an entry that claims one difference and now covers
      // another.
      expect(
        _astDriftFingerprints.keys.toSet(),
        _astWorkingTreeDrift.keys.toSet(),
        reason:
            'Every _astWorkingTreeDrift entry needs a fingerprint of the '
            'difference it accepts, and no fingerprint may outlive its entry.',
      );
      final resolved = _resolvedAstRoot();
      final sibling = Directory('../tom_d4rt_ast');
      if (resolved == null || !sibling.existsSync()) {
        markTestSkipped(
          'needs both the resolved tom_d4rt_ast and the sibling working tree',
        );
        return;
      }
      final moved = <String>[];
      for (final path in _astWorkingTreeDrift.keys) {
        final published = File('${resolved.path}/lib/$path');
        final working = File('${sibling.path}/lib/$path');
        // A listed file that no longer differs, or exists on one side only,
        // is F-SCC80-3's to report; fingerprinting it here would say it twice.
        if (!published.existsSync() || !working.existsSync()) continue;
        final a = published.readAsStringSync();
        final b = working.readAsStringSync();
        if (a == b) continue;
        final observed = _divergenceFingerprint(a, b);
        if (observed != _astDriftFingerprints[path]) {
          moved.add(
            '$path\n      recorded: ${_astDriftFingerprints[path]}\n'
            '      observed: $observed',
          );
        }
      }
      expect(
        moved,
        isEmpty,
        reason:
            'The published and working-tree copies of these files now differ '
            'by something other than what their _astWorkingTreeDrift entry '
            'accepts. Diff them and read the change: if it is still what the '
            'reason says (a doc comment, say), paste the observed value into '
            '_astDriftFingerprints; if it touches an export, a declaration or '
            'a body, the entry is false — remove it and let F-SCC80-3 report '
            'the file.\n${moved.join('\n')}',
      );
    });

    test('F-SCC80-1: the resolved tom_d4rt_ast version is readable, printed '
        'and exactly the declared floor [2026-09-07]', () {
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

      // SCE192. Not behind is not enough: the lock may also be AHEAD. Then the
      // only record of which interpreter a green run certified is a gitignored
      // lockfile and the line printed above — per-machine, and unrecoverable
      // once the lock moves again. Held to EQUALITY, the pubspec in the
      // repository says which interpreter the suite measures, in every diff and
      // every review. That is SCC80's own argument for a caret bound "on the
      // version actually certified, so moving onto a new interpreter is a
      // deliberate edit"; equality is what makes the edit happen.
      //
      // THE COST, MEASURED RATHER THAN FEARED. A caret on a 0.x version is
      // minor-locked — `^0.65.0` is `>=0.65.0 <0.66.0` — so taking any new
      // minor interpreter release already required editing this pubspec. What
      // equality adds is the edit for a PATCH release, and the order is the
      // one the failure below spells out: bump the constraint, then upgrade,
      // in one commit.
      //
      // HOSTED ONLY. Under SCD66's pre-publish pass the lock resolves the
      // working tree by path, at the tree's version; that is F-SCC80-3's
      // finding, reported there, and one of the flips the pass expects. A
      // second red here for the same cause would lengthen that list and say
      // nothing new.
      final source = _execAstSource();
      if (source != 'hosted') {
        // ignore: avoid_print
        print(
          'F-SCC80-1: tom_d4rt_ast resolves by `$source`, not from pub.dev — '
          'the equality half does not apply; F-SCC80-3 reports the resolution.',
        );
        return;
      }
      expect(
        resolved,
        floor,
        reason:
            'pubspec.lock resolves tom_d4rt_ast $resolved, but this package '
            'declares $floor. Every result in this run certifies $resolved, and '
            'the repository records $floor — so which interpreter was measured '
            'now lives only in a gitignored lockfile. Set the constraint to '
            '"^$resolved" in pubspec.yaml, in the same commit as the upgrade '
            'that moved the lock (or `dart pub downgrade` if the move was not '
            'meant).',
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

      // The drift may be PINNED to the todo that forbids the publish which
      // would clear it. The pin is checked before it is honoured: a block
      // naming a todo that does not exist, or one already closed, is worse
      // than no block, because it reads as a decision somebody took.
      final blocker = _astPublishBlock;
      if (blocker != null) {
        final status = _questTodoStatus(blocker);
        expect(
          status,
          isNotNull,
          reason:
              '_astPublishBlock names `$blocker`, and no todo with that id is '
              'declared in any of '
              '${_questTodoSources().map((f) => f.path).join(', ')}. '
              'A block that cannot be '
              'followed to its reason is prose, which is the state SCD103 was '
              'built to end. Name a todo that exists, or delete the block and '
              'let this case be red.',
        );
        expect(
          _closedTodoStatuses.contains(status),
          isFalse,
          reason:
              '_astPublishBlock names `$blocker`, which is `$status`. The '
              'publish it was waiting on is no longer blocked, so this case '
              'must go back to demanding one: publish tom_d4rt_ast, raise the '
              'constraint in pubspec.yaml, and delete _astPublishBlock in the '
              'same change.',
        );

        expect(
          unexplained,
          isNotEmpty,
          reason:
              '_astPublishBlock names `$blocker`, but the resolved '
              'tom_d4rt_ast and the working tree no longer differ — the '
              'publish has landed. Delete the block; a baseline nobody prunes '
              'is how a ratchet loosens.',
        );

        // Pinned, not silenced. The drift is real and is reported on every
        // run; what the pin buys is that a reader can tell it from a
        // regression without re-deriving the cause.
        printOnFailure(
          'F-SCC80-3 is PINNED to $blocker: the resolved tom_d4rt_ast and the '
          'working tree differ in ${unexplained.length} file(s).',
        );
        return;
      }

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
            'reason — and expect to remove it at the next release.\n\n'
            'If the publish is BLOCKED by a todo, pin it: set '
            '_astPublishBlock to that todo id. The pin is verified to name an '
            'open todo and is deleted by the publish.',
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
    // SCD159. The verdict rule decides what part four means, and TODAY IT
    // CANNOT BE EXERCISED BY THE REGISTER: exec's constraint is `^0.65.0` and
    // its lock resolves 0.65.0, so `floor` and `resolved` are the same string
    // and the old rule and the new one agree on every one of the eight pins.
    // The gap is real and latent — it opens the moment somebody runs
    // `pub upgrade` after a publish, which a caret bound permits without any
    // edit to the pubspec — so it is asserted directly, with the two versions
    // supplied rather than read.
    //
    // Without this case the fix would be a change nothing measured, in a file
    // whose whole subject is that a pin written from prose rots.
    test('F-SCD159-1: a pin is due when the RESOLVED interpreter passes it, '
        'not when the constraint does [2026-09-15]', () {
      // The gap, stated as the case that used to be missed: a publish has
      // landed and been resolved, the constraint has not been touched, and the
      // pin sits between the two.
      expect(
        _pinVerdict('0.81.0', floor: '0.65.0', resolved: '0.87.0'),
        _PinVerdict.due,
        reason:
            'This is the window SCD159 was filed about. Comparing against the '
            'constraint answers `waiting` here, while the suite is already '
            'running an interpreter two publishes past the pin.',
      );
      expect(
        _pinVerdict('0.81.0', floor: '0.87.0', resolved: '0.87.0'),
        _PinVerdict.floorRaised,
        reason:
            'Once the constraint has moved too, the entry is not merely '
            're-portable — nothing here can resolve an interpreter old enough '
            'to justify it, which is a stronger claim and a different '
            'instruction.',
      );
      expect(
        _pinVerdict('0.87.0', floor: '0.65.0', resolved: '0.65.0'),
        _PinVerdict.waiting,
        reason: 'The ordinary state: the publish has not happened.',
      );
      expect(
        _pinVerdict('0.65.0', floor: '0.65.0', resolved: '0.65.0'),
        _PinVerdict.waiting,
        reason:
            'Equality is not "past". A pin names the version whose publish it '
            'waits for, so being AT that version is the moment before, not '
            'after — and reading it the other way would declare every pin due '
            'one release early.',
      );
      // Non-vacuity in the direction that matters: `floorRaised` must be
      // checked before `due`, or the weaker answer masks the stronger one for
      // every entry the constraint has passed.
      expect(
        _pinVerdict('0.40.0', floor: '0.65.0', resolved: '0.65.0'),
        isNot(_PinVerdict.due),
      );
    });

    test('F-SCE68-1: a baseline entry pinned on a publish is registered as '
        'one [2026-09-21]', () {
      // F-SCC43-1 reads [_pinnedInterpreterFloors] and retires entries whose
      // floor the resolved interpreter has reached. It cannot see an entry
      // that was pinned in PROSE and never added to that register: nothing
      // then connects the entry to the publish that frees it, and it outlives
      // its cause exactly the way SCC44's seven did — "recorded from prose
      // rather than from a run, and the pins outlived their cause by a full
      // release".
      //
      // TWO CONVENTIONS, BOTH MATCHED, and finding the second is why the
      // pattern is not simply "a version literal appears".
      // `_divergentBaseline` writes prose — "Converges at a floor past
      // 0.100.0" — while `_uncoveredBaseline` writes explicit
      // `PUBLISH-BLOCKED` / `Re-port when ...` markers. A pattern built from
      // either alone covers half the corpus and reports a confident zero over
      // the other half.
      //
      // FORWARD-LOOKING PHRASING ONLY. "the published interpreter answers X"
      // is evidence about today and appears in most entries; "converges when
      // X publishes" is a claim about a future event that retires the entry.
      // Matching the first would make nearly every entry a finding. Measured
      // 2026-09-21: 30 entries are pin-shaped and 29 were registered — the one
      // that was not is scd4, registered by this todo.
      final pinPhrase = RegExp(
        r'(PUBLISH-BLOCKED|re-?port\s+when|converges?\s+(at|when|once)'
        r'|flips?\s+(at|when|once)|blocked\s+until|at\s+a\s+floor\s+past'
        r'|raises?\s+\S+\s+floor\s+past|once\s+\S+\s+publishes)',
        caseSensitive: false,
      );
      // An entry that genuinely cannot be pinned says so, rather than the
      // check being switched off for the one case it cannot judge.
      final exempt = RegExp(r'pin-registered:\s*n/a', caseSensitive: false);

      // SCE140, part zero — the scan reached both registers, BEFORE anything
      // is concluded from it. [_baselineEntriesWithComments] returns `const []`
      // when it cannot find the register's opening line, which is silent by
      // construction: every loop below then runs zero times and every
      // assertion passes. The floor further down would catch the total
      // collapse, but not the half of it — one register found and the other
      // not — which is the shape both of this file's historical empty scans
      // actually took.
      const registers = ['_divergentBaseline', '_uncoveredBaseline'];
      final expectedKeys = {
        '_divergentBaseline': _divergentBaseline.keys.toSet(),
        '_uncoveredBaseline': _uncoveredBaseline.keys.toSet(),
      };
      for (final register in registers) {
        expect(
          _baselineEntriesWithComments(register).map((e) => e.path).toSet(),
          equals(expectedKeys[register]),
          reason:
              'The entry scan did not pair up with $register. Either the map '
              'literal moved out from under `indexOf(\'\$register = \')`, or '
              'the entry syntax changed and the scan stopped seeing entries — '
              'and in either case everything below this passes over nothing.',
        );
      }

      final problems = <String>[];
      var pinShaped = 0;
      for (final register in registers) {
        for (final entry in _baselineEntriesWithComments(register)) {
          final prose = entry.comment.replaceAll(RegExp(r'\s+'), ' ');
          if (!pinPhrase.hasMatch(prose)) continue;
          if (exempt.hasMatch(prose)) continue;
          pinShaped++;
          if (_pinnedInterpreterFloors.containsKey(entry.path)) continue;
          problems.add(
            '$register: ${entry.path} reads as waiting on a release '
            '("${pinPhrase.firstMatch(prose)!.group(0)}") but has no '
            '_pinnedInterpreterFloors entry',
          );
        }
      }

      expect(
        pinShaped,
        greaterThanOrEqualTo(20),
        reason:
            'Anti-vacuity: this case is a loop over pin-shaped entries, so a '
            'pattern that matched nothing would satisfy it while checking '
            'nothing. 30 matched when it was written; the floor asks only that '
            'the prose still has the shape this reads.',
      );
      expect(
        problems,
        isEmpty,
        reason:
            'A baseline entry pinned on a publish must name its floor in '
            '_pinnedInterpreterFloors, or F-SCC43-1 cannot retire it when the '
            'publish lands:\n  ${problems.join('\n  ')}\n\n'
            'Add the version the fix ACTUALLY landed in — the commit is '
            'usually known, and a floor later than it needs to be keeps an '
            'available port out of reach. If the entry genuinely cannot be '
            'pinned to a version, write `pin-registered: n/a — <reason>` in '
            'its comment.',
      );
    });

    test('F-SCE141-1: every pinned verdict was measured against the '
        'interpreter this suite resolves [2026-09-22] (PASS)', () {
      // THE OTHER HALF OF SCC43, and the expensive one.
      //
      // F-SCC43-1 answers WHEN an entry becomes reviewable: it reads exec's
      // floor and fires the moment a pin's publish has landed. It cannot
      // answer whether the entry was ever TRUE. SCC44 found six of the seven
      // pins then standing had been passing for a full release — each written
      // from prose describing a working-tree behaviour that had in fact
      // already shipped — and the floor never moved for any of them, so
      // nothing fired.
      //
      // Only a run answers that. `tool/remeasure_pins.dart` is that run and it
      // takes half an hour over this register, so it stays manual — wiring it
      // into a suite was considered and rejected, because a guard that takes
      // minutes gets switched off. What CAN live in a suite is the age of its
      // evidence: two strings compared, nothing executed.
      //
      // A VERDICT IS ABOUT ONE INTERPRETER. `measured` records which one. When
      // the lock moves — a `pub upgrade` after a publish — every verdict taken
      // against the older copy becomes a claim nobody has checked, and this
      // case says so on the next run rather than on the next audit.
      //
      // THE LOCK, NOT THE FLOOR, for the reason SCD159 separated the two: the
      // constraint moves when somebody edits `pubspec.yaml`, the resolved
      // version moves on every upgrade, and the resolved one is what the
      // verdicts were taken against.
      final resolved = _execAstResolved();
      final live = {..._uncoveredBaseline.keys, ..._divergentBaseline.keys};
      final stale = [
        for (final entry in _pinnedInterpreterFloors.entries)
          if (live.contains(entry.key) &&
              _versionExceeds(resolved, entry.value.measured))
            '${entry.key}: last measured against '
                '${entry.value.measured}, suite resolves $resolved',
      ];

      expect(
        stale,
        isEmpty,
        reason:
            'These pins record a verdict taken against an interpreter older '
            'than the one this suite runs, so what they claim is unverified '
            'against what is actually being measured:\n  '
            '${stale.join('\n  ')}\n\n'
            'Re-measure them and act on each verdict — that is\n'
            '    dart run tool/remeasure_pins.dart\n'
            'from tom_d4rt_exec, which reports still-failing (justified; paste '
            'the case ids into the entry), does-not-compile or HANGS (also '
            'justified, and say which — a hang is not a measurement), or '
            'PASSES NOW (the pin was never true: port the file and delete '
            'both the baseline entry and its register line). Then set '
            '`measured:` to the resolved version on every entry the run '
            'covered.\n\n'
            'Do NOT simply bump `measured:` to silence this. The string is a '
            'claim that a run happened; making it true without one is the '
            'exact substitution — prose in the shape of a measurement — that '
            'SCC44 found six times over.',
      );
    });

    test('F-SCE141-2 (control): the register is non-empty and its stamps are '
        'readable versions [2026-09-22] (PASS)', () {
      // Anti-vacuity for the case above, which is an emptiness assertion over a
      // comprehension: an empty register, or a `measured` string
      // [_versionExceeds] cannot parse, satisfies it while checking nothing.
      // 47 entries when this was written, every stamp 0.65.0.
      expect(
        _pinnedInterpreterFloors.length,
        greaterThanOrEqualTo(20),
        reason:
            'Only ${_pinnedInterpreterFloors.length} pinned entries, against '
            '47 measured on 2026-09-22. F-SCE141-1 is a loop over this map, so '
            'a collapse here makes it pass over nothing.',
      );
      final malformed = [
        for (final entry in _pinnedInterpreterFloors.entries)
          if (!RegExp(r'^\d+\.\d+\.\d+$').hasMatch(entry.value.measured) ||
              !RegExp(r'^\d+\.\d+\.\d+$').hasMatch(entry.value.floor))
            '${entry.key}: floor "${entry.value.floor}", measured '
                '"${entry.value.measured}"',
      ];
      expect(
        malformed,
        isEmpty,
        reason:
            'A stamp _versionExceeds cannot parse throws rather than comparing, '
            'so these would take the whole case down with them — or, worse, be '
            'made to compare equal by a defensive catch somebody adds '
            'later:\n  ${malformed.join('\n  ')}',
      );
    });

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

      final declared = _floorsDeclaredInComments();

      // Part two — the scan reached the entries, BEFORE anything is concluded
      // from it. SCD122 measured this scanner returning the EMPTY MAP: the one
      // entry that had ever been written with a `floor past X.Y.Z` comment had
      // since been converged away, and the flip conditions that remained were
      // stated in the `///` header narrative instead. Part three below was
      // still doing its job, but part two was asserting over nothing and
      // passing — the precise shape [_floorsDeclaredInComments]'s own doc
      // comment warns about, and the shape F-SCC44-1 part one exists to stop
      // for the sibling scanner.
      //
      // This is the direction the register can enforce. "Every comment names a
      // registered floor" (part three of this block) cannot notice a flip
      // condition nobody wrote down; "every registered floor is named in a
      // comment above its entry" can, and it is what makes deleting a register
      // line turn this test red instead of silently narrowing its subject.
      final livePins = _pinnedInterpreterFloors.keys.where(live.contains);
      final undeclared = [
        for (final path in livePins)
          if (declared[path] == null)
            '$path: registered as waiting on '
                '${_pinnedInterpreterFloors[path]!.floor}, no comment above '
                'its '
                'baseline entry says so',
      ];
      expect(
        undeclared,
        isEmpty,
        reason:
            'A pinned floor is invisible to the reader of the entry it belongs '
            'to. Put the condition in a `//` comment run immediately above the '
            'baseline entry, in the form this scan reads — "Re-port when a '
            'publish raises exec\'s floor past X.Y.Z." The narrative in the '
            'header doc comment is worth keeping, but it is not attributable '
            'to an entry and so cannot be checked against this '
            'register:\n${undeclared.join('\n')}',
      );

      // Part three — the register agrees with the prose. The observed failure
      // mode was an entry whose flip condition lived only in a comment; this
      // makes writing the comment insufficient on its own.
      final unregistered = <String>[];
      declared.forEach((path, version) {
        if (!live.contains(path)) return;
        final registered = _pinnedInterpreterFloors[path]?.floor;
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

      // Part four — the point of the whole register. Everything whose publish
      // has landed is now due, and the failure message IS the checklist.
      //
      // SCD159 changed WHICH VERSION this asks about. It used to compare the pin
      // against the declared floor, which is not what the suite runs: the
      // constraint moves when somebody edits the pubspec, the resolved version
      // moves on every `pub upgrade`, and a caret bound admits everything up to
      // the next major. Between a publish and the constraint bump that follows
      // it, every pin in that window was actionable while this reported it as
      // waiting.
      final resolved = _execAstResolved();
      final due = <String>[];
      final stalePins = <String>[];
      _pinnedInterpreterFloors.forEach((path, pin) {
        final waitingOn = pin.floor;
        switch (_pinVerdict(waitingOn, floor: floor, resolved: resolved)) {
          case _PinVerdict.floorRaised:
            stalePins.add(
              '$path — waited on $waitingOn; the CONSTRAINT is $floor, so '
              'nothing here can resolve an interpreter old enough to justify '
              'the entry',
            );
          case _PinVerdict.due:
            due.add(
              '$path — waited on $waitingOn; this run resolved $resolved',
            );
          case _PinVerdict.waiting:
            break;
        }
      });
      expect(
        [...stalePins, ...due],
        isEmpty,
        reason:
            "exec resolves tom_d4rt_ast $resolved (constraint $floor), which "
            'passes the version these entries were waiting for. The '
            'interpreter behaviour they were pinned to is published, so each '
            'one can be re-ported now: '
            'copy the twin from ../tom_d4rt/test over the exec copy, rewrite '
            'the interpreter import, run it, and delete both the baseline '
            'entry and its line in _pinnedInterpreterFloors. If one of them '
            'turns out still to fail, that is a real finding and needs a fresh '
            'entry saying so — do not re-pin it to the next version without '
            'measuring. `dart run tool/remeasure_pins.dart` does that '
            'measurement for every entry at once and prints the failing case '
            'ids to paste into the entry.\n\n'
            'An entry listed as CONSTRAINT-stale is the stronger case: it is '
            'not merely re-portable, nothing in this package can resolve an '
            'interpreter old enough for it, so leaving the register line is '
            'recording a wait that cannot happen.\n'
            '${[...stalePins, ...due].join('\n')}',
      );
    });
  }, skip: skipReason);

  group(
    'SCD126: every standing UNCOVERED entry is justified in writing',
    () {
      test('F-SCD126-1: each _uncoveredBaseline entry carries a reason '
          '[2026-09-15] (PASS)', () {
        // THE SAME GUARANTEE F-SCC44-1 GIVES THE OTHER MAP, and for the same
        // reason. SCC44 measured `_divergentBaseline` by simply running the
        // experiment its entries assert is impossible, and 32 of 38 converged on
        // the spot: they had never been verdicts, only assumptions written in the
        // syntax of one, each absorbing every subsequent change to its file for as
        // long as it stood.
        //
        // `_uncoveredBaseline` has the identical property — an entry says a
        // reference file has no exec counterpart, and while it stands nothing
        // notices if one becomes possible — and it had NO shape guarantee at all:
        // its values are case counts, so nothing distinguished "this file cannot
        // be ported" from "nobody has ported it".
        //
        // SCD126 re-measured it and the ratio did NOT reproduce: 8 of 9 entries
        // already carried a reason confirmed against a run or the source, with a
        // date, left by SCD25, SCD74, SCD79 and SCD157. The ninth
        // (`stdlib/member_coverage_baseline_test.dart`) was confirmed from source
        // in the same pass. This case is what stops the tenth from being written
        // without one.
        final reasons = _uncoveredEntryComments();

        // Part one — the scanner reached the map, before anything is concluded
        // from it. A source scan that matches nothing passes every assertion built
        // on it; this file has had that failure twice (SCC44's value-type change,
        // and the empty floor scan SCD122 found), so coverage is asserted first.
        expect(
          reasons.keys.toSet(),
          equals(_uncoveredBaseline.keys.toSet()),
          reason:
              'The comment scan did not pair up with _uncoveredBaseline. Either '
              'an entry has no comment run above it — write the reason, and say '
              'whether it was confirmed by a run or from the source — or the '
              'entry syntax changed and this scanner stopped seeing it, which '
              'would make every assertion below pass over nothing.',
        );

        // Part two — the reason says something. The threshold is deliberately
        // crude: it separates a sentence from a placeholder, and nothing more. No
        // check can tell a measured reason from a plausible one, which is why the
        // register asks for the DATE and the method — those are what the next
        // reader re-measures against.
        final thin = [
          for (final entry in reasons.entries)
            if (entry.value.trim().length < 40)
              '${entry.key}: "${entry.value.trim()}"',
        ];
        expect(
          thin,
          isEmpty,
          reason:
              'These entries have a comment but not a reason. An uncovered entry '
              'is a claim that a port is impossible or not worth making, and the '
              'next reader cannot re-derive which from a path and a case '
              'count:\n${thin.join('\n')}',
        );
      });
    },
    skip: skipReason,
  );

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
    test('F-SCE142-1: a convergence reason describes the file it is '
        'attached to [2026-09-22] (PASS)', () {
      // SCE142. F-SCC44-1 checks that an entry HAS a reason; F-SCC44-2 checks
      // that the pair it names still agrees. Neither looks at what the reason
      // SAYS — so when two entries had their reasons written against each
      // other's file, every guard here passed and only a reader who opened both
      // reference headers could notice. A reason attached to the wrong file is
      // unreviewable in the most convincing way: it is a true sentence.
      //
      // THE GATE IS ZERO, AND THAT IS MEASURED RATHER THAN CHOSEN. Computing
      // the overlap across the whole register on 2026-09-22 gave: three correct
      // entries at 0.50 (`d4_helpers` names exec's imports, `stream_consumer`
      // deliberately names a SIBLING entry, `bridged_class` names this guard's
      // own `_normalise`), five at 1.00, and the two swapped entries at 0.00.
      // Any threshold above zero fires on a correct entry, and a guard that
      // fires on correct entries gets deleted — which is the failure this todo
      // said to avoid ahead of building anything.
      //
      // A REASON WITH NO DISTINCTIVE TERMS IS UNSCOREABLE, not a miss. Six of
      // the fourteen entries are plain prose citing a commit, and reporting
      // those as zero-overlap would bury the finding in noise. They are counted
      // in the control below so that "unscoreable" cannot quietly become the
      // whole register.
      final unrelated = <String>[];
      var scored = 0;
      _convergenceLog.forEach((path, entry) {
        if (entry.why.contains('names-own-file: n/a')) return;
        final refFile = File('${refTests.path}/$path');
        if (!refFile.existsSync()) return; // F-SCC44-2's finding, not this one.
        final score = _reasonOverlap(entry.why, refFile);
        if (score == null) return;
        scored++;
        if (score > 0) return;

        // Name the likely owner. The defect this was written for is a
        // PERMUTATION — the reasons were swapped, not invented — so the entry
        // whose file the terms DO match is the answer, and printing it turns a
        // finding into a fix. Measured on the pre-correction text: each swapped
        // reason scored 0.00 against its own file and 1.00 against the other's.
        final better = <String>[];
        for (final other in _convergenceLog.keys) {
          if (other == path) continue;
          final otherFile = File('${refTests.path}/$other');
          if (!otherFile.existsSync()) continue;
          if ((_reasonOverlap(entry.why, otherFile) ?? 0) > 0) {
            better.add(other);
          }
        }
        unrelated.add(
          '$path: none of ${_distinctiveTerms(entry.why).toList()..sort()} '
          'appears in its reference file'
          '${better.isEmpty ? '' : '; they do appear in ${better.join(', ')}'}',
        );
      });

      expect(
        unrelated,
        isEmpty,
        reason:
            'These convergence reasons name identifiers their own reference '
            'file does not contain:\n  ${unrelated.join('\n  ')}\n\n'
            'When another entry is named, that is almost certainly where the '
            'reason belongs — two entries once had theirs swapped and both '
            'read as true. Otherwise the reason may be about exec\'s copy or '
            'about this guard, which is legitimate: say so by writing '
            '`names-own-file: n/a — <why>` into the reason.',
      );
      expect(
        scored,
        greaterThanOrEqualTo(5),
        reason:
            'Only $scored of ${_convergenceLog.length} reasons yielded any '
            'distinctive term, against 8 measured on 2026-09-22. The extractor '
            'has probably stopped matching, which makes the case above pass '
            'over nothing.',
      );
    });

    test('F-SCE142-2 (control): the check ranks the defect it was written for '
        '[2026-09-22] (PASS)', () {
      // THE HISTORICAL DEFECT AS THE CONTROL, rather than a synthetic one. The
      // todo asked for exactly this and asked for it BEFORE the guard was
      // shipped: "do not ship a guard whose negative control is the defect it
      // was written for and fails to rank it." These are the two reasons
      // verbatim as they stood before SCD125 corrected them (commit 37ffe85e1).
      //
      // The result is stronger than ranking: the permutation is LOCALISABLE.
      // Each reason scores 0.00 against the entry it was attached to and 1.00
      // against the entry it belongs to, so the check does not merely flag the
      // pair, it says which way round they go — which is what F-SCE142-1 prints.
      const dfub5 = 'dfub5_function_record_runtime_type_test.dart';
      const dfub6 = 'dfub6_applied_generic_runtime_types_test.dart';
      const swappedOntoDfub5 =
          'the exec copy carried an explanation the reference lacked — the '
          'SAstNode tree has no parent pointers, so the applied return type is '
          'captured at declaration time.';
      const swappedOntoDfub6 =
          'same shape as dfub5: the exec copy recorded that tom_ast_generator '
          'used to flatten RecordTypeAnnotationField, which the reference '
          'header did not say.';

      final five = File('${refTests.path}/$dfub5');
      final six = File('${refTests.path}/$dfub6');
      expect(
        five.existsSync() && six.existsSync(),
        isTrue,
        reason:
            'both reference files must be present for this control to mean '
            'anything',
      );

      expect(
        _reasonOverlap(swappedOntoDfub5, five),
        equals(0.0),
        reason:
            'the swapped reason must score zero against the entry it was '
            'wrongly attached to — otherwise F-SCE142-1 would not have fired',
      );
      expect(
        _reasonOverlap(swappedOntoDfub6, six),
        equals(0.0),
        reason: 'as above, for the other half of the swap',
      );
      expect(
        _reasonOverlap(swappedOntoDfub5, six),
        equals(1.0),
        reason:
            'and it must score FULL against the entry it belongs to, which '
            'is what lets the failure message name the owner',
      );
      expect(
        _reasonOverlap(swappedOntoDfub6, five),
        equals(1.0),
        reason: 'as above, for the other half',
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

  group('SCD124: the port recipe reads in both directions', () {
    // `port_recipe.dart` is one table read two ways: `_normalise` collapses both
    // spellings to a token so a port compares equal to its twin, and
    // `tool/remeasure_pins.dart` rewrites the reference spelling into the exec
    // one so a twin can be RUN here. Before SCD124 those were two tables; the
    // failure of two tables is silent and asymmetric, because only one of them
    // is exercised by a suite. These two cases are what make the table's other
    // direction non-theoretical without running the tool.
    test('F-SCD124-1: rewriting a reference import produces something the '
        'guard calls a port [2026-09-14]', () {
      for (final import in portImports) {
        final reference = "import '${import.reference}';";
        expect(
          _normalise(rewriteReferenceImports(reference)),
          equals(_normalise(reference)),
          reason:
              'The rewrite of ${import.reference} does not normalise to the '
              'same token as the original, so the tool would produce a file '
              'this guard does not consider a port.',
        );
        expect(
          rewriteReferenceImports(reference),
          contains(import.exec),
          reason: 'the rewrite did not reach the exec spelling',
        );
      }
    });

    test('F-SCD124-2 (control): the rewrite is not a no-op and not a '
        'sledgehammer [2026-09-14]', () {
      // A table whose every pair mapped a string to itself would pass the case
      // above vacuously, and one that rewrote too eagerly would corrupt an
      // unrelated import. `package:tom_d4rt_ast/` is the trap: it does not
      // start with `package:tom_d4rt/`, and an implementation that matched on
      // the package NAME rather than the full path would break it.
      for (final import in portImports) {
        expect(
          import.exec,
          isNot(equals(import.reference)),
          reason: '${import.token} maps a spelling to itself',
        );
      }
      const untouched =
          "import 'package:tom_d4rt_ast/runtime.dart';\n"
          "import 'package:test/test.dart';\n"
          "import 'interpreter_test.dart';";
      expect(rewriteReferenceImports(untouched), equals(untouched));
    });
  });
}
