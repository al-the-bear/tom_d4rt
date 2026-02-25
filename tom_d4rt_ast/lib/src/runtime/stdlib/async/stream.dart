import 'dart:async';
import 'package:tom_d4rt_ast/runtime.dart';

// Helper function for running interpreted functions
FutureOr<T> _runAction<T>(
    InterpreterVisitor visitor, InterpretedFunction? func, List<dynamic> args) {
  try {
    return func?.call(visitor, args) as FutureOr<T>;
  } catch (e) {
    rethrow;
  }
}

class StreamAsync {
  static BridgedClass get definition => BridgedClass(
        nativeType: Stream,
        name: 'Stream',
        typeParameterCount: 1,
        nativeNames: [
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
          '_StdStream'
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
                  'Stream.error requires at least one argument.');
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
                  'Stream.fromIterable requires an Iterable argument.');
            }
            return Stream.fromIterable(positionalArgs[0] as Iterable);
          },
          'periodic': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty || positionalArgs[0] is! Duration) {
              throw RuntimeD4rtException(
                  'Stream.periodic requires a Duration argument.');
            }
            final callback = positionalArgs.length > 1
                ? positionalArgs[1] as InterpretedFunction?
                : null;
            return Stream.periodic(
              positionalArgs[0] as Duration,
              callback == null
                  ? null
                  : (i) => _runAction(visitor, callback, [i]),
            );
          },
          'fromFuture': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! Future) {
              throw RuntimeD4rtException(
                  'Stream.fromFuture requires a Future argument.');
            }
            return Stream.fromFuture(positionalArgs[0] as Future);
          },
          'fromFutures': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! Iterable) {
              throw RuntimeD4rtException(
                  'Stream.fromFutures requires an Iterable argument.');
            }
            return Stream.fromFutures((positionalArgs[0] as Iterable).cast());
          },
          'multi': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty ||
                positionalArgs[0] is! InterpretedFunction) {
              throw RuntimeD4rtException('Stream.multi requires an onListen function.');
            }
            final onListen = positionalArgs[0] as InterpretedFunction;
            final isBroadcast = namedArgs['isBroadcast'] as bool? ?? false;
            return Stream.multi(
              (controller) => _runAction<void>(visitor, onListen, [controller]),
              isBroadcast: isBroadcast,
            );
          },
          'eventTransformed': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.length < 2) {
              throw RuntimeD4rtException(
                  'Stream.eventTransformed requires source and mapSink.');
            }
            final source = positionalArgs[0] as Stream;
            final mapSink = positionalArgs[1] as InterpretedFunction;
            return Stream.eventTransformed(
              source,
              (sink) {
                _runAction<void>(visitor, mapSink, [sink]);
                return sink;
              },
            );
          },
          'castFrom': (visitor, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty) {
              throw RuntimeD4rtException('Stream.castFrom requires a source stream.');
            }
            return Stream.castFrom(positionalArgs[0] as Stream);
          },
        },
        methods: {
          'listen': (visitor, target, positionalArgs, namedArgs, _) {
            final onData = positionalArgs.isNotEmpty
                ? positionalArgs[0] as InterpretedFunction?
                : null;
            final onError = namedArgs['onError'] as InterpretedFunction?;
            final onDone = namedArgs['onDone'] as InterpretedFunction?;
            final cancelOnError = namedArgs['cancelOnError'] as bool?;

            void onDataWrapper(dynamic data) =>
                _runAction<void>(visitor, onData!, [data]);
            Function? onErrorWrapper = onError == null
                ? null
                : (Object error, [StackTrace? stackTrace]) =>
                    _runAction<void>(visitor, onError, [error, stackTrace]);
            void Function()? onDoneWrapper = onDone == null
                ? null
                : () => _runAction<void>(visitor, onDone, []);

            return (target as Stream).listen(
              onData != null ? onDataWrapper : null,
              onError: onErrorWrapper,
              onDone: onDoneWrapper,
              cancelOnError: cancelOnError,
            );
          },
          'map': (visitor, target, positionalArgs, namedArgs, _) {
            final mapper = positionalArgs[0];
            if (mapper is! InterpretedFunction) {
              throw RuntimeD4rtException(
                  'Stream.map requires an Function mapper argument.');
            }
            return (target as Stream)
                .map((event) => _runAction<dynamic>(visitor, mapper, [event]));
          },
          'where': (visitor, target, positionalArgs, namedArgs, _) {
            final predicate = positionalArgs[0];
            if (predicate is! InterpretedFunction) {
              throw RuntimeD4rtException(
                  'Stream.where requires an Function predicate argument.');
            }
            return (target as Stream).where((event) {
              final result = _runAction<dynamic>(visitor, predicate, [event]);
              return result is bool && result;
            });
          },
          'expand': (visitor, target, positionalArgs, namedArgs, _) {
            final converter = positionalArgs[0];
            if (converter is! InterpretedFunction) {
              throw RuntimeD4rtException(
                  'Stream.expand requires an Function converter argument.');
            }
            return (target as Stream).expand((event) {
              final result = _runAction<dynamic>(visitor, converter, [event]);
              return result is Iterable ? result : const [];
            });
          },
          'transform': (visitor, target, positionalArgs, namedArgs, _) {
            final streamTransformer = positionalArgs[0];
            if (streamTransformer is! StreamTransformer) {
              throw RuntimeD4rtException(
                  'Stream.transform requires a StreamTransformer argument.');
            }
            return (target as Stream).transform(streamTransformer);
          },
          'take': (visitor, target, positionalArgs, namedArgs, _) {
            final count = positionalArgs[0];
            if (count is! int) {
              throw RuntimeD4rtException(
                  'Stream.take requires an integer count argument.');
            }
            return (target as Stream).take(count);
          },
          'skip': (visitor, target, positionalArgs, namedArgs, _) {
            final count = positionalArgs[0];
            if (count is! int) {
              throw RuntimeD4rtException(
                  'Stream.skip requires an integer count argument.');
            }
            return (target as Stream).skip(count);
          },
          'takeWhile': (visitor, target, positionalArgs, namedArgs, _) {
            final predicate = positionalArgs[0];
            if (predicate is! InterpretedFunction) {
              throw RuntimeD4rtException(
                  'Stream.takeWhile requires an Function predicate argument.');
            }
            return (target as Stream).takeWhile((event) {
              final result = _runAction<dynamic>(visitor, predicate, [event]);
              return result is bool && result;
            });
          },
          'skipWhile': (visitor, target, positionalArgs, namedArgs, _) {
            final predicate = positionalArgs[0];
            if (predicate is! InterpretedFunction) {
              throw RuntimeD4rtException(
                  'Stream.skipWhile requires an Function predicate argument.');
            }
            return (target as Stream).skipWhile((event) {
              final result = _runAction<dynamic>(visitor, predicate, [event]);
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
                final result = _runAction<dynamic>(visitor, equals, [p, n]);
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
                  'Stream.pipe requires a StreamConsumer argument.');
            }
            return (target as Stream).pipe(streamConsumer);
          },
          'any': (visitor, target, positionalArgs, namedArgs, _) {
            final predicate = positionalArgs[0];
            if (predicate is! InterpretedFunction) {
              throw RuntimeD4rtException(
                  'Stream.any requires an Function predicate argument.');
            }
            return (target as Stream).any((event) {
              final result = _runAction<dynamic>(visitor, predicate, [event]);
              return result is bool && result;
            });
          },
          'contains': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty) {
              throw RuntimeD4rtException(
                  'Stream.contains requires an element argument.');
            }
            return (target as Stream).contains(positionalArgs[0]);
          },
          'every': (visitor, target, positionalArgs, namedArgs, _) {
            final predicate = positionalArgs[0];
            if (predicate is! InterpretedFunction) {
              throw RuntimeD4rtException(
                  'Stream.every requires an Function predicate argument.');
            }
            return (target as Stream).every((event) {
              final result = _runAction<dynamic>(visitor, predicate, [event]);
              return result is bool && result;
            });
          },
          'fold': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length < 2 ||
                positionalArgs[1] is! InterpretedFunction) {
              throw RuntimeD4rtException(
                  'Stream.fold requires initial value and InterpretedFunction combine arguments.');
            }
            final initialValue = positionalArgs[0];
            final combine = positionalArgs[1] as InterpretedFunction;
            return (target as Stream).fold(
              initialValue,
              (previous, element) =>
                  _runAction<dynamic>(visitor, combine, [previous, element]),
            );
          },
          'reduce': (visitor, target, positionalArgs, namedArgs, _) {
            final combine = positionalArgs[0];
            if (combine is! InterpretedFunction) {
              throw RuntimeD4rtException(
                  'Stream.reduce requires an Function combine argument.');
            }
            return (target as Stream).reduce(
              (previous, element) =>
                  _runAction<dynamic>(visitor, combine, [previous, element]),
            );
          },
          'forEach': (visitor, target, positionalArgs, namedArgs, _) {
            final action = positionalArgs[0];
            if (action is! InterpretedFunction) {
              throw RuntimeD4rtException(
                  'Stream.forEach requires an Function action argument.');
            }
            return (target as Stream).forEach(
              (element) => _runAction<void>(visitor, action, [element]),
            );
          },
          'asBroadcastStream': (visitor, target, positionalArgs, namedArgs, _) {
            final onListen = namedArgs['onListen'] as InterpretedFunction?;
            final onCancel = namedArgs['onCancel'] as InterpretedFunction?;
            return (target as Stream).asBroadcastStream(
              onListen: onListen == null
                  ? null
                  : (subscription) =>
                      _runAction<void>(visitor, onListen, [subscription]),
              onCancel: onCancel == null
                  ? null
                  : (subscription) =>
                      _runAction<void>(visitor, onCancel, [subscription]),
            );
          },
          'asyncMap': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty ||
                positionalArgs[0] is! InterpretedFunction) {
              throw RuntimeD4rtException(
                  'Stream.asyncMap requires a convert function.');
            }
            final convert = positionalArgs[0] as InterpretedFunction;
            return (target as Stream).asyncMap(
              (event) => _runAction(visitor, convert, [event]),
            );
          },
          'asyncExpand': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty ||
                positionalArgs[0] is! InterpretedFunction) {
              throw RuntimeD4rtException(
                  'Stream.asyncExpand requires a convert function.');
            }
            final convert = positionalArgs[0] as InterpretedFunction;
            return (target as Stream).asyncExpand<dynamic>(
              (event) {
                final result = _runAction(visitor, convert, [event]);
                return result is Stream ? result : Stream.empty();
              },
            );
          },
          'handleError': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty ||
                positionalArgs[0] is! InterpretedFunction) {
              throw RuntimeD4rtException(
                  'Stream.handleError requires an onError function.');
            }
            final onError = positionalArgs[0] as InterpretedFunction;
            final test = namedArgs['test'] as InterpretedFunction?;
            // Dart's handleError callback can take 1 or 2 arguments
            // Check the callback arity to pass the correct number of args
            final callbackArity = onError.arity;
            return (target as Stream).handleError(
              (error, stackTrace) {
                // Unwrap InternalInterpreterException to get the original thrown value
                final actualError = error is InternalInterpreterD4rtException
                    ? error.originalThrownValue
                    : error;
                return callbackArity >= 2
                    ? _runAction<void>(visitor, onError, [actualError, stackTrace])
                    : _runAction<void>(visitor, onError, [actualError]);
              },
              test: test == null
                  ? null
                  : (error) {
                      final actualError = error is InternalInterpreterD4rtException
                          ? error.originalThrownValue
                          : error;
                      return _runAction<bool>(visitor, test, [actualError]) == true;
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
                  : (sink) => _runAction<void>(visitor, onTimeout, [sink]),
            );
          },
          'firstWhere': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty ||
                positionalArgs[0] is! InterpretedFunction) {
              throw RuntimeD4rtException('Stream.firstWhere requires a test function.');
            }
            final test = positionalArgs[0] as InterpretedFunction;
            final orElse = namedArgs['orElse'] as InterpretedFunction?;
            return (target as Stream).firstWhere(
              (element) => _runAction<bool>(visitor, test, [element]) == true,
              orElse:
                  orElse == null ? null : () => _runAction(visitor, orElse, []),
            );
          },
          'lastWhere': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty ||
                positionalArgs[0] is! InterpretedFunction) {
              throw RuntimeD4rtException('Stream.lastWhere requires a test function.');
            }
            final test = positionalArgs[0] as InterpretedFunction;
            final orElse = namedArgs['orElse'] as InterpretedFunction?;
            return (target as Stream).lastWhere(
              (element) => _runAction<bool>(visitor, test, [element]) == true,
              orElse:
                  orElse == null ? null : () => _runAction(visitor, orElse, []),
            );
          },
          'singleWhere': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty ||
                positionalArgs[0] is! InterpretedFunction) {
              throw RuntimeD4rtException(
                  'Stream.singleWhere requires a test function.');
            }
            final test = positionalArgs[0] as InterpretedFunction;
            final orElse = namedArgs['orElse'] as InterpretedFunction?;
            return (target as Stream).singleWhere(
              (element) => _runAction<bool>(visitor, test, [element]) == true,
              orElse:
                  orElse == null ? null : () => _runAction(visitor, orElse, []),
            );
          },
          'elementAt': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty || positionalArgs[0] is! int) {
              throw RuntimeD4rtException('Stream.elementAt requires an int index.');
            }
            return (target as Stream).elementAt(positionalArgs[0] as int);
          },
          'drain': (visitor, target, positionalArgs, namedArgs, _) {
            final futureValue =
                positionalArgs.isNotEmpty ? positionalArgs[0] : null;
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
          'pause': (visitor, target, positionalArgs, namedArgs, _) {
            final resumeSignal =
                positionalArgs.isNotEmpty ? positionalArgs[0] as Future? : null;
            (target as StreamSubscription).pause(resumeSignal);
            return null;
          },
          'resume': (visitor, target, positionalArgs, namedArgs, _) {
            (target as StreamSubscription).resume();
            return null;
          },
        },
        getters: {
          'isPaused': (visitor, target) =>
              (target as StreamSubscription).isPaused,
        },
        setters: {
          'onData': (visitorParam, target, value) {
            final callback = value as InterpretedFunction?;
            final visitor = visitorParam; // Keep reference for closure
            (target as StreamSubscription).onData(
              callback == null
                  ? null
                  : (data) => _runAction<void>(visitor!, callback, [data]),
            );
            return;
          },
          'onError': (visitorParam, target, value) {
            final callback = value as InterpretedFunction?;
            final visitor = visitorParam; // Keep reference for closure
            (target as StreamSubscription).onError(
              callback == null
                  ? null
                  : (error, stackTrace) =>
                      _runAction<void>(visitor!, callback, [error, stackTrace]),
            );
            return;
          },
          'onDone': (visitorParam, target, value) {
            final callback = value as InterpretedFunction?;
            final visitor = visitorParam; // Keep reference for closure
            (target as StreamSubscription).onDone(
              callback == null
                  ? null
                  : () => _runAction<void>(visitor!, callback, []),
            );
            return;
          },
        },
      );
}

class StreamSinkAsync {
  static BridgedClass get definition => BridgedClass(
        nativeType: StreamSink,
        name: 'StreamSink',
        typeParameterCount: 1,
        constructors: {},
        methods: {
          'add': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty) {
              throw RuntimeD4rtException('StreamSink.add requires an event argument.');
            }
            (target as StreamSink).add(positionalArgs[0]);
            return null;
          },
          'addError': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty) {
              throw RuntimeD4rtException(
                  'StreamSink.addError requires an error argument.');
            }
            final error = positionalArgs[0];
            if (error == null) {
              throw RuntimeD4rtException(
                  'StreamSink.addError requires a non-null error.');
            }
            final stackTrace = positionalArgs.length > 1
                ? positionalArgs[1] as StackTrace?
                : null;
            (target as StreamSink).addError(error, stackTrace);
            return null;
          },
          'close': (visitor, target, positionalArgs, namedArgs, _) =>
              (target as StreamSink).close(),
        },
        getters: {
          'done': (visitor, target) => (target as StreamSink).done,
        },
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
            final handleError =
                namedArgs['handleError'] as InterpretedFunction?;
            final handleDone = namedArgs['handleDone'] as InterpretedFunction?;

            return StreamTransformer.fromHandlers(
              handleData: handleData == null
                  ? null
                  : (data, sink) =>
                      _runAction<void>(visitor, handleData, [data, sink]),
              handleError: handleError == null
                  ? null
                  : (error, stackTrace, sink) => _runAction<void>(
                      visitor, handleError, [error, stackTrace, sink]),
              handleDone: handleDone == null
                  ? null
                  : (sink) => _runAction<void>(visitor, handleDone, [sink]),
            );
          },
          'fromBind': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.isEmpty ||
                positionalArgs[0] is! InterpretedFunction) {
              throw RuntimeD4rtException(
                  'StreamTransformer.fromBind requires a bind function.');
            }
            final bind = positionalArgs[0] as InterpretedFunction;
            return StreamTransformer.fromBind(
              (stream) => _runAction<Stream>(visitor, bind, [stream]) as Stream,
            );
          },
          'castFrom': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.isEmpty) {
              throw RuntimeD4rtException(
                  'StreamTransformer.castFrom requires a source.');
            }
            return StreamTransformer.castFrom(
                positionalArgs[0] as StreamTransformer);
          },
        },
        staticMethods: {},
        methods: {
          'bind': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! Stream) {
              throw RuntimeD4rtException(
                  'StreamTransformer.bind requires a Stream argument.');
            }
            return (target as StreamTransformer)
                .bind(positionalArgs[0] as Stream);
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
        typeParameterCount: 1,
        constructors: {
          '': (visitor, positionalArgs, namedArgs) {
            if (positionalArgs.length != 1 || positionalArgs[0] is! Stream) {
              throw RuntimeD4rtException(
                  'StreamIterator constructor requires a Stream argument.');
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

class MultiStreamControllerAsync {
  static BridgedClass get definition => BridgedClass(
        nativeType: MultiStreamController,
        name: 'MultiStreamController',
        typeParameterCount: 1,
        constructors: {},
        methods: {
          'add': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty) {
              throw RuntimeD4rtException(
                  'MultiStreamController.add requires an event argument.');
            }
            (target as MultiStreamController).add(positionalArgs[0]);
            return null;
          },
          'addSync': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty) {
              throw RuntimeD4rtException(
                  'MultiStreamController.addSync requires an event argument.');
            }
            (target as MultiStreamController).addSync(positionalArgs[0]);
            return null;
          },
          'addError': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty) {
              throw RuntimeD4rtException(
                  'MultiStreamController.addError requires an error argument.');
            }
            final error = positionalArgs[0];
            if (error == null) {
              throw RuntimeD4rtException(
                  'MultiStreamController.addError requires a non-null error.');
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
                  'MultiStreamController.addErrorSync requires an error argument.');
            }
            final error = positionalArgs[0];
            if (error == null) {
              throw RuntimeD4rtException(
                  'MultiStreamController.addErrorSync requires a non-null error.');
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
                  'MultiStreamController.addStream requires a Stream argument.');
            }
            return (target as MultiStreamController)
                .addStream(positionalArgs[0] as Stream);
          },
        },
        getters: {
          'stream': (visitor, target) =>
              (target as MultiStreamController).stream,
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
                : () => _runAction<void>(visitor!, callback, []);
          },
          'onPause': (visitor, target, value) {
            final callback = value as InterpretedFunction?;
            (target as MultiStreamController).onPause = callback == null
                ? null
                : () => _runAction<void>(visitor!, callback, []);
          },
          'onResume': (visitor, target, value) {
            final callback = value as InterpretedFunction?;
            (target as MultiStreamController).onResume = callback == null
                ? null
                : () => _runAction<void>(visitor!, callback, []);
          },
          'onCancel': (visitor, target, value) {
            final callback = value as InterpretedFunction?;
            (target as MultiStreamController).onCancel = callback == null
                ? null
                : () => _runAction<void>(visitor!, callback, []);
          },
        },
      );
}

class EventSinkAsync {
  static BridgedClass get definition => BridgedClass(
        nativeType: EventSink,
        name: 'EventSink',
        typeParameterCount: 1,
        nativeNames: [
          '_EventSinkWrapper',
          '_HandlerEventSink',
        ],
        constructors: {},
        staticMethods: {},
        methods: {
          'add': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty) {
              throw RuntimeD4rtException('EventSink.add requires a value argument.');
            }
            (target as EventSink).add(positionalArgs[0]);
            return null;
          },
          'addError': (visitor, target, positionalArgs, namedArgs, _) {
            if (positionalArgs.isEmpty) {
              throw RuntimeD4rtException(
                  'EventSink.addError requires an error argument.');
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
    environment.defineBridge(StreamSinkAsync.definition);
    environment.defineBridge(StreamTransformerAsync.definition);
    environment.defineBridge(StreamIteratorAsync.definition);
    environment.defineBridge(MultiStreamControllerAsync.definition);
    environment.defineBridge(EventSinkAsync.definition);
  }
}
