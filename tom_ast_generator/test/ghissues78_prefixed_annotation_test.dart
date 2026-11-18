// ghissues78 (GitHub #22) - a prefixed annotation name converts, bundles and
// runs. Serverpod 4.1's generated code writes `@_isc.useResult`; the
// converter cast the annotation's name to `SSimpleIdentifier?` and threw
// `type 'SPrefixedIdentifier' is not a subtype of type 'SSimpleIdentifier?'`.
// tom_ast_model 0.3.3 types `SAnnotation.name` as `SIdentifier?`.

import 'package:test/test.dart';
import 'package:tom_ast_generator/tom_ast_generator.dart';
import 'package:tom_d4rt_ast/runtime.dart' show AstBundle, D4rtRunner;

import 'test_helpers.dart';

/// The annotation on the single function of [source].
SAnnotation _annotationOf(String source) {
  final unit = parseSource(source);
  final fn = unit.declarations.whereType<SFunctionDeclaration>().single;
  return fn.metadata.single;
}

/// GitHub #22's repro.
const _repro = '''
import 'package:meta/meta.dart' as m;
@m.useResult
int f() => 1;
int main() => f();
''';

/// A stand-in for package:meta's library, as a source the bundler carries.
const _metaStub = '''
class UseResult {
  const UseResult();
}
const useResult = UseResult();
''';

void main() {
  group('ghissues78: annotation names', () {
    test('GH78-1: a simple name stays an SSimpleIdentifier [2026-11-18]', () {
      final a = _annotationOf('@override\nint f() => 1;\n');
      expect(a.name, isA<SSimpleIdentifier>());
      expect(a.name!.identifierName, 'override');
      expect(a.constructorName, isNull);
      expect(a.arguments, isNull);
    });

    test('GH78-2: a prefixed name is an SPrefixedIdentifier [2026-11-18]', () {
      final a = _annotationOf(
        "import 'package:meta/meta.dart' as m;\n@m.useResult\nint f() => 1;\n",
      );
      expect(a.name, isA<SPrefixedIdentifier>());
      final name = a.name! as SPrefixedIdentifier;
      expect(name.prefix?.name, 'm');
      expect(name.identifier?.name, 'useResult');
      expect(a.arguments, isNull);
    });

    test('GH78-3: a direct constructor call with a name and arguments '
        '[2026-11-18]', () {
      final a = _annotationOf('@Foo.named(1)\nint f() => 1;\n');
      // The analyzer reads `Foo.named` as a prefixed identifier with no
      // constructor name.
      expect(a.name!.identifierName, 'Foo.named');
      expect(a.arguments?.arguments, hasLength(1));
    });

    test('GH78-4: a prefixed constructor call with a name and arguments '
        '(`@m.Foo.named(1)`) [2026-11-18]', () {
      final a = _annotationOf(
        "import 'package:p/p.dart' as m;\n@m.Foo.named(1)\nint f() => 1;\n",
      );
      expect(a.name, isA<SPrefixedIdentifier>());
      expect(a.name!.identifierName, 'm.Foo');
      expect(a.constructorName?.name, 'named');
      expect(a.arguments?.arguments, hasLength(1));
    });
  });

  group('ghissues78: GitHub #22\'s repro', () {
    test('GH78-5: bundles, keeps the prefixed name through toBytes / '
        'fromBytes, and runs [2026-11-18]', () async {
      final bundle = await AstBundler(
        explicitSources: {
          'package:p/main.dart': _repro,
          'package:meta/meta.dart': _metaStub,
        },
        fileAccessValidator: (_) => false,
      ).createFromSource(_repro, sourcePath: 'package:p/main.dart');
      final read = AstBundle.fromBytes(bundle.toBytes());
      final fn = read.modules['package:p/main.dart']!.declarations
          .whereType<SFunctionDeclaration>()
          .firstWhere((d) => d.name?.name == 'f');
      final name = fn.metadata.single.name;
      expect(name, isA<SPrefixedIdentifier>());
      expect(name!.identifierName, 'm.useResult');
      expect(D4rtRunner().executeBundle(read), 1);
    });
  });
}
