import 'package:analyzer/dart/element/element.dart';
import 'package:tom_analyzer_model/tom_analyzer_model.dart';

/// Parses analyzer annotations into model representations.
class AnnotationParser {
  List<AnnotationInfo> parseAll(Iterable<ElementAnnotation> annotations) {
    return annotations.map(_parse).toList();
  }

  bool hasDeprecated(Iterable<ElementAnnotation> annotations) {
    for (final annotation in annotations) {
      final info = _parse(annotation);
      if (_isDeprecated(info)) {
        return true;
      }
    }
    return false;
  }

  AnnotationInfo _parse(ElementAnnotation annotation) {
    final element = annotation.element;
    final name = element?.displayName ?? annotation.toSource();
    // In analyzer 8.x, source is on the fragment, not the element
    final libraryUri = element?.library?.firstFragment.source.uri.toString();
    final qualifiedName = libraryUri == null ? name : '$libraryUri.$name';

    return AnnotationInfo(
      name: name,
      qualifiedName: qualifiedName,
    );
  }

  bool _isDeprecated(AnnotationInfo info) {
    final rawName = info.name.trim().toLowerCase();
    final normalizedName = rawName.startsWith('@') ? rawName.substring(1) : rawName;
    final baseName = normalizedName.split('(').first;
    if (baseName == 'deprecated') {
      return true;
    }
    final qualified = info.qualifiedName.toLowerCase();
    return qualified == 'deprecated' || qualified.endsWith('.deprecated');
  }
}
