import 'package:tom_d4rt_ast/runtime.dart';

/// Minimal `Enum` base-class bridge — scripts that declare generic types
/// like `class _SettingCard<T extends Enum>` need `Enum` to resolve at
/// bound-check time even though they never instantiate it directly.
///
/// Exposes the two getters every enum value carries (`index`, `name`) and
/// the default `toString`. Because enum values are bridged per-enum via
/// `BridgedEnumValue`, the methods/getters here only apply when a script
/// somehow ends up holding a native `Enum` (rare in practice).
class EnumCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: Enum,
    name: 'Enum',
    // SCD176: without this, `x is Enum` was FALSE for every bridged value,
    // including genuine SDK enums. `_valueHasType`'s bridged branch falls back
    // to `isAssignable` for an operand the supertype walk did not resolve, and
    // skips the fallback entirely when the bridge declares none — so the answer
    // was false by omission rather than by any decision.
    //
    // A PREDICATE RATHER THAN SUPERTYPE EDGES, and the difference is not
    // stylistic. SCD176 proposed declaring an `-> Enum` edge on every
    // "enum-shaped" bridge; measured against Dart, four of the five it names
    // are not enums at all — `StdioType`, `ProcessSignal` and
    // `InternetAddressType` are `final`/`interface class` with static consts,
    // and `FileMode` likewise, so `is Enum` is correctly FALSE for them. A
    // hand-declared edge would have made four correct answers wrong. Asking
    // the native value is right for each without anyone classifying it.
    isAssignable: (v) => v is Enum,
    typeParameterCount: 0,
    constructors: {},
    staticMethods: {
      'compareByIndex': (visitor, positionalArgs, namedArgs, _) {
        final pair = _comparandPair('compareByIndex', positionalArgs);
        return pair.$1.index.compareTo(pair.$2.index);
      },
      'compareByName': (visitor, positionalArgs, namedArgs, _) {
        final pair = _comparandPair('compareByName', positionalArgs);
        return pair.$1.name.compareTo(pair.$2.name);
      },
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Enum).toString();
      },
      'noSuchMethod': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! Invocation) {
          throw RuntimeD4rtException(
            'Enum.noSuchMethod requires an Invocation argument.',
          );
        }
        return (target as Enum).noSuchMethod(positionalArgs[0] as Invocation);
      },
    },
    getters: {
      'index': (visitor, target) => (target as Enum).index,
      'name': (visitor, target) => (target as Enum).name,
      'hashCode': (visitor, target) => (target as Enum).hashCode,
      'runtimeType': (visitor, target) => (target as Enum).runtimeType,
    },
  );
}

/// The `index` and `name` of one enum value, read from whichever
/// representation the interpreter happens to be holding.
typedef _EnumFacts = ({int index, String name});

/// Reads [value] as an enum value regardless of representation.
///
/// D4rt has three: a native SDK `Enum` (reached through a bridge that hands
/// back the raw value), a [BridgedEnumValue] wrapping one, and an
/// [InterpretedEnumValue], which is what a script-declared `enum` produces and
/// which has no native value at all. Writing these comparators as
/// `positionalArgs[0] as Enum` would compile and then reject precisely the
/// enums a script is most likely to declare and then compare. All three expose
/// an index and a name, so the comparison is expressible over all three — and
/// the rule that settles it is the one this bridge family keeps meeting: the
/// bridge must not refuse what Dart accepts.
_EnumFacts? _enumFacts(Object? value) {
  if (value is Enum) return (index: value.index, name: value.name);
  if (value is BridgedEnumValue) {
    return (index: value.index, name: value.name);
  }
  if (value is InterpretedEnumValue) {
    return (index: value.index, name: value.name);
  }
  return null;
}

/// Reads both comparands, or throws naming the argument that is not an enum.
(_EnumFacts, _EnumFacts) _comparandPair(
  String member,
  List<Object?> positionalArgs,
) {
  if (positionalArgs.length != 2) {
    throw RuntimeD4rtException(
      'Enum.$member(value1, value2) expects two positional arguments.',
    );
  }
  final first = _enumFacts(positionalArgs[0]);
  final second = _enumFacts(positionalArgs[1]);
  if (first == null || second == null) {
    throw RuntimeD4rtException(
      'Enum.$member expects an enum value for both arguments, got '
      '${positionalArgs[0].runtimeType} and '
      '${positionalArgs[1].runtimeType}.',
    );
  }
  return (first, second);
}
