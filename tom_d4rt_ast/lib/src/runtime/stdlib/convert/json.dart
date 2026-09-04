import 'dart:convert';
import 'package:tom_d4rt_ast/runtime.dart';

class JsonCodecConvert {
  static BridgedClass get definition => BridgedClass(
    nativeType: JsonCodec,
    name: 'JsonCodec',
    isAssignable: (v) => v is JsonCodec,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        final reviverArg = namedArgs['reviver'] as InterpretedFunction?;
        final toEncodableArg = namedArgs['toEncodable'] as InterpretedFunction?;

        return JsonCodec(
          reviver: reviverArg == null
              ? null
              : (key, value) => reviverArg.call(visitor, [key, value]),
          toEncodable: toEncodableArg == null
              ? null
              : (object) => toEncodableArg.call(visitor, [object]),
        );
      },
      // `JsonCodec.withReviver(dynamic Function(Object?, Object?) reviver)`
      // — one REQUIRED positional. Unlike the default constructor's
      // `reviver:` named argument, null is not a legal value here, so this
      // rejects a missing or non-function argument outright rather than
      // falling back to a reviver-less codec.
      'withReviver': (visitor, positionalArgs, namedArgs) {
        final reviver = positionalArgs.isNotEmpty ? positionalArgs[0] : null;
        if (reviver is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'JsonCodec.withReviver reviver must be a Function '
            '(key, value).',
          );
        }
        return JsonCodec.withReviver(
          (key, value) => reviver.call(visitor, [key, value]),
        );
      },
    },
    methods: {
      'encode': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as JsonCodec).encode(positionalArgs[0]);
      },
      'decode': (visitor, target, positionalArgs, namedArgs, _) {
        final source = positionalArgs[0] as String;
        final reviverArg =
            namedArgs['reviver'] as InterpretedFunction? ??
            (positionalArgs.length > 1
                ? positionalArgs[1] as InterpretedFunction?
                : null);
        return (target as JsonCodec).decode(
          source,
          reviver: reviverArg == null
              ? null
              : (key, value) => reviverArg.call(visitor, [key, value]),
        );
      },
      'fuse': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 ||
            positionalArgs[0] is! Codec<String, dynamic>) {
          throw RuntimeD4rtException(
            'JsonCodec.fuse requires another Codec<String, dynamic> as argument.',
          );
        }
        return (target as JsonCodec).fuse(
          positionalArgs[0] as Codec<String, dynamic>,
        );
      },
    },
    getters: {
      'encoder': (visitor, target) => (target as JsonCodec).encoder,
      'decoder': (visitor, target) => (target as JsonCodec).decoder,
      'inverted': (visitor, target) => (target as JsonCodec).inverted,
    },
  );
}

class JsonEncoderConvert {
  static BridgedClass get definition => BridgedClass(
    nativeType: JsonEncoder,
    name: 'JsonEncoder',
    isAssignable: (v) => v is JsonEncoder,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        final toEncodableArg = positionalArgs.isNotEmpty
            ? positionalArgs[0] as InterpretedFunction?
            : null;
        return JsonEncoder(
          toEncodableArg == null
              ? null
              : (object) => toEncodableArg.call(visitor, [object]),
        );
      },
      // `JsonEncoder.withIndent(String? indent,
      //  [Object? toEncodable(Object?)?])` — the ordinary way to ask for
      // pretty-printed JSON. `indent` is positionally REQUIRED in the SDK
      // even though its type is nullable, and passing `null` is meaningful
      // (it selects compact output). Presence and nullness are therefore
      // distinct cases and both are checked: a missing argument is an
      // error, an explicit null is not.
      'withIndent': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.isEmpty) {
          throw RuntimeD4rtException(
            'JsonEncoder.withIndent requires the indent argument '
            '(a String, or null for compact output).',
          );
        }
        final indent = positionalArgs[0];
        if (indent != null && indent is! String) {
          throw RuntimeD4rtException(
            'JsonEncoder.withIndent indent must be a String or null.',
          );
        }
        final toEncodable = positionalArgs.length > 1
            ? positionalArgs[1]
            : null;
        if (toEncodable != null && toEncodable is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'JsonEncoder.withIndent toEncodable must be a Function '
            'or null.',
          );
        }
        return JsonEncoder.withIndent(
          indent as String?,
          toEncodable == null
              ? null
              : (object) => (toEncodable as InterpretedFunction).call(visitor, [
                  object,
                ]),
        );
      },
    },
    methods: {
      'convert': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as JsonEncoder).convert(positionalArgs[0]);
      },
      'fuse': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 ||
            positionalArgs[0] is! Converter<String, dynamic>) {
          throw RuntimeD4rtException(
            'JsonEncoder.fuse requires another Converter<String, dynamic> as argument.',
          );
        }
        return (target as JsonEncoder).fuse(
          positionalArgs[0] as Converter<String, dynamic>,
        );
      },
      'startChunkedConversion':
          (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 ||
                positionalArgs[0] is! Sink<String>) {
              throw RuntimeD4rtException(
                'startChunkedConversion requires a Sink<String> argument.',
              );
            }
            return (target as JsonEncoder).startChunkedConversion(
              positionalArgs[0] as Sink<String>,
            );
          },
      'bind': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 ||
            positionalArgs[0] is! Stream<dynamic>) {
          throw RuntimeD4rtException(
            'bind requires a Stream<dynamic> argument.',
          );
        }
        return (target as JsonEncoder).bind(
          positionalArgs[0] as Stream<dynamic>,
        );
      },
      'cast': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as JsonEncoder).cast<dynamic, String>();
      },
    },
    getters: {
      // `final String? indent` is public on the SDK class; it was the only
      // instance field and the bridge exposed no getters at all, so a
      // script could construct an indented encoder but not ask what its
      // indent was.
      'indent': (visitor, target) => (target as JsonEncoder).indent,
    },
  );
}

class JsonDecoderConvert {
  static BridgedClass get definition => BridgedClass(
    nativeType: JsonDecoder,
    name: 'JsonDecoder',
    isAssignable: (v) => v is JsonDecoder,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        final reviverArg = positionalArgs.isNotEmpty
            ? positionalArgs[0] as InterpretedFunction?
            : null;
        return JsonDecoder(
          reviverArg == null
              ? null
              : (key, value) => reviverArg.call(visitor, [key, value]),
        );
      },
    },
    methods: {
      'convert': (visitor, target, positionalArgs, namedArgs, _) {
        final source = positionalArgs[0] as String;
        return (target as JsonDecoder).convert(source);
      },
      'fuse': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 ||
            positionalArgs[0] is! Converter<dynamic, dynamic>) {
          throw RuntimeD4rtException(
            'JsonDecoder.fuse requires another Converter<dynamic, dynamic> as argument.',
          );
        }
        return (target as JsonDecoder).fuse(
          positionalArgs[0] as Converter<dynamic, dynamic>,
        );
      },
      'startChunkedConversion':
          (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 ||
                positionalArgs[0] is! Sink<dynamic>) {
              throw RuntimeD4rtException(
                'startChunkedConversion requires a Sink<dynamic> argument.',
              );
            }
            return (target as JsonDecoder).startChunkedConversion(
              positionalArgs[0] as Sink<dynamic>,
            );
          },
      'bind': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 ||
            positionalArgs[0] is! Stream<String>) {
          throw RuntimeD4rtException(
            'bind requires a Stream<String> argument.',
          );
        }
        return (target as JsonDecoder).bind(
          positionalArgs[0] as Stream<String>,
        );
      },
      'cast': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as JsonDecoder).cast<String, dynamic>();
      },
    },
    getters: {},
  );
}
