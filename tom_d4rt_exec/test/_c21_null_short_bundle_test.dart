/// The BUNDLE-PATH half of `_c21_null_short_test.dart`.
///
/// Null-shorting (`a?.size.height`) must stop at the null receiver instead of
/// evaluating the rest of the chain. The suite next door runs that through
/// `execute(source:)` and is a verbatim port of the analyzer-based copy, which
/// is what lets `conformance_drift_test.dart` hold the two trees together on
/// it. The cases here run the same feature through `createBundleFromSource` +
/// `D4rtRunner.executeBundle` — the pre-compiled path a Flutter app uses, which
/// has no counterpart in `tom_d4rt` and so can only be pinned in this package.
///
/// SPLITTING THEM IS WHAT LETS THE SHARED-NAME FILE STAY A VERBATIM PORT
/// without losing this coverage. A shared-name file carrying exec-only cases
/// can never converge, and the standing `_divergentBaseline` entry it needs
/// would then absorb every future drift in that file for as long as it stood.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  test('AST runner: null-shorting through . after ?. simple', () async {
    final d4rt = D4rt();
    final bundle = await d4rt.createBundleFromSource('''
class Box {
  Size get size => Size(10, 20);
}
class Size {
  final double width;
  final double height;
  Size(this.width, this.height);
}
double main() {
  Box? a;
  return a?.size.height ?? -1.0;
}
''');
    final runner = D4rtRunner();
    final result = runner.executeBundle(bundle);
    expect(result, -1.0);
  });

  test('AST runner: null-shorting after method-returned null', () async {
    final d4rt = D4rt();
    final bundle = await d4rt.createBundleFromSource('''
class Box {
  Size get size => Size(10, 20);
}
class Size {
  final double width;
  final double height;
  Size(this.width, this.height);
}
Box? lookup() => null;
double main() {
  final Box? a = lookup();
  return a?.size.height ?? -1.0;
}
''');
    final runner = D4rtRunner();
    final result = runner.executeBundle(bundle);
    expect(result, -1.0);
  });
}
