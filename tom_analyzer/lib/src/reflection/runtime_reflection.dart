typedef InstanceMethodInvoker = Object? Function(Object instance,
    List<dynamic> positional, Map<Symbol, dynamic> named);

typedef StaticMethodInvoker = Object? Function(
    List<dynamic> positional, Map<Symbol, dynamic> named);

typedef ConstructorInvoker = Object? Function(
    List<dynamic> positional, Map<Symbol, dynamic> named);

typedef InstanceGetter = Object? Function(Object instance);

typedef InstanceSetter = Object? Function(Object instance, Object? value);

typedef StaticGetter = Object? Function();

typedef StaticSetter = Object? Function(Object? value);

enum TypeKind {
  classType,
  enumType,
  mixinType,
  extensionType,
  extension,
  typeAlias,
}

enum GlobalKind {
  function,
  variable,
  getter,
  setter,
}

class AnnotationDescriptor {
  final String name;
  final String qualifiedName;
  final String? constructorName;
  final List<Object?> positionalArguments;
  final Map<String, Object?> namedArguments;

  const AnnotationDescriptor({
    required this.name,
    required this.qualifiedName,
    this.constructorName,
    this.positionalArguments = const [],
    this.namedArguments = const {},
  });
}

class TypeParameterDescriptor {
  final String name;
  final String? boundQualifiedName;
  final String? variance;

  const TypeParameterDescriptor({
    required this.name,
    this.boundQualifiedName,
    this.variance,
  });
}

class ParameterDescriptor {
  final String name;
  final String typeQualifiedName;
  final bool isRequired;
  final bool isNamed;
  final bool isPositional;
  final bool hasDefaultValue;
  final Object? defaultValue;
  final List<AnnotationDescriptor> annotations;

  const ParameterDescriptor({
    required this.name,
    required this.typeQualifiedName,
    required this.isRequired,
    required this.isNamed,
    required this.isPositional,
    required this.hasDefaultValue,
    this.defaultValue,
    this.annotations = const [],
  });
}

class MethodDescriptor {
  final String name;
  final bool isStatic;
  final bool isAbstract;
  final bool isOperator;
  final String? returnTypeQualifiedName;
  final String? declaringClassQualifiedName;
  final List<TypeParameterDescriptor> typeParameters;
  final List<ParameterDescriptor> parameters;
  final List<AnnotationDescriptor> annotations;
  final InstanceMethodInvoker? invokeOn;
  final StaticMethodInvoker? invokeStatic;

  const MethodDescriptor({
    required this.name,
    required this.isStatic,
    this.isAbstract = false,
    this.isOperator = false,
    this.returnTypeQualifiedName,
    this.declaringClassQualifiedName,
    this.typeParameters = const [],
    this.parameters = const [],
    this.annotations = const [],
    this.invokeOn,
    this.invokeStatic,
  });
}

class ConstructorDescriptor {
  final String name;
  final bool isFactory;
  final List<TypeParameterDescriptor> typeParameters;
  final List<ParameterDescriptor> parameters;
  final List<AnnotationDescriptor> annotations;
  /// The invoker for this constructor. Null for generative constructors of abstract classes.
  final ConstructorInvoker? invoke;

  const ConstructorDescriptor({
    required this.name,
    required this.isFactory,
    this.typeParameters = const [],
    this.parameters = const [],
    this.annotations = const [],
    this.invoke,
  });
}

class FieldDescriptor {
  final String name;
  final String typeQualifiedName;
  final bool isStatic;
  final bool isFinal;
  final bool isConst;
  final String? declaringClassQualifiedName;
  final List<AnnotationDescriptor> annotations;
  final InstanceGetter? getInstance;
  final InstanceSetter? setInstance;
  final StaticGetter? getStatic;
  final StaticSetter? setStatic;

  const FieldDescriptor({
    required this.name,
    required this.typeQualifiedName,
    required this.isStatic,
    required this.isFinal,
    required this.isConst,
    this.declaringClassQualifiedName,
    this.annotations = const [],
    this.getInstance,
    this.setInstance,
    this.getStatic,
    this.setStatic,
  });
}

class GetterDescriptor {
  final String name;
  final String typeQualifiedName;
  final bool isStatic;
  final bool isAbstract;
  final String? declaringClassQualifiedName;
  final List<AnnotationDescriptor> annotations;
  final InstanceGetter? getInstance;
  final StaticGetter? getStatic;

  const GetterDescriptor({
    required this.name,
    required this.typeQualifiedName,
    required this.isStatic,
    this.isAbstract = false,
    this.declaringClassQualifiedName,
    this.annotations = const [],
    this.getInstance,
    this.getStatic,
  });
}

class SetterDescriptor {
  final String name;
  final String typeQualifiedName;
  final bool isStatic;
  final bool isAbstract;
  final String? declaringClassQualifiedName;
  final List<AnnotationDescriptor> annotations;
  final InstanceSetter? setInstance;
  final StaticSetter? setStatic;

  const SetterDescriptor({
    required this.name,
    required this.typeQualifiedName,
    required this.isStatic,
    this.isAbstract = false,
    this.declaringClassQualifiedName,
    this.annotations = const [],
    this.setInstance,
    this.setStatic,
  });
}

class MemberContainerDescriptor {
  final TypeKind kind;
  final String name;
  final String qualifiedName;
  final String libraryUri;
  final String package;
  final List<AnnotationDescriptor> annotations;
  final List<TypeParameterDescriptor> typeParameters;
  final Map<String, MethodDescriptor> methods;
  final Map<String, MethodDescriptor> staticMethods;
  final Map<String, FieldDescriptor> fields;
  final Map<String, FieldDescriptor> staticFields;
  final Map<String, GetterDescriptor> getters;
  final Map<String, GetterDescriptor> staticGetters;
  final Map<String, SetterDescriptor> setters;
  final Map<String, SetterDescriptor> staticSetters;

  const MemberContainerDescriptor({
    required this.kind,
    required this.name,
    required this.qualifiedName,
    required this.libraryUri,
    required this.package,
    this.annotations = const [],
    this.typeParameters = const [],
    this.methods = const {},
    this.staticMethods = const {},
    this.fields = const {},
    this.staticFields = const {},
    this.getters = const {},
    this.staticGetters = const {},
    this.setters = const {},
    this.staticSetters = const {},
  });
}

class ClassDescriptor extends MemberContainerDescriptor {
  final bool isAbstract;
  final bool isSealed;
  final bool isFinal;
  final bool isBase;
  final bool isInterface;
  final bool isMixinClass;
  final String? superclassQualifiedName;
  final List<String> interfaceQualifiedNames;
  final List<String> mixinQualifiedNames;
  final List<String> appliedExtensionQualifiedNames;
  final Map<String, ConstructorDescriptor> constructors;
  final bool Function(Object instance) isInstance;

  const ClassDescriptor({
    required super.name,
    required super.qualifiedName,
    required super.libraryUri,
    required super.package,
    super.annotations,
    super.typeParameters,
    super.methods,
    super.staticMethods,
    super.fields,
    super.staticFields,
    super.getters,
    super.staticGetters,
    super.setters,
    super.staticSetters,
    this.isAbstract = false,
    this.isSealed = false,
    this.isFinal = false,
    this.isBase = false,
    this.isInterface = false,
    this.isMixinClass = false,
    required this.superclassQualifiedName,
    this.interfaceQualifiedNames = const [],
    this.mixinQualifiedNames = const [],
    this.appliedExtensionQualifiedNames = const [],
    this.constructors = const {},
    required this.isInstance,
  }) : super(kind: TypeKind.classType);

  Object? newInstance({
    String constructorName = '',
    List<dynamic> positional = const [],
    Map<Symbol, dynamic> named = const {},
  }) {
    final ctor = constructors[constructorName];
    if (ctor == null) {
      throw StateError('No constructor named $constructorName for $qualifiedName');
    }
    if (ctor.invoke == null) {
      throw StateError(
          'Cannot invoke generative constructor $constructorName of abstract class $qualifiedName');
    }
    return ctor.invoke!(positional, named);
  }

  Object? invoke(
    Object instance,
    String methodName, {
    List<dynamic> positional = const [],
    Map<Symbol, dynamic> named = const {},
  }) {
    final method = methods[methodName];
    if (method == null || method.invokeOn == null) {
      throw StateError('No instance method named $methodName for $qualifiedName');
    }
    return method.invokeOn!(instance, positional, named);
  }

  Object? invokeStatic(
    String methodName, {
    List<dynamic> positional = const [],
    Map<Symbol, dynamic> named = const {},
  }) {
    final method = staticMethods[methodName];
    if (method == null || method.invokeStatic == null) {
      throw StateError('No static method named $methodName for $qualifiedName');
    }
    return method.invokeStatic!(positional, named);
  }

  Object? getProperty(Object instance, String name) {
    final getter = getters[name];
    if (getter != null && getter.getInstance != null) {
      return getter.getInstance!(instance);
    }
    final field = fields[name];
    if (field != null && field.getInstance != null) {
      return field.getInstance!(instance);
    }
    throw StateError('No instance property named $name for $qualifiedName');
  }

  void setProperty(Object instance, String name, Object? value) {
    final setter = setters[name];
    if (setter != null && setter.setInstance != null) {
      setter.setInstance!(instance, value);
      return;
    }
    final field = fields[name];
    if (field != null && field.setInstance != null) {
      field.setInstance!(instance, value);
      return;
    }
    throw StateError('No instance property named $name for $qualifiedName');
  }

  Object? getStaticProperty(String name) {
    final getter = staticGetters[name];
    if (getter != null && getter.getStatic != null) {
      return getter.getStatic!();
    }
    final field = staticFields[name];
    if (field != null && field.getStatic != null) {
      return field.getStatic!();
    }
    throw StateError('No static property named $name for $qualifiedName');
  }

  void setStaticProperty(String name, Object? value) {
    final setter = staticSetters[name];
    if (setter != null && setter.setStatic != null) {
      setter.setStatic!(value);
      return;
    }
    final field = staticFields[name];
    if (field != null && field.setStatic != null) {
      field.setStatic!(value);
      return;
    }
    throw StateError('No static property named $name for $qualifiedName');
  }
}

class TypeAliasDescriptor {
  final String name;
  final String qualifiedName;
  final String libraryUri;
  final String package;
  final String aliasedTypeQualifiedName;
  final List<AnnotationDescriptor> annotations;
  final List<TypeParameterDescriptor> typeParameters;

  const TypeAliasDescriptor({
    required this.name,
    required this.qualifiedName,
    required this.libraryUri,
    required this.package,
    required this.aliasedTypeQualifiedName,
    this.annotations = const [],
    this.typeParameters = const [],
  });
}

class ExtensionDescriptor extends MemberContainerDescriptor {
  final String extendedTypeQualifiedName;

  const ExtensionDescriptor({
    required super.name,
    required super.qualifiedName,
    required super.libraryUri,
    required super.package,
    required this.extendedTypeQualifiedName,
    super.annotations,
    super.typeParameters,
    super.methods,
    super.staticMethods,
    super.fields,
    super.staticFields,
    super.getters,
    super.staticGetters,
    super.setters,
    super.staticSetters,
  }) : super(kind: TypeKind.extension);
}

class GlobalDescriptor {
  final GlobalKind kind;
  final String name;
  final String qualifiedName;
  final String libraryUri;
  final String package;
  final String typeQualifiedName;
  final List<AnnotationDescriptor> annotations;
  final StaticMethodInvoker? invokeFunction;
  final StaticGetter? getValue;
  final StaticSetter? setValue;

  const GlobalDescriptor({
    required this.kind,
    required this.name,
    required this.qualifiedName,
    required this.libraryUri,
    required this.package,
    required this.typeQualifiedName,
    this.annotations = const [],
    this.invokeFunction,
    this.getValue,
    this.setValue,
  });
}

class ReflectionApi {
  final Map<String, ClassDescriptor> classesByQualifiedName;
  final Map<String, MemberContainerDescriptor> enumsByQualifiedName;
  final Map<String, MemberContainerDescriptor> mixinsByQualifiedName;
  final Map<String, ExtensionDescriptor> extensionsByQualifiedName;
  final Map<String, MemberContainerDescriptor> extensionTypesByQualifiedName;
  final Map<String, TypeAliasDescriptor> typeAliasesByQualifiedName;
  final Map<String, GlobalDescriptor> globalsByQualifiedName;

  ReflectionApi({
    required this.classesByQualifiedName,
    required this.enumsByQualifiedName,
    required this.mixinsByQualifiedName,
    required this.extensionsByQualifiedName,
    required this.extensionTypesByQualifiedName,
    required this.typeAliasesByQualifiedName,
    required this.globalsByQualifiedName,
  });

  List<ClassDescriptor> get allClasses => classesByQualifiedName.values.toList();
  List<MemberContainerDescriptor> get allEnums => enumsByQualifiedName.values.toList();
  List<MemberContainerDescriptor> get allMixins => mixinsByQualifiedName.values.toList();
  List<ExtensionDescriptor> get allExtensions => extensionsByQualifiedName.values.toList();
  List<MemberContainerDescriptor> get allExtensionTypes =>
      extensionTypesByQualifiedName.values.toList();
  List<TypeAliasDescriptor> get allTypeAliases => typeAliasesByQualifiedName.values.toList();
  List<GlobalDescriptor> get allGlobals => globalsByQualifiedName.values.toList();

  ClassDescriptor? findClass(String name) => _findByName(classesByQualifiedName, name);

  ClassDescriptor? findClassByQualifiedName(String qualifiedName) =>
      classesByQualifiedName[qualifiedName];

  GlobalDescriptor? findGlobal(String name) => _findByName(globalsByQualifiedName, name);

  GlobalDescriptor? findGlobalByQualifiedName(String qualifiedName) =>
      globalsByQualifiedName[qualifiedName];

  List<ClassDescriptor> getClassesByPackage(String package) =>
      classesByQualifiedName.values.where((c) => c.package == package).toList();

  List<MemberContainerDescriptor> getEnumsByPackage(String package) =>
      enumsByQualifiedName.values.where((c) => c.package == package).toList();

  List<MemberContainerDescriptor> getMixinsByPackage(String package) =>
      mixinsByQualifiedName.values.where((c) => c.package == package).toList();

  List<ExtensionDescriptor> getExtensionsByPackage(String package) =>
      extensionsByQualifiedName.values.where((c) => c.package == package).toList();

  List<MemberContainerDescriptor> getExtensionTypesByPackage(String package) =>
      extensionTypesByQualifiedName.values
          .where((c) => c.package == package)
          .toList();

  List<TypeAliasDescriptor> getTypeAliasesByPackage(String package) =>
      typeAliasesByQualifiedName.values.where((c) => c.package == package).toList();

  List<GlobalDescriptor> getGlobalsByPackage(String package) =>
      globalsByQualifiedName.values.where((g) => g.package == package).toList();

  bool isInstanceOf(Object instance, String classQualifiedName) {
    final cls = classesByQualifiedName[classQualifiedName];
    if (cls == null) return false;
    return cls.isInstance(instance);
  }

  bool isSubclassOf(String classQualifiedName, String otherQualifiedName) {
    var current = classesByQualifiedName[classQualifiedName];
    while (current != null && current.superclassQualifiedName != null) {
      final superclass = current.superclassQualifiedName!;
      if (superclass == otherQualifiedName) {
        return true;
      }
      current = classesByQualifiedName[superclass];
    }
    return false;
  }

  bool implementsInterface(String classQualifiedName, String interfaceQualifiedName) {
    var current = classesByQualifiedName[classQualifiedName];
    while (current != null) {
      if (current.interfaceQualifiedNames.contains(interfaceQualifiedName)) {
        return true;
      }
      final superclass = current.superclassQualifiedName;
      if (superclass == null) {
        break;
      }
      current = classesByQualifiedName[superclass];
    }
    return false;
  }

  bool hasMixin(String classQualifiedName, String mixinQualifiedName) {
    var current = classesByQualifiedName[classQualifiedName];
    while (current != null) {
      if (current.mixinQualifiedNames.contains(mixinQualifiedName)) {
        return true;
      }
      final superclass = current.superclassQualifiedName;
      if (superclass == null) {
        break;
      }
      current = classesByQualifiedName[superclass];
    }
    return false;
  }

  List<Object?> createList(String typeQualifiedName, int length, {Object? fill}) {
    return List<Object?>.filled(length, fill);
  }

  T? _findByName<T extends Object>(Map<String, T> map, String name) {
    if (map.containsKey(name)) {
      return map[name];
    }
    final matches = map.values
        .where((value) => (value as dynamic).name == name)
        .toList();
    if (matches.isEmpty) return null;
    if (matches.length > 1) {
      throw StateError('Multiple matches found for name "$name"');
    }
    return matches.first;
  }
}
