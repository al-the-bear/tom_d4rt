/// Tests for GEN-056: Extension on-type resolution for stdlib and bridge types.
///
/// Verifies that bridged extensions can resolve their on-type when:
/// - The on-type is from a stdlib module (e.g., Platform from dart:io)
/// - The on-type is from another bridge package
/// - The script does not explicitly import the on-type's source module
///
/// These tests exercise the module_loader's type resolution fallback logic.
@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  group('GEN-056: Extension on stdlib types', () {
    test(
      'GEN-056a: Extension on dart:io Platform resolves without explicit dart:io import. [2026-02-14] (PASS)',
      () {
        final d4rt = D4rt()..setDebug(false);
        d4rt.grant(FilesystemPermission.any);

        // Register a bridged extension on Platform (dart:io type)
        d4rt.registerBridgedExtension(
          BridgedExtensionDefinition(
            name: 'PlatformHelper',
            onTypeName: 'Platform',
            getters: {'info': (visitor, target) => 'platform_info'},
          ),
          'package:test_pkg/test_pkg.dart',
        );

        // Validate registrations — the script imports test_pkg but NOT dart:io.
        // The interpreter should auto-resolve Platform from dart:io stdlib.
        final errors = d4rt.validateRegistrations(
          source: '''
          import 'package:test_pkg/test_pkg.dart';
          void main() {}
        ''',
        );

        expect(
          errors,
          isEmpty,
          reason:
              'Extension on Platform should resolve without explicit dart:io import',
        );
      },
    );

    test(
      'GEN-056b: Extension on dart:io Platform resolves with explicit dart:io import. [2026-02-14] (PASS)',
      () {
        final d4rt = D4rt()..setDebug(false);
        d4rt.grant(FilesystemPermission.any);

        // Register a bridged extension on Platform (dart:io type)
        d4rt.registerBridgedExtension(
          BridgedExtensionDefinition(
            name: 'PlatformHelper',
            onTypeName: 'Platform',
            getters: {'info': (visitor, target) => 'platform_info'},
          ),
          'package:test_pkg/test_pkg.dart',
        );

        // With explicit dart:io import BEFORE the package import,
        // Platform should already be in the environment.
        final errors = d4rt.validateRegistrations(
          source: '''
          import 'dart:io';
          import 'package:test_pkg/test_pkg.dart';
          void main() {}
        ''',
        );

        expect(
          errors,
          isEmpty,
          reason:
              'Extension on Platform should resolve with explicit dart:io import',
        );
      },
    );

    test(
      'GEN-056c: Extension on bridge class from another package resolves. [2026-02-14] (PASS)',
      () {
        final d4rt = D4rt()..setDebug(false);

        // Register a BridgedClass under package A
        final myClass = BridgedClass(
          nativeType: String, // Using String as a placeholder native type
          name: 'MyCustomClass',
          getters: {'value': (visitor, instance) => 'test'},
        );
        d4rt.registerBridgedClass(myClass, 'package:pkg_a/pkg_a.dart');

        // Register an extension on MyCustomClass under package B
        d4rt.registerBridgedExtension(
          BridgedExtensionDefinition(
            name: 'MyCustomClassExt',
            onTypeName: 'MyCustomClass',
            getters: {'doubled': (visitor, target) => 'doubled'},
          ),
          'package:pkg_b/pkg_b.dart',
        );

        // Import package B only — MyCustomClass is from package A which
        // is NOT imported. The extension should still resolve because
        // MyCustomClass is registered as a bridge class.
        final errors = d4rt.validateRegistrations(
          source: '''
          import 'package:pkg_a/pkg_a.dart';
          import 'package:pkg_b/pkg_b.dart';
          void main() {}
        ''',
        );

        expect(
          errors,
          isEmpty,
          reason:
              'Extension on MyCustomClass should resolve from bridge class registry',
        );
      },
    );

    test(
      'GEN-056d: Extension on unknown type reports error. [2026-02-14] (PASS)',
      () {
        final d4rt = D4rt()..setDebug(false);

        // Register an extension on a type that doesn't exist anywhere
        d4rt.registerBridgedExtension(
          BridgedExtensionDefinition(
            name: 'UnknownTypeExt',
            onTypeName: 'CompletelyUnknownType',
            getters: {'foo': (visitor, target) => 'bar'},
          ),
          'package:test_pkg/test_pkg.dart',
        );

        final errors = d4rt.validateRegistrations(
          source: '''
          import 'package:test_pkg/test_pkg.dart';
          void main() {}
        ''',
        );

        expect(
          errors,
          isNotEmpty,
          reason: 'Extension on unknown type should produce an error',
        );
        expect(errors.first, contains('CompletelyUnknownType'));
      },
    );

    test(
      'GEN-056e: Multiple extensions on different stdlib types resolve. [2026-02-14] (PASS)',
      () {
        final d4rt = D4rt()..setDebug(false);
        d4rt.grant(FilesystemPermission.any);

        // Extension on Platform (dart:io)
        d4rt.registerBridgedExtension(
          BridgedExtensionDefinition(
            name: 'PlatformExt',
            onTypeName: 'Platform',
            getters: {'info': (visitor, target) => 'platform'},
          ),
          'package:multi_ext/multi_ext.dart',
        );

        // Extension on String (dart:core — always loaded)
        d4rt.registerBridgedExtension(
          BridgedExtensionDefinition(
            name: 'StringExt',
            onTypeName: 'String',
            getters: {
              'reversed': (visitor, target) => String.fromCharCodes(
                (target as String).runes.toList().reversed,
              ),
            },
          ),
          'package:multi_ext/multi_ext.dart',
        );

        final errors = d4rt.validateRegistrations(
          source: '''
          import 'package:multi_ext/multi_ext.dart';
          void main() {}
        ''',
        );

        expect(
          errors,
          isEmpty,
          reason:
              'All extensions should resolve — String from core, Platform from io',
        );
      },
    );

    test(
      'GEN-056f: an on-type resolved by the fallback reports no error. [2026-08-04] (PASS)',
      () {
        // GEN-056a proves the fallback *resolves* Platform. This asserts the
        // probe that precedes it stays quiet: the environment lookup misses by
        // design (the script never imports dart:io), and a miss that the loader
        // then handles must not be left behind in the ErrorReporter.
        //
        // It is not cosmetic. Any host that collects reported errors as its
        // pass/fail signal — the dcli/d4rt REPL in `-test` mode is one — counts
        // these and fails a run in which nothing actually went wrong: importing
        // a bridge library with N such extensions reports N phantom
        // "Undefined variable" errors.
        ErrorReporter.enableTracking();
        ErrorReporter.clear();
        try {
          final d4rt = D4rt()..setDebug(false);
          d4rt.grant(FilesystemPermission.any);

          d4rt.registerBridgedExtension(
            BridgedExtensionDefinition(
              name: 'PlatformHelper',
              onTypeName: 'Platform',
              getters: {'info': (visitor, target) => 'platform_info'},
            ),
            'package:test_pkg/test_pkg.dart',
          );

          final errors = d4rt.validateRegistrations(
            source: '''
            import 'package:test_pkg/test_pkg.dart';
            void main() {}
          ''',
          );
          expect(errors, isEmpty);

          expect(
            ErrorReporter.errors.map((e) => e.message).toList(),
            isNot(contains(contains('Undefined variable: Platform'))),
            reason: 'A handled lookup miss must not be reported as an error',
          );
        } finally {
          ErrorReporter.clear();
          ErrorReporter.disableTracking();
        }
      },
    );

    test(
      'GEN-056g: probing the stdlib modules for an on-type reports nothing. [2026-08-04] (PASS)',
      () {
        // The stdlib fallback loads one module at a time and asks whether the
        // on-type has appeared. Every module that does not carry it is a miss by
        // construction, and an on-type that resolves nowhere misses in all of
        // them — which is not a runtime error: the loader's contract for that
        // case is to warn, skip the extension, and (under validation) return the
        // one collected message GEN-056d asserts.
        //
        // GEN-056f covers the probe *before* the fallback; this covers the probe
        // *inside* it, a separate call site that was still throwing. Its misses
        // left one `Undefined variable` per stdlib module behind, so a host
        // reading the ErrorReporter — the dcli/d4rt REPL in `-test` mode — failed
        // a run over an extension the loader had deliberately skipped. Importing
        // a bridge library whose on-type is not bridged (`Digest`, from a crypto
        // package) was enough to do it.
        ErrorReporter.enableTracking();
        ErrorReporter.clear();
        try {
          final d4rt = D4rt()..setDebug(false);
          d4rt.grant(FilesystemPermission.any);

          d4rt.registerBridgedExtension(
            BridgedExtensionDefinition(
              name: 'DigestHelper',
              onTypeName: 'CompletelyUnknownType',
              getters: {'summary': (visitor, target) => 'unknown'},
            ),
            'package:test_pkg/test_pkg.dart',
          );

          d4rt.validateRegistrations(
            source: '''
            import 'package:test_pkg/test_pkg.dart';
            void main() {}
          ''',
          );

          expect(
            ErrorReporter.errors.map((e) => e.message).toList(),
            isNot(
              contains(contains('Undefined variable: CompletelyUnknownType')),
            ),
            reason:
                'A stdlib probe that misses must not be reported as an error',
          );
        } finally {
          ErrorReporter.clear();
          ErrorReporter.disableTracking();
        }
      },
    );
  });
}
