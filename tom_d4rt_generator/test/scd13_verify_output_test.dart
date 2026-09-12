// SCD13 (scd13_ahcm): `d4rtgen --verify-output`.
//
// GEN-121 put the generator's own output under `dart analyze`, inside the
// generator's test suite. That protects the generator and not its consumers: a
// consumer's `analysis_options.yaml` excludes the generated bridge directory,
// so `dart analyze` reports the project clean while a generated file imports a
// URI resolving nowhere. GEN-119 and GEN-120 both shipped through that gap and
// were found by hand afterwards, by someone who thought to analyse one file.
//
// `--verify-output` closes it at the tool. These tests cover the part where the
// decisions are made — the severity policy and, more importantly, the SCOPING:
// only diagnostics inside files this run generated may fail a generation.
// Without that property the flag could never be defaulted on, because any
// consumer carrying an unrelated warning of its own would start failing.

@Tags(['generation'])
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/v2/d4rtgen_tool.dart';
import 'package:tom_d4rt_generator/src/verification/generated_output_analysis.dart';

/// A throwaway package whose files can be written by hand.
///
/// Deliberately minimal and analyzer-resolvable on its own: the point is to
/// control exactly which diagnostics exist, which a real fixture cannot do.
class Scratch {
  Scratch(this.root);

  final Directory root;

  String get lib => p.join(root.path, 'lib');

  String write(String relative, String content) {
    final file = File(p.join(root.path, relative));
    file.parent.createSync(recursive: true);
    file.writeAsStringSync(content);
    return file.path;
  }

  static Scratch create(String tag) {
    final dir = Directory.systemTemp.createTempSync('scd13_${tag}_');
    final scratch = Scratch(dir);
    scratch.write(
      'pubspec.yaml',
      'name: zom_verify\n'
      'environment:\n'
      "  sdk: '>=3.0.0 <4.0.0'\n",
    );
    scratch.write(
      p.join('.dart_tool', 'package_config.json'),
      '{\n'
      '  "configVersion": 2,\n'
      '  "packages": [\n'
      '    {\n'
      '      "name": "zom_verify",\n'
      '      "rootUri": "../",\n'
      '      "packageUri": "lib/",\n'
      '      "languageVersion": "3.0"\n'
      '    }\n'
      '  ]\n'
      '}\n',
    );
    return scratch;
  }

  void dispose() {
    try {
      root.deleteSync(recursive: true);
    } catch (_) {}
  }
}

void main() {
  late Scratch scratch;

  setUp(() => scratch = Scratch.create('case'));
  tearDown(() => scratch.dispose());

  group('SCD13: verify-output decides what a bad emission is', () {
    test(
      'G-SCD13-1: a generated file that analyses clean passes [2026-09-12] '
      '(PASS)',
      () async {
        final generated = scratch.write(
          p.join('lib', 'good.b.dart'),
          'class ZomGood {\n'
          '  const ZomGood();\n'
          '}\n',
        );

        final result = await verifyGeneratedOutput(
          generatedFiles: [generated],
        );

        expect(result.ok, isTrue, reason: result.describe(label: 'good'));
        expect(result.analysed, hasLength(1));
      },
    );

    test(
      'G-SCD13-2: a bare-path import in a generated file fails the '
      'verification [2026-09-12] (PASS)',
      () async {
        // The GEN-119 shape verbatim: a project-relative path where a package
        // URI belongs. It resolves against the generated file's own directory,
        // which is never the resolution base, so it points at nothing.
        final generated = scratch.write(
          p.join('lib', 'broken.b.dart'),
          "import 'lib/src/nowhere.dart' as \$aux_aux;\n"
          '\n'
          'class ZomBroken {}\n',
        );

        final result = await verifyGeneratedOutput(
          generatedFiles: [generated],
        );

        expect(
          result.ok,
          isFalse,
          reason:
              'A generated file importing a URI that resolves nowhere is '
              'exactly what --verify-output exists to catch.',
        );
        expect(
          result.fatal.map((d) => d.code),
          contains('URI_DOES_NOT_EXIST'),
          reason: 'reported: ${result.fatal}',
        );
        expect(
          result.describe(label: 'zom_verify'),
          contains('VERIFY FAILED'),
        );
      },
    );

    test(
      'G-SCD13-3: an error elsewhere in the package does NOT fail the '
      'verification [2026-09-12] (PASS)',
      () async {
        // The property that makes the flag safe to run on a real consumer, and
        // the precondition for ever defaulting it on. A package of its own may
        // be mid-refactor, carry a deliberate warning, or simply be broken for
        // unrelated reasons — none of that is the generator's emission.
        scratch.write(
          p.join('lib', 'hand_written.dart'),
          "import 'package:does_not_exist/nope.dart';\n"
          '\n'
          'int broken() => undefinedFunctionCall();\n',
        );
        final generated = scratch.write(
          p.join('lib', 'clean.b.dart'),
          'class ZomClean {}\n',
        );

        final result = await verifyGeneratedOutput(
          generatedFiles: [generated],
        );

        expect(
          result.ok,
          isTrue,
          reason:
              'Only diagnostics inside generated files may fail a generation. '
              'Reported: ${result.fatal}',
        );
      },
    );

    test(
      'G-SCD13-4: lints and other INFO diagnostics do not fail the '
      'verification [2026-09-12] (PASS)',
      () async {
        // Gating on INFO would make a generation fail because the SDK's default
        // lint set moved, or because the consumer enabled a rule — neither of
        // which is a generator defect.
        final generated = scratch.write(
          p.join('lib', 'lints.b.dart'),
          'class zom_badly_named_class {\n'
          '  void Method_With_Bad_Name() {}\n'
          '}\n',
        );

        final result = await verifyGeneratedOutput(
          generatedFiles: [generated],
        );

        expect(result.ok, isTrue, reason: '${result.fatal}');
        expect(
          nonFatalSeverities,
          contains('INFO'),
          reason: 'the policy this test depends on',
        );
      },
    );

    test(
      'G-SCD13-5: a file the run did not write is skipped, not failed '
      '[2026-09-12] (PASS)',
      () async {
        // A module that generated nothing must not read as a broken emission.
        final result = await verifyGeneratedOutput(
          generatedFiles: [p.join(scratch.lib, 'never_written.b.dart')],
        );

        expect(result.ok, isTrue);
        expect(result.analysed, isEmpty);
      },
    );

    test(
      'G-SCD13-6: the allowlist is empty, so a warning in generated code is '
      'fatal [2026-09-12] (PASS)',
      () {
        // Anti-vacuity for G-SCD13-2: were the allowlist to grow silently, the
        // fatal-diagnostic tests above could start passing for the wrong
        // reason. Each entry is a standing promise that generated code may
        // carry that warning forever, so adding one is a decision, not a fix.
        expect(
          allowedWarningCodes,
          isEmpty,
          reason:
              'An entry here needs a comment naming who reviewed it and why it '
              'cannot be fixed at the generator.',
        );

        final warning = Diagnostic(
          severity: 'WARNING',
          code: 'UNUSED_IMPORT',
          file: 'x.b.dart',
          line: '1',
          message: 'unused',
        );
        expect(fatalDiagnostics([warning]), hasLength(1));
      },
    );
  });

  group('SCD13: the flag is wired to the tool', () {
    test(
      'G-SCD13-7: d4rtgen declares --verify-output [2026-09-12] (PASS)',
      () {
        final names = d4rtgenTool.globalOptions.map((o) => o.name).toList();
        expect(
          names,
          contains('verify-output'),
          reason:
              'The policy can be perfect and still reach nobody if the flag '
              'is not on the tool. Declared options: $names',
        );
      },
    );
  });
}
