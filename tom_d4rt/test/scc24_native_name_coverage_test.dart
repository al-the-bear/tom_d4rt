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
import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:tom_d4rt/src/bridge/bridged_types.dart';
// `Environment.toBridgedInstance` is this file's entire subject, so the
// dependency is declared directly rather than leaning on a stdlib barrel that
// happens to re-export it today.
// ignore: unnecessary_import
import 'package:tom_d4rt/src/environment.dart';
import 'package:tom_d4rt/src/exceptions.dart';
import 'package:tom_d4rt/src/stdlib/async/stream.dart';
import 'package:tom_d4rt/src/stdlib/async/stream_controller.dart';
import 'package:tom_d4rt/src/stdlib/collection.dart';
import 'package:tom_d4rt/src/stdlib/convert.dart';
import 'package:tom_d4rt/src/stdlib/io.dart';
import 'package:tom_d4rt/src/stdlib/stdlib.dart';

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
      'AssertionError': AssertionError('x'),
      'ConcurrentModificationError': ConcurrentModificationError(<int>[]),
      'NoSuchMethodError':
          NoSuchMethodError.withInvocation(1, Invocation.getter(#a)),
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
      // dart:convert sinks
      'Sink': ByteConversionSink.withCallback((_) {}),
      'ByteConversionSink': ByteConversionSink.withCallback((_) {}),
      'StringConversionSink': StringConversionSink.withCallback((_) {}),
      'ClosableStringSink':
          StringConversionSink.withCallback((_) {}).asStringSink(),
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
  // `Uri.isScheme` is a METHOD in the SDK (`bool isScheme(String)`) but is
  // registered as a getter returning the tear-off, so the sweep sees a
  // function object rather than a value. Scripts are unaffected — the
  // interpreter's getter-then-call path makes `uri.isScheme('https')` work —
  // so this is a bridge-shape oddity, not a live defect. Normalising it to a
  // method is tracked separately.
  'Uri.isScheme': 'method registered as a getter; returns a tear-off',
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
      'asyncExpand', () => _source().asyncExpand(Stream<int>.value), 'Stream'),
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
          StreamTransformer<int, int>.fromHandlers(handleData: (e, s) {})),
      'Stream'),
  _Probe('where', () => _source().where((e) => true), 'Stream'),
  // Static members returning a Stream.
  _Probe('castFrom', () => Stream.castFrom<int, num>(_source()), 'Stream'),
  _Probe('empty', () => const Stream<int>.empty(), 'Stream'),
  _Probe('error', () => Stream<int>.error('x'), 'Stream'),
  _Probe('eventTransformed',
      () => Stream<int>.eventTransformed(_source(), (sink) => sink), 'Stream'),
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
  _Probe('listen (single-subscription controller)',
      () => _controller().stream.listen(null), 'StreamSubscription'),
  _Probe('listen (broadcast controller)',
      () => StreamController<int>.broadcast().stream.listen(null),
      'StreamSubscription'),
  _Probe('listen (asBroadcastStream)',
      () => _source().asBroadcastStream().listen(null), 'StreamSubscription'),
  _Probe('listen (empty)', () => const Stream<int>.empty().listen(null),
      'StreamSubscription'),
];

/// Members that return a `StreamSink`.
final _sinkProbes = <_Probe>[
  _Probe('sink', () => _controller().sink, 'StreamSink'),
  _Probe('sink (broadcast)', () => StreamController<int>.broadcast().sink,
      'StreamSink'),
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
  _Probe('asFuture', () => _source().listen(null).asFuture<Object?>(), 'Future'),
  _Probe('cancel', () => _source().listen(null).cancel(), 'Future'),
  _Probe('done', () => _controller().sink.done, 'Future'),
  _Probe('done (controller)', () => _controller().done, 'Future'),
  _Probe('close', () => _controller().sink.close(), 'Future'),
  _Probe('addStream', () => _controller().sink.addStream(_source()), 'Future'),
  _Probe('close (controller)', () => _controller().close(), 'Future'),
  _Probe('addStream (controller)', () => _controller().addStream(_source()),
      'Future'),
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
  _Probe('LinkedList.iterator', () => LinkedList<_ListEntry>().iterator,
      'Iterator'),
  _Probe('RegExp.allMatches().iterator',
      () => RegExp('a').allMatches('a').iterator, 'Iterator'),
  _Probe('Uint8List.iterator', () => Uint8List(1).iterator, 'Iterator'),
  _Probe('Int32List.iterator', () => Int32List(1).iterator, 'Iterator'),
  _Probe('Float64List.iterator', () => Float64List(1).iterator, 'Iterator'),
  // dart:convert — fused converters. The SDK special-cases the UTF-8/JSON pair
  // in both directions and uses a general wrapper for everything else, so both
  // paths need a claim.
  _Probe('Converter.fuse (utf8 + json)', () => utf8.decoder.fuse(json.decoder),
      'Converter'),
  _Probe('Converter.fuse (general)',
      () => ascii.decoder.fuse(json.decoder), 'Converter'),
  _Probe('Converter.fuse (base64)',
      () => base64.encoder.fuse<String>(_IdentityConverter<String>()),
      'Converter'),
  _Probe('Codec.inverted', () => utf8.inverted, 'Codec'),
  _Probe('Codec.inverted (json)', () => json.inverted, 'Codec'),
  _Probe('Codec.inverted (base64)', () => base64.inverted, 'Codec'),
  // dart:io — a Stream implementation defined outside dart:async.
  _Probe('File.openRead', () => File('pubspec.yaml').openRead(), 'Stream'),
  _Probe('File.openRead (ranged)', () => File('pubspec.yaml').openRead(0, 4),
      'Stream'),
];

// ---------------------------------------------------------------------------

void main() {
  group('SCC24: native-name coverage', () {
    test(
        'F-SCC24-1: every instance getter on every bridge returns a value that '
        'resolves [2026-09-04]', () {
      final env = _stdlibEnvironment();
      final instances = _canonicalInstances();
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
          final resolved = _resolvedBridgeName(env, result);
          if (resolved == '<inert: no bridge>') {
            inert[key] = '${result.runtimeType}';
          }
        }
      }

      expect(inert, isEmpty,
          reason: 'These getters return a value that no bridge claims, so '
              'every member call on the result would fail with "Undefined '
              'property or method ... on _Whatever". Add the private type the '
              'SDK reported to `nativeNames` on the bridge for the type it '
              'actually is — and then check whether the member has any test '
              'coverage at all, because an inert return value means it could '
              'not have been used, which is how the previous four instances of '
              'this defect stayed hidden.');
    });

    test(
        'F-SCC24-2: every dart:async member returning a Stream resolves to the '
        'Stream bridge [2026-09-04]', () {
      expect(_gaps(_streamProbes), isEmpty,
          reason: 'Add the reported private type to `nativeNames` on the '
              'Stream bridge in stdlib/async/stream.dart.');
    });

    test(
        'F-SCC24-3: every dart:async member returning a StreamSubscription '
        'resolves to the StreamSubscription bridge [2026-09-04]', () {
      expect(_gaps(_subscriptionProbes), isEmpty,
          reason: 'Add the reported private type to `nativeNames` on the '
              'StreamSubscription bridge.');
    });

    test(
        'F-SCC24-4: every dart:async member returning a StreamSink resolves to '
        'the StreamSink bridge [2026-09-04]', () {
      expect(_gaps(_sinkProbes), isEmpty,
          reason: 'This is the SC4 defect. Add the reported private type to '
              '`nativeNames` on the StreamSink bridge.');
    });

    test(
        'F-SCC24-5: every dart:async member returning a Future resolves to the '
        'Future bridge [2026-09-04]', () {
      expect(_gaps(_futureProbes), isEmpty,
          reason: 'An unclaimed Future is inert in exactly the same way an '
              'unclaimed Stream is. Add the reported private type to '
              '`nativeNames` on the Future bridge.');
    });

    test(
        'F-SCC24-6: every declared member of the async family bridges is '
        'probed or explicitly exempt [2026-09-04]', () {
      final probed =
          _asyncFamilyProbes.map((p) => p.member.split(' ').first).toSet();
      final unclassified = <String, List<String>>{};
      for (final entry in _asyncFamilyBridges().entries) {
        final bridge = entry.value;
        final members = <String>{
          ...bridge.methods.keys,
          ...bridge.getters.keys,
          ...bridge.staticMethods.keys,
          ...bridge.staticGetters.keys,
        };
        final missing = members
            .where((m) =>
                !probed.contains(m) &&
                !_asyncNonFamilyReturning.containsKey(m))
            .toList()
          ..sort();
        if (missing.isNotEmpty) unclassified[entry.key] = missing;
      }
      expect(unclassified, isEmpty,
          reason: 'A bridged member was added without deciding whether it can '
              'return a family value. Either add a probe for it, or add it to '
              '`_asyncNonFamilyReturning` with the type it actually returns. '
              'The probe table must not be able to fall behind the bridge '
              'definition — that is the whole point of this guard.');
    });

    test(
        'F-SCC24-7: the collection, convert and io gaps SCC24 found stay fixed '
        '[2026-09-04]', () {
      // These members take arguments, so the getter sweep in F-SCC24-1 cannot
      // reach them. Every one was inert before SCC24, and each had the
      // second-order symptom: `Codec.inverted` had no test anywhere in the
      // suite, the general `Converter.fuse` path had none, and the suite's one
      // `File.openRead` call never touched a member of the result.
      expect(_gaps(_beyondAsyncProbes), isEmpty,
          reason: 'A previously fixed gap has reopened, or an SDK upgrade '
              'renamed the implementation type behind one of these members.');
    });

    test(
        'F-SCC24-8: the check fails when a nativeNames entry is missing '
        '[2026-09-04]', () {
      // Verify by breaking. A family bridge with an EMPTY `nativeNames` must
      // NOT resolve these values — otherwise the resolver's name-based
      // fallbacks would be doing the work, the enumeration would not be
      // load-bearing, and every assertion above would pass no matter what was
      // deleted from the lists. Measured when this file was written: 26 of 27
      // stream-family values fail to resolve without their entry.
      //
      // No private type name appears here either: the values come from the same
      // public calls, and the assertion is only that resolution FAILS without
      // the enumeration.
      final bare = Environment()
        ..defineBridge(BridgedClass(
          nativeType: Stream,
          name: 'Stream',
          typeParameterCount: 1,
          nativeNames: const [],
        ))
        ..defineBridge(BridgedClass(
          nativeType: StreamSubscription,
          name: 'StreamSubscription',
          typeParameterCount: 1,
          nativeNames: const [],
        ))
        ..defineBridge(BridgedClass(
          nativeType: StreamSink,
          name: 'StreamSink',
          typeParameterCount: 1,
          nativeNames: const [],
        ));

      for (final value in <Object?>[
        _controller().stream,
        _controller().sink,
        _source().handleError((Object e) {}),
        _source().map((e) => e),
        _source().listen(null),
      ]) {
        expect(_resolvedBridgeName(bare, value), '<inert: no bridge>',
            reason: 'Without its `nativeNames` entry this value resolved '
                'anyway, which means the assertions above are not actually '
                'guarding the enumeration.');
      }
    });

    test(
        'F-SCC24-9: the sweep\'s blind spot does not grow [2026-09-04]', () {
      // F-SCC24-1 can only check bridges it has a canonical instance for.
      // Bridges without one are its blind spot. Pinning the count means adding
      // a bridge forces either an instance (widening the sweep) or a deliberate
      // decision to leave it uncovered — it cannot happen silently.
      //
      // Measured 2026-09-04: 170 bridges registered, 111 with a canonical
      // instance, 20 with getters but no instance. The remainder declare no
      // instance getters, so an instance would add nothing.
      //
      // The 20 are not arbitrary leftovers — every one needs a resource this
      // suite should not acquire (a bound socket, a spawned process, a live
      // HTTP exchange, the real stdio handles) or cannot be constructed at
      // all (`OutOfMemoryError`, `StackOverflowError`). Widening the sweep to
      // them means standing a server up inside the guard, which is a
      // different kind of test; tracked separately rather than smuggled in
      // here.
      //
      // The bound is `lessThanOrEqualTo`, not `equals`, on purpose: adding a
      // canonical instance should never fail the guard, only removing
      // coverage should.
      final env = _stdlibEnvironment();
      final instances = _canonicalInstances();
      final uncovered = _allBridges(env)
          .values
          .where((b) => b.getters.isNotEmpty && !instances.containsKey(b.name))
          .map((b) => b.name)
          .toList()
        ..sort();

      expect(uncovered.length, lessThanOrEqualTo(20),
          reason: 'A bridge with instance getters was added without a '
              'canonical instance in `_canonicalInstances`, so F-SCC24-1 '
              'cannot see it. Add one, or lower this baseline deliberately. '
              'Uncovered: ${uncovered.join(', ')}');
    });
  });
}
