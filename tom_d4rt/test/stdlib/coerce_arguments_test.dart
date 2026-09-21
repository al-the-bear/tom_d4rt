// SCD26: an over-narrow cast rejects arguments a script is entitled to pass.
//
// d4rt evaluates a list literal to `List<Object?>` and a map literal to
// `Map<Object?, Object?>` — element and key types are erased — and values that
// came from bridged code arrive as `BridgedInstance` wrappers. So an adapter
// written `positionalArgs[0] as Iterable<int>` tests the CONTAINER's type
// argument, which never matches, rather than its CONTENTS, which usually do.
//
// THE ASYMMETRY IS WHY THESE SURVIVE REVIEW. `Runes('ab').followedBy(Runes('c'))`
// passes the cast and `Runes('ab').followedBy([99])` does not, so the natural
// spot-check reaches for the typed form and sees nothing wrong. Every case below
// therefore passes a LITERAL, which is the shape that was broken.
//
// SCC9 fixed this across eleven typed-data bridges; SCD26 measured how far it
// reaches beyond them and fixed the `core` and `convert` sites. Probed before
// changing anything, because the todo was explicit that not every site is
// broken: `Function.apply` and `latin1.encode` were already correct and are
// asserted here so a future sweep does not "fix" them into a regression.
//
// COERCION MUST NOT WIDEN, which is the half that needs its own cases. An
// element whose type genuinely does not fit must still fail — accepting an
// argument the SDK rejects makes a script green here that cannot compile as
// Dart, and that is the one bridge defect no passing test can catch.

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  dynamic run(String source) {
    final d4rt = D4rt();
    d4rt.grant(FilesystemPermission.any);
    return d4rt.execute(source: source);
  }

  group(
    'SCD26: a literal is a valid argument where the SDK takes a collection',
    () {
      test('F-SCD26-1: Runes.followedBy accepts a list literal [2026-09-12] '
          '(PASS)', () {
        expect(
          run("main() => Runes('ab').followedBy([99]).toList();"),
          equals([97, 98, 99]),
        );
      });

      test('F-SCD26-2: RegExpMatch.groups accepts a list literal [2026-09-12] '
          '(PASS)', () {
        expect(
          run(
            r"main() { var m = RegExp('(a)(b)').firstMatch('ab'); "
            r"return m.groups([1, 2]); }",
          ),
          equals(['a', 'b']),
        );
      });

      test('F-SCD26-3: Uri accepts a map literal for queryParameters '
          '[2026-09-12] (PASS)', () {
        expect(
          run(
            "main() => Uri(scheme: 'x', host: 'y', "
            "queryParameters: {'a': 'b'}).toString();",
          ),
          equals('x://y?a=b'),
        );
      });

      test('F-SCD26-4: Uri accepts a list literal for pathSegments '
          '[2026-09-12] (PASS)', () {
        expect(
          run(
            "main() => Uri(scheme: 'x', host: 'y', "
            "pathSegments: ['a', 'b']).toString();",
          ),
          equals('x://y/a/b'),
        );
      });

      test('F-SCD26-5: latin1.decode accepts a list literal [2026-09-12] '
          '(PASS)', () {
        expect(
          run("import 'dart:convert'; main() => latin1.decode([104, 105]);"),
          equals('hi'),
        );
      });
    },
  );

  group('SCD26: coercion does not widen', () {
    test('F-SCD26-6: an element of the wrong type still fails [2026-09-12] '
        '(PASS)', () {
      // `Runes.followedBy` takes `Iterable<int>`. A String element is a type
      // error in Dart and must stay one here — this is the assertion that
      // separates a coercion from a blanket cast to dynamic.
      expect(
        () => run("main() => Runes('ab').followedBy(['x']).toList();"),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });

    test('F-SCD26-7: a map key of the wrong type still fails [2026-09-12] '
        '(PASS)', () {
      expect(
        () => run(
          "main() => Uri(scheme: 'x', host: 'y', "
          "queryParameters: {1: 'b'}).toString();",
        ),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });

    test('F-SCD26-8: a non-collection argument still fails [2026-09-12] '
        '(PASS)', () {
      expect(
        () => run("main() => Runes('ab').followedBy(7).toList();"),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });
  });

  group('SCD26: the sites that were already correct stay correct', () {
    // Anti-regression for the probe result. Both of these were measured
    // WORKING before any change, so a later sweep that "fixes" every cast it
    // greps for would be changing code that was never broken — and these two
    // are the evidence that the sweep must probe rather than assume.
    test('F-SCD26-9: Function.apply took a list literal already [2026-09-12] '
        '(PASS)', () {
      expect(
        run("main() { f(a, b) => a + b; return Function.apply(f, [1, 2]); }"),
        equals(3),
      );
    });

    test(
      'F-SCD26-10: latin1.encode was never affected [2026-09-12] (PASS)',
      () {
        expect(
          run("import 'dart:convert'; main() => latin1.encode('hi').toList();"),
          equals([104, 105]),
        );
      },
    );
  });

  // --------------------------------------------------------------------
  // SCE69: the `io` and `isolate` batch.
  //
  // scd26 split this work by library and did `core` + `convert`. The 19 sites
  // it left were re-measured here before anything was written, and ALL OF THEM
  // WERE ALREADY FIXED — no reified `as List<int>` / `as Map<String, …>`
  // remains anywhere under `io/` or `isolate/`; what is there now is the safe
  // `as List` + `.cast<int>()` or `as Iterable<dynamic>` shape. They were
  // corrected incidentally by the work that passed through those files (scd170,
  // scd171, scd187, scd196, scd204) rather than by a sweep.
  //
  // So the substance left is the half the todo asked for and that no commit
  // provided: a LITERAL-PASSING TEST per site. A fix nothing asserts is a fix
  // that survives until the next person writes `as List<int>` from habit —
  // which is exactly how these accumulated, since a typed argument masks the
  // bug and the natural spot-check reaches for the typed form.
  // --------------------------------------------------------------------

  group('SCE69: the io and isolate sites accept a literal', () {
    final tmp = Directory.systemTemp.createTempSync('zom_sce69_');
    tearDownAll(() => tmp.deleteSync(recursive: true));

    test('F-SCE69-1: File byte sinks accept a list literal [2026-09-21]', () {
      // io/file.dart — writeAsBytes, and the RandomAccessFile pair, which is
      // the one place a literal is passed IN to be filled rather than read.
      expect(
        run(
          "import 'dart:io';\n"
          "main() { final f = File('${tmp.path}/a.bin'); "
          'f.writeAsBytesSync([1, 2, 3]); return f.lengthSync(); }',
        ),
        3,
      );
      expect(
        run(
          "import 'dart:io';\n"
          'main() {'
          "  final w = File('${tmp.path}/b.bin').openSync(mode: FileMode.write);"
          '  w.writeFromSync([4, 5, 6]);'
          '  w.closeSync();'
          "  final r = File('${tmp.path}/b.bin').openSync();"
          '  final n = r.readIntoSync([0, 0, 0]);'
          '  r.closeSync();'
          '  return n;'
          '}',
        ),
        3,
        reason: 'readInto fills the literal the script supplied',
      );
    });

    test(
      'F-SCE69-1b: the ASYNC File byte sinks accept one too [2026-09-21]',
      () async {
        // Added because ablating `readInto` (line 76) left F-SCE69-1 green: it
        // covered only the Sync variants, and each async member is a SEPARATE
        // adapter with its own cast. Four sites in this file, four members —
        // readInto / readIntoSync / writeAsBytes / writeAsBytesSync — and a test
        // naming two of them says nothing about the other two.
        final d4rt = D4rt()..grant(FilesystemPermission.any);
        expect(
          await (d4rt.execute(
                source:
                    "import 'dart:io';\n"
                    'main() async {'
                    "  final f = File('${tmp.path}/d.bin');"
                    '  await f.writeAsBytes([7, 8, 9]);'
                    '  final r = await f.open();'
                    '  final n = await r.readInto([0, 0, 0]);'
                    '  await r.close();'
                    '  return n;'
                    '}',
              )
              as Future),
          3,
        );
      },
    );

    test(
      'F-SCE69-1c: RandomAccessFile.writeFrom accepts one [2026-09-21]',
      () async {
        // The IN direction, which SCD70 routes through `coerceList` rather than
        // `.cast` — a different mechanism at the same kind of site, so it needs
        // its own case rather than being assumed to follow readInto.
        final d4rt = D4rt()..grant(FilesystemPermission.any);
        expect(
          await (d4rt.execute(
                source:
                    "import 'dart:io';\n"
                    'main() async {'
                    "  final w = await File('${tmp.path}/e.bin')"
                    '      .open(mode: FileMode.write);'
                    '  await w.writeFrom([1, 2, 3, 4]);'
                    '  await w.close();'
                    "  return File('${tmp.path}/e.bin').lengthSync();"
                    '}',
              )
              as Future),
          4,
        );
      },
    );

    test('F-SCE69-2: IOSink and stdout writeAll accept a list literal '
        '[2026-09-21]', () {
      // io/io_sink.dart and io/stdio.dart. `writeAll` takes Iterable, and the
      // cast that used to sit here reified its element type.
      expect(
        run(
          "import 'dart:io';\n"
          "main() { final s = File('${tmp.path}/c.txt').openWrite(); "
          "s.writeAll(['x', 'y'], '-'); return 'ok'; }",
        ),
        'ok',
      );
      expect(
        run(
          "import 'dart:io';\nmain() { stdout.writeAll([], '-'); return 'ok'; }",
        ),
        'ok',
        reason:
            'an EMPTY literal is still a literal, and erases to '
            'List<Object?> exactly as a populated one does',
      );
    });

    test(
      'F-SCE69-3: SendPort.send accepts a list literal [2026-09-21]',
      () async {
        // isolate/isolate.dart — the single site in that library.
        final d4rt = D4rt()..grant(IsolatePermission.any);
        expect(
          await (d4rt.execute(
                source:
                    "import 'dart:isolate';\n"
                    'main() async {'
                    '  final p = ReceivePort();'
                    '  p.sendPort.send([1, 2, 3]);'
                    '  final v = await p.first;'
                    '  p.close();'
                    '  return v.length;'
                    '}',
              )
              as Future),
          3,
        );
      },
    );

    test(
      'F-SCE69-4: Socket.add and writeAll accept literals [2026-09-21]',
      () async {
        // io/socket.dart, over a real loopback connection — the same shape
        // scc22_io_error_handler_arity_test.dart uses, because a socket bridge
        // cannot be asked this question without one.
        final d4rt = D4rt()
          ..grant(NetworkPermission.any)
          ..grant(FilesystemPermission.any);
        expect(
          await (d4rt.execute(
                source:
                    "import 'dart:io';\n"
                    'main() async {'
                    "  final server = await ServerSocket.bind('127.0.0.1', 0);"
                    '  server.listen((c) { c.listen((_) {}); });'
                    "  final s = await Socket.connect('127.0.0.1', server.port);"
                    '  s.add([104, 105]);'
                    "  s.writeAll(['a', 'b'], '-');"
                    '  await s.flush();'
                    '  await s.close();'
                    '  await server.close();'
                    "  return 'sent';"
                    '}',
              )
              as Future),
          'sent',
        );
      },
    );

    test('F-SCE69-5: HttpResponse.add and writeAll accept literals '
        '[2026-09-21]', () async {
      // io/http.dart. The body is read back rather than merely not throwing:
      // `add` taking a literal and then writing the WRONG BYTES would pass a
      // does-not-throw assertion, and that is the failure this batch is about.
      final d4rt = D4rt()
        ..grant(NetworkPermission.any)
        ..grant(FilesystemPermission.any);
      expect(
        await (d4rt.execute(
              source:
                  "import 'dart:io';\nimport 'dart:convert';\n"
                  'main() async {'
                  "  final server = await HttpServer.bind('127.0.0.1', 0);"
                  '  server.listen((req) async {'
                  '    req.response.add([104, 105]);'
                  "    req.response.writeAll(['x', 'y'], '-');"
                  '    await req.response.close();'
                  '  });'
                  '  final client = HttpClient();'
                  '  final r = await client.getUrl('
                  "      Uri.parse('http://127.0.0.1:\${server.port}/'));"
                  '  final resp = await r.close();'
                  '  final body = await utf8.decoder.bind(resp).join();'
                  '  client.close();'
                  '  await server.close();'
                  '  return body;'
                  '}',
            )
            as Future),
        'hix-y',
        reason:
            'add([104, 105]) is "hi" and writeAll is "x-y" — the bytes, '
            'not just the absence of a throw',
      );
    });
  });

  group('SCE69: the io sites do not widen either', () {
    final tmp = Directory.systemTemp.createTempSync('zom_sce69w_');
    tearDownAll(() => tmp.deleteSync(recursive: true));

    test('F-SCE69-6: a list of strings is still rejected where bytes are '
        'required [2026-09-21]', () {
      // The half that needs its own cases. Coercion must accept a LITERAL,
      // never a wrong ELEMENT TYPE: a script that writes strings as bytes must
      // fail here exactly as it would fail to compile as Dart.
      expect(
        () => run(
          "import 'dart:io';\n"
          "main() => File('${tmp.path}/w.bin').writeAsBytesSync(['a', 'b']);",
        ),
        throwsA(
          predicate(
            (e) =>
                e.toString().contains("'String'") ||
                e.toString().contains('String'),
            'an error naming the element type, not an unrelated failure — a '
            'bare throwsA passes on a permission refusal too',
          ),
        ),
      );
      expect(
        () => run(
          "import 'dart:io';\n"
          'main() {'
          "  final w = File('${tmp.path}/x.bin').openSync(mode: FileMode.write);"
          "  w.writeFromSync(['a']);"
          '  w.closeSync();'
          '}',
        ),
        throwsA(
          predicate(
            (e) => e.toString().contains('String'),
            'likewise: the failure must be about the element type',
          ),
        ),
      );
    });
  });
}
