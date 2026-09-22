/// Library bridge mapping types for deduplicating elements across re-exports.
///
/// These types describe a RUNTIME solution to barrel re-export deduplication:
/// group bridged elements by the canonical library they came from, record
/// which source libraries each barrel re-exports, and let the interpreter
/// recognise that the same element reached through two barrels is one element.
///
/// ## Deprecated — the problem was solved in the other layer (SCE155)
///
/// That deduplication happens, and it happens at GENERATION time instead:
/// `PerPackageBridgeOrchestrator` in `tom_d4rt_generator` maps each source
/// file to the barrel that exports it (`sourceFileToBarrel`,
/// `BarrelPackageMapping`) and emits one per-package bridge file plus
/// delegating barrel files, so the duplicate never reaches the runtime to be
/// deduplicated. Nothing here was ever wired up, and nothing needs to be: this
/// is a SUPERSEDED design, not an unfinished one. There is no intent to
/// recover.
///
/// MEASURED 2026-09-23, and the answer is conclusive rather than presumed.
/// Workspace-wide, the only `.dart` files naming [LibraryBridgeDefinition],
/// [BarrelMapping] or [ModuleBridgeInfo] are this file and the two guards that
/// record them as dead. Outside it, pub.dev lists exactly four dependents of
/// `tom_d4rt` — `tom_d4rt_generator`, `tom_d4rt_exec`, `tom_d4rt_dcli`,
/// `tom_d4rt_flutter`, all of them this workspace's own — and no cached
/// release of any of the four names one of these types. The API has never had
/// a consumer, here or anywhere.
///
/// It is deprecated rather than deleted because it is on a PUBLISHED surface
/// and removal is breaking whether or not anyone is hurt by it. The removal is
/// due at 2.0.0, and is not left to memory:
/// `tom_d4rt/test/sce155_dead_surface_removal_test.dart` fails the moment this
/// package's major version reaches 2 while the file is still here.
library;

import 'package:tom_d4rt/src/bridge/bridged_types.dart';
import 'package:tom_d4rt/src/bridge/registration.dart';
import 'package:tom_d4rt/src/callable.dart';
import 'package:tom_d4rt/src/d4rt_base.dart';
import 'package:tom_d4rt/src/exceptions.dart';

/// Bridges for a single source library.
///
/// doc-ref: ok — the `package:` URIs below name BRIDGED libraries, the
/// canonical URI a bridge registers under. They are runtime identities, not
/// files, and several deliberately name a library this package does not ship.
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
@Deprecated(
  'Superseded by generation-time deduplication in tom_d4rt_generator '
  '(PerPackageBridgeOrchestrator). Never wired up and never used by any '
  'consumer; scheduled for removal in tom_d4rt 2.0.0. See SCE155.',
)
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
      throw ArgumentD4rtException(
        'Cannot merge libraries with different URIs: $canonicalUri != ${other.canonicalUri}',
      );
    }

    // Check for duplicate names
    for (final name in other.classes.keys) {
      if (classes.containsKey(name)) {
        throw StateD4rtException(
          'Duplicate class "$name" in library $canonicalUri',
        );
      }
    }
    for (final name in other.functions.keys) {
      if (functions.containsKey(name)) {
        throw StateD4rtException(
          'Duplicate function "$name" in library $canonicalUri',
        );
      }
    }
    for (final name in other.variables.keys) {
      if (variables.containsKey(name)) {
        throw StateD4rtException(
          'Duplicate variable "$name" in library $canonicalUri',
        );
      }
    }
    for (final name in other.getters.keys) {
      if (getters.containsKey(name)) {
        throw StateD4rtException(
          'Duplicate getter "$name" in library $canonicalUri',
        );
      }
    }
    for (final name in other.enums.keys) {
      if (enums.containsKey(name)) {
        throw StateD4rtException(
          'Duplicate enum "$name" in library $canonicalUri',
        );
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

/// doc-ref: ok — the `package:` URIs in this example name BRIDGED libraries,
/// the canonical URIs a bridge registers under rather than files here.
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
@Deprecated(
  'Superseded by generation-time deduplication in tom_d4rt_generator '
  '(PerPackageBridgeOrchestrator). Never wired up and never used by any '
  'consumer; scheduled for removal in tom_d4rt 2.0.0. See SCE155.',
)
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
@Deprecated(
  'Superseded by generation-time deduplication in tom_d4rt_generator '
  '(PerPackageBridgeOrchestrator). Never wired up and never used by any '
  'consumer; scheduled for removal in tom_d4rt 2.0.0. See SCE155.',
)
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
