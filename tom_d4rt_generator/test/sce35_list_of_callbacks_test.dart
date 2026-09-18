// sce35: a `List<Callback>` parameter is converted element by element, as a
// `Map<K, Callback>` already was — not refused.
//
// The generator emitted a throw for such a parameter, with the message "Bridge
// cannot handle function types in collections". That had stopped being true of
// collections in general: the map path converts value by value and single
// callbacks are wrapped. A script could not construct
// `VSCodeBridgeServer(additionalBridgeRegistrars: [...])`, or call any method
// taking a list of callbacks.
//
// COMPILING IS NOT THE PROPERTY UNDER TEST. `sce34_function_typedef_detection`
// asserts which path is taken, and the GEN-121 gate asserts the result
// analyses clean — a conversion that produced an empty list would satisfy
// both. This suite runs the bridge for real: a D4rt script passes closures,
// the native side calls them, and the assertions turn on the values they
// returned.

@Tags(['generation'])
@TestOn('vm')
@Timeout(Duration(minutes: 3))
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bridge_config.dart';
import 'package:tom_d4rt_generator/src/build_config_loader.dart';
import 'package:tom_d4rt_generator/src/testing/d4rt_tester.dart';

final String _generatorRoot = Directory.current.path;
final String _d4Project = p.join(_generatorRoot, 'example', 'd4');

void main() {
  late D4rtTester tester;
  late BridgeConfig config;

  setUpAll(() async {
    config = BuildConfigLoader.loadFromTomBuildYaml(_d4Project)!;
    // Distinct runner and binary names: this suite shares `example/d4` with
    // d4rt_tester_test and d4rt_coverage_test, and `compile exe -o` in one
    // races `Process.start` in another on a shared name (ETXTBSY).
    tester = D4rtTester(
      projectPath: _d4Project,
      defaultTimeout: const Duration(seconds: 60),
      runnerExecutable: 'd4rtrun_sce35.b',
      compiledBinaryName: 'd4_sce35',
    );
    final ok = await tester.prepareBridges(config);
    expect(
      ok,
      isTrue,
      reason: 'bridge generation failed: ${tester.lastGenerationErrors}',
    );
  });

  test(
    'GEN-LISTCB-1: a script passes a list of closures and the native side '
    'calls every element, for named and positional parameters [2026-09-18]',
    () async {
      final result = await tester.runScriptOnly(
        config,
        '../d4_test_scripts/bin/callbacks/d4rt_test_list_of_callbacks.dart',
      );

      expect(
        result.exceptions,
        isEmpty,
        reason:
            'the script threw, so the list of callbacks did not arrive intact:\n'
            '${result.exceptions.join('\n')}\n${result.processOutput}',
      );
      expect(
        result.success,
        isTrue,
        reason: 'script run failed:\n${result.processOutput}',
      );
      // The script's own checks are the assertion; this is its completion
      // marker. Without it a run that silently produced no output would pass.
      expect(
        result.processOutput,
        contains('LIST_CALLBACK_TESTS_PASSED'),
        reason: 'the script did not reach its end:\n${result.processOutput}',
      );
    },
  );
}
