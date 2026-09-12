// SCD51 — which stdlib members no script can reach, for the ANALYZER-FREE tree.
//
// `tom_d4rt` has had a standing member-coverage audit since SCC13. This tree —
// the one that ships inside Flutter apps — had none, and could not get one by
// copying: `tom_d4rt/tool/stdlib_member_diff.dart` reflects over *that*
// package's registry, so a copied file with the import line rewritten would
// measure the reference tree while appearing to measure this one. Green for a
// reason unrelated to its subject is the worst outcome a coverage guard has.
//
// So this is a second instance of the design, not a port. It differs from the
// reference in one deliberate way, and the difference is the whole reason this
// tool could be written at all.
//
// HOW REACHABILITY IS DECIDED. The reference RUNS a script per candidate:
// build an instance from a hand-written recipe, read the member, see whether
// the interpreter resolves it. That needs source execution, which this package
// cannot do — it interprets pre-parsed `SAstNode` trees, and the parser lives
// in `tom_ast_generator`, which depends back on this package. The one place
// with both a parser and this interpreter is `tom_d4rt_exec`, and it resolves
// this package FROM PUB.DEV (DGUC6) — measured 2026-09-12 at 0.65.0 against a
// working tree of 0.74.0, with five interpreter fixes in between. An audit
// there would describe a release nobody is working on.
//
// Instead this walks the registered supertype chain — `[C, ...C's transitive
// supertypes]` — and asks whether any bridge on it declares the member. That
// is what `InterpreterVisitor.lookupOnBridgedSupertypes` does at runtime, so
// it is a simulation of resolution rather than a proxy for it.
//
// THE SIMULATION WAS CALIBRATED BEFORE IT WAS TRUSTED, against the reference's
// empirical result, on 2026-09-12 (tom_d4rt 1.86.0):
//
//   | member kind                    | candidates decided | disagreements |
//   | ------------------------------ | -----------------: | ------------: |
//   | ordinary named members         |                644 |         **0** |
//   | operators and Object universals|                 63 |            63 |
//
// Exact agreement on ordinary members, in both directions — the chain walk
// never called a member reachable that the probe found unreachable, and never
// the reverse. On operators (`+`, `<`, `[]`, `/`) and the universal `Object`
// members (`==`, `toString`, `hashCode`, `runtimeType`, `noSuchMethod`) it
// disagreed on every single one: the interpreter reaches those through paths
// the registry does not model. So THEY ARE EXCLUDED, by measurement rather
// than by taste, and `tom_d4rt`'s audit remains the only one that covers them.
//
// WHAT THE SIMULATION BUYS BACK. The reference cannot measure a class it has no
// instance recipe for — 36 members on `Stdin` sit in its "unmeasurable" bucket
// for that reason. A chain walk needs no instance, so it decides those too.
//
// Run:
//   dart run tool/stdlib_member_audit.dart            # the report
//   dart run tool/stdlib_member_audit.dart --baseline # rewrite the baseline

import 'dart:io';
import 'dart:mirrors';

import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/isolate.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/math.dart';

/// The registration a script gets with every `dart:` library imported.
///
/// `Stdlib.register()` wires core + async + typed_data eagerly and leaves the
/// rest to load on import; the audit asks what is reachable GIVEN the right
/// import, so all of them run here.
Environment buildFullyRegisteredEnvironment() {
  final env = Environment();
  Stdlib(env).register();
  MathStdlib.register(env);
  ConvertStdlib.register(env);
  IoStdlib.register(env);
  CollectionStdlib.register(env);
  IsolateStdlib.register(env);
  return env;
}

/// Members every object carries. Excluded: measured as unreachable by the chain
/// walk and reachable in practice, on all 63 occurrences.
const universalObjectMembers = <String>{
  'hashCode',
  'runtimeType',
  'toString',
  'noSuchMethod',
  '==',
};

bool _isOperator(String n) =>
    n.isNotEmpty && !RegExp(r'^[A-Za-z_$]').hasMatch(n);

/// Mirrors key setters as `foo=`; the adapter maps key them as `foo`.
String _normalizeSetter(String name) => name.endsWith('=') && !_isOperator(name)
    ? name.substring(0, name.length - 1)
    : name;

bool _isPublic(String name) => !name.startsWith('_');

/// Whether [decl] carries `@Deprecated`. A retired SDK alias is not a gap, and
/// bridging one would carry a spelling the SDK abandoned into D4rt for ever.
bool _isDeprecated(DeclarationMirror decl) {
  try {
    return decl.metadata.any((m) => m.reflectee is Deprecated);
  } catch (_) {
    return false;
  }
}

/// Member names a script may reach on the native [type].
///
/// Statics come from the entry class only: Dart does not inherit them, so
/// walking the hierarchy for statics would invent members nothing can call.
({Set<String> instance, Set<String> statics})? sdkSurface(Type type) {
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
      continue; // partly-reflectable; keep what the rest of the walk finds
    }

    for (final entry in declarations.entries) {
      final raw = MirrorSystem.getName(entry.key);
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
        // A field is reachable as a getter, and as a setter when not final.
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
      // best-effort hierarchy walk
    }
  }

  return (instance: instance, statics: statics);
}

/// Every adapter key a bridge declares itself.
Set<String> _declaredBy(BridgedClass bc) => {
  ...bc.methods.keys,
  ...bc.getters.keys,
  ...bc.setters.keys,
  ...bc.staticMethods.keys,
  ...bc.staticGetters.keys,
  ...bc.staticSetters.keys,
};

/// One class's result.
class ClassAudit {
  ClassAudit(this.name, this.nativeType);
  final String name;
  final String nativeType;

  /// Why the class could not be diffed at all, if it could not.
  String? error;

  /// Candidates the chain resolves — a member the bridge does not declare
  /// itself but inherits from a registered supertype.
  final reachable = <String>[];

  /// Candidates nothing on the chain declares. These are the gaps.
  final unreachable = <String>[];
}

/// Walks every bridged class and classifies every ordinary named member the SDK
/// offers and the registry does not declare directly.
List<ClassAudit> auditMembers(Environment env) {
  final names = env.bridgedClassNames..sort();
  final out = <ClassAudit>[];

  bool chainDeclares(String cls, String member) {
    for (final n in [cls, ...BridgedClass.transitiveSupertypeNames(cls)]) {
      final bc = env.findBridgedClassByName(n);
      if (bc != null && _declaredBy(bc).contains(member)) return true;
    }
    return false;
  }

  for (final name in names) {
    final bc = env.findBridgedClassByName(name);
    if (bc == null) continue;
    final audit = ClassAudit(name, bc.nativeType.toString());

    // A bridge whose nativeType is `Function` registers a top-level FUNCTION
    // (`unawaited` is the stdlib's one), not a class. Diffing it against the
    // `Function` surface reports `apply` as missing, which is a gap in nothing.
    if (bc.nativeType == Function) {
      audit.error = 'bridged top-level function — no class surface to diff';
      out.add(audit);
      continue;
    }

    final sdk = sdkSurface(bc.nativeType);
    if (sdk == null) {
      audit.error = 'not reflectable as a ClassMirror';
      out.add(audit);
      continue;
    }

    final declared = _declaredBy(bc);
    for (final m in {...sdk.instance, ...sdk.statics}) {
      if (declared.contains(m)) continue;
      if (_isOperator(m) || universalObjectMembers.contains(m)) continue;
      if (bc.constructors.containsKey(m)) continue;
      (chainDeclares(name, m) ? audit.reachable : audit.unreachable).add(m);
    }
    audit.reachable.sort();
    audit.unreachable.sort();
    out.add(audit);
  }
  return out;
}

String renderBaselineSource(List<ClassAudit> audits) {
  final gaps = <String, List<String>>{};
  for (final a in audits) {
    if (a.unreachable.isNotEmpty) gaps[a.name] = a.unreachable;
  }
  final audited = [
    for (final a in audits)
      if (a.error == null) a.name,
  ]..sort();
  final total = gaps.values.fold<int>(0, (s, l) => s + l.length);

  String renderMap(Map<String, List<String>> m) {
    final b = StringBuffer();
    for (final key in m.keys.toList()..sort()) {
      b.writeln("  '$key': [");
      for (final member in m[key]!) {
        b.writeln("    r'$member',");
      }
      b.writeln('  ],');
    }
    return b.toString();
  }

  return '''
// GENERATED — regenerate with:
//   dart run tool/stdlib_member_audit.dart --baseline
//
// The standing member-coverage baseline for the ANALYZER-FREE stdlib bridges,
// read by `test/scd51_member_coverage_test.dart`. Do not hand-edit: a
// hand-edited entry is an assertion about the interpreter that nothing
// measured, which is the claim this baseline exists to stop anyone making.
//
// Current state: $total unreachable members across ${gaps.length} classes,
// over ${audited.length} classes the audit could diff. Those totals are
// documentation, not assertions — the test derives them from the tables below.
//
// Scope: ordinary named members only. Operators and the universal `Object`
// members are excluded because the chain walk cannot decide them — see the
// calibration table in `tool/stdlib_member_audit.dart`.

/// Members no bridge on the class's registered supertype chain declares, so no
/// script can reach them.
const unreachableMembers = <String, List<String>>{
${renderMap(gaps)}};

/// Classes the audit could diff against an SDK surface. A class dropping out of
/// this set stopped being measured, which the test reports rather than passing.
const auditedClasses = <String>{
${audited.map((n) => "  '$n',").join('\n')}
};
''';
}

void main(List<String> args) {
  final env = buildFullyRegisteredEnvironment();
  final audits = auditMembers(env);

  if (args.contains('--baseline')) {
    const path = 'test/stdlib_member_baseline.dart';
    File(path).writeAsStringSync(renderBaselineSource(audits));
    // The emitter writes one element per line and `dart format` collapses short
    // lists, so an unformatted write buries a two-line change in re-wrapping.
    final formatted = Process.runSync('dart', ['format', path]);
    if (formatted.exitCode != 0) {
      stderr.writeln(
        'Baseline written but `dart format` failed; the diff will be mostly '
        're-wrapping:\n${formatted.stderr}',
      );
    }
    stdout.writeln('Baseline written to $path');
    return;
  }

  final withGaps = audits.where((a) => a.unreachable.isNotEmpty).toList()
    ..sort((a, b) {
      final byCount = b.unreachable.length.compareTo(a.unreachable.length);
      return byCount != 0 ? byCount : a.name.compareTo(b.name);
    });
  final total = audits.fold<int>(0, (s, a) => s + a.unreachable.length);
  final reachable = audits.fold<int>(0, (s, a) => s + a.reachable.length);
  final undiffable = audits.where((a) => a.error != null).length;

  stdout.writeln('Bridged classes examined:        ${audits.length}');
  stdout.writeln('  ... not diffable:              $undiffable');
  stdout.writeln('Reachable via the supertype chain: $reachable');
  stdout.writeln(
    'UNREACHABLE:                     $total '
    'in ${withGaps.length} classes',
  );
  for (final a in withGaps) {
    stdout.writeln('  ${a.name} (${a.unreachable.length})');
    for (final m in a.unreachable) {
      stdout.writeln('      $m');
    }
  }
}
