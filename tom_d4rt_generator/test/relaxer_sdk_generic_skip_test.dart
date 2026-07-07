/// Tests that `dart:async` SDK generic types never trip the GEN-079 relaxer
/// "No ClassInfo for generic base type" / "skipping wrapper" warnings.
///
/// Relaxer wrappers only apply to *application-package* generic types scanned
/// from module barrels. SDK generics such as `FutureOr`, `StreamSubscription`,
/// `StreamConsumer`, `StreamTransformer` and `EventSink` are provided by D4rt's
/// stdlib bridges (`tom_d4rt/lib/src/stdlib/async/`), so no application-level
/// relaxer wrapper is needed — and none is possible, because the generator has
/// no scanned `ClassInfo` for an SDK type. `FutureOr` is a union type, not a
/// class, and can never be wrapped at all.
///
/// Before the fix, these SDK types (which appear in bridged method signatures)
/// were recorded as relaxer targets, then skipped with a noisy warning. They
/// must instead be skipped *silently*, like `Future`/`Stream`/`List` already
/// are.
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  group('SDK async generics are skipped without GEN-079 warnings', () {
    const barrel = 'package:fake_pkg/fake_pkg.dart';

    // A real application generic (`Box<T>`) plus one concrete bridged type, so
    // relaxer generation proceeds normally and produces a wrapper — proving the
    // SDK types are the *only* thing being silently skipped.
    Map<String, ClassInfo> buildLookup() => {
          'Box': ClassInfo(
            name: 'Box',
            sourceFile: barrel,
            typeParameters: const {'T': null},
            constructors: const [
              ConstructorInfo(
                parameters: [ParameterInfo(name: 'value', type: 'T')],
              ),
            ],
          ),
          'Apple': ClassInfo(name: 'Apple', sourceFile: barrel),
        };

    BridgeConfig configFor(String outputPath) => BridgeConfig(
          name: 'fake_pkg',
          modules: const [
            ModuleConfig(
              name: 'fake',
              barrelFiles: ['lib/fake_pkg.dart'],
              outputPath: 'lib/src/fake.b.dart',
              barrelImport: barrel,
            ),
          ],
          relaxerOutputPath: outputPath,
        );

    late Directory tempDir;

    setUp(() {
      tempDir = Directory.systemTemp.createTempSync('relaxer_sdk_skip_test');
    });

    tearDown(() {
      if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
    });

    // The SDK generic base types that appear in bridged signatures but have no
    // scanned ClassInfo. None of these must produce a warning.
    const sdkAsyncGenerics = [
      'FutureOr',
      'StreamSubscription',
      'StreamConsumer',
      'StreamTransformer',
      'EventSink',
      'StreamSink',
    ];

    test('no "No ClassInfo" / "skipping wrapper" warning for SDK async generics',
        () async {
      final config = configFor('${tempDir.path}/relaxers.b.dart');
      final result = await generateRelaxers(
        config: config,
        projectPath: tempDir.path,
        globalClassLookup: buildLookup(),
        genericExtractionSites: [
          // A real, wrappable application generic.
          const GenericExtractionSite(
            baseTypeName: 'Box',
            typeArg: 'Apple',
            moduleName: 'fake',
          ),
          // SDK async generics — must be skipped silently.
          for (final t in sdkAsyncGenerics)
            GenericExtractionSite(
              baseTypeName: t,
              typeArg: 'Apple',
              moduleName: 'fake',
            ),
        ],
      );

      for (final t in sdkAsyncGenerics) {
        expect(
          result.warnings,
          isNot(contains(contains(t))),
          reason: 'SDK async generic "$t" should be skipped without a warning, '
              'but a warning mentioning it was emitted: '
              '${result.warnings.where((w) => w.contains(t)).toList()}',
        );
      }

      // The real application relaxer must still be generated.
      expect(result.outputFile, isNotNull);
      final code = File(result.outputFile!).readAsStringSync();
      expect(code, contains(r'$RelaxedBox'),
          reason: 'the real Box<T> relaxer wrapper should still be generated');
    });
  });
}
