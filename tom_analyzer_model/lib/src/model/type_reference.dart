part of 'model.dart';

/// Reference to a type with optional resolved declaration.
class TypeReference {
  final String id;
  final String name;
  final String qualifiedName;
  final List<TypeReference> typeArguments;
  final bool isNullable;
  final bool isDynamic;
  final bool isVoid;
  final bool isFunction;
  final FunctionTypeInfo? functionType;
  final LibraryInfo? definitionLibrary;
  final bool isTypeParameter;
  final TypeReference? typeParameterBound;
  final TypeParameterInfo? typeParameterInfo;
  final List<TypeReference>? supertypes;
  final TypeParameterVariance? variance;
  TypeDeclaration? _resolvedElement;

  TypeReference({
    required this.id,
    required this.name,
    required this.qualifiedName,
    this.typeArguments = const [],
    this.isNullable = false,
    this.isDynamic = false,
    this.isVoid = false,
    this.isFunction = false,
    this.functionType,
    this.definitionLibrary,
    this.isTypeParameter = false,
    this.typeParameterBound,
    this.typeParameterInfo,
    this.supertypes,
    this.variance,
    TypeDeclaration? resolvedElement,
  }) : _resolvedElement = resolvedElement;

  ClassInfo? resolveAsClass() {
    final element = _resolvedElement;
    return element is ClassInfo ? element : null;
  }

  EnumInfo? resolveAsEnum() {
    final element = _resolvedElement;
    return element is EnumInfo ? element : null;
  }

  MixinInfo? resolveAsMixin() {
    final element = _resolvedElement;
    return element is MixinInfo ? element : null;
  }

  TypeAliasInfo? resolveAsTypeAlias() {
    final element = _resolvedElement;
    return element is TypeAliasInfo ? element : null;
  }

  ExtensionTypeInfo? resolveAsExtensionType() {
    final element = _resolvedElement;
    return element is ExtensionTypeInfo ? element : null;
  }

  TypeDeclaration? resolveAsTypeDeclaration() {
    final element = _resolvedElement;
    return element is TypeDeclaration ? element : null;
  }

  T? resolveAs<T extends TypeDeclaration>() {
    final element = _resolvedElement;
    return element is T ? element : null;
  }

  bool get isResolved => _resolvedElement != null;

  TypeDeclaration? get resolvedElement => _resolvedElement;

  void setResolvedElement(TypeDeclaration? element) {
    _resolvedElement = element;
  }

  R? matchResolved<R>({
    required R Function(ClassInfo) onClass,
    required R Function(EnumInfo) onEnum,
    required R Function(MixinInfo) onMixin,
    required R Function(ExtensionInfo) onExtension,
    required R Function(TypeAliasInfo) onTypeAlias,
    required R Function(ExtensionTypeInfo) onExtensionType,
    required R Function() onUnresolved,
  }) {
    final element = _resolvedElement;
    if (element == null) return onUnresolved();

    return switch (element) {
      ClassInfo cls => onClass(cls),
      EnumInfo enm => onEnum(enm),
      MixinInfo mix => onMixin(mix),
      ExtensionInfo ext => onExtension(ext),
      TypeAliasInfo alias => onTypeAlias(alias),
      ExtensionTypeInfo ext => onExtensionType(ext),
    };
  }
}
