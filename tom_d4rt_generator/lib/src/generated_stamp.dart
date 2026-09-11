/// The provenance line every file this generator writes carries: when it was
/// generated, and by which generator.
///
/// WHY THE VERSION IS HERE. "Which generator produced these committed
/// bridges?" used to be answerable only by reading each consumer's
/// `.dart_tool/package_config.json` — and that says which generator a
/// regeneration WOULD use today, not which one wrote the files. A sweep once
/// produced a baseline from three different generators without anything
/// showing it. With the version in the file, a grep of the committed tree
/// answers the question.
///
/// WHY ON THIS LINE. Every comparison of generated output — the freshness
/// gate, the example ratchet, the flutter corpus — ignores lines starting with
/// `// Generated:`, because the timestamp differs on every run. Putting the
/// version on the same line keeps it out of those comparisons: a new
/// generator release that produces the same code does not make every
/// consumer's bridges read as stale.
library;

import 'version.versioner.dart';

/// What every provenance line starts with.
const generatedStampPrefix = '// Generated:';

/// The provenance line for a file generated now (or at [at]) by this
/// generator (or by [generatorVersion], for tests).
String generatedStampLine({DateTime? at, String? generatorVersion}) =>
    '$generatedStampPrefix ${(at ?? DateTime.now()).toIso8601String()} '
    'by tom_d4rt_generator ${generatorVersion ?? D4rtGenVersionInfo.version}';

/// A provenance line read back from generated content.
class GeneratedStamp {
  /// Creates a stamp record.
  const GeneratedStamp({required this.generatedAt, this.generatorVersion});

  /// When the file was generated, or null when the line carries no parseable
  /// timestamp.
  final DateTime? generatedAt;

  /// The generator version that wrote the file, or null for files written
  /// before the version was recorded (tom_d4rt_generator < 1.20.0).
  final String? generatorVersion;
}

final _stampPattern = RegExp(
  r'^// Generated:\s*(\S+)(?:\s+by tom_d4rt_generator\s+(\S+))?\s*$',
);

/// The provenance line of generated [content], or null when it has none.
///
/// Only the head of the file is searched — the stamp is written in the first
/// few lines — so a `// Generated:` string inside generated code cannot be
/// mistaken for it.
GeneratedStamp? parseGeneratedStamp(String content) {
  for (final line in content.split('\n').take(20)) {
    final match = _stampPattern.firstMatch(line.trimRight());
    if (match == null) continue;
    return GeneratedStamp(
      generatedAt: DateTime.tryParse(match.group(1)!),
      generatorVersion: match.group(2),
    );
  }
  return null;
}
