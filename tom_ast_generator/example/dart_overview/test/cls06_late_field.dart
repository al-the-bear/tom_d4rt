// D4rt test: CLS06 - Late field
// Verifies late-initialized fields are accessible via bridges.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // LateFieldDemo has late String config and late final int id
  var lf = LateFieldDemo();

  // Assign late fields
  lf.config = 'test_config';
  lf.id = 99;

  if (lf.config != 'test_config') {
    errors.add('LateFieldDemo.config expected "test_config", got "${lf.config}"');
  }
  if (lf.id != 99) {
    errors.add('LateFieldDemo.id expected 99, got ${lf.id}');
  }

  // Using named constructor
  var lf2 = LateFieldDemo.withValues('cfg_data', 42);
  if (lf2.config != 'cfg_data') {
    errors.add('LateFieldDemo.withValues config expected "cfg_data", got "${lf2.config}"');
  }
  if (lf2.id != 42) {
    errors.add('LateFieldDemo.withValues id expected 42, got ${lf2.id}');
  }

  // Also test top-level late variable (lazyConfig)
  var val = lazyConfig;
  if (val != 'config_data') {
    errors.add('lazyConfig expected "config_data", got "$val"');
  }

  if (errors.isEmpty) {
    print('CLS06_PASSED');
  } else {
    print('CLS06_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
