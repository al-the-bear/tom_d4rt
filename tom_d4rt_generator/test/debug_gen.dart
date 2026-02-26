import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() async {
  final testFixturesDir = p.join(Directory.current.path, 'test', 'fixtures');
  final tempDir = Directory.systemTemp.createTempSync('bridge_debug_');

  final generator = BridgeGenerator(
    workspacePath: testFixturesDir,
    skipPrivate: true,
    helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
    sourceImport: 'flutter_patterns_source.dart',
    packageName: 'test_package',
    verbose: false,
  );

  final sourceFile = p.join(testFixturesDir, 'flutter_patterns_source.dart');
  final outputFile = p.join(tempDir.path, 'flutter_patterns_bridges.dart');

  final result = await generator.generateBridges(
    sourceFiles: [sourceFile],
    outputPath: outputFile,
    moduleName: 'flutter_test',
  );

  final code = await File(result.outputFiles.first).readAsString();

  // Print ContainerLike and LayoutBuilderLike sections for RC-9 analysis
  final lines = code.split('\n');
  var printing = false;
  for (var i = 0; i < lines.length; i++) {
    if (lines[i].contains('ContainerLike Bridge') || lines[i].contains('LayoutBuilderLike Bridge')) {
      printing = true;
    }
    if (printing) {
      print('L${i + 1}: ${lines[i]}');
      if (lines[i] == '}' && i > 560) {
        printing = false;
        print('---');
      }
    }
  }

  tempDir.deleteSync(recursive: true);
}
