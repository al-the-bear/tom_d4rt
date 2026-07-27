import 'dart:io';

/// The process working directory, used to absolutize a relative permission
/// path before it is matched against an operation path.
///
/// Lives behind a conditional import (see `current_directory_web.dart`) so
/// `permissions.dart` — which every consumer pulls in — stays free of a hard
/// `dart:io` dependency. The twin file in `tom_d4rt_ast` must compile for web,
/// where that package puts all of `dart:io` behind `dart.library.html`.
String currentDirectoryPath() => Directory.current.path;

/// [path] with every symlink in it resolved, so two spellings of the same
/// location compare equal in the scope matcher.
///
/// Plain `resolveSymbolicLinksSync()` is not usable on its own here: it throws
/// for a path that does not exist, and permission checks routinely run BEFORE
/// the file does — a `writePath` grant is consulted to decide whether a file
/// may be created. So this walks up to the deepest ancestor that DOES exist,
/// resolves that, and re-appends the untraversed tail. The tail cannot contain
/// a symlink (it does not exist yet), which is what makes the shortcut sound.
///
/// That ancestor walk is not merely a convenience for the missing-file case:
/// it is what keeps a symlinked ANCESTOR from being missed. Resolving only
/// whole existing paths would let `<sandbox>/link_to_elsewhere/new.txt` pass a
/// `<sandbox>` grant purely because the leaf has not been created yet.
///
/// Falls back to [path] unchanged whenever resolution is impossible (a broken
/// link, a racing deletion, an unreadable directory). Returning the input keeps
/// the matcher total, and it is the safe direction: the caller then compares
/// the unresolved spellings, which is exactly the pre-DGUB5 behaviour.
String resolveRealPath(String path) {
  var probe = path;
  final tail = <String>[];

  while (probe.isNotEmpty) {
    if (FileSystemEntity.typeSync(probe) != FileSystemEntityType.notFound) {
      try {
        // `resolveSymbolicLinksSync` is declared on FileSystemEntity and calls
        // the platform realpath on the path string; it does not require the
        // entity to actually be a directory, so `Directory` is just the
        // cheapest concrete subclass to reach it through.
        final resolved = Directory(probe).resolveSymbolicLinksSync();
        if (tail.isEmpty) return resolved;
        return '$resolved/${tail.reversed.join('/')}';
      } on FileSystemException {
        return path;
      }
    }

    final separator = probe.lastIndexOf(RegExp(r'[/\\]'));
    // `<= 0` also stops at a leading separator, where the remaining prefix
    // would be the empty string rather than the root.
    if (separator <= 0) break;
    tail.add(probe.substring(separator + 1));
    probe = probe.substring(0, separator);
  }

  return path;
}
