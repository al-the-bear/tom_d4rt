#!/usr/bin/env dart
// ignore_for_file: avoid_print

/// Script to extract all test IDs, deduplicate them with suffixes,
/// and replace them in the source files.
///
/// Usage: dart tool/deduplicate_test_ids.dart [--dry-run]
///
/// Output: doc/test_ids.csv with columns:
///   old_id, new_id, file, line, description

import 'dart:io';

/// Represents a test ID found in a file
class TestIdEntry {
  final String oldId;
  String newId;
  final String file;
  final int line;
  final String description;
  final String fullLine;

  TestIdEntry({
    required this.oldId,
    required this.file,
    required this.line,
    required this.description,
    required this.fullLine,
  }) : newId = oldId;

  @override
  String toString() => '$oldId -> $newId in $file:$line';
}

void main(List<String> args) {
  final dryRun = args.contains('--dry-run');

  if (dryRun) {
    print('🔍 DRY RUN - no files will be modified\n');
  }

  final testDir = Directory('test');
  if (!testDir.existsSync()) {
    print('Error: test/ directory not found');
    exit(1);
  }

  // Pattern to match test IDs like G-GB-1:, G-CLS-6:, etc.
  final idPattern = RegExp(r"'(G-[A-Z]+-\d+):\s*([^']+)'");

  final entries = <TestIdEntry>[];

  // Scan all test files
  for (final file in testDir.listSync().whereType<File>()) {
    if (!file.path.endsWith('_test.dart')) continue;

    final lines = file.readAsLinesSync();
    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      final match = idPattern.firstMatch(line);
      if (match != null) {
        final id = match.group(1)!;
        final description = match.group(2)!.trim();
        entries.add(
          TestIdEntry(
            oldId: id,
            file: file.path,
            line: i + 1, // 1-indexed
            description: description,
            fullLine: line,
          ),
        );
      }
    }
  }

  print('Found ${entries.length} test IDs\n');

  // Sort by ID (natural sort: G-GB-1, G-GB-2, ..., G-GB-10, G-GB-11)
  entries.sort((a, b) {
    final prefixA = a.oldId.replaceAll(RegExp(r'\d+$'), '');
    final prefixB = b.oldId.replaceAll(RegExp(r'\d+$'), '');
    final numA = int.parse(a.oldId.replaceAll(RegExp(r'^[A-Z]+-[A-Z]+-'), ''));
    final numB = int.parse(b.oldId.replaceAll(RegExp(r'^[A-Z]+-[A-Z]+-'), ''));

    final prefixCompare = prefixA.compareTo(prefixB);
    if (prefixCompare != 0) return prefixCompare;
    return numA.compareTo(numB);
  });

  // Find duplicates and assign suffixes
  final idCounts = <String, int>{};
  final idOccurrence = <String, int>{};

  // First pass: count occurrences
  for (final entry in entries) {
    idCounts[entry.oldId] = (idCounts[entry.oldId] ?? 0) + 1;
  }

  // Second pass: assign new IDs with suffixes for duplicates
  for (final entry in entries) {
    final count = idCounts[entry.oldId]!;
    if (count > 1) {
      final occurrence = idOccurrence[entry.oldId] ?? 0;
      final suffix = String.fromCharCode('a'.codeUnitAt(0) + occurrence);
      entry.newId = '${entry.oldId}$suffix';
      idOccurrence[entry.oldId] = occurrence + 1;
    }
    // else: newId remains same as oldId
  }

  // Count changes needed
  final duplicateCount = entries.where((e) => e.oldId != e.newId).length;
  print('Duplicate IDs to rename: $duplicateCount\n');

  // Write CSV
  final csvFile = File('doc/test_ids.csv');
  final csvBuffer = StringBuffer();
  csvBuffer.writeln('old_id,new_id,file,line,description');

  for (final entry in entries) {
    // Escape description for CSV (double quotes)
    final escapedDesc = entry.description.replaceAll('"', '""');
    csvBuffer.writeln(
      '${entry.oldId},${entry.newId},${entry.file},${entry.line},"$escapedDesc"',
    );
  }

  if (!dryRun) {
    csvFile.writeAsStringSync(csvBuffer.toString());
    print('✅ Wrote ${entries.length} entries to doc/test_ids.csv\n');
  } else {
    print('Would write ${entries.length} entries to doc/test_ids.csv\n');
  }

  // Group entries by file for efficient replacement
  final entriesByFile = <String, List<TestIdEntry>>{};
  for (final entry in entries) {
    entriesByFile.putIfAbsent(entry.file, () => []).add(entry);
  }

  // Replace IDs in source files
  var filesModified = 0;
  var replacementsMade = 0;

  for (final filePath in entriesByFile.keys) {
    final file = File(filePath);
    final lines = file.readAsLinesSync();
    var modified = false;

    // Sort entries by line number (descending not needed since we're doing in-place)
    final fileEntries = entriesByFile[filePath]!;

    for (final entry in fileEntries) {
      final lineIndex = entry.line - 1;
      if (lineIndex >= 0 && lineIndex < lines.length) {
        final oldLine = lines[lineIndex];
        // Replace the ID in the line (with colon to be precise)
        final newLine = oldLine.replaceFirst(
          '${entry.oldId}:',
          '${entry.newId}:',
        );

        if (oldLine != newLine) {
          lines[lineIndex] = newLine;
          modified = true;
          replacementsMade++;
          if (dryRun) {
            print('Would replace in ${entry.file}:${entry.line}:');
            print('  - ${entry.oldId}:');
            print('  + ${entry.newId}:');
          }
        }
      }
    }

    if (modified) {
      if (!dryRun) {
        file.writeAsStringSync('${lines.join('\n')}\n');
      }
      filesModified++;
    }
  }

  print('\n📊 Summary:');
  print('   Test IDs found: ${entries.length}');
  print('   Duplicate IDs:  ${duplicateCount ~/ 2} (each appearing 2+ times)');
  print('   Files ${dryRun ? "would be " : ""}modified: $filesModified');
  print('   Replacements ${dryRun ? "would be " : ""}made: $replacementsMade');

  if (!dryRun) {
    print('\n✅ Done! Run testkit :baseline to create a fresh baseline.');
  }
}
