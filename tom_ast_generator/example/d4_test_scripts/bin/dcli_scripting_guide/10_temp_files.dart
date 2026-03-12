#!/usr/bin/env dcli
// DCli Scripting Guide - Temp Files Example

import 'package:dcli/dcli.dart';
import 'package:path/path.dart';

Future<void> main() async {
  print('DCli Temp File Examples');
  print('=======================\n');
  
  // Temp dir with auto-cleanup
  print('1. Using withTempDirAsync:');
  await withTempDirAsync((tmpDir) async {
    var dataFile = join(tmpDir, 'data.json');
    dataFile.write('{"key": "value"}');
    
    // Process file...
    print('  Working in: $tmpDir');
    print('  Created: $dataFile');
    cat(dataFile);
    
    // Auto-deleted when scope exits
  });
  print('  (temp dir auto-deleted)\n');
  
  // Keep temp dir for debugging
  print('2. Keeping temp dir:');
  var debugDir = await withTempDirAsync((tmp) async {
    print('  Debug dir: $tmp');
    return tmp;
  }, keep: true);
  print('  Kept at: $debugDir');
  
  // Cleanup the kept dir
  deleteDir(debugDir);
  print('  (manually deleted)');
  
  print(green('\nTemp file examples completed!'));
}
