// file_toolkit — pure dcli filesystem operations.
//
// Creates a scratch directory, writes a few files, finds them, reads one back,
// and cleans up. Every call here is a bridged dcli function running natively.

import 'package:dcli/dcli.dart';

void main(List<String> args) {
  const dir = 'scratch';

  // Start clean.
  if (exists(dir)) deleteDir(dir);
  createDir(dir, recursive: true);
  print('Created $dir/');

  // Write three notes.
  for (var i = 1; i <= 3; i++) {
    final path = '$dir/note_$i.txt';
    path.write('This is note $i.');
    print('  wrote $path');
  }

  // Find them with a glob.
  final found = find('*.txt', workingDirectory: dir, recursive: false).toList();
  print('\nfind("*.txt") matched ${found.length} file(s):');
  for (final path in found) {
    print('  $path');
  }

  // Read one back. `read(path).toParagraph()` returns the file as one string.
  final first = '$dir/note_1.txt';
  print('\nContents of $first:');
  print('  ${read(first).toParagraph().trim()}');

  // Clean up.
  deleteDir(dir);
  print('\nRemoved $dir/ (exists now: ${exists(dir)})');
}
