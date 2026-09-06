import 'dart:async';
import 'dart:io';

import 'package:tom_d4rt_ast/runtime.dart';

import '../run_action.dart';
import '../stream_listen.dart';

/// The WebSocket block of `dart:io` — the last of the three unreachable
/// re-export groups SCB21's audit found.
///
/// Nothing here was bridged before: `WebSocket`, `WebSocketTransformer`,
/// `WebSocketException`, `WebSocketStatus` and `CompressionOptions` all failed
/// on first mention with `Undefined variable`. That is why the block could be
/// scoped last and closed in one go — unlike the server half, which was
/// half-built (a bridged `HttpServer` handing out unnameable values), there was
/// no partial state for a script to be stranded in.
///
/// **Its own file rather than more of `http.dart`.** The five classes form a
/// closed protocol surface that no other io bridge refers to, and `http.dart`
/// was already the largest file in the library. Registration still happens from
/// `IoHttpStdlib.register`, because the names arrive through the same
/// `dart:_http` re-export and splitting the registrar would make the import gate
/// two things to keep in step instead of one.

/// `WebSocketStatus` — the close codes, as a constants holder.
///
/// `abstract class WebSocketStatus` with no constructor and thirteen static
/// const ints, the same shape as `HttpStatus`: there are no instances, so
/// `isAssignable` would have nothing to answer for and is deliberately absent.
///
/// Every constant is bridged rather than the handful scripts commonly use. The
/// list is closed by the RFC and will not grow, so the cost of completeness is
/// paid once — whereas a partial holder fails at the one call site that needed
/// the code nobody anticipated, with a message about an undefined member on a
/// class that plainly exists.
class WebSocketStatusIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: WebSocketStatus,
    name: 'WebSocketStatus',
    typeParameterCount: 0,
    isAbstract: true,
    staticGetters: {
      'normalClosure': (visitor) => WebSocketStatus.normalClosure,
      'goingAway': (visitor) => WebSocketStatus.goingAway,
      'protocolError': (visitor) => WebSocketStatus.protocolError,
      'unsupportedData': (visitor) => WebSocketStatus.unsupportedData,
      'reserved1004': (visitor) => WebSocketStatus.reserved1004,
      'noStatusReceived': (visitor) => WebSocketStatus.noStatusReceived,
      'abnormalClosure': (visitor) => WebSocketStatus.abnormalClosure,
      'invalidFramePayloadData': (visitor) =>
          WebSocketStatus.invalidFramePayloadData,
      'policyViolation': (visitor) => WebSocketStatus.policyViolation,
      'messageTooBig': (visitor) => WebSocketStatus.messageTooBig,
      'missingMandatoryExtension': (visitor) =>
          WebSocketStatus.missingMandatoryExtension,
      'internalServerError': (visitor) => WebSocketStatus.internalServerError,
      'reserved1015': (visitor) => WebSocketStatus.reserved1015,
    },
  );
}

/// `CompressionOptions` — the per-message-deflate negotiation settings.
///
/// A real class with a public const constructor, unlike the other two
/// constant-carrying types in this file: `compressionDefault` and
/// `compressionOff` are instances a script can also build for itself, so both
/// the statics and the constructor are bridged.
///
/// The fields are read-only in the SDK (`final`), so there are no setters — a
/// script configures a connection by constructing a new value and passing it,
/// which is the shape `F-SCC63-19` exercises.
class CompressionOptionsIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: CompressionOptions,
    name: 'CompressionOptions',
    isAssignable: (v) => v is CompressionOptions,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) => CompressionOptions(
        clientNoContextTakeover:
            namedArgs['clientNoContextTakeover'] as bool? ?? false,
        serverNoContextTakeover:
            namedArgs['serverNoContextTakeover'] as bool? ?? false,
        clientMaxWindowBits: namedArgs['clientMaxWindowBits'] as int?,
        serverMaxWindowBits: namedArgs['serverMaxWindowBits'] as int?,
        enabled: namedArgs['enabled'] as bool? ?? true,
      ),
    },
    staticGetters: {
      'compressionDefault': (visitor) => CompressionOptions.compressionDefault,
      'compressionOff': (visitor) => CompressionOptions.compressionOff,
    },
    getters: {
      'clientNoContextTakeover': (visitor, target) =>
          (target as CompressionOptions).clientNoContextTakeover,
      'serverNoContextTakeover': (visitor, target) =>
          (target as CompressionOptions).serverNoContextTakeover,
      'clientMaxWindowBits': (visitor, target) =>
          (target as CompressionOptions).clientMaxWindowBits,
      'serverMaxWindowBits': (visitor, target) =>
          (target as CompressionOptions).serverMaxWindowBits,
      'enabled': (visitor, target) => (target as CompressionOptions).enabled,
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as CompressionOptions).toString(),
    },
  );
}

/// Reads the `compression:` named argument, defaulting the way the SDK does.
///
/// Three call sites take it (`WebSocket.connect`, `WebSocket.fromUpgradedSocket`
/// and `WebSocketTransformer.upgrade`) and the SDK's default is a *value*, not
/// null, so `?? null` would silently disable negotiation rather than leave it at
/// the default. Hoisted so the three cannot drift.
CompressionOptions _compressionArg(Map<String, Object?> namedArgs) =>
    namedArgs['compression'] as CompressionOptions? ??
    CompressionOptions.compressionDefault;

/// Wraps a script's `protocolSelector` for the SDK's `Function(List<String>)`.
///
/// Shared by the transformer's factory and its static `upgrade` for the same
/// reason as [_compressionArg]. The SDK accepts a `String` or a
/// `Future<String>` back, so the result is deliberately not narrowed here —
/// `runAction` returns whichever the script produced, and narrowing it would
/// reject the async form the SDK documents.
Function(List<String>)? _protocolSelectorArg(
  InterpreterVisitor visitor,
  Map<String, Object?> namedArgs,
) {
  final selector = namedArgs['protocolSelector'] as InterpretedFunction?;
  if (selector == null) return null;
  return (List<String> protocols) =>
      runAction<Object?>(visitor, selector, [protocols]);
}

/// Narrows a script value for `WebSocket.add`, which is `String|List<int>`.
///
/// A script's list literal is `List<dynamic>` at runtime, and the SDK's frame
/// writer casts to `List<int>` deep inside the socket write — so without this
/// the failure surfaces from the transport with no line number, on a value the
/// script had every right to pass. Strings go through untouched: the runtime
/// type is what picks the frame opcode, so coercing both arms to one shape
/// would make every binary frame arrive as text.
Object? _webSocketData(Object? data) =>
    data is List ? List<int>.from(data.toNativeList()) : data;

/// `WebSocket` — the two-way connection itself.
///
/// `abstract class WebSocket implements Stream<dynamic>, StreamSink<dynamic>`,
/// so this bridge carries both shapes. The supertype edges are declared in
/// `IoHierarchyIo` rather than left to the predicates: a `WebSocket` value
/// satisfies its own `isAssignable` and `StreamCore`'s at the same time, and
/// with nothing ordering them `_filterToMostSpecific` has no ground to drop the
/// base — so the edges are load-bearing for dispatch and not only for `is`.
///
/// `listen` routes through [bridgedStreamListen] rather than being written out
/// again, which is what stops this becoming the tenth hand-rolled copy SCC25
/// collapsed.
///
/// There are three ways to obtain one and all three are bridged: `connect` for
/// a client, `WebSocketTransformer.upgrade` for a server, and
/// `fromUpgradedSocket` for a caller that performed the handshake itself. The
/// deprecated zero-argument `WebSocket()` constructor is deliberately absent —
/// it exists upstream only so pre-2.0 code could `extends` the class, and
/// bridging it would make code runnable here that a current SDK rejects.
class WebSocketIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: WebSocket,
    name: 'WebSocket',
    isAssignable: (v) => v is WebSocket,
    typeParameterCount: 0,
    constructors: {
      'fromUpgradedSocket': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.isEmpty || positionalArgs[0] is! Socket) {
          throw RuntimeD4rtException(
            'WebSocket.fromUpgradedSocket requires a Socket argument.',
          );
        }
        // `serverSide` is passed through as the nullable it is declared to be,
        // rather than defaulted here: the SDK raises `ArgumentError` when it is
        // omitted, and supplying a default would silently pick a masking
        // behaviour for a caller who did not choose one.
        return WebSocket.fromUpgradedSocket(
          positionalArgs[0] as Socket,
          protocol: namedArgs['protocol'] as String?,
          serverSide: namedArgs['serverSide'] as bool?,
          compression: _compressionArg(namedArgs),
        );
      },
    },
    staticMethods: {
      'connect': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty || positionalArgs[0] is! String) {
          throw RuntimeD4rtException(
            'WebSocket.connect requires a url String argument.',
          );
        }
        final protocols = namedArgs['protocols'];
        return WebSocket.connect(
          positionalArgs[0] as String,
          protocols: protocols is Iterable
              ? List<String>.from(protocols.toList().toNativeList())
              : null,
          // `coerceMap`, not a cast: a map literal written in a script is a
          // `_Map<Object?, Object?>` whatever its entries hold, so `as
          // Map<String, dynamic>?` throws before `connect` is reached.
          headers: D4.coerceMapOrNull<String, dynamic>(
            namedArgs['headers'],
            'headers',
            visitor,
          ),
          compression: _compressionArg(namedArgs),
          customClient: namedArgs['customClient'] as HttpClient?,
        );
      },
    },
    staticGetters: {
      // The `readyState` values. They live on `WebSocket` and not on
      // `WebSocketStatus`, which reads backwards but is what the SDK does —
      // `WebSocketStatus` carries close codes, these carry connection state,
      // and the two sets never mix.
      'connecting': (visitor) => WebSocket.connecting,
      'open': (visitor) => WebSocket.open,
      'closing': (visitor) => WebSocket.closing,
      'closed': (visitor) => WebSocket.closed,
      'userAgent': (visitor) => WebSocket.userAgent,
    },
    staticSetters: {
      'userAgent': (visitor, value) {
        WebSocket.userAgent = value as String?;
        return;
      },
    },
    methods: {
      'listen': (visitor, target, positionalArgs, namedArgs, _) =>
          bridgedStreamListen(
            visitor,
            target as WebSocket,
            positionalArgs,
            namedArgs,
          ),
      'add': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty) {
          throw RuntimeD4rtException(
            'add requires a String or List<int> argument.',
          );
        }
        (target as WebSocket).add(_webSocketData(positionalArgs[0]));
        return null;
      },
      'addUtf8Text': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty || positionalArgs[0] is! List) {
          throw RuntimeD4rtException(
            'addUtf8Text requires a List<int> argument.',
          );
        }
        (target as WebSocket).addUtf8Text(
          List<int>.from((positionalArgs[0] as List).toNativeList()),
        );
        return null;
      },
      'addError': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty) {
          throw RuntimeD4rtException(
            'addError requires at least one argument (error).',
          );
        }
        (target as WebSocket).addError(
          positionalArgs[0]!,
          positionalArgs.length > 1 ? positionalArgs[1] as StackTrace? : null,
        );
        return null;
      },
      'addStream': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty || positionalArgs[0] is! Stream) {
          throw RuntimeD4rtException('addStream requires a Stream argument.');
        }
        return (target as WebSocket).addStream(
          positionalArgs[0] as Stream<Object?>,
        );
      },
      'close': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as WebSocket).close(
            positionalArgs.isNotEmpty ? positionalArgs[0] as int? : null,
            positionalArgs.length > 1 ? positionalArgs[1] as String? : null,
          ),
      'toString': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as WebSocket).toString(),
    },
    getters: {
      'readyState': (visitor, target) => (target as WebSocket).readyState,
      'extensions': (visitor, target) => (target as WebSocket).extensions,
      'protocol': (visitor, target) => (target as WebSocket).protocol,
      'closeCode': (visitor, target) => (target as WebSocket).closeCode,
      'closeReason': (visitor, target) => (target as WebSocket).closeReason,
      'pingInterval': (visitor, target) => (target as WebSocket).pingInterval,
      'done': (visitor, target) => (target as WebSocket).done,
    },
    setters: {
      // The one mutable member on the class. Nullable by contract — assigning
      // null is how a script turns keep-alive pings off — so the cast must be
      // `Duration?` and not `Duration`.
      'pingInterval': (visitor, target, value) {
        (target as WebSocket).pingInterval = value as Duration?;
        return;
      },
    },
  );
}

/// `WebSocketTransformer` — the server-side handshake.
///
/// The static `upgrade` is the member scripts actually use, and it is what makes
/// the whole block testable end to end: it takes an `HttpRequest`, which only
/// became a value a script could hold when SCC62 bridged that type. Before that
/// the server half of every WebSocket case would have had to be faked.
///
/// The instance side is bridged too, but thinly. `bind` is the
/// `StreamTransformer` surface, and its element type (`Stream<HttpRequest>` in,
/// `Stream<WebSocket>` out) is the shape `HttpServer.transform` consumes; the
/// factory exists so `bind` has something to be called on.
class WebSocketTransformerIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: WebSocketTransformer,
    name: 'WebSocketTransformer',
    isAssignable: (v) => v is WebSocketTransformer,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) => WebSocketTransformer(
        protocolSelector: _protocolSelectorArg(visitor, namedArgs),
        compression: _compressionArg(namedArgs),
      ),
    },
    staticMethods: {
      'upgrade': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty || positionalArgs[0] is! HttpRequest) {
          throw RuntimeD4rtException(
            'WebSocketTransformer.upgrade requires an HttpRequest argument.',
          );
        }
        return WebSocketTransformer.upgrade(
          positionalArgs[0] as HttpRequest,
          protocolSelector: _protocolSelectorArg(visitor, namedArgs),
          compression: _compressionArg(namedArgs),
        );
      },
      'isUpgradeRequest': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty || positionalArgs[0] is! HttpRequest) {
          throw RuntimeD4rtException(
            'WebSocketTransformer.isUpgradeRequest requires an HttpRequest '
            'argument.',
          );
        }
        return WebSocketTransformer.isUpgradeRequest(
          positionalArgs[0] as HttpRequest,
        );
      },
    },
    methods: {
      'bind': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty || positionalArgs[0] is! Stream) {
          throw RuntimeD4rtException('bind requires a Stream argument.');
        }
        return (target as WebSocketTransformer).bind(
          (positionalArgs[0] as Stream).cast<HttpRequest>(),
        );
      },
    },
  );
}

/// `WebSocketException` — what a failed handshake raises.
///
/// `class WebSocketException implements IOException`, and `isAssignable` is what
/// makes `on WebSocketException catch` work on the exception the *SDK* throws
/// rather than only on one the script constructed: a native exception reaches
/// the catch clause as a native object, and without the predicate no bridge
/// claims it. That is the whole reason to bridge an exception type — an
/// unresolvable name in a catch clause is not an error, it is a handler that
/// silently never matches.
///
/// `httpStatusCode` is the second positional parameter and is populated when the
/// server answered the upgrade with an ordinary HTTP response, which is the most
/// common way this is thrown in practice.
class WebSocketExceptionIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: WebSocketException,
    name: 'WebSocketException',
    isAssignable: (v) => v is WebSocketException,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) => WebSocketException(
        positionalArgs.isNotEmpty ? positionalArgs[0] as String? ?? '' : '',
        positionalArgs.length > 1 ? positionalArgs[1] as int? : null,
      ),
    },
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as WebSocketException).toString(),
    },
    getters: {
      'message': (visitor, target) => (target as WebSocketException).message,
      'httpStatusCode': (visitor, target) =>
          (target as WebSocketException).httpStatusCode,
    },
  );
}
