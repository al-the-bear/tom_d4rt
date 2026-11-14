/// ghissues55: the names a generated file can write without a prefix.
library;

import 'public_import_targets.dart' show ExportNamespace;

/// The names a library that imports a set of libraries can name without an
/// import prefix: the union of the imported libraries' export namespaces, with
/// the names `dart:core` adds (an imported name hides `dart:core`'s, as in
/// Dart), minus the names two imported libraries export from different
/// declarations - those are ambiguous and Dart refuses them. A declaration
/// from a platform (`dart:`) library yields to a package library's, as Dart
/// resolves such a conflict, so only two package declarations (or two
/// platform declarations) of one name are ambiguous.
class ImportedNames {
  ImportedNames({
    required this.nameable,
    required this.ambiguous,
    this.unresolved = const [],
  });

  /// Every name the importing library can write unprefixed.
  final Set<String> nameable;

  /// Each ambiguous name with the imported libraries that export it, sorted.
  final Map<String, List<String>> ambiguous;

  /// Imports whose library did not resolve; their names are missing from
  /// [nameable], so a caller should not trust the set when this is not empty.
  final List<String> unresolved;

  /// The names the libraries of [importNamespaces] (import URI -> its export
  /// namespace, each name with its declaring library) make nameable, with
  /// [dartCore]'s names under them. A name exported by several imports from
  /// one declaring library (a re-export) is one declaration, not ambiguous.
  factory ImportedNames.compute(
    Map<String, ExportNamespace> importNamespaces, {
    ExportNamespace dartCore = const {},
    List<String> unresolved = const [],
  }) {
    final declaringLibraries = <String, Set<String>>{};
    final exportingImports = <String, Set<String>>{};
    for (final import in importNamespaces.entries) {
      for (final name in import.value.entries) {
        declaringLibraries.putIfAbsent(name.key, () => {}).add(name.value);
        exportingImports.putIfAbsent(name.key, () => {}).add(import.key);
      }
    }
    final nameable = <String>{};
    final ambiguous = <String, List<String>>{};
    for (final entry in declaringLibraries.entries) {
      // A declaration from a platform (`dart:`) library yields to one from a
      // package library, as in Dart: `TextStyle` from dart:ui and from
      // package:flutter/painting is flutter's, not ambiguous.
      final fromPackages = entry.value.where((d) => !d.startsWith('dart:'));
      final declarations = fromPackages.isEmpty
          ? entry.value
          : fromPackages.toSet();
      if (declarations.length == 1) {
        nameable.add(entry.key);
      } else {
        ambiguous[entry.key] = exportingImports[entry.key]!.toList()..sort();
      }
    }
    for (final name in dartCore.keys) {
      if (!declaringLibraries.containsKey(name)) nameable.add(name);
    }
    return ImportedNames(
      nameable: nameable,
      ambiguous: ambiguous,
      unresolved: unresolved,
    );
  }
}
