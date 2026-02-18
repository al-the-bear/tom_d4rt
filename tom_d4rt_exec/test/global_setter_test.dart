import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:test/test.dart';

// Native variables simulating a library with getter/setter
int _counter = 0;
int get counter => _counter;
set counter(int v) => _counter = v;

String _name = 'initial';
String get name => _name;
set name(String v) => _name = v;

void main() {
  group('INTER-002: Top-level setter assignment', () {
    late D4rt d4rt;

    setUp(() {
      _counter = 0;
      _name = 'initial';
      d4rt = D4rt()..setDebug(false);
      
      // Register counter getter and setter
      d4rt.registerGlobalGetter('counter', () => counter, 'package:test_lib/test_lib.dart');
      d4rt.registerGlobalSetter('counter', (v) => counter = v as int, 'package:test_lib/test_lib.dart');
      
      // Register name getter and setter
      d4rt.registerGlobalGetter('name', () => name, 'package:test_lib/test_lib.dart');
      d4rt.registerGlobalSetter('name', (v) => name = v as String, 'package:test_lib/test_lib.dart');
    });

    test('I-COLL-8: Read top-level getter returns native value. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(
        library: 'package:main/main.dart',
        sources: {'package:main/main.dart': '''
          import 'package:test_lib/test_lib.dart';
          main() {
            var c = counter;
            return c;
          }
        '''},
      );
      expect(result, 0);
    });

    test('I-COLL-9: Assign to top-level setter updates native value. [2026-02-10 06:37] (PASS)', () {
      d4rt.execute(
        library: 'package:main/main.dart',
        sources: {'package:main/main.dart': '''
          import 'package:test_lib/test_lib.dart';
          main() {
            counter = 42;
          }
        '''},
      );
      expect(_counter, 42);
    });

    test('I-COLL-10: Read after assignment returns new value. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(
        library: 'package:main/main.dart',
        sources: {'package:main/main.dart': '''
          import 'package:test_lib/test_lib.dart';
          main() {
            counter = 100;
            return counter;
          }
        '''},
      );
      expect(result, 100);
      expect(_counter, 100);
    });

    test('I-COLL-11: Compound assignment works with getter/setter. [2026-02-10 06:37] (PASS)', () {
      _counter = 10;
      final result = d4rt.execute(
        library: 'package:main/main.dart',
        sources: {'package:main/main.dart': '''
          import 'package:test_lib/test_lib.dart';
          main() {
            counter += 5;
            return counter;
          }
        '''},
      );
      expect(result, 15);
      expect(_counter, 15);
    });

    test('I-COLL-12: String setter works correctly. [2026-02-10 06:37] (PASS)', () {
      final result = d4rt.execute(
        library: 'package:main/main.dart',
        sources: {'package:main/main.dart': '''
          import 'package:test_lib/test_lib.dart';
          main() {
            name = 'updated';
            return name;
          }
        '''},
      );
      expect(result, 'updated');
      expect(_name, 'updated');
    });

    test('I-COLL-7: Read-only getter without setter throws on assignment. [2026-02-10 06:37] (PASS)', () {
      final d4rtReadOnly = D4rt()..setDebug(false);
      d4rtReadOnly.registerGlobalGetter('readOnly', () => 42, 'package:test_lib/test_lib.dart');
      // No setter registered
      
      expect(() => d4rtReadOnly.execute(
        library: 'package:main/main.dart',
        sources: {'package:main/main.dart': '''
          import 'package:test_lib/test_lib.dart';
          main() {
            readOnly = 100;
          }
        '''},
      ), throwsA(isA<RuntimeD4rtException>()));
    });
  });
}
