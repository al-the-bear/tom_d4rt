import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// The stdlib registrars are deliberately not re-exported from `runtime.dart`
// — see the note in `stdlib_bytes_builder_test.dart`. Reaching for them by
// same-package path keeps the published API unchanged.
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/isolate.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/math.dart';

/// SCB24 mirror coverage for `tom_d4rt_ast` — a bridge definition that is
/// written must be registered.
///
/// THE DEFECT. `StringConversionConvert` and `ChunkedConversionConvert` were
/// fully written, exported, and never passed to `defineBridge`. No script could
/// name either. The SDK gap audit could not see it: it looks for missing FILES,
/// and by that measure both libraries were complete — only the one line that
/// puts the definition into an `Environment` was missing.
///
/// THIS TWIN IS WEAKER THAN THE ANALYZER ONE, deliberately and by necessity.
/// `tom_d4rt/test/scb24_unregistered_bridge_test.dart` parses each definition
/// getter, reads the `name:` it passes to `BridgedClass`, and asserts that name
/// is live — so it can say WHICH definition is unregistered. This package is
/// analyzer-free by construction, so the declared side is counted rather than
/// named:
///
///   the number of `static BridgedClass get …` declarations under the stdlib
///   must equal the number of live bridge names in a fully registered
///   environment.
///
/// WHAT THAT BUYS AND WHAT IT DOES NOT. An orphaned definition makes
/// declarations exceed live names and fails here. A count cannot say which one,
/// and it could in principle be balanced by a second defect in the opposite
/// direction — one orphan plus one duplicate registration. The duplicate half
/// is covered separately and exactly by `scc76_bridge_name_collision_test.dart`,
/// so the pair of guards together is not open to that.
///
/// It is worth having on this side rather than leaning on the mirror: the two
/// stdlib trees are supposed to be copies, but nothing verifies that they are
/// (scd183), and SCC78 found the two interpreters disagreeing on a line for as
/// long as both existed.
void main() {
  /// `static BridgedClass get …` declarations under the stdlib tree.
  ///
  /// Counted with a regex because there is no parser here. The pattern is the
  /// declaration form every stdlib bridge uses; F-SCB24-AST-2 is the floor that
  /// catches it silently matching nothing.
  int declaredDefinitionCount() {
    final pattern = RegExp(r'static\s+BridgedClass\s+get\s+\w+');
    var total = 0;
    for (final file
        in Directory('lib/src/runtime/stdlib')
            .listSync(recursive: true)
            .whereType<File>()
            .where((f) => f.path.endsWith('.dart'))) {
      total += pattern.allMatches(file.readAsStringSync()).length;
    }
    return total;
  }

  Environment fullyRegistered() {
    final env = Environment();
    Stdlib(env).register(); // core + async + typed_data
    MathStdlib.register(env);
    ConvertStdlib.register(env);
    IoStdlib.register(env);
    CollectionStdlib.register(env);
    IsolateStdlib.register(env);
    return env;
  }

  test('F-SCB24-AST-1: every declared bridge definition is registered '
      '[2026-09-06]', () {
    final declared = declaredDefinitionCount();
    final live = fullyRegistered().bridgedClassNames.length;
    expect(
      live,
      equals(declared),
      reason:
          'The stdlib declares $declared `static BridgedClass get …` '
          'definitions and a fully registered environment has $live live '
          'bridge names.\n'
          '${live < declared ? 'Fewer live than declared: a definition is '
                    'written but never passed to defineBridge, so no script can name '
                    'the class it describes. The analyzer twin in tom_d4rt names '
                    'which one.' : 'More live than declared: a bridge is registered from '
                    'somewhere this scan does not look, or the declaration form '
                    'changed and the regex has stopped matching.'}',
    );
  });

  test('F-SCB24-AST-2: the scan and the registry both found a real corpus '
      '[2026-09-06]', () {
    // F-SCB24-AST-1 compares two numbers and 0 == 0 is true, so it passes on a
    // regex that stopped matching AND an environment where nothing registered.
    // The bounds are far below the real figures (205 and 205 measured
    // 2026-09-06) because the job is to separate "measured" from "measured
    // nothing", not to pin the count.
    expect(declaredDefinitionCount(), greaterThan(150));
    expect(fullyRegistered().bridgedClassNames.length, greaterThan(150));
  });
}
