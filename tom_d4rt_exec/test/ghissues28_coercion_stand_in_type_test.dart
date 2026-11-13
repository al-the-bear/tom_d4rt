// ghissues28 — a value a registered type coercion converts to a bridged type
// stands in for that type in a type check.
//
// Measured 2026-11-10 in the Flutter AST twin on the tree (tom_d4rt_ast
// 0.229.0 under prepublish_overrides --set):
//
//   import 'dart:ui' as ui;
//   String f({required ui.StrutStyle? strut}) => 'ok';
//   f(strut: ui.StrutStyle(height: 1.6));
//   // type 'StrutStyle' is not a subtype of type 'StrutStyle?' of 'strut'
//
// The twins' user bridge builds a painting `StrutStyle` for a dart:ui
// `StrutStyle(...)` call (the engine type has no getters) and registers the
// coercion painting.StrutStyle -> dart:ui.StrutStyle for dart:ui APIs. Up to
// 1.237.0 a prefixed annotation was looked up by its bare name, which found
// the painting class - the value's own - so the parameter passed. Since
// ghissues7 (1.238.0, 720e141b4; bisected with GHI28-1) it resolves to the
// prefixed library's own class, which is not the value's, and the stand-in was
// refused in `dart_ui/text_test.dart` and `dart_ui/text_data_test.dart` (base
// corpus, pre-publish only). `ui.StrutStyle() is ui.StrutStyle` was false in
// every version measured (1.231.1, 1.235.0-1.238.0). A registered coercion now
// declares the stand-in: its source type is a subtype of its target. Two
// same-named bridges without one stay distinct. The same in tom_d4rt_ast
// (test/runtime/ghissues28_coercion_stand_in_type_test.dart).

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// The native type the script's constructor call really builds (painting's).
class Gh28Rich {
  const Gh28Rich(this.height);
  final double height;
}

/// The native type the script names (dart:ui's).
class Gh28Engine {
  const Gh28Engine();
}

/// A same-named type with no coercion to [Gh28Engine].
class Gh28Other {
  const Gh28Other();
}

D4rt _interpreter() {
  final d4rt = D4rt()
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh28Rich,
        name: 'Gh28Strut',
        constructors: {'': (v, p, n) => Gh28Rich(n['height'] as double? ?? 1)},
        getters: {'height': (v, t) => (t as Gh28Rich).height},
      ),
      'package:g/painting.dart',
    )
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh28Engine,
        name: 'Gh28Strut',
        // The stand-in constructor: a `ui.Gh28Strut(...)` call builds the
        // rich type, as the twins' StrutStyle user bridge does.
        constructors: {'': (v, p, n) => Gh28Rich(n['height'] as double? ?? 1)},
      ),
      'package:g/ui.dart',
    )
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh28Other,
        name: 'Gh28Strut',
        constructors: {'': (v, p, n) => const Gh28Other()},
      ),
      'package:g/other.dart',
    );
  D4.registerTypeCoercion(
    sourceType: Gh28Rich,
    targetType: Gh28Engine,
    factory: (value) => const Gh28Engine(),
  );
  return d4rt;
}

Object? _run(String body) => _interpreter().execute(
  library: 'package:p/main.dart',
  sources: {
    'package:p/main.dart':
        "import 'package:g/ui.dart' as ui;\n"
        "import 'package:g/other.dart' as other;\n"
        "String f({required ui.Gh28Strut? strut}) => 'ok';\n"
        "String g(other.Gh28Strut s) => 'other';\n"
        'main() => $body;\n',
  },
);

void main() {
  group('ghissues28: a coercion stand-in passes a check of its target', () {
    test('GHI28-1: a prefixed parameter and a declared variable take the '
        'stand-in [2026-11-10]', () {
      expect(
        _run(
          '[f(strut: ui.Gh28Strut(height: 1.6)), '
          '(() { final ui.Gh28Strut s = ui.Gh28Strut(height: 2.0); '
          'return s.height; })()]',
        ),
        ['ok', 2.0],
      );
    });

    test('GHI28-2: `is` and `as` accept the stand-in [2026-11-10]', () {
      expect(
        _run(
          '[ui.Gh28Strut() is ui.Gh28Strut, '
          '(ui.Gh28Strut() as ui.Gh28Strut) != null]',
        ),
        [true, true],
      );
    });

    test('GHI28-3: a same-named bridge without a coercion is still another '
        'type [2026-11-10]', () {
      expect(
        () => _run('g(ui.Gh28Strut())'),
        throwsA(
          isA<D4rtTypeError>().having(
            (e) => e.toString(),
            'text',
            contains('is not a subtype of'),
          ),
        ),
      );
      expect(_run('other.Gh28Strut() is ui.Gh28Strut'), isFalse);
    });
  });
}
