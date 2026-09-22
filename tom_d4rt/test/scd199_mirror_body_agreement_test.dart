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
// THE RISK EACH CARRIES, stated rather than hidden. (1) would mask a divergence
// where the twin names a mirror type and the reference names an unrelated
// analyzer type of the same base name — that is the 1:1 claim being false, a
// larger problem, and `tom_ast_model`'s own suite is where it belongs. (2)
// would mask a reference `x!` against a twin `x`: a crash-versus-crash
// difference, not a wrong-answer one. (3) is bounded to a whole bracketed token
// whose S-form is a declared type, so `[Setup]` survives.
//
// WHAT WAS DELIBERATELY NOT NORMALISED, having been measured: `?.` -> `.` is
// worth 0 bodies, `.lexeme` -> `.name` is worth 3, and `moduleLoader` ->
// `moduleContext` is worth 0. Each is a semantic rewrite that could hide a
// genuinely wrong accessor, and none of them pays for that.
//
// THE 107 ARE PINNED BY THEIR DIVERGENCE, not merely listed. Each entry holds a
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
// resolved. SCC78's own line is among the 107. This guard freezes the
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
/// NO PER-ENTRY REASON, also deliberate. 107 individually-worded reasons would
/// be 107 restatements of five facts, and the five facts are recorded once
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
    'BoundExtensionMethodCallable.call': '1154620a',
    'InterpretedExtensionMethod.call': 'c2d7ab35',
    'InterpretedFunction._beginAwaitForIteration': '57e94918',
    'InterpretedFunction._callImpl': 'c0f390c5',
    'InterpretedFunction._containsAwait': 'ee448f09',
    'InterpretedFunction._determineNextNodeAfterAwait': '296f0d23',
    'InterpretedFunction._extractTypeParameterBounds': '065705f9',
    'InterpretedFunction._extractTypeParameterNames': '065705f9',
    'InterpretedFunction._findEnclosingTryStatement': '64523cb5',
    'InterpretedFunction._findInvocationWithAwaitInArguments': '5fedfaed',
    'InterpretedFunction._findNextSequentialNode': '00e07640',
    'InterpretedFunction._enclosingExpressionFunctionBody': '34fd9762',
    'InterpretedFunction._handleAsyncError': '44cf6fc0',
    'InterpretedFunction._instantiateRedirectedFactory': 'c9d9b3ba',
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
    'InterpretedFunction._jumpTarget': 'c5e2ff57',
    'InterpretedFunction._leaveLoopsFor': 'e47bcb14',
    'InterpretedFunction._nextEnclosingFinallyTry': 'fe832583',
    'InterpretedFunction._paramRuntimeType': '7b7a00d6',
    'InterpretedFunction._prepareExecutionEnvironment': 'e931c715',
    'InterpretedFunction._resolveTypeAnnotationDynamic': '2c861378',
    // SCE139: the statement walker the return and invocation resumption
    // routes hand their statement back through, divergent for the same
    // architectural reason as its neighbours — the mirror AST has no
    // `parent` getter, so the twin walks with `_parentOf`.
    'InterpretedFunction._resumableStatementFor': 'ca3c88e4',
    // SCE102 moved this signature without changing what diverges. The
    // empty-loop-body fallback landed symmetrically in both trees — the
    // added lines are identical modulo the `S` prefix — and a symmetric
    // edit to an ALREADY-divergent member still moves the pair's hash,
    // because the hash is over both bodies. The divergence itself is
    // unchanged: the mirror AST has no `parent` getter, so the twin walks
    // with `_parentOf`.
    'InterpretedFunction._runStateMachine': 'a68fb2ac',
    'InterpretedFunction._tryOwningCatchClauseOf': 'f1617e03',
    'InterpretedFunction._tryOwningFinallyBlockOf': '34fd9762',
    'InterpretedFunction.bind': '78b56933',
    'InterpretedFunction.get arity': 'c0481db8',
    'InterpretedFunction.get callableRuntimeType': 'cc843066',
    'InterpretedFunction.get canCallWithoutArgs': 'ef0e0484',
    'InterpretedFunction.get maxPositionalArity': '8f421c1b',
    'InterpretedFunction.get namedParameterNames': 'a22a70a7',
    'InterpretedFunction.get positionalParameterNames': 'b1eea3ef',
    'InterpretedFunction.new constructor': '49d18ddc',
    'InterpretedFunction.new declaration': '65a26fb0',
    'InterpretedFunction.new expression': '73245b03',
    'InterpretedFunction.new method': '77b0bad1',
    'InterpretedFunction.resolveBinding': 'fe2646f7',
    '_LazySyncGeneratorIterator._executeForInWithYieldSuspension': 'd10a91e2',
  },
  'declaration_visitor.dart': {
    // SCE130: 81e4977d -> 954e4039. Pass 1 now passes `lenient: true` when
    // extracting the class's type-parameter bounds, in both trees; the
    // residue is the accessor difference this member already had.
    'DeclarationVisitor.visitClassDeclaration': '954e4039',
    'DeclarationVisitor.visitEnumDeclaration': '10a0fbf5',
    'DeclarationVisitor.visitFunctionDeclaration': 'c120e983',
    'DeclarationVisitor.visitMixinDeclaration': '065705f9',
    'DeclarationVisitor.visitTopLevelVariableDeclaration': '22ca34c5',
  },
  'interpreter_visitor.dart': {
    'InterpreterVisitor._chainHasNullAwareSelector': 'a28a7690',
    'InterpreterVisitor._checkAppliedGenericReturn': '04ded847',
    'InterpreterVisitor._checkValueMatchesType': 'aa296ffe',
    'InterpreterVisitor._evaluateArguments': '0df79830',
    'InterpreterVisitor._evaluateArgumentsAsync': '0df79830',
    'InterpreterVisitor._executeCascadeAssignment': '24682899',
    'InterpreterVisitor._executeClassicFor': '89d506ba',
    'InterpreterVisitor._executeForIn': '9e90b956',
    'InterpreterVisitor._executeForInWithItems': '9e90b956',
    'InterpreterVisitor._functionRuntimeTypeFromParts': '13a969d0',
    'InterpreterVisitor._mapCompoundToOperatorName': 'd728ed84',
    // SCE104 extracted both from `visitAsExpression`, whose divergence they
    // inherit: the mirror AST carries an `importPrefix` and an `isNullable`
    // flag where the analyzer's node carries a token and a `question`, and it
    // cannot print itself, so the twin rebuilds the type's spelling by hand.
    // `_castTypeDescription` exists to keep that one difference in one member
    // instead of at both call sites.
    'InterpreterVisitor._castTypeDescription': '8ab45b85',
    'InterpreterVisitor._tryCast': '15d1bc02',
    'InterpreterVisitor._matchAndBind': '83c84f07',
    'InterpreterVisitor._processCollectionElement': '2043ae78',
    'InterpreterVisitor._resolveFormalParameterRuntimeType': '7b7a00d6',
    'InterpreterVisitor._resolveTypeAnnotationWithEnvironment': 'ff411f95',
    'InterpreterVisitor._statementsIntroduceBindings': '73f8180e',
    'InterpreterVisitor._subtreeContainsClosure': 'b6e41360',
    'InterpreterVisitor._valueHasType': 'e8b1caf9',
    'InterpreterVisitor.catchClauseMatches': '1154620a',
    'InterpreterVisitor.computeCompoundValue': 'aab15c4a',
    'InterpreterVisitor.new': '2cc4e641',
    'InterpreterVisitor.registerTypeAlias': '2107b213',
    'InterpreterVisitor.resolveStaticCoordinates': '1c58137b',
    'InterpreterVisitor.visitAsExpression': '749f9253',
    'InterpreterVisitor.visitAssignmentExpression': '510fd0b5',
    'InterpreterVisitor.visitBinaryExpression': '4a8ad811',
    // SCE130: 57fc0f99 -> fffabfd5. Both trees gained the same call to
    // `klass.resolveDeferredTypeParameterBounds`; the residue is the
    // accessor difference this member already had.
    'InterpreterVisitor.visitClassDeclaration': 'fffabfd5',
    'InterpreterVisitor.visitConstructorReference': 'eca261a7',
    'InterpreterVisitor.visitEnumDeclaration': '17c15a6b',
    'InterpreterVisitor.visitExtensionDeclaration': '9ebdafbe',
    'InterpreterVisitor.visitExtensionTypeDeclaration': 'eb245e2e',
    'InterpreterVisitor.visitForStatement': '1df0d7d7',
    'InterpreterVisitor.visitFunctionDeclaration': '3eb87faa',
    'InterpreterVisitor.visitFunctionDeclarationStatement': '1a8fa2ed',
    'InterpreterVisitor.visitIdentifier': '0b2aded7',
    'InterpreterVisitor.visitIfStatement': 'f881cee4',
    'InterpreterVisitor.visitImportDirective': '9958469b',
    'InterpreterVisitor.visitInstanceCreationExpression': '57654813',
    'InterpreterVisitor.visitIsExpression': '6e0e258c',
    'InterpreterVisitor.visitListLiteral': 'f2dad9eb',
    // SCE109 moved this signature without changing what diverges: the
    // arity-heuristic throw sites inside it now raise `RangeError`
    // rather than `RuntimeD4rtException`, symmetrically in both trees.
    'InterpreterVisitor.visitMethodInvocation': '2435dba5',
    'InterpreterVisitor.visitMixinDeclaration': '945459ee',
    'InterpreterVisitor.visitNode': '9f50a531',
    'InterpreterVisitor.visitPostfixExpression': 'e253ea5d',
    'InterpreterVisitor.visitPrefixExpression': 'a6f310ca',
    'InterpreterVisitor.visitPrefixedIdentifier': 'c95921c9',
    'InterpreterVisitor.visitPropertyAccess': 'fa905cfd',
    'InterpreterVisitor.visitReturnStatement': '769cc75d',
    'InterpreterVisitor.visitSetOrMapLiteral': 'c55d6070',
    'InterpreterVisitor.visitSimpleIdentifier': '2cd8b958',
    'InterpreterVisitor.visitSwitchExpression': '0e2ec45a',
    'InterpreterVisitor.visitSwitchStatement': '059a026e',
    'InterpreterVisitor.visitSymbolLiteral': 'd18a2bb6',
    'InterpreterVisitor.visitTopLevelVariableDeclaration': 'ac8d1025',
    'InterpreterVisitor.visitTryStatement': 'da0501a5',
    'InterpreterVisitor.visitVariableDeclarationList': '5bb0fd50',
    'InterpreterVisitor.visitYieldStatement': '51c9c740',
  },
  'introspection.dart': {
    'IntrospectionBuilder._buildClassInfo': 'ae54b734',
    'IntrospectionBuilder.buildFromEnvironment': '74b793ea',
  },
  'runtime_types.dart': {
    'InterpretedClass.createAndInitializeInstance': '44fa7495',
    'InterpretedClass.extractTypeParameterBounds': '065705f9',
    'InterpretedClass.extractTypeParameterNames': '065705f9',
    'InterpretedClass.getInstanceFieldNames': '77e37c53',
    // SCE130. New in both trees, and divergent for the oldest architectural
    // reason in this table: a type parameter's name is a `Token` with
    // `.lexeme` on the reference and a nullable `SSimpleIdentifier` on the
    // mirror, so `p.name.lexeme` cannot be written the same way twice. The
    // reference also needs the `bridge.` prefix, because `TypeParameter` is
    // ambiguous there between the analyzer's AST node and d4rt's own type.
    // The bodies are otherwise token-for-token the same shape.
    'InterpretedClass.resolveDeferredTypeParameterBounds': 'd241f09e',
    'InterpretedClass.resolveTypeAnnotationDynamic': '63de37c4',
    'InterpretedInstance.get': '286b1331',
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
  void visitClassDeclaration(ClassDeclaration node) =>
      _scoped(node.name.lexeme, () => super.visitClassDeclaration(node));

  @override
  void visitMixinDeclaration(MixinDeclaration node) =>
      _scoped(node.name.lexeme, () => super.visitMixinDeclaration(node));

  @override
  void visitEnumDeclaration(EnumDeclaration node) =>
      _scoped(node.name.lexeme, () => super.visitEnumDeclaration(node));

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
