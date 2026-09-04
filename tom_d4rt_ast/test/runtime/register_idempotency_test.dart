/// Step 5 of `d4rt_consolidation_plan.md` — register-twice idempotency
/// for the D4 / BridgedClass registries.
///
/// The `_relaxersRegistered` static-bool guard in
/// `tom_d4rt_flutterm/lib/src/flutter_d4rt.dart` was removed in step 5;
/// the generated `registerRelaxers()` block (and the matching
/// `registerD4rtRuntimeExtensions()`) now fire on every `FlutterD4rt`
/// instance. That requires every register-* method on `D4` and on
/// `BridgedClass` to be idempotent — repeated calls with the same key
/// must not grow the per-key list, must not multiply chained dispatches,
/// and must not throw.
///
/// These tests assert the contract directly. They use distinct synthetic
/// keys so they do not interfere with the framework's real registrations.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  group('D4.registerInterfaceProxy is idempotent', () {
    test('repeated registration with the same key does not throw and stays '
        'visible via hasInterfaceProxy', () {
      const name = '_StepFiveTest_InterfaceProxy';
      Object? proxyA(InterpreterVisitor v, InterpretedInstance i) => 'A';
      Object? proxyB(InterpreterVisitor v, InterpretedInstance i) => 'B';

      D4.registerInterfaceProxy(name, proxyA);
      expect(D4.hasInterfaceProxy(name), isTrue);

      // Same key, same factory — idempotent no-op.
      expect(() => D4.registerInterfaceProxy(name, proxyA), returnsNormally);
      expect(D4.hasInterfaceProxy(name), isTrue);

      // Same key, different factory — overwrite (well-defined for a
      // single-value-per-key registry).
      expect(() => D4.registerInterfaceProxy(name, proxyB), returnsNormally);
      expect(D4.hasInterfaceProxy(name), isTrue);
    });
  });

  group('D4.registerTypeCoercion is idempotent', () {
    test('repeated registration with the same source/target pair does not '
        'throw', () {
      Object? cast1(Object v) => '1:$v';
      Object? cast2(Object v) => '2:$v';

      expect(
        () => D4.registerTypeCoercion(
          sourceType: _StepFiveSrc,
          targetType: _StepFiveDst,
          factory: cast1,
        ),
        returnsNormally,
      );
      // Same factory, same key — overwrite no-op.
      expect(
        () => D4.registerTypeCoercion(
          sourceType: _StepFiveSrc,
          targetType: _StepFiveDst,
          factory: cast1,
        ),
        returnsNormally,
      );
      // Different factory, same key — overwrite (well-defined).
      expect(
        () => D4.registerTypeCoercion(
          sourceType: _StepFiveSrc,
          targetType: _StepFiveDst,
          factory: cast2,
        ),
        returnsNormally,
      );
    });
  });

  group('D4.registerGenericConstructor is idempotent', () {
    test('the same factory registered twice is stored as the bare factory '
        '(no chained closure layered on itself)', () {
      const className = '_StepFiveTest_GenericCtor_Bare';
      const ctorName = '';
      Object? factory(
        InterpreterVisitor visitor,
        List<Object?> positional,
        Map<String, Object?> named,
        List<RuntimeType>? typeArgs,
      ) => 'made';

      D4.registerGenericConstructor(className, ctorName, factory);
      // Pre-condition: identity equals the registered factory.
      expect(
        identical(D4.findGenericConstructor(className, ctorName), factory),
        isTrue,
        reason: 'First registration stores the bare factory.',
      );

      D4.registerGenericConstructor(className, ctorName, factory);
      // Post-condition: identity is *still* the bare factory — the
      // duplicate-registration path no-ops; it does NOT wrap `factory`
      // in a chained closure that would then call itself twice.
      expect(
        identical(D4.findGenericConstructor(className, ctorName), factory),
        isTrue,
        reason:
            'Same factory registered twice must not be chained on top '
            'of itself.',
      );

      // Triple-register — still the bare factory.
      D4.registerGenericConstructor(className, ctorName, factory);
      expect(
        identical(D4.findGenericConstructor(className, ctorName), factory),
        isTrue,
        reason: 'Repeated duplicate registrations remain idempotent.',
      );
    });

    test('two distinct factories chain (first registered → fallback) and a '
        're-registration of either does not extend the chain', () {
      const className = '_StepFiveTest_GenericCtor_Chain';
      const ctorName = '';
      Object? first(
        InterpreterVisitor visitor,
        List<Object?> positional,
        Map<String, Object?> named,
        List<RuntimeType>? typeArgs,
      ) => null;
      Object? second(
        InterpreterVisitor visitor,
        List<Object?> positional,
        Map<String, Object?> named,
        List<RuntimeType>? typeArgs,
      ) => 'fallback';

      D4.registerGenericConstructor(className, ctorName, first);
      // After one registration: stored factory is `first` itself.
      expect(
        identical(D4.findGenericConstructor(className, ctorName), first),
        isTrue,
      );

      D4.registerGenericConstructor(className, ctorName, second);
      // After second registration with a *different* factory: stored is a
      // chained closure (not `first`, not `second`).
      final afterChain = D4.findGenericConstructor(className, ctorName);
      expect(identical(afterChain, first), isFalse);
      expect(identical(afterChain, second), isFalse);

      // Re-register `first` — duplicate, must no-op (no extra wrap).
      D4.registerGenericConstructor(className, ctorName, first);
      expect(
        identical(D4.findGenericConstructor(className, ctorName), afterChain),
        isTrue,
        reason:
            'Re-registering an already-registered factory must not produce '
            'a deeper chain.',
      );

      // Re-register `second` — same idempotency guarantee.
      D4.registerGenericConstructor(className, ctorName, second);
      expect(
        identical(D4.findGenericConstructor(className, ctorName), afterChain),
        isTrue,
      );
    });
  });

  group('D4.registerGenericTypeWrapper is idempotent', () {
    test('repeated registration of the same factory does not throw', () {
      const baseType = '_StepFiveTest_TypeWrapper';
      Object? factory(Object value, String innerType) => 'wrapped:$value';

      expect(
        () => D4.registerGenericTypeWrapper(baseType, factory),
        returnsNormally,
      );
      // Same factory, same key — must no-op rather than append.
      expect(
        () => D4.registerGenericTypeWrapper(baseType, factory),
        returnsNormally,
      );
      expect(
        () => D4.registerGenericTypeWrapper(baseType, factory),
        returnsNormally,
      );

      // A *distinct* factory for the same base type — appended.
      Object? otherFactory(Object value, String innerType) => null;
      expect(
        () => D4.registerGenericTypeWrapper(baseType, otherFactory),
        returnsNormally,
      );
      // Re-registering the distinct factory is also idempotent.
      expect(
        () => D4.registerGenericTypeWrapper(baseType, otherFactory),
        returnsNormally,
      );
    });
  });

  group('D4.registerSupplementaryMethod is idempotent', () {
    test('repeated registration with same (class, method) overwrites without '
        'throwing', () {
      const className = '_StepFiveTest_SupplMethod';
      const methodName = 'doIt';
      Object? adapterA(
        InterpreterVisitor visitor,
        Object target,
        List<Object?> positional,
        Map<String, Object?> named,
        List<RuntimeType>? typeArgs,
      ) => 'A';
      Object? adapterB(
        InterpreterVisitor visitor,
        Object target,
        List<Object?> positional,
        Map<String, Object?> named,
        List<RuntimeType>? typeArgs,
      ) => 'B';

      D4.registerSupplementaryMethod(className, methodName, adapterA);
      expect(
        identical(D4.findSupplementaryMethod(className, methodName), adapterA),
        isTrue,
      );
      // Same adapter, same key — overwrite no-op.
      D4.registerSupplementaryMethod(className, methodName, adapterA);
      expect(
        identical(D4.findSupplementaryMethod(className, methodName), adapterA),
        isTrue,
      );
      // Different adapter — last write wins (well-defined for an
      // overwrite-by-key registry).
      D4.registerSupplementaryMethod(className, methodName, adapterB);
      expect(
        identical(D4.findSupplementaryMethod(className, methodName), adapterB),
        isTrue,
      );
    });
  });

  group('BridgedClass.registerSupertypes is idempotent', () {
    test('repeated registration of the same hierarchy does not duplicate '
        'entries (Set semantics)', () {
      const cls = '_StepFiveTest_RegisterSupertypes';
      BridgedClass.registerSupertypes({
        cls: ['Widget', 'DiagnosticableTree'],
      });
      // Duplicate call — Set.addAll on the same values is a no-op.
      expect(
        () => BridgedClass.registerSupertypes({
          cls: ['Widget', 'DiagnosticableTree'],
        }),
        returnsNormally,
      );
      // Adding a third entry on top — earlier entries persist (Set
      // semantics).
      BridgedClass.registerSupertypes({
        cls: ['Object'],
      });

      final transitive = BridgedClass.transitiveSupertypeNames(cls);
      expect(transitive, containsAll(<String>['Widget', 'DiagnosticableTree']));
      expect(transitive, contains('Object'));
    });
  });
}

// Throwaway native types used as the source/target of the test coercion.
// `D4.registerTypeCoercion` only stores them by `Type` identity / hashCode
// and never invokes them, so the empty class bodies are fine.
class _StepFiveSrc {}

class _StepFiveDst {}
