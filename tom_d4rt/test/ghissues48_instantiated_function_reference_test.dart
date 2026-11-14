// ghissues48 — GitHub #15: an explicitly instantiated generic function
// reference keeps its type arguments.
//
// Measured 2026-11-14 on tom_d4rt 1.259.0 / tom_d4rt_ast 0.239.0:
//
//   Type typeOf<T>() => T;
//   const cbs = [typeOf<String>, typeOf<List<int?>>];
//   [cbs[0](), cbs[1]()]          // [T, T]       (Dart: [String, List<int?>])
//   final f = K().m<int?>; f()    // T            (Dart: int?)
//   [nameOf<String>][0]()         // the bridged nameOf got typeArguments null
//
// A direct call `typeOf<String>()` kept them; a reference `typeOf<String>`
// (FunctionReference) evaluated only its function and dropped its type
// arguments, so the later call ran with T unbound. Also: a parameter typed `T`
// with `T = int?` refused null (`g<int?>(null)`: type 'Null' is not a subtype
// of type 'int?'), direct call or not - the binding check now treats a type
// parameter bound to a nullable type as nullable. It now evaluates to an
// InstantiatedCallable that calls the function with the resolved type
// arguments (`?` and nesting kept). Serverpod's generated serialization
// metadata holds const lists of such references (`getType<Model>`). The same
// in tom_d4rt_ast (test/runtime/ghissues48_instantiated_function_reference_test.dart).

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

const _names = ['String', 'List<int?>', 'Map<String, List<int?>?>?'];

/// Native Dart control for an explicitly instantiated generic reference.
Type _typeOf<T>() => T;

Object? _run(String body) {
  final d4rt = D4rt()
    // The issue's bridged function: answers the names of its type arguments.
    ..registertopLevelFunction(
      'nameOf',
      (visitor, positional, named, typeArgs) => typeArgs!.single.name,
      'package:n/n.dart',
    )
    // Native code that keeps a callback and calls it.
    ..registertopLevelFunction(
      'callLater',
      (visitor, positional, named, typeArgs) =>
          D4.callInterpreterCallback(visitor, positional.single, const []),
      'package:n/n.dart',
    );
  return d4rt.execute(
    library: 'package:p/main.dart',
    sources: {
      'package:p/main.dart':
          "import 'package:n/n.dart';\n"
          'Type typeOf<T>() => T;\n'
          '$body',
    },
  );
}

void main() {
  group('ghissues48: an instantiated generic function reference', () {
    test('GHI48-1: the native control [2026-11-14]', () {
      const callbacks = [
        _typeOf<String>,
        _typeOf<List<int?>>,
        _typeOf<Map<String, List<int?>?>?>,
      ];
      expect(callbacks.map((c) => c().toString()).toList(), _names);
    });

    test('GHI48-2: the issue - a const list of references to a bridged '
        'generic function (GitHub #15) [2026-11-14]', () {
      expect(
        _run(
          'Object main() {\n'
          '  const callbacks = [nameOf<String>, nameOf<List<int?>>, '
          'nameOf<Map<String, List<int?>?>?>];\n'
          '  return [callbacks[0](), callbacks[1](), callbacks[2]()];\n'
          '}',
        ),
        _names,
      );
    });

    test('GHI48-3: references to an interpreted generic function bind T '
        '[2026-11-14]', () {
      expect(
        _run(
          'Object main() {\n'
          '  const callbacks = [typeOf<String>, typeOf<List<int?>>, '
          'typeOf<Map<String, List<int?>?>?>];\n'
          '  return [for (final c in callbacks) c().toString()];\n'
          '}',
        ),
        _names,
      );
    });

    test('GHI48-4: the controls - direct calls and closures [2026-11-14]', () {
      expect(
        _run(
          'Object main() => [nameOf<String>(), nameOf<List<int?>>(), '
          'nameOf<Map<String, List<int?>?>?>()];',
        ),
        _names,
      );
      expect(
        _run(
          'Object main() {\n'
          '  final callbacks = [() => typeOf<String>(), '
          '() => typeOf<List<int?>>()];\n'
          '  return [for (final c in callbacks) c().toString()];\n'
          '}',
        ),
        _names.take(2).toList(),
      );
    });

    test('GHI48-5: a generic method tear-off `obj.m<int?>` [2026-11-14]', () {
      expect(
        _run(
          'class K { String m<T>(T value) => "\$T:\$value"; }\n'
          'Object main() {\n'
          '  final f = K().m<int?>;\n'
          '  return [f(null), f(3)];\n'
          '}',
        ),
        ['int?:null', 'int?:3'],
      );
    });

    test('GHI48-6: a reference handed to native code runs with its type '
        'arguments when called there [2026-11-14]', () {
      expect(
        _run("Object main() => [callLater(nameOf<List<int?>>), "
            "callLater(typeOf<String>).toString()];"),
        ['List<int?>', 'String'],
      );
    });

    test('GHI48-8: a parameter typed T with T = int? admits null and still '
        'refuses another type [2026-11-14]', () {
      expect(
        _run(
          'String g<T>(T value) => "ok:\$value";\n'
          'Object main() => [g<int?>(null), g<String?>(null), (g<int?>)(4)];',
        ),
        ['ok:null', 'ok:null', 'ok:4'],
      );
      expect(
        () => _run(
          'String g<T>(T value) => "ok";\n'
          "Object main() => g<int?>('x');",
        ),
        throwsA(
          predicate(
            (Object e) => e.toString().contains(
              "type 'String' is not a subtype of type 'int?'",
            ),
            'refused as a String for int?',
          ),
        ),
      );
    });

    test('GHI48-9: an instantiated reference takes no type arguments again '
        '[2026-11-14]', () {
      expect(
        () => _run(
          'Object main() { final f = typeOf<String>; return f<int>(); }',
        ),
        throwsA(
          predicate(
            (Object e) => e.toString().contains('already instantiated'),
            'refused as instantiated twice',
          ),
        ),
      );
    });

    test('GHI48-7: equality of instantiations [2026-11-14]', () {
      expect(
        _run(
          'Object main() => [typeOf<int> == typeOf<int>, '
          'typeOf<int> == typeOf<String>, typeOf<int?> == typeOf<int>];',
        ),
        [true, false, false],
      );
    });
  });
}
