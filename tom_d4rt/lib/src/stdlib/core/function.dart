import 'package:tom_d4rt/d4rt.dart';

class FunctionCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: Function,
    name: 'Function',
    typeParameterCount: 0,
    constructors: {},
    staticMethods: {
      'apply': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty || positionalArgs[0] is! Callable) {
          throw RuntimeD4rtException(
            'Function.apply requires a Callable as the first argument.',
          );
        }
        final functionToApply = positionalArgs[0] as Callable;
        // Both argument lists are nullable in the SDK signature, and `null`
        // means "none" rather than being an error.
        final rawPositional = positionalArgs.length > 1
            ? positionalArgs[1]
            : null;
        final argumentsToPass = rawPositional == null
            ? const <Object?>[]
            : D4.coerceList<Object?>(rawPositional, 'positionalArguments');
        final namedArgumentsToPass = positionalArgs.length > 2
            ? _namedArgumentsFromSymbolKeys(positionalArgs[2])
            // `Function.apply` declares no named parameters of its own, so
            // this adapter's `namedArgs` is always empty; say so rather than
            // forwarding it and implying it could carry something.
            : const <String, Object?>{};

        return functionToApply.call(
          visitor,
          argumentsToPass,
          namedArgumentsToPass,
        );
      },
    },
    methods: {
      'call': (visitor, target, positionalArgs, namedArgs, _) {
        if (target is Callable) {
          return target.call(visitor, positionalArgs, namedArgs);
        }
        throw RuntimeD4rtException('Cannot call non-Callable Function');
      },
      'toString': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as Function).toString(),
    },
    getters: {
      'hashCode': (visitor, target) => (target as Function).hashCode,
      'runtimeType': (visitor, target) => (target as Function).runtimeType,
    },
  );

  /// Translates the SDK's `Map<Symbol, dynamic>` named-argument map into the
  /// name-keyed map [Callable.call] takes.
  ///
  /// SCD70 made this adapter coerce rather than cast, which replaced an opaque
  /// `_TypeError` with a readable message — but the message it produced said
  /// `Symbol` is not a `String`, because the adapter still wanted the keys
  /// d4rt uses internally. The SDK declares `Map<Symbol, dynamic>?`, so
  /// `{#b: 2}` — the only spelling the analyzer accepts — was the one that
  /// failed, and `{'b': 2}` — which no Dart program can contain — was the one
  /// that worked. The translation happens here so that the legal spelling is
  /// the working one.
  ///
  /// String keys are rejected rather than accepted alongside Symbols: d4rt
  /// matches the SDK per construct, so that a script ported from Dart behaves
  /// the same and a script written against d4rt still compiles as Dart.
  static Map<String, Object?> _namedArgumentsFromSymbolKeys(Object? raw) {
    if (raw == null) return const <String, Object?>{};
    if (raw is! Map) {
      throw ArgumentD4rtException(
        'Invalid parameter "namedArguments": expected '
        'Map<Symbol, dynamic>, got ${raw.runtimeType}',
      );
    }
    final result = <String, Object?>{};
    for (final entry in raw.entries) {
      final key = entry.key;
      if (key is! Symbol) {
        final wrote = key is String ? "{'$key': ...}" : '{$key: ...}';
        throw ArgumentD4rtException(
          'Invalid parameter "namedArguments": named arguments are keyed by '
          'Symbol, not ${key.runtimeType} - write {#${key is String ? key : 'name'}: ...} '
          'rather than $wrote',
        );
      }
      result[_symbolName(key)] = entry.value;
    }
    return result;
  }

  /// Reads a [Symbol]'s name without `dart:mirrors`, which the analyzer-free
  /// twin cannot import.
  ///
  /// `Symbol('b').toString()` is `Symbol("b")`. Minification is the usual
  /// reason not to trust that, and it does not apply: every Symbol a script
  /// can produce is built at run time by the interpreter — from a symbol
  /// literal, or through the `Symbol` bridge constructor — so its name is
  /// always the spelling in the source.
  static String _symbolName(Symbol symbol) {
    final text = symbol.toString();
    const prefix = 'Symbol("';
    if (text.startsWith(prefix) && text.endsWith('")')) {
      return text.substring(prefix.length, text.length - 2);
    }
    throw ArgumentD4rtException(
      'Invalid parameter "namedArguments": cannot read the name of $text, '
      'so it cannot be matched to a named parameter',
    );
  }
}
