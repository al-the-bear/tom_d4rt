// REPO-WIDE GUARD (tom_d4rt) — the two barrels export the same public names, and each place they do not is recorded.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt's
// suite runs and a session working elsewhere in the repo reaches none of it.
// SCD129 made that arrangement visible rather than incidental: `grep -rn
// 'REPO-WIDE GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// SCD134 — `package:tom_d4rt/d4rt.dart` and `package:tom_d4rt_ast/runtime.dart`
// are the two public faces of one interpreter. They had drifted, and nothing
// measured it.
//
// HOW THE DRIFT PRESENTS. Not as a compile error — as a type a consumer
// RECEIVES but cannot NAME. `BridgedEnumDefinition.buildBridgedEnum()` returns a
// `BridgedEnum` and `Environment.getRuntimeType` hands one back for any enum
// value, yet `BridgedEnum` was reachable only through
// `package:tom_d4rt/src/bridge/bridged_enum.dart` — an implementation import,
// which `implementation_imports` exists to forbid. `InterpreterVisitor
// .moduleLoader` is a public field of type `ModuleLoader`, also unexported. The
// SCB10 error types the interpreter raises so that `on TypeError` matches in
// interpreted code could not be caught by name by a host. Three files, seven
// names, all of them already public in everything but the one way that counts.
//
// The AST twin exported all three equivalents, so the twin is the oracle: two
// faces of one interpreter should name the same things, and where they do not
// there is a reason worth writing down. SCD134 added the exports; this file is
// what stops the next one going unnoticed.
//
// AN ORACLE IS ALSO A CEILING, and the complement lives beside this file.
// Because the twin decides, this check cannot see a type BOTH lines forget to
// export. `sce156_public_type_nameability_test.dart` asks the stronger
// question the three findings above were all instances of — is every type in a
// public member's signature exported by the same barrel? — which needs no twin
// and looks at members, where this one looks only at top-level names. The two
// are separate because a resolved-analyzer walk costs seconds and this parse
// costs milliseconds; folding them together would make the cheap check as
// expensive as the thorough one.
//
// WHAT IS COMPARED. The set of public top-level names each barrel exports,
// computed by PARSING (no resolution) and following `export` / `part`
// directives within the owning package, honouring `show` / `hide`.
//
// WHAT IS DELIBERATELY NOT COMPARED:
//
//   * CROSS-PACKAGE RE-EXPORTS. `tom_d4rt_ast/runtime.dart` re-exports
//     `package:tom_ast_model/ast.dart`, the serializable mirror AST — 190 `S*`
//     types the reference line has no equivalent of, because it uses
//     `package:analyzer`'s AST and does not re-export that either. Following it
//     turns a 20-entry difference into a 208-entry one, 188 of which say the
//     same thing. The skipped URIs are themselves asserted (F-SCD134-4), so a
//     SECOND cross-package export cannot slip in under this exemption.
//   * MEMBERS. This compares top-level names only. `bridgedLibraryUris` exists
//     on `D4rtRunner` and has no counterpart on `D4rt`, and nothing here sees
//     that. Member-level parity is a much larger guard; see sce156.
//   * PRIVATE NAMES, and anything `show`/`hide` removes.
//
// THE DIVERGENCES ARE PINNED INDIVIDUALLY, not waved through by file. Each
// entry records its side and its reason, and a `counterpart` where the two
// lines simply named one concept differently — so a rename losing its other
// half is a finding rather than a quiet gap. F-SCD134-3 fails when an entry
// stops being divergent, so a resolved difference cannot leave a permanent
// permission behind.
//
// EACH TEST HERE HAS BEEN SEEN TO FAIL:
//
//   | Injected fault                                             | Fires      |
//   | ---------------------------------------------------------- | ---------- |
//   | the `bridged_enum.dart` export removed from this barrel     | 2          |
//   | `sdk_errors.dart`'s export removed                          | 2          |
//   | an allow-list entry deleted                                 | 2          |
//   | an allow-list entry for a name that is no longer divergent   | 3          |
//   | the twin barrel path pointed at a file that does not exist   | ALL FOUR   |
//   | `tom_ast_model` reached through a second cross-package URI    | 4          |
//
// The last-but-one row is worth knowing before reading a four-way red as four
// problems. With no twin names parsed, every AST-only entry looks absent, every
// reference-only name looks newly asymmetric, and the walk never reaches the
// package boundary it was going to stop at — so 2, 3 and 4 are all downstream of
// the same single cause. F-SCD134-1 is the one to believe, and it is ordered
// first for exactly that reason: nothing else here means anything until it
// passes. (SCD49's header records the same hazard for the same reason.)
@TestOn('vm')
library;

import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:test/test.dart';

import 'sibling_trees.dart';

/// This package's barrel, relative to the package root.
const _refBarrel = 'lib/d4rt.dart';

/// The twin's. A sibling checkout — both packages live in the one `tom_d4rt`
/// repository. `d4rt.dart` there is a one-line re-export of `runtime.dart`.
const _astBarrel = '../tom_d4rt_ast/lib/d4rt.dart';

const _refRoots = <String, String>{'tom_d4rt': 'lib'};
const _astRoots = <String, String>{'tom_d4rt_ast': '../tom_d4rt_ast/lib'};

/// Cross-package export URIs the walk is allowed to stop at.
///
/// Exactly one, and it is load-bearing that it stay exactly one: the mirror AST
/// is the AST line's reason for existing and the reference line's equivalent is
/// `package:analyzer`, which it does not re-export either. Anything else
/// crossing a package boundary is a surface this file would stop measuring, so
/// it has to be added here deliberately.
const _allowedSkips = <String>{'package:tom_ast_model/ast.dart'};

/// Both barrels exported ~150 names on 2026-09-15. The floor is well below that
/// because its job is to separate "compared the surfaces" from "compared
/// nothing" — a walk that silently parsed no declarations would otherwise
/// satisfy every emptiness assertion below.
const _minNames = 120;

/// Which side a divergence is on.
enum _Side { refOnly, astOnly }

/// One recorded divergence.
class _Divergence {
  const _Divergence(this.side, this.reason, {this.counterpart});

  final _Side side;
  final String reason;

  /// The other line's name for the same concept, when the two simply chose
  /// different names. Asserted to still exist on that side (F-SCD134-3), so a
  /// rename cannot lose half of itself silently.
  final String? counterpart;
}

/// Every name the two barrels disagree on, and why.
///
/// Read the `reason` strings as the actual answer to "are the twins in sync" —
/// the count is not the point, the classification is. Two entries are marked as
/// GAPS rather than structural differences and carry their own todo ids; the
/// rest are consequences of one line having an analyzer and the other not.
const _divergences = <String, _Divergence>{
  // ── The bundle format: the AST line's whole reason for existing ──────────
  'AstBundle': _Divergence(
    _Side.astOnly,
    'pre-compiled AST bundles are the analyzer-free delivery format; the '
    'reference line executes source and has no bundle',
  ),
  'AstBundleFormat': _Divergence(_Side.astOnly, 'part of AstBundle'),
  'AstBundleManifest': _Divergence(_Side.astOnly, 'part of AstBundle'),

  // ── One concept, two names ──────────────────────────────────────────────
  'AstModuleLoader': _Divergence(
    _Side.astOnly,
    'the AST line\'s module loader; resolves pre-bundled modules rather than '
    'reading source from disk',
    counterpart: 'ModuleLoader',
  ),
  'ModuleLoader': _Divergence(
    _Side.refOnly,
    'the reference line\'s module loader; `InterpreterVisitor.moduleLoader` '
    'is typed with it, which is why SCD134 exported it',
    counterpart: 'AstModuleLoader',
  ),
  'D4rtRunner': _Divergence(
    _Side.astOnly,
    'the AST line\'s interpreter class, with `D4rt` as a typedef onto it. On '
    'the reference line `D4rt` IS the class, so `D4rt` is exported by both '
    'and only the second name is asymmetric',
    counterpart: 'D4rt',
  ),

  // ── The AST line abstracts what it cannot depend on ─────────────────────
  'ModuleContext': _Divergence(
    _Side.astOnly,
    'module loading behind an interface, because the AST line must run with '
    'no `dart:io` (web-safe) — the reference line holds a concrete '
    '`ModuleLoader` instead',
  ),
  'NoOpModuleContext': _Divergence(_Side.astOnly, 'part of ModuleContext'),
  'PermissionChecker': _Divergence(
    _Side.astOnly,
    'permission checking behind an interface for the same reason. Note the '
    'behavioural difference SCD49 records: the reference reaches the '
    'permission table through a nullable `D4rt` and SKIPS the check when '
    'it is null, while the twin always performs it',
  ),

  // ── The analyzer source front end: on the AST line that is tom_d4rt_exec ─
  'executeSource': _Divergence(
    _Side.refOnly,
    'analyzer-driven source execution. The AST line\'s equivalent lives in '
    '`tom_d4rt_exec`, which is a separate package precisely so the '
    'interpreter stays analyzer-free',
  ),
  'executeFile': _Divergence(_Side.refOnly, 'part of the source front end'),
  'executeFileContinued': _Divergence(
    _Side.refOnly,
    'part of the source front end',
  ),
  'resolveImportsRecursively': _Divergence(
    _Side.refOnly,
    'part of the source front end',
  ),
  'ScriptExecutionResult': _Divergence(
    _Side.refOnly,
    'part of the source front end',
  ),
  'StaticCoord': _Divergence(
    _Side.refOnly,
    'the reference resolver returns coordinate objects; the mirror resolver '
    'writes `SSimpleIdentifier.resolvedSlot` onto the nodes instead, so '
    'there is nothing to name',
  ),

  // ── Present on both lines, but one of them exports it from tom_ast_model ──
  //
  // These two are the visible cost of the `_allowedSkips` exemption, and they
  // are listed rather than hidden by it: the guard reports them, and the honest
  // answer is "the AST line has this, one package over". Following
  // `tom_ast_model` to reach them would drag in 188 `S*` types that say nothing.
  'StaticResolver': _Divergence(
    _Side.refOnly,
    'the lexical resolver EXISTS on the AST line — `tom_ast_model`\'s '
    '`ast_scope_resolver.dart`, re-exported through '
    '`tom_d4rt_ast/ast.dart`, and called from its `InterpreterVisitor '
    '.resolveStaticCoordinates`. Asymmetric only because this walk stops '
    'at the package boundary',
  ),
  'opensLexicalFrame': _Divergence(
    _Side.refOnly,
    'same file and same reason as StaticResolver',
  ),

  // ── Not structural. One recorded gap, with a todo. ──────────────────────
  //
  // `D4rtUserProxy` / `D4rtUserRelaxer` were here and are gone: SCE154
  // mirrored `d4rt_user_proxy_annotation.dart` into the AST tree and exported
  // it from `runtime.dart`. Nothing about the analyzer-free design required
  // their absence — an annotation is a marker class with no analyzer
  // dependency — and their own `generator/d4.dart` doc comment had been
  // telling AST-line consumers to apply an annotation their dependency did
  // not declare.
  'BarrelMapping': _Divergence(
    _Side.refOnly,
    'dead API, now DEPRECATED with a removal version (sce155). The runtime '
    'deduplication these three describe happens at generation time instead, '
    'in tom_d4rt_generator\'s PerPackageBridgeOrchestrator — superseded, not '
    'unfinished. Measured 2026-09-23: no .dart file in the workspace names '
    'them beyond this guard and the declaring file, and pub.dev\'s four '
    'dependents of tom_d4rt are all this workspace\'s own and name none of '
    'them. Removal is breaking, so it is due at 2.0.0 and held by '
    'sce155_dead_surface_removal_test.dart rather than by a todo; these three '
    'entries come out in the same commit as the file',
  ),
  'LibraryBridgeDefinition': _Divergence(
    _Side.refOnly,
    'deprecated dead API, same file as BarrelMapping (sce155)',
  ),
  'ModuleBridgeInfo': _Divergence(
    _Side.refOnly,
    'deprecated dead API, same file as BarrelMapping (sce155)',
  ),
};

/// Cross-package URIs the last walk declined to follow.
final Set<String> _skipped = <String>{};

/// Files a walk expected and did not find. Non-empty means the measurement is
/// void, not that the surfaces agree.
final Set<String> _missing = <String>{};

String? _resolveUri(String uri, String fromFile, Map<String, String> roots) {
  if (uri.startsWith('package:')) {
    final rest = uri.substring('package:'.length);
    final slash = rest.indexOf('/');
    if (slash < 0) return null;
    final root = roots[rest.substring(0, slash)];
    if (root == null) {
      _skipped.add(uri);
      return null;
    }
    return '$root/${rest.substring(slash + 1)}';
  }
  if (uri.startsWith('dart:')) return null;
  return '${File(fromFile).parent.path}/$uri';
}

/// The public top-level names [barrel] exports, following `export` and `part`
/// within the packages named in [roots].
Set<String> _exportedNames(String barrel, Map<String, String> roots) {
  final names = <String>{};
  final visited = <String>{};

  void walk(String path, Set<String>? show, Set<String> hide) {
    if (!visited.add('$path|${show?.join(",")}|${hide.join(",")}')) return;
    final file = File(path);
    if (!file.existsSync()) {
      _missing.add(path);
      return;
    }
    final unit = parseString(
      content: file.readAsStringSync(),
      featureSet: FeatureSet.latestLanguageVersion(),
      throwIfDiagnostics: false,
    ).unit;

    void emit(String name) {
      if (name.startsWith('_')) return;
      if (show != null && !show.contains(name)) return;
      if (hide.contains(name)) return;
      names.add(name);
    }

    for (final declaration in unit.declarations) {
      if (declaration is NamedCompilationUnitMember) {
        emit(declaration.name.lexeme);
      } else if (declaration is TopLevelVariableDeclaration) {
        for (final variable in declaration.variables.variables) {
          emit(variable.name.lexeme);
        }
      }
    }

    for (final directive in unit.directives) {
      // A part's declarations belong to the enclosing library, so the
      // combinators in force carry straight through.
      if (directive is PartDirective) {
        final uri = directive.uri.stringValue;
        if (uri == null) continue;
        final resolved = _resolveUri(uri, path, roots);
        if (resolved != null) walk(resolved, show, hide);
        continue;
      }
      if (directive is! ExportDirective) continue;
      final uri = directive.uri.stringValue;
      if (uri == null) continue;
      final resolved = _resolveUri(uri, path, roots);
      if (resolved == null) continue;

      final nestedShow = <String>{};
      final nestedHide = <String>{...hide};
      for (final combinator in directive.combinators) {
        if (combinator is ShowCombinator) {
          nestedShow.addAll(combinator.shownNames.map((e) => e.name));
        } else if (combinator is HideCombinator) {
          nestedHide.addAll(combinator.hiddenNames.map((e) => e.name));
        }
      }
      // `show` composes by intersection: a name must survive every clause on
      // the path from the barrel down to its declaration.
      final effectiveShow = nestedShow.isEmpty
          ? show
          : (show == null ? nestedShow : show.intersection(nestedShow));
      walk(resolved, effectiveShow, nestedHide);
    }
  }

  walk(barrel, null, <String>{});
  return names;
}

void main() {
  // SCD158: this guard resolves its subject relative to the package it
  // runs in, so a copy anywhere else measures a different tree in silence.
  requirePackage(
    'tom_d4rt',
    subject: "this package's barrel files and their twins",
  );

  late Set<String> refNames;
  late Set<String> astNames;

  setUpAll(() {
    _skipped.clear();
    _missing.clear();
    refNames = _exportedNames(_refBarrel, _refRoots);
    astNames = _exportedNames(_astBarrel, _astRoots);
  });

  group('SCD134: the twins\' barrels export the same names', () {
    test('F-SCD134-1: both surfaces were actually read [2026-09-15]', () {
      expect(
        _missing,
        isEmpty,
        reason:
            'a barrel or an exported file could not be found, so the name '
            'sets below are incomplete and every difference they report is '
            'meaningless. Nothing else in this file means anything until '
            'this passes:\n  ${_missing.join('\n  ')}',
      );
      expect(
        refNames.length,
        greaterThanOrEqualTo(_minNames),
        reason:
            'only ${refNames.length} names parsed out of $_refBarrel — a '
            'walk that found nothing satisfies every set comparison below',
      );
      expect(
        astNames.length,
        greaterThanOrEqualTo(_minNames),
        reason: 'only ${astNames.length} names parsed out of $_astBarrel',
      );
    });

    test('F-SCD134-2: every name only one barrel exports is recorded, with a '
        'reason [2026-09-15]', () {
      final unrecorded = <String>[];
      for (final name in (astNames.difference(refNames).toList()..sort())) {
        final recorded = _divergences[name];
        if (recorded == null || recorded.side != _Side.astOnly) {
          unrecorded.add('$name — exported by the AST twin only');
        }
      }
      for (final name in (refNames.difference(astNames).toList()..sort())) {
        final recorded = _divergences[name];
        if (recorded == null || recorded.side != _Side.refOnly) {
          unrecorded.add('$name — exported by tom_d4rt only');
        }
      }

      expect(
        unrecorded,
        isEmpty,
        reason:
            '${unrecorded.length} name(s) differ between the two public '
            'faces of one interpreter with no recorded reason. Either export '
            'it from the barrel that is missing it, or add a `_Divergence` '
            'saying why the two lines genuinely differ there — a name that '
            'is public on one line and unnameable on the other is the defect '
            'this file exists for:\n  ${unrecorded.join('\n  ')}',
      );
    });

    test(
      'F-SCD134-3: no allow-list entry outlives its divergence [2026-09-15]',
      () {
        // scd49's lesson: a permission left behind after the difference is
        // resolved silently un-guards the name it names.
        final stale = <String>[];
        _divergences.forEach((name, recorded) {
          final present = switch (recorded.side) {
            _Side.astOnly => astNames.contains(name),
            _Side.refOnly => refNames.contains(name),
          };
          final absentOnOther = switch (recorded.side) {
            _Side.astOnly => !refNames.contains(name),
            _Side.refOnly => !astNames.contains(name),
          };
          if (!present) {
            stale.add(
              '$name — recorded as ${recorded.side.name} but the '
              'barrel that should export it no longer does',
            );
          } else if (!absentOnOther) {
            stale.add(
              '$name — recorded as ${recorded.side.name} but BOTH '
              'barrels export it now. Delete the entry; the divergence is '
              'resolved',
            );
          }
          final counterpart = recorded.counterpart;
          if (counterpart != null) {
            final otherSide = recorded.side == _Side.astOnly
                ? refNames
                : astNames;
            if (!otherSide.contains(counterpart)) {
              stale.add(
                '$name — its recorded counterpart `$counterpart` is '
                'no longer exported by the other line, so one concept has '
                'lost half its naming',
              );
            }
          }
        });

        expect(
          stale,
          isEmpty,
          reason:
              '${stale.length} allow-list entr(y/ies) no longer describe '
              'reality:\n  ${stale.join('\n  ')}',
        );
      },
    );

    test('F-SCD134-4: the walk stopped only at the recorded package boundary '
        '[2026-09-15]', () {
      expect(
        _skipped,
        _allowedSkips,
        reason:
            'this file exempts exactly one cross-package re-export — the '
            'mirror AST, whose reference-line equivalent is '
            '`package:analyzer` and is not re-exported either. A second one '
            'is a public surface that stops being compared, so it has to be '
            'added here deliberately. Found: $_skipped',
      );
    });
  });
}
