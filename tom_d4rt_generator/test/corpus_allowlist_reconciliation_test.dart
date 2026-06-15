/// Static reconciliation for the committed corpus relaxer allowlist (P&R#5 c
/// — the static half).
///
/// P&R#5 step 3 ("Verify") asks for **zero relaxer/ctor misses** once
/// `generateAllRelaxers: false` gates the combinatorial B/C switch families to
/// `genericExtractionSites ∪ relaxerClasses ∪ additionalRelaxerTypes`. The
/// `additionalRelaxerTypes` allowlist is the committed
/// `doc/corpus_relaxer_allowlist.yaml`, produced by `scan_corpus_types` over
/// the flutter-material HTTP corpus.
///
/// A *runtime* zero-miss proof (the dynamic half) needs one serial corpus run
/// with `D4RT_LOG_RELAXER_USAGE=1` on both flutter twins — co-located with the
/// `generateAllRelaxers: false` production flip behind the heavyweight serial
/// base-test gate. That stays deferred.
///
/// What is provable here, statically and without flutter, is the *static*
/// guarantee the runtime proof rests on: the committed allowlist is a faithful,
/// current **superset** of every type-argument the corpus writes syntactically.
/// A fresh `CorpusTypeScanner.scanDirectory` over the live corpus must not
/// surface a single type-arg that is absent from the committed allowlist —
/// otherwise reduced generation could silently drop a switch case the corpus
/// exercises. This test pins that contract and guards the artifact against
/// drift: add a corpus script using a new generic type-argument and this test
/// fails until `corpus_relaxer_allowlist.yaml` is regenerated.
///
/// The only runtime hit that can legitimately be absent from this static scan
/// is a type-arg supplied purely by inference (never written `<...>`); those
/// correspond to bridge extraction sites and are covered independently by
/// `genericExtractionSites`, which the reduced gating unions in regardless of
/// the allowlist.
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';
import 'package:yaml/yaml.dart';

/// Resolves a path relative to the `tom_d4rt_generator` package root, whatever
/// the test runner's CWD happens to be.
String _fromPackageRoot(String relative) {
  // This file lives at <pkg>/test/corpus_allowlist_reconciliation_test.dart.
  final testFileDir = p.dirname(Platform.script.toFilePath());
  // Walk up to the package root when invoked oddly; fall back to CWD-relative.
  for (final base in <String>[
    p.normalize(p.join(testFileDir, '..')),
    Directory.current.path,
  ]) {
    final candidate = p.normalize(p.join(base, relative));
    if (File(candidate).existsSync() || Directory(candidate).existsSync()) {
      return candidate;
    }
  }
  // Last resort: CWD-relative (lets the failure message show the real path).
  return p.normalize(p.join(Directory.current.path, relative));
}

const _corpusRelative =
    '../tom_d4rt_flutter_ast/test/tom_d4rt_flutter_ast_app/test/'
    'send_ast_via_http_scripts';
const _allowlistRelative = 'doc/corpus_relaxer_allowlist.yaml';

/// Reads the `additionalRelaxerTypes:` entries from the committed allowlist.
Set<String> _readCommittedAllowlist(String path) {
  final doc = loadYaml(File(path).readAsStringSync());
  final list = (doc as YamlMap)['additionalRelaxerTypes'] as YamlList;
  return list.map((e) => e.toString()).toSet();
}

void main() {
  group('Corpus allowlist reconciliation (P&R#5 c — static)', () {
    final corpusPath = _fromPackageRoot(_corpusRelative);
    final allowlistPath = _fromPackageRoot(_allowlistRelative);

    test('G-RCN-1: committed allowlist file exists and parses', () {
      expect(File(allowlistPath).existsSync(), isTrue,
          reason: 'missing committed allowlist at $allowlistPath');
      final names = _readCommittedAllowlist(allowlistPath);
      expect(names, isNotEmpty);
    });

    test('G-RCN-2: corpus directory is present', () {
      expect(Directory(corpusPath).existsSync(), isTrue,
          reason: 'corpus not found at $corpusPath');
    });

    test(
        'G-RCN-3: committed allowlist is a superset of a fresh corpus scan '
        '(zero-miss for syntactically-written type-args)', () {
      const scanner = CorpusTypeScanner();
      final fresh = scanner.scanDirectory(corpusPath);
      final committed = _readCommittedAllowlist(allowlistPath);

      final scanned = fresh.typeArgumentCounts.keys.toSet();
      final missing = scanned.difference(committed).toList()..sort();

      expect(
        missing,
        isEmpty,
        reason: 'These type-args appear in the corpus but are absent from the '
            'committed allowlist — reduced generation would drop their switch '
            'cases. Regenerate doc/corpus_relaxer_allowlist.yaml via '
            '`dart run tom_d4rt_generator:scan_corpus_types`:\n'
            '${missing.join(', ')}',
      );
    });

    test(
        'G-RCN-4: committed allowlist matches a fresh scan exactly '
        '(no stale extras either)', () {
      const scanner = CorpusTypeScanner();
      final fresh = scanner.scanDirectory(corpusPath);
      final committed = _readCommittedAllowlist(allowlistPath);
      final scanned = fresh.typeArgumentCounts.keys.toSet();

      // Equality is the reconciliation snapshot. G-RCN-3 (superset) is the
      // load-bearing safety property; this stricter check also catches a stale
      // allowlist that lists type-args the corpus no longer uses, prompting a
      // regen so the artifact stays an honest record of the corpus.
      expect(
        scanned,
        equals(committed),
        reason: 'Committed allowlist diverged from a fresh scan. '
            'Regenerate doc/corpus_relaxer_allowlist.yaml.\n'
            'Only-in-corpus: ${(scanned.difference(committed).toList()..sort())}\n'
            'Only-in-allowlist: '
            '${(committed.difference(scanned).toList()..sort())}',
      );
    });

    test('G-RCN-5: scanned file count matches the committed corpus size', () {
      const scanner = CorpusTypeScanner();
      final fresh = scanner.scanDirectory(corpusPath);
      // The committed artifact header records "Files scanned: 2083"; a large
      // drift signals the corpus moved or the path is wrong, which would make
      // the reconciliation above vacuous.
      expect(fresh.filesScanned, greaterThan(1500),
          reason: 'unexpectedly few corpus files scanned '
              '(${fresh.filesScanned}) — corpus path may be wrong');
      expect(fresh.readFailures, isEmpty,
          reason: 'corpus files failed to read: ${fresh.readFailures}');
    });
  });
}
