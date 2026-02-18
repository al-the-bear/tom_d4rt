# Dart Analyzer 8.x Element API

Extracted from: file:///Users/alexiskyaw/.pub-cache/hosted/pub.dev/analyzer-8.4.1/lib/dart/element/element.dart

## Summary

- Total types: 95
- Element types: 38
- Fragment types: 38
- Visitor types: 1
- Other types: 18

## Element Types

### BindPatternVariableElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** PatternVariableElement

**Getters:**
- `BindPatternVariableFragment get firstFragment`
- `List<BindPatternVariableFragment> get fragments`

---

### ClassElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** InterfaceElement

**Getters:**
- `ClassFragment get firstFragment`
- `List<ClassFragment> get fragments`
- `bool get hasNonFinalField`
- `bool get isAbstract`
- `bool get isBase`
- `bool get isConstructable`
- `bool get isDartCoreEnum`
- `bool get isDartCoreObject`
- `bool get isExhaustive`
- `bool get isExtendableOutside`
- `bool get isFinal`
- `bool get isImplementableOutside`
- `bool get isInterface`
- `bool get isMixableOutside`
- `bool get isMixinApplication`
- `bool get isMixinClass`
- `bool get isSealed`
- `bool get isValidMixin`

**Methods:**
- `bool isExtendableIn(LibraryElement library)`
- `bool isExtendableIn2(LibraryElement library)`
- `bool isImplementableIn(LibraryElement library)`
- `bool isImplementableIn2(LibraryElement library)`
- `bool isMixableIn(LibraryElement library)`
- `bool isMixableIn2(LibraryElement library)`

---

### ConstructorElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** ExecutableElement

**Getters:**
- `ConstructorElement get baseElement`
- `InterfaceElement get enclosingElement`
- `InterfaceElement get enclosingElement2`
- `ConstructorFragment get firstFragment`
- `List<ConstructorFragment> get fragments`
- `bool get isConst`
- `bool get isDefaultConstructor`
- `bool get isFactory`
- `bool get isGenerative`
- `String? get name`
- `String? get name3`
- `ConstructorElement? get redirectedConstructor`
- `ConstructorElement? get redirectedConstructor2`
- `InvalidType get returnType`
- `ConstructorElement? get superConstructor`
- `ConstructorElement? get superConstructor2`

---

### Element

**Kind:** abstract class
**Superclass:** Object

**Getters:**
- `Element get baseElement`
- `List<Element> get children`
- `List<Element> get children2`
- `String get displayName`
- `String? get documentationComment`
- `Element? get enclosingElement`
- `Element? get enclosingElement2`
- `Fragment get firstFragment`
- `List<Fragment> get fragments`
- `int get id`
- `bool get isPrivate`
- `bool get isPublic`
- `bool get isSynthetic`
- `ElementKind get kind`
- `LibraryElement? get library`
- `LibraryElement? get library2`
- `String? get lookupName`
- `Metadata get metadata`
- `String? get name`
- `String? get name3`
- `Element get nonSynthetic`
- `Element get nonSynthetic2`
- `InvalidType get session`
- `InvalidType get sinceSdkVersion`

**Methods:**
- `T? accept(ElementVisitor2<T> visitor)`
- `T? accept2(ElementVisitor2<T> visitor)`
- `String displayString(bool multiline, bool preferTypeAlias)`
- `String displayString2(bool multiline, bool preferTypeAlias)`
- `String getExtendedDisplayName(String? shortName)`
- `String getExtendedDisplayName2(String? shortName)`
- `bool isAccessibleIn(LibraryElement library)`
- `bool isAccessibleIn2(LibraryElement library)`
- `bool isDeprecatedWithKind(String kind)`
- `Element? thisOrAncestorMatching(bool Function(Element) predicate)`
- `Element? thisOrAncestorMatching2(bool Function(Element) predicate)`
- `E? thisOrAncestorOfType()`
- `E? thisOrAncestorOfType2()`
- `void visitChildren(ElementVisitor2<T> visitor)`
- `void visitChildren2(ElementVisitor2<T> visitor)`

---

### EnumElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** InterfaceElement

**Getters:**
- `List<FieldElement> get constants`
- `List<FieldElement> get constants2`
- `EnumFragment get firstFragment`
- `List<EnumFragment> get fragments`

---

### ExecutableElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** FunctionTypedElement

**Getters:**
- `ExecutableElement get baseElement`
- `ExecutableFragment get firstFragment`
- `List<ExecutableFragment> get fragments`
- `bool get hasImplicitReturnType`
- `bool get isAbstract`
- `bool get isExtensionTypeMember`
- `bool get isExternal`
- `bool get isStatic`

---

### ExtensionElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** InstanceElement

**Getters:**
- `InvalidType get extendedType`
- `ExtensionFragment get firstFragment`
- `List<ExtensionFragment> get fragments`

---

### ExtensionTypeElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** InterfaceElement

**Getters:**
- `ExtensionTypeFragment get firstFragment`
- `List<ExtensionTypeFragment> get fragments`
- `ConstructorElement get primaryConstructor`
- `ConstructorElement get primaryConstructor2`
- `FieldElement get representation`
- `FieldElement get representation2`
- `InvalidType get typeErasure`

---

### FieldElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** PropertyInducingElement

**Getters:**
- `FieldElement get baseElement`
- `InstanceElement get enclosingElement`
- `InstanceElement get enclosingElement2`
- `FieldFragment get firstFragment`
- `List<FieldFragment> get fragments`
- `bool get isAbstract`
- `bool get isCovariant`
- `bool get isEnumConstant`
- `bool get isExternal`
- `bool get isPromotable`

---

### FieldFormalParameterElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** FormalParameterElement

**Getters:**
- `FieldElement? get field`
- `FieldElement? get field2`
- `FieldFormalParameterFragment get firstFragment`
- `List<FieldFormalParameterFragment> get fragments`

---

### FormalParameterElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** VariableElement, Annotatable, LocalElement

**Getters:**
- `FormalParameterElement get baseElement`
- `String? get defaultValueCode`
- `FormalParameterFragment get firstFragment`
- `List<FormalParameterElement> get formalParameters`
- `List<FormalParameterFragment> get fragments`
- `bool get hasDefaultValue`
- `bool get isCovariant`
- `bool get isInitializingFormal`
- `bool get isNamed`
- `bool get isOptional`
- `bool get isOptionalNamed`
- `bool get isOptionalPositional`
- `bool get isPositional`
- `bool get isRequired`
- `bool get isRequiredNamed`
- `bool get isRequiredPositional`
- `bool get isSuperFormal`
- `List<TypeParameterElement> get typeParameters`
- `List<TypeParameterElement> get typeParameters2`

**Methods:**
- `void appendToWithoutDelimiters(StringBuffer buffer)`
- `void appendToWithoutDelimiters2(StringBuffer buffer)`

---

### FunctionTypedElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** TypeParameterizedElement

**Getters:**
- `FunctionTypedFragment get firstFragment`
- `List<FormalParameterElement> get formalParameters`
- `List<FunctionTypedFragment> get fragments`
- `InvalidType get returnType`
- `InvalidType get type`

---

### GenericFunctionTypeElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** FunctionTypedElement

**Getters:**
- `GenericFunctionTypeFragment get firstFragment`
- `List<GenericFunctionTypeFragment> get fragments`

---

### GetterElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** PropertyAccessorElement

**Getters:**
- `GetterElement get baseElement`
- `SetterElement? get correspondingSetter`
- `SetterElement? get correspondingSetter2`
- `GetterFragment get firstFragment`
- `List<GetterFragment> get fragments`

---

### InstanceElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** TypeDefiningElement, TypeParameterizedElement

**Getters:**
- `InstanceElement get baseElement`
- `LibraryElement get enclosingElement`
- `LibraryElement get enclosingElement2`
- `List<FieldElement> get fields`
- `List<FieldElement> get fields2`
- `InstanceFragment get firstFragment`
- `List<InstanceFragment> get fragments`
- `List<GetterElement> get getters`
- `List<GetterElement> get getters2`
- `List<MethodElement> get methods`
- `List<MethodElement> get methods2`
- `List<SetterElement> get setters`
- `List<SetterElement> get setters2`
- `InvalidType get thisType`

**Methods:**
- `FieldElement? getField(String name)`
- `FieldElement? getField2(String name)`
- `GetterElement? getGetter(String name)`
- `GetterElement? getGetter2(String name)`
- `MethodElement? getMethod(String name)`
- `MethodElement? getMethod2(String name)`
- `SetterElement? getSetter(String name)`
- `SetterElement? getSetter2(String name)`
- `GetterElement? lookUpGetter(required String name, required LibraryElement library)`
- `GetterElement? lookUpGetter2(required String name, required LibraryElement library)`
- `MethodElement? lookUpMethod(required String name, required LibraryElement library)`
- `MethodElement? lookUpMethod2(required String name, required LibraryElement library)`
- `SetterElement? lookUpSetter(required String name, required LibraryElement library)`
- `SetterElement? lookUpSetter2(required String name, required LibraryElement library)`

---

### InterfaceElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** InstanceElement

**Getters:**
- `List<InvalidType> get allSupertypes`
- `List<ConstructorElement> get constructors`
- `List<ConstructorElement> get constructors2`
- `InterfaceFragment get firstFragment`
- `List<InterfaceFragment> get fragments`
- `Map<InvalidType, ExecutableElement> get inheritedConcreteMembers`
- `Map<InvalidType, ExecutableElement> get inheritedMembers`
- `Map<InvalidType, ExecutableElement> get interfaceMembers`
- `List<InvalidType> get interfaces`
- `List<InvalidType> get mixins`
- `InvalidType get supertype`
- `InvalidType get thisType`
- `ConstructorElement? get unnamedConstructor`
- `ConstructorElement? get unnamedConstructor2`

**Methods:**
- `ExecutableElement? getInheritedConcreteMember(InvalidType name)`
- `ExecutableElement? getInheritedMember(InvalidType name)`
- `ExecutableElement? getInterfaceMember(InvalidType name)`
- `ConstructorElement? getNamedConstructor(String name)`
- `ConstructorElement? getNamedConstructor2(String name)`
- `List<ExecutableElement>? getOverridden(InvalidType name)`
- `InvalidType instantiate(required List<InvalidType> typeArguments, required InvalidType nullabilitySuffix)`
- `MethodElement? lookUpConcreteMethod(String methodName, LibraryElement library)`
- `MethodElement? lookUpInheritedMethod(required String methodName, required LibraryElement library)`
- `MethodElement? lookUpInheritedMethod2(required String methodName, required LibraryElement library)`

---

### JoinPatternVariableElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** PatternVariableElement

**Getters:**
- `JoinPatternVariableFragment get firstFragment`
- `List<JoinPatternVariableFragment> get fragments`
- `bool get isConsistent`
- `List<PatternVariableElement> get variables`
- `List<PatternVariableElement> get variables2`

---

### LabelElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** Element

**Getters:**
- `ExecutableElement? get enclosingElement`
- `ExecutableElement? get enclosingElement2`
- `LabelFragment get firstFragment`
- `List<LabelFragment> get fragments`
- `LibraryElement get library`
- `LibraryElement get library2`

---

### LibraryElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** Element, Annotatable

**Getters:**
- `List<ClassElement> get classes`
- `TopLevelFunctionElement? get entryPoint`
- `TopLevelFunctionElement? get entryPoint2`
- `List<EnumElement> get enums`
- `List<LibraryElement> get exportedLibraries`
- `List<LibraryElement> get exportedLibraries2`
- `InvalidType get exportNamespace`
- `List<ExtensionElement> get extensions`
- `List<ExtensionTypeElement> get extensionTypes`
- `InvalidType get featureSet`
- `LibraryFragment get firstFragment`
- `List<LibraryFragment> get fragments`
- `List<GetterElement> get getters`
- `String get identifier`
- `bool get isDartAsync`
- `bool get isDartCore`
- `bool get isInSdk`
- `LibraryLanguageVersion get languageVersion`
- `LibraryElement get library`
- `LibraryElement get library2`
- `TopLevelFunctionElement get loadLibraryFunction`
- `TopLevelFunctionElement get loadLibraryFunction2`
- `List<MixinElement> get mixins`
- `InvalidType get publicNamespace`
- `InvalidType get session`
- `List<SetterElement> get setters`
- `List<TopLevelFunctionElement> get topLevelFunctions`
- `List<TopLevelVariableElement> get topLevelVariables`
- `List<TypeAliasElement> get typeAliases`
- `InvalidType get typeProvider`
- `InvalidType get typeSystem`
- `Uri get uri`

**Methods:**
- `ClassElement? getClass(String name)`
- `ClassElement? getClass2(String name)`
- `EnumElement? getEnum(String name)`
- `EnumElement? getEnum2(String name)`
- `ExtensionElement? getExtension(String name)`
- `ExtensionTypeElement? getExtensionType(String name)`
- `GetterElement? getGetter(String name)`
- `MixinElement? getMixin(String name)`
- `MixinElement? getMixin2(String name)`
- `SetterElement? getSetter(String name)`
- `TopLevelFunctionElement? getTopLevelFunction(String name)`
- `TopLevelVariableElement? getTopLevelVariable(String name)`
- `TypeAliasElement? getTypeAlias(String name)`

---

### LocalElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** Element

---

### LocalFunctionElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** ExecutableElement, LocalElement

**Getters:**
- `LocalFunctionFragment get firstFragment`
- `List<LocalFunctionFragment> get fragments`

---

### LocalVariableElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** VariableElement, LocalElement, Annotatable

**Getters:**
- `LocalVariableElement get baseElement`
- `LocalVariableFragment get firstFragment`
- `List<LocalVariableFragment> get fragments`

---

### MethodElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** ExecutableElement

**Getters:**
- `MethodElement get baseElement`
- `MethodFragment get firstFragment`
- `List<MethodFragment> get fragments`
- `bool get isOperator`

---

### MixinElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** InterfaceElement

**Getters:**
- `MixinFragment get firstFragment`
- `List<MixinFragment> get fragments`
- `bool get isBase`
- `bool get isImplementableOutside`
- `List<InvalidType> get superclassConstraints`

**Methods:**
- `bool isImplementableIn(LibraryElement library)`
- `bool isImplementableIn2(LibraryElement library)`

---

### MultiplyDefinedElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** Element

**Getters:**
- `List<Element> get conflictingElements`
- `List<Element> get conflictingElements2`
- `MultiplyDefinedFragment get firstFragment`
- `List<MultiplyDefinedFragment> get fragments`

---

### PatternVariableElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** LocalVariableElement

**Getters:**
- `PatternVariableFragment get firstFragment`
- `List<PatternVariableFragment> get fragments`
- `JoinPatternVariableElement? get join`
- `JoinPatternVariableElement? get join2`

---

### PrefixElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** Element

**Getters:**
- `Null get enclosingElement`
- `Null get enclosingElement2`
- `PrefixFragment get firstFragment`
- `List<PrefixFragment> get fragments`
- `List<LibraryImport> get imports`
- `LibraryElement get library`
- `LibraryElement get library2`
- `InvalidType get scope`

---

### PropertyAccessorElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** ExecutableElement

**Getters:**
- `PropertyAccessorElement get baseElement`
- `Element get enclosingElement`
- `Element get enclosingElement2`
- `PropertyAccessorFragment get firstFragment`
- `List<PropertyAccessorFragment> get fragments`
- `PropertyInducingElement get variable`
- `PropertyInducingElement? get variable3`

---

### PropertyInducingElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** VariableElement, Annotatable

**Getters:**
- `PropertyInducingFragment get firstFragment`
- `List<PropertyInducingFragment> get fragments`
- `GetterElement? get getter`
- `GetterElement? get getter2`
- `bool get hasInitializer`
- `LibraryElement get library`
- `LibraryElement get library2`
- `SetterElement? get setter`
- `SetterElement? get setter2`

---

### SetterElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** PropertyAccessorElement

**Getters:**
- `SetterElement get baseElement`
- `GetterElement? get correspondingGetter`
- `GetterElement? get correspondingGetter2`
- `SetterFragment get firstFragment`
- `List<SetterFragment> get fragments`

---

### SuperFormalParameterElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** FormalParameterElement

**Getters:**
- `SuperFormalParameterFragment get firstFragment`
- `List<SuperFormalParameterFragment> get fragments`
- `FormalParameterElement? get superConstructorParameter`
- `FormalParameterElement? get superConstructorParameter2`

---

### TopLevelFunctionElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** ExecutableElement

**Getters:**
- `TopLevelFunctionElement get baseElement`
- `TopLevelFunctionFragment get firstFragment`
- `List<TopLevelFunctionFragment> get fragments`
- `bool get isDartCoreIdentical`
- `bool get isEntryPoint`

---

### TopLevelVariableElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** PropertyInducingElement

**Getters:**
- `TopLevelVariableElement get baseElement`
- `TopLevelVariableFragment get firstFragment`
- `List<TopLevelVariableFragment> get fragments`
- `bool get isExternal`

---

### TypeAliasElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** TypeParameterizedElement, TypeDefiningElement

**Getters:**
- `Element? get aliasedElement`
- `Element? get aliasedElement2`
- `InvalidType get aliasedType`
- `LibraryElement get enclosingElement`
- `LibraryElement get enclosingElement2`
- `TypeAliasFragment get firstFragment`
- `List<TypeAliasFragment> get fragments`

**Methods:**
- `InvalidType instantiate(required List<InvalidType> typeArguments, required InvalidType nullabilitySuffix)`

---

### TypeDefiningElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** Element, Annotatable

**Getters:**
- `TypeDefiningFragment get firstFragment`
- `List<TypeDefiningFragment> get fragments`

---

### TypeParameterElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** TypeDefiningElement

**Getters:**
- `TypeParameterElement get baseElement`
- `InvalidType get bound`
- `TypeParameterFragment get firstFragment`
- `List<TypeParameterFragment> get fragments`

**Methods:**
- `InvalidType instantiate(required InvalidType nullabilitySuffix)`

---

### TypeParameterizedElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** Element, Annotatable

**Getters:**
- `TypeParameterizedFragment get firstFragment`
- `List<TypeParameterizedFragment> get fragments`
- `bool get isSimplyBounded`
- `LibraryElement get library`
- `LibraryElement get library2`
- `List<TypeParameterElement> get typeParameters`
- `List<TypeParameterElement> get typeParameters2`

---

### VariableElement

**Kind:** abstract class
**Superclass:** Object
**Implements:** Element

**Getters:**
- `InvalidType get constantInitializer`
- `VariableFragment get firstFragment`
- `List<VariableFragment> get fragments`
- `bool get hasImplicitType`
- `bool get isConst`
- `bool get isFinal`
- `bool get isLate`
- `bool get isStatic`
- `InvalidType get type`

**Methods:**
- `InvalidType computeConstantValue()`

---

## Fragment Types

### BindPatternVariableFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** PatternVariableFragment

**Getters:**
- `BindPatternVariableElement get element`
- `BindPatternVariableFragment? get nextFragment`
- `BindPatternVariableFragment? get previousFragment`

---

### ClassFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** InterfaceFragment

**Getters:**
- `ClassElement get element`
- `ClassFragment? get nextFragment`
- `ClassFragment? get previousFragment`

---

### ConstructorFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** ExecutableFragment

**Getters:**
- `ConstructorElement get element`
- `InstanceFragment? get enclosingFragment`
- `String get name`
- `String get name2`
- `ConstructorFragment? get nextFragment`
- `int get offset`
- `int? get periodOffset`
- `ConstructorFragment? get previousFragment`
- `String? get typeName`
- `int? get typeNameOffset`

---

### EnumFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** InterfaceFragment

**Getters:**
- `List<FieldElement> get constants`
- `List<FieldElement> get constants2`
- `EnumElement get element`
- `EnumFragment? get nextFragment`
- `EnumFragment? get previousFragment`

---

### ExecutableFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** FunctionTypedFragment

**Getters:**
- `ExecutableElement get element`
- `bool get isAsynchronous`
- `bool get isAugmentation`
- `bool get isGenerator`
- `bool get isSynchronous`
- `bool get isSynthetic`
- `LibraryFragment get libraryFragment`
- `ExecutableFragment? get nextFragment`
- `ExecutableFragment? get previousFragment`

---

### ExtensionFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** InstanceFragment

**Getters:**
- `ExtensionElement get element`
- `ExtensionFragment? get nextFragment`
- `int get offset`
- `ExtensionFragment? get previousFragment`

---

### ExtensionTypeFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** InterfaceFragment

**Getters:**
- `ExtensionTypeElement get element`
- `ExtensionTypeFragment? get nextFragment`
- `ExtensionTypeFragment? get previousFragment`
- `ConstructorFragment get primaryConstructor`
- `ConstructorFragment get primaryConstructor2`
- `FieldFragment get representation`
- `FieldFragment get representation2`

---

### FieldFormalParameterFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** FormalParameterFragment

**Getters:**
- `FieldFormalParameterElement get element`
- `FieldFormalParameterFragment? get nextFragment`
- `FieldFormalParameterFragment? get previousFragment`

---

### FieldFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** PropertyInducingFragment

**Getters:**
- `FieldElement get element`
- `FieldFragment? get nextFragment`
- `int get offset`
- `FieldFragment? get previousFragment`

---

### FormalParameterFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** VariableFragment, Annotatable, LocalFragment

**Getters:**
- `FormalParameterElement get element`
- `FormalParameterFragment? get nextFragment`
- `int get offset`
- `FormalParameterFragment? get previousFragment`

---

### Fragment

**Kind:** abstract class
**Superclass:** Object

**Getters:**
- `List<Fragment> get children`
- `List<Fragment> get children3`
- `String? get documentationComment`
- `Element get element`
- `Fragment? get enclosingFragment`
- `LibraryFragment? get libraryFragment`
- `Metadata get metadata`
- `String? get name`
- `String? get name2`
- `int? get nameOffset`
- `int? get nameOffset2`
- `Fragment? get nextFragment`
- `int get offset`
- `Fragment? get previousFragment`

---

### FunctionTypedFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** TypeParameterizedFragment

**Getters:**
- `FunctionTypedElement get element`
- `List<FormalParameterFragment> get formalParameters`
- `FunctionTypedFragment? get nextFragment`
- `FunctionTypedFragment? get previousFragment`

---

### GenericFunctionTypeFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** FunctionTypedFragment

**Getters:**
- `GenericFunctionTypeElement get element`
- `GenericFunctionTypeFragment? get nextFragment`
- `int get offset`
- `GenericFunctionTypeFragment? get previousFragment`

---

### GetterFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** PropertyAccessorFragment

**Getters:**
- `GetterElement get element`
- `GetterFragment? get nextFragment`
- `int get offset`
- `GetterFragment? get previousFragment`

---

### InstanceFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** TypeDefiningFragment, TypeParameterizedFragment

**Getters:**
- `InstanceElement get element`
- `LibraryFragment? get enclosingFragment`
- `List<FieldFragment> get fields`
- `List<FieldFragment> get fields2`
- `List<GetterFragment> get getters`
- `bool get isAugmentation`
- `LibraryFragment get libraryFragment`
- `List<MethodFragment> get methods`
- `List<MethodFragment> get methods2`
- `InstanceFragment? get nextFragment`
- `InstanceFragment? get previousFragment`
- `List<SetterFragment> get setters`

---

### InterfaceFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** InstanceFragment

**Getters:**
- `List<ConstructorFragment> get constructors`
- `List<ConstructorFragment> get constructors2`
- `InterfaceElement get element`
- `List<InvalidType> get interfaces`
- `List<InvalidType> get mixins`
- `InterfaceFragment? get nextFragment`
- `InterfaceFragment? get previousFragment`
- `InvalidType get supertype`

---

### JoinPatternVariableFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** PatternVariableFragment

**Getters:**
- `JoinPatternVariableElement get element`
- `JoinPatternVariableFragment? get nextFragment`
- `int get offset`
- `JoinPatternVariableFragment? get previousFragment`

---

### LabelFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** Fragment

**Getters:**
- `LabelElement get element`
- `LabelFragment? get nextFragment`
- `LabelFragment? get previousFragment`

---

### LibraryFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** Fragment

**Getters:**
- `List<ExtensionElement> get accessibleExtensions`
- `List<ExtensionElement> get accessibleExtensions2`
- `List<ClassFragment> get classes`
- `List<ClassFragment> get classes2`
- `LibraryElement get element`
- `LibraryFragment? get enclosingFragment`
- `List<EnumFragment> get enums`
- `List<EnumFragment> get enums2`
- `List<ExtensionFragment> get extensions`
- `List<ExtensionFragment> get extensions2`
- `List<ExtensionTypeFragment> get extensionTypes`
- `List<ExtensionTypeFragment> get extensionTypes2`
- `List<TopLevelFunctionFragment> get functions`
- `List<TopLevelFunctionFragment> get functions2`
- `List<GetterFragment> get getters`
- `List<LibraryElement> get importedLibraries`
- `List<LibraryElement> get importedLibraries2`
- `List<LibraryExport> get libraryExports`
- `List<LibraryExport> get libraryExports2`
- `List<LibraryImport> get libraryImports`
- `List<LibraryImport> get libraryImports2`
- `InvalidType get lineInfo`
- `List<MixinFragment> get mixins`
- `List<MixinFragment> get mixins2`
- `LibraryFragment? get nextFragment`
- `int get offset`
- `List<PartInclude> get partIncludes`
- `List<PrefixElement> get prefixes`
- `LibraryFragment? get previousFragment`
- `InvalidType get scope`
- `List<SetterFragment> get setters`
- `InvalidType get source`
- `List<TopLevelVariableFragment> get topLevelVariables`
- `List<TopLevelVariableFragment> get topLevelVariables2`
- `List<TypeAliasFragment> get typeAliases`
- `List<TypeAliasFragment> get typeAliases2`

---

### LocalFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** Fragment

---

### LocalFunctionFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** ExecutableFragment, LocalFragment

**Getters:**
- `LocalFunctionElement get element`
- `LocalFunctionFragment? get nextFragment`
- `int get offset`
- `LocalFunctionFragment? get previousFragment`

---

### LocalVariableFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** VariableFragment, LocalFragment

**Getters:**
- `LocalVariableElement get element`
- `LocalVariableFragment? get nextFragment`
- `LocalVariableFragment? get previousFragment`

---

### MethodFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** ExecutableFragment

**Getters:**
- `MethodElement get element`
- `InstanceFragment? get enclosingFragment`
- `MethodFragment? get nextFragment`
- `MethodFragment? get previousFragment`

---

### MixinFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** InterfaceFragment

**Getters:**
- `MixinElement get element`
- `MixinFragment? get nextFragment`
- `MixinFragment? get previousFragment`
- `List<InvalidType> get superclassConstraints`

---

### MultiplyDefinedFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** Fragment

**Getters:**
- `MultiplyDefinedElement get element`
- `Null get nextFragment`
- `int get offset`
- `Null get previousFragment`

---

### PatternVariableFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** LocalVariableFragment

**Getters:**
- `PatternVariableElement get element`
- `JoinPatternVariableFragment? get join`
- `JoinPatternVariableFragment? get join2`
- `PatternVariableFragment? get nextFragment`
- `PatternVariableFragment? get previousFragment`

---

### PrefixFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** Fragment

**Getters:**
- `PrefixElement get element`
- `LibraryFragment? get enclosingFragment`
- `bool get isDeferred`
- `PrefixFragment? get nextFragment`
- `PrefixFragment? get previousFragment`

---

### PropertyAccessorFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** ExecutableFragment

**Getters:**
- `PropertyAccessorElement get element`
- `PropertyAccessorFragment? get nextFragment`
- `PropertyAccessorFragment? get previousFragment`

---

### PropertyInducingFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** VariableFragment, Annotatable

**Getters:**
- `PropertyInducingElement get element`
- `bool get hasInitializer`
- `bool get isAugmentation`
- `bool get isSynthetic`
- `LibraryFragment get libraryFragment`
- `PropertyInducingFragment? get nextFragment`
- `PropertyInducingFragment? get previousFragment`

---

### SetterFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** PropertyAccessorFragment

**Getters:**
- `SetterElement get element`
- `SetterFragment? get nextFragment`
- `int get offset`
- `SetterFragment? get previousFragment`

---

### SuperFormalParameterFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** FormalParameterFragment

**Getters:**
- `SuperFormalParameterElement get element`
- `SuperFormalParameterFragment? get nextFragment`
- `SuperFormalParameterFragment? get previousFragment`

---

### TopLevelFunctionFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** ExecutableFragment

**Getters:**
- `TopLevelFunctionElement get element`
- `TopLevelFunctionFragment? get nextFragment`
- `TopLevelFunctionFragment? get previousFragment`

---

### TopLevelVariableFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** PropertyInducingFragment

**Getters:**
- `TopLevelVariableElement get element`
- `TopLevelVariableFragment? get nextFragment`
- `TopLevelVariableFragment? get previousFragment`

---

### TypeAliasFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** TypeParameterizedFragment, TypeDefiningFragment

**Getters:**
- `TypeAliasElement get element`
- `LibraryFragment? get enclosingFragment`
- `Null get nextFragment`
- `Null get previousFragment`

---

### TypeDefiningFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** Fragment, Annotatable

**Getters:**
- `TypeDefiningElement get element`
- `TypeDefiningFragment? get nextFragment`
- `int get offset`
- `TypeDefiningFragment? get previousFragment`

---

### TypeParameterFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** TypeDefiningFragment

**Getters:**
- `TypeParameterElement get element`
- `TypeParameterFragment? get nextFragment`
- `TypeParameterFragment? get previousFragment`

---

### TypeParameterizedFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** Fragment, Annotatable

**Getters:**
- `TypeParameterizedElement get element`
- `TypeParameterizedFragment? get nextFragment`
- `TypeParameterizedFragment? get previousFragment`
- `List<TypeParameterFragment> get typeParameters`
- `List<TypeParameterFragment> get typeParameters2`

---

### VariableFragment

**Kind:** abstract class
**Superclass:** Object
**Implements:** Fragment

**Getters:**
- `VariableElement get element`
- `VariableFragment? get nextFragment`
- `VariableFragment? get previousFragment`

---

## Visitor Types

### ElementVisitor2

**Kind:** abstract class
**Superclass:** Object

**Methods:**
- `R? visitClassElement(ClassElement element)`
- `R? visitConstructorElement(ConstructorElement element)`
- `R? visitEnumElement(EnumElement element)`
- `R? visitExtensionElement(ExtensionElement element)`
- `R? visitExtensionTypeElement(ExtensionTypeElement element)`
- `R? visitFieldElement(FieldElement element)`
- `R? visitFieldFormalParameterElement(FieldFormalParameterElement element)`
- `R? visitFormalParameterElement(FormalParameterElement element)`
- `R? visitGenericFunctionTypeElement(GenericFunctionTypeElement element)`
- `R? visitGetterElement(GetterElement element)`
- `R? visitLabelElement(LabelElement element)`
- `R? visitLibraryElement(LibraryElement element)`
- `R? visitLocalFunctionElement(LocalFunctionElement element)`
- `R? visitLocalVariableElement(LocalVariableElement element)`
- `R? visitMethodElement(MethodElement element)`
- `R? visitMixinElement(MixinElement element)`
- `R? visitMultiplyDefinedElement(MultiplyDefinedElement element)`
- `R? visitPrefixElement(PrefixElement element)`
- `R? visitSetterElement(SetterElement element)`
- `R? visitSuperFormalParameterElement(SuperFormalParameterElement element)`
- `R? visitTopLevelFunctionElement(TopLevelFunctionElement element)`
- `R? visitTopLevelVariableElement(TopLevelVariableElement element)`
- `R? visitTypeAliasElement(TypeAliasElement element)`
- `R? visitTypeParameterElement(TypeParameterElement element)`

---

## Other Types

### Annotatable

**Kind:** abstract class
**Superclass:** Object

**Getters:**
- `String? get documentationComment`
- `Metadata get metadata`
- `Metadata get metadata2`

---

### DirectiveUri

**Kind:** abstract class
**Superclass:** Object

---

### DirectiveUriWithLibrary

**Kind:** abstract class
**Superclass:** DirectiveUriWithSource

**Getters:**
- `LibraryElement get library`
- `LibraryElement get library2`

---

### DirectiveUriWithRelativeUri

**Kind:** abstract class
**Superclass:** DirectiveUriWithRelativeUriString

**Getters:**
- `Uri get relativeUri`

---

### DirectiveUriWithRelativeUriString

**Kind:** abstract class
**Superclass:** DirectiveUri

**Getters:**
- `String get relativeUriString`

---

### DirectiveUriWithSource

**Kind:** abstract class
**Superclass:** DirectiveUriWithRelativeUri

**Getters:**
- `InvalidType get source`

---

### DirectiveUriWithUnit

**Kind:** abstract class
**Superclass:** DirectiveUriWithSource

**Getters:**
- `LibraryFragment get libraryFragment`

---

### ElementAnnotation

**Kind:** abstract class
**Superclass:** Object

**Getters:**
- `List<InvalidType>? get constantEvaluationErrors`
- `String? get deprecationKind`
- `Element? get element`
- `Element? get element2`
- `bool get isAlwaysThrows`
- `bool get isAwaitNotRequired`
- `bool get isDeprecated`
- `bool get isDoNotStore`
- `bool get isDoNotSubmit`
- `bool get isExperimental`
- `bool get isFactory`
- `bool get isImmutable`
- `bool get isInternal`
- `bool get isIsTest`
- `bool get isIsTestGroup`
- `bool get isJS`
- `bool get isLiteral`
- `bool get isMustBeConst`
- `bool get isMustBeOverridden`
- `bool get isMustCallSuper`
- `bool get isNonVirtual`
- `bool get isOptionalTypeArgs`
- `bool get isOverride`
- `bool get isProtected`
- `bool get isProxy`
- `bool get isRedeclare`
- `bool get isReopen`
- `bool get isRequired`
- `bool get isSealed`
- `bool get isTarget`
- `bool get isUseResult`
- `bool get isVisibleForOverriding`
- `bool get isVisibleForTemplate`
- `bool get isVisibleForTesting`
- `bool get isVisibleOutsideTemplate`
- `bool get isWidgetFactory`
- `LibraryFragment get libraryFragment`

**Methods:**
- `InvalidType computeConstantValue()`
- `String toSource()`

---

### ElementDirective

**Kind:** abstract class
**Superclass:** Object
**Implements:** Annotatable

**Getters:**
- `LibraryFragment get libraryFragment`
- `Metadata get metadata`
- `DirectiveUri get uri`

---

### ElementKind

**Kind:** class
**Superclass:** Object
**Implements:** Comparable

**Fields:**
- `String name`
- `int ordinal`
- `String displayName`

**Methods:**
- `int compareTo(ElementKind other)`
- `String toString()`

---

### HideElementCombinator

**Kind:** abstract class
**Superclass:** Object
**Implements:** NamespaceCombinator

**Getters:**
- `List<String> get hiddenNames`

---

### LibraryExport

**Kind:** abstract class
**Superclass:** Object
**Implements:** ElementDirective

**Getters:**
- `List<NamespaceCombinator> get combinators`
- `LibraryElement? get exportedLibrary`
- `LibraryElement? get exportedLibrary2`
- `int get exportKeywordOffset`

---

### LibraryImport

**Kind:** abstract class
**Superclass:** Object
**Implements:** ElementDirective

**Getters:**
- `List<NamespaceCombinator> get combinators`
- `LibraryElement? get importedLibrary`
- `LibraryElement? get importedLibrary2`
- `int get importKeywordOffset`
- `bool get isSynthetic`
- `InvalidType get namespace`
- `PrefixFragment? get prefix`
- `PrefixFragment? get prefix2`

---

### LibraryLanguageVersion

**Kind:** class
**Superclass:** Object

**Fields:**
- `InvalidType package`
- `InvalidType override`

**Getters:**
- `InvalidType get effective`

---

### Metadata

**Kind:** abstract class
**Superclass:** Object

**Getters:**
- `List<ElementAnnotation> get annotations`
- `bool get hasAlwaysThrows`
- `bool get hasAwaitNotRequired`
- `bool get hasDeprecated`
- `bool get hasDoNotStore`
- `bool get hasDoNotSubmit`
- `bool get hasExperimental`
- `bool get hasFactory`
- `bool get hasImmutable`
- `bool get hasInternal`
- `bool get hasIsTest`
- `bool get hasIsTestGroup`
- `bool get hasJS`
- `bool get hasLiteral`
- `bool get hasMustBeConst`
- `bool get hasMustBeOverridden`
- `bool get hasMustCallSuper`
- `bool get hasNonVirtual`
- `bool get hasOptionalTypeArgs`
- `bool get hasOverride`
- `bool get hasProtected`
- `bool get hasRedeclare`
- `bool get hasReopen`
- `bool get hasRequired`
- `bool get hasSealed`
- `bool get hasUseResult`
- `bool get hasVisibleForOverriding`
- `bool get hasVisibleForTemplate`
- `bool get hasVisibleForTesting`
- `bool get hasVisibleOutsideTemplate`
- `bool get hasWidgetFactory`

---

### NamespaceCombinator

**Kind:** abstract class
**Superclass:** Object

**Getters:**
- `int get end`
- `int get offset`

---

### PartInclude

**Kind:** abstract class
**Superclass:** Object
**Implements:** ElementDirective

**Getters:**
- `LibraryFragment? get includedFragment`
- `int get partKeywordOffset`

---

### ShowElementCombinator

**Kind:** abstract class
**Superclass:** Object
**Implements:** NamespaceCombinator

**Getters:**
- `List<String> get shownNames`

---

