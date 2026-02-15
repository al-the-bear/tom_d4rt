// Supplementary bridges for dcli functions/classes not picked up by d4rtgen.
// These are manually maintained until the generator handles them.
//
// Missing items:
// - lastModified() and setLastModifed() global functions (from dcli_core is.dart)
// - symlink() global function (from dcli file_sync.dart)
// - Find class with static const members (from dcli_core find.dart)
library;

import 'package:dcli_core/src/functions/find.dart' as dcli_find;
import 'package:dcli_core/src/functions/is.dart' as dcli_is;
import 'package:dcli/src/util/file_sync.dart' as dcli_filesync;
import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

/// Registers missing dcli bridges not covered by the generator.
class DcliMissingBridges {
  /// Register all missing bridges with the interpreter.
  static void register(D4rt interpreter, String importPath) {
    // Register missing global functions
    final funcs = _globalFunctions();
    final sources = _functionSourceUris();
    final sigs = _functionSignatures();
    for (final entry in funcs.entries) {
      interpreter.registertopLevelFunction(
        entry.key,
        entry.value,
        importPath,
        sourceUri: sources[entry.key],
        signature: sigs[entry.key],
      );
    }

    // Register Find class bridge
    interpreter.registerBridgedClass(
      _createFindBridge(),
      importPath,
      sourceUri: 'package:dcli_core/src/functions/find.dart',
    );
  }

  static Map<String, NativeFunctionImpl> _globalFunctions() {
    return {
      'lastModified': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'lastModified');
        final path =
            D4.getRequiredArg<String>(positional, 0, 'path', 'lastModified');
        return dcli_is.lastModified(path);
      },
      'setLastModifed': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'setLastModifed');
        final path =
            D4.getRequiredArg<String>(positional, 0, 'path', 'setLastModifed');
        final lastModified = D4.getRequiredArg<DateTime>(
            positional, 1, 'lastModified', 'setLastModifed');
        dcli_is.setLastModifed(path, lastModified);
        return null;
      },
      'symlink': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'symlink');
        final existingPath = D4.getRequiredArg<String>(
            positional, 0, 'existingPath', 'symlink');
        final linkPath =
            D4.getRequiredArg<String>(positional, 1, 'linkPath', 'symlink');
        // Use createSymLink internally (symlink is deprecated in dcli 8.4.2)
        dcli_filesync.createSymLink(
            targetPath: existingPath, linkPath: linkPath);
        return null;
      },
    };
  }

  static Map<String, String> _functionSourceUris() {
    return {
      'lastModified': 'package:dcli_core/src/functions/is.dart',
      'setLastModifed': 'package:dcli_core/src/functions/is.dart',
      'symlink': 'package:dcli/src/util/file_sync.dart',
    };
  }

  static Map<String, String> _functionSignatures() {
    return {
      'lastModified': 'DateTime lastModified(String path)',
      'setLastModifed':
          'void setLastModifed(String path, DateTime lastModified)',
      'symlink': 'void symlink(String existingPath, String linkPath)',
    };
  }

  /// Bridge for the Find class (static const members for FileSystemEntityType).
  static BridgedClass _createFindBridge() {
    return BridgedClass(
      nativeType: dcli_find.Find,
      name: 'Find',
      constructors: {},
      methods: {},
      getters: {},
      staticGetters: {
        'file': (visitor) => dcli_find.Find.file,
        'directory': (visitor) => dcli_find.Find.directory,
        'link': (visitor) => dcli_find.Find.link,
      },
      staticMethods: {},
      methodSignatures: {},
    );
  }
}
