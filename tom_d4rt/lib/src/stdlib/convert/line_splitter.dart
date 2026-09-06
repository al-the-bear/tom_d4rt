import 'dart:convert';
import 'package:tom_d4rt/d4rt.dart';

class LineSplitterConvert {
  static BridgedClass get definition => BridgedClass(
    nativeType: LineSplitter,
    name: 'LineSplitter',
    isAssignable: (v) => v is LineSplitter,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        return LineSplitter();
      },
    },
    staticMethods: {
      // `LineSplitter.split(text, [start, end])` — the offsets are what
      // distinguish this from `LineSplitter().convert(text)`; forwarding
      // only the string would look correct until a caller passed a second
      // argument.
      'split': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty ||
            positionalArgs.length > 3 ||
            namedArgs.isNotEmpty) {
          throw RuntimeD4rtException(
            'LineSplitter.split(text, [start, end]) expects one to three '
            'positional arguments.',
          );
        }
        final text = positionalArgs[0];
        if (text is! String) {
          throw RuntimeD4rtException(
            'The first argument to LineSplitter.split must be a String.',
          );
        }
        return LineSplitter.split(
          text,
          positionalArgs.length > 1 ? positionalArgs[1] as int : 0,
          positionalArgs.length > 2 ? positionalArgs[2] as int? : null,
        );
      },
    },
    methods: {
      'convert': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
          throw RuntimeD4rtException(
            'LineSplitter.convert requires one String argument.',
          );
        }
        return (target as LineSplitter).convert(positionalArgs[0] as String);
      },
      'startChunkedConversion':
          (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 ||
                positionalArgs[0] is! Sink<String>) {
              throw RuntimeD4rtException(
                'startChunkedConversion requires a Sink<String> argument.',
              );
            }
            return (target as LineSplitter).startChunkedConversion(
              positionalArgs[0] as Sink<String>,
            );
          },
      'bind': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! Stream) {
          throw RuntimeD4rtException(
            'LineSplitter.bind requires a Stream<String> argument.',
          );
        }
        return (target as LineSplitter).bind(
          D4.coerceStream<String>(positionalArgs[0], 'LineSplitter.bind'),
        );
      },
      'cast': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as LineSplitter).cast<String, List<String>>();
      },
    },
    getters: {
      'hashCode': (visitor, target) => (target as LineSplitter).hashCode,
      'runtimeType': (visitor, target) => (target as LineSplitter).runtimeType,
    },
  );
}
