/// SCE234 — `identical` and `identityHashCode` treat a bridged class and the
/// native `Type` it denotes as one object.
///
/// This package has no parser, so it calls the registered functions directly
/// with what the script-level spellings evaluate to: a class name is its
/// `BridgedClass`, and `x.runtimeType` is the native `Type`. The script-level
/// test is `tom_d4rt`'s `test/sce234_class_name_identity_test.dart`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core.dart';

void main() {
  late Environment env;
  late InterpreterVisitor visitor;

  setUp(() {
    env = Environment();
    CoreStdlib.register(env);
    visitor = InterpreterVisitor(
      globalEnvironment: env,
      moduleContext: AstModuleLoader(
        modules: const {},
        globalEnvironment: env,
        runner: D4rtRunner(),
      ),
    );
  });

  Object? call(String name, List<Object?> args) =>
      (env.get(name) as NativeFunction).call(visitor, args);

  test('F-SCE234-AST-1: a bridged class is identical to its native Type, and '
      'hashes the same by identity [2026-09-29] (PASS)', () {
    final string = env.findBridgedClassByName('String')!;
    expect(call('identical', [string, 'x'.runtimeType]), isTrue);
    expect(
      call('identityHashCode', [string]),
      call('identityHashCode', ['x'.runtimeType]),
    );
  });

  test('F-SCE234-AST-2: different types stay non-identical [2026-09-29] '
      '(PASS)', () {
    final string = env.findBridgedClassByName('String')!;
    final integer = env.findBridgedClassByName('int')!;
    expect(call('identical', [string, integer]), isFalse);
    expect(call('identical', [string, 1.runtimeType]), isFalse);
  });
}
