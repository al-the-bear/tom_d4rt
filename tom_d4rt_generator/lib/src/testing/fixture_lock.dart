import 'dart:io';

/// How old a fixture lock may be before it is taken to belong to a holder
/// that died without releasing it.
const Duration staleFixtureLockAfter = Duration(minutes: 10);

/// Run [body] while holding the lock file at [lockPath].
///
/// SCE190. Several suites drive ONE fixture project — in this package
/// `d4rt_tester_test.dart`, `d4rt_coverage_test.dart` and
/// `sce35_list_of_callbacks_test.dart` all prepare `example/d4` — and
/// `dart test` runs them concurrently. Distinct runner and binary names
/// (Cluster K #32) stopped them overwriting each other's executable, but each
/// still re-resolves the project, regenerates the shared bridge tree and
/// compiles against it, so one could analyze or compile while another was
/// rewriting. Measured in `tom_d4rt_exec`'s copy of the pair: an analyzer link
/// error naming a pub-cache library that was never absent, and a binary
/// compiled from a half-rewritten bridge file. [D4rtTester.prepareBridges]
/// holds this lock for its whole pipeline.
///
/// An `O_EXCL` create, deliberately not `RandomAccessFile.lock`: `dart test`
/// runs suites as isolates of one process, and POSIX record locks belong to
/// the process, so two isolates would both acquire one. Exclusive creation
/// fails for every second caller, wherever it runs.
Future<T> withFixtureLock<T>(
  String lockPath,
  Future<T> Function() body, {
  Duration poll = const Duration(milliseconds: 200),
}) async {
  final lock = File(lockPath);
  lock.parent.createSync(recursive: true);
  while (true) {
    try {
      lock.createSync(exclusive: true);
      break;
    } on FileSystemException {
      try {
        final age = DateTime.now().difference(lock.lastModifiedSync());
        if (age > staleFixtureLockAfter) {
          lock.deleteSync();
          continue;
        }
      } on FileSystemException {
        // Released between the create and the stat: try again at once.
        continue;
      }
      await Future<void>.delayed(poll);
    }
  }
  try {
    return await body();
  } finally {
    if (lock.existsSync()) lock.deleteSync();
  }
}
