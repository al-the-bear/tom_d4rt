import 'dart:convert';
import 'package:tom_d4rt_ast/runtime.dart';
import '../coerce_elements.dart';

class UriCore {
  static BridgedClass get definition => BridgedClass(
    nativeType: Uri,
    name: 'Uri',
    isAssignable: (v) => v is Uri,
    typeParameterCount: 0,
    nativeNames: ['_SimpleUri'],
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        return Uri(
          scheme: namedArgs['scheme'] as String?,
          userInfo: namedArgs['userInfo'] as String?,
          host: namedArgs['host'] as String?,
          port: namedArgs['port'] as int?,
          path: namedArgs['path'] as String?,
          pathSegments: coerceElementsOrNull<String>(
            namedArgs['pathSegments'],
            'Uri.pathSegments',
          ),
          query: namedArgs['query'] as String?,
          queryParameters: coerceMapArg<String, dynamic>(
            namedArgs['queryParameters'],
            'Uri.queryParameters',
          ),
          fragment: namedArgs['fragment'] as String?,
        );
      },
      'http': (visitor, positionalArgs, namedArgs) {
        final host = positionalArgs[0] as String;
        final path = positionalArgs.length > 1
            ? positionalArgs[1] as String
            : '';
        return Uri.http(host, path, positionalArgs.get<Map?>(2)?.cast());
      },
      'https': (visitor, positionalArgs, namedArgs) {
        final host = positionalArgs[0] as String;
        final path = positionalArgs.length > 1
            ? positionalArgs[1] as String
            : '';

        return Uri.https(host, path, positionalArgs.get<Map?>(2)?.cast());
      },
      'file': (visitor, positionalArgs, namedArgs) {
        final path = positionalArgs[0] as String;
        final windows = namedArgs['windows'] as bool?;
        return Uri.file(path, windows: windows);
      },
      'directory': (visitor, positionalArgs, namedArgs) {
        final path = positionalArgs[0] as String;
        final windows = namedArgs['windows'] as bool?;
        return Uri.directory(path, windows: windows);
      },
      'dataFromBytes': (visitor, positionalArgs, namedArgs) {
        return Uri.dataFromBytes(
          (positionalArgs[0] as List).cast(),
          mimeType:
              positionalArgs.get<String?>(1) ?? 'application/octet-stream',
          parameters: positionalArgs.get<Map?>(2)?.cast(),
          percentEncoded: positionalArgs.get<bool?>(3) ?? false,
        );
      },
      'dataFromString': (visitor, positionalArgs, namedArgs) {
        return Uri.dataFromString(
          positionalArgs[0] as String,
          mimeType: namedArgs.get<String?>('mimeType'),
          parameters: (namedArgs.get<Map?>(
            'parameters',
          ))?.cast<String, String>(),
          encoding: namedArgs.get<Encoding?>('encoding') ?? utf8,
          base64: namedArgs.get<bool?>('base64') ?? false,
        );
      },
    },
    // `Uri.base` is the only route to the process's own working directory as
    // a Uri, and statics get no supertype fallback, so its absence was a
    // hard failure on an otherwise complete class.
    staticGetters: {'base': (visitor) => Uri.base},
    staticMethods: {
      // SCE110: `start` and `end` are optional POSITIONAL parameters of
      // `Uri.parse(String uri, [int start = 0, int? end])`, not named ones.
      // Read as named they were unreachable — the only spelling that would
      // have filled them is one Dart refuses to compile — so the legal call
      // silently used the defaults. Same shape as SCD68's `FormatException`.
      'parse': (visitor, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Uri.parse', atMost: 3);
        final start = positionalArgs.length > 1 ? positionalArgs[1] as int : 0;
        final end = positionalArgs.length > 2
            ? positionalArgs[2] as int?
            : null;
        return Uri.parse(positionalArgs[0] as String, start, end);
      },
      // SCE110: positional, as on `parse` above.
      'tryParse': (visitor, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Uri.tryParse', atMost: 3);
        final start = positionalArgs.length > 1 ? positionalArgs[1] as int : 0;
        final end = positionalArgs.length > 2
            ? positionalArgs[2] as int?
            : null;
        return Uri.tryParse(positionalArgs[0] as String, start, end);
      },
      'parseIPv4Address': (visitor, positionalArgs, namedArgs, _) {
        return Uri.parseIPv4Address(positionalArgs[0] as String);
      },
      // SCE110: positional, as on `parse` above.
      'parseIPv6Address': (visitor, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Uri.parseIPv6Address', atMost: 3);
        final start = positionalArgs.length > 1 ? positionalArgs[1] as int : 0;
        final end = positionalArgs.length > 2
            ? positionalArgs[2] as int?
            : null;
        return Uri.parseIPv6Address(positionalArgs[0] as String, start, end);
      },
      'encodeComponent': (visitor, positionalArgs, namedArgs, _) {
        return Uri.encodeComponent(positionalArgs[0] as String);
      },
      'encodeQueryComponent': (visitor, positionalArgs, namedArgs, _) {
        final encoding = namedArgs['encoding'] as Encoding? ?? utf8;
        return Uri.encodeQueryComponent(
          positionalArgs[0] as String,
          encoding: encoding,
        );
      },
      'decodeComponent': (visitor, positionalArgs, namedArgs, _) {
        return Uri.decodeComponent(positionalArgs[0] as String);
      },
      'decodeQueryComponent': (visitor, positionalArgs, namedArgs, _) {
        final encoding = namedArgs['encoding'] as Encoding? ?? utf8;
        return Uri.decodeQueryComponent(
          positionalArgs[0] as String,
          encoding: encoding,
        );
      },
      'encodeFull': (visitor, positionalArgs, namedArgs, _) {
        return Uri.encodeFull(positionalArgs[0] as String);
      },
      'decodeFull': (visitor, positionalArgs, namedArgs, _) {
        return Uri.decodeFull(positionalArgs[0] as String);
      },
      'splitQueryString': (visitor, positionalArgs, namedArgs, _) {
        final encoding = namedArgs['encoding'] as Encoding? ?? utf8;
        return Uri.splitQueryString(
          positionalArgs[0] as String,
          encoding: encoding,
        );
      },
    },
    methods: {
      // SCD77: `isScheme` is `bool isScheme(String)` in the SDK and was
      // registered as a getter returning the tear-off. Scripts were unaffected —
      // the interpreter's property-access-then-call path made
      // `uri.isScheme('https')` work, and still does, because a bridged METHOD
      // also tears off. What it cost was the SCC24 sweep: a getter whose value
      // is a function resolves to no bridge, so the entry had to be exempted,
      // and an exemption is a member the sweep cannot check.
      'isScheme': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Uri).isScheme(positionalArgs[0] as String);
      },
      'replace': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Uri).replace(
          scheme: namedArgs['scheme'] as String?,
          userInfo: namedArgs['userInfo'] as String?,
          host: namedArgs['host'] as String?,
          port: namedArgs['port'] as int?,
          path: namedArgs['path'] as String?,
          pathSegments: coerceElementsOrNull<String>(
            namedArgs['pathSegments'],
            'Uri.pathSegments',
          ),
          query: namedArgs['query'] as String?,
          queryParameters: coerceMapArg<String, dynamic>(
            namedArgs['queryParameters'],
            'Uri.queryParameters',
          ),
          fragment: namedArgs['fragment'] as String?,
        );
      },
      'removeFragment': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Uri).removeFragment();
      },
      'resolve': (visitor, target, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Uri.resolve', atMost: 1);
        return (target as Uri).resolve(positionalArgs[0] as String);
      },
      'resolveUri': (visitor, target, positionalArgs, namedArgs, _) {
        D4.checkArity(positionalArgs, 'Uri.resolveUri', atMost: 1);
        return (target as Uri).resolveUri(positionalArgs[0] as Uri);
      },
      'toFilePath': (visitor, target, positionalArgs, namedArgs, _) {
        final windows = namedArgs['windows'] as bool?;
        return (target as Uri).toFilePath(windows: windows);
      },
      'toString': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Uri).toString();
      },
      'normalizePath': (visitor, target, positionalArgs, namedArgs, _) {
        return (target as Uri).normalizePath();
      },
    },
    getters: {
      'scheme': (visitor, target) => (target as Uri).scheme,
      'data': (visitor, target) => (target as Uri).data,
      'authority': (visitor, target) => (target as Uri).authority,
      'userInfo': (visitor, target) => (target as Uri).userInfo,
      'host': (visitor, target) => (target as Uri).host,
      'port': (visitor, target) => (target as Uri).port,
      'path': (visitor, target) => (target as Uri).path,
      'query': (visitor, target) => (target as Uri).query,
      'fragment': (visitor, target) => (target as Uri).fragment,
      'pathSegments': (visitor, target) => (target as Uri).pathSegments,
      'queryParameters': (visitor, target) => (target as Uri).queryParameters,
      'queryParametersAll': (visitor, target) =>
          (target as Uri).queryParametersAll,
      'isAbsolute': (visitor, target) => (target as Uri).isAbsolute,
      'hasScheme': (visitor, target) => (target as Uri).hasScheme,
      'hasAuthority': (visitor, target) => (target as Uri).hasAuthority,
      'hasPort': (visitor, target) => (target as Uri).hasPort,
      'hasQuery': (visitor, target) => (target as Uri).hasQuery,
      'hasFragment': (visitor, target) => (target as Uri).hasFragment,
      'hasEmptyPath': (visitor, target) => (target as Uri).hasEmptyPath,
      'hasAbsolutePath': (visitor, target) => (target as Uri).hasAbsolutePath,
      'origin': (visitor, target) => (target as Uri).origin,
      'hashCode': (visitor, target) => (target as Uri).hashCode,
      'runtimeType': (visitor, target) => (target as Uri).runtimeType,
    },
  );
}
