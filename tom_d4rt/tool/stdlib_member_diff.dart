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
import 'package:tom_d4rt/src/unbridged_reasons.dart';
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

/// Adapter keys that are REAL Dart extension members on the native type.
///
/// SCD23. `extraBridged` used to hold these mixed in with genuine defects, and
/// that is dangerous rather than untidy: the column reads as a list of things to
/// delete, and deleting these breaks `list.firstOrNull` for every script while
/// the test suites stay green. SCC8 came within one step of doing exactly that
/// on the first entry it looked at.
///
/// THE BLINDNESS IS STRUCTURAL, not a bug in this tool. The oracle is
/// `dart:mirrors`, which reports DECLARATIONS ON A TYPE. An extension declares
/// nothing on the type it extends — it is a separate top-level declaration with
/// a static dispatch rule — so no mirror walk can ever see an extension member,
/// and no amount of walking superinterfaces changes that. Every extension member
/// a bridge correctly offers therefore lands in `extraBridged`, permanently.
///
/// A HAND-WRITTEN ALLOWLIST IS THE RIGHT SHAPE for this, not a stopgap. The set
/// is small, it changes only when the SDK adds an extension, and it fails in the
/// safe direction: a missing entry reports a correct bridge as unexplained,
/// which is a question; a stale entry is caught by [_staleExtensionAllowlist]
/// below rather than silently hiding a defect. Teaching the tool to read the
/// SDK's extension declarations with the analyzer would be a real front end and
/// a much larger change — worth it only if this list becomes troublesome.
///
/// Every entry was cleared by the verification recipe rather than by reading the
/// bridge: a one-liner using the member on the NATIVE type, run through
/// `dart analyze`. All fifteen compile; `isCreate`, `asUint8ListView` and the
/// four `InternetAddressType` members do not, which is why they are absent here.
const Map<String, Set<String>> _knownExtensionMembers = {
  // `IterableExtensions` / `ListExtensions` (dart:core).
  'Iterable': {
    'elementAtOrNull',
    'firstOrNull',
    'indexed',
    'lastOrNull',
    'singleOrNull',
  },
  'List': {
    'elementAtOrNull',
    'firstOrNull',
    'indexed',
    'lastOrNull',
    'singleOrNull',
    // `EnumByName`, which extends `Iterable<T extends Enum>`. Legal on a List
    // whose elements are an enum, which is the case the bridge offers it for.
    'byName',
  },
  // `EnumName` (dart:core). Reached on every bridged enum, not only `Enum`
  // itself — which is why a second entry appears here for a concrete one.
  'Enum': {'name'},
  'HttpClientResponseCompressionState': {'name'},
  // `FutureExtensions` (dart:async).
  'Future': {'ignore', 'onError'},
};

/// The report for one bridged class.
class ClassDiff {
  ClassDiff(this.name, this.nativeTypeName, {this.nativeType});

  final String name;
  final String nativeTypeName;

  /// The bridge's native type, kept alongside its printed name because the
  /// operator probe needs to read the SDK signature off the mirror to derive a
  /// well-typed right-hand operand (SCD39). Nullable so a hand-built
  /// `ClassDiff` in a test stays cheap to construct.
  final Type? nativeType;

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

  /// Adapter keys with no matching SDK member and NO recorded explanation.
  ///
  /// SCD23 split this. It used to hold the known extension members too, which
  /// made it read as a defect list while being roughly half correct bridges —
  /// and the correct half is the half a tidy-up deletes. What is left here is
  /// the part that genuinely wants a verdict: a declared convenience, or a
  /// FABRICATION, which is the one bridge defect no passing test can catch. A
  /// member the SDK lacks makes every script using it green in the interpreter
  /// and uncompilable as Dart, so the error surfaces only when the script moves
  /// to real Dart.
  final extraBridged = <String>[];

  /// Adapter keys that are real Dart extension members on the native type.
  ///
  /// Not a defect and not a candidate: `dart:mirrors` structurally cannot see
  /// these. See [_knownExtensionMembers] for why the list is hand-written.
  final extraBridgedKnownExtension = <String>[];

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
    'extraBridgedKnownExtension': extraBridgedKnownExtension,
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
  final diff = ClassDiff(
    name,
    bc.nativeType.toString(),
    nativeType: bc.nativeType,
  );

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

  final knownExtensions = _knownExtensionMembers[bc.name] ?? const <String>{};
  for (final m in bridgedInstance) {
    if (!sdk.instance.contains(m) && !_universalObjectMembers.contains(m)) {
      if (knownExtensions.contains(m)) {
        diff.extraBridgedKnownExtension.add(m);
      } else {
        diff.extraBridged.add(m);
      }
    }
  }

  diff.missingInstance.sort();
  diff.missingStatic.sort();
  diff.missingOperators.sort();
  diff.missingUniversal.sort();
  diff.extraBridged.sort();
  diff.extraBridgedKnownExtension.sort();
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

/// Members measured as unreachable ON PURPOSE, keyed `Class.member`.
///
/// `confirmedGaps` answers "what is broken". Until this table existed it also
/// silently held "what we decided not to bridge", and the two are different
/// claims: one is a backlog, the other is a design boundary. A reader could not
/// tell them apart, so the backlog looked permanent and the decisions looked
/// like neglect. The three `ByteBuffer` views below had been a recorded
/// decision — doc row and pinned test — for a whole release while still sitting
/// in `confirmedGaps` as if nobody had got to them.
///
/// The reason here is one line and a pointer, never the argument itself. The
/// argument lives in `doc/d4rt_limitations.md` § Intentionally-Unbridged SDK
/// Classes, which is also what the disposition rule requires: every unbridged
/// name carries either a tracked todo or a table row with a case in
/// `test/stdlib/intentionally_unbridged_test.dart`. Restating it here would
/// give the same decision two homes that can disagree.
///
/// A member that merely has not been got to yet does NOT belong here — it
/// belongs in `confirmedGaps`, where it reads as the work it is.
/// Supertype edges the audit must not report as defects, because not declaring
/// them is a decision the stdlib made uniformly.
///
/// The hierarchy half had no equivalent of the member-level decision table
/// until SCC89 needed one. The member half has had one since SCB29, and for the
/// same reason: an audit that cannot distinguish "nobody did this" from "we
/// decided not to" reports both as gaps, and a gap nobody intends to close
/// teaches readers to skip the section.
const _declinedEdges = <String, Map<String, String>>{
  'HttpClientResponseCompressionState': {'Enum': _enumSupertypeNotModelled},
};

const _enumSupertypeNotModelled =
    'the stdlib bridges every enum as a BridgedClass with staticGetters rather '
    'than a BridgedEnumDefinition, and no bridged enum declares an `-> Enum` '
    'edge. Declaring it for this one would make it the only enum in the '
    'library that does. Whether they all should is a real question and is '
    'filed as SCD207 -- until it is answered, the uniform convention is the '
    'decision, not an oversight. This class is the only enum the audit can see '
    'the edge on at all, because SCC89 gave it the instance recipe that made '
    'it measurable.';

/// Whether `Class -> Supertype` is a recorded decision rather than a defect.
bool _isDeclinedEdge(String className, String supertype) =>
    _declinedEdges[className]?.containsKey(supertype) ?? false;

/// Strip the declined edges out of [gaps] and return how many were removed.
///
/// Called by the report and by `test/doc/gap_audit_figures_test.dart`, which
/// checks the doc's printed figures against a live run. It exists as a function
/// rather than a loop inside the report for that reason: a second copy in the
/// test would be a second thing to keep in step, and the figure it produces is
/// exactly what the doc quotes.
///
/// Declined edges are removed before anything counts them, so every downstream
/// figure and the rendered table agree, and reported separately, because a
/// decision that stops being visible stops being reviewable.
int applyDeclinedEdges(List<HierarchyGap> gaps) {
  var total = 0;
  for (final gap in gaps) {
    final declined = gap.missingEdges
        .where((e) => _isDeclinedEdge(gap.name, e))
        .toList();
    if (declined.isEmpty) continue;
    total += declined.length;
    gap.declinedEdges
      ..addAll(declined)
      ..sort();
    gap.missingEdges.removeWhere((e) => _isDeclinedEdge(gap.name, e));
  }
  return total;
}

/// Whether `Class.member` is a recorded decision rather than a defect.
///
/// Reads `kUnbridgedMemberReasons` from `lib/` rather than a copy. SCC91 gave
/// that map to the interpreter so a declined member explains itself at the
/// point of failure, and it held exactly the five keys this tool was already
/// carrying privately. Two tables of the same five decisions, in the same
/// `Class.member` shape, is one table too many: the one the error message uses
/// is the one that cannot go stale unnoticed, so the audit defers to it.
bool _isDeclined(String className, String member) =>
    kUnbridgedMemberReasons.containsKey('$className.$member');

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
  // SCC89: the hierarchy audit's last unverified class. An enum, so the recipe
  // is a value read — the same shape as `StdioType` above, and missing for the
  // same reason: nobody had asked the audit about it, not because it was hard.
  'HttpClientResponseCompressionState': Recipe(
    'HttpClientResponseCompressionState.notCompressed',
    imports: "import 'dart:io';",
  ),
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
  // The three classes SCC61..SCC63 bridged arrived without recipes, so 73
  // members went straight into the unmeasurable bucket and the audit stopped
  // being able to see the surface it had just gained. Both server-side recipes
  // below drive a real round trip, which is the only way to obtain either
  // value — neither type has a constructor.
  'WebSocketTransformer': Recipe(
    'WebSocketTransformer()',
    imports: "import 'dart:io';",
  ),
  // SCD45: the reason this class carried for a release was that an HTTP round
  // trip "does not finish inside the interpreter -- the probe hangs rather than
  // answering". It does finish. Measured under a wall clock, the shape below
  // returns `[200, OK, _HttpClientResponse, true, false, true]` in well under a
  // second, and `test/stdlib/io/http_client_request_test.dart` pins the same
  // round trip.
  //
  // The response is a `Stream<List<int>>`, so a bare read of an inherited
  // getter (`first`, `length`, `isEmpty`) SUBSCRIBES -- the hazard the `Stdin`
  // entry in `_notAuditable` documents. It is safe here and not there: this
  // stream is a real HTTP body that the server closes, so a subscription
  // completes instead of capturing a process-wide file descriptor. The body is
  // deliberately non-empty, so a probe that drains it gets data rather than the
  // `StateError` an empty stream raises for `first`.
  'HttpClientResponse': Recipe(
    '_auditClientResponse()',
    imports: "import 'dart:async';\nimport 'dart:io';",
    prelude:
        'HttpServer? _auditRespServer;'
        'HttpClient? _auditRespClient;'
        'Future<HttpClientResponse> _auditClientResponse() async {'
        "  final server = await HttpServer.bind('127.0.0.1', 0);"
        '  _auditRespServer = server;'
        '  server.listen((r) async {'
        "    r.response.write('pong');"
        '    await r.response.close();'
        '  });'
        '  final client = HttpClient();'
        '  _auditRespClient = client;'
        '  final request = await client.getUrl('
        "      Uri.parse('http://127.0.0.1:\${server.port}/audit'));"
        '  return await request.close();'
        '}',
    isAsync: true,
    teardown:
        '_auditRespClient?.close(force: true); '
        'await _auditRespServer?.close(force: true);',
  ),
  // SCD44: both of these were `_notAuditable` because the value
  // `HttpClient.getUrl` yields was said to arrive bridged as its `IOSink`
  // supertype, hiding every `HttpClientRequest` member. It is not: bridge
  // selection resolves `_HttpClientRequest` to `HttpClientRequest` by the
  // `_Foo -> Foo` name canonicalization, which runs BEFORE any ancestor or
  // `isAssignable` scan. Measured end to end -- a loopback round trip reads
  // `request.headers`, sets one and closes the request.
  //
  // The server is kept alive in `_auditServer` rather than closed inside the
  // prelude: the request is not usable once its connection is gone, and a
  // probe that measured a dead request would report the whole class missing.
  'HttpClientRequest': Recipe(
    '_auditClientRequest()',
    imports: "import 'dart:async';\nimport 'dart:io';",
    prelude:
        'HttpServer? _auditReqServer;'
        'HttpClient? _auditReqClient;'
        'Future<HttpClientRequest> _auditClientRequest() async {'
        "  final server = await HttpServer.bind('127.0.0.1', 0);"
        '  _auditReqServer = server;'
        '  server.listen((r) async {'
        '    await r.response.close();'
        '  });'
        '  final client = HttpClient();'
        '  _auditReqClient = client;'
        '  return await client.getUrl('
        "      Uri.parse('http://127.0.0.1:\${server.port}/audit'));"
        '}',
    isAsync: true,
    teardown:
        '_auditReqClient?.close(force: true); '
        'await _auditReqServer?.close(force: true);',
  ),
  // Only reachable through `HttpClientRequest.headers`, which is why it shared
  // that entry's fate.
  'HttpHeaders': Recipe(
    '_auditHeaders()',
    imports: "import 'dart:async';\nimport 'dart:io';",
    prelude:
        'HttpServer? _auditHdrServer;'
        'HttpClient? _auditHdrClient;'
        'Future<HttpHeaders> _auditHeaders() async {'
        "  final server = await HttpServer.bind('127.0.0.1', 0);"
        '  _auditHdrServer = server;'
        '  server.listen((r) async {'
        '    await r.response.close();'
        '  });'
        '  final client = HttpClient();'
        '  _auditHdrClient = client;'
        '  final request = await client.getUrl('
        "      Uri.parse('http://127.0.0.1:\${server.port}/audit'));"
        '  return request.headers;'
        '}',
    isAsync: true,
    teardown:
        '_auditHdrClient?.close(force: true); '
        'await _auditHdrServer?.close(force: true);',
  ),
  'HttpRequest': Recipe(
    '_auditHttpRequest()',
    imports: "import 'dart:async';\nimport 'dart:io';",
    prelude:
        'HttpServer? _auditServer;'
        'Future<HttpRequest> _auditHttpRequest() async {'
        "  final server = await HttpServer.bind('127.0.0.1', 0);"
        '  _auditServer = server;'
        '  final client = HttpClient();'
        '  final request = await client.getUrl('
        "      Uri.parse('http://127.0.0.1:\${server.port}/audit'));"
        '  unawaited(request.close());'
        '  final received = await server.first;'
        '  client.close(force: true);'
        '  return received;'
        '}',
    isAsync: true,
    // One probe program runs per member, so the bound port has to go back.
    // The request is only released once its response is closed, and the
    // server only once it is no longer holding the connection.
    teardown:
        'await o.response.close(); '
        'await _auditServer?.close(force: true);',
  ),
  'WebSocket': Recipe(
    '_auditWebSocket()',
    imports: "import 'dart:async';\nimport 'dart:io';",
    prelude:
        'Future<WebSocket> _auditWebSocket() async {'
        "  final server = await HttpServer.bind('127.0.0.1', 0);"
        '  final port = server.port;'
        '  unawaited(server.first.then((request) async {'
        '    final peer = await WebSocketTransformer.upgrade(request);'
        '    await peer.close();'
        '  }));'
        "  final socket = await WebSocket.connect('ws://127.0.0.1:\$port/');"
        '  await server.close(force: true);'
        '  return socket;'
        '}',
    isAsync: true,
    teardown: 'await o.close();',
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

/// Literal expressions for an operator's right-hand operand, by the SDK
/// parameter type the operator declares.
///
/// Keyed by TYPE, like `_argumentLiterals`, so the table does not grow a row
/// per class. `Object` and `dynamic` are absent deliberately: a class is always
/// assignable to them, so the self-operand rule answers first and is the more
/// faithful probe.
const _operandLiterals = <String, String>{
  'int': '1',
  'num': '1',
  'double': '1.0',
  'bool': 'true',
  'String': "'a'",
  'Pattern': "'a'",
  'Duration': 'Duration(seconds: 1)',
  'BigInt': 'BigInt.one',
};

/// Index operators want a valid index, not an arbitrary one. The recipes yield
/// small collections, so `1` is frequently out of range where `0` is not, and
/// a RangeError is a different failure from an unresolved operator.
const _indexOperators = <String>{'[]', '[]='};

/// How to exercise each operator. `%r%` is the right-hand operand and `%v%` the
/// assigned value; both are synthesised per class from the SDK signature by
/// [_operatorProbeFor].
const _operatorProbes = <String, String>{
  '+': 'o + %r%',
  '-': 'o - %r%',
  '*': 'o * %r%',
  '/': 'o / %r%',
  '~/': 'o ~/ %r%',
  '%': 'o % %r%',
  '&': 'o & %r%',
  '|': 'o | %r%',
  '^': 'o ^ %r%',
  '<': 'o < %r%',
  '<=': 'o <= %r%',
  '>': 'o > %r%',
  '>=': 'o >= %r%',
  '==': 'o == %r%',
  '<<': 'o << %r%',
  '>>': 'o >> %r%',
  '>>>': 'o >>> %r%',
  '~': '~o',
  'unary-': '-o',
  '[]': 'o[%r%]',
  '[]=': 'o[%r%] = %v%',
};

/// One operand expression, or the reason there cannot be one.
typedef _Operand = ({String? expr, String? reason});

/// The expression to use for a parameter of [param] on [nativeType].
///
/// Self-operand FIRST when it type-checks: `o + o` exercises the operator with
/// a value of exactly the kind the class is built from, which is the most
/// faithful probe available and is what every operator whose signature admits
/// its own type should use. A literal is the fallback for the operators whose
/// right-hand type is something else — `String * int` is the case SCD39 was
/// filed for.
_Operand _operandFor(ClassMirror root, TypeMirror param, String op) {
  // A type variable (`Map`'s `K`/`V`, `List`'s `E`) names no concrete type the
  // table could hold. The self-operand is the right answer and is genuinely
  // well-typed at the boundary, because the bridge erases type arguments --
  // every bridged collection is instantiated at `dynamic`, so any value
  // satisfies the parameter. Stated rather than left to `isSubtypeOf`, which
  // happens to answer true here for reasons that have nothing to do with that.
  if (param is TypeVariableMirror) return (expr: 'o', reason: null);
  try {
    if (root.isSubtypeOf(param)) return (expr: 'o', reason: null);
  } catch (_) {
    // Not comparable; fall through to the literal table.
  }
  final bare = _bareTypeName(param);
  if (_indexOperators.contains(op) && (bare == 'int' || bare == 'num')) {
    return (expr: '0', reason: null);
  }
  final literal = _operandLiterals[bare];
  if (literal != null) return (expr: literal, reason: null);
  return (
    expr: null,
    reason:
        'the operator takes a `$bare`, which the class is not assignable to '
        'and for which no operand literal is defined',
  );
}

/// The probe source for [op] on [className], or the reason there is none.
///
/// WHY A WELL-TYPED OPERAND IS THE WHOLE POINT. The interpreter's final
/// fallthrough for a binary expression is
/// `Unsupported operator (STAR) for types String and String`, and that one
/// wording covers BOTH "this operator does not resolve" and "these operand
/// types are wrong". While the probe drove every operator with the instance on
/// both sides, the two were indistinguishable: `'a' * 'a'` throws it, so
/// `String *` read as reachable whatever the truth. Deriving the operand from
/// the SDK signature removes the second meaning, which is what makes the
/// wording safe to classify on -- see [_isUnreachableOperatorError].
({String? probe, String? reason}) _operatorProbeFor(
  String className,
  Type nativeType,
  String op,
) {
  final template = _operatorProbes[op];
  if (template == null) {
    return (probe: null, reason: 'no probe template for `$op`');
  }
  if (!template.contains('%r%')) return (probe: template, reason: null);

  final decl = _declaredMember(nativeType, op, static: false);
  if (decl == null) {
    // `int >>>` is the live instance: the mirror does not surface it, so there
    // is no signature to derive an operand from. Reported rather than guessed,
    // because guessing `1` here would be assuming the very thing the probe is
    // supposed to establish.
    return (
      probe: null,
      reason:
          'the SDK signature for `$op` is not reflectable, so no operand can '
          'be derived',
    );
  }

  final ClassMirror root;
  try {
    final r = reflectType(nativeType);
    if (r is! ClassMirror) {
      return (probe: null, reason: 'native type is not a class mirror');
    }
    root = r;
  } catch (_) {
    return (probe: null, reason: 'native type is not reflectable');
  }

  final params = decl.parameters;
  if (params.isEmpty) {
    return (probe: null, reason: '`$op` declares no parameter to supply');
  }

  final rhs = _operandFor(root, params.first.type, op);
  if (rhs.expr == null) return (probe: null, reason: rhs.reason);
  var probe = template.replaceAll('%r%', rhs.expr!);

  if (probe.contains('%v%')) {
    if (params.length < 2) {
      return (probe: null, reason: '`$op` declares no value parameter');
    }
    final value = _operandFor(root, params[1].type, op);
    if (value.expr == null) return (probe: null, reason: value.reason);
    probe = probe.replaceAll('%v%', value.expr!);
  }
  return (probe: probe, reason: null);
}

/// Test/diagnostic access to [_operatorProbeFor].
({String? probe, String? reason}) operatorProbeForDebug(
  String className,
  Type nativeType,
  String op,
) => _operatorProbeFor(className, nativeType, op);

/// Operator probes that could not be made well-typed, and why.
///
/// `'<class>.<op>' -> reason`. An operator with no valid probe is UNVERIFIED
/// WITH A REASON rather than skipped: skipping is how these ended up classified
/// as reachable in the first place, and an unexplained hole is what SCC12
/// established the member columns must not have.
final operatorProbeSkips = <String, String>{};

/// Whether [message] means the operator did not resolve.
///
/// Extends the shared wordings with the binary-expression fallthrough, which is
/// only unambiguous BECAUSE the operand is derived from the SDK signature. Do
/// not move this into `_isUnreachableError`: that function also classifies
/// member and hierarchy probes, where an ill-typed expression is still possible
/// and would then be reported as a gap the tool invented.
bool _isUnreachableOperatorError(String message) =>
    _isUnreachableError(message) || message.contains('Unsupported operator (');

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
/// `try`**. That was originally load-bearing rather than stylistic: in an async
/// function, an error raised inside a `try` with a non-empty `finally` and no
/// `catch` was discarded and the function completed with the finally block's
/// last evaluated value. With `try { return o.member; } finally { await
/// o.close(); }` a bound `ServerSocket` reported *every* missing member as
/// present — the program completed and yielded the socket.
///
/// SCD40 fixed the interpreter, so the obvious shape is now correct too. This
/// one is kept anyway, for two reasons that outlive the fix: the audit is the
/// instrument that has to be trusted when the interpreter is wrong, so it
/// should not depend on interpreter behaviour it can avoid depending on; and
/// the twins resolve the interpreter from pub.dev (DGUC6), so a probe written
/// to the fixed semantics would silently mis-measure against an older release.
/// Do not "simplify" it.
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
Future<Reach> verifyOperator(
  String className,
  String op, {
  Type? nativeType,
}) async {
  final recipe = _instanceRecipes[className];
  if (recipe == null) return Reach.unverified;
  if (nativeType == null) return Reach.unverified;

  final built = _operatorProbeFor(className, nativeType, op);
  final reason = built.reason;
  if (reason != null) {
    operatorProbeSkips['$className.$op'] = reason;
    return Reach.unverified;
  }

  _traceProbe('$className $op');
  final outcome = await _runProbe(_recipeSource(recipe, built.probe!));
  // A probe that never answers is REACHABLE for the same reason a member read
  // is: the recipe already works and an unresolved operator throws instantly,
  // so a program still running got past the dispatch.
  if (!outcome.answered) return Reach.reachable;
  final error = outcome.error;
  if (error == null) return Reach.reachable;
  return _isUnreachableOperatorError(error)
      ? Reach.confirmedMissing
      : Reach.reachable;
}

/// Import directives for classes that have statics worth probing but no
/// instance recipe to borrow an import from.
///
/// SCD44: `Platform` is the clear case -- it is all statics and has no public
/// constructor, so no instance recipe will ever exist for it, yet its statics
/// are exactly what a script reaches for. Without an import the probe cannot
/// even name the class.
const _staticOnlyImports = <String, String>{
  'ConnectionTask': "import 'dart:io';",
  'Platform': "import 'dart:io';",
  'RawSocketOption': "import 'dart:io';",
};

Future<Reach> verifyStaticMember(String className, String member) {
  // Statics need no instance, so every class can be verified -- PROVIDED the
  // class name is in scope. The import is whatever the instance recipe used,
  // when there is one, and [_staticOnlyImports] otherwise.
  final imports =
      _instanceRecipes[className]?.imports ??
      _staticOnlyImports[className] ??
      '';
  _traceProbe('$className.$member (static)');
  return _probeStatic(
    className,
    '$imports main() { return $className.$member; }',
  );
}

/// Runs a static-member probe and refuses to score it when the CLASS did not
/// resolve.
///
/// SCD44: a class with no instance recipe gets a probe with no imports, so
/// `HttpHeaders.acceptRangesHeader` failed with `Undefined variable:
/// HttpHeaders` -- the class, not the member. That wording is not one of the
/// audit's unreachable wordings, so the probe was scored **reachable**, and
/// every static of every recipe-less class outside `dart:core` passed silently.
/// Measured: 45 genuinely missing `HttpHeaders` constants read as present until
/// this todo gave the class a recipe.
///
/// Scored UNVERIFIED rather than as a gap, which is the conservative direction
/// the audit moves in everywhere: a probe that could not name the class
/// measured nothing about its members. Giving the class a recipe -- or any
/// import -- is what makes it measurable.
Future<Reach> _probeStatic(String className, String source) async {
  final outcome = await _runProbe(source);
  // A probe that never answers is reachable for the usual reason: an
  // unresolved member throws instantly, so a program still running got past
  // the lookup.
  if (!outcome.answered) return Reach.reachable;
  final error = outcome.error;
  if (error == null) return Reach.reachable;
  if (error.contains('Undefined variable: $className')) {
    staticProbeSkips[className] =
        'the probe has no import for `$className`, so the class name does not '
        'resolve and nothing about its statics was measured; give the class an '
        'instance recipe (its `imports` are reused here)';
    return Reach.unverified;
  }
  return _isUnreachableError(error) ? Reach.confirmedMissing : Reach.reachable;
}

/// Classes whose static probes could not name the class, and why.
///
/// Printed at the end of a run for the same reason `operatorProbeSkips` is: an
/// unmeasurable column has to say so rather than read as a pass.
final staticProbeSkips = <String, String>{};

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
        ? await verifyOperator(diff.name, m, nativeType: diff.nativeType)
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
        ? await verifyOperator(diff.name, m, nativeType: diff.nativeType)
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

  /// Candidate edges [applyDeclinedEdges] removed because `_declinedEdges`
  /// says they are deliberate.
  ///
  /// SCD47: recorded rather than merely counted, so the baseline can pin them.
  /// A declined edge measures exactly like a confirmed one — `o is T` answers
  /// false — and the difference is why, not whether; without the list, a
  /// decision being silently reversed is indistinguishable from a gap closing.
  final declinedEdges = <String>[];

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
    'declinedEdges': declinedEdges,
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

/// Phase 2 over [gaps], in place — the edge counterpart of [verifyAll].
///
/// SCD47: extracted so the CLI and `hierarchy_baseline_test.dart` run the SAME
/// walk. The member half learned this in SCC13: a test that re-implements the
/// audit tests its own copy, and the two drift in exactly the direction that
/// makes the guard agree with whatever the tool now does.
Future<void> verifyAllEdges(
  List<HierarchyGap> gaps,
  Environment env, {
  void Function(String name, int candidates)? onClass,
}) async {
  for (final g in gaps) {
    if (g.missingEdges.isNotEmpty) onClass?.call(g.name, g.missingEdges.length);
    await verifyHierarchy(g, env);
  }
}

/// The generated source of `test/stdlib/hierarchy_baseline.dart`.
///
/// Mirrors [renderBaselineSource] deliberately, down to the header warning: the
/// two baselines are read by two tests with the same four-way split, and a
/// reader who has met one should not have to learn the other.
String renderHierarchyBaselineSource(List<HierarchyGap> gaps) {
  final buffer = StringBuffer();

  String entries(
    Iterable<HierarchyGap> source,
    List<String> Function(HierarchyGap) pick,
  ) {
    final b = StringBuffer();
    for (final g in source.toList()..sort((a, b) => a.name.compareTo(b.name))) {
      final values = pick(g);
      if (values.isEmpty) continue;
      b.writeln("  '${g.name}': [");
      for (final v in values..sort()) {
        b.writeln("    r'$v',");
      }
      b.writeln('  ],');
    }
    return b.toString();
  }

  final confirmed = gaps.where((g) => g.missingEdges.isNotEmpty);
  final declined = gaps.where((g) => g.declinedEdges.isNotEmpty);
  final unmeasurable = gaps.where((g) => g.unverifiedEdges.isNotEmpty);
  final measured =
      (gaps.where((g) => g.recipeUsable).map((g) => g.name).toList()..sort());

  int count(
    Iterable<HierarchyGap> s,
    List<String> Function(HierarchyGap) pick,
  ) => s.fold(0, (t, g) => t + pick(g).length);

  buffer.writeln('''
// GENERATED — regenerate with:
//   dart run tool/stdlib_member_diff.dart --hierarchy --baseline
//
// The standing SUPERTYPE-EDGE baseline for the `dart:*` stdlib bridges, read by
// `hierarchy_baseline_test.dart`. Do not hand-edit: a hand-edited entry is an
// assertion about the interpreter that nothing measured.
//
// A missing edge is the more expensive of the two defects this tool finds. It
// costs the whole inherited surface at once rather than one member, and it makes
// `is` and `on` answer wrongly — `LinkedList` went from 27 unreachable members
// to 2 when one edge was declared. The member baseline DOES catch a deleted
// edge, but reports it as N unrelated member regressions; this one names the
// edge.
//
// Current state: ${count(confirmed, (g) => g.missingEdges)} confirmed missing edges across ${confirmed.length} classes,
// ${count(declined, (g) => g.declinedEdges)} edges on ${declined.length} classes missing by decision,
// and ${count(unmeasurable, (g) => g.unverifiedEdges)} edges on ${unmeasurable.length} classes that cannot be measured at all.
// Those totals are documentation, not assertions — the test derives them from the
// tables below, so there is only ever one thing to update.
''');

  buffer.writeln(
    '/// Edges proven absent through the interpreter (`o is T` answered false).',
  );
  buffer.writeln('const confirmedEdges = <String, List<String>>{');
  buffer.write(entries(confirmed, (g) => g.missingEdges));
  buffer.writeln('};\n');

  buffer.writeln(
    '/// Edges deliberately not declared — see `_declinedEdges` in the tool.',
  );
  buffer.writeln('const declinedEdges = <String, List<String>>{');
  buffer.write(entries(declined, (g) => g.declinedEdges));
  buffer.writeln('};\n');

  buffer.writeln('''
/// Edges no probe could measure.
///
/// Pinned for the reason SCC13 learned the hard way on the member side: without
/// it, `unverified -> confirmed` is indistinguishable from
/// `reachable -> confirmed`, so adding an instance recipe would read as a wave
/// of fresh regressions rather than as new information.''');
  buffer.writeln('const unmeasurableEdges = <String, List<String>>{');
  buffer.write(entries(unmeasurable, (g) => g.unverifiedEdges));
  buffer.writeln('};\n');

  buffer.writeln('''
/// Classes whose instance recipe yielded an instance when this was taken.
///
/// The floor under the tolerance above: a recipe that stops working turns every
/// one of its class's edges UNVERIFIED, and an unverified edge is not asserted
/// about. Without pinning which classes COULD be measured, the guard can go
/// dark and still report success.''');
  buffer.writeln('const measuredEdgeClasses = <String>{');
  for (final n in measured) {
    buffer.writeln("  '$n',");
  }
  buffer.writeln('};');

  return buffer.toString();
}

Future<void> runHierarchyAudit(Environment env, List<String> args) async {
  final gaps = auditHierarchy(env);
  final candidateEdges = gaps.fold<int>(0, (s, g) => s + g.missingEdges.length);

  if (!args.contains('--no-verify')) {
    stderr.writeln(
      'Verifying $candidateEdges candidate edges against the '
      'interpreter...',
    );
    await verifyAllEdges(gaps, env);
    gaps.sort((a, b) {
      final byCount = b.missingEdges.length.compareTo(a.missingEdges.length);
      return byCount != 0 ? byCount : a.name.compareTo(b.name);
    });
  }

  final declinedEdgeTotal = applyDeclinedEdges(gaps);

  // SCD47: the edge half now has a standing baseline too. Written after
  // `applyDeclinedEdges` so the declined list is populated, and before the
  // report so a `--baseline` run does not also print a table nobody asked for.
  if (args.contains('--baseline')) {
    final path =
        _optionValue(args, '--baseline-out') ??
        'test/stdlib/hierarchy_baseline.dart';
    File(path).writeAsStringSync(renderHierarchyBaselineSource(gaps));
    final formatted = Process.runSync('dart', ['format', path]);
    if (formatted.exitCode != 0) {
      stderr.writeln(
        'Baseline written but `dart format` failed; the diff will be mostly '
        're-wrapping:\n${formatted.stderr}',
      );
    }
    stdout.writeln('Hierarchy baseline written to $path');
    return;
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
  stdout.writeln(
    '  ... missing BY DECISION:           $declinedEdgeTotal '
    '(see _declinedEdges)',
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
/// Four things are pinned, and the choice of which four is the whole design:
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
///   * **the registry itself** — every bridge name live in the environment.
///     The other three describe classes the audit has an OPINION about, and a
///     class earns an opinion by having a gap, a blind spot or a recipe. 109 of
///     the 205 bridged classes have none of those, so before SCD48 they were
///     pinned by nothing here. See `bridgedClasses` below for the two ways that
///     mattered.
///
/// The ~378 members that are reachable only via the supertype-chain fallback are
/// deliberately NOT pinned. They add no guard power — a member of that set going
/// bad shows up as "confirmed and absent from the baseline" either way — and they
/// would triple the file with names that carry no finding, turning a reviewable
/// list of known defects into a wall nobody reads. That is the same failure as a
/// count-only assertion, just in the other direction.
String renderBaselineSource(List<ClassDiff> diffs, Set<String> registry) {
  final confirmed = <String, List<String>>{};
  final unmeasurable = <String, List<String>>{};
  final measured = <String>[];

  final declined = <String, List<String>>{};

  for (final d in diffs) {
    if (d.recipeUsable) measured.add(d.name);
    final measuredGaps = <String>{
      ...d.missingInstance,
      ...d.missingStatic,
      ...d.missingOperators,
      ...d.missingUniversal,
    }.toList()..sort();
    // A measured gap is either a defect or a decision. Splitting them here is
    // what lets the guard demand that the defect list shrink while leaving the
    // decision list alone.
    final gaps = [
      for (final m in measuredGaps)
        if (!_isDeclined(d.name, m)) m,
    ];
    final byDesign = [
      for (final m in measuredGaps)
        if (_isDeclined(d.name, m)) m,
    ];
    if (byDesign.isNotEmpty) declined[d.name] = byDesign;
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
  final declinedTotal = declined.values.fold<int>(0, (s, l) => s + l.length);
  // The recipe-less classes. The tool already separated these from the ones
  // with a stated reason; the baseline records the split so the test can
  // demand it stay empty.
  final unfinished = [
    for (final d in diffs)
      if (d.unverifiedCount > 0 && d.notAuditableReason == null) d.name,
  ]..sort();

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
// Current state: ${registry.length} bridged classes registered; of those,
// $gapTotal confirmed-unreachable members across ${confirmed.length} classes,
// $declinedTotal members on ${declined.length} classes unreachable by decision,
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

/// Members unreachable BY DECISION, per bridged class. Each carries its reason
/// in `_declined` in the tool.
///
/// Separate from [confirmedGaps] because the two make different claims. A
/// confirmed gap is work not yet done and the guard wants that list to shrink;
/// a declined member is a boundary that was chosen, and shrinking it would mean
/// reversing a decision rather than fixing a defect.
const declinedMembers = <String, List<String>>{
${renderMap(declined)}};

/// Candidates that could not be measured, per bridged class. Each of these has a
/// stated reason in `_notAuditable` in the tool; they are pinned so that a member
/// moving out of this bucket is reported as the new information it is, rather
/// than as a fresh defect.
const unmeasurable = <String, List<String>>{
${renderMap(unmeasurable)}};

/// Classes carrying unmeasured members with NO stated reason — i.e. a bridged
/// class nobody has written an instance recipe for yet.
///
/// Pinned at empty on purpose. Three classes (`HttpRequest`, `WebSocket`,
/// `WebSocketTransformer`) sat here for a whole release cycle with 73 members
/// between them: they were bridged, no recipe followed, and the audit simply
/// stopped seeing that surface. Nothing failed, because the old baseline folded
/// them in with the classes that have a stated reason. Measuring them found a
/// real gap on the first run.
const unfinishedClasses = <String>{
${unfinished.map((n) => "  '$n',").join('\n')}
};

/// Classes whose instance recipe produced a usable instance when the baseline was
/// taken. A class dropping out of this list means its gaps stopped being
/// measured, which the test reports as a failure rather than as a pass.
const measuredClasses = <String>{
${measured.map((n) => "  '$n',").join('\n')}
};

/// Every bridge name live in a fully registered `Environment` — the vocabulary
/// a script with every `dart:` library imported can actually name.
///
/// The other four tables pin classes the audit has an opinion about. This one
/// pins the ones it does not, which on the 2026-09-12 measurement was 109 of
/// 205. Two changes reach those classes and were caught by nothing:
///
///   * a bridge's `name:` string changed. The definition is still declared and
///     still registered, so `F-SCB24-1` is green — under the NEW name. Every
///     script naming the old one breaks. Measured: renaming `FileLock` to
///     `FileLockZ` left all 3543 tests passing.
///   * a definition deleted together with its `defineBridge` call. Nothing
///     declares it, so there is no unregistered declaration for `F-SCB24-1`
///     to find.
///
/// Deleting only the `defineBridge` call is NOT in that set — `F-SCB24-1` has
/// covered it since 2026-09-06, and a class with a working recipe is covered by
/// `measuredClasses` above. This list is the remainder, not a second copy of
/// either.
const bridgedClasses = <String>{
${(registry.toList()..sort()).map((n) => "  '$n',").join('\n')}
};
''';
}

/// Reads a two-token option (`--only Foo,Bar`) out of [args].

// ---------------------------------------------------------------------------
// SCD36: the return-type pass.
// ---------------------------------------------------------------------------

/// What one registered member's returned value turned out to be worth.
enum ReturnReach {
  /// The value came back and a member its declared type guarantees could be
  /// read off it. This is the answer that matters — not "a value arrived".
  usable,

  /// The value came back and the interpreter could not resolve it to any
  /// bridge, so the script cannot do anything with it. The defect class this
  /// pass exists to find.
  gap,

  /// No argument could be synthesised for a required parameter, or the
  /// declared return type offered no witness member. Measured nothing.
  unprobed,

  /// The probe never answered. Measured nothing.
  noAnswer,
}

/// Literal expressions by SDK parameter type, used to call members that take
/// arguments.
///
/// Keyed by TYPE rather than by member, which is what makes the pass scale: a
/// per-member argument table would be the same per-case work the instance
/// recipes already cost, and the pass would then only cover members somebody
/// had already thought about — exactly the property that let this defect class
/// hide. The two members that motivated SCD36 both take one argument
/// (`Iterable.castFrom(Iterable)`, `LineSplitter.split(String)`), so a pass
/// restricted to no-argument members would have missed both.
const _argumentLiterals = <String, String>{
  'int': '1',
  'double': '1.0',
  'num': '1',
  'bool': 'true',
  'String': "'ab'",
  'Object': '1',
  'dynamic': '1',
  'Pattern': "'a'",
  'Comparable': '1',
  'Iterable': '[1, 2, 3]',
  'List': '[1, 2, 3]',
  'Set': '{1, 2}',
  'Map': "{'a': 1}",
  'Duration': 'Duration(seconds: 1)',
  'StackTrace': 'StackTrace.current',
};

/// Members that must not be probed, because calling them ends or blocks the
/// probe rather than returning a value.
///
/// This is not a list of things that are hard to measure — it is a list of
/// things whose measurement would destroy the measurement. A probe that calls
/// `exit` takes the isolate with it; one that calls `sleep` burns the idle
/// timeout and is scored as no-answer.
const _unprobableMembers = <String>{
  // Writers. These are the reason the list is not merely about probes that
  // hang: this pass CALLS members where the member diff only reads them, and a
  // called `dart:io` writer acts on the filesystem. `o.openWrite().done` left
  // an empty `audit_probe_does_not_exist` in the package root on every run --
  // the audit dirtying the tree it was auditing.
  //
  // Containment by moving the process working directory was tried first and is
  // wrong: `dart test` runs its files as isolates in ONE process, so setting
  // `Directory.current` from the doc-figures test changed it under every other
  // test file running concurrently. Three unrelated cases went red, and only
  // under `-j 4`. Exclusion is local; global state is not.
  'openWrite',
  'copy',
  'copySync',
  'createTemp',
  'createTempSync',
  'writeAsBytes',
  'writeAsBytesSync',
  'setLastModified',
  'setLastModifiedSync',
  'setLastAccessed',
  'setLastAccessedSync',
  'lock',
  'lockSync',
  'unlock',
  'unlockSync',
  'flush',
  'exit',
  'sleep',
  'abort',
  'clear',
  'close',
  'cancel',
  'destroy',
  'kill',
  'shutdown',
  'removeWhere',
  'retainWhere',
  'removeLast',
  'removeRange',
  'removeAt',
  'remove',
  'deleteSync',
  'delete',
  'renameSync',
  'rename',
  'createSync',
  'create',
  'writeAsStringSync',
  'writeAsString',
  'watch',
  'listen',
  'pause',
  'resume',
  'wait',
  'reduce',
  'single',
  'last',
  'first',
};

/// Getters that make good witnesses: cheap, total, and declared by the type
/// rather than inherited from `Object`.
///
/// Order is preference order. A witness must not throw on a legitimate value —
/// `first` and `single` do on an empty or multi-element iterable — because the
/// pass would then report a working member as a gap.
const _preferredWitnesses = <String>[
  'isEmpty',
  'isNotEmpty',
  'length',
  'iterator',
  'keys',
  'values',
  'entries',
  'inMilliseconds',
  'scheme',
  'path',
  'index',
  'name',
];

/// The SDK declaration of [member] on [type], instance or static.
MethodMirror? _declaredMember(
  Type type,
  String member, {
  required bool static,
}) {
  final ClassMirror root;
  try {
    final t = reflectType(type);
    if (t is! ClassMirror) return null;
    root = t;
  } catch (_) {
    return null;
  }

  final seen = <ClassMirror>{};
  final queue = <ClassMirror>[root];
  while (queue.isNotEmpty) {
    final cm = queue.removeAt(0);
    if (!seen.add(cm)) continue;
    Map<Symbol, DeclarationMirror> declarations;
    try {
      declarations = cm.declarations;
    } catch (_) {
      continue;
    }
    for (final entry in declarations.entries) {
      final decl = entry.value;
      if (decl is! MethodMirror) continue;
      if (decl.isConstructor) continue;
      if (decl.isStatic != static) continue;
      if (_symbolName(entry.key) != member) continue;
      return decl;
    }
    if (static) break; // statics do not inherit
    try {
      final sup = cm.superclass;
      if (sup != null && sup.reflectedType != Object) queue.add(sup);
      queue.addAll(cm.superinterfaces);
    } catch (_) {
      // best effort
    }
  }
  return null;
}

/// The bare name of a type mirror, without type arguments or nullability.
String _bareTypeName(TypeMirror t) {
  final raw = _symbolName(t.simpleName);
  final cut = raw.indexOf('<');
  return (cut < 0 ? raw : raw.substring(0, cut)).replaceAll('?', '');
}

/// A witness member on [returnType] — something the declared type promises,
/// whose absence therefore means the VALUE was not usable rather than that the
/// member was never bridged.
String? _witnessFor(TypeMirror returnType) {
  final ClassMirror cm;
  try {
    if (returnType is! ClassMirror) return null;
    cm = returnType;
  } catch (_) {
    return null;
  }

  final available = <String>{};
  final seen = <ClassMirror>{};
  final queue = <ClassMirror>[cm];
  while (queue.isNotEmpty) {
    final c = queue.removeAt(0);
    if (!seen.add(c)) continue;
    Map<Symbol, DeclarationMirror> declarations;
    try {
      declarations = c.declarations;
    } catch (_) {
      continue;
    }
    for (final entry in declarations.entries) {
      final name = _symbolName(entry.key);
      if (!_isPublic(name)) continue;
      if (_universalObjectMembers.contains(name)) continue;
      final decl = entry.value;
      final isGetter =
          (decl is MethodMirror && decl.isGetter && !decl.isStatic) ||
          (decl is VariableMirror && !decl.isStatic);
      if (isGetter) available.add(name);
    }
    try {
      final sup = c.superclass;
      if (sup != null && sup.reflectedType != Object) queue.add(sup);
      queue.addAll(c.superinterfaces);
    } catch (_) {
      // best effort
    }
  }

  for (final preferred in _preferredWitnesses) {
    if (available.contains(preferred)) return preferred;
  }
  final rest = available.toList()..sort();
  return rest.isEmpty ? null : rest.first;
}

/// The argument list to call [m] with, or null when some required parameter
/// has no literal.
String? _argumentsFor(MethodMirror m) {
  final parts = <String>[];
  for (final p in m.parameters) {
    if (p.isOptional) continue; // optional parameters are simply not passed
    final literal = _argumentLiterals[_bareTypeName(p.type)];
    if (literal == null) return null;
    parts.add(p.isNamed ? '${_symbolName(p.simpleName)}: $literal' : literal);
  }
  return parts.join(', ');
}

/// One member's result.
class ReturnGap {
  ReturnGap(
    this.className,
    this.member, {
    required this.isStatic,
    required this.declaredReturn,
  });

  final String className;
  final String member;
  final bool isStatic;
  final String declaredReturn;

  String? witness;
  ReturnReach reach = ReturnReach.unprobed;

  /// Why it was not probed, or what the interpreter said when it failed.
  String? detail;

  Map<String, dynamic> toJson() => {
    'class': className,
    'member': member,
    'static': isStatic,
    'declaredReturn': declaredReturn,
    'witness': witness,
    'reach': reach.name,
    if (detail != null) 'detail': detail,
  };
}

/// The receiver type named in a member-lookup failure, or null when the
/// message is not one.
///
/// Extracted rather than guessed at by substring. The bridge names are short
/// and appear INSIDE SDK implementation names — `_EfficientLengthCastIterable`
/// ends with `Iterable` — so a "does this message mention a bridge name" test
/// answers yes for the very case that is a gap.
String? lookupFailureReceiver(String message) {
  const patterns = [
    // The wording an UNBRIDGED native target produces. `core/map.dart` already
    // documents it against `_ConstMap`, and it is the one shape the audit's
    // shared `_isUnreachableError` has never recognised -- which is why this
    // pass reported zero until the negative control exposed it.
    r"Cannot access property '[^']*' on target of type ([^.]+)\.",
    r"Undefined property or method '[^']*' on ([A-Za-z_$][\w<>, ?$]*)",
    r"([A-Za-z_$][\w<>, ?$]*) has no getter named",
    r"([A-Za-z_$][\w<>, ?$]*) has no instance method named",
  ];
  for (final p in patterns) {
    final m = RegExp(p).firstMatch(message);
    if (m != null) return m.group(1)!.trim();
  }
  return null;
}

/// Whether [message] says the interpreter could not resolve the RETURNED value
/// to any bridge, as opposed to the bridge lacking the witness member.
///
/// The distinction is the whole precision of this pass. The interpreter names
/// the receiver it failed on: when that receiver is a registered bridge the
/// finding is an ordinary member gap, which the member diff already reports and
/// this pass must not double-count. When it is an SDK implementation type --
/// `_LineSplitIterable`, `_EfficientLengthCastIterable`, `_ConstMap` -- the
/// value never became a bridged instance at all, which is this defect class.
bool namesAnUnbridgedReceiver(String message, Set<String> bridgeNames) {
  final receiver = lookupFailureReceiver(message);
  if (receiver == null) return false;
  final cut = receiver.indexOf('<');
  final bare = (cut < 0 ? receiver : receiver.substring(0, cut)).trim();
  return !bridgeNames.contains(bare);
}

/// Probes every registered member of every bridged class and reports the ones
/// whose RETURNED VALUE the script cannot use.
///
/// Why this is a runtime pass and not the static one SCD36 proposed: mirrors
/// report the DECLARED return type, and for both members that motivated the
/// todo that type is `Iterable`, which is bridged. `Iterable.castFrom` returns
/// `_EfficientLengthCastIterable` and `LineSplitter.split` returns
/// `_LineSplitIterable` — neither appears anywhere in a static signature. A
/// pass that read declared return types and cross-referenced them against
/// `nativeNames` would have reported zero for both, which is the same blindness
/// in a new place.
Future<List<ReturnGap>> auditReturnTypes(
  Environment env, {
  Set<String>? only,
  void Function(String name, int probes)? onClass,
}) async {
  final bridgeNames = env.bridgedClassNames.toSet();
  final results = <ReturnGap>[];

  final names = env.bridgedClassNames..sort();
  for (final className in names) {
    if (only != null && !only.contains(className)) continue;
    final bc = env.findBridgedClassByName(className);
    if (bc == null) continue;
    if (bc.nativeType == Function) continue;

    final recipe = _instanceRecipes[className];
    final instanceMembers = <String>{...bc.methods.keys, ...bc.getters.keys};
    final staticMembers = <String>{
      ...bc.staticMethods.keys,
      ...bc.staticGetters.keys,
    };

    final planned = <ReturnGap>[];

    void plan(String member, {required bool isStatic}) {
      if (_isOperator(member)) return;
      // `_isOperator` tests the first character only, so the mirror's name for
      // unary minus -- `unary-` -- passes it and then builds the probe
      // `o.unary-.witness`, which parses as a subtraction and fails with a
      // lookup error that looks exactly like a gap. Probe plain identifiers.
      if (!RegExp(r'^[A-Za-z_$][A-Za-z0-9_$]*$').hasMatch(member)) return;
      if (_universalObjectMembers.contains(member)) return;
      if (_unprobableMembers.contains(member)) return;
      final decl = _declaredMember(bc.nativeType, member, static: isStatic);
      if (decl == null) return; // bridge-only member; the member diff owns it
      final ret = decl.returnType;
      final bare = _bareTypeName(ret);
      // A primitive or an untyped result carries no bridge question: the
      // interpreter represents these natively whatever the SDK returns.
      const native = {
        'void',
        'dynamic',
        'Null',
        'Never',
        'int',
        'double',
        'num',
        'bool',
        'String',
        'Object',
      };
      if (native.contains(bare)) return;
      final gap = ReturnGap(
        className,
        member,
        isStatic: isStatic,
        declaredReturn: bare,
      );
      gap.witness = _witnessFor(ret);
      if (gap.witness == null) {
        gap.detail = 'declared return type $bare offers no witness getter';
        planned.add(gap);
        return;
      }
      final args = decl.isGetter ? '' : _argumentsFor(decl);
      if (args == null) {
        gap.detail =
            'a required parameter has no literal '
            '(${decl.parameters.where((p) => !p.isOptional).map((p) => _bareTypeName(p.type)).join(', ')})';
        planned.add(gap);
        return;
      }
      gap.detail = decl.isGetter ? '<getter>' : '($args)';
      planned.add(gap);
    }

    if (recipe != null) {
      for (final m in instanceMembers) {
        plan(m, isStatic: false);
      }
    }
    for (final m in staticMembers) {
      plan(m, isStatic: true);
    }

    final probable = planned
        .where((g) => g.witness != null && !g.detail!.startsWith('a required'))
        .toList();
    if (planned.isNotEmpty) onClass?.call(className, probable.length);

    for (final gap in planned) {
      if (gap.witness == null || gap.detail!.startsWith('a required')) {
        results.add(gap); // stays unprobed, with its reason
        continue;
      }
      final call = gap.detail == '<getter>'
          ? gap.member
          : '${gap.member}${gap.detail}';
      final String source;
      if (gap.isStatic) {
        final imports = recipe?.imports ?? '';
        source =
            '$imports main() { final r = $className.$call; '
            'return r.${gap.witness}; }';
      } else {
        source = _recipeSource(recipe!, 'o.$call.${gap.witness}');
      }
      final outcome = await _runProbe(source);
      if (!outcome.answered) {
        gap.reach = ReturnReach.noAnswer;
        gap.detail = 'probe never answered';
      } else if (outcome.error == null) {
        gap.reach = ReturnReach.usable;
        gap.detail = null;
      } else if (lookupFailureReceiver(outcome.error!) == 'null') {
        // The member returned null, so the witness read failed on null rather
        // than on an unbridged type. Every instance of this was a `tryParse`
        // -- `BigInt.tryParse('ab')`, `DateTime.tryParse('ab')`,
        // `Encoding.getByName('ab')` -- answering null for a synthesised
        // argument that is not a valid input, which is the SDK behaving
        // correctly. Nothing about the bridge was measured.
        gap.reach = ReturnReach.unprobed;
        gap.detail = 'returned null for the synthesised argument';
      } else if (namesAnUnbridgedReceiver(outcome.error!, bridgeNames)) {
        gap.reach = ReturnReach.gap;
        gap.detail = outcome.error!.split('\n').first;
      } else {
        // Threw for some other reason — a type error from a synthesised
        // argument, a StateError from a legitimate call. Not this pass's
        // finding, and deliberately not reported as one.
        gap.reach = ReturnReach.usable;
        gap.detail = null;
      }
      results.add(gap);
    }
  }
  return results;
}

/// The mirror-image question, asked statically: a member that TAKES an SDK type
/// no bridge knows is uncallable, and a name-level member diff is equally blind
/// to it.
///
/// Unlike the return-type question this one really is static, and the asymmetry
/// is the point. A script must *construct* the argument it passes, so what
/// constrains it is the DECLARED parameter type — if that type is bridged, the
/// script has a way to make one. A return value arrives already built, as
/// whatever concrete class the SDK chose, so only the runtime type says whether
/// the script can use it. Same defect shape, opposite instrument.
List<String> auditParameterTypes(Environment env, {Set<String>? only}) {
  // Both the bridge NAMES and the NATIVE TYPE NAMES they wrap. The two differ
  // whenever a bridge is registered under the SDK's name while wrapping a
  // d4rt-side class: the `LinkedListEntry` bridge wraps
  // `BridgedLinkedListEntry`, so its own `insertAfter(BridgedLinkedListEntry)`
  // reported as taking an unbridged type when only names were compared.
  final bridged = env.bridgedClassNames.toSet();
  for (final n in env.bridgedClassNames) {
    final bc = env.findBridgedClassByName(n);
    if (bc == null) continue;
    final native = bc.nativeType.toString();
    final cut = native.indexOf('<');
    bridged.add(cut < 0 ? native : native.substring(0, cut));
  }
  // Types the interpreter represents natively, plus the shapes that carry no
  // class question at all (type variables, function types, void).
  const native = {
    'void',
    'dynamic',
    'Null',
    'Never',
    'int',
    'double',
    'num',
    'bool',
    'String',
    'Object',
    'Function',
    'Symbol',
    'Type',
    'Enum',
    'Record',
  };
  final findings = <String>[];

  final names = env.bridgedClassNames..sort();
  for (final className in names) {
    if (only != null && !only.contains(className)) continue;
    final bc = env.findBridgedClassByName(className);
    if (bc == null || bc.nativeType == Function) continue;

    void check(String member, {required bool isStatic}) {
      if (!RegExp(r'^[A-Za-z_$][A-Za-z0-9_$]*$').hasMatch(member)) return;
      final decl = _declaredMember(bc.nativeType, member, static: isStatic);
      if (decl == null) return;
      for (final param in decl.parameters) {
        final t = param.type;
        // A type variable (`E`, `T`) is not a class the registry could hold.
        if (t is TypeVariableMirror) continue;
        // A function-type parameter is a callback, not a class the registry
        // could hold -- and `FunctionTypeMirror` implements `ClassMirror`, so
        // without this it reports its whole signature as an unbridged type
        // name. It was 525 findings before this line and 40 after, and every
        // one of the 485 was a callback.
        if (t is FunctionTypeMirror) continue;
        if (t is! ClassMirror) continue;
        if (t.isAbstract && _symbolName(t.simpleName).isEmpty) continue;
        final bare = _bareTypeName(t);
        if (bare.isEmpty || native.contains(bare)) continue;
        if (bridged.contains(bare)) continue;
        findings.add(
          '$className.$member${isStatic ? " (static)" : ""} '
          'takes ${param.isOptional ? "optional " : ""}$bare',
        );
      }
    }

    for (final m in <String>{...bc.methods.keys}) {
      check(m, isStatic: false);
    }
    for (final m in <String>{...bc.staticMethods.keys}) {
      check(m, isStatic: true);
    }
  }
  findings.sort();
  return findings;
}

Future<void> runReturnTypeAudit(Environment env, List<String> args) async {
  final only = _optionValue(args, '--only')?.split(',').toSet();
  final results = await auditReturnTypes(
    env,
    only: only,
    onClass: (name, probes) {
      if (probes > 0) stderr.writeln('  $name ($probes)');
    },
  );

  final gaps = results.where((r) => r.reach == ReturnReach.gap).toList();
  final usable = results.where((r) => r.reach == ReturnReach.usable).length;
  final unprobed = results.where((r) => r.reach == ReturnReach.unprobed).length;
  final noAnswer = results.where((r) => r.reach == ReturnReach.noAnswer).length;

  if (args.contains('--json')) {
    stdout.writeln(
      const JsonEncoder.withIndent('  ').convert({
        'probed': usable + gaps.length,
        'usable': usable,
        'gaps': gaps.length,
        'unprobed': unprobed,
        'noAnswer': noAnswer,
        'results': results.map((r) => r.toJson()).toList(),
      }),
    );
    return;
  }

  stdout.writeln(
    'Members whose return value was probed:  ${usable + gaps.length}',
  );
  stdout.writeln('  ... usable (witness read succeeded):  $usable');
  stdout.writeln('  ... RETURN-TYPE GAP:                  ${gaps.length}');
  stdout.writeln('Not probed (no argument literal / no witness): $unprobed');
  stdout.writeln('No answer (probe wedged):                     $noAnswer');

  final paramFindings = auditParameterTypes(env, only: only);
  stdout.writeln(
    'Parameter types with no bridge (static pass):  ${paramFindings.length}',
  );

  if (gaps.isEmpty) {
    stdout.writeln('\nNo return-type gaps.');
  }
  if (paramFindings.isNotEmpty) {
    stdout.writeln('\nPARAMETER TYPES WITH NO BRIDGE');
    for (final f in paramFindings) {
      stdout.writeln('  $f');
    }
  }

  if (gaps.isEmpty) return;
  stdout.writeln('\nRETURN-TYPE GAPS');
  for (final g in gaps) {
    stdout.writeln(
      '  ${g.className}.${g.member}${g.isStatic ? " (static)" : ""} '
      '-> declared ${g.declaredReturn}, witness .${g.witness}',
    );
    stdout.writeln('      ${g.detail}');
  }
}

String? _optionValue(List<String> args, String name) {
  final i = args.indexOf(name);
  return i >= 0 && i + 1 < args.length ? args[i + 1] : null;
}

Future<void> main(List<String> args) async {
  _trace = args.contains('--trace');
  final env = buildFullyRegisteredEnvironment();

  if (args.contains('--returns')) {
    await runReturnTypeAudit(env, args);
    exit(0);
  }

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

  // SCD39: operators that could not be given a well-typed probe. Printed
  // rather than folded into the unverified total alone, because the whole
  // point of the change is that an unmeasurable operator says why.
  if (staticProbeSkips.isNotEmpty) {
    stderr.writeln(
      'Static probes skipped, class name not in scope: '
      '${staticProbeSkips.length}',
    );
    for (final e
        in (staticProbeSkips.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key)))) {
      stderr.writeln('  ${e.key}: ${e.value}');
    }
  }

  if (operatorProbeSkips.isNotEmpty) {
    stderr.writeln(
      'Operator probes skipped (unverified, with a reason): '
      '${operatorProbeSkips.length}',
    );
    for (final e
        in (operatorProbeSkips.entries.toList()
          ..sort((a, b) => a.key.compareTo(b.key)))) {
      stderr.writeln('  ${e.key}: ${e.value}');
    }
  }

  if (args.contains('--baseline')) {
    // A narrowed run measures a subset, and a baseline written from a subset
    // silently disarms every guard that reads it: `measuredClasses` shrinks to
    // the named classes, so the "this recipe went dark" test has almost nothing
    // left to check, and it reports that as a pass. The floors in the test
    // cannot catch it either — they bound the LIVE run, which is full-size.
    if (only != null) {
      stderr.writeln(
        'Refusing to write a baseline from a --only run: it would measure '
        '${only.length} classes and record that as the expected state of all '
        '${env.bridgedClassNames.length}. Drop --only, or keep the narrowed '
        'run for diagnosis and regenerate separately.',
      );
      exit(2);
    }
    final path =
        _optionValue(args, '--baseline-out') ??
        'test/stdlib/member_coverage_baseline.dart';
    File(path).writeAsStringSync(
      renderBaselineSource(diffs, env.bridgedClassNames.toSet()),
    );
    // The emitter writes one list element per line and `dart format` collapses
    // short lists onto one, so an unformatted write produced a 125-line diff
    // for a two-line change — burying exactly the "which members moved and
    // why" this tool tells its caller to look for. Formatting here makes that
    // instruction true instead of aspirational.
    final formatted = Process.runSync('dart', ['format', path]);
    if (formatted.exitCode != 0) {
      stderr.writeln(
        'Baseline written but `dart format` failed; the diff will be mostly '
        're-wrapping:\n${formatted.stderr}',
      );
    }
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
  // The measured-unreachable total splits the same way the baseline does.
  // Reporting one number here while the baseline reported two was how the
  // three `ByteBuffer` SIMD views spent a release looking like a backlog on
  // the console while already being a documented decision.
  final declinedTotal = diffs.fold<int>(
    0,
    (sum, d) =>
        sum +
        [
          ...d.missingInstance,
          ...d.missingStatic,
          ...d.missingOperators,
          ...d.missingUniversal,
        ].where((m) => _isDeclined(d.name, m)).length,
  );
  stdout.writeln(
    'MEASURED unreachable members:        $totalGaps in $withGaps classes',
  );
  stdout.writeln(
    '  ... unreachable BY DECISION:      $declinedTotal '
    '(see kUnbridgedMemberReasons / doc/d4rt_limitations.md)',
  );
  stdout.writeln(
    'CONFIRMED unreachable members:       ${totalGaps - declinedTotal}',
  );
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

  // SCD23. `extraBridged` reached only the JSON before this, which is most of
  // why it could be mistaken for a defect list: the one place it appeared gave
  // no room for the distinction. Both halves are printed now, under headings
  // that say which is which.
  final knownExt = diffs
      .where((d) => d.extraBridgedKnownExtension.isNotEmpty)
      .toList();
  final unexplainedExtra = diffs
      .where((d) => d.extraBridged.isNotEmpty)
      .toList();

  if (knownExt.isNotEmpty) {
    final total = knownExt.fold<int>(
      0,
      (s, d) => s + d.extraBridgedKnownExtension.length,
    );
    stdout.writeln('');
    stdout.writeln(
      'Bridged members the oracle CANNOT see: $total in ${knownExt.length} '
      'classes',
    );
    stdout.writeln('');
    stdout.writeln(
      'These are real Dart extension members on the native type. `dart:mirrors` '
      'reports declarations ON a type, and an extension declares nothing on the '
      'type it extends, so every one of these lands in the map diff no matter '
      'how correct the bridge is. NOT candidates for removal — deleting them '
      'breaks working script code while the suites stay green.',
    );
    stdout.writeln('');
    stdout.writeln('| Class | Extension members |');
    stdout.writeln('| --- | --- |');
    for (final d in knownExt) {
      stdout.writeln(
        '| ${d.name} | ${d.extraBridgedKnownExtension.join(', ')} |',
      );
    }
  }

  // A name allowlisted for a class that no longer reports it. The allowlist is
  // hand-written, so it can outlive its cause — and an entry that silently
  // stopped matching would hide a member that had become a real defect.
  final byName = {for (final d in diffs) d.name: d};
  final staleAllowlist = <String>[];
  for (final entry in _knownExtensionMembers.entries) {
    final diff = byName[entry.key];
    if (diff == null) continue;
    for (final member in entry.value) {
      if (!diff.extraBridgedKnownExtension.contains(member)) {
        staleAllowlist.add('${entry.key}.$member');
      }
    }
  }
  staleAllowlist.sort();
  if (staleAllowlist.isNotEmpty) {
    stdout.writeln('');
    stdout.writeln(
      'STALE extension allowlist entries: ${staleAllowlist.length}',
    );
    stdout.writeln(
      'Allowlisted in _knownExtensionMembers but not reported by the diff, so '
      'the entry is excusing nothing. Either the bridge dropped the member, or '
      'the SDK grew a real declaration for it — both are worth knowing, and '
      'leaving the entry means the next one that stops matching is invisible:',
    );
    for (final s in staleAllowlist) {
      stdout.writeln('  $s');
    }
  }

  if (unexplainedExtra.isNotEmpty) {
    final total = unexplainedExtra.fold<int>(
      0,
      (s, d) => s + d.extraBridged.length,
    );
    stdout.writeln('');
    stdout.writeln(
      'Bridged members with NO SDK counterpart and no explanation: $total in '
      '${unexplainedExtra.length} classes',
    );
    stdout.writeln('');
    stdout.writeln(
      'Each wants a verdict — a declared convenience, or a FABRICATION. The '
      'second is the one bridge defect no passing test can catch: a member the '
      'SDK lacks makes every script using it green here and uncompilable as '
      'Dart, so the error surfaces only when the script moves to real Dart. '
      'Settle each with the recipe, not by reading the bridge: write a '
      'one-liner using the member on the NATIVE type and run `dart analyze`. '
      'Verdicts live in doc/stdlib_sdk_gap_audit.md.',
    );
    stdout.writeln('');
    stdout.writeln('| Class | Members |');
    stdout.writeln('| --- | --- |');
    for (final d in unexplainedExtra) {
      stdout.writeln('| ${d.name} | ${d.extraBridged.join(', ')} |');
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
