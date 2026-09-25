/// SCD146 — a census of what `nativeNames` is still doing, after SCC49.
///
/// SCC49 demoted the allowlist from THE dispatch mechanism to a fast path plus
/// an explicit-ownership override, and deliberately touched no existing entry:
/// a change that both adds a mechanism and removes the old one cannot be
/// bisected if it regresses. So the lists became three kinds in unknown
/// proportion, and this file measures the split.
///
///   1. **Redundant** — the name alone would reach the same bridge.
///   2. **Load-bearing, the SDK abbreviates** — the implementation type is not
///      named after its interface, so no suffix rule can reach it
///      (`_StreamSinkWrapper` for `StreamSink`).
///   3. **Load-bearing as an OVERRIDE** — the name points at a DIFFERENT
///      bridge and the entry corrects it. The dangerous ones: removing one is
///      silently wrong rather than loudly broken.
///
/// ## Measured 2026-09-15 — 84 bridges, 106 entries
///
/// | kind | count | share |
/// | ---- | ----: | ----: |
/// | 1 — redundant | 87 | 82 % |
/// | 2 — SDK abbreviates | 17 | 16 % |
/// | 3 — override | **2** | 2 % |
///
/// **Four fifths of the allowlist is dead weight by name**, and the override
/// kind — the one the todo expected to be most dangerous — is almost empty.
/// Both survivors are in the `Stream` bridge's list and both point elsewhere:
///
/// | entry | the name reaches | the entry forces |
/// | ----- | ---------------- | ---------------- |
/// | `_StreamIterator` | `StreamIterator` | `Stream` |
/// | `_HandlerEventSink` | `EventSink` | `Stream` |
///
/// Neither looks like an override that corrects a misleading name. They look
/// like entries a more specific bridge already claims — which is measured for
/// `_StreamIterator` (F-SCD146-3) and untested for the other.
///
/// ## WHAT THIS CENSUS DOES AND DOES NOT PREDICT — read before pruning
///
/// It classifies the NAME RELATIONSHIP, which is how the three kinds are
/// defined. It does **not** predict that a kind-1 entry is safe to delete, and
/// the reason is a correction this file made to itself.
///
/// The first draft modelled only SCC49's structural pass, which strips a
/// leading `_` before matching. On that model `_StreamIterator` "points at"
/// `Iterator` — but measured, it resolves to `StreamIterator` and scripts using
/// it work. Step 3's generic arm runs first and matches the UNSTRIPPED name, so
/// `_StreamIterator` ends with `StreamIterator` and takes it. The census now
/// models both and takes the longer match, because either path may fire.
///
/// The correction moved the split from 84/18/4 to 87/17/2: `_TypeError` and
/// `_AssertionError` had been reported as overrides because stripping the
/// underscore made their names exactly as long as their own bridge's, which the
/// `strictly shorter` rule excludes — so the match fell through to `Error`. With
/// the underscore kept they reach their own bridge and are simply redundant.
/// **The first draft was wrong about half of the category it was most
/// interested in**, which is the argument for validating a classifier against
/// ground truth rather than trusting its output.
///
/// That correction is also a finding: the `Stream` bridge's `_StreamIterator`
/// entry is INERT — a more specific bridge claims the type first — which no
/// amount of reading the list would have shown.
///
/// ## After the prune — measured 2026-09-25 (SCE177)
///
/// The 85 kind-1 entries with no reason to stay were deleted, and both
/// interpreter suites ran green on the result — the analyzer-free line's
/// routing cases rewritten to ask `toBridgedClass` which bridge a REAL SDK
/// object reaches, rather than whether a name sits in a list. What is left:
///
/// | kind | count |
/// | ---- | ----: |
/// | 2 — SDK abbreviates | 19 |
/// | 3 — override (sce178's) | 2 |
/// | 1 — redundant but KEPT, each for a stated reason | 3 |
///
/// 24 entries across 10 bridges, from 109 across 28. The three kept ones are
/// [_redundantButKept]; F-SCE177-1 keeps that list honest in both directions.
///
/// The real resolution order has more arms than any static model should claim
/// to reproduce (a private-name arm, an exact-name pass, a nativeName PREFIX
/// pass, PASS B's corroborated prefix, then the structural pass). So the honest
/// use of this table is to say WHICH entries are worth attempting to remove and
/// which must not be touched — the removal itself is measured by deleting and
/// running, which is sce177.
/// ## Why there is no twin of this file
///
/// `tom_d4rt_ast` carries the same stdlib and therefore the same allowlists —
/// and that is not an assumption: `scd49_stdlib_twin_sync_test.dart` asserts the
/// two stdlib trees are code-identical except at four recorded points, none of
/// which is a `nativeNames` list. A second census would print the same table on
/// every run, which `mirror_maintenance.md` records as noise in every future
/// diff. If SCD49's guard ever baselines a stdlib bridge as divergent, that is
/// the moment to revisit this.
@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// How the three kinds are decided for one entry.
enum EntryKind { redundant, sdkAbbreviates, override }

/// One classified `nativeNames` entry.
typedef Census = ({
  String entry,
  String owner,
  EntryKind kind,
  String? nameReaches,
});

/// `_structuralBaseName` — strip type arguments, then a leading underscore.
String structuralBase(String name) {
  var s = name;
  final angle = s.indexOf('<');
  if (angle >= 0) s = s.substring(0, angle);
  if (s.startsWith('_')) s = s.substring(1);
  return s;
}

/// Step 3's base — type arguments stripped, underscore KEPT.
String genericBase(String name) {
  final angle = name.indexOf('<');
  return angle >= 0 ? name.substring(0, angle) : name;
}

/// `_longestNameSuffixMatch`, replicated exactly: at least three characters,
/// strictly shorter than the subject, longest wins.
String? longestSuffix(Iterable<String> bridgeNames, String subject) {
  String? best;
  var bestLen = 0;
  for (final name in bridgeNames) {
    if (name.length < 3 || name.length <= bestLen) continue;
    if (subject.length <= name.length) continue;
    if (!subject.endsWith(name)) continue;
    bestLen = name.length;
    best = name;
  }
  return best;
}

/// The bridge the NAME alone would reach, by whichever of the two suffix paths
/// matches more of it.
String? nameReaches(Iterable<String> bridgeNames, String entry) {
  final viaGeneric = longestSuffix(bridgeNames, genericBase(entry));
  final viaStructural = longestSuffix(bridgeNames, structuralBase(entry));
  if (viaGeneric == null) return viaStructural;
  if (viaStructural == null) return viaGeneric;
  return viaGeneric.length >= viaStructural.length ? viaGeneric : viaStructural;
}

Future<List<Census>> takeCensus() async {
  final d4rt = D4rt();
  await d4rt.execute(source: 'dynamic main() => 1;');
  final env = d4rt.visitor!.globalEnvironment;

  final bridges = <String, BridgedClass>{};
  for (Environment? frame = env; frame != null; frame = frame.enclosing) {
    for (final name in frame.bridgedClassNames) {
      final bridge = env.findBridgedClassByName(name);
      if (bridge != null) bridges.putIfAbsent(name, () => bridge);
    }
  }

  final out = <Census>[];
  for (final bridge in bridges.values) {
    for (final entry in bridge.nativeNames ?? const <String>[]) {
      final reached = nameReaches(bridges.keys, entry);
      out.add((
        entry: entry,
        owner: bridge.name,
        kind: reached == null
            ? EntryKind.sdkAbbreviates
            : reached == bridge.name
            ? EntryKind.redundant
            : EntryKind.override,
        nameReaches: reached,
      ));
    }
  }
  return out;
}

/// Native types claimed by MORE THAN ONE bridge, with why each is still here.
///
/// A duplicate is not one of the three kinds this census set out to measure —
/// it was found on the way, and it is worse than any of them. The step-3 lookup
/// is a `firstWhereOrNull` over the registry, so which bridge wins is decided by
/// REGISTRATION ORDER: nothing records it, nothing tests it, and reordering two
/// `registerBridgedClass` calls changes dispatch silently. SCC49's own comment
/// says that is exactly why its suffix match became longest-wins; the same
/// hazard survived in `nativeNames`.
///
/// Recorded rather than fixed, deliberately: SCD146 is a census, and its own
/// instruction is to measure before changing so that a regression stays
/// attributable. Resolving one means deciding which bridge owns the type and
/// proving the other entry was inert — a measurement, not an edit. sce178 owns
/// it.
/// Kind-1 entries — the name alone reaches the owning bridge — that SCE177's
/// prune deliberately KEPT, with why. Anything redundant and not listed here is
/// an entry nobody needs, and a trap for the next reader: it makes the
/// mechanism look like it needs hand-maintenance when it does not.
const Map<String, String> _redundantButKept = {
  '_CopyingBytesBuilder':
      'In a Flutter app the widget bridges are in the NEARER scope frame and '
      '`Builder` is a suffix of this name, so without the precise entry '
      '`BytesBuilder()` resolves to the Builder widget (measured, SCE177; '
      'guarded by sce177_stdlib_routing_under_flutter_test.dart).',
  '_BytesBuilder':
      'The same exposure as `_CopyingBytesBuilder` by name: `Builder` is a '
      'suffix. The guard measured only the copying variant being taken, but '
      'the two are one decision in one list.',
  '_HandlerEventSink':
      'The `EventSink` half of a duplicate whose other half is the `Stream` '
      'override. Deleting only this half would hand the type to the override '
      'silently; which bridge owns it is sce178\'s decision.',
};

const Map<String, String> _knownDuplicates = {
  '_HandlerEventSink':
      'Claimed by `Stream` (async/stream.dart:70) and `EventSink` '
      '(async/stream.dart:1039). The name reaches `EventSink` by suffix, so the '
      '`Stream` entry is the one that needs justifying — and it may already be '
      'inert, exactly as the `Stream` bridge\'s `_StreamIterator` entry turned '
      'out to be (F-SCD146-3). Neither was measured here because instantiating '
      'the type needs a live `handleError` sink.',
};

void main() {
  late List<Census> census;

  setUpAll(() async => census = await takeCensus());

  group('SCD146: what nativeNames is still doing', () {
    test('F-SCD146-1: the census read a real registry [2026-09-15]', () {
      // Anti-vacuity. Every assertion below filters this list, and an empty one
      // satisfies all of them.
      expect(
        census.length,
        greaterThanOrEqualTo(20),
        reason:
            'only ${census.length} entries found; 24 across 10 bridges after '
            "SCE177's prune on 2026-09-25 (106 across 84 before it). Finding "
            'almost none means the stdlib did not register and this file is '
            'classifying nothing.',
      );
    });

    test('F-SCD146-2 (ground truth): the two entries SCC24 proved load-bearing '
        'classify as kind 2 [2026-09-15]', () {
      // This is what makes the classifier credible rather than plausible.
      // F-SCC24-8 asserts these stay INERT without their entry — measured,
      // not modelled — so a classifier that called them redundant would be
      // wrong in the one place there is independent evidence.
      for (final name in ['_StreamSinkWrapper', '_ControllerSubscription']) {
        final row = census.firstWhere((c) => c.entry == name);
        expect(
          row.kind,
          EntryKind.sdkAbbreviates,
          reason:
              '$name is owned by ${row.owner}; F-SCC24-8 measured that it is '
              'unreachable without its entry. The classifier says the name '
              'reaches ${row.nameReaches ?? "nothing"}.',
        );
      }
    });

    test('F-SCD146-3 (ground truth): a type whose name reaches a MORE specific '
        'bridge is classified as an override [2026-09-15]', () {
      // `_StreamIterator` sits in the `Stream` bridge's list, and measured
      // against a live interpreter it resolves to `StreamIterator` — a
      // different, more specific bridge that claims it first. So the entry is
      // inert, and the classifier must see the name pointing elsewhere.
      final row = census.firstWhere((c) => c.entry == '_StreamIterator');
      expect(row.owner, 'Stream');
      expect(row.kind, EntryKind.override);
      expect(
        row.nameReaches,
        'StreamIterator',
        reason:
            'the first draft of this census modelled only the structural '
            'pass, which strips the leading underscore, and so reported '
            '`Iterator`. Step 3 matches the unstripped name and gets '
            '`StreamIterator`, which is what actually happens.',
      );
    });

    test('F-SCD146-4: no entry is claimed by two bridges [2026-09-15]', () {
      // Not one of the three kinds, and the census found it anyway. When two
      // bridges list the same type, the step-3 lookup is a `firstWhereOrNull`
      // over the registry, so REGISTRATION ORDER decides silently — the exact
      // hazard SCC49's own comment says the longest-suffix change removed for
      // suffix matching. The same hazard survives here.
      final owners = <String, List<String>>{};
      for (final row in census) {
        owners.putIfAbsent(row.entry, () => <String>[]).add(row.owner);
      }
      final duplicated = {
        for (final e in owners.entries)
          if (e.value.length > 1) e.key: e.value..sort(),
      };

      final unrecorded = [
        for (final e in duplicated.entries)
          if (!_knownDuplicates.containsKey(e.key))
            '${e.key} claimed by ${e.value.join(", ")}',
      ];
      expect(
        unrecorded,
        isEmpty,
        reason:
            'Two bridges claiming one native type resolve by registration '
            'order, which nothing records and reordering silently changes. '
            'Decide which bridge owns it and delete the other entry, or '
            'record it here with the reason:\n  ${unrecorded.join("\n  ")}',
      );

      // No exemption outlives its cause — the scd49 / F-SCD134-3 rule. A
      // recorded duplicate that has been resolved must leave, or it silently
      // un-guards the name it names.
      final stale = [
        for (final name in _knownDuplicates.keys)
          if (!duplicated.containsKey(name))
            '$name is recorded as duplicated but is not',
      ];
      expect(stale, isEmpty, reason: stale.join('\n'));
    });

    test(
      'F-SCE177-1: every redundant entry that survives is kept for a '
      'stated reason, and every stated reason still applies [2026-09-25]',
      () {
        final redundant = {
          for (final row in census)
            if (row.kind == EntryKind.redundant) row.entry,
        };
        expect(
          redundant.difference(_redundantButKept.keys.toSet()),
          isEmpty,
          reason:
              'These entries are reached by name alone and nothing records why '
              'they are here. Delete them, or add them to `_redundantButKept` '
              'with the reason — typically a nearer-frame suffix match that '
              'would take the type (SCF26).',
        );
        expect(
          _redundantButKept.keys.toSet().difference(redundant),
          isEmpty,
          reason:
              'These are listed as kept-though-redundant but are no longer '
              'redundant entries (gone, or reclassified). Remove them from '
              '`_redundantButKept`.',
        );
      },
    );
  });
}
