/// Path shaping for the analyzer's `includedPaths` contract.
///
/// `AnalysisContextCollection` and `AnalysisContextCollectionImpl` reject any
/// `includedPaths` entry that is not both absolute and normalized, with
/// `Invalid argument(s): Only absolute normalized paths are supported: <path>`.
/// The generator builds analyzer contexts from five places, and the rule has
/// two independent halves that are easy to satisfy by accident on one platform
/// and miss on another — so it is stated once, here.
library;

import 'dart:io';

import 'package:path/path.dart' as p;

/// Shapes [path] into something `AnalysisContextCollection*.includedPaths`
/// accepts: absolute, and normalized for the host path context.
///
/// Both halves are load-bearing:
///
/// * **Absolute** — d4rtgen is normally invoked as `d4rtgen -s .`, so project
///   directories arrive relative. `p.normalize` alone leaves them relative and
///   the analyzer throws. A relative path is resolved against
///   [Directory.current].
/// * **Normalized** — on Windows an already-absolute forward-slash path such
///   as `C:/Code/x` is *not* normalized in the host context, so it is rejected
///   even though it is absolute. Normalization also collapses any `..`
///   segments introduced by joining.
String analysisIncludedPath(String path) => p.normalize(
  p.isAbsolute(path) ? path : p.join(Directory.current.path, path),
);
