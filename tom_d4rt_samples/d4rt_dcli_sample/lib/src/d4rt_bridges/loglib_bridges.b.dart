// D4rt Bridge - Generated file, do not edit
// Sources: 3 files
// Generated: 2026-06-17T19:03:58.263868

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls, invalid_use_of_protected_member, unnecessary_non_null_assertion, invalid_use_of_visible_for_testing_member, unnecessary_cast, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_is_empty, unnecessary_question_mark, unreachable_switch_case, unintended_html_in_doc_comment, empty_constructor_bodies, prefer_const_constructors_in_immutables, prefer_final_fields, unused_field, must_call_super, no_logic_in_create_state, use_key_in_widget_constructors, annotate_overrides, unnecessary_import

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

import 'package:d4rt_dcli_sample/src/loglib/log_entry.dart' as $d4rt_dcli_sample_1;
import 'package:d4rt_dcli_sample/src/loglib/log_parser.dart' as $d4rt_dcli_sample_2;
import 'package:d4rt_dcli_sample/src/loglib/log_stats.dart' as $d4rt_dcli_sample_3;

/// Bridge class for loglib module.
class LoglibBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createLogEntryBridge(),
      _createLogParserBridge(),
      _createLogStatsBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'LogEntry': 'package:d4rt_dcli_sample/src/loglib/log_entry.dart',
      'LogParser': 'package:d4rt_dcli_sample/src/loglib/log_parser.dart',
      'LogStats': 'package:d4rt_dcli_sample/src/loglib/log_stats.dart',
    };
  }

  /// Returns a map of class names to their flattened (transitive)
  /// native supertype names (superclasses, interfaces and mixins).
  ///
  /// Fed to `BridgedClass.registerSupertypes` so interpreted subclasses
  /// of bridged classes pass `is`/subtype checks against bridged
  /// ancestors and the interface-proxy supertype walk resolves up the
  /// chain (MCI#1 / A1).
  static Map<String, List<String>> classSupertypes() {
    return {
    };
  }

  /// Returns a map of type alias names to their target class names.
  ///
  /// Type aliases like `typedef MaterialStateProperty<T> = WidgetStateProperty<T>`
  /// are registered so that code using the alias name can resolve to the
  /// bridged class under its canonical name.
  static Map<String, String> classAliases() {
    return {
    };
  }

  /// Returns the list of function typedef names declared in this library.
  ///
  /// Function typedefs like `typedef VoidCallback = void Function()` are
  /// registered so that they can be used as type arguments in D4rt scripts.
  static List<String> functionTypedefs() {
    return [
    ];
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$d4rt_dcli_sample_1.LogLevel>(
        name: 'LogLevel',
        values: $d4rt_dcli_sample_1.LogLevel.values,
        getters: {
          'label': (visitor, target) => (target as $d4rt_dcli_sample_1.LogLevel).label,
        },
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'LogLevel': 'package:d4rt_dcli_sample/src/loglib/log_entry.dart',
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

  /// GEN-107: Library re-exports declared by the bridged source
  /// libraries. Each tuple mirrors a Dart `export '…'` directive.
  /// Consumed by `registerBridges` via `D4rt.registerLibraryReExport`
  /// (mirrored on `D4rtRunner` in tom_d4rt_ast).
  static List<({String source, String target, Set<String>? show, Set<String>? hide})>
  bridgeReExports() {
    return [
      (source: 'package:d4rt_dcli_sample/d4rt_dcli_sample.dart', target: 'package:d4rt_dcli_sample/src/loglib/log_entry.dart', show: null, hide: null),
      (source: 'package:d4rt_dcli_sample/d4rt_dcli_sample.dart', target: 'package:d4rt_dcli_sample/src/loglib/log_parser.dart', show: null, hide: null),
      (source: 'package:d4rt_dcli_sample/d4rt_dcli_sample.dart', target: 'package:d4rt_dcli_sample/src/loglib/log_stats.dart', show: null, hide: null),
    ];
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

    // MCI#1 / A1: Register the flattened native supertype table so
    // interpreted subclasses pass subtype checks against bridged
    // ancestors. Idempotent — safe to call per barrel.
    BridgedClass.registerSupertypes(classSupertypes());

    // Register bridged enums with source URIs for deduplication
    final enums = bridgedEnums();
    final enumSources = enumSourceUris();
    for (final enumDef in enums) {
      interpreter.registerBridgedEnum(enumDef, importPath, sourceUri: enumSources[enumDef.name]);
    }

    // GEN-107: Register library re-exports
    for (final r in bridgeReExports()) {
      interpreter.registerLibraryReExport(r.source, r.target, show: r.show, hide: r.hide);
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {};
  }

  /// Returns a map of global function names to their canonical source URIs.
  static Map<String, String> globalFunctionSourceUris() {
    return {};
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {};
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:d4rt_dcli_sample/src/loglib/log_entry.dart',
      'package:d4rt_dcli_sample/src/loglib/log_parser.dart',
      'package:d4rt_dcli_sample/src/loglib/log_stats.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:d4rt_dcli_sample/d4rt_dcli_sample.dart';";
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

  /// Returns a list of bridged enum names.
  static List<String> get enumNames => [
    'LogLevel',
  ];

}

// =============================================================================
// LogEntry Bridge
// =============================================================================

BridgedClass _createLogEntryBridge() {
  return BridgedClass(
    nativeType: $d4rt_dcli_sample_1.LogEntry,
    name: 'LogEntry',
    isAssignable: (v) => v is $d4rt_dcli_sample_1.LogEntry,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'LogEntry');
        final lineNumber = D4.getRequiredArg<int>(positional, 0, 'lineNumber', 'LogEntry');
        final level = D4.getRequiredArg<$d4rt_dcli_sample_1.LogLevel>(positional, 1, 'level', 'LogEntry');
        final message = D4.getRequiredArg<String>(positional, 2, 'message', 'LogEntry');
        return $d4rt_dcli_sample_1.LogEntry(lineNumber, level, message);
      },
    },
    getters: {
      'lineNumber': (visitor, target) => D4.validateTarget<$d4rt_dcli_sample_1.LogEntry>(target, 'LogEntry').lineNumber,
      'level': (visitor, target) => D4.validateTarget<$d4rt_dcli_sample_1.LogEntry>(target, 'LogEntry').level,
      'message': (visitor, target) => D4.validateTarget<$d4rt_dcli_sample_1.LogEntry>(target, 'LogEntry').message,
      'isError': (visitor, target) => D4.validateTarget<$d4rt_dcli_sample_1.LogEntry>(target, 'LogEntry').isError,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_dcli_sample_1.LogEntry>(target, 'LogEntry');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'LogEntry(int lineNumber, LogLevel level, String message)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'lineNumber': 'int get lineNumber',
      'level': 'LogLevel get level',
      'message': 'String get message',
      'isError': 'bool get isError',
    },
  );
}

// =============================================================================
// LogParser Bridge
// =============================================================================

BridgedClass _createLogParserBridge() {
  return BridgedClass(
    nativeType: $d4rt_dcli_sample_2.LogParser,
    name: 'LogParser',
    isAssignable: (v) => v is $d4rt_dcli_sample_2.LogParser,
    constructors: {
      '': (visitor, positional, named) {
        return $d4rt_dcli_sample_2.LogParser();
      },
    },
    methods: {
      'parse': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_dcli_sample_2.LogParser>(target, 'LogParser');
        D4.requireMinArgs(positional, 2, 'parse');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'parse');
        final lineNumber = D4.getRequiredArg<int>(positional, 1, 'lineNumber', 'parse');
        return t.parse(line, lineNumber);
      },
      'parseAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_dcli_sample_2.LogParser>(target, 'LogParser');
        D4.requireMinArgs(positional, 1, 'parseAll');
        if (positional.isEmpty) {
          throw ArgumentError('parseAll: Missing required argument "lines" at position 0');
        }
        final lines = D4.coerceList<String>(positional[0], 'lines');
        return t.parseAll(lines);
      },
    },
    constructorSignatures: {
      '': 'LogParser()',
    },
    methodSignatures: {
      'parse': 'LogEntry? parse(String line, int lineNumber)',
      'parseAll': 'List<LogEntry> parseAll(List<String> lines)',
    },
  );
}

// =============================================================================
// LogStats Bridge
// =============================================================================

BridgedClass _createLogStatsBridge() {
  return BridgedClass(
    nativeType: $d4rt_dcli_sample_3.LogStats,
    name: 'LogStats',
    isAssignable: (v) => v is $d4rt_dcli_sample_3.LogStats,
    constructors: {
      '': (visitor, positional, named) {
        return $d4rt_dcli_sample_3.LogStats();
      },
    },
    getters: {
      'total': (visitor, target) => D4.validateTarget<$d4rt_dcli_sample_3.LogStats>(target, 'LogStats').total,
      'errors': (visitor, target) => D4.validateTarget<$d4rt_dcli_sample_3.LogStats>(target, 'LogStats').errors,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_dcli_sample_3.LogStats>(target, 'LogStats');
        D4.requireMinArgs(positional, 1, 'add');
        final entry = D4.getRequiredArg<$d4rt_dcli_sample_1.LogEntry>(positional, 0, 'entry', 'add');
        t.add(entry);
        return null;
      },
      'addAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_dcli_sample_3.LogStats>(target, 'LogStats');
        D4.requireMinArgs(positional, 1, 'addAll');
        if (positional.isEmpty) {
          throw ArgumentError('addAll: Missing required argument "entries" at position 0');
        }
        final entries = D4.coerceList<$d4rt_dcli_sample_1.LogEntry>(positional[0], 'entries');
        t.addAll(entries);
        return null;
      },
      'countOf': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_dcli_sample_3.LogStats>(target, 'LogStats');
        D4.requireMinArgs(positional, 1, 'countOf');
        final level = D4.getRequiredArg<$d4rt_dcli_sample_1.LogLevel>(positional, 0, 'level', 'countOf');
        return t.countOf(level);
      },
      'summary': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$d4rt_dcli_sample_3.LogStats>(target, 'LogStats');
        return t.summary();
      },
    },
    constructorSignatures: {
      '': 'LogStats()',
    },
    methodSignatures: {
      'add': 'void add(LogEntry entry)',
      'addAll': 'void addAll(List<LogEntry> entries)',
      'countOf': 'int countOf(LogLevel level)',
      'summary': 'String summary()',
    },
    getterSignatures: {
      'total': 'int get total',
      'errors': 'List<LogEntry> get errors',
    },
  );
}

