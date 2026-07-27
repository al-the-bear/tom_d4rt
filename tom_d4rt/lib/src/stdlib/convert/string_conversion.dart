import 'dart:convert';
import 'package:tom_d4rt/d4rt.dart';

/// `StringConversionSink` (dart:convert) — the sink half of chunked string
/// conversion.
///
/// This definition existed and was exported for a long time without ever being
/// passed to `defineBridge`, so it was unreachable from scripts. Registering it
/// is what makes `Converter.startChunkedConversion` callable at all — a script
/// had no way to construct the sink argument it requires — and it is also the
/// route by which real code obtains a [ClosableStringSink], via
/// `asStringSink()`.
class StringConversionConvert {
  static BridgedClass get definition => BridgedClass(
        nativeType: StringConversionSink,
        name: 'StringConversionSink',
        isAssignable: (v) => v is StringConversionSink,
        // `withCallback` returns this private implementation; without the
        // routing the sink constructs and then rejects its first `add`.
        nativeNames: const ['_StringCallbackSink'],
        typeParameterCount: 0,
        staticMethods: {
          'withCallback': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 ||
                positionalArgs[0] is! InterpretedFunction) {
              throw RuntimeD4rtException(
                  'StringConversionSink.withCallback requires one Function argument.');
            }
            final callback = positionalArgs[0] as InterpretedFunction;
            return StringConversionSink.withCallback((accumulated) {
              callback.call(visitor, [accumulated]);
            });
          },
        },
        methods: {
          'add': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1) {
              throw RuntimeD4rtException(
                  'StringConversionSink.add requires one argument.');
            }
            if (positionalArgs[0] is! String) {
              throw RuntimeD4rtException(
                  'StringConversionSink.add requires a String argument.');
            }
            (target as StringConversionSink).add(positionalArgs[0] as String);
            return null;
          },
          'addSlice': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 4 ||
                positionalArgs[0] is! String ||
                positionalArgs[1] is! int ||
                positionalArgs[2] is! int ||
                positionalArgs[3] is! bool) {
              throw RuntimeD4rtException(
                  'StringConversionSink.addSlice requires arguments (String, int, int, bool).');
            }
            (target as StringConversionSink).addSlice(
                positionalArgs[0] as String,
                positionalArgs[1] as int,
                positionalArgs[2] as int,
                positionalArgs[3] as bool);
            return null;
          },
          'close': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isNotEmpty || namedArgs.isNotEmpty) {
              throw RuntimeD4rtException(
                  'StringConversionSink.close takes no arguments.');
            }
            (target as StringConversionSink).close();
            return null;
          },
          // The idiomatic route to a `ClosableStringSink`: it hands back a
          // `_ClosableStringSink`, which the ClosableStringSink bridge routes.
          'asStringSink': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isNotEmpty || namedArgs.isNotEmpty) {
              throw RuntimeD4rtException(
                  'StringConversionSink.asStringSink takes no arguments.');
            }
            return (target as StringConversionSink).asStringSink();
          },
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as StringConversionSink).toString();
          },
        },
        getters: {
          'hashCode': (visitor, target) {
            return (target as StringConversionSink).hashCode;
          },
          'runtimeType': (visitor, target) {
            return (target as StringConversionSink).runtimeType;
          },
        },
      );
}
