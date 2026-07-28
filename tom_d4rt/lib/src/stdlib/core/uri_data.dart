import 'dart:convert';

import 'package:tom_d4rt/d4rt.dart';

/// SC10: `dart:core` [UriData] — the payload of a `data:` URI.
///
/// `Uri.dataFromString` / `Uri.dataFromBytes` were already bridged, so without
/// this class the interpreter could produce a data URI it had no way to read
/// back. Pure parsing and codec work — no I/O, so no permission gate.
///
/// `contentAsString` takes an optional [Encoding]; `dart:convert` is bridged
/// and defines `utf8` / `latin1` / `ascii` as globals, so scripts can pass one
/// through directly.
class UriDataCore {
  static BridgedClass get definition => BridgedClass(
        nativeType: UriData,
        name: 'UriData',
        isAssignable: (v) => v is UriData,
        typeParameterCount: 0,
        constructors: {
          'fromString': (visitor, positionalArgs, namedArgs) {
            return UriData.fromString(
              positionalArgs[0] as String,
              mimeType: namedArgs.get<String?>('mimeType'),
              encoding: namedArgs.get<Encoding?>('encoding'),
              parameters:
                  namedArgs.get<Map?>('parameters')?.cast<String, String>(),
              base64: namedArgs.get<bool?>('base64') ?? false,
            );
          },
          'fromBytes': (visitor, positionalArgs, namedArgs) {
            return UriData.fromBytes(
              (positionalArgs[0] as List).cast<int>(),
              mimeType: namedArgs.get<String?>('mimeType') ??
                  'application/octet-stream',
              parameters:
                  namedArgs.get<Map?>('parameters')?.cast<String, String>(),
              percentEncoded: namedArgs.get<bool?>('percentEncoded') ?? false,
            );
          },
          'fromUri': (visitor, positionalArgs, namedArgs) {
            return UriData.fromUri(positionalArgs[0] as Uri);
          },
        },
        staticMethods: {
          'parse': (visitor, positionalArgs, namedArgs, typeArgs) {
            return UriData.parse(positionalArgs[0] as String);
          },
        },
        methods: {
          'contentAsBytes': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as UriData).contentAsBytes();
          },
          // The three predicates are how a script decides whether a data URI is
          // the shape it expects before decoding it. Without them the only
          // option was string-matching `mimeType` / `charset` by hand, which
          // gets the case- and parameter-normalisation rules wrong.
          'isMimeType': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as UriData).isMimeType(positionalArgs[0] as String);
          },
          'isCharset': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as UriData).isCharset(positionalArgs[0] as String);
          },
          'isEncoding': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as UriData)
                .isEncoding(positionalArgs[0] as Encoding);
          },
          'contentAsString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as UriData).contentAsString(
              encoding: namedArgs.get<Encoding?>('encoding'),
            );
          },
          'toString': (visitor, target, positionalArgs, namedArgs, _) {
            return (target as UriData).toString();
          },
        },
        getters: {
          'uri': (visitor, target) => (target as UriData).uri,
          'mimeType': (visitor, target) => (target as UriData).mimeType,
          'charset': (visitor, target) => (target as UriData).charset,
          'isBase64': (visitor, target) => (target as UriData).isBase64,
          'parameters': (visitor, target) => (target as UriData).parameters,
          'contentText': (visitor, target) => (target as UriData).contentText,
          'hashCode': (visitor, target) => (target as UriData).hashCode,
          'runtimeType': (visitor, target) => (target as UriData).runtimeType,
        },
      );
}
