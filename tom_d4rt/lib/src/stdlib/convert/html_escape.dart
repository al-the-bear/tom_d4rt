import 'dart:convert';
import 'package:tom_d4rt/d4rt.dart';

class HtmlEscapeConvert {
  static BridgedClass get definition => BridgedClass(
    nativeType: HtmlEscape,
    name: 'HtmlEscape',
    isAssignable: (v) => v is HtmlEscape,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        final mode = positionalArgs.isNotEmpty
            ? positionalArgs[0] as HtmlEscapeMode?
            : HtmlEscapeMode.unknown;
        return HtmlEscape(mode ?? HtmlEscapeMode.unknown);
      },
    },
    methods: {
      'convert': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! String) {
          throw RuntimeD4rtException(
            'HtmlEscape.convert requires a String argument.',
          );
        }
        return (target as HtmlEscape).convert(positionalArgs[0] as String);
      },
      'startChunkedConversion':
          (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 ||
                positionalArgs[0] is! Sink<String>) {
              throw RuntimeD4rtException(
                'startChunkedConversion requires a Sink<String> argument.',
              );
            }
            return (target as HtmlEscape).startChunkedConversion(
              positionalArgs[0] as Sink<String>,
            );
          },
      'bind': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 ||
            positionalArgs[0] is! Stream<String>) {
          throw RuntimeD4rtException(
            'bind requires a Stream<String> argument.',
          );
        }
        return (target as HtmlEscape).bind(positionalArgs[0] as Stream<String>);
      },
      'fuse': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 ||
            positionalArgs[0] is! Converter<String, dynamic>) {
          throw RuntimeD4rtException(
            'HtmlEscape.fuse requires another Converter<String, dynamic> as argument.',
          );
        }
        return (target as HtmlEscape).fuse(
          positionalArgs[0] as Converter<String, dynamic>,
        );
      },
      'cast': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as HtmlEscape).cast<String, String>();
      },
    },
    getters: {
      // Without `mode` a script can build an escaper but never inspect the
      // mode it was built with — the read half of a round trip the
      // constructor already advertises.
      'mode': (visitor, target) => (target as HtmlEscape).mode,
      'hashCode': (visitor, target) => (target as HtmlEscape).hashCode,
      'runtimeType': (visitor, target) => (target as HtmlEscape).runtimeType,
    },
  );

  static BridgedClass get modeDefinition => BridgedClass(
    nativeType: HtmlEscapeMode,
    name: 'HtmlEscapeMode',
    isAssignable: (v) => v is HtmlEscapeMode,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        return HtmlEscapeMode(
          name: namedArgs['name'] as String? ?? 'custom',
          escapeQuot: namedArgs['escapeQuot'] as bool? ?? false,
          escapeApos: namedArgs['escapeApos'] as bool? ?? false,
          escapeLtGt: namedArgs['escapeLtGt'] as bool? ?? false,
          escapeSlash: namedArgs['escapeSlash'] as bool? ?? false,
        );
      },
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as HtmlEscapeMode).toString(),
    },
    // The four named modes are `static const` on the SDK type, so they
    // belong in staticGetters. They previously sat in the instance `getters`
    // map, which made `HtmlEscapeMode.element` unresolvable and left the
    // HtmlEscape constructor taking a value no script could name.
    staticGetters: {
      'attribute': (visitor) => HtmlEscapeMode.attribute,
      'element': (visitor) => HtmlEscapeMode.element,
      'sqAttribute': (visitor) => HtmlEscapeMode.sqAttribute,
      'unknown': (visitor) => HtmlEscapeMode.unknown,
    },
    getters: {
      // The escape flags are the whole of the type's public instance
      // surface (the name field is private — `toString` is the only read).
      'escapeQuot': (visitor, target) => (target as HtmlEscapeMode).escapeQuot,
      'escapeApos': (visitor, target) => (target as HtmlEscapeMode).escapeApos,
      'escapeLtGt': (visitor, target) => (target as HtmlEscapeMode).escapeLtGt,
      'escapeSlash': (visitor, target) =>
          (target as HtmlEscapeMode).escapeSlash,
      'hashCode': (visitor, target) => (target as HtmlEscapeMode).hashCode,
      'runtimeType': (visitor, target) =>
          (target as HtmlEscapeMode).runtimeType,
    },
  );

  static void register(Environment environment) {
    environment.defineBridge(definition);
    environment.defineBridge(modeDefinition);

    // Define the default instance
    environment.define('htmlEscape', htmlEscape);
  }
}
