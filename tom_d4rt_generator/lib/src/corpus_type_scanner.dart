/// Corpus type-combination scanner (P&R step 5 / request b).
///
/// Statically scans a directory of D4rt test scripts for the concrete type
/// arguments that appear in generic instantiations — e.g. `Tween<double>`,
/// `ValueNotifier<int>`, `<String, List<Color>>{}`, `foo<Bar>()` — and emits
/// the de-duplicated set of those type-argument names.
///
/// The output feeds `BridgeConfig.additionalRelaxerTypes` (P&R step 4): once
/// `generateAllRelaxers` is flipped to `false`, the relaxer/RC-2 switch
/// families enumerate only the type-args the corpus actually exercises (plus
/// the ones discovered from real extraction sites), instead of every concrete
/// bridged class. Scanning is purely syntactic (`parseString`, no resolution),
/// so it is fast and tolerant of scripts that don't type-check in isolation.
library;

import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:path/path.dart' as p;

/// Type names that can appear syntactically as type arguments but are never
/// bridged class keys, so they would be inert in the reduced allowlist. They
/// are dropped to keep the emitted list focused.
const _nonBridgeableTypeArgs = <String>{'dynamic', 'void', 'Never'};

/// Aggregated result of a corpus scan.
class CorpusTypeScanResult {
  /// Type-argument name → number of occurrences across all scanned sources.
  ///
  /// Names are bare (no nullability `?`, no import prefix, no own type
  /// arguments — those are captured as their own entries). Sorted access is
  /// via [sortedTypeArguments].
  final Map<String, int> typeArgumentCounts;

  /// Number of source files successfully parsed and scanned.
  final int filesScanned;

  /// Paths that could not be read. Parsing itself never throws (recovery mode),
  /// so this only collects filesystem read failures.
  final List<String> readFailures;

  const CorpusTypeScanResult({
    required this.typeArgumentCounts,
    required this.filesScanned,
    this.readFailures = const [],
  });

  /// The distinct type-argument names, sorted (case-sensitive, ascending).
  List<String> get sortedTypeArguments =>
      typeArgumentCounts.keys.toList()..sort();

  /// Total distinct type-argument names found.
  int get distinctCount => typeArgumentCounts.length;
}

/// Scans D4rt scripts for the concrete type arguments used in generic
/// instantiations and emits an allowlist consumable by
/// [BridgeConfig.additionalRelaxerTypes].
class CorpusTypeScanner {
  /// File extensions scanned when walking a directory.
  final List<String> extensions;

  const CorpusTypeScanner({this.extensions = const ['.dart']});

  /// Scans a single Dart [source] string and returns the type-argument counts
  /// it contains. Parsing runs in recovery mode, so malformed scripts still
  /// yield whatever type arguments could be parsed.
  Map<String, int> scanSource(String source) {
    final result = parseString(content: source, throwIfDiagnostics: false);
    final visitor = _TypeArgumentCollector();
    result.unit.accept(visitor);
    return visitor.counts;
  }

  /// Recursively scans every file under [directoryPath] whose extension is in
  /// [extensions], aggregating the type-argument counts.
  ///
  /// Throws [ArgumentError] if the directory does not exist.
  CorpusTypeScanResult scanDirectory(String directoryPath) {
    final dir = Directory(directoryPath);
    if (!dir.existsSync()) {
      throw ArgumentError('Corpus directory not found: $directoryPath');
    }

    final counts = <String, int>{};
    final readFailures = <String>[];
    var filesScanned = 0;

    final entries = dir.listSync(recursive: true, followLinks: false)
      ..sort((a, b) => a.path.compareTo(b.path));

    for (final entity in entries) {
      if (entity is! File) continue;
      if (!extensions.contains(p.extension(entity.path))) continue;

      final String source;
      try {
        source = entity.readAsStringSync();
      } catch (_) {
        readFailures.add(entity.path);
        continue;
      }

      final fileCounts = scanSource(source);
      fileCounts.forEach((name, count) {
        counts[name] = (counts[name] ?? 0) + count;
      });
      filesScanned++;
    }

    return CorpusTypeScanResult(
      typeArgumentCounts: counts,
      filesScanned: filesScanned,
      readFailures: readFailures,
    );
  }

  /// Renders [result] as a YAML `additionalRelaxerTypes:` block ready to paste
  /// into a `buildkit.yaml` `d4rtgen:` section. Entries are sorted and
  /// de-duplicated. When [header] is non-null it is emitted as leading
  /// `#` comment lines.
  String toYamlAllowlist(CorpusTypeScanResult result, {String? header}) {
    final buffer = StringBuffer();
    if (header != null) {
      for (final line in header.split('\n')) {
        buffer.writeln('# $line');
      }
    }
    buffer.writeln('additionalRelaxerTypes:');
    for (final name in result.sortedTypeArguments) {
      buffer.writeln('  - $name');
    }
    return buffer.toString();
  }

  /// Renders [result] as a plain newline-separated list of type-argument names
  /// (sorted, de-duplicated) — convenient for diffing or piping.
  String toTextAllowlist(CorpusTypeScanResult result) =>
      '${result.sortedTypeArguments.join('\n')}\n';
}

/// Collects the bare names of every type appearing inside a [TypeArgumentList].
///
/// Visiting *all* `TypeArgumentList` nodes (including nested ones, via
/// `super`) means that for `Map<String, List<Color>>` the outer list yields
/// `String` and `List`, and the inner list yields `Color` — capturing every
/// type that is ever used as a type argument, at any nesting depth.
class _TypeArgumentCollector extends RecursiveAstVisitor<void> {
  final Map<String, int> counts = <String, int>{};

  @override
  void visitTypeArgumentList(TypeArgumentList node) {
    for (final arg in node.arguments) {
      if (arg is NamedType) {
        final name = arg.name2.lexeme;
        if (!_nonBridgeableTypeArgs.contains(name)) {
          counts[name] = (counts[name] ?? 0) + 1;
        }
      }
    }
    super.visitTypeArgumentList(node);
  }
}
