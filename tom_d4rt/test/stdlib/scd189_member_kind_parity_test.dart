// Every bridged member is registered under the KIND the SDK declares.
//
// WHAT THE MEMBER AUDIT DOES NOT ASK. `scc73_sdk_member_completeness_test.dart`
// asks whether a member RESOLVES, and the coverage baseline asks whether it is
// REACHABLE. Both are satisfied by an adapter that resolves and then does the
// wrong thing — which is not hypothetical: SCC73 found `Runes.iterator`
// registered as a METHOD, so it resolved fine and handed back the bound
// callable instead of the iterator, and no existing guard noticed.
//
// THIS FILE ASKS THE NEXT QUESTION, and it is the cheapest useful form of it.
// Not "does the adapter compute the right value" — that is a behaviour case per
// member and there are 3 103 adapters. Just: is it registered as the same KIND
// of member the SDK declares? A getter registered among the methods, or a
// method among the setters, is wrong for every value it could possibly return,
// and the SDK source already says which is which.
//
// SCD189 PROPOSED A DIFFERENT NET, and measuring it is what produced this one.
// The suggestion was to classify each adapter BODY as "a single forwarding
// expression" or not, splitting the surface into "cannot plausibly be wrong
// once it resolves" and "could be". Measured over all 3 103 stdlib adapters:
//
//     pure forwarding, no risk marker      2 064
//     coerces an argument                    101
//     adapts a callback                      266
//     branches on arity                      835
//     constructs a result                     98
//     at least one marker                  1 039
//
// A thousand adapters is not a list anybody works through, so that split does
// not turn an unbounded ask into a bounded one. And the decisive objection is
// sharper: the body classifier would not have caught SCD189's OWN motivating
// example. `Runes.iterator`'s body was `(target as Runes).iterator` — a single
// forwarding expression, in the "cannot plausibly be wrong" bucket. The defect
// was in which MAP it sat in.
//
// So the shape worth guarding is the registration, not the body. It is also
// complete rather than sampled: 1 487 members compared, every one of them.
//
// ONE DIRECTION OF THIS WAS ALREADY GUARDED, and finding that out is what
// showed the two are complementary rather than redundant. `F-SCD77-4` in
// `scc24_native_name_coverage_test.dart` refuses a name registered as a GETTER
// that the SDK declares as a METHOD, asked through `dart:mirrors`. Every one of
// the three fabrications below is the OPPOSITE direction — a method registered
// where the SDK declares a getter — which that case structurally cannot see.
// Different oracle too: it reads the runtime registry, this reads the SDK
// source. Both are kept.
//
// WHAT IT FOUND — six, in two shapes.
//
// THE BLOCKING SHAPE. `StreamSubscription.onData`, `onDone` and `onError` were
// registered as SETTERS. Dart declares them as methods — `sub.onData(h)` — so a
// script written correctly failed with "has no instance method named 'onData'"
// and only the uncompilable `sub.onData = h` worked. The one test in this repo
// that exercised it, F-SCB9-8, was itself written in the invalid form; it is
// now written the Dart way.
//
// THE FABRICATION SHAPE. `Encoding.inverted`, `Function.hashCode` and
// `UnmodifiableListView.reversed` were registered as METHODS beside a correct
// getter, so `utf8.inverted()`, `f.hashCode()` and `view.reversed()` were
// accepted. Each is green in the interpreter and rejected by the Dart analyser
// — the defect `stdlib_member_diff.dart` calls out as the one no passing test
// can catch, because the test would have to be written in the same invalid
// Dart. `Function.hashCode`'s method was additionally DEAD: the universal
// Object getter shadowed it, so the adapter had never run.
//
// None of the six is visible to a reachability check, which is the argument for
// this file existing.
//
// READING THE SDK IS WHERE THE CARE GOES, and two subtleties cost a wrong
// answer each before this settled:
//
//   * A NAME CAN HAVE TWO KINDS. `Stdin.echoMode` is a getter AND a setter;
//     keeping one kind per name reported three false mismatches. The SDK side
//     is a SET.
//   * A KIND CAN BE INHERITED. `List` declares only `set first`; the getter
//     comes from `Iterable`. Comparing against the declaring class alone
//     reported `List.first` as a getter-registered setter. So the comparison
//     walks the supertype chain, and a name found nowhere on it is skipped
//     rather than guessed at.
//   * THE CHAIN LEAVES THE BRIDGED LIBRARIES. `UnmodifiableListView` reaches
//     `List`'s `set length` through `UnmodifiableListBase`, a CLASS TYPE ALIAS
//     declared in `dart:_internal`. Three things had to be added for that one
//     edge — type aliases, mixins, and a private library in the READ set — and
//     until they were, `length` read as a mismatch and `reversed`'s real
//     mismatch stayed hidden behind it.
//
// EACH CASE HAS BEEN SEEN TO FAIL:
//
//   | Injected fault                                     | Fires      |
//   | -------------------------------------------------- | ---------- |
//   | `Runes.iterator` moved back to the methods map      | 1          |
//   | the SDK library list emptied                        | 2, 3       |
//   | the supertype walk stopped at the declaring class   | 1, 2, 3    |
//
// The third row is the header's own argument, demonstrated: a walk that stops
// early does not go quiet. It under-reports (fewer members compared) and
// over-accuses (inherited kinds read as mismatches) at the same time, so the
// two failures together say "the oracle is broken", not "the bridges are".

import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/src/stdlib/async.dart';
import 'package:tom_d4rt/src/stdlib/collection.dart';
import 'package:tom_d4rt/src/stdlib/convert.dart';
import 'package:tom_d4rt/src/stdlib/io.dart';
import 'package:tom_d4rt/src/stdlib/math.dart';
import 'package:tom_d4rt/src/stdlib/typed_data.dart';

const _libraries = <String>[
  'core',
  'async',
  'collection',
  'convert',
  'io',
  'math',
  'typed_data',
  'isolate',
  // `_internal` is not a bridged library and never will be — it is here only
  // so the SUPERTYPE WALK can pass through it. `UnmodifiableListView` reaches
  // `List`'s `set length` via `UnmodifiableListBase`, which is a class type
  // alias declared in `dart:_internal`; without this the chain dead-ends and
  // every member inherited across it reads as a mismatch. Adding a private
  // library to a READ is safe in a way registering one would not be: nothing
  // here is exposed to a script.
  '_internal',
];

/// 1 487 members compared on 2026-09-15. The floor is well below that because
/// its job is to separate "compared the surface" from "compared nothing" —
/// every assertion below is an emptiness check, which an empty comparison
/// satisfies.
///
/// The number is also the measure of the supertype walk: before it followed
/// class type aliases, mixins and `dart:_internal`, the same comparison reached
/// 957 and reported four members as mismatched that were not. A walk that stops
/// early does not fail, it under-reports and over-accuses at once.
const _minCompared = 1100;

/// Registrations that differ from the SDK's kind for a reason.
///
/// Empty, and measured empty rather than assumed: the three that were here when
/// this file was written are fixed rather than recorded. An entry is a decision
/// on the record; the shape it would take is `'Class.member': 'why'`.
const _accepted = <String, String>{};

CompilationUnit _parse(String path) => parseFile(
  path: path,
  featureSet: FeatureSet.latestLanguageVersion(),
  throwIfDiagnostics: false,
).unit;

String _sdkLibRoot() =>
    '${File(Platform.resolvedExecutable).parent.parent.path}/lib';

/// `dart:<name>` to its source files: the library file plus every part.
List<String> _sdkSourceFiles(String libRoot, String dartLibrary) {
  final json =
      jsonDecode(File('$libRoot/libraries.json').readAsStringSync())
          as Map<String, dynamic>;
  final libs = <String, dynamic>{};
  void merge(String target) {
    final block = json[target] as Map<String, dynamic>?;
    if (block == null) return;
    for (final include in (block['include'] as List<dynamic>? ?? const [])) {
      merge((include as Map<String, dynamic>)['target'] as String);
    }
    libs.addAll(block['libraries'] as Map<String, dynamic>? ?? const {});
  }

  merge('vm');
  final entry = libs[dartLibrary] as Map<String, dynamic>?;
  if (entry == null) return const [];
  final found = <String>[];
  final queue = <String>['$libRoot/${entry['uri']}'];
  while (queue.isNotEmpty) {
    final path = queue.removeLast();
    if (found.contains(path) || !File(path).existsSync()) continue;
    found.add(path);
    for (final directive in _parse(path).directives) {
      if (directive is! PartDirective) continue;
      final uri = directive.uri.stringValue;
      if (uri == null || uri.startsWith('dart:')) continue;
      queue.add(File('${File(path).parent.path}/$uri').absolute.path);
    }
  }
  return found;
}

/// One SDK class: the kinds it declares per member name, and who it extends.
class _SdkClass {
  final kinds = <String, Set<String>>{};
  final supertypes = <String>{};
}

Map<String, _SdkClass> _readSdk() {
  final root = _sdkLibRoot();
  final out = <String, _SdkClass>{};
  for (final library in _libraries) {
    for (final path in _sdkSourceFiles(root, library)) {
      for (final declaration in _parse(path).declarations) {
        // CLASS TYPE ALIASES ARE NOT OPTIONAL HERE, and leaving them out is
        // what made `UnmodifiableListView.length` read as a mismatch.
        // `abstract class UnmodifiableListBase<E> = ListBase<E> with
        // UnmodifiableListMixin<E>;` is a `ClassTypeAlias`, so a walk that
        // only visits `ClassDeclaration` stops there — and everything above
        // it, including `List`'s `set length`, becomes invisible.
        if (declaration is ClassTypeAlias) {
          final alias = out.putIfAbsent(declaration.name.lexeme, _SdkClass.new);
          alias.supertypes.add(declaration.superclass.name.lexeme);
          for (final type in declaration.withClause.mixinTypes) {
            alias.supertypes.add(type.name.lexeme);
          }
          for (final type
              in declaration.implementsClause?.interfaces ?? const []) {
            alias.supertypes.add(type.name.lexeme);
          }
          continue;
        }
        if (declaration is MixinDeclaration) {
          final mixin = out.putIfAbsent(declaration.name.lexeme, _SdkClass.new);
          for (final type
              in declaration.onClause?.superclassConstraints ??
                  const <NamedType>[]) {
            mixin.supertypes.add(type.name.lexeme);
          }
          for (final type
              in declaration.implementsClause?.interfaces ?? const []) {
            mixin.supertypes.add(type.name.lexeme);
          }
          for (final member in declaration.members) {
            if (member is! MethodDeclaration || member.isStatic) continue;
            final memberName = member.name.lexeme;
            if (memberName.startsWith('_')) continue;
            mixin.kinds
                .putIfAbsent(memberName, () => <String>{})
                .add(
                  member.isGetter
                      ? 'getter'
                      : (member.isSetter ? 'setter' : 'method'),
                );
          }
          continue;
        }
        if (declaration is! ClassDeclaration) continue;
        final name = declaration.name.lexeme;
        if (name.startsWith('_')) continue;
        final entry = out.putIfAbsent(name, _SdkClass.new);
        final extendsClause = declaration.extendsClause;
        if (extendsClause != null) {
          entry.supertypes.add(extendsClause.superclass.name.lexeme);
        }
        for (final type
            in declaration.implementsClause?.interfaces ?? const []) {
          entry.supertypes.add(type.name.lexeme);
        }
        for (final type in declaration.withClause?.mixinTypes ?? const []) {
          entry.supertypes.add(type.name.lexeme);
        }
        for (final member in declaration.members) {
          if (member is! MethodDeclaration || member.isStatic) continue;
          final memberName = member.name.lexeme;
          if (memberName.startsWith('_')) continue;
          entry.kinds
              .putIfAbsent(memberName, () => <String>{})
              .add(
                member.isGetter
                    ? 'getter'
                    : (member.isSetter ? 'setter' : 'method'),
              );
        }
      }
    }
  }
  return out;
}

/// Every kind [member] is declared with on [className] or anywhere above it.
///
/// Empty when the name is not declared on the chain at all — which is not a
/// finding, only a name this comparison cannot speak about.
Set<String> _kindsOn(
  Map<String, _SdkClass> sdk,
  String className,
  String member,
) {
  final seen = <String>{};
  // SCD196: `Object` is every class's supertype and almost never written down.
  // `abstract interface class Match {` declares no `extends` and no
  // `implements`, so a walk that follows only written clauses stops there and
  // reports every inherited member as unspeakable — which is a PASS. That is
  // how `hashCode` registered as a method on `Match`, `Pattern` and `Sink`, and
  // `toString` registered as a getter on two isolate errors, survived
  // F-SCD189-1: the five members live on `Object` and the walk never arrived.
  final queue = <String>[className, 'Object'];
  final kinds = <String>{};
  while (queue.isNotEmpty) {
    final name = queue.removeLast();
    if (!seen.add(name)) continue;
    final entry = sdk[name];
    if (entry == null) continue;
    kinds.addAll(entry.kinds[member] ?? const <String>{});
    queue.addAll(entry.supertypes);
  }
  return kinds;
}

void main() {
  final sdk = _readSdk();

  final env = Environment();
  Stdlib(env).register();
  AsyncStdlib.register(env);
  CollectionStdlib.register(env);
  ConvertStdlib.register(env);
  IoStdlib.register(env);
  MathStdlib.register(env);
  TypedDataStdlib.register(env);

  var compared = 0;
  final mismatches = <String>[];
  for (final className in (sdk.keys.toList()..sort())) {
    final bridge = env.findBridgedClassByName(className);
    if (bridge == null) continue;
    void check(Iterable<String> names, String registeredAs) {
      for (final member in (names.toList()..sort())) {
        final declared = _kindsOn(sdk, className, member);
        if (declared.isEmpty) continue;
        compared++;
        if (declared.contains(registeredAs)) continue;
        final key = '$className.$member';
        if (_accepted.containsKey(key)) continue;
        mismatches.add(
          '  $key: registered as $registeredAs, '
          'the SDK declares ${(declared.toList()..sort()).join(' + ')}',
        );
      }
    }

    check(bridge.methods.keys, 'method');
    check(bridge.getters.keys, 'getter');
    check(bridge.setters.keys, 'setter');
  }

  test('F-SCD189-2 (control): the SDK was read and the registry populated '
      '[2026-09-15] (PASS)', () {
    // Ordered first in intent even though the id is second: every assertion
    // below is an emptiness check over this comparison, and a comparison that
    // ran over nothing satisfies all of them. Two ways to reach that state —
    // an unreadable SDK and an unregistered stdlib — and both look identical
    // from the result.
    expect(
      sdk.keys.length,
      greaterThanOrEqualTo(200),
      reason:
          'Read only ${sdk.keys.length} classes from the SDK at '
          '${_sdkLibRoot()}. That is not a finding about the bridges — the '
          'SDK walk did not run.',
    );
    expect(
      compared,
      greaterThanOrEqualTo(_minCompared),
      reason:
          'Compared only $compared members. The registry or the SDK read is '
          'empty, so F-SCD189-1 below is passing over nothing.',
    );
  });

  test('F-SCD189-1: no bridged member is registered under the wrong kind '
      '[2026-09-15] (PASS)', () {
    expect(
      mismatches,
      isEmpty,
      reason:
          'These members are registered as a kind the SDK does not '
          'declare:\n${mismatches.join('\n')}\n\n'
          'A getter among the methods resolves and hands back the bound '
          'callable instead of the value; a method among the setters makes the '
          'Dart spelling fail and an uncompilable one work. Both satisfy every '
          'reachability check in this repository, which is why this one exists '
          '— SCC73 found `Runes.iterator` registered as a method and nothing '
          'else had noticed.\n\n'
          'Move the adapter to the map that matches the SDK. If the divergence '
          'is deliberate, add it to _accepted with the reason — but read the '
          'SDK declaration first: all three findings this guard was written '
          'for looked deliberate and were not.',
    );
  });

  test('F-SCD189-3: the supertype walk is doing work [2026-09-15] (PASS)', () {
    // Anti-vacuity for the half that is easiest to get wrong and hardest to
    // notice. `List` declares only `set first`; its getter is on `Iterable`.
    // A comparison that looked at the declaring class alone would report
    // `List.first` as a mismatch, and a comparison whose walk silently found
    // nothing would report every inherited member as unspeakable and skip it —
    // which is a pass.
    expect(
      _kindsOn(sdk, 'List', 'first'),
      containsAll(<String>['getter', 'setter']),
      reason:
          'The walk from List must reach Iterable, or every inherited member '
          'is skipped and this file compares far less than it appears to.',
    );
    expect(
      sdk['List']?.kinds['first'] ?? const <String>{},
      isNot(contains('getter')),
      reason:
          'If List itself declares the getter, this case has stopped '
          'demonstrating that the walk is needed — pick another inherited '
          'member and say so here.',
    );
  });
}
