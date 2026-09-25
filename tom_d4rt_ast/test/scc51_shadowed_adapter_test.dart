// SCC51: adapters a subtype bridge redeclares from its supertype bridge.
//
// SCB17 found one by accident. `HashMap` and `LinkedHashMap` each carried a
// local `addEntries` doing `newEntries.cast()`, which cannot unwrap the
// `BridgedInstance<MapEntry>` an interpreted `MapEntry(...)` produces, while
// `MapCore`'s copy unwraps correctly. `SplayTreeMap` had no local copy and
// therefore already worked. The defect was visible only because one of three
// siblings lacked the duplicate; where every sibling carries the same divergent
// copy there is no asymmetry and nothing to notice.
//
// WHAT THE CENSUS MEASURED (2026-09-06). Intersecting each collection bridge's
// adapter keys with its registered supertypes' gives **315 shadowed members** —
// far too many to diff by hand, and far too many for the "assert the shadow set
// is empty except for an allowlist" test this was originally scoped as. An
// allowlist of three hundred names is noise a reader learns to skip.
//
// So the shadow set is not the measurement. Two adapters having the same NAME
// costs nothing; only their behaving DIFFERENTLY does. `F-SCC51-8` below is
// therefore differential: it invokes both adapters on the same native object
// with the same arguments and compares the outcomes. That reduced 315 pairs to
// one real family, and it keeps working as bridges change, which a name
// allowlist would not.
//
// WHAT IT FOUND. `first`, `last` and `single` were hand-written on six
// collection bridges, and each one caught the SDK's `StateError` (or pre-empted
// it with a length check) and threw a `RuntimeD4rtException` carrying a
// hand-written message instead. So `try { s.single } on StateError catch (e)`
// caught nothing on any `dart:collection` type — while the identical script
// over a `List` worked, because the `List` bridge has no hand-written copy and
// delegates. Seventeen adapters were deleted, plus
// `UnmodifiableMapView.addEntries`, which is byte-for-byte the `.cast()` shape
// SCB17 removed and is unobservable today only because `cast()` is lazy and the
// view throws `UnsupportedError` before it ever iterates.
//
// WHAT WIDENING IT FOUND (SCE185, 2026-09-25). The walk above covered only
// the collection bridges: 537 of 2 076 shadowed pairs. Walking every bridge
// that shadows anything — typed data, numbers, `Runes`, the errors, the
// `dart:async` sinks and every `dart:io` handle — turned up 128 divergences in
// seven families, every one a defect in one of the two adapters:
//
// - `Runes` cast each script callback to a Dart function type, so all thirteen
//   callback members threw on every call; deleted, the `Iterable` ones serve.
// - `Iterable`/`List` `reduce` and `followedBy`, `List.setRange`,
//   `Stream.reduce` and `Stream.transform` rejected a script's untyped
//   argument on any NATIVELY TYPED receiver — `List<int>`, `Stream<Socket>` —
//   where the typed leaves had coerced it all along.
// - `List.shuffle` dropped its `Random`; `Sink.close` and `EventSink.close`
//   dropped the `Future` the sink returned; `LinkedList.contains` threw on a
//   non-entry instead of answering false; `WebSocketTransformer.cast`
//   hard-coded its type arguments; the typed lists' `[]=` returned a value.
//
// `F-SCE185-1` now holds the fixture table to the registry, so the walk cannot
// shrink back to a subset without failing.
//
// WHY THIS FILE IS ADAPTER-LEVEL, not script-level like its `tom_d4rt` twin:
// this package has no parser, so there is no `execute(source: ...)` to write
// `try { ... } on StateError catch` in. The adapters are invoked directly
// instead, which measures exactly the same thing one layer down — the exception
// family that escapes the adapter is the family the script's handler sees.

import 'dart:async';
import 'dart:collection';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/src/runtime/bridge/bridged_types.dart';
import 'package:tom_d4rt_ast/src/runtime/callable.dart';
import 'package:tom_d4rt_ast/src/runtime/interpreter_visitor.dart';
import 'package:tom_d4rt_ast/src/runtime/module_context.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection/linked_list.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/isolate.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/stdlib.dart';

import 'bridge_reachability.dart';

/// A fresh native fixture per call, so a mutating member cannot leak state from
/// the subtype invocation into the supertype one. SCE185: a fixture may be
/// asynchronous, because the io bridges' receivers — a connected `Socket`, a
/// server-side `HttpResponse` — only exist once a handshake has completed.
typedef Fixture = FutureOr<Object> Function();

/// SCE185. The fixture table used to list fourteen COLLECTION types, so the
/// differential reached 537 of the 2 076 shadowed pairs the stdlib registry
/// holds and never walked the typed-data lists, the numbers, `Runes`, the
/// errors or anything in `dart:io` — while calling itself the guard for all of
/// them. It now carries one row per bridge that shadows a supertype member,
/// and `F-SCE185-1` fails when a shadowing bridge has neither a row here nor a
/// reason in [_unwalked], so the table cannot quietly fall behind again.
final Map<String, Fixture> _fixtures = {
  // --- dart:collection, and the core collections they refine.
  'HashMap': () => HashMap<dynamic, dynamic>.from({'a': 1, 'b': 2}),
  'LinkedHashMap': () => LinkedHashMap<dynamic, dynamic>.from({'a': 1, 'b': 2}),
  'SplayTreeMap': () => SplayTreeMap<dynamic, dynamic>.from({'a': 1, 'b': 2}),
  'UnmodifiableMapView': () =>
      UnmodifiableMapView<dynamic, dynamic>({'a': 1, 'b': 2}),
  'HashSet': () => HashSet<dynamic>.of([3, 1, 2]),
  // A Dart set literal already *is* a `LinkedHashSet` — which is why spelling
  // the constructor out here trips `prefer_collection_literals`. Same value as
  // 'Set' below, reached through the other bridge name on purpose.
  'LinkedHashSet': () => <dynamic>{3, 1, 2},
  'SplayTreeSet': () => SplayTreeSet<dynamic>.of([3, 1, 2]),
  'UnmodifiableSetView': () => UnmodifiableSetView<dynamic>(<dynamic>{3, 1, 2}),
  'UnmodifiableListView': () => UnmodifiableListView<dynamic>([3, 1, 2]),
  'DoubleLinkedQueue': () => DoubleLinkedQueue<dynamic>.of([3, 1, 2]),
  'ListQueue': () => ListQueue<dynamic>.of([3, 1, 2]),
  'Queue': () => Queue<dynamic>.of([3, 1, 2]),
  'LinkedList': () => LinkedList<BridgedLinkedListEntry>(),
  'Set': () => <dynamic>{3, 1, 2},
  'List': () => <dynamic>[3, 1, 2],
  'Runes': () => 'abc'.runes,

  // --- dart:typed_data. Eleven siblings carrying the same 81 adapters: the
  // SCB17 shape, where a divergent copy on every sibling shows no asymmetry.
  'Int8List': () => Int8List.fromList([3, 1, 2]),
  'Int16List': () => Int16List.fromList([3, 1, 2]),
  'Int32List': () => Int32List.fromList([3, 1, 2]),
  'Int64List': () => Int64List.fromList([3, 1, 2]),
  'Uint8List': () => Uint8List.fromList([3, 1, 2]),
  'Uint8ClampedList': () => Uint8ClampedList.fromList([3, 1, 2]),
  'Uint16List': () => Uint16List.fromList([3, 1, 2]),
  'Uint32List': () => Uint32List.fromList([3, 1, 2]),
  'Uint64List': () => Uint64List.fromList([3, 1, 2]),
  'Float32List': () => Float32List.fromList([3, 1, 2]),
  'Float64List': () => Float64List.fromList([3, 1, 2]),
  'ByteData': () => ByteData(4),

  // --- dart:core values.
  'int': () => 7,
  'double': () => 7.5,
  'num': () => 7,
  'BigInt': () => BigInt.from(7),
  'String': () => 'abc',
  'StringBuffer': () => StringBuffer('ab'),
  'RegExp': () => RegExp('b'),
  'RegExpMatch': () => RegExp('(b)').firstMatch('abc')!,
  'DateTime': () => DateTime.utc(2020),
  'Duration': () => const Duration(seconds: 5),

  // --- errors and exceptions. Mostly `toString` / `message` over a shared
  // base, which is exactly where a hand-written copy drifts unnoticed.
  'ArgumentError': () => ArgumentError('x'),
  'RangeError': () => RangeError.range(5, 0, 3, 'i'),
  'IndexError': () => IndexError.withLength(5, 3, name: 'i'),
  'StateError': () => StateError('x'),
  'UnsupportedError': () => UnsupportedError('x'),
  'UnimplementedError': () => UnimplementedError('x'),
  'ConcurrentModificationError': () => ConcurrentModificationError(),
  'TypeError': () => TypeError(),
  'AssertionError': () => AssertionError('x'),
  'NoSuchMethodError': () =>
      NoSuchMethodError.withInvocation(null, Invocation.method(#x, const [])),
  'StackOverflowError': () => StackOverflowError(),
  'OutOfMemoryError': () => OutOfMemoryError(),
  'IntegerDivisionByZeroException': () => _divisionByZero(),
  'FormatException': () => const FormatException('x'),
  'AsyncError': () => AsyncError('x', StackTrace.empty),
  'TimeoutException': () => TimeoutException('x'),
  'RemoteError': () => RemoteError('x', 'st'),
  'IsolateSpawnException': () => IsolateSpawnException('x'),
  'OSError': () => const OSError('x', 2),
  'IOException': () => const FileSystemException('x'),
  'FileSystemException': () => const FileSystemException('x', 'p'),
  'PathNotFoundException': () =>
      const PathNotFoundException('p', OSError('x', 2)),
  'PathAccessException': () => const PathAccessException('p', OSError('x', 13)),
  'PathExistsException': () => const PathExistsException('p', OSError('x', 17)),
  'HttpException': () => const HttpException('x'),
  'RedirectException': () => const RedirectException('x', []),
  'WebSocketException': () => const WebSocketException('x'),
  'SocketException': () => const SocketException('x'),
  'ContentType': () => ContentType('text', 'plain', charset: 'utf-8'),

  // --- dart:async sinks and controllers. Created unlistened: an `addError`
  // is buffered rather than surfacing as an uncaught error.
  'StreamController': () => StreamController<dynamic>(),
  'StreamSink': () => StreamController<dynamic>().sink,
  'EventSink': () => StreamController<dynamic>().sink,
  'MultiStreamController': _multiStreamController,
  'StreamTransformerBase': () =>
      StreamTransformer<dynamic, dynamic>.fromHandlers(),
  'ReceivePort': () => ReceivePort()..close(),
  'SendPort': () => (ReceivePort()..close()).sendPort,

  // --- dart:io. Every handle is tracked and closed by `_Net.close`.
  'File': () => File(_absentPath),
  'Directory': () => Directory(_absentPath),
  'IOSink': () => _net.track(_ignoreDone(File(_sinkPath()).openWrite())),
  'Socket': () async =>
      _net.track(_ignoreDone(await Socket.connect(_loopback, _net.tcp.port))),
  // No 'ServerSocket' row: sce195 deleted its 28 Stream copies once every pair
  // here agreed, so it shadows nothing and F-SCE185-1 forbids a row for it.
  // Against the SILENT peer: a RawSocket re-fires `read` for as long as unread
  // bytes remain, and the walk's `listen` callback does not read, so a peer
  // that sends anything spins the event loop and starves every later fixture.
  'RawSocket': () async =>
      _net.track(await RawSocket.connect(_loopback, _net.silent.port)),
  'RawServerSocket': () async =>
      _net.track(await RawServerSocket.bind(_loopback, 0)),
  'RawDatagramSocket': () async =>
      _net.track(await RawDatagramSocket.bind(_loopback, 0)),
  'HttpServer': () async => _net.track(await HttpServer.bind(_loopback, 0)),
  'HttpClientRequest': () async => _ignoreDone(
    await _net.client.get(_loopback.address, _net.http.port, '/plain'),
  ),
  'HttpClientResponse': () async => (await _net.client.get(
    _loopback.address,
    _net.http.port,
    '/plain',
  )).close(),
  'HttpRequest': () => _net.serverRequest(),
  'HttpResponse': () async =>
      _ignoreDone((await _net.serverRequest()).response),
  'HttpSession': () async => (await _net.serverRequest()).session,
  'WebSocket': () async => _net.track(
    _ignoreDone(
      await WebSocket.connect('ws://${_loopback.address}:${_net.http.port}/ws'),
    ),
  ),
  'WebSocketTransformer': () => WebSocketTransformer(),
};

/// SCE185. Shadowing bridges the walk deliberately does not drive, each with
/// the reason no fixture exists. `F-SCE185-1` holds this set and [_fixtures]
/// to the registry's actual shadowing bridges in both directions.
const Map<String, String> _unwalked = {
  'Stdout':
      'the only instances are the process\'s own stdout/stderr, and the '
      'walk calls `close` and `addError` on every sink — closing the test '
      'runner\'s output stream is not an experiment worth having.',
  'Stdin':
      'the only instance is the process\'s stdin, which is '
      'single-subscription: the second `listen` of a pair would fail because '
      'the first had consumed it, which reads as a divergence and is not one.',
};

final InternetAddress _loopback = InternetAddress.loopbackIPv4;

/// A path under this package's `.dart_tool`, which nothing creates: `File` and
/// `Directory` members then take their not-found branch on both sides.
final String _absentPath =
    '${Directory.current.path}/.dart_tool/scc51_absent/never_created';

var _sinkCounter = 0;
String _sinkPath() {
  final dir = Directory('${Directory.current.path}/.dart_tool/scc51_sinks')
    ..createSync(recursive: true);
  return '${dir.path}/sink_${_sinkCounter++}';
}

Object _divisionByZero() {
  try {
    // A zero the analyzer cannot fold, so this compiles to a runtime division.
    return 1 ~/ int.parse('0');
    // The bridge still exists and still shadows, so it is walked; the SDK's
    // deprecation says what scripts should catch, not what they can meet.
    // ignore: deprecated_member_use
  } on IntegerDivisionByZeroException catch (e) {
    return e;
  }
}

Object _multiStreamController() {
  MultiStreamController<dynamic>? captured;
  // Listened with an error handler: the walk calls `addError` on it, and a
  // listener without one reports the error as uncaught.
  Stream<dynamic>.multi(
    (c) => captured = c,
  ).listen(null, onError: (Object _) {});
  return captured!;
}

/// A sink's `done` future fails once an `addError` reaches it. Nothing here
/// awaits it, so it would surface as an uncaught error that says nothing about
/// the adapters.
T _ignoreDone<T extends Object>(T sink) {
  final done = (sink as dynamic).done;
  if (done is Future) done.ignore();
  return sink;
}

/// The loopback peers the io fixtures talk to, and everything they create.
class _Net {
  _Net._(this.tcp, this.silent, this.http);

  /// Accepts, writes two bytes and closes — so a connected `Socket` is a
  /// finite stream and its Stream members terminate.
  final ServerSocket tcp;

  /// Accepts and never writes: the peer for `RawSocket`.
  final ServerSocket silent;

  /// `/ws` upgrades and echoes; a request that a fixture is waiting for is
  /// handed over unanswered; anything else gets `ok`.
  final HttpServer http;
  final HttpClient client = HttpClient();
  final List<Completer<HttpRequest>> _waiting = [];
  final List<Object> _open = [];

  static Future<_Net> start() async {
    final tcp = await ServerSocket.bind(_loopback, 0);
    tcp.listen((s) {
      s.add([104, 105]);
      s.close().ignore();
      s.listen(null, onError: (Object _) {});
    });
    final silent = await ServerSocket.bind(_loopback, 0);
    silent.listen((s) => s.listen(null, onError: (Object _) {}));
    final http = await HttpServer.bind(_loopback, 0);
    final net = _Net._(tcp, silent, http);
    http.listen((req) async {
      if (req.uri.path == '/ws') {
        final ws = await WebSocketTransformer.upgrade(req);
        ws.listen(ws.add, onError: (Object _) {});
        net._open.add(ws);
      } else if (req.uri.path == '/hold' && net._waiting.isNotEmpty) {
        net._waiting.removeAt(0).complete(req);
      } else {
        req.response.write('ok');
        await req.response.close();
      }
    });
    return net;
  }

  T track<T extends Object>(T handle) {
    _open.add(handle);
    return handle;
  }

  /// The server side of a fresh request, left unanswered for the fixture.
  Future<HttpRequest> serverRequest() async {
    final waiter = Completer<HttpRequest>();
    _waiting.add(waiter);
    final request = await client.get(_loopback.address, http.port, '/hold');
    request.close().then((r) => r.drain<void>()).ignore();
    return waiter.future;
  }

  Future<void> close() async {
    for (final h in _open) {
      try {
        final closing = (h as dynamic).close();
        if (closing is Future) closing.ignore();
      } catch (_) {
        // Already closed by the walk itself — `close` is a shadowed member.
      }
    }
    client.close(force: true);
    await http.close(force: true);
    await tcp.close();
    await silent.close();
  }
}

late _Net _net;

/// Positional arguments by member name. Members absent here take none.
final Map<String, List<Object?>> _args = {
  '[]': ['a'],
  'containsKey': ['a'],
  'containsValue': [1],
  'remove': ['a'],
  'contains': [1],
  'add': [9],
  'lookup': [1],
  'elementAt': [0],
  'skip': [1],
  'take': [1],
  'join': ['-'],
  'indexOf': [1],
  'lastIndexOf': [1],
  'removeAt': [0],
  'sublist': [0, 1],
  'getRange': [0, 2],
  'containsAll': [
    <dynamic>[1],
  ],
  'removeAll': [
    <dynamic>[1],
  ],
  'retainAll': [
    <dynamic>[1, 2, 3],
  ],
  'union': [
    <dynamic>{7},
  ],
  'intersection': [
    <dynamic>{1},
  ],
  'difference': [
    <dynamic>{1},
  ],
  'addAll': [
    <dynamic>[9],
  ],
};

/// Per-`<class>.<member>` overrides, for members whose argument type depends on
/// the receiver — `Map.addAll` takes a map where `Iterable.addAll` takes a list.
final Map<String, List<Object?>> _classArgs = {
  for (final m in [
    'HashMap',
    'LinkedHashMap',
    'SplayTreeMap',
    'UnmodifiableMapView',
  ])
    '$m.addAll': [
      <dynamic, dynamic>{'c': 3},
    ],
};

/// Interpreter-side callables, by the shape the member expects. SCD152: the
/// differential used to SKIP every member taking one of these — 261 of 542
/// pairs, which is where SCC51 predicted divergence would hide, because
/// unwrapping a callback argument is fiddly and a leaf copy that gets it subtly
/// wrong looks identical from the outside. Both predictions held: driving them
/// found `HashMap.map` and `LinkedHashMap.map` rebuilding the entry as
/// `MapEntry(key, callbackResult)` instead of using the `MapEntry` the callback
/// returns, so `{'a': 1}.map((k, v) => MapEntry(v, k))` produced
/// `{'a': MapEntry(1, 'a')}`. `SplayTreeMap` had no copy and already worked —
/// byte-for-byte the SCB17 `addEntries` asymmetry.
///
/// These are natively built rather than parsed because `tom_d4rt_ast` has no
/// parser. `tom_d4rt` keeps the same shape so the two files stay diffable, and
/// because the alternative does not work there either: a script cannot force
/// the SUPERTYPE's adapter to run on a given object — dispatch resolves by the
/// object's bridged class — so a script-level probe cannot produce a
/// differential at all.
final _pred1 = NativeFunction(
  (visitor, positional, named, types) => true,
  arity: 1,
  name: 'pred1',
);
final _pred2 = NativeFunction(
  (visitor, positional, named, types) => true,
  arity: 2,
  name: 'pred2',
);
final _ident1 = NativeFunction(
  (visitor, positional, named, types) => positional.first,
  arity: 1,
  name: 'ident1',
);
final _combine2 = NativeFunction(
  (visitor, positional, named, types) => positional.first,
  arity: 2,
  name: 'combine2',
);
final _expand1 = NativeFunction(
  (visitor, positional, named, types) => [positional.first],
  arity: 1,
  name: 'expand1',
);
final _greaterThan97 = NativeFunction(
  (visitor, positional, named, types) => (positional.first as int) > 97,
  arity: 1,
  name: 'greaterThan97',
);
final _sum2 = NativeFunction(
  (visitor, positional, named, types) =>
      (positional[0] as num) + (positional[1] as num),
  arity: 2,
  name: 'sum2',
);
final _supplier0 = NativeFunction(
  (visitor, positional, named, types) => 99,
  arity: 0,
  name: 'supplier0',
);

/// `Map.map` takes `(K, V) => MapEntry`, not a one-argument transform. Getting
/// that wrong is what made the first run of this walk report `HashMap.map` as
/// divergent for the wrong reason — the leaf accepted a 1-arg callable while
/// `Map.map` correctly refused it, which says nothing about entry handling.
final _entry2 = NativeFunction(
  (visitor, positional, named, types) =>
      MapEntry<dynamic, dynamic>(positional[0], positional[1]),
  arity: 2,
  name: 'entry2',
);

/// The fixtures whose member signatures are the `Map` ones — `forEach` takes
/// `(k, v)` here and `(e)` everywhere else.
const _mapFixtures = {
  'HashMap',
  'LinkedHashMap',
  'SplayTreeMap',
  'UnmodifiableMapView',
};

/// Arguments for members the plain `_args` table cannot express, either because
/// one of them has to be a `Callable` or because the argument depends on whether
/// the receiver is a map.
///
/// Returns null for a member with no recipe, which the walk counts rather than
/// silently invoking with no arguments — an adapter called wrongly throws on
/// BOTH sides and would otherwise read as agreement.
List<Object?>? _callableArgs(String cls, String m) {
  final isMap = _mapFixtures.contains(cls);
  switch (m) {
    case 'map':
      return [isMap ? _entry2 : _ident1];
    case 'forEach':
    case 'removeWhere':
      return [isMap ? _pred2 : _pred1];
    case 'where':
    case 'any':
    case 'every':
    case 'firstWhere':
    case 'lastWhere':
    case 'singleWhere':
    case 'retainWhere':
    case 'indexWhere':
    case 'lastIndexWhere':
    case 'skipWhile':
    case 'takeWhile':
      return [_pred1];
    case 'fold':
      return [0, _combine2];
    case 'reduce':
      return [_combine2];
    case 'expand':
      return [_expand1];
    case 'putIfAbsent':
      return ['z', _supplier0];
    case 'update':
      return ['a', _ident1];
    case 'updateAll':
      return [_combine2];
    // No callback, and no entry in `_args` either: these were swept into the
    // old skip set alongside the callback-takers, which is why the set was
    // never only about callables.
    case 'sort':
    case 'asMap':
    case 'clear':
    case 'removeLast':
    case 'removeFirst':
    case 'cast':
    case 'whereType':
    // Genuinely no positional arguments — listed rather than left to a default,
    // because the default is what made `elementAtOrNull` below compare
    // `THROW == THROW` and read as agreement.
    case 'toList':
    case 'toSet':
    case 'toString':
      return const <Object?>[];
    case 'elementAtOrNull':
      return [0];
    // Seeded, so both sides shuffle the same way and the after-state compares.
    case 'shuffle':
      return [Random(1)];
    case 'followedBy':
      return [
        <dynamic>[7, 8],
      ];
    case 'addEntries':
      return [
        <dynamic>[const MapEntry<dynamic, dynamic>('c', 3)],
      ];
    case '[]=':
      return isMap ? ['c', 3] : [0, 7];
    case 'setAll':
      return [
        0,
        <dynamic>[7],
      ];
    case 'setRange':
      return [
        0,
        1,
        <dynamic>[7],
      ];
    case 'fillRange':
      return [0, 1, 7];
    case 'replaceRange':
      return [
        0,
        1,
        <dynamic>[7],
      ];
    case 'insert':
      return [0, 7];
    case 'insertAll':
      return [
        0,
        <dynamic>[7],
      ];
    case 'removeRange':
      return [0, 1];
    case 'addFirst':
    case 'addLast':
      return [7];
  }
  return null;
}

/// SCE185. Receiver kinds whose members take different arguments from the
/// collection members of the same name — `add` takes bytes on a `Socket`,
/// `compareTo` a number on `int`, `[]` an index on a typed list.
const _floatLists = {'Float32List', 'Float64List'};
const _intLists = {
  'Int8List',
  'Int16List',
  'Int32List',
  'Int64List',
  'Uint8List',
  'Uint8ClampedList',
  'Uint16List',
  'Uint32List',
  'Uint64List',
};
const _numbers = {'int', 'double', 'num'};
const _byteSinks = {'Socket', 'IOSink', 'HttpResponse', 'HttpClientRequest'};
const _sinks = {
  ..._byteSinks,
  'StreamController',
  'StreamSink',
  'EventSink',
  'MultiStreamController',
  'WebSocket',
};
const _streams = {
  'Socket',
  'ReceivePort',
  'HttpServer',
  'HttpClientResponse',
  'HttpRequest',
  'RawSocket',
  'RawServerSocket',
  'RawDatagramSocket',
  'WebSocket',
};
const _fileSystem = {'File', 'Directory'};

final _stream1 = NativeFunction(
  (visitor, positional, named, types) =>
      Stream<dynamic>.value(positional.first),
  arity: 1,
  name: 'stream1',
);

/// Arguments that depend on what KIND of receiver the member is called on.
/// Built fresh on every call, because the walk calls it once per side: an
/// argument that is itself a single-subscription stream would otherwise be
/// consumed by the subtype invocation and fail the supertype one.
List<Object?>? _receiverArgs(String cls, String m) {
  if (_intLists.contains(cls) || _floatLists.contains(cls)) {
    final Object seven = _floatLists.contains(cls) ? 7.0 : 7;
    final Object one = _floatLists.contains(cls) ? 1.0 : 1;
    switch (m) {
      case '[]':
        return [0];
      case '[]=':
        return [0, seven];
      case 'contains':
      case 'indexOf':
      case 'lastIndexOf':
        return [one];
      case 'fillRange':
        return [0, 1, seven];
      case 'setAll':
        return [
          0,
          <dynamic>[seven],
        ];
      case 'setRange':
        return [
          0,
          1,
          <dynamic>[seven],
        ];
      // Doubles into a float list. A typed-list adapter applies Dart's rule
      // that an int LITERAL in a `double` context is a double (SCD29); the
      // generic `Iterable` adapter cannot know the element type and appends
      // the ints as they are. A float list always dispatches to its own
      // bridge, so that difference is unreachable from a script — the recipe
      // states the argument a script's `[7.0, 8.0]` would be.
      case 'followedBy':
        return [
          <dynamic>[seven, _floatLists.contains(cls) ? 8.0 : 8],
        ];
    }
    return null;
  }
  if (_numbers.contains(cls)) {
    switch (m) {
      case '%':
      case '*':
      case '+':
      case '-':
      case '/':
      case '~/':
      case 'remainder':
      case 'compareTo':
      case 'toStringAsExponential':
      case 'toStringAsFixed':
        return [2];
      case 'toStringAsPrecision':
        return [3];
      case 'clamp':
        return [0, 5];
      case 'unary-':
      case 'abs':
      case 'ceil':
      case 'ceilToDouble':
      case 'floor':
      case 'floorToDouble':
      case 'round':
      case 'roundToDouble':
      case 'toDouble':
      case 'toInt':
      case 'truncate':
      case 'truncateToDouble':
        return const <Object?>[];
    }
    return null;
  }
  switch ((cls, m)) {
    case ('BigInt', 'compareTo'):
      return [BigInt.two];
    case ('DateTime', 'compareTo'):
      return [DateTime.utc(2021)];
    case ('Duration', 'compareTo'):
      return [const Duration(seconds: 1)];
    case ('String', 'compareTo'):
      return ['abd'];
    case ('String', 'allMatches'):
      return ['b'];
    case ('String', 'matchAsPrefix'):
      return ['a'];
    case ('RegExp', 'allMatches'):
      return ['abcb'];
    case ('RegExp', 'matchAsPrefix'):
      return ['bc'];
    case ('RegExpMatch', '[]'):
    case ('RegExpMatch', 'group'):
      return [1];
    case ('RegExpMatch', 'groups'):
      return [
        <int>[0, 1],
      ];
    case ('WebSocketTransformer', 'bind'):
      return [Stream<HttpRequest>.empty()];
  }
  if (_fileSystem.contains(cls)) {
    return switch (m) {
      'rename' || 'renameSync' => ['$_absentPath.renamed'],
      _ => const <Object?>[],
    };
  }
  if (cls == 'StringBuffer' || _sinks.contains(cls)) {
    final bytes = _byteSinks.contains(cls);
    switch (m) {
      case 'add':
        return [
          bytes ? <int>[104] : 'x',
        ];
      case 'addError':
        return ['boom'];
      case 'addStream':
        return [
          bytes
              ? Stream<List<int>>.value(<int>[104])
              : Stream<dynamic>.value('x'),
        ];
      case 'write':
      case 'writeln':
        return ['x'];
      case 'writeAll':
        return [
          <dynamic>['x', 'y'],
        ];
      case 'writeCharCode':
        return [65];
      case 'close':
      case 'flush':
        return const <Object?>[];
    }
  }
  if (_streams.contains(cls)) {
    switch (m) {
      case 'listen':
      case 'handleError':
        return [_pred1];
      case 'asyncMap':
        return [_ident1];
      case 'asyncExpand':
        return [_stream1];
      case 'timeout':
        return [const Duration(milliseconds: 200)];
      case 'pipe':
        return [StreamController<dynamic>()..stream.listen(null)];
      case 'transform':
        return [
          cls == 'Socket'
              ? StreamTransformer<Uint8List, dynamic>.fromHandlers()
              : StreamTransformer<dynamic, dynamic>.fromHandlers(),
        ];
      case 'distinct':
      case 'drain':
      case 'asBroadcastStream':
        return const <Object?>[];
    }
  }
  return null;
}

/// How a pair of outcomes is counted. Extracted from the walk so the third
/// case is reachable without contriving a registry state that produces it:
/// no ablation of the recipes yields two IDENTICAL `RuntimeD4rtException`s —
/// they differ in message and land in [_PairVerdict.divergent] first — so the
/// branch that keeps `THROW == THROW` from reading as agreement would otherwise
/// be asserted by nothing. `F-SCD152-1` covers it directly.
enum _PairVerdict { compared, divergent, vacuous }

_PairVerdict _verdict(String subOutcome, String supOutcome) {
  if (subOutcome != supOutcome) return _PairVerdict.divergent;
  // `contains`, not `startsWith`: SCE185's async members report a rejection
  // as `Future(THROW RuntimeD4rtException)`, which is just as vacuous.
  if (subOutcome.contains('THROW RuntimeD4rtException')) {
    return _PairVerdict.vacuous;
  }
  return _PairVerdict.compared;
}

/// Stringifies an invocation so two adapters can be compared for behavioural
/// equality — including which exception family escaped, which is the whole
/// point of F-SCC51-1..5.
///
/// SCE185: a `Future` result is awaited and a `Stream` result drained, each
/// within [_settle], so an io member is compared by what it DELIVERS rather
/// than by the type of its handle. When the receiver is a collection its state
/// after the call is appended: a mutating member that returns `void` otherwise
/// compares `Null(null)` with `Null(null)` whatever it did.
Future<String> _outcome(
  FutureOr<Object?> Function() f, [
  Object? receiver,
]) async {
  String result;
  try {
    result = await _describe(f());
  } catch (e) {
    result = 'THROW ${e.runtimeType}';
  }
  if (receiver is Iterable || receiver is Map || receiver is StringBuffer) {
    try {
      result += ' | after: ${await _describe(receiver)}';
    } catch (e) {
      result += ' | after: THROW ${e.runtimeType}';
    }
  }
  return result;
}

/// How long an io result may take to arrive. A result still outstanding is
/// recorded as `pending` / `open` — a state, compared like any other.
const _settle = Duration(milliseconds: 500);

Future<String> _describe(Object? v) async {
  if (v is Future) {
    try {
      return 'Future(${await _describe(await v.timeout(_settle))})';
    } on TimeoutException {
      return 'Future(pending)';
    } catch (e) {
      return 'Future(THROW ${e.runtimeType})';
    }
  }
  if (v is Stream) {
    try {
      return 'Stream(${await _describe(await v.toList().timeout(_settle))})';
    } on TimeoutException {
      return 'Stream(open)';
    } catch (e) {
      return 'Stream(THROW ${e.runtimeType})';
    }
  }
  if (v is Iterable) return 'Iterable(${v.toList()})';
  // `Map.of`, not the map itself: an `HttpSession` prints its random session
  // id, so two fresh sessions holding the same entries would never compare.
  if (v is Map) return 'Map(${Map.of(v)})';
  // Each IOSink fixture writes its own file, so a result naming the file names
  // a different path on each side. What is compared is that it is a File.
  if (v is FileSystemEntity) return v.runtimeType.toString();
  return '${v.runtimeType}($v)';
}

Environment _stdlibEnvironment() {
  final env = Environment();
  Stdlib(env).register();
  CollectionStdlib.register(env);
  // SCE185: the io and isolate bridges shadow Stream, sink and error members
  // too, and are walked like every other bridge.
  IoStdlib.register(env);
  IsolateStdlib.register(env);
  return env;
}

void main() {
  final env = _stdlibEnvironment();
  final visitor = InterpreterVisitor(
    globalEnvironment: env,
    moduleContext: NoOpModuleContext(globalEnvironment: env),
  );

  /// Resolves `<className>.<getter>` the way a script would — through the
  /// bridge for [className], falling back to its registered supertypes — and
  /// reports which exception family escaped.
  Object? read(String className, Object target, String getter) {
    for (final name in [
      className,
      ...BridgedClass.transitiveSupertypeNames(className),
    ]) {
      final adapter = env.findBridgedClassByName(name)?.getters[getter];
      if (adapter != null) return adapter(visitor, target);
    }
    fail('no bridge on $className or its supertypes declares `$getter`');
  }

  String kind(String className, Object target, String getter) {
    try {
      return 'no-throw:${read(className, target, getter)}';
    } on StateError {
      return 'StateError';
    } catch (e) {
      return 'OTHER:${e.runtimeType}';
    }
  }

  // Every bridged collection, paired with an empty and a two-element form.
  // `List` is included deliberately: it is the one that already behaved
  // correctly, so it is the control that says the expectation below is
  // reachable rather than aspirational.
  final nonEmpty = <String, Object Function()>{
    'HashSet': () => HashSet<int>.of([1, 2]),
    'LinkedHashSet': () => <int>{1, 2},
    'SplayTreeSet': () => SplayTreeSet<int>.of([1, 2]),
    'ListQueue': () => ListQueue<int>.of([1, 2]),
    'DoubleLinkedQueue': () => DoubleLinkedQueue<int>.of([1, 2]),
    'UnmodifiableListView': () => UnmodifiableListView<int>([1, 2]),
    'UnmodifiableSetView': () => UnmodifiableSetView<int>(<int>{1, 2}),
    'Set': () => <int>{1, 2},
    'List': () => <int>[1, 2],
  };
  final empty = <String, Object Function()>{
    'HashSet': () => HashSet<int>(),
    'LinkedHashSet': () => <int>{},
    'SplayTreeSet': () => SplayTreeSet<int>(),
    'ListQueue': () => ListQueue<int>(),
    'DoubleLinkedQueue': () => DoubleLinkedQueue<int>(),
    'UnmodifiableListView': () => UnmodifiableListView<int>([]),
    'UnmodifiableSetView': () => UnmodifiableSetView<int>(<int>{}),
    'Set': () => <int>{},
    'List': () => <int>[],
  };

  group('SCC51: shadowed adapters preserve the SDK contract', () {
    test('F-SCC51-1: `single` on a multi-element collection throws a catchable '
        'StateError [2026-09-06]', () {
      for (final e in nonEmpty.entries) {
        expect(
          kind(e.key, e.value(), 'single'),
          'StateError',
          reason:
              '${e.key}.single threw something a script cannot catch as '
              'StateError. Native Dart throws StateError("Too many elements"); '
              'a hand-written RuntimeD4rtException is not catchable by the '
              'handler a Dart author would write.',
        );
      }
    });

    test(
      'F-SCC51-2: `single` on an empty collection throws StateError [2026-09-06]',
      () {
        for (final e in empty.entries) {
          expect(kind(e.key, e.value(), 'single'), 'StateError', reason: e.key);
        }
      },
    );

    test(
      'F-SCC51-3: `first` on an empty collection throws StateError [2026-09-06]',
      () {
        for (final e in empty.entries) {
          expect(kind(e.key, e.value(), 'first'), 'StateError', reason: e.key);
        }
      },
    );

    test(
      'F-SCC51-4: `last` on an empty collection throws StateError [2026-09-06]',
      () {
        for (final e in empty.entries) {
          expect(kind(e.key, e.value(), 'last'), 'StateError', reason: e.key);
        }
      },
    );

    test('F-SCC51-5: LinkedList first/last throw StateError when empty '
        '[2026-09-06]', () {
      // Separated because `LinkedList<E extends LinkedListEntry<E>>` cannot be
      // built from an int, so it does not fit the tables above. It has no
      // `single` adapter to begin with and inherits `Iterable`'s.
      final list = LinkedList<BridgedLinkedListEntry>();
      expect(kind('LinkedList', list, 'first'), 'StateError');
      expect(kind('LinkedList', list, 'last'), 'StateError');
    });

    test('F-SCC51-6: the happy path still returns the element [2026-09-06]', () {
      // The non-vacuity guard. Deleting the shadow adapters must not make the
      // members throw where they previously worked — an inherited adapter that
      // failed to resolve would satisfy every StateError assertion above.
      for (final e in nonEmpty.entries) {
        expect(kind(e.key, e.value(), 'first'), 'no-throw:1', reason: e.key);
        expect(kind(e.key, e.value(), 'last'), 'no-throw:2', reason: e.key);
      }
      expect(kind('List', <int>[7], 'single'), 'no-throw:7');
      expect(kind('HashSet', HashSet<int>.of([7]), 'single'), 'no-throw:7');
    });

    test('F-SCC51-7: ordered collections still report THEIR first and last '
        '[2026-09-06]', () {
      // The sharper non-vacuity guard, and the one that pins that dispatch
      // still lands on the right native object. `SplayTreeSet` sorts, so its
      // `first` is the smallest rather than the first inserted; a
      // `LinkedHashSet` on the same input reports insertion order. If the
      // inherited adapter were somehow reading a copy, these would agree.
      final splay = SplayTreeSet<int>.of([5, 1, 9]);
      expect(read('SplayTreeSet', splay, 'first'), 1);
      expect(read('SplayTreeSet', splay, 'last'), 9);
      final linked = <int>{5, 1, 9};
      expect(read('LinkedHashSet', linked, 'first'), 5);
      expect(read('LinkedHashSet', linked, 'last'), 9);
      expect(read('ListQueue', ListQueue<int>.of([5, 1, 9]), 'first'), 5);
    });

    // SCD152. The verdict rule decides what the two counters above mean, and
    // its third case cannot be reached by ablating the recipes — two adapters
    // rejecting the same bad arguments produce DIFFERENT messages, so they are
    // reported as a divergence before the vacuous branch is consulted.
    // Asserted directly for that reason.
    test('F-SCD152-1: identical rejections are not counted as agreement '
        '[2026-09-15]', () {
      expect(
        _verdict('Iterable([1, 2])', 'Iterable([1, 2])'),
        _PairVerdict.compared,
        reason: 'two adapters returning the same value is the passing case',
      );
      expect(
        _verdict('int(3)', 'Null(null)'),
        _PairVerdict.divergent,
        reason:
            'the shape of the `[]=` divergence SCD152 found — same call, '
            'different result',
      );
      expect(
        _verdict('THROW StateError', 'THROW StateError'),
        _PairVerdict.compared,
        reason:
            'an SDK error on both sides IS meaningful agreement: it is what '
            'F-SCC51-1..5 are about, so it must stay a comparison',
      );
      expect(
        _verdict('THROW RuntimeD4rtException', 'THROW RuntimeD4rtException'),
        _PairVerdict.vacuous,
        reason:
            'a D4rt-level rejection on both sides means the harness supplied '
            'arguments neither adapter accepted. Counting that as a comparison '
            'is how a differential hollows out while staying green.',
      );
    });

    test('F-SCC51-8: no shadowed adapter behaves differently from the '
        'supertype adapter it hides [2026-09-06]', () async {
      // The standing guard, and the reason this file is not a 300-name
      // allowlist. For every member a subtype bridge redeclares from a
      // registered supertype, invoke BOTH adapters on the SAME native object
      // with the SAME arguments and compare the outcomes. A name collision
      // costs nothing; only a behavioural divergence does.
      //
      // The expected set is EMPTY, not an allowlist. Every divergence found so
      // far has been a defect (`addEntries` in SCB17, `firstKey` in SCC10,
      // `first`/`last`/`single` above), so a new entry here is a finding, not a
      // line to append. If a subtype ever genuinely needs different behaviour,
      // the deliberate way to express it is to make the difference invisible to
      // this harness — as `setAlgebraMethods` does by coercing rather than
      // copying, so the native leaf's override runs and `SplayTreeSet.union`
      // stays sorted while sharing one adapter body.
      var compared = 0;
      var undrivable = 0;
      var vacuous = 0;
      final diffs = <String>[];
      final noRecipe = <String>{};
      final noBridge = <String>[];

      // SCD152: a member with no recipe is COUNTED, never invoked with whatever
      // `_args` happens to hold. An adapter called with the wrong arguments
      // throws on both sides, and THROW == THROW would be recorded as agreement
      // — the quietest way for this guard to hollow out as the bridges grow.
      // SCE185: the recipe is evaluated once PER SIDE, so an argument that is
      // itself single-use (a stream to `addStream`) reaches both adapters.
      List<Object?>? recipe(String name, String m) =>
          _receiverArgs(name, m) ??
          _classArgs['$name.$m'] ??
          _args[m] ??
          _callableArgs(name, m);

      _net = await _Net.start();
      try {
        for (final name in _fixtures.keys) {
          final sub = env.findBridgedClassByName(name);
          if (sub == null) {
            noBridge.add(name);
            continue;
          }
          for (final sname in BridgedClass.transitiveSupertypeNames(name)) {
            final sup = env.findBridgedClassByName(sname);
            if (sup == null) continue;

            for (final m in sub.methods.keys.toSet().intersection(
              sup.methods.keys.toSet(),
            )) {
              if (recipe(name, m) == null) {
                undrivable++;
                noRecipe.add('$name.$m');
                continue;
              }
              final subTarget = await _fixtures[name]!();
              final a = await _outcome(
                () => sub.methods[m]!(
                  visitor,
                  subTarget,
                  recipe(name, m)!,
                  {},
                  [],
                ),
                subTarget,
              );
              final supTarget = await _fixtures[name]!();
              final b = await _outcome(
                () => sup.methods[m]!(
                  visitor,
                  supTarget,
                  recipe(name, m)!,
                  {},
                  [],
                ),
                supTarget,
              );
              switch (_verdict(a, b)) {
                case _PairVerdict.divergent:
                  diffs.add('$name -> $sname .$m()  sub: $a  sup: $b');
                case _PairVerdict.vacuous:
                  // Both adapters rejected the arguments. That is agreement
                  // about nothing, so it is not counted as a comparison.
                  vacuous++;
                case _PairVerdict.compared:
                  compared++;
              }
            }

            for (final g in sub.getters.keys.toSet().intersection(
              sup.getters.keys.toSet(),
            )) {
              // `hashCode` is read off ONE shared instance: two separately
              // constructed fixtures differ for reasons that say nothing about
              // the adapters. Everything else gets a fresh receiver per side,
              // because a Stream getter (`first`, `length`) consumes a
              // single-subscription receiver.
              final shared = g == 'hashCode' ? await _fixtures[name]!() : null;
              final subTarget = shared ?? await _fixtures[name]!();
              final a = await _outcome(
                () => sub.getters[g]!(visitor, subTarget),
              );
              final supTarget = shared ?? await _fixtures[name]!();
              final b = await _outcome(
                () => sup.getters[g]!(visitor, supTarget),
              );
              compared++;
              if (a != b) {
                diffs.add('$name -> $sname .$g  sub: $a  sup: $b');
              }
            }
          }
        }
      } finally {
        await _net.close();
      }

      expect(
        noBridge,
        isEmpty,
        reason:
            'These fixture rows name no registered bridge, so the walk skipped '
            'them without comparing anything: $noBridge',
      );
      expect(
        diffs,
        isEmpty,
        reason:
            'A subtype bridge adapter behaves differently from the supertype '
            'adapter it shadows. Either the subtype copy is a latent defect '
            '(delete it — the inherited one is right), or the difference is '
            'deliberate and belongs in a coercing shared adapter rather than a '
            'divergent copy.',
      );

      // Non-vacuity: the walk must actually reach the shadowed pairs. A
      // registry that silently stopped returning supertypes would make the
      // assertion above pass by comparing nothing.
      //
      // SCD152 raised this floor from 200 to 500, when the walk covered the
      // fourteen collection bridges and compared 537 pairs of them. SCE185
      // widened it to every shadowing bridge: 2 028 pairs compared, measured
      // 2026-09-25 — the registry's 2 076 less the 34 on the two `_unwalked`
      // bridges and the 14 shadowed copies SCE185 deleted (thirteen on `Runes`,
      // `WebSocketTransformer.cast`). SCE195 then deleted `ServerSocket`'s 28,
      // leaving 2 000.
      expect(
        compared,
        greaterThan(1950),
        reason:
            'compared=$compared undrivable=$undrivable vacuous=$vacuous — '
            'the differential walk found far fewer shadowed pairs than the '
            '~2 000 known to exist, so the supertype registry or the bridge '
            'registration changed shape.',
      );

      // SCD152. The two ways this guard can stop measuring without failing,
      // both counted rather than assumed away. `undrivable` is a shadowed
      // member `_callableArgs` has no recipe for; `vacuous` is a pair where
      // both adapters rejected the arguments, which is agreement about
      // nothing. Both are zero today, and an assertion is the only thing that
      // keeps them so — the old skip set reached 261 precisely because nothing
      // objected to it growing.
      expect(
        undrivable,
        isZero,
        reason:
            'No recipe for: $noRecipe. Add one to `_callableArgs` — a member '
            'left out is a member this guard does not check, which is how the '
            'callback-taking half of the surface went unmeasured until SCD152.',
      );
      expect(
        vacuous,
        isZero,
        reason:
            '$vacuous shadowed pairs threw `RuntimeD4rtException` on BOTH '
            'sides, so they agree only about rejecting the arguments the '
            'harness supplied. Fix the recipe in `_callableArgs` rather than '
            'reading THROW == THROW as a passing comparison.',
      );
    });

    test('F-SCE185-1: every bridge that shadows a supertype member is walked, '
        'or named in `_unwalked` with the reason it cannot be [2026-09-25]', () {
      // The defect SCE185 fixed was not a wrong comparison but a MISSING one:
      // the walk covered 537 of 2 076 shadowed pairs and nothing said so. This
      // is the census that would have. It is computed from the registry, so a
      // new bridge that shadows anything turns this red until it has a fixture.
      final shadowing = <String>{};
      for (final name in env.bridgedClassNames) {
        final sub = env.findBridgedClassByName(name)!;
        for (final sname in BridgedClass.transitiveSupertypeNames(name)) {
          final sup = env.findBridgedClassByName(sname);
          if (sup == null) continue;
          if (sub.methods.keys.any(sup.methods.containsKey) ||
              sub.getters.keys.any(sup.getters.containsKey)) {
            shadowing.add(name);
          }
        }
      }
      final accounted = {..._fixtures.keys, ..._unwalked.keys};
      expect(
        shadowing.difference(accounted),
        isEmpty,
        reason:
            'These bridges redeclare a supertype member and the differential '
            'never compares them. Add a `_fixtures` row (and recipes), or an '
            '`_unwalked` entry saying why no fixture can exist.',
      );
      expect(
        accounted.difference(shadowing),
        isEmpty,
        reason:
            'These rows name a bridge that no longer shadows anything; delete '
            'them so the table stays a description of the registry.',
      );
      expect(
        _fixtures.keys.toSet().intersection(_unwalked.keys.toSet()),
        isEmpty,
      );
      // Control: the census itself must see the surface. Measured 2026-09-25:
      // 92 shadowing bridges over the stdlib registry.
      expect(shadowing.length, greaterThanOrEqualTo(85));
    });
  });

  // SCE185's findings, asserted on the behaviour a script sees rather than only
  // as agreement between two adapters. Each was a defect the widened walk
  // reported, and each is resolved here the way a script's call resolves: by
  // the receiver's own bridge first, then its registered supertypes.
  Object? call(
    String className,
    Object target,
    String member, [
    List<Object?> args = const [],
  ]) {
    final adapter = findReachableMethod(env, className, member);
    if (adapter == null) {
      fail('no bridge on $className or its supertypes declares `$member`');
    }
    return adapter(visitor, target, args, {}, []);
  }

  group('SCE185: what the widened differential found', () {
    test('F-SCE195-1: ServerSocket declares only what it adds over Stream, and '
        'its connections still arrive through the inherited listen '
        '[2026-09-25]', () async {
      // LAYOUT: the bridge's own member map is the subject. sce195 deleted the
      // 28 `Stream` copies `ServerSocket` spelled out, once F-SCC51-8 showed
      // every pair agreeing. A deletion is protected only by an assertion that
      // fails when the copy comes back — without this, the next reader restores
      // them as an oversight.
      final own = env.findBridgedClassByName('ServerSocket')!;
      final base = env.findBridgedClassByName('Stream')!;
      expect(
        own.methods.keys.toSet().intersection(base.methods.keys.toSet()),
        isEmpty,
      );
      expect(
        own.getters.keys.toSet().intersection(base.getters.keys.toSet()),
        isEmpty,
      );

      // `listen` is a server socket's primary use, so it is driven for real:
      // a connection accepted through the inherited adapter.
      final accepted = <Object?>[];
      final accept = NativeFunction(
        (visitor, positional, named, types) {
          accepted.add(positional.first);
          return null;
        },
        arity: 1,
        name: 'accept',
      );
      final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
      final subscription =
          findReachableMethod(env, 'ServerSocket', 'listen')!(
                visitor,
                server,
                [accept],
                {},
                [],
              )
              as StreamSubscription;
      final client = await Socket.connect(server.address, server.port);
      await Future<void>.delayed(const Duration(milliseconds: 200));
      expect(accepted, hasLength(1));
      expect(accepted.single, isA<Socket>());
      client.destroy();
      (accepted.single as Socket).destroy();
      await subscription.cancel();
      await server.close();
    });

    test('F-SCE185-2: Runes members that take a callback run it '
        '[2026-09-25]', () {
      // Thirteen `Runes` copies cast the script's callback to a Dart function
      // type, which a `Callable` never is, so every call threw `_TypeError`.
      final runes = 'abc'.runes;
      expect(
        (call('Runes', runes, 'where', [_greaterThan97]) as Iterable).toList(),
        [98, 99],
      );
      expect(call('Runes', runes, 'fold', [0, _sum2]), 294);
      expect(call('Runes', runes, 'any', [_greaterThan97]), isTrue);
      expect(call('Runes', runes, 'reduce', [_sum2]), 294);
    });

    test('F-SCE185-3: LinkedList.contains answers false for a non-entry '
        '[2026-09-25]', () {
      expect(
        call('LinkedList', LinkedList<BridgedLinkedListEntry>(), 'contains', [
          1,
        ]),
        isFalse,
      );
    });

    test('F-SCE185-4: List.shuffle honours the Random it is given '
        '[2026-09-25]', () {
      final expected = [1, 2, 3, 4, 5, 6, 7, 8]..shuffle(Random(3));
      final list = <dynamic>[1, 2, 3, 4, 5, 6, 7, 8];
      call('List', list, 'shuffle', [Random(3)]);
      expect(list, expected);
    });

    test('F-SCE185-5: a natively typed List<int> takes a script\'s list '
        'literal and callback [2026-09-25]', () {
      // `'ab'.codeUnits.toList()` is the shape: a real `List<int>` that
      // dispatches to the `List` bridge, handed arguments that are
      // `List<Object?>` and an untyped callback, as a script's always are.
      final list = 'ab'.codeUnits.toList();
      expect(
        (call('List', list, 'followedBy', [
                  <Object?>[1],
                ])
                as Iterable)
            .toList(),
        [97, 98, 1],
      );
      expect(call('List', list, 'reduce', [_sum2]), 195);
      call('List', list, 'setRange', [
        0,
        1,
        <Object?>[7],
      ]);
      expect(list, [7, 98]);
      expect(
        () => call('List', list, 'setRange', [
          0,
          2,
          <Object?>[7],
        ]),
        throwsStateError,
      );
    });

    test('F-SCE185-6: a natively typed Stream takes a script\'s transformer '
        'and combine callback [2026-09-25]', () async {
      Stream<int> stream() => Stream<int>.fromIterable([1, 2, 3]);
      expect(await (call('Stream', stream(), 'reduce', [_sum2]) as Future), 6);
      final transformed = call('Stream', stream(), 'transform', [
        StreamTransformer<dynamic, dynamic>.fromHandlers(
          handleData: (v, sink) => sink.add(v * 10),
        ),
      ]);
      expect(await (transformed as Stream).toList(), [10, 20, 30]);
    });

    test('F-SCE185-7: Sink.close hands back the Future the sink returns '
        '[2026-09-25]', () async {
      final controller = StreamController<dynamic>();
      final drained = controller.stream.toList();
      final closing = findReachableMethod(env, 'Sink', 'close')!(
        visitor,
        controller,
        const [],
        {},
        [],
      );
      expect(closing, isA<Future<void>>());
      await (closing! as Future);
      expect(await drained, isEmpty);
    });
  });
}
