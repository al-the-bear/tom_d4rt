/// SCD138 / GEN-126 — the `Intent` rows: a proxy handed to an interpreted
/// method BY NATIVE CODE.
///
/// GEN-126's entry opened by reasoning that a script subclass crossing into
/// Flutter and back "is genuinely the wrong thing by then" — the interpreted
/// identity lost at the boundary. **scd119 disproved that** for the
/// `ThemeExtension` row: the identity survives as a registered
/// `D4InterpretedProxy`, every member access on it already works, and only
/// `getRuntimeType` answered with the BRIDGE's name. The repair went into
/// `ResolvedBinding.bind`, which retries against the interpreted instance
/// behind the proxy after the base check has failed.
///
/// What scd119 could not settle is whether that closes the NINE `Intent` rows,
/// because they arrive by a different route. scd119's cases call the script
/// function from SCRIPT code:
///
///     int main() => take(Shape.wrap(MyShape()));
///
/// The `Intent` shape is the inverse. `Actions.invoke(context, intent)` is
/// NATIVE code that looks up the action and calls `action.invoke(intent)` — so
/// the interpreted method is invoked by the framework, and the argument is
/// bound on a native→interpreted callback rather than on an interpreted call.
/// Whether that path reaches the repaired branch at all is the open question,
/// and it is the one this file answers.
///
/// The canonical corpus shape, `widgets/actions_test.dart:37-43`:
///
/// ```dart
/// class _GreetIntent extends Intent { const _GreetIntent(); }
/// class _GreetAction extends Action<_GreetIntent> {
///   Object? invoke(_GreetIntent intent) { … }
/// }
/// ```
///
/// F-SCD138-3 is the control that keeps a green result honest: if the callback
/// path simply never type-checks its arguments, every case here would pass
/// while proving nothing.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// `Intent`'s stand-in — the bridged base a script extends.
class _NativeIntent {
  const _NativeIntent();
}

/// An unrelated bridged native type, for the control.
class _NativeCrate {
  const _NativeCrate();
}

/// What `D4.registerInterfaceProxy` produces: a real native subtype carrying
/// the interpreted instance it stands for. Named in the bridge's
/// `nativeNames`, per SCD132 — the relationship is declared, not inferred.
class IntentProxy extends _NativeIntent implements D4InterpretedProxy {
  IntentProxy(this._instance);
  final Object _instance;

  @override
  Object get d4rtInstance => _instance;
}

/// `Intent.wrap(x)` — the native crossing. Idempotent, like the real proxy
/// factories.
Object? _wrap(
  InterpreterVisitor visitor,
  List<Object?> positional,
  Map<String, Object?> named,
  List<RuntimeType>? typeArgs,
) {
  final value = positional[0];
  return value is IntentProxy ? value : IntentProxy(value as Object);
}

/// `Actions.invoke(action, intent)` — **native** code that calls back into the
/// interpreter, handing the proxy to a script-declared method.
///
/// This is the whole difference from scd119. The callable arrives as an
/// interpreted value; invoking it from here is the native→interpreted
/// direction, which is how the framework delivers an `Intent` to
/// `Action.invoke`.
Object? _dispatch(
  InterpreterVisitor visitor,
  List<Object?> positional,
  Map<String, Object?> named,
  List<RuntimeType>? typeArgs,
) {
  final callable = positional[0] as Callable;
  final intent = positional[1];
  return callable.call(visitor, [intent]);
}

void main() {
  group('SCD138: a proxy bound by a native→interpreted callback', () {
    late D4rt interpreter;

    setUp(() {
      interpreter = D4rt();
      interpreter.registerBridgedClass(
        BridgedClass(
          nativeType: _NativeIntent,
          name: 'Intent',
          nativeNames: const ['IntentProxy'],
          constructors: {'': (visitor, positional, named) => _NativeIntent()},
          staticMethods: {'wrap': _wrap, 'dispatch': _dispatch},
        ),
        'package:test/intent.dart',
      );
      interpreter.registerBridgedClass(
        BridgedClass(
          nativeType: _NativeCrate,
          name: 'Crate',
          constructors: {'': (visitor, positional, named) => _NativeCrate()},
          staticMethods: {'wrap': _wrap},
        ),
        'package:test/crate.dart',
      );
    });

    test('F-SCD138-1: a top-level function invoked from native code binds the '
        'proxy to a parameter declared as the script class [2026-09-15]', () {
      final result = interpreter.execute(
        source: '''
            import 'package:test/intent.dart';

            class GreetIntent extends Intent {
              int size = 7;
            }

            int handle(GreetIntent intent) => intent.size;

            int main() {
              final proxied = Intent.wrap(GreetIntent());
              return Intent.dispatch(handle, proxied);
            }
          ''',
      );
      expect(
        result,
        7,
        reason:
            'the corpus signature is '
            "`type 'Intent' is not a subtype of type '_GreetIntent' of "
            "'intent'`. If that is what fails here, the native callback path "
            'does not reach the branch scd119 repaired and the Intent rows '
            'are a distinct, still-open defect.',
      );
    });

    test('F-SCD138-2: the same, through a METHOD on a script class — the shape '
        '`Action<_GreetIntent>.invoke` actually has [2026-09-15]', () {
      // `Actions.invoke` calls a method on an instance, not a bare function.
      // Worth separating: a tear-off and a method binding are different
      // callables, and the corpus only ever exercises the second.
      final result = interpreter.execute(
        source: '''
            import 'package:test/intent.dart';

            class GreetIntent extends Intent {
              int size = 11;
            }

            class GreetAction {
              int invoke(GreetIntent intent) => intent.size;
            }

            int main() {
              final action = GreetAction();
              final proxied = Intent.wrap(GreetIntent());
              return Intent.dispatch(action.invoke, proxied);
            }
          ''',
      );
      expect(result, 11);
    });

    test(
      'F-SCD138-3 (control): the callback path DOES type-check its arguments '
      '[2026-09-15]',
      () {
        // Without this, a green F-SCD138-1/2 is indistinguishable from a path
        // that never checks anything — which would make this whole file a
        // tautology. An unrelated bridged value must still be refused.
        expect(
          () => interpreter.execute(
            source: '''
              import 'package:test/intent.dart';
              import 'package:test/crate.dart';

              class GreetIntent extends Intent {
                int size = 7;
              }

              int handle(GreetIntent intent) => intent.size;

              int main() {
                return Intent.dispatch(handle, Crate());
              }
            ''',
          ),
          throwsA(
            predicate(
              (e) => e.toString().contains('GreetIntent'),
              'rejects an unrelated value, naming the declared type',
            ),
          ),
        );
      },
    );
  });
}
