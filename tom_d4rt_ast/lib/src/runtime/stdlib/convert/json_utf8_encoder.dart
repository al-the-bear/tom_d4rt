import 'dart:convert';

import 'package:tom_d4rt_ast/runtime.dart';

/// `JsonUtf8Encoder` (dart:convert) — object to UTF-8 JSON bytes in one pass.
///
/// **This bridge repairs a path that already existed.** The SDK specialises
/// `JsonEncoder.fuse`: fusing a `JsonEncoder` with a `Utf8Encoder` does not
/// build a generic `_FusedConverter`, it returns a `JsonUtf8Encoder`. The
/// `JsonEncoder` bridge has always exposed `fuse`, so interpreted code could
/// reach this type — and then hit `Undefined property or method 'convert' on
/// JsonUtf8Encoder`, because nothing was registered under that name. Adding
/// the class therefore closes a live dead end, not just a gap in coverage.
///
/// Unlike most recent bridges this needs no `nativeNames`: the class is
/// concrete and public, so `runtimeType` is `JsonUtf8Encoder` itself.
class JsonUtf8EncoderConvert {
  static BridgedClass get definition => BridgedClass(
        nativeType: JsonUtf8Encoder,
        name: 'JsonUtf8Encoder',
        isAssignable: (v) => v is JsonUtf8Encoder,
        typeParameterCount: 0,
        constructors: {
          // `JsonUtf8Encoder([String? indent, Object? toEncodable(Object?)?,
          // int? bufferSize])` — three optional positionals. Passing `null` for
          // `indent` is meaningful (it selects compact output), so the
          // arguments are read by position rather than by presence.
          '': (visitor, positionalArgs, namedArgs) {
            final indent = positionalArgs.isNotEmpty ? positionalArgs[0] : null;
            if (indent != null && indent is! String) {
              throw RuntimeD4rtException(
                  'JsonUtf8Encoder indent must be a String or null.');
            }
            final toEncodable =
                positionalArgs.length > 1 ? positionalArgs[1] : null;
            if (toEncodable != null && toEncodable is! InterpretedFunction) {
              throw RuntimeD4rtException(
                  'JsonUtf8Encoder toEncodable must be a Function or null.');
            }
            final bufferSize =
                positionalArgs.length > 2 ? positionalArgs[2] : null;
            if (bufferSize != null && bufferSize is! int) {
              throw RuntimeD4rtException(
                  'JsonUtf8Encoder bufferSize must be an int or null.');
            }
            return JsonUtf8Encoder(
              indent as String?,
              toEncodable == null
                  ? null
                  : (object) =>
                      (toEncodable as InterpretedFunction).call(visitor, [object]),
              // The SDK default is 256; `null` is not accepted for this one.
              bufferSize as int? ?? 256,
            );
          },
        },
        methods: {
          'convert': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1) {
              throw RuntimeD4rtException(
                  'JsonUtf8Encoder.convert requires one argument (the object).');
            }
            return (target as JsonUtf8Encoder).convert(positionalArgs[0]);
          },
          'startChunkedConversion':
              (visitor, target, positionalArgs, namedArgs, _) {
            final sink = positionalArgs.isNotEmpty ? positionalArgs[0] : null;
            if (sink is! Sink<List<int>>) {
              throw RuntimeD4rtException(
                  'JsonUtf8Encoder.startChunkedConversion requires a '
                  'Sink<List<int>> argument.');
            }
            return (target as JsonUtf8Encoder).startChunkedConversion(sink);
          },
          'fuse': (visitor, target, positionalArgs, namedArgs, _) {
            final other = positionalArgs.isNotEmpty ? positionalArgs[0] : null;
            if (other is! Converter<List<int>, dynamic>) {
              throw RuntimeD4rtException(
                  'JsonUtf8Encoder.fuse requires a Converter<List<int>, dynamic> '
                  'argument.');
            }
            return (target as JsonUtf8Encoder).fuse(other);
          },
          'bind': (visitor, target, positionalArgs, namedArgs, _) {
            final stream = positionalArgs.isNotEmpty ? positionalArgs[0] : null;
            if (stream is! Stream<Object?>) {
              throw RuntimeD4rtException(
                  'JsonUtf8Encoder.bind requires a Stream argument.');
            }
            return (target as JsonUtf8Encoder).bind(stream);
          },
          'cast': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as JsonUtf8Encoder).cast<Object?, List<int>>();
          },
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as JsonUtf8Encoder).toString();
          },
        },
        getters: {
          'hashCode': (visitor, target) => (target as JsonUtf8Encoder).hashCode,
          'runtimeType': (visitor, target) =>
              (target as JsonUtf8Encoder).runtimeType,
        },
      );
}
