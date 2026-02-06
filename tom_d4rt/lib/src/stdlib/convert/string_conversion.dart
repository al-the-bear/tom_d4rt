import 'dart:convert';
import 'package:tom_d4rt/d4rt.dart';

class StringConversionConvert {
  static BridgedClass get definition => BridgedClass(
        nativeType: StringConversionSink,
        name: 'StringConversionSink',
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
