// REPO-WIDE GUARD (tom_d4rt) — the two interpreter trees agree member by member, and every place they do not is named and pinned.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt's
// suite runs and a session working elsewhere in the repo reaches none of it.
// SCD129 made that arrangement visible rather than incidental: `grep -rn
// 'REPO-WIDE GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// SCD199 — the mirror rule at the granularity a mirror defect actually has.
//
// WHAT WENT WRONG. `visitPropertyAccess` returned `target.runtimeType` for a
// bridged instance in `tom_d4rt` — the WRAPPER's type, so every bridged value
// reported `BridgedInstance<Object>`. The twin has returned
// `nativeObject.runtimeType` since GEN-075. One line, opposite answers, for as
// long as both files existed. SCC78 found it by fixing one tree and noticing
// the other had never had the defect. Both suites were green throughout.
//
// WHY NOTHING SAW IT, and it is not carelessness. The workspace rule is that an
// interpreter fix must be MIRRORED INTO BOTH TREES. It has no counterpart
// saying the two must AGREE, and a divergence that arose from a fix landing in
// one tree only is indistinguishable, from inside either tree, from correct
// code. SCD183 added the file-level half of that missing counterpart; this is
// the half it explicitly cannot reach.
//
// WHY SCD183 CANNOT REACH IT. SCD183 compares each shared file's whole token
// stream and trims the common prefix and suffix to quote the divergence. That
// is the right shape for the 26 files where the two copies are identical — and
// it degenerates on the five where they are not, because ONE early difference
// leaves every token after it inside the residue. `interpreter_visitor.dart`
// reads as "99 % of tokens differ" and is exempted wholesale as `_structural`.
// Wholesale is the operative word: inside that exemption a one-line
// disagreement is invisible, which is precisely the condition SCC78's defect
// needed to survive.
//
// WHAT THIS FILE MEASURES INSTEAD. The same comparison applied per MEMBER BODY.
// A method is the unit a mirror defect actually has, and localising the trim to
// one body stops a single early difference from swallowing the file. The result
// is a different picture of the same trees, and it is the finding:
//
//     726 shared member bodies across the 31 shared files
//     619 byte-identical after normalisation            (85 %)
//     107 divergent, in 6 files                         (15 %)
//
// 25 of the 31 files are 100 % body-identical, including `generator/d4.dart`
// (96 bodies) and `environment.dart` (92). Even the worst file,
// `interpreter_visitor.dart`, is 77 of 134 bodies identical rather than the
// 1 % its file-level reading suggests.
//
// SO THE EXEMPTION SHRINKS FROM 5 FILES TO 107 METHODS, and the 619 bodies that
// do agree are now held to agreeing.
//
// SCD208 TOOK THE FIRST ONE OFF THE LIST, which is what F-SCD199-3 is for.
// `BridgedInstance.get` spelled one enum-property lookup as an if-chain in the
// reference and a switch in the twin — recorded here, and in SCD183's region
// list, as behaviour-identical-but-different. It was mirrored, both records
// went stale within a second of the change, and both guards said so. The
// census above is the state after that. `environment.dart` reached its 92 the
// same way earlier: its `removeLocalValue` was DECLARED IN A DIFFERENT
// POSITION, which per-body comparison correctly reports as no divergence at
// all — SCD208 then moved the declaration so the whole-file readings agree
// too.
//
// WHAT NORMALISATION IS APPLIED, and each is a difference the twin is REQUIRED
// to have rather than one it happens to have:
//
//   1. `SFoo` -> `Foo` for every type `tom_ast_model` declares. The quest's own
//      architecture states the model is a 1:1 mirror and that the interpreter
//      should port "by changing import statements"; this is that claim made
//      executable. Shared with SCD183 — see `mirror_normalisation.dart`.
//   2. A postfix `!` is dropped. The mirror model's fields are nullable where
//      the analyzer's are not, so the twin must write `node.name!` for the
//      reference's `node.name`. Detected from the AST (`PostfixExpression` with
//      a `!` operator), never from the token text, so a prefix `!` — negation —
//      is untouched. Worth 23 of the 131 bodies that differ without it.
//   3. `[SThrowExpression]` -> `[ThrowExpression]` inside a string literal. A
//      log prefix names the node type being logged, so the rename reaches into
//      strings where the token map cannot. Worth 7.
//
//   4. `tom_ast_model`'s ACCESSOR VOCABULARY (SCE235), applied to BOTH trees:
//      `notOperator != null` -> `isNot`, `constKeyword != null` -> `isConst`,
//      `.question != null` -> `.isNullable`, `lexeme` -> `name`,
//      `identifier . name` -> `name . name`, and the twin's nullable
//      `?. name ?? ''` -> `. name`. (A row dropping `as NormalFormalParameter`
//      left with analyzer 14, which has no such cast to drop.) SCE235 decided the
//      model keeps its own names (option (b)) and that the nullability
//      difference is permanent, so these spellings are required rather than
//      incidental. The table lives in `mirror_normalisation.dart`
//      (`accessorVocabulary`). Because it is applied to both sides, it can only
//      turn a divergence into agreement, never break an agreeing body.
//      Measured 2026-09-29: 116 divergent -> 98, with the 18 moved into the
//      checked set.
//
//   CENSUS AFTER SCE235 (2026-09-29): 755 shared bodies, 657 identical, 98
//   divergent, in the same six files. The small end of the 98 is now design
//   rather than spelling: the model has no `parent` pointers (`_parentOf`), a
//   reconstructed parent map, a stored `SymbolLiteral` value, the module
//   context type, and two residues too narrow for a safe rule (an import
//   prefix `bridge.` and the model's flattened `onClause`).
//
// THE RISK EACH CARRIES, stated rather than hidden. (1) would mask a divergence
// where the twin names a mirror type and the reference names an unrelated
// analyzer type of the same base name — that is the 1:1 claim being false, a
// larger problem, and `tom_ast_model`'s own suite is where it belongs. (2)
// would mask a reference `x!` against a twin `x`: a crash-versus-crash
// difference, not a wrong-answer one. (3) is bounded to a whole bracketed token
// whose S-form is a declared type, so `[Setup]` survives.
//
// WHAT WAS DELIBERATELY NOT NORMALISED, having been measured: a bare `?.` ->
// `.` is worth 0 bodies, and `moduleLoader` -> `moduleContext` is worth 0.
// `.lexeme` -> `.name` measured 3 on its own; SCE235 took it as part of the
// vocabulary table above, where together with the rows beside it it is worth
// 18.
//
// THE RECORDED BODIES ARE PINNED BY THEIR DIVERGENCE, not merely listed. Each entry holds a
// hash of the trimmed residue — what the two sides say where they stop
// agreeing. That is what makes this a detector for SCC78's shape rather than
// only for new ones:
//
//   - a change to ONE tree inside a listed method alters the residue and fires
//     F-SCD199-4, which is exactly the event nothing could see before;
//   - a change MIRRORED INTO BOTH alters the common prefix and suffix but not
//     the residue, and stays silent. That asymmetry is the whole design.
//
// WHAT IT STILL CANNOT SEE, so that a green run is not read as more than it
// is: a divergence that was present when the list was written is recorded, not
// resolved. SCC78's own line is among the recorded ones. This guard freezes the
// disagreement at a known shape and reports every movement in it; it does not
// adjudicate which of the two sides is right. Shrinking the list is
// ordinary work, and F-SCD199-3 is what makes that work visible.
//
// RELATIONSHIP TO SCD183, and why neither duplicates the other. SCD183 asks
// whether a FILE's tokens agree and whether the two trees DECLARE the same
// members; this asks whether a shared member's BODY agrees. A body divergence
// implies a token divergence, so every file named below is already one SCD183
// exempts — no assertion here re-checks that, it is arithmetic. A member that
// exists in one tree only never reaches this comparison and is F-SCD183-5's.
//
// EACH TEST HERE HAS BEEN SEEN TO FAIL:
//
//   | Injected fault                                             | Fires   |
//   | ---------------------------------------------------------- | ------- |
//   | twin root pointed at a path that does not exist             | 1, 3    |
//   | `tom_ast_model` root pointed at a path that does not exist  | 1, 2, 4 |
//   | an identical body changed in the reference tree only        | 2       |
//   | SCC78's own line reverted in the twin                       | 4       |
//   | a recorded divergence the two trees now agree on            | 3       |
//   | a recorded member renamed                                   | 2, 3    |
//
// F-SCD199-1 is ordered first and nothing else here means anything until it
// passes: every other assertion is an emptiness check over a walk, and a walk
// that found no bodies satisfies all of them.
//
// THE FIRST TWO ROWS FIRE MORE THAN ONE, and it is worth knowing before reading
// a triple red as three problems. With no twin files there are no divergences,
// so every recorded entry looks resolved (3); with no rename map every body in
// the twin reads as divergent (2), and every recorded one as divergent
// differently (4). F-SCD199-1 is the one to believe.
//
// THE FOURTH ROW IS THE POINT OF THE FILE. Reverting SCC78's line in the twin —
// recreating, in the other tree, the exact defect that motivated all this —
// fires F-SCD199-4 and nothing else. That is the event that was invisible: a
// one-line change to one tree, inside a member both trees were already known
// not to match, with both suites staying green.

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

/// The twin's. A sibling checkout — both packages live in the one `tom_d4rt`
/// repository.
const _astRoot = '../tom_d4rt_ast/lib/src/runtime';

/// `stdlib/` is SCD49's subject. It compares its half for plain token identity,
/// which it can demand because a stdlib bridge is the same code in both trees.
const _excludedPrefix = 'stdlib/';

/// 726 bodies were shared on 2026-09-15. The floor is well below that because
/// its job is to separate "compared the corpus" from "compared nothing" — not
/// to track the number, which moves with every method anybody writes.
const _minSharedBodies = 600;

/// `tom_ast_model` declared 192 types on 2026-09-15. Same reasoning, and the
/// same failure mode it guards: a rename map read from a missing directory is
/// empty, and an empty map normalises nothing while looking exactly like a map
/// that had nothing to do. Every structural file would then report a divergence
/// it does not have.
const _minMirrorTypes = 150;

/// Member bodies that differ between the trees, with a hash of WHERE they
/// differ.
///
/// Keyed by file, then by `Owner.member` — `get `/`set `/`new ` prefixes
/// distinguish a getter, a setter and a constructor from a method of the same
/// name. The value is the FNV-1a hash of the trimmed residue: the two sides'
/// tokens with the common prefix and suffix removed.
///
/// A HASH RATHER THAN THE TEXT, and the trade is deliberate. The residues run
/// to several hundred tokens each — `_checkAppliedGenericReturn` alone is over
/// 400 — so recording them literally would be tens of thousands of tokens of
/// quoted source that nobody reads and `dart format` reflows. The hash makes
/// the pin exact and cheap; the failure message prints the live residue, so the
/// reader still sees the divergence itself at the moment it matters.
///
/// NO PER-ENTRY REASON, also deliberate. ~100 individually-worded reasons would
/// be ~100 restatements of five facts, and the five facts are recorded once
/// where they belong — SCD183's `_structural` and `_allowedRegions` say why
/// each of these six files cannot be compared whole. This map is a census of
/// WHAT diverges, so that a change in it is visible.
const _divergentBodies = <String, Map<String, String>>{
  // SCD208: both were '1954…'-era signatures naming the reference's two
  // separate `Environment()` objects. It now binds one local like the twin, so
  // the residue is the type difference alone — and identical in both members,
  // which is why the two hashes are now the same.
  'bridge/bridged_enum.dart': {
    'BridgedEnumValue.get': '184efa79',
    'BridgedEnumValue.toString': '184efa79',
  },
  'callable.dart': {
    // GHISSUES32: `type.name.lexeme` against the mirror model's nullable
    // `type.name?.name`; the same test otherwise.
    'ResolvedBinding.declaresDouble': 'b1de00ae',
    'InterpretedFunction._beginAwaitForIteration': 'f361cfa9',
    'InterpretedFunction._isWithin': 'a8bc018c',
    'InterpretedFunction._callImpl': 'c0f390c5',
    'InterpretedFunction._containsAwait': 'ee448f09',
    'InterpretedFunction._determineNextNodeAfterAwait': '3dd47cca',
    'InterpretedFunction._findEnclosingTryStatement': '64523cb5',
    'InterpretedFunction._findInvocationWithAwaitInArguments': '5fedfaed',
    'InterpretedFunction._findNextSequentialNode': 'f20b7114',
    'InterpretedFunction._enclosingExpressionFunctionBody': '34fd9762',
    // GHISSUES12: both trees choose and bind the catch clause for the native
    // error a RuntimeD4rtException carries; the recorded residue is unchanged
    // in kind, its signature moved with the shared edit.
    'InterpretedFunction._handleAsyncError': 'a9719a4d',
    'InterpretedFunction._instantiateRedirectedFactory': '92a6e173',
    'InterpretedFunction._isInsideCatchClauseOf': '3782eeaf',
    // SCE78: the finally-block companion to the catch-clause predicate
    // above, and divergent for the same architectural reason — the mirror
    // AST has no `parent` getter, so the twin walks with `_parentOf`.
    'InterpretedFunction._isInsideFinallyBlockOf': '34fd9762',
    // SCE79: the catch-clause environment lookup, divergent for the same
    // architectural reason as the two predicates around it — the mirror
    // AST has no `parent` getter, so the twin walks with `_parentOf`.
    'InterpretedFunction._catchEnvironmentFor': '34fd9762',
    // SCE81: the cascade walker, divergent for the same architectural
    // reason as its neighbours — the mirror AST has no `parent` getter, so
    // the twin walks with `_parentOf`.
    'InterpretedFunction._enclosingCascadeOf': '34fd9762',
    // VSTDM3: the analyzer 14 port edited both trees alike; the divergence
    // itself is unchanged.
    'InterpretedFunction._jumpTarget': '0f43f668',
    'InterpretedFunction._leaveLoopsFor': 'e47bcb14',
    'InterpretedFunction._nextEnclosingFinallyTry': 'fe832583',
    'InterpretedFunction._nextFinallyTryBefore': '5b8b6fab',
    // VSTDM3: the analyzer 14 port edited both trees alike; the divergence
    // itself is unchanged.
    'InterpretedFunction._prepareExecutionEnvironment': '368f64b6',
    // VSTDM3: the analyzer 14 port edited both trees alike; the divergence
    // itself is unchanged.
    // GHISSUES7: both trees look a prefixed type up through its prefix; the
    // residue grows by the prefix's accessor, `importPrefix?.name.lexeme`
    // here (a token) and `importPrefix?.name` in the twin (an identifier).
    // GHISSUES23: both trees give a record field its `?`; the reference does
    // it inline with `question != null`, the twin in its
    // `_resolveRecordFieldTypeDynamic` helper with `isNullable`.
    'InterpretedFunction._resolveTypeAnnotationDynamic': 'e04ab501',
    // SCE139 / SCF29: the walker that finds the unit an await resumption
    // hands back to the state machine (a statement, an `=>` body's
    // expression, or an if / while / do reached from its condition),
    // divergent for the same architectural reason as its neighbours — the
    // mirror AST has no `parent` getter, so the twin walks with `_parentOf`.
    'InterpretedFunction._resumableNodeFor': 'ca3c88e4',
    // SCE102 moved this signature without changing what diverges. The
    // empty-loop-body fallback landed symmetrically in both trees — the
    // added lines are identical modulo the `S` prefix — and a symmetric
    // edit to an ALREADY-divergent member still moves the pair's hash,
    // because the hash is over both bodies. The divergence itself is
    // unchanged: the mirror AST has no `parent` getter, so the twin walks
    // with `_parentOf`.
    // DASY1: the state machine's body moved to `_runStateMachineSegment`;
    // `_runStateMachine` is now the frame wrapper both trees agree on. The
    // divergence (`parent` against `_parentOf`) moved with the body.
    'InterpretedFunction._runStateMachineSegment': '25b5cd5d',
    'InterpretedFunction._tryOwningCatchClauseOf': 'f1617e03',
    'InterpretedFunction._tryOwningFinallyBlockOf': '34fd9762',
    'InterpretedFunction.bind': '78b56933',
    // VSTDM3: the analyzer 14 port edited both trees alike; the divergence
    // itself is unchanged.
    'InterpretedFunction.get callableRuntimeType': '818a3898',
    'InterpretedFunction.new constructor': 'aab4d189',
    'InterpretedFunction.new declaration': '3060dbb6',
    'InterpretedFunction.new expression': '73245b03',
    'InterpretedFunction.new method': '3847e56b',
    '_LazySyncGeneratorIterator._executeForInWithYieldSuspension': '2f4748e3',
  },
  // VSTDM3: the twin's typedef node is TypedefDeclaration and its declared
  // names are nullable; see SCD183's `_structural` entry.
  'declared_names.dart': {'fn namedMemberName': 'a7165dcd'},
  'declaration_visitor.dart': {
    // SCE130: 81e4977d -> 954e4039. Pass 1 now passes `lenient: true` when
    // extracting the class's type-parameter bounds, in both trees; the
    // residue is the accessor difference this member already had.
    'DeclarationVisitor.visitClassDeclaration': '246afb3b',
    'DeclarationVisitor.visitFunctionDeclaration': '4ebc6925',
    'DeclarationVisitor.visitTopLevelVariableDeclaration': '17090fd4',
  },
  'interpreter_visitor.dart': {
    // WONEPRPD153: the one place the call stack is reached, so the two bodies
    // that use it (executeBlock, InterpretedFunction.call) stay identical.
    // The run's loader is `moduleLoader` here and `moduleContext` in the twin.
    'InterpreterVisitor.get callStack': 'e8f05235',
    'InterpreterVisitor._chainHasNullAwareSelector': 'c135924e',
    'InterpreterVisitor._checkAppliedGenericReturn': '04ded847',
    'InterpreterVisitor._evaluateArguments': '0df79830',
    'InterpreterVisitor._evaluateArgumentsAsync': '0df79830',
    'InterpreterVisitor._executeCascadeAssignment': '6ba592d9',
    'InterpreterVisitor._executeClassicFor': 'cc48545f',
    'InterpreterVisitor._mapCompoundToOperatorName': 'd728ed84',
    // SCE104 extracted both from `visitAsExpression`, whose divergence they
    // inherit: the mirror AST carries an `importPrefix` and an `isNullable`
    // flag where the analyzer's node carries a token and a `question`, and it
    // cannot print itself, so the twin rebuilds the type's spelling by hand.
    // `_castTypeDescription` exists to keep that one difference in one member
    // instead of at both call sites. DFIN5 extended the twin's half for record
    // and function types, which it now spells through their resolved runtime
    // type, as the reference's `toSource()` does.
    'InterpreterVisitor._castTypeDescription': '81b8f29e',
    'InterpreterVisitor._tryCast': 'c54f1a19',
    'InterpreterVisitor._matchAndBind': 'bcdd64fd',
    'InterpreterVisitor._processCollectionElement': '14f71e24',
    // GHISSUES7: the prefix's accessor — the analyzer's import prefix names a
    // token (`importPrefix?.name.lexeme`), the mirror's an identifier
    // (`importPrefix?.name`).
    'InterpreterVisitor._relationshipLookupName': 'f7ad00b8',
    // GHISSUES23: both trees give a record field its `?`, spelled
    // `question != null` here and `isNullable` (on a nullable field type) in
    // the twin.
    'InterpreterVisitor._resolveTypeAnnotationWithEnvironment': 'c98479f1',
    'InterpreterVisitor._statementsIntroduceBindings': '73f8180e',
    'InterpreterVisitor._subtreeContainsClosure': 'b6e41360',
    'InterpreterVisitor._valueHasType': '716e1f67',
    'InterpreterVisitor.computeCompoundValue': 'aab15c4a',
    'InterpreterVisitor.new': '2cc4e641',
    'InterpreterVisitor.registerTypeAlias': '8b81a27c',
    'InterpreterVisitor.resolveStaticCoordinates': '1c58137b',
    'InterpreterVisitor.visitAsExpression': '749f9253',
    // SCE176: 510fd0b5 -> fddd7587. Both trees appended the same
    // unbridged-native clause to the same two assignment errors; the residue
    // is still `PrefixedIdentifier` vs `SPrefixedIdentifier` in one message,
    // which the new text now sits beside. DART313B1: 0d5d1441 -> 8af32809,
    // both trees appended the same declined-member reason to the same
    // setter-miss message.
    'InterpreterVisitor.visitAssignmentExpression': '8af32809',
    'InterpreterVisitor.visitBinaryExpression': 'c2f2a78f',
    // SCE130: 57fc0f99 -> fffabfd5. Both trees gained the same call to
    // `klass.resolveDeferredTypeParameterBounds`; the residue is the
    // accessor difference this member already had.
    // VSTDM3: the analyzer 14 port edited both trees alike; the divergence
    // itself is unchanged.
    // GHISSUES4: both trees gained the same deferred relationship and bound
    // resolution; the new residue is the loader field's name, `moduleLoader`
    // here and `moduleContext` in the twin.
    // GHISSUES7: both trees look every relationship type up through
    // `_relationshipLookupName`, which replaced the per-clause bare-name
    // accessors; the residue left is the loader field's name.
    'InterpreterVisitor.visitClassDeclaration': '297bfae2',
    'InterpreterVisitor.visitConstructorReference': '1d51b6d4',
    // VSTDM3: the analyzer 14 port edited both trees alike; the divergence
    // itself is unchanged.
    // GHISSUES19: both trees resolve the enum's `implements` clause, deferred
    // while modules load; the residue grows by the interface name's accessor
    // (`name.lexeme` / `name!.name`) and the loader field's name.
    'InterpreterVisitor.visitEnumDeclaration': 'b6064b95',
    // GHISSUES11: both trees defer an `on` type declared in a library still
    // loading; the residue grows by the loader field's name, `moduleLoader`
    // here and `moduleContext` in the twin.
    'InterpreterVisitor.visitExtensionDeclaration': '1ea7e106',
    // VSTDM3: the analyzer 14 port edited both trees alike; the divergence
    // itself is unchanged.
    'InterpreterVisitor.visitExtensionTypeDeclaration': '32961e82',
    'InterpreterVisitor.visitForStatement': '1df0d7d7',
    'InterpreterVisitor.visitFunctionDeclaration': 'a398e655',
    'InterpreterVisitor.visitFunctionDeclarationStatement': '1a8fa2ed',
    'InterpreterVisitor.visitIdentifier': '0b2aded7',
    'InterpreterVisitor.visitIfStatement': 'f881cee4',
    // GHISSUES7: both trees bind a prefix to `prefixSurface`; the new residue
    // is the loader field's name, `moduleLoader` here and `moduleContext` in
    // the twin.
    'InterpreterVisitor.visitImportDirective': '72f538a9',
    'InterpreterVisitor.visitInstanceCreationExpression': '942d3194',
    // SCE109 moved this signature without changing what diverges: the
    // arity-heuristic throw sites inside it now raise `RangeError`
    // rather than `RuntimeD4rtException`, symmetrically in both trees.
    'InterpreterVisitor.visitMethodInvocation': 'a1b41959',
    // GHISSUES4: identical in both trees but for the loader field's name,
    // `moduleLoader` here and `moduleContext` in the twin (the twin's
    // interpreter reaches its loader through the ModuleContext interface).
    'InterpreterVisitor.visitMixinDeclaration': 'e8f05235',
    'InterpreterVisitor._deferUnresolvedBounds': 'e8f05235',
    // SCE236: the two `visitNode` bodies are identical now. Only the excerpt
    // helper differs: `toSource()` here, the bundled source in the twin.
    'InterpreterVisitor._nodeExcerpt': 'b5e37909',
    // SCF37: both bodies gained the bridged-receiver branch, identically.
    // QR1: and the bare-name write-back through `_assignBareName` and the
    // class-target branch, identically again.
    'InterpreterVisitor.visitPostfixExpression': 'c9e1cab1',
    'InterpreterVisitor.visitPrefixExpression': 'ac3124de',
    // SCF37: the bridged step. The only difference is the operator spelling —
    // `TokenType.PLUS_PLUS` / `PLUS_EQ` here, the strings `'++'` / `'+='` in
    // the twin, as in [computeCompoundValue] which it calls.
    'InterpreterVisitor._stepBridgedProperty': '15618af1',
    // QR1: the static step for a class target, the same operator spelling as
    // `_stepBridgedProperty` and nothing else.
    'InterpreterVisitor._stepStaticProperty': '15618af1',
    'InterpreterVisitor.visitPrefixedIdentifier': 'f3391558',
    // DART313B1: 9ac16b77 -> 4745333b, both trees appended the same
    // declined-member reason to the same property-miss message.
    // GHISSUES25: 4745333b -> 43934bf3, smaller: `super.x` on a bridged
    // superclass reads its target through `nativeReceiverFor` in both trees
    // (the reference used to skip the `nativeProxy` fallback the twin had).
    // GHISSUES30: 43934bf3 -> e8e8640d, both trees wrapped the same debug
    // line in `if (Logger.debugEnabled)`; the line already differed (the
    // node's `toSource()` / `toString()`), so the divergence moved with it.
    'InterpreterVisitor.visitPropertyAccess': 'e8e8640d',
    'InterpreterVisitor.visitReturnStatement': 'b0d7b56c',
    'InterpreterVisitor.visitSetOrMapLiteral': '1a33a2d6',
    'InterpreterVisitor.visitSimpleIdentifier': 'c243901e',
    'InterpreterVisitor.visitSwitchExpression': '0e2ec45a',
    // VSTDM3: the analyzer 14 port edited both trees alike; the divergence
    // itself is unchanged.
    'InterpreterVisitor.visitSwitchStatement': 'b768ec28',
    'InterpreterVisitor.visitSymbolLiteral': '971210c9',
    'InterpreterVisitor.visitTryStatement': 'a0a6d8d1',
    'InterpreterVisitor.visitVariableDeclarationList': '9282373f',
    'InterpreterVisitor.visitYieldStatement': '344aa778',
  },
  'introspection.dart': {
    'IntrospectionBuilder._buildClassInfo': 'b394ab44',
    // VSTDM3: the analyzer 14 port edited both trees alike; the divergence
    // itself is unchanged.
    'IntrospectionBuilder.buildFromEnvironment': 'c1da1828',
  },
  'runtime_types.dart': {
    // GHISSUES32: 06adb03e -> 07da2480, both trees widen an int bound to a
    // `double` field alike; the mirror model's nullable field access moved
    // with it.
    'InterpretedClass.createAndInitializeInstance': '07da2480',
    // GHISSUES32: the same set of `double` field names; the mirror model's
    // `fields` and `name` are nullable (`?.`, `?? const []`).
    'InterpretedClass.get doubleFieldNames': 'd9435592',
    'InterpretedClass.getInstanceFieldNames': 'de802187',
    // SCE130. New in both trees, and divergent for the oldest architectural
    // reason in this table: a type parameter's name is a `Token` with
    // `.lexeme` on the reference and a nullable `SSimpleIdentifier` on the
    // mirror, so `p.name.lexeme` cannot be written the same way twice. The
    // reference also needs the `bridge.` prefix, because `TypeParameter` is
    // ambiguous there between the analyzer's AST node and d4rt's own type.
    // The bodies are otherwise token-for-token the same shape.
    'InterpretedClass.resolveDeferredTypeParameterBounds': '93cf914e',
    'InterpretedClass.resolveTypeAnnotationDynamic': 'b27475b4',
    'InterpretedInstance._get': '286b1331',
  },
};

/// The `!` tokens that are null-assertions, gathered from the AST.
///
/// Token text alone cannot tell `x!` from `!x` — both are a lone `!` — and the
/// obvious heuristic ("the previous token looks like a receiver") reads
/// `return !flag` as a null-assert, because `return` is spelled like an
/// identifier. The AST knows; ask it.
class _NullAssertOperators extends GeneralizingAstVisitor<void> {
  final out = <Token>{};

  @override
  void visitPostfixExpression(PostfixExpression node) {
    if (node.operator.type == TokenType.BANG) out.add(node.operator);
    super.visitPostfixExpression(node);
  }
}

/// Every member with a body, keyed by `Owner.member`, as normalised tokens.
///
/// Comments are skipped for free — `Token.next` walks past them, they hang off
/// `precedingComments` — which is correct here for the same reason SCD49 argues
/// it: a doc comment naming the twin's own test path is right, not divergent.
/// Trailing commas are dropped because whether `dart format` emits one depends
/// on the line length, which depends on the comment above it.
class _MemberBodies extends GeneralizingAstVisitor<void> {
  final bool isTwin;
  final Set<Token> _nullAsserts;
  final Set<String> _mirrorTypes;
  final out = <String, List<String>>{};
  String _owner = '';

  _MemberBodies(this.isTwin, this._nullAsserts, this._mirrorTypes);

  List<String> _tokens(AstNode node) {
    final out = <String>[];
    for (Token? t = node.beginToken; t != null; t = t.next) {
      final last = t == node.endToken;
      if (t.lexeme == ',') {
        final next = t.next;
        if (next != null && const [')', ']', '}'].contains(next.lexeme)) {
          if (last) break;
          continue;
        }
      }
      if (_nullAsserts.contains(t)) {
        if (last) break;
        continue;
      }
      var lexeme = t.lexeme;
      if (isTwin) {
        lexeme = denormaliseMirrorType(lexeme, _mirrorTypes);
        lexeme = denormaliseLogPrefix(lexeme, _mirrorTypes);
      }
      out.add(lexeme);
      if (last) break;
    }
    return out;
  }

  void _scoped(String owner, void Function() body) {
    _owner = owner;
    body();
    _owner = '';
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) => _scoped(
    node.namePart.typeName.lexeme,
    () => super.visitClassDeclaration(node),
  );

  @override
  void visitMixinDeclaration(MixinDeclaration node) =>
      _scoped(node.name.lexeme, () => super.visitMixinDeclaration(node));

  @override
  void visitEnumDeclaration(EnumDeclaration node) => _scoped(
    node.namePart.typeName.lexeme,
    () => super.visitEnumDeclaration(node),
  );

  @override
  void visitExtensionDeclaration(ExtensionDeclaration node) => _scoped(
    node.name?.lexeme ?? '<unnamed>',
    () => super.visitExtensionDeclaration(node),
  );

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    // An abstract or external member has no body to compare. Whether it is
    // DECLARED in both trees is F-SCD183-5's question, not this one's.
    if (node.body is EmptyFunctionBody) return;
    final kind = node.isGetter ? 'get ' : (node.isSetter ? 'set ' : '');
    out['$_owner.$kind${node.name.lexeme}'] = _tokens(node.body);
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    if (node.body is EmptyFunctionBody && node.initializers.isEmpty) return;
    // Initialisers are part of what a constructor DOES, and a redirect or a
    // field initialiser diverging is the same class of defect as a statement
    // diverging.
    // `Foo.new` for the unnamed constructor, `Foo.new bar` for a named one.
    // Not `'$_owner.new ${node.name?.lexeme ?? ''}'`, which yields a key with an
    // INVISIBLE TRAILING SPACE for every unnamed constructor — a recorded entry
    // then silently fails to match the member it names, and the guard reports
    // the same constructor as both an unrecorded divergence and a resolved one.
    final name = node.name?.lexeme;
    out['$_owner.new${name == null ? '' : ' $name'}'] = [
      for (final i in node.initializers) ..._tokens(i),
      ..._tokens(node.body),
    ];
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    if (_owner.isEmpty) {
      final body = node.functionExpression.body;
      if (body is! EmptyFunctionBody) {
        out['fn ${node.name.lexeme}'] = _tokens(body);
      }
    }
    super.visitFunctionDeclaration(node);
  }
}

Map<String, List<String>> _memberBodies(
  String path,
  bool isTwin,
  Set<String> mirrorTypes,
) {
  final unit = parseString(
    content: File(path).readAsStringSync(),
    featureSet: FeatureSet.latestLanguageVersion(),
    throwIfDiagnostics: false,
  ).unit;
  final nullAsserts = _NullAssertOperators();
  unit.visitChildren(nullAsserts);
  final bodies = _MemberBodies(isTwin, nullAsserts.out, mirrorTypes);
  unit.visitChildren(bodies);
  return bodies.out;
}

/// FNV-1a, 32-bit, as eight hex digits.
///
/// Hand-rolled rather than pulled from `crypto`: this is a change detector over
/// text the repository already holds, not a security primitive, and a test
/// helper that adds a dependency to the package is a worse trade than nine
/// lines of arithmetic. Deterministic across runs and platforms, which is the
/// only property the pin needs.
String _signature(String refResidue, String astResidue) {
  var hash = 0x811c9dc5;
  for (final unit in '$refResidue $astResidue'.codeUnits) {
    hash ^= unit;
    hash = (hash * 0x01000193) & 0xffffffff;
  }
  return hash.toRadixString(16).padLeft(8, '0');
}

void main() {
  // SCD158: this guard resolves its subject relative to the package it runs
  // in, so a copy anywhere else measures a different tree in silence.
  requirePackage(
    'tom_d4rt',
    subject: 'member bodies shared by both interpreter trees outside stdlib',
  );

  final mirrorTypes = mirrorTypeNames();
  final shared =
      dartFilesUnder(_refRoot, excludedPrefix: _excludedPrefix)
          .toSet()
          .intersection(
            dartFilesUnder(_astRoot, excludedPrefix: _excludedPrefix).toSet(),
          )
          .toList()
        ..sort();

  /// `file -> member -> (ref residue, ast residue)` for every shared body whose
  /// two copies disagree. Computed once; all four tests read it.
  final divergences = <String, Map<String, (String, String)>>{};
  var sharedBodies = 0;

  for (final rel in shared) {
    final ref = _memberBodies('$_refRoot/$rel', false, mirrorTypes);
    final ast = _memberBodies('$_astRoot/$rel', true, mirrorTypes);
    ref.updateAll((_, t) => normaliseAccessorVocabulary(t));
    ast.updateAll((_, t) => normaliseAccessorVocabulary(t));
    final members = (ref.keys.toSet().intersection(ast.keys.toSet()).toList())
      ..sort();
    sharedBodies += members.length;
    for (final member in members) {
      final d = tokenDivergence(ref[member]!, ast[member]!);
      if (d == null) continue;
      (divergences[rel] ??= <String, (String, String)>{})[member] = d;
    }
  }

  test('F-SCD199-1: both trees are present and the corpus was walked '
      '[2026-09-15] (PASS)', () {
    // Runs first, and nothing below means anything until it passes: every other
    // assertion here is an emptiness check over this walk, and a walk that
    // found nothing satisfies all of them. A missing sibling checkout is the
    // likeliest way to reach that state and must not read as three passes.
    expect(
      sharedBodies,
      greaterThanOrEqualTo(_minSharedBodies),
      reason:
          'Only $sharedBodies member bodies are shared between $_refRoot and '
          '$_astRoot, across ${shared.length} files. That is not a finding '
          'about the trees — the walk did not run. The twin is a sibling '
          'checkout in the same `tom_d4rt` repository, and tests are expected '
          'to run with the package root as the working directory.',
    );

    expect(
      mirrorTypes,
      hasLength(greaterThanOrEqualTo(_minMirrorTypes)),
      reason:
          'Read only ${mirrorTypes.length} type names from $mirrorModelRoot. '
          'Every comparison below runs through that rename map, and an empty '
          'map normalises nothing while looking exactly like a map with '
          'nothing to do — every body in the twin would then read as divergent '
          'for spelling `SAstNode`.',
    );
  });

  test('F-SCD199-2: every shared member body outside the recorded list is '
      'identical in both trees [2026-09-15] (PASS)', () {
    final unrecorded = <String>[];
    for (final file in divergences.entries) {
      final recorded = _divergentBodies[file.key] ?? const <String, String>{};
      for (final member in file.value.entries) {
        if (recorded.containsKey(member.key)) continue;
        unrecorded.add(
          '  ${file.key} :: ${member.key}\n'
          '      ref: ${tokenExcerpt(member.value.$1)}\n'
          '      ast: ${tokenExcerpt(member.value.$2)}',
        );
      }
    }

    expect(
      unrecorded,
      isEmpty,
      reason:
          'These member bodies now differ between the two interpreter '
          'trees:\n${unrecorded.join('\n')}\n\n'
          'The mirror rule says a fix lands in BOTH trees in one commit — see '
          '_copilot_guidelines/d4rt/mirror_maintenance.md. This is that rule '
          'measured at the granularity a mirror defect has: one member. Port '
          'the change to the other tree. If the two genuinely cannot say the '
          'same thing here, add the member to _divergentBodies with the '
          'signature the failure prints — but read the divergence first, '
          'because SCC78 is what an unread one costs.',
    );
  });

  test('F-SCD199-3: every recorded divergence is still a divergence '
      '[2026-09-15] (PASS)', () {
    // The ratchet. A list nobody prunes stops being a record of known
    // exceptions and becomes a set of members that are not checked. Two trees
    // coming to agree is good news, and good news has to be recorded or the
    // next reader cannot tell an exemption that is still earned from one whose
    // cause went away years ago.
    final resolved = <String>[];
    for (final file in _divergentBodies.entries) {
      final actual =
          divergences[file.key] ?? const <String, (String, String)>{};
      for (final member in file.key.isEmpty ? <String>[] : file.value.keys) {
        if (!actual.containsKey(member)) {
          resolved.add('  ${file.key} :: $member');
        }
      }
    }

    expect(
      resolved,
      isEmpty,
      reason:
          'These members are recorded as divergent but the two trees now '
          'agree, or no longer share the member at all:\n'
          '${resolved.join('\n')}\n\n'
          'Delete their entries. If the member was renamed rather than '
          'reconciled, rename the entry — a record of a member nobody has is '
          'not a record of anything, and it silently unguards whatever took '
          'the name.',
    );
  });

  test('F-SCD199-4: every recorded divergence is still the SAME divergence '
      '[2026-09-15] (PASS)', () {
    // The SCC78 detector, and the reason the entries carry a signature rather
    // than being a bare list of names.
    //
    // The signature covers the trimmed residue — what the two sides say where
    // they stop agreeing. A fix MIRRORED INTO BOTH trees moves the common
    // prefix and suffix and leaves the residue alone, so it stays silent. A fix
    // that lands in ONE tree changes the residue, and that is exactly the event
    // nothing in this repository could see before.
    final changed = <String>[];
    for (final file in _divergentBodies.entries) {
      final actual =
          divergences[file.key] ?? const <String, (String, String)>{};
      for (final member in file.value.entries) {
        final live = actual[member.key];
        // Absent here means F-SCD199-3 owns it; do not report it twice.
        if (live == null) continue;
        final signature = _signature(live.$1, live.$2);
        if (signature == member.value) continue;
        changed.add(
          '  ${file.key} :: ${member.key}\n'
          '      recorded ${member.value}, now $signature\n'
          '      ref: ${tokenExcerpt(live.$1)}\n'
          '      ast: ${tokenExcerpt(live.$2)}',
        );
      }
    }

    expect(
      changed,
      isEmpty,
      reason:
          'These members diverge differently than their entry records:\n'
          '${changed.join('\n')}\n\n'
          'A recorded divergence changing shape means one tree moved and the '
          'other did not — the mirror rule broken inside a member that was '
          'already known not to match, which is where it is invisible. Decide '
          'which it is:\n'
          '  - the fix belongs in both trees: port it, and the signature goes '
          'back to what it was;\n'
          '  - the divergence genuinely grew: update the signature to the one '
          'printed above, in the same commit as the change that caused it.',
    );
  });
}
