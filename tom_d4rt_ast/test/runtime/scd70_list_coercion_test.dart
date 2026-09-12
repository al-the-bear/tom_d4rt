// SCD70/AST — the byte APIs accept the erased list shape the interpreter hands
// them.
//
// `s.add([65, 66])` threw `type 'List<Object?>' is not a subtype of type
// 'List<int>' in type cast`, and so did `s.add(<int>[65, 66])`: a list literal
// written in a script is a `List<Object?>` whatever its elements hold and
// whatever the author annotated, because the interpreter CHECKS the element
// type without reifying it. Thirteen adapters across `io/socket.dart`,
// `io/file.dart`, `io/stdio.dart`, `io/io_sink.dart`, `io/http.dart` and
// `isolate/isolate.dart` cast instead of coercing, so none of them could be
// called from a script at all.
//
// REGISTRATION-LEVEL, for the DGUC6 reason this tree's other stdlib mirrors
// give: `tom_d4rt_exec` is the only runner that could execute a script against
// THIS tree, and it resolves `tom_d4rt_ast` from pub.dev rather than by path,
// so it cannot see unpublished local edits. The script-level twin is
// `tom_d4rt/test/scd70_list_coercion_test.dart`.
//
// The level is also the honest one for what changed, exactly as
// `stdlib_stream_arg_coercion_test.dart` argues for its own defect: the bug was
// entirely inside the adapter's argument handling, so handing the lambda the
// erased shape the interpreter actually produces — `<Object?>[65, 66]` —
// reproduces it precisely, without a script and without a socket.
//
// NO I/O AT ALL, which is what makes this mirror cheap. The five adapters below
// cover all three changed io files: two are constructors that touch nothing
// (`RawSocketOption`, `Datagram`), and the rest run against a real temp file
// and a real file sink. `Socket.add` and `RawDatagramSocket.send` need a
// network peer and are covered script-level in the reference tree.
//
// CONTROL, measured by reverting the sweep in this tree: `+1 -4`. Only
// F-SCD70-AST-5 keeps passing — it asserts that a list of the WRONG element
// type is still rejected, which a cast also did, and which is the rail against
// "coerce harder until something goes through". The reference tree's twin
// splits `+1 -5` the same way.
//
// F-SCD70-AST-3 IS THE ONE WITH TEETH BEYOND THE CAST. `readIntoSync` is an
// OUT parameter: the native writes into the caller's list. An eager coercion
// hands it a COPY, so the byte count comes back right and the script's buffer
// stays zeroed — quieter than the exception it replaced, and worse. That site
// uses `List.cast<int>()`, a writable view, and this case reads the buffer back
// rather than trusting the return value.

@TestOn('vm')
library;

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// The stdlib registrars are deliberately not re-exported from `runtime.dart`;
// reaching for them by same-package path keeps the published API unchanged.
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';

void main() {
  late Environment env;
  late InterpreterVisitor visitor;
  late Directory dir;

  setUp(() {
    env = Environment();
    IoStdlib.register(env);
    visitor = InterpreterVisitor(
      globalEnvironment: env,
      moduleContext: AstModuleLoader(
        modules: const {},
        globalEnvironment: env,
        runner: D4rtRunner(),
      ),
    );
    dir = Directory.systemTemp.createTempSync('scd70ast');
  });

  tearDown(() => dir.deleteSync(recursive: true));

  BridgedClass bridge(String name) {
    final b = env.findBridgedClassByName(name);
    expect(b, isNotNull, reason: '$name must be a registered bridge');
    return b!;
  }

  /// The erased shape the interpreter produces for `[65, 66]` — and for
  /// `<int>[65, 66]`, which is the point.
  List<Object?> erased(List<int> bytes) => <Object?>[...bytes];

  group('SCD70/AST: byte adapters take the erased list', () {
    test('F-SCD70-AST-1: the two socket constructors take one '
        '[2026-09-12] (PASS)', () {
      // `RawSocketOption(level, option, value)` and `Datagram(data, addr,
      // port)` both read a `List<int>` positional and touch no I/O, so they
      // are the cheapest proof that socket.dart's casts are gone.
      final option = bridge('RawSocketOption').constructors['']!(visitor, [
        1,
        2,
        erased([65, 66]),
      ], {});
      expect(option, isA<RawSocketOption>());
      expect((option as RawSocketOption).value, [65, 66]);

      final datagram = bridge('Datagram').constructors['']!(visitor, [
        erased([67, 68]),
        InternetAddress('127.0.0.1'),
        1234,
      ], {});
      expect(datagram, isA<Datagram>());
      expect((datagram as Datagram).data, [67, 68]);
    });

    test('F-SCD70-AST-2: RandomAccessFile.writeFromSync takes one '
        '[2026-09-12] (PASS)', () {
      final path = '${dir.path}/w.bin';
      final raf = File(path).openSync(mode: FileMode.write);
      bridge('RandomAccessFile').methods['writeFromSync']!(
        visitor,
        raf,
        [
          erased([65, 66, 67]),
        ],
        {},
        [],
      );
      raf.closeSync();
      expect(File(path).readAsBytesSync(), [65, 66, 67]);
    });

    test('F-SCD70-AST-3: readIntoSync fills the CALLER\'s buffer '
        '[2026-09-12] (PASS)', () {
      // Asserting the return value alone passes against an adapter that
      // coerced to a copy: the count is right and the buffer is untouched.
      final path = '${dir.path}/r.bin';
      File(path).writeAsBytesSync([70, 71, 72]);
      final raf = File(path).openSync();
      final buffer = <Object?>[0, 0, 0];
      final n = bridge('RandomAccessFile').methods['readIntoSync']!(
        visitor,
        raf,
        [buffer],
        {},
        [],
      );
      raf.closeSync();
      expect(n, 3);
      expect(
        buffer,
        [70, 71, 72],
        reason:
            'the bytes must land in the list '
            'the caller passed, not in a coerced copy of it',
      );
    });

    test('F-SCD70-AST-4: IOSink.add takes one [2026-09-12] (PASS)', () async {
      final path = '${dir.path}/sink.bin';
      final sink = File(path).openWrite();
      bridge('IOSink').methods['add']!(
        visitor,
        sink,
        [
          erased([73, 74]),
        ],
        {},
        [],
      );
      await sink.close();
      expect(File(path).readAsBytesSync(), [73, 74]);
    });

    test('F-SCD70-AST-5: a wrong element type is still rejected '
        '[2026-09-12] (PASS)', () async {
      // THE RAIL. The fix makes `List<Object?>` usable, not every list — a
      // coercion that shrugged at a String would send whatever it converted
      // and silently lose the rest. This is the one thing the old cast got
      // right, and it must survive.
      final path = '${dir.path}/bad.bin';
      final sink = File(path).openWrite();
      expect(
        () => bridge('IOSink').methods['add']!(
          visitor,
          sink,
          [
            <Object?>[73, 'not a byte'],
          ],
          {},
          [],
        ),
        throwsA(anything),
      );
      await sink.close();
    });
  });
}
