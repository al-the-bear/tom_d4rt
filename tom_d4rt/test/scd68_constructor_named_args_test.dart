// SCD68 — a bridge constructor that reads `namedArgs['x']` is claiming the SDK
// constructor has a named parameter `x`. Check the claim.
//
// That claim was false for `FormatException`, whose adapter read `source` and
// `offset` out of `namedArgs` while the SDK declares
// `FormatException([String message = "", this.source, this.offset])` — three
// POSITIONAL parameters, none of them named. The consequence is silent in both
// directions: the legal spelling dropped both arguments, and the only spelling
// that set them is one Dart does not compile. Nothing caught it for as long as
// the bridge has existed, because nothing was asking.
//
// THE CLAIM IS MECHANICALLY CHECKABLE, which is the whole reason this file
// exists rather than a note saying "check the neighbours". `dart:mirrors` can
// read the SDK constructor's own parameter list on the host VM, so every
// `namedArgs['x']` in a constructor adapter can be matched against it. Measured
// on 2026-09-12: 70 such claims across 17 stdlib files, and after SCD68's fix
// exactly zero mismatches.
//
// EACH CASE OBSERVED, by breaking the thing named:
//
//   | Injected fault                                  | Fires |
//   | ----------------------------------------------- | ----- |
//   | the pre-SCD68 FormatException adapter restored   | 6     |
//   | the walk pointed at a directory with no bridges  | 5     |
//
// The second row is the one that matters. A parser that finds nothing reports
// no mismatches and looks exactly like a clean tree — and this walk was
// briefly in that state while being written, because `parseString` does not
// resolve and `BridgedClass(...)` therefore arrives as a MethodInvocation
// rather than an InstanceCreationExpression. The floor caught it on the first
// run.
//
// PARSED WITH THE ANALYZER, not matched as text. These files are dense with
// comments quoting SDK declarations, and `namedArgs['offset']` appears in prose
// as readily as in code — SCD58 already had to stop a sibling guard counting
// its own commentary. The analyzer discards comments before this code sees a
// token.
//
// GETTERS, METHODS AND STATIC ADAPTERS ARE OUT OF SCOPE and deliberately so.
// Their named arguments come from the METHOD's signature, which mirrors can
// also read, but a method adapter is often a hand-written convenience over
// several SDK members and the one-to-one mapping this check relies on does not
// hold. Constructors are the case where the bridge and the SDK are the same
// shape, which is what makes the comparison sound.
//
// ONE TREE, BOTH COVERED: `tom_d4rt_ast` cannot use `dart:mirrors` — that is
// the point of the analyzer-free twin — and does not need to, because
// `scd49_stdlib_twin_sync_test.dart` asserts the two stdlib trees are
// code-identical. A divergence here would have to break that guard first.

@TestOn('vm')
library;

import 'dart:io';
import 'dart:mirrors';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:test/test.dart';

/// Measured 2026-09-12: 70 claims. The floor catches a parser that stopped
/// matching — which would report zero mismatches and read as a clean tree.
const _minClaims = 55;

/// One `namedArgs['named']` read inside the adapter for `Class.ctor`.
typedef Claim = ({String file, String cls, String ctor, String named});

/// Every such read across the stdlib.
List<Claim> constructorNamedArgClaims(String root) {
  final claims = <Claim>[];
  for (final file
      in Directory(root)
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))) {
    final unit = parseString(
      content: file.readAsStringSync(),
      throwIfDiagnostics: false,
    ).unit;
    unit.accept(_BridgeVisitor(claims, file.uri.pathSegments.last));
  }
  return claims;
}

/// Walks `BridgedClass(...)` creations and pairs each constructor adapter with
/// the `namedArgs[...]` keys its body reads.
class _BridgeVisitor extends RecursiveAstVisitor<void> {
  _BridgeVisitor(this.claims, this.file);

  final List<Claim> claims;
  final String file;

  // `parseString` does not RESOLVE, so `BridgedClass(...)` — written without
  // `new`, as everything in this tree is — arrives as a MethodInvocation and
  // not an InstanceCreationExpression. Both shapes are handled because which
  // one the analyzer produces depends on resolution rather than on the source,
  // and an unresolved parse is what keeps this guard fast.
  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    super.visitInstanceCreationExpression(node);
    if (node.constructorName.type.name.lexeme != 'BridgedClass') return;
    _collect(node.argumentList);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    super.visitMethodInvocation(node);
    if (node.methodName.name != 'BridgedClass') return;
    _collect(node.argumentList);
  }

  void _collect(ArgumentList arguments) {
    String? nativeType;
    SetOrMapLiteral? constructors;
    for (final arg in arguments.arguments) {
      if (arg is! NamedExpression) continue;
      final label = arg.name.label.name;
      final value = arg.expression;
      if (label == 'nativeType' && value is Identifier) {
        nativeType = value.name;
      } else if (label == 'constructors' && value is SetOrMapLiteral) {
        constructors = value;
      }
    }
    if (nativeType == null || constructors == null) return;

    for (final element in constructors.elements) {
      if (element is! MapLiteralEntry) continue;
      final key = element.key;
      if (key is! SimpleStringLiteral) continue;
      final finder = _NamedArgFinder();
      element.value.accept(finder);
      for (final named in finder.keys) {
        claims.add((
          file: file,
          cls: nativeType,
          ctor: key.value,
          named: named,
        ));
      }
    }
  }
}

/// Collects the string keys of every `namedArgs[...]` index expression.
class _NamedArgFinder extends RecursiveAstVisitor<void> {
  final keys = <String>{};

  @override
  void visitIndexExpression(IndexExpression node) {
    super.visitIndexExpression(node);
    final target = node.target;
    final index = node.index;
    if (target is SimpleIdentifier &&
        target.name == 'namedArgs' &&
        index is SimpleStringLiteral) {
      keys.add(index.value);
    }
  }
}

/// The SDK class of that name in any `dart:` library, or null.
ClassMirror? sdkClass(String name) {
  for (final library in currentMirrorSystem().libraries.values) {
    if (!library.uri.toString().startsWith('dart:')) continue;
    for (final declaration in library.declarations.values) {
      if (declaration is ClassMirror &&
          MirrorSystem.getName(declaration.simpleName) == name) {
        return declaration;
      }
    }
  }
  return null;
}

/// The named parameters of `mirror`'s constructor called [ctor], or null when
/// there is no such constructor.
Set<String>? namedParametersOf(ClassMirror mirror, String ctor) {
  for (final declaration in mirror.declarations.values) {
    if (declaration is! MethodMirror || !declaration.isConstructor) continue;
    if (MirrorSystem.getName(declaration.constructorName) != ctor) continue;
    return {
      for (final p in declaration.parameters)
        if (p.isNamed) MirrorSystem.getName(p.simpleName),
    };
  }
  return null;
}

void main() {
  final claims = constructorNamedArgClaims('lib/src/stdlib');

  group('SCD68: bridged constructors agree with the SDK on named parameters', () {
    test('F-SCD68-5: the walk found the constructor adapters '
        '[2026-09-12] (PASS)', () {
      // F-SCD68-6 reports mismatches; with nothing parsed it reports none and
      // reads as a clean bill of health. This is the case that stops that.
      expect(
        claims.length,
        greaterThanOrEqualTo(_minClaims),
        reason:
            'Only ${claims.length} `namedArgs[...]` reads found in '
            'constructor adapters. That is not a finding about the bridges — '
            'the walk or the parse stopped matching, and every adapter would '
            'then read as correct by absence.',
      );
    });

    test('F-SCD68-6: every named key a constructor reads is one the SDK declares '
        '[2026-09-12] (PASS)', () {
      final wrong = <String>[];
      final unreadable = <String>[];
      for (final claim in claims) {
        final mirror = sdkClass(claim.cls);
        if (mirror == null) {
          unreadable.add('${claim.cls} (${claim.file}): no dart: class');
          continue;
        }
        final named = namedParametersOf(mirror, claim.ctor);
        if (named == null) {
          // A factory reached through a different name, or a class whose
          // constructor mirrors do not expose. Reported, not failed: an
          // unreadable signature is not evidence of a wrong one.
          unreadable.add(
            '${claim.cls}.${claim.ctor} (${claim.file}): constructor not '
            'found through mirrors',
          );
          continue;
        }
        if (named.contains(claim.named)) continue;
        wrong.add(
          '${claim.file}  ${claim.cls}'
          '${claim.ctor.isEmpty ? '' : '.${claim.ctor}'}  reads '
          "namedArgs['${claim.named}'], but the SDK constructor declares "
          '${named.isEmpty ? 'NO named parameters' : 'named: ${(named.toList()..sort()).join(', ')}'}',
        );
      }
      expect(
        wrong,
        isEmpty,
        reason:
            'These adapters read a named argument the SDK constructor does '
            'not have, so the only spelling that reaches them is one Dart '
            'will not compile — and the legal spelling silently drops the '
            'value:\n${wrong.join('\n')}\n\n'
            'Read the parameter positionally instead, length-guarded. '
            '${unreadable.isEmpty ? '' : '\n\nNot checkable (reported, not failed): ${unreadable.join('; ')}'}',
      );
    });
  });
}
