// REPO-WIDE GUARD (tom_d4rt_ast) — no SDK private implementation type is left unclaimed by a nativeNames list.
//
// Its subject reaches OUTSIDE this package, so it runs only when tom_d4rt_ast's suite
// runs and a session working elsewhere in the repo reaches none of it. SCD129
// made that arrangement visible rather than incidental: `grep -rn 'REPO-WIDE
// GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
// SCC24 — mechanical detection of unclaimed SDK implementation types.
//
// THE DEFECT SHAPE
//
// A `BridgedClass` claims the SDK's private implementation types by listing
// their names in `nativeNames`. A type that is not listed resolves to no
// bridge, so the value comes back from the interpreter successfully and is then
// completely inert: every member on it fails with "Undefined property or method
// 'x' on _Whatever". The value looks fine right up to the moment anything is
// done with it.
//
// It had been found four times by accident before this file existed — SC4
// (`_StreamSinkWrapper`, what `StreamController.sink` returns), SC9
// (the JSON/UTF-8 fused encoder), SCB9 (`_HandleErrorStream`, what
// `Stream.handleError` returns), and the `Iterator` bridge's own comment
// records a fifth round. Twice in the same file, one method apart. That is what
// makes this a test about the mechanism rather than about another missing name.
//
// THE SECOND-ORDER EFFECT, which is why "we would have noticed" is false: a
// missing name does not merely break the value, it suppresses the tests that
// would have exercised the code behind it. If `Stream.handleError` cannot be
// used, nobody writes a test that uses it — so SCB9's arity bug survived
// underneath. Every gap this file found on its first run reproduced that
// pattern exactly: `Codec.inverted` had ZERO uses anywhere in the suite, the
// general `Converter.fuse` path had none (only the Codec-level fuse was
// tested), and the suite's single `File.openRead` call passed the result
// straight into `addStream` without ever calling a member on it.
//
// WHY NO PRIVATE TYPE NAME APPEARS IN THIS FILE
//
// The private names are SDK internals: not reachable from public API, different
// across SDK versions, and pinning them here would trade this bug for a
// version-fragility bug. So every value below is produced by an ordinary public
// call and the resolver is asked what claims the result — whatever the SDK
// happened to return. When the SDK renames an internal type this test keeps
// working and starts failing for the right reason.
//
// WHAT "RESOLVES" MEANS, AND WHY NOT A SCRIPT
//
// [Environment.toBridgedInstance] is the primitive the interpreter uses to turn
// a native object into something a script can call members on. Asserting on it
// directly is strictly stronger than driving a script: a script probe only sees
// "threw" versus "did not throw", whereas the resolver can also return the
// WRONG bridge through its fuzzy name-prefix fallback — which a script would
// only notice if it happened to call a member the wrong bridge lacks. Being
// script-free also lets `tom_d4rt_ast` carry this file verbatim; that package
// has no parser, so a script probe could not be mirrored there at all.
//
// HOW THE MECHANICAL SWEEP WORKS (F-SCC24-1)
//
// `BridgedInstanceGetterAdapter` takes a NULLABLE visitor, so every instance
// getter on every registered bridge can be invoked directly against a real
// native target. Given one canonical instance per bridge, the sweep reaches
// several hundred return values with no knowledge of return types, no argument
// construction and no name list — it simply asks every getter for its value and
// resolves whatever comes back. Members that take arguments cannot be reached
// this way and are covered by the explicit probe tables below.
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:mirrors';
import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/src/runtime/bridge/bridged_types.dart';
// `Environment.toBridgedInstance` is this file's entire subject, so the
// dependency is declared directly rather than leaning on a stdlib barrel that
// happens to re-export it today.
// ignore: unnecessary_import
import 'package:tom_d4rt_ast/src/runtime/environment.dart';
import 'package:tom_d4rt_ast/src/runtime/exceptions.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/async/stream.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/async/stream_controller.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/stdlib.dart';

import 'tls_fixture.dart';

// ---------------------------------------------------------------------------
// Infrastructure
// ---------------------------------------------------------------------------

/// One probe: the bridged member it stands for, a factory performing the real
/// public SDK call, and the bridge that must claim the result.
class _Probe {
  const _Probe(this.member, this.produce, this.expected);

  /// The bridged member name this exercises. Read by the coverage guard so the
  /// probe table cannot silently fall behind the bridge definition.
  final String member;

  /// An ordinary public SDK call. Its return type is whatever the SDK chooses;
  /// this file never names it.
  final Object? Function() produce;

  /// The bridge that must claim the produced value.
  final String expected;
}

/// A realistic environment — the same registration a script gets, plus the
/// libraries that are otherwise loaded on demand.
Environment _stdlibEnvironment() {
  final env = Environment();
  Stdlib(env).register();
  CollectionStdlib.register(env);
  ConvertStdlib.register(env);
  IoStdlib.register(env);
  return env;
}

/// Every bridge registered in [env], keyed by bridge name.
Map<String, BridgedClass> _allBridges(Environment env) {
  final all = <String, BridgedClass>{};
  for (final name in env.bridgedClassNames) {
    for (final bridge in env.findAllBridgedClassesByName(name)) {
      all[bridge.name] = bridge;
    }
  }
  return all;
}

/// Resolve [value] and return the claiming bridge's name, or a description of
/// the failure. Never throws, so one run reports EVERY gap instead of stopping
/// at the first.
String _resolvedBridgeName(Environment env, Object? value) {
  try {
    final instance = env.toBridgedInstance(value);
    if (instance == null) return '<null instance>';
    return instance.bridgedClass.name;
  } on RuntimeD4rtException {
    return '<inert: no bridge>';
  }
}

/// Run [probes] and return `member -> actual` for every one whose result did
/// not resolve to its expected bridge.
Map<String, String> _gaps(Iterable<_Probe> probes) {
  final env = _stdlibEnvironment();
  final gaps = <String, String>{};
  for (final probe in probes) {
    final Object? value;
    try {
      value = probe.produce();
    } catch (e) {
      gaps[probe.member] = '<probe threw: $e>';
      continue;
    }
    final actual = _resolvedBridgeName(env, value);
    if (actual != probe.expected) {
      gaps[probe.member] = '$actual (expected ${probe.expected})';
    }
  }
  return gaps;
}

// ---------------------------------------------------------------------------
// Canonical instances for the mechanical getter sweep
// ---------------------------------------------------------------------------

final class _ListEntry extends LinkedListEntry<_ListEntry> {}

/// One real native instance per bridge, so the sweep has something to call
/// getters on. A bridge with no entry here is skipped — F-SCC24-9 pins how many
/// those are, so the blind spot cannot grow unnoticed.
Map<String, Object> _canonicalInstances() => {
  // dart:core
  'Iterable': <int>[1].map((e) => e),
  'List': <int>[1],
  'Set': <int>{1},
  'Map': <String, int>{'a': 1},
  'MapEntry': const MapEntry('a', 1),
  'Runes': 'a'.runes,
  'String': 'abc',
  'int': 1,
  'double': 1.0,
  'num': 1,
  'bool': true,
  'Duration': const Duration(seconds: 1),
  'DateTime': DateTime(2026),
  'Uri': Uri.parse('https://example.com/a?b=c'),
  'RegExp': RegExp('a'),
  'RegExpMatch': RegExp('a').firstMatch('a')!,
  'Match': RegExp('a').firstMatch('a')!,
  'StringBuffer': StringBuffer('a'),
  'Stopwatch': Stopwatch(),
  'Error': StateError('x'),
  'Exception': const FormatException('x'),
  'StackTrace': StackTrace.current,
  'Symbol': #a,
  'Type': int,
  'BigInt': BigInt.one,
  // `Iterator` is the bridge SCC24 widened three names on, so the sweep
  // has to be able to see it. A `List` iterator is the one implementation
  // that was never missing, which is precisely why it is a safe canonical
  // instance: the sweep tests the bridge's GETTERS, and the names are
  // covered by the probe tables below.
  'Iterator': <int>[1].iterator,
  'Object': Object(),
  'Comparable': 1,
  'Pattern': RegExp('a'),
  'Function': _canonicalInstances,
  'StringSink': StringBuffer('a'),
  'Invocation': Invocation.getter(#a),
  'Enum': _CanonicalEnum.value,
  // Error and exception types. Cheap to construct and they carry real
  // getters (`message`, `stackTrace`, `invalidValue`) whose results are
  // exactly the kind of value that goes inert unnoticed.
  'ArgumentError': ArgumentError.value(1, 'n', 'bad'),
  'StateError': StateError('x'),
  'RangeError': RangeError.range(1, 2, 3),
  'IndexError': IndexError.withLength(1, 1),
  'FormatException': const FormatException('x'),
  'TypeError': _typeError(),
  'UnimplementedError': UnimplementedError('x'),
  'UnsupportedError': UnsupportedError('x'),
  // Both of this type's getters are always null, which is exactly the shape
  // the sweep exists to check: a getter returning null is indistinguishable
  // from one that has gone inert unless something asserts it is *reachable*.
  // ignore: deprecated_member_use
  'IntegerDivisionByZeroException': IntegerDivisionByZeroException(),
  'AssertionError': AssertionError('x'),
  'ConcurrentModificationError': ConcurrentModificationError(<int>[]),
  'NoSuchMethodError': NoSuchMethodError.withInvocation(
    1,
    Invocation.getter(#a),
  ),
  // dart:async
  'Future': Future.value(1),
  'AsyncError': AsyncError(StateError('x'), StackTrace.current),
  'TimeoutException': TimeoutException('x', const Duration(seconds: 1)),
  'Stream': Stream<int>.fromIterable(const [1]),
  'StreamController': StreamController<int>(),
  'StreamSubscription': Stream<int>.fromIterable(const [1]).listen(null),
  'StreamSink': StreamController<int>().sink,
  'Completer': Completer<int>(),
  'StreamIterator': StreamIterator<int>(const Stream<int>.empty()),
  'Timer': Timer(const Duration(days: 1), () {}),
  // dart:collection
  'Queue': Queue<int>()..add(1),
  'ListQueue': ListQueue<int>()..add(1),
  'DoubleLinkedQueue': DoubleLinkedQueue<int>()..add(1),
  'HashMap': HashMap<String, int>()..['a'] = 1,
  // Named constructors, not literals: each entry has to state which native
  // type it stands for, and `<String, int>{}` would make this line
  // textually identical to the `Map` entry above.
  // ignore: prefer_collection_literals
  'LinkedHashMap': LinkedHashMap<String, int>()..['a'] = 1,
  'SplayTreeMap': SplayTreeMap<String, int>()..['a'] = 1,
  'HashSet': HashSet<int>()..add(1),
  // ignore: prefer_collection_literals
  'LinkedHashSet': LinkedHashSet<int>()..add(1),
  'SplayTreeSet': SplayTreeSet<int>()..add(1),
  'UnmodifiableListView': UnmodifiableListView<int>(const [1]),
  'UnmodifiableMapView': UnmodifiableMapView<String, int>({'a': 1}),
  'UnmodifiableSetView': UnmodifiableSetView<int>({1}),
  'LinkedList': LinkedList<_ListEntry>()..add(_ListEntry()),
  'LinkedListEntry': _linkedEntry(),
  'DoubleLinkedQueueEntry': (DoubleLinkedQueue<int>()..add(1)).firstEntry()!,
  // dart:convert
  'Codec': utf8,
  'Encoding': utf8,
  'Utf8Codec': utf8,
  'AsciiCodec': ascii,
  'Latin1Codec': latin1,
  'Base64Codec': base64,
  'JsonCodec': json,
  'Converter': utf8.decoder,
  'Utf8Decoder': utf8.decoder,
  'Utf8Encoder': utf8.encoder,
  'AsciiDecoder': ascii.decoder,
  'AsciiEncoder': ascii.encoder,
  'Latin1Decoder': latin1.decoder,
  'Latin1Encoder': latin1.encoder,
  'Base64Decoder': base64.decoder,
  'Base64Encoder': base64.encoder,
  'JsonDecoder': json.decoder,
  'JsonEncoder': json.encoder,
  'JsonUtf8Encoder': JsonUtf8Encoder(),
  'LineSplitter': const LineSplitter(),
  'HtmlEscape': const HtmlEscape(),
  'HtmlEscapeMode': HtmlEscapeMode.element,
  // dart:typed_data. All of these share `_TypedListIterator`, one of the
  // names SCC24 added, so covering the whole family is not redundant —
  // it is the family the fix was for.
  'Uint8List': Uint8List(1),
  'Uint8ClampedList': Uint8ClampedList(1),
  'Uint16List': Uint16List(1),
  'Uint32List': Uint32List(1),
  'Uint64List': Uint64List(1),
  'Int8List': Int8List(1),
  'Int16List': Int16List(1),
  'Int32List': Int32List(1),
  'Int64List': Int64List(1),
  'Float32List': Float32List(1),
  'Float64List': Float64List(1),
  'ByteData': ByteData(8),
  'ByteBuffer': Uint8List(1).buffer,
  'TypedData': Uint8List(1),
  'Endian': Endian.little,
  // dart:io
  'File': File('pubspec.yaml'),
  'Directory': Directory('.'),
  'FileStat': File('pubspec.yaml').statSync(),
  'FileSystemEntity': File('pubspec.yaml'),
  'HttpClient': HttpClient(),
  // A plain data holder with a default constructor — the only one of the six
  // types SCC62 bridged that can be built without a live connection. The other
  // four are in `_liveInstances`.
  'HttpConnectionsInfo': HttpConnectionsInfo(),
  // Not an enum despite reading like one: a final class with a private
  // constructor and three static const instances, so a constant is the only
  // way to get one.
  'SameSite': SameSite.lax,
  'ContentType': ContentType.json,
  'HeaderValue': HeaderValue('a', const {'b': 'c'}),
  'Cookie': Cookie('a', 'b'),
  'InternetAddress': InternetAddress.loopbackIPv4,
  'InternetAddressType': InternetAddressType.IPv4,
  'FileSystemException': const FileSystemException('x', 'p'),
  'PathAccessException': const PathAccessException('p', OSError('x')),
  'PathExistsException': const PathExistsException('p', OSError('x')),
  'PathNotFoundException': const PathNotFoundException('p', OSError('x')),
  'SocketException': const SocketException('x'),
  // `IOException` has no entry: it is abstract, declares no getters, and any
  // instance would really be one of the leaves above — so a canonical instance
  // would sweep a subclass's members under the base name.
  'HttpException': const HttpException('x'),
  // An empty redirect list is enough for the sweep: `uri` reads through the
  // list and returns null for an empty one, which is exactly the shape that
  // goes inert unnoticed unless something asserts it is reachable. A populated
  // one would sweep `RedirectInfo`'s getters under this name; the real thing is
  // in `_liveInstances`.
  'RedirectException': const RedirectException('x', <RedirectInfo>[]),
  // An enum, so a constant is the only instance there is. Its `name` and
  // `index` are the getters the sweep reads.
  'HttpClientResponseCompressionState':
      HttpClientResponseCompressionState.notCompressed,
  'WebSocketException': const WebSocketException('x'),
  // The one member of the WebSocket block with a public constructor. The socket
  // itself needs a handshake and is in the live map below; `WebSocketStatus` and
  // `WebSocketTransformer` declare no instance getters and so are not swept.
  'CompressionOptions': CompressionOptions.compressionDefault,
  'UriData': UriData.fromString('a'),
  // The bridge SCC24 had to ADD: `osError` on the four exceptions above
  // returned an unbridged value. Covered here so a later refactor that
  // drops the registration is caught by the sweep, not by a script.
  'OSError': const OSError('x', 1),
  'BytesBuilder': BytesBuilder()..addByte(1),
  'ProcessSignal': ProcessSignal.sigint,
  'StdioType': StdioType.terminal,
  'ProcessResult': ProcessResult(0, 0, '', ''),
  'RandomAccessFile': File('pubspec.yaml').openSync(),
  'IOSink': IOSink(StreamController<List<int>>()),
  'Datagram': Datagram(Uint8List(1), InternetAddress.loopbackIPv4, 1),
  'RawSocketOption': RawSocketOption.fromInt(0, 0, 0),
  // SCD78 — filed as "not publicly constructible", and both are. `const
  // OutOfMemoryError()` and `StackOverflowError()` are ordinary public
  // constructors; nothing stood in the way of sweeping them but the claim.
  'OutOfMemoryError': OutOfMemoryError(),
  'StackOverflowError': StackOverflowError(),
  // dart:convert sinks
  'Sink': ByteConversionSink.withCallback((_) {}),
  'ByteConversionSink': ByteConversionSink.withCallback((_) {}),
  'StringConversionSink': StringConversionSink.withCallback((_) {}),
  'ClosableStringSink': StringConversionSink.withCallback(
    (_) {},
  ).asStringSink(),
};

/// The six `dart:io` types that only exist inside a live connection.
///
/// `HttpRequest`, `HttpResponse`, `HttpSession`, `HttpConnectionInfo`,
/// `WebSocket` and `RedirectInfo` have no usable public constructor — the SDK
/// hands the first four to a request handler and nowhere else, a `WebSocket`
/// exists only on the far side of a completed upgrade handshake, and a
/// `RedirectInfo` only inside an `HttpClient` that actually followed a hop. So
/// none of them can join the
/// synchronous map above. Standing a loopback server up for them, rather than
/// letting them widen F-SCC24-9's baseline, is deliberate: their getters return
/// `Uri`, `HttpHeaders`, `List<Cookie>`, `HttpSession`, `HttpConnectionInfo` and
/// `Duration`, which is exactly the shape that goes inert unnoticed. SCC62
/// exists because one of them did — `Cookie.sameSite` was bridged on both sides
/// while returning a value no bridge claimed.
///
/// The instances are detached by the time the sweep reads them, since the server
/// is closed first. That is harmless here and not worth keeping a socket open
/// for: a getter that objects to a closed connection throws, and the sweep
/// already skips a throwing getter — it is looking for values that resolve to no
/// bridge, not for values that cannot be produced.
final Map<String, Object> _liveInstances = {};

/// Populate [_liveInstances]. Called once from `setUpAll`.
///
/// One server serves both round trips because a WebSocket *is* an upgraded HTTP
/// request — binding a second port would model the two as unrelated when the
/// handshake is the thing that connects them.
Future<void> _captureLiveInstances() async {
  final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
  server.listen((request) async {
    if (WebSocketTransformer.isUpgradeRequest(request)) {
      // Listening with no handler keeps the server end responsive so the
      // client's close handshake completes rather than timing out.
      (await WebSocketTransformer.upgrade(request)).listen(null);
      return;
    }
    if (request.uri.path == '/redirect') {
      // A real 302 is the only way to obtain a `RedirectInfo`: `HttpClient`
      // builds one per hop internally and exposes it nowhere else.
      request.response
        ..statusCode = HttpStatus.movedTemporarily
        ..headers.set(HttpHeaders.locationHeader, '/')
        ..close();
      return;
    }
    _liveInstances['HttpRequest'] = request;
    _liveInstances['HttpResponse'] = request.response;
    // Reading `session` is what creates it; there is no other way to obtain one.
    _liveInstances['HttpSession'] = request.session;
    final info = request.connectionInfo;
    if (info != null) _liveInstances['HttpConnectionInfo'] = info;
    request.response.close();
  });

  final client = HttpClient();
  final request = await client.getUrl(
    Uri.parse('http://127.0.0.1:${server.port}/'),
  );
  final response = await request.close();
  await response.drain<void>();

  // A second round trip through the 302 above. What lands in the map is the
  // SDK's private `_RedirectInfo`, which is the point: the bridge claims that
  // name in `nativeNames`, and a hand-rolled `implements RedirectInfo` fake
  // would sweep clean without ever exercising the claim.
  final redirected = await (await client.getUrl(
    Uri.parse('http://127.0.0.1:${server.port}/redirect'),
  )).close();
  await redirected.drain<void>();
  if (redirected.redirects.isNotEmpty) {
    _liveInstances['RedirectInfo'] = redirected.redirects.first;
  }

  final socket = await WebSocket.connect('ws://127.0.0.1:${server.port}/');
  await socket.close();
  _liveInstances['WebSocket'] = socket;

  await server.close();
  client.close();

  // SCD78 — four of these were already in hand and merely unrecorded. The
  // server, the client request and response, and the request's headers are
  // objects this fixture has held since SCC62 wrote it; capturing them costs
  // four assignments and covers four bridges whose getters return `Uri`,
  // `HttpConnectionInfo`, `X509Certificate` and `List<Cookie>` — the shape this
  // sweep exists to catch.
  _liveInstances['HttpServer'] = server;
  _liveInstances['HttpClientRequest'] = request;
  _liveInstances['HttpClientResponse'] = response;
  _liveInstances['HttpHeaders'] = request.headers;

  // No resource at all: a `MultiStreamController` exists only inside
  // `Stream.multi`'s callback, which runs on the first listen.
  final controllerCapture = Completer<MultiStreamController<int>>();
  final multiSub = Stream<int>.multi(controllerCapture.complete).listen(null);
  _liveInstances['MultiStreamController'] = await controllerCapture.future;
  await multiSub.cancel();

  // Reads the host's interface list. Nothing is bound and nothing is claimed;
  // the guard is for a host that reports none, where the bridge stays uncovered
  // rather than the fixture throwing.
  final interfaces = await NetworkInterface.list();
  if (interfaces.isNotEmpty) {
    _liveInstances['NetworkInterface'] = interfaces.first;
  }

  // The socket family, on loopback — the resource class this file already
  // accepted in writing for the HTTP server above: bound, used, closed again,
  // with no consequence past the test. `startConnect` is used rather than
  // `connect` because it is the only way to obtain a `ConnectionTask`, and it
  // yields the connected `Socket` as well, so one exchange covers three bridges.
  final listener = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
  final accepting = listener.first;
  final connecting = await Socket.startConnect(
    InternetAddress.loopbackIPv4,
    listener.port,
  );
  final connected = await connecting.socket;
  final accepted = await accepting;
  _liveInstances['ServerSocket'] = listener;
  _liveInstances['Socket'] = connected;
  _liveInstances['ConnectionTask'] = connecting;
  accepted.destroy();
  connected.destroy();
  await listener.close();

  final rawListener = await RawServerSocket.bind(
    InternetAddress.loopbackIPv4,
    0,
  );
  final rawAccepting = rawListener.first;
  final rawConnected = await RawSocket.connect(
    InternetAddress.loopbackIPv4,
    rawListener.port,
  );
  final rawAccepted = await rawAccepting;
  _liveInstances['RawServerSocket'] = rawListener;
  _liveInstances['RawSocket'] = rawConnected;
  rawAccepted.close();
  rawConnected.close();
  await rawListener.close();

  final datagram = await RawDatagramSocket.bind(
    InternetAddress.loopbackIPv4,
    0,
  );
  _liveInstances['RawDatagramSocket'] = datagram;
  datagram.close();

  // A pipe pair, closed again in the same breath. Same class as a loopback
  // socket: two descriptors, both released here.
  final pipe = await Pipe.create();
  _liveInstances['Pipe'] = pipe;
  await pipe.write.close();
  await pipe.read.drain<void>();

  // Process globals, read and not claimed. Every getter that needs a real
  // terminal (`echoMode`, `terminalColumns`) throws under a test runner, and the
  // sweep already skips a throwing getter — so this reads what is readable and
  // leaves stdio exactly as it found it.
  _liveInstances['Stdout'] = stdout;
  _liveInstances['Stdin'] = stdin;

  // SCD171: the TLS pair, for the reason the reference copy records — a real
  // handshake is the only source of the `_X509CertificateImpl` the runtime
  // builds, and both `certificate` getters are null on a plain-HTTP request,
  // which is the null the sweep skips. Skipped on a host with no `openssl`.
  final tls = await TlsFixture.generate();
  if (tls != null) {
    try {
      _liveInstances['X509Certificate'] = await tls.peerCertificate();
      _liveInstances['SecurityContext'] = tls.serverContext();
    } finally {
      tls.dispose();
    }
  }
}

/// The bridges with instance getters that this sweep deliberately does NOT cover,
/// each with the reason it is declined rather than acquired.
///
/// SCD78 took the blind spot from 20 to 3, and the interesting part is how: it
/// was filed listing eleven types needing "live network", four needing "live
/// process / stdio", and five as "not publicly constructible". Measured, all but
/// these three were obtainable, and four of them were **already in hand** inside
/// the fixture this file has had since SCC62 — the bound had been recording a
/// resource cost that was mostly a bookkeeping gap.
///
/// A decline is a claim about cost, so each one names the cost:
const _declinedInstances = <String, String>{
  'Process':
      'spawning a process has consequences past the end of the test — '
      'the one resource class this file has always refused, and the reason it '
      'accepts a loopback socket, which does not',
  'FileSystemEvent':
      'needs a filesystem watcher, whose delivery is platform- and '
      'timing-dependent. It was measured working on macOS in milliseconds, and '
      'declined anyway: a watcher with a timeout fallback would leave this '
      'bridge covered on some hosts and not others, so the number below would '
      'stop being a fact about the registry and become a fact about the host',
  'Null':
      'there is no instance to hold. `null` IS the value, and the instance table '
      'is `Map<String, Object>` where a null means "no instance" — the signal '
      'this sweep uses to skip. Covering it would need a sentinel, to sweep '
      "three getters (`hashCode`, `toString`, `runtimeType`) that cannot go "
      'inert',
};

/// Every instance the getter sweep has to work with: the synchronous map plus
/// the connection-bound captures.
Map<String, Object> _sweepInstances() => {
  ..._canonicalInstances(),
  ..._liveInstances,
};

/// A minimal enum so the `Enum` bridge has a canonical instance.
enum _CanonicalEnum { value }

/// A real `TypeError`, which cannot be constructed directly.
Object _typeError() {
  try {
    // ignore: unnecessary_cast
    (1 as Object) as String;
  } on TypeError catch (e) {
    return e;
  }
  throw StateError('unreachable: the cast above must throw');
}

/// A `LinkedListEntry` that is attached to a list, so its `next` / `previous` /
/// `list` getters return real values rather than throwing.
_ListEntry _linkedEntry() {
  final entry = _ListEntry();
  LinkedList<_ListEntry>().add(entry);
  return entry;
}

/// Getters whose result legitimately does not resolve to a bridge, with the
/// reason. Keep this list short and justified — every entry is a hole in the
/// sweep.
const _sweepExemptions = <String, String>{
  // EMPTY SINCE SCD77, and the emptiness is the point: every entry here was a
  // member the sweep could not check. Its one entry was `Uri.isScheme`, a
  // method registered as a getter, whose value was therefore a function object
  // that resolves to no bridge. SCD77 moved it to `methods` instead of widening
  // the exemption, and F-SCD77-4 below now catches the shape by reading the
  // DECLARATION rather than the value — which is what found the second instance
  // this map never could.
};

// ---------------------------------------------------------------------------
// dart:async stream family — the todo's named scope
// ---------------------------------------------------------------------------

StreamController<int> _controller() => StreamController<int>();
Stream<int> _source() => Stream<int>.fromIterable(const [1]);

/// Members that return a `Stream`.
final _streamProbes = <_Probe>[
  _Probe('stream', () => _controller().stream, 'Stream'),
  _Probe('asBroadcastStream', () => _source().asBroadcastStream(), 'Stream'),
  _Probe(
    'asyncExpand',
    () => _source().asyncExpand(Stream<int>.value),
    'Stream',
  ),
  _Probe('asyncMap', () => _source().asyncMap((e) => e), 'Stream'),
  _Probe('cast', () => _source().cast<num>(), 'Stream'),
  _Probe('distinct', () => _source().distinct(), 'Stream'),
  _Probe('expand', () => _source().expand((e) => [e]), 'Stream'),
  _Probe('handleError', () => _source().handleError((Object e) {}), 'Stream'),
  _Probe('map', () => _source().map((e) => e), 'Stream'),
  _Probe('skip', () => _source().skip(1), 'Stream'),
  _Probe('skipWhile', () => _source().skipWhile((e) => true), 'Stream'),
  _Probe('take', () => _source().take(1), 'Stream'),
  _Probe('takeWhile', () => _source().takeWhile((e) => true), 'Stream'),
  _Probe('timeout', () => _source().timeout(const Duration(days: 1)), 'Stream'),
  _Probe(
    'transform',
    () => _source().transform(
      StreamTransformer<int, int>.fromHandlers(handleData: (e, s) {}),
    ),
    'Stream',
  ),
  _Probe('where', () => _source().where((e) => true), 'Stream'),
  // Static members returning a Stream.
  _Probe('castFrom', () => Stream.castFrom<int, num>(_source()), 'Stream'),
  _Probe('empty', () => const Stream<int>.empty(), 'Stream'),
  _Probe('error', () => Stream<int>.error('x'), 'Stream'),
  _Probe(
    'eventTransformed',
    () => Stream<int>.eventTransformed(_source(), (sink) => sink),
    'Stream',
  ),
  _Probe('fromFuture', () => Stream.fromFuture(Future.value(1)), 'Stream'),
  _Probe('fromFutures', () => Stream.fromFutures([Future.value(1)]), 'Stream'),
  _Probe('fromIterable', () => Stream.fromIterable(const [1]), 'Stream'),
  _Probe('multi', () => Stream<int>.multi((_) {}), 'Stream'),
  _Probe('periodic', () => Stream.periodic(const Duration(days: 1)), 'Stream'),
  _Probe('value', () => Stream<int>.value(1), 'Stream'),
];

/// Members that return a `StreamSubscription`. Several `listen` variants,
/// because the SDK returns a different implementation for each stream shape and
/// each one needs its own claim.
final _subscriptionProbes = <_Probe>[
  _Probe('listen', () => _source().listen(null), 'StreamSubscription'),
  _Probe(
    'listen (single-subscription controller)',
    () => _controller().stream.listen(null),
    'StreamSubscription',
  ),
  _Probe(
    'listen (broadcast controller)',
    () => StreamController<int>.broadcast().stream.listen(null),
    'StreamSubscription',
  ),
  _Probe(
    'listen (asBroadcastStream)',
    () => _source().asBroadcastStream().listen(null),
    'StreamSubscription',
  ),
  _Probe(
    'listen (empty)',
    () => const Stream<int>.empty().listen(null),
    'StreamSubscription',
  ),
];

/// Members that return a `StreamSink`.
final _sinkProbes = <_Probe>[
  _Probe('sink', () => _controller().sink, 'StreamSink'),
  _Probe(
    'sink (broadcast)',
    () => StreamController<int>.broadcast().sink,
    'StreamSink',
  ),
];

/// Members that return a `Future`. Included because the same trap applies one
/// level out: an unclaimed Future is inert exactly like an unclaimed Stream,
/// and `await` is not the only thing a script does with one.
final _futureProbes = <_Probe>[
  _Probe('any', () => _source().any((e) => true), 'Future'),
  _Probe('contains', () => _source().contains(1), 'Future'),
  _Probe('drain', () => _source().drain<Object?>(), 'Future'),
  _Probe('elementAt', () => _source().elementAt(0), 'Future'),
  _Probe('every', () => _source().every((e) => true), 'Future'),
  _Probe('first', () => _source().first, 'Future'),
  _Probe('firstWhere', () => _source().firstWhere((e) => true), 'Future'),
  _Probe('fold', () => _source().fold<int>(0, (a, b) => a + b), 'Future'),
  _Probe('forEach', () => _source().forEach((e) {}), 'Future'),
  _Probe('isEmpty', () => _source().isEmpty, 'Future'),
  _Probe('join', () => _source().join(), 'Future'),
  _Probe('last', () => _source().last, 'Future'),
  _Probe('lastWhere', () => _source().lastWhere((e) => true), 'Future'),
  _Probe('length', () => _source().length, 'Future'),
  _Probe('pipe', () => _source().pipe(_controller().sink), 'Future'),
  _Probe('reduce', () => _source().reduce((a, b) => a + b), 'Future'),
  _Probe('single', () => _source().single, 'Future'),
  _Probe('singleWhere', () => _source().singleWhere((e) => true), 'Future'),
  _Probe('toList', () => _source().toList(), 'Future'),
  _Probe('toSet', () => _source().toSet(), 'Future'),
  _Probe(
    'asFuture',
    () => _source().listen(null).asFuture<Object?>(),
    'Future',
  ),
  _Probe('cancel', () => _source().listen(null).cancel(), 'Future'),
  _Probe('done', () => _controller().sink.done, 'Future'),
  _Probe('done (controller)', () => _controller().done, 'Future'),
  _Probe('close', () => _controller().sink.close(), 'Future'),
  _Probe('addStream', () => _controller().sink.addStream(_source()), 'Future'),
  _Probe('close (controller)', () => _controller().close(), 'Future'),
  _Probe(
    'addStream (controller)',
    () => _controller().addStream(_source()),
    'Future',
  ),
];

final _asyncFamilyProbes = <_Probe>[
  ..._streamProbes,
  ..._subscriptionProbes,
  ..._sinkProbes,
  ..._futureProbes,
];

/// Members of the async family bridges that cannot return a family value, with
/// the type they do return. The coverage guard requires every declared member
/// to be either probed or listed here, so adding a bridged member forces a
/// triage instead of letting the probe table quietly fall behind.
const _asyncNonFamilyReturning = <String, String>{
  'hashCode': 'int',
  'runtimeType': 'Type',
  'isBroadcast': 'bool',
  'isPaused': 'bool',
  'isClosed': 'bool',
  'hasListener': 'bool',
  'pause': 'void',
  'resume': 'void',
  'add': 'void',
  'addError': 'void',
  'onListen': 'callback (void Function()?)',
  'onCancel': 'callback (void Function()?)',
  'onPause': 'callback (void Function()?)',
  'onResume': 'callback (void Function()?)',
  // SCD189 moved these three from `setters` to `methods`, which is where the
  // SDK declares them (`void onData(void Function(T)?)`), so the methods scan
  // now sees them and asks for a triage. They install a handler and return
  // void — the callback they take is a family value's CONSUMER, never a
  // family value itself, which is the same reasoning as the four entries
  // above.
  'onData': 'void (installs a handler)',
  'onDone': 'void (installs a handler)',
  'onError': 'void (installs a handler)',
};

Map<String, BridgedClass> _asyncFamilyBridges() => {
  'Stream': StreamAsync.definition,
  'StreamSubscription': StreamSubscriptionAsync.definition,
  'StreamSink': StreamSinkAsync.definition,
  'EventSink': EventSinkAsync.definition,
  'StreamController': StreamControllerAsync.definition,
};

// ---------------------------------------------------------------------------
// Beyond dart:async — the gaps the generalisation sweep found
// ---------------------------------------------------------------------------

class _IdentityConverter<T> extends Converter<T, T> {
  @override
  T convert(T input) => input;
}

/// Members reached only by ARGUMENTS, which the getter sweep cannot invoke.
/// Every entry here was inert before SCC24.
final _beyondAsyncProbes = <_Probe>[
  // dart:collection / dart:core — Iterator implementations.
  _Probe(
    'LinkedList.iterator',
    () => LinkedList<_ListEntry>().iterator,
    'Iterator',
  ),
  _Probe(
    'RegExp.allMatches().iterator',
    () => RegExp('a').allMatches('a').iterator,
    'Iterator',
  ),
  _Probe('Uint8List.iterator', () => Uint8List(1).iterator, 'Iterator'),
  _Probe('Int32List.iterator', () => Int32List(1).iterator, 'Iterator'),
  _Probe('Float64List.iterator', () => Float64List(1).iterator, 'Iterator'),
  // dart:convert — fused converters. The SDK special-cases the UTF-8/JSON pair
  // in both directions and uses a general wrapper for everything else, so both
  // paths need a claim.
  _Probe(
    'Converter.fuse (utf8 + json)',
    () => utf8.decoder.fuse(json.decoder),
    'Converter',
  ),
  _Probe(
    'Converter.fuse (general)',
    () => ascii.decoder.fuse(json.decoder),
    'Converter',
  ),
  _Probe(
    'Converter.fuse (base64)',
    () => base64.encoder.fuse<String>(_IdentityConverter<String>()),
    'Converter',
  ),
  _Probe('Codec.inverted', () => utf8.inverted, 'Codec'),
  _Probe('Codec.inverted (json)', () => json.inverted, 'Codec'),
  _Probe('Codec.inverted (base64)', () => base64.inverted, 'Codec'),
  // dart:io — a Stream implementation defined outside dart:async.
  _Probe('File.openRead', () => File('pubspec.yaml').openRead(), 'Stream'),
  _Probe(
    'File.openRead (ranged)',
    () => File('pubspec.yaml').openRead(0, 4),
    'Stream',
  ),
];

// ---------------------------------------------------------------------------

void main() {
  group('SCC24: native-name coverage', () {
    setUpAll(_captureLiveInstances);

    test('F-SCC24-1: every instance getter on every bridge returns a value that '
        'resolves [2026-09-04]', () {
      final env = _stdlibEnvironment();
      final instances = _sweepInstances();
      final inert = <String, String>{};

      for (final bridge in _allBridges(env).values) {
        final target = instances[bridge.name];
        if (target == null) continue; // Blind spot; pinned by F-SCC24-9.
        for (final getter in bridge.getters.entries) {
          final key = '${bridge.name}.${getter.key}';
          if (_sweepExemptions.containsKey(key)) continue;
          final Object? result;
          try {
            result = getter.value(null, target);
          } catch (_) {
            // The getter itself refused this target (a type guard, an empty
            // collection). Not a resolution failure, and not this file's
            // subject.
            continue;
          }
          if (result == null) continue;
          if (result is Future) {
            // SCD78: a getter can hand back a Future that completes with an
            // error long after the sweep has read it, and no `try`/`catch`
            // here can hold that — it escapes to the zone and fails the test.
            // `Socket.first` on a socket that carried no data is the case that
            // found it ("Bad state: No element"), and that failure says
            // nothing about coverage. Marking it ignored keeps the FUTURE as
            // the value under test, which is the right subject: a `Future` is
            // claimed by the `Future` bridge whatever it completes with.
            result.ignore();
          }
          final resolved = _resolvedBridgeName(env, result);
          if (resolved == '<inert: no bridge>') {
            inert[key] = '${result.runtimeType}';
          }
        }
      }

      expect(
        inert,
        isEmpty,
        reason:
            'These getters return a value that no bridge claims, so '
            'every member call on the result would fail with "Undefined '
            'property or method ... on _Whatever". Add the private type the '
            'SDK reported to `nativeNames` on the bridge for the type it '
            'actually is — and then check whether the member has any test '
            'coverage at all, because an inert return value means it could '
            'not have been used, which is how the previous four instances of '
            'this defect stayed hidden.',
      );
    });

    test(
      'F-SCC24-2: every dart:async member returning a Stream resolves to the '
      'Stream bridge [2026-09-04]',
      () {
        expect(
          _gaps(_streamProbes),
          isEmpty,
          reason:
              'Add the reported private type to `nativeNames` on the '
              'Stream bridge in stdlib/async/stream.dart.',
        );
      },
    );

    test('F-SCC24-3: every dart:async member returning a StreamSubscription '
        'resolves to the StreamSubscription bridge [2026-09-04]', () {
      expect(
        _gaps(_subscriptionProbes),
        isEmpty,
        reason:
            'Add the reported private type to `nativeNames` on the '
            'StreamSubscription bridge.',
      );
    });

    test(
      'F-SCC24-4: every dart:async member returning a StreamSink resolves to '
      'the StreamSink bridge [2026-09-04]',
      () {
        expect(
          _gaps(_sinkProbes),
          isEmpty,
          reason:
              'This is the SC4 defect. Add the reported private type to '
              '`nativeNames` on the StreamSink bridge.',
        );
      },
    );

    test(
      'F-SCC24-5: every dart:async member returning a Future resolves to the '
      'Future bridge [2026-09-04]',
      () {
        expect(
          _gaps(_futureProbes),
          isEmpty,
          reason:
              'An unclaimed Future is inert in exactly the same way an '
              'unclaimed Stream is. Add the reported private type to '
              '`nativeNames` on the Future bridge.',
        );
      },
    );

    test('F-SCC24-6: every declared member of the async family bridges is '
        'probed or explicitly exempt [2026-09-04]', () {
      final probed = _asyncFamilyProbes
          .map((p) => p.member.split(' ').first)
          .toSet();
      final unclassified = <String, List<String>>{};
      for (final entry in _asyncFamilyBridges().entries) {
        final bridge = entry.value;
        final members = <String>{
          ...bridge.methods.keys,
          ...bridge.getters.keys,
          ...bridge.staticMethods.keys,
          ...bridge.staticGetters.keys,
        };
        final missing =
            members
                .where(
                  (m) =>
                      !probed.contains(m) &&
                      !_asyncNonFamilyReturning.containsKey(m),
                )
                .toList()
              ..sort();
        if (missing.isNotEmpty) unclassified[entry.key] = missing;
      }
      expect(
        unclassified,
        isEmpty,
        reason:
            'A bridged member was added without deciding whether it can '
            'return a family value. Either add a probe for it, or add it to '
            '`_asyncNonFamilyReturning` with the type it actually returns. '
            'The probe table must not be able to fall behind the bridge '
            'definition — that is the whole point of this guard.',
      );
    });

    test('F-SCC24-7: the collection, convert and io gaps SCC24 found stay fixed '
        '[2026-09-04]', () {
      // These members take arguments, so the getter sweep in F-SCC24-1 cannot
      // reach them. Every one was inert before SCC24, and each had the
      // second-order symptom: `Codec.inverted` had no test anywhere in the
      // suite, the general `Converter.fuse` path had none, and the suite's one
      // `File.openRead` call never touched a member of the result.
      expect(
        _gaps(_beyondAsyncProbes),
        isEmpty,
        reason:
            'A previously fixed gap has reopened, or an SDK upgrade '
            'renamed the implementation type behind one of these members.',
      );
    });

    test('F-SCC24-8: the check fails when a nativeNames entry is missing '
        '[2026-09-06]', () {
      // Verify by breaking. A family bridge with an EMPTY `nativeNames` must
      // NOT resolve these values — otherwise the assertions above would pass no
      // matter what was deleted from the lists.
      //
      // RETARGETED BY SCC49, and the reason matters. When this test was written
      // (2026-09-04) the enumeration was the ONLY mechanism, so all 27
      // stream-family values went inert once their entry was removed and the
      // control could simply sweep the lot. SCC49 added a structural suffix
      // fallback to `toBridgedClass` — Dart's implementation types end with the
      // interface they implement (`_ControllerStream`, `_MapStream`,
      // `_HandleErrorStream`), so those now resolve with no enumeration at all.
      // That is the intended outcome, not a regression: the allowlist was
      // deliberately demoted to a fast path plus an explicit-ownership
      // override.
      //
      // Loosening the assertion to accommodate that would have destroyed the
      // control's purpose, so the control was SPLIT along the line SCC49 drew,
      // and each half asserts something stronger than the original did:
      //
      //   * `_stillInertWithoutEnumeration` — values whose implementation type
      //     name suffix-matches no bridge, because the SDK abbreviates it
      //     (`_StreamSinkWrapper` for `StreamSink`, `_ControllerSubscription`
      //     for `StreamSubscription`). These still go inert, which is what
      //     proves resolution is not unconditional. If this half ever empties,
      //     the sweep really has become vacuous.
      //
      //   * `_structurallyResolvedWithoutEnumeration` — values that now resolve
      //     without their entry, asserted against the CORRECT bridge rather
      //     than merely against "something". `_ControllerStream` resolving to
      //     `Stream` and not to `StreamSink` is the property SCC49 delivers,
      //     and it is a tighter claim than the old `<inert>` check made.
      //
      // Measured 2026-09-06 against a bare three-bridge environment:
      //   _ControllerStream<int>       -> Stream
      //   _StreamSinkWrapper<int>      -> <inert: no bridge>
      //   _HandleErrorStream<int>      -> Stream
      //   _MapStream<int, int>         -> Stream
      //   _ControllerSubscription<int> -> <inert: no bridge>
      //
      // No private type name is hard-coded here either: the values come from
      // the same public calls, and the split above is a property of what the
      // SDK happens to name them.
      final bare = Environment()
        ..defineBridge(
          BridgedClass(
            nativeType: Stream,
            name: 'Stream',
            typeParameterCount: 1,
            nativeNames: const [],
          ),
        )
        ..defineBridge(
          BridgedClass(
            nativeType: StreamSubscription,
            name: 'StreamSubscription',
            typeParameterCount: 1,
            nativeNames: const [],
          ),
        )
        ..defineBridge(
          BridgedClass(
            nativeType: StreamSink,
            name: 'StreamSink',
            typeParameterCount: 1,
            nativeNames: const [],
          ),
        );

      // Half one: the SDK does not name these after the interface, so nothing
      // but the enumeration can claim them.
      final stillInertWithoutEnumeration = <Object?>[
        _controller().sink,
        _source().listen(null),
      ];
      for (final value in stillInertWithoutEnumeration) {
        expect(
          _resolvedBridgeName(bare, value),
          '<inert: no bridge>',
          reason:
              'Without its `nativeNames` entry this value resolved anyway. '
              'Its implementation type (${value.runtimeType}) suffix-matches '
              'no bridge name, so nothing but the enumeration should be able '
              'to claim it — if something did, the assertions above are no '
              'longer guarding anything.',
        );
      }

      // Half two: the SDK does name these after the interface, so SCC49's
      // structural pass claims them — and must claim the RIGHT one.
      final structurallyResolvedWithoutEnumeration = <Object?, String>{
        _controller().stream: 'Stream',
        _source().handleError((Object e) {}): 'Stream',
        _source().map((e) => e): 'Stream',
      };
      structurallyResolvedWithoutEnumeration.forEach((value, expected) {
        expect(
          _resolvedBridgeName(bare, value),
          expected,
          reason:
              'SCC49: ${value.runtimeType} should resolve to `$expected` from '
              'its name alone, with every `nativeNames` list emptied. '
              'Resolving to a different bridge would mean the structural pass '
              'picks by something other than the longest matching suffix; '
              'resolving to nothing would mean it did not run at all.',
        );
      });
    });

    test('F-SCC24-9: the sweep\'s blind spot does not grow [2026-09-04]', () {
      // F-SCC24-1 can only check bridges it has a canonical instance for.
      // Bridges without one are its blind spot. Pinning the count means adding
      // a bridge forces either an instance (widening the sweep) or a deliberate
      // decision to leave it uncovered — it cannot happen silently.
      //
      // A live connection used to be outside what this suite would acquire, and
      // is not: `_captureLiveInstances` stands a loopback server up in
      // `setUpAll`, because the alternative was to raise this baseline and lose
      // the sweep over the newest and least-exercised bridges in the tree. The
      // line it drew — a bound loopback socket that is closed again has no
      // consequence past the test, a spawned process does — is the line SCD78
      // then followed to its conclusion.
      //
      // **SCD78 TOOK THIS FROM 20 TO 3, and mostly by asking.** The todo listed
      // eleven types needing live network, four needing live process or stdio,
      // and five that "cannot be constructed at all". Measured, all but three
      // were obtainable: `OutOfMemoryError()` and `StackOverflowError()` are
      // ordinary public constructors, a `MultiStreamController` arrives in
      // `Stream.multi`'s callback, and FOUR of the HTTP types were already held
      // by the fixture above and simply never recorded. The socket family needs
      // only the loopback exchange this file had already accepted in writing.
      // So most of the blind spot was bookkeeping wearing the costume of a
      // resource cost.
      //
      // What remains is in `_declinedInstances`, each with the cost that makes
      // it not worth acquiring, and the checks below hold the set as well as
      // the count.
      //
      // The bound stays `lessThanOrEqualTo`, not `equals`, on purpose: adding a
      // canonical instance should never fail the guard, only removing
      // coverage should.
      final env = _stdlibEnvironment();
      final instances = _sweepInstances();
      final uncovered =
          _allBridges(env).values
              .where(
                (b) => b.getters.isNotEmpty && !instances.containsKey(b.name),
              )
              .map((b) => b.name)
              .toList()
            ..sort();

      // SCD78 added the set check beside the count, and the count stays because
      // the two refuse different things. The subset check refuses a bridge that
      // is uncovered WITHOUT a recorded reason — the drift this test was written
      // for — and names it. The count refuses growing the reasons map itself,
      // so adding a decline stays a deliberate act rather than a way to make
      // this green.
      expect(
        uncovered.where((name) => !_declinedInstances.containsKey(name)),
        isEmpty,
        reason:
            'A bridge with instance getters has no canonical instance and no '
            'recorded reason, so F-SCC24-1 cannot see it. Add one to '
            '`_canonicalInstances` (or, if it needs a connection or a socket, to '
            '`_captureLiveInstances`) — or decline it in `_declinedInstances` '
            'with the cost that makes it not worth acquiring.\n'
            'Uncovered: ${uncovered.join(', ')}',
      );

      expect(
        uncovered.length,
        lessThanOrEqualTo(3),
        reason:
            'The declined set has grown. Lower this deliberately if a bridge '
            'genuinely cannot be swept, and say why in `_declinedInstances`. '
            'Uncovered: ${uncovered.join(', ')}',
      );
    });

    test(
      'F-SCD77-4: no bridge registers, as a getter, a name the SDK declares as '
      'a method [2026-09-13]',
      () {
        // The declaration-direction companion to F-SCC24-1, and it exists
        // because F-SCC24-1 structurally cannot see this shape. That sweep
        // INVOKES each registered getter and asks whether the value resolves to
        // a bridge; a method registered as a getter yields a tear-off, and a
        // tear-off only fails to resolve by luck. `Uri.isScheme` failed that
        // way and so became the map above's one exemption.
        //
        // AND THE EXEMPTION HAD ALREADY GONE STALE, which is the strongest
        // argument for reading declarations. Measured 2026-09-13 by putting
        // `Uri.isScheme` back as a getter with the exemption map empty:
        // F-SCC24-1 PASSES. A `Function` bridge exists (`stdlib/core/function.dart`),
        // so a tear-off resolves like any other value now, and the only thing
        // that ever made this shape visible to the value sweep — the resolution
        // failing — is gone. This case is not a second opinion; since that
        // bridge landed it is the only detector.
        //
        // Asking the mirror also found a SECOND instance that could not have
        // surfaced any other way:
        // `TimeoutException.toString` was registered as a getter AND as a
        // method, with the method shadowing it — so the getter was unreachable
        // and its value, had anything reached it, was a `String` that resolves
        // perfectly well. Both are fixed; this case is what keeps the class
        // closed rather than the two instances.
        //
        // Neither was user-visible, which is worth stating so nobody reads this
        // as a bug guard: measured before the change, `uri.isScheme('https')`,
        // the `uri.isScheme` tear-off, `e.toString()`, `e.toString` and
        // `'\$e'` all behaved correctly. What a wrong member KIND costs is
        // checkability, and that is what is being defended here.
        final env = _stdlibEnvironment();
        final offenders = <String>[];
        var reflected = 0;

        for (final bridge in _allBridges(env).values) {
          final ClassMirror mirror;
          try {
            mirror = reflectType(bridge.nativeType) as ClassMirror;
          } catch (_) {
            // A bridge whose native type is not a reflectable ClassMirror —
            // `Function` for the top-level-function bridges, and typedefs.
            // Nothing to compare, and F-SCC24-9 owns the blind-spot accounting.
            continue;
          }
          reflected++;

          final methods = <String>{};
          final getters = <String>{};
          for (
            ClassMirror? c = mirror;
            c != null && c.reflectedType != Object;
            c = c.superclass
          ) {
            // `c.declarations.values`, not the map itself: writing the
            // `Map<Symbol, …>` annotation puts the token `Symbol` in this file,
            // and F-SCD58-3 reads test sources for bridge names — it fired on
            // exactly that, reporting the `Symbol` bridge as newly covered when
            // nothing here tests it. The guard was right; the mention was
            // incidental.
            final Iterable<DeclarationMirror> declarations;
            try {
              declarations = c.declarations.values;
            } catch (_) {
              break;
            }
            for (final declaration in declarations) {
              if (declaration is! MethodMirror) continue;
              if (declaration.isStatic || declaration.isConstructor) continue;
              final name = MirrorSystem.getName(declaration.simpleName);
              if (declaration.isRegularMethod) {
                methods.add(name);
              } else if (declaration.isGetter) {
                getters.add(name);
              }
            }
          }

          for (final name in bridge.getters.keys) {
            // A name declared BOTH ways in the SDK chain (an interface getter
            // overridden as a method, or the reverse) is not an error to
            // register as a getter — so only names the chain declares purely as
            // methods count.
            if (methods.contains(name) && !getters.contains(name)) {
              offenders.add('${bridge.name}.$name  (${bridge.nativeType})');
            }
          }
        }

        // Anti-vacuity: an environment that failed to register, or a mirror
        // system that reflected nothing, would report zero offenders and look
        // like success.
        expect(
          reflected,
          greaterThanOrEqualTo(100),
          reason:
              'only $reflected bridges were reflectable, so this is not a '
              'measurement of the registry',
        );

        offenders.sort();
        expect(
          offenders,
          isEmpty,
          reason:
              'These names are methods in the SDK and are registered as '
              'getters. Move each to the bridge\'s `methods` map, taking its '
              'arguments from `positionalArgs`. Registering a method as a '
              'getter happens to work for a script — the interpreter tears the '
              'value off and calls it — which is exactly why it survives: '
              'nothing fails, and F-SCC24-1 has to exempt the member.\n'
              '${offenders.join('\n')}',
        );
      },
    );
  });
  // -------------------------------------------------------------------------
  // SCD197 — bridges nothing resolves to, whose member lists are unreachable
  // -------------------------------------------------------------------------
  //
  // SCC77 found `StringSink` registered with seven adapters and nothing
  // resolving to it: every value the stdlib can hand a script has a more
  // specific bridge, so it is a TYPE-TEST and interface target and never a
  // member-lookup target. SCC77 predicted supertype edges would let lookup
  // fall through to it for members `StringBufferCore` does not declare. SCD197
  // asked how many bridges are in that position. Measured here rather than
  // guessed.
  //
  // WHY IT MATTERS. An unreachable member list is the precondition for SCB26:
  // the io registrar shipped a second, smaller `StringSink` that displaced the
  // core one and silently removed three members, and no script could tell
  // because no script could reach the bridge either way. The list can drift
  // arbitrarily and only a registration-level test will know.
  //
  // WHAT "UNREACHABLE" MEANS HERE, because the obvious measure over-counts
  // badly. A bridge that is never `toBridgedInstance`'s DIRECT answer may still
  // be reached through the supertype chain — `Set` is never the answer for a
  // set literal (`LinkedHashSet` is) and is obviously reachable. So the
  // question asked is per MEMBER: is there any bridge that IS an answer, has
  // this one above it, and does not shadow the member with its own or a nearer
  // declaration? By the direct measure 52 bridges look unreachable; by this one
  // the fully-unreachable set with a canonical instance is nine.
  //
  // SCC77's PREDICTION WAS NEARLY RIGHT AND NOT QUITE. `StringSink` is 1/7
  // reachable, not 0/7 — one member does fall through. The seven are not all
  // dead, which is worth knowing before anyone deletes them.
  //
  // WHAT THIS GROUP DOES NOT DO, deliberately: it does not delete anything.
  // SCD197 asked to measure first and then decide per bridge, and the deciding
  // is judgement-heavy — twenty-nine bridges, some of which want their adapters
  // kept and guarded rather than removed. This is the measurement plus the
  // ratchet that stops the set growing while that is decided; the deletions are
  // sce233.
  //
  // BOTH RATCHETS HAVE BEEN SEEN TO FAIL:
  //
  //   | Injected fault                                    | Fires |
  //   | ------------------------------------------------- | ----- |
  //   | a member added to `Pattern`, which nothing reaches | 1     |
  //   | a member added to `StringSink`, moving 1/7 to 1/8  | 2     |

  group('SCD197: interface bridges whose members nothing can reach', () {
    /// Bridges with a canonical instance that are never a resolution answer AND
    /// none of whose members any heir falls through to. Value is the member
    /// count, so a list that GROWS under an already-unreachable bridge shows.
    ///
    /// Measured 2026-09-15. `num` at 32 is the largest and is consistent with
    /// sce185's independent census: `int` and `double` each shadow ~36 of its
    /// adapters, so none of `num`'s own is ever reached.
    const measuredUnreachable = <String, int>{
      'Comparable': 4,
      'Error': 4,
      'FileSystemEntity': 16,
      'Function': 4,
      'LinkedListEntry': 7,
      'Match': 11,
      'Pattern': 5,
      'TypedData': 4,
      'num': 32,
    };

    /// Bridges some of whose members ARE reached. Pinned as a fraction because
    /// both halves are informative: a rise means a member stopped being
    /// shadowed, a fall means one started.
    const partlyReachable = <String, String>{
      'Codec': '2/8',
      'Converter': '2/7',
      'Encoding': '3/9',
      'Exception': '2/3',
      'Queue': '3/17',
      'Set': '3/43',
      'Sink': '3/5',
      'StringSink': '1/7',
    };

    /// Bridges with no canonical instance in `_canonicalInstances`, so "never a
    /// resolution answer" is UNMEASURED for them rather than established — a
    /// bridge cannot win a comparison it was not entered in. Listed so the
    /// distinction is on the record and nobody reads the nine above as the
    /// whole set.
    const unmeasuredForWantOfAnInstance = <String>{
      'ChunkedConversionSink',
      'EventSink',
      'FileSystemEntityType',
      'FileSystemEvent',
      'IOException',
      'Null',
      'Process',
      'ProcessStartMode',
      'StreamConsumer',
      'StreamTransformer',
      'StreamTransformerBase',
      'WebSocketTransformer',
    };

    late Environment env;
    late Set<String> winners;
    late Map<String, int> unreachable;
    late Map<String, String> partial;

    setUpAll(() {
      env = _stdlibEnvironment();
      final instances = _sweepInstances();
      winners = <String>{};
      for (final entry in instances.entries) {
        try {
          final bridged = env.toBridgedInstance(entry.value);
          if (bridged != null) winners.add(bridged.bridgedClass.name);
        } catch (_) {
          // A canonical instance whose native type has no bridge at all is
          // F-SCC24-1's subject, not this group's.
        }
      }

      bool declares(String className, String member) {
        final bridge = env.findBridgedClassByName(className);
        if (bridge == null) return false;
        return bridge.methods.containsKey(member) ||
            bridge.getters.containsKey(member) ||
            bridge.setters.containsKey(member);
      }

      unreachable = <String, int>{};
      partial = <String, String>{};
      for (final name in (env.bridgedClassNames..sort())) {
        if (winners.contains(name)) continue;
        if (!instances.containsKey(name)) continue;
        final bridge = env.findBridgedClassByName(name);
        if (bridge == null) continue;
        final members = <String>{
          ...bridge.methods.keys,
          ...bridge.getters.keys,
          ...bridge.setters.keys,
        };
        if (members.isEmpty) continue;
        final heirs = winners
            .where(
              (w) => BridgedClass.transitiveSupertypeNames(w).contains(name),
            )
            .toList();
        var reached = 0;
        for (final member in members) {
          for (final heir in heirs) {
            var shadowed = declares(heir, member);
            if (!shadowed) {
              for (final mid in BridgedClass.transitiveSupertypeNames(heir)) {
                if (mid == name) break;
                if (declares(mid, member)) {
                  shadowed = true;
                  break;
                }
              }
            }
            if (!shadowed) {
              reached++;
              break;
            }
          }
        }
        if (reached == 0) {
          unreachable[name] = members.length;
        } else if (reached < members.length) {
          partial[name] = '$reached/${members.length}';
        }
      }
    });

    test('F-SCD197-3 (control): instances resolved and heirs were found '
        '[2026-09-15] (PASS)', () {
      // Every assertion below is a set comparison over this walk, and two
      // plausible ways to break it both end in "nothing unreachable": no
      // instances resolved (so `winners` is empty and EVERY bridge looks
      // unreachable), or the supertype registry empty (so no heir shadows
      // anything and every member looks reachable). Both directions are
      // pinned.
      expect(
        winners.length,
        greaterThanOrEqualTo(120),
        reason:
            'Only ${winners.length} bridges were a resolution answer. The '
            'canonical instances did not resolve, so every bridge looks '
            'unreachable.',
      );
      expect(
        BridgedClass.transitiveSupertypeNames('LinkedHashSet'),
        contains('Set'),
        reason:
            'The supertype registry is not populated, so no heir shadows '
            'anything and every member reads as reachable.',
      );
    });

    test('F-SCD197-1: the unreachable set has not grown [2026-09-15] '
        '(PASS)', () {
      final appeared =
          unreachable.keys
              .where((n) => !measuredUnreachable.containsKey(n))
              .toList()
            ..sort();
      expect(
        appeared,
        isEmpty,
        reason:
            'These bridges are now a resolution answer for nothing, and no '
            'heir falls through to any of their members:\n'
            '${appeared.map((n) => '  $n (${unreachable[n]} members)').join('\n')}\n\n'
            'An unreachable member list is the precondition for SCB26, where a '
            'displaced `StringSink` lost three members and no script could '
            'tell. Either give the bridge a reason to be reached, or record it '
            'here — and say so in its source file, where somebody would go to '
            'add a member.',
      );

      final resolved =
          measuredUnreachable.keys
              .where((n) => !unreachable.containsKey(n))
              .toList()
            ..sort();
      expect(
        resolved,
        isEmpty,
        reason:
            'These are recorded as fully unreachable and no longer are: '
            '${resolved.join(', ')}.\n'
            'Good news, and it has to be recorded or the entry stops '
            'describing the registry.',
      );

      final grew =
          measuredUnreachable.keys
              .where(
                (n) =>
                    unreachable.containsKey(n) &&
                    unreachable[n]! != measuredUnreachable[n],
              )
              .map(
                (n) => '  $n: ${measuredUnreachable[n]} -> ${unreachable[n]}',
              )
              .toList()
            ..sort();
      expect(
        grew,
        isEmpty,
        reason:
            'The member count changed under a bridge nothing can reach:\n'
            '${grew.join('\n')}\n'
            'Adding to an unreachable list is adding code no script runs.',
      );
    });

    test('F-SCD197-2: the partly-reachable fractions hold [2026-09-15] '
        '(PASS)', () {
      // SCC77 predicted supertype edges would let lookup fall through to
      // `StringSink` for members `StringBufferCore` does not declare. It is
      // 1/7 — so the prediction was directionally right and almost entirely
      // wrong about the size, which is why this is pinned as a fraction rather
      // than as a boolean.
      final changed = <String>[];
      for (final entry in partlyReachable.entries) {
        final actual = partial[entry.key] ?? unreachable[entry.key]?.let0();
        if (actual == entry.value) continue;
        changed.add(
          '  ${entry.key}: recorded ${entry.value}, found '
          '${partial[entry.key] ?? (unreachable.containsKey(entry.key) ? '0/${unreachable[entry.key]}' : 'fully reachable')}',
        );
      }
      expect(
        changed,
        isEmpty,
        reason:
            'These reachability fractions moved:\n${changed.join('\n')}\n'
            'A rise means a member stopped being shadowed by an heir; a fall '
            'means one started. Both are worth a look before the number is '
            'updated.',
      );
    });

    test('F-SCD197-4: every unmeasured bridge is still unmeasured '
        '[2026-09-15] (PASS)', () {
      // The honest half. These have no canonical instance, so "nothing
      // resolves to them" is not a finding — a bridge cannot win a comparison
      // it was not entered in. When one gains an instance it moves into the
      // measured set, and this says so rather than letting it slip in.
      final nowMeasured =
          unmeasuredForWantOfAnInstance
              .where(_sweepInstances().containsKey)
              .toList()
            ..sort();
      expect(
        nowMeasured,
        isEmpty,
        reason:
            'These now have a canonical instance: ${nowMeasured.join(', ')}.\n'
            'Re-run the measurement and move each into measuredUnreachable or '
            'partlyReachable, or delete its entry if it resolves.',
      );
    });
  });
}

extension on int {
  /// Renders a fully-unreachable count in the `reached/total` shape the
  /// partly-reachable map uses, so the two can be compared without special
  /// cases at the call site.
  String let0() => '0/$this';
}
