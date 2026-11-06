// TDIMPA1 + DASY1 — async in any context, in the analyzer-free tree.
//
// The mirror of `tom_d4rt/test/tdimpa1_async_bridge_test.dart`. That file runs
// source; this package interprets pre-parsed `SAstNode` trees, so each script
// is a bundle built by hand and the set is smaller: the shapes that carry the
// claims, not every variation of them. The exec port of the reference file
// runs the full set through this interpreter once it is published (DGUC6).
//
// DASY1: `executeAsync` / `executeAsAsync<T>` on [D4rtRunner] settle an async
// entry point to its native value, and the typed variants — these two and the
// existing `executeBundleAsAsync<T>` — unwrap with the visitor of THEIR run,
// captured before the await. DASY1-AST-4 is red against the pre-DASY1
// `executeBundleAsAsync`, which read the runner's visitor field after the
// await and so unwrapped with whichever run had started last.
//
// TDIMPA1: a bridged method returning a native Future is awaitable; the value
// is wrapped like a sync result and the error is a catchable script exception.

@TestOn('vm')
library;

import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// A host service whose calls complete later.
class AsyncService {
  static Future<void> wait(int milliseconds) =>
      Future<void>.delayed(Duration(milliseconds: milliseconds));

  Future<int> doubleLater(int value) =>
      Future<int>.delayed(const Duration(milliseconds: 5), () => value * 2);

  Future<Item> itemLater(int value) =>
      Future<Item>.delayed(const Duration(milliseconds: 5), () => Item(value));

  Future<int> failLater(String message) => Future<int>.delayed(
    const Duration(milliseconds: 5),
    () => throw StateError(message),
  );
}

class Item {
  Item(this.value);
  final int value;
}

/// A bridged interface a script implements; the host gets a proxy for it.
abstract class Greeter {
  String greet();
}

class _GreeterProxy implements Greeter {
  _GreeterProxy(this.visitor);
  final InterpreterVisitor visitor;
  @override
  String greet() => 'proxy';
}

const _library = 'package:probe/async_service.dart';
const _entry = 'package:probe/main.dart';

SSimpleIdentifier _id(String name) =>
    SSimpleIdentifier(offset: 0, length: 0, name: name);

SNamedType _type(String name) =>
    SNamedType(offset: 0, length: 0, name: _id(name));

SArgumentList _args([List<SExpression> arguments = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: arguments);

SFormalParameterList _noParams() =>
    SFormalParameterList(offset: 0, length: 0, parameters: const []);

SIntegerLiteral _int(int value) =>
    SIntegerLiteral(offset: 0, length: 0, value: value);

SSimpleStringLiteral _string(String value) =>
    SSimpleStringLiteral(offset: 0, length: 0, value: value);

SBlock _block(List<SStatement> statements) =>
    SBlock(offset: 0, length: 0, statements: statements);

SReturnStatement _return(SExpression expression) =>
    SReturnStatement(offset: 0, length: 0, expression: expression);

SAwaitExpression _await(SExpression expression) =>
    SAwaitExpression(offset: 0, length: 0, expression: expression);

/// `new <type>(<args>)`
SInstanceCreationExpression _new(
  String type, [
  List<SExpression> arguments = const [],
]) => SInstanceCreationExpression(
  offset: 0,
  length: 0,
  constructorName: SConstructorName(offset: 0, length: 0, type: _type(type)),
  argumentList: _args(arguments),
);

/// `<target>.<method>(<args>)`
SMethodInvocation _call(
  SExpression? target,
  String method, [
  List<SExpression> arguments = const [],
]) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: target == null ? null : '.',
  methodName: _id(method),
  argumentList: _args(arguments),
);

/// `AsyncService().<method>(<args>)`
SMethodInvocation _service(
  String method, [
  List<SExpression> args = const [],
]) => _call(_new('AsyncService'), method, args);

/// `await AsyncService.wait(<ms>);`
SExpressionStatement _wait(int milliseconds) => SExpressionStatement(
  offset: 0,
  length: 0,
  expression: _await(_call(_id('AsyncService'), 'wait', [_int(milliseconds)])),
);

/// An await that names no bridged library:
/// `await Future.value(0);`, for the import-free
/// scripts [D4rtRunner.execute] runs.
SExpressionStatement _yieldOnce() => SExpressionStatement(
  offset: 0,
  length: 0,
  expression: _await(_call(_id('Future'), 'value', [_int(0)])),
);

/// A compilation unit with an async `main` whose body is [statements], after
/// any [declarations]. It imports the probe library unless [imports] is
/// false: [D4rtRunner.execute] runs a single unit with no module loader, so
/// its scripts name no library (`NoOpModuleContext`); bundles import.
SCompilationUnit _unit(
  List<SStatement> statements, {
  List<SCompilationUnitMember> declarations = const [],
  bool imports = true,
}) => SCompilationUnit(
  offset: 0,
  length: 0,
  directives: [
    if (imports) SImportDirective(offset: 0, length: 0, uri: _string(_library)),
  ],
  declarations: [
    ...declarations,
    SFunctionDeclaration(
      offset: 0,
      length: 0,
      name: _id('main'),
      functionExpression: SFunctionExpression(
        offset: 0,
        length: 0,
        parameters: _noParams(),
        body: SBlockFunctionBody(
          offset: 0,
          length: 0,
          isAsync: true,
          block: _block(statements),
        ),
      ),
    ),
  ],
);

AstBundle _bundle(SCompilationUnit unit) =>
    AstBundle(entryPointUri: _entry, modules: {_entry: unit});

/// `class Hello implements Greeter { Hello(); String greet() => 'hello'; }`
SClassDeclaration _hello() => SClassDeclaration(
  offset: 0,
  length: 0,
  namePart: SNameWithTypeParameters(
    offset: 0,
    length: 0,
    typeName: _id('Hello'),
  ),
  implementsClause: SImplementsClause(
    offset: 0,
    length: 0,
    interfaces: [_type('Greeter')],
  ),
  body: SBlockClassBody(
    offset: 0,
    length: 0,
    members: [
      SConstructorDeclaration(
        offset: 0,
        length: 0,
        typeName: _id('Hello'),
        parameters: _noParams(),
        body: SBlockFunctionBody(offset: 0, length: 0, block: _block([])),
      ),
      SMethodDeclaration(
        offset: 0,
        length: 0,
        name: _id('greet'),
        returnType: _type('String'),
        parameters: _noParams(),
        body: SExpressionFunctionBody(
          offset: 0,
          length: 0,
          expression: _string('hello'),
        ),
      ),
    ],
  ),
);

/// `main() async { await AsyncService.wait(<ms>); return Hello(); }`
SCompilationUnit _helloAfter(int milliseconds) => _unit(
  [_wait(milliseconds), _return(_new('Hello'))],
  declarations: [_hello()],
);

D4rtRunner _runner() => D4rtRunner()
  ..registerBridgedClass(
    BridgedClass(
      nativeType: AsyncService,
      name: 'AsyncService',
      constructors: {'': (visitor, positional, named) => AsyncService()},
      staticMethods: {
        'wait': (visitor, positional, named, typeArgs) =>
            AsyncService.wait(positional[0] as int),
      },
      methods: {
        'doubleLater': (visitor, target, positional, named, _) =>
            (target as AsyncService).doubleLater(positional[0] as int),
        'itemLater': (visitor, target, positional, named, _) =>
            (target as AsyncService).itemLater(positional[0] as int),
        'failLater': (visitor, target, positional, named, _) =>
            (target as AsyncService).failLater(positional[0] as String),
      },
    ),
    _library,
    sourceUri: _library,
  )
  ..registerBridgedClass(
    BridgedClass(
      nativeType: Item,
      name: 'Item',
      constructors: {
        '': (visitor, positional, named) => Item(positional[0] as int),
      },
      getters: {'value': (visitor, target) => (target as Item).value},
    ),
    _library,
    sourceUri: _library,
  )
  ..registerBridgedClass(
    BridgedClass(nativeType: Greeter, name: 'Greeter', isAbstract: true),
    _library,
    sourceUri: _library,
  );

void main() {
  group('DASY1/AST: async entry points on D4rtRunner', () {
    test(
      'DASY1-AST-1: executeAsync settles an async main to its value [2026-11-06]',
      () async {
        final result = await _runner().executeAsync(
          ast: _unit([_yieldOnce(), _return(_int(42))], imports: false),
        );
        expect(result, 42);
      },
    );

    test(
      'DASY1-AST-2: an async main that throws fails the Future with the script\'s error [2026-11-06]',
      () async {
        await expectLater(
          _runner().executeAsync(
            ast: _unit([
              _yieldOnce(),
              SExpressionStatement(
                offset: 0,
                length: 0,
                expression: SThrowExpression(
                  offset: 0,
                  length: 0,
                  expression: _call(null, 'StateError', [_string('boom')]),
                ),
              ),
            ], imports: false),
          ),
          throwsA(
            isA<StateError>().having((e) => e.message, 'message', 'boom'),
          ),
        );
      },
    );

    test(
      'DASY1-AST-3: executeAsAsync<T> settles and casts to T, and refuses a wrong T [2026-11-06]',
      () async {
        SCompilationUnit unit() =>
            _unit([_yieldOnce(), _return(_int(9))], imports: false);
        expect(await _runner().executeAsAsync<int>(ast: unit()), 9);
        await expectLater(
          _runner().executeAsAsync<String>(ast: unit()),
          throwsA(
            isA<D4UnwrapException>()
                .having((e) => e.expectedType, 'expectedType', 'String')
                .having((e) => e.actualType, 'actualType', 'int'),
          ),
        );
      },
    );

    test(
      'DASY1-AST-4: two interleaved executeBundleAsAsync runs on one runner each '
      'unwrap with their own visitor [2026-11-06]',
      () async {
        D4.registerInterfaceProxy(
          'Greeter',
          (visitor, instance) => _GreeterProxy(visitor),
        );
        final runner = _runner();
        final first = runner.executeBundleAsAsync<Greeter>(
          _bundle(_helloAfter(40)),
        );
        final firstVisitor = runner.visitor;
        final second = runner.executeBundleAsAsync<Greeter>(
          _bundle(_helloAfter(1)),
        );
        final secondVisitor = runner.visitor;
        expect(identical(firstVisitor, secondVisitor), isFalse);

        final secondProxy = await second as _GreeterProxy;
        final firstProxy = await first as _GreeterProxy;
        expect(identical(secondProxy.visitor, secondVisitor), isTrue);
        expect(
          identical(firstProxy.visitor, firstVisitor),
          isTrue,
          reason:
              'the first run finished after the second started; it must '
              'still unwrap with the visitor it ran on',
        );
      },
    );

    // The AST tree navigates resumption through parent links (SAstNode has no
    // `.parent`). They used to sit in a process-wide map that every top-level
    // run CLEARED, so a run suspended at an await lost its enclosing statement
    // when another run started — on the same runner or any other — and its
    // `async main` came back null. Measured before the fix: 'first null'.
    for (final runners in [1, 2]) {
      test(
        'DASY1-AST-5: a suspended run keeps its result when another run starts '
        '($runners runner${runners == 1 ? '' : 's'}) [2026-11-06]',
        () async {
          final a = _runner();
          final b = runners == 1 ? a : _runner();
          SCompilationUnit after(int milliseconds, int value) =>
              _unit([_wait(milliseconds), _return(_int(value))]);
          final first = a.executeBundleAsAsync<int>(_bundle(after(40, 1)));
          final second = b.executeBundleAsAsync<int>(_bundle(after(1, 2)));
          expect(await second, 2);
          expect(await first, 1);
        },
      );
    }
  });

  group('DASY1/AST: an async error keeps its frames', () {
    // Positions come from the bundle's sources, so the script is written out
    // and every statement carries its real offset.
    const source =
        'Future<void> inner() async {\n'
        '  await AsyncService.wait(5);\n'
        '  throw StateError(\'later\');\n'
        '}\n'
        '\n'
        'Future<void> main() async {\n'
        '  await inner();\n'
        '}\n';

    SFunctionDeclaration asyncFunction(String name, List<SStatement> body) =>
        SFunctionDeclaration(
          offset: source.indexOf('Future<void> $name'),
          length: 0,
          name: _id(name),
          functionExpression: SFunctionExpression(
            offset: 0,
            length: 0,
            parameters: _noParams(),
            body: SBlockFunctionBody(
              offset: 0,
              length: 0,
              isAsync: true,
              block: _block(body),
            ),
          ),
        );

    SExpressionStatement at(String text, SExpression expression) =>
        SExpressionStatement(
          offset: source.indexOf(text),
          length: text.length,
          expression: expression,
        );

    test('DASY1-AST-6: an error raised after an await is traced to the async '
        'function and statement it was raised in [2026-11-06]', () async {
      final bundle = AstBundle(
        entryPointUri: _entry,
        modules: {
          _entry: SCompilationUnit(
            offset: 0,
            length: source.length,
            directives: [
              SImportDirective(offset: 0, length: 0, uri: _string(_library)),
            ],
            declarations: [
              asyncFunction('inner', [
                at(
                  'await AsyncService.wait(5);',
                  _await(_call(_id('AsyncService'), 'wait', [_int(5)])),
                ),
                at(
                  "throw StateError('later');",
                  SThrowExpression(
                    offset: 0,
                    length: 0,
                    expression: _call(null, 'StateError', [_string('later')]),
                  ),
                ),
              ]),
              asyncFunction('main', [
                at('await inner();', _await(_call(null, 'inner'))),
              ]),
            ],
          ),
        },
        sources: {_entry: source},
      );
      final runner = _runner();
      await expectLater(
        runner.executeBundleAsAsync<Object?>(bundle),
        throwsA(isA<StateError>()),
      );
      expect(runner.lastErrorTrace, isNotEmpty);
      final innermost = runner.lastErrorTrace.first;
      expect(innermost.member, 'inner');
      expect(innermost.line, 3);
    });
  });

  group('TDIMPA1/AST: awaiting a host Future from a script', () {
    test(
      'TDIMPA1-AST-1: await on a bridged method returning Future<int> gives the value [2026-11-06]',
      () async {
        final result = await _runner().executeBundleAsAsync<Object?>(
          _bundle(
            _unit([
              _return(_await(_service('doubleLater', [_int(21)]))),
            ]),
          ),
        );
        expect(result, 42);
      },
    );

    test(
      'TDIMPA1-AST-2: an awaited bridged value is wrapped like a sync result [2026-11-06]',
      () async {
        final item = SSimpleIdentifier(offset: 0, length: 0, name: 'item');
        final result = await _runner().executeBundleAsAsync<Object?>(
          _bundle(
            _unit([
              SVariableDeclarationStatement(
                offset: 0,
                length: 0,
                variables: SVariableDeclarationList(
                  offset: 0,
                  length: 0,
                  variables: [
                    SVariableDeclaration(
                      offset: 0,
                      length: 0,
                      name: _id('item'),
                      initializer: _await(_service('itemLater', [_int(5)])),
                    ),
                  ],
                ),
              ),
              _return(
                SListLiteral(
                  offset: 0,
                  length: 0,
                  elements: [
                    SPrefixedIdentifier(
                      offset: 0,
                      length: 0,
                      prefix: item,
                      identifier: _id('value'),
                    ),
                    _id('item'),
                  ],
                ),
              ),
            ]),
          ),
        );
        final list = result as List<Object?>;
        expect(list[0], 5);
        expect(list[1], isA<Item>(), reason: 'the host gets the native object');
      },
    );

    test(
      'TDIMPA1-AST-3: a failing host Future is a catchable script exception [2026-11-06]',
      () async {
        final result = await _runner().executeBundleAsAsync<Object?>(
          _bundle(
            _unit([
              STryStatement(
                offset: 0,
                length: 0,
                body: _block([
                  SExpressionStatement(
                    offset: 0,
                    length: 0,
                    expression: _await(
                      _service('failLater', [_string('no row')]),
                    ),
                  ),
                  _return(_string('not reached')),
                ]),
                catchClauses: [
                  SCatchClause(
                    offset: 0,
                    length: 0,
                    exceptionType: _type('StateError'),
                    exceptionParameter: _id('e'),
                    body: _block([
                      _return(
                        SPrefixedIdentifier(
                          offset: 0,
                          length: 0,
                          prefix: _id('e'),
                          identifier: _id('message'),
                        ),
                      ),
                    ]),
                  ),
                ],
              ),
            ]),
          ),
        );
        expect(result, 'no row');
      },
    );

    test(
      'TDIMPA1-AST-4: an uncaught host Future error fails the run with that error [2026-11-06]',
      () async {
        await expectLater(
          _runner().executeBundleAsAsync<Object?>(
            _bundle(
              _unit([
                _return(_await(_service('failLater', [_string('lost')]))),
              ]),
            ),
          ),
          throwsA(
            isA<StateError>().having((e) => e.message, 'message', 'lost'),
          ),
        );
      },
    );
  });
}
