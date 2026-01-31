/// Library bridge mapping types for deduplicating elements across re-exports.
///
/// These types enable D4rt to correctly handle barrels that re-export
/// elements from other packages without registering duplicate bridges.
library;

import 'package:tom_d4rt/src/bridge/bridged_types.dart';
import 'package:tom_d4rt/src/bridge/registration.dart';
import 'package:tom_d4rt/src/callable.dart';
import 'package:tom_d4rt/src/d4rt_base.dart';

/// Bridges for a single source library.
///
/// Groups all bridged elements that originate from the same canonical library
/// (e.g., `package:tom_crypto/src/rsa/helpers.dart`). This allows the runtime
/// to identify that elements from the same source are identical, even when
/// accessed through different barrels.
///
/// Example:
/// ```dart
/// // Elements from package:tom_crypto/src/rsa/helpers.dart
/// final libraryBridge = LibraryBridgeDefinition(
///   canonicalUri: 'package:tom_crypto/src/rsa/helpers.dart',
///   classes: {'RsaKeyHelper': rsaKeyHelperBridge},
///   functions: {'getRsaKeyPair': getRsaKeyPairFunc},
///   variables: {},
///   getters: {},
///   enums: {},
/// );
/// ```
class LibraryBridgeDefinition {
  /// The canonical package URI for this library.
  ///
  /// This is the actual source location of the elements, not the barrel
  /// through which they were exported. Format: `package:pkg_name/path/file.dart`.
  final String canonicalUri;

  /// Bridged class definitions keyed by class name.
  final Map<String, BridgedClass> classes;

  /// Native function implementations keyed by function name.
  final Map<String, NativeFunction> functions;

  /// Library variables keyed by variable name.
  final Map<String, LibraryVariable> variables;

  /// Library getters keyed by getter name.
  final Map<String, LibraryGetter> getters;

  /// Bridged enum definitions keyed by enum name.
  final Map<String, BridgedEnumDefinition> enums;

  /// Creates a new library bridge definition.
  const LibraryBridgeDefinition({
    required this.canonicalUri,
    this.classes = const {},
    this.functions = const {},
    this.variables = const {},
    this.getters = const {},
    this.enums = const {},
  });

  /// Whether this library has any bridged content.
  bool get isEmpty =>
      classes.isEmpty &&
      functions.isEmpty &&
      variables.isEmpty &&
      getters.isEmpty &&
      enums.isEmpty;

  /// Whether this library has any bridged content.
  bool get isNotEmpty => !isEmpty;

  /// Returns a new definition with additional elements merged in.
  ///
  /// Throws [StateError] if any element already exists (true duplicates).
  LibraryBridgeDefinition merge(LibraryBridgeDefinition other) {
    if (canonicalUri != other.canonicalUri) {
      throw ArgumentError(
        'Cannot merge libraries with different URIs: $canonicalUri != ${other.canonicalUri}',
      );
    }

    // Check for duplicate names
    for (final name in other.classes.keys) {
      if (classes.containsKey(name)) {
        throw StateError('Duplicate class "$name" in library $canonicalUri');
      }
    }
    for (final name in other.functions.keys) {
      if (functions.containsKey(name)) {
        throw StateError('Duplicate function "$name" in library $canonicalUri');
      }
    }
    for (final name in other.variables.keys) {
      if (variables.containsKey(name)) {
        throw StateError('Duplicate variable "$name" in library $canonicalUri');
      }
    }
    for (final name in other.getters.keys) {
      if (getters.containsKey(name)) {
        throw StateError('Duplicate getter "$name" in library $canonicalUri');
      }
    }
    for (final name in other.enums.keys) {
      if (enums.containsKey(name)) {
        throw StateError('Duplicate enum "$name" in library $canonicalUri');
      }
    }

    return LibraryBridgeDefinition(
      canonicalUri: canonicalUri,
      classes: {...classes, ...other.classes},
      functions: {...functions, ...other.functions},
      variables: {...variables, ...other.variables},
      getters: {...getters, ...other.getters},
      enums: {...enums, ...other.enums},
    );
  }

  @override
  String toString() =>
      'LibraryBridgeDefinition($canonicalUri, '
      '${classes.length} classes, '
      '${functions.length} functions, '
      '${variables.length} variables, '
      '${getters.length} getters, '
      '${enums.length} enums)';
}

/// Mapping from a barrel (re-export file) to its source libraries.
///
/// Barrels like `package:tom_core_kernel/tom_core_kernel.dart` export elements
/// from many source libraries. This mapping allows the runtime to trace which
/// libraries a barrel provides access to.
///
/// Example:
/// ```dart
/// final mapping = BarrelMapping(
///   barrelUri: 'package:tom_core_kernel/tom_core_kernel.dart',
///   sourceLibraries: [
///     'package:tom_core_kernel/src/logging/logger.dart',
///     'package:tom_core_kernel/src/context/execution_context.dart',
///     'package:tom_crypto/src/rsa/helpers.dart',  // Re-exported from tom_crypto
///   ],
/// );
/// ```
class BarrelMapping {
  /// The barrel's package URI.
  ///
  /// This is the import path that D4rt scripts use to access the package.
  /// Format: `package:pkg_name/barrel.dart`.
  final String barrelUri;

  /// List of canonical source library URIs exported by this barrel.
  ///
  /// Includes both libraries from this package and re-exported libraries
  /// from other packages.
  final List<String> sourceLibraries;

  /// Show clause restrictions (if any).
  ///
  /// If non-empty, only these symbols are accessible via this barrel.
  final Set<String>? showClause;

  /// Hide clause restrictions (if any).
  ///
  /// If non-empty, these symbols are hidden from this barrel.
  final Set<String>? hideClause;

  /// Creates a new barrel mapping.
  const BarrelMapping({
    required this.barrelUri,
    required this.sourceLibraries,
    this.showClause,
    this.hideClause,
  });

  /// Whether a symbol is accessible through this barrel.
  bool isSymbolExported(String symbolName) {
    if (showClause != null && showClause!.isNotEmpty) {
      return showClause!.contains(symbolName);
    }
    if (hideClause != null && hideClause!.isNotEmpty) {
      return !hideClause!.contains(symbolName);
    }
    return true;
  }

  @override
  String toString() =>
      'BarrelMapping($barrelUri -> ${sourceLibraries.length} libraries)';
}

/// Complete bridge information for a package/module.
///
/// Contains both the barrel-to-libraries mappings and the library-to-bridges
/// definitions. This enables complete deduplication at registration time.
class ModuleBridgeInfo {
  /// Mappings from barrel URIs to their source libraries.
  final List<BarrelMapping> barrelMappings;

  /// Bridge definitions keyed by canonical library URI.
  final Map<String, LibraryBridgeDefinition> libraryBridges;

  /// Creates a new module bridge info.
  const ModuleBridgeInfo({
    required this.barrelMappings,
    required this.libraryBridges,
  });

  /// Gets all source libraries for a barrel URI.
  List<String>? getLibrariesForBarrel(String barrelUri) {
    for (final mapping in barrelMappings) {
      if (mapping.barrelUri == barrelUri) {
        return mapping.sourceLibraries;
      }
    }
    return null;
  }

  /// Gets the bridge definition for a library URI.
  LibraryBridgeDefinition? getBridgesForLibrary(String libraryUri) {
    return libraryBridges[libraryUri];
  }

  @override
  String toString() =>
      'ModuleBridgeInfo(${barrelMappings.length} barrels, '
      '${libraryBridges.length} libraries)';
}
