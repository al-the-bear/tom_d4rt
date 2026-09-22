/// SCE155 — a deprecation with a removal version, held by a test rather than
/// by memory.
///
/// `lib/src/bridge/library_mapping.dart` declares `LibraryBridgeDefinition`,
/// `BarrelMapping` and `ModuleBridgeInfo`, and `d4rt.dart` exports all three.
/// Nothing uses them. Not this package, not the generator, not the twins, not
/// the CLI tools, not a test — and, measured against pub.dev's own dependents
/// list rather than guessed at, no consumer outside this workspace either. The
/// design they describe (deduplicating elements that reach the interpreter
/// through several barrels) was solved in the GENERATOR instead, at generation
/// time, by `PerPackageBridgeOrchestrator`. It is superseded, not unfinished.
///
/// ## Why a test and not a todo
///
/// The removal is breaking, so it belongs at a major, and `tom_d4rt` has no
/// major on any roadmap — it publishes minors several times a day. A todo
/// saying "remove at 2.0.0" would sit unread until somebody happened to open
/// it during the one release where it applied. The obligation is therefore
/// attached to the condition that makes it actionable: F-SCE155-1 goes red the
/// moment this package's major version reaches 2 with the file still present.
///
/// The same shape is why F-SCE155-2 exists. A deprecation whose message names
/// no removal version is a deprecation nobody can schedule, and it is the
/// cheapest thing in the world to write one — so that is checked here too,
/// against the file rather than against a convention.
///
/// ## The anchor, and why the obvious argument against it is wrong
///
/// The subject is this package's own `lib/` and its own `pubspec.yaml`, so the
/// tempting reading of SCD158 is that no anchor is needed: a copy elsewhere
/// finds no `lib/src/bridge/library_mapping.dart` and fails on its own.
///
/// Measured, by copying this file into `tom_d4rt_exec` and running it: it does
/// fail — 1 of 2 — and it fails saying *"the file was removed before the major
/// that permits it"*, which is a report of an event that never happened, about
/// a package that never had the file. Red for the wrong reason is not much
/// better than green for no reason; both send the reader somewhere the defect
/// is not. So it is anchored, and a copy now says what is actually true.
library;

import 'dart:io';

import 'package:test/test.dart';

import 'sibling_trees.dart';

/// The types this file is about, and the version their removal is due at.
const _deadTypes = <String>[
  'LibraryBridgeDefinition',
  'BarrelMapping',
  'ModuleBridgeInfo',
];

const _removalMajor = 2;

const _mappingFile = 'lib/src/bridge/library_mapping.dart';

int _declaredMajor() {
  for (final line in File('pubspec.yaml').readAsLinesSync()) {
    if (line.startsWith('version:')) {
      return int.parse(
        line.substring('version:'.length).trim().split('.').first,
      );
    }
  }
  fail('no `version:` line in pubspec.yaml');
}

void main() {
  // SCD158: this guard reads `lib/` and `pubspec.yaml` relative to the package
  // it runs in, so a copy elsewhere silently asks a different question.
  requirePackage(
    'tom_d4rt',
    subject:
        "tom_d4rt's own published surface and declared version. It is "
        'structurally single-copy: tom_d4rt_ast never had '
        'lib/src/bridge/library_mapping.dart, so a port has no subject rather '
        'than a different one',
  );

  group('SCE155: the dead bridge-mapping surface is scheduled, not forgotten', () {
    test('F-SCE155-1: at 2.0.0 the deprecated file and its export are gone', () {
      final major = _declaredMajor();
      final file = File(_mappingFile);
      if (major < _removalMajor) {
        expect(
          file.existsSync(),
          isTrue,
          reason:
              'the file was removed before the major that permits it. Removing '
              'an exported type is breaking; if this was deliberate, the '
              'version has to move first and this guard has to be deleted with '
              'it, not left behind asserting a schedule nobody is following',
        );
        return;
      }

      expect(
        file.existsSync(),
        isFalse,
        reason:
            'tom_d4rt is at major $major, which is the release the SCE155 '
            'deprecation was written for: $_mappingFile and its `export` line '
            'in lib/d4rt.dart come out, together with their '
            '${_deadTypes.length} `_divergences` entries in '
            'scd134_barrel_surface_parity_test.dart and this file. The types '
            'are ${_deadTypes.join(', ')}',
      );
    });

    test('F-SCE155-2: every dead type is deprecated, and the deprecation names '
        'the release that removes it', () {
      final file = File(_mappingFile);
      if (!file.existsSync()) return; // F-SCE155-1 owns the post-removal state.
      final source = file.readAsStringSync();

      final undeprecated = <String>[];
      for (final type in _deadTypes) {
        final declaration = source.indexOf('class $type {');
        expect(
          declaration,
          greaterThanOrEqualTo(0),
          reason:
              '`$type` is no longer declared in $_mappingFile. If it moved, '
              'this list moves with it; if it was removed early, see '
              'F-SCE155-1',
        );
        // The annotation sits immediately above the declaration; 400 chars is
        // ample for it and far short of the previous class's body.
        final window = source.substring(
          declaration < 400 ? 0 : declaration - 400,
          declaration,
        );
        if (!window.contains('@Deprecated(')) undeprecated.add(type);
      }
      expect(
        undeprecated,
        isEmpty,
        reason:
            'these types are on the published surface with no deprecation, so '
            'a consumer reaching for one today gets no warning that it is '
            'scheduled to go: ${undeprecated.join(', ')}',
      );

      expect(
        source.contains('tom_d4rt $_removalMajor.0.0'),
        isTrue,
        reason:
            'a deprecation message that names no removal version cannot be '
            'scheduled by anyone, and F-SCE155-1 above is calibrated to '
            'major $_removalMajor. The two have to agree',
      );
    });
  });
}
