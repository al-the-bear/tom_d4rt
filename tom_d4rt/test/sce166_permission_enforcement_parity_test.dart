// REPO-WIDE GUARD (tom_d4rt) — every permission the sandbox DECLARES is
// enforced somewhere, in BOTH interpreter trees.
//
// Its subject reaches OUTSIDE this package (the twin's `lib/src/runtime`), so
// it runs only when tom_d4rt's suite runs. SCD129 made that arrangement visible
// rather than incidental: `grep -rn 'REPO-WIDE GUARD' */test` lists every one,
// and `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
/// SCE166 — a declared permission that nothing checks is worse than no
/// permission at all.
///
/// The analyzer-free tree declared `IsolatePermission` and consulted it
/// NOWHERE: a bundle could import `dart:isolate`, build `ReceivePort`s and call
/// `Isolate.spawn` with the embedder granting nothing. `dart:io` was equally
/// open. The reference tree had gated both in `ModuleLoader
/// ._checkModulePermissions` since long before.
///
/// THE PLACE MATTERS MORE THAN THE GAP. `tom_d4rt_ast` is the tree that ships
/// inside Flutter apps executing bundles downloaded at runtime — precisely the
/// deployment where an ungated capability counts — and it was the line without
/// the gate. The permission class being PRESENT made it worse rather than
/// better: an embedder reading `IsolatePermission` in the public API reasonably
/// concludes the capability is gated.
///
/// ## Why a structural guard and not just the two behavioural tests
///
/// `tom_d4rt_ast/test/runtime/sce166_module_permission_gate_test.dart` pins the
/// two gates by executing bundles. That is the right test for the two gates
/// that exist, and it says nothing about the seventh permission somebody adds
/// next year. One instance of "declared and unchecked" implies the question for
/// all of them, and the honest form of the question is a scan rather than
/// another audit: the declarations are one file per tree and the enforcement
/// sites are a grep, so this is cheap and total.
///
/// It compares the two trees as well as checking each, because a permission
/// added to one tree only is the same defect one level up — and that is exactly
/// the shape this todo was filed about.
///
/// ## What this guard CANNOT see, measured rather than assumed
///
/// | ablation                                   | here | the behavioural tests |
/// | ------------------------------------------ | ---- | --------------------- |
/// | the gate's CALL removed, the method kept    | ok   | RED (-1 and -3)       |
/// | a 7th permission declared in one tree only  | RED  | ok                    |
/// | the gate removed outright                   | RED  | RED                   |
///
/// The first row is the division of labour, and it is a real limit rather than
/// an oversight: this scan asks whether anything in the tree REFERENCES a
/// permission's type string, so a gate that exists and is never invoked passes
/// it. Nothing static can cheaply prove the call is reached. What proves it is
/// executing a bundle, which is exactly what
/// `tom_d4rt_ast/test/runtime/sce166_module_permission_gate_test.dart` does —
/// and it goes red on that row. Neither test is sufficient alone; the pair is
/// why both exist.
library;

import 'dart:io';

import 'package:test/test.dart';

import 'sibling_trees.dart';

const _refPermissions = 'lib/src/security/permissions.dart';
const _astPermissions =
    '../tom_d4rt_ast/lib/src/runtime/security/permissions.dart';
const _refLib = 'lib/src';
const _astLib = '../tom_d4rt_ast/lib/src/runtime';

/// Floors, not equalities. Six permissions exist today; the point is that the
/// scan found a real file, not that the number stays six.
const _minPermissions = 4;

/// `<class name>` → the `type` string it answers to, read from [source].
///
/// Each permission declares `final String type = '<kind>';` and every
/// enforcement site passes that string in a `{'type': '<kind>', ...}` map, so
/// the declaration is what links the two halves. Reading it rather than
/// hard-coding a table means a seventh permission is covered the day it is
/// written.
Map<String, String> declaredPermissions(String source) {
  final out = <String, String>{};
  final lines = source.split('\n');
  String? current;
  for (final line in lines) {
    final declaration = RegExp(
      r'^(?:abstract\s+)?class\s+(\w+)\s+extends\s+Permission\b',
    ).firstMatch(line);
    if (declaration != null) {
      current = declaration.group(1);
      continue;
    }
    if (current == null) continue;
    final type = RegExp(
      r"""^\s*(?:final|const)\s+String\s+type\s*=\s*'(\w+)'""",
    ).firstMatch(line);
    if (type != null) {
      out[current] = type.group(1)!;
      current = null;
    }
  }
  return out;
}

/// Files under [root] that pass `'type': '<kind>'` to a permission check.
///
/// `permissions.dart` itself is excluded: it DECLARES the kinds and matches
/// against them, so counting it would make every permission look enforced by
/// virtue of existing — which is the exact failure this guard is about.
List<String> enforcementSites(String root, String kind) {
  final needle = "'type': '$kind'";
  final out = <String>[];
  final dir = Directory(root);
  if (!dir.existsSync()) return out;
  for (final entity in dir.listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    if (entity.path.endsWith('security/permissions.dart')) continue;
    if (entity.readAsStringSync().contains(needle)) {
      out.add(entity.path.substring(root.length + 1));
    }
  }
  out.sort();
  return out;
}

void main() {
  // SCD158: this guard resolves both trees relative to the package it runs in,
  // so a copy elsewhere would scan a different pair in silence.
  requirePackage('tom_d4rt', subject: 'both interpreter trees\' sandbox');

  late Map<String, String> refDeclared;
  late Map<String, String> astDeclared;

  setUpAll(() {
    for (final path in <String>[_refPermissions, _astPermissions]) {
      expect(
        File(path).existsSync(),
        isTrue,
        reason:
            '$path is where the permissions are declared. If it moved, move '
            'this guard with it rather than leaving one that scans nothing',
      );
    }
    refDeclared = declaredPermissions(File(_refPermissions).readAsStringSync());
    astDeclared = declaredPermissions(File(_astPermissions).readAsStringSync());
  });

  group('SCE166: every declared permission is enforced, in both trees', () {
    test('F-SCE166-6: no permission is declared and never checked '
        '[2026-09-23]', () {
      final unenforced = <String>[];
      for (final (label, declared, root)
          in <(String, Map<String, String>, String)>[
            ('tom_d4rt', refDeclared, _refLib),
            ('tom_d4rt_ast', astDeclared, _astLib),
          ]) {
        for (final entry in declared.entries) {
          if (enforcementSites(root, entry.value).isEmpty) {
            unenforced.add(
              '$label: ${entry.key} (type \'${entry.value}\') is declared and '
              'checked nowhere',
            );
          }
        }
      }
      expect(
        unenforced,
        isEmpty,
        reason:
            'A permission class on the public API that nothing consults is '
            'worse than an absent one: an embedder reading it reasonably '
            'concludes the capability is gated, and it is not. This is the '
            'state `IsolatePermission` was in on the analyzer-free line — the '
            'tree that runs downloaded bundles inside shipped '
            'apps:\n  ${unenforced.join('\n  ')}',
      );
    });

    test('F-SCE166-7: the two trees declare the same permissions, answering to '
        'the same type strings [2026-09-23]', () {
      expect(
        astDeclared,
        refDeclared,
        reason:
            'a permission declared in one tree only is the same defect one '
            'level up — half the sandbox has a capability the other half does '
            'not know exists. Mirror the declaration, then F-SCE166-6 will '
            'ask for its enforcement',
      );
    });

    test('F-SCE166-8 (control): the scan parsed real declarations and real '
        'sites [2026-09-23]', () {
      for (final (label, declared) in <(String, Map<String, String>)>[
        ('tom_d4rt', refDeclared),
        ('tom_d4rt_ast', astDeclared),
      ]) {
        expect(
          declared.length,
          greaterThanOrEqualTo(_minPermissions),
          reason:
              '$label: only ${declared.length} permissions parsed. F-SCE166-6 '
              'iterates this map, so a broken parse passes it by checking '
              'nothing — which is the exact failure mode of the thing it '
              'guards',
        );
      }
      expect(
        refDeclared.values.toSet(),
        contains('isolate'),
        reason:
            'the permission this guard was written for must be among the ones '
            'it found',
      );
      // And the site scan is discriminating rather than matching everything:
      // a kind nothing uses must come back empty.
      expect(
        enforcementSites(_refLib, 'no_such_permission_kind'),
        isEmpty,
        reason:
            'the enforcement scan matched a kind that does not exist, so every '
            'permission would look enforced',
      );
      expect(
        enforcementSites(_astLib, 'isolate'),
        isNotEmpty,
        reason:
            'the twin\'s isolate gate is what SCE166 added; if this is empty '
            'the scan is not reading the twin',
      );
    });
  });
}
