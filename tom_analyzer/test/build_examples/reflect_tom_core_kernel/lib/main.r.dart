// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
import 'package:tom_analyzer/tom_analyzer.dart' as ta;
import 'package:reflect_tom_core_kernel/main.dart' as lib0;
import 'package:tom_basics/tom_basics.dart' as lib1;
import 'package:tom_core_kernel/tom_core_kernel.dart' as lib2;
import 'package:tom_crypto/tom_crypto.dart' as lib3;
import 'package:tom_reflection/generated.dart' as lib4;
import 'package:tom_reflection/tom_reflection.dart' as lib5;

final _classes = <String, ta.ClassDescriptor>{
'package:tom_reflection/tom_reflection.dart.Reflection': ta.ClassDescriptor(
  name: 'Reflection',
  qualifiedName: 'package:tom_reflection/tom_reflection.dart.Reflection',
  libraryUri: 'package:tom_reflection/tom_reflection.dart',
  package: 'tom_reflection',
  annotations: const [],
  typeParameters: const [],
  isAbstract: true,
  isSealed: false,
  isFinal: false,
  isBase: false,
  isInterface: false,
  isMixinClass: false,
  methods: <String, ta.MethodDescriptor>{
  'canReflect': ta.MethodDescriptor(
    name: 'canReflect',
    isStatic: false,
    isAbstract: false,
    isOperator: false,
    returnTypeQualifiedName: 'dart:core.bool',
    declaringClassQualifiedName: 'package:tom_reflection/src/reflection/reflection_builder_based.dart.ReflectionImpl',
    typeParameters: const [],
    parameters: [
ta.ParameterDescriptor(name: 'reflectee',typeQualifiedName: 'dart:core.Object',isRequired: true,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],)
],
    annotations: [
ta.AnnotationDescriptor(name: 'override',qualifiedName: 'dart:core.override',positionalArguments: <Object?>[],namedArguments: const <String, Object?>{},)
],
    invokeOn: (Object instance, List<dynamic> positional, Map<Symbol, dynamic> named) => Function.apply((instance as lib5.Reflection).canReflect, positional, named),
    invokeStatic: null,
  ),
  'reflect': ta.MethodDescriptor(
    name: 'reflect',
    isStatic: false,
    isAbstract: false,
    isOperator: false,
    returnTypeQualifiedName: 'package:tom_reflection/src/reflection/mirrors.dart.InstanceMirror',
    declaringClassQualifiedName: 'package:tom_reflection/src/reflection/reflection_builder_based.dart.ReflectionImpl',
    typeParameters: const [],
    parameters: [
ta.ParameterDescriptor(name: 'reflectee',typeQualifiedName: 'dart:core.Object',isRequired: true,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],)
],
    annotations: [
ta.AnnotationDescriptor(name: 'override',qualifiedName: 'dart:core.override',positionalArguments: <Object?>[],namedArguments: const <String, Object?>{},)
],
    invokeOn: (Object instance, List<dynamic> positional, Map<Symbol, dynamic> named) => Function.apply((instance as lib5.Reflection).reflect, positional, named),
    invokeStatic: null,
  ),
  'canReflectType': ta.MethodDescriptor(
    name: 'canReflectType',
    isStatic: false,
    isAbstract: false,
    isOperator: false,
    returnTypeQualifiedName: 'dart:core.bool',
    declaringClassQualifiedName: 'package:tom_reflection/src/reflection/reflection_builder_based.dart.ReflectionImpl',
    typeParameters: const [],
    parameters: [
ta.ParameterDescriptor(name: 'type',typeQualifiedName: 'dart:core.Type',isRequired: true,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],)
],
    annotations: [
ta.AnnotationDescriptor(name: 'override',qualifiedName: 'dart:core.override',positionalArguments: <Object?>[],namedArguments: const <String, Object?>{},)
],
    invokeOn: (Object instance, List<dynamic> positional, Map<Symbol, dynamic> named) => Function.apply((instance as lib5.Reflection).canReflectType, positional, named),
    invokeStatic: null,
  ),
  'reflectType': ta.MethodDescriptor(
    name: 'reflectType',
    isStatic: false,
    isAbstract: false,
    isOperator: false,
    returnTypeQualifiedName: 'package:tom_reflection/src/reflection/mirrors.dart.TypeMirror',
    declaringClassQualifiedName: 'package:tom_reflection/src/reflection/reflection_builder_based.dart.ReflectionImpl',
    typeParameters: const [],
    parameters: [
ta.ParameterDescriptor(name: 'type',typeQualifiedName: 'dart:core.Type',isRequired: true,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],)
],
    annotations: [
ta.AnnotationDescriptor(name: 'override',qualifiedName: 'dart:core.override',positionalArguments: <Object?>[],namedArguments: const <String, Object?>{},)
],
    invokeOn: (Object instance, List<dynamic> positional, Map<Symbol, dynamic> named) => Function.apply((instance as lib5.Reflection).reflectType, positional, named),
    invokeStatic: null,
  ),
  'findLibrary': ta.MethodDescriptor(
    name: 'findLibrary',
    isStatic: false,
    isAbstract: false,
    isOperator: false,
    returnTypeQualifiedName: 'package:tom_reflection/src/reflection/mirrors.dart.LibraryMirror',
    declaringClassQualifiedName: 'package:tom_reflection/src/reflection/reflection_builder_based.dart.ReflectionImpl',
    typeParameters: const [],
    parameters: [
ta.ParameterDescriptor(name: 'libraryName',typeQualifiedName: 'dart:core.String',isRequired: true,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],)
],
    annotations: [
ta.AnnotationDescriptor(name: 'override',qualifiedName: 'dart:core.override',positionalArguments: <Object?>[],namedArguments: const <String, Object?>{},)
],
    invokeOn: (Object instance, List<dynamic> positional, Map<Symbol, dynamic> named) => Function.apply((instance as lib5.Reflection).findLibrary, positional, named),
    invokeStatic: null,
  ),
  },
  staticMethods: <String, ta.MethodDescriptor>{
  'getInstance': ta.MethodDescriptor(
    name: 'getInstance',
    isStatic: true,
    isAbstract: false,
    isOperator: false,
    returnTypeQualifiedName: 'package:tom_reflection/tom_reflection.dart.Reflection',
    declaringClassQualifiedName: null,
    typeParameters: const [],
    parameters: [
ta.ParameterDescriptor(name: 'type',typeQualifiedName: 'dart:core.Type',isRequired: true,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],)
],
    annotations: const [],
    invokeOn: null,
    invokeStatic: (List<dynamic> positional, Map<Symbol, dynamic> named) => Function.apply(lib5.Reflection.getInstance, positional, named),
  ),
  },
  fields: <String, ta.FieldDescriptor>{
  'libraries': ta.FieldDescriptor(
    name: 'libraries',
    typeQualifiedName: 'dart:core.Map',
    isStatic: false,
    isFinal: false,
    isConst: false,
    declaringClassQualifiedName: 'package:tom_reflection/src/reflection/reflection_builder_based.dart.ReflectionImpl',
    annotations: const [],
    getInstance: (Object instance) => (instance as lib5.Reflection).libraries,
    setInstance: null,
    getStatic: null,
    setStatic: null,
  ),
  'annotatedClasses': ta.FieldDescriptor(
    name: 'annotatedClasses',
    typeQualifiedName: 'dart:core.Iterable',
    isStatic: false,
    isFinal: false,
    isConst: false,
    declaringClassQualifiedName: 'package:tom_reflection/src/reflection/reflection_builder_based.dart.ReflectionImpl',
    annotations: const [],
    getInstance: (Object instance) => (instance as lib5.Reflection).annotatedClasses,
    setInstance: null,
    getStatic: null,
    setStatic: null,
  ),
  },
  staticFields: <String, ta.FieldDescriptor>{
  'thisClassName': ta.FieldDescriptor(
    name: 'thisClassName',
    typeQualifiedName: 'dart:core.String',
    isStatic: true,
    isFinal: false,
    isConst: true,
    declaringClassQualifiedName: null,
    annotations: const [],
    getInstance: null,
    setInstance: null,
    getStatic: () => lib5.Reflection.thisClassName,
    setStatic: null,
  ),
  'thisClassId': ta.FieldDescriptor(
    name: 'thisClassId',
    typeQualifiedName: 'dart:core.String',
    isStatic: true,
    isFinal: false,
    isConst: true,
    declaringClassQualifiedName: null,
    annotations: const [],
    getInstance: null,
    setInstance: null,
    getStatic: () => lib5.Reflection.thisClassId,
    setStatic: null,
  ),
  },
  getters: const {},
  staticGetters: const {},
  setters: const {},
  staticSetters: const {},
  superclassQualifiedName: 'package:tom_reflection/src/reflection/reflection_builder_based.dart.ReflectionImpl',
  interfaceQualifiedNames: <String>['package:tom_reflection/tom_reflection.dart.ReflectionInterface'],
  mixinQualifiedNames: const [],
  appliedExtensionQualifiedNames: const [],
  constructors: <String, ta.ConstructorDescriptor>{
    'fromList': ta.ConstructorDescriptor(
      name: 'fromList',
      isFactory: false,
      parameters: [
ta.ParameterDescriptor(name: 'capabilities',typeQualifiedName: 'dart:core.List',isRequired: true,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],)
],
      annotations: const [],
      invoke: null,
    ),
    'new': ta.ConstructorDescriptor(
      name: 'new',
      isFactory: false,
      parameters: [
ta.ParameterDescriptor(name: 'cap0',typeQualifiedName: 'package:tom_reflection/src/reflection/capability.dart.ReflectCapability',isRequired: false,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],),
ta.ParameterDescriptor(name: 'cap1',typeQualifiedName: 'package:tom_reflection/src/reflection/capability.dart.ReflectCapability',isRequired: false,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],),
ta.ParameterDescriptor(name: 'cap2',typeQualifiedName: 'package:tom_reflection/src/reflection/capability.dart.ReflectCapability',isRequired: false,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],),
ta.ParameterDescriptor(name: 'cap3',typeQualifiedName: 'package:tom_reflection/src/reflection/capability.dart.ReflectCapability',isRequired: false,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],),
ta.ParameterDescriptor(name: 'cap4',typeQualifiedName: 'package:tom_reflection/src/reflection/capability.dart.ReflectCapability',isRequired: false,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],),
ta.ParameterDescriptor(name: 'cap5',typeQualifiedName: 'package:tom_reflection/src/reflection/capability.dart.ReflectCapability',isRequired: false,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],),
ta.ParameterDescriptor(name: 'cap6',typeQualifiedName: 'package:tom_reflection/src/reflection/capability.dart.ReflectCapability',isRequired: false,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],),
ta.ParameterDescriptor(name: 'cap7',typeQualifiedName: 'package:tom_reflection/src/reflection/capability.dart.ReflectCapability',isRequired: false,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],),
ta.ParameterDescriptor(name: 'cap8',typeQualifiedName: 'package:tom_reflection/src/reflection/capability.dart.ReflectCapability',isRequired: false,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],),
ta.ParameterDescriptor(name: 'cap9',typeQualifiedName: 'package:tom_reflection/src/reflection/capability.dart.ReflectCapability',isRequired: false,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],)
],
      annotations: const [],
      invoke: null,
    ),
  },
  isInstance: (Object instance) => instance is lib5.Reflection,
),
'package:tom_reflection/tom_reflection.dart.ReflectionInterface': ta.ClassDescriptor(
  name: 'ReflectionInterface',
  qualifiedName: 'package:tom_reflection/tom_reflection.dart.ReflectionInterface',
  libraryUri: 'package:tom_reflection/tom_reflection.dart',
  package: 'tom_reflection',
  annotations: const [],
  typeParameters: const [],
  isAbstract: true,
  isSealed: false,
  isFinal: false,
  isBase: false,
  isInterface: false,
  isMixinClass: false,
  methods: <String, ta.MethodDescriptor>{
  'canReflect': ta.MethodDescriptor(
    name: 'canReflect',
    isStatic: false,
    isAbstract: true,
    isOperator: false,
    returnTypeQualifiedName: 'dart:core.bool',
    declaringClassQualifiedName: null,
    typeParameters: const [],
    parameters: [
ta.ParameterDescriptor(name: 'o',typeQualifiedName: 'dart:core.Object',isRequired: true,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],)
],
    annotations: const [],
    invokeOn: null,
    invokeStatic: null,
  ),
  'reflect': ta.MethodDescriptor(
    name: 'reflect',
    isStatic: false,
    isAbstract: true,
    isOperator: false,
    returnTypeQualifiedName: 'package:tom_reflection/src/reflection/mirrors.dart.InstanceMirror',
    declaringClassQualifiedName: null,
    typeParameters: const [],
    parameters: [
ta.ParameterDescriptor(name: 'o',typeQualifiedName: 'dart:core.Object',isRequired: true,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],)
],
    annotations: const [],
    invokeOn: null,
    invokeStatic: null,
  ),
  'canReflectType': ta.MethodDescriptor(
    name: 'canReflectType',
    isStatic: false,
    isAbstract: true,
    isOperator: false,
    returnTypeQualifiedName: 'dart:core.bool',
    declaringClassQualifiedName: null,
    typeParameters: const [],
    parameters: [
ta.ParameterDescriptor(name: 'type',typeQualifiedName: 'dart:core.Type',isRequired: true,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],)
],
    annotations: const [],
    invokeOn: null,
    invokeStatic: null,
  ),
  'reflectType': ta.MethodDescriptor(
    name: 'reflectType',
    isStatic: false,
    isAbstract: true,
    isOperator: false,
    returnTypeQualifiedName: 'package:tom_reflection/src/reflection/mirrors.dart.TypeMirror',
    declaringClassQualifiedName: null,
    typeParameters: const [],
    parameters: [
ta.ParameterDescriptor(name: 'type',typeQualifiedName: 'dart:core.Type',isRequired: true,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],)
],
    annotations: const [],
    invokeOn: null,
    invokeStatic: null,
  ),
  'findLibrary': ta.MethodDescriptor(
    name: 'findLibrary',
    isStatic: false,
    isAbstract: true,
    isOperator: false,
    returnTypeQualifiedName: 'package:tom_reflection/src/reflection/mirrors.dart.LibraryMirror',
    declaringClassQualifiedName: null,
    typeParameters: const [],
    parameters: [
ta.ParameterDescriptor(name: 'library',typeQualifiedName: 'dart:core.String',isRequired: true,isNamed: false,isPositional: true,hasDefaultValue: false,defaultValue: null,annotations: const [],)
],
    annotations: const [],
    invokeOn: null,
    invokeStatic: null,
  ),
  },
  staticMethods: const {},
  fields: <String, ta.FieldDescriptor>{
  'libraries': ta.FieldDescriptor(
    name: 'libraries',
    typeQualifiedName: 'dart:core.Map',
    isStatic: false,
    isFinal: false,
    isConst: false,
    declaringClassQualifiedName: null,
    annotations: const [],
    getInstance: (Object instance) => (instance as lib5.ReflectionInterface).libraries,
    setInstance: null,
    getStatic: null,
    setStatic: null,
  ),
  'annotatedClasses': ta.FieldDescriptor(
    name: 'annotatedClasses',
    typeQualifiedName: 'dart:core.Iterable',
    isStatic: false,
    isFinal: false,
    isConst: false,
    declaringClassQualifiedName: null,
    annotations: const [],
    getInstance: (Object instance) => (instance as lib5.ReflectionInterface).annotatedClasses,
    setInstance: null,
    getStatic: null,
    setStatic: null,
  ),
  },
  staticFields: const {},
  getters: const {},
  staticGetters: const {},
  setters: const {},
  staticSetters: const {},
  superclassQualifiedName: 'dart:core.Object',
  interfaceQualifiedNames: const [],
  mixinQualifiedNames: const [],
  appliedExtensionQualifiedNames: const [],
  constructors: <String, ta.ConstructorDescriptor>{
    'new': ta.ConstructorDescriptor(
      name: 'new',
      isFactory: false,
      parameters: const [],
      annotations: const [],
      invoke: null,
    ),
  },
  isInstance: (Object instance) => instance is lib5.ReflectionInterface,
),
'package:tom_reflection/tom_reflection.dart.StringInvocation': ta.ClassDescriptor(
  name: 'StringInvocation',
  qualifiedName: 'package:tom_reflection/tom_reflection.dart.StringInvocation',
  libraryUri: 'package:tom_reflection/tom_reflection.dart',
  package: 'tom_reflection',
  annotations: const [],
  typeParameters: const [],
  isAbstract: true,
  isSealed: false,
  isFinal: false,
  isBase: false,
  isInterface: false,
  isMixinClass: false,
  methods: const {},
  staticMethods: const {},
  fields: <String, ta.FieldDescriptor>{
  'memberName': ta.FieldDescriptor(
    name: 'memberName',
    typeQualifiedName: 'dart:core.String',
    isStatic: false,
    isFinal: false,
    isConst: false,
    declaringClassQualifiedName: null,
    annotations: const [],
    getInstance: (Object instance) => (instance as lib5.StringInvocation).memberName,
    setInstance: null,
    getStatic: null,
    setStatic: null,
  ),
  'positionalArguments': ta.FieldDescriptor(
    name: 'positionalArguments',
    typeQualifiedName: 'dart:core.List',
    isStatic: false,
    isFinal: false,
    isConst: false,
    declaringClassQualifiedName: null,
    annotations: const [],
    getInstance: (Object instance) => (instance as lib5.StringInvocation).positionalArguments,
    setInstance: null,
    getStatic: null,
    setStatic: null,
  ),
  'namedArguments': ta.FieldDescriptor(
    name: 'namedArguments',
    typeQualifiedName: 'dart:core.Map',
    isStatic: false,
    isFinal: false,
    isConst: false,
    declaringClassQualifiedName: null,
    annotations: const [],
    getInstance: (Object instance) => (instance as lib5.StringInvocation).namedArguments,
    setInstance: null,
    getStatic: null,
    setStatic: null,
  ),
  'isMethod': ta.FieldDescriptor(
    name: 'isMethod',
    typeQualifiedName: 'dart:core.bool',
    isStatic: false,
    isFinal: false,
    isConst: false,
    declaringClassQualifiedName: null,
    annotations: const [],
    getInstance: (Object instance) => (instance as lib5.StringInvocation).isMethod,
    setInstance: null,
    getStatic: null,
    setStatic: null,
  ),
  'isGetter': ta.FieldDescriptor(
    name: 'isGetter',
    typeQualifiedName: 'dart:core.bool',
    isStatic: false,
    isFinal: false,
    isConst: false,
    declaringClassQualifiedName: null,
    annotations: const [],
    getInstance: (Object instance) => (instance as lib5.StringInvocation).isGetter,
    setInstance: null,
    getStatic: null,
    setStatic: null,
  ),
  'isSetter': ta.FieldDescriptor(
    name: 'isSetter',
    typeQualifiedName: 'dart:core.bool',
    isStatic: false,
    isFinal: false,
    isConst: false,
    declaringClassQualifiedName: null,
    annotations: const [],
    getInstance: (Object instance) => (instance as lib5.StringInvocation).isSetter,
    setInstance: null,
    getStatic: null,
    setStatic: null,
  ),
  'isAccessor': ta.FieldDescriptor(
    name: 'isAccessor',
    typeQualifiedName: 'dart:core.bool',
    isStatic: false,
    isFinal: false,
    isConst: false,
    declaringClassQualifiedName: null,
    annotations: const [],
    getInstance: (Object instance) => (instance as lib5.StringInvocation).isAccessor,
    setInstance: null,
    getStatic: null,
    setStatic: null,
  ),
  },
  staticFields: const {},
  getters: const {},
  staticGetters: const {},
  setters: const {},
  staticSetters: const {},
  superclassQualifiedName: 'dart:core.Object',
  interfaceQualifiedNames: const [],
  mixinQualifiedNames: const [],
  appliedExtensionQualifiedNames: const [],
  constructors: <String, ta.ConstructorDescriptor>{
    'new': ta.ConstructorDescriptor(
      name: 'new',
      isFactory: false,
      parameters: const [],
      annotations: const [],
      invoke: null,
    ),
  },
  isInstance: (Object instance) => instance is lib5.StringInvocation,
),
};
final _enums = <String, ta.MemberContainerDescriptor>{
};
final _mixins = <String, ta.MemberContainerDescriptor>{
};
final _extensions = <String, ta.ExtensionDescriptor>{
};
final _extensionTypes = <String, ta.MemberContainerDescriptor>{
};
final _typeAliases = <String, ta.TypeAliasDescriptor>{
};
final _globals = <String, ta.GlobalDescriptor>{
};
final reflectionApi = ta.ReflectionApi(
  classesByQualifiedName: _classes,
  enumsByQualifiedName: _enums,
  mixinsByQualifiedName: _mixins,
  extensionsByQualifiedName: _extensions,
  extensionTypesByQualifiedName: _extensionTypes,
  typeAliasesByQualifiedName: _typeAliases,
  globalsByQualifiedName: _globals,
);
