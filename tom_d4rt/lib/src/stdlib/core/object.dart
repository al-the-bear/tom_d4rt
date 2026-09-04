import 'package:tom_d4rt/d4rt.dart';

class ObjectCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: Object,
    name: 'Object',
    typeParameterCount: 0,
    constructors: {'': (visitor, positionalArgs, namedArgs) => Object()},
    staticMethods: {
      // Object.hash(o1, o2, [o3, ..., o20]) — added in Dart 2.14.
      // The native API takes 2..20 positional args; we forward by count to
      // preserve the exact hash combination semantics.
      'hash': (visitor, positionalArgs, namedArgs, _) {
        final args = positionalArgs;
        if (args.length < 2) {
          throw RuntimeD4rtException(
            'Object.hash requires at least 2 arguments.',
          );
        }
        switch (args.length) {
          case 2:
            return Object.hash(args[0], args[1]);
          case 3:
            return Object.hash(args[0], args[1], args[2]);
          case 4:
            return Object.hash(args[0], args[1], args[2], args[3]);
          case 5:
            return Object.hash(args[0], args[1], args[2], args[3], args[4]);
          case 6:
            return Object.hash(
              args[0],
              args[1],
              args[2],
              args[3],
              args[4],
              args[5],
            );
          case 7:
            return Object.hash(
              args[0],
              args[1],
              args[2],
              args[3],
              args[4],
              args[5],
              args[6],
            );
          case 8:
            return Object.hash(
              args[0],
              args[1],
              args[2],
              args[3],
              args[4],
              args[5],
              args[6],
              args[7],
            );
          case 9:
            return Object.hash(
              args[0],
              args[1],
              args[2],
              args[3],
              args[4],
              args[5],
              args[6],
              args[7],
              args[8],
            );
          case 10:
            return Object.hash(
              args[0],
              args[1],
              args[2],
              args[3],
              args[4],
              args[5],
              args[6],
              args[7],
              args[8],
              args[9],
            );
          case 11:
            return Object.hash(
              args[0],
              args[1],
              args[2],
              args[3],
              args[4],
              args[5],
              args[6],
              args[7],
              args[8],
              args[9],
              args[10],
            );
          case 12:
            return Object.hash(
              args[0],
              args[1],
              args[2],
              args[3],
              args[4],
              args[5],
              args[6],
              args[7],
              args[8],
              args[9],
              args[10],
              args[11],
            );
          case 13:
            return Object.hash(
              args[0],
              args[1],
              args[2],
              args[3],
              args[4],
              args[5],
              args[6],
              args[7],
              args[8],
              args[9],
              args[10],
              args[11],
              args[12],
            );
          case 14:
            return Object.hash(
              args[0],
              args[1],
              args[2],
              args[3],
              args[4],
              args[5],
              args[6],
              args[7],
              args[8],
              args[9],
              args[10],
              args[11],
              args[12],
              args[13],
            );
          case 15:
            return Object.hash(
              args[0],
              args[1],
              args[2],
              args[3],
              args[4],
              args[5],
              args[6],
              args[7],
              args[8],
              args[9],
              args[10],
              args[11],
              args[12],
              args[13],
              args[14],
            );
          case 16:
            return Object.hash(
              args[0],
              args[1],
              args[2],
              args[3],
              args[4],
              args[5],
              args[6],
              args[7],
              args[8],
              args[9],
              args[10],
              args[11],
              args[12],
              args[13],
              args[14],
              args[15],
            );
          case 17:
            return Object.hash(
              args[0],
              args[1],
              args[2],
              args[3],
              args[4],
              args[5],
              args[6],
              args[7],
              args[8],
              args[9],
              args[10],
              args[11],
              args[12],
              args[13],
              args[14],
              args[15],
              args[16],
            );
          case 18:
            return Object.hash(
              args[0],
              args[1],
              args[2],
              args[3],
              args[4],
              args[5],
              args[6],
              args[7],
              args[8],
              args[9],
              args[10],
              args[11],
              args[12],
              args[13],
              args[14],
              args[15],
              args[16],
              args[17],
            );
          case 19:
            return Object.hash(
              args[0],
              args[1],
              args[2],
              args[3],
              args[4],
              args[5],
              args[6],
              args[7],
              args[8],
              args[9],
              args[10],
              args[11],
              args[12],
              args[13],
              args[14],
              args[15],
              args[16],
              args[17],
              args[18],
            );
          case 20:
          default:
            return Object.hash(
              args[0],
              args[1],
              args[2],
              args[3],
              args[4],
              args[5],
              args[6],
              args[7],
              args[8],
              args[9],
              args[10],
              args[11],
              args[12],
              args[13],
              args[14],
              args[15],
              args[16],
              args[17],
              args[18],
              args[19],
            );
        }
      },
      'hashAll': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty) {
          throw RuntimeD4rtException(
            'Object.hashAll requires an Iterable argument.',
          );
        }
        final iter = positionalArgs[0] as Iterable;
        return Object.hashAll(iter);
      },
      'hashAllUnordered': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty) {
          throw RuntimeD4rtException(
            'Object.hashAllUnordered requires an Iterable argument.',
          );
        }
        final iter = positionalArgs[0] as Iterable;
        return Object.hashAllUnordered(iter);
      },
    },
    methods: {
      '==': (visitor, target, positionalArgs, namedArgs, _) {
        return target == positionalArgs[0];
      },
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return target.toString();
      },
    },
    getters: {
      'hashCode': (visitor, target) => target.hashCode,
      'runtimeType': (visitor, target) => target.runtimeType,
    },
  );
}
