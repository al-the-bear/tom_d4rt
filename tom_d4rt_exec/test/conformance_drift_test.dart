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
//
// That is what the guard was actually for: nothing detected *additions*. The
// existing backlog is a separate, owned remediation, and porting it is how these
// lists shrink — never by relaxing the comparison.
//
// MEASURED 2026-09-04 on mbp, after SCC7's ports: reference 185 test files, exec
// 176, tom_d4rt_ast 54. Forty reference files have no same-path counterpart in
// exec; 27 are covered elsewhere, 13 are genuinely uncovered (121 cases). Of the
// 145 files present in both trees, 30 differ by more than the one import line the
// port recipe legitimately rewrites.
//
// Those figures are a snapshot for orientation only — the BASELINES below are the
// authority, because they are the thing a failing test forces someone to update.
// A count in a comment is exactly the artifact this guard exists to replace.
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
  const _Coverage(this.where, this.why, {this.refCases = 0, this.twinCases = 0});

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
      'ast:runtime/extract_bridged_arg_diagnostics_test.dart', _astTwin,
      refCases: 3, twinCases: 3),
  'bridge/facade_user_registration_test.dart': _Coverage(
      'ast:runtime/facade_user_registration_test.dart', _astTwin,
      refCases: 5, twinCases: 5),
  'bridge/unwrap_as_test.dart': _Coverage(
      'ast:runtime/unwrap_as_test.dart', _astTwin,
      refCases: 12, twinCases: 12),
  'bridge/usage_log_test.dart': _Coverage(
      'ast:runtime/usage_log_test.dart', _astTwin,
      refCases: 9, twinCases: 9),
  'bridge_retention_test.dart': _Coverage(
      'ast:runtime/bridge_retention_test.dart', _astTwin,
      refCases: 3, twinCases: 3),
  'bridged_enum_memo_test.dart': _Coverage(
      'ast:bridged_enum_memo_test.dart', _astTwin,
      refCases: 3, twinCases: 3),
  'bridged_module_env_cache_test.dart': _Coverage(
      'ast:runtime/bridged_module_env_cache_test.dart', _astTwin,
      refCases: 3, twinCases: 3),
  'dgub5_filesystem_permission_symlink_test.dart': _Coverage(
      'ast:runtime/dgub5_filesystem_permission_symlink_test.dart', _astTwin,
      refCases: 6, twinCases: 3),
  'environment_lazy_bridge_test.dart': _Coverage(
      'ast:environment_lazy_bridge_test.dart', _astTwin,
      refCases: 17, twinCases: 17),
  'environment_lookup_test.dart': _Coverage(
      'ast:runtime/environment_lookup_test.dart', _astTwin,
      refCases: 8, twinCases: 8),
  'extension_hook_test.dart': _Coverage(
      'ast:runtime/extension_hook_test.dart', _astTwin,
      refCases: 7, twinCases: 7),
  'extension_once_per_process_test.dart': _Coverage(
      'ast:runtime/extension_once_per_process_test.dart', _astTwin,
      refCases: 3, twinCases: 3),
  'phase1_uri_registration_test.dart': _Coverage(
      'ast:runtime/phase1_uri_registration_test.dart', _astTwin,
      refCases: 4, twinCases: 4),
  'pool_security_test.dart': _Coverage(
      'ast:runtime/pool_security_test.dart', _astTwin,
      refCases: 4, twinCases: 4),
  'profiler_disabled_test.dart': _Coverage(
      'ast:profiler_disabled_test.dart', _astTwin,
      refCases: 2, twinCases: 2),
  'reuse_across_runs_toggle_test.dart': _Coverage(
      'ast:runtime/reuse_across_runs_toggle_test.dart', _astTwin,
      refCases: 3, twinCases: 3),
  'scb10_sdk_shaped_errors_test.dart': _Coverage(
      'ast:runtime/scb10_sdk_shaped_errors_test.dart', _astTwin,
      refCases: 18, twinCases: 4),
  'stdlib/bridge_arity_test.dart': _Coverage(
      'ast:runtime/bridge_arity_test.dart', _astTwin,
      refCases: 13, twinCases: 8),
  'warm_parent_lazy_class_test.dart': _Coverage(
      'ast:runtime/warm_parent_lazy_class_test.dart', _astTwin,
      refCases: 1, twinCases: 1),

  // ---- Native ast twins, `stdlib_`-prefixed --------------------------------
  'stdlib/convert/convert_hierarchy_test.dart': _Coverage(
      'ast:runtime/stdlib_convert_hierarchy_test.dart', _astStdlibPrefix,
      refCases: 15, twinCases: 11),
  'stdlib/io/io_reexport_visibility_test.dart': _Coverage(
      'ast:runtime/stdlib_io_reexport_visibility_test.dart', _astStdlibPrefix,
      refCases: 10, twinCases: 6),
  'stdlib/io/string_sink_collision_test.dart': _Coverage(
      'ast:runtime/stdlib_string_sink_collision_test.dart', _astStdlibPrefix,
      refCases: 4, twinCases: 4),
};

/// Reference files with a twin in NEITHER exec nor tom_d4rt_ast: the real gap.
///
/// This is a BASELINE, not an allowlist — every entry is a hole that should be
/// closed by porting, and the case count is the size of the hole. Removing an
/// entry is only correct once the file has a counterpart; the test then confirms
/// it. Adding an entry is only correct for a file that genuinely cannot be
/// ported, and no such file has been found yet — every one of these is portable
/// in principle.
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
  '_conway_perf_probe_test.dart': 1,
  'bridge/bridged_setter_unwrap_test.dart': 3,
  'bridge/d4_helpers_test.dart': 26,
  'bridge/enum_map_arg_and_roundtrip_test.dart': 6,
  'bridge/is_operator_on_unwrapped_native_test.dart': 5,
  'bridge/usage_log_runner_test.dart': 1,
  'environment_bridge_cache_test.dart': 4,
  'null_safety/null_propagating_operators_test.dart': 18,
  'scb11_symbol_literal_test.dart': 11,
  'scb14_await_receiver_position_test.dart': 12,
  'scb17_map_set_inherited_surface_test.dart': 7,
  'scb9_error_handler_arity_test.dart': 14,
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
///   * `stdlib/typed_data/byte_data_test.dart` differs only in a comment naming
///     which interpreter it exercises.
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
/// Six entries currently share ONE flip condition — the next `tom_d4rt_ast`
/// publish — because exec resolves that package from pub.dev, so this suite
/// certifies the PUBLISHED interpreter and not the working tree. Unpin all six
/// there and remove their entries in the same commit.
///
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
  'instance_field_shadows_global_test.dart',
  'interpreter_test.dart',
  'late_test.dart',
  'object_universal_members_test.dart',
  'open_issues/b11_warmup_test.dart',
  'open_issues/b1_redirecting_factory_test.dart',
  'open_issues/b5_bridged_exception_catch_test.dart',
  'open_issues/b9_static_field_sibling_write_test.dart',
  'operator_improvements_test.dart',
  'stdlib/collection/linked_list_test.dart',
  'stdlib/collection/list_queue_test.dart',
  'stdlib/collection/queue_test.dart',
  'stdlib/collection/splay_tree_map_test.dart',
  'stdlib/intentionally_unbridged_test.dart',
  'stdlib/typed_data/byte_data_test.dart',
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
String _normalise(String source) => source
    .replaceAll('package:tom_d4rt/d4rt.dart', '@INTERPRETER@')
    .replaceAll('package:tom_d4rt_exec/d4rt.dart', '@INTERPRETER@')
    .replaceAll('package:tom_d4rt/src/exceptions.dart', '@EXCEPTIONS@')
    .replaceAll('package:tom_d4rt_ast/src/runtime/exceptions.dart',
        '@EXCEPTIONS@');

Map<String, File> _testFiles(Directory root) {
  final prefix = '${root.path}${Platform.pathSeparator}';
  final result = <String, File>{};
  for (final entity in root.listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('_test.dart')) continue;
    result[entity.path
        .substring(prefix.length)
        .replaceAll(Platform.pathSeparator, '/')] = entity;
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
          path: _coveredElsewhere[path] ??
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
          reason: 'A coverage claim points at a file that no longer exists. '
              'Either the twin was renamed — update the entry — or it was '
              'deleted, in which case the reference file is now a real gap and '
              'belongs in _uncoveredBaseline.\n${broken.join('\n')}',
        );
      },
    );

    test(
      'F-SCC6-2: no reference test has appeared without a counterpart '
      '[2026-09-03] (PASS)',
      () {
        final uncovered = unmatched.entries
            .where((e) => e.value.where.isEmpty)
            .map((e) => e.key)
            .toSet();
        final appeared = uncovered.difference(_uncoveredBaseline.keys.toSet());
        final closed = _uncoveredBaseline.keys.toSet().difference(uncovered);

        expect(
          appeared,
          isEmpty,
          reason: 'A tom_d4rt test has no recorded counterpart. That is the '
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
          reason: 'These files now have a counterpart but are still listed in '
              '_uncoveredBaseline. Remove them: a stale baseline is how the '
              'ratchet loosens.\n${closed.join('\n')}',
        );
      },
    );

    test(
      'F-SCC6-3: partial twins are reported with their case deficit '
      '[2026-09-03] (PASS)',
      () {
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
        printOnFailure(partials
            .map((e) => '${e.key}: ${e.value.refCases} cases vs '
                '${e.value.twinCases} in ${e.value.where}')
            .join('\n'));
        expect(
          partials.length,
          lessThanOrEqualTo(6),
          reason: 'More files are now only PARTIALLY covered than when this was '
              'measured (6 files, $deficit cases short). A partial twin passes '
              'the presence check while leaving assertions unrun on the '
              'analyzer-free line.',
        );
      },
    );

    test(
      'F-SCC6-4: no shared file has started diverging in content '
      '[2026-09-03] (PASS)',
      () {
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
          reason: 'A file present in both trees has started asserting different '
              'things. This is the case a presence check cannot see: the name is '
              'on both sides and both suites are green. Either mirror the change '
              'into the other tree, or — if the divergence is deliberate — add '
              'it to _divergentBaseline with the reason in the comment '
              'above.\n${appeared.join('\n')}',
        );
        expect(
          converged,
          isEmpty,
          reason: 'These files no longer diverge. Remove them from '
              '_divergentBaseline so the next real divergence is not absorbed '
              'by a stale entry.\n${converged.join('\n')}',
        );
      },
    );
  }, skip: skipReason);
}
