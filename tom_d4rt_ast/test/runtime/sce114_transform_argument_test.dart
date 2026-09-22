// SCE114/AST — the analyzer-free twin of
// `tom_d4rt/test/sce114_transform_argument_test.dart`.
//
// Four `transform` adapters asked the same question and only one asked it
// properly: `Stream.transform` resolved its argument through a helper, while
// both socket adapters wrote `positionalArgs[0] as StreamTransformer` — which
// admits a native transformer and a bridged one and rejects the third shape,
// an interpreted class with a `bind` method. The resolver now lives in
// `stdlib/stream_transformer_arg.dart` and all four use it.
//
// WHAT THIS SIDE UNIQUELY ANSWERS is the interpreted-instance branch. Reading
// `bind` off an `InterpretedInstance` and calling it through `runAction` is
// interpreter code, not parser code, so the analyzer-free tree has to hold the
// property on its own terms. The reference's socket cases need a live socket
// and a parsed script; the RESOLVER is the shared code the fix moved, and it
// is reachable here through `Stream.transform`.
//
// THE BUNDLE RETURNS THE STREAM rather than awaiting it, so no `async` body or
// `await` expression has to be constructed: the host drains it. The question
// is which transformer the adapter accepted, and that is settled before the
// first element is produced.
//
// ABLATED 2026-09-22 by restoring the pre-SCE83 `_asStreamTransformer` shape
// — dropping the `InterpretedInstance` branch: -1 fails, -2 and -3 pass. -2 is
// the control the move could have broken and -3 is the sentence, which the
// call site owns either way.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String name) =>
    SSimpleIdentifier(offset: 0, length: 0, name: name);

SNamedType _type(String name) =>
    SNamedType(offset: 0, length: 0, name: _id(name));

SArgumentList _args([List<SExpression> arguments = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: arguments);

SFormalParameterList _noParams() =>
    SFormalParameterList(offset: 0, length: 0, parameters: const []);

/// `class Lengths { Lengths(); Stream bind(Stream source) => source.map(...); }`
///
/// The constructor is explicit because a hand-built bundle is not a generated
/// one — nothing here synthesises the unnamed constructor source omits.
SClassDeclaration _lengthsClass() => SClassDeclaration(
  offset: 0,
  length: 0,
  name: _id('Lengths'),
  members: [
    SConstructorDeclaration(
      offset: 0,
      length: 0,
      returnType: _id('Lengths'),
      parameters: _noParams(),
      body: SBlockFunctionBody(
        offset: 0,
        length: 0,
        block: SBlock(offset: 0, length: 0, statements: const []),
      ),
    ),
    SMethodDeclaration(
      offset: 0,
      length: 0,
      name: _id('bind'),
      returnType: _type('Stream'),
      parameters: SFormalParameterList(
        offset: 0,
        length: 0,
        parameters: [
          SSimpleFormalParameter(
            offset: 0,
            length: 0,
            name: _id('source'),
            type: _type('Stream'),
            isRequired: true,
          ),
        ],
      ),
      // `source.map((chunk) => chunk.length)`
      body: SExpressionFunctionBody(
        offset: 0,
        length: 0,
        expression: SMethodInvocation(
          offset: 0,
          length: 0,
          target: _id('source'),
          operator: '.',
          methodName: _id('map'),
          argumentList: _args([
            SFunctionExpression(
              offset: 0,
              length: 0,
              parameters: SFormalParameterList(
                offset: 0,
                length: 0,
                parameters: [
                  SSimpleFormalParameter(
                    offset: 0,
                    length: 0,
                    name: _id('chunk'),
                    isRequired: true,
                  ),
                ],
              ),
              body: SExpressionFunctionBody(
                offset: 0,
                length: 0,
                expression: SPropertyAccess(
                  offset: 0,
                  length: 0,
                  target: _id('chunk'),
                  operator: '.',
                  propertyName: _id('length'),
                ),
              ),
            ),
          ]),
        ),
      ),
    ),
  ],
);

/// `main() => Stream.fromIterable(['ab', 'cde']).transform(<argument>);`
AstBundle _bundle(SExpression argument) {
  const entry = 'package:probe/main.dart';
  final source = SMethodInvocation(
    offset: 0,
    length: 0,
    target: _id('Stream'),
    operator: '.',
    methodName: _id('fromIterable'),
    argumentList: _args([
      SListLiteral(
        offset: 0,
        length: 0,
        elements: [
          SSimpleStringLiteral(offset: 0, length: 2, value: 'ab'),
          SSimpleStringLiteral(offset: 0, length: 3, value: 'cde'),
        ],
      ),
    ]),
  );

  return AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
        offset: 0,
        length: 0,
        declarations: [
          _lengthsClass(),
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: _id('main'),
            functionExpression: SFunctionExpression(
              offset: 0,
              length: 0,
              parameters: _noParams(),
              body: SExpressionFunctionBody(
                offset: 0,
                length: 0,
                expression: SMethodInvocation(
                  offset: 0,
                  length: 0,
                  target: source,
                  operator: '.',
                  methodName: _id('transform'),
                  argumentList: _args([argument]),
                ),
              ),
            ),
          ),
        ],
      ),
    },
  );
}

SExpression get _interpretedTransformer => SInstanceCreationExpression(
  offset: 0,
  length: 0,
  constructorName: SConstructorName(
    offset: 0,
    length: 0,
    type: _type('Lengths'),
  ),
  argumentList: _args(),
);

Future<List<Object?>> _drain(SExpression argument) async {
  final result = D4rtRunner().executeBundle(_bundle(argument));
  return (result as Stream).toList();
}

void main() {
  group('SCE114/AST: the transform argument resolver', () {
    test('F-SCE114-AST-1: an interpreted class with `bind` is a transformer '
        '[2026-09-22] (PASS)', () async {
      // No native object anywhere in `Lengths` — its `bind` exists only in the
      // interpreter, so the resolver has to wrap it in
      // `StreamTransformer.fromBind` for the SDK to accept it at all.
      expect(await _drain(_interpretedTransformer), [2, 3]);
    });

    test('F-SCE114-AST-2 (control): a native transformer is passed through '
        '[2026-09-22] (PASS)', () async {
      // `StreamTransformer.fromHandlers(...)` — the shape that always
      // satisfied the old cast, and so the one the move could have broken.
      final native = SMethodInvocation(
        offset: 0,
        length: 0,
        target: _id('StreamTransformer'),
        operator: '.',
        methodName: _id('fromHandlers'),
        argumentList: _args(),
      );
      expect(await _drain(native), ['ab', 'cde']);
    });

    test('F-SCE114-AST-3: a non-transformer names the member [2026-09-22] '
        '(PASS)', () async {
      expect(
        () => _drain(SIntegerLiteral(offset: 0, length: 2, value: 42)),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.toString(),
            'message',
            contains('Stream.transform requires a StreamTransformer argument'),
          ),
        ),
      );
    });
  });
}
