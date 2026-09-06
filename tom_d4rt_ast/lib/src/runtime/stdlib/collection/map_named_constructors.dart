import 'package:tom_d4rt_ast/runtime.dart';

/// The `Map` named constructors that every `dart:collection` map
/// implementation declares with the same body.
///
/// `HashMap`, `LinkedHashMap` and `SplayTreeMap` each carry `fromIterable`,
/// `fromIterables` and `fromEntries`, and in the SDK all of them delegate to
/// the same two private helpers on `MapBase`. Those helpers are private, so a
/// bridge cannot call them — which is how the adapters came within one edit of
/// being written out three times over. They are written once here instead and
/// parameterised by the empty map each implementation creates, so a fix to the
/// argument handling lands in all three.
///
/// Each entry takes the [className] purely for its error messages: a script
/// that passes the wrong argument should be told which constructor rejected
/// it, not which helper.
class MapNamedConstructors {
  const MapNamedConstructors._();

  /// `X.fromIterable(iterable, {key, value})`.
  ///
  /// The two callbacks arrive as interpreted functions and default to the
  /// identity, exactly as the SDK's own defaults do.
  static Object fromIterable(
    String className,
    Map<Object?, Object?> Function() create,
    InterpreterVisitor visitor,
    List<Object?> positionalArgs,
    Map<String, Object?> namedArgs,
  ) {
    if (positionalArgs.length != 1 || positionalArgs[0] is! Iterable) {
      throw RuntimeD4rtException(
        '$className.fromIterable expects one Iterable argument.',
      );
    }
    final key = namedArgs['key'] as InterpretedFunction?;
    final value = namedArgs['value'] as InterpretedFunction?;
    final map = create();
    for (final element in positionalArgs[0] as Iterable) {
      map[key == null ? element : key.call(visitor, [element])] = value == null
          ? element
          : value.call(visitor, [element]);
    }
    return map;
  }

  /// `X.fromIterables(keys, values)`.
  static Object fromIterables(
    String className,
    Map<Object?, Object?> Function() create,
    List<Object?> positionalArgs,
  ) {
    if (positionalArgs.length != 2 ||
        positionalArgs[0] is! Iterable ||
        positionalArgs[1] is! Iterable) {
      throw RuntimeD4rtException(
        '$className.fromIterables expects two Iterable arguments.',
      );
    }
    final keys = (positionalArgs[0] as Iterable).iterator;
    final values = (positionalArgs[1] as Iterable).iterator;
    final map = create();
    while (keys.moveNext()) {
      if (!values.moveNext()) {
        throw RuntimeD4rtException(
          '$className.fromIterables: keys and values have different lengths.',
        );
      }
      map[keys.current] = values.current;
    }
    if (values.moveNext()) {
      throw RuntimeD4rtException(
        '$className.fromIterables: keys and values have different lengths.',
      );
    }
    return map;
  }

  /// `X.fromEntries(entries)`.
  ///
  /// A `MapEntry` built by a script arrives wrapped, so each element is
  /// unwrapped before it is read — the same handling `Map.fromEntries` does.
  static Object fromEntries(
    String className,
    Map<Object?, Object?> Function() create,
    List<Object?> positionalArgs,
  ) {
    if (positionalArgs.length != 1 || positionalArgs[0] is! Iterable) {
      throw RuntimeD4rtException(
        '$className.fromEntries expects one Iterable<MapEntry> argument.',
      );
    }
    final map = create();
    for (final raw in positionalArgs[0] as Iterable) {
      final entry = raw is BridgedInstance ? raw.nativeObject : raw;
      if (entry is! MapEntry) {
        throw RuntimeD4rtException(
          '$className.fromEntries expects Iterable<MapEntry>, got '
          '${entry.runtimeType}.',
        );
      }
      map[entry.key] = entry.value;
    }
    return map;
  }
}
