// ghissues51 - GitHub #17: no generated import names a part file.
//
// Reported on a material_ui adapter: `import 'package:vector_math/src/
// vector_math_64/matrix4.dart' as $vector_math_1;` (import_of_non_library).
// Matrix4 is declared in a part of vector_math_64.dart. An extension found by
// import discovery (GEN-049) carried its on-type's URI from the declaring
// FRAGMENT - the part file - and the on-type URIs of packages no bridged file
// covers were added to the import list unresolved. Fixed twice over: the
// on-type URI is the library's, and every URI of the prefixed import list goes
// through the part-of resolution.

@Tags(['generation'])
library;

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/verification/generated_output_analysis.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

import 'synthesised_package.dart';

/// Two packages: `zom_vm` declares `Mat4` in a part of `vm64.dart` (the shape
/// of vector_math's `Matrix4`), `zom_adapter` uses it through that library.
Directory writeFixture() {
  final root = Directory.systemTemp.createTempSync('ghissues51_');
  final vm = Directory(p.join(root.path, 'zom_vm'));
  final adapter = Directory(p.join(root.path, 'zom_adapter'));
  void write(Directory d, String rel, String text) {
    final f = File(p.join(d.path, rel));
    f.parent.createSync(recursive: true);
    f.writeAsStringSync(text);
  }

  write(
    vm,
    'pubspec.yaml',
    "name: zom_vm\nenvironment:\n  sdk: '>=3.0.0 <4.0.0'\n",
  );
  write(vm, 'lib/vm64.dart', "library;\n\npart 'src/vm64/m4.dart';\n");
  write(
    vm,
    'lib/src/vm64/m4.dart',
    "part of '../../vm64.dart';\n\nclass Mat4 {\n  Mat4();\n  double get det => 1.0;\n}\n",
  );
  // An extension declared in a part of another library of zom_vm: the
  // bridge calls it, so it needs that library imported, not the part.
  write(
    vm,
    'lib/extras.dart',
    "import 'vm64.dart';\n\npart 'src/extras/ops.dart';\n",
  );
  write(
    vm,
    'lib/src/extras/ops.dart',
    "part of '../../extras.dart';\n\n"
        'extension Mat4Ops on Mat4 {\n  double get half => det / 2;\n}\n',
  );
  write(
    adapter,
    'pubspec.yaml',
    "name: zom_adapter\nenvironment:\n  sdk: '>=3.0.0 <4.0.0'\n"
        'dependencies:\n  zom_vm:\n    path: ../zom_vm\n',
  );
  // tom_d4rt and the adapter from the generator's own resolved config, then
  // zom_vm beside them, so the generated file can be analysed.
  writeSynthesisedPackageConfig(
    root: adapter,
    generatorRoot: Directory.current.path,
    packageName: 'zom_adapter',
  );
  final configFile = File(
    p.join(adapter.path, '.dart_tool', 'package_config.json'),
  );
  final config =
      jsonDecode(configFile.readAsStringSync()) as Map<String, dynamic>;
  (config['packages'] as List).add({
    'name': 'zom_vm',
    'rootUri': '../../zom_vm',
    'packageUri': 'lib/',
    'languageVersion': '3.0',
  });
  configFile.writeAsStringSync(jsonEncode(config));
  write(
    adapter,
    'lib/adapter.dart',
    "import 'package:zom_vm/vm64.dart';\n"
        "import 'package:zom_vm/extras.dart';\n"
        "import 'ext.dart';\n\n"
        'class Holder {\n  Holder(this.m);\n  final Mat4 m;\n'
        '  Mat4 same(Mat4 other) => other;\n'
        '  double get twice => m.twice;\n'
        '  double get half => m.half;\n}\n',
  );
  // The extension sits in a library the bridged file imports, so it reaches
  // the generator through import discovery (GEN-049), whose on-type URI is
  // the fragment's source - the part file.
  write(
    adapter,
    'lib/ext.dart',
    "import 'package:zom_vm/vm64.dart';\n\n"
        'extension Mat4Ext on Mat4 {\n  double get twice => det * 2;\n}\n',
  );
  return root;
}

void main() {
  late Directory fixture;
  late String code;

  setUpAll(() async {
    fixture = writeFixture();
    final adapter = p.join(fixture.path, 'zom_adapter');
    final out = p.join(adapter, 'lib', 'adapter_bridges.b.dart');
    final generator = BridgeGenerator(
      workspacePath: adapter,
      skipPrivate: true,
      helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
      packageName: 'zom_adapter',
    );
    final result = await generator.generateBridges(
      sourceFiles: [p.join(adapter, 'lib', 'adapter.dart')],
      outputPath: out,
      moduleName: 'adapter',
    );
    expect(result.errors, isEmpty);
    code = File(out).readAsStringSync();
  });

  tearDownAll(() => fixture.deleteSync(recursive: true));

  test('GHI51-1: a type declared in another package\'s part file is imported '
      'through its library (GitHub #17) [2026-11-14]', () {
    final imports = RegExp(
      r"^import '([^']+)'",
      multiLine: true,
    ).allMatches(code).map((m) => m.group(1)!).toList();
    expect(imports, isNot(contains('package:zom_vm/src/vm64/m4.dart')));
    expect(imports, isNot(contains('package:zom_vm/src/extras/ops.dart')));
    expect(imports, contains('package:zom_vm/vm64.dart'));
    expect(
      RegExp(
        r"^import 'package:zom_vm/vm64\.dart' as \$\w+;",
        multiLine: true,
      ).hasMatch(code),
      isTrue,
      reason: 'the library is imported with a prefix, as the issue expects',
    );
  });

  test('GHI51-2: the generated file analyzes clean [2026-11-14]', () async {
    final fatal = fatalDiagnostics(
      await analyzeDirectory(p.join(fixture.path, 'zom_adapter')),
    );
    expect(fatal, isEmpty, reason: fatal.join('\n'));
  });
}
