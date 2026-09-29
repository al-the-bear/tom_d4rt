import 'dart:convert';
import 'package:tom_d4rt/d4rt.dart';
import 'fuse_argument.dart';

class CodecConvert {
  static BridgedClass get definition => BridgedClass(
    nativeType: Codec,
    name: 'Codec',
    // SCE233 KEEP. Partly reached (scc24 SCD197 pins the fraction): the
    // concrete codecs declare most members, and the rest fall through to here.
    // `Codec` is extendable, and a codec that does not override a member is
    // answered here.
    typeParameterCount: 2, // Codec<S, T>
    // `_FusedCodec` is what `Codec.fuse` returns; `_InvertedCodec` is what
    // `Codec.inverted` returns. SCC24 found the second one missing, which
    // is also why `inverted` had no test anywhere in the suite: the getter
    // returned successfully and the result was then inert, so there was
    // nothing to write a test about.
    nativeNames: ['_FusedCodec', '_InvertedCodec'],
    methods: {
      'encode': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException('Codec.encode requires one argument.');
        }
        return (target as Codec).encode(positionalArgs[0]);
      },
      'decode': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1) {
          throw RuntimeD4rtException('Codec.decode requires one argument.');
        }
        return (target as Codec).decode(positionalArgs[0]);
      },
      'fuse': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! Codec) {
          throw RuntimeD4rtException(
            fuseArgumentMessage(
              'Codec.fuse',
              'Codec',
              positionalArgs.isEmpty ? null : positionalArgs[0],
            ),
          );
        }
        return (target as Codec).fuse(positionalArgs[0] as Codec);
      },
    },
    getters: {
      'inverted': (visitor, target) => (target as Codec).inverted,
      'decoder': (visitor, target) => (target as Codec).decoder,
      'encoder': (visitor, target) => (target as Codec).encoder,
      'hashCode': (visitor, target) => (target as Codec).hashCode,
      'runtimeType': (visitor, target) => (target as Codec).runtimeType,
    },
  );
}
