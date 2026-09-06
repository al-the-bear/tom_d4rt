import 'package:test/test.dart';
import '../../interpreter_test.dart';

/// SCC63 — the WebSocket block, the last of the three unreachable `dart:io`
/// re-export groups SCB21's audit found.
///
/// Unlike SCC61 (exceptions, which failed *silently* — an unresolvable name in
/// a catch clause is a handler that never matches) and SCC62 (the server half,
/// which was half-built — a bridged `HttpServer` handing out values with no
/// name), nothing WebSocket-shaped was bridged at all. `WebSocket`,
/// `WebSocketTransformer`, `WebSocketException`, `WebSocketStatus` and
/// `CompressionOptions` all failed loudly on first mention, so no script was
/// part-way through using them. That is why this block was scoped last.
///
/// **SCC62 is what made this testable end to end.** `WebSocketTransformer.upgrade`
/// takes an `HttpRequest`, and until SCC62 bridged that type a script could not
/// hold one — the server-side half of every case below would have had to be
/// faked, leaving only name-resolution assertions. `F-SCC63-1` is instead a real
/// handshake: the script binds a port, upgrades the inbound request, connects to
/// itself as a client, exchanges a message in each direction and reads the close
/// code back. The script is both ends for the same reason `http_server_test.dart`
/// gives — driving the client from the host would require the port before the
/// script runs, and a pre-bound-then-released port is a race.
///
/// SANDBOX POSTURE: this file adds no permission gate, inheriting SCC62's
/// decision rather than inventing a second one. The measurement that decision
/// rests on is that `NetworkPermission` gates exactly one call site in the whole
/// library (`InternetAddress.lookup`) while `bind`, `connect` and the entire
/// `HttpClient` surface sit behind an import gate keyed on
/// `FilesystemPermission`. A gate added here would be bypassable — a script can
/// reach the same socket through `HttpServer.bind` plus `HttpResponse.detachSocket`
/// — while *looking* like the capability was sandboxed, which is worse than the
/// honest absence. Closing the gap coherently across the library is tracked
/// separately.
void main() {
  group('SCC63: a script can hold both ends of a WebSocket', () {
    test('F-SCC63-1: upgrade, connect, exchange a message each way, read the '
        'close code [2026-09-06]', () async {
      // The whole todo in one script. Before these bridges the first line of
      // the listener body failed on `WebSocketTransformer`.
      //
      // `.then` rather than an `async` closure: the callback is invoked from
      // native code through `runAction`, which returns the callback's value
      // without awaiting it, so an `async` listener body would run detached and
      // its errors would surface with no line number.
      const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        var serverSaw = [];
        server.listen((request) {
          WebSocketTransformer.upgrade(request).then((socket) {
            socket.listen((message) {
              serverSaw.add(message);
              socket.add('echo:' + message);
              socket.close(WebSocketStatus.normalClosure, 'bye');
            });
          });
        });

        var client = await WebSocket.connect(
          'ws://127.0.0.1:' + server.port.toString() + '/');
        var received = [];
        var closed = Completer();
        client.listen(
          (message) { received.add(message); },
          onDone: () { closed.complete(); },
        );
        client.add('hello');
        await closed.future;
        await server.close();

        return [serverSaw, received, client.closeCode, client.closeReason];
      }
      ''';
      expect(
        await executeAsync(source),
        equals([
          ['hello'],
          ['echo:hello'],
          // 1000 is `WebSocketStatus.normalClosure`, asserted as a literal so
          // the expectation does not read the same constant the script wrote.
          1000,
          'bye',
        ]),
      );
    });

    test('F-SCC63-2: the socket is recognised as its own type and as the two '
        'shapes it implements [2026-09-06]', () async {
      // `abstract class WebSocket implements Stream<dynamic>, StreamSink<dynamic>`
      // — both edges have to be declared in `IoHierarchyIo`, and for dispatch
      // and not only for `is`: a `WebSocket` value satisfies its own predicate
      // and `StreamCore`'s at once, and with nothing ordering them
      // `_filterToMostSpecific` has no ground to drop the base.
      const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        server.listen((request) {
          WebSocketTransformer.upgrade(request).then((socket) {
            socket.close();
          });
        });

        var client = await WebSocket.connect(
          'ws://127.0.0.1:' + server.port.toString() + '/');
        var kinds = [
          client is WebSocket,
          client is Stream,
          client is StreamSink,
          client is HttpRequest,
        ];
        await client.close();
        await server.close();
        return kinds;
      }
      ''';
      expect(await executeAsync(source), equals([true, true, true, false]));
    });

    test('F-SCC63-3: the declared getters all read [2026-09-06]', () async {
      // A sweep rather than one assertion per getter, for the reason
      // `http_server_test.dart` gives: an unbridged getter on a bridged class
      // throws rather than failing quietly, so one script touching all of them
      // is the same coverage at a fraction of the handshake setup.
      const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        server.listen((request) {
          WebSocketTransformer.upgrade(request).then((socket) {
            socket.close();
          });
        });

        var client = await WebSocket.connect(
          'ws://127.0.0.1:' + server.port.toString() + '/');
        var out = [
          client.readyState,
          client.extensions,
          client.protocol,
          client.closeCode,
          client.closeReason,
          client.pingInterval,
        ];
        await client.close();
        await server.close();
        return out;
      }
      ''';
      expect(
        await executeAsync(source),
        equals([
          // 1 is `WebSocket.open` — the connection is live at the point the
          // getters are read, which is what makes the two close fields null
          // rather than merely unbridged.
          1,
          // The empty string is the SDK's own constant, not a negotiation
          // result: `_WebSocketImpl` declares `String get extensions => "";`
          // and never populates it. So this row pins that the getter is
          // *reachable*, and `F-SCC63-19` has to observe compression on the
          // wire instead — which is why it reads a request header rather than
          // this property.
          '',
          null,
          null,
          null,
          null,
        ]),
      );
    });

    test(
      'F-SCC63-4: pingInterval is settable and reads back [2026-09-06]',
      () async {
        // The one mutable member on the class. A bridge carrying the getter alone
        // would satisfy `F-SCC63-3` while leaving the property read-only, which is
        // the same failure mode `HttpResponse`'s setters were bridged to avoid.
        const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        server.listen((request) {
          WebSocketTransformer.upgrade(request).then((socket) {
            socket.close();
          });
        });

        var client = await WebSocket.connect(
          'ws://127.0.0.1:' + server.port.toString() + '/');
        client.pingInterval = Duration(seconds: 30);
        var seconds = client.pingInterval.inSeconds;
        await client.close();
        await server.close();
        return seconds;
      }
      ''';
        expect(await executeAsync(source), equals(30));
      },
    );

    test(
      'F-SCC63-5: a binary frame arrives as bytes, not as text [2026-09-06]',
      () async {
        // `WebSocket.add` takes `String|List<int>` and the frame opcode follows
        // the argument's runtime type, so this is the case that fails if the
        // adapter coerces its argument to one shape. The script's list literal is
        // `List<dynamic>` at runtime, which is exactly the value the SDK would
        // reject — the adapter has to narrow it.
        const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        var got = Completer();
        server.listen((request) {
          WebSocketTransformer.upgrade(request).then((socket) {
            socket.listen((message) {
              got.complete([message is String, message.length, message[1]]);
              socket.close();
            });
          });
        });

        var client = await WebSocket.connect(
          'ws://127.0.0.1:' + server.port.toString() + '/');
        client.add([7, 8, 9]);
        var out = await got.future;
        await client.close();
        await server.close();
        return out;
      }
      ''';
        expect(await executeAsync(source), equals([false, 3, 8]));
      },
    );

    test('F-SCC63-6: addUtf8Text sends a text frame built from bytes '
        '[2026-09-06]', () async {
      // The method exists precisely so a caller holding UTF-8 bytes can send
      // them as TEXT rather than as binary, so the discriminating assertion is
      // that the peer receives a `String` — the same bytes through `add` would
      // arrive as a byte list, which `F-SCC63-5` pins.
      const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        var got = Completer();
        server.listen((request) {
          WebSocketTransformer.upgrade(request).then((socket) {
            socket.listen((message) {
              got.complete([message is String, message]);
              socket.close();
            });
          });
        });

        var client = await WebSocket.connect(
          'ws://127.0.0.1:' + server.port.toString() + '/');
        client.addUtf8Text([104, 105]);
        var out = await got.future;
        await client.close();
        await server.close();
        return out;
      }
      ''';
      expect(await executeAsync(source), equals([true, 'hi']));
    });

    test('F-SCC63-7: addStream sends one frame per event [2026-09-06]', () async {
      // `Future addStream(Stream stream)` is the `StreamSink` half of the class
      // and the only member that takes a stream rather than a value. One frame
      // per event is the SDK's documented behaviour and not an implementation
      // detail, so asserting three received messages rather than one
      // concatenation is asserting the contract.
      const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        var seen = [];
        var got = Completer();
        server.listen((request) {
          WebSocketTransformer.upgrade(request).then((socket) {
            socket.listen(
              (message) { seen.add(message); },
              onDone: () { got.complete(seen); },
            );
          });
        });

        var client = await WebSocket.connect(
          'ws://127.0.0.1:' + server.port.toString() + '/');
        await client.addStream(Stream.fromIterable(['a', 'b', 'c']));
        await client.close();
        var out = await got.future;
        await server.close();
        return out;
      }
      ''';
      expect(await executeAsync(source), equals(['a', 'b', 'c']));
    });

    test(
      'F-SCC63-8: done completes once this end has closed [2026-09-06]',
      () async {
        // `done` is the `StreamSink` half of the class and tracks THIS end's
        // sink, not the connection: measured against the SDK directly, a `done`
        // awaited on a socket whose *peer* closed never completes. So the case is
        // written around the script's own `close()`, and the peer-initiated
        // shutdown is covered by `F-SCC63-1`'s `onDone` instead. Asserting the
        // intuitive version would have been asserting a hang.
        //
        // `readyState` and the close fields are deliberately not asserted here:
        // `close()` resolves before the closing handshake has completed, so all
        // three are still in flight at this point. `F-SCC63-1` reads them after
        // the peer's close arrives, which is when they are settled.
        const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        server.listen((request) {
          WebSocketTransformer.upgrade(request).then((socket) {
            socket.listen((message) {});
          });
        });

        var client = await WebSocket.connect(
          'ws://127.0.0.1:' + server.port.toString() + '/');
        client.listen((message) {});
        await client.close(WebSocketStatus.goingAway, 'client leaving');
        await client.done;
        await server.close();
        return 'done resolved';
      }
      ''';
        expect(await executeAsync(source), equals('done resolved'));
      },
    );
  });

  group('SCC63: WebSocketTransformer', () {
    test('F-SCC63-9: isUpgradeRequest separates a handshake from a plain GET '
        '[2026-09-06]', () async {
      // The predicate a real server calls BEFORE upgrading, so a false positive
      // here would make every ordinary request get hijacked. Both answers are
      // asserted from one server, because a bridge returning a constant would
      // satisfy either case alone.
      const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        var verdicts = [];
        var plainDone = Completer();
        server.listen((request) {
          var isUpgrade = WebSocketTransformer.isUpgradeRequest(request);
          verdicts.add(isUpgrade);
          if (isUpgrade) {
            WebSocketTransformer.upgrade(request).then((socket) {
              socket.close();
            });
          } else {
            request.response.close();
            plainDone.complete();
          }
        });

        var url = 'http://127.0.0.1:' + server.port.toString() + '/';
        var httpClient = HttpClient();
        var plain = await httpClient.getUrl(Uri.parse(url));
        await plain.close();
        await plainDone.future;

        var socket = await WebSocket.connect(
          'ws://127.0.0.1:' + server.port.toString() + '/');
        await socket.close();

        await server.close();
        httpClient.close();
        return verdicts;
      }
      ''';
      expect(await executeAsync(source), equals([false, true]));
    });

    test('F-SCC63-10: protocolSelector picks from the offered subprotocols '
        '[2026-09-06]', () async {
      // The one place `WebSocketTransformer.upgrade` calls back INTO the script,
      // so it is the case that fails if the named callback is passed through
      // unwrapped. The selected value has to come back out on
      // `WebSocket.protocol` at both ends — asserting only the server's copy
      // would pass on a bridge that never sent the negotiated header.
      const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        var offered = Completer();
        server.listen((request) {
          WebSocketTransformer.upgrade(
            request,
            protocolSelector: (protocols) {
              offered.complete(protocols);
              return 'v2';
            },
          ).then((socket) { socket.close(); });
        });

        var client = await WebSocket.connect(
          'ws://127.0.0.1:' + server.port.toString() + '/',
          protocols: ['v1', 'v2']);
        var seen = await offered.future;
        var negotiated = client.protocol;
        await client.close();
        await server.close();
        return [seen, negotiated];
      }
      ''';
      expect(
        await executeAsync(source),
        equals([
          ['v1', 'v2'],
          'v2',
        ]),
      );
    });

    test(
      'F-SCC63-11: the factory constructor builds a transformer [2026-09-06]',
      () {
        // `factory WebSocketTransformer({protocolSelector, compression})`. Bridged
        // for completeness of the class rather than because a script needs it —
        // the static `upgrade` is the ergonomic path and is what `F-SCC63-1` uses.
        // Pinned so the constructor is not quietly dropped as unused.
        const source = '''
      import 'dart:io';
      main() {
        var t = WebSocketTransformer();
        var custom = WebSocketTransformer(
          compression: CompressionOptions.compressionOff);
        return [t is WebSocketTransformer, custom is WebSocketTransformer];
      }
      ''';
        expect(execute(source), equals([true, true]));
      },
    );
  });

  group('SCC63: WebSocketStatus', () {
    // A constants holder — `abstract class WebSocketStatus` with no
    // constructor and thirteen static const ints, the same shape as
    // `HttpStatus`. Every constant is read rather than a representative few,
    // because the failure mode is a single missing `staticGetter` and a
    // spot-check finds it only by luck.
    const expected = <String, int>{
      'normalClosure': 1000,
      'goingAway': 1001,
      'protocolError': 1002,
      'unsupportedData': 1003,
      'reserved1004': 1004,
      'noStatusReceived': 1005,
      'abnormalClosure': 1006,
      'invalidFramePayloadData': 1007,
      'policyViolation': 1008,
      'messageTooBig': 1009,
      'missingMandatoryExtension': 1010,
      'internalServerError': 1011,
      'reserved1015': 1015,
    };

    expected.forEach((name, value) {
      test(
        'F-SCC63-12-$name: WebSocketStatus.$name is $value [2026-09-06]',
        () {
          final source =
              '''
        import 'dart:io';
        main() { return WebSocketStatus.$name; }
        ''';
          expect(execute(source), equals(value));
        },
      );
    });
  });

  group('SCC63: WebSocket state constants', () {
    const expected = <String, int>{
      'connecting': 0,
      'open': 1,
      'closing': 2,
      'closed': 3,
    };

    expected.forEach((name, value) {
      test('F-SCC63-13-$name: WebSocket.$name is $value [2026-09-06]', () {
        // These sit on `WebSocket` itself rather than on `WebSocketStatus`,
        // which is easy to get backwards when writing the bridge — `readyState`
        // is compared against them and against nothing else.
        final source =
            '''
        import 'dart:io';
        main() { return WebSocket.$name; }
        ''';
        expect(execute(source), equals(value));
      });
    });
  });

  group('SCC63: WebSocketException', () {
    test('F-SCC63-14: it constructs, carries its fields and stringifies '
        '[2026-09-06]', () {
      const source = '''
      import 'dart:io';
      main() {
        var bare = WebSocketException();
        var withMessage = WebSocketException('handshake failed');
        var withStatus = WebSocketException('rejected', 401);
        return [
          bare.message,
          bare.httpStatusCode,
          withMessage.message,
          withMessage.toString(),
          withStatus.httpStatusCode,
          withStatus.toString(),
        ];
      }
      ''';
      expect(
        execute(source),
        equals([
          '',
          null,
          'handshake failed',
          'WebSocketException: handshake failed',
          401,
          // The SDK appends the status only when one was supplied, which is why
          // both `toString` forms are asserted rather than one.
          'WebSocketException: rejected, HTTP status code: 401',
        ]),
      );
    });

    test('F-SCC63-15: it is catchable, and as an IOException [2026-09-06]', () {
      // `class WebSocketException implements IOException`. Reachability is the
      // whole point of bridging an exception type: an unresolvable name in a
      // catch clause is not an error, it is a handler that silently never
      // matches — which is the failure SCC61 was written about.
      //
      // `is` inside the handler rather than a second `on` clause, for the reason
      // `http_exception_test.dart` gives: an `on` clause inside an async body
      // currently matches unconditionally, so an `on`-shaped assertion would be
      // green with or without the edge.
      const source = '''
      import 'dart:io';
      main() {
        var out = [];
        try {
          throw WebSocketException('boom');
        } on WebSocketException catch (e) {
          out.add(e.message);
          out.add(e is IOException);
          out.add(e is Exception);
        }
        return out;
      }
      ''';
      expect(execute(source), equals(['boom', true, true]));
    });

    test('F-SCC63-16: a natively-thrown handshake failure is catchable by name '
        '[2026-09-06]', () async {
      // The case the bridge exists for, as opposed to the two above where the
      // script both throws and catches. An exception crossing from native code
      // reaches the catch clause as a native object, so `isAssignable` is what
      // makes this match — a bridge with a constructor but no predicate passes
      // `F-SCC63-14` and fails here.
      //
      // Connecting to an ordinary HTTP endpoint that does not upgrade is the
      // deterministic way to provoke one; a closed port raises a
      // `SocketException` instead, which would test the wrong type.
      const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        server.listen((request) {
          request.response.statusCode = 200;
          request.response.close();
        });

        var out = [];
        try {
          await WebSocket.connect(
            'ws://127.0.0.1:' + server.port.toString() + '/');
          out.add('no throw');
        } catch (e) {
          out.add(e is WebSocketException);
          out.add(e is IOException);
        }
        await server.close();
        return out;
      }
      ''';
      expect(await executeAsync(source), equals([true, true]));
    });
  });

  group('SCC63: CompressionOptions', () {
    test('F-SCC63-17: the two static instances read their fields [2026-09-06]', () {
      // `compressionDefault` is the value every `connect`/`upgrade` call takes
      // when none is passed, so its fields are the negotiation the interpreter
      // performs by default. Asserting them pins that the bridge is exposing the
      // SDK's constants and not reconstructing equivalent-looking ones.
      const source = '''
      import 'dart:io';
      main() {
        var d = CompressionOptions.compressionDefault;
        var off = CompressionOptions.compressionOff;
        return [
          d.enabled,
          d.clientNoContextTakeover,
          d.serverNoContextTakeover,
          d.clientMaxWindowBits,
          d.serverMaxWindowBits,
          off.enabled,
        ];
      }
      ''';
      expect(execute(source), equals([true, false, false, null, null, false]));
    });

    test('F-SCC63-18: the const constructor takes its named arguments '
        '[2026-09-06]', () {
      const source = '''
      import 'dart:io';
      main() {
        var o = CompressionOptions(
          clientNoContextTakeover: true,
          serverNoContextTakeover: true,
          clientMaxWindowBits: 12,
          serverMaxWindowBits: 13,
          enabled: false,
        );
        return [
          o is CompressionOptions,
          o.clientNoContextTakeover,
          o.serverNoContextTakeover,
          o.clientMaxWindowBits,
          o.serverMaxWindowBits,
          o.enabled,
        ];
      }
      ''';
      expect(execute(source), equals([true, true, true, 12, 13, false]));
    });

    test('F-SCC63-19: the options a script passes change what goes on the wire '
        '[2026-09-06]', () async {
      // The reason the class is bridged rather than merely nameable: passing it
      // has an observable effect. The observation has to be made on the
      // handshake headers the server receives, because `WebSocket.extensions`
      // is a hardcoded `""` upstream (see `F-SCC63-3`) and reports nothing.
      //
      // Two connections against one server, differing only in this argument:
      // `compressionOff` offers no extension at all, an enabled one offers
      // per-message-deflate. A bridge that dropped the argument would produce
      // the same header twice, and one connection alone could not tell.
      const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var offers = [];
        var seen = Completer();
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        server.listen((request) {
          offers.add(request.headers.value('sec-websocket-extensions'));
          if (offers.length == 2) { seen.complete(); }
          WebSocketTransformer.upgrade(request).then((socket) {
            socket.listen((message) {});
          });
        });

        var url = 'ws://127.0.0.1:' + server.port.toString() + '/';
        var off = await WebSocket.connect(
          url, compression: CompressionOptions.compressionOff);
        await off.close();
        var on = await WebSocket.connect(
          url, compression: CompressionOptions(enabled: true));
        await on.close();

        await seen.future;
        await server.close();
        return [offers[0], offers[1].contains('permessage-deflate')];
      }
      ''';
      expect(await executeAsync(source), equals([null, true]));
    });
  });

  group('SCC63: the remaining statics', () {
    test('F-SCC63-20: fromUpgradedSocket builds a socket over a raw connection '
        '[2026-09-06]', () async {
      // The third way to obtain a `WebSocket`, and the only one that does not
      // perform a handshake — the caller asserts one already happened. Exercised
      // over a bare `Socket` pair, which is exactly the situation
      // `HttpResponse.detachSocket` leaves a hand-rolled server in.
      //
      // `serverSide` is required despite being named and nullable, and the SDK
      // raises `ArgumentError` rather than defaulting when it is omitted. Both
      // halves are asserted, because a bridge that quietly supplied a default
      // would pass the success case while diverging from Dart on the other.
      const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
        var accepted = Completer();
        server.listen((socket) { accepted.complete(socket); });
        var clientSocket = await Socket.connect('127.0.0.1', server.port);
        var serverSocket = await accepted.future;

        var out = [];
        try {
          WebSocket.fromUpgradedSocket(serverSocket);
          out.add('no throw');
        } catch (e) {
          out.add(e.toString().contains('serverSide'));
        }

        var ws = WebSocket.fromUpgradedSocket(serverSocket, serverSide: true);
        // Subscribed before the peer is torn down: an unlistened socket routes
        // the disconnect to the zone's error handler, where it surfaces as an
        // unrelated test failure.
        ws.listen((message) {}, onError: (e) {}, onDone: () {});
        out.add(ws is WebSocket);
        out.add(ws.readyState);

        clientSocket.destroy();
        await server.close();
        return out;
      }
      ''';
      // 1 is `WebSocket.open` — `fromUpgradedSocket` reports a live connection
      // immediately, since by contract the handshake is already behind it.
      expect(await executeAsync(source), equals([true, true, 1]));
    });

    test('F-SCC63-21: the userAgent static round-trips [2026-09-06]', () {
      // A static getter/setter pair, which is a shape the io bridges have
      // nowhere else — every other static on these classes is read-only.
      //
      // The prior value is restored rather than nulled, and asserted by SHAPE
      // rather than by value: the default is the SDK's own version banner
      // (`Dart/3.12 (dart:io)` today), so pinning the literal would make this
      // case fail on the next SDK bump for no reason connected to the bridge.
      // Restoring matters because the setter is process-global — leaving it set
      // would change the handshake every later case in this file performs.
      const source = '''
      import 'dart:io';
      main() {
        var before = WebSocket.userAgent;
        WebSocket.userAgent = 'scc63-agent';
        var after = WebSocket.userAgent;
        WebSocket.userAgent = before;
        return [
          before is String,
          after,
          WebSocket.userAgent == before,
        ];
      }
      ''';
      expect(execute(source), equals([true, 'scc63-agent', true]));
    });

    test('F-SCC63-22: a collection named argument survives the interpreter\'s '
        'element type [2026-09-06]', () async {
      // The one shape on this surface where a plain `as` cast in the bridge is
      // wrong. A map literal written in a script is a `_Map<Object?, Object?>`
      // regardless of what its entries hold, so
      // `namedArgs['headers'] as Map<String, dynamic>?` throws before `connect`
      // is ever reached — and it throws a raw `type '_Map<Object?, Object?>' is
      // not a subtype` cast error, which tells a script author nothing about
      // their own code.
      //
      // Asserted through the wire rather than through the call returning: a
      // bridge could satisfy the cast and still drop the headers, and the point
      // of the argument is that the server sees them.
      const source = '''
      import 'dart:io';
      import 'dart:async';
      Future<Object?> main() async {
        var server = await HttpServer.bind('127.0.0.1', 0);
        var seen = Completer();
        server.listen((req) async {
          seen.complete(req.headers.value('x-probe'));
          await WebSocketTransformer.upgrade(req);
        });
        var ws = await WebSocket.connect(
          'ws://127.0.0.1:' + server.port.toString() + '/',
          headers: {'x-probe': 'yes'},
        );
        var v = await seen.future;
        await ws.close();
        await server.close();
        return v;
      }
      ''';
      expect(await execute(source), equals('yes'));
    });
  });
}
