/// Whether a package's committed bridges still match what the generator would
/// produce from that package's own configuration.
///
/// WHY THIS EXISTS. Bridge regeneration is not a side effect of any non-Flutter
/// test suite — it happens only when somebody runs `d4rtgen` by hand. So a
/// generator change can land, every suite go green, and every checked-in
/// `*.b.dart` stay stale: the suites then test the OLD generated code. GEN-123
/// was the concrete case — a relative scan root silently dropped all four user
/// bridges in `d4rt_userbridges_sample`, and no suite noticed, because none
/// regenerated. [checkBridgeFreshness] turns "the committed bridges match the
/// current generator" from a convention into something a test can assert.
///
/// HOW IT AVOIDS TOUCHING THE PACKAGE. It runs the ordinary [generateBridges]
/// against the package, with its unmodified configuration, inside a scratch
/// overlay (`scratch_overlay.dart`): writes to the package's `*.b.dart` files
/// land in a scratch tree, and reads see what an in-place run would see — this
/// run's output where it has written one, the committed file otherwise. Every
/// file [generateBridges] writes ends in `.b.dart`, because each destination
/// passes through `ensureBDartExtension`, so the suffix covers all of them.
///
/// The configuration must NOT be rewritten to point elsewhere, which is the
/// obvious alternative and the wrong one: the generator derives CONTENT from
/// the configured output paths, not just destinations. The test runner, for
/// one, imports a module with `package:` when it lives outside `lib/` and the
/// module inside it, and quotes its own path in its usage comments. Re-rooted
/// paths produce a different file, and every package would read as stale.
library;

import 'dart:io';

import 'package:path/path.dart' as p;

import 'bridge_api.dart';
import 'build_config_loader.dart';
import 'generation_preview.dart';

/// One generated file whose committed copy does not match a fresh generation.
class StaleBridge {
  /// Creates a record of a stale bridge at [path].
  const StaleBridge(this.path, this.reason);

  /// Package-relative path, for example `lib/src/d4rt_bridges/x.b.dart`.
  final String path;

  /// Why it is stale: [StaleReason.differs] or [StaleReason.notCommitted].
  final StaleReason reason;

  @override
  String toString() => '$path (${reason.description})';
}

/// The two ways a committed bridge can disagree with a fresh generation.
enum StaleReason {
  /// The file is committed, and its content differs beyond the timestamp.
  differs('committed content differs from a fresh generation'),

  /// The generator produces the file, and the package does not contain it.
  notCommitted('generated, but not in the package');

  const StaleReason(this.description);

  /// A phrase fit for a failure message.
  final String description;
}

/// The outcome of [checkBridgeFreshness].
class BridgeFreshness {
  /// Creates a freshness report.
  const BridgeFreshness({
    required this.checked,
    required this.stale,
    required this.errors,
  });

  /// Package-relative paths of every file the generator produced.
  final List<String> checked;

  /// The files whose committed copy does not match.
  final List<StaleBridge> stale;

  /// Generation errors. A report with errors has not measured anything.
  final List<String> errors;

  /// True only when the generator ran cleanly AND nothing is stale.
  bool get isFresh => errors.isEmpty && stale.isEmpty;
}

/// Regenerate [projectPath]'s bridges into a scratch tree and compare them with
/// what the package has committed.
///
/// The scratch tree lives under the package's own `.dart_tool/`, which is
/// gitignored and per-package, and is removed afterwards. A unique
/// subdirectory per call keeps two concurrent checks of one package apart.
Future<BridgeFreshness> checkBridgeFreshness(String projectPath) async {
  final packageRoot = p.normalize(p.absolute(projectPath));
  final config = BuildConfigLoader.loadFromTomBuildYaml(packageRoot);
  if (config == null) {
    throw ArgumentError('No d4rtgen configuration found in $packageRoot');
  }

  // `generateBridges` runs `dart pub get` for a package without a package
  // config. That is a subprocess, which no `dart:io` overlay can redirect, and
  // it would rewrite `pubspec.lock` in place. An unresolved package is refused.
  final packageConfig = File(
    p.join(packageRoot, '.dart_tool', 'package_config.json'),
  );
  if (!packageConfig.existsSync()) {
    return BridgeFreshness(
      checked: const [],
      stale: const [],
      errors: [
        '$packageRoot is not resolved (no .dart_tool/package_config.json). '
            'Run `dart pub get` first; the check does not run it, because '
            'that would write to the package.',
      ],
    );
  }

  final preview = await previewGeneration(
    packageRoot: packageRoot,
    purpose: 'freshness',
    generate: () => generateBridges(config: config, projectPath: packageRoot),
  );
  final writes = {for (final w in preview.writes) w.path: w.change};

  final checked = <String>[];
  final stale = <StaleBridge>[];
  for (final reportedPath in preview.result.outputFiles) {
    final relative = p.relative(
      p.normalize(p.absolute(reportedPath)),
      from: packageRoot,
    );
    checked.add(relative);
    // The generator reports destinations in the package; the overlay sent the
    // writes to the scratch tree. A reported file the preview did not see was
    // written some other way — possibly in place — so nothing can be
    // concluded, and the package itself should be inspected.
    final change = writes[relative];
    if (change == null) {
      return BridgeFreshness(
        checked: checked,
        stale: stale,
        errors: [
          'The generator reported $relative, but it is not in the scratch '
              'tree. The write was not redirected, so the package itself may '
              'have been modified — inspect it before trusting any result.',
        ],
      );
    }
    switch (change) {
      case PreviewedChange.created:
        stale.add(StaleBridge(relative, StaleReason.notCommitted));
      case PreviewedChange.changed:
        stale.add(StaleBridge(relative, StaleReason.differs));
      case PreviewedChange.unchanged:
        break;
    }
  }
  return BridgeFreshness(
    checked: checked,
    stale: stale,
    errors: preview.result.errors,
  );
}
