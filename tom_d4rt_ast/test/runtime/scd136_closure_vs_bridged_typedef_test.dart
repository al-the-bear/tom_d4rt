/// SCD136 / GEN-125 — an interpreted closure must satisfy a parameter whose
/// declared type is a bridged FUNCTION TYPEDEF.
///
/// A function typedef has no bridgeable class, so the module loader registers
/// it as a `BridgedClass` carrying `Function` as its native type and the
/// *typedef's* name:
///
/// ```dart
/// BridgedClass(nativeType: Function, name: typedef.name)  // ast_module_loader
/// ```
///
/// `FunctionRuntimeType.isSubtypeOf` — the type an interpreted closure resolves
/// to — ended by identifying `Function` **by name**. The bridged typedef's name
/// is `VoidCallback`, which is the one property of that bridge deliberately NOT
/// `Function`, so the test missed and the closure was declared not-a-function:
///
/// ```
/// type 'dynamic Function()'        is not a subtype of type 'VoidCallback?' of 'onPressed'
/// type 'dynamic Function(dynamic)' is not a subtype of type 'ValueChanged'  of 'onChanged'
/// ```
///
/// Blast radius, which is why this is not a four-line curiosity: every Flutter
/// callback (`VoidCallback`, `ValueChanged`, `ValueSetter`,
/// `GestureTapCallback`, …) on every widget, wherever a declared parameter type
/// is checked. Nothing about the script narrows it.
///
/// **Why this line needs its own SCRIPT-level case and does not inherit the
/// reference tree's.** `runtime_interfaces.dart` is code-identical across the
/// twins (SCC92 does not baseline it as divergent), so F-SCD136-1..3 really do
/// measure the same rule twice. `callable.dart` — where `_checkArgumentType`
/// consults that rule, and the consumer that made GEN-125 visible at all — IS
/// on SCC92's divergent baseline, so nothing establishes that the two lines'
/// argument checks agree. F-SCD136-4 is therefore not a duplicate: it is the
/// only evidence that this line's declared-parameter path reaches the fix.
/// SCD5A is the precedent — tcca19 shipped with every unit test green because
/// every one of them built an `Environment` by hand and asked what the registry
/// decided about candidates the test itself supplied. None ran a script.
///
/// Twin of `tom_d4rt/test/scd136_closure_vs_bridged_typedef_test.dart`, which
/// carries two further script cases this line cannot express as cheaply (it has
/// no analyzer, so every script here is a hand-built `SAstNode` tree).
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

const _fixtureUri = 'package:fixture/fixture.dart';

/// A native class, to prove the new rule does not accept a closure for *any*
/// bridge — only for one whose native type really is `Function`.
class Text {
  const Text(this.data);
  final String data;
}

/// What an interpreted closure's runtime type looks like: `dynamic Function()`.
FunctionRuntimeType _closureType({int positional = 0}) => FunctionRuntimeType(
  returnType: const NamedRuntimeType('dynamic'),
  positionalParameterTypes: List<RuntimeType>.filled(
    positional,
    const NamedRuntimeType('dynamic'),
  ),
);

/// A function typedef as the module loader registers it.
BridgedClass _bridgedTypedef(String name) =>
    BridgedClass(nativeType: Function, name: name);

void main() {
  var offset = 0;
  int next() => ++offset;

  SSimpleIdentifier id(String name) =>
      SSimpleIdentifier(offset: next(), length: name.length, name: name);

  /// A bundle holding, under an import of [_fixtureUri]:
  ///
  /// ```dart
  /// int take(VoidCallback cb) => 7;
  /// main() => take(() {});
  /// ```
  ///
  /// The declared-parameter check fires when `cb` is bound, which is the whole
  /// point — the closure never has to be invoked for GEN-125 to reject it.
  AstBundle bundle(String typedefName) {
    const entry = 'package:t/main.dart';

    final take = SFunctionDeclaration(
      offset: next(),
      length: 4,
      name: id('take'),
      functionExpression: SFunctionExpression(
        offset: next(),
        length: 1,
        parameters: SFormalParameterList(
          offset: next(),
          length: 1,
          parameters: [
            SSimpleFormalParameter(
              offset: next(),
              length: 2,
              name: id('cb'),
              type: SNamedType(
                offset: next(),
                length: typedefName.length,
                name: id(typedefName),
              ),
            ),
          ],
        ),
        body: SExpressionFunctionBody(
          offset: next(),
          length: 1,
          expression: SIntegerLiteral(offset: next(), length: 1, value: 7),
        ),
      ),
    );

    // `() {}` — the argument.
    final closure = SFunctionExpression(
      offset: next(),
      length: 1,
      parameters: SFormalParameterList(offset: next(), length: 1),
      body: SBlockFunctionBody(
        offset: next(),
        length: 1,
        block: SBlock(offset: next(), length: 1),
      ),
    );

    final mainFn = SFunctionDeclaration(
      offset: next(),
      length: 4,
      name: id('main'),
      functionExpression: SFunctionExpression(
        offset: next(),
        length: 1,
        parameters: SFormalParameterList(offset: next(), length: 1),
        body: SExpressionFunctionBody(
          offset: next(),
          length: 1,
          expression: SMethodInvocation(
            offset: next(),
            length: 1,
            methodName: id('take'),
            argumentList: SArgumentList(
              offset: next(),
              length: 2,
              arguments: [closure],
            ),
          ),
        ),
      ),
    );

    return AstBundle(
      entryPointUri: entry,
      modules: {
        entry: SCompilationUnit(
          offset: 0,
          length: 0,
          directives: [
            SImportDirective(
              offset: next(),
              length: 1,
              uri: SSimpleStringLiteral(
                offset: next(),
                length: 1,
                value: _fixtureUri,
              ),
            ),
          ],
          declarations: [take, mainFn],
        ),
      },
    );
  }

  D4rtRunner runnerWithTypedefs() {
    final runner = D4rtRunner();
    for (final name in ['VoidCallback', 'ValueChanged']) {
      runner.registerBridgedClass(_bridgedTypedef(name), _fixtureUri);
    }
    runner.registerBridgedClass(
      BridgedClass(nativeType: Text, name: 'Text'),
      _fixtureUri,
    );
    return runner;
  }

  group('SCD136/AST: a closure against a bridged function typedef', () {
    test(
      'F-SCD136-AST-1: a closure type is a subtype of a bridged typedef, whose '
      'name is the typedef and whose native type is Function',
      () {
        expect(
          _closureType().isSubtypeOf(_bridgedTypedef('VoidCallback')),
          isTrue,
          reason:
              'the bridge is identified by its NAME, which is `VoidCallback` '
              'by design. Identify it by its native type instead — that is '
              'what actually says "this is a function".',
        );
        expect(
          _closureType(
            positional: 1,
          ).isSubtypeOf(_bridgedTypedef('ValueChanged')),
          isTrue,
        );
      },
    );

    test('F-SCD136-AST-2: a bridge whose native type is NOT Function still '
        'rejects a closure', () {
      // The control that separates this fix from "accept everything". If it
      // ever passes, the rule has stopped discriminating and every declared
      // parameter type accepts a closure.
      expect(
        _closureType().isSubtypeOf(
          BridgedClass(nativeType: Text, name: 'Text'),
        ),
        isFalse,
        reason:
            'a closure is not a Text. The native-type check must be an '
            'equality against `Function`, not a fallback that returns true.',
      );
    });

    test('F-SCD136-AST-3: the rule subsumes the name test — `dart:core`\'s own '
        '`Function` bridge still matches', () {
      // `Function` is registered with `nativeType: Function` too, so the name
      // branch it replaces is redundant rather than merely bypassed.
      expect(_closureType().isSubtypeOf(_bridgedTypedef('Function')), isTrue);
      expect(
        _closureType().isSubtypeOf(
          FunctionRuntimeType(returnType: const NamedRuntimeType('dynamic')),
        ),
        isTrue,
      );
    });

    test(
      'F-SCD136-AST-4: SCRIPT level — a closure passed to a parameter declared '
      '`VoidCallback` is accepted',
      () {
        expect(
          runnerWithTypedefs().executeBundleAs<Object?>(
            bundle('VoidCallback'),
            name: 'main',
          ),
          7,
          reason:
              'the declared-parameter check lives in `callable.dart`, which '
              'SCC92 baselines as divergent between the twins — so this line\'s '
              'argument path reaching the fix is not implied by the reference '
              'tree\'s script test',
        );
      },
    );
  });
}
