import 'dart:convert';

import 'package:tom_d4rt/d4rt.dart';

/// `ClosableStringSink` (dart:convert) — a `StringSink` that can be closed.
///
/// Abstract, so the usual private-implementation routing applies: both routes
/// to an instance return `_ClosableStringSink`. The two routes are
/// `ClosableStringSink.fromStringSink(sink, onClose)` and
/// `StringConversionSink.asStringSink()` — the latter is why
/// [StringConversionConvert] had to be registered alongside this bridge, since
/// it is the route that actually appears in chunked-conversion code.
///
/// The `StringSink` surface (`write`, `writeln`, `writeAll`, `writeCharCode`)
/// is declared explicitly rather than inherited: bridges dispatch per-bridge,
/// and the `dart:convert` hierarchy has no supertype edges registered, so a
/// `_ClosableStringSink` has no route to the `StringSink` bridge's members.
class ClosableStringSinkConvert {
  static BridgedClass get definition => BridgedClass(
    nativeType: ClosableStringSink,
    name: 'ClosableStringSink',
    isAssignable: (v) => v is ClosableStringSink,
    nativeNames: const ['_ClosableStringSink'],
    typeParameterCount: 0,
    constructors: {
      'fromStringSink': (visitor, positionalArgs, namedArgs) {
        final sink = positionalArgs.isNotEmpty ? positionalArgs[0] : null;
        if (sink is! StringSink) {
          throw RuntimeD4rtException(
            'ClosableStringSink.fromStringSink requires a StringSink as '
            'its first argument.',
          );
        }
        final onClose = positionalArgs.length > 1 ? positionalArgs[1] : null;
        if (onClose is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'ClosableStringSink.fromStringSink requires a callback as its '
            'second argument.',
          );
        }
        return ClosableStringSink.fromStringSink(
          sink,
          () => onClose.call(visitor, []),
        );
      },
    },
    methods: {
      'close': (visitor, target, positionalArgs, namedArgs, _) {
        (target as ClosableStringSink).close();
        return null;
      },
      'write': (visitor, target, positionalArgs, namedArgs, _) {
        final value = positionalArgs.isNotEmpty ? positionalArgs[0] : null;
        (target as ClosableStringSink).write(value);
        return null;
      },
      'writeln': (visitor, target, positionalArgs, namedArgs, _) {
        final value = positionalArgs.isNotEmpty ? positionalArgs[0] : '';
        (target as ClosableStringSink).writeln(value);
        return null;
      },
      'writeCharCode': (visitor, target, positionalArgs, namedArgs, _) {
        final code = positionalArgs.isNotEmpty ? positionalArgs[0] : null;
        if (code is! int) {
          throw RuntimeD4rtException(
            'ClosableStringSink.writeCharCode requires one int argument.',
          );
        }
        (target as ClosableStringSink).writeCharCode(code);
        return null;
      },
      'writeAll': (visitor, target, positionalArgs, namedArgs, _) {
        final objects = positionalArgs.isNotEmpty ? positionalArgs[0] : null;
        if (objects is! Iterable) {
          throw RuntimeD4rtException(
            'ClosableStringSink.writeAll requires an Iterable as its '
            'first argument.',
          );
        }
        final separator = positionalArgs.length > 1 ? positionalArgs[1] : '';
        if (separator is! String) {
          throw RuntimeD4rtException(
            'ClosableStringSink.writeAll separator must be a String.',
          );
        }
        (target as ClosableStringSink).writeAll(objects, separator);
        return null;
      },
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as ClosableStringSink).toString();
      },
    },
    getters: {
      'hashCode': (visitor, target) => (target as ClosableStringSink).hashCode,
      'runtimeType': (visitor, target) =>
          (target as ClosableStringSink).runtimeType,
    },
  );
}
