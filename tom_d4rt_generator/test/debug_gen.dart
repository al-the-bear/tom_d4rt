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

  // Search for ContainerLike to inspect type bounds  
  final lines = code.split('\n');
  for (var i = 0; i < lines.length; i++) {
    if (lines[i].contains('ContainerLike')) {
      print('L${i + 1}: ${lines[i]}');
    }
  }

  tempDir.deleteSync(recursive: true);
}
