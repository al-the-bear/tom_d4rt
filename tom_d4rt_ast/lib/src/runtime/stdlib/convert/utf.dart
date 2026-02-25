import 'dart:convert';
import 'package:tom_d4rt_ast/runtime.dart';

class Utf8CodecConvert {
  static BridgedClass get definition => BridgedClass(
        nativeType: Utf8Codec,
        name: 'Utf8Codec',
        typeParameterCount: 0,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            final allowMalformed =
                namedArgs['allowMalformed'] as bool? ?? false;
            return Utf8Codec(allowMalformed: allowMalformed);
          },
        },
        methods: {
          'encode': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Utf8Codec).encode(positionalArgs[0] as String);
          },
          'decode': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! List) {
              throw RuntimeD4rtException('Utf8Codec.decode requires a List argument.');
            }
            final allowMalformed = namedArgs['allowMalformed'] as bool?;
            return (target as Utf8Codec).decode(
                (positionalArgs[0] as List).cast(),
                allowMalformed: allowMalformed);
          },
          'fuse': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 ||
                positionalArgs[0] is! Codec<List<int>, dynamic>) {
              throw RuntimeD4rtException(
                  'Utf8Codec.fuse requires another Codec<List<int>, dynamic> as argument.');
            }
            return (target as Utf8Codec)
                .fuse(positionalArgs[0] as Codec<List<int>, dynamic>);
          },
        },
        getters: {
          'encoder': (visitor, target) => (target as Utf8Codec).encoder,
          'decoder': (visitor, target) => (target as Utf8Codec).decoder,
          'name': (visitor, target) => (target as Utf8Codec).name,
          'inverted': (visitor, target) => (target as Utf8Codec).inverted,
          'hashCode': (visitor, target) => (target as Utf8Codec).hashCode,
          'runtimeType': (visitor, target) => (target as Utf8Codec).runtimeType,
        },
      );
}

class Utf8EncoderConvert {
  static BridgedClass get definition => BridgedClass(
        nativeType: Utf8Encoder,
        name: 'Utf8Encoder',
        typeParameterCount: 0,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.isNotEmpty || namedArgs.isNotEmpty) {
              throw RuntimeD4rtException('Utf8Encoder constructor takes no arguments.');
            }
            return Utf8Encoder();
          },
        },
        methods: {
          'convert': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Utf8Encoder).convert(positionalArgs[0] as String);
          },
          'startChunkedConversion':
              (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 ||
                positionalArgs[0] is! Sink<List<int>>) {
              throw RuntimeD4rtException(
                  'startChunkedConversion requires a Sink<List<int>> argument.');
            }
            return (target as Utf8Encoder)
                .startChunkedConversion(positionalArgs[0] as Sink<List<int>>);
          },
          'bind': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 ||
                positionalArgs[0] is! Stream<String>) {
              throw RuntimeD4rtException('bind requires a Stream<String> argument.');
            }
            return (target as Utf8Encoder)
                .bind(positionalArgs[0] as Stream<String>);
          },
          'fuse': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 ||
                positionalArgs[0] is! Converter<List<int>, dynamic>) {
              throw RuntimeD4rtException(
                  'Utf8Encoder.fuse requires another Converter<List<int>, dynamic> as argument.');
            }
            return (target as Utf8Encoder)
                .fuse(positionalArgs[0] as Converter<List<int>, dynamic>);
          },
          'cast': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Utf8Encoder).cast<String, List<int>>();
          },
        },
        getters: {
          'hashCode': (visitor, target) => (target as Utf8Encoder).hashCode,
          'runtimeType': (visitor, target) =>
              (target as Utf8Encoder).runtimeType,
        },
      );
}

class Utf8DecoderConvert {
  static BridgedClass get definition => BridgedClass(
        nativeType: Utf8Decoder,
        name: 'Utf8Decoder',
        typeParameterCount: 0,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            final allowMalformed =
                namedArgs['allowMalformed'] as bool? ?? false;
            return Utf8Decoder(allowMalformed: allowMalformed);
          },
        },
        methods: {
          'convert': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! List) {
              throw RuntimeD4rtException(
                  'Utf8Decoder.convert requires a List argument.');
            }
            return (target as Utf8Decoder).convert(
                (positionalArgs[0] as List).cast(),
                positionalArgs.get<int?>(1) ?? 0,
                positionalArgs.get<int?>(2));
          },
          'startChunkedConversion':
              (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 ||
                positionalArgs[0] is! Sink<String>) {
              throw RuntimeD4rtException(
                  'startChunkedConversion requires a Sink<String> argument.');
            }
            return (target as Utf8Decoder)
                .startChunkedConversion(positionalArgs[0] as Sink<String>);
          },
          'bind': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 ||
                positionalArgs[0] is! Stream<List<int>>) {
              throw RuntimeD4rtException('bind requires a Stream<List<int>> argument.');
            }
            return (target as Utf8Decoder)
                .bind(positionalArgs[0] as Stream<List<int>>);
          },
          'fuse': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 ||
                positionalArgs[0] is! Converter<String, dynamic>) {
              throw RuntimeD4rtException(
                  'Utf8Decoder.fuse requires another Converter<String, dynamic> as argument.');
            }
            return (target as Utf8Decoder)
                .fuse(positionalArgs[0] as Converter<String, dynamic>);
          },
          'cast': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as Utf8Decoder).cast<List<int>, String>();
          },
        },
        getters: {
          'hashCode': (visitor, target) => (target as Utf8Decoder).hashCode,
          'runtimeType': (visitor, target) =>
              (target as Utf8Decoder).runtimeType,
        },
      );
}
