/// Runs all async feature demonstrations
///
/// This script executes all examples in the async area:
/// - futures
/// - streams
/// - isolates
library;

import 'futures/run_futures.dart' as futures;
import 'streams/run_streams.dart' as streams;
import 'isolates/run_isolates.dart' as isolates;

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

  print('');
  print(separator);
  print('  3. ISOLATES');
  print(separator);
  print('');
  await isolates.main();

  print('');
  print(separator);
  print('  All async demos completed!');
  print(separator);
}
