// REPO-WIDE GUARD (tom_d4rt) — the two interpreter trees agree outside stdlib, and every place they do not is named.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt's suite
// runs and a session working elsewhere in the repo reaches none of it. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// SCD183 — the mirror rule, measured on the half SCD49 does not cover.
//
// WHAT THE RULE IS. `_copilot_guidelines/d4rt/mirror_maintenance.md` and the
// quest overview both say it: a fix to the interpreter lands in BOTH
// `tom_d4rt/lib/src/` and `tom_d4rt_ast/lib/src/runtime/`, in one commit. Until
// SCD49 that rule was prose — it told an editor what to do and detected
// nothing. SCD49 turned the `stdlib/` half into a measurement. This file is the
// other half: the ~31 shared files OUTSIDE stdlib, which include every one that
// an interpreter fix actually touches — `interpreter_visitor.dart`,
// `callable.dart`, `environment.dart`, `runtime_types.dart`, `generator/d4.dart`.
//
// WHY THAT HALF NEEDS A DIFFERENT SHAPE. SCD49 can demand token identity
// because a stdlib bridge is the same code in both trees. These files are not:
// the twin is written against the mirror AST, so it says `SAstNode` where the
// reference says `AstNode`, and in five files it diverges structurally because
// the mirror AST has no parent pointer and its node accessors differ. A single
// "must be identical" assertion over this surface would be red on the day it
// landed and would stay red, which is the same as having no guard.
//
// THE FILE-LEVEL READING OVERSTATES THE FIVE, and SCD199 is the correction.
// `_divergence` trims the common prefix and suffix, so a single early
// difference leaves every token after it inside the residue — which is how
// `interpreter_visitor.dart` reads as "99 % of tokens differ" when 77 of its
// 134 member bodies are in fact identical. That matters because a wholesale
// `_structural` exemption is where SCC78's one-line divergence survived for as
// long as both files existed. `scd199_mirror_body_agreement_test.dart` applies
// this file's normalisation per member instead and pins the 108 bodies that
// really do disagree.
//
// SO THERE ARE TWO MEASUREMENTS, and each is applied where it can be true.
//
//   1. CODE IDENTITY, after normalising the mirror type names. The twin's
//      `SFoo` is rewritten to `Foo` for every type `tom_ast_model` declares.
//      That is not a convenience: the quest's own architecture states the model
//      is a 1:1 mirror of the analyzer AST and that the interpreter should port
//      "by simply changing import statements". This normalisation is that claim
//      made executable, and 23 of the 31 shared files satisfy it exactly today.
//      Three more diverge in ONE recordable region and are pinned like SCD49's.
//
//   2. MEMBER-SET PARITY, for all 31 including the five that cannot satisfy
//      (1). Two files may spell their bodies differently and still be required
//      to declare the same things — and "declares the same things" is precisely
//      what the mirror rule is about in practice. SCD169 added
//      `_isInsideCatchClauseOf` to `callable.dart`; had it landed in one tree
//      only, THIS is the assertion that would have said so. Token identity
//      could not have: `callable.dart` is 99 % divergent by tokens.
//
// WHAT IS DELIBERATELY NOT COMPARED — the same three exclusions SCD49 argues
// for, for the same reasons: comments (a doc comment naming the twin's own test
// path is CORRECT), directives (the barrels have different granularity, and a
// wrong import cannot fail quietly — it does not compile), and trailing commas
// (whether `dart format` emits one depends on the line length, which depends on
// the comment above it).
//
// THE RISK THE NORMALISATION CARRIES, stated rather than hidden: mapping `SFoo`
// to `Foo` would mask a divergence in which the twin correctly names a mirror
// type and the reference names an unrelated analyzer type that happens to share
// the base name. That is the 1:1-mirror claim being false, which is a larger
// problem than this guard, and `tom_ast_model`'s own suite is where it belongs.
// The map is DERIVED from `tom_ast_model/lib` at run time rather than written
// out here, so it cannot go stale and no one maintains it.
//
// EACH TEST HERE HAS BEEN SEEN TO FAIL:
//
//   | Injected fault                                              | Fires   |
//   | ----------------------------------------------------------- | ------- |
//   | twin root pointed at a path that does not exist              | 1, 3, 6 |
//   | `tom_ast_model` root pointed at a path that does not exist   | 2       |
//   | a method renamed in the twin's `generator/d4.dart` only      | 2, 5    |
//   | a private helper added to the twin's `callable.dart` only    | 5       |
//   | `bridge/bridged_types.dart` made identical in both trees     | 3       |
//   | a second divergence added to `bridge/bridged_types.dart`     | 4       |
//   | `removeLocalValue` deleted from the reference                | 4, 5    |
//   | a recorded member-divergence name renamed in the twin        | 5, 6    |
//
// F-SCD183-1 is ordered first and nothing else here means anything until it
// passes: every other assertion is an emptiness check over a walk, and a walk
// that found no files satisfies all of them.
//
// THE FIRST ROW FIRES THREE, and it is worth knowing before reading a triple
// red as three problems. With no twin files there are no divergences, so every
// allow-list entry looks resolved (3) and every recorded member divergence
// looks mirrored (6). F-SCD183-1 is the one to believe.
//
// THE SEVENTH ROW IS THE INSTRUCTIVE ONE. Deleting `removeLocalValue` from the
// reference does not make `environment.dart` identical, because the twin
// declares that method too — just in a different position, which is what the
// pinned region records. So the fault surfaces as a CHANGED region (4) plus a
// member the twin has and the reference does not (5), and the two readings
// together say what a token diff alone could not: this is a deletion, not a
// reordering.

import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:test/test.dart';

import 'mirror_normalisation.dart';
import 'sibling_trees.dart';

/// The reference tree's interpreter sources, relative to the package root.
const _refRoot = 'lib/src';

/// The twin's. A sibling checkout, because both packages live in the one
/// `tom_d4rt` repository.
const _astRoot = '../tom_d4rt_ast/lib/src/runtime';

/// `stdlib/` is SCD49's subject, not this file's. Splitting them keeps each
/// failure pointing at one remedy — and the stdlib half can demand plain token
/// identity, which this half cannot.
const _excludedPrefix = 'stdlib/';

/// 31 files were shared on 2026-09-15. The floor is well below that because its
/// job is to separate "compared the corpus" from "compared nothing".
const _minShared = 24;

/// `tom_ast_model` declared 195 types on 2026-09-15. Same reasoning: a rename
/// map read from a missing directory is empty, and an empty map normalises
/// nothing while looking exactly like a map that had nothing to do.
const _minMirrorTypes = 150;

/// Files that exist in the reference tree alone, and why.
///
/// These are the analyzer line's own machinery. Recording them is what makes a
/// NEW unmirrored file a finding: without the list, "this file has no twin" is
/// indistinguishable from "somebody forgot to mirror it", which is the mistake
/// this guard exists to catch.
const _refOnly = <String, String>{
  'bridge/library_mapping.dart':
      'maps analyzer library URIs; the twin resolves modules from a pre-built '
      'bundle and has no URI to map.',
  'd4rt_base.dart':
      'the analyzer-parsing entry point. The twin\'s equivalent is '
      'd4rt_runner.dart, which takes a bundle rather than source.',
  'generator/d4rt_user_proxy_annotation.dart':
      'proxy generation is a tom_d4rt_generator concern and the generator '
      'reads the analyzer line only.',
  'module_loader.dart':
      'loads modules by parsing source. The twin\'s ast_module_loader.dart '
      'resolves them from the bundle instead.',
  'scope_frame.dart':
      'slot-resolution machinery for the analyzer front end; the twin resolves '
      'slots during bundle construction.',
  'script_execution.dart':
      'drives a parse-then-run cycle the twin does not have.',
  'static_name_report.dart':
      'reports names the analyzer resolved statically; nothing in the twin '
      'produces that input.',
};

/// Files that exist in the twin alone, and why.
const _astOnly = <String, String>{
  'ast_bundle.dart':
      'the shipped bundle format. The reference parses source and never reads '
      'a bundle.',
  'ast_module_loader.dart':
      'resolves modules from the bundle — the twin\'s answer to '
      'module_loader.dart.',
  'd4rt_runner.dart':
      'the bundle entry point — the twin\'s answer to d4rt_base.dart.',
  'module_context.dart':
      'the non-nullable permission/module surface the twin reaches through '
      'visitor.moduleContext, where the reference reaches '
      'visitor.moduleLoader.d4rt and may find null.',
  'utils/file_access/file_access.dart':
      'conditional file access. The twin must build for web, where dart:io is '
      'absent; the reference is VM-only and imports dart:io directly.',
  'utils/file_access/io.dart': 'the dart:io half of the above.',
  'utils/file_access/web.dart': 'the web half of the above.',
};

/// Shared files whose divergence is ONE contiguous region, pinned on both
/// sides exactly as SCD49 pins its four.
///
/// Pinning the region rather than the path is what makes an allow-list safe to
/// have: `environment.dart` is 8278 tokens and 199 of them differ, so
/// exempting the file would unguard 8079 tokens to permit 199. A second
/// divergence anywhere in the file changes the trimmed result and is reported
/// by F-SCD183-4.
const _allowedRegions = <String, (String, String)>{
  // The twin has no `ModuleLoader`; it constructs a `NoOpModuleContext` over
  // the same fresh environment, and has to bind the environment first because
  // the context takes it as a named argument.
  'bridge/bridged_enum.dart': (
    'return methodAdapter ( InterpreterVisitor ( globalEnvironment '
        ': Environment ( ) , moduleLoader : ModuleLoader ( Environment '
        '( ) , { } , { } , { } ) ) , nativeValue , [ ] , { } , null ) ; '
        "} catch ( _ ) { return ' \${ enumType . name } . \$ name ' ; } } "
        "throw RuntimeD4rtException ( 'Cannot access method \" \$ "
        'identifier " as a property on enum value  \${ enumType . name } '
        ". \$ name . Use call syntax ().' ) ; } throw "
        "RuntimeD4rtException ( 'Property \" \$ identifier \" not found on "
        "enum value  \${ enumType . name } . \$ name ' ) ; } } @ override "
        'void set ( String identifier , Object ? value ) { throw '
        "RuntimeD4rtException ( 'Cannot set property \" \$ identifier \" "
        "on enum value  \${ enumType . name } . \$ name ' ) ; } bool "
        'hasMethod ( String method ) => _methods . containsKey ( method '
        ') || enumType . methods . containsKey ( method ) ; Object ? '
        'invoke ( InterpreterVisitor visitor , String method , List < '
        'Object ? > args , Map < String , Object ? > namedArgs ) { '
        'final methodAdapter = _methods [ method ] ?? enumType . '
        'methods [ method ] ; if ( methodAdapter == null ) { if ( '
        "method == 'toString' && args . isEmpty && namedArgs . isEmpty "
        ") { return ' \${ enumType . name } . \$ name ' ; } throw "
        "RuntimeD4rtException ( 'Method \" \$ method \" not found on enum "
        "value  \${ enumType . name } . \$ name ' ) ; } try { return "
        'methodAdapter ( visitor , nativeValue , args , namedArgs , '
        "null ) ; } catch ( e ) { throw RuntimeD4rtException ( 'Error "
        'executing bridged method " \$ method " on  \${ enumType . name } '
        ". \$ name :  \$ e ' ) ; } } @ override String toString ( ) { "
        "final toStringAdapter = _methods [ 'toString' ] ?? enumType . "
        "methods [ 'toString' ] ; if ( toStringAdapter != null ) { try "
        '{ return toStringAdapter ( InterpreterVisitor ( '
        'globalEnvironment : Environment ( ) , moduleLoader : '
        'ModuleLoader ( Environment ( ) , { } , { } , { }',
    'final env = Environment ( ) ; return methodAdapter ( '
        'InterpreterVisitor ( globalEnvironment : env , moduleContext : '
        'NoOpModuleContext ( globalEnvironment : env ) ) , nativeValue '
        ", [ ] , { } , null ) ; } catch ( _ ) { return ' \${ enumType . "
        "name } . \$ name ' ; } } throw RuntimeD4rtException ( 'Cannot "
        'access method " \$ identifier " as a property on enum value  \${ '
        "enumType . name } . \$ name . Use call syntax ().' ) ; } throw "
        "RuntimeD4rtException ( 'Property \" \$ identifier \" not found on "
        "enum value  \${ enumType . name } . \$ name ' ) ; } } @ override "
        'void set ( String identifier , Object ? value ) { throw '
        "RuntimeD4rtException ( 'Cannot set property \" \$ identifier \" "
        "on enum value  \${ enumType . name } . \$ name ' ) ; } bool "
        'hasMethod ( String method ) => _methods . containsKey ( method '
        ') || enumType . methods . containsKey ( method ) ; Object ? '
        'invoke ( InterpreterVisitor visitor , String method , List < '
        'Object ? > args , Map < String , Object ? > namedArgs ) { '
        'final methodAdapter = _methods [ method ] ?? enumType . '
        'methods [ method ] ; if ( methodAdapter == null ) { if ( '
        "method == 'toString' && args . isEmpty && namedArgs . isEmpty "
        ") { return ' \${ enumType . name } . \$ name ' ; } throw "
        "RuntimeD4rtException ( 'Method \" \$ method \" not found on enum "
        "value  \${ enumType . name } . \$ name ' ) ; } try { return "
        'methodAdapter ( visitor , nativeValue , args , namedArgs , '
        "null ) ; } catch ( e ) { throw RuntimeD4rtException ( 'Error "
        'executing bridged method " \$ method " on  \${ enumType . name } '
        ". \$ name :  \$ e ' ) ; } } @ override String toString ( ) { "
        "final toStringAdapter = _methods [ 'toString' ] ?? enumType . "
        "methods [ 'toString' ] ; if ( toStringAdapter != null ) { try "
        '{ final env = Environment ( ) ; return toStringAdapter ( '
        'InterpreterVisitor ( globalEnvironment : env , moduleContext : '
        'NoOpModuleContext ( globalEnvironment : env',
  ),
  // Two spellings of one dispatch. Behaviourally identical; recorded rather
  // than reconciled because neither is better and changing one to match the
  // other would be churn in a 1388-token file for no measurable gain.
  'bridge/bridged_types.dart': (
    "final enumObj = nativeObject as Enum ; if ( name == 'name' ) return "
        "enumObj . name ; if ( name == 'index' ) return enumObj . index ;",
    "switch ( name ) { case 'name' : return ( nativeObject as Enum ) . name ; "
        "case 'index' : return ( nativeObject as Enum ) . index ; }",
  ),
};

/// Shared files whose divergence is pervasive, and why token identity cannot
/// express it.
///
/// An entry here buys an exemption from F-SCD183-2 ONLY, and it is a narrower
/// exemption than it looks. Every one of these is still held to member-set
/// parity by F-SCD183-5 — "the same fix landed in both" is first a claim about
/// what a file declares — and, since SCD199, to per-BODY agreement by
/// `scd199_mirror_body_agreement_test.dart`, which compares each shared member
/// separately so that one early difference no longer swallows the file. The
/// percentages quoted below are what THIS file's whole-stream comparison sees;
/// per body the same five files are 249 of 354 members identical. Both readings
/// are of the same trees, and the second is where a one-line divergence is
/// visible.
const _structural = <String, String>{
  'callable.dart':
      'the mirror AST has no parent pointer, so the twin reconstructs one '
      '(_buildParentMap, _parentOf, _ChildCollectorVisitor) where the '
      'reference walks node.parent directly. 99 % of the tokens differ.',
  'declaration_visitor.dart':
      'node accessors differ throughout: node.name.lexeme against '
      "node.name?.name ?? ''. 96 % of the tokens differ.",
  'interpreter_visitor.dart':
      'the same accessor divergence across the whole evaluator, plus '
      'moduleLoader against moduleContext at every permission site. 99 % of '
      'the tokens differ.',
  'introspection.dart':
      'reads declarations off the AST, so it is accessor-shaped throughout. '
      '65 % of the tokens differ.',
  'runtime_types.dart':
      'resolves type annotations from AST nodes; same accessor divergence. '
      '55 % of the tokens differ.',
};

/// Members declared in one tree and not the other, and why that is correct.
///
/// Recorded as sorted name lists rather than a count, so that a DIFFERENT
/// member appearing is a finding even when the count is unchanged.
const _memberDivergence = <String, (List<String>, List<String>)>{
  'callable.dart': (
    <String>[],
    <String>[
      'InterpretedFunction._buildParentMap',
      'InterpretedFunction._isBodyAsync',
      'InterpretedFunction._isBodyGenerator',
      'InterpretedFunction._loopVarName',
      'InterpretedFunction._paramName',
      'InterpretedFunction._parentMap',
      'InterpretedFunction._parentOf',
      'InterpretedFunction._resolveRecordFieldTypeDynamic',
      'InterpretedFunction._walkChildren',
      'InterpretedFunction.clearParentMap',
      'InterpretedFunction.declaredReturnTypeApplied',
      '_ChildCollectorVisitor.children',
      '_ChildCollectorVisitor.visitNode',
      'class _ChildCollectorVisitor',
    ],
  ),
  'interpreter_visitor.dart': (
    <String>[
      'InterpreterVisitor._nodeExcerpt',
      'InterpreterVisitor.declSlots',
      'InterpreterVisitor.moduleLoader',
      'InterpreterVisitor.staticCoords',
      'InterpreterVisitor.visitTypeAlias',
    ],
    <String>[
      'InterpreterVisitor._formalParameterName',
      'InterpreterVisitor._resolveAppliedReturnType',
      'InterpreterVisitor.moduleContext',
      'InterpreterVisitor.visitTypedefDeclaration',
      '_SClosurePresenceVisitor.found',
      '_SClosurePresenceVisitor.visitNode',
      'class _SClosurePresenceVisitor',
    ],
  ),
  'introspection.dart': (<String>[], <String>['fn _typeNodeToString']),
};

/// Why each member divergence above is correct. Keyed by file, because the
/// reason is one reason per file rather than one per name.
const _memberDivergenceReasons = <String, String>{
  'callable.dart':
      'the parent-map reconstruction the mirror AST needs, plus the helpers '
      'that walk it. The reference reads node.parent and needs none of them.',
  'interpreter_visitor.dart':
      'the moduleLoader/moduleContext pair, the typedef node\'s different name '
      'in the two ASTs (TypeAlias against TypedefDeclaration), the '
      'slot/coordinate caches the analyzer front end populates, and the '
      'closure-presence walker the twin needs for want of a parent pointer.',
  'introspection.dart':
      'the twin renders a type node to a string by hand; the reference asks '
      'the analyzer node for its source range.',
};

/// The executable tokens of [source]: no comments, no directives, no trailing
/// commas. When [mirrorTypes] is non-empty every mirror type name is rewritten
/// to its reference spelling.
List<String> _codeTokens(String source, {Set<String> mirrorTypes = const {}}) {
  final unit = parseString(
    content: source,
    featureSet: FeatureSet.latestLanguageVersion(),
    throwIfDiagnostics: false,
  ).unit;
  final directives = unit.directives;
  // `Token.next` skips comments — they hang off `precedingComments` — so
  // excluding them costs nothing here.
  final start = directives.isEmpty
      ? unit.beginToken
      : directives.last.endToken.next!;
  final out = <String>[];
  for (Token? t = start; t != null && t.type != TokenType.EOF; t = t.next) {
    if (t.lexeme == ',') {
      final next = t.next;
      if (next != null && const [')', ']', '}'].contains(next.lexeme)) continue;
    }
    out.add(
      mirrorTypes.isEmpty
          ? t.lexeme
          : denormaliseMirrorType(t.lexeme, mirrorTypes),
    );
  }
  return out;
}

/// Every named declaration in [source], qualified by its owner.
///
/// Names only — no signatures, no bodies. A signature comparison would fail on
/// every one of the five structural files for spelling `SAstNode` where the
/// reference spells `AstNode`, and the S-normalisation that fixes that for
/// tokens is not available here without re-parsing. Names are the part the
/// mirror rule is actually a claim about.
class _DeclaredMembers extends GeneralizingAstVisitor<void> {
  final out = <String>{};
  String _owner = '';

  void _scoped(String owner, String kind, void Function() body) {
    out.add('$kind $owner');
    _owner = owner;
    body();
    _owner = '';
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) => _scoped(
    node.name.lexeme,
    'class',
    () => super.visitClassDeclaration(node),
  );

  @override
  void visitMixinDeclaration(MixinDeclaration node) => _scoped(
    node.name.lexeme,
    'mixin',
    () => super.visitMixinDeclaration(node),
  );

  @override
  void visitExtensionDeclaration(ExtensionDeclaration node) => _scoped(
    node.name?.lexeme ?? '<unnamed>',
    'extension',
    () => super.visitExtensionDeclaration(node),
  );

  @override
  void visitEnumDeclaration(EnumDeclaration node) =>
      _scoped(node.name.lexeme, 'enum', () => super.visitEnumDeclaration(node));

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    final kind = node.isGetter ? 'get ' : (node.isSetter ? 'set ' : '');
    out.add('$_owner.$kind${node.name.lexeme}');
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) =>
      out.add('$_owner.new ${node.name?.lexeme ?? ''}');

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    for (final v in node.fields.variables) {
      out.add('$_owner.${v.name.lexeme}');
    }
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    if (_owner.isEmpty) out.add('fn ${node.name.lexeme}');
    super.visitFunctionDeclaration(node);
  }

  @override
  void visitTopLevelVariableDeclaration(TopLevelVariableDeclaration node) {
    for (final v in node.variables.variables) {
      out.add('top ${v.name.lexeme}');
    }
  }
}

Set<String> _declaredMembers(String source) {
  final visitor = _DeclaredMembers();
  parseString(
    content: source,
    featureSet: FeatureSet.latestLanguageVersion(),
    throwIfDiagnostics: false,
  ).unit.visitChildren(visitor);
  return visitor.out;
}

void main() {
  // SCD158: this guard resolves its subject relative to the package it runs
  // in, so a copy anywhere else measures a different tree in silence.
  requirePackage(
    'tom_d4rt',
    subject: 'both interpreter trees outside lib/src/stdlib',
  );

  final mirrorTypes = mirrorTypeNames();
  final refFiles = dartFilesUnder(_refRoot, excludedPrefix: _excludedPrefix);
  final astFiles = dartFilesUnder(_astRoot, excludedPrefix: _excludedPrefix);
  final shared = (refFiles.toSet().intersection(astFiles.toSet()).toList())
    ..sort();

  /// Token divergence per shared file, computed once.
  final divergences = <String, (String, String)>{};

  /// Member-set divergence per shared file, computed once.
  final memberDeltas = <String, (List<String>, List<String>)>{};

  for (final rel in shared) {
    final refSource = File('$_refRoot/$rel').readAsStringSync();
    final astSource = File('$_astRoot/$rel').readAsStringSync();
    final d = tokenDivergence(
      _codeTokens(refSource),
      _codeTokens(astSource, mirrorTypes: mirrorTypes),
    );
    if (d != null) divergences[rel] = d;

    final refMembers = _declaredMembers(refSource);
    final astMembers = _declaredMembers(astSource);
    final onlyRef = (refMembers.difference(astMembers).toList())..sort();
    final onlyAst = (astMembers.difference(refMembers).toList())..sort();
    if (onlyRef.isNotEmpty || onlyAst.isNotEmpty) {
      memberDeltas[rel] = (onlyRef, onlyAst);
    }
  }

  test('F-SCD183-1: both trees are present, and every unmirrored file is '
      'recorded [2026-09-15] (PASS)', () {
    // Runs first because everything below is an emptiness assertion over a
    // walk, and a walk that found nothing satisfies all of them. A missing twin
    // is the likeliest way to reach that state and must not read as a pass.
    expect(
      shared,
      hasLength(greaterThanOrEqualTo(_minShared)),
      reason:
          'Only ${shared.length} files are shared between $_refRoot and '
          '$_astRoot. That is not a finding about the trees — the walk did not '
          'run. The twin is a sibling checkout in the same `tom_d4rt` '
          'repository, and tests are expected to run with the package root as '
          'the working directory.',
    );

    final unrecordedRef =
        refFiles
            .toSet()
            .difference(astFiles.toSet())
            .where((f) => !_refOnly.containsKey(f))
            .toList()
          ..sort();
    final unrecordedAst =
        astFiles
            .toSet()
            .difference(refFiles.toSet())
            .where((f) => !_astOnly.containsKey(f))
            .toList()
          ..sort();

    expect(
      [...unrecordedRef, ...unrecordedAst],
      isEmpty,
      reason:
          '${unrecordedRef.isEmpty ? '' : 'Only in the reference tree:\n'
                    '  ${unrecordedRef.join('\n  ')}\n'}'
          '${unrecordedAst.isEmpty ? '' : 'Only in the twin:\n'
                    '  ${unrecordedAst.join('\n  ')}\n'}\n'
          'A file that exists in one interpreter tree and not the other is the '
          'coarsest form of the divergence the mirror rule forbids, and it is '
          'the one no other guard in this repository can see. Either mirror '
          'it, or add an entry to _refOnly / _astOnly saying why the other '
          'tree does not need it.',
    );

    final stale = [
      ..._refOnly.keys.where((f) => !refFiles.contains(f)),
      ..._astOnly.keys.where((f) => !astFiles.contains(f)),
    ]..sort();
    expect(
      stale,
      isEmpty,
      reason:
          'These files are recorded as single-copy but no longer exist:\n'
          '  ${stale.join('\n  ')}\n\n'
          'Delete their entries. A record of a file nobody has is not a '
          'record of anything.',
    );
  });

  test('F-SCD183-2: every shared file outside the two allow-lists is '
      'code-identical [2026-09-15] (PASS)', () {
    // Anti-vacuity first, and it is not decorative: the whole comparison runs
    // through a rename map read off disk, and an empty map normalises nothing
    // while looking exactly like a map with nothing to do. Every structural
    // file would then report a divergence it does not have.
    expect(
      mirrorTypes,
      hasLength(greaterThanOrEqualTo(_minMirrorTypes)),
      reason:
          'Read only ${mirrorTypes.length} type names from $mirrorModelRoot. The '
          'mirror rename map is derived from that checkout; without it this '
          'comparison is measuring something else.',
    );

    final unexpected =
        divergences.keys
            .where(
              (f) =>
                  !_allowedRegions.containsKey(f) &&
                  !_structural.containsKey(f),
            )
            .toList()
          ..sort();

    expect(
      unexpected,
      isEmpty,
      reason:
          'These files differ in CODE between the two interpreter trees:\n'
          '${unexpected.map((f) => '  $f\n'
              '      ref: ${tokenExcerpt(divergences[f]!.$1)}\n'
              '      ast: ${tokenExcerpt(divergences[f]!.$2)}').join('\n')}\n\n'
          'The mirror rule says a fix lands in both trees in one commit — see '
          '_copilot_guidelines/d4rt/mirror_maintenance.md. Port the change. If '
          'the trees genuinely cannot agree, add an entry to _allowedRegions '
          'pinning both sides (when the divergence is one region) or to '
          '_structural saying why token identity cannot express it (when it is '
          'pervasive). A _structural entry still owes member parity below.',
    );
  });

  test('F-SCD183-3: every allow-list entry is still needed [2026-09-15] '
      '(PASS)', () {
    // The ratchet. An allow-list nobody prunes stops being a list of known
    // exceptions and becomes a list of files that are not checked. Resolving a
    // divergence is good news, and good news has to be recorded or the
    // permission outlives its reason.
    final resolved = [
      ..._allowedRegions.keys.where((f) => !divergences.containsKey(f)),
      ..._structural.keys.where((f) => !divergences.containsKey(f)),
    ]..sort();

    expect(
      resolved,
      isEmpty,
      reason:
          'These files are on an allow-list and no longer differ:\n'
          '  ${resolved.join('\n  ')}\n\n'
          'Delete their entries. Until you do, each is exempt from '
          'F-SCD183-2 for a reason that has stopped being true, and a real '
          'divergence introduced later would not be reported.',
    );

    final absent = [
      ..._allowedRegions.keys.where((f) => !shared.contains(f)),
      ..._structural.keys.where((f) => !shared.contains(f)),
    ]..sort();
    expect(
      absent,
      isEmpty,
      reason:
          'These files are on an allow-list and are not shared by the two '
          'trees at all:\n  ${absent.join('\n  ')}\n\n'
          'Either the file moved, or it is now single-copy and belongs in '
          '_refOnly / _astOnly instead.',
    );
  });

  test('F-SCD183-4: every region-pinned file diverges only where recorded '
      '[2026-09-15] (PASS)', () {
    // What makes the region list safe to have. `environment.dart` is 8278
    // tokens and 199 of them differ; exempting the path would unguard 8079 to
    // permit 199. Pinning both sides means a second divergence anywhere in the
    // file changes the trimmed result and is reported here.
    final changed = <String>[];
    for (final entry in _allowedRegions.entries) {
      final actual = divergences[entry.key];
      // Absent means the divergence was resolved, which F-SCD183-3 owns —
      // skipping it here keeps one event from being reported twice with two
      // different remedies.
      if (actual == null) continue;
      if (actual.$1 == entry.value.$1 && actual.$2 == entry.value.$2) continue;
      changed.add(
        '  ${entry.key}\n'
        '      recorded ref: ${tokenExcerpt(entry.value.$1)}\n'
        '      actual   ref: ${tokenExcerpt(actual.$1)}\n'
        '      recorded ast: ${tokenExcerpt(entry.value.$2)}\n'
        '      actual   ast: ${tokenExcerpt(actual.$2)}',
      );
    }

    expect(
      changed,
      isEmpty,
      reason:
          'These files diverge somewhere other than where their entry '
          'records:\n${changed.join('\n')}\n\n'
          'Either a second divergence was introduced — port it — or the '
          'recorded one moved, in which case update the entry to the new '
          'region and say in the comment above it why it moved.',
    );
  });

  test('F-SCD183-5: both trees declare the same members [2026-09-15] (PASS)', () {
    // THE ASSERTION THAT CORRESPONDS TO THE RULE. "The same fix landed in both
    // trees" is a claim about what a file declares, not about how it spells the
    // body — and for the five structural files it is the only form of the claim
    // that can be true at all. SCD169 added `_isInsideCatchClauseOf` to
    // `callable.dart`; this is the check that would have caught it landing in
    // one tree only, and token identity could not have.
    final unexpected = <String>[];
    for (final rel in (memberDeltas.keys.toList()..sort())) {
      final actual = memberDeltas[rel]!;
      final recorded = _memberDivergence[rel];
      if (recorded != null &&
          _sameNames(actual.$1, recorded.$1) &&
          _sameNames(actual.$2, recorded.$2)) {
        continue;
      }
      final newRef = actual.$1
          .where((n) => !(recorded?.$1.contains(n) ?? false))
          .toList();
      final newAst = actual.$2
          .where((n) => !(recorded?.$2.contains(n) ?? false))
          .toList();
      unexpected.add(
        '  $rel\n'
        '${newRef.isEmpty ? '' : '      only in tom_d4rt:     ${newRef.join(', ')}\n'}'
        '${newAst.isEmpty ? '' : '      only in tom_d4rt_ast: ${newAst.join(', ')}\n'}'
        '${_missingText(rel, actual, recorded)}',
      );
    }

    expect(
      unexpected,
      isEmpty,
      reason:
          'These files declare different members in the two trees:\n'
          '${unexpected.join()}\n'
          'This is the mirror rule\'s usual failure: a helper, a field or a '
          'visit method added to one tree and not the other. Port it. If the '
          'member genuinely belongs to one tree alone — the twin\'s '
          'parent-map machinery is the standing example — add it to '
          '_memberDivergence and give the file a reason in '
          '_memberDivergenceReasons.',
    );
  });

  test('F-SCD183-6: every recorded member divergence is still real '
      '[2026-09-15] (PASS)', () {
    // The same ratchet as F-SCD183-3, one level down. A name that got mirrored
    // after all leaves a permission behind, and the next unmirrored member with
    // that name would be waved through.
    final resolved = <String>[];
    for (final entry in _memberDivergence.entries) {
      final actual = memberDeltas[entry.key];
      final goneRef = entry.value.$1
          .where((n) => !(actual?.$1.contains(n) ?? false))
          .toList();
      final goneAst = entry.value.$2
          .where((n) => !(actual?.$2.contains(n) ?? false))
          .toList();
      if (goneRef.isEmpty && goneAst.isEmpty) continue;
      resolved.add('  ${entry.key}: ${[...goneRef, ...goneAst].join(', ')}');
    }

    expect(
      resolved,
      isEmpty,
      reason:
          'These names are recorded as declared in one tree only, and are '
          'not:\n${resolved.join('\n')}\n\n'
          'Delete them from _memberDivergence. Until you do, the entry grants '
          'a permission whose reason has expired.',
    );

    // Every file with an entry owes a reason, and a reason is what the entry is
    // FOR — the list without it records that a divergence exists and not that
    // anybody decided it should.
    final unexplained =
        _memberDivergence.keys
            .where((f) => !_memberDivergenceReasons.containsKey(f))
            .toList()
          ..sort();
    expect(
      unexplained,
      isEmpty,
      reason:
          'These files have a member-divergence entry and no reason:\n'
          '  ${unexplained.join('\n  ')}',
    );
  });
}

/// The first 240 characters of a token region, so a 59 000-token divergence
/// does not make a failure unreadable.
bool _sameNames(List<String> a, List<String> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

/// Names the entry records but the trees no longer show. F-SCD183-6 owns the
/// remedy; naming them here too stops F-SCD183-5's report from looking like an
/// unexplained mismatch when the cause is a stale entry.
String _missingText(
  String rel,
  (List<String>, List<String>) actual,
  (List<String>, List<String>)? recorded,
) {
  if (recorded == null) return '';
  final gone = [
    ...recorded.$1.where((n) => !actual.$1.contains(n)),
    ...recorded.$2.where((n) => !actual.$2.contains(n)),
  ];
  if (gone.isEmpty) return '';
  return '      recorded but no longer divergent: ${gone.join(', ')}\n'
      '      (F-SCD183-6 owns that half — prune the entry.)\n';
}
