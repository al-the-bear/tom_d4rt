// D4rt Bridge - Generated file, do not edit
// Sources: 6 files
// Generated: 2026-02-15T11:20:43.854498

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:path/path.dart' as $path_1;
import 'package:path/src/context.dart' as $path_2;
import 'package:path/src/internal_style.dart' as $path_3;
import 'package:path/src/path_exception.dart' as $path_4;
import 'package:path/src/path_map.dart' as $path_5;
import 'package:path/src/path_set.dart' as $path_6;
import 'package:path/src/style.dart' as $path_7;

/// Bridge class for path module.
class PathBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createContextBridge(),
      _createPathExceptionBridge(),
      _createPathMapBridge(),
      _createPathSetBridge(),
      _createStyleBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'Context': 'package:path/src/context.dart',
      'PathException': 'package:path/src/path_exception.dart',
      'PathMap': 'package:path/src/path_map.dart',
      'PathSet': 'package:path/src/path_set.dart',
      'Style': 'package:path/src/style.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
    };
  }

  /// Returns all bridged extension definitions.
  static List<BridgedExtensionDefinition> bridgedExtensions() {
    return [
    ];
  }

  /// Returns a map of extension identifiers to their canonical source URIs.
  static Map<String, String> extensionSourceUris() {
    return {
    };
  }

  /// Registers all bridges with an interpreter.
  ///
  /// [importPath] is the package import path that D4rt scripts will use
  /// to access these classes (e.g., 'package:tom_build/tom.dart').
  static void registerBridges(D4rt interpreter, String importPath) {
    // Register bridged classes with source URIs for deduplication
    final classes = bridgeClasses();
    final classSources = classSourceUris();
    for (final bridge in classes) {
      interpreter.registerBridgedClass(bridge, importPath, sourceUri: classSources[bridge.name]);
    }

    // Register global variables
    registerGlobalVariables(interpreter, importPath);

    // Register global functions with source URIs for deduplication
    final funcs = globalFunctions();
    final funcSources = globalFunctionSourceUris();
    final funcSigs = globalFunctionSignatures();
    for (final entry in funcs.entries) {
      interpreter.registertopLevelFunction(entry.key, entry.value, importPath, sourceUri: funcSources[entry.key], signature: funcSigs[entry.key]);
    }
  }

  /// Registers all global variables with the interpreter.
  ///
  /// [importPath] is the package import path for library-scoped registration.
  /// Collects all registration errors and throws a single exception
  /// with all error details if any registrations fail.
  static void registerGlobalVariables(D4rt interpreter, String importPath) {
    final errors = <String>[];

    try {
      interpreter.registerGlobalVariable('posix', $path_1.posix, importPath, sourceUri: 'package:path/path.dart');
    } catch (e) {
      errors.add('Failed to register variable "posix": $e');
    }
    try {
      interpreter.registerGlobalVariable('windows', $path_1.windows, importPath, sourceUri: 'package:path/path.dart');
    } catch (e) {
      errors.add('Failed to register variable "windows": $e');
    }
    try {
      interpreter.registerGlobalVariable('url', $path_1.url, importPath, sourceUri: 'package:path/path.dart');
    } catch (e) {
      errors.add('Failed to register variable "url": $e');
    }
    try {
      interpreter.registerGlobalVariable('context', $path_1.context, importPath, sourceUri: 'package:path/path.dart');
    } catch (e) {
      errors.add('Failed to register variable "context": $e');
    }
    interpreter.registerGlobalGetter('style', () => $path_1.style, importPath, sourceUri: 'package:path/path.dart');
    interpreter.registerGlobalGetter('current', () => $path_1.current, importPath, sourceUri: 'package:path/path.dart');
    interpreter.registerGlobalGetter('separator', () => $path_1.separator, importPath, sourceUri: 'package:path/path.dart');

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (path):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'absolute': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'absolute');
        final part1 = D4.getRequiredArg<String>(positional, 0, 'part1', 'absolute');
        final part2 = positional.length > 1 ? positional[1] as String? : null;
        final part3 = positional.length > 2 ? positional[2] as String? : null;
        final part4 = positional.length > 3 ? positional[3] as String? : null;
        final part5 = positional.length > 4 ? positional[4] as String? : null;
        final part6 = positional.length > 5 ? positional[5] as String? : null;
        final part7 = positional.length > 6 ? positional[6] as String? : null;
        final part8 = positional.length > 7 ? positional[7] as String? : null;
        final part9 = positional.length > 8 ? positional[8] as String? : null;
        final part10 = positional.length > 9 ? positional[9] as String? : null;
        final part11 = positional.length > 10 ? positional[10] as String? : null;
        final part12 = positional.length > 11 ? positional[11] as String? : null;
        final part13 = positional.length > 12 ? positional[12] as String? : null;
        final part14 = positional.length > 13 ? positional[13] as String? : null;
        final part15 = positional.length > 14 ? positional[14] as String? : null;
        return $path_1.absolute(part1, part2, part3, part4, part5, part6, part7, part8, part9, part10, part11, part12, part13, part14, part15);
      },
      'basename': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'basename');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'basename');
        return $path_1.basename(path);
      },
      'basenameWithoutExtension': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'basenameWithoutExtension');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'basenameWithoutExtension');
        return $path_1.basenameWithoutExtension(path);
      },
      'dirname': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'dirname');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'dirname');
        return $path_1.dirname(path);
      },
      'extension': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'extension');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'extension');
        final level = D4.getOptionalArgWithDefault<int>(positional, 1, 'level', 1);
        return $path_1.extension(path, level);
      },
      'rootPrefix': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'rootPrefix');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'rootPrefix');
        return $path_1.rootPrefix(path);
      },
      'isAbsolute': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isAbsolute');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isAbsolute');
        return $path_1.isAbsolute(path);
      },
      'isRelative': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isRelative');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isRelative');
        return $path_1.isRelative(path);
      },
      'isRootRelative': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isRootRelative');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isRootRelative');
        return $path_1.isRootRelative(path);
      },
      'join': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'join');
        final part1 = D4.getRequiredArg<String>(positional, 0, 'part1', 'join');
        final part2 = positional.length > 1 ? positional[1] as String? : null;
        final part3 = positional.length > 2 ? positional[2] as String? : null;
        final part4 = positional.length > 3 ? positional[3] as String? : null;
        final part5 = positional.length > 4 ? positional[4] as String? : null;
        final part6 = positional.length > 5 ? positional[5] as String? : null;
        final part7 = positional.length > 6 ? positional[6] as String? : null;
        final part8 = positional.length > 7 ? positional[7] as String? : null;
        final part9 = positional.length > 8 ? positional[8] as String? : null;
        final part10 = positional.length > 9 ? positional[9] as String? : null;
        final part11 = positional.length > 10 ? positional[10] as String? : null;
        final part12 = positional.length > 11 ? positional[11] as String? : null;
        final part13 = positional.length > 12 ? positional[12] as String? : null;
        final part14 = positional.length > 13 ? positional[13] as String? : null;
        final part15 = positional.length > 14 ? positional[14] as String? : null;
        final part16 = positional.length > 15 ? positional[15] as String? : null;
        return $path_1.join(part1, part2, part3, part4, part5, part6, part7, part8, part9, part10, part11, part12, part13, part14, part15, part16);
      },
      'joinAll': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'joinAll');
        final parts = D4.getRequiredArg<Iterable<String>>(positional, 0, 'parts', 'joinAll');
        return $path_1.joinAll(parts);
      },
      'split': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'split');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'split');
        return $path_1.split(path);
      },
      'canonicalize': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'canonicalize');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'canonicalize');
        return $path_1.canonicalize(path);
      },
      'normalize': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'normalize');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'normalize');
        return $path_1.normalize(path);
      },
      'relative': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'relative');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'relative');
        final from = D4.getOptionalNamedArg<String?>(named, 'from');
        return $path_1.relative(path, from: from);
      },
      'isWithin': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'isWithin');
        final parent = D4.getRequiredArg<String>(positional, 0, 'parent', 'isWithin');
        final child = D4.getRequiredArg<String>(positional, 1, 'child', 'isWithin');
        return $path_1.isWithin(parent, child);
      },
      'equals': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'equals');
        final path1 = D4.getRequiredArg<String>(positional, 0, 'path1', 'equals');
        final path2 = D4.getRequiredArg<String>(positional, 1, 'path2', 'equals');
        return $path_1.equals(path1, path2);
      },
      'hash': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'hash');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'hash');
        return $path_1.hash(path);
      },
      'withoutExtension': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'withoutExtension');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'withoutExtension');
        return $path_1.withoutExtension(path);
      },
      'setExtension': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'setExtension');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'setExtension');
        final extension = D4.getRequiredArg<String>(positional, 1, 'extension', 'setExtension');
        return $path_1.setExtension(path, extension);
      },
      'fromUri': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fromUri');
        final uri = D4.getRequiredArg<Object?>(positional, 0, 'uri', 'fromUri');
        return $path_1.fromUri(uri);
      },
      'toUri': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'toUri');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'toUri');
        return $path_1.toUri(path);
      },
      'prettyUri': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'prettyUri');
        final uri = D4.getRequiredArg<Object?>(positional, 0, 'uri', 'prettyUri');
        return $path_1.prettyUri(uri);
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'absolute': 'package:path/path.dart',
      'basename': 'package:path/path.dart',
      'basenameWithoutExtension': 'package:path/path.dart',
      'dirname': 'package:path/path.dart',
      'extension': 'package:path/path.dart',
      'rootPrefix': 'package:path/path.dart',
      'isAbsolute': 'package:path/path.dart',
      'isRelative': 'package:path/path.dart',
      'isRootRelative': 'package:path/path.dart',
      'join': 'package:path/path.dart',
      'joinAll': 'package:path/path.dart',
      'split': 'package:path/path.dart',
      'canonicalize': 'package:path/path.dart',
      'normalize': 'package:path/path.dart',
      'relative': 'package:path/path.dart',
      'isWithin': 'package:path/path.dart',
      'equals': 'package:path/path.dart',
      'hash': 'package:path/path.dart',
      'withoutExtension': 'package:path/path.dart',
      'setExtension': 'package:path/path.dart',
      'fromUri': 'package:path/path.dart',
      'toUri': 'package:path/path.dart',
      'prettyUri': 'package:path/path.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'absolute': 'String absolute(String part1, [String? part2, String? part3, String? part4, String? part5, String? part6, String? part7, String? part8, String? part9, String? part10, String? part11, String? part12, String? part13, String? part14, String? part15])',
      'basename': 'String basename(String path)',
      'basenameWithoutExtension': 'String basenameWithoutExtension(String path)',
      'dirname': 'String dirname(String path)',
      'extension': 'String extension(String path, [int level = 1])',
      'rootPrefix': 'String rootPrefix(String path)',
      'isAbsolute': 'bool isAbsolute(String path)',
      'isRelative': 'bool isRelative(String path)',
      'isRootRelative': 'bool isRootRelative(String path)',
      'join': 'String join(String part1, [String? part2, String? part3, String? part4, String? part5, String? part6, String? part7, String? part8, String? part9, String? part10, String? part11, String? part12, String? part13, String? part14, String? part15, String? part16])',
      'joinAll': 'String joinAll(Iterable<String> parts)',
      'split': 'List<String> split(String path)',
      'canonicalize': 'String canonicalize(String path)',
      'normalize': 'String normalize(String path)',
      'relative': 'String relative(String path, {String? from})',
      'isWithin': 'bool isWithin(String parent, String child)',
      'equals': 'bool equals(String path1, String path2)',
      'hash': 'int hash(String path)',
      'withoutExtension': 'String withoutExtension(String path)',
      'setExtension': 'String setExtension(String path, String extension)',
      'fromUri': 'String fromUri(Object? uri)',
      'toUri': 'Uri toUri(String path)',
      'prettyUri': 'String prettyUri(Object? uri)',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:path/path.dart',
      'package:path/src/context.dart',
      'package:path/src/path_exception.dart',
      'package:path/src/path_map.dart',
      'package:path/src/path_set.dart',
      'package:path/src/style.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:path/path.dart';";
  }

  /// Returns barrel import URIs for sub-packages discovered through re-exports.
  ///
  /// When a module follows re-exports into sub-packages (e.g., dcli re-exports
  /// dcli_core), D4rt scripts may import those sub-packages directly.
  /// These barrels need to be registered with the interpreter separately
  /// so that module resolution finds content for those URIs.
  static List<String> subPackageBarrels() {
    return [];
  }

}

// =============================================================================
// Context Bridge
// =============================================================================

BridgedClass _createContextBridge() {
  return BridgedClass(
    nativeType: $path_2.Context,
    name: 'Context',
    constructors: {
      '': (visitor, positional, named) {
        final style = D4.getOptionalNamedArg<$path_7.Style?>(named, 'style');
        final current = D4.getOptionalNamedArg<String?>(named, 'current');
        return $path_2.Context(style: style, current: current);
      },
    },
    getters: {
      'style': (visitor, target) => D4.validateTarget<$path_2.Context>(target, 'Context').style,
      'current': (visitor, target) => D4.validateTarget<$path_2.Context>(target, 'Context').current,
      'separator': (visitor, target) => D4.validateTarget<$path_2.Context>(target, 'Context').separator,
    },
    methods: {
      'absolute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 1, 'absolute');
        final part1 = D4.getRequiredArg<String>(positional, 0, 'part1', 'absolute');
        final part2 = D4.getOptionalArg<String?>(positional, 1, 'part2');
        final part3 = D4.getOptionalArg<String?>(positional, 2, 'part3');
        final part4 = D4.getOptionalArg<String?>(positional, 3, 'part4');
        final part5 = D4.getOptionalArg<String?>(positional, 4, 'part5');
        final part6 = D4.getOptionalArg<String?>(positional, 5, 'part6');
        final part7 = D4.getOptionalArg<String?>(positional, 6, 'part7');
        final part8 = D4.getOptionalArg<String?>(positional, 7, 'part8');
        final part9 = D4.getOptionalArg<String?>(positional, 8, 'part9');
        final part10 = D4.getOptionalArg<String?>(positional, 9, 'part10');
        final part11 = D4.getOptionalArg<String?>(positional, 10, 'part11');
        final part12 = D4.getOptionalArg<String?>(positional, 11, 'part12');
        final part13 = D4.getOptionalArg<String?>(positional, 12, 'part13');
        final part14 = D4.getOptionalArg<String?>(positional, 13, 'part14');
        final part15 = D4.getOptionalArg<String?>(positional, 14, 'part15');
        return t.absolute(part1, part2, part3, part4, part5, part6, part7, part8, part9, part10, part11, part12, part13, part14, part15);
      },
      'basename': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 1, 'basename');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'basename');
        return t.basename(path);
      },
      'basenameWithoutExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 1, 'basenameWithoutExtension');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'basenameWithoutExtension');
        return t.basenameWithoutExtension(path);
      },
      'dirname': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 1, 'dirname');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'dirname');
        return t.dirname(path);
      },
      'extension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 1, 'extension');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'extension');
        final level = D4.getOptionalArgWithDefault<int>(positional, 1, 'level', 1);
        return t.extension(path, level);
      },
      'rootPrefix': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 1, 'rootPrefix');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'rootPrefix');
        return t.rootPrefix(path);
      },
      'isAbsolute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 1, 'isAbsolute');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isAbsolute');
        return t.isAbsolute(path);
      },
      'isRelative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 1, 'isRelative');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isRelative');
        return t.isRelative(path);
      },
      'isRootRelative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 1, 'isRootRelative');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isRootRelative');
        return t.isRootRelative(path);
      },
      'join': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 1, 'join');
        final part1 = D4.getRequiredArg<String>(positional, 0, 'part1', 'join');
        final part2 = D4.getOptionalArg<String?>(positional, 1, 'part2');
        final part3 = D4.getOptionalArg<String?>(positional, 2, 'part3');
        final part4 = D4.getOptionalArg<String?>(positional, 3, 'part4');
        final part5 = D4.getOptionalArg<String?>(positional, 4, 'part5');
        final part6 = D4.getOptionalArg<String?>(positional, 5, 'part6');
        final part7 = D4.getOptionalArg<String?>(positional, 6, 'part7');
        final part8 = D4.getOptionalArg<String?>(positional, 7, 'part8');
        final part9 = D4.getOptionalArg<String?>(positional, 8, 'part9');
        final part10 = D4.getOptionalArg<String?>(positional, 9, 'part10');
        final part11 = D4.getOptionalArg<String?>(positional, 10, 'part11');
        final part12 = D4.getOptionalArg<String?>(positional, 11, 'part12');
        final part13 = D4.getOptionalArg<String?>(positional, 12, 'part13');
        final part14 = D4.getOptionalArg<String?>(positional, 13, 'part14');
        final part15 = D4.getOptionalArg<String?>(positional, 14, 'part15');
        final part16 = D4.getOptionalArg<String?>(positional, 15, 'part16');
        return t.join(part1, part2, part3, part4, part5, part6, part7, part8, part9, part10, part11, part12, part13, part14, part15, part16);
      },
      'joinAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 1, 'joinAll');
        final parts = D4.getRequiredArg<Iterable<String>>(positional, 0, 'parts', 'joinAll');
        return t.joinAll(parts);
      },
      'split': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 1, 'split');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'split');
        return t.split(path);
      },
      'canonicalize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 1, 'canonicalize');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'canonicalize');
        return t.canonicalize(path);
      },
      'normalize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 1, 'normalize');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'normalize');
        return t.normalize(path);
      },
      'relative': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 1, 'relative');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'relative');
        final from = D4.getOptionalNamedArg<String?>(named, 'from');
        return t.relative(path, from: from);
      },
      'isWithin': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 2, 'isWithin');
        final parent = D4.getRequiredArg<String>(positional, 0, 'parent', 'isWithin');
        final child = D4.getRequiredArg<String>(positional, 1, 'child', 'isWithin');
        return t.isWithin(parent, child);
      },
      'equals': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 2, 'equals');
        final path1 = D4.getRequiredArg<String>(positional, 0, 'path1', 'equals');
        final path2 = D4.getRequiredArg<String>(positional, 1, 'path2', 'equals');
        return t.equals(path1, path2);
      },
      'hash': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 1, 'hash');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'hash');
        return t.hash(path);
      },
      'withoutExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 1, 'withoutExtension');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'withoutExtension');
        return t.withoutExtension(path);
      },
      'setExtension': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 2, 'setExtension');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'setExtension');
        final extension = D4.getRequiredArg<String>(positional, 1, 'extension', 'setExtension');
        return t.setExtension(path, extension);
      },
      'fromUri': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 1, 'fromUri');
        final uri = D4.getRequiredArg<Object?>(positional, 0, 'uri', 'fromUri');
        return t.fromUri(uri);
      },
      'toUri': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 1, 'toUri');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'toUri');
        return t.toUri(path);
      },
      'prettyUri': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_2.Context>(target, 'Context');
        D4.requireMinArgs(positional, 1, 'prettyUri');
        final uri = D4.getRequiredArg<Object?>(positional, 0, 'uri', 'prettyUri');
        return t.prettyUri(uri);
      },
    },
    constructorSignatures: {
      '': 'factory Context({Style? style, String? current})',
    },
    methodSignatures: {
      'absolute': 'String absolute(String part1, [String? part2, String? part3, String? part4, String? part5, String? part6, String? part7, String? part8, String? part9, String? part10, String? part11, String? part12, String? part13, String? part14, String? part15])',
      'basename': 'String basename(String path)',
      'basenameWithoutExtension': 'String basenameWithoutExtension(String path)',
      'dirname': 'String dirname(String path)',
      'extension': 'String extension(String path, [int level = 1])',
      'rootPrefix': 'String rootPrefix(String path)',
      'isAbsolute': 'bool isAbsolute(String path)',
      'isRelative': 'bool isRelative(String path)',
      'isRootRelative': 'bool isRootRelative(String path)',
      'join': 'String join(String part1, [String? part2, String? part3, String? part4, String? part5, String? part6, String? part7, String? part8, String? part9, String? part10, String? part11, String? part12, String? part13, String? part14, String? part15, String? part16])',
      'joinAll': 'String joinAll(Iterable<String> parts)',
      'split': 'List<String> split(String path)',
      'canonicalize': 'String canonicalize(String path)',
      'normalize': 'String normalize(String path)',
      'relative': 'String relative(String path, {String? from})',
      'isWithin': 'bool isWithin(String parent, String child)',
      'equals': 'bool equals(String path1, String path2)',
      'hash': 'int hash(String path)',
      'withoutExtension': 'String withoutExtension(String path)',
      'setExtension': 'String setExtension(String path, String extension)',
      'fromUri': 'String fromUri(Object? uri)',
      'toUri': 'Uri toUri(String path)',
      'prettyUri': 'String prettyUri(Object? uri)',
    },
    getterSignatures: {
      'style': 'InternalStyle get style',
      'current': 'String get current',
      'separator': 'String get separator',
    },
  );
}

// =============================================================================
// PathException Bridge
// =============================================================================

BridgedClass _createPathExceptionBridge() {
  return BridgedClass(
    nativeType: $path_4.PathException,
    name: 'PathException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PathException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'PathException');
        return $path_4.PathException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$path_4.PathException>(target, 'PathException').message,
    },
    setters: {
      'message': (visitor, target, value) => 
        D4.validateTarget<$path_4.PathException>(target, 'PathException').message = value as String,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_4.PathException>(target, 'PathException');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'PathException(String message)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'message': 'String get message',
    },
    setterSignatures: {
      'message': 'set message(dynamic value)',
    },
  );
}

// =============================================================================
// PathMap Bridge
// =============================================================================

BridgedClass _createPathMapBridge() {
  return BridgedClass(
    nativeType: $path_5.PathMap,
    name: 'PathMap',
    constructors: {
      '': (visitor, positional, named) {
        final context = D4.getOptionalNamedArg<$path_2.Context?>(named, 'context');
        return $path_5.PathMap(context: context);
      },
      'of': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PathMap');
        if (positional.isEmpty) {
          throw ArgumentError('PathMap: Missing required argument "other" at position 0');
        }
        final other = D4.coerceMap<String, dynamic>(positional[0], 'other');
        final context = D4.getOptionalNamedArg<$path_2.Context?>(named, 'context');
        return $path_5.PathMap.of(other, context: context);
      },
    },
    getters: {
      'isEmpty': (visitor, target) => D4.validateTarget<$path_5.PathMap>(target, 'PathMap').isEmpty,
      'isNotEmpty': (visitor, target) => D4.validateTarget<$path_5.PathMap>(target, 'PathMap').isNotEmpty,
      'length': (visitor, target) => D4.validateTarget<$path_5.PathMap>(target, 'PathMap').length,
      'keys': (visitor, target) => D4.validateTarget<$path_5.PathMap>(target, 'PathMap').keys,
      'values': (visitor, target) => D4.validateTarget<$path_5.PathMap>(target, 'PathMap').values,
      'entries': (visitor, target) => D4.validateTarget<$path_5.PathMap>(target, 'PathMap').entries,
    },
    methods: {
      'cast': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_5.PathMap>(target, 'PathMap');
        return t.cast();
      },
      'addAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_5.PathMap>(target, 'PathMap');
        D4.requireMinArgs(positional, 1, 'addAll');
        if (positional.isEmpty) {
          throw ArgumentError('addAll: Missing required argument "other" at position 0');
        }
        final other = D4.coerceMap<String?, dynamic>(positional[0], 'other');
        t.addAll(other);
        return null;
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_5.PathMap>(target, 'PathMap');
        t.clear();
        return null;
      },
      'putIfAbsent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_5.PathMap>(target, 'PathMap');
        D4.requireMinArgs(positional, 2, 'putIfAbsent');
        final key = D4.getRequiredArg<String?>(positional, 0, 'key', 'putIfAbsent');
        if (positional.length <= 1) {
          throw ArgumentError('putIfAbsent: Missing required argument "ifAbsent" at position 1');
        }
        final ifAbsentRaw = positional[1];
        return t.putIfAbsent(key, () { return D4.callInterpreterCallback(visitor, ifAbsentRaw, []) as dynamic; });
      },
      'containsKey': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_5.PathMap>(target, 'PathMap');
        D4.requireMinArgs(positional, 1, 'containsKey');
        final key = D4.getRequiredArg<Object?>(positional, 0, 'key', 'containsKey');
        return t.containsKey(key);
      },
      'containsValue': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_5.PathMap>(target, 'PathMap');
        D4.requireMinArgs(positional, 1, 'containsValue');
        final value = D4.getRequiredArg<Object?>(positional, 0, 'value', 'containsValue');
        return t.containsValue(value);
      },
      'forEach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_5.PathMap>(target, 'PathMap');
        D4.requireMinArgs(positional, 1, 'forEach');
        if (positional.isEmpty) {
          throw ArgumentError('forEach: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        t.forEach((dynamic p0, dynamic p1) { D4.callInterpreterCallback(visitor, actionRaw, [p0, p1]); });
        return null;
      },
      'remove': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_5.PathMap>(target, 'PathMap');
        D4.requireMinArgs(positional, 1, 'remove');
        final key = D4.getRequiredArg<Object?>(positional, 0, 'key', 'remove');
        return t.remove(key);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_5.PathMap>(target, 'PathMap');
        return t.toString();
      },
      'addEntries': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_5.PathMap>(target, 'PathMap');
        D4.requireMinArgs(positional, 1, 'addEntries');
        final entries = D4.getRequiredArg<Iterable<MapEntry<String?, dynamic>>>(positional, 0, 'entries', 'addEntries');
        t.addEntries(entries);
        return null;
      },
      'map': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_5.PathMap>(target, 'PathMap');
        D4.requireMinArgs(positional, 1, 'map');
        if (positional.isEmpty) {
          throw ArgumentError('map: Missing required argument "transform" at position 0');
        }
        final transformRaw = positional[0];
        return t.map((dynamic p0, dynamic p1) { return D4.callInterpreterCallback(visitor, transformRaw, [p0, p1]) as MapEntry<dynamic, dynamic>; });
      },
      'update': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_5.PathMap>(target, 'PathMap');
        D4.requireMinArgs(positional, 2, 'update');
        final key = D4.getRequiredArg<String?>(positional, 0, 'key', 'update');
        if (positional.length <= 1) {
          throw ArgumentError('update: Missing required argument "update" at position 1');
        }
        final updateRaw = positional[1];
        final ifAbsentRaw = named['ifAbsent'];
        return t.update(key, (dynamic p0) { return D4.callInterpreterCallback(visitor, updateRaw, [p0]) as dynamic; }, ifAbsent: ifAbsentRaw == null ? null : () { return D4.callInterpreterCallback(visitor, ifAbsentRaw, []) as dynamic; });
      },
      'updateAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_5.PathMap>(target, 'PathMap');
        D4.requireMinArgs(positional, 1, 'updateAll');
        if (positional.isEmpty) {
          throw ArgumentError('updateAll: Missing required argument "update" at position 0');
        }
        final updateRaw = positional[0];
        t.updateAll((dynamic p0, dynamic p1) { return D4.callInterpreterCallback(visitor, updateRaw, [p0, p1]) as dynamic; });
        return null;
      },
      'removeWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_5.PathMap>(target, 'PathMap');
        D4.requireMinArgs(positional, 1, 'removeWhere');
        if (positional.isEmpty) {
          throw ArgumentError('removeWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        t.removeWhere((dynamic p0, dynamic p1) { return D4.callInterpreterCallback(visitor, testRaw, [p0, p1]) as bool; });
        return null;
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_5.PathMap>(target, 'PathMap');
        final index = D4.getRequiredArg<Object?>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_5.PathMap>(target, 'PathMap');
        final index = D4.getRequiredArg<String?>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<dynamic>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
    },
    constructorSignatures: {
      '': 'PathMap({p.Context? context})',
      'of': 'PathMap.of(Map<String, V> other, {p.Context? context})',
    },
    methodSignatures: {
      'cast': 'Map<dynamic, dynamic> cast()',
      'addAll': 'void addAll(Map<String?, V> other)',
      'clear': 'void clear()',
      'putIfAbsent': 'V putIfAbsent(String? key, V Function() ifAbsent)',
      'containsKey': 'bool containsKey(Object? key)',
      'containsValue': 'bool containsValue(Object? value)',
      'forEach': 'void forEach(void Function(String? key, V value) action)',
      'remove': 'V remove(Object? key)',
      'toString': 'String toString()',
      'addEntries': 'void addEntries(Iterable<MapEntry<String?, V>> entries)',
      'map': 'Map<dynamic, dynamic> map(MapEntry<dynamic, dynamic> Function(String? key, V value) transform)',
      'update': 'V update(String? key, V Function(V value) update, {V Function() ifAbsent})',
      'updateAll': 'void updateAll(V Function(String? key, V value) update)',
      'removeWhere': 'void removeWhere(bool Function(String? key, V value) test)',
    },
    getterSignatures: {
      'isEmpty': 'bool get isEmpty',
      'isNotEmpty': 'bool get isNotEmpty',
      'length': 'int get length',
      'keys': 'Iterable<String?> get keys',
      'values': 'Iterable<V> get values',
      'entries': 'Iterable<MapEntry<String?, V>> get entries',
    },
  );
}

// =============================================================================
// PathSet Bridge
// =============================================================================

BridgedClass _createPathSetBridge() {
  return BridgedClass(
    nativeType: $path_6.PathSet,
    name: 'PathSet',
    constructors: {
      '': (visitor, positional, named) {
        final context = D4.getOptionalNamedArg<$path_2.Context?>(named, 'context');
        return $path_6.PathSet(context: context);
      },
      'of': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PathSet');
        final other = D4.getRequiredArg<Iterable<String>>(positional, 0, 'other', 'PathSet');
        final context = D4.getOptionalNamedArg<$path_2.Context?>(named, 'context');
        return $path_6.PathSet.of(other, context: context);
      },
    },
    getters: {
      'iterator': (visitor, target) => D4.validateTarget<$path_6.PathSet>(target, 'PathSet').iterator,
      'length': (visitor, target) => D4.validateTarget<$path_6.PathSet>(target, 'PathSet').length,
      'isEmpty': (visitor, target) => D4.validateTarget<$path_6.PathSet>(target, 'PathSet').isEmpty,
      'isNotEmpty': (visitor, target) => D4.validateTarget<$path_6.PathSet>(target, 'PathSet').isNotEmpty,
      'first': (visitor, target) => D4.validateTarget<$path_6.PathSet>(target, 'PathSet').first,
      'last': (visitor, target) => D4.validateTarget<$path_6.PathSet>(target, 'PathSet').last,
      'single': (visitor, target) => D4.validateTarget<$path_6.PathSet>(target, 'PathSet').single,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'add');
        final value = D4.getRequiredArg<String?>(positional, 0, 'value', 'add');
        return t.add(value);
      },
      'addAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'addAll');
        final elements = D4.getRequiredArg<Iterable<String?>>(positional, 0, 'elements', 'addAll');
        t.addAll(elements);
        return null;
      },
      'cast': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        return t.cast();
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        t.clear();
        return null;
      },
      'contains': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'contains');
        final element = D4.getRequiredArg<Object?>(positional, 0, 'element', 'contains');
        return t.contains(element);
      },
      'containsAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'containsAll');
        final other = D4.getRequiredArg<Iterable<Object?>>(positional, 0, 'other', 'containsAll');
        return t.containsAll(other);
      },
      'difference': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'difference');
        final other = D4.getRequiredArg<Set<Object?>>(positional, 0, 'other', 'difference');
        return t.difference(other);
      },
      'intersection': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'intersection');
        final other = D4.getRequiredArg<Set<Object?>>(positional, 0, 'other', 'intersection');
        return t.intersection(other);
      },
      'lookup': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'lookup');
        final element = D4.getRequiredArg<Object?>(positional, 0, 'element', 'lookup');
        return t.lookup(element);
      },
      'remove': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'remove');
        final value = D4.getRequiredArg<Object?>(positional, 0, 'value', 'remove');
        return t.remove(value);
      },
      'removeAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'removeAll');
        final elements = D4.getRequiredArg<Iterable<Object?>>(positional, 0, 'elements', 'removeAll');
        t.removeAll(elements);
        return null;
      },
      'removeWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'removeWhere');
        if (positional.isEmpty) {
          throw ArgumentError('removeWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        t.removeWhere((String? p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
        return null;
      },
      'retainAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'retainAll');
        final elements = D4.getRequiredArg<Iterable<Object?>>(positional, 0, 'elements', 'retainAll');
        t.retainAll(elements);
        return null;
      },
      'retainWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'retainWhere');
        if (positional.isEmpty) {
          throw ArgumentError('retainWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        t.retainWhere((String? p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
        return null;
      },
      'union': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'union');
        final other = D4.getRequiredArg<Set<String?>>(positional, 0, 'other', 'union');
        return t.union(other);
      },
      'toSet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        return t.toSet();
      },
      'followedBy': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'followedBy');
        final other = D4.getRequiredArg<Iterable<String?>>(positional, 0, 'other', 'followedBy');
        return t.followedBy(other);
      },
      'map': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'map');
        if (positional.isEmpty) {
          throw ArgumentError('map: Missing required argument "toElement" at position 0');
        }
        final toElementRaw = positional[0];
        return t.map((dynamic p0) { return D4.callInterpreterCallback(visitor, toElementRaw, [p0]) as dynamic; });
      },
      'where': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'where');
        if (positional.isEmpty) {
          throw ArgumentError('where: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.where((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'whereType': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        return t.whereType();
      },
      'expand': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'expand');
        if (positional.isEmpty) {
          throw ArgumentError('expand: Missing required argument "toElements" at position 0');
        }
        final toElementsRaw = positional[0];
        return t.expand((dynamic p0) { return D4.callInterpreterCallback(visitor, toElementsRaw, [p0]) as Iterable<dynamic>; });
      },
      'forEach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'forEach');
        if (positional.isEmpty) {
          throw ArgumentError('forEach: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        t.forEach((dynamic p0) { D4.callInterpreterCallback(visitor, actionRaw, [p0]); });
        return null;
      },
      'reduce': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'reduce');
        if (positional.isEmpty) {
          throw ArgumentError('reduce: Missing required argument "combine" at position 0');
        }
        final combineRaw = positional[0];
        return t.reduce((dynamic p0, dynamic p1) { return D4.callInterpreterCallback(visitor, combineRaw, [p0, p1]) as dynamic; });
      },
      'fold': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 2, 'fold');
        final initialValue = D4.getRequiredArg<dynamic>(positional, 0, 'initialValue', 'fold');
        if (positional.length <= 1) {
          throw ArgumentError('fold: Missing required argument "combine" at position 1');
        }
        final combineRaw = positional[1];
        return t.fold(initialValue, (dynamic p0, dynamic p1) { return D4.callInterpreterCallback(visitor, combineRaw, [p0, p1]) as dynamic; });
      },
      'every': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'every');
        if (positional.isEmpty) {
          throw ArgumentError('every: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.every((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'join': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        final separator = D4.getOptionalArgWithDefault<String>(positional, 0, 'separator', "");
        return t.join(separator);
      },
      'any': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'any');
        if (positional.isEmpty) {
          throw ArgumentError('any: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.any((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'toList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        final growable = D4.getNamedArgWithDefault<bool>(named, 'growable', true);
        return t.toList(growable: growable);
      },
      'take': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'take');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'take');
        return t.take(count);
      },
      'takeWhile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'takeWhile');
        if (positional.isEmpty) {
          throw ArgumentError('takeWhile: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.takeWhile((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'skip': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'skip');
        final count = D4.getRequiredArg<int>(positional, 0, 'count', 'skip');
        return t.skip(count);
      },
      'skipWhile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'skipWhile');
        if (positional.isEmpty) {
          throw ArgumentError('skipWhile: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        return t.skipWhile((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; });
      },
      'firstWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'firstWhere');
        if (positional.isEmpty) {
          throw ArgumentError('firstWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.firstWhere((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as dynamic; });
      },
      'lastWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'lastWhere');
        if (positional.isEmpty) {
          throw ArgumentError('lastWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.lastWhere((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as dynamic; });
      },
      'singleWhere': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'singleWhere');
        if (positional.isEmpty) {
          throw ArgumentError('singleWhere: Missing required argument "test" at position 0');
        }
        final testRaw = positional[0];
        final orElseRaw = named['orElse'];
        return t.singleWhere((dynamic p0) { return D4.callInterpreterCallback(visitor, testRaw, [p0]) as bool; }, orElse: orElseRaw == null ? null : () { return D4.callInterpreterCallback(visitor, orElseRaw, []) as dynamic; });
      },
      'elementAt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        D4.requireMinArgs(positional, 1, 'elementAt');
        final index = D4.getRequiredArg<int>(positional, 0, 'index', 'elementAt');
        return t.elementAt(index);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_6.PathSet>(target, 'PathSet');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'PathSet({p.Context? context})',
      'of': 'PathSet.of(Iterable<String> other, {p.Context? context})',
    },
    methodSignatures: {
      'add': 'bool add(String? value)',
      'addAll': 'void addAll(Iterable<String?> elements)',
      'cast': 'Set<T> cast()',
      'clear': 'void clear()',
      'contains': 'bool contains(Object? element)',
      'containsAll': 'bool containsAll(Iterable<Object?> other)',
      'difference': 'Set<String?> difference(Set<Object?> other)',
      'intersection': 'Set<String?> intersection(Set<Object?> other)',
      'lookup': 'String? lookup(Object? element)',
      'remove': 'bool remove(Object? value)',
      'removeAll': 'void removeAll(Iterable<Object?> elements)',
      'removeWhere': 'void removeWhere(bool Function(String?) test)',
      'retainAll': 'void retainAll(Iterable<Object?> elements)',
      'retainWhere': 'void retainWhere(bool Function(String?) test)',
      'union': 'Set<String?> union(Set<String?> other)',
      'toSet': 'Set<String?> toSet()',
      'followedBy': 'Iterable<String?> followedBy(Iterable<String?> other)',
      'map': 'Iterable<dynamic> map(dynamic Function(String? e) toElement)',
      'where': 'Iterable<String?> where(bool Function(String? element) test)',
      'whereType': 'Iterable<dynamic> whereType()',
      'expand': 'Iterable<dynamic> expand(Iterable<dynamic> Function(String? element) toElements)',
      'forEach': 'void forEach(void Function(String? element) action)',
      'reduce': 'String? reduce(String? Function(String? value, String? element) combine)',
      'fold': 'dynamic fold(dynamic initialValue, dynamic Function(dynamic previousValue, String? element) combine)',
      'every': 'bool every(bool Function(String? element) test)',
      'join': 'String join([String separator = ""])',
      'any': 'bool any(bool Function(String? element) test)',
      'toList': 'List<String?> toList({bool growable = true})',
      'take': 'Iterable<String?> take(int count)',
      'takeWhile': 'Iterable<String?> takeWhile(bool Function(String? value) test)',
      'skip': 'Iterable<String?> skip(int count)',
      'skipWhile': 'Iterable<String?> skipWhile(bool Function(String? value) test)',
      'firstWhere': 'String? firstWhere(bool Function(String? element) test, {String? Function() orElse})',
      'lastWhere': 'String? lastWhere(bool Function(String? element) test, {String? Function() orElse})',
      'singleWhere': 'String? singleWhere(bool Function(String? element) test, {String? Function() orElse})',
      'elementAt': 'String? elementAt(int index)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'iterator': 'Iterator<String?> get iterator',
      'length': 'int get length',
      'isEmpty': 'bool get isEmpty',
      'isNotEmpty': 'bool get isNotEmpty',
      'first': 'String? get first',
      'last': 'String? get last',
      'single': 'String? get single',
    },
  );
}

// =============================================================================
// Style Bridge
// =============================================================================

BridgedClass _createStyleBridge() {
  return BridgedClass(
    nativeType: $path_7.Style,
    name: 'Style',
    constructors: {
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$path_7.Style>(target, 'Style').name,
      'context': (visitor, target) => D4.validateTarget<$path_7.Style>(target, 'Style').context,
      'separator': (visitor, target) => D4.validateTarget<$path_7.Style>(target, 'Style').separator,
      'separatorPattern': (visitor, target) => D4.validateTarget<$path_7.Style>(target, 'Style').separatorPattern,
      'needsSeparatorPattern': (visitor, target) => D4.validateTarget<$path_7.Style>(target, 'Style').needsSeparatorPattern,
      'rootPattern': (visitor, target) => D4.validateTarget<$path_7.Style>(target, 'Style').rootPattern,
      'relativeRootPattern': (visitor, target) => D4.validateTarget<$path_7.Style>(target, 'Style').relativeRootPattern,
    },
    methods: {
      'getRoot': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_7.Style>(target, 'Style');
        D4.requireMinArgs(positional, 1, 'getRoot');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'getRoot');
        return t.getRoot(path);
      },
      'getRelativeRoot': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_7.Style>(target, 'Style');
        D4.requireMinArgs(positional, 1, 'getRelativeRoot');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'getRelativeRoot');
        return t.getRelativeRoot(path);
      },
      'pathFromUri': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_7.Style>(target, 'Style');
        D4.requireMinArgs(positional, 1, 'pathFromUri');
        final uri = D4.getRequiredArg<Uri>(positional, 0, 'uri', 'pathFromUri');
        return t.pathFromUri(uri);
      },
      'relativePathToUri': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_7.Style>(target, 'Style');
        D4.requireMinArgs(positional, 1, 'relativePathToUri');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'relativePathToUri');
        return t.relativePathToUri(path);
      },
      'absolutePathToUri': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_7.Style>(target, 'Style');
        D4.requireMinArgs(positional, 1, 'absolutePathToUri');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'absolutePathToUri');
        return t.absolutePathToUri(path);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$path_7.Style>(target, 'Style');
        return t.toString();
      },
    },
    staticGetters: {
      'posix': (visitor) => $path_7.Style.posix,
      'windows': (visitor) => $path_7.Style.windows,
      'url': (visitor) => $path_7.Style.url,
      'platform': (visitor) => $path_7.Style.platform,
    },
    methodSignatures: {
      'getRoot': 'String? getRoot(String path)',
      'getRelativeRoot': 'String? getRelativeRoot(String path)',
      'pathFromUri': 'String pathFromUri(Uri uri)',
      'relativePathToUri': 'Uri relativePathToUri(String path)',
      'absolutePathToUri': 'Uri absolutePathToUri(String path)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'name': 'String get name',
      'context': 'Context get context',
      'separator': 'String get separator',
      'separatorPattern': 'Pattern get separatorPattern',
      'needsSeparatorPattern': 'Pattern get needsSeparatorPattern',
      'rootPattern': 'Pattern get rootPattern',
      'relativeRootPattern': 'Pattern? get relativeRootPattern',
    },
    staticGetterSignatures: {
      'posix': 'Style get posix',
      'windows': 'Style get windows',
      'url': 'Style get url',
      'platform': 'Style get platform',
    },
  );
}

