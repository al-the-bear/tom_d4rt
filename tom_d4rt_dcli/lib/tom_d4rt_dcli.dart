/// DCLI - D4rt Command Line Interface with dcli bridges
/// 
/// This is the base D4rt REPL tool with only dcli package bridges.
/// For the full D4rt tool with Tom Framework bridges, use tom_dartscript_bridges.
library;

import 'package:tom_d4rt/tom_d4rt.dart';

import 'src/bridges/dcli_bridges.dart' as dcli_bridges;
import 'src/cli/repl_base.dart';

export 'src/bridges/dcli_bridges.dart';
export 'src/cli/repl_base.dart';

/// The current version of the dcli tool.
const String dcliVersion = '0.1.0';

/// Combined bridge registration for tom_d4rt_dcli.
class DcliBridges {
  /// Register all bridges with D4rt interpreter.
  static void register([D4rt? interpreter]) {
    final d4rt = interpreter ?? D4rt();
    dcli_bridges.DcliBridge.registerBridges(
      d4rt,
      'package:dcli/dcli.dart',
    );
  }
  
  /// Get import block for all modules.
  static String getImportBlock() {
    return dcli_bridges.DcliBridge.getImportBlock();
  }
}

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
    DcliBridges.register(d4rt);
  }
  
  @override
  String getImportBlock() {
    return DcliBridges.getImportBlock();
  }
  
  @override
  String getBridgesHelp([D4rt? d4rt]) {
    if (d4rt == null) {
      return '''
<cyan>**Bridges**</cyan>
  DCLI provides bridges for the `dcli` package.
  Use <yellow>**info**</yellow> <package> to see details for a specific package.
  Use <yellow>**classes**</yellow> to list all available classes.''';
    }
    
    // Generate dynamic bridges help from configuration
    final buffer = StringBuffer();
    buffer.writeln('<cyan>**Bridges**</cyan>');
    buffer.writeln('  Use <yellow>**info**</yellow> <package> to see details for a specific package.');
    buffer.writeln('');
    printAllPackagesInfo(d4rt);
    buffer.writeln('');
    buffer.writeln('  Use <yellow>**classes**</yellow> to list all available classes.');
    return buffer.toString();
  }
}
