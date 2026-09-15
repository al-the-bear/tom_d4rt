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
      // SCD196 raised it 26 -> 27, and the reason is the one case where raising
      // is right. `scd196_member_map_disjointness_test.dart` asks whether any
      // bridge declares one member in two maps; its subject is EVERY bridge, so
      // there is no bridge to name and reading the member maps off the loop
      // variable is the assertion rather than a shortcut. Same shape as the two
      // sweeps above. Raise this only for that shape; a site that COULD name
      // its bridge should.
      final unattributable = sites.length - attributed.length;
      expect(
        unattributable,
        lessThanOrEqualTo(27),
        reason:
            '$unattributable sites cannot be attributed to a bridge, against '
            '24 measured. Each is a site F-SCD151-1 cannot check. Prefer '
            'naming the bridge — `findReachableMethod(env, \'HashSet\', ...)` — '
            'over a receiver the scan has to infer.',
      );
    });
  });
}
