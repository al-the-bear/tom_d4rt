/// SCE190. `ExecTestSetup.exclusive` is what keeps the two suites that
/// prepare the shared `example/d4` project from rewriting it under each other.
/// These cases pin the lock's two promises without generating anything.
@TestOn('vm')
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

import 'exec_test_setup.dart';

void main() {
  late Directory dir;

  setUp(() => dir = Directory.systemTemp.createTempSync('sce190_'));
  tearDown(() => dir.deleteSync(recursive: true));

  test('F-SCE190-1: concurrent holders never overlap, and the lock is '
      'released afterwards [2026-09-25]', () async {
    final lockPath = p.join(dir.path, 'sub', 'prepare.lock');
    var inside = 0;
    var maxInside = 0;
    Future<int> holder(int id) => ExecTestSetup.exclusive(lockPath, () async {
      inside++;
      if (inside > maxInside) maxInside = inside;
      await Future<void>.delayed(const Duration(milliseconds: 60));
      inside--;
      return id;
    }, poll: const Duration(milliseconds: 5));

    final ids = await Future.wait([for (var i = 0; i < 4; i++) holder(i)]);
    expect(ids, [0, 1, 2, 3]);
    expect(maxInside, 1, reason: 'two holders ran the body at once');
    expect(File(lockPath).existsSync(), isFalse);
  });

  test('F-SCE190-2: a lock older than staleLockAfter is taken over, and a '
      'failing body still releases it [2026-09-25]', () async {
    final lockPath = p.join(dir.path, 'prepare.lock');
    File(lockPath)
      ..createSync()
      ..setLastModifiedSync(
        DateTime.now().subtract(
          ExecTestSetup.staleLockAfter + const Duration(minutes: 1),
        ),
      );
    expect(await ExecTestSetup.exclusive(lockPath, () async => 'ran'), 'ran');

    await expectLater(
      ExecTestSetup.exclusive<void>(
        lockPath,
        () async => throw StateError('x'),
      ),
      throwsStateError,
    );
    expect(File(lockPath).existsSync(), isFalse);
  });
}
