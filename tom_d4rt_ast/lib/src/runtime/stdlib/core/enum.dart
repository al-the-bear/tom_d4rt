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
        typeParameterCount: 0,
        constructors: {},
        staticMethods: {},
        methods: {
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Enum).toString();
          },
          'noSuchMethod': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! Invocation) {
              throw RuntimeD4rtException(
                  'Enum.noSuchMethod requires an Invocation argument.');
            }
            return (target as Enum)
                .noSuchMethod(positionalArgs[0] as Invocation);
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
