/// SCD145 — a native object no bridge claims must SAY SO, not report a missing
/// member.
///
/// THE SYMPTOM, recorded verbatim in F-SCC49-1's reason string because it was
/// actively misleading while debugging:
///
///     Undefined property or method 'moveNext' on _TallyIterator
///
/// The real cause is thrown at the end of `Environment.toBridgedClass` —
/// `Cannot bridge native object: No registered bridged class found for native
/// type …` — and then absorbed. `InterpreterVisitorExtension.toBridgedInstance`
/// catches everything, `revoke()`s it and returns `(null, false)`, which is a
/// CONTROL-FLOW signal its callers need: an internal interpreter value
/// (`BridgedEnum`, `BridgedClass`, an `InterpretedInstance`) legitimately has no
/// bridge, and those callers must fall through to other registries. So the catch
/// is right and the message is lost.
///
/// The member error is then raised at the end of the fallthrough chain, and it
/// points the reader at the member: they go looking for a missing method on a
/// bridge, when the bridge does not exist at all.
///
/// WHY THIS MATTERS MORE AFTER SCC49, NOT LESS. SCC49 made implementation types
/// named after their interface resolve structurally, so the population reaching
/// this path shrank to the hard residue — types the SDK abbreviates
/// (`_StreamSinkWrapper`, `_ControllerSubscription`) and types with no naming
/// relationship to any bridge at all. Those are exactly the cases where the
/// reader most needs the diagnostic to name the cause, and they are now the only
/// ones that produce it.
///
/// WHAT THIS CHANGES, AND WHAT IT DELIBERATELY DOES NOT. Only the MESSAGE, at
/// the two sites that raise the member error for a non-bridged receiver. Not the
/// exception type, not `memberName`, not `receiver`, and not the control flow —
/// `environment.dart`'s own note records why widening resolution instead broke
/// 43 enum-dispatch tests, because callers use the throw as a signal. A message
/// change on a path that is already failing cannot regress a passing one, which
/// is the same safety argument SCC49 made for its structural pass.
///
/// F-SCD145-4 and -5 are the controls: an internal interpreter value and a
/// genuinely-bridged object must not acquire the new wording.
///
/// Twin of `tom_d4rt/test/scd145_unbridged_native_diagnostic_test.dart`, minus
/// its SCRIPT-level cases. This line has no analyzer, so a script here is a
/// hand-built `SAstNode` tree; the clause is produced by
/// `InterpreterVisitorExtension.unbridgedNativeClause`, which is code-identical
/// across the twins (SCC92 does not baseline `utils/extensions/visitor.dart` as
/// divergent), so what is asserted here is the clause's own decision table —
/// which receivers earn it and which do not. That is the part worth measuring
/// twice; the reference tree owns the end-to-end evidence.
@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// A native type NO bridge can reach, by any pass. See the reference twin for
/// why the name is load-bearing.
class Zqwx {
  int get tally => 5;
}

/// The native type behind the one registered bridge.
class NativeGadget {}

/// A script-declared class stands in for the interpreter-internal case; here it
/// is represented directly by the abstractions the clause tests against.
void main() {
  late InterpreterVisitor visitor;

  setUp(() {
    final runner = D4rtRunner();
    runner.registerBridgedClass(
      BridgedClass(nativeType: NativeGadget, name: 'Gadget'),
      'package:scd145/fixtures.dart',
    );
    runner.warmup();
    // A visitor is needed for the extension; the runner builds one on execute,
    // so a trivial bundle is the cheapest way to get a real one.
    final bundle = AstBundle(
      entryPointUri: 'package:t/main.dart',
      modules: {
        'package:t/main.dart': SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: [
            SFunctionDeclaration(
              offset: 1,
              length: 4,
              name: SSimpleIdentifier(offset: 2, length: 4, name: 'main'),
              functionExpression: SFunctionExpression(
                offset: 3,
                length: 1,
                parameters: SFormalParameterList(offset: 4, length: 1),
                body: SExpressionFunctionBody(
                  offset: 5,
                  length: 1,
                  expression: SIntegerLiteral(offset: 6, length: 1, value: 1),
                ),
              ),
            ),
          ],
        ),
      },
    );
    runner.executeBundleAs<Object?>(bundle, name: 'main');
    visitor = runner.visitor!;
  });

  group('SCD145/AST: the unbridged-native clause decides correctly', () {
    test('F-SCD145-AST-1: a native type no bridge claims earns the clause '
        '[2026-09-15]', () {
      final clause = visitor.unbridgedNativeClause(Zqwx());
      expect(clause, contains('no bridged class is registered'));
      expect(
        clause,
        contains('Zqwx'),
        reason: 'the clause must name the type a bridge is missing for',
      );
    });

    test('F-SCD145-AST-2 (control): a bridged native type earns nothing '
        '[2026-09-15]', () {
      // `Gadget` IS registered, so the member really is the problem and the
      // clause would be a lie.
      expect(visitor.unbridgedNativeClause(NativeGadget()), isEmpty);
    });

    test('F-SCD145-AST-3 (control): interpreter-internal values earn nothing '
        '[2026-09-15]', () {
      // The case the absorbing catch in `toBridgedInstance` exists for. Tested
      // against the abstractions the interpreter owns rather than a list of
      // concrete types, because a list is what rots.
      final bridge = BridgedClass(nativeType: NativeGadget, name: 'Gadget');
      expect(
        visitor.unbridgedNativeClause(bridge),
        isEmpty,
        reason: 'a BridgedClass is a RuntimeType',
      );
      expect(
        visitor.unbridgedNativeClause(BridgedInstance(bridge, NativeGadget())),
        isEmpty,
        reason: 'a BridgedInstance is a RuntimeValue',
      );
      expect(visitor.unbridgedNativeClause(null), isEmpty);
    });
  });
}
