/// Runs all collections feature demonstrations
///
/// This script executes all examples in the collections area:
/// - lists
/// - sets
/// - maps
/// - iterables
library;

import 'lists/run_lists.dart' as lists;
import 'sets/run_sets.dart' as sets;
import 'maps/run_maps.dart' as maps;
import 'iterables/run_iterables.dart' as iterables;

void main() {
  final separator = '=' * 70;

  print('');
  print(separator);
  print('                         DART COLLECTIONS');
  print(separator);
  print('');

  print('');
  print(separator);
  print('  1. LISTS');
  print(separator);
  print('');
  lists.main();

  print('');
  print(separator);
  print('  2. SETS');
  print(separator);
  print('');
  sets.main();

  print('');
  print(separator);
  print('  3. MAPS');
  print(separator);
  print('');
  maps.main();

  print('');
  print(separator);
  print('  4. ITERABLES');
  print(separator);
  print('');
  iterables.main();

  print('');
  print(separator);
  print('  All collections demos completed!');
  print(separator);
}
