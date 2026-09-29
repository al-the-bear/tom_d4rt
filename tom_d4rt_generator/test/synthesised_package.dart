/// Helpers for tests that synthesise a throwaway package, generate into it and
/// analyse the result.
///
/// Shared by the GEN-121 analyze gate and the SCF15 user-proxy emission test,
/// which build their fixture packages the same way.
library;

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/verification/generated_output_analysis.dart';

/// Runs `dart analyze` over [directory] and returns the parsed diagnostics.
///
/// SCD13: the severity policy, the machine-format parser and the allowlist are
/// no longer defined here. They live in
/// `lib/src/verification/generated_output_analysis.dart` and are shared with
/// `d4rtgen --verify-output`, so the gate and the tool cannot drift into
/// disagreeing about what a bad emission is — which was the whole point of
/// having a gate.
Future<List<Diagnostic>> analyzeDirectory(String directory) async {
  try {
    return await analyzePaths([directory]);
  } on AnalyzeInvocationException catch (e) {
    fail('$e');
  }
}

/// Writes a `package_config.json` that resolves both `tom_d4rt` and the fixture.
void writeSynthesisedPackageConfig({
  required Directory root,
  required String generatorRoot,
  String packageName = 'zom_analyzegate',
}) {
  final ownConfigFile = File(
    p.join(generatorRoot, '.dart_tool', 'package_config.json'),
  );
  if (!ownConfigFile.existsSync()) {
    fail(
      'Cannot synthesise a package config: the generator package has no '
      'resolved .dart_tool/package_config.json at ${ownConfigFile.path}. '
      'This suite reads it to borrow the resolved location of tom_d4rt, and '
      'expects the process cwd to be the generator package root. Run '
      '`dart pub get` in tom_d4rt_generator.',
    );
  }

  final ownConfig =
      jsonDecode(ownConfigFile.readAsStringSync()) as Map<String, dynamic>;
  // Hosted entries carry absolute `file://` roots and stay valid when copied
  // into a config that lives somewhere else. The generator's OWN entry (and
  // any path dependency) is relative to the generator's config, so it is made
  // absolute here — copied verbatim it would claim the fixture's root too,
  // and two packages sharing a root invalidate the whole config.
  final ownConfigDir = ownConfigFile.parent.uri;
  final packages = [
    for (final entry
        in (ownConfig['packages'] as List).cast<Map<String, dynamic>>())
      {
        ...entry,
        'rootUri': ownConfigDir.resolve(entry['rootUri'] as String).toString(),
      },
    {
      'name': packageName,
      // Relative, as `dart pub get` writes it: resolved against the config
      // file's own location, so the package root is the same path whether the
      // analyzer reaches it through a symlink (macOS `/var` → `/private/var`)
      // or not. An absolute `/var/...` URI here left `package:` URIs of the
      // fixture unresolvable from an analyzer rooted at the real path.
      'rootUri': '../',
      'packageUri': 'lib/',
      'languageVersion': '3.0',
    },
  ];

  Directory(p.join(root.path, '.dart_tool')).createSync(recursive: true);
  File(
    p.join(root.path, '.dart_tool', 'package_config.json'),
  ).writeAsStringSync(
    const JsonEncoder.withIndent(
      '  ',
    ).convert({'configVersion': 2, 'packages': packages}),
  );
}
