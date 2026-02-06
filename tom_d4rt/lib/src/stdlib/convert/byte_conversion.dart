import 'dart:convert';
import 'package:tom_d4rt/d4rt.dart';

class ByteConversionConvert {
  static BridgedClass get definition => BridgedClass(
        nativeType: ByteConversionSink,
        name: 'ByteConversionSink',
        typeParameterCount: 0,
        staticMethods: {
          'from': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 ||
                positionalArgs[0] is! Sink<List<int>>) {
              throw RuntimeD4rtException(
                  'ByteConversionSink.from requires one Sink<List<int>> argument.');
            }
            return ByteConversionSink.from(
                positionalArgs[0] as Sink<List<int>>);
          },
          'withCallback': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 ||
                positionalArgs[0] is! InterpretedFunction) {
              throw RuntimeD4rtException(
                  'ByteConversionSink.withCallback requires one Function argument.');
            }
            final callback = positionalArgs[0] as InterpretedFunction;
            return ByteConversionSink.withCallback((accumulated) {
              callback.call(visitor, [accumulated]);
            });
          },
        },
        methods: {
          'add': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! List) {
              throw RuntimeD4rtException(
                  'ByteConversionSink.add requires one List<int> argument.');
            }
            (target as ByteConversionSink)
                .add((positionalArgs[0] as List).cast());
            return null;
          },
          'addSlice': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 4 ||
                positionalArgs[0] is! List ||
                positionalArgs[1] is! int ||
                positionalArgs[2] is! int ||
                positionalArgs[3] is! bool) {
              throw RuntimeD4rtException(
                  'ByteConversionSink.addSlice requires arguments (List, int, int, bool).');
            }
            (target as ByteConversionSink).addSlice(
                (positionalArgs[0] as List).cast(),
                positionalArgs[1] as int,
                positionalArgs[2] as int,
                positionalArgs[3] as bool);
            return null;
          },
          'close': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isNotEmpty || namedArgs.isNotEmpty) {
              throw RuntimeD4rtException(
                  'ByteConversionSink.close takes no arguments.');
            }
            (target as ByteConversionSink).close();
            return null;
          },
        },
        getters: {
          'hashCode': (visitor, target) =>
              (target as ByteConversionSink).hashCode,
          'runtimeType': (visitor, target) =>
              (target as ByteConversionSink).runtimeType,
        },
      );
}
