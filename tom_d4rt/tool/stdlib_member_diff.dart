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
import 'dart:isolate';
import 'dart:mirrors';

import 'package:tom_d4rt/d4rt.dart'
    show
        D4rt,
        FilesystemPermission,
        IsolatePermission,
        NetworkPermission,
        ProcessRunPermission;
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

  /// Why this class cannot be measured, when that is known and deliberate.
  ///
  /// UNVERIFIED has two very different causes and used to be indistinguishable
  /// between them: "no recipe exists because a recipe is impossible" and "nobody
  /// wrote one yet". Only the first is a finished state, and only a stated reason
  /// tells a reader which one they are looking at. Populated from
  /// [_notAuditable]; null means the class is expected to be auditable, so a
  /// non-zero unverified count on it is unfinished work.
  String? notAuditableReason;

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
    if (notAuditableReason != null) 'notAuditableReason': notAuditableReason,
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

/// Phase 1 for every bridged class in [env]: the raw candidate members, before
/// any of them has been driven through the interpreter.
///
/// Extracted from `main` so the standing baseline test in
/// `test/stdlib/member_coverage_baseline_test.dart` measures through the same
/// code path as the CLI. A test that reimplemented the walk could disagree with
/// the tool about what a candidate even is, and then the two would drift with
/// nobody the wiser — which is the failure this whole audit exists to prevent,
/// reproduced one level up.
///
/// [only] narrows the run to named classes, as `--only` does. The totals over a
/// narrowed run are a subset and must not be published as a measurement.
List<ClassDiff> collectMemberDiffs(Environment env, {Set<String>? only}) {
  final names = env.bridgedClassNames..sort();
  final diffs = <ClassDiff>[];
  for (final name in names) {
    if (only != null && !only.contains(name)) continue;
    final bc = env.findBridgedClassByName(name);
    if (bc == null) continue;
    diffs.add(diffClass(name, bc));
  }
  return diffs;
}

/// Phase 2 over [diffs], in place: classifies every candidate as confirmed,
/// reachable-anyway or unverified.
///
/// [onClass] is called with each class name and its candidate count *before* the
/// class is probed, which is what makes a wedged run diagnosable — see the
/// comment at the call site in `main`.
Future<void> verifyAll(
  List<ClassDiff> diffs, {
  void Function(String name, int candidates)? onClass,
}) async {
  for (final d in diffs) {
    final candidates =
        d.missingInstance.length +
        d.missingStatic.length +
        d.missingOperators.length +
        d.missingUniversal.length;
    if (candidates > 0) onClass?.call(d.name, candidates);
    await verify(d);
  }
}

String _symbolName(Symbol s) => MirrorSystem.getName(s);

bool _isPublic(String n) => !n.startsWith('_');

bool _isOperator(String n) =>
    n.isNotEmpty && !RegExp(r'^[A-Za-z_$]').hasMatch(n);

/// Mirrors keys setters as `foo=`; the adapter maps key them as `foo`.
String _normalizeSetter(String name) => name.endsWith('=') && !_isOperator(name)
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
/// as gaps.
class Recipe {
  const Recipe(
    this.expr, {
    this.imports = '',
    this.prelude = '',
    this.isAsync = false,
    this.teardown = '',
  });

  /// Import directives the expression needs.
  final String imports;

  /// Top-level declarations the expression needs, emitted before `main`.
  ///
  /// Two classes cannot be reached by an expression alone. `LinkedListEntry` is
  /// abstract and exists to be subclassed, so the only honest instance is an
  /// interpreted subclass; `Socket` needs something listening before a connect
  /// can succeed, which is a statement sequence, not an expression. Both are
  /// ordinary uses of the type rather than contortions to satisfy the tool.
  final String prelude;

  /// The expression yielding the instance, bound to `o` in the probe.
  final String expr;

  /// Whether [expr] (or [teardown]) awaits. Every `dart:io` socket and server
  /// recipe does — `bind` and `connect` have no synchronous form — which is the
  /// whole reason the probe harness is asynchronous.
  final bool isAsync;

  /// Statements to release `o`, run in a `finally`.
  ///
  /// It has to be a `finally` rather than a trailing statement: the probes worth
  /// running are precisely the ones that throw, so teardown placed after the
  /// member read would be skipped for every confirmed gap. With ~200 probes each
  /// binding a loopback port, leaking on the interesting path would exhaust file
  /// descriptors and then hang the VM at exit on the still-open sockets.
  final String teardown;
}

/// Classes that cannot be measured, and why.
///
/// This is the other half of an honest UNVERIFIED bucket. A class listed here is
/// a *finished* answer — "cannot be measured, here is the reason" — as opposed to
/// a class merely absent from [_instanceRecipes], which means nobody has written
/// a recipe yet. Every reason here is a bridge defect blocking the measurement,
/// so each entry is a pointer at work to do rather than a permanent exemption:
/// fix the defect and the class becomes auditable.
const _notAuditable = <String, String>{
  'HttpClientRequest':
      'the value `HttpClient.getUrl` yields is bridged as '
      '`IOSink`, its supertype, so every `HttpClientRequest` member reads as '
      'undefined regardless of the adapter map — the recipe would measure the '
      'wrong bridge',
  'HttpHeaders':
      'only reachable via `HttpClientRequest.headers`, which the '
      'same `IOSink` misbridging hides',
  'HttpClientResponse':
      'requires a completed HTTP round trip, which does not '
      'finish inside the interpreter — the probe hangs rather than answering',
  // The one entry here that is NOT a bridge defect, and the one that had to be
  // learned the hard way. `Stdin` has no constructor: the only instance in
  // existence is the process's own standard input, so a recipe cannot sandbox
  // it the way `IOSink` sandboxes a file sink. That is survivable while `Stdin`
  // exposes nothing but `readLineSync` and `hasTerminal`; it stops being
  // survivable the moment `Stdin` gains a `Stream` supertype, because the probe
  // then bare-reads `stdin.length`, `stdin.first`, `stdin.last` — and a bare
  // read of a `Stream` getter SUBSCRIBES.
  //
  // Subscribing to fd 0 inside `dart test` does not fail the one probe; it
  // destroys the file descriptor for the whole process, and every suite that
  // registers `dart:io` afterwards dies in `IoStdioStdlib.register` with
  // "Failed to get type of stdio handle (fd 0)". Measured: 82 unrelated
  // failures in `test/stdlib` alone, none of them near the audit. The probe
  // timeout does not help — the damage is done by the subscription, not by the
  // hang it causes.
  'Stdin':
      'the only instance is the process\'s own standard input, which has '
      'no constructor and cannot be sandboxed; a bare read of any inherited '
      '`Stream` getter subscribes to fd 0 and destroys it for every later '
      'suite in the same `dart test` process',
};

const _instanceRecipes = <String, Recipe>{
  'String': Recipe("'abc'"),
  // The `dart:core` classes the hierarchy audit reported UNVERIFIED (SCC56).
  // Each is an expression away — nobody had needed an instance probe for them
  // before the supertype edges were asked about, which is the usual reason a
  // recipe is missing rather than any difficulty in writing one.
  'RegExp': Recipe("RegExp('a+')"),
  'RegExpMatch': Recipe("RegExp('a+').firstMatch('aaa')"),
  'Runes': Recipe("'abc'.runes"),
  'StringBuffer': Recipe("StringBuffer('x')"),
  'UriData': Recipe("UriData.parse('data:text/plain;charset=utf-8,x')"),
  'Uri': Recipe("Uri.parse('https://example.dev/a?b=c')"),
  'Duration': Recipe('Duration(seconds: 1)'),
  'DateTime': Recipe('DateTime.utc(2026, 1, 2, 3, 4, 5)'),
  'Object': Recipe('Object()'),
  'Symbol': Recipe('#auditProbe'),
  'List': Recipe('[1, 2]'),
  'Set': Recipe('{1, 2}'),
  'Iterable': Recipe('[1, 2]'),
  'ByteData': Recipe('ByteData(8)', imports: "import 'dart:typed_data';"),
  'ByteBuffer': Recipe(
    'Uint8List(8).buffer',
    imports: "import 'dart:typed_data';",
  ),
  'Uint8List': Recipe(
    'Uint8List.fromList([1, 2, 3])',
    imports: "import 'dart:typed_data';",
  ),
  'Uint8ClampedList': Recipe(
    'Uint8ClampedList.fromList([1, 2, 3])',
    imports: "import 'dart:typed_data';",
  ),
  'Uint16List': Recipe(
    'Uint16List.fromList([1, 2])',
    imports: "import 'dart:typed_data';",
  ),
  'Uint32List': Recipe(
    'Uint32List.fromList([1, 2])',
    imports: "import 'dart:typed_data';",
  ),
  'Uint64List': Recipe(
    'Uint64List.fromList([1, 2])',
    imports: "import 'dart:typed_data';",
  ),
  'Int8List': Recipe(
    'Int8List.fromList([1, 2])',
    imports: "import 'dart:typed_data';",
  ),
  'Int16List': Recipe(
    'Int16List.fromList([1, 2])',
    imports: "import 'dart:typed_data';",
  ),
  'Int32List': Recipe(
    'Int32List.fromList([1, 2])',
    imports: "import 'dart:typed_data';",
  ),
  'Int64List': Recipe(
    'Int64List.fromList([1, 2])',
    imports: "import 'dart:typed_data';",
  ),
  'Float32List': Recipe(
    'Float32List.fromList([1.0, 2.0])',
    imports: "import 'dart:typed_data';",
  ),
  'Float64List': Recipe(
    'Float64List.fromList([1.0, 2.0])',
    imports: "import 'dart:typed_data';",
  ),
  // The primitives had no recipe at all, which is why the operator column was
  // UNVERIFIED for precisely the classes whose operators matter most — `bool`'s
  // missing `& | ^` sat in an unverified bucket on an unverified column. A
  // literal is the whole recipe; there was never a reason to leave them out
  // beyond nobody needing an instance probe for them before operators were
  // verified.
  'bool': Recipe('true'),
  'int': Recipe('1'),
  'double': Recipe('1.5'),
  'num': Recipe('2'),
  'BigInt': Recipe('BigInt.from(6)'),
  'Queue': Recipe('Queue<int>()..add(1)', imports: "import 'dart:collection';"),
  'ListQueue': Recipe(
    'ListQueue<int>()..add(1)',
    imports: "import 'dart:collection';",
  ),
  'DoubleLinkedQueue': Recipe(
    'DoubleLinkedQueue<int>()..add(1)',
    imports: "import 'dart:collection';",
  ),
  'HashSet': Recipe(
    'HashSet<int>()..add(1)',
    imports: "import 'dart:collection';",
  ),
  'LinkedHashSet': Recipe(
    'LinkedHashSet<int>()..add(1)',
    imports: "import 'dart:collection';",
  ),
  'SplayTreeSet': Recipe(
    'SplayTreeSet<int>()..add(1)',
    imports: "import 'dart:collection';",
  ),
  'SplayTreeMap': Recipe(
    'SplayTreeMap<int, int>()',
    imports: "import 'dart:collection';",
  ),
  'HashMap': Recipe(
    'HashMap<int, int>()',
    imports: "import 'dart:collection';",
  ),
  'LinkedHashMap': Recipe(
    'LinkedHashMap<int, int>()',
    imports: "import 'dart:collection';",
  ),
  'UnmodifiableListView': Recipe(
    'UnmodifiableListView<int>([1, 2])',
    imports: "import 'dart:collection';",
  ),
  // The map sibling of the view above, missing for no reason other than that
  // nobody had asked it a question — the list view was added when a `List` gap
  // was being chased and its twin was not.
  'UnmodifiableMapView': Recipe(
    'UnmodifiableMapView<String, int>({\'a\': 1})',
    imports: "import 'dart:collection';",
  ),
  'LinkedList': Recipe('LinkedList()', imports: "import 'dart:collection';"),
  // The SDK's `LinkedListEntry` is abstract and exists to be subclassed; this
  // bridge models it as a concrete value carrier instead, so `LinkedListEntry(1)`
  // is the recipe the bridge under measurement actually accepts. The divergence
  // is real and tracked separately — measuring the bridge as it is, is the audit's
  // job; changing it is not.
  'LinkedListEntry': Recipe(
    'LinkedListEntry(1)',
    imports: "import 'dart:collection';",
  ),
  'StreamController': Recipe(
    'StreamController<int>()',
    imports: "import 'dart:async';",
  ),
  'StreamView': Recipe(
    'StreamView<int>(Stream<int>.fromIterable([1]))',
    imports: "import 'dart:async';",
  ),
  'StreamSubscription': Recipe(
    'Stream<int>.fromIterable([1]).listen((e) {})',
    imports: "import 'dart:async';",
  ),
  'Utf8Codec': Recipe('utf8', imports: "import 'dart:convert';"),
  'AsciiCodec': Recipe('ascii', imports: "import 'dart:convert';"),
  'Latin1Codec': Recipe('latin1', imports: "import 'dart:convert';"),
  'Encoding': Recipe('utf8', imports: "import 'dart:convert';"),
  'JsonEncoder': Recipe('JsonEncoder()', imports: "import 'dart:convert';"),
  'JsonDecoder': Recipe('JsonDecoder()', imports: "import 'dart:convert';"),
  'Converter': Recipe('JsonEncoder()', imports: "import 'dart:convert';"),
  'HtmlEscape': Recipe('HtmlEscape()', imports: "import 'dart:convert';"),
  'HtmlEscapeMode': Recipe(
    'HtmlEscapeMode.element',
    imports: "import 'dart:convert';",
  ),
  'LineSplitter': Recipe('LineSplitter()', imports: "import 'dart:convert';"),
  'StreamTransformerBase': Recipe(
    'utf8.decoder',
    imports: "import 'dart:convert';",
  ),
  'StringConversionSink': Recipe(
    'StringConversionSink.withCallback((s) {})',
    imports: "import 'dart:convert';",
  ),
  'Point': Recipe('Point(1, 2)', imports: "import 'dart:math';"),
  'Rectangle': Recipe('Rectangle(0, 0, 2, 2)', imports: "import 'dart:math';"),
  'ReceivePort': Recipe(
    'ReceivePort()',
    imports: "import 'dart:isolate';",
    teardown: 'o.close();',
  ),
  'SendPort': Recipe(
    '(ReceivePort()..close()).sendPort',
    imports: "import 'dart:isolate';",
  ),
  // The `dart:io` / `dart:isolate` classes the hierarchy audit reported
  // UNVERIFIED (SCC57). Each is a plain constructor call over values, so the
  // reason they were missing is the same one that kept the `dart:core` recipes
  // missing until SCC56: the member audit never needed an instance of them, and
  // the hierarchy audit inherited its table rather than being given its own.
  'OSError': Recipe("OSError('audit', 1)", imports: "import 'dart:io';"),
  'ContentType': Recipe(
    "ContentType('text', 'plain')",
    imports: "import 'dart:io';",
  ),
  'RemoteError': Recipe(
    "RemoteError('audit', 'stack')",
    imports: "import 'dart:isolate';",
  ),
  // `File` and `Directory` are pure value objects until a method is called —
  // the constructor stores a path and touches nothing. They read as
  // resource-holding classes and are not; that misreading is why they had no
  // recipe. A path that does not exist is fine, and is chosen deliberately so
  // no probe can be tempted into I/O.
  'File': Recipe(
    "File('audit_probe_does_not_exist')",
    imports: "import 'dart:io';",
  ),
  'Directory': Recipe(
    "Directory('audit_probe_does_not_exist')",
    imports: "import 'dart:io';",
  ),
  // The one genuinely resource-holding recipe added by SCC57. `IOSink` has no
  // bridged constructor, and every other route to one is a SUBTYPE — `stdout`
  // dispatches to the `Stdout` bridge, a connected socket to `Socket` — so a
  // probe built on those would measure the wrong bridge's walk and report it
  // under this class's name. `openWrite` is the only expression that yields a
  // value whose sole matching bridge is `IOSink` itself.
  //
  // The scratch file goes under a project-local `ztmp/`, which the repo root
  // gitignores at any depth, and is removed in the teardown. Never the system
  // temp directory: a probe that leaks there leaks somewhere nobody looks.
  'IOSink': Recipe(
    '_auditSink()',
    imports: "import 'dart:io';",
    prelude:
        'Future<IOSink> _auditSink() async {'
        "  final d = Directory('ztmp');"
        '  if (!d.existsSync()) { d.createSync(recursive: true); }'
        "  return File('ztmp/audit_iosink.tmp').openWrite();"
        '}',
    teardown:
        'await o.close(); '
        "final f = File('ztmp/audit_iosink.tmp'); "
        'if (f.existsSync()) { f.deleteSync(); }',
    isAsync: true,
  ),
  'ProcessSignal': Recipe('ProcessSignal.sigint', imports: "import 'dart:io';"),
  'InternetAddressType': Recipe(
    'InternetAddressType.IPv4',
    imports: "import 'dart:io';",
  ),
  'InternetAddress': Recipe(
    'InternetAddress.loopbackIPv4',
    imports: "import 'dart:io';",
  ),
  'FileSystemEntityType': Recipe(
    'FileSystemEntityType.file',
    imports: "import 'dart:io';",
  ),
  'StdioType': Recipe('StdioType.terminal', imports: "import 'dart:io';"),
  'ProcessStartMode': Recipe(
    'ProcessStartMode.normal',
    imports: "import 'dart:io';",
  ),
  'RawSocketEvent': Recipe('RawSocketEvent.read', imports: "import 'dart:io';"),
  // `Stdin` is deliberately absent — see `_notAuditable`. `Stdout` stays: it is
  // a sink, so a bare read of an inherited `IOSink` getter observes it without
  // consuming anything.
  'Stdout': Recipe('stdout', imports: "import 'dart:io';"),
  'HttpClient': Recipe(
    'HttpClient()',
    imports: "import 'dart:io';",
    teardown: 'o.close(force: true);',
  ),
  // Port 0 asks the OS for an ephemeral port, so concurrent audit runs — and a
  // developer's own servers — cannot collide with the probe.
  'ServerSocket': Recipe(
    "ServerSocket.bind('127.0.0.1', 0)",
    imports: "import 'dart:io';",
    isAsync: true,
    teardown: 'await o.close();',
  ),
  'RawServerSocket': Recipe(
    "RawServerSocket.bind('127.0.0.1', 0)",
    imports: "import 'dart:io';",
    isAsync: true,
    teardown: 'await o.close();',
  ),
  'RawDatagramSocket': Recipe(
    "RawDatagramSocket.bind('127.0.0.1', 0)",
    imports: "import 'dart:io';",
    isAsync: true,
    teardown: 'o.close();',
  ),
  'HttpServer': Recipe(
    "HttpServer.bind('127.0.0.1', 0)",
    imports: "import 'dart:io';",
    isAsync: true,
    teardown: 'await o.close(force: true);',
  ),
  'Socket': Recipe(
    '_auditConnect()',
    imports: "import 'dart:io';",
    prelude:
        'Future<Socket> _auditConnect() async {'
        "  final s = await ServerSocket.bind('127.0.0.1', 0);"
        "  final c = await Socket.connect('127.0.0.1', s.port);"
        '  await s.close();'
        '  return c;'
        '}',
    isAsync: true,
    teardown: 'o.destroy();',
  ),
  'RawSocket': Recipe(
    '_auditConnectRaw()',
    imports: "import 'dart:io';",
    prelude:
        'Future<RawSocket> _auditConnectRaw() async {'
        "  final s = await RawServerSocket.bind('127.0.0.1', 0);"
        "  final c = await RawSocket.connect('127.0.0.1', s.port);"
        '  await s.close();'
        '  return c;'
        '}',
    isAsync: true,
    teardown: 'o.close();',
  ),
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

/// How long a single probe may take before it is abandoned.
///
/// Without a bound one probe stops the whole audit rather than one row: a bare
/// read of a stream getter on a live socket (`server.first`, `stdin.length`)
/// yields a future that never completes, and there are dozens of those. Three
/// seconds is generous for the question actually being asked — a member lookup
/// either resolves or throws immediately, so anything still running is waiting on
/// I/O, not resolving.
const _probeTimeout = Duration(seconds: 3);

/// `--trace`: announce every individual probe on stderr before running it.
///
/// Per-class progress is enough to see *that* a run is stuck; it is not enough to
/// see *where*, and the difference cost a wedged eight-minute run to learn. Off
/// by default because it is one line per candidate (~650 of them).
var _trace = false;

void _traceProbe(String what) {
  if (_trace) stderr.writeln('      $what');
}

/// Assembles a probe program: acquire `o`, run [body], release `o`.
///
/// The teardown wraps [body] in `try`/`finally` **without a `return` inside the
/// `try`**, and that is load-bearing rather than stylistic. Measured: in an
/// async function, a `return` whose expression throws inside a `try` with a
/// non-empty `finally` and no `catch` loses the error and returns the finally
/// block's last evaluated value instead. With `try { return o.member; } finally
/// { await o.close(); }` a bound `ServerSocket` reports *every* missing member
/// as present — the program completes and yields the socket. The shape here
/// throws correctly. Do not "simplify" it; the failure is silent and it
/// falsifies the whole run, not one row. Tracked as scd40.
///
/// [body]'s value still reaches the caller, which `verifyHierarchy` needs — it
/// reads the answer, not just whether the program threw.
String _recipeSource(Recipe recipe, String body, {String extraImport = ''}) {
  final imports = <String>{
    if (recipe.imports.isNotEmpty) recipe.imports,
    if (extraImport.isNotEmpty) extraImport,
  }.join(' ');
  final acquire = recipe.isAsync
      ? 'final o = await ${recipe.expr};'
      : 'final o = ${recipe.expr};';
  final read = 'probed = $body;';
  final guarded = recipe.teardown.isEmpty
      ? read
      : 'try { $read } finally { ${recipe.teardown} }';
  final signature = recipe.isAsync ? 'Future<dynamic> main() async' : 'main()';
  return '$imports ${recipe.prelude} '
      '$signature { $acquire dynamic probed; $guarded return probed; }';
}

/// What one probe program did.
///
/// Three outcomes, and they are not collapsible: a program that threw carries
/// wording the classifier reads, a program that completed carries a value the
/// hierarchy audit reads, and a program that never answered carries neither and
/// must not be scored as either.
class _ProbeOutcome {
  const _ProbeOutcome.completed({required this.isFalse})
    : error = null,
      answered = true;
  const _ProbeOutcome.threw(this.error) : isFalse = false, answered = true;
  const _ProbeOutcome.noAnswer()
    : error = null,
      isFalse = false,
      answered = false;

  /// False when the probe timed out or its isolate died without reporting —
  /// nothing was measured, whatever the caller was hoping to learn.
  final bool answered;
  final String? error;

  /// Whether the program evaluated to Dart `false`. Only the hierarchy audit
  /// reads it (`o is Supertype`); the member diff classifies on [error] alone.
  final bool isFalse;
}

/// The one message shape a probe isolate sends back, tagged so it cannot be
/// confused with `Isolate.spawn`'s own `onError` / `onExit` messages, which
/// arrive on the same port.
const _probeTag = 'probe';

class _ProbeRequest {
  const _ProbeRequest(this.source, this.reply);
  final String source;
  final SendPort reply;
}

void _probeEntry(_ProbeRequest request) {
  final interpreter = D4rt()..setDebug(false);
  // A `dart:io` recipe binds a loopback port and a `dart:isolate` one opens a
  // receive port, so the audit needs more than filesystem access. Granting
  // everything is right here and only here: the tool's whole job is to measure
  // what a fully-permitted script can reach, so a permission denial would be
  // measurement noise indistinguishable from a missing member.
  interpreter.grant(FilesystemPermission.any);
  interpreter.grant(NetworkPermission.any);
  interpreter.grant(IsolatePermission.any);
  interpreter.grant(ProcessRunPermission.any);
  try {
    final result = interpreter.execute(
      library: 'package:audit/main.dart',
      sources: {'package:audit/main.dart': request.source},
    );
    if (result is Future) {
      // Report from the continuation rather than awaiting, so this function
      // never holds a frame open: if the future never completes the isolate
      // simply runs out of work (or the parent kills it), and either way the
      // parent hears about it.
      result.then(
        (v) => request.reply.send([_probeTag, 'ok', v == false]),
        onError: (Object e) =>
            request.reply.send([_probeTag, 'threw', e.toString()]),
      );
      return;
    }
    request.reply.send([_probeTag, 'ok', result == false]);
  } catch (e) {
    request.reply.send([_probeTag, 'threw', e.toString()]);
  }
}

/// Runs one probe program in its own isolate, with a watchdog that can actually
/// stop it.
///
/// The interpreter used to be driven in-process under `Future.timeout`, and that
/// is unsound for this job: reading a member can put the interpreter into an
/// unbounded **synchronous** loop, and a `Future` timeout only fires when the
/// event loop gets a turn — which a synchronous loop never yields. Measured: a
/// full run wedged on `HttpServer` at 100 % CPU for eight minutes with a 3-second
/// timeout nominally in force. An isolate is the only handle the VM offers on
/// code that will not yield. It also bounds the damage from probes that leak: a
/// killed isolate takes its bound sockets and pending futures with it, where the
/// in-process version accumulated them for the whole run.
Future<_ProbeOutcome> _runProbe(String source) async {
  final port = ReceivePort();
  final isolate = await Isolate.spawn(
    _probeEntry,
    _ProbeRequest(source, port.sendPort),
    errorsAreFatal: true,
    onError: port.sendPort,
    onExit: port.sendPort,
  );
  var outcome = const _ProbeOutcome.noAnswer();
  try {
    // An *idle* timeout, which is the right shape: the probe either answers
    // promptly or is not going to.
    final answers = port.timeout(
      _probeTimeout,
      onTimeout: (sink) => sink.close(),
    );
    await for (final message in answers) {
      if (message is List && message.length == 3 && message[0] == _probeTag) {
        outcome = message[1] == 'ok'
            ? _ProbeOutcome.completed(isFalse: message[2] == true)
            : _ProbeOutcome.threw('${message[2]}');
        break;
      }
      if (message is List && message.length == 2) {
        // `onError`: something escaped the entry point's own catch.
        outcome = _ProbeOutcome.threw('${message[0]}');
        break;
      }
      if (message == null) {
        // `onExit` with no result: the isolate's event loop drained while the
        // program was still pending. Nothing was measured.
        break;
      }
    }
  } finally {
    isolate.kill(priority: Isolate.immediate);
    port.close();
  }
  return outcome;
}

/// Runs [source] and classifies the outcome.
///
/// [onTimeout] is what a probe that never answers should be classified as, and
/// it differs by caller rather than being a property of the timeout. For a member
/// read it is [Reach.reachable]: the recipe has already been proven to work, and a
/// *missing* member throws instantly — so a program still running got past the
/// lookup and is awaiting I/O, which means the member resolved. For a recipe
/// check it is [Reach.unverified]: there the thing that hung is the instance
/// acquisition itself, so nothing was measured at all.
Future<Reach> _probe(String source, {required Reach onTimeout}) async {
  final outcome = await _runProbe(source);
  if (!outcome.answered) return onTimeout;
  final error = outcome.error;
  if (error == null) return Reach.reachable;
  return _isUnreachableError(error) ? Reach.confirmedMissing : Reach.reachable;
}

/// Whether [source] evaluated to something other than `false`, or null when it
/// threw or never answered.
///
/// Separate from [_probe] because the hierarchy audit classifies on the *value*
/// (`o is Supertype` answering false) rather than on the failure wording.
Future<bool?> _probeIsTrue(String source) async {
  final outcome = await _runProbe(source);
  if (!outcome.answered || outcome.error != null) return null;
  return !outcome.isFalse;
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
Future<bool> recipeWorks(String className) async {
  final recipe = _instanceRecipes[className];
  if (recipe == null) return false;
  _traceProbe('recipe $className');
  return await _probe(
        _recipeSource(recipe, '1'),
        onTimeout: Reach.unverified,
      ) ==
      Reach.reachable;
}

/// Reads [member] off an instance, without calling it — a bare read is enough to
/// make the interpreter perform the lookup, and it avoids having to know each
/// member's signature.
Future<Reach> verifyInstanceMember(String className, String member) {
  final recipe = _instanceRecipes[className];
  if (recipe == null) return Future.value(Reach.unverified);
  _traceProbe('$className.$member');
  return _probe(_recipeSource(recipe, 'o.$member'), onTimeout: Reach.reachable);
}

/// Applies [op] to a recipe instance. UNVERIFIED when there is no recipe for the
/// class or no probe template for the operator, never a gap.
Future<Reach> verifyOperator(String className, String op) {
  final recipe = _instanceRecipes[className];
  final probe = _operatorProbes[op];
  if (recipe == null || probe == null) return Future.value(Reach.unverified);
  _traceProbe('$className $op');
  return _probe(_recipeSource(recipe, probe), onTimeout: Reach.reachable);
}

Future<Reach> verifyStaticMember(String className, String member) {
  // Statics need no instance, so every class can be verified. The import is
  // whatever the instance recipe used, when there is one.
  final imports = _instanceRecipes[className]?.imports ?? '';
  _traceProbe('$className.$member (static)');
  return _probe(
    '$imports main() { return $className.$member; }',
    onTimeout: Reach.reachable,
  );
}

Future<void> verify(ClassDiff diff) async {
  diff.notAuditableReason = _notAuditable[diff.name];
  final canProbeInstances = await recipeWorks(diff.name);
  diff.recipeUsable = canProbeInstances;

  final confirmedInstance = <String>[];
  for (final m in diff.missingInstance) {
    final reach = canProbeInstances
        ? await verifyInstanceMember(diff.name, m)
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
    switch (await verifyStaticMember(diff.name, m)) {
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
    final reach = canProbeInstances
        ? await verifyOperator(diff.name, m)
        : Reach.unverified;
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
        ? await verifyOperator(diff.name, m)
        : await verifyInstanceMember(diff.name, m);
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

  /// Why this class cannot be measured, from [_notAuditable]; null means a
  /// recipe is merely missing.
  ///
  /// The member audit has printed this since SCC12 and the hierarchy audit did
  /// not, which made the two modes disagree about what an unverified edge means:
  /// members separated "cannot be measured, here is why" from "nobody wrote a
  /// recipe", and the hierarchy report showed one number covering both. A blind
  /// spot only visible in a todo is a blind spot twice.
  String? notAuditableReason;

  Map<String, dynamic> toJson() => {
    'name': name,
    'nativeType': nativeTypeName,
    'hasIsAssignable': hasIsAssignable,
    'verified': verified,
    'recipeUsable': recipeUsable,
    if (notAuditableReason != null) 'notAuditableReason': notAuditableReason,
    'missingEdges': missingEdges,
    'satisfiedAnyway': satisfiedAnyway,
    'unverifiedEdges': unverifiedEdges,
    'registeredEdges': registeredEdges,
  };
}

/// SDK implementation libraries, and the public library that re-exports each.
///
/// A `dart:_`-prefixed library cannot be imported by any program, so an import
/// directive naming one does not resolve and the probe throws — which the
/// hierarchy audit then scores UNVERIFIED. That is not a hypothetical: `dart:io`
/// declares its whole HTTP surface in the patch library `dart:_http`, so
/// `ContentType -> HeaderValue` reported as "no recipe written yet" while the
/// recipe worked perfectly. A blind spot manufactured by the instrument is worse
/// than the one it was built to find, because it names the wrong cause.
const _sdkReexports = <String, String>{'dart:_http': 'dart:io'};

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
    final raw = owner.uri.toString();
    final uri = _sdkReexports[raw] ?? raw;
    if (!uri.startsWith('dart:') || uri == 'dart:core') return null;
    // An unmapped implementation library: emit nothing rather than something
    // unresolvable. The supertype may still be in scope through the recipe's own
    // imports, and if it is not the probe fails honestly instead of failing for
    // a reason that has nothing to do with the edge.
    if (uri.startsWith('dart:_')) return null;
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

    final registered = BridgedClass.transitiveSupertypeNames(name).toSet();
    final gap = HierarchyGap(
      name,
      bc.nativeType.toString(),
      bc.isAssignable != null,
    )..registeredEdges.addAll(registered.toList()..sort());

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
Future<void> verifyHierarchy(HierarchyGap gap, Environment env) async {
  gap.verified = true;
  gap.notAuditableReason = _notAuditable[gap.name];
  final recipe = _instanceRecipes[gap.name];
  if (recipe == null || !await recipeWorks(gap.name)) {
    gap.unverifiedEdges
      ..addAll(gap.missingEdges)
      ..sort();
    gap.missingEdges.clear();
    return;
  }
  gap.recipeUsable = true;

  final confirmed = <String>[];
  for (final supertype in gap.missingEdges) {
    final bc = env.findBridgedClassByName(supertype);
    final supertypeImport = bc == null ? null : _importForType(bc.nativeType);

    final result = await _probeIsTrue(
      _recipeSource(
        recipe,
        'o is $supertype',
        extraImport: supertypeImport ?? '',
      ),
    );
    if (result == null) {
      // A throwing `is` (an unbridged or out-of-scope supertype name) is not
      // the same finding as a false one; do not count it as a missing edge.
      gap.unverifiedEdges.add(supertype);
      continue;
    }
    if (!result) {
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

Future<void> runHierarchyAudit(Environment env, List<String> args) async {
  final gaps = auditHierarchy(env);
  final candidateEdges = gaps.fold<int>(0, (s, g) => s + g.missingEdges.length);

  if (!args.contains('--no-verify')) {
    stderr.writeln(
      'Verifying $candidateEdges candidate edges against the '
      'interpreter...',
    );
    for (final g in gaps) {
      await verifyHierarchy(g, env);
    }
    gaps.sort((a, b) {
      final byCount = b.missingEdges.length.compareTo(a.missingEdges.length);
      return byCount != 0 ? byCount : a.name.compareTo(b.name);
    });
  }

  final withGaps = gaps.where((g) => g.missingEdges.isNotEmpty).toList();
  final totalEdges = withGaps.fold<int>(0, (s, g) => s + g.missingEdges.length);
  final assignableWithGaps = withGaps.where((g) => g.hasIsAssignable).length;

  stdout.writeln('Bridged classes examined:            ${gaps.length}');
  stdout.writeln(
    '  ... with >=1 registered edge:      '
    '${gaps.where((g) => g.registeredEdges.isNotEmpty).length}',
  );
  stdout.writeln(
    '  ... declaring isAssignable:        '
    '${gaps.where((g) => g.hasIsAssignable).length}',
  );
  stdout.writeln('Candidate edges from cross-reference: $candidateEdges');
  stdout.writeln(
    '  ... satisfied anyway (isAssignable): '
    '${gaps.fold<int>(0, (s, g) => s + g.satisfiedAnyway.length)}',
  );
  final unverifiedClasses = gaps
      .where((g) => g.unverifiedEdges.isNotEmpty)
      .toList();
  final explained = unverifiedClasses
      .where((g) => g.notAuditableReason != null)
      .toList();
  final unexplained = unverifiedClasses
      .where((g) => g.notAuditableReason == null)
      .toList();
  stdout.writeln(
    '  ... unverified (no instance recipe): '
    '${gaps.fold<int>(0, (s, g) => s + g.unverifiedEdges.length)}',
  );
  stdout.writeln(
    '      ... with a stated reason:      '
    '${explained.fold<int>(0, (s, g) => s + g.unverifiedEdges.length)} '
    'in ${explained.length} classes',
  );
  stdout.writeln(
    '      ... no recipe yet (unfinished): '
    '${unexplained.fold<int>(0, (s, g) => s + g.unverifiedEdges.length)} '
    'in ${unexplained.length} classes',
  );
  stdout.writeln('CONFIRMED missing edges:             $totalEdges');
  stdout.writeln('Classes with >=1 confirmed gap:      ${withGaps.length}');
  stdout.writeln('  ... of those, with isAssignable:   $assignableWithGaps');
  stdout.writeln('');
  stdout.writeln(
    '| Class | Native type | isAssignable | Confirmed missing | Registered |',
  );
  stdout.writeln('| --- | --- | --- | --- | --- |');
  for (final g in withGaps) {
    stdout.writeln(
      '| ${g.name} | ${g.nativeTypeName} '
      '| ${g.hasIsAssignable ? 'yes' : 'no'} '
      '| ${g.missingEdges.join(', ')} '
      '| ${g.registeredEdges.isEmpty ? '—' : g.registeredEdges.join(', ')} |',
    );
  }

  if (unverifiedClasses.isNotEmpty) {
    stdout.writeln('');
    stdout.writeln('Why each unverified class cannot be measured:');
    stdout.writeln('');
    stdout.writeln('| Class | Unverified edges | Reason |');
    stdout.writeln('| --- | --- | --- |');
    for (final g in unverifiedClasses) {
      stdout.writeln(
        '| ${g.name} | ${g.unverifiedEdges.join(', ')} '
        '| ${g.notAuditableReason ?? '**no recipe written yet**'} |',
      );
    }
  }

  final jsonIndex = args.indexOf('--json');
  if (jsonIndex >= 0 && jsonIndex + 1 < args.length) {
    final out = File(args[jsonIndex + 1]);
    out.parent.createSync(recursive: true);
    out.writeAsStringSync(
      const JsonEncoder.withIndent(
        '  ',
      ).convert(gaps.map((g) => g.toJson()).toList()),
    );
    stdout.writeln('\nJSON written to ${out.path}');
  }
}

// =============================================================================
// Standing baseline — SCC13
// =============================================================================

/// Renders the checked-in baseline consumed by
/// `test/stdlib/member_coverage_baseline_test.dart`.
///
/// Three things are pinned, and the choice of which three is the whole design:
///
///   * **confirmed gaps** — the known defects. A member confirmed unreachable
///     that is absent here is a regression.
///   * **unmeasurable members** — the known blind spots. Needed to tell
///     "unverified became a gap", which is a new *measurement* and not a new
///     defect, apart from "reachable became a gap", which is the regression this
///     guard exists for. Without this set the two are indistinguishable.
///   * **which classes had a working recipe** — so the measurement cannot go
///     dark silently. If a recipe breaks, every gap on that class turns
///     unverified, and a guard that merely tolerates confirmed → unverified
///     would report success while measuring nothing.
///
/// The ~378 members that are reachable only via the supertype-chain fallback are
/// deliberately NOT pinned. They add no guard power — a member of that set going
/// bad shows up as "confirmed and absent from the baseline" either way — and they
/// would triple the file with names that carry no finding, turning a reviewable
/// list of known defects into a wall nobody reads. That is the same failure as a
/// count-only assertion, just in the other direction.
String renderBaselineSource(List<ClassDiff> diffs) {
  final confirmed = <String, List<String>>{};
  final unmeasurable = <String, List<String>>{};
  final measured = <String>[];

  for (final d in diffs) {
    if (d.recipeUsable) measured.add(d.name);
    final gaps = <String>{
      ...d.missingInstance,
      ...d.missingStatic,
      ...d.missingOperators,
      ...d.missingUniversal,
    }.toList()..sort();
    if (gaps.isNotEmpty) confirmed[d.name] = gaps;
    final blind = <String>{
      ...d.unverifiedInstance,
      ...d.unverifiedStatic,
      ...d.unverifiedOperators,
      ...d.unverifiedUniversal,
    }.toList()..sort();
    if (blind.isNotEmpty) unmeasurable[d.name] = blind;
  }
  measured.sort();

  final gapTotal = confirmed.values.fold<int>(0, (s, l) => s + l.length);
  final blindTotal = unmeasurable.values.fold<int>(0, (s, l) => s + l.length);

  String renderMap(Map<String, List<String>> m) {
    final b = StringBuffer();
    for (final entry in m.entries) {
      b.writeln("  '${entry.key}': [");
      for (final member in entry.value) {
        b.writeln("    r'$member',");
      }
      b.writeln('  ],');
    }
    return b.toString();
  }

  return '''
// GENERATED — regenerate with:
//   dart run tool/stdlib_member_diff.dart --baseline
//
// The standing member-coverage baseline for the `dart:*` stdlib bridges, read by
// `member_coverage_baseline_test.dart`. Do not hand-edit: a hand-edited entry is
// an assertion about the interpreter that nothing measured, which is exactly the
// claim this baseline was introduced to stop anyone making.
//
// Current state: $gapTotal confirmed-unreachable members across ${confirmed.length} classes,
// and $blindTotal members on ${unmeasurable.length} classes that cannot be measured at all.
// Those totals are documentation, not assertions — the test derives them from the
// tables below, so there is only ever one thing to update.
//
// Regenerating is a normal part of closing a gap and a normal part of adding an
// instance recipe. It is NOT a normal part of making a red suite green: if
// `no previously-reachable member became unreachable` is the test that failed,
// regenerating hides a live defect.

/// Members proven unreachable through the interpreter, per bridged class.
const confirmedGaps = <String, List<String>>{
${renderMap(confirmed)}};

/// Candidates that could not be measured, per bridged class. Each of these has a
/// stated reason in `_notAuditable` in the tool; they are pinned so that a member
/// moving out of this bucket is reported as the new information it is, rather
/// than as a fresh defect.
const unmeasurable = <String, List<String>>{
${renderMap(unmeasurable)}};

/// Classes whose instance recipe produced a usable instance when the baseline was
/// taken. A class dropping out of this list means its gaps stopped being
/// measured, which the test reports as a failure rather than as a pass.
const measuredClasses = <String>{
${measured.map((n) => "  '$n',").join('\n')}
};
''';
}

/// Reads a two-token option (`--only Foo,Bar`) out of [args].
String? _optionValue(List<String> args, String name) {
  final i = args.indexOf(name);
  return i >= 0 && i + 1 < args.length ? args[i + 1] : null;
}

Future<void> main(List<String> args) async {
  _trace = args.contains('--trace');
  final env = buildFullyRegisteredEnvironment();

  if (args.contains('--hierarchy')) {
    await runHierarchyAudit(env, args);
    // A probe that bound a loopback port leaves the event loop with work to do
    // even after teardown, so the VM would sit at exit rather than return.
    exit(0);
  }

  // `--only Foo,Bar` narrows the run to named classes. The totals it prints are
  // then a subset and must not be published as a measurement — it exists so that
  // a single class can be re-probed in seconds instead of minutes while
  // diagnosing one.
  final only = _optionValue(args, '--only')?.split(',').toSet();

  final diffs = collectMemberDiffs(env, only: only);

  final rawCandidates = diffs.fold<int>(
    0,
    (s, d) => s + d.missingInstance.length + d.missingStatic.length,
  );

  if (!args.contains('--no-verify')) {
    // A clean run is around 600 probes in ~7 seconds; it stretches badly when
    // probes wedge, because each one then costs the full idle timeout. That is
    // why the progress lines below exist.
    stderr.writeln(
      'Verifying $rawCandidates candidates against the '
      'interpreter...',
    );
    // Per-class progress on stderr, announced BEFORE the class rather than
    // after. A silent run is indistinguishable from a wedged one, and it does
    // wedge: a bare read of a stream getter on a live socket returns a future
    // that never completes. A line printed on completion cannot name the class
    // that is currently hanging, which is the only line anyone diagnosing the
    // hang wants.
    await verifyAll(
      diffs,
      onClass: (name, candidates) => stderr.writeln('  $name ($candidates)'),
    );
  }

  if (args.contains('--baseline')) {
    final path =
        _optionValue(args, '--baseline-out') ??
        'test/stdlib/member_coverage_baseline.dart';
    File(path).writeAsStringSync(renderBaselineSource(diffs));
    stdout.writeln('Baseline written to $path');
    exit(0);
  }

  diffs.sort((a, b) {
    final byGap = b.gapCount.compareTo(a.gapCount);
    return byGap != 0 ? byGap : a.name.compareTo(b.name);
  });

  final totalGaps = diffs.fold<int>(0, (s, d) => s + d.gapCount);
  final withGaps = diffs.where((d) => d.gapCount > 0).length;
  final fallback = diffs.fold<int>(
    0,
    (s, d) => s + d.reachableViaFallback.length,
  );
  final unverified = diffs.fold<int>(0, (s, d) => s + d.unverifiedCount);

  final unverifiedClasses = diffs.where((d) => d.unverifiedCount > 0).toList();
  final explained = unverifiedClasses
      .where((d) => d.notAuditableReason != null)
      .toList();
  final unexplained = unverifiedClasses
      .where((d) => d.notAuditableReason == null)
      .toList();

  stdout.writeln('Bridged classes examined:            ${diffs.length}');
  stdout.writeln('Raw candidates from the map diff:    $rawCandidates');
  stdout.writeln('  ... reachable anyway (fallback):   $fallback');
  stdout.writeln('  ... unverified (not measurable):   $unverified');
  stdout.writeln(
    '      ... with a stated reason:      '
    '${explained.fold<int>(0, (s, d) => s + d.unverifiedCount)} '
    'in ${explained.length} classes',
  );
  stdout.writeln(
    '      ... no recipe yet (unfinished): '
    '${unexplained.fold<int>(0, (s, d) => s + d.unverifiedCount)} '
    'in ${unexplained.length} classes',
  );
  stdout.writeln('CONFIRMED unreachable members:       $totalGaps');
  stdout.writeln('Classes with >=1 confirmed gap:      $withGaps');
  stdout.writeln('');
  // Operator and Universal are broken out rather than folded into Confirmed:
  // a row reading `Confirmed 1 | Instance 0 | Static 0` was unreadable, and
  // these two columns spent long enough being invisible.
  stdout.writeln(
    '| Class | Native type | Confirmed | Instance | Static '
    '| Operator | Universal | Unverified |',
  );
  stdout.writeln('| --- | --- | --- | --- | --- | --- | --- | --- |');
  for (final d in diffs) {
    // A class with 38 unverified members and no confirmed gap used to be
    // filtered out here, so the unverified total appeared in the summary with
    // nothing in the report accounting for it — a fresh instance of the very
    // invisible-column hazard this audit exists to avoid. Unverified is a
    // reportable state, so it earns a row.
    if (d.gapCount == 0 && d.unverifiedCount == 0 && d.error == null) continue;
    stdout.writeln(
      '| ${d.name} | ${d.nativeTypeName} | ${d.gapCount} '
      '| ${d.missingInstance.length} | ${d.missingStatic.length} '
      '| ${d.missingOperators.length} | ${d.missingUniversal.length} '
      '| ${d.unverifiedCount} |${d.error == null ? '' : ' ${d.error}'}',
    );
  }

  if (unverifiedClasses.isNotEmpty) {
    stdout.writeln('');
    stdout.writeln('Why each unverified class cannot be measured:');
    stdout.writeln('');
    stdout.writeln('| Class | Unverified | Reason |');
    stdout.writeln('| --- | --- | --- |');
    for (final d in unverifiedClasses) {
      stdout.writeln(
        '| ${d.name} | ${d.unverifiedCount} '
        '| ${d.notAuditableReason ?? '**no recipe written yet**'} |',
      );
    }
  }

  final jsonIndex = args.indexOf('--json');
  if (jsonIndex >= 0 && jsonIndex + 1 < args.length) {
    final out = File(args[jsonIndex + 1]);
    out.parent.createSync(recursive: true);
    out.writeAsStringSync(
      const JsonEncoder.withIndent(
        '  ',
      ).convert(diffs.map((d) => d.toJson()).toList()),
    );
    stdout.writeln('\nJSON written to ${out.path}');
  }

  // See the `--hierarchy` branch: a probe that bound a port leaves the event
  // loop non-empty, so an explicit exit is what ends the run.
  exit(0);
}
