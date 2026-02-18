part of 'model.dart';

/// Represents an export directive between libraries.
class ExportInfo {
  final String id;
  final LibraryInfo exportingLibrary;
  final LibraryInfo exportedLibrary;
  final List<String>? show;
  final List<String>? hide;
  final String? documentation;

  const ExportInfo({
    required this.id,
    required this.exportingLibrary,
    required this.exportedLibrary,
    this.show,
    this.hide,
    this.documentation,
  });
}
