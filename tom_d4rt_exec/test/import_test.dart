import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  group('Import Tests', () {
    final Map<String, String> sources = {
      "d4rt-mem:/lib_common.dart": '''
    String getMessage() {
      return "Hello from lib_common!";
    }
    int getNumber() {
      return 42;
    }
    String getExtraMessage() {
      return "Extra message from lib_common!";
    }
    ''',
      "d4rt-mem:/main_source.dart": '''
    import 'lib_common.dart';

    String main() {
      return "Message from lib: " +
          getMessage() +
          " and number is " +
          getNumber().toString() +
          " and extra: " +
          getExtraMessage();
    }
    ''',
      "package:my_test_pkg/utils.dart": '''
    String getPackageUtilMessage() {
      return "Hello from my_test_pkg/utils!";
    }
    int getPackageUtilNumber() {
      return 123;
    }
    ''',
      "d4rt-mem:/main_pkg_import.dart": '''
    import 'package:my_test_pkg/utils.dart';
    String main() {
      return "PkgMsg: " +
          getPackageUtilMessage() +
          " | PkgNum: " +
          getPackageUtilNumber().toString();
    }
    ''',
      "d4rt-mem:/main_prefixed_pkg_import.dart": '''
    import 'package:my_test_pkg/utils.dart' as mypkg;
    String main() {
      return "PrefixedPkgMsg: " +
          mypkg.getPackageUtilMessage() +
          " | PrefixedPkgNum: " +
          mypkg.getPackageUtilNumber().toString();
    }
    ''',
      "d4rt-mem:/main_dart_math_import.dart": '''
    import 'dart:math';
    String main() {
      var result = sin(pi / 2);
      return "sin(pi/2) = " + result.toString();
    }
    ''',
      "d4rt-mem:/main_import_show.dart": '''
    import 'lib_common.dart' show getMessage, getNumber;
    String main() {
      return getMessage() + " | " + getNumber().toString();
    }
    ''',
      "d4rt-mem:/main_import_show_check_hidden.dart": '''
    import 'lib_common.dart' show getMessage, getNumber;
    String main() {
      return getExtraMessage();
    }
    ''',
      "d4rt-mem:/main_import_hide.dart": '''
    import 'lib_common.dart' hide getExtraMessage;
    String main() {
      return getMessage() + " | " + getNumber().toString();
    }
    ''',
      "d4rt-mem:/main_import_hide_check_hidden.dart": '''
    import 'lib_common.dart' hide getExtraMessage;
    String main() {
      return getExtraMessage();
    }
    ''',
      "d4rt-mem:/main_prefixed_import_show.dart": '''
    import 'lib_common.dart' as common show getMessage, getNumber;
    String main() {
      return common.getMessage() + " | " + common.getNumber().toString();
    }
    ''',
      "d4rt-mem:/main_prefixed_import_show_check_hidden.dart": '''
    import 'lib_common.dart' as common show getMessage, getNumber;
    String main() {
      return common.getExtraMessage();
    }
    ''',
      "d4rt-mem:/main_prefixed_import_hide.dart": '''
    import 'lib_common.dart' as common hide getExtraMessage;
    String main() {
      return common.getMessage() + " | " + common.getNumber().toString();
    }
    ''',
      "d4rt-mem:/main_prefixed_import_hide_check_hidden.dart": '''
    import 'lib_common.dart' as common hide getExtraMessage;
    String main() {
      return common.getExtraMessage();
    }
    ''',
      "d4rt-mem:/main_import_conflict_show.dart": '''
    import 'lib_common.dart' show getNumber;
    String getMessage() {
      return "Local getMessage";
    }
    String main() {
      return getMessage() + " | " + getNumber().toString();
    }
    ''',
      "d4rt-mem:/main_import_conflict_hide.dart": '''
    import 'lib_common.dart' hide getMessage;
    String getMessage() {
      return "Local getMessage";
    }
    String main() {
      return getMessage() + " | " + getNumber().toString() + " | " + getExtraMessage();
    }
    ''',
    };

    test(
      'I-IMPORT-9: Import local simple file (memory) - check all symbols of the common lib. [2026-02-12] (PASS)',
      () {
        final d4rt = D4rt();
        final mainlibrary = "d4rt-mem:/main_source.dart";
        final result = d4rt.execute(
          library: mainlibrary,
          sources: sources,
        );
        expect(
          result,
          equals(
              "Message from lib: Hello from lib_common! and number is 42 and extra: Extra message from lib_common!"),
        );
      },
    );

    test('I-IMPORT-1: Import package simple (memory). [2026-02-10 06:37] (PASS)', () {
      final d4rt = D4rt();
      final mainlibrary = "d4rt-mem:/main_pkg_import.dart";
      final result = d4rt.execute(
        library: mainlibrary,
        sources: sources,
      );
      expect(
        result,
        equals("PkgMsg: Hello from my_test_pkg/utils! | PkgNum: 123"),
      );
    });

    test('I-IMPORT-2: Import prefixed package (memory). [2026-02-10 06:37] (PASS)', () {
      final d4rt = D4rt();
      final mainlibrary = "d4rt-mem:/main_prefixed_pkg_import.dart";
      final result = d4rt.execute(
        library: mainlibrary,
        sources: sources,
      );
      expect(
        result,
        equals(
            "PrefixedPkgMsg: Hello from my_test_pkg/utils! | PrefixedPkgNum: 123"),
      );
    });

    test('I-IMPORT-3: Import dart:math (global functions). [2026-02-10 06:37] (PASS)', () {
      final d4rt = D4rt();
      final mainlibrary = "d4rt-mem:/main_dart_math_import.dart";
      final result = d4rt.execute(
        library: mainlibrary,
        sources: sources,
      );
      expect(result, equals("sin(pi/2) = 1.0"));
    });

    group('Combinators (show/hide)', () {
      test('I-IMPORT-4: Import with "show" (no prefix) - access allowed symbols. [2026-02-10 06:37] (PASS)', () {
        final d4rt = D4rt();
        final result = d4rt.execute(
          library: "d4rt-mem:/main_import_show.dart",
          sources: sources,
        );
        expect(result, equals("Hello from lib_common! | 42"));
      });

      test(
        'I-IMPORT-10: Import with "show" (no prefix) - check that the hidden symbol is not accessible. [2026-02-12] (PASS)',
        () {
          final d4rt = D4rt();
          expect(
            () => d4rt.execute(
                library: "d4rt-mem:/main_import_show_check_hidden.dart",
                sources: sources),
            throwsA(
              isA<RuntimeD4rtException>().having(
                (e) => e.message,
                'message',
                contains("Undefined variable: getExtraMessage"),
              ),
            ),
          );
        },
      );

      test('I-IMPORT-5: Import with "hide" (no prefix) - access allowed symbols. [2026-02-10 06:37] (PASS)', () {
        final d4rt = D4rt();
        final result = d4rt.execute(
          library: "d4rt-mem:/main_import_hide.dart",
          sources: sources,
        );
        expect(result, equals("Hello from lib_common! | 42"));
      });

      test(
        'I-IMPORT-11: Import with "hide" (no prefix) - check that the hidden symbol is not accessible. [2026-02-12] (PASS)',
        () {
          final d4rt = D4rt();
          expect(
            () => d4rt.execute(
                library: "d4rt-mem:/main_import_hide_check_hidden.dart",
                sources: sources),
            throwsA(
              isA<RuntimeD4rtException>().having(
                (e) => e.message,
                'message',
                contains("Undefined variable: getExtraMessage"),
              ),
            ),
          );
        },
      );

      test('I-IMPORT-6: Import prefixed with "show" - access allowed symbols. [2026-02-10 06:37] (PASS)', () {
        final d4rt = D4rt();
        final result = d4rt.execute(
            library: "d4rt-mem:/main_prefixed_import_show.dart",
            sources: sources);
        expect(result, equals("Hello from lib_common! | 42"));
      });

      test(
        'I-IMPORT-12: Import prefixed with "show" - check that the hidden symbol is not accessible. [2026-02-12] (PASS)',
        () {
          final d4rt = D4rt();
          expect(
            () => d4rt.execute(
                library:
                    "d4rt-mem:/main_prefixed_import_show_check_hidden.dart",
                sources: sources),
            throwsA(
              isA<RuntimeD4rtException>().having(
                (e) => e.message,
                'message',
                contains(
                    "Method 'getExtraMessage' not found in imported module 'common'. Error: Undefined variable: getExtraMessage"),
              ),
            ),
          );
        },
      );

      test('I-IMPORT-8: Import prefixed with "hide" - access allowed symbols. [2026-02-10 06:37] (PASS)', () {
        final d4rt = D4rt();
        final result = d4rt.execute(
            library: "d4rt-mem:/main_prefixed_import_hide.dart",
            sources: sources);
        expect(result, equals("Hello from lib_common! | 42"));
      });

      test(
        'I-IMPORT-13: Import prefixed with "hide" - check that the hidden symbol is not accessible. [2026-02-12] (PASS)',
        () {
          final d4rt = D4rt();
          expect(
            () => d4rt.execute(
                library:
                    "d4rt-mem:/main_prefixed_import_hide_check_hidden.dart",
                sources: sources),
            throwsA(
              isA<RuntimeD4rtException>().having(
                (e) => e.message,
                'message',
                contains(
                    "Method 'getExtraMessage' not found in imported module 'common'. Error: Undefined variable: getExtraMessage"),
              ),
            ),
          );
        },
      );

      test('I-IMPORT-7: Import with "show" avoids name conflict with local definition. [2026-02-10 06:37] (PASS)', () {
        final d4rt = D4rt();
        final result = d4rt.execute(
            library: "d4rt-mem:/main_import_conflict_show.dart",
            sources: sources);
        expect(result, equals("Local getMessage | 42"));
      });

      test(
        'I-IMPORT-14: Import with "hide" avoids name conflict and allows access to other imported symbols. [2026-02-12] (PASS)',
        () {
          final d4rt = D4rt();
          final result = d4rt.execute(
              library: "d4rt-mem:/main_import_conflict_hide.dart",
              sources: sources);
          expect(result,
              equals("Local getMessage | 42 | Extra message from lib_common!"));
        },
      );
    });
  });
}
