/// Which public library a generated bridge imports a `src` library through.
///
/// A bridge refers to every type through the prefix of the library that
/// declares it, and those are mostly a package's `lib/src/` files. Importing
/// them directly pins the bridge to the package's internal file layout: when
/// Flutter 3.47 removed `package:flutter/src/widgets/visibility.dart`, every
/// published Flutter bridge stopped compiling (GitHub al-the-bear/tom_d4rt#5).
/// The public libraries of a package (`package:flutter/widgets.dart`, ...) are
/// its stable surface. [choosePublicImportTargets] names, for each `src`
/// library, a public library that can stand in for it under the same prefix.
library;

/// The names a library's export namespace defines, each with the URI of the
/// library that declares it (setters carry their `=`).
typedef ExportNamespace = Map<String, String>;

/// For each `src` library in [srcNamespaces], the public library of
/// [publicNamespaces] to import it through, when one can stand in for it.
///
/// A public library B stands in for a `src` library L when B's export
/// namespace binds every name L's namespace defines to the same declaration:
/// then `import B as $p` and `import L as $p` resolve every `$p.Name` a bridge
/// writes for L identically, whatever else B exports. Among the libraries that
/// qualify the one exporting the fewest names is taken (the narrowest surface,
/// e.g. `widgets.dart` rather than `material.dart` for a widgets file), ties by
/// URI. A `src` library no public library covers — a type only reachable
/// through `src`, or one a public library hides — keeps its own import, and so
/// does a library whose namespace is empty.
Map<String, String> choosePublicImportTargets({
  required Map<String, ExportNamespace> publicNamespaces,
  required Map<String, ExportNamespace> srcNamespaces,
}) {
  final candidates = publicNamespaces.keys.toList()
    ..sort((a, b) {
      final bySize = publicNamespaces[a]!.length.compareTo(
        publicNamespaces[b]!.length,
      );
      return bySize != 0 ? bySize : a.compareTo(b);
    });
  final targets = <String, String>{};
  for (final entry in srcNamespaces.entries) {
    final names = entry.value;
    if (names.isEmpty) continue;
    for (final candidate in candidates) {
      final surface = publicNamespaces[candidate]!;
      if (names.entries.every((n) => surface[n.key] == n.value)) {
        targets[entry.key] = candidate;
        break;
      }
    }
  }
  return targets;
}
