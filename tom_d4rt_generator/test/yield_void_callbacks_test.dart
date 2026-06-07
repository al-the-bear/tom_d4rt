/// B.14 — cooperative-yield switch for void bridged callbacks.
///
/// The interpreter is a synchronous visitor, so Timer/`KeyEvent`/gesture/
/// `onChanged` callbacks run straight through to completion and never return
/// control to the embedder — queued input is starved during long synchronous
/// interpreted runs. The `yieldVoidCallbacks` switch (default off) makes the
/// generator emit *void* callback wrappers as `async` closures that
/// `await Future.delayed(const Duration(milliseconds: 1))` after invoking the
/// interpreted callback.
///
/// These tests pin the contract:
///   • OFF (default) ⇒ generated wrappers are the historical synchronous shape
///     (no yield, no `async`) — byte-identical to prior output.
///   • ON ⇒ void callbacks become `async` and carry the 1 ms yield, while
///     non-void callbacks (with a return value the framework consumes) are
///     left untouched.
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

/// The exact yield expression the wrapper appends to a void callback.
const String _yieldExpr =
    'await Future.delayed(const Duration(milliseconds: 1))';

void main() {
  late String testFixturesDir;
  late String tempOutputDir;
  late String sourceFile;

  setUpAll(() {
    testFixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
    tempOutputDir = Directory.systemTemp.createTempSync('yield_void_cb_').path;
    sourceFile = p.join(testFixturesDir, 'callback_test_source.dart');
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  Future<String> generate({required bool yieldVoidCallbacks}) async {
    final generator = BridgeGenerator(
      workspacePath: testFixturesDir,
      skipPrivate: true,
      helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
      sourceImport: 'callback_test_source.dart',
      packageName: 'test_package',
      verbose: false,
    );
    generator.yieldVoidCallbacks = yieldVoidCallbacks;

    final outputFile = p.join(
      tempOutputDir,
      'yield_${yieldVoidCallbacks ? 'on' : 'off'}.dart',
    );
    final result = await generator.generateBridges(
      sourceFiles: [sourceFile],
      outputPath: outputFile,
      moduleName: 'yield_${yieldVoidCallbacks ? 'on' : 'off'}',
    );
    expect(result.errors, isEmpty, reason: 'Should generate without errors');
    expect(result.outputFiles, isNotEmpty);
    return File(result.outputFiles.first).readAsString();
  }

  group('B.14 yieldVoidCallbacks generator switch', () {
    late String generatedOff;
    late String generatedOn;

    setUpAll(() async {
      generatedOff = await generate(yieldVoidCallbacks: false);
      generatedOn = await generate(yieldVoidCallbacks: true);
    });

    test(
      'G-B14-1: default (off) emits no yield — synchronous void wrappers. '
      '[2026-06-07] (PASS)',
      () {
        expect(
          generatedOff,
          isNot(contains(_yieldExpr)),
          reason: 'With the switch off no void callback may carry the 1 ms '
              'yield (output must stay byte-identical to historical wrappers)',
        );
        // The historical synchronous void wrapper shape is still present.
        expect(
          generatedOff,
          contains('{ D4.callInterpreterCallback(visitor!,'),
          reason: 'void callbacks keep the synchronous { ...; } wrapper body',
        );
      },
    );

    test(
      'G-B14-2: on ⇒ void callbacks become async with the 1 ms yield. '
      '[2026-06-07] (PASS)',
      () {
        expect(
          generatedOn,
          contains(_yieldExpr),
          reason: 'void callbacks must yield 1 ms after invoking the script',
        );
        // The yielded body lives inside an `async` closure.
        expect(
          generatedOn,
          contains('async { D4.callInterpreterCallback'),
          reason: 'void wrapper closure must be async to host the await',
        );
        // Every yield sits at the end of a void wrapper body, after the call.
        expect(
          generatedOn,
          contains('D4.callInterpreterCallback(visitor!, '),
          reason: 'the call still precedes the yield',
        );
      },
    );

    test(
      'G-B14-3: on ⇒ non-void callbacks are left untouched (no async, no '
      'yield). [2026-06-07] (PASS)',
      () {
        // `filter` returns bool, `transform` returns String — both keep their
        // synchronous `{ return ... }` wrapper. No non-void wrapper is made
        // async (an `async { return` shape would mean we wrapped one).
        expect(
          generatedOn,
          isNot(contains('async { return')),
          reason: 'non-void callbacks must not be async-wrapped — their '
              'Future return type would be unconsumable by the framework',
        );
        // The non-void return casts survive in both modes.
        expect(generatedOn, contains('as bool'));
        expect(generatedOn, contains('as String'));
      },
    );

    test(
      'G-B14-4: non-void wrapper fragments are byte-identical across the '
      'switch. [2026-06-07] (PASS)',
      () {
        // Each emitted constructor packs several callbacks on one line, so the
        // invariant is fragment-level, not line-level: the non-void wrapper
        // closure text itself is unchanged by the switch (only its void
        // siblings on the same line gain the yield).
        const boolFragment =
            '{ return D4.callInterpreterCallback(visitor!, predicateRaw, '
            '[p0]) as bool; }';
        const stringFragment =
            '{ return D4.callInterpreterCallback(visitor!, transformerRaw, '
            '[p0]) as String; }';

        for (final fragment in [boolFragment, stringFragment]) {
          expect(generatedOff, contains(fragment),
              reason: 'baseline must contain the synchronous non-void wrapper');
          expect(generatedOn, contains(fragment),
              reason: 'the non-void wrapper must be unchanged with switch on');
        }

        // And the void sibling on that constructor line DID gain the yield.
        expect(
          generatedOn,
          contains('() async { D4.callInterpreterCallback(visitor!, '
              'onReadyRaw, []); $_yieldExpr; }'),
          reason: 'void constructor callbacks gain the async yield',
        );
        expect(
          generatedOff,
          contains('() { D4.callInterpreterCallback(visitor!, onReadyRaw, '
              '[]); }'),
          reason: 'baseline void constructor callback stays synchronous',
        );
      },
    );
  });

  group('B.14 BridgeConfig plumbing', () {
    test(
      'G-B14-5: yieldVoidCallbacks defaults false and round-trips through '
      'json/copyWith. [2026-06-07] (PASS)',
      () {
        const base = BridgeConfig(name: 'pkg', modules: []);
        expect(base.yieldVoidCallbacks, isFalse,
            reason: 'default must be off to keep CLI/build output unchanged');

        // Off ⇒ key omitted from json (back-compatible).
        expect(base.toJson().containsKey('yieldVoidCallbacks'), isFalse);

        final on = base.copyWith(yieldVoidCallbacks: true);
        expect(on.yieldVoidCallbacks, isTrue);
        expect(on.toJson()['yieldVoidCallbacks'], isTrue);

        final restored = BridgeConfig.fromJson(on.toJson());
        expect(restored.yieldVoidCallbacks, isTrue);

        // Absent in json ⇒ false.
        final fromBare = BridgeConfig.fromJson({'name': 'pkg', 'modules': []});
        expect(fromBare.yieldVoidCallbacks, isFalse);
      },
    );
  });
}
