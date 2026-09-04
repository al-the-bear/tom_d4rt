import 'dart:convert';
import 'package:tom_d4rt/d4rt.dart';

class ConverterConvert {
  static BridgedClass get definition => BridgedClass(
        nativeType: Converter,
        name: 'Converter',
        typeParameterCount: 2, // Converter<S, T>
        staticMethods: {
          // The static counterpart of the instance `cast()`: wraps an existing
          // converter so it accepts and produces different static types. Type
          // arguments are erased at the bridge boundary, so the native call is
          // instantiated at `dynamic` — the wrapper still delegates to the
          // same converter.
          'castFrom': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || namedArgs.isNotEmpty) {
              throw RuntimeD4rtException(
                  'Converter.castFrom(source) expects one positional '
                  'argument.');
            }
            final source = positionalArgs[0];
            if (source is! Converter) {
              throw RuntimeD4rtException(
                  'The argument to Converter.castFrom must be a Converter.');
            }
            return Converter.castFrom<dynamic, dynamic, dynamic, dynamic>(
                source);
          },
        },
        methods: {
          'convert': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Converter).convert(positionalArgs[0]);
          },
          'startChunkedConversion':
              (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! Sink) {
              throw RuntimeD4rtException(
                  'startChunkedConversion requires one Sink argument.');
            }
            return (target as Converter)
                .startChunkedConversion(positionalArgs[0] as Sink);
          },
          'bind': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! Stream) {
              throw RuntimeD4rtException('bind requires one Stream argument.');
            }
            return (target as Converter).bind(positionalArgs[0] as Stream);
          },
          'fuse': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! Converter) {
              throw RuntimeD4rtException(
                  'fuse requires another Converter as argument.');
            }
            return (target as Converter).fuse(positionalArgs[0] as Converter);
          },
          'cast': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Converter).cast<dynamic, dynamic>();
          },
        },
        getters: {
          'hashCode': (visitor, target) => (target as Converter).hashCode,
          'runtimeType': (visitor, target) => (target as Converter).runtimeType,
        },
      );
}
