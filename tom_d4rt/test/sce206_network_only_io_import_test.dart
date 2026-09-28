/// SCE206 — `dart:io`'s import gate admits EITHER `FilesystemPermission` or
/// `NetworkPermission`.
///
/// It asked only for filesystem access, and `dart:io` is where every network
/// class lives, so a script granted `NetworkPermission` and nothing else could
/// not import the library its grant is for. Decision (a): either capability
/// admits the import; the per-operation gates — `NetworkPermission` on every
/// socket-acquiring call (SCD170), `FilesystemPermission` on every file
/// operation — do the enforcing, so the network-only script names `File` and
/// still cannot touch one.
@TestOn('vm')
library;

import 'dart:async';
import 'dart:io' as io;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Future<Object?> _run(D4rt interpreter, String source) async {
  final result = interpreter.execute(source: source);
  return result is Future ? await result : result;
}

void main() {
  late io.ServerSocket server;

  setUp(() async {
    server = await io.ServerSocket.bind(io.InternetAddress.loopbackIPv4, 0);
    server.listen((socket) => socket.destroy());
  });
  tearDown(() => server.close());

  test('F-SCE206-1: a script granted only NetworkPermission imports dart:io '
      'and opens a socket [2026-09-28]', () async {
    final interpreter = D4rt()..grant(NetworkPermission.any);
    expect(
      await _run(interpreter, '''
        import 'dart:io';
        Future<String> main() async {
          final s = await Socket.connect('127.0.0.1', ${server.port});
          s.destroy();
          return 'connected';
        }
      '''),
      'connected',
    );
  });

  test('F-SCE206-2: in the same script, a filesystem operation still refuses '
      '[2026-09-28]', () async {
    final interpreter = D4rt()..grant(NetworkPermission.any);
    await expectLater(
      _run(interpreter, '''
        import 'dart:io';
        Future<String> main() async {
          final s = await Socket.connect('127.0.0.1', ${server.port});
          s.destroy();
          return File('pubspec.yaml').readAsStringSync();
        }
      '''),
      throwsA(
        // From the FILE operation, not the import gate: the old gate's refusal
        // named FilesystemPermission too, and would have satisfied a looser
        // predicate without the socket ever being opened.
        predicate(
          (Object? e) =>
              e.toString().contains('FilesystemPermission') &&
              !e.toString().contains('Access to dart:io'),
          'a refusal from the file operation naming FilesystemPermission',
        ),
      ),
    );
  });

  test('F-SCE206-3 (control): with neither permission the import is still '
      'refused, and the message names both [2026-09-28]', () async {
    await expectLater(
      _run(D4rt(), '''
        import 'dart:io';
        main() => 'imported';
      '''),
      throwsA(
        isA<RuntimeD4rtException>().having(
          (e) => e.message,
          'message',
          allOf(
            contains('FilesystemPermission'),
            contains('NetworkPermission'),
          ),
        ),
      ),
    );
  });

  test('F-SCE206-4 (control): a filesystem-only grant still imports, as it '
      'always did [2026-09-28]', () async {
    final interpreter = D4rt()..grant(FilesystemPermission.any);
    expect(
      await _run(interpreter, '''
        import 'dart:io';
        main() => File('pubspec.yaml').existsSync() ? 'yes' : 'no';
      '''),
      'yes',
    );
  });
}
