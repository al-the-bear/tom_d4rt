part of 'model.dart';

/// Represents a source file in the package.
class FileInfo {
  final String id;
  final String path;
  final PackageInfo package;
  final LibraryInfo? library;
  final bool isPart;
  final String? partOfDirective;
  final int lines;
  final String contentHash;
  final DateTime modified;

  const FileInfo({
    required this.id,
    required this.path,
    required this.package,
    required this.library,
    required this.isPart,
    this.partOfDirective,
    required this.lines,
    required this.contentHash,
    required this.modified,
  });
}
