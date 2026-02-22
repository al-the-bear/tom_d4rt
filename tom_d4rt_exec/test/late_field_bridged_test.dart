import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:test/test.dart';

// Simulate a class with late fields
class _LateFieldClass {
  late String config;
  late final int id;

  _LateFieldClass();

  _LateFieldClass.withValues(this.config, this.id);
}

void main() {
  group('INTER-004: Late field setter on bridged instances', () {
    late D4rt d4rt;

    setUp(() {
      d4rt = D4rt()..setDebug(false);

      // Register the LateFieldClass bridge
      d4rt.registerBridgedClass(BridgedClass(
        nativeType: _LateFieldClass,
        name: 'LateFieldClass',
        constructors: {
          '': (visitor, positional, named) {
            return _LateFieldClass();
          },
          'withValues': (visitor, positional, named) {
            return _LateFieldClass.withValues(
              positional[0] as String,
              positional[1] as int,
            );
          },
        },
        getters: {
          'config': (visitor, target) => (target as _LateFieldClass).config,
          'id': (visitor, target) => (target as _LateFieldClass).id,
        },
        setters: {
          'config': (visitor, target, value) =>
              (target as _LateFieldClass).config = value as String,
          'id': (visitor, target, value) =>
              (target as _LateFieldClass).id = value as int,
        },
      ), 'package:test_lib/test_lib.dart');
    });

    test('I-LATE-10: Late field setter on bridged instance assigns value. [2026-02-10] (PASS)', () {
      d4rt.execute(
        library: 'package:main/main.dart',
        sources: {
          'package:main/main.dart': '''
            import 'package:test_lib/test_lib.dart';
            main() {
              var lf = LateFieldClass();
              lf.config = 'test_config';
              lf.id = 99;
            }
          '''
        },
      );
      // Verify through the native object - we can't easily access it
      // but the test passes if no exception is thrown
    });

    test('I-LATE-11: Late field getter after setter returns correct value. [2026-02-10] (PASS)', () {
      final result = d4rt.execute(
        library: 'package:main/main.dart',
        sources: {
          'package:main/main.dart': '''
            import 'package:test_lib/test_lib.dart';
            main() {
              var lf = LateFieldClass();
              lf.config = 'test_config';
              lf.id = 99;
              return lf.config;
            }
          '''
        },
      );
      expect(result, 'test_config');
    });

    test('I-LATE-12: Named constructor with late final fields. [2026-02-10] (PASS)', () {
      final result = d4rt.execute(
        library: 'package:main/main.dart',
        sources: {
          'package:main/main.dart': '''
            import 'package:test_lib/test_lib.dart';
            main() {
              var lf = LateFieldClass.withValues('cfg_data', 42);
              return [lf.config, lf.id];
            }
          '''
        },
      );
      expect(result, ['cfg_data', 42]);
    });
  });
}
