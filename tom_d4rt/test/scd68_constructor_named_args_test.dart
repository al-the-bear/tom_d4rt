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
//   | SCE110: `Uri.parse` re-broken (a STATIC)         | 6     |
//   | SCE110: `RandomAccessFile.unlock` (a METHOD)     | 6     |
//
// The last two are the widening's own ablation: each newly covered section
// reached separately, because a walk that collects a section and then drops it
// before the comparison would still pass the floor.
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
// SCE110 WIDENED THIS TO METHODS AND STATICS, and the paragraph it replaces
// was a hypothesis that measurement did not support. It read: a method adapter
// "is often a hand-written convenience over several SDK members and the
// one-to-one mapping this check relies on does not hold". Nobody had counted.
//
// Counted 2026-09-22, over 279 claims:
//
//   | section         | claims | resolved one-to-one |
//   | --------------- | -----: | ------------------: |
//   | methods         |    145 |                 145 |
//   | constructors    |     71 |                  70 |
//   | staticMethods   |     63 |                  63 |
//
// One claim in the whole stdlib cannot be resolved — `BytesBuilder`'s unnamed
// constructor, a factory on an abstract class that mirrors does not expose.
// The hypothesis was wrong by 278 to 1.
//
// TWO LOOKUP FIXES WERE NEEDED TO SEE THAT, and both were the check's fault
// rather than the bridges'. Resolving only through `superclass` reported 47
// unresolvable, because `HashSet` IMPLEMENTS `Set` and reaches `firstWhere`
// through no superclass at all; walking `superinterfaces` too took it to 14.
// The remaining 13 were factory constructors exposed as statics — `List.filled`,
// `Map.fromIterable`, `int.fromEnvironment` — which is an ordinary bridge shape
// and a signature mirrors can read, so the static lookup falls back to the
// constructor of the same name. An unresolvable bucket that is really the
// checker's blind spot is the worst kind: it looks like modesty and reads as
// coverage.
//
// The widening found 17 mismatches, every one the same shape as SCD68's and
// none of them subtle: `Uri.parse`/`tryParse`/`parseIPv6Address`,
// `RandomAccessFile.lock`/`lockSync`/`unlock`/`unlockSync` and
// `HttpClientResponse.redirect` each read an optional POSITIONAL parameter out
// of `namedArgs`. All are fixed; the count here is now zero.
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

/// Measured 2026-09-22: 262 claims — 134 methods, 71 constructors, 57 statics.
/// The floor catches a parser that stopped matching, which would report zero
/// mismatches and read as a clean tree.
///
/// SCE110 raised it WITH the scope. A floor left at the constructor-only 55
/// would have been satisfied by the constructors alone, so the two thirds this
/// widening exists for could have stopped being walked without a word.
const _minClaims = 210;

/// One `namedArgs['named']` read inside the adapter for `Class.member`.
typedef Claim = ({
  String file,
  String cls,
  String section,
  String member,
  String named,
});

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
    final sections = <String, SetOrMapLiteral>{};
    for (final arg in arguments.arguments) {
      if (arg is! NamedExpression) continue;
      final label = arg.name.label.name;
      final value = arg.expression;
      if (label == 'nativeType' && value is Identifier) {
        nativeType = value.name;
      } else if (_sections.contains(label) && value is SetOrMapLiteral) {
        sections[label] = value;
      }
    }
    if (nativeType == null || sections.isEmpty) return;

    sections.forEach((section, literal) {
      for (final element in literal.elements) {
        if (element is! MapLiteralEntry) continue;
        final key = element.key;
        if (key is! SimpleStringLiteral) continue;
        final finder = _NamedArgFinder();
        element.value.accept(finder);
        for (final named in finder.keys) {
          claims.add((
            file: file,
            cls: nativeType!,
            section: section,
            member: key.value,
            named: named,
          ));
        }
      }
    });
  }
}

/// The adapter sections whose named keys are a claim about an SDK signature.
///
/// Getters and setters take no arguments, so they make no such claim.
const _sections = {'constructors', 'methods', 'staticMethods'};

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

/// The named parameters of the method [name] on [start], its superclasses, its
/// mixins or the INTERFACES it implements; null when no such member is
/// reachable.
///
/// SCE110: the interface walk is the half a superclass-only lookup misses.
/// `HashSet` is an abstract class that IMPLEMENTS `Set`, so `firstWhere` is
/// reachable through `superinterfaces` and through no superclass at all —
/// counting that as "unresolvable" would inflate the one bucket this check
/// cannot speak for, which is the bucket most likely to be mistaken for
/// modesty.
Set<String>? namedParametersOfMethod(
  ClassMirror? start,
  String name, {
  required bool isStatic,
}) {
  final seen = <ClassMirror>{};
  final queue = <ClassMirror>[?start];
  while (queue.isNotEmpty) {
    final mirror = queue.removeAt(0);
    if (!seen.add(mirror)) continue;
    for (final declaration in mirror.declarations.values) {
      if (declaration is! MethodMirror ||
          declaration.isConstructor ||
          declaration.isGetter ||
          declaration.isSetter) {
        continue;
      }
      if (declaration.isStatic != isStatic) continue;
      if (MirrorSystem.getName(declaration.simpleName) != name) continue;
      return {
        for (final p in declaration.parameters)
          if (p.isNamed) MirrorSystem.getName(p.simpleName),
      };
    }
    // Statics are not inherited, so one class is the whole search.
    if (isStatic) break;
    final superclass = mirror.superclass;
    if (superclass != null && superclass.simpleName != const Symbol('Object')) {
      queue.add(superclass);
    }
    queue.addAll(mirror.superinterfaces);
  }
  return null;
}

/// Claims whose SDK signature this check cannot read, and why.
///
/// SCE110 gave the bucket a policy instead of a silent skip. An unreadable
/// signature is not evidence of a wrong one, so these are not failures — but
/// "cannot read" must not become the escape hatch that quietly absorbs the
/// next real mismatch, so the SET is pinned and F-SCE110-1 fails when it grows.
///
/// Both lookup fixes SCE110 made were found by asking why this set was large:
/// it stood at 47 with a superclass-only walk, 14 after interfaces, and 1 once
/// a static could fall back to a factory constructor of the same name.
const Map<String, String> _unreadableBaseline = <String, String>{
  'BytesBuilder.': 'a factory on an abstract class; mirrors does not expose it',
};

void main() {
  final claims = constructorNamedArgClaims('lib/src/stdlib');

  group('SCD68/SCE110: bridged adapters agree with the SDK on named parameters', () {
    test('F-SCD68-5: the walk found the adapters, in all three sections '
        '[2026-09-12] (PASS)', () {
      // F-SCD68-6 reports mismatches; with nothing parsed it reports none and
      // reads as a clean bill of health. This is the case that stops that.
      expect(
        claims.length,
        greaterThanOrEqualTo(_minClaims),
        reason:
            'Only ${claims.length} `namedArgs[...]` reads found across the '
            'constructor, method and static adapters. That is not a finding '
            'about the bridges — '
            'the walk or the parse stopped matching, and every adapter would '
            'then read as correct by absence.',
      );
    });

    test('F-SCD68-6: every named key an adapter reads is one the SDK declares '
        '[2026-09-12] (PASS)', () {
      final wrong = <String>[];
      final unreadable = <String>[];
      for (final claim in claims) {
        final mirror = sdkClass(claim.cls);
        if (mirror == null) {
          unreadable.add('${claim.cls} (${claim.file}): no dart: class');
          continue;
        }
        Set<String>? named;
        if (claim.section == 'constructors') {
          named = namedParametersOf(mirror, claim.member);
        } else {
          named = namedParametersOfMethod(
            mirror,
            claim.member,
            isStatic: claim.section == 'staticMethods',
          );
          // A named or factory CONSTRUCTOR exposed as a static is an ordinary
          // bridge shape — `List.filled`, `Map.fromIterable`,
          // `int.fromEnvironment` — and its signature is one mirrors can read,
          // so it is checked rather than shrugged at.
          named ??= claim.section == 'staticMethods'
              ? namedParametersOf(mirror, claim.member)
              : null;
        }
        if (named == null) {
          // A factory reached through a different name, or a class whose
          // constructor mirrors do not expose. Reported, not failed: an
          // unreadable signature is not evidence of a wrong one.
          unreadable.add('${claim.cls}.${claim.member}');
          continue;
        }
        if (named.contains(claim.named)) continue;
        wrong.add(
          '${claim.file}  ${claim.cls}'
          '${claim.member.isEmpty ? '' : '.${claim.member}'} '
          '[${claim.section}]  reads '
          "namedArgs['${claim.named}'], but the SDK member declares "
          '${named.isEmpty ? 'NO named parameters' : 'named: ${(named.toList()..sort()).join(', ')}'}',
        );
      }
      expect(
        wrong,
        isEmpty,
        reason:
            'These adapters read a named argument the SDK member does '
            'not have, so the only spelling that reaches them is one Dart '
            'will not compile — and the legal spelling silently drops the '
            'value:\n${wrong.join('\n')}\n\n'
            'Read the parameter positionally instead, length-guarded.',
      );
    });

    test('F-SCE110-1: the unreadable set has not grown [2026-09-22] (PASS)', () {
      // The policy the bucket lacked. An unreadable signature is not evidence
      // of a wrong one, so it does not fail — but left unpinned, "cannot read"
      // is where the next real mismatch goes to be quiet. Measured 2026-09-22:
      // exactly one, and only after two lookup fixes took it from 47.
      final unreadable = <String>{};
      for (final claim in claims) {
        final mirror = sdkClass(claim.cls);
        Set<String>? named;
        if (mirror != null) {
          named = claim.section == 'constructors'
              ? namedParametersOf(mirror, claim.member)
              : namedParametersOfMethod(
                      mirror,
                      claim.member,
                      isStatic: claim.section == 'staticMethods',
                    ) ??
                    (claim.section == 'staticMethods'
                        ? namedParametersOf(mirror, claim.member)
                        : null);
        }
        if (named == null) unreadable.add('${claim.cls}.${claim.member}');
      }
      expect(
        unreadable.difference(_unreadableBaseline.keys.toSet()),
        isEmpty,
        reason:
            'These claims joined the unreadable bucket, so nothing is checking '
            'them:\n  ${unreadable.difference(_unreadableBaseline.keys.toSet()).join('\n  ')}\n\n'
            'Either teach the lookup to reach the member — both of SCE110\'s '
            'fixes came from asking exactly that — or record it in '
            '_unreadableBaseline with the reason it cannot be read.',
      );
      expect(
        _unreadableBaseline.keys.toSet().difference(unreadable),
        isEmpty,
        reason:
            'These are recorded as unreadable but now resolve. Remove them: a '
            'baseline that outlives its cause reads as a gap that is already '
            'closed.',
      );
    });
  });
}
