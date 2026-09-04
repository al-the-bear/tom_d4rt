import 'dart:convert';

import 'package:tom_d4rt_ast/runtime.dart';

class EncodingConvert {
  static BridgedClass get definition => BridgedClass(
    nativeType: Encoding,
    name: 'Encoding',
    typeParameterCount: 0,
    staticMethods: {
      'getByName': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
          throw RuntimeD4rtException(
            'Encoding.getByName requires one String argument (name).',
          );
        }
        return Encoding.getByName(positionalArgs[0] as String);
      },
    },
    methods: {
      'encode': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
          throw RuntimeD4rtException(
            'Encoding.encode requires one String argument.',
          );
        }
        return (target as Encoding).encode(positionalArgs[0] as String);
      },
      'decode': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! List) {
          throw RuntimeD4rtException(
            'Encoding.decode requires one List<int> argument.',
          );
        }
        return (target as Encoding).decode((positionalArgs[0] as List).cast());
      },
      'inverted': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Encoding).inverted;
      },
      // SCB23: the one member of this bridge that the three character
      // encodings cannot declare for themselves — the SDK puts it on
      // `Encoding` only. It is reachable on `utf8`/`ascii`/`latin1` through
      // the supertype walk, which is why the edges in
      // `ConvertHierarchyConvert` and this adapter are one change.
      'decodeStream': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! Stream) {
          throw RuntimeD4rtException(
            'Encoding.decodeStream requires one Stream<List<int>> argument.',
          );
        }
        // `Stream.cast<List<int>>()` is NOT enough: the interpreter hands
        // over a `Stream` of `List<Object?>` chunks, and casting the
        // ELEMENT to `List<int>` fails on the first chunk. Each chunk has
        // to be cast in turn, which is the same thing `decode` above does
        // to its single list.
        final byteStream = (positionalArgs[0] as Stream).map<List<int>>((
          chunk,
        ) {
          if (chunk is! List) {
            throw RuntimeD4rtException(
              'Encoding.decodeStream requires a Stream of List<int> '
              'chunks; got ${chunk.runtimeType}.',
            );
          }
          return chunk.cast<int>();
        });
        return (target as Encoding).decodeStream(byteStream);
      },
      'fuse': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 ||
            positionalArgs[0] is! Codec<List<int>, dynamic>) {
          throw RuntimeD4rtException(
            'Encoding.fuse requires another Codec<List<int>, dynamic> as argument.',
          );
        }
        return (target as Encoding).fuse(
          positionalArgs[0] as Codec<List<int>, dynamic>,
        );
      },
    },
    getters: {
      'name': (visitor, target) {
        return (target as Encoding).name;
      },
      'decoder': (visitor, target) {
        return (target as Encoding).decoder;
      },
      'encoder': (visitor, target) {
        return (target as Encoding).encoder;
      },
      'hashCode': (visitor, target) {
        return (target as Encoding).hashCode;
      },
      'runtimeType': (visitor, target) {
        return (target as Encoding).runtimeType;
      },
    },
  );
}
