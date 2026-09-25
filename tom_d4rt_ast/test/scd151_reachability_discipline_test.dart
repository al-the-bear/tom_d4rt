// A registration-level test must resolve a bridged member the way the
// interpreter does, not by asking one bridge whether it declares the name.
//
// WHY THIS EXISTS. `env.findBridgedClassByName('HashSet')!.getters['first']!`
// asserts two things at once: that a script can reach `first`, and that *this
// particular* bridge carries it. Only the first is a contract. SCC51 made the
// second move — it deleted seventeen leaf copies of `first`/`last`/`single` that
// shadowed a correct inherited one — and five tests went red without anything a
// script does having changed. Worse in the other direction: such a test PASSES
// when a leaf re-adds a divergent copy, which is the defect SCC51 exists to
// prevent, so the suite would not have caught the bug it was extended to catch.
//
// `test/bridge_reachability.dart` is the primitive that resolves correctly.
// This file is what stops the fragile shape coming back, because it came back
// once already: SC7 registered the supertype edges, and the tests written after
// it kept indexing one bridge's map anyway.
//
// WHAT COUNTS AS A VIOLATION. Indexing `getters` / `setters` / `methods` (or
// their `.keys`) on a bridge that HAS registered supertypes, without saying that
// the declaring bridge is the point. A bridge with no supertypes is exempt by
// construction: nothing can move, so there is nothing for reachability to
// resolve — `DoubleLinkedQueueEntry` is the common case.
//
// SAYING SO is the token `LAYOUT` in a comment inside the enclosing `test(`.
// Three sites carry it today and each explains itself: `LinkedList`'s declared
// mutating surface (which pins a disagreement `tom_d4rt_exec` recorded in its
// `_divergentBaseline`, and reachability cannot express), and `AsyncError`'s two
// registration assertions. `staticMethods` / `staticGetters` are NOT checked at
// all: statics are reached through the bridge a script names, never through its
// supertype chain, so indexing them directly is correct.
//
// COMMENTS ARE STRIPPED BEFORE SCANNING, and that is load-bearing rather than
// tidy. The first version of this scan fired on `stdlib_ordered_sorted_sets`'s
// prose — a comment that says `splay.methods.keys` would stay silent if a
// supertype acquired the name — and reported the best-documented site in the
// file as a violation. A detector that reads prose as code reports its own
// examples.
@TestOn('vm')
library;

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/async.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/isolate.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/math.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/typed_data.dart';

/// This file names every pattern it looks for, so scanning itself would report
/// its own regexes. Excluded by name for that reason and no other.
const String _self = 'scd151_reachability_discipline_test.dart';

/// Member maps whose contents a supertype can legitimately supply. Statics are
/// deliberately absent — see the header.
const List<String> _instanceMaps = ['getters', 'setters', 'methods'];

/// Blanks out comment bodies, preserving offsets and newlines so line numbers
/// and the binding scan stay correct. String literals are skipped so a `//`
/// inside one is not mistaken for a comment.
String _stripComments(String src) {
  final out = src.split('');
  var i = 0;
  while (i < src.length) {
    final c = src[i];
    if (c == "'" || c == '"') {
      final quote = c;
      i++;
      while (i < src.length && src[i] != quote) {
        if (src[i] == r'\') i++;
        i++;
      }
      i++;
    } else if (src.startsWith('//', i)) {
      while (i < src.length && src[i] != '\n') {
        out[i] = ' ';
        i++;
      }
    } else if (src.startsWith('/*', i)) {
      while (i < src.length && !src.startsWith('*/', i)) {
        if (src[i] != '\n') out[i] = ' ';
        i++;
      }
      i += 2;
    } else {
      i++;
    }
  }
  return out.join();
}

final RegExp _site = RegExp(
  r"([A-Za-z_][A-Za-z0-9_]*(?:\(\))?|findBridgedClassByName\('[^']+'\)!?)\s*"
  '\\.(${_instanceMaps.join('|')})'
  r"(\[\s*'([^']+)'\s*\]|\.keys|\.containsKey\(\s*'([^']+)'\s*\))",
);

/// `X() => env.findBridgedClassByName('N')!` / `final x = ...findBridged...`.
final RegExp _directBinding = RegExp(
  r'(?:BridgedClass\??\s+(\w+)\(\)\s*=>'
  r'|(?:final|late final|late|var)\s+(?:BridgedClass\s+)?(\w+)\s*='
  r'|\b(\w+)\s*=)'
  r"\s*[\w.]*findBridgedClassByName\(\s*'([^']+)'",
);

/// `final x = someHelper();`, where `someHelper` is itself bound above.
final RegExp _aliasBinding = RegExp(
  r'(?:BridgedClass\??\s+(\w+)\(\)\s*=>'
  r'|(?:final|late final|late|var)\s+(?:BridgedClass\s+)?(\w+)\s*='
  r'|\b(\w+)\s*=)'
  r'\s*(\w+)\(\)\s*;',
);

class _Site {
  _Site(this.file, this.line, this.bridge, this.marked);
  final String file;
  final int line;
  final String? bridge;
  final bool marked;
  @override
  String toString() => '$file:$line ($bridge)';
}

Environment _unionRegistry() {
  final env = Environment();
  CoreStdlib.register(env);
  AsyncStdlib.register(env);
  CollectionStdlib.register(env);
  ConvertStdlib.register(env);
  MathStdlib.register(env);
  TypedDataStdlib.register(env);
  IoStdlib.register(env);
  IsolateStdlib.register(env);
  return env;
}

List<_Site> _scan() {
  final sites = <_Site>[];
  final root = Directory('test');
  for (final entity in root.listSync(recursive: true)) {
    if (entity is! File) continue;
    final name = entity.uri.pathSegments.last;
    if (!name.endsWith('_test.dart') || name == _self) continue;
    final raw = entity.readAsStringSync();
    final src = _stripComments(raw);

    // Every binding with the offset it takes effect at, so a `bridge` rebound
    // per test resolves to the bridge of ITS test rather than the file's first.
    final bindings = <String, List<(int, String)>>{};
    void add(String? ident, int at, String bridge) {
      if (ident == null) return;
      bindings.putIfAbsent(ident, () => []).add((at, bridge));
    }

    for (final m in _directBinding.allMatches(src)) {
      add(m.group(1) ?? m.group(2) ?? m.group(3), m.start, m.group(4)!);
    }
    final unique = <String, String>{
      for (final e in bindings.entries)
        if (e.value.length == 1) e.key: e.value.single.$2,
    };
    for (var pass = 0; pass < 4; pass++) {
      for (final m in _aliasBinding.allMatches(src)) {
        final target = unique[m.group(4)];
        if (target != null) {
          add(m.group(1) ?? m.group(2) ?? m.group(3), m.start, target);
        }
      }
    }
    for (final list in bindings.values) {
      list.sort((a, b) => a.$1.compareTo(b.$1));
    }

    for (final m in _site.allMatches(src)) {
      final receiver = m.group(1)!;
      String? bridge;
      if (receiver.startsWith('findBridgedClassByName')) {
        bridge = RegExp(r"'([^']+)'").firstMatch(receiver)!.group(1);
      } else {
        final ident = receiver.endsWith('()')
            ? receiver.substring(0, receiver.length - 2)
            : receiver;
        final candidates = bindings[ident];
        if (candidates != null) {
          final before = candidates.where((c) => c.$1 < m.start).toList();
          // A file-level helper binds for the whole file even when declared
          // after its first use, so fall back to the earliest binding.
          bridge = before.isNotEmpty ? before.last.$2 : candidates.first.$2;
        }
      }
      final testStart = src.lastIndexOf('test(', m.start);
      final region = testStart >= 0 ? raw.substring(testStart, m.start) : '';
      sites.add(
        _Site(
          entity.path,
          src.substring(0, m.start).split('\n').length,
          bridge,
          region.contains('LAYOUT'),
        ),
      );
    }
  }
  return sites;
}

/// SCE184 — every registrar a test file calls, by the name it is called with.
///
/// Ownership is COMPUTED from these, by registering each into a fresh
/// environment, rather than written down: a sub-registrar
/// (`AsyncStreamStdlib`, `AsyncErrorStdlib`) registers a subset of what its
/// parent does, and scd151's first hand audit reported `Stream` missing from
/// a file that registered it because it modelled ownership per library. A
/// registrar a test calls that is absent here fails F-SCE184-2 by name.
final Map<String, void Function(Environment)> _registrars = {
  'CoreStdlib': CoreStdlib.register,
  'AsyncStdlib': AsyncStdlib.register,
  'AsyncStreamStdlib': AsyncStreamStdlib.register,
  'AsyncErrorStdlib': AsyncErrorStdlib.register,
  'CollectionStdlib': CollectionStdlib.register,
  'ConvertStdlib': ConvertStdlib.register,
  'MathStdlib': MathStdlib.register,
  'TypedDataStdlib': TypedDataStdlib.register,
  'IoStdlib': IoStdlib.register,
  'IsolateStdlib': IsolateStdlib.register,
};

/// What one test file registers and what its named bridges need.
class _RegistrarAudit {
  _RegistrarAudit(this.file, this.calls, this.wholeStdlib, this.exempt);
  final String file;
  final Set<String> calls;
  final bool wholeStdlib;
  final bool exempt;
  final Set<String> named = {};
  final List<String> missing = [];
}

final RegExp _registrarCall = RegExp(r'\b([A-Z][A-Za-z]*Stdlib)\.register\(');
final RegExp _wholeStdlib = RegExp(r'\bStdlib\([^)]*\)\.register\(\)');
final RegExp _namedBridge = RegExp(
  r"findBridgedClassByName\(\s*'([^']+)'"
  r"|(?:findReachable\w+|readReachable|reachable\w+Names)\(\s*\w+\s*,\s*'([^']+)'",
);

/// scd151's part (2) as a guard: for every bridge a file names, the file must
/// call a registrar owning that bridge AND each of its registered supertypes.
/// A hierarchy truncated at the leaf makes an inherited-member assertion
/// structurally incapable of passing, while the test still looks green.
List<_RegistrarAudit> _auditRegistration(Environment union) {
  final owners = <String, Set<String>>{};
  _registrars.forEach((name, register) {
    final env = Environment();
    register(env);
    for (final bridge in env.bridgedClassNames) {
      owners.putIfAbsent(bridge, () => {}).add(name);
    }
  });
  final audits = <_RegistrarAudit>[];
  for (final entity in Directory('test').listSync(recursive: true)) {
    if (entity is! File) continue;
    final name = entity.uri.pathSegments.last;
    if (!name.endsWith('_test.dart') || name == _self) continue;
    final raw = entity.readAsStringSync();
    final src = _stripComments(raw);
    final audit = _RegistrarAudit(
      entity.path,
      {for (final m in _registrarCall.allMatches(src)) m.group(1)!},
      _wholeStdlib.hasMatch(src),
      raw.contains('PARTIAL-REGISTRATION'),
    );
    for (final m in _namedBridge.allMatches(src)) {
      final bridge = m.group(1) ?? m.group(2)!;
      if (union.findBridgedClassByName(bridge) != null) audit.named.add(bridge);
    }
    if (audit.calls.isNotEmpty && !audit.wholeStdlib && !audit.exempt) {
      final needed = <String>{
        for (final bridge in audit.named) ...[
          bridge,
          ...BridgedClass.transitiveSupertypeNames(bridge),
        ],
      }.where((n) => owners.containsKey(n));
      for (final n in needed.toList()..sort()) {
        if (owners[n]!.intersection(audit.calls).isEmpty) {
          audit.missing.add('$n (registered by ${owners[n]!.join(' or ')})');
        }
      }
    }
    audits.add(audit);
  }
  return audits;
}

void main() {
  final env = _unionRegistry();
  final sites = _scan();
  final attributed = sites
      .where(
        (s) =>
            s.bridge != null && env.findBridgedClassByName(s.bridge!) != null,
      )
      .toList();
  final withSupertypes = attributed
      .where((s) => BridgedClass.transitiveSupertypeNames(s.bridge!).isNotEmpty)
      .toList();

  group('SCD151: a registration test resolves members by reachability', () {
    test('F-SCD151-1: no test indexes one bridge\'s member map for a bridge '
        'that has supertypes, unless the layout is the point [2026-09-15]', () {
      final unmarked = withSupertypes.where((s) => !s.marked).toList();
      expect(
        unmarked,
        isEmpty,
        reason:
            'These sites ask which bridge DECLARES a member, on a bridge whose '
            'supertypes could supply it. That assertion fails when a member '
            'correctly moves upward and passes when a leaf re-adds a divergent '
            'copy — the defect SCC51 exists to prevent. Resolve through '
            '`test/bridge_reachability.dart` instead: `findReachableGetter` / '
            '`findReachableMethod` / `readReachable` for a single member, '
            '`reachableMethodNames` / `reachableGetterNames` / '
            '`reachableSetterNames` for a surface claim. If the declaring '
            'bridge really is the subject, say so with the token LAYOUT in a '
            'comment inside the test and explain why reachability cannot '
            'express it.\n  ${unmarked.join('\n  ')}',
      );
    });

    test('F-SCD151-2 (control): the scan resolves the set it asserts over '
        '[2026-09-15]', () {
      // A scan that attributes nothing passes F-SCD151-1 over an empty list,
      // and this file's subject makes that especially quiet: zero violations is
      // also what a broken receiver resolver reports. Measured 2026-09-15:
      // 91 sites, 67 attributed to a registered bridge, 2 of those on a bridge
      // with supertypes and both marked. The floors sit below those so a
      // legitimate conversion does not fail, and far enough above zero that a
      // detector which stopped matching cannot pass.
      expect(
        sites.length,
        greaterThanOrEqualTo(60),
        reason:
            'The site regex found ${sites.length} where 91 were measured. '
            'Either a great many direct member-map accesses were converted — '
            'lower this floor deliberately — or the pattern stopped matching.',
      );
      // A RATIO, not a floor, and the difference is the whole value of this
      // expectation. Converting sites to reachability removes them from BOTH
      // counts, so an absolute floor on `attributed` has to sit far enough below
      // today's number to survive that — and once it does, it no longer notices
      // the failure it is for. Measured by ablation: replacing the
      // literal-receiver branch with `if (false)` left `attributed` above 45 and
      // the old floor passed. The ratio falls, because a broken resolver drops
      // attributed while leaving sites alone.
      expect(
        attributed.length / sites.length,
        greaterThanOrEqualTo(0.65),
        reason:
            'Only ${attributed.length} of ${sites.length} sites resolved to a '
            'registered bridge (${(attributed.length / sites.length * 100).round()}%), '
            'against 67 of 91 — 74% — measured on 2026-09-15. The receiver '
            'resolver has probably stopped following a binding form, which '
            'makes F-SCD151-1 pass over sites it can no longer see.',
      );
      expect(
        withSupertypes.length,
        greaterThanOrEqualTo(2),
        reason:
            'No attributed site names a bridge with registered supertypes, so '
            'F-SCD151-1 cannot fail for any reason. Either both LAYOUT-marked '
            'sites are gone — which is the thing to check — or supertype '
            'registration broke.',
      );
    });

    test('F-SCD151-3: the unattributable remainder stays small [2026-09-15]', () {
      // 24 sites take their receiver from a loop variable or a parameter —
      // `scc24_native_name_coverage_test.dart` and
      // `scc51_shadowed_adapter_test.dart` sweep the whole registry, which is
      // layout-level by nature and correct. They are invisible to F-SCD151-1,
      // so the number is pinned: a new unattributable site is a new blind spot,
      // and the fix is to name the bridge rather than to raise this ceiling.
      //
      // SCD196 raised it 26 -> 27 and SCD197 27 -> 30, both for the one shape
      // where raising is right. `scd196_member_map_disjointness_test.dart` asks
      // whether any bridge declares one member in two maps; SCD197's group in
      // `scc24_native_name_coverage_test.dart` asks which bridges no heir falls
      // through to. Each has EVERY bridge as its subject, so there is no bridge
      // to name and reading the member maps off the loop variable is the
      // assertion rather than a shortcut — the same shape as the two sweeps
      // above. Raise this only for that shape; a site that COULD name its
      // bridge should.
      //
      // SCE70 raised it 30 -> 33 for that same shape once more, and the
      // symmetry is the justification:
      // `runtime/stdlib_member_map_disjointness_test.dart` is this tree's twin
      // of the very `scd196` file named above. It asks the identical question
      // of the identical subject — every bridge — so there is again no bridge
      // to name, and reading the six member maps off the loop variable IS the
      // assertion. The AST tree had no disjointness guard at all until then.
      //
      // SCE185 raised it 33 -> 35, for the same shape and nothing else: the
      // two `.keys` reads in `F-SCE185-1` (`scc51_shadowed_adapter_test.dart`),
      // whose subject is which bridges of the WHOLE registry shadow a
      // supertype member. There is no bridge to name there either. The
      // behaviour tests SCE185 added beside it name their bridges through
      // `findReachableMethod` and are attributed.
      final unattributable = sites.length - attributed.length;
      expect(
        unattributable,
        lessThanOrEqualTo(35),
        reason:
            '$unattributable sites cannot be attributed to a bridge, against '
            '24 measured. Each is a site F-SCD151-1 cannot check. Prefer '
            'naming the bridge — `findReachableMethod(env, \'HashSet\', ...)` — '
            'over a receiver the scan has to infer.',
      );
    });
  });

  group('SCE184: a registration test registers what its bridges inherit from', () {
    final audits = _auditRegistration(env);

    test('F-SCE184-1: every file calls a registrar for each bridge it names '
        'and each of that bridge\'s supertypes [2026-09-25]', () {
      final incomplete = [
        for (final a in audits)
          if (a.missing.isNotEmpty)
            '${a.file}: missing ${a.missing.join(', ')}',
      ];
      expect(
        incomplete,
        isEmpty,
        reason:
            'These files name a bridge whose supertypes they do not register. '
            'An assertion about an inherited member cannot pass there, and the '
            'test still looks green by asserting against the leaf\'s own '
            'copies — how three files sat wrong until scc51 and scd151 looked. '
            'Call the registrar named, or `Stdlib(env).register()`. If partial '
            'registration IS the subject, put the token PARTIAL-REGISTRATION in '
            'a comment saying why:\n  ${incomplete.join('\n  ')}',
      );
    });

    test('F-SCE184-2 (control): the audit sees the registrar calls it reasons '
        'about, and knows every registrar a test calls [2026-09-25]', () {
      // A scan that matches no `register(` call reports every file complete,
      // which is this guard's quiet failure. Measured 2026-09-25: 29 files
      // judged, 19 of them naming a bridge; the floors sit a little below.
      final judged = audits
          .where((a) => a.calls.isNotEmpty && !a.wholeStdlib && !a.exempt)
          .toList();
      expect(
        judged.length,
        greaterThanOrEqualTo(25),
        reason: 'only ${judged.length} files were judged',
      );
      expect(
        judged.where((a) => a.named.isNotEmpty).length,
        greaterThanOrEqualTo(15),
        reason: 'judged files that name a bridge are the ones that can fail',
      );
      final unknown = {
        for (final a in audits)
          ...a.calls.where((c) => !_registrars.containsKey(c)),
      };
      expect(
        unknown,
        isEmpty,
        reason:
            'add these to `_registrars` so their ownership is computed: '
            '$unknown',
      );
      final consumer = audits.singleWhere(
        (a) => a.file.endsWith('stdlib_stream_consumer_test.dart'),
      );
      expect(consumer.calls, containsAll(['CoreStdlib', 'AsyncStreamStdlib']));
    });
  });
}
