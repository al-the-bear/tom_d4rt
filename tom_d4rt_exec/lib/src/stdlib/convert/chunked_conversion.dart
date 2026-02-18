import 'dart:convert';
import 'package:tom_d4rt_exec/d4rt.dart';

class ChunkedConversionConvert {
  static BridgedClass get definition => BridgedClass(
        nativeType: ChunkedConversionSink,
        name: 'ChunkedConversionSink',
        typeParameterCount: 1,
        staticMethods: {
          'withCallback': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 ||
                positionalArgs[0] is! InterpretedFunction) {
              throw RuntimeD4rtException(
                  'ChunkedConversionSink.withCallback requires an Function callback.');
            }
            final callback = positionalArgs[0] as InterpretedFunction;
            return ChunkedConversionSink<dynamic>.withCallback(
                (List<dynamic> chunks) {
              callback.call(visitor, [chunks]);
            });
          },
        },
        methods: {
          'add': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1) {
              throw RuntimeD4rtException(
                  'ChunkedConversionSink.add requires one argument.');
            }
            (target as ChunkedConversionSink).add(positionalArgs[0]);
            return null;
          },
          'close': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isNotEmpty || namedArgs.isNotEmpty) {
              throw RuntimeD4rtException(
                  'ChunkedConversionSink.close takes no arguments.');
            }
            (target as ChunkedConversionSink).close();
            return null;
          },
        },
        getters: {},
      );
}
