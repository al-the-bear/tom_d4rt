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
// A second, independent audit shares this tool's environment and mirror walk:
// `--hierarchy` answers SCB19's question instead of the member-gap one. Where
// the member diff asks "which members of this class can no script reach?", the
// hierarchy audit asks "which of this class's BRIDGED supertypes has nobody
// declared to the registry?" — the SC7 defect, where `ListQueue` shipped
// without a `-> Iterable` edge and lost its whole inherited surface, `.contains`
// included. That failure is invisible to the member diff whenever the class has
// no instance recipe, and it is a single missing line rather than N missing
// adapters, so it is worth asking directly.
//
// Both live here rather than in two tools because they need the same fully
// registered environment and the same mirror hierarchy walk, and because the
// question a maintainer actually has is "audit the stdlib bridges", not one of
// the two halves.
//
// Run: dart run tool/stdlib_member_diff.dart [--json out.json] [--no-verify]
//      dart run tool/stdlib_member_diff.dart --hierarchy [--json out.json]

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
  final unverifiedOperators = <String>[];
  final unverifiedUniversal = <String>[];

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

  /// Every column that survives verification counts, operators and universal
  /// Object members included. Excluding them — on the reasoning that the
  /// interpreter routes operators through its own evaluation path, so a
  /// map-diff "miss" proves nothing — meant no published number ever moved when
  /// one of those columns held a real defect. It cost `bool`'s missing
  /// `& | ^`. Verification is what separates a candidate from a gap; once a
  /// column goes through it, there is no reason left to discount it.
  int get gapCount =>
      missingInstance.length +
      missingStatic.length +
      missingOperators.length +
      missingUniversal.length;

  int get unverifiedCount =>
      unverifiedInstance.length +
      unverifiedStatic.length +
      unverifiedOperators.length +
      unverifiedUniversal.length;

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
        'unverifiedOperators': unverifiedOperators,
        'unverifiedUniversal': unverifiedUniversal,
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

/// Whether [decl] carries `@Deprecated` (or the bare `@deprecated`).
///
/// Deprecated SDK members are not gaps. `FileSystemEntityType.NOT_FOUND` is the
/// case that prompted this: it is a screaming-caps alias kept for compatibility
/// with a naming convention the SDK abandoned, and bridging it would carry that
/// spelling into D4rt scripts forever. Detected from the annotation rather than
/// name-listed, so the next alias the SDK retires drops out on its own instead
/// of arriving as a fresh phantom gap.
bool _isDeprecated(DeclarationMirror decl) {
  try {
    return decl.metadata.any((m) => m.reflectee is Deprecated);
  } catch (_) {
    // Some SDK declarations throw on metadata access; treat as not annotated.
    return false;
  }
}

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
      if (_isDeprecated(decl)) continue;

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

  // A bridge whose nativeType is `Function` is not a class bridge at all: it is
  // how a bridged *top-level function* is registered (`unawaited` is the one in
  // the stdlib). Diffing it against the `Function` class surface reports
  // `apply` as missing, which is not a gap in anything — nobody calls
  // `unawaited.apply`. Reported as a kind rather than skipped silently, so the
  // row stays visible and countable without inflating the gap total.
  if (bc.nativeType == Function) {
    diff.error = 'bridged top-level function — no class surface to diff';
    return diff;
  }

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
  // The primitives had no recipe at all, which is why the operator column was
  // UNVERIFIED for precisely the classes whose operators matter most — `bool`'s
  // missing `& | ^` sat in an unverified bucket on an unverified column. A
  // literal is the whole recipe; there was never a reason to leave them out
  // beyond nobody needing an instance probe for them before operators were
  // verified.
  'bool': ('', 'true'),
  'int': ('', '1'),
  'double': ('', '1.5'),
  'num': ('', '2'),
  'BigInt': ('', 'BigInt.from(6)'),
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
    message.contains('Undefined property or method') ||
    // Operator dispatch has its own wording and does not mention a "member" at
    // all. Without these two the operator column would be verified and then
    // misclassified wholesale as reachable — which is how `bool & | ^` stayed
    // invisible: the column was never verified AND could not have been.
    message.contains('Unsupported binary operator') ||
    message.contains('Compound assignment operator');

/// How to exercise an operator from interpreted code.
///
/// An operator cannot be probed the way a named member can — `o.+` is not an
/// expression, so the bare-read trick that covers every other column does not
/// apply. Each entry applies the operator to the recipe instance `o`, using a
/// second `o` as the right operand where the operator is symmetric and a literal
/// where the SDK fixes the right-hand type (shifts take an int, index takes a
/// key).
///
/// The self-operand shortcut costs precision: on `String`, `o * o` is
/// `'a' * 'a'`, a type error rather than a resolution failure, so it classifies
/// as *reachable* even if `'a' * 2` were broken. That is the conservative
/// direction — the column may under-report, but it will not invent gaps.
const _operatorProbes = <String, String>{
  '+': 'o + o',
  '-': 'o - o',
  '*': 'o * o',
  '/': 'o / o',
  '~/': 'o ~/ o',
  '%': 'o % o',
  '&': 'o & o',
  '|': 'o | o',
  '^': 'o ^ o',
  '<': 'o < o',
  '<=': 'o <= o',
  '>': 'o > o',
  '>=': 'o >= o',
  '==': 'o == o',
  '<<': 'o << 1',
  '>>': 'o >> 1',
  '>>>': 'o >>> 1',
  '~': '~o',
  'unary-': '-o',
  '[]': 'o[0]',
  '[]=': 'o[0] = o',
};

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

/// Applies [op] to a recipe instance. UNVERIFIED when there is no recipe for the
/// class or no probe template for the operator, never a gap.
Reach verifyOperator(String className, String op) {
  final recipe = _instanceRecipes[className];
  final probe = _operatorProbes[op];
  if (recipe == null || probe == null) return Reach.unverified;
  final (imports, expr) = recipe;
  return _probe('$imports main() { final o = $expr; return $probe; }');
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

  // Operators and universal Object members go through the same pass as every
  // other column. They used to skip it, which made both columns raw map-diff
  // output that nothing had checked — and because `gapCount` excluded them too,
  // there was no number anywhere that would move when one of them was real. That
  // is how `bool`'s missing `& | ^` sat in plain sight next to obvious false
  // positives like `int <` and was dismissed as noise.
  final confirmedOperators = <String>[];
  for (final m in diff.missingOperators) {
    final reach =
        canProbeInstances ? verifyOperator(diff.name, m) : Reach.unverified;
    switch (reach) {
      case Reach.confirmedMissing:
        confirmedOperators.add(m);
      case Reach.reachable:
        diff.reachableViaFallback.add(m);
      case Reach.unverified:
        diff.unverifiedOperators.add(m);
    }
  }
  diff.missingOperators
    ..clear()
    ..addAll(confirmedOperators);

  final confirmedUniversal = <String>[];
  for (final m in diff.missingUniversal) {
    // `==` is both universal and an operator, and the universal check runs
    // first, so it lands here. It still needs the operator probe: `o.==` does
    // not parse, and a parse failure is not an unreachable-member error, so the
    // bare read would have reported it reachable no matter what.
    final reach = !canProbeInstances
        ? Reach.unverified
        : _isOperator(m)
            ? verifyOperator(diff.name, m)
            : verifyInstanceMember(diff.name, m);
    switch (reach) {
      case Reach.confirmedMissing:
        confirmedUniversal.add(m);
      case Reach.reachable:
        diff.reachableViaFallback.add(m);
      case Reach.unverified:
        diff.unverifiedUniversal.add(m);
    }
  }
  diff.missingUniversal
    ..clear()
    ..addAll(confirmedUniversal);

  diff.verified = true;
}

// =============================================================================
// Hierarchy audit — SCB19
// =============================================================================

/// One bridged class's supertype-registry state.
class HierarchyGap {
  HierarchyGap(this.name, this.nativeTypeName, this.hasIsAssignable);

  final String name;
  final String nativeTypeName;

  /// Whether the bridge declares an `isAssignable` predicate. SCB19 framed the
  /// defect around this flag, and it does raise the stakes — a predicate with no
  /// edges lets the bridge claim ownership of natives it cannot fully serve.
  /// But it is reported rather than filtered on: the edges are what carry the
  /// inherited surface, so a bridge without a predicate that is missing edges is
  /// just as broken for `is` and for inherited members.
  final bool hasIsAssignable;

  /// Bridged supertypes the SDK says this type has, which the registry does not
  /// know about — transitively, so an edge reachable via an intermediate hop
  /// counts as present.
  ///
  /// After [verifyHierarchy] these are only the edges whose absence a script can
  /// OBSERVE, i.e. where `o is Supertype` actually answered false. Before it
  /// they are candidates.
  final missingEdges = <String>[];

  /// Candidate edges where `is` answered true anyway. The registry is not the
  /// only path: `BridgedClass.isSubtypeOf` also consults the target's
  /// `isAssignable` against the native value (GEN-075), and the interpreter
  /// special-cases the primitives. Kept in the report because their number is
  /// the evidence that the raw cross-reference must not be published as a
  /// defect list.
  final satisfiedAnyway = <String>[];

  /// Candidates left untested for want of an instance recipe — reported as
  /// their own bucket rather than folded into either answer.
  final unverifiedEdges = <String>[];

  /// What the registry does know, for context in the report.
  final registeredEdges = <String>[];

  bool verified = false;
  bool recipeUsable = false;

  Map<String, dynamic> toJson() => {
        'name': name,
        'nativeType': nativeTypeName,
        'hasIsAssignable': hasIsAssignable,
        'verified': verified,
        'recipeUsable': recipeUsable,
        'missingEdges': missingEdges,
        'satisfiedAnyway': satisfiedAnyway,
        'unverifiedEdges': unverifiedEdges,
        'registeredEdges': registeredEdges,
      };
}

/// The `dart:` library that declares [type], as an import directive.
///
/// Read from the mirror's own owner rather than guessed from a name table: the
/// probe needs the supertype in scope, and a wrong guess would make a present
/// edge look absent. Returns null for `dart:core` (always in scope) and for
/// anything not reflectable.
String? _importForType(Type type) {
  try {
    final t = reflectType(type);
    if (t is! ClassMirror) return null;
    final owner = t.owner;
    if (owner is! LibraryMirror) return null;
    final uri = owner.uri.toString();
    if (!uri.startsWith('dart:') || uri == 'dart:core') return null;
    return "import '$uri';";
  } catch (_) {
    return null;
  }
}

/// Every supertype of [type] the SDK declares — superclass chain plus
/// superinterfaces, transitively.
///
/// Returned as `originalDeclaration` mirrors so that `Queue<dynamic>` and
/// `Queue<int>` compare equal: bridges carry instantiated native types
/// (`Queue<dynamic>`), while `superinterfaces` yields whatever the declaration
/// site wrote, and matching on the raw `Type` would miss nearly every edge.
Set<ClassMirror> _sdkSupertypeDeclarations(Type type) {
  final result = <ClassMirror>{};
  final ClassMirror root;
  try {
    final t = reflectType(type);
    if (t is! ClassMirror) return result;
    root = t;
  } catch (_) {
    return result;
  }

  final seen = <ClassMirror>{};
  final queue = <ClassMirror>[root];
  while (queue.isNotEmpty) {
    final cm = queue.removeAt(0);
    if (!seen.add(cm)) continue;
    if (!identical(cm, root)) result.add(cm.originalDeclaration as ClassMirror);
    try {
      final sup = cm.superclass;
      if (sup != null && sup.reflectedType != Object) queue.add(sup);
      queue.addAll(cm.superinterfaces);
    } catch (_) {
      // Partly-reflectable SDK class — keep whatever the rest of the walk found.
    }
  }
  return result;
}

/// Cross-references every bridge's SDK supertypes against the supertype
/// registry, and reports the bridged ones nobody declared.
///
/// Only BRIDGED supertypes are reported. An edge to an unbridged type would be
/// unrepresentable — the registry keys on the name of a bridge — so listing
/// those would be noise rather than a defect list. Types the SDK reaches that
/// have no bridge are a different finding (a missing bridge), and the member
/// diff is not the place to raise it either.
List<HierarchyGap> auditHierarchy(Environment env) {
  final names = env.bridgedClassNames..sort();

  // Declaration mirror -> the bridge names registered for it. A list because
  // aliases exist: two names can share one native type.
  final byDeclaration = <ClassMirror, List<String>>{};
  for (final name in names) {
    final bc = env.findBridgedClassByName(name);
    if (bc == null) continue;
    try {
      final t = reflectType(bc.nativeType);
      if (t is! ClassMirror) continue;
      byDeclaration
          .putIfAbsent(t.originalDeclaration as ClassMirror, () => [])
          .add(name);
    } catch (_) {
      // Not reflectable (`Never`); it cannot participate either way.
    }
  }

  final gaps = <HierarchyGap>[];
  for (final name in names) {
    final bc = env.findBridgedClassByName(name);
    if (bc == null) continue;

    final registered =
        BridgedClass.transitiveSupertypeNames(name).toSet();
    final gap = HierarchyGap(
        name, bc.nativeType.toString(), bc.isAssignable != null)
      ..registeredEdges.addAll(registered.toList()..sort());

    for (final decl in _sdkSupertypeDeclarations(bc.nativeType)) {
      final bridgeNames = byDeclaration[decl];
      if (bridgeNames == null) continue;
      for (final supertypeName in bridgeNames) {
        if (supertypeName == name) continue;
        if (registered.contains(supertypeName)) continue;
        gap.missingEdges.add(supertypeName);
      }
    }
    gap.missingEdges.sort();
    gaps.add(gap);
  }

  gaps.sort((a, b) {
    final byCount = b.missingEdges.length.compareTo(a.missingEdges.length);
    return byCount != 0 ? byCount : a.name.compareTo(b.name);
  });
  return gaps;
}

/// Drives `o is Supertype` through the interpreter for each candidate edge.
///
/// The parallel of the member diff's phase 2, and for the same reason: a static
/// cross-reference is a candidate generator. `int`'s missing `-> num` edge is
/// the clearest case — the registry has nothing, yet `1 is num` is true, because
/// the interpreter never routes a primitive through the bridge registry at all.
/// Publishing that as a defect would send someone to fix working code.
void verifyHierarchy(HierarchyGap gap, Environment env) {
  gap.verified = true;
  final recipe = _instanceRecipes[gap.name];
  if (recipe == null || !recipeWorks(gap.name)) {
    gap.unverifiedEdges
      ..addAll(gap.missingEdges)
      ..sort();
    gap.missingEdges.clear();
    return;
  }
  gap.recipeUsable = true;

  final (recipeImport, expr) = recipe;
  final confirmed = <String>[];
  for (final supertype in gap.missingEdges) {
    final bc = env.findBridgedClassByName(supertype);
    final supertypeImport =
        bc == null ? null : _importForType(bc.nativeType);
    final imports = <String>{
      if (recipeImport.isNotEmpty) recipeImport,
      if (supertypeImport != null) supertypeImport,
    }.join(' ');

    final source = '$imports main() { final o = $expr; return o is $supertype; }';
    final interpreter = D4rt()..setDebug(false);
    interpreter.grant(FilesystemPermission.any);
    Object? result;
    try {
      result = interpreter.execute(
        library: 'package:audit/main.dart',
        sources: {'package:audit/main.dart': source},
      );
    } catch (_) {
      // A throwing `is` (an unbridged or out-of-scope supertype name) is not
      // the same finding as a false one; do not count it as a missing edge.
      gap.unverifiedEdges.add(supertype);
      continue;
    }
    if (result == false) {
      confirmed.add(supertype);
    } else {
      gap.satisfiedAnyway.add(supertype);
    }
  }
  gap.missingEdges
    ..clear()
    ..addAll(confirmed);
  gap.unverifiedEdges.sort();
  gap.satisfiedAnyway.sort();
}

void runHierarchyAudit(Environment env, List<String> args) {
  final gaps = auditHierarchy(env);
  final candidateEdges =
      gaps.fold<int>(0, (s, g) => s + g.missingEdges.length);

  if (!args.contains('--no-verify')) {
    stderr.writeln('Verifying $candidateEdges candidate edges against the '
        'interpreter...');
    for (final g in gaps) {
      verifyHierarchy(g, env);
    }
    gaps.sort((a, b) {
      final byCount = b.missingEdges.length.compareTo(a.missingEdges.length);
      return byCount != 0 ? byCount : a.name.compareTo(b.name);
    });
  }

  final withGaps = gaps.where((g) => g.missingEdges.isNotEmpty).toList();
  final totalEdges = withGaps.fold<int>(0, (s, g) => s + g.missingEdges.length);
  final assignableWithGaps =
      withGaps.where((g) => g.hasIsAssignable).length;

  stdout.writeln('Bridged classes examined:            ${gaps.length}');
  stdout.writeln('  ... with >=1 registered edge:      '
      '${gaps.where((g) => g.registeredEdges.isNotEmpty).length}');
  stdout.writeln('  ... declaring isAssignable:        '
      '${gaps.where((g) => g.hasIsAssignable).length}');
  stdout.writeln('Candidate edges from cross-reference: $candidateEdges');
  stdout.writeln('  ... satisfied anyway (isAssignable): '
      '${gaps.fold<int>(0, (s, g) => s + g.satisfiedAnyway.length)}');
  stdout.writeln('  ... unverified (no instance recipe): '
      '${gaps.fold<int>(0, (s, g) => s + g.unverifiedEdges.length)}');
  stdout.writeln('CONFIRMED missing edges:             $totalEdges');
  stdout.writeln('Classes with >=1 confirmed gap:      ${withGaps.length}');
  stdout.writeln('  ... of those, with isAssignable:   $assignableWithGaps');
  stdout.writeln('');
  stdout.writeln('| Class | Native type | isAssignable | Confirmed missing | Registered |');
  stdout.writeln('| --- | --- | --- | --- | --- |');
  for (final g in withGaps) {
    stdout.writeln('| ${g.name} | ${g.nativeTypeName} '
        '| ${g.hasIsAssignable ? 'yes' : 'no'} '
        '| ${g.missingEdges.join(', ')} '
        '| ${g.registeredEdges.isEmpty ? '—' : g.registeredEdges.join(', ')} |');
  }

  final jsonIndex = args.indexOf('--json');
  if (jsonIndex >= 0 && jsonIndex + 1 < args.length) {
    final out = File(args[jsonIndex + 1]);
    out.parent.createSync(recursive: true);
    out.writeAsStringSync(const JsonEncoder.withIndent('  ')
        .convert(gaps.map((g) => g.toJson()).toList()));
    stdout.writeln('\nJSON written to ${out.path}');
  }
}

void main(List<String> args) {
  final env = buildFullyRegisteredEnvironment();

  if (args.contains('--hierarchy')) {
    runHierarchyAudit(env, args);
    return;
  }

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
  // Operator and Universal are broken out rather than folded into Confirmed:
  // a row reading `Confirmed 1 | Instance 0 | Static 0` was unreadable, and
  // these two columns spent long enough being invisible.
  stdout.writeln('| Class | Native type | Confirmed | Instance | Static '
      '| Operator | Universal | Unverified |');
  stdout.writeln('| --- | --- | --- | --- | --- | --- | --- | --- |');
  for (final d in diffs) {
    if (d.gapCount == 0 && d.error == null) continue;
    stdout.writeln('| ${d.name} | ${d.nativeTypeName} | ${d.gapCount} '
        '| ${d.missingInstance.length} | ${d.missingStatic.length} '
        '| ${d.missingOperators.length} | ${d.missingUniversal.length} '
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
