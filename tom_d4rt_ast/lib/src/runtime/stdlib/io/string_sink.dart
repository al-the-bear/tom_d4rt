import 'dart:core';
import 'package:tom_d4rt_ast/runtime.dart';

/// Bridged implementation of dart:core StringSink
class StringSinkIo {
  static BridgedClass get definition => BridgedClass(
        nativeType: StringSink,
        name: 'StringSink',
        typeParameterCount: 0,
        methods: {
          'write': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty) {
              throw ArgumentD4rtException('StringSink.write requires object');
            }
            (target as StringSink).write(positionalArgs[0]);
            return null;
          },
          'writeln': (visitor, target, positionalArgs, namedArgs, _) {
            final obj = positionalArgs.isNotEmpty ? positionalArgs[0] : '';
            (target as StringSink).writeln(obj);
            return null;
          },
          'writeAll': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty) {
              throw ArgumentD4rtException('StringSink.writeAll requires objects');
            }
            final objects = positionalArgs[0] as Iterable;
            final separator =
                positionalArgs.length > 1 ? positionalArgs[1].toString() : '';
            (target as StringSink).writeAll(objects, separator);
            return null;
          },
          'writeCharCode': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty) {
              throw ArgumentD4rtException('StringSink.writeCharCode requires charCode');
            }
            (target as StringSink).writeCharCode(positionalArgs[0] as int);
            return null;
          },
        },
      );
}
