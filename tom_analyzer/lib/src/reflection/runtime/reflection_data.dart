/// Data structures for generated reflection code.
///
/// These classes are used by the code generator to build compact,
/// index-based reflection data that gets compiled into `.r.dart` files.
library;

/// Package metadata for reflection data.
///
/// Contains the package name and indices of libraries in this package.
class PackageData {
  /// Package name (e.g., 'my_app', 'flutter').
  final String name;

  /// Indices of libraries belonging to this package.
  final List<int> libraryIndices;

  const PackageData(this.name, this.libraryIndices);
}

/// Library metadata for reflection data.
///
/// Contains the library URI and indices of types/declarations.
class LibraryData {
  /// Full library URI (e.g., 'package:my_app/models/user.dart').
  final String uri;

  /// Index of the package containing this library.
  final int packageIndex;

  /// Indices of types declared in this library.
  final List<int> typeIndices;

  /// Indices of declarations in this library.
  final List<int> declarationIndices;

  const LibraryData(
    this.uri,
    this.packageIndex,
    this.typeIndices,
    this.declarationIndices,
  );
}

/// Base class for type mirror data.
///
/// Subclasses provide type-specific data for classes, enums, mixins, etc.
abstract class TypeMirrorData {
  /// Simple name of the type.
  String get name;

  /// Bit flags encoding type properties.
  int get flags;

  /// Library index where this type is declared.
  int get libraryIndex;

  const TypeMirrorData();
}

/// Class mirror data for generated reflection.
class ClassMirrorData<T> extends TypeMirrorData {
  @override
  final String name;

  @override
  final int flags;

  @override
  final int libraryIndex;

  /// Indices of declarations owned by this class.
  final List<int> ownDeclarationIndices;

  /// Indices of all instance members (inherited + own).
  final List<int> allInstanceMemberIndices;

  /// Indices of static member declarations.
  final List<int> staticMemberIndices;

  /// Type index of superclass (-1 if Object).
  final int superclassIndex;

  /// Type indices of implemented interfaces.
  final List<int> interfaceIndices;

  /// Type indices of applied mixins.
  final List<int> mixinIndices;

  /// Indices of extensions that apply to this class.
  final List<int> extensionIndices;

  /// Indices of annotations on this class.
  final List<int> annotationIndices;

  /// Invoker indices for constructors.
  final List<int> constructorInvokerIndices;

  const ClassMirrorData(
    this.name,
    this.flags,
    this.libraryIndex,
    this.ownDeclarationIndices,
    this.allInstanceMemberIndices,
    this.staticMemberIndices,
    this.superclassIndex,
    this.interfaceIndices,
    this.mixinIndices,
    this.extensionIndices,
    this.annotationIndices,
    this.constructorInvokerIndices,
  );
}

/// Enum mirror data for generated reflection.
class EnumMirrorData<T> extends TypeMirrorData {
  @override
  final String name;

  @override
  final int flags;

  @override
  final int libraryIndex;

  /// Names of enum values.
  final List<String> valueNames;

  /// Indices of annotations on this enum.
  final List<int> annotationIndices;

  const EnumMirrorData(
    this.name,
    this.flags,
    this.libraryIndex,
    this.valueNames,
    this.annotationIndices,
  );
}

/// Mixin mirror data for generated reflection.
class MixinMirrorData<T> extends TypeMirrorData {
  @override
  final String name;

  @override
  final int flags;

  @override
  final int libraryIndex;

  /// Type indices of superclass constraints.
  final List<int> superclassConstraintIndices;

  /// Indices of declarations in this mixin.
  final List<int> declarationIndices;

  /// Indices of annotations on this mixin.
  final List<int> annotationIndices;

  const MixinMirrorData(
    this.name,
    this.flags,
    this.libraryIndex,
    this.superclassConstraintIndices,
    this.declarationIndices,
    this.annotationIndices,
  );
}

/// Extension type mirror data for generated reflection.
class ExtensionTypeMirrorData<T> extends TypeMirrorData {
  @override
  final String name;

  @override
  final int flags;

  @override
  final int libraryIndex;

  /// Type index of the representation type.
  final int representationTypeIndex;

  /// Indices of declarations in this extension type.
  final List<int> declarationIndices;

  /// Indices of annotations on this extension type.
  final List<int> annotationIndices;

  const ExtensionTypeMirrorData(
    this.name,
    this.flags,
    this.libraryIndex,
    this.representationTypeIndex,
    this.declarationIndices,
    this.annotationIndices,
  );
}

/// Base class for declaration mirror data.
abstract class DeclarationMirrorData {
  /// Name of the declaration.
  String get name;

  /// Bit flags encoding declaration properties.
  int get flags;

  /// Type index of the owner (class, mixin, etc.).
  int get ownerIndex;

  const DeclarationMirrorData();
}

/// Field mirror data for generated reflection.
class FieldMirrorData extends DeclarationMirrorData {
  @override
  final String name;

  @override
  final int flags;

  @override
  final int ownerIndex;

  /// Type reference index for the field type.
  final int typeRefIndex;

  /// Invoker index for getter (-1 if none).
  final int getterInvokerIndex;

  /// Invoker index for setter (-1 if read-only).
  final int setterInvokerIndex;

  /// Indices of annotations on this field.
  final List<int> annotationIndices;

  const FieldMirrorData(
    this.name,
    this.flags,
    this.ownerIndex,
    this.typeRefIndex,
    this.getterInvokerIndex,
    this.setterInvokerIndex,
    this.annotationIndices,
  );
}

/// Method mirror data for generated reflection.
class MethodMirrorData extends DeclarationMirrorData {
  @override
  final String name;

  @override
  final int flags;

  @override
  final int ownerIndex;

  /// Type reference index for return type (-1 for void).
  final int returnTypeRefIndex;

  /// Invoker index (-1 if not covered).
  final int invokerIndex;

  /// Indices of parameters.
  final List<int> parameterIndices;

  /// Indices of type parameters.
  final List<int> typeParameterIndices;

  /// Indices of annotations on this method.
  final List<int> annotationIndices;

  const MethodMirrorData(
    this.name,
    this.flags,
    this.ownerIndex,
    this.returnTypeRefIndex,
    this.invokerIndex,
    this.parameterIndices,
    this.typeParameterIndices,
    this.annotationIndices,
  );
}

/// Constructor mirror data for generated reflection.
class ConstructorMirrorData extends DeclarationMirrorData {
  @override
  final String name;

  @override
  final int flags;

  @override
  final int ownerIndex;

  /// Invoker index (-1 if not covered).
  final int invokerIndex;

  /// Indices of parameters.
  final List<int> parameterIndices;

  /// Indices of type parameters.
  final List<int> typeParameterIndices;

  /// Indices of annotations on this constructor.
  final List<int> annotationIndices;

  const ConstructorMirrorData(
    this.name,
    this.flags,
    this.ownerIndex,
    this.invokerIndex,
    this.parameterIndices,
    this.typeParameterIndices,
    this.annotationIndices,
  );
}

/// Getter mirror data for generated reflection.
class GetterMirrorData extends DeclarationMirrorData {
  @override
  final String name;

  @override
  final int flags;

  @override
  final int ownerIndex;

  /// Type reference index for return type.
  final int returnTypeRefIndex;

  /// Invoker index (-1 if not covered).
  final int invokerIndex;

  /// Indices of annotations on this getter.
  final List<int> annotationIndices;

  const GetterMirrorData(
    this.name,
    this.flags,
    this.ownerIndex,
    this.returnTypeRefIndex,
    this.invokerIndex,
    this.annotationIndices,
  );
}

/// Setter mirror data for generated reflection.
class SetterMirrorData extends DeclarationMirrorData {
  @override
  final String name;

  @override
  final int flags;

  @override
  final int ownerIndex;

  /// Type reference index for parameter type.
  final int parameterTypeRefIndex;

  /// Invoker index (-1 if not covered).
  final int invokerIndex;

  /// Indices of annotations on this setter.
  final List<int> annotationIndices;

  const SetterMirrorData(
    this.name,
    this.flags,
    this.ownerIndex,
    this.parameterTypeRefIndex,
    this.invokerIndex,
    this.annotationIndices,
  );
}

/// Parameter mirror data for generated reflection.
class ParameterMirrorData {
  /// Name of the parameter.
  final String name;

  /// Bit flags encoding parameter properties.
  final int flags;

  /// Index of the owning method/constructor.
  final int ownerIndex;

  /// Type reference index for parameter type.
  final int typeRefIndex;

  /// Default value (if any).
  final Object? defaultValue;

  const ParameterMirrorData(
    this.name,
    this.flags,
    this.ownerIndex,
    this.typeRefIndex,
    this.defaultValue,
  );
}

/// Annotation mirror data for generated reflection.
class AnnotationMirrorData {
  /// Qualified name of the annotation type.
  final String qualifiedName;

  /// Named arguments to the annotation constructor.
  final Map<String, Object?> namedArguments;

  /// Positional arguments to the annotation constructor.
  final List<Object?> positionalArguments;

  const AnnotationMirrorData(
    this.qualifiedName,
    this.namedArguments,
    this.positionalArguments,
  );
}

/// Complete reflection data structure.
///
/// This is the top-level container for all reflection data generated
/// for an entry point.
class ReflectionData {
  /// Package metadata.
  final List<PackageData> packages;

  /// Library metadata.
  final List<LibraryData> libraries;

  /// Invoker closures.
  final List<Function> invokers;

  /// Type mirror data.
  final List<TypeMirrorData> types;

  /// Declaration mirror data.
  final List<DeclarationMirrorData> declarations;

  /// Parameter mirror data.
  final List<ParameterMirrorData> parameters;

  /// Type references (runtime Type objects).
  final List<Type> typeRefs;

  /// Annotation data.
  final List<AnnotationMirrorData> annotations;

  const ReflectionData({
    this.packages = const [],
    this.libraries = const [],
    this.invokers = const [],
    this.types = const [],
    this.declarations = const [],
    this.parameters = const [],
    this.typeRefs = const [],
    this.annotations = const [],
  });
}

/// Global reflection data registry.
///
/// Stores registered reflection data for runtime access.
final _registeredData = <ReflectionData>[];

/// Register reflection data for runtime access.
void registerReflectionData(ReflectionData data) {
  _registeredData.add(data);
}

/// Get all registered reflection data.
List<ReflectionData> get registeredReflectionData =>
    List.unmodifiable(_registeredData);
