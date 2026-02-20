// DCli utilities test script for d4 example
// Uses imports that d4 has bridged
import 'package:dcli/dcli.dart';
import 'package:path/path.dart' as p;

void main() {
  print('');
  print('═══════════════════════════════════════════════════════════════');
  print('DCli Utilities Example');
  print('═══════════════════════════════════════════════════════════════');
  print('');
  
  print('** Current Directory **');
  print('');
  var cwd = pwd;
  print('  pwd: $cwd');
  
  print('');
  print('** Path Manipulation **');
  print('');
  var testPath = p.join(cwd, 'lib', 'src', 'example.dart');
  print('  p.join(cwd, "lib", "src", "example.dart")');
  print('  → $testPath');
  print('');
  print('  p.dirname(testPath):   ${p.dirname(testPath)}');
  print('  p.basename(testPath):  ${p.basename(testPath)}');
  print('  p.extension(testPath): ${p.extension(testPath)}');
  print('  p.basenameWithoutExtension(testPath): ${p.basenameWithoutExtension(testPath)}');
  
  print('');
  print('** File Existence Checks **');
  print('');
  print('  exists("pubspec.yaml"): ${exists('pubspec.yaml')}');
  print('  exists("nonexistent"):  ${exists('nonexistent')}');
  print('  isFile("pubspec.yaml"): ${isFile('pubspec.yaml')}');
  print('  isDirectory("lib"):     ${isDirectory('lib')}');
  
  print('');
  print('** Temp Directory **');
  print('');
  var tempPath = createTempDir();
  print('  createTempDir(): $tempPath');
  print('  Exists: ${exists(tempPath)}');
  deleteDir(tempPath);
  print('  Deleted: ${!exists(tempPath)}');
  
  print('');
  print('═══════════════════════════════════════════════════════════════');
  print('Test complete!');
  print('');
}
