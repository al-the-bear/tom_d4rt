/// Regression tests for static-method dispatch on a bridged enum
/// (GitHub issue al-the-bear/tom_d4rt#2) on the analyzer-free `D4rtRunner`.
///
/// A native enum's STATIC methods (e.g. `static PageFormat fromString(String)`)
/// must be reachable from interpreted code as `EnumType.staticMethod(args)`.
/// Previously the generator only emitted instance methods and the interpreter
/// had no static-method dispatch on a `BridgedEnum` target, so the call threw
/// "Undefined property or method 'fromString' on BridgedEnum".
///
/// Twin of `tom_d4rt/test/bridge/bridged_enum_test.dart`
/// (group "Bridged Enum Tests - Static methods (issue #2)").
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// A native enum exposing a static factory method, mirroring the
/// `PageFormat.fromString` shape from issue #2.
enum SizeEnum {
  small,
  medium,
  large;

  static SizeEnum fromString(String name) =>
      SizeEnum.values.firstWhere((e) => e.name == name,
          orElse: () => SizeEnum.small);
}

void main() {
  /// Builds an [AstBundle] whose `main` returns
  /// `SizeEnum.<methodName>(<argLiteral>)`. The enum URI is imported so the
  /// bridged enum resolves as the method-invocation target.
  AstBundle bundleCallingStatic(String methodName, String argLiteral) {
    final importDirective = SImportDirective(
      offset: 0,
      length: 0,
      uri: SSimpleStringLiteral(
          offset: 0, length: 0, value: 'package:test/size.dart'),
    );
    final invocation = SMethodInvocation(
      offset: 0,
      length: 0,
      target: SSimpleIdentifier(offset: 0, length: 8, name: 'SizeEnum'),
      methodName:
          SSimpleIdentifier(offset: 0, length: methodName.length, name: methodName),
      argumentList: SArgumentList(
        offset: 0,
        length: 0,
        arguments: [
          SSimpleStringLiteral(offset: 0, length: 0, value: argLiteral),
        ],
      ),
    );
    final mainFn = SFunctionDeclaration(
      offset: 0,
      length: 0,
      name: SSimpleIdentifier(offset: 0, length: 4, name: 'main'),
      functionExpression: SFunctionExpression(
        offset: 0,
        length: 0,
        parameters: SFormalParameterList(offset: 0, length: 0),
        body: SBlockFunctionBody(
          offset: 0,
          length: 0,
          block: SBlock(
            offset: 0,
            length: 0,
            statements: [
              SReturnStatement(offset: 0, length: 0, expression: invocation),
            ],
          ),
        ),
      ),
    );
    final unit = SCompilationUnit(
      offset: 0,
      length: 0,
      directives: [importDirective],
      declarations: [mainFn],
    );
    return AstBundle(
      entryPointUri: 'package:t/main.dart',
      modules: {'package:t/main.dart': unit},
    );
  }

  BridgedEnumDefinition<SizeEnum> sizeDefinition() =>
      BridgedEnumDefinition<SizeEnum>(
        name: 'SizeEnum',
        values: SizeEnum.values,
        staticMethods: {
          'fromString': (visitor, positional, named, typeArgs) =>
              SizeEnum.fromString(positional[0] as String),
        },
      );

  group('Bridged enum static methods (issue #2, analyzer-free)', () {
    setUp(D4rtRunner.debugResetPool);
    tearDown(D4rtRunner.debugResetPool);

    test('AST-ENUM-STATIC-1: call static method on bridged enum', () {
      final runner = D4rtRunner();
      runner.registerBridgedEnum(sizeDefinition(), 'package:test/size.dart',
          sourceUri: 'package:test/size.dart');

      final result = runner.executeBundle(bundleCallingStatic('fromString', 'medium'));
      expect(result, equals(SizeEnum.medium));
    });

    test('AST-ENUM-STATIC-2: static method falls back via orElse', () {
      final runner = D4rtRunner();
      runner.registerBridgedEnum(sizeDefinition(), 'package:test/size.dart',
          sourceUri: 'package:test/size.dart');

      final result = runner.executeBundle(bundleCallingStatic('fromString', 'nope'));
      expect(result, equals(SizeEnum.small));
    });
  });
}
