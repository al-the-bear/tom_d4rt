import 'package:tom_d4rt_ast/runtime.dart';

/// Supertype edges for `dart:io`.
///
/// The last of the large stdlib libraries to get one. `dart:collection`,
/// `dart:convert`, `dart:typed_data`, `dart:async` and (since SCC56) `dart:core`
/// all declare their hierarchies; `dart:io` declared nothing, so the type tests
/// a script writes about the two shapes the library is built out of — the byte
/// sink and the stream source — all answered `false`.
///
/// **Two declarations close six edges.** `IOSink implements
/// StreamSink&lt;List&lt;int&gt;&gt;, StringSink`, and `dart:async` already
/// declares `StreamSink -> EventSink, StreamConsumer` and `EventSink -> Sink`.
/// So `Socket -> IOSink` plus `IOSink`'s own two reach `EventSink`, `Sink`,
/// `StreamConsumer`, `StreamSink` and `StringSink` — five answers from one
/// declaration, because the registry walks rather than looks up.
///
/// **Why the fallback did not already cover this.** `Socket is IOSink` *was*
/// true before this block, answered by `IOSinkIo.isAssignable` with nothing
/// declared behind it. That single true answer is why the gap survived
/// inspection for so long: whoever spot-checked it got the right answer and
/// stopped. A predicate is consulted for the pair being asked about and does not
/// then continue up the target's own supertypes — so `socket is StringSink`
/// stayed false while `socket is IOSink` was true. Only a registered edge walks.
///
/// **Dispatch.** Unlike the `dart:core` block, every class named here has an
/// `isAssignable` predicate, so these edges do feed
/// `Environment._filterToMostSpecific`. The direction is the safe one — the
/// filter can now drop an `IOSink` or `Stream` match in favour of the more
/// specific `Socket` or `Stdout` — but that is pinned rather than argued: see the
/// `F-SCC57-3x` cases in `test/stdlib/io/io_hierarchy_test.dart`.
///
/// Each edge is declared ONCE, mirroring the SDK's own `implements` clause; the
/// transitive closure is computed by the registry walk. Spelling closures out by
/// hand is what hid the depth defect SCC19 fixed, and a block written that way
/// passes its own tests without ever exercising the walk.
///
/// The registry keys on NAME, so `register()` must run after the bridges these
/// names refer to are defined.
class IoHierarchyIo {
  static void register() {
    BridgedClass.registerSupertypes(const {
      // The byte sinks. `abstract interface class IOSink implements
      // StreamSink<List<int>>, StringSink` is the hub: everything else in this
      // group reaches five supertypes through it.
      'IOSink': ['StreamSink', 'StringSink'],
      // `abstract interface class Socket implements Stream<Uint8List>, IOSink`
      // — the one class in the library that is both shapes at once, which is why
      // it carried six missing edges rather than five or one.
      'Socket': ['Stream', 'IOSink'],
      'Stdout': ['IOSink'],
      // `abstract interface class HttpClientRequest implements IOSink`. Declared
      // from the SDK reading rather than from a measurement: the audit cannot
      // probe this class at all, because the value `HttpClient.getUrl` yields is
      // bridged as `IOSink` and so answers for the wrong bridge. An edge the
      // instrument cannot see is still either right or wrong in the registry,
      // and the SDK says which.
      'HttpClientRequest': ['IOSink'],
      // `abstract interface class HttpResponse implements IOSink`. Unlike the
      // line above, this edge IS reachable by the audit — and it has to be
      // declared for dispatch and not only for `is`: an `HttpResponse` value
      // satisfies both its own predicate and `IOSinkIo`'s, and with nothing
      // ordering them `_filterToMostSpecific` has no ground to drop the base.
      'HttpResponse': ['IOSink'],
      // `abstract class WebSocket implements Stream<dynamic>,
      // StreamSink<dynamic>` — the one class in the library that is both shapes
      // without going through `IOSink`, because its sink element type is
      // `String|List<int>` and not bytes. Listed with the sinks rather than
      // twice; the `Stream` half carries the same dispatch argument as
      // `HttpRequest` below.
      'WebSocket': ['Stream', 'StreamSink'],

      // The stream sources. Each `implements Stream<T>` for its own element
      // type, which the registry does not model — the edge is on the raw name,
      // and `is Stream` is the question scripts actually ask.
      'Stdin': ['Stream'],
      'HttpServer': ['Stream'],
      // `abstract interface class HttpRequest implements Stream<Uint8List>` —
      // the request body. Same dispatch argument as `HttpResponse` above, with
      // `StreamCore` as the base that would otherwise tie.
      'HttpRequest': ['Stream'],
      'HttpClientResponse': ['Stream'],
      'RawDatagramSocket': ['Stream'],
      'RawServerSocket': ['Stream'],
      'RawSocket': ['Stream'],
      'ServerSocket': ['Stream'],

      // The value types. `class OSError implements Exception` is the one edge
      // here a script reaches by catching rather than by testing: an
      // `on Exception` handler around a failed file operation never matched the
      // `OSError` a failure carries, so the handler was skipped in favour of the
      // rethrow.
      'OSError': ['Exception'],
      // Already true before this block, via the `FileSystemEntity` and
      // `HeaderValue` predicates. Declared so the hierarchy reads from one place
      // rather than being inferred from a predicate in another file — the same
      // reasoning as `RegExpMatch -> Match` in the `dart:core` block.
      'File': ['FileSystemEntity'],
      'Directory': ['FileSystemEntity'],
      'ContentType': ['HeaderValue'],
      // `abstract interface class HttpSession implements Map`. The Map surface
      // is spread into `HttpSessionIo` from `MapCore` rather than inherited —
      // bridge member lookup is flat and does not walk this registry — so the
      // edge is here for the type test, and to record that the spread is
      // implementing a declared relationship rather than borrowing adapters.
      'HttpSession': ['Map'],
      // The credentials family (SCC64). `HttpClientCredentials` is the marker
      // `addCredentials` accepts, so `concrete is HttpClientCredentials` is the
      // question a script actually asks — and `isAssignable` is consulted only
      // for the pair being asked about, never walking the target's own
      // supertypes, so without these edges that question answers false while
      // `concrete is ConcreteType` passes.
      //
      // They also break the bridge-selection tie: both the marker and the
      // concrete bridge answer `isAssignable` true for the same native object,
      // and hand-written bridges all carry `hierarchyDepth == 0`.
      'HttpClientBasicCredentials': ['HttpClientCredentials'],
      'HttpClientDigestCredentials': ['HttpClientCredentials'],
      'HttpClientBearerCredentials': ['HttpClientCredentials'],
    });
  }
}
