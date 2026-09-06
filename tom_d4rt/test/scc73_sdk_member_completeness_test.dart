// SCC73 — mechanical detection of bridged members the SDK declares and the
// bridge does not.
//
// THE DEFECT SHAPE
//
// SCB24 guards the axis one level up: every definition a registrar writes must
// actually reach `defineBridge`, so no whole class goes missing. SCB25's defect
// sat one level below that line and was therefore invisible to it. `JsonEncoder`
// WAS registered — the class-level guard would have been satisfied — yet
// `withIndent` was absent from its constructors and `indent` was not exposed at
// all, because the bridge declared `getters: {}`. A script could construct an
// indented encoder and then not ask what indent it had been built with.
//
// Nothing in the tree could notice a short member list, which is why that gap
// survived both a targeted audit and a release. This file is that missing
// notice.
//
// WHY TWO AXES WITH TWO DIFFERENT ORACLES
//
// The obvious implementation — diff the SDK's declared members against the
// bridge's `constructors` / `getters` key sets — is correct for one axis and
// badly wrong for the other. Measured on the first run, the naive diff reported
// 53 gaps of which roughly three quarters were false:
//
//   * CONSTRUCTORS are not inherited, and the interpreter resolves `C.n()` by
//     looking up `n` in the bridge registered under the name `C`. The declared
//     diff asks exactly that question, so it is sound. Every constructor this
//     file reports was confirmed to fail from a real script.
//
//   * GETTERS are not resolved that way at all. Reading `x.foo` off a native
//     value takes several paths through the interpreter depending on what the
//     value is, and none of them is "look in the bridge's getters map" alone.
//     `SplayTreeSet` declares `first`, the `SplayTreeSet` bridge does not
//     expose it, and `s.first` nevertheless returns 1. Fourteen of the
//     seventeen getters the map diff flagged were reachable from a script.
//
// So the getter axis stops modelling the lookup and performs it: it runs
// `<instance>.<getter>` as an actual script and reads the outcome. A member
// that is absent raises an undefined-member error and nothing else does — a
// getter that exists and throws on its own terms (`LinkedList().first` on an
// empty list) is correctly counted as present.
//
// WHY A GUARD RATHER THAN ANOTHER SWEEP
//
// The gap class had already been swept by hand once (SCB25, over dart:convert)
// and the sweep's own candidate list turned out to be mostly already satisfied
// while the real defects were two constructors it had not enumerated and one
// axis — getters — it had not considered. A hand sweep finds what its author
// thought to look for. This file enumerates from the SDK source, so it finds
// what is there.
//
// WHAT IS ASSERTED
//
// F-SCC73-1  every public constructor the SDK declares on a bridged class is
//            reachable, or is on the allowlist with a reason
// F-SCC73-2  every public instance getter the SDK declares on a bridged class
//            resolves through the interpreter's own lookup, or is allowlisted
// F-SCC73-3  no getter candidate is undecidable — a class with a candidate gap
//            and no canonical instance must be recorded, so the blind spot
//            cannot grow silently
// F-SCC73-4  the SDK source is actually being read; a zero-class parse would
//            make all three pass vacuously
//
// WHY THIS FILE HAS NO `tom_d4rt_ast` TWIN
//
// It reads the SDK source with the `analyzer` package. `tom_d4rt_ast` is
// analyzer-free by construction — that is the whole point of the package — so
// the guard cannot run there. The AST tree inherits the coverage through the
// mirror rule instead: its stdlib is a copy of this one, so a member this file
// forces into `tom_d4rt` arrives there with the mirror.

import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';
// The stdlib registrars are not part of the published surface, so they are
// reached by same-package path rather than by widening `d4rt.dart` for a
// test's convenience.
import 'package:tom_d4rt/src/stdlib/collection.dart';
import 'package:tom_d4rt/src/stdlib/convert.dart';
import 'package:tom_d4rt/src/stdlib/io.dart';

// ---------------------------------------------------------------------------
// The SDK side
// ---------------------------------------------------------------------------

/// The `dart:` libraries whose bridges this file guards.
const _libraries = <String>[
  'core',
  'async',
  'collection',
  'convert',
  'io',
  'math',
  'typed_data',
  'isolate',
];

/// `<sdk>/lib`, derived from the running VM rather than from an environment
/// variable, so the guard reads the SDK it is actually running against.
String _sdkLibRoot() =>
    '${File(Platform.resolvedExecutable).parent.parent.path}/lib';

/// `dart:<name>` to its source files: the library file plus every part it
/// pulls in.
///
/// `libraries.json` is the SDK's own map and is generated, so it stays correct
/// across SDK versions in a way a hardcoded path list would not. The `vm`
/// target reaches the real entries through an `include` chain, which is why
/// this resolves includes rather than reading one block.
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

CompilationUnit _parse(String path) => parseFile(
  path: path,
  featureSet: FeatureSet.latestLanguageVersion(),
  throwIfDiagnostics: false,
).unit;

/// The public surface of one SDK class, as declared on the class itself.
class _SdkClass {
  final constructors = <String>{};
  final getters = <String>{};
}

/// Every public class in `dart:<dartLibrary>`, with the constructors and
/// instance getters it declares.
///
/// GENERATIVE CONSTRUCTORS ON ABSTRACT CLASSES ARE SKIPPED, and that is a
/// property of the language rather than a convenience: a script cannot
/// instantiate an abstract class, and an interpreted subclass calling `super()`
/// against an abstract bridged base is already handled as a no-op (see
/// `BridgedClass.isAbstract`). A `factory` on an abstract class is a different
/// matter — `HashMap.identity()` is ordinary callable API — so factories are
/// kept whatever the class.
Map<String, _SdkClass> _sdkClasses(String libRoot, String dartLibrary) {
  final classes = <String, _SdkClass>{};
  for (final path in _sdkSourceFiles(libRoot, dartLibrary)) {
    for (final declaration in _parse(path).declarations) {
      if (declaration is! ClassDeclaration) continue;
      final className = declaration.name.lexeme;
      if (className.startsWith('_')) continue;
      final isAbstract = declaration.abstractKeyword != null;
      final entry = classes.putIfAbsent(className, _SdkClass.new);

      for (final member in declaration.members) {
        if (member is ConstructorDeclaration) {
          final name = member.name?.lexeme ?? '';
          if (name.startsWith('_')) continue;
          if (isAbstract && member.factoryKeyword == null) continue;
          entry.constructors.add(name);
        } else if (member is MethodDeclaration) {
          if (!member.isGetter || member.isStatic) continue;
          if (member.name.lexeme.startsWith('_')) continue;
          entry.getters.add(member.name.lexeme);
        } else if (member is FieldDeclaration) {
          // A public instance field is a getter as far as a script can tell.
          if (member.isStatic) continue;
          for (final variable in member.fields.variables) {
            if (variable.name.lexeme.startsWith('_')) continue;
            entry.getters.add(variable.name.lexeme);
          }
        }
      }
    }
  }
  return classes;
}

// ---------------------------------------------------------------------------
// The bridge side
// ---------------------------------------------------------------------------

/// The same registration a script gets.
Environment _stdlibEnvironment() {
  final env = Environment();
  Stdlib(env).register();
  CollectionStdlib.register(env);
  ConvertStdlib.register(env);
  IoStdlib.register(env);
  return env;
}

/// Every bridge registered under each name. A name can carry more than one
/// definition, so members must be unioned across the list rather than read off
/// whichever one happens to be last.
Map<String, List<BridgedClass>> _bridgesByName(Environment env) {
  final all = <String, List<BridgedClass>>{};
  for (final name in env.bridgedClassNames) {
    for (final bridge in env.findAllBridgedClassesByName(name)) {
      (all[bridge.name] ??= <BridgedClass>[]).add(bridge);
    }
  }
  return all;
}

/// A script EXPRESSION yielding an instance of the named class, so the getter
/// axis can read a member off a real value the way a script would.
///
/// Only classes that actually reach the getter check need an entry — F-SCC73-3
/// fails on any candidate left undecidable, so a missing entry surfaces as a
/// test failure rather than as silence.
///
/// The expressions deliberately produce NON-EMPTY containers where they can.
/// An empty one still answers the presence question — `first` raises a
/// `StateError`, not an undefined-member error — but a populated one keeps the
/// probe's own output readable when a member does resolve.
const _instanceExpressions = <String, String>{
  'Runes': "'ab'.runes",
  'StreamController': 'StreamController()',
  'StreamView': 'StreamView(StreamController().stream)',
  'SplayTreeSet': '(SplayTreeSet()..add(1))',
  'SplayTreeMap': '(SplayTreeMap()..[1] = 2)',
  'DoubleLinkedQueue': '(DoubleLinkedQueue()..add(1))',
  'ListQueue': '(ListQueue()..add(1))',
  'LinkedList': 'LinkedList()',
  'Stdin': 'stdin',
  'Stdout': 'stdout',
  'HashMap': '(HashMap()..[1] = 2)',
  'HashSet': '(HashSet()..add(1))',
  'LinkedHashMap': '(LinkedHashMap()..[1] = 2)',
  'LinkedHashSet': '(LinkedHashSet()..add(1))',
  'Queue': '(Queue()..add(1))',
};

/// Read every candidate member off a real instance, in ONE interpreted run.
///
/// A run costs a parse plus a full stdlib registration, so one run per member
/// took thirty seconds and timed out the test. Batching makes the whole axis a
/// single execution; the per-member `try` inside the script keeps the results
/// individually attributable.
///
/// Returns `Class.member` to a description of the failure, for the members that
/// did not resolve. A member that resolves and then throws on its own terms —
/// `LinkedList().first` on an empty list raises a `StateError` — is present,
/// and is deliberately not reported.
Future<Map<String, String>> _probeGetters(
  Map<String, Set<String>> candidatesByClass,
) async {
  final probes = StringBuffer();
  for (final entry in candidatesByClass.entries) {
    final expression = _instanceExpressions[entry.key]!;
    for (final member in entry.value) {
      final key = '${entry.key}.$member';
      probes.writeln('  try {');
      probes.writeln('    final v = $expression.$member;');
      probes.writeln("    out.add('$key|ok|' + v.runtimeType.toString());");
      probes.writeln('  } catch (e) {');
      probes.writeln("    out.add('$key|err|' + e.toString());");
      probes.writeln('  }');
    }
  }

  const path = 'd4rt-mem:/scc73_getter_probe.dart';
  final d4rt = D4rt();
  // `dart:io` is permissioned, and `stdin` / `stdout` are two of the probes.
  d4rt.grant(FilesystemPermission.any);
  final raw =
      await d4rt.execute(
            library: path,
            name: 'main',
            sources: {
              path:
                  "import 'dart:async';\n"
                  "import 'dart:collection';\n"
                  "import 'dart:convert';\n"
                  "import 'dart:io';\n"
                  'Future<Object?> main() async {\n'
                  '  final out = <String>[];\n'
                  '$probes'
                  '  return out;\n'
                  '}\n',
            },
          )
          as List<Object?>;

  final failures = <String, String>{};
  for (final line in raw.cast<String>()) {
    final parts = line.split('|');
    final key = parts[0];
    final outcome = parts[1];
    final detail = parts.sublist(2).join('|');
    if (outcome == 'err') {
      // Only "no such member" is this file's subject.
      if (detail.contains('Undefined property or method')) {
        failures[key] = 'unreachable — $detail';
      }
      continue;
    }
    // A member registered as a METHOD rather than a getter still resolves,
    // but reading it hands back the callable instead of the value — so
    // `x.iterator.moveNext()` fails on a value that looked fine. Inside the
    // interpreter a bound bridge method reports its `runtimeType` as
    // `Function`, which is the only signal available here. A getter whose
    // value is genuinely a function would look the same; none currently is,
    // and one that appears belongs in `_allowed` with that as its reason.
    if (detail == 'Function') {
      failures[key] =
          'resolves to a Function — the SDK declares a GETTER but the bridge '
          'registers a method, so reading it yields the callable, not the '
          'value';
    }
  }
  return failures;
}

// ---------------------------------------------------------------------------
// Deliberate omissions
// ---------------------------------------------------------------------------

/// `Class.member` to the reason it is deliberately not bridged.
///
/// An entry here is a decision on the record. Silence is not — which is the
/// whole reason the guard aggregates rather than allowing a short list to pass.
const _allowed = <String, String>{};

void main() {
  final libRoot = _sdkLibRoot();
  final sdk = <String, Map<String, _SdkClass>>{
    for (final library in _libraries) library: _sdkClasses(libRoot, library),
  };
  final env = _stdlibEnvironment();
  final bridges = _bridgesByName(env);

  test('F-SCC73-4: the SDK source is being read [2026-09-06]', () {
    for (final entry in sdk.entries) {
      expect(
        entry.value,
        isNotEmpty,
        reason:
            'dart:${entry.key} parsed to zero classes — the guard would pass '
            'vacuously. Check $libRoot/libraries.json.',
      );
    }
  });

  test('F-SCC73-1: every SDK constructor on a bridged class is reachable '
      '[2026-09-06]', () {
    final missing = <String>[];
    for (final library in _libraries) {
      for (final entry in sdk[library]!.entries) {
        final defs = bridges[entry.key];
        if (defs == null) continue;
        // The interpreter accepts a constructor adapter or a static member
        // under the same name, so both count as reachable.
        final reachable = <String>{
          for (final d in defs) ...d.constructors.keys,
          for (final d in defs) ...d.staticMethods.keys,
          for (final d in defs) ...d.staticGetters.keys,
        };
        for (final name in entry.value.constructors) {
          if (reachable.contains(name)) continue;
          final shown = name.isEmpty ? '<unnamed>' : name;
          final key = '${entry.key}.$shown';
          if (_allowed.containsKey(key)) continue;
          missing.add('dart:$library  $key');
        }
      }
    }
    expect(
      missing..sort(),
      isEmpty,
      reason:
          'These constructors are declared by the SDK on a class this package '
          'bridges, and no script can call them. Bridge them, or add a '
          '`Class.member` entry to `_allowed` with the reason.',
    );
  });

  test('F-SCC73-2: every SDK instance getter on a bridged class resolves '
      '[2026-09-06]', () async {
    final undecidable = <String>[];
    final candidates = <String, Set<String>>{};
    final libraryOf = <String, String>{};
    for (final library in _libraries) {
      for (final entry in sdk[library]!.entries) {
        final defs = bridges[entry.key];
        if (defs == null) continue;
        final declared = <String>{for (final d in defs) ...d.getters.keys};
        for (final name in entry.value.getters) {
          // Present on the bridge itself: reachable, no script needed.
          if (declared.contains(name)) continue;
          final key = '${entry.key}.$name';
          if (_allowed.containsKey(key)) continue;

          // Absent from this bridge is NOT the same as unreachable — the
          // interpreter has several paths to a native member. Ask it.
          if (!_instanceExpressions.containsKey(entry.key)) {
            undecidable.add('dart:$library  $key');
            continue;
          }
          (candidates[entry.key] ??= <String>{}).add(name);
          libraryOf[key] = library;
        }
      }
    }

    final missing = [
      for (final failure in (await _probeGetters(candidates)).entries)
        'dart:${libraryOf[failure.key]}  ${failure.key}  (${failure.value})',
    ];
    expect(
      missing..sort(),
      isEmpty,
      reason:
          'These getters are declared by the SDK on a class this package '
          'bridges, and the bridge that claims such a value does not expose '
          'them. Add them, or record the omission in `_allowed`.',
    );
    expect(
      undecidable..sort(),
      isEmpty,
      reason:
          'F-SCC73-3: no canonical instance for these classes, so the guard '
          'cannot tell a real gap from an inherited one. Add an entry to '
          '`_canonicalInstances`, or record the omission in `_allowed`.',
    );
  });
}
