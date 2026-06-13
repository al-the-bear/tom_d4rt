/// Log-pipeline report.
///
/// The aggregated result plus its rendering. Separated from the stages so the
/// output format can evolve independently of the pipeline mechanics.
library;

import 'package:dcli/dcli.dart';

/// Immutable summary produced by `AggregateStage`.
class Report {
  const Report({
    required this.total,
    required this.countsByLevel,
    required this.firstSeen,
    required this.lastSeen,
  });

  final int total;
  final Map<String, int> countsByLevel;
  final DateTime? firstSeen;
  final DateTime? lastSeen;

  /// Plain-text rendering suitable for writing to a report file.
  String toPlainText() {
    final buffer = StringBuffer()
      ..writeln('# log pipeline report')
      ..writeln('total entries: $total')
      ..writeln('first seen   : ${firstSeen?.toIso8601String() ?? '-'}')
      ..writeln('last seen    : ${lastSeen?.toIso8601String() ?? '-'}')
      ..writeln('by level:');
    for (final level in _sortedLevels()) {
      buffer.writeln('  $level: ${countsByLevel[level]}');
    }
    return buffer.toString();
  }

  /// Coloured rendering for the console, with a small ASCII bar per level.
  void printColoured() {
    print(blue('Log pipeline report', bold: true));
    print(grey('total: $total entries', level: 0.6));
    if (total == 0) return;
    final max = countsByLevel.values.fold(0, (a, b) => a > b ? a : b);
    for (final level in _sortedLevels()) {
      final count = countsByLevel[level]!;
      final bar = '█' * ((count * 20 / max).ceil());
      print('  ${_colourForLevel(level)}  ${count.toString().padLeft(4)}  $bar');
    }
  }

  List<String> _sortedLevels() {
    final levels = countsByLevel.keys.toList();
    levels.sort((a, b) => countsByLevel[b]!.compareTo(countsByLevel[a]!));
    return levels;
  }

  String _colourForLevel(String level) {
    final label = level.padRight(5);
    switch (level) {
      case 'ERROR':
        return red(label, bold: true);
      case 'WARN':
        return yellow(label);
      case 'INFO':
        return green(label);
      default:
        return grey(label, level: 0.6);
    }
  }
}
