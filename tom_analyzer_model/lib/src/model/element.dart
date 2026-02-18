part of 'model.dart';

/// Base type for all analyzed model elements.
sealed class Element {
  String get id;
  String get name;
  String? get documentation;
  List<AnnotationInfo> get annotations;
  bool get isDeprecated;

  bool hasAnnotation(String annotationName) {
    return annotations.any((annotation) => annotation.name == annotationName);
  }
}

/// Base type for elements that aggregate other elements.
sealed class ContainerElement extends Element {
  ContainerElement();
}

/// Base type for declarations with source locations.
sealed class DeclarationElement extends Element {
  String get qualifiedName;
  LibraryInfo get library;
  FileInfo get sourceFile;
  SourceLocation get location;
}

/// Base type for class, enum, mixin, and type alias declarations.
sealed class TypeDeclaration extends DeclarationElement {
  @override
  LibraryInfo get library;
}

/// Base type for callable declarations like functions and methods.
sealed class ExecutableElement extends DeclarationElement {
  bool get isAsync;
  bool get isExternal;
  bool get isStatic;
  List<ParameterInfo> get parameters;
}

/// Base type for variable and field declarations.
sealed class VariableElement extends DeclarationElement {
  TypeReference get type;
  bool get isFinal;
  bool get isConst;
  bool get isLate;
  bool get isStatic;
}
