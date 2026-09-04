// DFUB10 conformance: circular module imports and exports — verified against
// the ANALYZER-FREE interpreter.
//
// Mirror of tom_d4rt/test/dfub10_circular_module_load_test.dart. Circular
// imports and circular exports are both LEGAL in real Dart and run correctly;
// both loaders used to blow the stack because a module was only published to
// the cache after all of its directives had been walked, so a cycle re-entered
// the load of a module that was still in progress.
//
// DELIBERATE DIVERGENCE FROM UPSTREAM: upstream kodjodevf/d4rt f6e1257 fixes
// the same crash by DETECTING the cycle and throwing "Circular module
// dependency detected". That rejects valid Dart, so we do not adopt it — we
// support the cycle instead. This file is the guard that the ast tree behaves
// identically to the analyzer tree.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

dynamic executeSources(String library, Map<String, String> sources) {
  final d4rt = D4rt()..setDebug(false);
  return d4rt.execute(library: library, sources: sources);
}

void main() {
  group('DFUB10 (exec): circular module load', () {
    test('F-DFUB10-EXEC-1: import cycle A<->B resolves [2026-07-27]', () {
      final sources = {
        'package:test/cycle_a.dart': '''
import 'cycle_b.dart';

String fromA() => 'A';

String main() {
  return fromB();
}
''',
        'package:test/cycle_b.dart': '''
import 'cycle_a.dart';

String fromB() => fromA();
''',
      };
      expect(executeSources('package:test/cycle_a.dart', sources), equals('A'));
    });

    test('F-DFUB10-EXEC-2: export cycle A<->B resolves [2026-07-27]', () {
      final sources = {
        'package:test/export_cycle_a.dart': '''
export 'export_cycle_b.dart';

String fromExportA() => 'A';
''',
        'package:test/export_cycle_b.dart': '''
export 'export_cycle_a.dart';

String fromExportB() => 'B';
''',
        'package:test/export_cycle_main.dart': '''
import 'export_cycle_a.dart';

String main() {
  return fromExportA() + fromExportB();
}
''',
      };
      expect(
        executeSources('package:test/export_cycle_main.dart', sources),
        equals('AB'),
      );
    });

    test('F-DFUB10-EXEC-3: self-import is a degenerate cycle [2026-07-27]', () {
      final sources = {
        'package:test/self.dart': '''
import 'self.dart';

String greet() => 'hi';

String main() => greet();
''',
      };
      expect(executeSources('package:test/self.dart', sources), equals('hi'));
    });

    test('F-DFUB10-EXEC-4: three-module cycle A->B->C->A [2026-07-27]', () {
      final sources = {
        'package:test/tri_a.dart': '''
import 'tri_b.dart';

String fromA() => 'A';

String main() => fromB();
''',
        'package:test/tri_b.dart': '''
import 'tri_c.dart';

String fromB() => 'B' + fromC();
''',
        'package:test/tri_c.dart': '''
import 'tri_a.dart';

String fromC() => 'C' + fromA();
''',
      };
      expect(executeSources('package:test/tri_a.dart', sources), equals('BCA'));
    });

    test('F-DFUB10-EXEC-5: cyclic import of a class, not just a function '
        '[2026-07-27]', () {
      final sources = {
        'package:test/klass_a.dart': '''
import 'klass_b.dart';

class A {
  String name() => 'A';
}

String main() {
  return B().describe();
}
''',
        'package:test/klass_b.dart': '''
import 'klass_a.dart';

class B {
  String describe() => 'B sees ' + A().name();
}
''',
      };
      expect(
        executeSources('package:test/klass_a.dart', sources),
        equals('B sees A'),
      );
    });
  });
}
