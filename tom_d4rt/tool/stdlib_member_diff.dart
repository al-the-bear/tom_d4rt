// Mechanical member-level gap audit for the `dart:*` stdlib bridges.
//
// The gap audit in `doc/stdlib_sdk_gap_audit.md` used to claim that member-level
// coverage on the core types was "strong" on the strength of hand spot-checks.
// A spot-check can only ever confirm the members someone thought to try, so it
// cannot support a claim about the members nobody tried — this tool replaces it
// with an exhaustive diff.
//
// Two sources of truth, deliberately chosen:
//
//   * Bridged surface — read from a **live** `Environment` after running every
//     `*Stdlib.register()`, via the public `bridgedClassNames` /
//     `findBridgedClassByName` API. Reading the registry rather than parsing the
//     bridge sources means lazily-built and aliased registrations are counted
//     exactly as a script would see them, and it answers the audit's real
//     question: what can a script actually reach?
//
//   * SDK surface — `dart:mirrors` over `BridgedClass.nativeType`. The bridge
//     hands us the `Type` object directly, so there is no name-resolution step
//     that could silently pick the wrong class.
//
// A note on why the SDK side walks `declarations` transitively rather than using
// the far more convenient `ClassMirror.instanceMembers`: **`instanceMembers`
// omits abstract members.** Most of the high-traffic `dart:core` types are
// abstract interfaces, so it under-reports them catastrophically — measured on
// Dart 3.12, `Uri` yields 6 members via `instanceMembers` against 50 via
// `declarations`, and `Map` yields 5 against 32. Since those are precisely the
// types whose coverage this audit is about, using `instanceMembers` would have
// produced a confidently wrong "no gaps here" for them. Instead the hierarchy
// (superclass chain + superinterfaces, which is how `Float32List` reaches its
// `List` members) is walked explicitly and members are classified from the
// mirror's own `isStatic` / `isConstructor` flags.
//
// The diff alone is only a *candidate* generator, and it over-reports badly. An
// adapter map is not the interpreter's whole lookup path: instance lookups fall
// back through the supertype chain, so `Uint8List.sort` resolves via the `List`
// bridge even though `sort` appears in no typed-list adapter map. Measured, that
// accounts for ~150 of the raw candidates. Static members are *not* inherited, so
// they do not get that fallback.
//
// The fallback is also not uniform — `Uint8List.sort` resolves but
// `HashSet.difference` does not, despite `HashSet` being a `Set` — so it cannot
// be predicted by reimplementing the rule either. Any static approximation of it
// would be wrong in one direction or the other.
//
// So phase 2 asks the only authority that can actually answer: it drives each
// candidate through the interpreter and classifies the outcome by the
// interpreter's own "no such member" wording. Members whose lookup succeeds
// (including ones that then fail on arguments, or throw `UnsupportedError`) are
// reachable and are dropped. Only CONFIRMED-unreachable members are reported as
// gaps, and classes with no instance recipe are reported as UNVERIFIED rather
// than silently counted either way.
//
// Run: dart run tool/stdlib_member_diff.dart [--json out.json] [--no-verify]

import 'dart:convert';
import 'dart:io';
import 'dart:mirrors';

import 'package:tom_d4rt/d4rt.dart' show D4rt, FilesystemPermission;
import 'package:tom_d4rt/src/bridge/bridged_types.dart';
import 'package:tom_d4rt/src/stdlib/core.dart';
import 'package:tom_d4rt/src/stdlib/async.dart';
import 'package:tom_d4rt/src/stdlib/collection.dart';
import 'package:tom_d4rt/src/stdlib/convert.dart';
import 'package:tom_d4rt/src/stdlib/io.dart';
import 'package:tom_d4rt/src/stdlib/isolate.dart';
import 'package:tom_d4rt/src/stdlib/math.dart';
import 'package:tom_d4rt/src/stdlib/typed_data.dart';

/// Members every Dart object carries. A bridge that omits them is not thereby
/// broken — the interpreter resolves them intrinsically — so they are counted
/// separately rather than inflating every class's gap count.
const _universalObjectMembers = <String>{
  'hashCode',
  'runtimeType',
  'toString',
  'noSuchMethod',
  '==',
};

/// The report for one bridged class.
class ClassDiff {
  ClassDiff(this.name, this.nativeTypeName);

  final String name;
  final String nativeTypeName;

  /// After [verify], these hold only members confirmed unreachable through the
  /// interpreter. Before it, they are unverified candidates.
  final missingInstance = <String>[];
  final missingStatic = <String>[];
  final missingOperators = <String>[];
  final missingUniversal = <String>[];

  /// Candidates the interpreter could in fact resolve — absent from this class's
  /// adapter maps but reachable anyway, almost always via the supertype chain.
  /// Kept in the report because their size is the evidence that a raw map diff
  /// must not be published as a gap count.
  final reachableViaFallback = <String>[];

  /// Candidates left untested for want of an instance recipe. Reported honestly
  /// rather than folded into either bucket.
  final unverifiedInstance = <String>[];
  final unverifiedStatic = <String>[];

  /// Adapter keys with no matching SDK member. Mostly extension members that
  /// mirrors cannot see (`firstOrNull` and friends live on `IterableExtensions`,
  /// not on `Iterable`), so this is informational, not a defect list.
  final extraBridged = <String>[];

  bool verified = false;

  /// Whether this class's instance recipe produced a usable instance. False
  /// means the instance candidates are UNVERIFIED, not gaps.
  bool recipeUsable = false;
  int bridgedCount = 0;
  int sdkCount = 0;
  String? error;

  /// Operators are excluded: the interpreter routes most of them through its own
  /// evaluation path rather than the adapter maps, so a "missing" operator here
  /// is not reliable evidence of a gap.
  int get gapCount => missingInstance.length + missingStatic.length;

  int get unverifiedCount =>
      unverifiedInstance.length + unverifiedStatic.length;

  Map<String, dynamic> toJson() => {
        'name': name,
        'nativeType': nativeTypeName,
        'verified': verified,
        'recipeUsable': recipeUsable,
        'gapCount': gapCount,
        'bridgedCount': bridgedCount,
        'sdkCount': sdkCount,
        'missingInstance': missingInstance,
        'missingStatic': missingStatic,
        'reachableViaFallback': reachableViaFallback,
        'unverifiedInstance': unverifiedInstance,
        'unverifiedStatic': unverifiedStatic,
        'missingOperators': missingOperators,
        'missingUniversal': missingUniversal,
        'extraBridged': extraBridged,
        if (error != null) 'error': error,
      };
}

/// Registers every stdlib module into one environment.
///
/// `Stdlib.register()` only wires core + async + typed_data eagerly; the rest
/// load on import. The audit asks what is reachable *given the right import*, so
/// all of them are registered here.
Environment buildFullyRegisteredEnvironment() {
  final env = Environment();
  CoreStdlib.register(env);
  AsyncStdlib.register(env);
  TypedDataStdlib.register(env);
  CollectionStdlib.register(env);
  ConvertStdlib.register(env);
  MathStdlib.register(env);
  IsolateStdlib.register(env);
  IoStdlib.register(env);
  return env;
}

String _symbolName(Symbol s) => MirrorSystem.getName(s);

bool _isPublic(String n) => !n.startsWith('_');

bool _isOperator(String n) =>
    n.isNotEmpty && !RegExp(r'^[A-Za-z_$]').hasMatch(n);

/// Mirrors keys setters as `foo=`; the adapter maps key them as `foo`.
String _normalizeSetter(String name) =>
    name.endsWith('=') && !_isOperator(name)
        ? name.substring(0, name.length - 1)
        : name;

/// The set of member names a script may reach on the native [type], with
/// instance and static members kept apart.
///
/// Statics are collected from the entry class only — unlike instance members,
/// statics are not inherited in Dart, so walking the hierarchy for them would
/// invent members that no script can actually call.
({Set<String> instance, Set<String> statics})? _sdkSurface(Type type) {
  final ClassMirror root;
  try {
    final t = reflectType(type);
    if (t is! ClassMirror) return null;
    root = t;
  } catch (_) {
    return null;
  }

  final instance = <String>{};
  final statics = <String>{};

  final seen = <ClassMirror>{};
  final queue = <ClassMirror>[root];

  while (queue.isNotEmpty) {
    final cm = queue.removeAt(0);
    if (!seen.add(cm)) continue;
    final isRoot = identical(cm, root);

    Map<Symbol, DeclarationMirror> declarations;
    try {
      declarations = cm.declarations;
    } catch (_) {
      // Partly-reflectable SDK class — keep whatever the rest of the walk finds.
      continue;
    }

    for (final entry in declarations.entries) {
      final raw = _symbolName(entry.key);
      final decl = entry.value;
      if (!_isPublic(raw)) continue;

      if (decl is MethodMirror) {
        if (decl.isConstructor) continue;
        final name = _normalizeSetter(raw);
        if (decl.isStatic) {
          if (isRoot) statics.add(name);
        } else {
          instance.add(name);
        }
      } else if (decl is VariableMirror) {
        // A field is reachable as a getter (and a setter when not final).
        if (decl.isStatic) {
          if (isRoot) statics.add(raw);
        } else {
          instance.add(raw);
        }
      }
    }

    try {
      final sup = cm.superclass;
      if (sup != null && sup.reflectedType != Object) queue.add(sup);
      queue.addAll(cm.superinterfaces);
    } catch (_) {
      // ignore — hierarchy walk is best-effort
    }
  }

  return (instance: instance, statics: statics);
}

ClassDiff diffClass(String name, BridgedClass bc) {
  final diff = ClassDiff(name, bc.nativeType.toString());

  final bridgedInstance = <String>{
    ...bc.methods.keys,
    ...bc.getters.keys,
    ...bc.setters.keys,
  };
  final bridgedStatic = <String>{
    ...bc.staticMethods.keys,
    ...bc.staticGetters.keys,
    ...bc.staticSetters.keys,
  };
  diff.bridgedCount = bridgedInstance.length + bridgedStatic.length;

  final sdk = _sdkSurface(bc.nativeType);
  if (sdk == null) {
    diff.error = 'not reflectable as a ClassMirror';
    return diff;
  }
  diff.sdkCount = sdk.instance.length + sdk.statics.length;

  for (final m in sdk.instance) {
    if (bridgedInstance.contains(m)) continue;
    if (_universalObjectMembers.contains(m)) {
      diff.missingUniversal.add(m);
    } else if (_isOperator(m)) {
      diff.missingOperators.add(m);
    } else {
      diff.missingInstance.add(m);
    }
  }

  for (final m in sdk.statics) {
    // Constructors surface as static members on some mirrors; they are tracked
    // by the `constructors` map, not the static adapter maps.
    if (bridgedStatic.contains(m)) continue;
    if (bc.constructors.containsKey(m)) continue;
    if (_isOperator(m)) {
      diff.missingOperators.add(m);
    } else {
      diff.missingStatic.add(m);
    }
  }

  for (final m in bridgedInstance) {
    if (!sdk.instance.contains(m) && !_universalObjectMembers.contains(m)) {
      diff.extraBridged.add(m);
    }
  }

  diff.missingInstance.sort();
  diff.missingStatic.sort();
  diff.missingOperators.sort();
  diff.missingUniversal.sort();
  diff.extraBridged.sort();
  return diff;
}

// =============================================================================
// Phase 2 — verification against the interpreter
// =============================================================================

/// How to obtain an instance of a bridged class from interpreted code.
///
/// Needed because an instance-member probe has to have something to read the
/// member off. Classes absent from this table are reported as UNVERIFIED, never
/// as gaps — the `dart:io` sockets and servers are deliberately left out rather
/// than have the audit open listening ports.
const _instanceRecipes = <String, (String imports, String expr)>{
  'String': ('', "'abc'"),
  'UriData': ('', "UriData.parse('data:text/plain;charset=utf-8,x')"),
  'Uri': ('', "Uri.parse('https://example.dev/a?b=c')"),
  'Duration': ('', 'Duration(seconds: 1)'),
  'ByteData': ("import 'dart:typed_data';", 'ByteData(8)'),
  'ByteBuffer': ("import 'dart:typed_data';", 'Uint8List(8).buffer'),
  'Uint8List': ("import 'dart:typed_data';", 'Uint8List.fromList([1, 2, 3])'),
  'Uint8ClampedList': (
    "import 'dart:typed_data';",
    'Uint8ClampedList.fromList([1, 2, 3])'
  ),
  'Uint16List': ("import 'dart:typed_data';", 'Uint16List.fromList([1, 2])'),
  'Uint32List': ("import 'dart:typed_data';", 'Uint32List.fromList([1, 2])'),
  'Uint64List': ("import 'dart:typed_data';", 'Uint64List.fromList([1, 2])'),
  'Int8List': ("import 'dart:typed_data';", 'Int8List.fromList([1, 2])'),
  'Int16List': ("import 'dart:typed_data';", 'Int16List.fromList([1, 2])'),
  'Int32List': ("import 'dart:typed_data';", 'Int32List.fromList([1, 2])'),
  'Int64List': ("import 'dart:typed_data';", 'Int64List.fromList([1, 2])'),
  'Float32List': (
    "import 'dart:typed_data';",
    'Float32List.fromList([1.0, 2.0])'
  ),
  'Float64List': (
    "import 'dart:typed_data';",
    'Float64List.fromList([1.0, 2.0])'
  ),
  'Queue': ("import 'dart:collection';", 'Queue<int>()..add(1)'),
  'ListQueue': ("import 'dart:collection';", 'ListQueue<int>()..add(1)'),
  'DoubleLinkedQueue': (
    "import 'dart:collection';",
    'DoubleLinkedQueue<int>()..add(1)'
  ),
  'HashSet': ("import 'dart:collection';", 'HashSet<int>()..add(1)'),
  'LinkedHashSet': (
    "import 'dart:collection';",
    'LinkedHashSet<int>()..add(1)'
  ),
  'SplayTreeSet': ("import 'dart:collection';", 'SplayTreeSet<int>()..add(1)'),
  'SplayTreeMap': ("import 'dart:collection';", 'SplayTreeMap<int, int>()'),
  'HashMap': ("import 'dart:collection';", 'HashMap<int, int>()'),
  'LinkedHashMap': ("import 'dart:collection';", 'LinkedHashMap<int, int>()'),
  'UnmodifiableListView': (
    "import 'dart:collection';",
    'UnmodifiableListView<int>([1, 2])'
  ),
  'LinkedList': ("import 'dart:collection';", 'LinkedList()'),
  'StreamController': ("import 'dart:async';", 'StreamController<int>()'),
  'StreamView': (
    "import 'dart:async';",
    'StreamView<int>(Stream<int>.fromIterable([1]))'
  ),
  'StreamSubscription': (
    "import 'dart:async';",
    'Stream<int>.fromIterable([1]).listen((e) {})'
  ),
  'Utf8Codec': ("import 'dart:convert';", 'utf8'),
  'AsciiCodec': ("import 'dart:convert';", 'ascii'),
  'Latin1Codec': ("import 'dart:convert';", 'latin1'),
  'Encoding': ("import 'dart:convert';", 'utf8'),
  'JsonEncoder': ("import 'dart:convert';", 'JsonEncoder()'),
  'JsonDecoder': ("import 'dart:convert';", 'JsonDecoder()'),
  'Converter': ("import 'dart:convert';", 'JsonEncoder()'),
  'HtmlEscape': ("import 'dart:convert';", 'HtmlEscape()'),
  'HtmlEscapeMode': ("import 'dart:convert';", 'HtmlEscapeMode.element'),
  'LineSplitter': ("import 'dart:convert';", 'LineSplitter()'),
  'ProcessSignal': ("import 'dart:io';", 'ProcessSignal.sigint'),
  'InternetAddressType': ("import 'dart:io';", 'InternetAddressType.IPv4'),
  'FileSystemEntityType': ("import 'dart:io';", 'FileSystemEntityType.file'),
  'StdioType': ("import 'dart:io';", 'StdioType.terminal'),
  'ProcessStartMode': ("import 'dart:io';", 'ProcessStartMode.normal'),
};

/// Whether the interpreter said the member does not exist, as opposed to failing
/// for any other reason.
///
/// The distinction is the whole point of the verification pass: an argument-count
/// `TypeError` or an `UnsupportedError` from a fixed-length list both mean the
/// member *resolved*, so the candidate is a false positive.
bool _isUnreachableError(String message) =>
    message.contains('has no instance method named') ||
    message.contains('Undefined static member') ||
    message.contains('has no constructor or static method named') ||
    message.contains('has no getter named') ||
    message.contains('Undefined property or method');

enum Reach { confirmedMissing, reachable, unverified }

Reach _probe(String source) {
  final interpreter = D4rt()..setDebug(false);
  interpreter.grant(FilesystemPermission.any);
  try {
    interpreter.execute(
      library: 'package:audit/main.dart',
      sources: {'package:audit/main.dart': source},
    );
    return Reach.reachable;
  } catch (e) {
    return _isUnreachableError(e.toString())
        ? Reach.confirmedMissing
        : Reach.reachable;
  }
}

/// Whether the recipe for [className] actually yields an instance.
///
/// This check is load-bearing, not defensive. Several recipes are themselves
/// static member reads (`HtmlEscapeMode.element`, `StdioType.terminal`), and a
/// *missing* static fails with the very "Undefined static member" wording that
/// [_isUnreachableError] looks for — so an unusable recipe would silently
/// "confirm" every instance candidate on that class. Measured: this is exactly
/// what happened to `HtmlEscapeMode`'s four instance candidates before the check
/// existed. Classes whose recipe does not work are reported UNVERIFIED.
bool recipeWorks(String className) {
  final recipe = _instanceRecipes[className];
  if (recipe == null) return false;
  final (imports, expr) = recipe;
  return _probe('$imports main() { final o = $expr; return 1; }') ==
      Reach.reachable;
}

/// Reads [member] off an instance, without calling it — a bare read is enough to
/// make the interpreter perform the lookup, and it avoids having to know each
/// member's signature.
Reach verifyInstanceMember(String className, String member) {
  final recipe = _instanceRecipes[className];
  if (recipe == null) return Reach.unverified;
  final (imports, expr) = recipe;
  return _probe('$imports main() { final o = $expr; return o.$member; }');
}

Reach verifyStaticMember(String className, String member) {
  // Statics need no instance, so every class can be verified. The import is
  // whatever the instance recipe used, when there is one.
  final imports = _instanceRecipes[className]?.$1 ?? '';
  return _probe('$imports main() { return $className.$member; }');
}

void verify(ClassDiff diff) {
  final canProbeInstances = recipeWorks(diff.name);
  diff.recipeUsable = canProbeInstances;

  final confirmedInstance = <String>[];
  for (final m in diff.missingInstance) {
    final reach = canProbeInstances
        ? verifyInstanceMember(diff.name, m)
        : Reach.unverified;
    switch (reach) {
      case Reach.confirmedMissing:
        confirmedInstance.add(m);
      case Reach.reachable:
        diff.reachableViaFallback.add(m);
      case Reach.unverified:
        diff.unverifiedInstance.add(m);
    }
  }
  diff.missingInstance
    ..clear()
    ..addAll(confirmedInstance);

  final confirmedStatic = <String>[];
  for (final m in diff.missingStatic) {
    switch (verifyStaticMember(diff.name, m)) {
      case Reach.confirmedMissing:
        confirmedStatic.add(m);
      case Reach.reachable:
        diff.reachableViaFallback.add(m);
      case Reach.unverified:
        diff.unverifiedStatic.add(m);
    }
  }
  diff.missingStatic
    ..clear()
    ..addAll(confirmedStatic);

  diff.verified = true;
}

void main(List<String> args) {
  final env = buildFullyRegisteredEnvironment();
  final names = env.bridgedClassNames..sort();

  final diffs = <ClassDiff>[];
  for (final name in names) {
    final bc = env.findBridgedClassByName(name);
    if (bc == null) continue;
    diffs.add(diffClass(name, bc));
  }

  final rawCandidates = diffs.fold<int>(
      0, (s, d) => s + d.missingInstance.length + d.missingStatic.length);

  if (!args.contains('--no-verify')) {
    stderr.writeln('Verifying $rawCandidates candidates against the '
        'interpreter (this takes a minute)...');
    for (final d in diffs) {
      verify(d);
    }
  }

  diffs.sort((a, b) {
    final byGap = b.gapCount.compareTo(a.gapCount);
    return byGap != 0 ? byGap : a.name.compareTo(b.name);
  });

  final totalGaps = diffs.fold<int>(0, (s, d) => s + d.gapCount);
  final withGaps = diffs.where((d) => d.gapCount > 0).length;
  final fallback = diffs.fold<int>(0, (s, d) => s + d.reachableViaFallback.length);
  final unverified = diffs.fold<int>(0, (s, d) => s + d.unverifiedCount);

  stdout.writeln('Bridged classes examined:            ${diffs.length}');
  stdout.writeln('Raw candidates from the map diff:    $rawCandidates');
  stdout.writeln('  ... reachable anyway (fallback):   $fallback');
  stdout.writeln('  ... unverified (no instance recipe): $unverified');
  stdout.writeln('CONFIRMED unreachable members:       $totalGaps');
  stdout.writeln('Classes with >=1 confirmed gap:      $withGaps');
  stdout.writeln('');
  stdout.writeln('| Class | Native type | Confirmed | Instance | Static | Unverified |');
  stdout.writeln('| --- | --- | --- | --- | --- | --- |');
  for (final d in diffs) {
    if (d.gapCount == 0 && d.error == null) continue;
    stdout.writeln('| ${d.name} | ${d.nativeTypeName} | ${d.gapCount} '
        '| ${d.missingInstance.length} | ${d.missingStatic.length} '
        '| ${d.unverifiedCount} |${d.error == null ? '' : ' ${d.error}'}');
  }

  final jsonIndex = args.indexOf('--json');
  if (jsonIndex >= 0 && jsonIndex + 1 < args.length) {
    final out = File(args[jsonIndex + 1]);
    out.parent.createSync(recursive: true);
    out.writeAsStringSync(
        const JsonEncoder.withIndent('  ').convert(diffs.map((d) => d.toJson()).toList()));
    stdout.writeln('\nJSON written to ${out.path}');
  }
}
