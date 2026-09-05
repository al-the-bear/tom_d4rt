// DFUB10: support circular module imports and exports.
//
// Circular imports and circular exports are both LEGAL in real Dart and run
// correctly (verified against the SDK: an import cycle A<->B returns 'A'; an
// export cycle returns 'AB'). Our ModuleLoader crashed with a Stack Overflow
// on both, because loadModule only wrote to _moduleCache at the very END —
// after recursing through every import and export directive. A cycle A->B->A
// therefore re-entered loadModule(A) while A was still in progress, the
// `_moduleCache.containsKey(uri)` guard missed, and the recursion never
// bottomed out.
//
// DELIBERATE DIVERGENCE FROM UPSTREAM: upstream kodjodevf/d4rt f6e1257 fixes
// the same crash by DETECTING the cycle and throwing "Circular module
// dependency detected". That rejects valid Dart, so we do not adopt it — we
// support the cycle instead, by publishing a partial module entry before
// walking the directives, exactly as a real Dart front end does.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  group('DFUB10: circular module load', () {
    test('F-DFUB10-1: import cycle A<->B resolves [2026-07-27]', () {
      final sources = {
        'd4rt-mem:/cycle_a.dart': '''
import 'cycle_b.dart';

String fromA() => 'A';

String main() {
  return fromB();
}
''',
        'd4rt-mem:/cycle_b.dart': '''
import 'cycle_a.dart';

String fromB() => fromA();
''',
      };
      final d4rt = D4rt();
      expect(
        d4rt.execute(library: 'd4rt-mem:/cycle_a.dart', sources: sources),
        equals('A'),
      );
    });

    test('F-DFUB10-2: export cycle A<->B resolves [2026-07-27]', () {
      final sources = {
        'd4rt-mem:/export_cycle_a.dart': '''
export 'export_cycle_b.dart';

String fromExportA() => 'A';
''',
        'd4rt-mem:/export_cycle_b.dart': '''
export 'export_cycle_a.dart';

String fromExportB() => 'B';
''',
        'd4rt-mem:/export_cycle_main.dart': '''
import 'export_cycle_a.dart';

String main() {
  return fromExportA() + fromExportB();
}
''',
      };
      final d4rt = D4rt();
      expect(
        d4rt.execute(
          library: 'd4rt-mem:/export_cycle_main.dart',
          sources: sources,
        ),
        equals('AB'),
      );
    });

    test('F-DFUB10-3: self-import is a degenerate cycle [2026-07-27]', () {
      final sources = {
        'd4rt-mem:/self.dart': '''
import 'self.dart';

String greet() => 'hi';

String main() => greet();
''',
      };
      final d4rt = D4rt();
      expect(
        d4rt.execute(library: 'd4rt-mem:/self.dart', sources: sources),
        equals('hi'),
      );
    });

    test('F-DFUB10-4: three-module cycle A->B->C->A resolves [2026-07-27]', () {
      final sources = {
        'd4rt-mem:/tri_a.dart': '''
import 'tri_b.dart';

String fromA() => 'A';

String main() => fromB();
''',
        'd4rt-mem:/tri_b.dart': '''
import 'tri_c.dart';

String fromB() => 'B' + fromC();
''',
        'd4rt-mem:/tri_c.dart': '''
import 'tri_a.dart';

String fromC() => 'C' + fromA();
''',
      };
      final d4rt = D4rt();
      expect(
        d4rt.execute(library: 'd4rt-mem:/tri_a.dart', sources: sources),
        equals('BCA'),
      );
    });

    test('F-DFUB10-5: cyclic import of a class, not just a function '
        '[2026-07-27]', () {
      final sources = {
        'd4rt-mem:/klass_a.dart': '''
import 'klass_b.dart';

class A {
  String name() => 'A';
}

String main() {
  return B().describe();
}
''',
        'd4rt-mem:/klass_b.dart': '''
import 'klass_a.dart';

class B {
  String describe() => 'B sees ' + A().name();
}
''',
      };
      final d4rt = D4rt();
      expect(
        d4rt.execute(library: 'd4rt-mem:/klass_a.dart', sources: sources),
        equals('B sees A'),
      );
    });
  });
}
