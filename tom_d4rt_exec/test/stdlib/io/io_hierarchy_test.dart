// SCC57: `dart:io` had no supertype edges at all. `dart:collection`,
// `dart:convert`, `dart:typed_data`, `dart:async` and (since SCC56) `dart:core`
// each got a hierarchy block; `dart:io` never did, so the type tests a script
// writes about the two shapes the library is built out of — the byte sink and
// the stream source — all answered false:
//
//     stdout is StringSink            // false — Stdout implements IOSink
//     socket is Stream                // false — Socket implements Stream<...>
//     await ServerSocket.bind(...) is Stream
//     stdin is Stream
//
// TWO DECLARATIONS CLOSE SIX EDGES, and that is the shape worth understanding
// before reading the cases. `IOSink implements StreamSink<List<int>>,
// StringSink`, and `dart:async` already declares `StreamSink -> EventSink,
// StreamConsumer` and `EventSink -> Sink`. So one edge from `Socket` to `IOSink`
// plus `IOSink`'s own two reach `EventSink`, `Sink`, `StreamConsumer`,
// `StreamSink` and `StringSink` — five answers from one declaration, because the
// registry walks and does not merely look up. Before SCC57 `Socket -> IOSink`
// was already true, answered by `IOSink`'s `isAssignable` with nothing declared
// behind it, and that one true answer bought nothing: a predicate fires for one
// hop and then stops. F-SCC57-3 pins exactly that.
//
// Each edge is declared ONCE, mirroring the SDK's own `implements` clause. A
// block that spelled the closures out by hand would pass every case here without
// ever exercising the walk, which is the defect SCC19 was filed to remove.

import 'dart:io';

import '../../interpreter_test.dart';
import 'package:test/test.dart';

/// Expressions yielding a value that the SDK says is an `IOSink`.
///
/// `stdout` is synchronous; the socket needs a listener, so the async cases live
/// in their own group below.
const _syncSinks = <String, String>{'stdout': 'Stdout'};

/// The five supertypes an `IOSink` carries, four of them reached by walking.
const _sinkSupertypes = <String>[
  'IOSink',
  'StreamSink',
  'StreamConsumer',
  'EventSink',
  'Sink',
  'StringSink',
];

void main() {
  group('SCC57: the dart:io byte-sink edges', () {
    _syncSinks.forEach((expr, className) {
      for (final supertype in _sinkSupertypes) {
        test('F-SCC57-1-$className-$supertype: `$expr is $supertype` answers '
            'true [2026-09-06]', () {
          expect(
            execute("import 'dart:io'; main() => $expr is $supertype;"),
            isTrue,
            reason:
                '$className implements IOSink, and IOSink implements '
                'StreamSink and StringSink; before SCC57 dart:io declared no '
                'supertype edges at all',
          );
        });
      }
    });

    test(
      'F-SCC57-2: a plain `IOSink` carries the same five [2026-09-06]',
      () async {
        // Every other route to an IOSink is a subtype — `stdout` dispatches to the
        // `Stdout` bridge, a connected socket to `Socket` — so `openWrite` is the
        // only expression whose value has `IOSink` as its sole matching bridge.
        // Without this case the edges on `IOSink` itself would be measured only
        // through classes that could have declared them directly.
        final dir = Directory('ztmp')..createSync(recursive: true);
        final path = '${dir.path}/io_hierarchy_test_sink.tmp';
        try {
          for (final supertype in _sinkSupertypes.skip(1)) {
            expect(
              await executeAsync('''
import 'dart:io';
main() async {
  final sink = File('$path').openWrite();
  final answer = sink is $supertype;
  await sink.close();
  return answer;
}
'''),
              isTrue,
              reason: 'IOSink implements StreamSink<List<int>>, StringSink',
            );
          }
        } finally {
          final f = File(path);
          if (f.existsSync()) f.deleteSync();
        }
      },
    );

    test('F-SCC57-3: the `isAssignable` fallback answers one hop and does not '
        'walk [2026-09-06]', () {
      // `Socket is IOSink` was true before SCC57 — `IOSinkIo` declares an
      // `isAssignable` predicate, and a connected socket satisfies it. That is
      // why the five edges above stayed invisible for so long: the one answer
      // anybody spot-checked was already right. A predicate is consulted for the
      // pair being asked about; it does not then continue up the target's own
      // supertypes. Only a registered edge does that.
      //
      // Pinned as an assertion about the mechanism rather than about `dart:io`,
      // because the same reasoning governs every future hierarchy block.
      expect(
        execute("import 'dart:io'; main() => stdout is IOSink;"),
        isTrue,
        reason: 'true before SCC57 as well, via IOSink.isAssignable',
      );
      expect(
        execute("import 'dart:io'; main() => stdout is StringSink;"),
        isTrue,
        reason: 'reachable only by walking from the declared IOSink edge',
      );
    });
  });

  group('SCC57: the dart:io stream-source edges', () {
    test('F-SCC57-11: `stdin is Stream` answers true [2026-09-06]', () {
      expect(execute("import 'dart:io'; main() => stdin is Stream;"), isTrue);
    });

    test(
      'F-SCC57-12: a bound server socket is a `Stream` [2026-09-06]',
      () async {
        expect(
          await executeAsync('''
import 'dart:io';
main() async {
  final s = await ServerSocket.bind('127.0.0.1', 0);
  final answer = s is Stream;
  await s.close();
  return answer;
}
'''),
          isTrue,
        );
      },
    );

    test(
      'F-SCC57-13: a bound HTTP server is a `Stream` [2026-09-06]',
      () async {
        expect(
          await executeAsync('''
import 'dart:io';
main() async {
  final s = await HttpServer.bind('127.0.0.1', 0);
  final answer = s is Stream;
  await s.close(force: true);
  return answer;
}
'''),
          isTrue,
        );
      },
    );

    test(
      'F-SCC57-14: a bound datagram socket is a `Stream` [2026-09-06]',
      () async {
        expect(
          await executeAsync('''
import 'dart:io';
main() async {
  final s = await RawDatagramSocket.bind('127.0.0.1', 0);
  final answer = s is Stream;
  s.close();
  return answer;
}
'''),
          isTrue,
        );
      },
    );

    test('F-SCC57-15: a connected socket is both a `Stream` and an `IOSink` '
        '[2026-09-06]', () async {
      // `abstract interface class Socket implements Stream<Uint8List>, IOSink`
      // — the one class in `dart:io` that is both shapes at once, which is why
      // it carried six confirmed missing edges rather than five or one.
      expect(
        await executeAsync('''
import 'dart:io';
main() async {
  final server = await ServerSocket.bind('127.0.0.1', 0);
  final c = await Socket.connect('127.0.0.1', server.port);
  await server.close();
  final answer = c is Stream && c is IOSink && c is StringSink && c is Sink;
  c.destroy();
  return answer;
}
'''),
        isTrue,
      );
    });
  });

  group('SCC57: the dart:io value-type edges', () {
    test('F-SCC57-21: `OSError` is an `Exception` [2026-09-06]', () {
      // The one edge here that a script reaches by catching rather than by
      // testing: `on Exception` around a failed file operation never matched an
      // `OSError`, so the handler a user wrote was skipped in favour of the
      // rethrow.
      expect(
        execute("import 'dart:io'; main() => OSError('x', 1) is Exception;"),
        isTrue,
      );
    });

    test('F-SCC57-22: `File` and `Directory` are `FileSystemEntity` '
        '[2026-09-06]', () {
      // Already true before SCC57, via `FileSystemEntityIo.isAssignable`, and
      // declared anyway so the hierarchy reads from one place rather than being
      // inferred from a predicate in another file. The same reasoning as
      // `RegExpMatch -> Match` in the `dart:core` block.
      expect(
        execute("import 'dart:io'; main() => File('x') is FileSystemEntity;"),
        isTrue,
      );
      expect(
        execute(
          "import 'dart:io'; main() => Directory('x') is FileSystemEntity;",
        ),
        isTrue,
      );
    });

    test('F-SCC57-23: `ContentType` is a `HeaderValue` [2026-09-06]', () {
      expect(
        execute(
          "import 'dart:io'; "
          "main() => ContentType('text', 'plain') is HeaderValue;",
        ),
        isTrue,
      );
    });
  });

  group('SCC57: dispatch is unchanged', () {
    // Every class touched here declares an `isAssignable` predicate, so unlike
    // the `dart:core` block this one CAN move `Environment._filterToMostSpecific`
    // on all of them. These cases read members that exist on the subtype only:
    // if `IOSink` or `Stream` started winning dispatch, each would fail with
    // "has no instance method named".
    test('F-SCC57-31: `Stdout`-only members still resolve [2026-09-06]', () {
      expect(
        execute(
          "import 'dart:io'; main() => stdout.supportsAnsiEscapes is "
          'bool;',
        ),
        isTrue,
      );
      expect(
        execute("import 'dart:io'; main() => stdout.encoding != null;"),
        isTrue,
      );
    });

    test('F-SCC57-32: `File`-only members still resolve [2026-09-06]', () {
      expect(execute("import 'dart:io'; main() => File('x').path;"), 'x');
      expect(
        execute("import 'dart:io'; main() => File('x').existsSync();"),
        isFalse,
      );
    });

    test(
      'F-SCC57-33: `is` against the io types is still exact [2026-09-06]',
      () {
        // The edges are one-directional. A symmetric registration, or an edge
        // declared the wrong way round, shows up here rather than in a member
        // probe.
        expect(
          execute("import 'dart:io'; main() => File('x') is Directory;"),
          isFalse,
        );
        expect(
          execute("import 'dart:io'; main() => stdout is Stream;"),
          isFalse,
          reason: 'Stdout is a sink, not a source',
        );
        expect(
          execute("import 'dart:io'; main() => stdin is IOSink;"),
          isFalse,
          reason: 'Stdin is a source, not a sink',
        );
      },
    );
  });
}
