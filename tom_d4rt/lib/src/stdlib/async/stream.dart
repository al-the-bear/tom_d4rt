import 'dart:async';
import 'package:tom_d4rt/d4rt.dart';

import '../error_handler_args.dart';
import '../run_action.dart';
import '../stream_listen.dart';

/// Coerce a script-supplied transformer to a native [StreamTransformer].
///
/// Scripts reach `Stream.transform` from three directions: with a native
/// transformer built by `StreamTransformer.fromBind` (already native), with a
/// bridged one, and — the case `StreamTransformerBase` exists to enable — with
/// an [InterpretedInstance] of a script class that extends
/// `StreamTransformerBase` or implements `StreamTransformer`. The last shape
/// has no native object at all; its `bind` lives only in the interpreter, so
/// the only way to hand it to the SDK is to wrap the interpreted method in
/// `StreamTransformer.fromBind`.
///
/// Returns `null` when the value is not a transformer in any of those senses,
/// leaving the "what do I throw" decision to the call site.
StreamTransformer? _asStreamTransformer(
  InterpreterVisitor visitor,
  Object? value,
) {
  if (value is StreamTransformer) return value;
  if (value is BridgedInstance && value.nativeObject is StreamTransformer) {
    return value.nativeObject as StreamTransformer;
  }
  if (value is InterpretedInstance) {
    final bind = value.get('bind', visitor: visitor);
    if (bind is InterpretedFunction) {
      return StreamTransformer.fromBind(
        (stream) => runAction<Stream>(visitor, bind, [stream]) as Stream,
      );
    }
  }
  return null;
}

class StreamAsync {
  static BridgedClass get definition => BridgedClass(
    nativeType: Stream,
    name: 'Stream',
    typeParameterCount: 1,
    nativeNames: [
      // Public, unlike every other entry here: `StreamView` has its own
      // bridge for the constructor, but its instances must dispatch to
      // THIS bridge or they lose the whole inherited Stream surface. See
      // [StreamViewAsync] for the reasoning.
      'StreamView',
      '_MultiStream',
      '_ControllerStream',
      '_BroadcastStream',
      '_SingleSubscriptionStream',
      '_StreamIterator',
      '_EmptyStream',
      '_SingleStream',
      '_ErrorStream',
      '_PeriodicStream',
      '_FromIterableStream',
      '_ForwardingStream',
      // The stream `handleError` returns. Absent until SCB9, which made
      // every member of a handleError result fail with "Undefined property
      // or method ... on _HandleErrorStream" — and is why handleError's
      // own arity handling had never been exercised by a test.
      '_HandleErrorStream',
      '_AsBroadcastStream',
      '_StreamHandlerTransformer',
      '_BoundSinkStream',
      '_HandlerEventSink',
      '_TakeStream',
      '_MapStream',
      '_WhereStream',
      '_ExpandStream',
      '_SkipStream',
      '_TakeWhileStream',
      '_SkipWhileStream',
      '_DistinctStream',
      '_StdStream',
      // What `File.openRead()` returns. A `dart:io` private type, but it is
      // a Stream, so this bridge is the one that has to claim it. Missing
      // until SCC24: the single use of `openRead` in the suite passed the
      // result straight into `addStream` and so never called a member on
      // it, which is exactly the blind spot an inert value creates.
      '_FileStream',
    ],
    constructors: {},
    staticMethods: {
      'value': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty) {
          throw RuntimeD4rtException('Stream.value requires one argument.');
        }
        return Stream.value(positionalArgs[0]);
      },
      'error': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty) {
          throw RuntimeD4rtException(
            'Stream.error requires at least one argument.',
          );
        }
        final error = positionalArgs[0];
        if (error == null) {
          throw RuntimeD4rtException('Stream.error requires a non-null error.');
        }
        final stackTrace = positionalArgs.length > 1
            ? positionalArgs[1] as StackTrace?
            : null;
        return Stream.error(error, stackTrace);
      },
      'empty': (visitor, positionalArgs, namedArgs, _) {
        final broadcast = namedArgs['broadcast'] as bool? ?? true;
        return Stream.empty(broadcast: broadcast);
      },
      'fromIterable': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! Iterable) {
          throw RuntimeD4rtException(
            'Stream.fromIterable requires an Iterable argument.',
          );
        }
        return Stream.fromIterable(positionalArgs[0] as Iterable);
      },
      'periodic': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty || positionalArgs[0] is! Duration) {
          throw RuntimeD4rtException(
            'Stream.periodic requires a Duration argument.',
          );
        }
        final callback = positionalArgs.length > 1
            ? positionalArgs[1] as InterpretedFunction?
            : null;
        return Stream.periodic(
          positionalArgs[0] as Duration,
          callback == null ? null : (i) => runAction(visitor, callback, [i]),
        );
      },
      'fromFuture': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! Future) {
          throw RuntimeD4rtException(
            'Stream.fromFuture requires a Future argument.',
          );
        }
        return Stream.fromFuture(positionalArgs[0] as Future);
      },
      'fromFutures': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! Iterable) {
          throw RuntimeD4rtException(
            'Stream.fromFutures requires an Iterable argument.',
          );
        }
        return Stream.fromFutures((positionalArgs[0] as Iterable).cast());
      },
      'multi': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty ||
            positionalArgs[0] is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'Stream.multi requires an onListen function.',
          );
        }
        final onListen = positionalArgs[0] as InterpretedFunction;
        final isBroadcast = namedArgs['isBroadcast'] as bool? ?? false;
        return Stream.multi(
          (controller) => runAction<void>(visitor, onListen, [controller]),
          isBroadcast: isBroadcast,
        );
      },
      'eventTransformed': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.length < 2) {
          throw RuntimeD4rtException(
            'Stream.eventTransformed requires source and mapSink.',
          );
        }
        final source = positionalArgs[0] as Stream;
        final mapSink = positionalArgs[1] as InterpretedFunction;
        return Stream.eventTransformed(source, (sink) {
          runAction<void>(visitor, mapSink, [sink]);
          return sink;
        });
      },
      'castFrom': (visitor, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty) {
          throw RuntimeD4rtException(
            'Stream.castFrom requires a source stream.',
          );
        }
        return Stream.castFrom(positionalArgs[0] as Stream);
      },
    },
    methods: {
      'listen': (visitor, target, positionalArgs, namedArgs, _) =>
          bridgedStreamListen(
            visitor,
            target as Stream,
            positionalArgs,
            namedArgs,
          ),
      'map': (visitor, target, positionalArgs, namedArgs, _) {
        final mapper = positionalArgs[0];
        if (mapper is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'Stream.map requires an Function mapper argument.',
          );
        }
        return (target as Stream).map(
          (event) => runAction<dynamic>(visitor, mapper, [event]),
        );
      },
      'where': (visitor, target, positionalArgs, namedArgs, _) {
        final predicate = positionalArgs[0];
        if (predicate is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'Stream.where requires an Function predicate argument.',
          );
        }
        return (target as Stream).where((event) {
          final result = runAction<dynamic>(visitor, predicate, [event]);
          return result is bool && result;
        });
      },
      'expand': (visitor, target, positionalArgs, namedArgs, _) {
        final converter = positionalArgs[0];
        if (converter is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'Stream.expand requires an Function converter argument.',
          );
        }
        return (target as Stream).expand((event) {
          final result = runAction<dynamic>(visitor, converter, [event]);
          return result is Iterable ? result : const [];
        });
      },
      'transform': (visitor, target, positionalArgs, namedArgs, _) {
        final streamTransformer = _asStreamTransformer(
          visitor,
          positionalArgs.firstOrNull,
        );
        if (streamTransformer == null) {
          throw RuntimeD4rtException(
            'Stream.transform requires a StreamTransformer argument.',
          );
        }
        return (target as Stream).transform(streamTransformer);
      },
      'take': (visitor, target, positionalArgs, namedArgs, _) {
        final count = positionalArgs[0];
        if (count is! int) {
          throw RuntimeD4rtException(
            'Stream.take requires an integer count argument.',
          );
        }
        return (target as Stream).take(count);
      },
      'skip': (visitor, target, positionalArgs, namedArgs, _) {
        final count = positionalArgs[0];
        if (count is! int) {
          throw RuntimeD4rtException(
            'Stream.skip requires an integer count argument.',
          );
        }
        return (target as Stream).skip(count);
      },
      'takeWhile': (visitor, target, positionalArgs, namedArgs, _) {
        final predicate = positionalArgs[0];
        if (predicate is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'Stream.takeWhile requires an Function predicate argument.',
          );
        }
        return (target as Stream).takeWhile((event) {
          final result = runAction<dynamic>(visitor, predicate, [event]);
          return result is bool && result;
        });
      },
      'skipWhile': (visitor, target, positionalArgs, namedArgs, _) {
        final predicate = positionalArgs[0];
        if (predicate is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'Stream.skipWhile requires an Function predicate argument.',
          );
        }
        return (target as Stream).skipWhile((event) {
          final result = runAction<dynamic>(visitor, predicate, [event]);
          return result is bool && result;
        });
      },
      'distinct': (visitor, target, positionalArgs, namedArgs, _) {
        final equals = positionalArgs.isNotEmpty
            ? positionalArgs[0] as InterpretedFunction?
            : null;
        if (equals == null) {
          return (target as Stream).distinct();
        } else {
          return (target as Stream).distinct((p, n) {
            final result = runAction<dynamic>(visitor, equals, [p, n]);
            return result is bool && result;
          });
        }
      },
      'toList': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as Stream).toList(),
      'toSet': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as Stream).toSet(),
      'join': (visitor, target, positionalArgs, namedArgs, _) {
        final separator = positionalArgs.isNotEmpty
            ? positionalArgs[0] as String? ?? ''
            : '';
        return (target as Stream).join(separator);
      },
      'pipe': (visitor, target, positionalArgs, namedArgs, _) {
        final streamConsumer = positionalArgs[0];
        if (streamConsumer is! StreamConsumer) {
          throw RuntimeD4rtException(
            'Stream.pipe requires a StreamConsumer argument.',
          );
        }
        return (target as Stream).pipe(streamConsumer);
      },
      'any': (visitor, target, positionalArgs, namedArgs, _) {
        final predicate = positionalArgs[0];
        if (predicate is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'Stream.any requires an Function predicate argument.',
          );
        }
        return (target as Stream).any((event) {
          final result = runAction<dynamic>(visitor, predicate, [event]);
          return result is bool && result;
        });
      },
      'contains': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty) {
          throw RuntimeD4rtException(
            'Stream.contains requires an element argument.',
          );
        }
        return (target as Stream).contains(positionalArgs[0]);
      },
      'every': (visitor, target, positionalArgs, namedArgs, _) {
        final predicate = positionalArgs[0];
        if (predicate is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'Stream.every requires an Function predicate argument.',
          );
        }
        return (target as Stream).every((event) {
          final result = runAction<dynamic>(visitor, predicate, [event]);
          return result is bool && result;
        });
      },
      'fold': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length < 2 ||
            positionalArgs[1] is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'Stream.fold requires initial value and InterpretedFunction combine arguments.',
          );
        }
        final initialValue = positionalArgs[0];
        final combine = positionalArgs[1] as InterpretedFunction;
        return (target as Stream).fold(
          initialValue,
          (previous, element) =>
              runAction<dynamic>(visitor, combine, [previous, element]),
        );
      },
      'reduce': (visitor, target, positionalArgs, namedArgs, _) {
        final combine = positionalArgs[0];
        if (combine is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'Stream.reduce requires an Function combine argument.',
          );
        }
        return (target as Stream).reduce(
          (previous, element) =>
              runAction<dynamic>(visitor, combine, [previous, element]),
        );
      },
      'forEach': (visitor, target, positionalArgs, namedArgs, _) {
        final action = positionalArgs[0];
        if (action is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'Stream.forEach requires an Function action argument.',
          );
        }
        return (target as Stream).forEach(
          (element) => runAction<void>(visitor, action, [element]),
        );
      },
      'asBroadcastStream': (visitor, target, positionalArgs, namedArgs, _) {
        final onListen = namedArgs['onListen'] as InterpretedFunction?;
        final onCancel = namedArgs['onCancel'] as InterpretedFunction?;
        return (target as Stream).asBroadcastStream(
          onListen: onListen == null
              ? null
              : (subscription) =>
                    runAction<void>(visitor, onListen, [subscription]),
          onCancel: onCancel == null
              ? null
              : (subscription) =>
                    runAction<void>(visitor, onCancel, [subscription]),
        );
      },
      'asyncMap': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty ||
            positionalArgs[0] is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'Stream.asyncMap requires a convert function.',
          );
        }
        final convert = positionalArgs[0] as InterpretedFunction;
        return (target as Stream).asyncMap(
          (event) => runAction(visitor, convert, [event]),
        );
      },
      'asyncExpand': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty ||
            positionalArgs[0] is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'Stream.asyncExpand requires a convert function.',
          );
        }
        final convert = positionalArgs[0] as InterpretedFunction;
        return (target as Stream).asyncExpand<dynamic>((event) {
          final result = runAction(visitor, convert, [event]);
          return result is Stream ? result : Stream.empty();
        });
      },
      'handleError': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty ||
            positionalArgs[0] is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'Stream.handleError requires an onError function.',
          );
        }
        final onError = positionalArgs[0] as InterpretedFunction;
        final test = namedArgs['test'] as InterpretedFunction?;
        return (target as Stream).handleError(
          (error, stackTrace) {
            // Unwrap InternalInterpreterException to get the original thrown value
            final actualError = error is InternalInterpreterD4rtException
                ? error.originalThrownValue
                : error;
            return runAction<void>(
              visitor,
              onError,
              errorHandlerArgs(onError, actualError, stackTrace),
            );
          },
          test: test == null
              ? null
              : (error) {
                  final actualError = error is InternalInterpreterD4rtException
                      ? error.originalThrownValue
                      : error;
                  return runAction<bool>(visitor, test, [actualError]) == true;
                },
        );
      },
      'timeout': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty || positionalArgs[0] is! Duration) {
          throw RuntimeD4rtException('Stream.timeout requires a Duration.');
        }
        final timeLimit = positionalArgs[0] as Duration;
        final onTimeout = namedArgs['onTimeout'] as InterpretedFunction?;
        return (target as Stream).timeout(
          timeLimit,
          onTimeout: onTimeout == null
              ? null
              : (sink) => runAction<void>(visitor, onTimeout, [sink]),
        );
      },
      'firstWhere': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty ||
            positionalArgs[0] is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'Stream.firstWhere requires a test function.',
          );
        }
        final test = positionalArgs[0] as InterpretedFunction;
        final orElse = namedArgs['orElse'] as InterpretedFunction?;
        return (target as Stream).firstWhere(
          (element) => runAction<bool>(visitor, test, [element]) == true,
          orElse: orElse == null ? null : () => runAction(visitor, orElse, []),
        );
      },
      'lastWhere': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty ||
            positionalArgs[0] is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'Stream.lastWhere requires a test function.',
          );
        }
        final test = positionalArgs[0] as InterpretedFunction;
        final orElse = namedArgs['orElse'] as InterpretedFunction?;
        return (target as Stream).lastWhere(
          (element) => runAction<bool>(visitor, test, [element]) == true,
          orElse: orElse == null ? null : () => runAction(visitor, orElse, []),
        );
      },
      'singleWhere': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty ||
            positionalArgs[0] is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'Stream.singleWhere requires a test function.',
          );
        }
        final test = positionalArgs[0] as InterpretedFunction;
        final orElse = namedArgs['orElse'] as InterpretedFunction?;
        return (target as Stream).singleWhere(
          (element) => runAction<bool>(visitor, test, [element]) == true,
          orElse: orElse == null ? null : () => runAction(visitor, orElse, []),
        );
      },
      'elementAt': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty || positionalArgs[0] is! int) {
          throw RuntimeD4rtException('Stream.elementAt requires an int index.');
        }
        return (target as Stream).elementAt(positionalArgs[0] as int);
      },
      'drain': (visitor, target, positionalArgs, namedArgs, _) {
        final futureValue = positionalArgs.isNotEmpty
            ? positionalArgs[0]
            : null;
        return (target as Stream).drain(futureValue);
      },
      'cast': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as Stream).cast(),
    },
    getters: {
      'isBroadcast': (visitor, target) => (target as Stream).isBroadcast,
      'first': (visitor, target) => (target as Stream).first,
      'last': (visitor, target) => (target as Stream).last,
      'single': (visitor, target) => (target as Stream).single,
      'length': (visitor, target) => (target as Stream).length,
      'isEmpty': (visitor, target) => (target as Stream).isEmpty,
      'hashCode': (visitor, target) => (target as Stream).hashCode,
      'runtimeType': (visitor, target) => (target as Stream).runtimeType,
    },
  );
}

class StreamSubscriptionAsync {
  static BridgedClass get definition => BridgedClass(
    nativeType: StreamSubscription,
    name: 'StreamSubscription',
    isAssignable: (v) => v is StreamSubscription,
    typeParameterCount: 1,
    nativeNames: [
      '_ControllerSubscription',
      '_BroadcastSubscription',
      '_BufferingStreamSubscription',
      '_StreamSubscriptionWrapper',
      '_DoneStreamSubscription',
      '_SingleSubscription',
      '_EmptyStreamSubscription',
    ],
    constructors: {},
    methods: {
      'cancel': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as StreamSubscription).cancel(),
      // Completes with [futureValue] once the stream is done. The value is
      // optional and defaults to null, so an absent argument and an
      // explicit `null` are indistinguishable — which matches the SDK,
      // whose parameter is `[E? futureValue]`.
      'asFuture': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length > 1 || namedArgs.isNotEmpty) {
          throw RuntimeD4rtException(
            'StreamSubscription.asFuture([futureValue]) expects at most '
            'one positional argument.',
          );
        }
        return (target as StreamSubscription).asFuture<Object?>(
          positionalArgs.isNotEmpty ? positionalArgs[0] : null,
        );
      },
      'pause': (visitor, target, positionalArgs, namedArgs, _) {
        final resumeSignal = positionalArgs.isNotEmpty
            ? positionalArgs[0] as Future?
            : null;
        (target as StreamSubscription).pause(resumeSignal);
        return null;
      },
      'resume': (visitor, target, positionalArgs, namedArgs, _) {
        (target as StreamSubscription).resume();
        return null;
      },
    },
    getters: {
      'isPaused': (visitor, target) => (target as StreamSubscription).isPaused,
    },
    setters: {
      'onData': (visitorParam, target, value) {
        final callback = value as InterpretedFunction?;
        final visitor = visitorParam; // Keep reference for closure
        (target as StreamSubscription).onData(
          callback == null
              ? null
              : (data) => runAction<void>(visitor!, callback, [data]),
        );
        return;
      },
      'onError': (visitorParam, target, value) {
        final callback = value as InterpretedFunction?;
        final visitor = visitorParam; // Keep reference for closure
        (target as StreamSubscription).onError(
          callback == null
              ? null
              : (error, stackTrace) => runAction<void>(
                  visitor!,
                  callback,
                  errorHandlerArgs(callback, error, stackTrace),
                ),
        );
        return;
      },
      'onDone': (visitorParam, target, value) {
        final callback = value as InterpretedFunction?;
        final visitor = visitorParam; // Keep reference for closure
        (target as StreamSubscription).onDone(
          callback == null
              ? null
              : () => runAction<void>(visitor!, callback, []),
        );
        return;
      },
    },
  );
}

/// The `StreamConsumer` half of the sink hierarchy.
///
/// Abstract interface — no constructor. Scripts never build one; they receive
/// one (a `StreamController`, its `sink`, or an `IOSink`) and either annotate
/// against it or type-test it.
///
/// Deliberately carries **no `isAssignable`**. That closure is consulted by
/// [Environment.toBridgedInstance] when deciding which bridge owns a native
/// object, and `StreamConsumer` is a supertype of both `StreamController` and
/// `StreamSink`. Claiming assignability here would have entered this bridge
/// into that contest as an equally-ranked match — every hand-written stdlib
/// bridge has `hierarchyDepth == 0`, so the tie breaks on registration order —
/// and could have quietly stolen dispatch from the two concrete bridges.
/// Instead the hierarchy is declared via [BridgedClass.registerSupertypes] in
/// [AsyncStreamStdlib.register], which feeds `isSubtypeOf` (so `is` answers
/// correctly) without touching dispatch.
class StreamConsumerAsync {
  static BridgedClass get definition => BridgedClass(
    nativeType: StreamConsumer,
    name: 'StreamConsumer',
    typeParameterCount: 1,
    constructors: {},
    methods: {
      'addStream': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! Stream) {
          throw RuntimeD4rtException(
            'StreamConsumer.addStream requires a Stream argument.',
          );
        }
        return (target as StreamConsumer).addStream(
          positionalArgs[0] as Stream,
        );
      },
      'close': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as StreamConsumer).close(),
    },
  );
}

class StreamSinkAsync {
  static BridgedClass get definition => BridgedClass(
    nativeType: StreamSink,
    name: 'StreamSink',
    typeParameterCount: 1,
    nativeNames: [
      // What `StreamController.sink` actually hands out, for both the
      // single-subscription and broadcast flavours. Without this entry the
      // wrapper reached no bridge at all and every member — including
      // `close()` — failed as "undefined property or method".
      '_StreamSinkWrapper',
    ],
    constructors: {},
    methods: {
      'add': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty) {
          throw RuntimeD4rtException(
            'StreamSink.add requires an event argument.',
          );
        }
        (target as StreamSink).add(positionalArgs[0]);
        return null;
      },
      'addError': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty) {
          throw RuntimeD4rtException(
            'StreamSink.addError requires an error argument.',
          );
        }
        final error = positionalArgs[0];
        if (error == null) {
          throw RuntimeD4rtException(
            'StreamSink.addError requires a non-null error.',
          );
        }
        final stackTrace = positionalArgs.length > 1
            ? positionalArgs[1] as StackTrace?
            : null;
        (target as StreamSink).addError(error, stackTrace);
        return null;
      },
      'close': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as StreamSink).close(),
      // Inherited from StreamConsumer in the SDK. Dispatch is per-bridge
      // rather than hierarchical, so the member has to be present here too
      // or it is unreachable on the concrete type scripts actually hold.
      'addStream': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! Stream) {
          throw RuntimeD4rtException(
            'StreamSink.addStream requires a Stream argument.',
          );
        }
        return (target as StreamSink).addStream(positionalArgs[0] as Stream);
      },
    },
    getters: {'done': (visitor, target) => (target as StreamSink).done},
  );
}

class StreamTransformerAsync {
  static BridgedClass get definition => BridgedClass(
    nativeType: StreamTransformer,
    name: 'StreamTransformer',
    typeParameterCount: 2,
    constructors: {
      'fromHandlers': (visitor, positionalArgs, namedArgs) {
        final handleData = namedArgs['handleData'] as InterpretedFunction?;
        final handleError = namedArgs['handleError'] as InterpretedFunction?;
        final handleDone = namedArgs['handleDone'] as InterpretedFunction?;

        return StreamTransformer.fromHandlers(
          handleData: handleData == null
              ? null
              : (data, sink) =>
                    runAction<void>(visitor, handleData, [data, sink]),
          handleError: handleError == null
              ? null
              : (error, stackTrace, sink) => runAction<void>(
                  visitor,
                  handleError,
                  [error, stackTrace, sink],
                ),
          handleDone: handleDone == null
              ? null
              : (sink) => runAction<void>(visitor, handleDone, [sink]),
        );
      },
      'fromBind': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.isEmpty ||
            positionalArgs[0] is! InterpretedFunction) {
          throw RuntimeD4rtException(
            'StreamTransformer.fromBind requires a bind function.',
          );
        }
        final bind = positionalArgs[0] as InterpretedFunction;
        return StreamTransformer.fromBind(
          (stream) => runAction<Stream>(visitor, bind, [stream]) as Stream,
        );
      },
      'castFrom': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.isEmpty) {
          throw RuntimeD4rtException(
            'StreamTransformer.castFrom requires a source.',
          );
        }
        return StreamTransformer.castFrom(
          positionalArgs[0] as StreamTransformer,
        );
      },
    },
    staticMethods: {},
    methods: {
      'bind': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! Stream) {
          throw RuntimeD4rtException(
            'StreamTransformer.bind requires a Stream argument.',
          );
        }
        return (target as StreamTransformer).bind(positionalArgs[0] as Stream);
      },
      'cast': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as StreamTransformer).cast(),
    },
    getters: {},
  );
}

class StreamIteratorAsync {
  static BridgedClass get definition => BridgedClass(
    nativeType: StreamIterator,
    name: 'StreamIterator',
    isAssignable: (v) => v is StreamIterator,
    typeParameterCount: 1,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! Stream) {
          throw RuntimeD4rtException(
            'StreamIterator constructor requires a Stream argument.',
          );
        }
        return StreamIterator(positionalArgs[0] as Stream);
      },
    },
    methods: {
      'moveNext': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as StreamIterator).moveNext(),
      'cancel': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as StreamIterator).cancel(),
    },
    getters: {
      'current': (visitor, target) => (target as StreamIterator).current,
    },
  );
}

/// `StreamView<T>` — the SDK's canonical way to hand out a stream while
/// keeping its controller private.
///
/// Deliberately carries **no `isAssignable`**, and instead registers its native
/// name on the `Stream` bridge (see [StreamAsync]'s `nativeNames`). The reason
/// is dispatch: bridge member lookup is per-bridge, not hierarchical, so a
/// `StreamView` that resolved to *this* bridge would expose only the members
/// declared here and lose the ~60-method `Stream` surface it inherits. Routing
/// the native object to the `Stream` bridge gives it that surface for free,
/// which is what a script wrapping a stream actually wants.
///
/// `v is StreamView` survives this anyway: the value's bridge is `Stream`,
/// which is not a subtype of `StreamView`, but `visitIsExpression` then falls
/// back to resolving the *native* object's runtime type by name and finds this
/// bridge. Both directions are pinned by F-SC6-5, because the answer depends on
/// that fallback rather than on anything declared here.
class StreamViewAsync {
  static BridgedClass get definition => BridgedClass(
    nativeType: StreamView,
    name: 'StreamView',
    typeParameterCount: 1,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.length != 1 || positionalArgs[0] is! Stream) {
          throw RuntimeD4rtException(
            'StreamView constructor requires a Stream argument.',
          );
        }
        return StreamView(positionalArgs[0] as Stream);
      },
    },
    methods: {},
    getters: {},
  );
}

/// `StreamTransformerBase<S, T>` — the SDK's base class for user-written
/// transformers. Abstract and constructor-only in the SDK (`const
/// StreamTransformerBase()`), its entire purpose is to be extended, so the
/// bridge exists to make `class X extends StreamTransformerBase<S, T>` legal
/// rather than to wrap native instances.
///
/// No `isAssignable`: nothing native is ever a bare `StreamTransformerBase`
/// (it is abstract), and claiming assignability would put this bridge into the
/// dispatch contest against `StreamTransformer` for every native transformer.
/// The `StreamTransformer` edge is declared in the supertype registry instead,
/// which is what makes `x is StreamTransformer` answer correctly.
///
/// `cast` is the one member the SDK actually implements on this class; `bind`
/// is left abstract for the subclass, which is why it is absent here.
class StreamTransformerBaseAsync {
  static BridgedClass get definition => BridgedClass(
    nativeType: StreamTransformerBase,
    name: 'StreamTransformerBase',
    typeParameterCount: 2,
    constructors: {
      // Present so `super()` in an interpreted subclass resolves. The SDK
      // constructor is const and takes nothing; there is no native object
      // to build, because the instance the script holds is the
      // InterpretedInstance of its own subclass.
      '': (visitor, positionalArgs, namedArgs) => null,
    },
    methods: {
      'cast': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as StreamTransformerBase).cast(),
    },
    getters: {},
  );
}

class MultiStreamControllerAsync {
  static BridgedClass get definition => BridgedClass(
    nativeType: MultiStreamController,
    name: 'MultiStreamController',
    isAssignable: (v) => v is MultiStreamController,
    typeParameterCount: 1,
    constructors: {},
    methods: {
      'add': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty) {
          throw RuntimeD4rtException(
            'MultiStreamController.add requires an event argument.',
          );
        }
        (target as MultiStreamController).add(positionalArgs[0]);
        return null;
      },
      'addSync': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty) {
          throw RuntimeD4rtException(
            'MultiStreamController.addSync requires an event argument.',
          );
        }
        (target as MultiStreamController).addSync(positionalArgs[0]);
        return null;
      },
      'addError': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty) {
          throw RuntimeD4rtException(
            'MultiStreamController.addError requires an error argument.',
          );
        }
        final error = positionalArgs[0];
        if (error == null) {
          throw RuntimeD4rtException(
            'MultiStreamController.addError requires a non-null error.',
          );
        }
        final stackTrace = positionalArgs.length > 1
            ? positionalArgs[1] as StackTrace?
            : null;
        (target as MultiStreamController).addError(error, stackTrace);
        return null;
      },
      'addErrorSync': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty) {
          throw RuntimeD4rtException(
            'MultiStreamController.addErrorSync requires an error argument.',
          );
        }
        final error = positionalArgs[0];
        if (error == null) {
          throw RuntimeD4rtException(
            'MultiStreamController.addErrorSync requires a non-null error.',
          );
        }
        final stackTrace = positionalArgs.length > 1
            ? positionalArgs[1] as StackTrace?
            : null;
        (target as MultiStreamController).addErrorSync(error, stackTrace);
        return null;
      },
      'close': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as MultiStreamController).close(),
      'closeSync': (visitor, target, positionalArgs, namedArgs, _) {
        (target as MultiStreamController).closeSync();
        return null;
      },
      'addStream': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty || positionalArgs[0] is! Stream) {
          throw RuntimeD4rtException(
            'MultiStreamController.addStream requires a Stream argument.',
          );
        }
        return (target as MultiStreamController).addStream(
          positionalArgs[0] as Stream,
        );
      },
    },
    getters: {
      'stream': (visitor, target) => (target as MultiStreamController).stream,
      'sink': (visitor, target) => (target as MultiStreamController).sink,
      'done': (visitor, target) => (target as MultiStreamController).done,
      'isClosed': (visitor, target) =>
          (target as MultiStreamController).isClosed,
      'isPaused': (visitor, target) =>
          (target as MultiStreamController).isPaused,
      'hasListener': (visitor, target) =>
          (target as MultiStreamController).hasListener,
    },
    setters: {
      'onListen': (visitor, target, value) {
        final callback = value as InterpretedFunction?;
        (target as MultiStreamController).onListen = callback == null
            ? null
            : () => runAction<void>(visitor!, callback, []);
      },
      'onPause': (visitor, target, value) {
        final callback = value as InterpretedFunction?;
        (target as MultiStreamController).onPause = callback == null
            ? null
            : () => runAction<void>(visitor!, callback, []);
      },
      'onResume': (visitor, target, value) {
        final callback = value as InterpretedFunction?;
        (target as MultiStreamController).onResume = callback == null
            ? null
            : () => runAction<void>(visitor!, callback, []);
      },
      'onCancel': (visitor, target, value) {
        final callback = value as InterpretedFunction?;
        (target as MultiStreamController).onCancel = callback == null
            ? null
            : () => runAction<void>(visitor!, callback, []);
      },
    },
  );
}

class EventSinkAsync {
  static BridgedClass get definition => BridgedClass(
    nativeType: EventSink,
    name: 'EventSink',
    typeParameterCount: 1,
    nativeNames: ['_EventSinkWrapper', '_HandlerEventSink'],
    constructors: {},
    staticMethods: {},
    methods: {
      'add': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty) {
          throw RuntimeD4rtException(
            'EventSink.add requires a value argument.',
          );
        }
        (target as EventSink).add(positionalArgs[0]);
        return null;
      },
      'addError': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.isEmpty) {
          throw RuntimeD4rtException(
            'EventSink.addError requires an error argument.',
          );
        }
        final error = positionalArgs[0] as Object;
        final stackTrace = positionalArgs.length > 1
            ? positionalArgs[1] as StackTrace?
            : null;
        (target as EventSink).addError(error, stackTrace);
        return null;
      },
      'close': (visitor, target, positionalArgs, namedArgs, _) {
        (target as EventSink).close();
        return null;
      },
    },
    getters: {},
    setters: {},
  );
}

class AsyncStreamStdlib {
  static void register(Environment environment) {
    environment.defineBridge(StreamAsync.definition);
    environment.defineBridge(StreamSubscriptionAsync.definition);
    environment.defineBridge(StreamConsumerAsync.definition);
    environment.defineBridge(StreamSinkAsync.definition);
    environment.defineBridge(StreamTransformerAsync.definition);
    environment.defineBridge(StreamTransformerBaseAsync.definition);
    environment.defineBridge(StreamIteratorAsync.definition);
    environment.defineBridge(StreamViewAsync.definition);
    environment.defineBridge(MultiStreamControllerAsync.definition);
    environment.defineBridge(EventSinkAsync.definition);

    // The sink hierarchy, as the SDK declares it:
    //   abstract class StreamSink<S> implements EventSink<S>, StreamConsumer<S>
    //   abstract class StreamController<T> implements StreamSink<T>, ...
    //
    // `isSubtypeOf` consults this registry, so declaring the edges is what
    // makes `x is StreamConsumer` true for the concrete types scripts hold.
    // The `StreamController` edge is declared here rather than next to that
    // bridge because it only became meaningful once `StreamConsumer` existed;
    // the registry is keyed by name and the call is idempotent, so it does not
    // matter which registrar runs first.
    BridgedClass.registerSupertypes({
      'StreamSink': ['EventSink', 'StreamConsumer'],
      'StreamController': ['StreamSink', 'EventSink', 'StreamConsumer'],
      'MultiStreamController': ['StreamController'],
      // `class StreamView<T> extends Stream<T>`. Recorded for completeness of
      // the registry even though StreamView instances dispatch to the `Stream`
      // bridge (so `is Stream` is already true by identity) — a later change
      // that gives StreamView its own dispatch must not silently lose the edge.
      'StreamView': ['Stream'],
      // `abstract class StreamTransformerBase<S, T>
      //      implements StreamTransformer<S, T>`. This edge is load-bearing:
      // it is what makes an interpreted `extends StreamTransformerBase`
      // subclass answer `true` to `is StreamTransformer`.
      'StreamTransformerBase': ['StreamTransformer'],
    });
  }
}
