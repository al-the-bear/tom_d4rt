/// Runs all async feature demonstrations
///
/// This script executes all examples in the async area:
/// - futures
/// - streams
/// - isolates (skipped in D4rt - see run_isolates_no_d4rt.dart)

import 'futures/run_futures.dart' as futures;
import 'streams/run_streams.dart' as streams;
// NOTE: Isolates are not supported in D4rt
// See: isolates/run_isolates_no_d4rt.dart for explanation
// import 'isolates/run_isolates.dart' as isolates;

Future<void> main() async {
  final separator = '=' * 70;

  print('');
  print(separator);
  print('                      DART ASYNC PROGRAMMING');
  print(separator);
  print('');

  print('');
  print(separator);
  print('  1. FUTURES');
  print(separator);
  print('');
  await futures.main();

  print('');
  print(separator);
  print('  2. STREAMS');
  print(separator);
  print('');
  await streams.main();

  // NOTE: Isolates are not supported in D4rt
  // Isolates require sending closures to separate execution contexts,
  // but D4rt interpreted functions capture interpreter state which
  // cannot be sent across isolate boundaries.
  // print('');
  // print(separator);
  // print('  3. ISOLATES');
  // print(separator);
  // print('');
  // await isolates.main();

  print('');
  print(separator);
  print('  Async demos completed! (Isolates skipped - not supported in D4rt)');
  print(separator);
}
