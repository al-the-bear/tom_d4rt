part of 'model.dart';

/// Represents an import directive between libraries.
class ImportInfo {
  final String id;
  final LibraryInfo importingLibrary;
  final LibraryInfo importedLibrary;
  final String? prefix;
  final bool isDeferred;
  final List<String>? show;
  final List<String>? hide;
  final String? documentation;

  const ImportInfo({
    required this.id,
    required this.importingLibrary,
    required this.importedLibrary,
    this.prefix,
    this.isDeferred = false,
    this.show,
    this.hide,
    this.documentation,
  });
}
