/// DCLI - D4rt Command Line Interface with dcli bridges
/// 
/// This is the base D4rt REPL tool with only dcli package bridges.
/// For the full D4rt tool with Tom Framework bridges, use tom_dartscript_bridges.
library;

import 'package:tom_d4rt/tom_d4rt.dart';

import 'dartscript.dart';
import 'src/cli/repl_base.dart';

export 'dartscript.dart';
export 'src/bridges/dcli_bridges.dart';
export 'src/cli/repl_base.dart';

/// The current version of the dcli tool.
const String dcliVersion = '0.1.0';

/// DCLI REPL implementation.
/// 
/// This is the concrete implementation of D4rtReplBase for the dcli tool,
/// providing only dcli package bridges.
class DcliRepl extends D4rtReplBase {
  @override
  String get toolName => 'DCLI';
  
  @override
  String get toolVersion => dcliVersion;
  
  @override
  void registerBridges(D4rt d4rt) {
    TomD4rtDcliBridge.register(d4rt);
  }
  
  @override
  String getImportBlock() {
    return TomD4rtDcliBridge.getImportBlock();
  }
  
  @override
  String getBridgesHelp([D4rt? d4rt]) {
    final buffer = StringBuffer();
    buffer.writeln('<cyan>**Bridges**</cyan>');
    buffer.writeln('  Use <yellow>**info**</yellow> <package> to see details for a specific package.');
    buffer.writeln('');
    
    if (d4rt != null) {
      // Generate list of info commands from configuration
      final packages = getPackageNames(d4rt);
      for (final pkg in packages) {
        buffer.writeln('  <yellow>info</yellow> $pkg');
      }
      buffer.writeln('');
    }
    
    buffer.writeln('  Use <yellow>**classes**</yellow> to list all available classes.');
    buffer.writeln('');
    buffer.writeln(getStdlibNote());
    return buffer.toString();
  }
}
