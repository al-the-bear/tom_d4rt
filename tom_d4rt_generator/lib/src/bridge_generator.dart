/// Bridge Generator for D4rt BridgedClass implementations.
///
/// Analyzes Dart source files and generates corresponding
/// BridgedClass registrations for use with D4rt interpreter.
library;

// ignore_for_file: curly_braces_in_flow_control_structures
// ignore_for_file: unintended_html_in_doc_comment

import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
// ignore: implementation_imports
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart'
    show AnalysisContextCollectionImpl;
import 'package:glob/glob.dart' as glob_pkg;
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/nullability_suffix.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;

import 'element_mode_extractor.dart';
import 'file_writer.dart';
import 'sdk_utils.dart' show getSdkPath;
import 'user_bridge_scanner.dart';

// =============================================================================
// OPERATOR DETECTION
// =============================================================================

/// Set of Dart binary operator symbols.
/// Used to detect operators in method names for code generation.
const _binaryOperators = {
  '<',
  '>',
  '<=',
  '>=',
  '==',
  '+',
  '-',
  '*',
  '/',
  '~/',
  '%',
  '&',
  '|',
  '^',
  '<<',
  '>>',
  '>>>',
};

/// Generates the appropriate code for calling an operator.
///
/// For binary operators like `<`, generates `(t as dynamic) < positional[0]`
/// by default. When [extensionOnType] is non-null, emits static dispatch
/// (`t < (positional[0] as <onType>)`) instead — required for extension
/// operators because Dart resolves extensions **statically**: dynamic
/// dispatch can never reach an extension method, even if the extension
/// is in scope. (Bucket #14: `WidgetState.a | WidgetState.b` failed with
/// `NoSuchMethodError: Class 'WidgetState' has no instance method '|'`
/// because the previous emission used `as dynamic`.)
///
/// For index operator `[]`, generates `t[positional[0]]`.
/// For index setter `[]=`, generates `t[positional[0]] = positional[1]`.
/// For unary `~`, generates `~t` (already statically dispatched on `t`'s
/// declared type, so it works for extensions without further changes).
///
/// Returns null if the name is not an operator (caller should use normal method call).
String? _generateOperatorCall(
  String operatorName,
  String targetVar, {
  String? extensionOnType,
}) {
  if (_binaryOperators.contains(operatorName)) {
    if (extensionOnType != null) {
      // Static dispatch — required for extension operators. The right
      // operand is cast to the on-type because the typical Flutter
      // extension-operator signature is symmetric (e.g.,
      // `WidgetStateOperators on WidgetStatesConstraint` defines
      // `WidgetStatesConstraint operator |(WidgetStatesConstraint other)`).
      return 'return $targetVar $operatorName (positional[0] as $extensionOnType);';
    }
    // Use dynamic cast to let Dart runtime dispatch handle the operator
    // (correct for native instance operators on the bridged type).
    return 'return ($targetVar as dynamic) $operatorName positional[0];';
  } else if (operatorName == '[]') {
    return 'return $targetVar[positional[0]];';
  } else if (operatorName == '[]=') {
    return '$targetVar[positional[0]] = positional[1]; return null;';
  } else if (operatorName == '~') {
    return 'return ~$targetVar;';
  }
  return null;
}

// =============================================================================
// BRIDGE GENERATOR
// =============================================================================

/// Result of bridge generation.
class BridgeGeneratorResult {
  /// Number of classes that had bridges generated.
  final int classesGenerated;

  /// Number of global functions bridged.
  final int globalFunctionsGenerated;

  /// Number of global variables bridged.
  final int globalVariablesGenerated;

  /// Output files that were written.
  final List<String> outputFiles;

  /// Errors encountered during generation.
  final List<String> errors;

  /// Warnings (non-fatal issues).
  final List<String> warnings;

  /// GEN-076: Names and source URIs of classes that were generated in this module.
  /// Used for cross-module deduplication to prevent a re-exported class
  /// from being registered multiple times across different bridge files.
  /// Key: class name, Value: source file path.
  final Map<String, String> generatedClassSources;

  const BridgeGeneratorResult({
    required this.classesGenerated,
    this.globalFunctionsGenerated = 0,
    this.globalVariablesGenerated = 0,
    required this.outputFiles,
    this.errors = const [],
    this.warnings = const [],
    this.generatedClassSources = const {},
  });
}

/// Information about a class member for bridging.
class MemberInfo {
  final String name;
  final String returnType;
  final Set<String> returnTypeImportUris; // All import URIs for the return type
  final Map<String, String>
  returnTypeToUri; // Map type name -> import URI for prefixing
  final bool isGetter;
  final bool isSetter;
  final bool isMethod;
  final bool isStatic;
  final bool isOperator;
  final List<ParameterInfo> parameters;

  /// Whether the method has type parameters (generics).
  /// These methods are bridged with type erasure (using their bounds).
  final bool hasTypeParameters;

  /// Type parameters and their bounds for this method (e.g., {'T': 'Object', 'E': 'TomObject'}).
  /// Used for type erasure - when a type parameter is encountered in a parameter type,
  /// it's replaced with its bound (or 'dynamic' if no bound).
  final Map<String, String?> methodTypeParameters;

  /// ENG-003: Function type info for setters with callback parameters.
  /// When a setter accepts a function type (e.g., `void Function(TapDownDetails)?`),
  /// this holds the function signature so the emitter can generate proper
  /// InterpretedFunction → native closure wrappers.
  final FunctionTypeInfo? functionTypeInfo;

  const MemberInfo({
    required this.name,
    required this.returnType,
    this.returnTypeImportUris = const {},
    this.returnTypeToUri = const {},
    this.isGetter = false,
    this.isSetter = false,
    this.isMethod = false,
    this.isStatic = false,
    this.isOperator = false,
    this.parameters = const [],
    this.hasTypeParameters = false,
    this.methodTypeParameters = const {},
    this.functionTypeInfo,
  });
}

/// Warning about external types used in class parameters.
/// These types may need wrapper classes for proper bridge support.
class ExternalTypeWarning {
  /// The class containing the external type.
  final String className;

  /// The parameter or field name with the external type.
  final String memberName;

  /// The external type that needs wrapping.
  final String externalType;

  /// The package the external type comes from.
  final String? packageName;

  /// Whether this type is used in a default value.
  final bool isDefaultValue;

  const ExternalTypeWarning({
    required this.className,
    required this.memberName,
    required this.externalType,
    this.packageName,
    this.isDefaultValue = false,
  });

  @override
  String toString() {
    final defaultNote = isDefaultValue ? ' (in default value)' : '';
    final pkg = packageName != null ? ' from $packageName' : '';
    return '$className.$memberName uses external type $externalType$pkg$defaultNote';
  }
}

/// Information about an export directive from a barrel file.
class ExportInfo {
  /// The absolute path to the exported source file.
  final String sourcePath;

  /// Symbols hidden from the export (from `hide` clause).
  final List<String>? hideClause;

  /// Symbols shown from the export (from `show` clause).
  final List<String>? showClause;

  /// The barrel file URI that this export was found in.
  /// Used to determine which import prefix to use for classes from this source.
  final String? barrelUri;

  const ExportInfo({
    required this.sourcePath,
    this.hideClause,
    this.showClause,
    this.barrelUri,
  });

  /// Create a copy with a different barrelUri and/or merged clauses.
  ExportInfo copyWith({
    String? barrelUri,
    List<String>? hideClause,
    List<String>? showClause,
  }) {
    return ExportInfo(
      sourcePath: sourcePath,
      hideClause: hideClause ?? this.hideClause,
      showClause: showClause ?? this.showClause,
      barrelUri: barrelUri ?? this.barrelUri,
    );
  }

  /// Merge this ExportInfo's show/hide clauses with parent clauses.
  ///
  /// The resulting show clause is the intersection of both show clauses.
  /// The resulting hide clause is the union of both hide clauses.
  /// If parent has a show clause and this has a hide clause, the show clause
  /// takes precedence (only symbols in show are visible, minus any hidden).
  ExportInfo mergeWithParent({
    List<String>? parentShowClause,
    List<String>? parentHideClause,
  }) {
    List<String>? mergedShow;
    List<String>? mergedHide;

    // Merge show clauses - result is intersection
    if (parentShowClause != null && showClause != null) {
      // Intersection: only symbols that appear in BOTH
      mergedShow = showClause!
          .where((s) => parentShowClause.contains(s))
          .toList();
    } else if (parentShowClause != null) {
      mergedShow = parentShowClause;
    } else if (showClause != null) {
      mergedShow = showClause;
    }

    // Merge hide clauses - result is union
    if (parentHideClause != null && hideClause != null) {
      // Union: symbols hidden by either
      mergedHide = {...parentHideClause, ...hideClause!}.toList();
    } else if (parentHideClause != null) {
      mergedHide = parentHideClause;
    } else if (hideClause != null) {
      mergedHide = hideClause;
    }

    // If both show and hide exist, apply hide to show
    if (mergedShow != null && mergedHide != null) {
      mergedShow = mergedShow.where((s) => !mergedHide!.contains(s)).toList();
      mergedHide = null; // show clause already incorporates hides
    }

    return ExportInfo(
      sourcePath: sourcePath,
      showClause: mergedShow,
      hideClause: mergedHide,
      barrelUri: barrelUri,
    );
  }

  /// Whether a symbol (class, enum, function, variable, typedef) is exported.
  ///
  /// Returns true if the symbol is not hidden and is included in show clause
  /// (if one exists).
  bool isSymbolExported(String symbolName) {
    if (showClause != null) {
      return showClause!.contains(symbolName);
    }
    if (hideClause != null) {
      return !hideClause!.contains(symbolName);
    }
    return true;
  }

  /// Deprecated: use [isSymbolExported] instead.
  @Deprecated('Use isSymbolExported instead')
  bool isClassExported(String className) => isSymbolExported(className);
}

/// Information about a top-level function for bridging.
class GlobalFunctionInfo {
  final String name;
  final String returnType;

  /// Import URIs needed for the return type.
  final Set<String> returnTypeImportUris;

  /// Map of type name to import URI for resolving return type.
  final Map<String, String> returnTypeToUri;
  final List<ParameterInfo> parameters;
  final String sourceFile;

  /// Whether the function has type parameters (generics).
  final bool hasTypeParameters;

  /// Type parameters and their bounds for this function (e.g., {'T': 'Object', 'E': 'TomObject'}).
  final Map<String, String?> typeParameters;

  const GlobalFunctionInfo({
    required this.name,
    required this.returnType,
    this.returnTypeImportUris = const {},
    this.returnTypeToUri = const {},
    required this.parameters,
    required this.sourceFile,
    this.hasTypeParameters = false,
    this.typeParameters = const {},
  });
}

/// Configuration for a type to use in recursive bound dispatch.
///
/// When generating bridges for functions with recursive type bounds like
/// `T extends Comparable<T>`, the generator creates runtime type dispatch
/// for a limited set of types. This class configures one such type.
class RecursiveBoundType {
  /// The simple type name (e.g., 'TomInt', 'DateTime').
  final String typeName;

  /// The import path for the type, or null for dart:core types.
  /// Format: 'package:package_name/path.dart' or null.
  final String? importPath;

  /// The import prefix to use for this type in generated code.
  /// If null, uses the type name directly (for dart:core types).
  final String? importPrefix;

  const RecursiveBoundType({
    required this.typeName,
    this.importPath,
    this.importPrefix,
  });

  /// Creates a RecursiveBoundType from a simple type name (for dart:core types).
  factory RecursiveBoundType.core(String typeName) =>
      RecursiveBoundType(typeName: typeName);

  /// Creates a RecursiveBoundType from a package import.
  /// Format: 'TypeName' or 'package:path.dart:TypeName'
  factory RecursiveBoundType.fromString(String spec) {
    if (spec.contains(':') && spec.startsWith('package:')) {
      // Format: package:import/path.dart:TypeName
      final lastColon = spec.lastIndexOf(':');
      final importPath = spec.substring(0, lastColon);
      final typeName = spec.substring(lastColon + 1);
      // Generate a prefix from the package name
      final packageMatch = RegExp(r'package:([^/]+)/').firstMatch(importPath);
      final prefix = packageMatch != null
          ? '\$${_toCamelCase(packageMatch.group(1)!)}'
          : null;
      return RecursiveBoundType(
        typeName: typeName,
        importPath: importPath,
        importPrefix: prefix,
      );
    }
    // Simple type name - assume dart:core
    return RecursiveBoundType(typeName: spec);
  }

  /// Converts snake_case to camelCase for import prefixes.
  static String _toCamelCase(String input) {
    final parts = input.split('_');
    return parts.first +
        parts
            .skip(1)
            .map((p) => p.isEmpty ? '' : p[0].toUpperCase() + p.substring(1))
            .join();
  }

  /// Returns the prefixed type name for generated code.
  String get prefixedTypeName =>
      importPrefix != null ? '$importPrefix.$typeName' : typeName;
}

/// Information about a top-level variable for bridging.
class GlobalVariableInfo {
  final String name;
  final String type;

  /// Import URIs needed for the type.
  final Set<String> typeImportUris;

  /// Map of type name to import URI for resolving type.
  final Map<String, String> typeToUri;
  final bool isFinal;
  final bool isConst;
  final bool isGetter;

  /// GEN-054: Whether this getter has a corresponding setter.
  final bool hasSetter;
  final String sourceFile;

  const GlobalVariableInfo({
    required this.name,
    required this.type,
    this.typeImportUris = const {},
    this.typeToUri = const {},
    required this.isFinal,
    required this.isConst,
    this.isGetter = false,
    this.hasSetter = false,
    required this.sourceFile,
  });

  /// Creates a copy with updated hasSetter value.
  GlobalVariableInfo copyWith({bool? hasSetter}) {
    return GlobalVariableInfo(
      name: name,
      type: type,
      typeImportUris: typeImportUris,
      typeToUri: typeToUri,
      isFinal: isFinal,
      isConst: isConst,
      isGetter: isGetter,
      hasSetter: hasSetter ?? this.hasSetter,
      sourceFile: sourceFile,
    );
  }
}

/// Information about an enum for bridging.
class EnumInfo {
  /// The name of the enum.
  final String name;

  /// The names of the enum values.
  final List<String> values;

  /// The source file containing this enum.
  final String sourceFile;

  /// Whether this enum has members (methods, getters, etc.).
  final bool hasMembers;

  /// Instance getter names (custom fields/getters on enhanced enums).
  /// E.g., for `enum Priority { ... final int value; }` → ['value']
  final List<String> getterNames;

  /// Instance method names on enhanced enums.
  /// E.g., for `enum HttpMethod { ... bool canHaveBody() => ...; }` → ['canHaveBody']
  List<String> get methodNames => methodDetails.map((m) => m.name).toList();

  /// RC-7: Detailed method information including parameter types.
  /// Used to generate proper argument coercion in enum method adapters.
  final List<EnumMethodDetail> methodDetails;

  /// RC-8: Static getter names (non-constant static members).
  /// E.g. `WidgetState.any` which is a `static const WidgetStatesConstraint`.
  final List<String> staticGetterNames;

  const EnumInfo({
    required this.name,
    required this.values,
    required this.sourceFile,
    this.hasMembers = false,
    this.getterNames = const [],
    this.methodDetails = const [],
    this.staticGetterNames = const [],
  });
}

/// RC-7: Detailed information about an enum instance method.
///
/// Stores parameter type information so the bridge generator can emit
/// proper argument coercion (e.g., `D4.coerceSet<T>()`) instead of
/// raw `Function.apply`.
class EnumMethodDetail {
  final String name;
  final List<ParameterInfo> parameters;

  const EnumMethodDetail({required this.name, this.parameters = const []});

  /// Whether any parameter requires collection coercion.
  bool get hasCollectionParams => parameters.any(
    (p) =>
        _typeNeedsCoercion(p.type),
  );

  static bool _typeNeedsCoercion(String type) {
    final baseType =
        type.endsWith('?') ? type.substring(0, type.length - 1) : type;
    return baseType.startsWith('Set<') ||
        baseType.startsWith('List<') ||
        baseType.startsWith('Iterable<') ||
        baseType.startsWith('Map<');
  }
}

/// Information about an extension declaration in the source code.
///
/// Collected by [ElementModeExtractor] (extension visitor path) and used
/// to generate `BridgedExtensionDefinition(...)` code.
class ExtensionInfo {
  /// The name of the extension (null for unnamed extensions).
  final String? name;

  /// The name of the type this extension applies to (e.g., 'String', 'DateTime').
  final String onTypeName;

  /// GEN-063: The full type name including generic arguments.
  /// For `extension on List<CommandResult>`, onTypeName is 'List' but
  /// onTypeFullName is 'List<CommandResult>'. Used for proper casting.
  final String? onTypeFullName;

  /// GEN-063: Source URIs for type arguments in the on-type.
  /// Maps type arg name to its source URI for prefix resolution during generation.
  /// e.g., {'CommandResult': 'package:tom_build_cli/src/...'} for List<CommandResult>
  final Map<String, String> onTypeArgUris;

  /// The source URI for the on-type (e.g., 'dart:io' for Platform).
  /// Used to create auxiliary imports when the on-type isn't exported from the barrel.
  final String? onTypeUri;

  /// The source file containing this extension.
  final String sourceFile;

  /// Instance getter names defined in this extension.
  final List<String> getterNames;

  /// Instance setter names defined in this extension.
  final List<String> setterNames;

  /// Instance method names defined in this extension.
  /// @deprecated Use [methods] instead for full parameter info.
  final List<String> methodNames;

  /// Full method info including parameters (for callback wrapping).
  /// GEN-052: Extension methods need parameter info for proper callback wrapping.
  final List<MemberInfo> methods;

  const ExtensionInfo({
    this.name,
    required this.onTypeName,
    this.onTypeFullName,
    this.onTypeArgUris = const {},
    this.onTypeUri,
    required this.sourceFile,
    this.getterNames = const [],
    this.setterNames = const [],
    this.methodNames = const [],
    this.methods = const [],
  });
}

/// Information about a function type signature.
/// Used to generate wrappers for function-type parameters.
class FunctionTypeInfo {
  /// Return type of the function (e.g., 'void', 'String', 'Widget')
  final String returnType;

  /// Whether the return type is nullable
  final bool returnTypeNullable;

  /// List of positional parameter types
  final List<String> positionalParamTypes;

  /// Map of named parameter name to type
  final Map<String, String> namedParamTypes;

  /// Whether named parameters are required (name -> isRequired)
  final Map<String, bool> namedParamRequired;

  /// Function-level generic type parameters and their bounds.
  /// Example for `T Function<T extends Object>(...)`: {'T': 'Object'}
  final Map<String, String?> genericTypeParameters;

  const FunctionTypeInfo({
    required this.returnType,
    this.returnTypeNullable = false,
    this.positionalParamTypes = const [],
    this.namedParamTypes = const {},
    this.namedParamRequired = const {},
    this.genericTypeParameters = const {},
  });

  /// Whether the function returns void
  bool get isVoid => returnType == 'void';

  /// Total number of parameters
  int get paramCount => positionalParamTypes.length + namedParamTypes.length;

  /// Whether this function has any parameters
  bool get hasParams => paramCount > 0;
}

/// Information about a method parameter.
class ParameterInfo {
  final String name;
  final String type;
  final Set<String>
  typeImportUris; // All import URIs for this type (including generic args)
  final Map<String, String>
  typeToUri; // Map type name -> import URI for prefixing
  final bool isRequired;
  final bool isNamed;
  final String? defaultValue;

  /// Whether this type is a function type alias (typedef for a function type).
  /// Function types can't be passed from D4rt scripts, so we use dynamic.
  final bool isFunctionTypeAlias;

  /// Detailed function type info if this parameter is a function type.
  /// Used to generate proper wrappers for InterpretedFunction.
  final FunctionTypeInfo? functionTypeInfo;

  const ParameterInfo({
    required this.name,
    required this.type,
    this.typeImportUris = const {},
    this.typeToUri = const {},
    this.isRequired = true,
    this.isNamed = false,
    this.defaultValue,
    this.isFunctionTypeAlias = false,
    this.functionTypeInfo,
  });

  /// Whether this parameter is a function type that can be wrapped
  bool get isFunctionType => functionTypeInfo != null;
}

/// Information about a constructor.
class ConstructorInfo {
  final String? name; // null for default constructor
  final List<ParameterInfo> parameters;
  final bool isFactory;
  final bool isConst;

  const ConstructorInfo({
    this.name,
    required this.parameters,
    this.isFactory = false,
    this.isConst = false,
  });
}

/// Parsed class information for bridge generation.
class ClassInfo {
  final String name;
  final String? superclass;

  /// The package URI of the superclass (e.g., 'package:tom_basics/tom_basics.dart').
  /// Used for resolving inherited members from external packages.
  final String? superclassUri;

  final bool isAbstract;

  /// GEN-051: Sealed classes cannot be directly instantiated.
  /// Like abstract classes, they should not have bridge constructors.
  final bool isSealed;

  /// Whether this class was declared as a pure `mixin` (not a `mixin class`).
  /// Used to force abstractness in the generated bridge — pure mixins cannot
  /// be instantiated.
  final bool isMixin;

  /// Whether this class can be used as a mixin in a `with` clause.
  ///
  /// True for:
  ///   * Pure mixin declarations (`mixin Foo`).
  ///   * Mixin classes (`mixin class Foo`, `abstract mixin class Foo`) —
  ///     detected via `ClassElement.isMixinClass`.
  ///
  /// Maps directly to `BridgedClass.canBeUsedAsMixin` in the generated
  /// registration. Without this flag, scripts that do
  /// `class Foo with WidgetsBindingObserver` fail at runtime with
  /// "Bridged class 'X' cannot be used as a mixin".
  final bool canBeUsedAsMixin;

  final List<ConstructorInfo> constructors;
  final List<MemberInfo> members;
  final String sourceFile;

  /// Maps generic type parameter names to their bounds.
  /// E.g., for `class TomList<E extends TomObject>`, this is `{'E': 'TomObject'}`.
  /// Type parameters without bounds map to `null` (treated as `dynamic`).
  final Map<String, String?> typeParameters;

  /// GEN-075-FIX: All supertype names (from extends, with, implements — transitive).
  /// Populated from the resolved element's `allSupertypes` when available.
  /// Used to sort GEN-075 switch cases most-specific-first so that
  /// `case SubClass _:` appears before `case SuperClass _:`.
  final Set<String> allSupertypeNames;

  const ClassInfo({
    required this.name,
    required this.sourceFile,
    this.superclass,
    this.superclassUri,
    this.isAbstract = false,
    this.isSealed = false,
    this.isMixin = false,
    this.canBeUsedAsMixin = false,
    this.constructors = const [],
    this.members = const [],
    this.typeParameters = const {},
    this.allSupertypeNames = const {},
  });

  /// Gets all getters (instance and static).
  List<MemberInfo> get getters => members.where((m) => m.isGetter).toList();

  /// Gets all setters (instance and static).
  List<MemberInfo> get setters => members.where((m) => m.isSetter).toList();

  /// Gets all methods (instance and static).
  List<MemberInfo> get methods => members.where((m) => m.isMethod).toList();

  /// Gets instance getters.
  List<MemberInfo> get instanceGetters =>
      members.where((m) => m.isGetter && !m.isStatic).toList();

  /// Gets instance setters.
  List<MemberInfo> get instanceSetters =>
      members.where((m) => m.isSetter && !m.isStatic).toList();

  /// Gets instance methods.
  List<MemberInfo> get instanceMethods =>
      members.where((m) => m.isMethod && !m.isStatic).toList();

  /// Gets instance operators.
  List<MemberInfo> get instanceOperators =>
      members.where((m) => m.isOperator && !m.isStatic).toList();

  /// Gets static members.
  List<MemberInfo> get staticMembers =>
      members.where((m) => m.isStatic).toList();

  /// Gets all instance getters including inherited ones from superclasses.
  List<MemberInfo> allInstanceGetters(Map<String, ClassInfo> classLookup) {
    final result = <String, MemberInfo>{};
    _collectInheritedMembers(classLookup, (cls) => cls.instanceGetters, result);
    return result.values.toList();
  }

  /// Gets all instance setters including inherited ones from superclasses.
  List<MemberInfo> allInstanceSetters(Map<String, ClassInfo> classLookup) {
    final result = <String, MemberInfo>{};
    _collectInheritedMembers(classLookup, (cls) => cls.instanceSetters, result);
    return result.values.toList();
  }

  /// Gets all instance methods including inherited ones from superclasses.
  List<MemberInfo> allInstanceMethods(Map<String, ClassInfo> classLookup) {
    final result = <String, MemberInfo>{};
    _collectInheritedMembers(classLookup, (cls) => cls.instanceMethods, result);
    return result.values.toList();
  }

  /// Gets all instance operators including inherited ones from superclasses.
  List<MemberInfo> allInstanceOperators(Map<String, ClassInfo> classLookup) {
    // Use a key that distinguishes by arity to prevent unary/binary clash
    final result = <String, MemberInfo>{};
    _collectInheritedOperators(classLookup, result);
    return result.values.toList();
  }

  /// Collects operators from this class and all superclasses.
  /// Uses a key that includes arity to distinguish unary from binary operators.
  void _collectInheritedOperators(
    Map<String, ClassInfo> classLookup,
    Map<String, MemberInfo> result,
  ) {
    // First collect from superclass (if any)
    if (superclass != null && classLookup.containsKey(superclass)) {
      classLookup[superclass]!._collectInheritedOperators(classLookup, result);
    }
    // Then add/override with this class's operators
    for (final op in instanceOperators) {
      // Use arity-aware key: "- (0)" for unary, "- (1)" for binary
      final key = '${op.name} (${op.parameters.length})';
      result[key] = op;
    }
  }

  /// Collects members from this class and all superclasses.
  /// Child class members override parent class members with same name.
  void _collectInheritedMembers(
    Map<String, ClassInfo> classLookup,
    List<MemberInfo> Function(ClassInfo) memberSelector,
    Map<String, MemberInfo> result,
  ) {
    // First collect from superclass (if any)
    if (superclass != null && classLookup.containsKey(superclass)) {
      classLookup[superclass]!._collectInheritedMembers(
        classLookup,
        memberSelector,
        result,
      );
    }
    // Then add/override with this class's members
    for (final member in memberSelector(this)) {
      result[member.name] = member;
    }
  }
}

/// Information about an external type dependency.
class ExternalTypeDependency {
  /// The type name (e.g., 'TomLogger').
  final String typeName;

  /// The package URI (e.g., 'package:tom_core_kernel/tom_core_kernel.dart').
  final String packageUri;

  /// The class that uses this type.
  final String referencedBy;

  /// How the type is used (parameter, return type, field).
  final String usageContext;

  const ExternalTypeDependency({
    required this.typeName,
    required this.packageUri,
    required this.referencedBy,
    required this.usageContext,
  });

  @override
  String toString() =>
      '$typeName from $packageUri (used by $referencedBy in $usageContext)';

  @override
  bool operator ==(Object other) =>
      other is ExternalTypeDependency &&
      other.typeName == typeName &&
      other.packageUri == packageUri;

  @override
  int get hashCode => Object.hash(typeName, packageUri);
}

/// Information about an auxiliary import needed for types used in defaults/parameters
/// that aren't directly exported from the barrel.
class AuxiliaryImport {
  /// The URI to import (e.g., 'package:dcli/src/functions/menu.dart').
  final String uri;

  /// The type names available from this import.
  final Set<String> typeNames;

  /// The prefix to use for this import in generated code.
  String? prefix;

  AuxiliaryImport({required this.uri, required this.typeNames, this.prefix});

  @override
  bool operator ==(Object other) =>
      other is AuxiliaryImport && other.uri == uri;

  @override
  int get hashCode => uri.hashCode;
}

/// Converts a snake_case or lowercase string to PascalCase.
///
/// Examples:
/// - 'tom_core_kernel' -> 'TomCoreKernel'
/// - 'all' -> 'All'
/// - 'myModule' -> 'MyModule'
String toPascalCase(String input) {
  if (input.isEmpty) return input;
  return input
      .split('_')
      .map((w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '')
      .join();
}

/// Maps private/internal Dart SDK libraries to their public equivalents.
///
/// Private SDK libraries (prefixed with dart:_) are internal implementation
/// details and should not be imported directly. This function returns the
/// public library that exports the same types.
///
/// Returns null if the library should be skipped entirely.
///
/// The [warnCallback] is called for unknown private libraries that are mapped
/// to null. This helps users identify libraries that may need explicit mapping.
String? mapPrivateSdkLibrary(
  String uri, {
  void Function(String)? warnCallback,
}) {
  if (!uri.startsWith('dart:_')) return uri;

  // Map known private libraries to public equivalents
  // This covers common SDK private libraries
  const privateToPublic = <String, String?>{
    // Core I/O and platform
    'dart:_http': 'dart:io',
    'dart:_platform': 'dart:io',

    // Typed data and byte handling
    'dart:_native_typed_data': 'dart:typed_data',
    'dart:_typed_data': 'dart:typed_data',

    // Async primitives
    'dart:_async': 'dart:async',

    // Collections
    'dart:_collection_wrappers': 'dart:collection',
    'dart:_collection_dev': 'dart:collection',

    // Convert - encoding/decoding
    'dart:_convert': 'dart:convert',

    // Math
    'dart:_math': 'dart:math',

    // Isolates
    'dart:_isolate': 'dart:isolate',

    // Mirrors (if available)
    'dart:_mirrors': 'dart:mirrors',

    // Developer tools
    'dart:_developer': 'dart:developer',

    // Internal utilities - skip (rarely needed in user code)
    'dart:_internal': null,
    'dart:_compact_hash': null,
    'dart:_late_helper': null,

    // JS interop internals - skip
    'dart:_interceptors': null,
    'dart:_js_helper': null,
    'dart:_js_primitives': null,
    'dart:_js_types': null,
    'dart:_js_annotations': null,
    'dart:_foreign_helper': null,

    // Native/FFI internals - skip
    'dart:_ffi': null,
    'dart:_native_wrappers': null,

    // WASM (future-proofing) - skip for now
    'dart:_wasm': null,
  };

  if (privateToPublic.containsKey(uri)) {
    return privateToPublic[uri];
  }

  // For unknown private libraries, warn and skip them
  // These are typically internal implementation details
  warnCallback?.call(
    'Unknown private SDK library: $uri - type will be mapped to dynamic',
  );
  return null;
}

/// Normalizes a library identifier to its canonical `dart:` URI where the SDK
/// library is actually sourced from an embedder package.
///
/// Flutter ships `dart:ui` via `package:sky_engine/ui/ui.dart`. When the
/// analyzer resolves types from a summary bundle or from the embedder source
/// tree directly, `LibraryElement.identifier` reports the embedder URI
/// (`package:sky_engine/ui/ui.dart`) rather than the canonical `dart:ui`.
/// If the bridge emitter lets that URI flow through to generated imports,
/// the resulting file ends up with *both* `dart:ui` and
/// `package:sky_engine/ui/ui.dart`, and the CFE treats those as distinct
/// libraries — so identical types (`Scene`, `TextStyle`, `Offset`, …) become
/// incompatible across call sites and every cross-call fails to type-check.
///
/// This helper maps the known embedder URIs back to their canonical form so
/// that both the AST walker and the element walker emit a single import.
/// Only well-known mappings are applied — any unrecognised URI is returned
/// unchanged.
String normalizeLibraryIdentifier(String uri) {
  // `package:sky_engine/ui/ui.dart` is the on-disk implementation of
  // `dart:ui`. Other `package:sky_engine/*` URIs (internal Dart SDK sources
  // like `package:sky_engine/core/…`) are not in general 1:1 with `dart:`
  // libraries, so we only normalize the ui barrel here. The private
  // `dart:_` → `dart:` mapping in `mapPrivateSdkLibrary` takes care of
  // the rest of the SDK.
  if (uri == 'package:sky_engine/ui/ui.dart') return 'dart:ui';
  return uri;
}

/// A generic extraction site discovered during bridge code generation.
///
/// Recorded whenever the generator emits a `D4.extractBridgedArg<Base<Arg>>`
/// or similar helper call where the type argument is itself generic.
/// Used by the relaxer generator to build wrapper classes and factory functions
/// without post-processing regex scanning.
class GenericExtractionSite {
  /// The generic base type name (unqualified, e.g., 'ValueNotifier').
  final String baseTypeName;

  /// The inner type argument (unqualified, e.g., 'MagnifierInfo', 'Color?').
  final String typeArg;

  /// The module this extraction was generated in.
  final String moduleName;

  const GenericExtractionSite({
    required this.baseTypeName,
    required this.typeArg,
    required this.moduleName,
  });

  @override
  String toString() =>
      'GenericExtractionSite($baseTypeName<$typeArg>, module: $moduleName)';
}

/// Generates D4rt BridgedClass implementations from Dart source files.
class BridgeGenerator {
  /// Workspace root path.
  final String workspacePath;

  /// Package name for imports (e.g., 'tom_build').
  final String? packageName;

  /// Import path for helper functions.
  final String helpersImport;

  /// Import path for the core D4rt runtime package.
  ///
  /// Defaults to `package:tom_d4rt/d4rt.dart`.
  /// Override when using an alternative D4rt runtime like `package:tom_d4rt_exec/d4rt.dart`.
  final String d4rtImport;

  /// Barrel file import path for source code (e.g., 'src/tom/tom.dart').
  /// If provided, this import is used in the generated file for accessing classes.
  /// @deprecated Use [sourceImports] instead for multiple barrel support.
  final String? sourceImport;

  /// Multiple barrel file import paths for source code.
  /// Each barrel is imported with a unique prefix ($pkg, $pkg2, etc.).
  /// When set, [sourceImport] is ignored.
  final List<String> sourceImports;

  /// Map of source file path to barrel file URI.
  /// Used to resolve which barrel exports each source file.
  final Map<String, String> sourceFileToBarrel;

  /// Mutable internal map of source file path to barrel URI.
  /// Built dynamically from exportInfo during bridge generation.
  /// Takes precedence over [sourceFileToBarrel] when populated.
  final Map<String, String> _dynamicSourceFileToBarrel = {};

  /// Whether to generate read-only bridges.
  final bool readOnly;

  /// Whether to skip private members.
  final bool skipPrivate;

  /// Whether to output verbose information.
  final bool verbose;

  /// Whether to emit `?? default` coercion for known VM↔web signature-skew
  /// parameters (B5/R6). See [_vmWebSkewNonNullParams].
  ///
  /// Defaults to `false` so committed `*.b.dart` output stays byte-identical
  /// until a deliberate regeneration enables it. The hand-written
  /// `SceneBuilderUserBridge.overrideMethodPushOpacity` currently covers the
  /// only concrete skew; flipping this flag on (and regenerating) retires that
  /// override.
  final bool enableVmWebSkewCoercion;

  /// External types that require wrapper classes (detected during generation).
  final List<ExternalTypeWarning> externalTypeWarnings = [];

  /// Non-wrappable defaults encountered during generation.
  /// Each entry contains context about where the non-wrappable default was found.
  final List<String> _nonWrappableDefaultWarnings = [];

  /// Missing exports encountered during generation.
  /// Tracks types that are used but not exported from the barrel file.
  final List<String> _missingExportWarnings = [];

  /// Skip reports for elements that were not bridged.
  /// Each entry clearly explains what was skipped and why.
  final List<String> _skipReports = [];

  /// Set of class/enum names that are exported from the barrel file.
  /// Built during bridge file generation from the export info.
  Set<String> _exportedTypeNames = {};

  /// Cached analysis context collection for resolved analysis.
  AnalysisContextCollection? _analysisContext;

  /// Phase 4 / summary-refactoring-plan: expose the primary analysis
  /// context so downstream stages (notably `generateProxies` in
  /// `proxy_generator.dart`) can reuse it instead of building a second
  /// summary-loaded [AnalysisContextCollectionImpl] per project.
  ///
  /// Lazily initializes the context on first access, matching
  /// [_getAnalysisContext]'s behavior. Returns the same instance on every
  /// call so summary bundles are loaded exactly once.
  AnalysisContextCollection getOrCreateAnalysisContext() =>
      _getAnalysisContext();

  /// Class lookup map for resolving superclass inheritance.
  /// Built during bridge file generation.
  Map<String, ClassInfo> _classLookup = {};

  /// Read-only view of the class lookup built during bridge generation.
  ///
  /// Populated after [generateBridgesFromExports] or [parseFile] is called.
  /// Used by the relaxer generator to build wrapper classes with correct
  /// member delegation.
  Map<String, ClassInfo> get classLookup => Map.unmodifiable(_classLookup);

  /// GEN-079: Generic extraction sites collected during bridge code generation.
  ///
  /// Each entry records a `D4.extractBridgedArg<Base<Arg>>` (or similar helper)
  /// call site where the type argument is itself generic. Populated during
  /// [generateBridgesFromExports] and consumed by the relaxer generator.
  final List<GenericExtractionSite> _genericExtractionSites = [];

  /// Read-only view of generic extraction sites collected during generation.
  List<GenericExtractionSite> get genericExtractionSites =>
      List.unmodifiable(_genericExtractionSites);

  /// GEN-079: Class names that have GEN-075 type-dispatch constructor switches.
  ///
  /// Populated during constructor body generation when a type-dispatch switch
  /// is emitted. Used by the relaxer generator to know which classes are
  /// constructed with runtime type inference.
  final Set<String> _gen075Classes = {};

  /// Read-only view of classes with GEN-075 type-dispatch switches.
  Set<String> get gen075Classes => Set.unmodifiable(_gen075Classes);

  /// GEN-079: The current module name during bridge generation.
  ///
  /// Set at the start of [generateBridges] and used by [_recordResolvedGenericType]
  /// to tag extraction sites with their source module.
  String? _currentModuleName;

  /// Constructors to drop during emission, qualified as `ClassName.ctorName`
  /// (with `ClassName.new` for the default constructor).
  ///
  /// Set at the start of [generateBridges] / [generateBridgesWithWriter] from
  /// the module's `excludeConstructors` config and consulted in
  /// [_emitClassBridge] so a single constructor can be pruned while the class
  /// is otherwise bridged. See [ModuleConfig.excludeConstructors].
  Set<String> _excludeConstructors = const {};

  /// Cache for resolved type arguments to prevent redundant resolution.
  /// Key is the full type string, value is the resolved result.
  /// This cache is cleared at the start of each bridge file generation.
  final Map<String, String> _typeResolutionCache = {};

  /// Set of type strings currently being resolved, to detect recursive type bounds.
  /// Used to prevent infinite recursion when resolving types like `T extends Comparable<T>`.
  final Set<String> _typeResolutionInProgress = {};

  /// External type dependencies collected during parsing.
  final Set<ExternalTypeDependency> _externalDependencies = {};

  /// Auxiliary imports needed for types used in default values, parameters, etc.
  /// that aren't directly exported from the barrel but are available via source file imports.
  /// Key is the import URI, value is the set of type names from that import.
  final Map<String, Set<String>> _auxiliaryImports = {};

  /// Prefixes assigned to auxiliary imports.
  /// Key is the import URI, value is the prefix to use.
  final Map<String, String> _auxiliaryPrefixes = {};

  /// Sentinel bound value used for function-level generic parameters.
  /// These params must be preserved as type variables (e.g., `T`) instead of
  /// being resolved to `dynamic` or their upper bound.
  static const String _functionGenericParamSentinel = '__D4RT_FUNC_GENERIC__';

  /// Map of source file path to its imports.
  /// Used to resolve types that aren't exported from the barrel but are used in defaults.
  /// Key is the normalized source file path, value is a map of type name to import URI.
  final Map<String, Map<String, String>> _sourceFileImports = {};

  /// GEN-107 Phase 2: Map of source file path to the list of `export …`
  /// directives declared by that library (re-exports). Each entry mirrors
  /// one Dart `export` directive and is keyed by the same path that
  /// [_sourceFileImports] uses.
  ///
  /// Populated by [_collectSourceFileReExportsFromElement] alongside
  /// [_collectSourceFileImportsFromElement]. Consumed by
  /// [_generateBridgeFile] to emit `bridgeReExports()` factories and
  /// `registerLibraryReExport(...)` calls so that `tom_d4rt_ast`'s
  /// per-module `AstModuleLoader` can merge re-exported bridges into the
  /// re-exporting library's environment.
  final Map<String,
          List<({String uri, Set<String>? show, Set<String>? hide})>>
      _sourceFileReExports = {};

  /// Map of typedef names to their expanded function type signatures.
  /// Used to fall back to the definition when a typedef is not exported from the barrel.
  /// Key is the typedef name, value is the expanded signature (e.g., 'Object? Function(Object?)').
  final Map<String, String> _typedefExpansions = {};

  /// GEN-074: Type alias records for class aliases (non-function typedefs).
  /// Key: alias name, Value: target class name.
  /// Example: 'MaterialStateProperty' -> 'WidgetStateProperty'
  final Map<String, String> _typeAliases = {};

  /// GEN-017: Global registry of type name → package URI mappings, populated
  /// from the resolved AST during visitor phase via `_collectInfoFromDartType()`.
  /// Used as a penultimate fallback in `_resolveTypeArgument()` before `dynamic`,
  /// so that types the analyzer fully resolves are never silently downgraded.
  final Map<String, String> _globalTypeToUri = {};

  /// Maps part-of file URIs to their parent library URIs.
  /// When a source file has `part of ...;`, it can't be imported directly.
  /// Types/functions from part-of files are accessible via the parent library.
  Map<String, String> _partOfToParent = {};

  /// Packages to follow for external type dependencies.
  /// Format: package names without 'package:' prefix (e.g., ['tom_core_kernel', 'tom_core_server'])
  List<String> followPackages = [];

  /// Optional analyzer-summary (`.sum`) paths for stable dependencies.
  ///
  /// Populated by the summary-cache stage
  /// (`package:tom_analyzer_shared`). When non-empty, the internal
  /// [AnalysisContextCollectionImpl] is built with `librarySummaryPaths:
  /// librarySummaryPaths` so hosted/SDK packages load from those
  /// bundles instead of being re-scanned from disk on every bridge
  /// generation run.
  final List<String>? librarySummaryPaths;

  /// Optional pre-built SDK summary `.sum` path.
  ///
  /// Pairs with [librarySummaryPaths]. When non-null, the context
  /// receives `sdkSummaryPath: sdkSummaryPath` and `sdkPath` is left
  /// unset so the analyzer reads `dart:core` (and, with the Flutter
  /// embedder, `dart:ui`) from the summary bundle.
  final String? sdkSummaryPath;

  /// External class lookup for cross-package inheritance resolution.
  /// Set this before generating bridges to include classes from other packages
  /// in the inheritance lookup (e.g., TomBaseException for TomException).
  /// Key is class name, value is ClassInfo from the external package.
  Map<String, ClassInfo> externalClassLookup = {};

  /// Whether to generate bridging code for deprecated elements.
  /// When false (default), deprecated elements are skipped and counted.
  /// Set this before calling generate methods if needed.
  bool generateDeprecatedElements = false;

  /// A.5: per-symbol opt-in for deprecated elements. A deprecated element is
  /// emitted when [generateDeprecatedElements] is true OR its simple name is in
  /// this set. Empty by default ⇒ historical behaviour (all deprecated skipped).
  Set<String> deprecatedAllowlist = {};

  /// B.14: when true, void bridged callbacks are emitted as `async` closures
  /// that `await Future.delayed(const Duration(milliseconds: 1))` after invoking
  /// the interpreted callback. This hands a slice of the event loop back to the
  /// embedder during long synchronous interpreted runs (e.g. `Timer.periodic`
  /// game ticks), so queued keyboard/gesture input is no longer starved. A
  /// `Future<void> Function(...)` is assignable to a `void Function(...)` slot,
  /// so native APIs still accept the wrapped callback. Off by default ⇒ the
  /// historical synchronous wrapper (generated output is byte-identical), so
  /// flip it on for the `tom_d4rt_flutter*` configs only — CLI/build scripting
  /// keeps its sync throughput.
  bool yieldVoidCallbacks = false;

  /// Counter for skipped deprecated elements (for reporting).
  int skippedDeprecatedCount = 0;

  /// User bridge scanner for detecting UserBridge override classes.
  /// Can be injected externally to share user bridge data across generators.
  late final UserBridgeScanner _userBridgeScanner;

  /// Expose user bridge scanner for testing.
  UserBridgeScanner get userBridgeScanner => _userBridgeScanner;

  /// B.14: builds a closure literal that invokes an interpreted callback whose
  /// return value is discarded (a void bridged callback).
  ///
  /// [params] is the comma-joined typed parameter list (without surrounding
  /// parentheses); [callExpr] is the `D4.callInterpreterCallback(...)`
  /// expression. When [yieldVoidCallbacks] is on and [isVoidCallback] is true,
  /// the closure is `async` and yields 1 ms after the call so the embedder can
  /// pump input/frames; otherwise the historical synchronous closure is emitted
  /// (byte-identical output).
  String _voidCallbackClosure(
    String params,
    String callExpr, {
    required bool isVoidCallback,
  }) {
    if (yieldVoidCallbacks && isVoidCallback) {
      return '($params) async { $callExpr; '
          'await Future.delayed(const Duration(milliseconds: 1)); }';
    }
    return '($params) { $callExpr; }';
  }

  /// Types to use for runtime dispatch when handling recursive type bounds.
  ///
  /// When a function has a type parameter with a recursive bound like
  /// `T extends Comparable<T>`, Dart cannot infer the type at runtime.
  /// The generator uses runtime type dispatch for these built-in types:
  /// `int`, `double`, `num`, `String`, `bool`, `DateTime`.
  ///
  /// Add custom types here to extend the dispatch. Each entry should be
  /// in the format 'TypeName' or 'package:import/path.dart:TypeName' for
  /// types that require imports.
  ///
  /// Example: ['TomInt', 'package:tom_core_kernel/tom_core_kernel.dart:TomDouble']
  List<RecursiveBoundType> recursiveBoundTypes = [];

  /// Default types for recursive bound dispatch.
  ///
  /// Note: Only types that actually implement Comparable<T> where T is themselves.
  /// - `num` works (int and double are subtypes of num)
  /// - `String` works (implements Comparable<String>)
  /// - `DateTime` works (implements Comparable<DateTime>)
  /// - `Duration` works (implements Comparable<Duration>)
  /// - `BigInt` works (implements Comparable<BigInt>)
  /// - `int` does NOT work (implements Comparable<num>, not Comparable<int>)
  /// - `double` does NOT work (implements Comparable<num>, not Comparable<double>)
  /// - `bool` does NOT work (doesn't implement Comparable at all)
  static const List<String> _defaultRecursiveBoundTypes = [
    'num',
    'String',
    'DateTime',
    'Duration',
    'BigInt',
  ];

  /// Gets or creates the analysis context collection.
  ///
  /// For cross-package bridge generation, the context needs to include
  /// paths for external packages. Use [_getAnalysisContextFor] to get
  /// a context that includes a specific file path.
  ///
  /// When [librarySummaryPaths] and/or [sdkSummaryPath] are provided
  /// (typically by the summary-cache stage from
  /// `package:tom_analyzer_shared`), the context is constructed via
  /// [AnalysisContextCollectionImpl] so it can load those `.sum`
  /// bundles instead of re-scanning dependency sources from disk.
  AnalysisContextCollection _getAnalysisContext() {
    // Ensure workspacePath is absolute AND normalized for the analyzer.
    // `AnalysisContextCollection*` rejects non-normalized `includedPaths`
    // ("Only absolute normalized paths are supported"). On Windows an
    // already-absolute path like `C:/Code/...` (forward slashes) is NOT
    // normalized per the host (Windows) path context, so it must be run
    // through `p.normalize` to become `C:\Code\...`. Skipping this caused
    // every external file to fail resolution → 0 classes generated → stale
    // bridge files left in place on Windows.
    final absoluteWorkspacePath = p.normalize(
      p.isAbsolute(workspacePath)
          ? workspacePath
          : p.join(Directory.current.path, workspacePath),
    );
    if (_analysisContext != null) return _analysisContext!;

    final hasSummaries = (librarySummaryPaths != null &&
            librarySummaryPaths!.isNotEmpty) ||
        sdkSummaryPath != null;
    if (hasSummaries) {
      _analysisContext = AnalysisContextCollectionImpl(
        includedPaths: [absoluteWorkspacePath],
        sdkPath: sdkSummaryPath == null ? getSdkPath() : null,
        sdkSummaryPath: sdkSummaryPath,
        librarySummaryPaths: librarySummaryPaths ?? const [],
      );
    } else {
      _analysisContext = AnalysisContextCollection(
        includedPaths: [absoluteWorkspacePath],
        sdkPath: getSdkPath(),
      );
    }
    return _analysisContext!;
  }

  /// Cache for analysis contexts per package path.
  /// This allows analyzing files from multiple packages in cross-package generation.
  final Map<String, AnalysisContextCollection> _packageAnalysisContexts = {};

  /// Gets or creates an analysis context that includes the given file path.
  ///
  /// This is essential for cross-package bridge generation where source files
  /// may come from different packages (e.g., generating bridges for tom_core_kernel
  /// from within tom_dartscript_bridges).
  ///
  /// Prefers the main workspace context because it has the project's full
  /// package_config.json which resolves all transitive dependencies. This is
  /// critical for .pub-cache files that import other packages (e.g., dcli's
  /// digest_helper.dart importing package:crypto).
  AnalysisContextCollection _getAnalysisContextFor(String filePath) {
    // Try the main workspace context first — it has full dependency resolution
    final mainContext = _getAnalysisContext();
    try {
      mainContext.contextFor(filePath);
      return mainContext;
    } catch (_) {
      // File not reachable from main context, fall through to per-package context
    }

    // Find the package root for this file
    // Walk up until we find a pubspec.yaml
    var dir = p.dirname(filePath);
    String? packageRoot;
    while (dir.isNotEmpty && dir != p.dirname(dir)) {
      if (File(p.join(dir, 'pubspec.yaml')).existsSync()) {
        packageRoot = dir;
        break;
      }
      dir = p.dirname(dir);
    }

    // Fallback to the file's parent directory if no package root found
    packageRoot ??= p.dirname(filePath);

    // Get or create a context for this package root
    if (!_packageAnalysisContexts.containsKey(packageRoot)) {
      // GEN-069: Use the workspace's package_config.json when creating the
      // per-package context. This is critical for Flutter SDK files: the Flutter
      // package does not have its own .dart_tool/package_config.json, so the
      // per-package context cannot resolve dart:ui (provided by sky_engine).
      // Using the workspace's package config gives the context access to all
      // transitive dependencies including sky_engine, making dart:ui types like
      // Color, Offset, and Size resolve correctly to dart:ui instead of being
      // reported as InvalidType.
      final wsPackageConfig = File(
        p.normalize(
          p.join(
            p.isAbsolute(workspacePath)
                ? workspacePath
                : p.join(Directory.current.path, workspacePath),
            '.dart_tool',
            'package_config.json',
          ),
        ),
      );
      final packageConfigFile = wsPackageConfig.existsSync()
          ? wsPackageConfig.path
          : null;
      // Forward any shared summaries to the per-package context so
      // dart:core / dart:ui (via sdkSummaryPath) and hosted-package
      // types resolve from .sum bundles instead of being re-scanned.
      final hasSummaries = (librarySummaryPaths != null &&
              librarySummaryPaths!.isNotEmpty) ||
          sdkSummaryPath != null;
      _packageAnalysisContexts[packageRoot] = AnalysisContextCollectionImpl(
        includedPaths: [packageRoot],
        sdkPath: hasSummaries && sdkSummaryPath != null ? null : getSdkPath(),
        sdkSummaryPath: sdkSummaryPath,
        librarySummaryPaths:
            hasSummaries ? (librarySummaryPaths ?? const []) : const [],
        packageConfigFile: packageConfigFile,
      );
    }

    return _packageAnalysisContexts[packageRoot]!;
  }

  /// Cache for resolved package paths.
  final Map<String, String?> _packagePathCache = {};

  /// Synchronously-built map of package name → package root directory, parsed
  /// once from `.dart_tool/package_config.json`. `null` until first access,
  /// then an (possibly empty) map. Used by [_packageRootSync] so that
  /// synchronous resolvers (e.g. [_getFilePathForPackageUri]) get the same
  /// authoritative resolution as the async [_resolvePackagePath].
  Map<String, String>? _packageConfigRoots;

  /// Returns the package root directory for [packageName] using
  /// `.dart_tool/package_config.json`, or `null` if not found. Synchronous and
  /// cached. Unlike the hardcoded sub-workspace search this covers every
  /// package the resolution graph knows about (including `distributed/`).
  String? _packageRootSync(String packageName) {
    var roots = _packageConfigRoots;
    if (roots == null) {
      roots = <String, String>{};
      final packageConfigFile = File(
        '$workspacePath/.dart_tool/package_config.json',
      );
      if (packageConfigFile.existsSync()) {
        try {
          final json =
              jsonDecode(packageConfigFile.readAsStringSync())
                  as Map<String, dynamic>;
          final packages = json['packages'] as List<dynamic>?;
          if (packages != null) {
            for (final pkg in packages) {
              final name = pkg['name'] as String?;
              var rootUri = pkg['rootUri'] as String?;
              if (name == null || rootUri == null) continue;
              if (rootUri.startsWith('file://')) {
                rootUri = Uri.parse(rootUri).toFilePath();
              } else {
                // rootUri is relative to the .dart_tool directory.
                rootUri = p.normalize(
                  p.join(workspacePath, '.dart_tool', rootUri),
                );
              }
              roots[name] = rootUri;
            }
          }
        } catch (e) {
          if (verbose) print('Error reading package_config.json: $e');
        }
      }
      _packageConfigRoots = roots;
    }
    return roots[packageName];
  }

  /// Resolves a package name to its root directory path.
  ///
  /// Uses `.dart_tool/package_config.json` for reliable resolution,
  /// falling back to sibling directories and pubspec.yaml path dependencies.
  ///
  /// Returns the package root directory path (without /lib), or null if not found.
  Future<String?> _resolvePackagePath(String packageName) async {
    // Check cache first
    if (_packagePathCache.containsKey(packageName)) {
      return _packagePathCache[packageName];
    }

    String? result;

    // Try to read from .dart_tool/package_config.json (most reliable)
    final packageConfigFile = File(
      '$workspacePath/.dart_tool/package_config.json',
    );
    if (packageConfigFile.existsSync()) {
      try {
        final content = await packageConfigFile.readAsString();
        final json = jsonDecode(content) as Map<String, dynamic>;
        final packages = json['packages'] as List<dynamic>?;
        if (packages != null) {
          for (final pkg in packages) {
            if (pkg['name'] == packageName) {
              var rootUri = pkg['rootUri'] as String;
              // rootUri is relative to .dart_tool directory
              if (rootUri.startsWith('../')) {
                rootUri = p.normalize(
                  p.join(workspacePath, '.dart_tool', rootUri),
                );
              } else if (rootUri.startsWith('file://')) {
                rootUri = Uri.parse(rootUri).toFilePath();
              }
              result = rootUri;
              break;
            }
          }
        }
      } catch (e) {
        if (verbose) print('Error reading package_config.json: $e');
      }
    }

    // Fallback: Check sibling directories (common in monorepo)
    if (result == null) {
      final workspaceParent = p.dirname(workspacePath);
      final siblingPackage = Directory('$workspaceParent/$packageName');
      if (siblingPackage.existsSync()) {
        result = siblingPackage.path;
      }
    }

    // Fallback: Check pubspec.yaml path dependencies
    if (result == null) {
      final pubspecFile = File('$workspacePath/pubspec.yaml');
      if (pubspecFile.existsSync()) {
        final content = await pubspecFile.readAsString();
        // Simple regex to find path dependencies
        final pathMatch = RegExp(
          '$packageName:\\s*path:\\s*([^\\n]+)',
          multiLine: true,
        ).firstMatch(content);
        if (pathMatch != null) {
          final pathValue = pathMatch.group(1)!.trim();
          final resolvedPath = p.normalize(p.join(workspacePath, pathValue));
          if (Directory(resolvedPath).existsSync()) {
            result = resolvedPath;
          }
        }
      }
    }

    _packagePathCache[packageName] = result;
    return result;
  }

  /// Resolves a dart: URI to an absolute file path.
  ///
  /// Given a URI like `dart:ui`, resolves it to the absolute file system path
  /// using the analyzer's context.
  ///
  /// For Flutter projects, dart:ui is provided by sky_engine package in the
  /// Flutter SDK cache: `flutter/bin/cache/pkg/sky_engine/lib/ui/ui.dart`
  ///
  /// Returns null if the dart library cannot be resolved.
  String? resolveDartUri(String dartUri) {
    if (!dartUri.startsWith('dart:')) {
      return null;
    }

    // Use the analyzer's context to resolve dart: URIs
    final context = _getAnalysisContext();
    if (context.contexts.isEmpty) return null;

    final anyContext = context.contexts.first;
    final session = anyContext.currentSession;

    // Parse the dart: URI and resolve it
    final uri = Uri.parse(dartUri);
    final path = session.uriConverter.uriToPath(uri);
    if (path != null && File(path).existsSync()) return path;

    // Fallback for summary-only contexts: when `sdkPath` is null (because
    // we're relying on `sdkSummaryPath`), the URI converter either returns
    // null or an opaque path that doesn't exist on disk, even though the
    // library is physically available through the Flutter embedder.
    // For `dart:ui` we resolve through the `sky_engine` package entry in
    // `.dart_tool/package_config.json`.
    if (dartUri == 'dart:ui') {
      final fallback = _resolveDartUiViaSkyEngine();
      if (fallback != null && File(fallback).existsSync()) return fallback;
    }
    return path;
  }

  /// Reads `.dart_tool/package_config.json` synchronously and returns the
  /// on-disk location of `sky_engine/lib/ui/ui.dart`, which Flutter uses
  /// as the implementation of `dart:ui`. Returns null if the package is
  /// not present or the file can't be read.
  String? _resolveDartUiViaSkyEngine() {
    final absoluteWorkspacePath = p.isAbsolute(workspacePath)
        ? workspacePath
        : p.normalize(p.join(Directory.current.path, workspacePath));
    final configFile = File(
      p.join(absoluteWorkspacePath, '.dart_tool', 'package_config.json'),
    );
    if (!configFile.existsSync()) return null;
    try {
      final doc = jsonDecode(configFile.readAsStringSync())
          as Map<String, dynamic>;
      final packages = doc['packages'] as List<dynamic>? ?? const [];
      for (final entry in packages) {
        final map = entry as Map<String, dynamic>;
        if (map['name'] != 'sky_engine') continue;
        final rootUri = map['rootUri'] as String? ?? '';
        final packageUri = (map['packageUri'] as String?) ?? 'lib/';
        String rootPath;
        if (rootUri.startsWith('file://')) {
          rootPath = Uri.parse(rootUri).toFilePath();
        } else {
          rootPath = p.normalize(
            p.join(absoluteWorkspacePath, '.dart_tool', rootUri),
          );
        }
        final libDir = p.normalize(p.join(rootPath, packageUri));
        return p.normalize(p.join(libDir, 'ui', 'ui.dart'));
      }
    } catch (_) {
      // Fall through to null on malformed config.
    }
    return null;
  }

  /// Resolves a package URI to an absolute file path.
  ///
  /// Given a URI like `package:tom_core_kernel/tom_core_kernel.dart`, resolves
  /// it to the absolute file system path using the package config.
  ///
  /// Returns null if the package cannot be resolved.
  Future<String?> resolvePackageUri(String packageUri) async {
    if (!packageUri.startsWith('package:')) {
      return null;
    }

    final match = RegExp(r'^package:([^/]+)/(.+)$').firstMatch(packageUri);
    if (match == null) return null;

    final pkgName = match.group(1)!;
    final relativePath = match.group(2)!;

    final packageRoot = await _resolvePackagePath(pkgName);
    if (packageRoot == null) return null;

    return p.normalize(p.join(packageRoot, 'lib', relativePath));
  }

  /// Extracts package name and relative path from a package URI.
  ///
  /// Given `package:tom_core_kernel/tom_core_kernel.dart`, returns
  /// `('tom_core_kernel', 'tom_core_kernel.dart')`.
  ///
  /// Returns null if the URI is not a valid package URI.
  (String, String)? _parsePackageUri(String uri) {
    if (!uri.startsWith('package:')) return null;

    final match = RegExp(r'^package:([^/]+)/(.+)$').firstMatch(uri);
    if (match == null) return null;

    return (match.group(1)!, match.group(2)!);
  }

  /// Extracts the package name from a package URI.
  ///
  /// Given `package:dcli_core/dcli_core.dart`, returns `dcli_core`.
  String? _extractPackageFromUri(String uri) {
    final parsed = _parsePackageUri(uri);
    return parsed?.$1;
  }

  /// Extracts the package name from a file path by looking at the /lib/ folder.
  ///
  /// Given `/path/to/.pub-cache/dcli_core-1.0.0/lib/src/util/line_file.dart`,
  /// returns `dcli_core`.
  String? _extractPackageFromPath(String filePath) {
    final libIndex = filePath.indexOf('/lib/');
    if (libIndex == -1) return null;

    final packageDir = filePath.substring(0, libIndex);
    final pubspecPath = '$packageDir/pubspec.yaml';

    try {
      final pubspecFile = File(pubspecPath);
      if (pubspecFile.existsSync()) {
        final content = pubspecFile.readAsStringSync();
        final nameMatch = RegExp(
          r'^name:\s*(\S+)',
          multiLine: true,
        ).firstMatch(content);
        if (nameMatch != null) {
          return nameMatch.group(1);
        }
      }
    } catch (_) {
      // Fall back to directory name
    }

    // Fall back to directory name (may include version suffix like dcli_core-1.0.0)
    final dirName = p.basename(packageDir);
    // Strip version suffix if present
    final versionMatch = RegExp(r'^(.+?)-\d+\.\d+').firstMatch(dirName);
    return versionMatch?.group(1) ?? dirName;
  }

  /// Merges two show clauses.
  /// If both are non-null, returns their intersection (only symbols in both).
  /// If one is null, returns the other.
  List<String>? _mergeShowClauses(List<String>? parent, List<String>? child) {
    if (parent == null) return child;
    if (child == null) return parent;
    // Intersection - only symbols that appear in both
    return child.where((s) => parent.contains(s)).toList();
  }

  /// Merges two hide clauses.
  /// If both are non-null, returns their union (symbols hidden by either).
  /// If one is null, returns the other.
  List<String>? _mergeHideClauses(List<String>? parent, List<String>? child) {
    if (parent == null) return child;
    if (child == null) return parent;
    // Union - symbols hidden by either
    return {...parent, ...child}.toList();
  }

  /// Checks if a file path matches any of the glob patterns.
  ///
  /// [filePath] - The file path to check
  /// [patterns] - List of glob patterns (e.g., '**/*_bridge.dart', 'src/**')
  ///
  /// Returns true if the file matches any pattern.
  bool _matchesGlobPattern(String filePath, List<String> patterns) {
    for (final pattern in patterns) {
      final glob = glob_pkg.Glob(pattern);
      if (glob.matches(filePath)) {
        return true;
      }
    }
    return false;
  }

  /// Checks if a source URI and element name match any exclusion pattern.
  ///
  /// Patterns can be plain source globs (exclude entire file) or include
  /// element selectors after '#', e.g.:
  /// - 'package:dcli_core/src/functions/backup.dart' (exclude all elements)
  /// - 'package:dcli_core/src/functions/backup.dart#backupFile,restoreFile'
  /// - 'package:dcli_core/src/util/file.dart#*Temp*' (glob on element name)
  bool _matchesSourceExclusion(
    String sourceUri,
    String elementName,
    List<String> patterns,
  ) {
    for (final pattern in patterns) {
      final parts = pattern.split('#');
      final sourcePattern = parts.first.trim();
      if (sourcePattern.isEmpty) {
        continue;
      }

      if (!_matchesGlobPattern(sourceUri, [sourcePattern])) {
        continue;
      }

      if (parts.length == 1) {
        return true;
      }

      final selector = parts.sublist(1).join('#').trim();
      if (selector.isEmpty) {
        return true;
      }

      final selectors = selector.split(',');
      for (final rawSelector in selectors) {
        final namePattern = rawSelector.trim();
        if (namePattern.isEmpty) {
          continue;
        }
        if (_matchesGlobPattern(elementName, [namePattern])) {
          return true;
        }
      }
    }

    return false;
  }

  /// Creates a bridge generator.
  ///
  /// [userBridgeScanner] - Optional pre-populated scanner for user bridge classes.
  /// If not provided, a new empty scanner will be created.
  ///
  /// [sourceImports] - List of barrel file URIs to import. Each will get a unique
  /// prefix ($pkg, $pkg2, etc.). If empty, falls back to [sourceImport].
  ///
  /// [sourceFileToBarrel] - Map of source file path to the barrel URI that exports it.
  /// Used to determine which prefix to use for each class.
  BridgeGenerator({
    required this.workspacePath,
    this.packageName,
    this.helpersImport = 'package:tom_d4rt/tom_d4rt.dart',
    this.d4rtImport = 'package:tom_d4rt/d4rt.dart',
    this.sourceImport,
    this.sourceImports = const [],
    this.sourceFileToBarrel = const {},
    this.readOnly = false,
    this.skipPrivate = true,
    this.verbose = false,
    this.enableVmWebSkewCoercion = false,
    this.followPackages = const [],
    this.librarySummaryPaths,
    this.sdkSummaryPath,
    List<RecursiveBoundType>? recursiveBoundTypes,
    UserBridgeScanner? userBridgeScanner,
  }) : recursiveBoundTypes = _mergeRecursiveBoundTypes(recursiveBoundTypes) {
    _userBridgeScanner = userBridgeScanner ?? UserBridgeScanner();
  }

  /// Merges configured recursive bound types with defaults.
  ///
  /// Configured types are added to the default types (num, String, DateTime,
  /// Duration, BigInt). Types are deduplicated by type name.
  static List<RecursiveBoundType> _mergeRecursiveBoundTypes(
    List<RecursiveBoundType>? configured,
  ) {
    final defaults = _defaultRecursiveBoundTypes
        .map(RecursiveBoundType.core)
        .toList();

    if (configured == null || configured.isEmpty) {
      return defaults;
    }

    // Merge: configured types + defaults (deduplicate by type name)
    final seen = <String>{};
    final merged = <RecursiveBoundType>[];

    // Add configured types first (they take precedence for same type name)
    for (final t in configured) {
      if (seen.add(t.typeName)) {
        merged.add(t);
      }
    }

    // Add defaults that weren't overridden
    for (final t in defaults) {
      if (seen.add(t.typeName)) {
        merged.add(t);
      }
    }

    return merged;
  }

  /// Finds the file containing a specific class.
  Future<String?> findFileForClass(String className) async {
    // Search in lib/ directory
    final libDir = Directory('$workspacePath/lib');
    if (!libDir.existsSync()) return null;

    final dartFiles = libDir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'));

    for (final file in dartFiles) {
      final content = await file.readAsString();
      // Quick check before full parse
      if (content.contains('class $className ') ||
          content.contains('class $className{') ||
          content.contains('class $className<')) {
        // Verify with parser
        final classes = await parseFile(file.path);
        if (classes.any((c) => c.name == className)) {
          return file.path;
        }
      }
    }

    return null;
  }

  /// Finds files matching a glob pattern.
  Future<List<String>> findFilesMatching(String pattern) async {
    final results = <String>[];
    final baseDir = Directory(workspacePath);

    // Simple glob support: *.dart, **/*.dart
    if (pattern.contains('*')) {
      final isRecursive = pattern.contains('**');
      final filePattern = pattern.replaceAll('**/', '').replaceAll('*', '');

      final files = baseDir
          .listSync(recursive: isRecursive)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'));

      for (final file in files) {
        if (filePattern.isEmpty || file.path.contains(filePattern)) {
          results.add(file.path);
        }
      }
    }

    return results;
  }

  /// Parses export barrel files to extract the list of exported source files.
  ///
  /// Scans the given barrel files (e.g., `lib/tom_build.dart`) and extracts
  /// all `export '...'` directives to build a list of source files to bridge.
  /// Recursively follows re-exported barrel files.
  ///
  /// [followAllReExports] - If true (default), follows all external package re-exports
  /// except those in [skipReExports]. If false, only follows packages in [followReExports].
  /// [skipReExports] - List of package names to skip when [followAllReExports] is true.
  /// [followReExports] - List of external package names to follow when [followAllReExports] is false.
  /// [originBarrelUri] - The top-level barrel URI that originated this export chain.
  ///   Used to track which barrel file each source file came from.
  /// [parentShowClause] - Show clause from parent export, to be merged with nested exports.
  /// [parentHideClause] - Hide clause from parent export, to be merged with nested exports.
  ///
  /// Returns a map of source file paths to their export info (hide/show clauses and barrel origin).
  Future<Map<String, ExportInfo>> parseExportFiles(
    List<String> barrelFiles, {
    Set<String>? visited,
    bool followAllReExports = true,
    List<String>? skipReExports,
    List<String>? followReExports,
    bool isTopLevel = true,
    String? originBarrelUri,
    List<String>? parentShowClause,
    List<String>? parentHideClause,
  }) async {
    visited ??= <String>{};
    skipReExports ??= const [];
    followReExports ??= const [];
    final exports = <String, ExportInfo>{};
    final exportPattern = RegExp(
      r'''export\s+['"]([^'"]+)['"]\s*(hide\s+[^;]+|show\s+[^;]+)?;''',
      multiLine: true,
    );

    for (final barrelPath in barrelFiles) {
      // Normalize path for comparison
      final normalizedPath = p.normalize(barrelPath);
      // For top-level barrel files, allow re-processing even if already visited
      // during recursive export chain from another barrel. This ensures each
      // top-level barrel gets its own barrelUri assigned correctly.
      // Only skip for recursive (non-top-level) calls to prevent infinite loops.
      if (!isTopLevel && visited.contains(normalizedPath)) {
        continue;
      }
      visited.add(normalizedPath);

      final file = File(normalizedPath);
      if (!file.existsSync()) {
        if (verbose) print('Warning: Barrel file not found: $normalizedPath');
        continue;
      }

      // Determine the barrel URI for this barrel file
      // For top-level barrels, compute it from the path; for nested, use originBarrelUri
      String? currentBarrelUri = originBarrelUri;
      if (isTopLevel) {
        // Convert file path to package URI for the barrel
        currentBarrelUri = _getPackageUri(normalizedPath);
      }

      // Add the barrel file itself to exports (it may contain its own declarations
      // like top-level getters, functions, variables, classes, or enums)
      // Only add for top-level barrel files (not nested barrels from recursive calls)
      // Nested barrels will have their restrictions handled by the parent export statement
      if (isTopLevel) {
        final existingBarrelInfo = exports[normalizedPath];
        if (existingBarrelInfo == null) {
          exports[normalizedPath] = ExportInfo(
            sourcePath: normalizedPath,
            hideClause: null,
            showClause: null,
            barrelUri: currentBarrelUri,
          );
        }
      }

      final content = await file.readAsString();

      for (final match in exportPattern.allMatches(content)) {
        final exportPath = match.group(1)!;
        final hideShow = match.group(2)?.trim();

        // Handle package: exports
        String absolutePath;
        if (exportPath.startsWith('package:')) {
          // Extract package name from export path
          final packageMatch = RegExp(
            r'^package:([^/]+)/(.+)$',
          ).firstMatch(exportPath);
          if (packageMatch == null) continue;

          final exportPackageName = packageMatch.group(1)!;
          final exportRelativePath = packageMatch.group(2)!;

          // Check if this is the current package
          if (packageName != null && exportPackageName == packageName) {
            // GEN-077: Check skipReExports for same-package re-exports.
            // When e.g. widgets/basic.dart has
            //   export 'package:flutter/animation.dart';
            // — the full URI must be checked against skipReExports because
            // both sides share the same package name ('flutter').
            if (skipReExports.contains(exportPath)) {
              if (verbose) {
                print(
                  'Skipping same-package re-export $exportPath (in skipReExports)',
                );
              }
              continue;
            }
            // Convert package: to relative path for current package
            absolutePath = '$workspacePath/lib/$exportRelativePath';
          } else {
            // Determine if we should follow this external package's re-exports
            bool shouldFollow;
            if (followAllReExports) {
              // Follow all except those in skipReExports.
              // GEN-077: Match both full URI (package:foo/bar.dart)
              // and bare package name (foo) for backwards compatibility.
              shouldFollow =
                  !skipReExports.contains(exportPackageName) &&
                  !skipReExports.contains(exportPath);
            } else {
              // Only follow those explicitly listed in followReExports
              shouldFollow = followReExports.contains(exportPackageName);
            }

            if (shouldFollow) {
              // Follow re-exports from external package
              final externalPackagePath = await _resolvePackagePath(
                exportPackageName,
              );
              if (externalPackagePath == null) {
                if (verbose) {
                  print(
                    'Warning: Could not resolve package path for $exportPackageName',
                  );
                }
                continue;
              }
              absolutePath = '$externalPackagePath/lib/$exportRelativePath';
            } else {
              // External package not configured to be followed, skip
              if (verbose) {
                print(
                  'Skipping re-export from $exportPackageName (not configured to follow)',
                );
              }
              continue;
            }
          }
        } else if (exportPath.startsWith('dart:')) {
          continue; // Skip dart: exports
        } else {
          // Relative path
          final barrelDir = p.dirname(normalizedPath);
          absolutePath = p.normalize(p.join(barrelDir, exportPath));
        }

        // Check if this is another barrel file (re-exports other files)
        final exportFile = File(absolutePath);
        if (exportFile.existsSync()) {
          final exportContent = await exportFile.readAsString();
          if (exportPattern.hasMatch(exportContent)) {
            // Parse the current export's show/hide clause
            List<String>? currentShowClause;
            List<String>? currentHideClause;
            if (hideShow?.startsWith('show') == true) {
              currentShowClause = hideShow!
                  .substring(5)
                  .split(',')
                  .map((s) => s.trim())
                  .toList();
            } else if (hideShow?.startsWith('hide') == true) {
              currentHideClause = hideShow!
                  .substring(5)
                  .split(',')
                  .map((s) => s.trim())
                  .toList();
            }

            // Merge current clause with parent clause for propagation
            final mergedShowClause = _mergeShowClauses(
              parentShowClause,
              currentShowClause,
            );
            final mergedHideClause = _mergeHideClauses(
              parentHideClause,
              currentHideClause,
            );

            // This file is a barrel - recursively parse it
            final nestedExports = await parseExportFiles(
              [absolutePath],
              visited: visited,
              followAllReExports: followAllReExports,
              skipReExports: skipReExports,
              followReExports: followReExports,
              isTopLevel: false,
              originBarrelUri: currentBarrelUri,
              parentShowClause: mergedShowClause,
              parentHideClause: mergedHideClause,
            );
            // Add nested exports with parent clauses applied
            for (final entry in nestedExports.entries) {
              final existingNested = exports[entry.key];

              // Merge the nested export with parent show/hide clauses
              final mergedEntry = entry.value.mergeWithParent(
                parentShowClause: parentShowClause,
                parentHideClause: parentHideClause,
              );

              if (existingNested == null) {
                // No existing entry - set directly
                exports[entry.key] = mergedEntry.barrelUri != null
                    ? mergedEntry
                    : mergedEntry.copyWith(barrelUri: currentBarrelUri);
              } else if (existingNested.showClause == null &&
                  existingNested.hideClause == null) {
                // Existing is fully permissive (no restrictions) - keep it
              } else if (mergedEntry.showClause != null &&
                  existingNested.showClause != null) {
                // GEN-070: Multiple export chains to the same source file are
                // additive in Dart. Union the show clauses so symbols visible
                // through ANY chain are included.
                final unionShow = {
                  ...existingNested.showClause!,
                  ...mergedEntry.showClause!,
                }.toList();
                exports[entry.key] = existingNested.copyWith(
                  showClause: unionShow,
                );
              } else {
                // Default: new entry overrides (e.g., new entry is more permissive)
                exports[entry.key] = mergedEntry.barrelUri != null
                    ? mergedEntry
                    : mergedEntry.copyWith(barrelUri: currentBarrelUri);
              }
            }
          }
          // Always add the file itself to exports (it may contain its own code)
          // even if it's a barrel file that re-exports other files
          // BUT: Don't overwrite an existing entry if:
          // 1. It's more permissive (no show/hide clause beats having a show/hide clause)
          // 2. It's from the same package as the source file (prefer same-package barrel)
          final existingInfo = exports[absolutePath];

          // Check if this barrel is from the same package as the source file
          final sourcePackage = _extractPackageFromPath(absolutePath);
          final currentBarrelPackage = currentBarrelUri != null
              ? _extractPackageFromUri(currentBarrelUri)
              : null;
          final existingBarrelPackage = existingInfo?.barrelUri != null
              ? _extractPackageFromUri(existingInfo!.barrelUri!)
              : null;

          final isSamePackageBarrel =
              sourcePackage != null && currentBarrelPackage == sourcePackage;
          final existingIsSamePackage =
              sourcePackage != null && existingBarrelPackage == sourcePackage;

          final isExistingMorePermissive =
              existingInfo != null &&
              existingInfo.showClause == null &&
              existingInfo.hideClause == null;

          // GEN-072: Check if current export is more permissive (no restrictions).
          // This is true when the export statement has no show/hide clause AND
          // there are no parent restrictions from the barrel chain above.
          final isCurrentMorePermissive =
              hideShow == null &&
              parentShowClause == null &&
              parentHideClause == null;

          // Override if:
          // - No existing entry
          // - Current is more permissive than existing (GEN-072: prefer permissive)
          // - This barrel is same-package and existing is not
          // - Existing is not more permissive AND this isn't less preferred
          final shouldOverride =
              existingInfo == null ||
              (isCurrentMorePermissive && !isExistingMorePermissive) ||
              (isSamePackageBarrel && !existingIsSamePackage) ||
              (!isExistingMorePermissive && !existingIsSamePackage);

          if (shouldOverride) {
            // Parse current export's show/hide clause
            List<String>? currentHide;
            List<String>? currentShow;
            if (hideShow?.startsWith('hide') == true) {
              currentHide = hideShow!
                  .substring(5)
                  .split(',')
                  .map((s) => s.trim())
                  .toList();
            } else if (hideShow?.startsWith('show') == true) {
              currentShow = hideShow!
                  .substring(5)
                  .split(',')
                  .map((s) => s.trim())
                  .toList();
            }

            // Merge with parent clauses
            final mergedShow = _mergeShowClauses(parentShowClause, currentShow);
            final mergedHide = _mergeHideClauses(parentHideClause, currentHide);

            // If both show and hide exist, apply hide to show
            List<String>? finalShow = mergedShow;
            List<String>? finalHide = mergedHide;
            if (finalShow != null && finalHide != null) {
              finalShow = finalShow
                  .where((s) => !finalHide!.contains(s))
                  .toList();
              finalHide = null;
            }

            // GEN-070: If existing entry has a show clause and we have one too,
            // union them (multiple export chains are additive in Dart).
            if (existingInfo != null &&
                existingInfo.showClause != null &&
                finalShow != null) {
              finalShow = {...existingInfo.showClause!, ...finalShow}.toList();
            }

            exports[absolutePath] = ExportInfo(
              sourcePath: absolutePath,
              hideClause: finalHide,
              showClause: finalShow,
              barrelUri: currentBarrelUri,
            );
          }
        }
      }

      // GEN-070: Remove from visited after processing completes.
      // This converts the visited set from "ever visited" to a recursion-stack,
      // preventing cycles (A->B->A) but allowing the same barrel to be reached
      // through different export chains with different show/hide clauses.
      // Top-level barrels skip the visited check anyway, so only remove for
      // non-top-level (recursive) calls.
      if (!isTopLevel) {
        visited.remove(normalizedPath);
      }
    }

    return exports;
  }

  /// Generates bridges from export barrel files.
  ///
  /// This is the preferred method as it automatically discovers which classes
  /// to bridge based on what's exported from the barrel files.
  ///
  /// [barrelFiles] - List of barrel file paths or package URIs
  ///   (e.g., `lib/tom_build.dart` or `package:tom_build/tom_build.dart`)
  /// [outputPath] - Where to write the generated bridge file
  /// [moduleName] - Name for the generated bridge class
  /// [excludePatterns] - File path patterns to exclude (e.g., `_bridge.dart`)
  /// [excludeClasses] - Class names to exclude
  /// [excludeEnums] - Enum names to exclude
  /// [excludeFunctions] - Global function names to exclude
  /// [excludeVariables] - Global variable names to exclude
  /// [excludeSourcePatterns] - Source URI glob patterns to exclude
  /// [followAllReExports] - If true (default), follows all external package re-exports
  /// [skipReExports] - List of package names to skip when [followAllReExports] is true
  /// [followReExports] - List of package names to follow when [followAllReExports] is false
  Future<BridgeGeneratorResult> generateBridgesFromExports({
    required List<String> barrelFiles,
    required String outputPath,
    String? moduleName,
    List<String>? excludePatterns,
    List<String>? excludeClasses,
    List<String>? excludeEnums,
    List<String>? excludeFunctions,
    List<String>? excludeConstructors,
    List<String>? excludeVariables,
    List<String>? excludeSourcePatterns,
    bool followAllReExports = true,
    List<String>? skipReExports,
    List<String>? followReExports,
    List<String> importShowClause = const [],
    List<String> importHideClause = const [],
    // GEN-076: Cross-module dedup — skip classes already generated in earlier modules.
    // Maps className → sourceFile so only exact same-source duplicates are skipped.
    Map<String, String>? skipClassSources,
  }) async {
    // Resolve package: and dart: URIs to file paths
    final resolvedBarrelFiles = <String>[];
    for (final barrelFile in barrelFiles) {
      if (barrelFile.startsWith('dart:')) {
        final resolved = resolveDartUri(barrelFile);
        if (resolved != null) {
          resolvedBarrelFiles.add(resolved);
        } else {
          if (verbose)
            print('Warning: Could not resolve dart URI: $barrelFile');
        }
      } else if (barrelFile.startsWith('package:')) {
        final resolved = await resolvePackageUri(barrelFile);
        if (resolved != null) {
          resolvedBarrelFiles.add(resolved);
        } else {
          if (verbose)
            print('Warning: Could not resolve package URI: $barrelFile');
        }
      } else {
        resolvedBarrelFiles.add(barrelFile);
      }
    }

    // Parse export files to get source files and their export info
    final exports = await parseExportFiles(
      resolvedBarrelFiles,
      followAllReExports: followAllReExports,
      skipReExports: skipReExports,
      followReExports: followReExports,
    );

    if (exports.isEmpty) {
      return BridgeGeneratorResult(
        classesGenerated: 0,
        outputFiles: [],
        errors: ['No exports found in barrel files: ${barrelFiles.join(', ')}'],
        warnings: [],
      );
    }

    // Filter out files matching exclude patterns (glob patterns)
    // Always exclude generated bridge files to prevent circular references
    final defaultExcludes = [
      '**/*_bridges.b.dart',
      '**/d4rt_bridges.b.dart',
      '**/*.b.dart',
    ];
    final allExcludePatterns = [...defaultExcludes, ...?excludePatterns];

    var sourceFiles = exports.keys.toList();
    sourceFiles = sourceFiles.where((path) {
      if (_matchesGlobPattern(path, allExcludePatterns)) {
        if (verbose) print('Excluding file by pattern: $path');
        return false;
      }
      return true;
    }).toList();

    // Generate bridges with export info for hide/show filtering
    return generateBridges(
      sourceFiles: sourceFiles,
      outputPath: outputPath,
      moduleName: moduleName,
      excludeClasses: excludeClasses,
      excludeEnums: excludeEnums,
      excludeFunctions: excludeFunctions,
      excludeConstructors: excludeConstructors,
      excludeVariables: excludeVariables,
      excludeSourcePatterns: excludeSourcePatterns,
      exportInfo: exports,
      importShowClause: importShowClause,
      importHideClause: importHideClause,
      // GEN-076: Forward cross-module dedup map
      skipClassSources: skipClassSources,
    );
  }

  /// Generates bridges from export barrel files using a [FileWriter].
  ///
  /// This variant is used by build_runner to write files via BuildStep
  /// instead of direct file system access.
  ///
  /// [barrelFiles] - List of barrel file paths or package URIs
  ///   (e.g., `lib/tom_build.dart` or `package:tom_build/tom_build.dart`)
  /// [outputFileId] - FileId for the output bridge file
  /// [moduleName] - Name for the generated bridge class
  /// [excludePatterns] - File path patterns to exclude (e.g., `_bridge.dart`)
  /// [excludeClasses] - Class names to exclude
  /// [excludeEnums] - Enum names to exclude
  /// [excludeFunctions] - Global function names to exclude
  /// [excludeVariables] - Global variable names to exclude
  /// [excludeSourcePatterns] - Source URI glob patterns to exclude
  /// [followAllReExports] - If true (default), follows all external package re-exports
  /// [skipReExports] - List of package names to skip when [followAllReExports] is true
  /// [followReExports] - List of package names to follow when [followAllReExports] is false
  /// [fileWriter] - The FileWriter to use for output
  Future<BridgeGeneratorResult> generateBridgesFromExportsWithWriter({
    required List<String> barrelFiles,
    required FileId outputFileId,
    String? moduleName,
    List<String>? excludePatterns,
    List<String>? excludeClasses,
    List<String>? excludeEnums,
    List<String>? excludeFunctions,
    List<String>? excludeConstructors,
    List<String>? excludeVariables,
    List<String>? excludeSourcePatterns,
    bool followAllReExports = true,
    List<String>? skipReExports,
    List<String>? followReExports,
    required FileWriter fileWriter,
    List<String> importShowClause = const [],
    List<String> importHideClause = const [],
  }) async {
    // Resolve package: and dart: URIs to file paths
    final resolvedBarrelFiles = <String>[];
    for (final barrelFile in barrelFiles) {
      if (barrelFile.startsWith('dart:')) {
        final resolved = resolveDartUri(barrelFile);
        if (resolved != null) {
          resolvedBarrelFiles.add(resolved);
        } else {
          if (verbose)
            print('Warning: Could not resolve dart URI: $barrelFile');
        }
      } else if (barrelFile.startsWith('package:')) {
        final resolved = await resolvePackageUri(barrelFile);
        if (resolved != null) {
          resolvedBarrelFiles.add(resolved);
        } else {
          if (verbose)
            print('Warning: Could not resolve package URI: $barrelFile');
        }
      } else {
        resolvedBarrelFiles.add(barrelFile);
      }
    }

    // Parse export files to get source files and their export info
    final exports = await parseExportFiles(
      resolvedBarrelFiles,
      followAllReExports: followAllReExports,
      skipReExports: skipReExports,
      followReExports: followReExports,
    );

    if (exports.isEmpty) {
      return BridgeGeneratorResult(
        classesGenerated: 0,
        outputFiles: [],
        errors: ['No exports found in barrel files: ${barrelFiles.join(', ')}'],
        warnings: [],
      );
    }

    // Filter out files matching exclude patterns (glob patterns)
    // Always exclude generated bridge files to prevent circular references
    final defaultExcludes = [
      '**/*_bridges.b.dart',
      '**/d4rt_bridges.b.dart',
      '**/*.b.dart',
    ];
    final allExcludePatterns = [...defaultExcludes, ...?excludePatterns];

    var sourceFiles = exports.keys.toList();
    sourceFiles = sourceFiles.where((path) {
      if (_matchesGlobPattern(path, allExcludePatterns)) {
        if (verbose) print('Excluding file by pattern: $path');
        return false;
      }
      return true;
    }).toList();

    // Generate bridges with export info for hide/show filtering
    return generateBridgesWithWriter(
      sourceFiles: sourceFiles,
      outputFileId: outputFileId,
      moduleName: moduleName,
      excludeClasses: excludeClasses,
      excludeEnums: excludeEnums,
      excludeFunctions: excludeFunctions,
      excludeConstructors: excludeConstructors,
      excludeVariables: excludeVariables,
      excludeSourcePatterns: excludeSourcePatterns,
      exportInfo: exports,
      fileWriter: fileWriter,
      importShowClause: importShowClause,
      importHideClause: importHideClause,
    );
  }

  /// Generates bridges for the specified source files.
  Future<BridgeGeneratorResult> generateBridges({
    required List<String> sourceFiles,
    required String outputPath,
    String? classPattern,
    String? targetClassName,
    String? moduleName,
    List<String>? excludeClasses,
    List<String>? excludeEnums,
    List<String>? excludeFunctions,
    List<String>? excludeConstructors,
    List<String>? excludeVariables,
    List<String>? excludeSourcePatterns,
    Map<String, ExportInfo>? exportInfo,
    List<String> importShowClause = const [],
    List<String> importHideClause = const [],
    // GEN-076: Cross-module dedup — skip classes already generated in earlier modules.
    // Maps className → sourceFile so only exact same-source duplicates are skipped.
    Map<String, String>? skipClassSources,
  }) async {
    _skipReports.clear();

    // GEN-079: Track module name for recording generic extraction sites
    _currentModuleName = moduleName;
    _excludeConstructors = (excludeConstructors ?? const <String>[]).toSet();

    // Build dynamic source file to barrel mapping from exportInfo
    _dynamicSourceFileToBarrel.clear();
    if (exportInfo != null) {
      for (final entry in exportInfo.entries) {
        final sourcePath = entry.key;
        final barrelUri = entry.value.barrelUri;
        if (barrelUri != null &&
            !_dynamicSourceFileToBarrel.containsKey(sourcePath)) {
          _dynamicSourceFileToBarrel[sourcePath] = barrelUri;
        }
      }
    }

    final allClasses = <ClassInfo>[];
    final errors = <String>[];
    final warnings = <String>[];

    // Parse all source files
    for (final sourcePath in sourceFiles) {
      try {
        final classes = await parseFile(sourcePath);
        allClasses.addAll(classes);
      } catch (e) {
        errors.add('Failed to parse $sourcePath: $e');
      }
    }

    // Filter classes by pattern if specified
    var filteredClasses = allClasses;

    if (targetClassName != null) {
      filteredClasses = allClasses
          .where((c) => c.name == targetClassName)
          .toList();
    } else if (classPattern != null) {
      filteredClasses = allClasses
          .where((c) => _matchesPattern(c.name, classPattern))
          .toList();
    }

    // Filter by export info (hide/show clauses from barrel files)
    if (exportInfo != null) {
      filteredClasses = filteredClasses.where((c) {
        final info = exportInfo[c.sourceFile];
        if (info != null && !info.isSymbolExported(c.name)) {
          _recordSkip('class', c.name, 'not exported from barrel file');
          return false;
        }
        return true;
      }).toList();
    }

    // Filter out explicitly excluded classes
    if (excludeClasses != null && excludeClasses.isNotEmpty) {
      final excludeSet = excludeClasses.toSet();
      filteredClasses = filteredClasses.where((c) {
        if (excludeSet.contains(c.name)) {
          _recordSkip('class', c.name, 'excluded by configuration');
          return false;
        }
        return true;
      }).toList();
    }

    // Filter out classes matching source URI patterns
    if (excludeSourcePatterns != null && excludeSourcePatterns.isNotEmpty) {
      filteredClasses = filteredClasses.where((c) {
        final sourceUri = _getPackageUri(c.sourceFile);
        if (_matchesSourceExclusion(sourceUri, c.name, excludeSourcePatterns)) {
          _recordSkip(
            'class',
            c.name,
            'source URI excluded by pattern: $sourceUri',
          );
          return false;
        }
        return true;
      }).toList();
    }

    // Filter out classes that extend D4UserBridge (they are helper classes, not to be bridged)
    filteredClasses = filteredClasses.where((c) {
      if (_userBridgeScanner.shouldExcludeClass(c.name)) {
        _recordSkip('class', c.name, 'extends D4UserBridge (helper class)');
        return false;
      }
      return true;
    }).toList();

    // Check for external types and add warnings
    externalTypeWarnings.clear();
    for (final cls in filteredClasses) {
      _checkExternalTypes(cls, warnings);
    }

    // Collect external dependencies if followPackages is configured
    if (followPackages.isNotEmpty) {
      _externalDependencies.clear();
      _collectExternalDependencies(filteredClasses);

      if (_externalDependencies.isNotEmpty && verbose) {
        print(
          'Resolving ${_externalDependencies.length} external type dependencies...',
        );
      }

      // Resolve and add external classes
      final externalClasses = await _resolveExternalDependencies();
      if (externalClasses.isNotEmpty) {
        if (verbose) {
          print(
            'Added ${externalClasses.length} classes from external packages',
          );
        }
        filteredClasses.addAll(externalClasses);
      }
    }

    // Include all classes, including abstract ones
    // Abstract classes without factory constructors will have no constructors in the bridge,
    // but will still be registered for type checking (is/as) and accessing instance members
    final bridgeableClasses = <ClassInfo>[];
    final seenClassNames =
        <String, String>{}; // name -> sourceFile of first occurrence
    for (final cls in filteredClasses) {
      // GEN-076: Cross-module dedup — skip classes from the SAME source file
      // that were already generated in an earlier module. Different classes with
      // the same name (e.g., dart:ui TextStyle vs Flutter TextStyle) are kept.
      if (skipClassSources != null &&
          skipClassSources.containsKey(cls.name) &&
          skipClassSources[cls.name] == cls.sourceFile) {
        _recordSkip(
          'class',
          cls.name,
          'already generated in an earlier module from same source (cross-module dedup)',
        );
        continue;
      }
      if (seenClassNames.containsKey(cls.name)) {
        // GEN-045: Detect barrel-level name collisions
        final firstSourceFile = seenClassNames[cls.name]!;
        final firstUri = _getPackageUri(firstSourceFile);
        final duplicateUri = _getPackageUri(cls.sourceFile);
        warnings.add(
          '⚠️  NAME COLLISION: Class "${cls.name}" is defined in multiple source files:\n'
          '    1. $firstUri (kept)\n'
          '    2. $duplicateUri (skipped)\n'
          '    Consider excluding one with excludeClasses, or using show/hide in barrel exports.',
        );
        _recordSkip(
          'class',
          cls.name,
          'duplicate (already seen from another source file: $firstUri)',
        );
        continue;
      }
      seenClassNames[cls.name] = cls.sourceFile;
      bridgeableClasses.add(cls);
    }

    // Parse globals (functions, variables, enums) from all source files early
    // so we can check if there's anything to generate
    final globalsRaw = await _parseGlobals(sourceFiles);

    // GEN-054: Mark variables that have corresponding setters.
    final variablesWithSetters = globalsRaw.variables.map((v) {
      if (v.isGetter && globalsRaw.setterNames.contains(v.name)) {
        return v.copyWith(hasSetter: true);
      }
      return v;
    }).toList();

    // Create updated globals record with setter-aware variables
    final globals = (
      functions: globalsRaw.functions,
      variables: variablesWithSetters,
      enums: globalsRaw.enums,
      extensions: globalsRaw.extensions,
      setterNames: globalsRaw.setterNames,
    );

    // Build the set of exported type names from ALL filtered classes (including abstract)
    // and exported enums. This is used to detect when a type is used but not
    // exported from the barrel.
    // We use filteredClasses (not bridgeableClasses) to include abstract classes like TomDbType
    _exportedTypeNames = {
      ...filteredClasses.map((c) => c.name),
      ...globals.enums.map((e) => e.name),
    };
    // Clear previous warnings since we're starting a new generation
    _missingExportWarnings.clear();
    final hasEnums = globals.enums.isNotEmpty;
    final hasGlobalFunctions = globals.functions.isNotEmpty;
    final hasGlobalVariables = globals.variables.isNotEmpty;
    final hasExtensions = globals.extensions.isNotEmpty;
    final hasClasses = bridgeableClasses.isNotEmpty;

    // Return early only if there's nothing to generate at all
    if (!hasClasses &&
        !hasEnums &&
        !hasGlobalFunctions &&
        !hasGlobalVariables &&
        !hasExtensions) {
      return BridgeGeneratorResult(
        classesGenerated: 0,
        outputFiles: [],
        errors: errors,
        warnings: warnings
          ..add('No bridgeable content found (no classes, enums, or globals)'),
      );
    }

    // Generate bridge code
    final outputFiles = <String>[];

    // Determine if output is a file or directory
    final isOutputDir =
        outputPath.endsWith('/') || Directory(outputPath).existsSync();

    if (isOutputDir) {
      // Ensure output directory exists
      final outDir = Directory(outputPath);
      if (!outDir.existsSync()) {
        await outDir.create(recursive: true);
      }

      // Group classes by source file
      final classesPerFile = <String, List<ClassInfo>>{};
      final allClassesPerFile = <String, List<ClassInfo>>{};
      for (final cls in bridgeableClasses) {
        classesPerFile.putIfAbsent(cls.sourceFile, () => []).add(cls);
      }
      // Also group all classes (including abstract) for inheritance lookup
      for (final cls in filteredClasses) {
        allClassesPerFile.putIfAbsent(cls.sourceFile, () => []).add(cls);
      }

      // Group globals (enums, functions, variables, extensions) by source file
      final enumsPerFile = <String, List<EnumInfo>>{};
      final functionsPerFile = <String, List<GlobalFunctionInfo>>{};
      final variablesPerFile = <String, List<GlobalVariableInfo>>{};
      final extensionsPerFile = <String, List<ExtensionInfo>>{};
      for (final e in globals.enums) {
        enumsPerFile.putIfAbsent(e.sourceFile, () => []).add(e);
      }
      for (final f in globals.functions) {
        functionsPerFile.putIfAbsent(f.sourceFile, () => []).add(f);
      }
      for (final v in globals.variables) {
        variablesPerFile.putIfAbsent(v.sourceFile, () => []).add(v);
      }
      for (final ext in globals.extensions) {
        extensionsPerFile.putIfAbsent(ext.sourceFile, () => []).add(ext);
      }

      // Collect all source files that have any bridgeable content
      final allSourceFiles = <String>{
        ...classesPerFile.keys,
        ...enumsPerFile.keys,
        ...functionsPerFile.keys,
        ...variablesPerFile.keys,
        ...extensionsPerFile.keys,
      };

      for (final sourceFile in allSourceFiles) {
        final classes = classesPerFile[sourceFile] ?? <ClassInfo>[];
        final allClassesForFile = allClassesPerFile[sourceFile] ?? classes;
        final fileEnums = enumsPerFile[sourceFile] ?? <EnumInfo>[];
        final fileFunctions =
            functionsPerFile[sourceFile] ?? <GlobalFunctionInfo>[];
        final fileVariables =
            variablesPerFile[sourceFile] ?? <GlobalVariableInfo>[];
        final fileExtensions =
            extensionsPerFile[sourceFile] ?? <ExtensionInfo>[];

        final baseName = p.basenameWithoutExtension(sourceFile);
        final outFile =
            '${outputPath.endsWith('/') ? outputPath : '$outputPath/'}${baseName}_bridge.dart';

        final code = _generateBridgeFile(
          classes,
          sourceFile,
          moduleName,
          allClasses: allClassesForFile,
          externalClassLookup: externalClassLookup.isNotEmpty
              ? externalClassLookup
              : null,
          globalFunctions: fileFunctions,
          globalVariables: fileVariables,
          enums: fileEnums,
          extensions: fileExtensions,
          importShowClause: importShowClause,
          importHideClause: importHideClause,
          // GEN-107 Phase 2: directory-mode emits one *.b.dart per source
          // file, so look up re-exports for that single file only.
          reExportSourceFiles: [sourceFile],
        );
        await File(outFile).writeAsString(code);
        outputFiles.add(outFile);
      }
    } else {
      // Ensure parent directory exists
      final parentDir = Directory(p.dirname(outputPath));
      if (!parentDir.existsSync()) {
        await parentDir.create(recursive: true);
      }

      // Filter globals by export info (hide/show clauses from barrel files)
      var filteredFunctions = globals.functions.toList();
      var filteredVariables = globals.variables.toList();
      var filteredEnums = globals.enums.toList();

      if (exportInfo != null) {
        filteredEnums = filteredEnums.where((e) {
          final info = exportInfo[e.sourceFile];
          if (info != null && !info.isSymbolExported(e.name)) {
            _recordSkip('enum', e.name, 'not exported from barrel file');
            return false;
          }
          return true;
        }).toList();

        filteredFunctions = filteredFunctions.where((f) {
          final info = exportInfo[f.sourceFile];
          if (info != null && !info.isSymbolExported(f.name)) {
            _recordSkip('function', f.name, 'not exported from barrel file');
            return false;
          }
          return true;
        }).toList();

        filteredVariables = filteredVariables.where((v) {
          final info = exportInfo[v.sourceFile];
          if (info != null && !info.isSymbolExported(v.name)) {
            _recordSkip('variable', v.name, 'not exported from barrel file');
            return false;
          }
          return true;
        }).toList();
      }

      // Filter out explicitly excluded functions
      if (excludeFunctions != null && excludeFunctions.isNotEmpty) {
        final excludeSet = excludeFunctions.toSet();
        filteredFunctions = filteredFunctions.where((f) {
          if (excludeSet.contains(f.name)) {
            _recordSkip('function', f.name, 'excluded by configuration');
            return false;
          }
          return true;
        }).toList();
      }

      // Filter out functions matching source URI patterns
      if (excludeSourcePatterns != null && excludeSourcePatterns.isNotEmpty) {
        filteredFunctions = filteredFunctions.where((f) {
          final sourceUri = _getPackageUri(f.sourceFile);
          if (_matchesSourceExclusion(
            sourceUri,
            f.name,
            excludeSourcePatterns,
          )) {
            _recordSkip(
              'function',
              f.name,
              'source URI excluded by pattern: $sourceUri',
            );
            return false;
          }
          return true;
        }).toList();
      }

      // Filter out duplicate functions (keep first occurrence)
      // GEN-045: Detect barrel-level name collisions
      final seenFunctions = <String, String>{}; // name -> sourceFile
      filteredFunctions = filteredFunctions.where((f) {
        if (seenFunctions.containsKey(f.name)) {
          final firstUri = _getPackageUri(seenFunctions[f.name]!);
          final duplicateUri = _getPackageUri(f.sourceFile);
          warnings.add(
            '⚠️  NAME COLLISION: Function "${f.name}" is defined in multiple source files:\n'
            '    1. $firstUri (kept)\n'
            '    2. $duplicateUri (skipped)\n'
            '    Consider excluding one with excludeFunctions, or using show/hide in barrel exports.',
          );
          _recordSkip(
            'function',
            f.name,
            'duplicate (already seen from another source file: $firstUri)',
          );
          return false;
        }
        seenFunctions[f.name] = f.sourceFile;
        return true;
      }).toList();

      // Filter out explicitly excluded variables
      if (excludeVariables != null && excludeVariables.isNotEmpty) {
        final excludeSet = excludeVariables.toSet();
        filteredVariables = filteredVariables.where((v) {
          if (excludeSet.contains(v.name)) {
            _recordSkip('variable', v.name, 'excluded by configuration');
            return false;
          }
          return true;
        }).toList();
      }

      // Filter out variables matching source URI patterns
      if (excludeSourcePatterns != null && excludeSourcePatterns.isNotEmpty) {
        filteredVariables = filteredVariables.where((v) {
          final sourceUri = _getPackageUri(v.sourceFile);
          if (_matchesSourceExclusion(
            sourceUri,
            v.name,
            excludeSourcePatterns,
          )) {
            _recordSkip(
              'variable',
              v.name,
              'source URI excluded by pattern: $sourceUri',
            );
            return false;
          }
          return true;
        }).toList();
      }

      // Filter out duplicate variables (keep first occurrence)
      // GEN-045: Detect barrel-level name collisions
      {
        final seenVariables = <String, String>{}; // name -> sourceFile
        filteredVariables = filteredVariables.where((v) {
          if (seenVariables.containsKey(v.name)) {
            final firstUri = _getPackageUri(seenVariables[v.name]!);
            final duplicateUri = _getPackageUri(v.sourceFile);
            warnings.add(
              '⚠️  NAME COLLISION: Variable "${v.name}" is defined in multiple source files:\n'
              '    1. $firstUri (kept)\n'
              '    2. $duplicateUri (skipped)\n'
              '    Consider excluding one with excludeVariables, or using show/hide in barrel exports.',
            );
            _recordSkip(
              'variable',
              v.name,
              'duplicate (already seen from another source file: $firstUri)',
            );
            return false;
          }
          seenVariables[v.name] = v.sourceFile;
          return true;
        }).toList();
      }

      // Filter out enums matching source URI patterns
      if (excludeSourcePatterns != null && excludeSourcePatterns.isNotEmpty) {
        filteredEnums = filteredEnums.where((e) {
          final sourceUri = _getPackageUri(e.sourceFile);
          if (_matchesSourceExclusion(
            sourceUri,
            e.name,
            excludeSourcePatterns,
          )) {
            _recordSkip(
              'enum',
              e.name,
              'source URI excluded by pattern: $sourceUri',
            );
            return false;
          }
          return true;
        }).toList();
      }

      // GEN-045: Detect barrel-level name collisions for enums
      {
        final seenEnums = <String, String>{}; // name -> sourceFile
        filteredEnums = filteredEnums.where((e) {
          if (seenEnums.containsKey(e.name)) {
            final firstUri = _getPackageUri(seenEnums[e.name]!);
            final duplicateUri = _getPackageUri(e.sourceFile);
            warnings.add(
              '⚠️  NAME COLLISION: Enum "${e.name}" is defined in multiple source files:\n'
              '    1. $firstUri (kept)\n'
              '    2. $duplicateUri (skipped)\n'
              '    Consider excluding one with excludeEnums, or using show/hide in barrel exports.',
            );
            _recordSkip(
              'enum',
              e.name,
              'duplicate (already seen from another source file: $firstUri)',
            );
            return false;
          }
          seenEnums[e.name] = e.sourceFile;
          return true;
        }).toList();
      }

      // Filter out extensions matching source URI patterns
      var filteredExtensions = globals.extensions;
      if (excludeSourcePatterns != null && excludeSourcePatterns.isNotEmpty) {
        filteredExtensions = filteredExtensions.where((e) {
          final sourceUri = _getPackageUri(e.sourceFile);
          final extName = e.name ?? e.onTypeName;
          if (_matchesSourceExclusion(
            sourceUri,
            extName,
            excludeSourcePatterns,
          )) {
            _recordSkip(
              'extension',
              extName,
              'source URI excluded by pattern: $sourceUri',
            );
            return false;
          }
          return true;
        }).toList();
      }

      // GEN-064: Filter out duplicate extensions (keep first occurrence)
      // Extensions can appear multiple times when imported through different
      // barrel re-exports. Deduplicate by name+sourceFile.
      {
        final seenExtensions = <String>{};
        filteredExtensions = filteredExtensions.where((e) {
          final key =
              '${e.name ?? '<unnamed>'}|${_getPackageUri(e.sourceFile)}';
          if (seenExtensions.contains(key)) {
            final extName = e.name ?? e.onTypeName;
            _recordSkip(
              'extension',
              extName,
              'duplicate (already seen from another import)',
            );
            return false;
          }
          seenExtensions.add(key);
          return true;
        }).toList();
      }

      // GEN-057: Post-process global functions to fix up missing return type URIs
      // This handles cases where return types like `core.Which` were InvalidType
      // during AST parsing, but the type was found in a different source file.
      final fixedFunctions = _fixupReturnTypeUris(filteredFunctions);

      // GEN-055: Collect API surface type dependencies from kept functions
      // Classes that are return types or parameter types of bridged functions
      // must also be bridged, even if not explicitly exported from the barrel
      // Use fixedFunctions to get correct return type URIs
      final apiSurfaceDependencies = _collectApiSurfaceTypeDependencies(
        fixedFunctions,
        filteredVariables,
      );
      if (apiSurfaceDependencies.isNotEmpty) {
        final existingClassNames = filteredClasses.map((c) => c.name).toSet();
        final existingBridgeableNames = bridgeableClasses
            .map((c) => c.name)
            .toSet();
        for (final typeName in apiSurfaceDependencies) {
          // Skip if already included
          if (existingClassNames.contains(typeName)) continue;

          // Find matching class in allClasses
          var matchingClass = allClasses
              .where((c) => c.name == typeName)
              .firstOrNull;

          // GEN-057: If not found in allClasses, try to parse from source file
          // using the URI from _globalTypeToUri
          if (matchingClass == null) {
            final typeUri = _globalTypeToUri[typeName];
            if (typeUri != null && typeUri.startsWith('package:')) {
              final sourceFile = _resolvePackageUriToFile(typeUri);
              if (sourceFile != null && File(sourceFile).existsSync()) {
                try {
                  // Parse the class from the source file
                  final classes = await parseFile(sourceFile);
                  final parsed = classes
                      .where((c) => c.name == typeName)
                      .firstOrNull;
                  if (parsed != null) {
                    matchingClass = parsed;
                    allClasses.add(parsed);
                    if (verbose) {
                      print(
                        'GEN-057: Parsed class "$typeName" from external file: $typeUri',
                      );
                    }
                  }
                } catch (e) {
                  if (verbose) {
                    print(
                      'Warning: Failed to parse "$typeName" from $typeUri: $e',
                    );
                  }
                }
              }
            }
          }

          if (matchingClass != null) {
            // Add to filteredClasses and bridgeableClasses
            filteredClasses.add(matchingClass);
            existingClassNames.add(typeName);

            // Add to bridgeableClasses if not already there (for concrete classes)
            if (!existingBridgeableNames.contains(typeName)) {
              bridgeableClasses.add(matchingClass);
              existingBridgeableNames.add(typeName);
            }

            // Note: Do NOT add to _exportedTypeNames - these types are not exported from
            // the barrel, so _collectAuxiliaryImportsFromTypes will generate auxiliary
            // imports for them when processing the functions that use them.

            if (verbose) {
              print('GEN-055: Added "$typeName" as API surface dependency');
            }
          }
        }
      }

      // Generate single output file using already-parsed globals
      final code = _generateBridgeFile(
        bridgeableClasses,
        sourceFiles.first,
        moduleName,
        allClasses: filteredClasses,
        externalClassLookup: externalClassLookup.isNotEmpty
            ? externalClassLookup
            : null,
        globalFunctions: fixedFunctions,
        globalVariables: filteredVariables,
        enums: filteredEnums,
        extensions: filteredExtensions,
        importShowClause: importShowClause,
        importHideClause: importHideClause,
        // GEN-107 Phase 2: bundle mode aggregates everything into one
        // *.b.dart file — pass the full input list (which includes pure
        // barrel files like `package:flutter/services.dart`) so their
        // `export …` directives are emitted as `registerLibraryReExport`
        // calls.
        reExportSourceFiles: sourceFiles,
      );
      final outFile = outputPath.endsWith('.dart')
          ? outputPath
          : '$outputPath.dart';
      await File(outFile).writeAsString(code);
      outputFiles.add(outFile);
    }

    // Count globals for result - use filtered counts from else branch if available,
    // otherwise use globals totals from if branch
    final functionCount = hasGlobalFunctions ? globals.functions.length : 0;
    final variableCount = hasGlobalVariables ? globals.variables.length : 0;

    return BridgeGeneratorResult(
      classesGenerated: bridgeableClasses.length,
      globalFunctionsGenerated: functionCount,
      globalVariablesGenerated: variableCount,
      outputFiles: outputFiles,
      errors: errors,
      warnings: warnings
        ..addAll(_nonWrappableDefaultWarnings)
        ..addAll(_missingExportWarnings)
        ..addAll(_skipReports),
      // GEN-076: Report which classes were generated for cross-module dedup
      generatedClassSources: {
        for (final c in bridgeableClasses) c.name: c.sourceFile,
      },
    );
  }

  /// Generates bridges for the specified source files using a [FileWriter].
  ///
  /// This variant is used by build_runner to write files via BuildStep
  /// instead of direct file system access.
  Future<BridgeGeneratorResult> generateBridgesWithWriter({
    required List<String> sourceFiles,
    required FileId outputFileId,
    String? classPattern,
    String? targetClassName,
    String? moduleName,
    List<String>? excludeClasses,
    List<String>? excludeEnums,
    List<String>? excludeFunctions,
    List<String>? excludeConstructors,
    List<String>? excludeVariables,
    List<String>? excludeSourcePatterns,
    Map<String, ExportInfo>? exportInfo,
    required FileWriter fileWriter,
    List<String> importShowClause = const [],
    List<String> importHideClause = const [],
  }) async {
    _skipReports.clear();
    _excludeConstructors = (excludeConstructors ?? const <String>[]).toSet();
    final allClasses = <ClassInfo>[];
    final errors = <String>[];
    final warnings = <String>[];

    // Parse all source files
    for (final sourcePath in sourceFiles) {
      try {
        final classes = await parseFile(sourcePath);
        allClasses.addAll(classes);
      } catch (e) {
        errors.add('Failed to parse $sourcePath: $e');
      }
    }

    // Filter classes by pattern if specified
    var filteredClasses = allClasses;

    if (targetClassName != null) {
      filteredClasses = allClasses
          .where((c) => c.name == targetClassName)
          .toList();
    } else if (classPattern != null) {
      filteredClasses = allClasses
          .where((c) => _matchesPattern(c.name, classPattern))
          .toList();
    }

    // Filter by export info (hide/show clauses from barrel files)
    if (exportInfo != null) {
      filteredClasses = filteredClasses.where((c) {
        final info = exportInfo[c.sourceFile];
        if (info != null && !info.isSymbolExported(c.name)) {
          _recordSkip('class', c.name, 'not exported from barrel file');
          return false;
        }
        return true;
      }).toList();
    }

    // Filter out explicitly excluded classes
    if (excludeClasses != null && excludeClasses.isNotEmpty) {
      final excludeSet = excludeClasses.toSet();
      filteredClasses = filteredClasses.where((c) {
        if (excludeSet.contains(c.name)) {
          _recordSkip('class', c.name, 'excluded by configuration');
          return false;
        }
        return true;
      }).toList();
    }

    // Filter out classes matching source URI patterns
    if (excludeSourcePatterns != null && excludeSourcePatterns.isNotEmpty) {
      filteredClasses = filteredClasses.where((c) {
        final sourceUri = _getPackageUri(c.sourceFile);
        if (_matchesSourceExclusion(sourceUri, c.name, excludeSourcePatterns)) {
          _recordSkip(
            'class',
            c.name,
            'source URI excluded by pattern: $sourceUri',
          );
          return false;
        }
        return true;
      }).toList();
    }

    // Filter out classes that extend D4UserBridge (they are helper classes, not to be bridged)
    filteredClasses = filteredClasses.where((c) {
      if (_userBridgeScanner.shouldExcludeClass(c.name)) {
        _recordSkip('class', c.name, 'extends D4UserBridge (helper class)');
        return false;
      }
      return true;
    }).toList();

    // Check for external types and add warnings
    externalTypeWarnings.clear();
    for (final cls in filteredClasses) {
      _checkExternalTypes(cls, warnings);
    }

    // Collect external dependencies if followPackages is configured
    if (followPackages.isNotEmpty) {
      _externalDependencies.clear();
      _collectExternalDependencies(filteredClasses);

      if (_externalDependencies.isNotEmpty && verbose) {
        print(
          'Resolving ${_externalDependencies.length} external type dependencies...',
        );
      }

      // Resolve and add external classes
      final externalClasses = await _resolveExternalDependencies();
      if (externalClasses.isNotEmpty) {
        if (verbose) {
          print(
            'Added ${externalClasses.length} classes from external packages',
          );
        }
        filteredClasses.addAll(externalClasses);
      }
    }

    // Include all classes, including abstract ones. Abstract classes without factory
    // constructors will have no constructors in the bridge, but will still be registered
    // for type checking (is/as) and accessing instance members.
    final bridgeableClasses = <ClassInfo>[];
    final seenClassNames = <String>{};
    for (final cls in filteredClasses) {
      if (seenClassNames.contains(cls.name)) {
        _recordSkip(
          'class',
          cls.name,
          'duplicate (already seen from another source file)',
        );
        continue;
      }
      seenClassNames.add(cls.name);
      bridgeableClasses.add(cls);
    }

    // Parse globals (functions, variables, enums) from all source files early
    // so we can check if there's anything to generate
    final globalsRaw = await _parseGlobals(sourceFiles);

    // GEN-054: Mark variables that have corresponding setters.
    final variablesWithSetters = globalsRaw.variables.map((v) {
      if (v.isGetter && globalsRaw.setterNames.contains(v.name)) {
        return v.copyWith(hasSetter: true);
      }
      return v;
    }).toList();

    // Create updated globals record with setter-aware variables
    final globals = (
      functions: globalsRaw.functions,
      variables: variablesWithSetters,
      enums: globalsRaw.enums,
      extensions: globalsRaw.extensions,
      setterNames: globalsRaw.setterNames,
    );

    // Build the set of exported type names from ALL filtered classes (including abstract)
    // and exported enums. This is used to detect when a type is used but not
    // exported from the barrel.
    // We use filteredClasses (not bridgeableClasses) to include abstract classes like TomDbType
    _exportedTypeNames = {
      ...filteredClasses.map((c) => c.name),
      ...globals.enums.map((e) => e.name),
    };
    // Clear previous warnings since we're starting a new generation
    _missingExportWarnings.clear();
    final hasEnums = globals.enums.isNotEmpty;
    final hasGlobalFunctions = globals.functions.isNotEmpty;
    final hasGlobalVariables = globals.variables.isNotEmpty;
    final hasExtensions = globals.extensions.isNotEmpty;
    final hasClasses = bridgeableClasses.isNotEmpty;

    // Return early only if there's nothing to generate at all
    if (!hasClasses &&
        !hasEnums &&
        !hasGlobalFunctions &&
        !hasGlobalVariables &&
        !hasExtensions) {
      return BridgeGeneratorResult(
        classesGenerated: 0,
        outputFiles: [],
        errors: errors,
        warnings: warnings
          ..add('No bridgeable content found (no classes, enums, or globals)'),
      );
    }

    // Generate bridge code
    final outputFiles = <String>[];

    // Filter globals by export info (hide/show clauses from barrel files)
    var filteredEnums = globals.enums;
    var filteredFunctions = globals.functions;
    var filteredVariables = globals.variables;

    if (exportInfo != null) {
      filteredEnums = globals.enums.where((e) {
        final info = exportInfo[e.sourceFile];
        if (info != null && !info.isSymbolExported(e.name)) {
          _recordSkip('enum', e.name, 'not exported from barrel file');
          return false;
        }
        return true;
      }).toList();

      filteredFunctions = globals.functions.where((f) {
        final info = exportInfo[f.sourceFile];
        if (info != null && !info.isSymbolExported(f.name)) {
          _recordSkip('function', f.name, 'not exported from barrel file');
          return false;
        }
        return true;
      }).toList();

      filteredVariables = globals.variables.where((v) {
        final info = exportInfo[v.sourceFile];
        if (info != null && !info.isSymbolExported(v.name)) {
          _recordSkip('variable', v.name, 'not exported from barrel file');
          return false;
        }
        return true;
      }).toList();
    }

    // Filter out explicitly excluded enums
    if (excludeEnums != null && excludeEnums.isNotEmpty) {
      final excludeSet = excludeEnums.toSet();
      filteredEnums = filteredEnums.where((e) {
        if (excludeSet.contains(e.name)) {
          _recordSkip('enum', e.name, 'excluded by configuration');
          return false;
        }
        return true;
      }).toList();
    }

    // Filter out enums matching source URI patterns
    if (excludeSourcePatterns != null && excludeSourcePatterns.isNotEmpty) {
      filteredEnums = filteredEnums.where((e) {
        final sourceUri = _getPackageUri(e.sourceFile);
        if (_matchesSourceExclusion(sourceUri, e.name, excludeSourcePatterns)) {
          _recordSkip(
            'enum',
            e.name,
            'source URI excluded by pattern: $sourceUri',
          );
          return false;
        }
        return true;
      }).toList();
    }

    // Filter out duplicate enums (keep first occurrence)
    {
      final seenEnums = <String>{};
      filteredEnums = filteredEnums.where((e) {
        if (seenEnums.contains(e.name)) {
          _recordSkip(
            'enum',
            e.name,
            'duplicate (already seen from another source file)',
          );
          return false;
        }
        seenEnums.add(e.name);
        return true;
      }).toList();
    }

    // Filter out explicitly excluded functions
    if (excludeFunctions != null && excludeFunctions.isNotEmpty) {
      final excludeSet = excludeFunctions.toSet();
      filteredFunctions = filteredFunctions.where((f) {
        if (excludeSet.contains(f.name)) {
          _recordSkip('function', f.name, 'excluded by configuration');
          return false;
        }
        return true;
      }).toList();
    }

    // Filter out functions matching source URI patterns
    if (excludeSourcePatterns != null && excludeSourcePatterns.isNotEmpty) {
      filteredFunctions = filteredFunctions.where((f) {
        final sourceUri = _getPackageUri(f.sourceFile);
        if (_matchesSourceExclusion(sourceUri, f.name, excludeSourcePatterns)) {
          _recordSkip(
            'function',
            f.name,
            'source URI excluded by pattern: $sourceUri',
          );
          return false;
        }
        return true;
      }).toList();
    }

    // Filter out duplicate functions (keep first occurrence)
    {
      final seenFunctions = <String>{};
      filteredFunctions = filteredFunctions.where((f) {
        if (seenFunctions.contains(f.name)) {
          _recordSkip(
            'function',
            f.name,
            'duplicate (already seen from another source file)',
          );
          return false;
        }
        seenFunctions.add(f.name);
        return true;
      }).toList();
    }

    // Filter out explicitly excluded variables
    if (excludeVariables != null && excludeVariables.isNotEmpty) {
      final excludeSet = excludeVariables.toSet();
      filteredVariables = filteredVariables.where((v) {
        if (excludeSet.contains(v.name)) {
          _recordSkip('variable', v.name, 'excluded by configuration');
          return false;
        }
        return true;
      }).toList();
    }

    // Filter out variables matching source URI patterns
    if (excludeSourcePatterns != null && excludeSourcePatterns.isNotEmpty) {
      filteredVariables = filteredVariables.where((v) {
        final sourceUri = _getPackageUri(v.sourceFile);
        if (_matchesSourceExclusion(sourceUri, v.name, excludeSourcePatterns)) {
          _recordSkip(
            'variable',
            v.name,
            'source URI excluded by pattern: $sourceUri',
          );
          return false;
        }
        return true;
      }).toList();
    }

    // Filter out duplicate variables (keep first occurrence)
    {
      final seenVariables = <String>{};
      filteredVariables = filteredVariables.where((v) {
        if (seenVariables.contains(v.name)) {
          _recordSkip(
            'variable',
            v.name,
            'duplicate (already seen from another source file)',
          );
          return false;
        }
        seenVariables.add(v.name);
        return true;
      }).toList();
    }

    // Filter out extensions matching source URI patterns
    var filteredExtensions = globals.extensions;
    if (excludeSourcePatterns != null && excludeSourcePatterns.isNotEmpty) {
      filteredExtensions = filteredExtensions.where((e) {
        final sourceUri = _getPackageUri(e.sourceFile);
        final extName = e.name ?? e.onTypeName;
        if (_matchesSourceExclusion(
          sourceUri,
          extName,
          excludeSourcePatterns,
        )) {
          _recordSkip(
            'extension',
            extName,
            'source URI excluded by pattern: $sourceUri',
          );
          return false;
        }
        return true;
      }).toList();
    }

    // GEN-064: Filter out duplicate extensions (keep first occurrence)
    // Extensions can appear multiple times when imported through different
    // barrel re-exports. Deduplicate by name+sourceFile.
    {
      final seenExtensions = <String>{};
      filteredExtensions = filteredExtensions.where((e) {
        final key = '${e.name ?? '<unnamed>'}|${_getPackageUri(e.sourceFile)}';
        if (seenExtensions.contains(key)) {
          final extName = e.name ?? e.onTypeName;
          _recordSkip(
            'extension',
            extName,
            'duplicate (already seen from another import)',
          );
          return false;
        }
        seenExtensions.add(key);
        return true;
      }).toList();
    }

    // GEN-057: Post-process global functions to fix up missing return type URIs
    // This handles cases where return types like `core.Which` were InvalidType
    // during AST parsing, but the type was found in a different source file.
    final fixedFunctions = _fixupReturnTypeUris(filteredFunctions);

    // GEN-055: Collect types that are API surface dependencies (return types, parameter types)
    // Even if a class is filtered out by show/hide clauses, it must be included if it's
    // used as a return type or parameter type of a kept function.
    // Use fixedFunctions to get correct return type URIs
    final apiSurfaceTypes = _collectApiSurfaceTypeDependencies(
      fixedFunctions,
      filteredVariables,
    );
    for (final typeName in apiSurfaceTypes) {
      // Check if this type is already in our bridgeable classes
      final alreadyBridgeable = bridgeableClasses.any(
        (c) => c.name == typeName,
      );
      if (!alreadyBridgeable) {
        // Check if this type exists in our filtered classes
        final existsInFiltered = filteredClasses.any((c) => c.name == typeName);
        if (!existsInFiltered) {
          // Look for this class in the original collected classes
          final originalClass = allClasses.cast<ClassInfo?>().firstWhere(
            (c) => c?.name == typeName,
            orElse: () => null,
          );
          if (originalClass != null &&
              !seenClassNames.contains(originalClass.name)) {
            filteredClasses.add(originalClass);
            bridgeableClasses.add(originalClass);
            seenClassNames.add(originalClass.name);
            // Note: Do NOT add to _exportedTypeNames - these types are not exported from
            // the barrel, so _collectAuxiliaryImportsFromTypes will generate auxiliary
            // imports for them when processing the functions that use them.
            if (verbose) {
              // ignore: avoid_print
              print(
                "GEN-055: Added '$typeName' as API surface dependency (return type or parameter type of kept function)",
              );
            }
          }
        } else {
          // Class is in filteredClasses but not bridgeable (shouldn't happen in this method, but handle it)
          final cls = filteredClasses.firstWhere((c) => c.name == typeName);
          if (!bridgeableClasses.contains(cls)) {
            bridgeableClasses.add(cls);
            if (verbose) {
              // ignore: avoid_print
              print(
                "GEN-055: Added '$typeName' to bridgeable classes (API surface dependency)",
              );
            }
          }
        }
      }
    }

    // Generate single output file content
    final code = _generateBridgeFile(
      bridgeableClasses,
      sourceFiles.first,
      moduleName,
      allClasses: filteredClasses,
      externalClassLookup: externalClassLookup.isNotEmpty
          ? externalClassLookup
          : null,
      globalFunctions: fixedFunctions,
      globalVariables: filteredVariables,
      enums: filteredEnums,
      extensions: filteredExtensions,
      importShowClause: importShowClause,
      importHideClause: importHideClause,
      // GEN-107 Phase 2: bundle mode via FileWriter — pass the full input
      // list so pure-barrel `export …` directives are captured. See sibling
      // caller in [generateBridges] for the rationale.
      reExportSourceFiles: sourceFiles,
    );

    // Write using the FileWriter
    await fileWriter.writeFile(outputFileId, code);
    outputFiles.add(fileWriter.absolutePath(outputFileId));

    return BridgeGeneratorResult(
      classesGenerated: bridgeableClasses.length,
      globalFunctionsGenerated: fixedFunctions.length,
      globalVariablesGenerated: filteredVariables.length,
      outputFiles: outputFiles,
      errors: errors,
      warnings: warnings
        ..addAll(_nonWrappableDefaultWarnings)
        ..addAll(_missingExportWarnings)
        ..addAll(_skipReports),
    );
  }

  /// Known external packages that require wrapper classes when used in defaults.
  static const _complexExternalPackages = {
    'package:pdf/',
    'package:printing/',
    'package:flutter/',
    'package:http/',
    'package:htmltopdfwidgets/',
  };

  /// Checks a class for external types in constructor parameters.
  /// Adds warnings for types that may need wrapper classes.
  void _checkExternalTypes(ClassInfo cls, List<String> warnings) {
    for (final ctor in cls.constructors) {
      for (final param in ctor.parameters) {
        // Check if any type imports are from complex external packages
        for (final uri in param.typeImportUris) {
          for (final pkg in _complexExternalPackages) {
            if (uri.startsWith(pkg)) {
              final warning = ExternalTypeWarning(
                className: cls.name,
                memberName: param.name,
                externalType: param.type,
                packageName: pkg.replaceAll('package:', '').replaceAll('/', ''),
                isDefaultValue: param.defaultValue != null,
              );
              externalTypeWarnings.add(warning);

              // Only add to warnings list if it has a default value (problematic)
              if (param.defaultValue != null) {
                warnings.add(
                  '⚠️  EXTERNAL TYPE: $warning - consider wrapping in a local class',
                );
              }
              break;
            }
          }
        }
      }
    }
  }

  /// Collects external type dependencies from parsed classes.
  ///
  /// Scans all method parameters, return types, field types, and superclasses
  /// to find types that come from packages in [followPackages].
  void _collectExternalDependencies(List<ClassInfo> classes) {
    for (final cls in classes) {
      // Check superclass for cross-package inheritance
      if (cls.superclass != null && cls.superclassUri != null) {
        for (final pkg in followPackages) {
          if (cls.superclassUri!.startsWith('package:$pkg/')) {
            _externalDependencies.add(
              ExternalTypeDependency(
                typeName: cls.superclass!,
                packageUri: cls.superclassUri!,
                referencedBy: cls.name,
                usageContext: 'superclass',
              ),
            );
            break;
          }
        }
      }

      // Check constructor parameters
      for (final ctor in cls.constructors) {
        for (final param in ctor.parameters) {
          _collectFromTypeUris(
            param.typeToUri,
            cls.name,
            'constructor parameter ${param.name}',
          );
        }
      }

      // Check members (methods, getters, setters)
      for (final member in cls.members) {
        // Check return type
        _collectFromTypeUris(
          member.returnTypeToUri,
          cls.name,
          '${member.isMethod
              ? 'method'
              : member.isGetter
              ? 'getter'
              : 'setter'} ${member.name} return type',
        );

        // Check method parameters
        for (final param in member.parameters) {
          _collectFromTypeUris(
            param.typeToUri,
            cls.name,
            'method ${member.name} parameter ${param.name}',
          );
        }
      }
    }
  }

  /// Helper to collect dependencies from type-to-URI mappings.
  void _collectFromTypeUris(
    Map<String, String> typeToUri,
    String className,
    String usageContext,
  ) {
    for (final entry in typeToUri.entries) {
      final typeName = entry.key;
      final uri = entry.value;

      // Skip dart: types - D4rt already bridges all dart:* libraries
      // See tom_d4rt/lib/src/stdlib/ for the full list:
      // - dart:core (String, int, List, Map, Set, Duration, DateTime, Uri, etc.)
      // - dart:async (Future, Stream, Completer, Timer, StreamController, etc.)
      // - dart:collection (HashMap, HashSet, LinkedList, Queue, etc.)
      // - dart:convert (json, utf8, base64, etc.)
      // - dart:io (File, Directory, Platform, Process, Socket, HttpClient, etc.)
      // - dart:math (Random, Point, Rectangle, etc.)
      // - dart:typed_data (Uint8List, ByteData, etc.)
      // - dart:isolate (Isolate, etc.)
      if (uri.startsWith('dart:')) continue;

      // Check if this is from a package we should follow
      for (final pkg in followPackages) {
        if (uri.startsWith('package:$pkg/')) {
          _externalDependencies.add(
            ExternalTypeDependency(
              typeName: typeName,
              packageUri: uri,
              referencedBy: className,
              usageContext: usageContext,
            ),
          );
          break;
        }
      }
    }
  }

  /// Resolves external dependencies by finding their source files and parsing them.
  ///
  /// Returns a list of classes from external packages that need bridges.
  Future<List<ClassInfo>> _resolveExternalDependencies() async {
    if (_externalDependencies.isEmpty || followPackages.isEmpty) {
      return [];
    }

    final resolvedClasses = <ClassInfo>[];
    final processedTypes = <String>{};

    if (verbose) {
      print(
        'Found ${_externalDependencies.length} external type dependencies to resolve',
      );
    }

    for (final dep in _externalDependencies) {
      // Skip if already processed
      final key = '${dep.typeName}@${dep.packageUri}';
      if (processedTypes.contains(key)) continue;
      processedTypes.add(key);

      // Try to resolve the package path
      final packagePath = _resolvePackageUriToFilePath(dep.packageUri);
      if (packagePath == null) {
        if (verbose) {
          print(
            '  Could not resolve path for ${dep.typeName} from ${dep.packageUri}',
          );
        }
        continue;
      }

      // Parse the file to find the class
      try {
        final classes = await parseFile(packagePath);
        final targetClass = classes
            .where((c) => c.name == dep.typeName)
            .firstOrNull;
        if (targetClass != null) {
          // Check if it's already in our class lookup
          if (!_classLookup.containsKey(dep.typeName)) {
            if (verbose) {
              print('  ✓ Resolved ${dep.typeName} from $packagePath');
            }
            resolvedClasses.add(targetClass);
          }
        } else {
          if (verbose) {
            print('  Class ${dep.typeName} not found in $packagePath');
          }
        }
      } catch (e) {
        if (verbose) {
          print('  Error parsing ${dep.packageUri}: $e');
        }
      }
    }

    return resolvedClasses;
  }

  /// Resolves a package: URI to an absolute file path (synchronous version).
  ///
  /// This resolves a full package URI like `package:tom_core_kernel/src/foo.dart`
  /// to an absolute file path. Used for resolving external type dependencies.
  String? _resolvePackageUriToFilePath(String packageUri) {
    // Parse the package URI: package:tom_core_kernel/src/foo.dart
    if (!packageUri.startsWith('package:')) return null;

    final withoutPrefix = packageUri.substring('package:'.length);
    final slashIndex = withoutPrefix.indexOf('/');
    if (slashIndex == -1) return null;

    final packageName = withoutPrefix.substring(0, slashIndex);
    final relativePath = withoutPrefix.substring(slashIndex + 1);

    // Try to find the package in the workspace
    // First check sibling directories (common in monorepo)
    final workspaceParent = p.dirname(workspacePath);
    final siblingPackage = Directory('$workspaceParent/$packageName');
    if (siblingPackage.existsSync()) {
      return p.normalize('${siblingPackage.path}/lib/$relativePath');
    }

    // Check if it's a local path dependency in pubspec.yaml
    final pubspecFile = File('$workspacePath/pubspec.yaml');
    if (pubspecFile.existsSync()) {
      final content = pubspecFile.readAsStringSync();
      // Simple regex to find path dependencies
      final pathMatch = RegExp(
        '$packageName:\\s*path:\\s*([^\\n]+)',
        multiLine: true,
      ).firstMatch(content);
      if (pathMatch != null) {
        final pathValue = pathMatch.group(1)!.trim();
        final resolvedPath = p.normalize(
          p.join(workspacePath, pathValue, 'lib', relativePath),
        );
        if (File(resolvedPath).existsSync()) {
          return resolvedPath;
        }
      }
    }

    return null;
  }

  /// Parses a Dart file and extracts class information with resolved types.
  ///
  /// This method is public to allow the orchestrator to build a global class
  /// lookup for cross-package inheritance resolution.
  ///
  /// Phase 6 (summary-refactoring-plan): the element walker is the only
  /// extraction path. Every bridged package is read from its `.sum`
  /// summary bundle, so [_tryElementModeClasses] handles both
  /// summary-backed and source-backed libraries uniformly. When
  /// resolution fails the method returns an empty list — there is no
  /// syntactic-only fallback.
  Future<List<ClassInfo>> parseFile(String filePath) async {
    // Normalize the file path
    final absolutePath = p.isAbsolute(filePath)
        ? filePath
        : p.join(Directory.current.path, filePath);
    final normalizedPath = p.normalize(absolutePath);

    try {
      final contextCollection = _getAnalysisContextFor(normalizedPath);
      final context = contextCollection.contextFor(normalizedPath);

      final elementClasses = await _tryElementModeClasses(
        context,
        normalizedPath,
      );
      if (elementClasses != null) return elementClasses;
    } catch (e) {
      if (verbose) {
        print('Warning: Could not resolve $filePath: $e');
      }
    }

    if (verbose) {
      print(
        'Warning: element-mode walker returned no library for $filePath '
        '— no classes extracted.',
      );
    }
    return const [];
  }

  /// Parses global functions, variables, and enums from a list of source files.
  ///
  /// Returns a record with lists of global functions, variables, enums,
  /// and a set of setter names for GEN-054 getter/setter matching.
  Future<
    ({
      List<GlobalFunctionInfo> functions,
      List<GlobalVariableInfo> variables,
      List<EnumInfo> enums,
      List<ExtensionInfo> extensions,
      Set<String> setterNames,
    })
  >
  _parseGlobals(List<String> sourceFiles) async {
    final functions = <GlobalFunctionInfo>[];
    final variables = <GlobalVariableInfo>[];
    final enums = <EnumInfo>[];
    final extensions = <ExtensionInfo>[];
    final setterNames = <String>{};

    for (final filePath in sourceFiles) {
      final absolutePath = p.isAbsolute(filePath)
          ? filePath
          : p.join(Directory.current.path, filePath);
      final normalizedPath = p.normalize(absolutePath);

      try {
        // Use _getAnalysisContextFor to support cross-package file analysis
        final contextCollection = _getAnalysisContextFor(normalizedPath);
        final context = contextCollection.contextFor(normalizedPath);

        final extracted = await _tryElementModeGlobals(
          context,
          normalizedPath,
        );
        if (extracted != null) {
          functions.addAll(extracted.functions);
          variables.addAll(extracted.variables);
          enums.addAll(extracted.enums);
          extensions.addAll(extracted.extensions);
          setterNames.addAll(extracted.setterNames);
        } else if (verbose) {
          print(
            'Warning: element-mode walker returned no globals from $filePath',
          );
        }
      } catch (e) {
        if (verbose) {
          print('Warning: Could not parse globals from $filePath: $e');
        }
      }
    }

    return (
      functions: functions,
      variables: variables,
      enums: enums,
      extensions: extensions,
      setterNames: setterNames,
    );
  }

  /// Converts an absolute source-file path under `/lib/` to a `package:` URI
  /// by reading the neighbouring `pubspec.yaml`. Returns `null` if the path
  /// cannot be mapped (e.g., it's not under a package's `lib/` directory).
  String? _packageUriForFilePath(String sourceFile) {
    final libIndex = sourceFile.indexOf('/lib/');
    if (libIndex == -1) return null;
    final packageDir = sourceFile.substring(0, libIndex);
    final pubspecPath = '$packageDir/pubspec.yaml';
    try {
      final pubspecFile = File(pubspecPath);
      if (!pubspecFile.existsSync()) return null;
      final content = pubspecFile.readAsStringSync();
      final nameMatch =
          RegExp(r'^name:\s*(\S+)', multiLine: true).firstMatch(content);
      final pkgName = nameMatch?.group(1);
      if (pkgName == null) return null;
      final relativePath = sourceFile.substring(libIndex + 5);
      return 'package:$pkgName/$relativePath';
    } catch (_) {
      return null;
    }
  }

  /// Resolves a [LibraryElement] for [normalizedPath], preferring the
  /// summary-friendly `getLibraryByUri(package:...)` path and falling back to
  /// `getResolvedLibrary(path)` for files that live outside a package `lib/`
  /// tree (test fixtures, scripts, etc.).
  ///
  /// Returns `null` if neither resolution strategy produced a library.
  Future<LibraryElement?> _resolveLibraryElement(
    dynamic context,
    String normalizedPath,
  ) async {
    final uriString = _packageUriForFilePath(normalizedPath);
    if (uriString != null) {
      final libResult =
          await context.currentSession.getLibraryByUri(uriString);
      if (libResult is LibraryElementResult) {
        return libResult.element;
      }
    }
    final resolved =
        await context.currentSession.getResolvedLibrary(normalizedPath);
    if (resolved is ResolvedLibraryResult) {
      return resolved.element;
    }
    return null;
  }

  /// Element-mode extraction entry point for [parseFile]. Resolves the
  /// library for [normalizedPath] (via package URI or resolved-library
  /// fallback) and walks the element tree with [ElementModeExtractor].
  ///
  /// Returns `null` if no library could be resolved.
  Future<List<ClassInfo>?> _tryElementModeClasses(
    dynamic context,
    String normalizedPath,
  ) async {
    final libraryElement =
        await _resolveLibraryElement(context, normalizedPath);
    if (libraryElement == null) return null;

    final extractor = ElementModeExtractor(
      skipPrivate: skipPrivate,
      generateDeprecatedElements: generateDeprecatedElements,
      deprecatedAllowlist: deprecatedAllowlist,
    );
    extractor.extract(libraryElement, normalizedPath);

    // Phase 5 (summary-refactoring-plan): scan the same resolved library
    // element for user bridges. User bridges living in regular bridged
    // source files are vanishingly rare — the canonical location is
    // `lib/{src/,}d4rt_user_bridges/`, covered by the pre-scan passes —
    // but we keep this hook so behaviour is identical.
    _userBridgeScanner.scanLibrary(libraryElement, normalizedPath);

    // Populate _sourceFileImports so that _resolveDefaultTypePrefix can
    // resolve identifiers like `Colors` referenced from default-value
    // expressions.
    _collectSourceFileImportsFromElement(libraryElement, normalizedPath);

    // GEN-107 Phase 2: capture `export …` directives so the generator can
    // emit `registerLibraryReExport(...)` calls in the *.b.dart file.
    _collectSourceFileReExportsFromElement(libraryElement, normalizedPath);

    skippedDeprecatedCount += extractor.skippedDeprecatedCount;
    _typedefExpansions.addAll(extractor.typedefExpansions);
    _typeAliases.addAll(extractor.typeAliases);
    _globalTypeToUri.addAll(extractor.globalTypeToUri);

    if (verbose) {
      print(
        '[element-mode] extracted ${extractor.classes.length} classes, '
        '${extractor.globalFunctions.length} functions, '
        '${extractor.enums.length} enums, '
        '${extractor.extensions.length} extensions '
        'from $normalizedPath',
      );
    }

    return extractor.classes
        .map(
          (c) => ClassInfo(
            name: c.name,
            sourceFile: normalizedPath,
            superclass: c.superclass,
            superclassUri: c.superclassUri,
            isAbstract: c.isAbstract,
            isSealed: c.isSealed,
            isMixin: c.isMixin,
            canBeUsedAsMixin: c.canBeUsedAsMixin,
            constructors: c.constructors,
            members: c.members,
            typeParameters: c.typeParameters,
            allSupertypeNames: c.allSupertypeNames,
          ),
        )
        .toList();
  }

  /// Element-mode globals extractor. See [_tryElementModeClasses] for the
  /// resolution strategy. Returns `null` if no library could be resolved.
  Future<
    ({
      List<GlobalFunctionInfo> functions,
      List<GlobalVariableInfo> variables,
      List<EnumInfo> enums,
      List<ExtensionInfo> extensions,
      Set<String> setterNames,
    })?
  > _tryElementModeGlobals(
    dynamic context,
    String normalizedPath,
  ) async {
    final libraryElement =
        await _resolveLibraryElement(context, normalizedPath);
    if (libraryElement == null) return null;

    final extractor = ElementModeExtractor(
      skipPrivate: skipPrivate,
      generateDeprecatedElements: generateDeprecatedElements,
      deprecatedAllowlist: deprecatedAllowlist,
    );
    extractor.extract(libraryElement, normalizedPath);

    // Populate _sourceFileImports so that _resolveDefaultTypePrefix can
    // resolve identifiers referenced from default-value expressions in
    // global functions / variables.
    _collectSourceFileImportsFromElement(libraryElement, normalizedPath);

    // GEN-107 Phase 2: capture `export …` directives during the globals
    // pass too — some bridged libraries reach this path without ever
    // going through _tryElementModeClasses (e.g. globals-only files).
    _collectSourceFileReExportsFromElement(libraryElement, normalizedPath);

    // GEN-049: Collect extensions from libraries imported by this file.
    // Restored in Phase 7 after the Phase 6 AST deletion unintentionally
    // removed the only call site. The helper itself has always been
    // element-API based; see `_collectExtensionsFromImportsFromElement`.
    final importedExtensions =
        _collectExtensionsFromImportsFromElement(libraryElement);

    skippedDeprecatedCount += extractor.skippedDeprecatedCount;
    _typedefExpansions.addAll(extractor.typedefExpansions);
    _typeAliases.addAll(extractor.typeAliases);
    _globalTypeToUri.addAll(extractor.globalTypeToUri);

    final allExtensions = <ExtensionInfo>[
      ...extractor.extensions,
      ...importedExtensions,
    ];

    if (verbose) {
      print(
        '[element-mode] globals: extracted ${extractor.globalFunctions.length} '
        'functions, ${extractor.globalVariables.length} variables, '
        '${extractor.enums.length} enums, ${allExtensions.length} '
        'extensions (${importedExtensions.length} from imports) '
        'from $normalizedPath',
      );
    }

    return (
      functions: extractor.globalFunctions,
      variables: extractor.globalVariables,
      enums: extractor.enums,
      extensions: allExtensions,
      setterNames: extractor.globalSetterNames,
    );
  }

  /// GEN-049: Collect extensions declared in libraries imported by
  /// [libraryElement] so that the generator can bridge extension methods
  /// defined elsewhere but visible at the source file. Element-API only —
  /// mirrors the pre-Phase-6 `_collectExtensionsFromImports` helper that was
  /// inadvertently deleted alongside the AST walker.
  ///
  /// Honours `show`/`hide` combinators via the import namespace. Skips:
  ///   * `dart:` imports (built-in),
  ///   * private extensions,
  ///   * extensions on complex (non-`InterfaceType`) generic types,
  ///   * extensions with zero bridgeable members,
  ///   * duplicate extensions seen through multiple imports.
  List<ExtensionInfo> _collectExtensionsFromImportsFromElement(
    LibraryElement libraryElement,
  ) {
    final collectedExtensions = <ExtensionInfo>[];
    final seenExtensions = <String>{};

    for (final fragment in libraryElement.fragments) {
      for (final import in fragment.libraryImports) {
        final importedLibrary = import.importedLibrary;
        if (importedLibrary == null) continue;

        final libraryUri = importedLibrary.identifier;
        if (libraryUri.startsWith('dart:')) continue;

        // Namespace honours show/hide combinators.
        final namespace = import.namespace;
        final visibleNames = namespace.definedNames2.keys.toSet();

        for (final extElement in importedLibrary.extensions) {
          final extName = extElement.name;

          // Skip unnamed extensions: per Dart 3 semantics, an unnamed
          // extension is library-private — only the library that declares
          // it can invoke its members. The bridge file is a *different*
          // library from the one that defines the extension, so emitting a
          // direct call (`(target as T).method()`) won't compile. We can
          // only safely bridge *named* extensions reachable through public
          // exports (e.g. `WidgetStateOperators`).
          if (extName == null || extName.isEmpty) continue;

          // Named extensions must be in the visible namespace.
          if (!visibleNames.contains(extName)) continue;

          if (extName.startsWith('_')) continue;

          final extUri = extElement.firstFragment.libraryFragment.source.uri;
          final extKey = '$extUri:$extName';
          if (seenExtensions.contains(extKey)) continue;
          seenExtensions.add(extKey);

          final extendedType = extElement.extendedType;
          String? onTypeName;
          String? onTypeFullName;
          String? onTypeUri;
          final onTypeArgUris = <String, String>{};
          if (extendedType is InterfaceType) {
            onTypeName = extendedType.element.name;
            // GEN-063: capture the full parameterised type (e.g.
            // `List<CommandResult>`) so the emitter can prefix generic
            // arguments correctly.
            final displayType = extendedType.getDisplayString();
            if (displayType != onTypeName) {
              onTypeFullName = displayType;
            }
            onTypeUri = extendedType.element.firstFragment
                .libraryFragment.source.uri
                .toString();
            for (final typeArg in extendedType.typeArguments) {
              if (typeArg is InterfaceType) {
                final argElement = typeArg.element;
                final argName = argElement.name;
                if (argName != null) {
                  onTypeArgUris[argName] = argElement
                      .firstFragment.libraryFragment.source.uri
                      .toString();
                }
              }
            }
          } else {
            // Complex / non-interface types (e.g. `List<T>`) — skip generic
            // variants; the emitter has no way to render them without type
            // substitution. Named, non-generic aliases are still handled.
            final typeStr = extendedType.getDisplayString();
            if (typeStr.contains('<')) continue;
            onTypeName = typeStr;
          }
          if (onTypeName == null || onTypeName.isEmpty) continue;

          final getterNames = <String>[];
          final setterNames = <String>[];
          final methodNames = <String>[];

          for (final getter in extElement.getters) {
            if (getter.isStatic) continue;
            final getterName = getter.name;
            if (getterName == null || getterName.startsWith('_')) continue;
            getterNames.add(getterName);
          }

          for (final setter in extElement.setters) {
            if (setter.isStatic) continue;
            final setterName = setter.name;
            if (setterName == null || setterName.startsWith('_')) continue;
            // Analyzer 8.x encodes setters with a trailing `=` in their name.
            final cleanName = setterName.endsWith('=')
                ? setterName.substring(0, setterName.length - 1)
                : setterName;
            setterNames.add(cleanName);
          }

          for (final method in extElement.methods) {
            if (method.isStatic) continue;
            final methodName = method.name;
            if (methodName == null || methodName.startsWith('_')) continue;
            // Operators ARE collected — the emitter routes them via
            // _generateOperatorCall so extension-defined operators can be
            // dispatched at runtime (e.g. WidgetStateOperators.|).
            methodNames.add(methodName);
          }

          if (getterNames.isEmpty &&
              setterNames.isEmpty &&
              methodNames.isEmpty) {
            continue;
          }

          collectedExtensions.add(
            ExtensionInfo(
              name: extName,
              onTypeName: onTypeName,
              onTypeFullName: onTypeFullName,
              onTypeArgUris: onTypeArgUris,
              onTypeUri: onTypeUri,
              sourceFile: extUri.toString(),
              getterNames: getterNames,
              setterNames: setterNames,
              methodNames: methodNames,
            ),
          );

          if (verbose) {
            print(
              '  GEN-049: Discovered extension '
              '$extName on $onTypeName '
              'from import $libraryUri',
            );
          }
        }
      }
    }

    return collectedExtensions;
  }

  /// Checks if a class name matches a pattern.
  bool _matchesPattern(String name, String pattern) {
    if (pattern.startsWith('*') && pattern.endsWith('*')) {
      // Contains: *Mode*
      final middle = pattern.substring(1, pattern.length - 1);
      return name.contains(middle);
    } else if (pattern.startsWith('*')) {
      // EndsWith: *Config
      final suffix = pattern.substring(1);
      return name.endsWith(suffix);
    } else if (pattern.endsWith('*')) {
      // StartsWith: Tom*
      final prefix = pattern.substring(0, pattern.length - 1);
      return name.startsWith(prefix);
    } else {
      // Exact match
      return name == pattern;
    }
  }

  /// Generates a sanitized import prefix from an import path.
  ///
  /// Uses a '$' prefix to avoid conflicts with local variables.
  /// Example: 'package:tom_build/src/tom/generation/placeholder_resolver.dart'
  /// becomes '$placeholder_resolver'.
  String _generateImportPrefix(String importPath) {
    // Get the filename without extension
    final filename = p.basenameWithoutExtension(importPath);
    // Convert to valid Dart identifier (replace non-alphanumeric with underscore)
    // Use '$' prefix to avoid conflicts with local variables
    return '\$${filename.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '_')}';
  }

  /// Map of import path to prefix for external imports.
  /// This is populated during bridge file generation.
  Map<String, String> _importPrefixes = {};

  /// Prefixes a default value with its source file's import alias if needed.
  ///
  /// Identifier-like default values (e.g., `defaultVSCodeBridgePort`) need to be
  /// prefixed with the source file's import alias because the bridge file imports
  /// source files with prefixes.
  ///
  /// Returns the original value for:
  /// - Literals: `null`, `true`, `false`, numbers, strings
  /// - Empty collections: `const []`, `const {}`
  ///
  /// For complex defaults that can't be resolved (class static members, private symbols),
  /// returns null to indicate a TODO default should be used.
  ///
  /// If [sourceFilePath] is provided, auxiliary imports from the source file will be
  /// checked for types not found in the barrel exports.
  String? _prefixDefaultValue(
    String defaultValue,
    String? sourceUri, {
    Map<String, String> typeToUri = const {},
    String? sourceFilePath,
  }) {
    // Skip literals - these are safe
    if (defaultValue == 'null' ||
        defaultValue == 'true' ||
        defaultValue == 'false') {
      return defaultValue;
    }

    // String literals
    if (defaultValue.startsWith("'") || defaultValue.startsWith('"')) {
      return defaultValue;
    }

    // Numeric literals (including negative)
    if (RegExp(r'^-?\d').hasMatch(defaultValue)) {
      return defaultValue;
    }

    // Empty collections
    if (defaultValue == 'const []' ||
        defaultValue == '[]' ||
        defaultValue == 'const {}' ||
        defaultValue == '{}') {
      return defaultValue;
    }

    // Typed empty collections like const <String>[] or const <String, int>{}
    // GEN-066: Resolve type arguments through _getTypeArgument to apply correct prefixes.
    // Source code may use prefixes like 'ui.StringAttribute' that don't exist in the bridge file.
    final typedListMatch = RegExp(
      r'^const\s*<([^>]+)>\[\]$',
    ).firstMatch(defaultValue);
    if (typedListMatch != null) {
      final typeArg = typedListMatch.group(1)!.trim();
      final resolvedType = _getTypeArgument(
        typeArg,
        typeToUri: typeToUri,
        sourceFilePath: sourceFilePath,
      );
      return 'const <$resolvedType>[]';
    }
    final typedMapSetMatch = RegExp(
      r'^const\s*<([^>]+)>\{\}$',
    ).firstMatch(defaultValue);
    if (typedMapSetMatch != null) {
      final typeArgs = typedMapSetMatch.group(1)!.trim();
      // For Map types like <String, int>, resolve each type argument
      if (typeArgs.contains(',')) {
        final parts = typeArgs.split(',').map((t) => t.trim());
        final resolvedParts = parts.map(
          (t) => _getTypeArgument(
            t,
            typeToUri: typeToUri,
            sourceFilePath: sourceFilePath,
          ),
        );
        return 'const <${resolvedParts.join(', ')}>{}';
      }
      final resolvedType = _getTypeArgument(
        typeArgs,
        typeToUri: typeToUri,
        sourceFilePath: sourceFilePath,
      );
      return 'const <$resolvedType>{}';
    }

    // 2. Core Library Constants (Duration, DateTime)
    if (defaultValue.startsWith('const Duration(') ||
        defaultValue.startsWith('const DateTime(')) {
      return defaultValue;
    }

    // 2b. GEN-065: Const constructor calls: const ClassName(...) and const ClassName.named(...)
    // Handles patterns like:
    //   const Color(0xFF000000)     → const $prefix.Color(0xFF000000)
    //   const EdgeInsets.all(0)     → const $prefix.EdgeInsets.all(0)
    //   const BorderSide()         → const $prefix.BorderSide()
    //   const Radius.circular(4.0) → const $prefix.Radius.circular(4.0)
    final constCtorMatch = RegExp(
      r'^const\s+([A-Z]\w*)(\.\w+)?\s*\(',
    ).matchAsPrefix(defaultValue);
    if (constCtorMatch != null) {
      final className = constCtorMatch.group(1)!;

      // Built-in types (e.g., Duration, DateTime) handled above — shouldn't reach here
      // but check just in case
      if (_isBuiltInType(className)) {
        return defaultValue;
      }

      // Check if the args contain nested type references (e.g., other const constructors
      // or ClassName.value patterns). We can safely prefix argument values that are
      // just literals, but nested types would need recursive prefixing.
      final argsStartIdx = defaultValue.indexOf('(');
      final argsContent = defaultValue
          .substring(argsStartIdx + 1, defaultValue.length - 1)
          .trim();
      if (argsContent.isNotEmpty &&
          RegExp(r'const\s+[A-Z]').hasMatch(argsContent)) {
        // Nested const constructors — too complex, non-wrappable
        return null;
      }

      if (argsContent.isNotEmpty) {
        final namedArgBareValues = RegExp(
          r':\s*([a-z]\w*)(?!\s*[\.(])',
        ).allMatches(argsContent);
        for (final match in namedArgBareValues) {
          final identifier = match.group(1)!;
          if (identifier == 'true' ||
              identifier == 'false' ||
              identifier == 'null' ||
              identifier == 'const') {
            continue;
          }
          // Bare lowerCamel identifiers inside const-ctor args are usually
          // top-level constants/functions from another source library and are
          // not safe to emit directly in generated bridge libraries.
          return null;
        }
      }

      if (argsContent.isNotEmpty &&
          RegExp(r'(^|[^\w])_[A-Za-z]\w*').hasMatch(argsContent)) {
        // Private symbols are library-scoped and not accessible from
        // generated bridge files, so defaults referencing them are non-wrappable.
        return null;
      }

      final resolvedPrefix = _resolveDefaultTypePrefix(
        className,
        sourceUri,
        typeToUri: typeToUri,
        sourceFilePath: sourceFilePath,
      );

      if (resolvedPrefix != null) {
        // Replace the class name with the prefixed version
        // 'const ClassName...' → 'const $prefix.ClassName...'
        final prefixedCtor = resolvedPrefix.isEmpty
            ? defaultValue
            : defaultValue.replaceFirst(
                'const $className',
                'const $resolvedPrefix.$className',
              );

        final withNestedStaticPrefixed = _prefixStaticAccessesInExpression(
          prefixedCtor,
          sourceUri,
          typeToUri: typeToUri,
          sourceFilePath: sourceFilePath,
        );
        return withNestedStaticPrefixed;
      }

      // Cannot determine prefix — non-wrappable
      return null;
    }

    // 3. Static/Enum access (ClassName.value)
    // Matches "Name.name" where Name is capitalized (Class/Enum) and name is camelCase.
    // Explicitly excludes function calls (parentheses).
    if (RegExp(r'^[A-Z]\w*\.[a-z]\w*$').hasMatch(defaultValue)) {
      final className = defaultValue.split('.').first;

      // If it's a built-in type (e.g. Duration.zero), don't prefix
      if (_isBuiltInType(className)) {
        return defaultValue;
      }

      final resolvedPrefix = _resolveDefaultTypePrefix(
        className,
        sourceUri,
        typeToUri: typeToUri,
        sourceFilePath: sourceFilePath,
      );
      if (resolvedPrefix != null) {
        return resolvedPrefix.isEmpty
            ? defaultValue
            : '$resolvedPrefix.$defaultValue';
      }
      // Cannot determine prefix — non-wrappable (triggers combinatorial dispatch)
      return null;
    }

    // 4. Simple Lists/Sets (heuristic: no internal function calls/parentheses)
    if ((defaultValue.startsWith('const [') ||
            defaultValue.startsWith('const {')) &&
        !defaultValue.contains('(')) {
      // If it contains a dot following an uppercase letter, it might be an Enum or Class constant.
      // We can't safely wrap it without parsing, so we mark it as non-wrappable.
      // This triggers combinatorial dispatch which uses the native default value.
      if (RegExp(r'[A-Z]\w*\.').hasMatch(defaultValue)) {
        return null;
      }
      return defaultValue;
    }

    // 5. Built-in numeric static constants (double.infinity, double.nan, …).
    // `double`/`int`/`num` are dart:core types available in every library, so
    // these resolve in the generated bridge with no prefix. The uppercase
    // `ClassName.member` branch above never matches them because the type name
    // is lowercase. (OPEN C.3 / U2.)
    if (_builtinNumericConstants.contains(defaultValue)) {
      return defaultValue;
    }

    // 6. Operator-bearing constant arithmetic (e.g. `math.pi * 2`, `1.0 / 2`).
    // Substitute known dart:math constants with their literal value and keep
    // built-in numeric constants as-is, leaving a literal const expression the
    // bridge can emit directly instead of the throwing TODO helper.
    // (OPEN C.3 / U2.)
    final arithmetic = _tryWrapConstArithmeticDefault(defaultValue);
    if (arithmetic != null) {
      return arithmetic;
    }

    // All other cases are non-wrappable:
    // - Const collections with values
    // - Function calls
    // - Class static members (e.g., guestUsername from TomUser)
    // - Private identifiers
    // - Any qualified identifiers (ClassName.member)
    return null;
  }

  /// Built-in numeric static constants that are valid in any Dart library and
  /// therefore emittable in a generated bridge with no import prefix.
  static const Set<String> _builtinNumericConstants = {
    'double.infinity',
    'double.negativeInfinity',
    'double.nan',
    'double.maxFinite',
    'double.minPositive',
  };

  /// `dart:math` top-level constants mapped to their literal `double` source.
  /// Substituting these lets an operator-bearing default such as `math.pi * 2`
  /// be emitted as a pure literal const expression (`3.1415926535897932 * 2`)
  /// without importing `dart:math` into the generated bridge.
  static const Map<String, String> _dartMathConstants = {
    'math.pi': '3.1415926535897932',
    'math.e': '2.718281828459045',
    'math.ln2': '0.6931471805599453',
    'math.ln10': '2.302585092994046',
    'math.log2e': '1.4426950408889634',
    'math.log10e': '0.4342944819032518',
    'math.sqrt1_2': '0.7071067811865476',
    'math.sqrt2': '1.4142135623730951',
  };

  /// Attempts to rewrite an operator-bearing constant default into a literal
  /// const expression the generated bridge can emit directly.
  ///
  /// Returns the rewritten expression, or `null` if it contains any token that
  /// cannot be safely emitted (an unknown identifier, function call, etc.) —
  /// in which case the caller keeps the existing non-wrappable behaviour.
  String? _tryWrapConstArithmeticDefault(String defaultValue) {
    // Only handle expressions that actually contain a binary arithmetic
    // operator; bare literals/identifiers are covered by the other branches.
    if (!RegExp(r'[+*/%]|\w\s*-\s*\w|\)\s*-').hasMatch(defaultValue)) {
      return null;
    }

    // Substitute known dart:math constants with their literal value.
    var expr = defaultValue;
    _dartMathConstants.forEach((token, literal) {
      expr = expr.replaceAll(RegExp('(?<![\\w.])${RegExp.escape(token)}(?![\\w])'),
          literal);
    });

    // Mask out built-in numeric constants (kept verbatim in the output) so the
    // validation pass sees only literal-arithmetic characters.
    var masked = expr;
    for (final constant in _builtinNumericConstants) {
      masked = masked.replaceAll(constant, '0');
    }

    // After substitution the expression must be pure literal arithmetic:
    // digits, decimal point, exponent marker, operators, parens, whitespace.
    if (!RegExp(r'^[0-9eE.+\-*/%()\s]+$').hasMatch(masked)) {
      return null;
    }
    // Require at least one digit so a degenerate match (e.g. a lone operator)
    // is rejected.
    if (!RegExp(r'[0-9]').hasMatch(masked)) {
      return null;
    }
    return expr;
  }

  String? _resolveDefaultTypePrefix(
    String className,
    String? sourceUri, {
    Map<String, String> typeToUri = const {},
    String? sourceFilePath,
  }) {
    if (typeToUri.containsKey(className)) {
      final uri = typeToUri[className];
      if (uri != null) {
        final prefix = _importPrefixes[uri];
        if (prefix != null) {
          return prefix;
        }
      }
    }

    if (sourceFilePath != null) {
      final auxiliaryUri = _resolveTypeFromSourceImports(
        className,
        sourceFilePath,
      );
      if (auxiliaryUri != null) {
        _addAuxiliaryImport(auxiliaryUri, className);
        return _getOrCreateAuxiliaryPrefix(auxiliaryUri);
      }
    }

    final globalUri = _globalTypeToUri[className];
    if (globalUri != null) {
      final globalPrefix = _importPrefixes[globalUri];
      if (globalPrefix != null) {
        return globalPrefix;
      }
    }

    if (sourceUri != null) {
      final sourcePrefix = _importPrefixes[sourceUri];
      if (sourcePrefix != null) {
        return sourcePrefix;
      }

      final parentUri = _partOfToParent[sourceUri];
      if (parentUri != null) {
        final parentPrefix = _importPrefixes[parentUri];
        if (parentPrefix != null) {
          return parentPrefix;
        }
      }
    }

    return null;
  }

  String? _prefixStaticAccessesInExpression(
    String expression,
    String? sourceUri, {
    Map<String, String> typeToUri = const {},
    String? sourceFilePath,
  }) {
    var unresolved = false;
    final result = expression.replaceAllMapped(
      RegExp(r'(?<![\w$\.])([A-Z]\w*)\.([a-z]\w*)(?!\s*\()'),
      (match) {
        final className = match.group(1)!;
        final fullMatch = match.group(0)!;

        if (_isBuiltInType(className)) {
          return fullMatch;
        }

        final resolvedPrefix = _resolveDefaultTypePrefix(
          className,
          sourceUri,
          typeToUri: typeToUri,
          sourceFilePath: sourceFilePath,
        );

        if (resolvedPrefix == null) {
          if (sourceUri != null) {
            unresolved = true;
          }
          return fullMatch;
        }

        return resolvedPrefix.isEmpty
            ? fullMatch
            : '$resolvedPrefix.$fullMatch';
      },
    );

    return unresolved ? null : result;
  }

  /// Checks if a default value is wrappable (can be used directly in bridge code).
  bool _isWrappableDefault(
    String defaultValue, {
    Map<String, String> typeToUri = const {},
    String? sourceFilePath,
  }) {
    return _prefixDefaultValue(
          defaultValue,
          null,
          typeToUri: typeToUri,
          sourceFilePath: sourceFilePath,
        ) !=
        null;
  }

  /// Records a warning for a non-wrappable default value.
  ///
  /// [context] describes where the default was found (e.g., "global function foo", "class Bar.method").
  /// [paramName] is the parameter name.
  /// [defaultValue] is the non-wrappable default value.
  void _recordNonWrappableDefault(
    String context,
    String paramName,
    String defaultValue,
  ) {
    final warning =
        'Non-wrappable default in $context: parameter "$paramName" has default "$defaultValue"';
    _nonWrappableDefaultWarnings.add(warning);
    if (verbose) {
      print('WARNING: $warning');
    }
  }

  /// GEN-055: Collects type names used in the API surface of bridged functions/variables.
  ///
  /// When a function returns a non-built-in type or takes one as a parameter,
  /// that type must also be bridged even if not explicitly exported from the barrel.
  ///
  /// Example: dcli's find() returns FindProgress, but the barrel only exports
  /// `show Find, find`. We need to add FindProgress as an API surface dependency.
  Set<String> _collectApiSurfaceTypeDependencies(
    List<GlobalFunctionInfo> functions,
    List<GlobalVariableInfo> variables,
  ) {
    final dependencies = <String>{};

    // Built-in types that don't need bridging
    const builtInTypes = {
      'void', 'dynamic', 'Object', 'Null',
      'bool', 'int', 'double', 'num', 'String',
      'List', 'Set', 'Map', 'Iterable', 'Iterator',
      'Future', 'FutureOr', 'Stream',
      'Function', 'Symbol', 'Type', 'Record',
      'Duration', 'DateTime', 'BigInt', 'Uri',
      'Comparable', 'Pattern', 'Match', 'RegExp',
      'Exception', 'Error', 'StackTrace',
      'Sink', 'StringSink', 'StringBuffer',
      'Encoding', 'Codec', 'Converter',
      'File',
      'Directory',
      'FileSystemEntity',
      'FileStat',
      'FileSystemEntityType',
      'Process', 'ProcessResult', 'ProcessSignal',
      'Platform', 'Stdin', 'Stdout', 'IOSink',
      'Digest', // from crypto
    };

    void collectFromType(String typeString) {
      if (typeString.isEmpty) return;

      // Strip nullability suffix
      var type = typeString;
      if (type.endsWith('?')) {
        type = type.substring(0, type.length - 1);
      }

      // Extract base type (handle generics like List<MyClass>)
      var baseType = _extractBaseType(type);

      // GEN-057: Strip import prefix (e.g., core.Which -> Which)
      if (baseType.contains('.')) {
        baseType = baseType.split('.').last;
      }

      // Skip built-in types
      if (builtInTypes.contains(baseType)) return;

      // Skip private types
      if (baseType.startsWith('_')) return;

      // Skip lowercase names (likely type parameters like T, E)
      if (baseType.isNotEmpty && baseType[0].toLowerCase() == baseType[0])
        return;

      dependencies.add(baseType);

      // Also process generic type arguments
      final ltIndex = type.indexOf('<');
      if (ltIndex > 0 && type.endsWith('>')) {
        final argsStr = type.substring(ltIndex + 1, type.length - 1);
        // Simple split on comma (doesn't handle nested generics perfectly but good enough)
        for (final arg in argsStr.split(',')) {
          collectFromType(arg.trim());
        }
      }
    }

    // Collect from function return types and parameters
    for (final func in functions) {
      collectFromType(func.returnType);
      for (final param in func.parameters) {
        collectFromType(param.type);
      }
    }

    // Collect from variable types
    for (final variable in variables) {
      collectFromType(variable.type);
    }

    return dependencies;
  }

  /// Records a warning for a type that is used but not exported from the barrel file.
  ///
  /// [context] describes where the type was used.
  /// [typeName] is the missing type name.
  void _recordMissingExport(String context, String typeName) {
    // Avoid duplicates
    final warning =
        'Missing export: Type "$typeName" used in $context is not exported from barrel file';
    if (!_missingExportWarnings.contains(warning)) {
      _missingExportWarnings.add(warning);
      if (verbose) {
        print('WARNING: $warning');
      }
    }
  }

  /// Records a skip report for an element that was not bridged.
  ///
  /// [category] describes what kind of element was skipped (e.g., "class", "method", "enum").
  /// [name] is the element name.
  /// [reason] explains why it was skipped.
  void _recordSkip(String category, String name, String reason) {
    final report = 'SKIPPED: $category $name - $reason';
    _skipReports.add(report);
    if (verbose) {
      print(report);
    }
  }

  /// Whether the constructor [ctorName] on [className] is excluded by config.
  ///
  /// Matches against [_excludeConstructors], where the default (unnamed)
  /// constructor is addressed as `ClassName.new` and named constructors as
  /// `ClassName.ctorName` (e.g. `Image.file`).
  bool _isConstructorExcluded(String className, String ctorName) {
    if (_excludeConstructors.isEmpty) return false;
    final qualified = '$className.${ctorName.isEmpty ? 'new' : ctorName}';
    return _excludeConstructors.contains(qualified);
  }

  /// Checks if a type name is exported from the barrel file.
  /// Returns true if:
  /// - The exported type names set is empty (no barrel tracking)
  /// - The type is a primitive/built-in type
  /// - The type is in the exported set
  /// - The type is available via an auxiliary import
  bool _isTypeExported(String typeName) {
    // If we're not tracking exports, assume all types are available
    if (_exportedTypeNames.isEmpty) {
      return true;
    }

    // Built-in types are always available
    const builtInTypes = {
      'int',
      'double',
      'num',
      'String',
      'bool',
      'void',
      'dynamic',
      'Object',
      'List',
      'Map',
      'Set',
      'Iterable',
      'Future',
      'Stream',
      'Function',
      'Type',
      'Symbol',
      'Null',
      'Never',
      'Duration',
      'DateTime',
      'Uri',
      'BigInt',
      'Comparable',
      'Pattern',
      'Match',
      'RegExp',
      'Runes',
      'StringBuffer',
      'StringSink',
      'Sink',
      'Error',
      'Exception',
      'StackTrace',
      'Record',
      'FutureOr',
      'MapEntry',
    };
    if (builtInTypes.contains(typeName)) {
      return true;
    }

    // Check if it's in the exported types
    if (_exportedTypeNames.contains(typeName)) {
      return true;
    }

    // Check if it's available via an auxiliary import
    for (final types in _auxiliaryImports.values) {
      if (types.contains(typeName)) {
        return true;
      }
    }

    // Check if its URI is in _importPrefixes (direct source import)
    // This covers types not exported from barrels but imported from source files
    final uri = _globalTypeToUri[typeName];
    if (uri != null && _importPrefixes.containsKey(uri)) {
      return true;
    }

    return false;
  }

  /// Resolves a type name that's not in the barrel exports by checking source file imports.
  ///
  /// Returns the import URI if the type can be resolved, null otherwise.
  String? _resolveTypeFromSourceImports(String typeName, String sourceFile) {
    final normalizedPath = p.normalize(
      p.isAbsolute(sourceFile)
          ? sourceFile
          : p.join(Directory.current.path, sourceFile),
    );
    final imports =
        _sourceFileImports[normalizedPath] ?? _sourceFileImports[sourceFile];
    if (imports == null) return null;
    return imports[typeName];
  }

  /// Resolves a type name by textually scanning the source file's import directives
  /// and checking imported barrels for the type definition.
  ///
  /// This is a fallback for when the analyzer can't resolve the type (InvalidType),
  /// typically because .pub-cache packages lack package_config.json for transitive deps.
  String? _resolveTypeByImportTextScan(String typeName, String sourceFile) {
    try {
      final content = File(sourceFile).readAsStringSync();
      // Match both single and double-quoted imports (Dart allows either)
      final importRegex = RegExp(r"""import\s+['"]([^'"]+)['"]\s*""");
      for (final match in importRegex.allMatches(content)) {
        final importUri = match.group(1)!;
        if (importUri.startsWith('dart:')) continue;

        final filePath = _resolvePackageUriToFile(importUri);
        if (filePath == null || !File(filePath).existsSync()) continue;

        // Check if type is defined or exported from this barrel
        if (_barrelExportsType(filePath, typeName)) {
          return importUri;
        }
      }
    } catch (_) {}
    return null;
  }

  /// Resolves a package: URI to a file system path using package_config.json.
  String? _resolvePackageUriToFile(String packageUri) {
    if (!packageUri.startsWith('package:')) return null;
    final withoutScheme = packageUri.substring(8);
    final slashIndex = withoutScheme.indexOf('/');
    if (slashIndex < 0) return null;
    final packageName = withoutScheme.substring(0, slashIndex);
    final relativePath = withoutScheme.substring(slashIndex + 1);

    final configFile = File('$workspacePath/.dart_tool/package_config.json');
    if (!configFile.existsSync()) return null;
    try {
      final content = configFile.readAsStringSync();
      final json = jsonDecode(content) as Map<String, dynamic>;
      final packages = json['packages'] as List<dynamic>?;
      if (packages != null) {
        for (final pkg in packages) {
          if (pkg['name'] == packageName) {
            var rootUri = pkg['rootUri'] as String;
            if (rootUri.startsWith('../')) {
              rootUri = p.normalize(
                p.join(workspacePath, '.dart_tool', rootUri),
              );
            } else if (rootUri.startsWith('file://')) {
              rootUri = Uri.parse(rootUri).toFilePath();
            }
            return p.join(rootUri, 'lib', relativePath);
          }
        }
      }
    } catch (_) {}
    return null;
  }

  /// Checks if a barrel file defines or exports a given type name.
  /// Follows export chains recursively up to [maxDepth] levels deep.
  /// Also checks `part` files which are syntactically part of the library.
  bool _barrelExportsType(
    String filePath,
    String typeName, [
    int maxDepth = 3,
  ]) {
    if (maxDepth <= 0) return false;
    try {
      final content = File(filePath).readAsStringSync();
      // Check if type is directly defined in this file
      if (_fileDefinesType(content, typeName)) return true;

      // Check part files (they are part of the same library unit)
      final partRegex = RegExp(r"""part\s+['"]([^'"]+)['"]\s*;""");
      for (final partMatch in partRegex.allMatches(content)) {
        final partRef = partMatch.group(1)!;
        final partFilePath = p.normalize(p.join(p.dirname(filePath), partRef));
        if (File(partFilePath).existsSync()) {
          final partContent = File(partFilePath).readAsStringSync();
          if (_fileDefinesType(partContent, typeName)) return true;
        }
      }

      // Check exported files recursively (reduced depth)
      final exportRegex = RegExp(r"""export\s+['"]([^'"]+)['"]\s*""");
      for (final exportMatch in exportRegex.allMatches(content)) {
        final exportRef = exportMatch.group(1)!;
        String? exportFilePath;
        if (exportRef.startsWith('package:')) {
          exportFilePath = _resolvePackageUriToFile(exportRef);
        } else {
          exportFilePath = p.normalize(p.join(p.dirname(filePath), exportRef));
        }
        if (exportFilePath != null && File(exportFilePath).existsSync()) {
          if (_barrelExportsType(exportFilePath, typeName, maxDepth - 1))
            return true;
        }
      }
    } catch (_) {}
    return false;
  }

  /// Checks if file content defines a type (class, mixin, typedef, enum) with the given name.
  bool _fileDefinesType(String content, String typeName) {
    return RegExp(
      r'(?:abstract\s+)?(?:class|mixin|typedef|enum|extension\s+type)\s+' +
          RegExp.escape(typeName) +
          r'[\s<{=]',
    ).hasMatch(content);
  }

  /// Adds a type to the auxiliary imports, tracking which URI provides it.
  void _addAuxiliaryImport(String importUri, String typeName) {
    // GEN-060 FIX: Resolve part-of files to their parent library
    final resolvedUri = _resolvePartOfToParent(importUri);
    _auxiliaryImports.putIfAbsent(resolvedUri, () => {}).add(typeName);
  }

  /// Gets or creates a prefix for an auxiliary import URI.
  ///
  /// Auxiliary imports are imports that aren't part of the barrel exports
  /// but are needed for default values, parameter types, etc.
  String _getOrCreateAuxiliaryPrefix(String uri) {
    // GEN-060 FIX: Resolve part-of files to their parent library
    final resolvedUri = _resolvePartOfToParent(uri);

    // Check if we already have a prefix for this URI
    if (_importPrefixes.containsKey(resolvedUri)) {
      final prefix = _importPrefixes[resolvedUri]!;
      return prefix.isEmpty ? '\$aux' : prefix;
    }

    // Check if we already have an auxiliary prefix for this URI
    if (_auxiliaryPrefixes.containsKey(resolvedUri)) {
      return _auxiliaryPrefixes[resolvedUri]!;
    }

    // Generate a new auxiliary prefix
    // Extract package name from URI for readability
    String baseName;
    if (resolvedUri.startsWith('package:')) {
      final parts = resolvedUri.substring(8).split('/');
      baseName = parts.first.replaceAll('-', '_');
    } else {
      baseName = 'aux';
    }

    // Make the prefix unique
    var prefix = '\$aux_$baseName';
    var counter = 1;
    while (_auxiliaryPrefixes.values.contains(prefix) ||
        _importPrefixes.values.contains(prefix)) {
      counter++;
      prefix = '\$aux_${baseName}_$counter';
    }

    _auxiliaryPrefixes[resolvedUri] = prefix;
    return prefix;
  }

  /// Forces creation of an auxiliary prefix for a URI, overriding any existing
  /// mapping in _importPrefixes.
  ///
  /// Used when a type is NOT exported from the barrel (e.g., FindProgress isn't
  /// in dcli's `show Find, find` clause), but the source file URI is already
  /// mapped to $pkg. In this case, $pkg.FindProgress won't work, so we need
  /// a direct import of the source file.
  String _forceCreateAuxiliaryPrefix(String uri) {
    // GEN-060 FIX: Detect if URI points to a 'part of' file and resolve to parent
    final resolvedUri = _resolvePartOfToParent(uri);

    // Check if we already have an auxiliary prefix for this URI
    if (_auxiliaryPrefixes.containsKey(resolvedUri)) {
      return _auxiliaryPrefixes[resolvedUri]!;
    }

    // Generate a new auxiliary prefix
    String baseName;
    if (resolvedUri.startsWith('package:')) {
      final parts = resolvedUri.substring(8).split('/');
      baseName = parts.first.replaceAll('-', '_');
    } else {
      baseName = 'aux';
    }

    // Make the prefix unique
    var prefix = '\$aux_$baseName';
    var counter = 1;
    while (_auxiliaryPrefixes.values.contains(prefix) ||
        _importPrefixes.values.contains(prefix)) {
      counter++;
      prefix = '\$aux_${baseName}_$counter';
    }

    _auxiliaryPrefixes[resolvedUri] = prefix;
    // Note: Don't update _importPrefixes here - the import-writing loop will
    // do that when it writes the import statement. Updating it here would cause
    // the loop to skip writing the import because it checks containsKey().
    return prefix;
  }

  /// Resolves a 'part of' file URI to its parent library URI.
  ///
  /// If the URI points to a file with 'part of ...' directive, returns the
  /// parent library URI. Otherwise returns the original URI unchanged.
  String _resolvePartOfToParent(String uri) {
    // Check cached mapping first
    final cached = _partOfToParent[uri];
    if (cached != null) {
      return cached;
    }

    // Only check package: URIs
    if (!uri.startsWith('package:')) return uri;

    // Try to find the file and check for 'part of'
    try {
      final filePath = _getFilePathForPackageUri(uri);
      if (filePath == null) {
        return uri;
      }

      final file = File(filePath);
      if (!file.existsSync()) {
        return uri;
      }

      final content = file.readAsStringSync();
      final firstLines = content.split('\n').take(30).toList();
      final partOfLine = firstLines.firstWhere((line) {
        final trimmed = line.trimLeft();
        return trimmed.startsWith('part of ') || trimmed == 'part of;';
      }, orElse: () => '');

      if (partOfLine.isEmpty) return uri;

      // Found 'part of' - resolve parent library
      final trimmed = partOfLine.trimLeft();
      String? parentUri;

      if (trimmed.contains("'")) {
        // URI form: part of 'relative_path.dart';
        final start = trimmed.indexOf("'") + 1;
        final end = trimmed.indexOf("'", start);
        if (end > start) {
          final relativePath = trimmed.substring(start, end);
          final parentPath = p.normalize(
            p.join(p.dirname(filePath), relativePath),
          );
          parentUri = _getPackageUri(parentPath);
        }
      } else {
        // Library name form: part of library_name;
        final match = RegExp(r'part\s+of\s+([\w.]+)\s*;').firstMatch(trimmed);
        if (match != null) {
          final libName = match.group(1)!;
          final simpleName = libName.contains('.')
              ? libName.split('.').last
              : libName;
          final parentPath = p.join(p.dirname(filePath), '$simpleName.dart');
          if (File(parentPath).existsSync()) {
            parentUri = _getPackageUri(parentPath);
          }
        }
      }

      if (parentUri != null && parentUri != uri) {
        // Cache the mapping
        _partOfToParent[uri] = parentUri;
        return parentUri;
      }
    } catch (_) {
      // If we can't read the file, return original URI
    }

    return uri;
  }

  /// Converts a package: URI to a file path if possible.
  String? _getFilePathForPackageUri(String uri) {
    if (!uri.startsWith('package:')) return null;

    // Parse package URI: package:pkg_name/path/to/file.dart
    final withoutScheme = uri.substring(8);
    final slashIndex = withoutScheme.indexOf('/');
    if (slashIndex < 0) return null;

    final pkgName = withoutScheme.substring(0, slashIndex);
    final pkgPath = withoutScheme.substring(slashIndex + 1);

    // Primary: resolve via .dart_tool/package_config.json. This is the
    // authoritative resolution graph and covers every sub-workspace
    // (including `distributed/`), unlike the hardcoded `searchDirs` fallback
    // below which historically omitted directories and caused part-of files
    // to be imported directly (B4 — tom_dist_ledger/ledger_api/call_callback).
    final pkgRoot = _packageRootSync(pkgName);
    if (pkgRoot != null) {
      final candidatePath = p.join(pkgRoot, 'lib', pkgPath);
      if (File(candidatePath).existsSync()) {
        return candidatePath;
      }
    }

    // Detect workspace root by looking for tom_workspace.yaml or tom.code-workspace
    var wsRoot = workspacePath;
    var current = Directory(workspacePath);
    while (current.path != current.parent.path) {
      if (File(p.join(current.path, 'tom_workspace.yaml')).existsSync() ||
          File(p.join(current.path, 'tom.code-workspace')).existsSync()) {
        wsRoot = current.path;
        break;
      }
      current = current.parent;
    }

    // Search common workspace locations for the package
    final searchDirs = <String>[
      wsRoot,
      p.join(wsRoot, 'core'),
      p.join(wsRoot, 'dartscript'),
      p.join(wsRoot, 'cloud'),
      p.join(wsRoot, 'uam'),
      p.join(wsRoot, 'sqm'),
      p.join(wsRoot, 'devops'),
    ];

    // Add xternal sub-directories (packages are nested inside sub-workspace dirs)
    final xternalDir = Directory(p.join(wsRoot, 'xternal'));
    if (xternalDir.existsSync()) {
      for (final entry in xternalDir.listSync()) {
        if (entry is Directory) {
          searchDirs.add(entry.path);
        }
      }
    }

    // Search for the package
    for (final searchDir in searchDirs) {
      final candidatePath = p.join(searchDir, pkgName, 'lib', pkgPath);
      if (File(candidatePath).existsSync()) {
        return candidatePath;
      }
    }

    // Also check .pub-cache for external packages
    final homeDir = Platform.environment['HOME'] ?? '';
    if (homeDir.isNotEmpty) {
      final pubCacheDir = Directory(
        p.join(homeDir, '.pub-cache', 'hosted', 'pub.dev'),
      );
      if (pubCacheDir.existsSync()) {
        // Find package directory (matches pkg_name-version pattern)
        for (final entry in pubCacheDir.listSync()) {
          if (entry is Directory &&
              p.basename(entry.path).startsWith('$pkgName-')) {
            final candidatePath = p.join(entry.path, 'lib', pkgPath);
            if (File(candidatePath).existsSync()) {
              return candidatePath;
            }
          }
        }
      }
    }

    return null;
  }

  /// Collects imports from a library element and stores type-to-URI mappings
  /// in [_sourceFileImports]. This enables default-value resolution (e.g.
  /// `Colors.white` → `package:flutter/src/material/colors.dart`) and
  /// auxiliary-import prefixing for types referenced from parameter defaults.
  void _collectSourceFileImportsFromElement(
    LibraryElement libraryElement,
    String filePath,
  ) {
    final typeToUri = <String, String>{};

    // Iterate through all fragments (includes the main file and parts)
    for (final fragment in libraryElement.fragments) {
      // Iterate through all imports in this fragment
      for (final import in fragment.libraryImports) {
        final importedLibrary = import.importedLibrary;
        if (importedLibrary == null) continue;

        // Get the URI string from the directive
        String? importUri;
        final directiveUri = import.uri;
        if (directiveUri is DirectiveUriWithRelativeUriString) {
          importUri = directiveUri.relativeUriString;
        }

        // Resolve relative URIs to package: if possible
        if (importUri == null || importUri.isEmpty) {
          importUri = importedLibrary.identifier;
        } else if (!importUri.startsWith('package:') &&
            !importUri.startsWith('dart:') &&
            directiveUri is DirectiveUriWithSource) {
          final sourcePath = directiveUri.source.fullName;
          importUri = _getPackageUri(sourcePath);
        }

        // Skip dart: imports - these are built-in
        if (importUri.startsWith('dart:')) continue;

        // The namespace gives us names visible through this import
        // (already accounts for show/hide combinators)
        final namespace = import.namespace;
        for (final name in namespace.definedNames2.keys) {
          typeToUri[name] = importUri;
        }
      }
    }

    _sourceFileImports[filePath] = typeToUri;
  }

  /// GEN-107 Phase 2: Collects `export …` directives declared by
  /// [libraryElement] and records them in [_sourceFileReExports] under
  /// [filePath].
  ///
  /// Walks every fragment's [LibraryFragment.libraryExports] (the same
  /// pattern used by [_collectSourceFileImportsFromElement] for imports),
  /// reads the resolved [LibraryExport.exportedLibrary] to get the target
  /// library's canonical URI, and translates `show` / `hide` combinators
  /// into [Set<String>] values matching the runtime API on
  /// `D4rtRunner.registerLibraryReExport`.
  ///
  /// Each `export` directive becomes one entry in the list, preserving
  /// source order so the generator can later emit them as
  /// `registerLibraryReExport(...)` calls verbatim.
  void _collectSourceFileReExportsFromElement(
    LibraryElement libraryElement,
    String filePath,
  ) {
    final reExports =
        <({String uri, Set<String>? show, Set<String>? hide})>[];

    for (final fragment in libraryElement.fragments) {
      for (final export in fragment.libraryExports) {
        final exportedLibrary = export.exportedLibrary;
        if (exportedLibrary == null) continue;

        final targetUri = exportedLibrary.identifier;
        if (targetUri.isEmpty) continue;

        Set<String>? show;
        Set<String>? hide;
        for (final combinator in export.combinators) {
          if (combinator is ShowElementCombinator) {
            (show ??= <String>{}).addAll(combinator.shownNames);
          } else if (combinator is HideElementCombinator) {
            (hide ??= <String>{}).addAll(combinator.hiddenNames);
          }
        }

        reExports.add((uri: targetUri, show: show, hide: hide));
      }
    }

    if (reExports.isNotEmpty) {
      _sourceFileReExports[filePath] = reExports;
    }
  }

  /// Pre-collect auxiliary imports needed for default values across classes and functions.
  void _collectAuxiliaryImportsFromDefaults({
    required List<ClassInfo> classes,
    required List<GlobalFunctionInfo> globalFunctions,
    required List<GlobalVariableInfo> globalVariables,
  }) {
    // Reset auxiliary tracking for this generation pass
    _auxiliaryImports.clear();
    _auxiliaryPrefixes.clear();

    void processParams(Iterable<ParameterInfo> params, String sourceFile) {
      final sourceUri = _getPackageUri(sourceFile);
      for (final param in params) {
        final defaultValue = param.defaultValue;
        if (defaultValue == null) continue;
        _prefixDefaultValue(
          defaultValue,
          sourceUri,
          typeToUri: param.typeToUri,
          sourceFilePath: sourceFile,
        );
      }
    }

    for (final func in globalFunctions) {
      processParams(func.parameters, func.sourceFile);
    }

    for (final cls in classes) {
      for (final ctor in cls.constructors) {
        processParams(ctor.parameters, cls.sourceFile);
      }
      for (final member in cls.members) {
        processParams(member.parameters, cls.sourceFile);
      }
    }
  }

  /// Pre-collect auxiliary imports needed for parameter types.
  ///
  /// This must be called BEFORE generating class bridges so that all necessary
  /// imports are written to the file header. Types that aren't exported from
  /// the barrel but are used in constructors, methods, or functions need
  /// auxiliary imports from their source files.
  void _collectAuxiliaryImportsFromTypes({
    required List<ClassInfo> classes,
    required List<GlobalFunctionInfo> globalFunctions,
    required List<GlobalVariableInfo> globalVariables,
    required List<ExtensionInfo> extensions,
  }) {
    void processTypeName(
      String typeName,
      Map<String, String> typeToUri,
      String sourceFile,
    ) {
      // Strip nullable suffix, but only if it's not inside generics
      // e.g., "String?" -> "String", but "Map<K,V>?" -> "Map<K,V>" (not "Map<K,V")
      var cleanType = typeName;
      if (cleanType.endsWith('?') && !cleanType.endsWith('>?')) {
        cleanType = cleanType.substring(0, cleanType.length - 1);
      } else if (cleanType.endsWith('>?')) {
        // Strip outer nullable from generic type: "List<T>?" -> "List<T>"
        cleanType = cleanType.substring(0, cleanType.length - 1);
      }
      // Handle generic types like List<T>, Map<K, V>
      if (cleanType.contains('<')) {
        final ltIndex = cleanType.indexOf('<');
        final gtIndex = cleanType.lastIndexOf('>');
        // Safety check: ensure we have valid < > pair and gtIndex is found
        if (gtIndex == -1 || gtIndex <= ltIndex) {
          // Malformed generic type, skip processing
          return;
        }
        final baseType = cleanType.substring(0, ltIndex);
        final innerTypes = cleanType.substring(ltIndex + 1, gtIndex);
        // Process base type
        processTypeName(baseType, typeToUri, sourceFile);
        // Process inner type arguments (split on comma, but be careful with nested generics)
        _splitTypeArguments(innerTypes).forEach((arg) {
          processTypeName(arg.trim(), typeToUri, sourceFile);
        });
        return;
      }

      // Skip built-in types
      if (_isBuiltInType(cleanType)) return;

      // GEN-055b: If the type is exported from the barrel, check if its actual
      // source URI has an import prefix. If not, add an auxiliary import.
      // The barrel may re-export the type, but typeToUri points to the original
      // source file which might not have its own import line.
      if (_isTypeExported(cleanType)) {
        var typeUri = typeToUri[cleanType] ?? _globalTypeToUri[cleanType];
        if (typeUri != null) {
          // Normalize URI to package: format
          if (typeUri.startsWith('file://') || typeUri.startsWith('file:')) {
            typeUri = _getPackageUri(Uri.parse(typeUri).toFilePath());
          } else if (!typeUri.startsWith('package:') &&
              !typeUri.startsWith('dart:')) {
            // Bare file path — convert to package: URI
            typeUri = _getPackageUri(typeUri);
          }
          // If the source file IS already imported, skip — the existing prefix works
          if (typeUri.startsWith('package:') &&
              _importPrefixes.containsKey(typeUri)) {
            return;
          }
          // Source file NOT imported — add auxiliary import for it
          if (typeUri.startsWith('package:') && !typeUri.startsWith('dart:')) {
            _addAuxiliaryImport(typeUri, cleanType);
            _forceCreateAuxiliaryPrefix(typeUri);
          }
        }
        return;
      }

      // Check typeToUri first (type info from the specific member)
      var uri = typeToUri[cleanType];
      if (uri != null) {
        if (!uri.startsWith('dart:')) {
          // Normalize URI to package: format
          if (uri.startsWith('file://') || uri.startsWith('file:')) {
            final filePath = Uri.parse(uri).toFilePath();
            uri = _getPackageUri(filePath);
          } else if (!uri.startsWith('package:')) {
            // Bare file path — convert to package: URI
            uri = _getPackageUri(uri);
          }
          if (uri.startsWith('package:')) {
            _addAuxiliaryImport(uri, cleanType);
            // GEN-055 FIX: If the type is not exported from the barrel, we need
            // to create a DIRECT import for its source file, not use $pkg.
            // The URI might already be in _importPrefixes (mapped to $pkg),
            // but since the type isn't exported, $pkg won't work - we need
            // a direct auxiliary import.
            // Force-create an auxiliary prefix, bypassing the _importPrefixes check
            _forceCreateAuxiliaryPrefix(uri);
          }
        }
        return;
      }

      // Fall back to global type registry
      uri = _globalTypeToUri[cleanType];
      if (uri != null) {
        if (!uri.startsWith('dart:')) {
          // Normalize URI to package: format
          if (uri.startsWith('file://') || uri.startsWith('file:')) {
            final filePath = Uri.parse(uri).toFilePath();
            uri = _getPackageUri(filePath);
          } else if (!uri.startsWith('package:')) {
            // Bare file path — convert to package: URI
            uri = _getPackageUri(uri);
          }
          if (uri.startsWith('package:')) {
            _addAuxiliaryImport(uri, cleanType);
            // GEN-055 FIX: Force-create auxiliary prefix for non-exported types
            _forceCreateAuxiliaryPrefix(uri);
          }
        }
        return;
      }

      // Try to resolve from source file imports
      final auxUri = _resolveTypeFromSourceImports(cleanType, sourceFile);
      if (auxUri != null) {
        _addAuxiliaryImport(auxUri, cleanType);
        // GEN-055 FIX: Force-create auxiliary prefix for non-exported types
        _forceCreateAuxiliaryPrefix(auxUri);
      }
    }

    void processParams(Iterable<ParameterInfo> params, String sourceFile) {
      for (final param in params) {
        processTypeName(param.type, param.typeToUri, sourceFile);
      }
    }

    // Process global functions
    for (final func in globalFunctions) {
      processTypeName(func.returnType, func.returnTypeToUri, func.sourceFile);
      processParams(func.parameters, func.sourceFile);
    }

    // Process global variables
    for (final v in globalVariables) {
      processTypeName(v.type, v.typeToUri, v.sourceFile);
    }

    // Process classes
    for (final cls in classes) {
      // GEN-055: For classes added as API surface dependencies, ensure their source file
      // has an auxiliary import prefix. These classes aren't exported from the barrel,
      // so $pkg.ClassName won't work - we need a direct import.
      if (!_exportedTypeNames.contains(cls.name)) {
        final classUri = _getPackageUri(cls.sourceFile);
        if (classUri.startsWith('package:') && !classUri.startsWith('dart:')) {
          _addAuxiliaryImport(classUri, cls.name);
          _forceCreateAuxiliaryPrefix(classUri);
        }
      }
      // GEN-056: Process superclass/mixin constraint types
      if (cls.superclass != null && cls.superclassUri != null) {
        final superTypeToUri = {cls.superclass!: cls.superclassUri!};
        processTypeName(cls.superclass!, superTypeToUri, cls.sourceFile);
      }
      // Process generic type parameter bounds
      for (final entry in cls.typeParameters.entries) {
        if (entry.value != null) {
          // Type bound exists - try to process it
          processTypeName(entry.value!, {}, cls.sourceFile);
        }
      }
      // Constructors
      for (final ctor in cls.constructors) {
        processParams(ctor.parameters, cls.sourceFile);
      }
      // Members (methods, getters, setters)
      for (final member in cls.members) {
        processTypeName(
          member.returnType,
          member.returnTypeToUri,
          cls.sourceFile,
        );
        processParams(member.parameters, cls.sourceFile);
      }
    }

    // Process extensions
    for (final ext in extensions) {
      // Extension "on" type - use the onTypeUri if available
      final onTypeToUri = ext.onTypeUri != null
          ? {ext.onTypeName: ext.onTypeUri!}
          : <String, String>{};
      processTypeName(ext.onTypeName, onTypeToUri, ext.sourceFile);
      // GEN-063: Process type arguments of generic on-types (e.g., CommandResult in List<CommandResult>)
      for (final entry in ext.onTypeArgUris.entries) {
        processTypeName(entry.key, {entry.key: entry.value}, ext.sourceFile);
      }
      // Extension methods
      for (final method in ext.methods) {
        processTypeName(
          method.returnType,
          method.returnTypeToUri,
          ext.sourceFile,
        );
        processParams(method.parameters, ext.sourceFile);
      }
    }
  }

  /// Splits type arguments handling nested generics.
  /// E.g., "String, Map<String, int>" -> ["String", "Map<String, int>"]
  List<String> _splitTypeArguments(String args) {
    final result = <String>[];
    var depth = 0;
    var start = 0;
    for (var i = 0; i < args.length; i++) {
      final c = args[i];
      if (c == '<')
        depth++;
      else if (c == '>')
        depth--;
      else if (c == ',' && depth == 0) {
        result.add(args.substring(start, i).trim());
        start = i + 1;
      }
    }
    if (start < args.length) {
      result.add(args.substring(start).trim());
    }
    return result;
  }

  /// Escapes a string for use in generated code.
  /// Escapes single quotes and backslashes.
  String _escapeString(String s) {
    return s.replaceAll(r'\', r'\\').replaceAll("'", r"\'");
  }

  /// Sanitizes a parameter name for use as a local variable.
  ///
  /// - Strips leading underscores (e.g., `_adapter` -> `adapter`)
  /// - Converts snake_case to camelCase (e.g., `my_var` -> `myVar`)
  String _sanitizeLocalVarName(String name) {
    // Strip leading underscores
    var result = name;
    while (result.startsWith('_')) {
      result = result.substring(1);
    }
    // If the name is empty after stripping underscores, use 'p' as fallback
    if (result.isEmpty) {
      return 'p';
    }
    // Convert snake_case to camelCase
    final parts = result.split('_');
    if (parts.length == 1) {
      return result;
    }
    final buffer = StringBuffer(parts.first);
    for (var i = 1; i < parts.length; i++) {
      if (parts[i].isNotEmpty) {
        buffer.write(parts[i][0].toUpperCase());
        buffer.write(parts[i].substring(1));
      }
    }
    return buffer.toString();
  }

  /// Generates a unique import prefix including package name for external packages.
  /// Uses 'ext\$' prefix to avoid lint warnings about leading underscores.
  String _generateUniqueImportPrefix(String uri) {
    if (uri.startsWith('package:')) {
      final content = uri.substring(8); // strip package:
      final parts = content.split('/');
      final pkg = parts.first;
      // avoid double underscores if filename is same as package
      final filename = p.basenameWithoutExtension(uri);
      if (filename == pkg || filename == 'dart') {
        return 'ext\$${pkg.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_')}';
      }
      return 'ext\$${pkg}_$filename'.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_');
    }
    return _generateImportPrefix(uri);
  }

  /// Generates bridge file content for a list of classes.
  ///
  /// [classes] - The classes to generate bridges for (non-abstract classes that can be bridged).
  /// [allClasses] - All classes including abstract ones, used for inheritance resolution.
  ///                If not provided, defaults to [classes].
  /// [externalClassLookup] - Classes from external packages for cross-package inheritance resolution.
  ///                         These are used in the lookup but not generated in this file.
  String _generateBridgeFile(
    List<ClassInfo> classes,
    String sourceFile,
    String? overrideModuleName, {
    List<ClassInfo>? allClasses,
    Map<String, ClassInfo>? externalClassLookup,
    List<GlobalFunctionInfo> globalFunctions = const [],
    List<GlobalVariableInfo> globalVariables = const [],
    List<EnumInfo> enums = const [],
    List<ExtensionInfo> extensions = const [],
    List<String> importShowClause = const [],
    List<String> importHideClause = const [],
    // GEN-107 Phase 2: explicit list of source files whose `export …`
    // directives should be looked up in [_sourceFileReExports]. Bundle-mode
    // callers pass the full input list (which includes pure-barrel files
    // with no direct declarations, like `package:flutter/services.dart`).
    // Directory-mode callers pass `[sourceFile]`. Falls back to
    // [allSourceFiles] when null.
    List<String>? reExportSourceFiles,
  }) {
    final buffer = StringBuffer();

    // Clear type resolution caches for fresh generation
    _typeResolutionCache.clear();
    _typeResolutionInProgress.clear();

    // Build class lookup map for inheritance resolution
    // Use allClasses (which includes abstract classes) for looking up superclasses
    // Also include external classes from other packages for cross-package inheritance
    final lookupClasses = allClasses ?? classes;
    _classLookup = {
      ...?externalClassLookup,
      for (final cls in lookupClasses) cls.name: cls,
    };

    // Collect all unique source files from classes, enums, extensions, and globals
    final allSourceFiles = <String>{
      ...classes.map((c) => c.sourceFile),
      ...enums.map((e) => e.sourceFile),
      ...extensions.map((e) => e.sourceFile),
      ...globalFunctions.map((f) => f.sourceFile),
      ...globalVariables.map((v) => v.sourceFile),
    }.toList()..sort();

    // Collect external type imports from resolved types
    // Filter out file:// URIs as those are local files covered by the source import
    final externalImports =
        _collectResolvedTypeImports(classes, globalFunctions: globalFunctions)
            .where(
              (uri) =>
                  !uri.startsWith('file://') && !uri.startsWith('file:///'),
            )
            .toSet();

    // Build import prefix map
    _importPrefixes = {};

    // Header - list all source files
    buffer.writeln('// D4rt Bridge - Generated file, do not edit');
    if (allSourceFiles.length == 1) {
      buffer.writeln('// Source: $sourceFile');
    } else {
      buffer.writeln('// Sources: ${allSourceFiles.length} files');
    }
    buffer.writeln('// Generated: ${DateTime.now().toIso8601String()}');
    buffer.writeln();

    // Suppress common linter warnings in generated code
    buffer.writeln(
      '// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables, implementation_imports, sort_child_properties_last, non_constant_identifier_names, avoid_function_literals_in_foreach_calls, invalid_use_of_protected_member, unnecessary_non_null_assertion, invalid_use_of_visible_for_testing_member, unnecessary_cast, unused_local_variable, no_leading_underscores_for_local_identifiers, prefer_is_empty, unnecessary_question_mark, unreachable_switch_case, unintended_html_in_doc_comment, empty_constructor_bodies, prefer_const_constructors_in_immutables, prefer_final_fields, unused_field, must_call_super, no_logic_in_create_state, use_key_in_widget_constructors, annotate_overrides, non_const_argument_for_const_parameter, unnecessary_import',
    );
    buffer.writeln();

    // Imports. When d4rtImport and helpersImport resolve to the same library
    // (e.g. the source-based runner points both at package:tom_d4rt/d4rt.dart),
    // emit a single import to avoid a `duplicate_import` warning.
    buffer.writeln("import '$d4rtImport';");
    if (helpersImport != d4rtImport) {
      buffer.writeln("import '$helpersImport';");
    }

    // Register unprefixed imports in _importPrefixes so type resolution
    // can find types from these packages (they're imported without prefix)
    _importPrefixes[d4rtImport] = '';
    _importPrefixes[helpersImport] = '';

    // Separate SDK imports (dart:*) from external package imports
    // Map private SDK libraries to their public equivalents
    final sdkImports = externalImports
        .where((uri) => uri.startsWith('dart:'))
        .map((uri) => mapPrivateSdkLibrary(uri))
        .whereType<String>() // Filter out nulls (skipped libraries)
        .toSet();

    // Flutter source APIs heavily rely on dart:ui core types (Color, Offset,
    // TextPosition, ParagraphBuilder, etc.). Analyzer summaries don't always
    // surface a stable dart:ui mapping for every such type, so ensure it is
    // always imported for Flutter bridge generation.
    final hasFlutterSources = allSourceFiles.any(
      (file) =>
          file.startsWith('package:flutter/') ||
          file.contains('/flutter/') ||
          file.contains('\\flutter\\'),
    );
    if (hasFlutterSources) {
      sdkImports.add('dart:ui');
    }

    bool shouldAliasSdkImport(String sdkUri) {
      if (sdkUri == 'dart:math') {
        return true;
      }
      if (sdkUri == 'dart:ui') {
        return true;
      }
      for (final entry in _globalTypeToUri.entries) {
        final normalizedUri = mapPrivateSdkLibrary(entry.value);
        if (normalizedUri == sdkUri &&
            !_isBuiltInType(entry.key) &&
            _exportedTypeNames.contains(entry.key)) {
          return true;
        }
      }
      return false;
    }

    // Add SDK imports.
    // Keep most dart:* imports unprefixed, but honor precomputed aliases
    // for clash-prone symbols.
    for (final importPath in sdkImports.toList()..sort()) {
      final sdkPrefix = _importPrefixes[importPath];
      if (sdkPrefix != null && sdkPrefix.isNotEmpty) {
        buffer.writeln("import '$importPath' as $sdkPrefix;");
        buffer.writeln("import '$importPath';");
      } else if (shouldAliasSdkImport(importPath)) {
        final generatedPrefix = _generateImportPrefix(importPath);
        _importPrefixes[importPath] = generatedPrefix;
        buffer.writeln("import '$importPath' as $generatedPrefix;");
        buffer.writeln("import '$importPath';");
      } else {
        _importPrefixes[importPath] = '';
        buffer.writeln("import '$importPath';");
      }
    }
    buffer.writeln();

    // === Direct Source File Import Strategy ===
    // Instead of importing from barrel files, import directly from each source file.
    // This avoids issues with types not exported from barrels (e.g., Which from dcli_core).
    // Barrel files are used only for discovery (finding which files to bridge).
    // See generator_strategies.md for the full design rationale.

    // Collect all unique package: URIs we need to import
    final allImportUris = <String>{};

    // Track which packages are covered by source files (from barrel exports)
    final coveredPackages = <String>{};

    // Clear part-of mapping for this generation run
    _partOfToParent = {};

    // From bridged symbols (their source files) — guaranteed proper libraries from barrel parsing
    for (final srcFile in allSourceFiles) {
      // GEN-060 FIX: If srcFile is a package URI, resolve it to file path first
      String? actualPath = srcFile;
      if (srcFile.startsWith('package:')) {
        actualPath = _getFilePathForPackageUri(srcFile);
        if (actualPath == null) {
          // Can't resolve to file path, check if it should be skipped via URI resolution
          final resolvedUri = _resolvePartOfToParent(srcFile);
          if (resolvedUri != srcFile) {
            // It's a part-of file, skip adding to allImportUris
            continue;
          }
          // Not a part-of file (or couldn't detect), add to imports
          if (!allImportUris.contains(srcFile)) {
            allImportUris.add(srcFile);
            final pkg = _extractPackageFromUri(srcFile);
            if (pkg != null) coveredPackages.add(pkg);
          }
          continue;
        }
      }

      // Skip 'part of' files — they can't be imported directly.
      // Types from part-of files are accessible via their parent library's import.
      try {
        final content = File(actualPath).readAsStringSync();
        final firstLines = content.split('\n').take(30).toList();
        final partOfLine = firstLines.firstWhere((line) {
          final trimmed = line.trimLeft();
          return trimmed.startsWith('part of ') || trimmed == 'part of;';
        }, orElse: () => '');
        if (partOfLine.isNotEmpty) {
          // Record the mapping from this part file to its parent library
          final partUri = srcFile.startsWith('package:')
              ? srcFile
              : _getPackageUri(srcFile);
          final trimmed = partOfLine.trimLeft();
          String? parentUri;

          if (trimmed.contains("'")) {
            // URI form: part of 'relative_path.dart';
            final start = trimmed.indexOf("'") + 1;
            final end = trimmed.indexOf("'", start);
            if (end > start) {
              final relativePath = trimmed.substring(start, end);
              final parentPath = p.normalize(
                p.join(p.dirname(actualPath), relativePath),
              );
              parentUri = _getPackageUri(parentPath);
            }
          } else {
            // Library name form: part of library_name;
            final match = RegExp(
              r'part\s+of\s+([\w.]+)\s*;',
            ).firstMatch(trimmed);
            if (match != null) {
              final libName = match.group(1)!;
              // Try to find the parent library file in the same directory
              // Convention: library_name → library_name.dart (use last segment for dotted names)
              final simpleName = libName.contains('.')
                  ? libName.split('.').last
                  : libName;
              final parentPath = p.join(
                p.dirname(actualPath),
                '$simpleName.dart',
              );
              if (File(parentPath).existsSync()) {
                parentUri = _getPackageUri(parentPath);
              }
            }
          }

          if (parentUri != null && partUri != parentUri) {
            _partOfToParent[partUri] = parentUri;
          }
          continue;
        }
      } catch (_) {
        // If we can't read the file, try importing it anyway
      }

      final uri = srcFile.startsWith('package:')
          ? srcFile
          : _getPackageUri(srcFile);
      if (uri.startsWith('package:')) {
        allImportUris.add(uri);
        final pkg = _extractPackageFromUri(uri);
        if (pkg != null) coveredPackages.add(pkg);
      }
    }

    // Include user bridge source files — these are skipped from bridge generation
    // but referenced in generated code via override methods.
    for (final entry in _userBridgeScanner.userBridges.values) {
      final uri = _getPackageUri(entry.sourceFile);
      if (uri.startsWith('package:')) {
        allImportUris.add(uri);
      }
    }
    for (final entry in _userBridgeScanner.globalsUserBridges.values) {
      final uri = _getPackageUri(entry.sourceFile);
      if (uri.startsWith('package:')) {
        allImportUris.add(uri);
      }
    }

    // From type dependencies: only add URIs from packages NOT already covered
    // by source files. This avoids importing 'part of' files from covered packages.
    // Also include extension on-type URIs — types from other packages that extensions work on.
    for (final ext in extensions) {
      var typeUri = ext.onTypeUri;
      // If onTypeUri is null (type couldn't be resolved by analyzer, e.g., InvalidType),
      // try to find it from the source file's import map or global type registry.
      if (typeUri == null && !_isBuiltInType(ext.onTypeName)) {
        typeUri = _resolveTypeFromSourceImports(ext.onTypeName, ext.sourceFile);
        typeUri ??= _globalTypeToUri[ext.onTypeName];
        // Last resort: textually scan source file imports and check barrels
        typeUri ??= _resolveTypeByImportTextScan(
          ext.onTypeName,
          ext.sourceFile,
        );
      }
      if (typeUri != null && !typeUri.startsWith('dart:')) {
        if (typeUri.startsWith('package:')) {
          final pkg = _extractPackageFromUri(typeUri);
          if (pkg != null && !coveredPackages.contains(pkg)) {
            allImportUris.add(typeUri);
          }
        }
      }
    }

    // Add external type imports (return types, parameter types from resolved AST)
    // These must be included even for covered packages because the specific source
    // file defining the return type class might not be in allSourceFiles.
    // For example: `which()` returns `Which` from dcli_core, but dcli_core's
    // `which.dart` source file isn't in allSourceFiles (since `which` is a function,
    // not a class being bridged).
    for (var uri in externalImports) {
      if (!uri.startsWith('package:')) continue;
      // GEN-060 FIX: Resolve part-of files to their parent library
      uri = _resolvePartOfToParent(uri);
      // Always add external type URIs — they're return types and parameter types
      // that must be accessible for proper type casting in generated code.
      if (!allImportUris.contains(uri)) {
        allImportUris.add(uri);
      }
    }

    // Assign $<pkgname>_<counter> prefixes and write import statements
    final packageCounters = <String, int>{};
    for (final uri in allImportUris.toList()..sort()) {
      final parsed = _parsePackageUri(uri);
      final pkgName = parsed?.$1 ?? 'pkg';
      final sanitized = pkgName.replaceAll(RegExp(r'[^a-zA-Z0-9_]'), '_');

      final counter = (packageCounters[sanitized] ?? 0) + 1;
      packageCounters[sanitized] = counter;

      final prefix = '\$${sanitized}_$counter';
      _importPrefixes[uri] = prefix;
      buffer.writeln("import '$uri' as $prefix;");
    }

    // Also map absolute file paths to their URI prefix
    // (some code paths pass absolute paths instead of package URIs)
    for (final srcFile in allSourceFiles) {
      final uri = _getPackageUri(srcFile);
      if (_importPrefixes.containsKey(uri) &&
          !_importPrefixes.containsKey(srcFile)) {
        _importPrefixes[srcFile] = _importPrefixes[uri]!;
      }
    }

    // Collect any additional imports needed for defaults and types not yet covered.
    // This acts as a safety net — with direct source imports, most URIs are already
    // in _importPrefixes, so these calls should produce few or no auxiliary imports.
    _collectAuxiliaryImportsFromDefaults(
      classes: classes,
      globalFunctions: globalFunctions,
      globalVariables: globalVariables,
    );

    _collectAuxiliaryImportsFromTypes(
      classes: classes,
      globalFunctions: globalFunctions,
      globalVariables: globalVariables,
      extensions: extensions,
    );

    if (_auxiliaryPrefixes.isNotEmpty) {
      for (final uri in _auxiliaryPrefixes.keys.toList()..sort()) {
        final auxPrefix = _auxiliaryPrefixes[uri]!;
        // GEN-060 FIX: If the URI is a 'part of' file, use its parent library instead
        var importUri = uri;
        final parentUri = _partOfToParent[uri];
        if (parentUri != null) {
          importUri = parentUri;
          // Check if parent is already imported
          if (_importPrefixes.containsKey(parentUri)) {
            continue;
          }
        }
        final existingPrefix = _importPrefixes[importUri];
        // Skip if URI already imported (with any prefix) — no need for auxiliary
        if (existingPrefix != null) {
          continue;
        }
        _importPrefixes[importUri] = auxPrefix;
        buffer.writeln("import '$importUri' as $auxPrefix;");
      }
    }
    buffer.writeln();

    // Generate module bridge class - use override name if provided, otherwise derive from file
    final moduleName =
        overrideModuleName ?? _getModuleName(classes.first.sourceFile);
    // Convert module name to PascalCase for class name (e.g., "tom_core_kernel" -> "TomCoreKernel")
    final capitalizedModuleName = toPascalCase(moduleName);
    buffer.writeln('/// Bridge class for $moduleName module.');
    buffer.writeln('class ${capitalizedModuleName}Bridge {');

    // bridgeClasses method
    buffer.writeln('  /// Returns all bridge class definitions.');
    buffer.writeln('  ///');
    buffer.writeln(
      '  /// Eager — building every class. Prefer [bridgeClassThunks] +',
    );
    buffer.writeln(
      '  /// [bridgeClassTypes] for lazy registration (Step #17); this remains',
    );
    buffer.writeln('  /// for diagnostics and callers that need the full list.');
    buffer.writeln('  static List<BridgedClass> bridgeClasses() {');
    buffer.writeln('    return [');
    for (final cls in classes) {
      buffer.writeln('      _create${cls.name}Bridge(),');
    }
    buffer.writeln('    ];');
    buffer.writeln('  }');
    buffer.writeln();

    // Step #17 — bridgeClassThunks: name → deferred factory thunk. Each thunk
    // builds one class's BridgedClass (member maps + adapter closures) on
    // demand, so a script touching N of the M classes materializes ≈N objects
    // rather than M.
    buffer.writeln('  /// Returns deferred factory thunks keyed by class name.');
    buffer.writeln('  ///');
    buffer.writeln(
      '  /// Each thunk builds one class\'s [BridgedClass] on demand. Plugs into',
    );
    buffer.writeln(
      '  /// the interpreter\'s lazy registry via [registerBridges] (Step #17).',
    );
    buffer.writeln(
      '  static Map<String, BridgedClass Function()> bridgeClassThunks() {',
    );
    buffer.writeln('    return {');
    for (final cls in classes) {
      buffer.writeln("      '${cls.name}': _create${cls.name}Bridge,");
    }
    buffer.writeln('    };');
    buffer.writeln('  }');
    buffer.writeln();

    // Step #17 — bridgeClassTypes: name → native Type, parallel to
    // [bridgeClassThunks]. Lets the registry index a class by its native type
    // without building the BridgedClass.
    buffer.writeln(
      '  /// Returns native [Type]s keyed by class name, parallel to',
    );
    buffer.writeln(
      '  /// [bridgeClassThunks] (Step #17). Used to register the native-type',
    );
    buffer.writeln('  /// lookup thunk without building the BridgedClass.');
    buffer.writeln('  static Map<String, Type> bridgeClassTypes() {');
    buffer.writeln('    return {');
    for (final cls in classes) {
      final prefixedName = _getPrefixedClassName(cls.name, cls.sourceFile);
      buffer.writeln("      '${cls.name}': $prefixedName,");
    }
    buffer.writeln('    };');
    buffer.writeln('  }');
    buffer.writeln();

    // Generate classSourceUris method for deduplication
    buffer.writeln(
      '  /// Returns a map of class names to their canonical source URIs.',
    );
    buffer.writeln('  ///');
    buffer.writeln(
      '  /// Used for deduplication when the same class is exported through',
    );
    buffer.writeln(
      '  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).',
    );
    buffer.writeln('  static Map<String, String> classSourceUris() {');
    buffer.writeln('    return {');
    for (final cls in classes) {
      final sourceUri = _getPackageUri(cls.sourceFile);
      buffer.writeln("      '${cls.name}': '$sourceUri',");
    }
    buffer.writeln('    };');
    buffer.writeln('  }');
    buffer.writeln();

    // MCI#1 / A1: Generate classSupertypes method — the flattened (transitive)
    // native supertype table. Replaces the hand-written
    // `BridgedClass.registerSupertypes({...})` block in
    // `d4rt_runtime_registrations.dart`. The interpreter feeds this to
    // `BridgedClass.registerSupertypes` so an interpreted subclass of a
    // bridged class (e.g. `MyWidget extends StatelessWidget`) passes `is`/
    // subtype checks against every bridged ancestor (`Widget`,
    // `DiagnosticableTree`, …) and the interface-proxy supertype walk in
    // `tryCreateInterfaceProxy` resolves up the chain. The list is the
    // analyzer's `allSupertypes` (superclass + interfaces + mixins,
    // transitively, minus `Object`), already captured per class — so the
    // entries are flattened, matching the two-level walk in
    // `BridgedClass.isSubtypeOf`.
    buffer.writeln(
      '  /// Returns a map of class names to their flattened (transitive)',
    );
    buffer.writeln(
      '  /// native supertype names (superclasses, interfaces and mixins).',
    );
    buffer.writeln('  ///');
    buffer.writeln(
      '  /// Fed to `BridgedClass.registerSupertypes` so interpreted subclasses',
    );
    buffer.writeln(
      '  /// of bridged classes pass `is`/subtype checks against bridged',
    );
    buffer.writeln(
      '  /// ancestors and the interface-proxy supertype walk resolves up the',
    );
    buffer.writeln('  /// chain (MCI#1 / A1).');
    buffer.writeln('  static Map<String, List<String>> classSupertypes() {');
    buffer.writeln('    return {');
    for (final cls in classes) {
      if (cls.allSupertypeNames.isEmpty) continue;
      final supers = cls.allSupertypeNames.map((s) => "'$s'").join(', ');
      buffer.writeln("      '${cls.name}': [$supers],");
    }
    buffer.writeln('    };');
    buffer.writeln('  }');
    buffer.writeln();

    // GEN-074: Generate classAliases method for type alias registration
    buffer.writeln(
      '  /// Returns a map of type alias names to their target class names.',
    );
    buffer.writeln('  ///');
    buffer.writeln(
      '  /// Type aliases like `typedef MaterialStateProperty<T> = WidgetStateProperty<T>`',
    );
    buffer.writeln(
      '  /// are registered so that code using the alias name can resolve to the',
    );
    buffer.writeln('  /// bridged class under its canonical name.');
    buffer.writeln('  static Map<String, String> classAliases() {');
    buffer.writeln('    return {');
    for (final entry in _typeAliases.entries) {
      buffer.writeln("      '${entry.key}': '${entry.value}',");
    }
    buffer.writeln('    };');
    buffer.writeln('  }');
    buffer.writeln();

    // GEN-100d: Generate functionTypedefs() method for function typedef registration
    buffer.writeln(
      '  /// Returns the list of function typedef names declared in this library.',
    );
    buffer.writeln('  ///');
    buffer.writeln(
      '  /// Function typedefs like `typedef VoidCallback = void Function()` are',
    );
    buffer.writeln(
      '  /// registered so that they can be used as type arguments in D4rt scripts.',
    );
    buffer.writeln('  static List<String> functionTypedefs() {');
    buffer.writeln('    return [');
    for (final name in _typedefExpansions.keys) {
      buffer.writeln("      '$name',");
    }
    buffer.writeln('    ];');
    buffer.writeln('  }');
    buffer.writeln();

    // Always generate bridgedEnums method (returns empty list if no enums)
    // This is required for delegating barrel files to compile
    buffer.writeln('  /// Returns all bridged enum definitions.');
    buffer.writeln('  static List<BridgedEnumDefinition> bridgedEnums() {');
    buffer.writeln('    return [');
    for (final enumInfo in enums) {
      // Get prefixed enum name for proper import reference
      final prefixedEnumName = _getPrefixedClassName(
        enumInfo.name,
        enumInfo.sourceFile,
      );
      buffer.writeln('      BridgedEnumDefinition<$prefixedEnumName>(');
      buffer.writeln("        name: '${enumInfo.name}',");
      buffer.writeln('        values: $prefixedEnumName.values,');

      // GEN-041: Emit getter adapters for enhanced enum fields
      if (enumInfo.getterNames.isNotEmpty) {
        buffer.writeln('        getters: {');
        for (final getter in enumInfo.getterNames) {
          buffer.writeln(
            "          '$getter': (visitor, target) => (target as $prefixedEnumName).$getter,",
          );
        }
        buffer.writeln('        },');
      }

      // GEN-041: Emit method adapters for enhanced enum methods
      // GEN-050: Handle operators with proper syntax (not dot notation)
      // RC-7: Use parameter-aware coercion for methods with collection params
      if (enumInfo.methodDetails.isNotEmpty) {
        buffer.writeln('        methods: {');
        for (final methodDetail in enumInfo.methodDetails) {
          final method = methodDetail.name;
          buffer.writeln(
            "          '$method': (visitor, target, positional, named, typeArgs) {",
          );
          buffer.writeln('            final t = target as $prefixedEnumName;');

          // Check if this is an operator - use operator syntax instead of Function.apply
          final operatorCall = _generateOperatorCall(method, 't');
          if (operatorCall != null) {
            buffer.writeln('            $operatorCall');
          } else if (methodDetail.hasCollectionParams) {
            // RC-7: Emit parameter-by-parameter coercion for collection types
            _emitEnumMethodWithCoercion(
              buffer,
              method,
              methodDetail,
              enumInfo.sourceFile,
            );
          } else {
            // Regular method without collection params - use Function.apply
            buffer.writeln(
              "            return Function.apply(t.$method, positional, named.map((k, v) => MapEntry(Symbol(k), v)));",
            );
          }
          buffer.writeln('          },');
        }
        buffer.writeln('        },');
      }

      // RC-8: Emit static getter adapters for non-constant static members
      if (enumInfo.staticGetterNames.isNotEmpty) {
        buffer.writeln('        staticGetters: {');
        for (final getter in enumInfo.staticGetterNames) {
          buffer.writeln(
            "          '$getter': () => $prefixedEnumName.$getter,",
          );
        }
        buffer.writeln('        },');
      }

      buffer.writeln('      ),');
    }
    buffer.writeln('    ];');
    buffer.writeln('  }');
    buffer.writeln();

    // Always generate enumSourceUris method (returns empty map if no enums)

    buffer.writeln(
      '  /// Returns a map of enum names to their canonical source URIs.',
    );
    buffer.writeln('  ///');
    buffer.writeln(
      '  /// Used for deduplication when the same enum is exported through',
    );
    buffer.writeln(
      '  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).',
    );
    buffer.writeln('  static Map<String, String> enumSourceUris() {');
    buffer.writeln('    return {');
    for (final enumInfo in enums) {
      final sourceUri = _getPackageUri(enumInfo.sourceFile);
      buffer.writeln("      '${enumInfo.name}': '$sourceUri',");
    }
    buffer.writeln('    };');
    buffer.writeln('  }');
    buffer.writeln();

    // GEN-047: Generate bridgedExtensions() method    // GEN-059: Filter extensions whose target type (onTypeName) is not resolvable.
    // If an extension targets a type from a skipped package (e.g., Digest from crypto),
    // including it would cause a registration error at runtime.
    final bridgedTypeNames = <String>{
      ...classes.map((c) => c.name),
      ...enums.map((e) => e.name),
    };
    final resolvableExtensions = extensions.where((ext) {
      if (_isBuiltInType(ext.onTypeName)) return true;
      if (bridgedTypeNames.contains(ext.onTypeName)) return true;
      // Bucket-#4 fix: accept on-types that are bridged in a sibling
      // module of the workspace. When `material.dart` re-exports
      // `widgets.dart`, an extension like `WidgetStateOperators on
      // WidgetStatesConstraint` is reachable from material scripts even
      // though `WidgetStatesConstraint` itself is bridged in widgets.dart
      // (skipped here because of skipReExports). The type lives in
      // `_globalTypeToUri` because it was discovered during barrel parsing,
      // and `_resolveExtensionOnType` will pick the right import prefix
      // (the module's source files transitively import widget_state.dart).
      if (_globalTypeToUri.containsKey(ext.onTypeName)) return true;
      // Type is neither built-in nor bridged — skip it
      return false;
    }).toList();

    buffer.writeln('  /// Returns all bridged extension definitions.');
    buffer.writeln(
      '  static List<BridgedExtensionDefinition> bridgedExtensions() {',
    );
    buffer.writeln('    return [');
    for (final ext in resolvableExtensions) {
      // For extension onType, built-in types should NOT be prefixed
      // (the extension is defined in user package but extends a built-in type)
      // For non-built-in types, resolve using the TYPE's URI (not the extension's source file)
      // because the on-type may come from a different package (e.g., Digest from crypto).
      final onTypePrefixed = _isBuiltInType(ext.onTypeName)
          ? ext.onTypeName
          : _resolveExtensionOnType(ext);
      // GEN-063: Use full generic type for cast (e.g., List<CommandResult> not just List)
      final onTypeCast = _resolveExtensionCastType(ext, onTypePrefixed);
      buffer.writeln('      BridgedExtensionDefinition(');
      if (ext.name != null) {
        buffer.writeln("        name: '${ext.name}',");
      }
      buffer.writeln("        onTypeName: '${ext.onTypeName}',");

      // Getter adapters
      if (ext.getterNames.isNotEmpty) {
        buffer.writeln('        getters: {');
        for (final getter in ext.getterNames) {
          buffer.writeln(
            "          '$getter': (visitor, target) => (target as $onTypeCast).$getter,",
          );
        }
        buffer.writeln('        },');
      }

      // Setter adapters
      if (ext.setterNames.isNotEmpty) {
        buffer.writeln('        setters: {');
        for (final setter in ext.setterNames) {
          buffer.writeln(
            "          '$setter': (visitor, target, value) => (target as $onTypeCast).$setter = value,",
          );
        }
        buffer.writeln('        },');
      }

      // Method adapters
      // GEN-050: Handle operators with proper syntax (not dot notation)
      // GEN-052: Use full method info for proper callback wrapping
      if (ext.methodNames.isNotEmpty) {
        buffer.writeln('        methods: {');

        // Build a map from method name to MemberInfo for quick lookup
        final methodInfoMap = <String, MemberInfo>{};
        for (final m in ext.methods) {
          methodInfoMap[m.name] = m;
        }

        for (final methodName in ext.methodNames) {
          buffer.writeln(
            "          '$methodName': (visitor, target, positional, named, typeArgs) {",
          );
          buffer.writeln('            final t = target as $onTypeCast;');

          // Check if this is an operator - use operator syntax instead of Function.apply.
          // Bucket #14: pass `onTypeCast` so binary operators emit static
          // dispatch (extensions are resolved statically; dynamic dispatch
          // never reaches an extension method).
          final operatorCall = _generateOperatorCall(
            methodName,
            't',
            extensionOnType: onTypeCast,
          );
          if (operatorCall != null) {
            buffer.writeln('            $operatorCall');
          } else {
            // GEN-052: Check if method has function-typed parameters that need wrapping
            final methodInfo = methodInfoMap[methodName];
            if (methodInfo != null && _hasCallbackParameter(methodInfo)) {
              // Generate proper callback wrapping (handles both simple and default-value cases)
              _generateExtensionMethodBody(
                buffer,
                ext,
                methodInfo,
                onTypePrefixed,
              );
            } else {
              // No callbacks - use Function.apply for flexibility
              buffer.writeln(
                "            return Function.apply(t.$methodName, positional, named.map((k, v) => MapEntry(Symbol(k), v)));",
              );
            }
          }
          buffer.writeln('          },');
        }
        buffer.writeln('        },');
      }

      buffer.writeln('      ),');
    }
    buffer.writeln('    ];');
    buffer.writeln('  }');
    buffer.writeln();

    // Extension source URIs
    buffer.writeln(
      '  /// Returns a map of extension identifiers to their canonical source URIs.',
    );
    buffer.writeln('  static Map<String, String> extensionSourceUris() {');
    buffer.writeln('    return {');
    for (final ext in resolvableExtensions) {
      final sourceUri = _getPackageUri(ext.sourceFile);
      final key = ext.name ?? '<unnamed>@${ext.onTypeName}';
      buffer.writeln("      '$key': '$sourceUri',");
    }
    buffer.writeln('    };');
    buffer.writeln('  }');
    buffer.writeln();

    // GEN-107 Phase 2: collect `(sourceUri, targetUri, show, hide)` tuples
    // for every `export …` directive declared by the bridged libraries, so
    // generated code can call `interpreter.registerLibraryReExport(...)`.
    // Falls back to [allSourceFiles] when callers don't pass the explicit
    // list (covers older entry points that haven't been updated).
    final reExportLookupFiles = reExportSourceFiles ?? allSourceFiles;
    final reExportEntries =
        <({String source, String target, Set<String>? show, Set<String>? hide})>[];
    for (final filePath in reExportLookupFiles) {
      final entries = _sourceFileReExports[filePath];
      if (entries == null || entries.isEmpty) continue;
      final sourceUri = _getPackageUri(filePath);
      for (final entry in entries) {
        reExportEntries.add((
          source: sourceUri,
          target: entry.uri,
          show: entry.show,
          hide: entry.hide,
        ));
      }
    }

    // Re-export factory — always emitted so the shape is stable across
    // bridge files; the body is empty when the library declares no
    // `export …` directives.
    buffer.writeln(
      '  /// GEN-107: Library re-exports declared by the bridged source',
    );
    buffer.writeln(
      '  /// libraries. Each tuple mirrors a Dart `export \'…\'` directive.',
    );
    buffer.writeln(
      '  /// Consumed by `registerBridges` via `D4rt.registerLibraryReExport`',
    );
    buffer.writeln(
      "  /// (mirrored on `D4rtRunner` in tom_d4rt_ast).",
    );
    buffer.writeln(
      '  static List<({String source, String target, Set<String>? show, Set<String>? hide})>',
    );
    buffer.writeln('  bridgeReExports() {');
    buffer.writeln('    return [');
    for (final r in reExportEntries) {
      final showLiteral = r.show == null
          ? 'null'
          : '{${r.show!.map((s) => "'$s'").join(', ')}}';
      final hideLiteral = r.hide == null
          ? 'null'
          : '{${r.hide!.map((s) => "'$s'").join(', ')}}';
      buffer.writeln(
        "      (source: '${r.source}', target: '${r.target}', show: $showLiteral, hide: $hideLiteral),",
      );
    }
    buffer.writeln('    ];');
    buffer.writeln('  }');
    buffer.writeln();

    // registerBridges method - accepts import path as parameter
    buffer.writeln('  /// Registers all bridges with an interpreter.');
    buffer.writeln('  ///');
    buffer.writeln(
      '  /// [importPath] is the package import path that D4rt scripts will use',
    );
    buffer.writeln(
      "  /// to access these classes (e.g., 'package:tom_build/tom.dart').",
    );
    buffer.writeln(
      '  static void registerBridges(D4rt interpreter, String importPath) {',
    );
    buffer.writeln(
      '    // Step #17 — register deferred factory thunks (not pre-built',
    );
    buffer.writeln(
      '    // BridgedClass objects): a script touching N of the M classes',
    );
    buffer.writeln(
      '    // materializes ≈N (each thunk builds its class on first resolve).',
    );
    buffer.writeln('    final classThunks = bridgeClassThunks();');
    buffer.writeln('    final classTypes = bridgeClassTypes();');
    buffer.writeln('    final classSources = classSourceUris();');
    buffer.writeln('    for (final entry in classThunks.entries) {');
    buffer.writeln('      interpreter.registerBridgedClassLazy(');
    buffer.writeln('        entry.key,');
    buffer.writeln('        classTypes[entry.key]!,');
    buffer.writeln('        entry.value,');
    buffer.writeln('        importPath,');
    buffer.writeln('        sourceUri: classSources[entry.key],');
    buffer.writeln('      );');
    buffer.writeln('    }');
    buffer.writeln();
    buffer.writeln(
      '    // MCI#1 / A1: Register the flattened native supertype table so',
    );
    buffer.writeln(
      '    // interpreted subclasses pass subtype checks against bridged',
    );
    buffer.writeln('    // ancestors. Idempotent — safe to call per barrel.');
    buffer.writeln(
      '    BridgedClass.registerSupertypes(classSupertypes());',
    );
    // Register enums
    if (enums.isNotEmpty) {
      buffer.writeln();
      buffer.writeln(
        '    // Register bridged enums with source URIs for deduplication',
      );
      buffer.writeln('    final enums = bridgedEnums();');
      buffer.writeln('    final enumSources = enumSourceUris();');
      buffer.writeln('    for (final enumDef in enums) {');
      buffer.writeln(
        '      interpreter.registerBridgedEnum(enumDef, importPath, sourceUri: enumSources[enumDef.name]);',
      );
      buffer.writeln('    }');
    }
    // Register global variables
    if (globalVariables.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('    // Register global variables');
      buffer.writeln('    registerGlobalVariables(interpreter, importPath);');
    }
    // Register global functions
    if (globalFunctions.isNotEmpty) {
      buffer.writeln();
      buffer.writeln(
        '    // Register global functions with source URIs for deduplication',
      );
      buffer.writeln('    final funcs = globalFunctions();');
      buffer.writeln('    final funcSources = globalFunctionSourceUris();');
      buffer.writeln('    final funcSigs = globalFunctionSignatures();');
      buffer.writeln('    for (final entry in funcs.entries) {');
      buffer.writeln(
        '      interpreter.registertopLevelFunction(entry.key, entry.value, importPath, sourceUri: funcSources[entry.key], signature: funcSigs[entry.key]);',
      );
      buffer.writeln('    }');
    }
    // GEN-047: Register bridged extensions
    if (resolvableExtensions.isNotEmpty) {
      buffer.writeln();
      buffer.writeln(
        '    // Register bridged extensions with source URIs for deduplication',
      );
      buffer.writeln('    final extensions = bridgedExtensions();');
      buffer.writeln('    final extSources = extensionSourceUris();');
      buffer.writeln('    for (final extDef in extensions) {');
      buffer.writeln(
        "      final extKey = extDef.name ?? '<unnamed>@\${extDef.onTypeName}';",
      );
      buffer.writeln(
        '      interpreter.registerBridgedExtension(extDef, importPath, sourceUri: extSources[extKey]);',
      );
      buffer.writeln('    }');
    }
    // GEN-074: Register class aliases (type aliases)
    if (_typeAliases.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('    // Register class aliases (typedef type aliases)');
      buffer.writeln('    final aliases = classAliases();');
      buffer.writeln('    for (final entry in aliases.entries) {');
      buffer.writeln(
        '      interpreter.registerClassAlias(entry.key, entry.value, importPath);',
      );
      buffer.writeln('    }');
    }
    // GEN-100d: Register function typedefs
    if (_typedefExpansions.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('    // Register function typedefs for type resolution');
      buffer.writeln('    final typedefs = functionTypedefs();');
      buffer.writeln('    for (final name in typedefs) {');
      buffer.writeln(
        '      interpreter.registerFunctionTypedef(name, importPath);',
      );
      buffer.writeln('    }');
    }
    // GEN-107 Phase 2: Register library re-exports.
    // Emitted unconditionally — the loop is a no-op when the library
    // declares no `export …` directives, but the call sequence keeps the
    // generated shape stable across bridges.
    if (reExportEntries.isNotEmpty) {
      buffer.writeln();
      buffer.writeln('    // GEN-107: Register library re-exports');
      buffer.writeln('    for (final r in bridgeReExports()) {');
      buffer.writeln(
        '      interpreter.registerLibraryReExport(r.source, r.target, show: r.show, hide: r.hide);',
      );
      buffer.writeln('    }');
    }
    buffer.writeln('  }');
    buffer.writeln();

    // Generate registerGlobalVariables method
    if (globalVariables.isNotEmpty) {
      final regularVariables = globalVariables
          .where((v) => !v.isGetter)
          .toList();
      final getterVariables = globalVariables.where((v) => v.isGetter).toList();

      buffer.writeln(
        '  /// Registers all global variables with the interpreter.',
      );
      buffer.writeln('  ///');
      buffer.writeln(
        '  /// [importPath] is the package import path for library-scoped registration.',
      );
      buffer.writeln(
        '  /// Collects all registration errors and throws a single exception',
      );
      buffer.writeln('  /// with all error details if any registrations fail.');
      buffer.writeln(
        '  static void registerGlobalVariables(D4rt interpreter, String importPath) {',
      );
      buffer.writeln('    final errors = <String>[];');
      buffer.writeln();

      // Regular variables - evaluated at registration time
      for (final variable in regularVariables) {
        // Get canonical source URI for deduplication
        final sourceUri = _getPackageUri(variable.sourceFile);
        // Get globals user bridge for this library
        final globalsUserBridge = _userBridgeScanner.getGlobalsUserBridgeFor(
          sourceUri,
        );
        final override = globalsUserBridge?.getGlobalVariableOverride(
          variable.name,
        );
        // Get prefixed variable name for proper import reference
        final prefixedVarName = _getPrefixedFunctionName(
          variable.name,
          variable.sourceFile,
        );
        final prefixedGlobalsBridge = globalsUserBridge != null
            ? _getPrefixedClassName(
                globalsUserBridge.userBridgeClassName,
                globalsUserBridge.sourceFile,
              )
            : null;
        buffer.writeln('    try {');
        if (override != null) {
          buffer.writeln(
            "      interpreter.registerGlobalVariable('${variable.name}', $prefixedGlobalsBridge.$override(), importPath, sourceUri: '$sourceUri');",
          );
        } else {
          buffer.writeln(
            "      interpreter.registerGlobalVariable('${variable.name}', $prefixedVarName, importPath, sourceUri: '$sourceUri');",
          );
        }
        buffer.writeln('    } catch (e) {');
        buffer.writeln(
          "      errors.add('Failed to register variable \"${variable.name}\": \$e');",
        );
        buffer.writeln('    }');
      }

      // Getter variables - evaluated lazily at runtime (these are safe since they're closures)
      for (final variable in getterVariables) {
        // Get canonical source URI for deduplication
        final sourceUri = _getPackageUri(variable.sourceFile);
        // Get globals user bridge for this library
        final globalsUserBridge = _userBridgeScanner.getGlobalsUserBridgeFor(
          sourceUri,
        );
        final override = globalsUserBridge?.getGlobalGetterOverride(
          variable.name,
        );
        // Get prefixed getter name for proper import reference
        final prefixedGetterName = _getPrefixedFunctionName(
          variable.name,
          variable.sourceFile,
        );
        final prefixedGlobalsBridge = globalsUserBridge != null
            ? _getPrefixedClassName(
                globalsUserBridge.userBridgeClassName,
                globalsUserBridge.sourceFile,
              )
            : null;
        if (override != null) {
          buffer.writeln(
            "    interpreter.registerGlobalGetter('${variable.name}', $prefixedGlobalsBridge.$override(), importPath, sourceUri: '$sourceUri');",
          );
        } else {
          buffer.writeln(
            "    interpreter.registerGlobalGetter('${variable.name}', () => $prefixedGetterName, importPath, sourceUri: '$sourceUri');",
          );
        }

        // GEN-054: Also register the setter if this getter has a corresponding setter.
        if (variable.hasSetter) {
          // Resolve cast type with typeToUri-aware logic so primitives and SDK
          // types don't get invalid prefixed casts (e.g. "$flutter_x.double").
          final resolvedSetterType = _getTypeArgument(
            variable.type,
            typeToUri: variable.typeToUri,
            sourceFilePath: variable.sourceFile,
          );
          buffer.writeln(
            "    interpreter.registerGlobalSetter('${variable.name}', (v) => $prefixedGetterName = v as $resolvedSetterType, importPath, sourceUri: '$sourceUri');",
          );
        }
      }

      // Throw collected errors if any
      buffer.writeln();
      buffer.writeln('    if (errors.isNotEmpty) {');
      buffer.writeln(
        "      throw StateError('Bridge registration errors ($moduleName):\\n\${errors.join(\"\\n\")}');",
      );
      buffer.writeln('    }');
      buffer.writeln('  }');
      buffer.writeln();
    }

    // Generate globalFunctions method returning a map of wrappers
    if (globalFunctions.isNotEmpty) {
      buffer.writeln(
        '  /// Returns a map of global function names to their native implementations.',
      );
      buffer.writeln(
        '  static Map<String, NativeFunctionImpl> globalFunctions() {',
      );
      buffer.writeln('    return {');
      for (final func in globalFunctions) {
        // Get canonical source URI for deduplication
        final sourceUri = _getPackageUri(func.sourceFile);
        // Get globals user bridge for this library
        final globalsUserBridge = _userBridgeScanner.getGlobalsUserBridgeFor(
          sourceUri,
        );
        // Check for function override
        final override = globalsUserBridge?.getGlobalFunctionOverride(
          func.name,
        );
        if (override != null) {
          // Use the override method instead of generating
          final prefixedGlobalsBridge = _getPrefixedClassName(
            globalsUserBridge!.userBridgeClassName,
            globalsUserBridge.sourceFile,
          );
          buffer.writeln(
            "      '${func.name}': $prefixedGlobalsBridge.$override,",
          );
          continue;
        }

        // Get the prefixed function name
        final prefixedFuncName = _getPrefixedFunctionName(
          func.name,
          func.sourceFile,
        );

        // Check for recursive type bounds
        final recursiveTypeParams = _getRecursiveBoundTypeParams(
          func.typeParameters,
        );

        buffer.writeln(
          "      '${func.name}': (visitor, positional, named, typeArgs) {",
        );

        // Count required positional parameters
        final requiredPositionalCount = func.parameters
            .where((p) => !p.isNamed && p.isRequired)
            .length;
        if (requiredPositionalCount > 0) {
          buffer.writeln(
            "        D4.requireMinArgs(positional, $requiredPositionalCount, '${func.name}');",
          );
        }

        // If function has recursive type bounds, use special dispatch
        if (recursiveTypeParams.isNotEmpty) {
          _generateRecursiveBoundDispatch(
            buffer,
            func,
            prefixedFuncName,
            recursiveTypeParams,
            '        ',
          );
          buffer.writeln('      },');
          continue;
        }

        // Generate argument extraction with proper D4 helpers
        var positionalIndex = 0;
        final argDeclarations = <String>[];
        final callArgs = <String>[];

        // Check for named unwrappable defaults for combinatorial fallback
        final nonWrappableDefaults = <ParameterInfo>[];
        for (final p in func.parameters) {
          if (p.isNamed && p.defaultValue != null) {
            // Check if this is a function-typed parameter with a non-nullable type
            // These need combinatorial dispatch because we can't pass null to a non-nullable param
            final funcInfo = p.functionTypeInfo;
            if (funcInfo != null && !p.type.endsWith('?')) {
              // Function-typed parameters with defaults and non-nullable types
              // must use combinatorial dispatch - we can't pass null
              nonWrappableDefaults.add(p);
            } else if (!_isWrappableDefault(
              p.defaultValue!,
              typeToUri: p.typeToUri,
              sourceFilePath: func.sourceFile,
            )) {
              nonWrappableDefaults.add(p);
            }
          } else if (p.isNamed &&
              p.defaultValue == null &&
              !p.isRequired &&
              !p.type.endsWith('?')) {
            // GEN-087: Named non-required non-nullable param with unavailable default
            // (e.g., const factory redirects where analyzer can't read the default).
            // Must use combinatorial dispatch to omit when not provided.
            nonWrappableDefaults.add(p);
          }
        }
        // Use combinatorial dispatch for up to 6 non-wrappable defaults
        // (generates 2^N branches, max 64). Above this threshold, falls back
        // to getRequiredNamedArgTodoDefault which requires callers to always
        // provide the value explicitly.
        final useCombinatorial =
            nonWrappableDefaults.isNotEmpty && nonWrappableDefaults.length <= 6;

        // Use function type parameters for type erasure
        final funcTypeParams = func.typeParameters;

        for (final param in func.parameters) {
          // Resolve the type using _getTypeArgument to handle generics and external types
          final resolvedType = _getTypeArgument(
            param.type,
            typeToUri: param.typeToUri,
            classTypeParams: funcTypeParams,
            sourceFilePath: func.sourceFile,
          );

          if (param.isNamed) {
            // Named parameter handling
            if (useCombinatorial && nonWrappableDefaults.contains(param)) {
              // Skip extraction for combinatorial params
              continue;
            }
            final localName = _sanitizeLocalVarName(param.name);

            // Check if this is a function-typed parameter that needs wrapping
            final funcInfo = param.functionTypeInfo;
            if (funcInfo != null) {
              // Generate callback wrapper for InterpretedFunction
              final rawVarName = '${localName}Raw';
              if (param.isRequired) {
                argDeclarations.add(
                  "        final $rawVarName = named['${param.name}'];",
                );
                argDeclarations.add("        if ($rawVarName == null) {");
                argDeclarations.add(
                  "          throw ArgumentError('${func.name}: Missing required named argument \"${param.name}\"');",
                );
                argDeclarations.add("        }");
              } else {
                argDeclarations.add(
                  "        final $rawVarName = named['${param.name}'];",
                );
              }

              // GEN-069: Nullability is based on the DECLARED TYPE, not optionality.
              // Optional named params can be omitted, but when provided,
              // non-nullable function types must stay non-nullable.
              final isNullable = param.type.endsWith('?');
              final wrapperExpr = _generateFunctionWrapper(
                callbackVarName: rawVarName,
                funcInfo: funcInfo,
                isNullable: isNullable,
                typeToUri: param.typeToUri,
                classTypeParams: funcTypeParams,
                sourceFilePath: func.sourceFile,
              );
              argDeclarations.add("        final $localName = $wrapperExpr;");
              callArgs.add('${param.name}: $localName');
              continue;
            }

            // Check for List types - need coercion (handles BridgedEnumValue unwrapping)
            if (_isListType(param.type)) {
              final elementType = _getListElementType(
                param.type,
                typeToUri: param.typeToUri,
                classTypeParams: funcTypeParams,
                sourceFilePath: func.sourceFile,
              );
              final isNullable = param.type.endsWith('?');
              final coerceMethod = isNullable
                  ? 'D4.coerceListOrNull'
                  : 'D4.coerceList';

              if (param.isRequired) {
                // GEN-071: Required nullable params only check containsKey, non-nullable also check null
                final requiredCheck = isNullable
                    ? "!named.containsKey('${param.name}')"
                    : "!named.containsKey('${param.name}') || named['${param.name}'] == null";
                argDeclarations.add("        if ($requiredCheck) {");
                argDeclarations.add(
                  "          throw ArgumentError('${func.name}: Missing required named argument \"${param.name}\"');",
                );
                argDeclarations.add("        }");
                argDeclarations.add(
                  "        final $localName = $coerceMethod<$elementType>(named['${param.name}'], '${param.name}');",
                );
              } else if (param.defaultValue != null) {
                final prefixedDefault = _prefixDefaultValue(
                  param.defaultValue!,
                  _getPackageUri(func.sourceFile),
                  typeToUri: param.typeToUri,
                  sourceFilePath: func.sourceFile,
                );
                if (prefixedDefault != null) {
                  argDeclarations.add(
                    "        final $localName = named.containsKey('${param.name}') && named['${param.name}'] != null",
                  );
                  argDeclarations.add(
                    "            ? $coerceMethod<$elementType>(named['${param.name}'], '${param.name}')",
                  );
                  argDeclarations.add("            : $prefixedDefault;");
                } else {
                  argDeclarations.add(
                    "        // TODO: Non-wrappable default: ${param.defaultValue}",
                  );
                  argDeclarations.add(
                    "        final $localName = $coerceMethod<$elementType>(named['${param.name}'], '${param.name}');",
                  );
                }
              } else {
                argDeclarations.add(
                  "        final $localName = D4.coerceListOrNull<$elementType>(named['${param.name}'], '${param.name}');",
                );
              }
              callArgs.add('${param.name}: $localName');
              continue;
            }

            if (param.isRequired) {
              argDeclarations.add(
                "        final $localName = D4.getRequiredNamedArg<$resolvedType>(named, '${param.name}', '${func.name}');",
              );
            } else if (param.defaultValue != null) {
              // Optional with default - try to use the default value
              final prefixedDefault = _prefixDefaultValue(
                param.defaultValue!,
                _getPackageUri(func.sourceFile),
                typeToUri: param.typeToUri,
                sourceFilePath: func.sourceFile,
              );
              if (prefixedDefault != null) {
                argDeclarations.add(
                  "        final $localName = D4.getNamedArgWithDefault<$resolvedType>(named, '${param.name}', $prefixedDefault);",
                );
              } else {
                // Non-wrappable default - use TODO helper and record warning
                _recordNonWrappableDefault(
                  'global function ${func.name}',
                  param.name,
                  param.defaultValue!,
                );
                argDeclarations.add(
                  "        // TODO: Non-wrappable default: ${param.defaultValue}",
                );
                argDeclarations.add(
                  "        final $localName = D4.getRequiredNamedArgTodoDefault<$resolvedType>(named, '${param.name}', '${func.name}', '${_escapeString(param.defaultValue!)}');",
                );
              }
            } else {
              if (param.type.endsWith('?')) {
                // Truly optional nullable parameter with no default
                final nullableType = _makeNullable(resolvedType);
                argDeclarations.add(
                  "        final $localName = D4.getOptionalNamedArg<$nullableType>(named, '${param.name}');",
                );
              } else {
                // Non-nullable optional named parameter with unavailable default.
                // This pattern appears in some external APIs where analyzer
                // summaries don't expose default value code.
                argDeclarations.add(
                  "        final $localName = D4.getRequiredNamedArgTodoDefault<$resolvedType>(named, '${param.name}', '${func.name}', '<default unavailable>');",
                );
              }
            }
            callArgs.add('${param.name}: $localName');
          } else {
            // Positional parameter
            final localName = _sanitizeLocalVarName(param.name);

            // Check if this is a function-typed parameter that needs wrapping
            final funcInfo = param.functionTypeInfo;
            if (funcInfo != null) {
              // Generate callback wrapper for InterpretedFunction
              final rawVarName = '${localName}Raw';
              if (param.isRequired) {
                argDeclarations.add(
                  "        if (${_lengthCheckLessThanOrEqual('positional', positionalIndex)}) {",
                );
                argDeclarations.add(
                  "          throw ArgumentError('${func.name}: Missing required argument \"${param.name}\" at position $positionalIndex');",
                );
                argDeclarations.add("        }");
                argDeclarations.add(
                  "        final $rawVarName = positional[$positionalIndex];",
                );
              } else {
                argDeclarations.add(
                  "        final $rawVarName = ${_lengthCheckGreaterThan('positional', positionalIndex)} ? positional[$positionalIndex] : null;",
                );
              }

              // GEN-069: Nullability is based on the DECLARED TYPE, not optionality.
              // Optional positional params can be omitted, but when provided,
              // non-nullable function types (e.g., VoidCallback) must stay non-nullable.
              // The null-check wrapper (raw == null ? null : ...) should only be used
              // when the type itself is nullable (e.g., VoidCallback?).
              final isNullable = param.type.endsWith('?');
              final wrapperExpr = _generateFunctionWrapper(
                callbackVarName: rawVarName,
                funcInfo: funcInfo,
                isNullable: isNullable,
                typeToUri: param.typeToUri,
                classTypeParams: funcTypeParams,
                sourceFilePath: func.sourceFile,
              );
              argDeclarations.add("        final $localName = $wrapperExpr;");
              callArgs.add(localName);
              positionalIndex++;
              continue;
            }

            if (param.isRequired) {
              // Required positional - use D4.getRequiredArg
              if (_isRecordType(resolvedType)) {
                // Record parameters need InterpretedRecord→native conversion
                final recordLines = _generateRecordParamExtraction(
                  localName: localName,
                  resolvedType: resolvedType,
                  positionalIndex: positionalIndex,
                  paramName: param.name,
                  funcName: func.name,
                  indent: '      ',
                );
                for (final line in recordLines) {
                  argDeclarations.add(line);
                }
              } else {
                argDeclarations.add(
                  "        final $localName = D4.getRequiredArg<$resolvedType>(positional, $positionalIndex, '${param.name}', '${func.name}');",
                );
              }
              callArgs.add(localName);
            } else if (param.defaultValue != null) {
              // Optional positional with default
              final prefixedDefault = _prefixDefaultValue(
                param.defaultValue!,
                _getPackageUri(func.sourceFile),
                typeToUri: param.typeToUri,
                sourceFilePath: func.sourceFile,
              );
              if (prefixedDefault != null) {
                argDeclarations.add(
                  "        final $localName = D4.getOptionalArgWithDefault<$resolvedType>(positional, $positionalIndex, '${param.name}', $prefixedDefault);",
                );
              } else {
                // Non-wrappable default - use TODO helper and record warning
                _recordNonWrappableDefault(
                  'global function ${func.name}',
                  param.name,
                  param.defaultValue!,
                );
                argDeclarations.add(
                  "        // TODO: Non-wrappable default: ${param.defaultValue}",
                );
                argDeclarations.add(
                  "        final $localName = D4.getRequiredArgTodoDefault<$resolvedType>(positional, $positionalIndex, '${param.name}', '${func.name}', '${_escapeString(param.defaultValue!)}');",
                );
              }
              callArgs.add(localName);
            } else {
              // Optional positional with no default - use nullable type
              final nullableType = _makeNullable(resolvedType);
              argDeclarations.add(
                "        final $localName = ${_lengthCheckGreaterThan('positional', positionalIndex)} ? positional[$positionalIndex] as $nullableType : null;",
              );
              callArgs.add(localName);
            }
            positionalIndex++;
          }
        }

        // Write declarations
        for (final decl in argDeclarations) {
          buffer.writeln(decl);
        }

        final isVoid = func.returnType == 'void';

        // Determine if we need explicit type arguments.
        // When a function has unbounded type parameters that resolve to dynamic,
        // and the return context is Object?, Dart's type inference may incorrectly
        // infer T=Object instead of T=dynamic, causing type mismatches.
        // We add explicit <dynamic, ...> type arguments to prevent this.
        String typeArgsStr = '';
        if (func.hasTypeParameters && funcTypeParams.isNotEmpty) {
          // Check if any type parameter is unbounded (resolves to dynamic)
          final needsExplicitTypeArgs = funcTypeParams.values.any(
            (bound) => bound == null,
          );
          if (needsExplicitTypeArgs) {
            // Generate <dynamic, dynamic, ...> for each unbounded type parameter
            final typeArgs = funcTypeParams.entries.map((e) {
              if (e.value == null) return 'dynamic';
              // For bounded type parameters, use the bound
              return _getTypeArgument(
                e.value!,
                typeToUri: {},
                classTypeParams: funcTypeParams,
              );
            }).toList();
            typeArgsStr = '<${typeArgs.join(', ')}>';
          }
        }

        if (useCombinatorial) {
          _generateCombinatorialDispatch(
            buffer,
            prefixedFuncName,
            callArgs,
            nonWrappableDefaults,
            func.name,
            isVoid: isVoid,
            typeParams: funcTypeParams,
            sourceFilePath: func.sourceFile,
          );
        } else {
          final callExpr =
              '$prefixedFuncName$typeArgsStr(${callArgs.join(', ')})';
          if (_isRecordType(func.returnType)) {
            // Record return types need native→InterpretedRecord conversion
            buffer.write(
              _generateRecordReturnWrapper(
                callExpr: callExpr,
                returnType: func.returnType,
                indent: '      ',
              ),
            );
            buffer.writeln();
          } else {
            buffer.writeln('        return $callExpr;');
          }
        }
        buffer.writeln('      },');
      }
      buffer.writeln('    };');
      buffer.writeln('  }');
      buffer.writeln();

      // Generate globalFunctionSourceUris method for deduplication
      buffer.writeln(
        '  /// Returns a map of global function names to their canonical source URIs.',
      );
      buffer.writeln('  ///');
      buffer.writeln(
        '  /// Used for deduplication when the same function is exported through',
      );
      buffer.writeln(
        '  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).',
      );
      buffer.writeln(
        '  static Map<String, String> globalFunctionSourceUris() {',
      );
      buffer.writeln('    return {');
      for (final func in globalFunctions) {
        final sourceUri = _getPackageUri(func.sourceFile);
        buffer.writeln("      '${func.name}': '$sourceUri',");
      }
      buffer.writeln('    };');
      buffer.writeln('  }');
      buffer.writeln();

      // Generate globalFunctionSignatures method for introspection
      buffer.writeln(
        '  /// Returns a map of global function names to their display signatures.',
      );
      buffer.writeln(
        '  static Map<String, String> globalFunctionSignatures() {',
      );
      buffer.writeln('    return {');
      for (final func in globalFunctions) {
        final signature = _escapeString(_getGlobalFunctionSignature(func));
        buffer.writeln("      '${func.name}': '$signature',");
      }
      buffer.writeln('    };');
      buffer.writeln('  }');
      buffer.writeln();
    } else {
      // Always generate empty globalFunctions() for delegating barrel compatibility
      buffer.writeln(
        '  /// Returns a map of global function names to their native implementations.',
      );
      buffer.writeln(
        '  static Map<String, NativeFunctionImpl> globalFunctions() {',
      );
      buffer.writeln('    return {};');
      buffer.writeln('  }');
      buffer.writeln();

      buffer.writeln(
        '  /// Returns a map of global function names to their canonical source URIs.',
      );
      buffer.writeln(
        '  static Map<String, String> globalFunctionSourceUris() {',
      );
      buffer.writeln('    return {};');
      buffer.writeln('  }');
      buffer.writeln();

      buffer.writeln(
        '  /// Returns a map of global function names to their display signatures.',
      );
      buffer.writeln(
        '  static Map<String, String> globalFunctionSignatures() {',
      );
      buffer.writeln('    return {};');
      buffer.writeln('  }');
      buffer.writeln();
    }

    // Generate sourceLibraries method - returns all unique source libraries
    // Collect all unique source URIs from classes, enums, functions, and variables
    final allSourceUris = <String>{
      ...classes.map((c) => _getPackageUri(c.sourceFile)),
      ...enums.map((e) => _getPackageUri(e.sourceFile)),
      ...globalFunctions.map((f) => _getPackageUri(f.sourceFile)),
      ...globalVariables.map((v) => _getPackageUri(v.sourceFile)),
    }.toList()..sort();

    buffer.writeln('  /// Returns the list of canonical source library URIs.');
    buffer.writeln('  ///');
    buffer.writeln(
      '  /// These are the actual source locations of all elements in this bridge,',
    );
    buffer.writeln(
      '  /// used for deduplication when the same libraries are exported through',
    );
    buffer.writeln('  /// multiple barrels.');
    buffer.writeln('  static List<String> sourceLibraries() {');
    buffer.writeln('    return [');
    for (final uri in allSourceUris) {
      buffer.writeln("      '$uri',");
    }
    buffer.writeln('    ];');
    buffer.writeln('  }');
    buffer.writeln();

    // getImportBlock method - returns import statements for D4rt scripts
    String? importBlockUri;
    if (sourceImport != null && sourceImport!.startsWith('package:')) {
      // Full package URI provided
      importBlockUri = sourceImport;
    } else {
      final detectedPackageName =
          packageName ?? _getPackageNameFromPath(sourceFile);
      if (detectedPackageName != null && sourceImport != null) {
        importBlockUri = 'package:$detectedPackageName/$sourceImport';
      }
    }

    if (importBlockUri != null) {
      // Pre-compute the set of sub-packages that have actual bridged content.
      // Used by both getImportBlock() and subPackageBarrels() to avoid including
      // packages that are only referenced for types but have no bridged content
      // (e.g., crypto when skipReExports includes it).
      final primaryPackage = _extractPackageFromUri(importBlockUri);
      final contentPackages = <String>{};
      for (final uri in allSourceUris) {
        if (!uri.startsWith('package:')) continue;
        final pkg = _extractPackageFromUri(uri);
        if (pkg != null && pkg != primaryPackage) {
          contentPackages.add(pkg);
        }
      }
      // Also include extensions' source packages
      for (final ext in extensions) {
        final uri = _getPackageUri(ext.sourceFile);
        if (!uri.startsWith('package:')) continue;
        final pkg = _extractPackageFromUri(uri);
        if (pkg != null && pkg != primaryPackage) {
          contentPackages.add(pkg);
        }
      }

      buffer.writeln(
        '  /// Returns the import statement needed for D4rt scripts.',
      );
      buffer.writeln('  ///');
      buffer.writeln(
        '  /// Use this in your D4rt initialization script to make all',
      );
      buffer.writeln('  /// bridged classes available to scripts.');
      buffer.writeln('  static String getImportBlock() {');

      // Collect sub-package barrel imports, filtered to only those with content.
      final subPackageBarrels = <String>{};
      for (final uri in _importPrefixes.keys) {
        if (!uri.startsWith('package:')) continue;
        final pkg = _extractPackageFromUri(uri);
        if (pkg != null &&
            pkg != primaryPackage &&
            contentPackages.contains(pkg)) {
          subPackageBarrels.add('package:$pkg/$pkg.dart');
        }
      }
      for (final uri in _auxiliaryImports.keys) {
        if (!uri.startsWith('package:')) continue;
        final pkg = _extractPackageFromUri(uri);
        if (pkg != null &&
            pkg != primaryPackage &&
            contentPackages.contains(pkg)) {
          subPackageBarrels.add('package:$pkg/$pkg.dart');
        }
      }

      // Check if we have additional barrel imports beyond the primary one
      final additionalBarrels = sourceImports
          .where((si) => si != importBlockUri && si.startsWith('package:'))
          .toList();

      // Merge additionalBarrels with sub-package barrels
      final allExtraBarrels = <String>{
        ...additionalBarrels,
        ...subPackageBarrels,
      }.where((b) => b != importBlockUri).toList()..sort();

      if (allExtraBarrels.isEmpty) {
        // Single barrel - return single import statement
        // Build import statement with optional show/hide clauses
        if (importShowClause.isNotEmpty) {
          final showList = importShowClause.join(', ');
          buffer.writeln(
            "    return \"import '$importBlockUri' show $showList;\";",
          );
        } else if (importHideClause.isNotEmpty) {
          final hideList = importHideClause.join(', ');
          buffer.writeln(
            "    return \"import '$importBlockUri' hide $hideList;\";",
          );
        } else {
          buffer.writeln("    return \"import '$importBlockUri';\";");
        }
      } else {
        // Multiple barrels - return import statements for all of them
        buffer.writeln("    final imports = StringBuffer();");
        // Primary barrel with optional show/hide
        if (importShowClause.isNotEmpty) {
          final showList = importShowClause.join(', ');
          buffer.writeln(
            "    imports.writeln(\"import '$importBlockUri' show $showList;\");",
          );
        } else if (importHideClause.isNotEmpty) {
          final hideList = importHideClause.join(', ');
          buffer.writeln(
            "    imports.writeln(\"import '$importBlockUri' hide $hideList;\");",
          );
        } else {
          buffer.writeln("    imports.writeln(\"import '$importBlockUri';\");");
        }
        // Additional barrels (sub-packages and explicit barrels)
        for (final barrel in allExtraBarrels) {
          buffer.writeln("    imports.writeln(\"import '$barrel';\");");
        }
        buffer.writeln("    return imports.toString();");
      }
      buffer.writeln('  }');
      buffer.writeln();

      // Generate subPackageBarrels() method - returns barrel URIs for sub-packages
      // that have actual bridged content. Reuses the contentPackages set
      // computed above for consistency with getImportBlock().
      final sortedContentBarrels =
          contentPackages.map((pkg) => 'package:$pkg/$pkg.dart').toList()
            ..sort();

      buffer.writeln(
        '  /// Returns barrel import URIs for sub-packages discovered through re-exports.',
      );
      buffer.writeln('  ///');
      buffer.writeln(
        '  /// When a module follows re-exports into sub-packages (e.g., dcli re-exports',
      );
      buffer.writeln(
        '  /// dcli_core), D4rt scripts may import those sub-packages directly.',
      );
      buffer.writeln(
        '  /// These barrels need to be registered with the interpreter separately',
      );
      buffer.writeln(
        '  /// so that module resolution finds content for those URIs.',
      );
      buffer.writeln('  static List<String> subPackageBarrels() {');
      if (sortedContentBarrels.isNotEmpty) {
        buffer.writeln('    return [');
        for (final barrel in sortedContentBarrels) {
          buffer.writeln("      '$barrel',");
        }
        buffer.writeln('    ];');
      } else {
        buffer.writeln('    return [];');
      }
      buffer.writeln('  }');
      buffer.writeln();
    } else {
      // Single-package inline strategy with no resolved barrel URI. The
      // generated dartscript helper calls getImportBlock() and
      // subPackageBarrels() UNCONDITIONALLY, so both methods must be emitted
      // here too — matching sourceLibraries() above, which is always emitted.
      // (Gating these behind importBlockUri != null caused a downstream
      // compile regression: dartscript.b.dart called methods that the
      // AllBridge class no longer declared.)
      //
      // Derive the import block straight from the canonical source libraries
      // so D4rt scripts still get a usable import surface, and report no
      // sub-package barrels (there are none in this configuration).
      final packageSourceUris =
          allSourceUris.where((uri) => uri.startsWith('package:')).toList()
            ..sort();

      buffer.writeln(
        '  /// Returns the import statement needed for D4rt scripts.',
      );
      buffer.writeln('  ///');
      buffer.writeln(
        '  /// Use this in your D4rt initialization script to make all',
      );
      buffer.writeln('  /// bridged classes available to scripts.');
      buffer.writeln('  static String getImportBlock() {');
      if (packageSourceUris.isEmpty) {
        buffer.writeln("    return '';");
      } else if (packageSourceUris.length == 1) {
        final only = packageSourceUris.first;
        if (importShowClause.isNotEmpty) {
          buffer.writeln(
            "    return \"import '$only' show ${importShowClause.join(', ')};\";",
          );
        } else if (importHideClause.isNotEmpty) {
          buffer.writeln(
            "    return \"import '$only' hide ${importHideClause.join(', ')};\";",
          );
        } else {
          buffer.writeln("    return \"import '$only';\";");
        }
      } else {
        buffer.writeln('    final imports = StringBuffer();');
        for (final uri in packageSourceUris) {
          buffer.writeln("    imports.writeln(\"import '$uri';\");");
        }
        buffer.writeln('    return imports.toString();');
      }
      buffer.writeln('  }');
      buffer.writeln();

      buffer.writeln(
        '  /// Returns barrel import URIs for sub-packages discovered through re-exports.',
      );
      buffer.writeln('  ///');
      buffer.writeln(
        '  /// This configuration uses the single-package inline strategy and',
      );
      buffer.writeln('  /// therefore has no sub-package barrels.');
      buffer.writeln('  static List<String> subPackageBarrels() {');
      buffer.writeln('    return [];');
      buffer.writeln('  }');
      buffer.writeln();
    }

    // Generate GlobalBridge class if we have globals
    // Note: For now, we only generate the import block and document globals
    // Actual global function/variable bridging requires D4rt-level support
    // Generate lists of enum, function, and variable names if we have any
    if (enums.isNotEmpty ||
        globalFunctions.isNotEmpty ||
        globalVariables.isNotEmpty) {
      // Enum names list
      if (enums.isNotEmpty) {
        buffer.writeln('  /// Returns a list of bridged enum names.');
        buffer.writeln('  static List<String> get enumNames => [');
        for (final enumInfo in enums) {
          buffer.writeln("    '${enumInfo.name}',");
        }
        buffer.writeln('  ];');
        buffer.writeln();
      }
    }

    buffer.writeln('}');
    buffer.writeln();

    // Generate individual bridge functions
    final allWarnings = <String>[];
    for (final cls in classes) {
      final warnings = _generateClassBridge(buffer, cls);
      allWarnings.addAll(warnings);
      buffer.writeln();
    }

    // Print any warnings
    if (allWarnings.isNotEmpty) {
      for (final warning in allWarnings) {
        // ignore: avoid_print
        print('Warning: $warning');
      }
    }

    return buffer.toString();
  }

  /// Gets a module name from a file path.
  String _getModuleName(String filePath) {
    final baseName = p.basenameWithoutExtension(filePath);
    // Convert snake_case to PascalCase
    return baseName
        .split('_')
        .map(
          (w) => w.isNotEmpty ? '${w[0].toUpperCase()}${w.substring(1)}' : '',
        )
        .join();
  }

  /// Gets the prefixed class name if the source file has a prefix, otherwise returns the plain name.
  String _getPrefixedClassName(String className, String sourceFile) {
    // Convert source file path to package URI
    final uri = _getPackageUri(sourceFile);

    final prefix = _importPrefixes[uri];
    if (prefix != null) {
      // Empty prefix means dart: library or no prefix needed
      return prefix.isEmpty ? className : '$prefix.$className';
    }
    // Check if this is a part-of file that maps to a parent library
    final parentUri = _partOfToParent[uri];
    if (parentUri != null) {
      final parentPrefix = _importPrefixes[parentUri];
      if (parentPrefix != null) {
        return parentPrefix.isEmpty ? className : '$parentPrefix.$className';
      }
    }
    // Try global type registry as fallback
    final globalUri = _globalTypeToUri[className];
    if (globalUri != null) {
      final globalPrefix = _importPrefixes[globalUri];
      if (globalPrefix != null) {
        return globalPrefix.isEmpty ? className : '$globalPrefix.$className';
      }
    }
    // Last resort: find any import from the same package
    final pkgName = _extractPackageFromUri(uri);
    if (pkgName != null) {
      for (final entry in _importPrefixes.entries) {
        if (entry.key.startsWith('package:$pkgName/') &&
            entry.value.isNotEmpty) {
          return '${entry.value}.$className';
        }
      }
    }
    // If no prefix found, log warning and return bare name
    _recordMissingExport(
      'class prefix resolution',
      '$className (no prefix for $uri)',
    );
    return className;
  }

  /// Gets the prefixed function name if the source file has a prefix, otherwise returns the plain name.
  String _getPrefixedFunctionName(String funcName, String sourceFile) {
    // Convert source file path to package URI
    final uri = _getPackageUri(sourceFile);
    final prefix = _importPrefixes[uri];
    if (prefix != null) {
      // Empty prefix means dart: library or no prefix needed
      return prefix.isEmpty ? funcName : '$prefix.$funcName';
    }
    // Check if this is a part-of file that maps to a parent library
    final parentUri = _partOfToParent[uri];
    if (parentUri != null) {
      final parentPrefix = _importPrefixes[parentUri];
      if (parentPrefix != null) {
        return parentPrefix.isEmpty ? funcName : '$parentPrefix.$funcName';
      }
    }
    // Try global type registry as fallback
    final globalUri = _globalTypeToUri[funcName];
    if (globalUri != null) {
      final globalPrefix = _importPrefixes[globalUri];
      if (globalPrefix != null) {
        return globalPrefix.isEmpty ? funcName : '$globalPrefix.$funcName';
      }
    }
    // Last resort: find any import from the same package
    final pkgName = _extractPackageFromUri(uri);
    if (pkgName != null) {
      for (final entry in _importPrefixes.entries) {
        if (entry.key.startsWith('package:$pkgName/') &&
            entry.value.isNotEmpty) {
          return '${entry.value}.$funcName';
        }
      }
    }
    // If no prefix found, log warning and return bare name
    _recordMissingExport(
      'function prefix resolution',
      '$funcName (no prefix for $uri)',
    );
    return funcName;
  }

  /// Resolves the prefixed type name for an extension's on-type.
  ///
  /// Extensions may work on types from a different package than the extension itself.
  /// For example, DigestHelper (from dcli) extends Digest (from crypto).
  /// This method resolves using the TYPE's URI, not the extension's source file.
  String _resolveExtensionOnType(ExtensionInfo ext) {
    // 1. Try the on-type URI directly (most precise — from the resolved AST)
    if (ext.onTypeUri != null) {
      final prefix = _importPrefixes[ext.onTypeUri!];
      if (prefix != null) {
        return prefix.isEmpty ? ext.onTypeName : '$prefix.${ext.onTypeName}';
      }
    }
    // 2. Try global type registry (populated during barrel parsing)
    final globalUri = _globalTypeToUri[ext.onTypeName];
    if (globalUri != null) {
      final prefix = _importPrefixes[globalUri];
      if (prefix != null) {
        return prefix.isEmpty ? ext.onTypeName : '$prefix.${ext.onTypeName}';
      }
    }
    // 3. Try source file imports (for types the analyzer couldn't fully resolve)
    final sourceUri = _resolveTypeFromSourceImports(
      ext.onTypeName,
      ext.sourceFile,
    );
    if (sourceUri != null) {
      final prefix = _importPrefixes[sourceUri];
      if (prefix != null) {
        return prefix.isEmpty ? ext.onTypeName : '$prefix.${ext.onTypeName}';
      }
    }
    // 4. Try text-based import scan (for types from unresolvable transitive deps)
    final textUri = _resolveTypeByImportTextScan(
      ext.onTypeName,
      ext.sourceFile,
    );
    if (textUri != null) {
      final prefix = _importPrefixes[textUri];
      if (prefix != null) {
        return prefix.isEmpty ? ext.onTypeName : '$prefix.${ext.onTypeName}';
      }
    }
    // 5. Fall back to extension's source file (same package case)
    return _getPrefixedClassName(ext.onTypeName, ext.sourceFile);
  }

  /// GEN-063: Resolves the full cast type for an extension, including generic args.
  ///
  /// For `extension on List<CommandResult>`, returns `List<_i3.CommandResult>`
  /// where `_i3` is the import prefix for CommandResult's package.
  /// Falls back to [onTypePrefixed] if no generic args.
  String _resolveExtensionCastType(ExtensionInfo ext, String onTypePrefixed) {
    if (ext.onTypeFullName == null || ext.onTypeArgUris.isEmpty) {
      return onTypePrefixed;
    }

    // Resolve each type argument with its import prefix
    final resolvedArgs = <String>[];
    for (final entry in ext.onTypeArgUris.entries) {
      final argName = entry.key;
      final argUri = entry.value;
      // Try to find import prefix for this type argument
      if (_isBuiltInType(argName)) {
        resolvedArgs.add(argName);
      } else {
        final prefix = _importPrefixes[argUri];
        if (prefix != null && prefix.isNotEmpty) {
          resolvedArgs.add('$prefix.$argName');
        } else {
          // Try global type registry
          final globalUri = _globalTypeToUri[argName];
          if (globalUri != null) {
            final gPrefix = _importPrefixes[globalUri];
            if (gPrefix != null && gPrefix.isNotEmpty) {
              resolvedArgs.add('$gPrefix.$argName');
            } else {
              resolvedArgs.add(argName);
            }
          } else {
            resolvedArgs.add(argName);
          }
        }
      }
    }

    if (resolvedArgs.isEmpty) return onTypePrefixed;
    return '$onTypePrefixed<${resolvedArgs.join(', ')}>';
  }

  /// Converts a source file path to a package URI.
  String _getPackageUri(String sourceFile) {
    // Handle file:// URIs by converting to normal path
    var normalizedPath = sourceFile;
    if (sourceFile.startsWith('file://')) {
      normalizedPath = Uri.parse(sourceFile).toFilePath();
    }

    // Normalise host-native separators to POSIX. On Windows `sourceFile` and
    // `toFilePath()` return backslash paths, which would (a) defeat the
    // forward-slash `/lib/`, `/test/`, `/sky_engine/lib/` lookups below and
    // (b) be embedded raw into generated source-URI map string literals, where
    // `\u`/`\t` sequences corrupt the emitted Dart. Import/source URIs are
    // always POSIX.
    normalizedPath = normalizedPath.replaceAll('\\', '/');

    // Special handling for sky_engine (dart:ui) files.
    // Paths like .../flutter/bin/cache/pkg/sky_engine/lib/ui/ui.dart
    // should be converted to dart:ui instead of package:sky_engine/ui/ui.dart.
    if (normalizedPath.contains('/sky_engine/lib/')) {
      final skyEngineLibIndex = normalizedPath.indexOf('/sky_engine/lib/');
      final relativePath = normalizedPath.substring(
        skyEngineLibIndex + 16,
      ); // Skip '/sky_engine/lib/' (16 chars)
      // Map common sky_engine paths to their dart: equivalents
      if (relativePath.startsWith('ui/')) {
        // ui/ui.dart, ui/painting.dart, etc. -> dart:ui
        return 'dart:ui';
      }
      // For other sky_engine paths, still use dart: scheme
      final dartLib = relativePath.split('/').first;
      return 'dart:$dartLib';
    }

    // Convert path like /path/to/package/lib/src/foo/bar.dart
    // to package:package_name/src/foo/bar.dart
    final libIndex = normalizedPath.indexOf('/lib/');
    if (libIndex != -1) {
      final pkgName = _getPackageNameFromPath(normalizedPath) ?? packageName;
      if (pkgName != null) {
        final relativePath = normalizedPath.substring(
          libIndex + 5,
        ); // Skip '/lib/'
        return 'package:$pkgName/$relativePath';
      }
    }

    // Also handle test files: /path/to/package/test/fixtures/foo.dart
    // becomes package:package_name/foo.dart (using just filename for tests)
    final testIndex = normalizedPath.indexOf('/test/');
    if (testIndex != -1 && packageName != null) {
      final fileName = normalizedPath.split('/').last;
      return 'package:$packageName/$fileName';
    }

    // Fall back to the POSIX-normalised path (never the raw backslash input):
    // an unresolved source URI must still be a valid Dart string literal.
    return normalizedPath;
  }

  /// Test-only accessor for [_getPackageUri].
  ///
  /// Source-URI mapping is private but its host-separator normalisation is a
  /// regression-prone Windows defect, so it is exposed for unit testing.
  @visibleForTesting
  String packageUriForTesting(String sourceFile) => _getPackageUri(sourceFile);

  /// Detects the package name from a file path by looking at pubspec.yaml.
  ///
  /// Given /path/to/tom_core_kernel/lib/src/foo.dart, returns 'tom_core_kernel'.
  String? _getPackageNameFromPath(String filePath) {
    final libIndex = filePath.indexOf('/lib/');
    if (libIndex == -1) return null;

    // Path up to /lib/
    final packageDir = filePath.substring(0, libIndex);
    final pubspecPath = '$packageDir/pubspec.yaml';

    try {
      final pubspecFile = File(pubspecPath);
      if (pubspecFile.existsSync()) {
        final content = pubspecFile.readAsStringSync();
        // Simple regex to extract package name
        final nameMatch = RegExp(
          r'^name:\s*(\S+)',
          multiLine: true,
        ).firstMatch(content);
        if (nameMatch != null) {
          return nameMatch.group(1);
        }
      }
    } catch (_) {
      // Ignore errors, fall back to null
    }

    return null;
  }

  /// Generates a bridge function for a single class.
  /// Returns list of warnings for skipped members.
  List<String> _generateClassBridge(StringBuffer buffer, ClassInfo cls) {
    final warnings = <String>[];
    final prefixedName = _getPrefixedClassName(cls.name, cls.sourceFile);
    final libraryPath = _getPackageUri(cls.sourceFile);
    final userBridge = _userBridgeScanner.getUserBridgeFor(
      libraryPath,
      cls.name,
    );
    // Compute prefixed user bridge class name so generated code resolves
    // correctly even when the barrel file is imported with a prefix ($pkg).
    final prefixedUserBridge = userBridge != null
        ? _getPrefixedClassName(
            userBridge.userBridgeClassName,
            userBridge.sourceFile,
          )
        : null;

    buffer.writeln(
      '// =============================================================================',
    );
    buffer.writeln('// ${cls.name} Bridge');
    buffer.writeln(
      '// =============================================================================',
    );
    buffer.writeln();
    buffer.writeln('BridgedClass _create${cls.name}Bridge() {');
    buffer.writeln('  return BridgedClass(');
    buffer.writeln('    nativeType: $prefixedName,');
    buffer.writeln("    name: '${cls.name}',");
    // GEN-079 reverted: isAssignable enables supertype bridge lookup for private subclasses
    // e.g., Curves.linear returns _Linear which should use Curve bridge
    buffer.writeln('    isAssignable: (v) => v is $prefixedName,');
    // GEN-115 (Phase 1): emit hierarchy depth (number of supertypes,
    // excluding Object) so Environment._filterToMostSpecific can pick the
    // most-specific bridge by depth in O(n) instead of walking the
    // hand-maintained _supertypeRegistry. See bridged_types.dart
    // hierarchyDepth doc and environment.dart _filterToMostSpecific.
    if (cls.allSupertypeNames.isNotEmpty) {
      buffer.writeln(
          '    hierarchyDepth: ${cls.allSupertypeNames.length},');
    }

    // Mixins must set canBeUsedAsMixin so the interpreter allows them in
    // `with` clauses. This covers both pure `mixin Foo` declarations
    // (extractor sets isMixin=true) and `mixin class Foo` /
    // `abstract mixin class Foo` declarations (extractor sets
    // canBeUsedAsMixin=true via ClassElement.isMixinClass).
    if (cls.isMixin || cls.canBeUsedAsMixin) {
      buffer.writeln('    canBeUsedAsMixin: true,');
    }

    // Plan I: emit isAbstract so the runtime can treat super() calls
    // against an abstract bridged base as a no-op when no constructor
    // adapter was emitted (GEN-051 strips non-factory constructors of
    // abstract classes). Sealed-only classes are not flagged: sealed
    // typically restricts subclassing intentionally and we want
    // super-call failures there to surface, not silently no-op.
    if (cls.isAbstract && !cls.isSealed) {
      buffer.writeln('    isAbstract: true,');
    }

    // Use nativeNames from UserBridge if available
    if (userBridge != null && userBridge.hasNativeNames) {
      buffer.writeln('    nativeNames: $prefixedUserBridge.nativeNames,');
    }

    // Constructors
    buffer.writeln('    constructors: {');
    for (final ctor in cls.constructors) {
      // GEN-051: Skip non-factory constructors for abstract AND sealed classes
      if ((cls.isAbstract || cls.isSealed) && !ctor.isFactory) {
        continue;
      }
      final ctorName = ctor.name ?? '';

      // Drop constructors explicitly excluded via config (e.g. `Image.file`,
      // which drags dart:io into an otherwise web-safe bridge).
      if (_isConstructorExcluded(cls.name, ctorName)) {
        _recordSkip(
          'constructor',
          '${cls.name}.${ctorName.isEmpty ? 'new' : ctorName}',
          'excluded by configuration',
        );
        continue;
      }

      // Check for constructor override
      final ctorOverride = userBridge?.getConstructorOverride(ctorName);
      if (ctorOverride != null) {
        buffer.writeln("      '$ctorName': $prefixedUserBridge.$ctorOverride,");
        continue;
      }

      // Try generating into temp buffer first
      final tempBuffer = StringBuffer();
      tempBuffer.writeln("      '$ctorName': (visitor, positional, named) {");
      if (_generateConstructorBody(
        tempBuffer,
        cls,
        ctor,
        prefixedName,
        warnings: warnings,
      )) {
        tempBuffer.writeln('      },');
        buffer.write(tempBuffer.toString());
      }
      // If false, constructor is skipped (warning already added)
    }
    buffer.writeln('    },');

    // Getters (including inherited)
    final instanceGetters = cls.allInstanceGetters(_classLookup);
    if (instanceGetters.isNotEmpty) {
      buffer.writeln('    getters: {');
      for (final getter in instanceGetters) {
        // Check for getter override
        final getterOverride = userBridge?.getGetterOverride(getter.name);
        if (getterOverride != null) {
          buffer.writeln(
            "      '${getter.name}': $prefixedUserBridge.$getterOverride,",
          );
        } else {
          if (_requiresDynamicMemberDispatch(getter.name)) {
            buffer.writeln(
              "      '${getter.name}': (visitor, target) => "
              "(D4.validateTarget<$prefixedName>(target, '${cls.name}') as dynamic).${getter.name},",
            );
            continue;
          }
          buffer.writeln(
            "      '${getter.name}': (visitor, target) => "
            "D4.validateTarget<$prefixedName>(target, '${cls.name}').${getter.name},",
          );
        }
      }
      buffer.writeln('    },');
    }

    // Setters (unless readOnly) - including inherited
    final instanceSetters = cls.allInstanceSetters(_classLookup);
    if (!readOnly && instanceSetters.isNotEmpty) {
      buffer.writeln('    setters: {');
      for (final setter in instanceSetters) {
        // Check for setter override
        final setterOverride = userBridge?.getSetterOverride(setter.name);
        if (setterOverride != null) {
          buffer.writeln(
            "      '${setter.name}': $prefixedUserBridge.$setterOverride,",
          );
        } else {
          // GEN-083: when the analyzer-derived functionTypeInfo is null
          // (typically because the setter's declared type is a typedef
          // alias that `extractFunctionTypeInfoFromDartType` didn't
          // unwrap), fall back to the `_knownFunctionTypeAliasInfo`
          // table. `VoidCallback`, `ValueChanged<T>`, etc. all get a
          // proper typed wrapper this way so assigning an
          // InterpretedFunction to e.g. `SemanticsConfiguration.onTap`
          // no longer hits "InterpretedFunction is not a subtype of
          // (() => void)?".
          FunctionTypeInfo? effectiveFuncInfo = setter.functionTypeInfo;
          if (effectiveFuncInfo == null) {
            final baseSetterType = setter.returnType.endsWith('?')
                ? setter.returnType
                    .substring(0, setter.returnType.length - 1)
                : setter.returnType;
            final lookupName = _getUnprefixedTypeName(baseSetterType);
            effectiveFuncInfo = _knownFunctionTypeAliasInfo[lookupName];
          }
          if (_requiresDynamicMemberDispatch(setter.name)) {
            buffer.writeln(
              "      '${setter.name}': (visitor, target, value) => ",
            );
            buffer.writeln(
              "        (D4.validateTarget<$prefixedName>(target, '${cls.name}') as dynamic).${setter.name} = value,",
            );
          } else if (effectiveFuncInfo != null) {
            // ENG-003: Function-typed setters need callback wrapping.
            // InterpretedFunction must be wrapped to a native closure matching
            // the setter's expected function signature.
            final funcInfo = effectiveFuncInfo;
            final isNullable = setter.returnType.endsWith('?');
            final rawVarName = '${setter.name}Raw';
            final wrapperExpr = _generateFunctionWrapper(
              callbackVarName: rawVarName,
              funcInfo: funcInfo,
              isNullable: isNullable,
              visitorExpr: 'visitor!',
              typeToUri: setter.returnTypeToUri,
              classTypeParams: cls.typeParameters,
              sourceFilePath: cls.sourceFile,
            );
            buffer.writeln(
              "      '${setter.name}': (visitor, target, value) {",
            );
            buffer.writeln(
              "        final $rawVarName = D4.extractBridgedArgOrNull<dynamic>(value, '${setter.name}');",
            );
            buffer.writeln(
              "        D4.validateTarget<$prefixedName>(target, '${cls.name}').${setter.name} = $wrapperExpr;",
            );
            buffer.writeln("      },");
          } else if (_isMapType(setter.returnType)) {
            final (keyType, valueType) = _getMapTypeArgs(
              setter.returnType,
              typeToUri: setter.returnTypeToUri,
              classTypeParams: cls.typeParameters,
              sourceFilePath: cls.sourceFile,
            );
            final cleanValueType = valueType.replaceAll('?', '');
            final isFunctionValue = _isFunctionTypeName(cleanValueType);
            if (isFunctionValue) {
              FunctionTypeInfo? valueFuncInfo;
              final lookupName = _getUnprefixedTypeName(cleanValueType);
              valueFuncInfo = _knownFunctionTypeAliasInfo[lookupName];
              valueFuncInfo ??= _parseFunctionType(cleanValueType);

              if (valueFuncInfo != null) {
                final localName = '${_getSafeLocalName(setter.name)}Map';
                final isNullable = setter.returnType.endsWith('?');
                buffer.writeln(
                  "      '${setter.name}': (visitor, target, value) {",
                );
                if (!isNullable) {
                  buffer.writeln("        if (value == null) {");
                  buffer.writeln(
                    "          throw ArgumentError('${cls.name}.${setter.name}: non-nullable map value cannot be null');",
                  );
                  buffer.writeln("        }");
                }
                final lines = _generateInlineFunctionMapConversion(
                  localName: localName,
                  rawMapExpr: 'value',
                  keyType: keyType,
                  valueType: valueType,
                  funcInfo: valueFuncInfo,
                  isNullable: isNullable,
                  typeToUri: setter.returnTypeToUri,
                  classTypeParams: cls.typeParameters,
                  sourceFilePath: cls.sourceFile,
                  indent: '        ',
                  visitorExpr: 'visitor!',
                );
                for (final line in lines) {
                  buffer.writeln(line);
                }
                buffer.writeln(
                  "        D4.validateTarget<$prefixedName>(target, '${cls.name}').${setter.name} = $localName;",
                );
                buffer.writeln("      },");
                continue;
              }
            }
          } else {
            // GEN-057: Use _generateSetterCast for proper collection type handling
            // GEN-075: Pass paramName for extractBridgedArg error messages
            // GEN-082: Pass sourceFilePath for local type resolution (e.g., Color in same file)
            final castExpression = _generateSetterCast(
              setter.returnType,
              paramName: setter.name,
              typeToUri: setter.returnTypeToUri,
              classTypeParams: cls.typeParameters,
              sourceFilePath: cls.sourceFile,
            );
            buffer.writeln(
              "      '${setter.name}': (visitor, target, value) => ",
            );
            buffer.writeln(
              "        D4.validateTarget<$prefixedName>(target, '${cls.name}').${setter.name} = $castExpression,",
            );
          }
        }
      }
      buffer.writeln('    },');
    }

    // Methods and operators (including inherited)
    final instanceMethods = cls.allInstanceMethods(_classLookup);
    final instanceOperators = cls.allInstanceOperators(_classLookup);
    if (instanceMethods.isNotEmpty || instanceOperators.isNotEmpty) {
      buffer.writeln('    methods: {');

      // Regular methods
      for (final method in instanceMethods) {
        // Check for method override (including operators)
        final methodOverride =
            userBridge?.getMethodOverride(method.name) ??
            userBridge?.getOperatorOverride(method.name);
        if (methodOverride != null) {
          buffer.writeln(
            "      '${method.name}': $prefixedUserBridge.$methodOverride,",
          );
          continue;
        }

        // Try generating into temp buffer first
        final tempBuffer = StringBuffer();
        tempBuffer.writeln(
          "      '${method.name}': (visitor, target, positional, named, typeArgs) {",
        );
        if (_generateMethodBody(tempBuffer, cls, method, warnings: warnings)) {
          tempBuffer.writeln('      },');
          buffer.write(tempBuffer.toString());
        }
        // If false, method is skipped (warning already added)
      }

      // Operators - group by name to handle unary/binary variants
      final operatorsByName = <String, List<MemberInfo>>{};
      for (final op in instanceOperators) {
        operatorsByName.putIfAbsent(op.name, () => []).add(op);
      }

      for (final entry in operatorsByName.entries) {
        final operatorName = entry.key;
        final variants = entry.value;

        // Check for operator override
        final operatorOverride = userBridge?.getOperatorOverride(operatorName);
        if (operatorOverride != null) {
          buffer.writeln(
            "      '$operatorName': $prefixedUserBridge.$operatorOverride,",
          );
          continue;
        }

        // Generate operator body - handle unary/binary variants
        if (variants.length == 1) {
          // Single variant - generate normally
          _generateOperatorBody(buffer, cls, variants.first);
        } else {
          // Multiple variants (e.g., unary and binary -) - generate combined handler
          _generateCombinedOperatorBody(buffer, cls, operatorName, variants);
        }
      }

      buffer.writeln('    },');
    }

    // Static members - separate getters from methods
    final staticMembers = cls.staticMembers;
    final staticGetters = staticMembers.where((m) => m.isGetter).toList();
    final staticMethods = staticMembers.where((m) => m.isMethod).toList();

    // Static getters use (visitor) signature for property access
    if (staticGetters.isNotEmpty) {
      buffer.writeln('    staticGetters: {');
      for (final getter in staticGetters) {
        // Check for static getter override
        final staticGetterOverride = userBridge?.getStaticGetterOverride(
          getter.name,
        );
        if (staticGetterOverride != null) {
          buffer.writeln(
            "      '${getter.name}': $prefixedUserBridge.$staticGetterOverride,",
          );
        } else {
          // Use prefixedName for static access
          buffer.writeln(
            "      '${getter.name}': (visitor) => "
            "$prefixedName.${getter.name},",
          );
        }
      }
      buffer.writeln('    },');
    }

    // Static methods use (visitor, positional, named, typeArgs) signature for method calls
    if (staticMethods.isNotEmpty) {
      buffer.writeln('    staticMethods: {');
      for (final method in staticMethods) {
        // Check for static method override
        final staticMethodOverride = userBridge?.getStaticMethodOverride(
          method.name,
        );
        if (staticMethodOverride != null) {
          buffer.writeln(
            "      '${method.name}': $prefixedUserBridge.$staticMethodOverride,",
          );
          continue;
        }

        // Try generating into temp buffer first
        final tempBuffer = StringBuffer();
        tempBuffer.writeln(
          "      '${method.name}': (visitor, positional, named, typeArgs) {",
        );
        if (_generateStaticMethodBody(
          tempBuffer,
          cls,
          method,
          warnings: warnings,
        )) {
          tempBuffer.writeln('      },');
          buffer.write(tempBuffer.toString());
        }
        // If false, static method is skipped (warning already added)
      }
      buffer.writeln('    },');
    }

    // Static setters use (visitor, value) signature for property assignment
    final staticSetters = staticMembers.where((m) => m.isSetter).toList();
    if (staticSetters.isNotEmpty) {
      buffer.writeln('    staticSetters: {');
      for (final setter in staticSetters) {
        // GEN-083 (mirror): typedef-alias fallback for static setters.
        FunctionTypeInfo? effectiveFuncInfo = setter.functionTypeInfo;
        if (effectiveFuncInfo == null) {
          final baseSetterType = setter.returnType.endsWith('?')
              ? setter.returnType
                  .substring(0, setter.returnType.length - 1)
              : setter.returnType;
          final lookupName = _getUnprefixedTypeName(baseSetterType);
          effectiveFuncInfo = _knownFunctionTypeAliasInfo[lookupName];
        }
        if (effectiveFuncInfo != null) {
          final funcInfo = effectiveFuncInfo;
          final isNullable = setter.returnType.endsWith('?');
          final rawVarName = '${setter.name}Raw';
          final wrapperExpr = _generateFunctionWrapper(
            callbackVarName: rawVarName,
            funcInfo: funcInfo,
            isNullable: isNullable,
            visitorExpr: 'visitor!',
            typeToUri: setter.returnTypeToUri,
            classTypeParams: cls.typeParameters,
            sourceFilePath: cls.sourceFile,
          );
          buffer.writeln("      '${setter.name}': (visitor, value) {");
          buffer.writeln(
            "        final $rawVarName = D4.extractBridgedArgOrNull<dynamic>(value, '${setter.name}');",
          );
          buffer.writeln(
            "        $prefixedName.${setter.name} = $wrapperExpr;",
          );
          buffer.writeln("      },");
          continue;
        }

        if (_isMapType(setter.returnType)) {
          final (keyType, valueType) = _getMapTypeArgs(
            setter.returnType,
            typeToUri: setter.returnTypeToUri,
            classTypeParams: cls.typeParameters,
            sourceFilePath: cls.sourceFile,
          );
          final cleanValueType = valueType.replaceAll('?', '');
          final isFunctionValue = _isFunctionTypeName(cleanValueType);
          if (isFunctionValue) {
            FunctionTypeInfo? valueFuncInfo;
            final lookupName = _getUnprefixedTypeName(cleanValueType);
            valueFuncInfo = _knownFunctionTypeAliasInfo[lookupName];
            valueFuncInfo ??= _parseFunctionType(cleanValueType);

            if (valueFuncInfo != null) {
              final localName = '${_getSafeLocalName(setter.name)}Map';
              final isNullable = setter.returnType.endsWith('?');
              buffer.writeln("      '${setter.name}': (visitor, value) {");
              if (!isNullable) {
                buffer.writeln("        if (value == null) {");
                buffer.writeln(
                  "          throw ArgumentError('${cls.name}.${setter.name}: non-nullable map value cannot be null');",
                );
                buffer.writeln("        }");
              }
              final lines = _generateInlineFunctionMapConversion(
                localName: localName,
                rawMapExpr: 'value',
                keyType: keyType,
                valueType: valueType,
                funcInfo: valueFuncInfo,
                isNullable: isNullable,
                typeToUri: setter.returnTypeToUri,
                classTypeParams: cls.typeParameters,
                sourceFilePath: cls.sourceFile,
                indent: '        ',
                visitorExpr: 'visitor!',
              );
              for (final line in lines) {
                buffer.writeln(line);
              }
              buffer.writeln(
                "        $prefixedName.${setter.name} = $localName;",
              );
              buffer.writeln("      },");
              continue;
            }
          }
        }

        // GEN-057: Use _generateSetterCast for proper collection type handling
        // GEN-075: Pass paramName for extractBridgedArg error messages
        // GEN-082: Pass sourceFilePath for local type resolution
        final castExpression = _generateSetterCast(
          setter.returnType,
          paramName: setter.name,
          typeToUri: setter.returnTypeToUri,
          classTypeParams: cls.typeParameters,
          sourceFilePath: cls.sourceFile,
        );
        buffer.writeln("      '${setter.name}': (visitor, value) => ");
        buffer.writeln(
          "        $prefixedName.${setter.name} = $castExpression,",
        );
      }
      buffer.writeln('    },');
    }

    // Generate signature maps for introspection
    _generateSignatureMaps(buffer, cls);

    buffer.writeln('  );');
    buffer.writeln('}');
    return warnings;
  }

  /// Generates signature maps for a class bridge.
  void _generateSignatureMaps(StringBuffer buffer, ClassInfo cls) {
    // Constructor signatures
    if (cls.constructors.isNotEmpty) {
      final validCtors = cls.constructors
          .where((ctor) => !cls.isAbstract || ctor.isFactory)
          .where((ctor) => !_isConstructorExcluded(cls.name, ctor.name ?? ''))
          .toList();
      if (validCtors.isNotEmpty) {
        buffer.writeln('    constructorSignatures: {');
        for (final ctor in validCtors) {
          final ctorName = ctor.name ?? '';
          final sig = _escapeString(_getConstructorSignature(cls, ctor));
          buffer.writeln("      '$ctorName': '$sig',");
        }
        buffer.writeln('    },');
      }
    }

    // Instance method signatures
    final instanceMethods = cls.allInstanceMethods(_classLookup);
    if (instanceMethods.isNotEmpty) {
      buffer.writeln('    methodSignatures: {');
      for (final method in instanceMethods) {
        final sig = _escapeString(_getMethodSignature(method));
        buffer.writeln("      '${method.name}': '$sig',");
      }
      buffer.writeln('    },');
    }

    // Instance getter signatures
    final instanceGetters = cls.allInstanceGetters(_classLookup);
    if (instanceGetters.isNotEmpty) {
      buffer.writeln('    getterSignatures: {');
      for (final getter in instanceGetters) {
        final sig = _escapeString(_getMethodSignature(getter));
        buffer.writeln("      '${getter.name}': '$sig',");
      }
      buffer.writeln('    },');
    }

    // Instance setter signatures
    final instanceSetters = cls.allInstanceSetters(_classLookup);
    if (instanceSetters.isNotEmpty) {
      buffer.writeln('    setterSignatures: {');
      for (final setter in instanceSetters) {
        final sig = _escapeString(_getMethodSignature(setter));
        buffer.writeln("      '${setter.name}': '$sig',");
      }
      buffer.writeln('    },');
    }

    // Static method signatures
    final staticMethods = cls.staticMembers.where((m) => m.isMethod).toList();
    if (staticMethods.isNotEmpty) {
      buffer.writeln('    staticMethodSignatures: {');
      for (final method in staticMethods) {
        final sig = _escapeString(_getMethodSignature(method));
        buffer.writeln("      '${method.name}': '$sig',");
      }
      buffer.writeln('    },');
    }

    // Static getter signatures
    final staticGetters = cls.staticMembers.where((m) => m.isGetter).toList();
    if (staticGetters.isNotEmpty) {
      buffer.writeln('    staticGetterSignatures: {');
      for (final getter in staticGetters) {
        final sig = _escapeString(_getMethodSignature(getter));
        buffer.writeln("      '${getter.name}': '$sig',");
      }
      buffer.writeln('    },');
    }

    // Static setter signatures
    final staticSetters = cls.staticMembers.where((m) => m.isSetter).toList();
    if (staticSetters.isNotEmpty) {
      buffer.writeln('    staticSetterSignatures: {');
      for (final setter in staticSetters) {
        final sig = _escapeString(_getMethodSignature(setter));
        buffer.writeln("      '${setter.name}': '$sig',");
      }
      buffer.writeln('    },');
    }
  }

  bool _requiresDynamicMemberDispatch(String memberName) {
    const restrictedMembers = {
      'activate',
      'build',
      'controller',
      'currentSelectionEndIndex',
      'currentSelectionStartIndex',
      'cursor',
      'debugBuildingDirtyElements',
      'debugCreator',
      'debugFillProperties',
      'didChangeDependencies',
      'didUpdateWidget',
      'dispose',
      'getOffsetToReveal',
      'initServiceExtensions',
      'initState',
      'receivedTransition',
      'redepthChildren',
      'saveOffset',
      'setCanDrag',
      'setIgnorePointer',
      'setSemanticsActions',
      'unlocked',
      'unmount',
      'updateRenderObject',
    };
    return restrictedMembers.contains(memberName);
  }

  /// GEN-092: Checks if any method parameter has a function type whose
  /// signature references class-level type parameters. Such methods need
  /// dynamic dispatch (`(t as dynamic).method(...)`) because:
  /// - Class type params resolve to `dynamic` at code-gen time
  /// - Generated wrappers produce e.g. `(dynamic) => Future<dynamic>`
  /// - But the native method expects e.g. `(String?) => Future<String>`
  /// - Dart's function subtyping is strict (invariant generics, contravariant params)
  bool _methodHasFunctionParamsReferencingClassTypeParams(
    List<ParameterInfo> params,
    Map<String, String?> classTypeParams,
  ) {
    if (classTypeParams.isEmpty) return false;

    // Build regex that matches any class type param as a whole word
    final typeParamPattern = RegExp(
      classTypeParams.keys.map(RegExp.escape).join('|'),
    );

    for (final param in params) {
      final funcInfo = param.functionTypeInfo;
      if (funcInfo == null) continue;

      // Check return type and all parameter types
      if (typeParamPattern.hasMatch(funcInfo.returnType)) return true;
      for (final pType in funcInfo.positionalParamTypes) {
        if (typeParamPattern.hasMatch(pType)) return true;
      }
      for (final nType in funcInfo.namedParamTypes.values) {
        if (typeParamPattern.hasMatch(nType)) return true;
      }
    }
    return false;
  }

  /// B3b: Builds an explicit method-level type-argument list (e.g. `<Object?>`)
  /// for a generic method whose callback parameter references the method's own
  /// type parameter.
  ///
  /// Without explicit type arguments, Dart infers the method type parameter
  /// from the callback wrapper's static type. The wrapper resolves an
  /// unresolved type parameter to `Object?` (e.g. a `FutureOr<T>` callback
  /// return becomes `FutureOr<Object?>`), but generic inference can still pick
  /// a non-nullable solution (`Object`) for `T`, making the wrapper
  /// non-assignable — `FutureOr<Object?> Function(X)` is not assignable to
  /// `FutureOr<Object> Function(X)`. This is the `MySQLConnectionPool`
  /// `withConnection<T>` / `transactional<T>` failure. Pinning each method
  /// type parameter to its bound (or `Object?` when unbounded) matches the
  /// wrapper's own resolution and removes the inference hazard.
  ///
  /// Returns an empty string when no explicit type arguments are needed.
  /// Explicit type arguments are only valid on a statically-typed receiver,
  /// so callers must pass [usesDynamicDispatch] = false to opt in.
  String _methodCallTypeArgs(
    MemberInfo method, {
    required bool usesDynamicDispatch,
    Map<String, String> typeToUri = const {},
    String? sourceFilePath,
  }) {
    if (usesDynamicDispatch) return '';
    final typeParams = method.methodTypeParameters;
    if (typeParams.isEmpty) return '';
    // Only needed when a function-typed parameter references a method type
    // parameter (the inference hazard described above).
    if (!_methodHasFunctionParamsReferencingClassTypeParams(
      method.parameters,
      typeParams,
    )) {
      return '';
    }
    final args = typeParams.entries.map((e) {
      final bound = e.value;
      if (bound == null || bound.isEmpty || bound == 'dynamic') {
        return 'Object?';
      }
      return _getTypeArgument(
        bound,
        typeToUri: typeToUri,
        classTypeParams: const {},
        sourceFilePath: sourceFilePath,
      );
    }).join(', ');
    return '<$args>';
  }

  /// Generates constructor body code.
  /// Returns false if the constructor cannot be bridged.
  /// Generates positional dispatch loop for unwrappable positional defaults.
  void _generatePositionalDispatch(
    StringBuffer buffer,
    String callTarget,
    List<ParameterInfo> allPositional,
    String contextName, {
    bool isVoid = false,
    List<String> suffixArgs = const [],
    Map<String, String?> typeParams = const {},
  }) {
    final requiredCount = allPositional.where((p) => p.isRequired).length;
    final totalCount = allPositional.length;

    // Generate branches for each possible argument count
    for (var len = totalCount; len >= requiredCount; len--) {
      // Use isEmpty for len == 0 to satisfy prefer_is_empty lint
      if (len == 0) {
        buffer.writeln("        if (positional.isEmpty) {");
      } else {
        buffer.writeln("        if (positional.length == $len) {");
      }

      final callArgs = <String>[];
      for (var i = 0; i < len; i++) {
        final param = allPositional[i];
        final resolvedType = _getTypeArgument(
          param.type,
          typeToUri: param.typeToUri,
          classTypeParams: typeParams,
        );
        // We use getRequiredArg because we know it exists at this index
        final sanitizedName = _sanitizeLocalVarName(param.name);
        buffer.writeln(
          "          final $sanitizedName = D4.getRequiredArg<$resolvedType>(positional, $i, '${param.name}', '$contextName');",
        );
        callArgs.add(sanitizedName);
      }

      // Add suffix args (e.g. named arguments)
      if (suffixArgs.isNotEmpty) {
        callArgs.addAll(suffixArgs);
      }

      if (isVoid) {
        buffer.writeln("          $callTarget(${callArgs.join(', ')});");
        buffer.writeln("          return null;");
      } else {
        buffer.writeln("          return $callTarget(${callArgs.join(', ')});");
      }
      buffer.writeln("        }");
    }
    // Add unreachable fallback - the conditions above are exhaustive but analyzer can't prove it
    buffer.writeln(
      "        throw ArgumentError('Invalid argument count for $contextName');",
    );
  }

  /// Generates combinatorial dispatch for unwrappable named defaults.
  void _generateCombinatorialDispatch(
    StringBuffer buffer,
    String callTarget,
    List<String> baseArgs,
    List<ParameterInfo> unwrappableParams,
    String contextName, {
    bool isVoid = false,
    Map<String, String?> typeParams = const {},
    String? sourceFilePath,
  }) {
    final count = unwrappableParams.length;
    final limit = 1 << count;

    for (var i = 0; i < limit; i++) {
      final conditions = <String>[];

      for (var j = 0; j < count; j++) {
        final param = unwrappableParams[j];
        if ((i & (1 << j)) != 0) {
          conditions.add("named.containsKey('${param.name}')");
        } else {
          conditions.add("!named.containsKey('${param.name}')");
        }
      }

      buffer.writeln("        if (${conditions.join(' && ')}) {");

      // Extract present parameters
      for (var j = 0; j < count; j++) {
        if ((i & (1 << j)) != 0) {
          final param = unwrappableParams[j];
          final localName = _sanitizeLocalVarName(param.name);

          // Check if this is a function-typed parameter that needs special handling
          final funcInfo = param.functionTypeInfo;
          if (funcInfo != null) {
            // For function-typed parameters, extract raw value and wrap it
            final rawVarName = '${localName}Raw';
            buffer.writeln(
              "          final $rawVarName = named['${param.name}'];",
            );
            // Generate wrapper - param is present so not nullable
            final wrapperExpr = _generateFunctionWrapper(
              callbackVarName: rawVarName,
              funcInfo: funcInfo,
              isNullable: false,
              typeToUri: param.typeToUri,
              classTypeParams: typeParams,
              sourceFilePath: sourceFilePath,
            );
            buffer.writeln("          final $localName = $wrapperExpr;");
          } else {
            // Standard extraction for non-function types
            // Check for collection types - need coercion (handles BridgedEnumValue unwrapping)
            if (_isListType(param.type)) {
              final elementType = _getListElementType(
                param.type,
                typeToUri: param.typeToUri,
                classTypeParams: typeParams,
                sourceFilePath: sourceFilePath,
              );
              final coerceMethod = 'D4.coerceList';
              buffer.writeln(
                "          final $localName = $coerceMethod<$elementType>(named['${param.name}'], '${param.name}');",
              );
            } else if (_isMapType(param.type)) {
              // GEN-079: Map types need coercion to unwrap BridgedEnumValue keys
              // and BridgedInstance values into properly typed Map<K,V>.
              final (keyType, valueType) = _getMapTypeArgs(
                param.type,
                typeToUri: param.typeToUri,
                classTypeParams: typeParams,
                sourceFilePath: sourceFilePath,
              );
              buffer.writeln(
                "          final $localName = D4.coerceMap<$keyType, $valueType>(named['${param.name}'], '${param.name}');",
              );
            } else if (_isSetType(param.type)) {
              // GEN-079: Set types need coercion similar to lists.
              final elementType = _getSetElementType(
                param.type,
                typeToUri: param.typeToUri,
                classTypeParams: typeParams,
                sourceFilePath: sourceFilePath,
              );
              buffer.writeln(
                "          final $localName = D4.coerceSet<$elementType>(named['${param.name}'], '${param.name}');",
              );
            } else {
              final resolvedType = _getTypeArgument(
                param.type,
                typeToUri: param.typeToUri,
                classTypeParams: typeParams,
              );
              buffer.writeln(
                "          final $localName = D4.getRequiredNamedArg<$resolvedType>(named, '${param.name}', '$contextName');",
              );
            }
          }
        }
      }

      // Construct call
      final currentArgs = List<String>.from(baseArgs);
      for (var j = 0; j < count; j++) {
        if ((i & (1 << j)) != 0) {
          final param = unwrappableParams[j];
          final localName = _sanitizeLocalVarName(param.name);
          currentArgs.add('${param.name}: $localName');
        }
      }

      if (isVoid) {
        buffer.writeln("          $callTarget(${currentArgs.join(', ')});");
        buffer.writeln("          return null;");
      } else {
        buffer.writeln(
          "          return $callTarget(${currentArgs.join(', ')});",
        );
      }
      buffer.writeln("        }");
    }
    // Add unreachable fallback - the conditions above are exhaustive but analyzer can't prove it
    buffer.writeln(
      "        throw StateError('Unreachable: all named parameter combinations should be covered');",
    );
  }

  bool _generateConstructorBody(
    StringBuffer buffer,
    ClassInfo cls,
    ConstructorInfo ctor,
    String prefixedName, {
    List<String>? warnings,
  }) {
    final params = ctor.parameters;
    final positionalParams = params.where((p) => !p.isNamed).toList();
    final namedParams = params.where((p) => p.isNamed).toList();

    // Required positional args validation
    final requiredCount = positionalParams.where((p) => p.isRequired).length;
    if (requiredCount > 0) {
      buffer.writeln(
        "        D4.requireMinArgs(positional, $requiredCount, '${cls.name}');",
      );
    }

    // Map to store custom call expressions for function-type parameters
    final callExpressions = <String, String>{};

    // Extract positional parameters
    final sourceUri = _getPackageUri(cls.sourceFile);
    for (var i = 0; i < positionalParams.length; i++) {
      final param = positionalParams[i];
      if (!_generatePositionalParamExtraction(
        buffer,
        param,
        i,
        cls.name,
        sourceUri: sourceUri,
        sourceFilePath: cls.sourceFile,
        warnings: warnings,
        classTypeParams: cls.typeParameters,
        callExpressions: callExpressions,
      )) {
        return false; // Can't bridge this constructor
      }
    }

    // Check for named unwrappable defaults for combinatorial fallback
    final nonWrappableDefaults = <ParameterInfo>[];
    for (final p in namedParams) {
      if (p.defaultValue != null) {
        // Check if this is a function-typed parameter with a non-nullable type
        final funcInfo = p.functionTypeInfo;
        if (funcInfo != null && !p.type.endsWith('?')) {
          // Function-typed parameters with defaults and non-nullable types
          // must use combinatorial dispatch - we can't pass null
          nonWrappableDefaults.add(p);
        } else if (!_isWrappableDefault(
          p.defaultValue!,
          typeToUri: p.typeToUri,
          sourceFilePath: cls.sourceFile,
        )) {
          nonWrappableDefaults.add(p);
        }
      } else if (!p.isRequired && !p.type.endsWith('?')) {
        // GEN-087: Named non-required non-nullable param with unavailable default
        // (e.g., const factory redirects where analyzer can't read the default).
        // Must use combinatorial dispatch to omit when not provided.
        nonWrappableDefaults.add(p);
      }
    }
    // Use combinatorial dispatch for up to 6 non-wrappable defaults
    // (generates 2^N branches, max 64). Above this threshold, falls back
    // to getRequiredNamedArgTodoDefault which requires callers to always
    // provide the value explicitly.
    final useCombinatorial =
        nonWrappableDefaults.isNotEmpty && nonWrappableDefaults.length <= 6;

    // Extract named parameters
    for (final param in namedParams) {
      if (useCombinatorial && nonWrappableDefaults.contains(param)) continue;

      if (!_generateNamedParamExtraction(
        buffer,
        param,
        cls.name,
        sourceUri: sourceUri,
        sourceFilePath: cls.sourceFile,
        warnings: warnings,
        classTypeParams: cls.typeParameters,
        callExpressions: callExpressions,
      )) {
        return false; // Can't bridge this constructor
      }
    }

    // Constructor call - use prefixed name for the constructor
    final ctorCall = ctor.name != null
        ? '$prefixedName.${ctor.name}'
        : prefixedName;
    final args = <String>[];
    for (final param in positionalParams) {
      // Use custom call expression if available, otherwise use local variable
      final callExpr = callExpressions[param.name];
      args.add(callExpr ?? _getSafeLocalName(param.name));
    }
    for (final param in namedParams) {
      if (useCombinatorial && nonWrappableDefaults.contains(param)) continue;

      // Use custom call expression if available, otherwise use local variable
      final callExpr = callExpressions[param.name];
      final argValue = callExpr ?? _getSafeLocalName(param.name);
      args.add('${param.name}: $argValue');
    }

    // Step 4: dart:ui Gradient constructors have a non-obvious assertion:
    // when `colorStops` is null, `colors.length` must equal 2 (not just be
    // >= 2). The native `ArgumentError` surfaces as a generic "Native error
    // during bridged constructor" message that obscures the actual cause —
    // callers think they passed valid input. Validate up front so the
    // failure is reported with a clearer, actionable message.
    _maybeEmitGradientStopsValidation(buffer, cls, ctor, positionalParams);

    if (useCombinatorial) {
      _generateCombinatorialDispatch(
        buffer,
        ctorCall,
        args,
        nonWrappableDefaults,
        cls.name,
        typeParams: cls.typeParameters,
        sourceFilePath: cls.sourceFile,
      );
    } else {
      // GEN-075: Type-dispatched construction for generic classes.
      // When a constructor has a positional parameter whose type is a class
      // type parameter (e.g., T value), the extracted value has static type
      // dynamic. This causes Dart to infer the wrong generic type parameter
      // (e.g., AlwaysStoppedAnimation<dynamic> instead of <double>).
      // Fix: Generate type dispatch on the runtime type of the value.
      final typeDispatchParam = _findTypeDispatchParam(
        positionalParams,
        cls.typeParameters,
        [...positionalParams, ...namedParams],
      );
      if (typeDispatchParam != null && cls.typeParameters.length == 1) {
        // GEN-079: Record this class as having a GEN-075 type-dispatch switch
        _gen075Classes.add(cls.name);
        final localName = _getSafeLocalName(typeDispatchParam.name);
        final argsStr = args.join(', ');
        // For named constructors, type arg goes on the class: Class<T>.named(...)
        // For unnamed constructors, type arg goes on the class: Class<T>(...)
        String typedCtorCall(String typeArg) {
          if (ctor.name != null) {
            return '$prefixedName<$typeArg>.${ctor.name}($argsStr)';
          }
          return '$prefixedName<$typeArg>($argsStr)';
        }

        buffer.writeln(
          '        // GEN-075: Preserve generic type parameter from runtime value',
        );
        buffer.writeln('        switch ($localName) {');
        buffer.writeln(
          '          case double _: return ${typedCtorCall('double')};',
        );
        buffer.writeln('          case int _: return ${typedCtorCall('int')};');
        buffer.writeln(
          '          case String _: return ${typedCtorCall('String')};',
        );
        buffer.writeln(
          '          case bool _: return ${typedCtorCall('bool')};',
        );
        // GEN-091: Also dispatch on all bridged class types from the module
        // so that non-primitive type arguments (Color, RelativeRect, etc.)
        // are correctly preserved in the generic type parameter.
        //
        // GEN-075-FIX: Sort entries most-specific-first (subclasses before
        // superclasses) so that `case SubClass _:` is not shadowed by
        // `case SuperClass _:`. Without this, all subclass cases are
        // unreachable and the wrong generic type parameter is inferred.
        //
        // Uses allSupertypeNames.length as specificity metric: classes with
        // more supertypes are deeper in the hierarchy (more specific).
        // This correctly handles extends, with, and implements relationships.
        final filteredEntries = _classLookup.entries.where((entry) {
          if (entry.key == cls.name) return false;
          if (const {
            'int',
            'double',
            'String',
            'bool',
            'num',
          }.contains(entry.key))
            return false;
          return true;
        }).toList();
        // GEN-075-FIX: Collect all class names in the switch for sealed
        // exhaustiveness check below.
        final switchClassNames = filteredEntries.map((e) => e.key).toSet();
        // Remove sealed classes whose subtypes are ALL present in the switch.
        // Dart's exhaustiveness checker knows sealed types can only be their
        // direct subtypes, so the base sealed case is provably unreachable.
        filteredEntries.removeWhere((entry) {
          if (!entry.value.isSealed) return false;
          // Find all direct subtypes of this sealed class in the lookup
          final directSubtypes = _classLookup.entries
              .where(
                (e) =>
                    e.key != entry.key &&
                    e.value.allSupertypeNames.contains(entry.key) &&
                    e.value.superclass == entry.key,
              )
              .map((e) => e.key);
          // If all direct subtypes are in the switch, the sealed case is redundant
          return directSubtypes.isNotEmpty &&
              directSubtypes.every(switchClassNames.contains);
        });
        final sortedEntries = filteredEntries
          ..sort((a, b) {
            final depthA = a.value.allSupertypeNames.length;
            final depthB = b.value.allSupertypeNames.length;
            // Deeper (more specific) first; equal depth sorts alphabetically
            // for deterministic output.
            if (depthA != depthB) return depthB.compareTo(depthA);
            return a.key.compareTo(b.key);
          });
        for (final entry in sortedEntries) {
          final otherClassName = entry.key;
          final otherClassInfo = entry.value;
          final prefixedOther = _getPrefixedClassName(
            otherClassName,
            otherClassInfo.sourceFile,
          );
          buffer.writeln(
            '          case $prefixedOther _: return ${typedCtorCall(prefixedOther)};',
          );
        }
        buffer.writeln('          default: return $ctorCall($argsStr);');
        buffer.writeln('        }');
      } else {
        buffer.writeln('        return $ctorCall(${args.join(', ')});');
      }
    }
    return true;
  }

  /// Step 4: emit pre-validation for `dart:ui.Gradient` constructors.
  ///
  /// The native `ui.Gradient.linear`, `.radial`, and `.sweep` factories assert
  /// `colors.length == 2` when `colorStops` is null (see `_validateColorStops`
  /// in the engine). When the assertion fires the bridge surfaces it as a
  /// generic "Native error during bridged constructor 'linear' for class
  /// 'Gradient': Invalid argument(s): ..." which gives no hint that the
  /// caller needs to pair an N-color list with an N-element `colorStops`
  /// list.
  ///
  /// To keep the error actionable, emit an upfront `ArgumentError` with a
  /// message that points the caller at the fix.
  void _maybeEmitGradientStopsValidation(
    StringBuffer buffer,
    ClassInfo cls,
    ConstructorInfo ctor,
    List<ParameterInfo> positionalParams,
  ) {
    if (cls.name != 'Gradient') return;
    // Restrict to dart:ui (sky_engine) Gradient — Flutter's painting
    // `Gradient` is a separate abstract class with its own subclasses.
    final source = cls.sourceFile;
    if (!source.contains('sky_engine') && !source.contains('dart:ui')) {
      return;
    }
    const ctorNames = {'linear', 'radial', 'sweep'};
    final ctorName = ctor.name;
    if (ctorName == null || !ctorNames.contains(ctorName)) return;

    // Locate the `colors` and `colorStops` positional parameters by name.
    String? colorsLocal;
    String? colorStopsLocal;
    for (final param in positionalParams) {
      if (param.name == 'colors') {
        colorsLocal = _getSafeLocalName(param.name);
      } else if (param.name == 'colorStops') {
        colorStopsLocal = _getSafeLocalName(param.name);
      }
    }
    if (colorsLocal == null) return;

    final stopsExpr = colorStopsLocal ?? 'null';
    buffer.writeln('        // Step 4: pre-validate dart:ui Gradient stops/colors contract.');
    buffer.writeln('        if ($stopsExpr == null && $colorsLocal.length != 2) {');
    buffer.writeln(
      "          throw ArgumentError('Gradient.$ctorName requires colors.length == 2 "
      "when colorStops is null (got colors.length=\${$colorsLocal.length}). "
      "Pass a colorStops list of equal length to use more than 2 colors.');",
    );
    buffer.writeln('        }');
    if (colorStopsLocal != null) {
      buffer.writeln(
        '        if ($colorStopsLocal != null && $colorStopsLocal.length != $colorsLocal.length) {',
      );
      buffer.writeln(
        "          throw ArgumentError('Gradient.$ctorName requires colors and colorStops "
        "to have equal length (got colors.length=\${$colorsLocal.length}, "
        "colorStops.length=\${$colorStopsLocal.length}).');",
      );
      buffer.writeln('        }');
    }
  }

  /// GEN-075: Find a positional parameter whose type is a class type parameter.
  /// Returns the first such parameter, or null if none exists.
  /// Also checks that:
  /// 1. No other constructor parameter uses the type parameter in a nested
  ///    generic position (e.g., List<TreeSliverNode<T>>)
  /// 2. The type parameter has no bound constraint (e.g., T extends KeyboardKey)
  ParameterInfo? _findTypeDispatchParam(
    List<ParameterInfo> positionalParams,
    Map<String, String?> classTypeParams,
    List<ParameterInfo> allConstructorParams,
  ) {
    ParameterInfo? candidate;
    String? typeParamName;
    for (final param in positionalParams) {
      final baseType = param.type.replaceAll('?', '');
      if (classTypeParams.containsKey(baseType)) {
        candidate = param;
        typeParamName = baseType;
        break;
      }
    }
    if (candidate == null || typeParamName == null) return null;

    // Skip if the type parameter has a bound constraint (e.g., T extends Foo)
    final bound = classTypeParams[typeParamName];
    if (bound != null && bound.isNotEmpty) {
      return null;
    }

    // Check that no OTHER param uses the type parameter in a nested generic.
    // E.g., List<Node<T>> would break because the outer List can't be cast.
    for (final param in allConstructorParams) {
      if (param == candidate) continue;
      final paramType = param.type;
      if (paramType.contains('<') && paramType.contains(typeParamName)) {
        return null;
      }
    }
    return candidate;
  }

  /// GEN-052: Get the unprefixed type name for lookup in known type maps.
  /// E.g., "core.LineAction" -> "LineAction", "$pkg.VoidCallback" -> "VoidCallback"
  String _getUnprefixedTypeName(String typeName) {
    final dotIndex = typeName.lastIndexOf('.');
    if (dotIndex != -1) {
      return typeName.substring(dotIndex + 1).replaceAll('?', '');
    }
    return typeName.replaceAll('?', '');
  }

  /// GEN-052: Check if a method has any function-typed parameters that need wrapping.
  bool _hasCallbackParameter(MemberInfo method) {
    for (final param in method.parameters) {
      // Check for explicit function type info
      if (param.functionTypeInfo != null) return true;

      // Check for function typedef patterns
      var baseType = param.type;
      if (baseType.endsWith('?')) {
        baseType = baseType.substring(0, baseType.length - 1);
      }
      if (_isFunctionTypeName(baseType)) return true;
    }
    return false;
  }

  /// GEN-052: Generate extension method body with proper callback wrapping.
  /// Uses hybrid approach with Function.apply when named params have non-nullable function defaults.
  void _generateExtensionMethodBody(
    StringBuffer buffer,
    ExtensionInfo ext,
    MemberInfo method,
    String prefixedTypeName,
  ) {
    final positionalParams = method.parameters
        .where((p) => !p.isNamed)
        .toList();
    final namedParams = method.parameters.where((p) => p.isNamed).toList();

    // Required positional args validation
    final requiredCount = positionalParams.where((p) => p.isRequired).length;
    if (requiredCount > 0) {
      buffer.writeln(
        "            D4.requireMinArgs(positional, $requiredCount, '${method.name}');",
      );
    }

    // Check if method has any named non-nullable function params with defaults
    // These require the hybrid approach with selective named arg inclusion
    final hasProblematicNamedDefaults = namedParams.any((param) {
      if (param.isRequired) return false;
      if (param.defaultValue == null) return false;
      if (param.type.endsWith('?')) return false; // nullable is fine

      // Check if it's a function type
      if (param.functionTypeInfo != null) return true;
      var baseType = param.type;
      if (_isFunctionTypeName(baseType)) return true;
      return false;
    });

    // Map to store custom call expressions for function-type parameters
    final callExpressions = <String, String>{};

    final sourceUri = _getPackageUri(ext.sourceFile);

    if (hasProblematicNamedDefaults) {
      // Hybrid approach: wrap callbacks explicitly, use Function.apply for selective named args
      _generateHybridExtensionMethodBody(
        buffer,
        ext,
        method,
        positionalParams,
        namedParams,
        sourceUri,
      );
    } else {
      // Standard approach: direct method call with all params
      _generateDirectExtensionMethodBody(
        buffer,
        ext,
        method,
        positionalParams,
        namedParams,
        sourceUri,
        callExpressions,
      );
    }
  }

  /// GEN-052: Generate hybrid method body using Function.apply for selective named arg inclusion.
  void _generateHybridExtensionMethodBody(
    StringBuffer buffer,
    ExtensionInfo ext,
    MemberInfo method,
    List<ParameterInfo> positionalParams,
    List<ParameterInfo> namedParams,
    String sourceUri,
  ) {
    // Generate wrapper variables for positional function params
    final positionalArgs = <String>[];
    for (var i = 0; i < positionalParams.length; i++) {
      final param = positionalParams[i];
      final localName = _getSafeLocalName(param.name);

      FunctionTypeInfo? funcInfo = param.functionTypeInfo;
      if (funcInfo == null) {
        var baseType = param.type;
        if (baseType.endsWith('?'))
          baseType = baseType.substring(0, baseType.length - 1);
        if (_isFunctionTypeName(baseType)) {
          final lookupName = _getUnprefixedTypeName(baseType);
          funcInfo =
              _knownFunctionTypeAliasInfo[lookupName] ??
              _parseFunctionType(baseType);
        }
      }

      if (funcInfo != null) {
        // Function type - generate wrapper
        final rawVarName = '${localName}Raw';
        if (param.isRequired) {
          buffer.writeln("            if (positional.length <= $i) {");
          buffer.writeln(
            "              throw ArgumentError('${method.name}: Missing required argument \"${param.name}\" at position $i');",
          );
          buffer.writeln("            }");
          buffer.writeln("            final $rawVarName = positional[$i];");
        } else {
          buffer.writeln(
            "            final $rawVarName = positional.length > $i ? positional[$i] : null;",
          );
        }

        // GEN-069: Nullability is based on the DECLARED TYPE, not optionality.
        final isNullable = param.type.endsWith('?');

        // Generate wrapper function variable
        final paramTypes = funcInfo.positionalParamTypes;
        final paramNames = <String>[];
        for (var j = 0; j < paramTypes.length; j++) {
          paramNames.add('p$j');
        }
        final typedParams = <String>[];
        for (var j = 0; j < paramTypes.length; j++) {
          // GEN-065: Replace InvalidType with dynamic for callback parameter types
          final pType = paramTypes[j].contains('InvalidType')
              ? 'dynamic'
              : paramTypes[j];
          typedParams.add('$pType p$j');
        }

        if (isNullable) {
          buffer.writeln("            dynamic $localName;");
          buffer.writeln("            if ($rawVarName != null) {");
          buffer.writeln(
            "              $localName = ${_voidCallbackClosure(typedParams.join(', '), 'D4.callInterpreterCallback(visitor, $rawVarName, [${paramNames.join(', ')}])', isVoidCallback: funcInfo.isVoid)};",
          );
          buffer.writeln("            }");
        } else {
          buffer.writeln(
            "            final $localName = ${_voidCallbackClosure(typedParams.join(', '), 'D4.callInterpreterCallback(visitor, $rawVarName, [${paramNames.join(', ')}])', isVoidCallback: funcInfo.isVoid)};",
          );
        }
        positionalArgs.add(localName);
      } else {
        // Non-function type - extract value
        final typeArg = _getTypeArgument(
          param.type,
          typeToUri: param.typeToUri,
          sourceFilePath: ext.sourceFile,
        );
        if (param.isRequired) {
          buffer.writeln(
            "            final $localName = D4.getRequiredArg<$typeArg>(positional, $i, '${param.name}', '${method.name}');",
          );
        } else {
          buffer.writeln(
            "            final $localName = D4.getOptionalArg<$typeArg>(positional, $i);",
          );
        }
        positionalArgs.add(localName);
      }
    }

    // Generate wrapped named args Map with conditional inclusion
    buffer.writeln("            final wrappedNamed = <Symbol, dynamic>{};");

    for (final param in namedParams) {
      final localName = _getSafeLocalName(param.name);

      FunctionTypeInfo? funcInfo = param.functionTypeInfo;
      if (funcInfo == null) {
        var baseType = param.type;
        if (baseType.endsWith('?'))
          baseType = baseType.substring(0, baseType.length - 1);
        if (_isFunctionTypeName(baseType)) {
          final lookupName = _getUnprefixedTypeName(baseType);
          funcInfo =
              _knownFunctionTypeAliasInfo[lookupName] ??
              _parseFunctionType(baseType);
        }
      }

      if (funcInfo != null) {
        // Function type - conditionally include wrapped callback
        final rawVarName = '${localName}Raw';
        buffer.writeln(
          "            final $rawVarName = named['${param.name}'];",
        );
        buffer.writeln("            if ($rawVarName != null) {");

        final paramTypesNamed = funcInfo.positionalParamTypes;
        final paramNamesNamed = <String>[];
        for (var j = 0; j < paramTypesNamed.length; j++) {
          paramNamesNamed.add('p$j');
        }
        final typedParamsNamed = <String>[];
        for (var j = 0; j < paramTypesNamed.length; j++) {
          // GEN-065: Replace InvalidType with dynamic for callback parameter types
          final pType = paramTypesNamed[j].contains('InvalidType')
              ? 'dynamic'
              : paramTypesNamed[j];
          typedParamsNamed.add('$pType p$j');
        }

        buffer.writeln(
          "              wrappedNamed[#${param.name}] = ${_voidCallbackClosure(typedParamsNamed.join(', '), 'D4.callInterpreterCallback(visitor, $rawVarName, [${paramNamesNamed.join(', ')}])', isVoidCallback: funcInfo.isVoid)};",
        );
        buffer.writeln("            }");
      } else {
        // Non-function type - include if provided
        buffer.writeln("            if (named.containsKey('${param.name}')) {");
        buffer.writeln(
          "              wrappedNamed[#${param.name}] = named['${param.name}'];",
        );
        buffer.writeln("            }");
      }
    }

    // Call using Function.apply
    final isVoid = method.returnType == 'void';
    if (isVoid) {
      buffer.writeln(
        "            Function.apply(t.${method.name}, [${positionalArgs.join(', ')}], wrappedNamed);",
      );
      buffer.writeln("            return null;");
    } else {
      buffer.writeln(
        "            return Function.apply(t.${method.name}, [${positionalArgs.join(', ')}], wrappedNamed);",
      );
    }
  }

  /// GEN-052: Generate direct method body with explicit params (no Function.apply).
  void _generateDirectExtensionMethodBody(
    StringBuffer buffer,
    ExtensionInfo ext,
    MemberInfo method,
    List<ParameterInfo> positionalParams,
    List<ParameterInfo> namedParams,
    String sourceUri,
    Map<String, String> callExpressions,
  ) {
    // Extract positional parameters
    for (var i = 0; i < positionalParams.length; i++) {
      final param = positionalParams[i];
      _generateExtensionPositionalParam(
        buffer,
        param,
        i,
        method.name,
        sourceUri: sourceUri,
        sourceFilePath: ext.sourceFile,
        callExpressions: callExpressions,
      );
    }

    // Extract named parameters
    for (final param in namedParams) {
      _generateExtensionNamedParam(
        buffer,
        param,
        method.name,
        sourceUri: sourceUri,
        sourceFilePath: ext.sourceFile,
        callExpressions: callExpressions,
      );
    }

    // Build method call arguments
    final args = <String>[];
    for (final param in positionalParams) {
      final callExpr = callExpressions[param.name];
      args.add(callExpr ?? _getSafeLocalName(param.name));
    }
    for (final param in namedParams) {
      final callExpr = callExpressions[param.name];
      final argValue = callExpr ?? _getSafeLocalName(param.name);
      args.add('${param.name}: $argValue');
    }

    final isVoid = method.returnType == 'void';
    if (isVoid) {
      buffer.writeln('            t.${method.name}(${args.join(', ')});');
      buffer.writeln('            return null;');
    } else {
      buffer.writeln(
        '            return t.${method.name}(${args.join(', ')});',
      );
    }
  }

  /// GEN-052: Generate positional parameter extraction for extension methods.
  void _generateExtensionPositionalParam(
    StringBuffer buffer,
    ParameterInfo param,
    int index,
    String contextName, {
    String? sourceUri,
    String? sourceFilePath,
    Map<String, String>? callExpressions,
  }) {
    final isNullable = param.type.endsWith('?');
    final localName = _getSafeLocalName(param.name);

    // Check if the parameter is a function type that needs wrapping
    FunctionTypeInfo? funcInfo = param.functionTypeInfo;

    if (funcInfo == null) {
      var baseType = param.type;
      if (baseType.endsWith('?')) {
        baseType = baseType.substring(0, baseType.length - 1);
      }
      if (_isFunctionTypeName(baseType)) {
        final lookupName = _getUnprefixedTypeName(baseType);
        funcInfo = _knownFunctionTypeAliasInfo[lookupName];
        funcInfo ??= _parseFunctionType(baseType);
      }
    }

    if (funcInfo != null) {
      // Function type - generate wrapper
      final rawVarName = '${localName}Raw';
      if (param.isRequired) {
        buffer.writeln("            if (positional.length <= $index) {");
        buffer.writeln(
          "              throw ArgumentError('$contextName: Missing required argument \"${param.name}\" at position $index');",
        );
        buffer.writeln("            }");
        buffer.writeln("            final $rawVarName = positional[$index];");
      } else {
        buffer.writeln(
          "            final $rawVarName = positional.length > $index ? positional[$index] : null;",
        );
      }

      // GEN-069: Nullability is based on the DECLARED TYPE, not optionality.
      final wrapperExpr = _generateFunctionWrapper(
        callbackVarName: rawVarName,
        funcInfo: funcInfo,
        isNullable: isNullable,
        typeToUri: param.typeToUri,
        sourceFilePath: sourceFilePath,
      );

      if (callExpressions != null) {
        callExpressions[param.name] = wrapperExpr;
      }
    } else {
      // Non-function type - simple extraction
      final typeArg = _getTypeArgument(
        param.type,
        typeToUri: param.typeToUri,
        sourceFilePath: sourceFilePath,
      );
      if (param.isRequired) {
        buffer.writeln(
          "            final $localName = D4.getRequiredArg<$typeArg>(positional, $index, '${param.name}', '$contextName');",
        );
      } else if (param.defaultValue != null) {
        if (_isWrappableDefault(
          param.defaultValue!,
          typeToUri: param.typeToUri,
          sourceFilePath: sourceFilePath,
        )) {
          final typedDefault = _getTypedDefaultValue(
            param.defaultValue!,
            param.type,
            typeToUri: param.typeToUri,
            sourceFilePath: sourceFilePath,
          );
          buffer.writeln(
            "            final $localName = D4.getArgWithDefault<$typeArg>(positional, $index, $typedDefault);",
          );
        } else {
          // Non-wrappable default - require explicit value
          buffer.writeln(
            "            final $localName = D4.getRequiredArg<$typeArg>(positional, $index, '${param.name}', '$contextName');",
          );
        }
      } else {
        buffer.writeln(
          "            final $localName = D4.getOptionalArg<$typeArg>(positional, $index);",
        );
      }
    }
  }

  /// GEN-052: Generate named parameter extraction for extension methods.
  void _generateExtensionNamedParam(
    StringBuffer buffer,
    ParameterInfo param,
    String contextName, {
    String? sourceUri,
    String? sourceFilePath,
    Map<String, String>? callExpressions,
  }) {
    final isNullable = param.type.endsWith('?');
    final localName = _getSafeLocalName(param.name);

    // Check if the parameter is a function type that needs wrapping
    FunctionTypeInfo? funcInfo = param.functionTypeInfo;

    if (funcInfo == null) {
      var baseType = param.type;
      if (baseType.endsWith('?')) {
        baseType = baseType.substring(0, baseType.length - 1);
      }
      if (_isFunctionTypeName(baseType)) {
        final lookupName = _getUnprefixedTypeName(baseType);
        funcInfo = _knownFunctionTypeAliasInfo[lookupName];
        funcInfo ??= _parseFunctionType(baseType);
      }
    }

    if (funcInfo != null) {
      // Function type - generate wrapper
      final rawVarName = '${localName}Raw';
      buffer.writeln("            final $rawVarName = named['${param.name}'];");

      // GEN-069: Nullability is based on the DECLARED TYPE, not optionality.
      final wrapperExpr = _generateFunctionWrapper(
        callbackVarName: rawVarName,
        funcInfo: funcInfo,
        isNullable: isNullable,
        typeToUri: param.typeToUri,
        sourceFilePath: sourceFilePath,
      );

      if (callExpressions != null) {
        callExpressions[param.name] = wrapperExpr;
      }
    } else {
      // Non-function type - simple extraction
      final typeArg = _getTypeArgument(
        param.type,
        typeToUri: param.typeToUri,
        sourceFilePath: sourceFilePath,
      );
      if (param.isRequired) {
        buffer.writeln(
          "            final $localName = D4.getRequiredNamedArg<$typeArg>(named, '${param.name}', '$contextName');",
        );
      } else if (param.defaultValue != null) {
        if (_isWrappableDefault(
          param.defaultValue!,
          typeToUri: param.typeToUri,
          sourceFilePath: sourceFilePath,
        )) {
          final typedDefault = _getTypedDefaultValue(
            param.defaultValue!,
            param.type,
            typeToUri: param.typeToUri,
            sourceFilePath: sourceFilePath,
          );
          buffer.writeln(
            "            final $localName = D4.getNamedArgWithDefault<$typeArg>(named, '${param.name}', $typedDefault);",
          );
        } else {
          // GEN-064 fix: Non-wrappable default - use TODO helper with non-nullable type
          // instead of making the type nullable (which causes compilation errors
          // when passed to a non-nullable parameter).
          _recordNonWrappableDefault(
            contextName,
            param.name,
            param.defaultValue!,
          );
          buffer.writeln(
            "            // TODO: Non-wrappable default: ${param.defaultValue}",
          );
          buffer.writeln(
            "            final $localName = D4.getRequiredNamedArgTodoDefault<$typeArg>(named, '${param.name}', '$contextName', '${_escapeString(param.defaultValue!)}');",
          );
        }
      } else {
        if (param.type.endsWith('?')) {
          buffer.writeln(
            "            final $localName = D4.getOptionalNamedArg<$typeArg?>(named, '${param.name}');",
          );
        } else {
          buffer.writeln(
            "            final $localName = D4.getRequiredNamedArgTodoDefault<$typeArg>(named, '${param.name}', '$contextName', '<default unavailable>');",
          );
        }
      }
    }
  }

  /// Generates method body code.
  /// Returns false if the method cannot be bridged.
  /// Plan E: Methods on `Element` whose bridge adapters drop `T` and whose
  /// resolution depends on script-supplied generic type arguments. The
  /// generator emits a `D4.findBridgedMethodInterceptor('Element', name)` hook
  /// at the top of these adapters so `tom_d4rt_flutterm` can override the
  /// native call with an ancestor-walk resolver that matches interpreted
  /// `InheritedWidget` subclasses by `InterpretedInstance.klass`.
  static const Map<String, String> _bridgedMethodInterceptHooks = {
    'dependOnInheritedWidgetOfExactType': 'Element',
    'getInheritedWidgetOfExactType': 'Element',
    'getElementForInheritedWidgetOfExactType': 'Element',
    // C6b: ThemeData.extension<T>() drops <T> at the bridge boundary so the
    // native call returns null for interpreted ThemeExtension subclasses.
    // The flutterm runtime registers an interceptor that walks
    // `theme.extensions.values`, matching `_InterpretedThemeExtension` proxies
    // against `typeArgs[0]` and returning the underlying `InterpretedInstance`.
    'extension': 'ThemeData',
  };

  /// Plan E (static): Static methods whose adapter must consult a runtime
  /// interceptor when one is registered. Used for cases where the native call
  /// drops a script-supplied `<T>` at the bridge boundary (Flutter's static
  /// lookups are typically keyed by the exact reified type argument).
  ///
  /// Keyed by `'ClassName.methodName'`; value is the conceptual owner class
  /// used as the runtime registry key. Keying by both class and method (rather
  /// than method name alone) avoids cross-talk between unrelated classes that
  /// happen to share a method name (e.g. many widgets define a `maybeOf`).
  ///
  /// Examples:
  /// - `InheritedModel.inheritFrom<T>`: the native impl is type-erased on
  ///   interpreted subclasses; the interceptor walks `Element` ancestors and
  ///   matches `_InterpretedInheritedWidget` by `InterpretedInstance.klass`.
  /// - `RadioGroup.maybeOf<T>`: dispatches to `RadioGroup.maybeOf<T>(context)`
  ///   for known type-arg names so the inherited-widget lookup finds the
  ///   actual `_RadioGroupStateScope<T>` rather than a `<dynamic>` miss.
  static const Map<String, String> _bridgedStaticMethodInterceptHooks = {
    'InheritedModel.inheritFrom': 'InheritedModel',
    'RadioGroup.maybeOf': 'RadioGroup',
  };

  bool _generateMethodBody(
    StringBuffer buffer,
    ClassInfo cls,
    MemberInfo method, {
    List<String>? warnings,
  }) {
    final prefixedName = _getPrefixedClassName(cls.name, cls.sourceFile);

    // Plan E: emit interceptor hook for selected methods so script-supplied
    // generic type arguments survive the bridge boundary. See
    // `_bridgedMethodInterceptHooks` for the hook list.
    final interceptOwner = _bridgedMethodInterceptHooks[method.name];
    if (interceptOwner != null) {
      buffer.writeln(
        "        final _interceptor = D4.findBridgedMethodInterceptor('$interceptOwner', '${method.name}');",
      );
      buffer.writeln(
        "        if (_interceptor != null) {",
      );
      buffer.writeln(
        "          return _interceptor(visitor, target, positional, named, typeArgs);",
      );
      buffer.writeln(
        "        }",
      );
    }

    buffer.writeln(
      "        final t = D4.validateTarget<$prefixedName>(target, '${cls.name}');",
    );

    final positionalParams = method.parameters
        .where((p) => !p.isNamed)
        .toList();
    final namedParams = method.parameters.where((p) => p.isNamed).toList();

    // Required positional args validation
    final requiredCount = positionalParams.where((p) => p.isRequired).length;
    if (requiredCount > 0) {
      buffer.writeln(
        "        D4.requireMinArgs(positional, $requiredCount, '${method.name}');",
      );
    }

    // Map to store custom call expressions for function-type parameters
    final callExpressions = <String, String>{};

    // Merge class type parameters with method type parameters
    // Method type parameters take precedence (they shadow class type params)
    final effectiveTypeParams = <String, String?>{
      ...cls.typeParameters,
      ...method.methodTypeParameters,
    };

    // Extract positional parameters
    final sourceUri = _getPackageUri(cls.sourceFile);
    for (var i = 0; i < positionalParams.length; i++) {
      final param = positionalParams[i];
      if (!_generatePositionalParamExtraction(
        buffer,
        param,
        i,
        method.name,
        sourceUri: sourceUri,
        sourceFilePath: cls.sourceFile,
        warnings: warnings,
        classTypeParams: effectiveTypeParams,
        callExpressions: callExpressions,
      )) {
        return false;
      }
    }

    // Check for named unwrappable defaults for combinatorial fallback
    final nonWrappableDefaults = <ParameterInfo>[];
    for (final p in namedParams) {
      if (p.defaultValue != null) {
        // Check if this is a function-typed parameter with a non-nullable type
        final funcInfo = p.functionTypeInfo;
        if (funcInfo != null && !p.type.endsWith('?')) {
          // Function-typed parameters with defaults and non-nullable types
          // must use combinatorial dispatch - we can't pass null
          nonWrappableDefaults.add(p);
        } else if (!_isWrappableDefault(
          p.defaultValue!,
          typeToUri: p.typeToUri,
          sourceFilePath: cls.sourceFile,
        )) {
          nonWrappableDefaults.add(p);
        }
      } else if (!p.isRequired && !p.type.endsWith('?')) {
        // GEN-087: Named non-required non-nullable param with unavailable default
        // (e.g., const factory redirects where analyzer can't read the default).
        // Must use combinatorial dispatch to omit when not provided.
        nonWrappableDefaults.add(p);
      }
    }
    // Use combinatorial dispatch for up to 6 non-wrappable defaults
    // (generates 2^N branches, max 64). Above this threshold, falls back
    // to getRequiredNamedArgTodoDefault which requires callers to always
    // provide the value explicitly.
    final useCombinatorial =
        nonWrappableDefaults.isNotEmpty && nonWrappableDefaults.length <= 6;

    // Extract named parameters
    for (final param in namedParams) {
      if (useCombinatorial && nonWrappableDefaults.contains(param)) continue;

      if (!_generateNamedParamExtraction(
        buffer,
        param,
        method.name,
        sourceUri: sourceUri,
        sourceFilePath: cls.sourceFile,
        warnings: warnings,
        classTypeParams: effectiveTypeParams,
        callExpressions: callExpressions,
        skewClassName: cls.name,
      )) {
        return false;
      }
    }

    // Method call
    final args = <String>[];
    for (final param in positionalParams) {
      // Use custom call expression if available, otherwise use local variable
      final callExpr = callExpressions[param.name];
      args.add(callExpr ?? _getSafeLocalName(param.name));
    }
    for (final param in namedParams) {
      if (useCombinatorial && nonWrappableDefaults.contains(param)) continue;

      // Use custom call expression if available, otherwise use local variable
      final callExpr = callExpressions[param.name];
      final argValue = callExpr ?? _getSafeLocalName(param.name);
      args.add('${param.name}: $argValue');
    }

    final isVoid = method.returnType == 'void';
    // GEN-092: Use dynamic dispatch when method has function-typed params
    // that reference class type parameters (avoids function type mismatch)
    //
    // Cluster C30 FIX: also use dynamic dispatch when the method has an
    // optional positional function-typed param with a non-nullable
    // declared type and no default value (legacy Dart syntax found in
    // abstract method declarations such as
    // `Decoration.createBoxPainter([VoidCallback onChanged])`). The
    // generated wrapper for that param is `Raw == null ? null : (){...}`
    // which evaluates to a nullable closure type — static dispatch
    // against the non-nullable declared parameter type fails to
    // compile. Concrete overrides redeclare the parameter as nullable
    // (`[VoidCallback? onChanged]`), so dynamic dispatch reaches a
    // compatible runtime signature.
    final hasLegacyOptionalFuncParam = method.parameters.any((p) {
      if (p.isNamed || p.isRequired) return false;
      if (p.defaultValue != null) return false;
      if (p.type.endsWith('?')) return false;
      return p.functionTypeInfo != null ||
          _isFunctionTypeName(p.type);
    });
    final callTarget =
        _requiresDynamicMemberDispatch(method.name) ||
            _methodHasFunctionParamsReferencingClassTypeParams(
              method.parameters,
              cls.typeParameters,
            ) ||
            hasLegacyOptionalFuncParam
        ? '(t as dynamic)'
        : 't';
    // B3b: pin generic method type arguments when a callback param references
    // the method's own type parameter, to avoid an inference hazard that picks
    // a non-nullable solution incompatible with the `Object?`-resolved wrapper.
    final methodTypeArgs = _methodCallTypeArgs(
      method,
      usesDynamicDispatch: callTarget != 't',
      sourceFilePath: cls.sourceFile,
    );
    if (useCombinatorial) {
      _generateCombinatorialDispatch(
        buffer,
        '$callTarget.${method.name}$methodTypeArgs',
        args,
        nonWrappableDefaults,
        method.name,
        isVoid: isVoid,
        typeParams: effectiveTypeParams,
        sourceFilePath: cls.sourceFile,
      );
    } else {
      if (isVoid) {
        buffer.writeln(
          '        $callTarget.${method.name}$methodTypeArgs(${args.join(', ')});',
        );
        buffer.writeln('        return null;');
      } else {
        buffer.writeln(
          '        return $callTarget.${method.name}$methodTypeArgs(${args.join(', ')});',
        );
      }
    }
    return true;
  }

  /// Generates operator bridge code.
  /// Operators are special methods that use operator syntax.
  void _generateOperatorBody(
    StringBuffer buffer,
    ClassInfo cls,
    MemberInfo operator,
  ) {
    final prefixedName = _getPrefixedClassName(cls.name, cls.sourceFile);
    final operatorName = operator.name;

    buffer.writeln(
      "      '$operatorName': (visitor, target, positional, named, typeArgs) {",
    );
    buffer.writeln(
      "        final t = D4.validateTarget<$prefixedName>(target, '${cls.name}');",
    );

    // Handle different operator arities
    if (operatorName == '[]') {
      // Index getter: target[index]
      // Get the parameter type for index operator
      if (operator.parameters.isNotEmpty) {
        final indexParam = operator.parameters.first;
        final indexType = _getTypeArgument(
          indexParam.type,
          typeToUri: indexParam.typeToUri,
          classTypeParams: cls.typeParameters,
          sourceFilePath: cls.sourceFile,
        );
        buffer.writeln(
          "        final index = D4.getRequiredArg<$indexType>(positional, 0, 'index', 'operator[]');",
        );
        buffer.writeln("        return t[index];");
      } else {
        buffer.writeln("        return t[positional[0]];");
      }
    } else if (operatorName == '[]=') {
      // Index setter: target[index] = value
      if (operator.parameters.length >= 2) {
        final indexParam = operator.parameters[0];
        final valueParam = operator.parameters[1];
        final indexType = _getTypeArgument(
          indexParam.type,
          typeToUri: indexParam.typeToUri,
          classTypeParams: cls.typeParameters,
          sourceFilePath: cls.sourceFile,
        );
        final valueType = _getTypeArgument(
          valueParam.type,
          typeToUri: valueParam.typeToUri,
          classTypeParams: cls.typeParameters,
          sourceFilePath: cls.sourceFile,
        );
        buffer.writeln(
          "        final index = D4.getRequiredArg<$indexType>(positional, 0, 'index', 'operator[]=');",
        );
        buffer.writeln(
          "        final value = D4.getRequiredArg<$valueType>(positional, 1, 'value', 'operator[]=');",
        );
        buffer.writeln("        t[index] = value;");
      } else {
        buffer.writeln("        t[positional[0]] = positional[1];");
      }
      buffer.writeln("        return null;");
    } else if (operatorName == '~') {
      // Unary bitwise NOT operator: ~target
      buffer.writeln("        return ~t;");
    } else if (operatorName == '-' && operator.parameters.isEmpty) {
      // Unary negation operator: -target
      buffer.writeln("        return -t;");
    } else {
      // Binary operators: target op operand
      // All binary operators (+, -, *, /, ~/, %, &, |, ^, <<, >>, >>>, <, >, <=, >=, ==)
      if (operator.parameters.isNotEmpty) {
        final operandParam = operator.parameters.first;
        final operandType = _getTypeArgument(
          operandParam.type,
          typeToUri: operandParam.typeToUri,
          classTypeParams: cls.typeParameters,
          sourceFilePath: cls.sourceFile,
        );
        // GEN-103: `operator ==` per Dart spec accepts `Object?` at runtime
        // even though the declared parameter type is `Object`. When `other`
        // is null, `t == other` must return false for a non-null `t` (which
        // `validateTarget<T>` guarantees). Short-circuit before the
        // `getRequiredArg<Object>` guard rejects null with an ArgumentError.
        if (operatorName == '==') {
          buffer.writeln(
            "        // GEN-103: Dart spec — non-null == null is always false.",
          );
          buffer.writeln(
            "        if (positional.isEmpty || positional[0] == null) return false;",
          );
        }
        buffer.writeln(
          "        final other = D4.getRequiredArg<$operandType>(positional, 0, 'other', 'operator$operatorName');",
        );
        buffer.writeln("        return t $operatorName other;");
      } else {
        buffer.writeln("        return t $operatorName positional[0];");
      }
    }

    buffer.writeln('      },');
  }

  /// Generates combined operator body for operators with multiple variants (e.g., unary and binary -).
  void _generateCombinedOperatorBody(
    StringBuffer buffer,
    ClassInfo cls,
    String operatorName,
    List<MemberInfo> variants,
  ) {
    final prefixedName = _getPrefixedClassName(cls.name, cls.sourceFile);

    buffer.writeln(
      "      '$operatorName': (visitor, target, positional, named, typeArgs) {",
    );
    buffer.writeln(
      "        final t = D4.validateTarget<$prefixedName>(target, '${cls.name}');",
    );

    // Sort by arity - unary first (0 params), then binary (1+ params)
    final sortedVariants = variants.toList()
      ..sort((a, b) => a.parameters.length.compareTo(b.parameters.length));

    // Check for unary variant (0 params)
    final unaryVariant = sortedVariants
        .where((v) => v.parameters.isEmpty)
        .firstOrNull;
    final binaryVariant = sortedVariants
        .where((v) => v.parameters.isNotEmpty)
        .firstOrNull;

    if (unaryVariant != null && binaryVariant != null) {
      // Generate dispatch based on argument count
      buffer.writeln("        if (positional.isEmpty) {");
      buffer.writeln("          // Unary operator");
      buffer.writeln(
        "          return $operatorName"
        "t;",
      );
      buffer.writeln("        } else {");
      buffer.writeln("          // Binary operator");
      final operandParam = binaryVariant.parameters.first;
      final operandType = _getTypeArgument(
        operandParam.type,
        typeToUri: operandParam.typeToUri,
        classTypeParams: cls.typeParameters,
        sourceFilePath: cls.sourceFile,
      );
      // GEN-103: see _generateOperatorBody for rationale.
      if (operatorName == '==') {
        buffer.writeln(
          "          // GEN-103: Dart spec — non-null == null is always false.",
        );
        buffer.writeln("          if (positional[0] == null) return false;");
      }
      buffer.writeln(
        "          final other = D4.getRequiredArg<$operandType>(positional, 0, 'other', 'operator$operatorName');",
      );
      buffer.writeln("          return t $operatorName other;");
      buffer.writeln("        }");
    } else if (unaryVariant != null) {
      // Only unary
      buffer.writeln(
        "        return $operatorName"
        "t;",
      );
    } else if (binaryVariant != null) {
      // Only binary
      final operandParam = binaryVariant.parameters.first;
      final operandType = _getTypeArgument(
        operandParam.type,
        typeToUri: operandParam.typeToUri,
        classTypeParams: cls.typeParameters,
        sourceFilePath: cls.sourceFile,
      );
      // GEN-103: see _generateOperatorBody for rationale.
      if (operatorName == '==') {
        buffer.writeln(
          "        // GEN-103: Dart spec — non-null == null is always false.",
        );
        buffer.writeln(
          "        if (positional.isEmpty || positional[0] == null) return false;",
        );
      }
      buffer.writeln(
        "        final other = D4.getRequiredArg<$operandType>(positional, 0, 'other', 'operator$operatorName');",
      );
      buffer.writeln("        return t $operatorName other;");
    }

    buffer.writeln('      },');
  }

  /// Generates static method body code.
  /// Returns false if the method cannot be bridged.
  bool _generateStaticMethodBody(
    StringBuffer buffer,
    ClassInfo cls,
    MemberInfo method, {
    List<String>? warnings,
  }) {
    final positionalParams = method.parameters
        .where((p) => !p.isNamed)
        .toList();
    final namedParams = method.parameters.where((p) => p.isNamed).toList();

    // Plan E (static): emit interceptor hook for selected static methods so
    // script-supplied generic type arguments survive the bridge boundary. See
    // `_bridgedStaticMethodInterceptHooks` for the hook list. Keyed by
    // `'ClassName.methodName'` so unrelated classes that share a method name
    // (e.g. many widgets define their own `maybeOf`) don't share a hook.
    final staticInterceptOwner =
        _bridgedStaticMethodInterceptHooks['${cls.name}.${method.name}'];
    if (staticInterceptOwner != null) {
      buffer.writeln(
        "        final _staticInterceptor = D4.findBridgedStaticMethodInterceptor('$staticInterceptOwner', '${method.name}');",
      );
      buffer.writeln("        if (_staticInterceptor != null) {");
      buffer.writeln(
        "          return _staticInterceptor(visitor, positional, named, typeArgs);",
      );
      buffer.writeln("        }");
    }

    // Required positional args validation
    final requiredCount = positionalParams.where((p) => p.isRequired).length;
    if (requiredCount > 0) {
      buffer.writeln(
        "        D4.requireMinArgs(positional, $requiredCount, '${method.name}');",
      );
    }

    // Check for unwrappable defaults
    final nonWrappablePositional = <ParameterInfo>[];
    for (final p in positionalParams) {
      if (p.defaultValue != null &&
          !_isWrappableDefault(
            p.defaultValue!,
            typeToUri: p.typeToUri,
            sourceFilePath: cls.sourceFile,
          )) {
        nonWrappablePositional.add(p);
      }
    }
    final usePositionalDispatch = nonWrappablePositional.isNotEmpty;

    final nonWrappableNamed = <ParameterInfo>[];
    for (final p in namedParams) {
      if (p.defaultValue != null &&
          !_isWrappableDefault(
            p.defaultValue!,
            typeToUri: p.typeToUri,
            sourceFilePath: cls.sourceFile,
          )) {
        nonWrappableNamed.add(p);
      }
    }
    final useCombinatorial =
        nonWrappableNamed.isNotEmpty && nonWrappableNamed.length <= 4;

    final sourceUri = _getPackageUri(cls.sourceFile);

    // For static methods, use method type parameters (not class type params)
    // Static methods can't access class type parameters
    final effectiveTypeParams = method.methodTypeParameters;

    // Extract positional parameters
    if (!usePositionalDispatch) {
      for (var i = 0; i < positionalParams.length; i++) {
        final param = positionalParams[i];
        if (!_generatePositionalParamExtraction(
          buffer,
          param,
          i,
          method.name,
          sourceUri: sourceUri,
          sourceFilePath: cls.sourceFile,
          warnings: warnings,
          classTypeParams: effectiveTypeParams,
        )) {
          return false;
        }
      }
    }

    // Extract named parameters
    for (final param in namedParams) {
      if (useCombinatorial && nonWrappableNamed.contains(param)) continue;

      if (!_generateNamedParamExtraction(
        buffer,
        param,
        method.name,
        sourceUri: sourceUri,
        sourceFilePath: cls.sourceFile,
        warnings: warnings,
        classTypeParams: effectiveTypeParams,
        skewClassName: cls.name,
      )) {
        return false;
      }
    }

    // Static method call
    final prefixedName = _getPrefixedClassName(cls.name, cls.sourceFile);
    final callTarget = '$prefixedName.${method.name}';
    final args = <String>[];
    final namedArgsForSuffix = <String>[];

    if (!usePositionalDispatch) {
      for (final param in positionalParams) {
        args.add(_getSafeLocalName(param.name));
      }
    }

    for (final param in namedParams) {
      if (useCombinatorial && nonWrappableNamed.contains(param)) continue;

      final argValue = _getSafeLocalName(param.name);
      final s = '${param.name}: $argValue';
      args.add(s);
      namedArgsForSuffix.add(s);
    }

    final isVoid = method.returnType == 'void';
    if (usePositionalDispatch) {
      _generatePositionalDispatch(
        buffer,
        callTarget,
        positionalParams,
        method.name,
        isVoid: isVoid,
        suffixArgs: namedArgsForSuffix,
        typeParams: effectiveTypeParams,
      );
    } else if (useCombinatorial) {
      _generateCombinatorialDispatch(
        buffer,
        callTarget,
        args,
        nonWrappableNamed,
        method.name,
        isVoid: isVoid,
        typeParams: effectiveTypeParams,
        sourceFilePath: cls.sourceFile,
      );
    } else {
      buffer.writeln('        return $callTarget(${args.join(', ')});');
    }
    return true;
  }

  /// Generates extraction code for a positional parameter.
  /// Returns false if the parameter cannot be bridged (e.g., required function type).
  ///
  /// If [callExpressions] is provided and this is a function-type parameter,
  /// the wrapper expression will be stored in the map. Otherwise the local
  /// variable name will be stored.
  bool _generatePositionalParamExtraction(
    StringBuffer buffer,
    ParameterInfo param,
    int index,
    String contextName, {
    String? sourceUri,
    String? sourceFilePath,
    List<String>? warnings,
    Map<String, String?> classTypeParams = const {},
    Map<String, String>? callExpressions,
  }) {
    final isNullable = param.type.endsWith('?');
    final localName = _getSafeLocalName(param.name);

    // Check for List types - need coercion
    if (_isListType(param.type)) {
      final elementType = _getListElementType(
        param.type,
        typeToUri: param.typeToUri,
        classTypeParams: classTypeParams,
        sourceFilePath: sourceFilePath,
      );

      // Check if element type is a function typedef - can't bridge those properly
      final rawElementType = _extractListElementType(param.type);
      if (_isFunctionTypeName(rawElementType)) {
        final localName = _getSafeLocalName(param.name);
        warnings?.add(
          'TODO: $contextName: parameter "${param.name}" '
          'has unbridgeable function type List<$rawElementType>',
        );
        // Generate TODO code that throws at runtime, but define variable for compilation
        buffer.writeln(
          "        // TODO: Unbridgeable function type List<$rawElementType>",
        );
        buffer.writeln(
          "        throw UnimplementedError('$contextName: Parameter \"${param.name}\" has unbridgeable function type List<$rawElementType>. Bridge cannot handle function types in collections.');",
        );
        // Define dummy variable so code compiles (unreachable due to throw)
        // ignore: dead_code
        buffer.writeln("        // ignore: dead_code");
        buffer.writeln("        final $localName = <dynamic>[];");
        return true;
      }

      final coerceMethod = isNullable ? 'D4.coerceListOrNull' : 'D4.coerceList';
      if (param.isRequired) {
        buffer.writeln(
          "        if (${_lengthCheckLessThanOrEqual('positional', index)}) {",
        );
        buffer.writeln(
          "          throw ArgumentError('$contextName: Missing required argument \"${param.name}\" at position $index');",
        );
        buffer.writeln("        }");
        buffer.writeln(
          "        final $localName = $coerceMethod<$elementType>(positional[$index], '${param.name}');",
        );
      } else if (param.defaultValue != null) {
        // Check if default is wrappable
        if (_isWrappableDefault(
          param.defaultValue!,
          typeToUri: param.typeToUri,
          sourceFilePath: sourceFilePath,
        )) {
          final typedDefault = _getTypedDefaultValue(
            param.defaultValue!,
            param.type,
            typeToUri: param.typeToUri,
            sourceFilePath: sourceFilePath,
          );
          buffer.writeln(
            "        final $localName = ${_lengthCheckGreaterThan('positional', index)} && positional[$index] != null",
          );
          buffer.writeln(
            "            ? $coerceMethod<$elementType>(positional[$index], '${param.name}')",
          );
          buffer.writeln("            : $typedDefault;");
        } else {
          // Non-wrappable default for List - record warning
          _recordNonWrappableDefault(
            contextName,
            param.name,
            param.defaultValue!,
          );
          buffer.writeln(
            "        // TODO: Non-wrappable default: ${param.defaultValue}",
          );
          buffer.writeln(
            "        if (${_lengthCheckLessThanOrEqual('positional', index)} || positional[$index] == null) {",
          );
          buffer.writeln(
            "          throw ArgumentError('$contextName: Parameter \"${param.name}\" has non-wrappable default (${_escapeString(param.defaultValue!)}). Value must be specified but was null.');",
          );
          buffer.writeln("        }");
          buffer.writeln(
            "        final $localName = $coerceMethod<$elementType>(positional[$index], '${param.name}');",
          );
        }
      } else {
        // Optional positional param without default
        if (isNullable) {
          buffer.writeln(
            "        final $localName = ${_lengthCheckGreaterThan('positional', index)}",
          );
          buffer.writeln(
            "            ? D4.coerceListOrNull<$elementType>(positional[$index], '${param.name}')",
          );
          buffer.writeln("            : null;");
        } else {
          // Non-nullable optional List - use empty list as default
          buffer.writeln(
            "        final $localName = ${_lengthCheckGreaterThan('positional', index)}",
          );
          buffer.writeln(
            "            ? D4.coerceList<$elementType>(positional[$index], '${param.name}')",
          );
          buffer.writeln("            : <$elementType>[];");
        }
      }
      return true;
    }

    // ENG-001: Check for Set types - need coercion
    if (_isSetType(param.type)) {
      final elementType = _getSetElementType(
        param.type,
        typeToUri: param.typeToUri,
        classTypeParams: classTypeParams,
        sourceFilePath: sourceFilePath,
      );

      final coerceMethod = isNullable ? 'D4.coerceSetOrNull' : 'D4.coerceSet';
      if (param.isRequired) {
        buffer.writeln(
          "        if (${_lengthCheckLessThanOrEqual('positional', index)}) {",
        );
        buffer.writeln(
          "          throw ArgumentError('$contextName: Missing required argument \"${param.name}\" at position $index');",
        );
        buffer.writeln("        }");
        buffer.writeln(
          "        final $localName = $coerceMethod<$elementType>(positional[$index], '${param.name}');",
        );
      } else if (param.defaultValue != null) {
        if (_isWrappableDefault(
          param.defaultValue!,
          typeToUri: param.typeToUri,
          sourceFilePath: sourceFilePath,
        )) {
          final typedDefault = _getTypedDefaultValue(
            param.defaultValue!,
            param.type,
            typeToUri: param.typeToUri,
            classTypeParams: classTypeParams,
            sourceFilePath: sourceFilePath,
          );
          buffer.writeln(
            "        final $localName = ${_lengthCheckGreaterThan('positional', index)} && positional[$index] != null",
          );
          buffer.writeln(
            "            ? $coerceMethod<$elementType>(positional[$index], '${param.name}')",
          );
          buffer.writeln("            : $typedDefault;");
        } else {
          _recordNonWrappableDefault(
            contextName,
            param.name,
            param.defaultValue!,
          );
          buffer.writeln(
            "        // TODO: Non-wrappable default: ${param.defaultValue}",
          );
          buffer.writeln(
            "        if (${_lengthCheckLessThanOrEqual('positional', index)} || positional[$index] == null) {",
          );
          buffer.writeln(
            "          throw ArgumentError('$contextName: Parameter \"${param.name}\" has non-wrappable default (${_escapeString(param.defaultValue!)}). Value must be specified but was null.');",
          );
          buffer.writeln("        }");
          buffer.writeln(
            "        final $localName = $coerceMethod<$elementType>(positional[$index], '${param.name}');",
          );
        }
      } else {
        if (isNullable) {
          buffer.writeln(
            "        final $localName = ${_lengthCheckGreaterThan('positional', index)}",
          );
          buffer.writeln(
            "            ? D4.coerceSetOrNull<$elementType>(positional[$index], '${param.name}')",
          );
          buffer.writeln("            : null;");
        } else {
          buffer.writeln(
            "        final $localName = ${_lengthCheckGreaterThan('positional', index)}",
          );
          buffer.writeln(
            "            ? D4.coerceSet<$elementType>(positional[$index], '${param.name}')",
          );
          buffer.writeln("            : <$elementType>{};");
        }
      }
      return true;
    }

    // Check for Map types - need coercion
    if (_isMapType(param.type)) {
      final (keyType, valueType) = _getMapTypeArgs(
        param.type,
        typeToUri: param.typeToUri,
        classTypeParams: classTypeParams,
        sourceFilePath: sourceFilePath,
      );

      // Check if value type is a function type - needs inline conversion
      final cleanValueType = valueType.replaceAll('?', '');
      final isFunctionValue = _isFunctionTypeName(cleanValueType);

      if (isFunctionValue) {
        // Get function type info for the value type
        FunctionTypeInfo? valueFuncInfo;
        final lookupName = _getUnprefixedTypeName(cleanValueType);
        valueFuncInfo = _knownFunctionTypeAliasInfo[lookupName];
        valueFuncInfo ??= _parseFunctionType(cleanValueType);

        if (valueFuncInfo != null) {
          // Generate inline conversion code
          if (param.isRequired) {
            buffer.writeln(
              "        if (${_lengthCheckLessThanOrEqual('positional', index)}) {",
            );
            buffer.writeln(
              "          throw ArgumentError('$contextName: Missing required argument \"${param.name}\" at position $index');",
            );
            buffer.writeln("        }");
            final lines = _generateInlineFunctionMapConversion(
              localName: localName,
              rawMapExpr: 'positional[$index]',
              keyType: keyType,
              valueType: valueType,
              funcInfo: valueFuncInfo,
              isNullable: isNullable,
              typeToUri: param.typeToUri,
              classTypeParams: classTypeParams,
              sourceFilePath: sourceFilePath,
            );
            for (final line in lines) {
              buffer.writeln(line);
            }
          } else if (param.defaultValue != null) {
            // Optional with default
            if (_isWrappableDefault(
              param.defaultValue!,
              typeToUri: param.typeToUri,
              sourceFilePath: sourceFilePath,
            )) {
              final typedDefault = _getTypedDefaultValue(
                param.defaultValue!,
                param.type,
                typeToUri: param.typeToUri,
                classTypeParams: classTypeParams,
                sourceFilePath: sourceFilePath,
              );
              // Declare variable before the if block for proper scoping
              final fullMapType = 'Map<$keyType, $valueType>';
              if (isNullable) {
                buffer.writeln("        $fullMapType? $localName;");
              } else {
                buffer.writeln(
                  "        var $localName = <$keyType, $valueType>{};",
                );
              }
              buffer.writeln(
                "        if (${_lengthCheckGreaterThan('positional', index)} && positional[$index] != null) {",
              );
              final lines = _generateInlineFunctionMapConversion(
                localName: localName,
                rawMapExpr: 'positional[$index]',
                keyType: keyType,
                valueType: valueType,
                funcInfo: valueFuncInfo,
                isNullable: isNullable,
                declareVariable: false,
                typeToUri: param.typeToUri,
                classTypeParams: classTypeParams,
                sourceFilePath: sourceFilePath,
                indent: '          ',
              );
              for (final line in lines) {
                buffer.writeln(line);
              }
              buffer.writeln("        } else {");
              buffer.writeln("          $localName = $typedDefault;");
              buffer.writeln("        }");
            } else {
              // Non-wrappable default
              _recordNonWrappableDefault(
                contextName,
                param.name,
                param.defaultValue!,
              );
              buffer.writeln(
                "        // TODO: Non-wrappable default: ${param.defaultValue}",
              );
              buffer.writeln(
                "        if (${_lengthCheckLessThanOrEqual('positional', index)} || positional[$index] == null) {",
              );
              buffer.writeln(
                "          throw ArgumentError('$contextName: Parameter \"${param.name}\" has non-wrappable default. Value must be specified.');",
              );
              buffer.writeln("        }");
              final lines = _generateInlineFunctionMapConversion(
                localName: localName,
                rawMapExpr: 'positional[$index]',
                keyType: keyType,
                valueType: valueType,
                funcInfo: valueFuncInfo,
                isNullable: isNullable,
                typeToUri: param.typeToUri,
                classTypeParams: classTypeParams,
                sourceFilePath: sourceFilePath,
              );
              for (final line in lines) {
                buffer.writeln(line);
              }
            }
          } else {
            // Optional without default
            // Declare variable before the if block for proper scoping
            final fullMapType = 'Map<$keyType, $valueType>';
            if (isNullable) {
              buffer.writeln("        $fullMapType? $localName;");
            } else {
              buffer.writeln(
                "        var $localName = <$keyType, $valueType>{};",
              );
            }
            buffer.writeln(
              "        if (${_lengthCheckGreaterThan('positional', index)} && positional[$index] != null) {",
            );
            final lines = _generateInlineFunctionMapConversion(
              localName: localName,
              rawMapExpr: 'positional[$index]',
              keyType: keyType,
              valueType: valueType,
              funcInfo: valueFuncInfo,
              isNullable: isNullable,
              declareVariable: false,
              typeToUri: param.typeToUri,
              classTypeParams: classTypeParams,
              sourceFilePath: sourceFilePath,
              indent: '          ',
            );
            for (final line in lines) {
              buffer.writeln(line);
            }
            buffer.writeln("        } else {");
            if (isNullable) {
              buffer.writeln("          $localName = null;");
            } else {
              // Keep empty map default (already set at declaration)
            }
            buffer.writeln("        }");
          }
          return true;
        }
      }

      // Non-function value type: use D4.coerceMap as before
      final coerceMethod = isNullable ? 'D4.coerceMapOrNull' : 'D4.coerceMap';
      if (param.isRequired) {
        buffer.writeln(
          "        if (${_lengthCheckLessThanOrEqual('positional', index)}) {",
        );
        buffer.writeln(
          "          throw ArgumentError('$contextName: Missing required argument \"${param.name}\" at position $index');",
        );
        buffer.writeln("        }");
        buffer.writeln(
          "        final $localName = $coerceMethod<$keyType, $valueType>(positional[$index], '${param.name}');",
        );
      } else if (param.defaultValue != null) {
        // Check if default is wrappable
        if (_isWrappableDefault(
          param.defaultValue!,
          typeToUri: param.typeToUri,
          sourceFilePath: sourceFilePath,
        )) {
          final typedDefault = _getTypedDefaultValue(
            param.defaultValue!,
            param.type,
            typeToUri: param.typeToUri,
            classTypeParams: classTypeParams,
            sourceFilePath: sourceFilePath,
          );
          buffer.writeln(
            "        final $localName = ${_lengthCheckGreaterThan('positional', index)} && positional[$index] != null",
          );
          buffer.writeln(
            "            ? $coerceMethod<$keyType, $valueType>(positional[$index], '${param.name}')",
          );
          buffer.writeln("            : $typedDefault;");
        } else {
          // Non-wrappable default for Map - record warning
          _recordNonWrappableDefault(
            contextName,
            param.name,
            param.defaultValue!,
          );
          buffer.writeln(
            "        // TODO: Non-wrappable default: ${param.defaultValue}",
          );
          buffer.writeln(
            "        if (${_lengthCheckLessThanOrEqual('positional', index)} || positional[$index] == null) {",
          );
          buffer.writeln(
            "          throw ArgumentError('$contextName: Parameter \"${param.name}\" has non-wrappable default (${_escapeString(param.defaultValue!)}). Value must be specified but was null.');",
          );
          buffer.writeln("        }");
          buffer.writeln(
            "        final $localName = $coerceMethod<$keyType, $valueType>(positional[$index], '${param.name}');",
          );
        }
      } else {
        // Optional positional param without default
        if (isNullable) {
          buffer.writeln(
            "        final $localName = ${_lengthCheckGreaterThan('positional', index)}",
          );
          buffer.writeln(
            "            ? D4.coerceMapOrNull<$keyType, $valueType>(positional[$index], '${param.name}')",
          );
          buffer.writeln("            : null;");
        } else {
          // Non-nullable optional Map - use empty map as default
          buffer.writeln(
            "        final $localName = ${_lengthCheckGreaterThan('positional', index)}",
          );
          buffer.writeln(
            "            ? D4.coerceMap<$keyType, $valueType>(positional[$index], '${param.name}')",
          );
          buffer.writeln("            : <$keyType, $valueType>{};");
        }
      }
      return true;
    }

    // Check if the parameter is a function type that needs wrapping
    // First check if we have function type info from resolved type analysis
    FunctionTypeInfo? funcInfo = param.functionTypeInfo;

    // If not, check if the parameter type itself is a function typedef (fallback for syntactic parsing)
    if (funcInfo == null) {
      // Only strip the trailing ? (for nullable function type), preserve inner nullable types
      var baseType = param.type;
      if (baseType.endsWith('?')) {
        baseType = baseType.substring(0, baseType.length - 1);
      }
      if (_isFunctionTypeName(baseType)) {
        // Get function type info - try known aliases first, then parse
        final lookupName = _getUnprefixedTypeName(baseType);
        funcInfo = _knownFunctionTypeAliasInfo[lookupName];
        funcInfo ??= _parseFunctionType(baseType);
      }
    }

    if (funcInfo != null) {
      // Generate extraction of raw InterpretedFunction value
      // Use camelCase suffix to satisfy non_constant_identifier_names lint
      final rawVarName = '${localName}Raw';
      if (param.isRequired) {
        buffer.writeln(
          "        if (${_lengthCheckLessThanOrEqual('positional', index)}) {",
        );
        buffer.writeln(
          "          throw ArgumentError('$contextName: Missing required argument \"${param.name}\" at position $index');",
        );
        buffer.writeln("        }");
        buffer.writeln("        final $rawVarName = positional[$index];");
      } else {
        buffer.writeln(
          "        final $rawVarName = ${_lengthCheckGreaterThan('positional', index)} ? positional[$index] : null;",
        );
      }

      // GEN-069: Nullability is based on the DECLARED TYPE, not optionality.
      //
      // Cluster C30 FIX: optional positional function-typed parameters
      // without a default value can be null at runtime even when the
      // declared type is non-nullable (legacy Dart syntax used in
      // abstract method declarations, e.g. Flutter's
      // `Decoration.createBoxPainter([VoidCallback onChanged])`).
      // Treat such parameters as nullable so the generated wrapper is
      // null-guarded — otherwise the wrapper is always emitted as a
      // non-null closure, and invoking it later with a null `Raw`
      // value throws "Null check operator used on a null value" inside
      // `D4.callInterpreterCallback`.
      final wrapperIsNullable = isNullable ||
          (!param.isRequired && param.defaultValue == null);
      final wrapperExpr = _generateFunctionWrapper(
        callbackVarName: rawVarName,
        funcInfo: funcInfo,
        isNullable: wrapperIsNullable,
        typeToUri: param.typeToUri,
        classTypeParams: classTypeParams,
        sourceFilePath: sourceFilePath,
      );

      if (callExpressions != null) {
        callExpressions[param.name] = wrapperExpr;
      } else {
        // If no callExpressions map, generate as local variable (for backwards compat)
        buffer.writeln("        final $localName = $wrapperExpr;");
      }
      return true;
    }

    // Standard extraction for other types
    final typeArg = _getTypeArgument(
      param.type,
      typeToUri: param.typeToUri,
      classTypeParams: classTypeParams,
      sourceFilePath: sourceFilePath,
    );
    if (param.isRequired) {
      buffer.writeln(
        "        final $localName = D4.getRequiredArg<$typeArg>"
        "(positional, $index, '${param.name}', '$contextName');",
      );
    } else if (param.defaultValue != null) {
      final prefixedDefault = _prefixDefaultValue(
        param.defaultValue!,
        sourceUri,
        typeToUri: param.typeToUri,
        sourceFilePath: sourceFilePath,
      );
      if (prefixedDefault != null) {
        // Wrappable default - use normal optional arg with default
        buffer.writeln(
          "        final $localName = D4.getOptionalArgWithDefault<$typeArg>"
          "(positional, $index, '${param.name}', $prefixedDefault);",
        );
      } else {
        // Non-wrappable default - use TODO helper and record warning
        _recordNonWrappableDefault(
          contextName,
          param.name,
          param.defaultValue!,
        );
        buffer.writeln(
          "        // TODO: Non-wrappable default: ${param.defaultValue}",
        );
        buffer.writeln(
          "        final $localName = D4.getRequiredArgTodoDefault<$typeArg>"
          "(positional, $index, '${param.name}', '$contextName', '${_escapeString(param.defaultValue!)}');",
        );
      }
    } else {
      buffer.writeln(
        "        final $localName = D4.getOptionalArg<$typeArg>"
        "(positional, $index, '${param.name}');",
      );
    }
    return true;
  }

  /// Gets a typed default value for List/Map types.
  /// Transforms `const []` to `const <Type>[]` and `const {}` to `const <K, V>{}`.
  String _getTypedDefaultValue(
    String defaultValue,
    String fullType, {
    Map<String, String> typeToUri = const {},
    Map<String, String?> classTypeParams = const {},
    String? sourceFilePath,
  }) {
    if (_isListType(fullType)) {
      final elementType = _getListElementType(
        fullType,
        typeToUri: typeToUri,
        classTypeParams: classTypeParams,
        sourceFilePath: sourceFilePath,
      );
      if (defaultValue == 'const []' || defaultValue == '[]') {
        return 'const <$elementType>[]';
      }
      // GEN-066: Handle already-typed empty collections: const <TypeArg>[]
      // Resolve the type arg through _getTypeArgument to apply correct prefixes.
      final typedListMatch = RegExp(
        r'^const\s*<([^>]+)>\[\]$',
      ).firstMatch(defaultValue);
      if (typedListMatch != null) {
        return 'const <$elementType>[]';
      }
    } else if (_isSetType(fullType)) {
      // A bare `const {}` / `{}` default on a Set parameter must become a
      // typed empty *set* `const <T>{}`. Left bare, Dart infers an empty Map
      // (static type Object), which fails to assign to the Set parameter
      // (argument_type_not_assignable). Checked before _isMapType so Set<T>
      // never falls through to the map branch.
      final elementType = _getSetElementType(
        fullType,
        typeToUri: typeToUri,
        classTypeParams: classTypeParams,
        sourceFilePath: sourceFilePath,
      );
      if (defaultValue == 'const {}' || defaultValue == '{}') {
        return 'const <$elementType>{}';
      }
      // Handle already-typed empty sets: const <T>{} — re-resolve the element
      // type so prefixes are applied correctly.
      final typedSetMatch = RegExp(
        r'^const\s*<[^>,]+>\{\}$',
      ).firstMatch(defaultValue);
      if (typedSetMatch != null) {
        return 'const <$elementType>{}';
      }
    } else if (_isMapType(fullType)) {
      final (keyType, valueType) = _getMapTypeArgs(
        fullType,
        typeToUri: typeToUri,
        classTypeParams: classTypeParams,
        sourceFilePath: sourceFilePath,
      );
      if (defaultValue == 'const {}' || defaultValue == '{}') {
        return 'const <$keyType, $valueType>{}';
      }
      // GEN-066: Handle already-typed empty maps: const <K, V>{}
      final typedMapMatch = RegExp(
        r'^const\s*<[^>]+>\{\}$',
      ).firstMatch(defaultValue);
      if (typedMapMatch != null) {
        return 'const <$keyType, $valueType>{}';
      }
    }
    // For const constructor defaults, use the prefixed version
    return _prefixDefaultValue(
          defaultValue,
          null,
          typeToUri: typeToUri,
          sourceFilePath: sourceFilePath,
        ) ??
        defaultValue;
  }

  /// Reserved parameter names in BridgedClass closures.
  /// Parameters with these names need to be renamed to avoid shadowing.
  static const _reservedNames = {
    'target',
    'visitor',
    'positional',
    'named',
    't',
  };

  /// Gets a safe local variable name for a parameter.
  /// Sanitizes the name (removes leading underscores, converts snake_case to camelCase)
  /// and renames reserved names by appending an underscore.
  String _getSafeLocalName(String paramName) {
    var sanitized = _sanitizeLocalVarName(paramName);
    if (_reservedNames.contains(sanitized)) {
      return '${sanitized}_';
    }
    return sanitized;
  }

  /// Makes a type nullable by appending '?' if necessary.
  /// Returns the original type if it's already nullable, or if it's 'dynamic'
  /// (since dynamic is inherently nullable).
  String _makeNullable(String type) {
    if (type == 'dynamic' || type.endsWith('?')) {
      return type;
    }
    return '$type?';
  }

  /// Generates extraction code for a named parameter.
  /// Handles List and Map types with coercion helpers.
  /// Returns false if this parameter cannot be bridged (e.g., required function type).
  ///
  /// If [callExpressions] is provided and this is a function-type parameter,
  /// the wrapper expression will be stored in the map. Otherwise the local
  /// variable name will be stored.
  /// Known VM↔web signature-skew parameters (B5/R6) — the web-divergence
  /// registry.
  ///
  /// Some Flutter `dart:ui` members declare a named parameter as **nullable**
  /// in the VM SDK but **non-nullable** in the web (dart2js) SDK. The analyzer
  /// summary the generator reads comes from the VM, so the standard extraction
  /// emits `getNamedArgWithDefault<T?>(…)`, whose nullable result cannot be
  /// forwarded to the web's non-nullable parameter — dart2js then fails with
  /// "The argument type 'T?' can't be assigned to the parameter type 'T'".
  ///
  /// For each entry the generator appends a `?? <default>` coercion so the
  /// local infers the non-null `T`, which satisfies both SDKs. The default
  /// reused is the parameter's own (already prefixed) default value, so only
  /// the *identity* of the skewed parameter needs recording here.
  ///
  /// Key format: `'<className>.<methodName>.<paramName>'`. Extend this set when
  /// a new VM↔web skew is discovered.
  ///
  /// Gated behind [enableVmWebSkewCoercion] (default off) so committed bridge
  /// output stays byte-identical until a deliberate regeneration.
  static const Set<String> _vmWebSkewNonNullParams = {
    // SceneBuilder.pushOpacity: VM `{Offset? offset = Offset.zero}` vs web
    // `{Offset offset = Offset.zero}`.
    'SceneBuilder.pushOpacity.offset',
  };

  /// Whether [paramName] of [className].[methodName] is a known VM↔web skew
  /// parameter that needs `?? default` coercion. Always false unless
  /// [enableVmWebSkewCoercion] is set.
  bool _isVmWebSkewParam(
    String? className,
    String methodName,
    String paramName,
  ) {
    if (!enableVmWebSkewCoercion || className == null) return false;
    return _vmWebSkewNonNullParams.contains(
      '$className.$methodName.$paramName',
    );
  }

  bool _generateNamedParamExtraction(
    StringBuffer buffer,
    ParameterInfo param,
    String contextName, {
    String? sourceUri,
    String? sourceFilePath,
    List<String>? warnings,
    Map<String, String?> classTypeParams = const {},
    Map<String, String>? callExpressions,
    String? skewClassName,
  }) {
    final isNullable = param.type.endsWith('?');
    final localName = _getSafeLocalName(param.name);

    // Check for List types - need coercion
    if (_isListType(param.type)) {
      final rawElementType = _extractListElementType(param.type);
      final isFunctionElement = _isFunctionTypeName(rawElementType);

      // If element type is a function typedef, we can't bridge it properly
      if (isFunctionElement) {
        warnings?.add(
          'TODO: $contextName: parameter "${param.name}" '
          'has unbridgeable type List<$rawElementType>',
        );
        // Generate TODO code that throws at runtime, but define variable for compilation
        buffer.writeln(
          "        // TODO: Unbridgeable function type List<$rawElementType>",
        );
        buffer.writeln(
          "        throw UnimplementedError('$contextName: Parameter \"${param.name}\" has unbridgeable function type List<$rawElementType>. Bridge cannot handle function types in collections.');",
        );
        // Define dummy variable so code compiles (unreachable due to throw)
        buffer.writeln("        // ignore: dead_code");
        buffer.writeln("        final $localName = <dynamic>[];");
        return true;
      }

      final elementType = _getListElementType(
        param.type,
        typeToUri: param.typeToUri,
        classTypeParams: classTypeParams,
        sourceFilePath: sourceFilePath,
      );
      // GEN-096 (D8g): pick coerceNestedList for List<List<X>> params.
      final picked = _pickListCoerce(elementType, isNullable);
      final coerceMethod = picked.method;
      final coerceGeneric = picked.generic;
      if (param.isRequired) {
        // GEN-071: Required nullable params only check containsKey, non-nullable also check null
        final requiredCheck = isNullable
            ? "!named.containsKey('${param.name}')"
            : "!named.containsKey('${param.name}') || named['${param.name}'] == null";
        buffer.writeln("        if ($requiredCheck) {");
        buffer.writeln(
          "          throw ArgumentError('$contextName: Missing required named argument \"${param.name}\"');",
        );
        buffer.writeln("        }");
        buffer.writeln(
          "        final $localName = $coerceMethod<$coerceGeneric>(named['${param.name}'], '${param.name}');",
        );
      } else if (param.defaultValue != null) {
        // Check if default is wrappable
        if (_isWrappableDefault(
          param.defaultValue!,
          typeToUri: param.typeToUri,
          sourceFilePath: sourceFilePath,
        )) {
          final typedDefault = _getTypedDefaultValue(
            param.defaultValue!,
            param.type,
            typeToUri: param.typeToUri,
            classTypeParams: classTypeParams,
            sourceFilePath: sourceFilePath,
          );
          buffer.writeln(
            "        final $localName = named.containsKey('${param.name}') && named['${param.name}'] != null",
          );
          buffer.writeln(
            "            ? $coerceMethod<$coerceGeneric>(named['${param.name}'], '${param.name}')",
          );
          buffer.writeln("            : $typedDefault;");
        } else {
          // Non-wrappable default for List - record warning
          _recordNonWrappableDefault(
            contextName,
            param.name,
            param.defaultValue!,
          );
          buffer.writeln(
            "        // TODO: Non-wrappable default: ${param.defaultValue}",
          );
          // GEN-071: Required nullable params only check containsKey, non-nullable also check null
          final requiredCheck = isNullable
              ? "!named.containsKey('${param.name}')"
              : "!named.containsKey('${param.name}') || named['${param.name}'] == null";
          buffer.writeln("        if ($requiredCheck) {");
          buffer.writeln(
            "          throw ArgumentError('$contextName: Parameter \"${param.name}\" has non-wrappable default (${_escapeString(param.defaultValue!)}). Value must be specified but was null.');",
          );
          buffer.writeln("        }");
          buffer.writeln(
            "        final $localName = $coerceMethod<$coerceGeneric>(named['${param.name}'], '${param.name}');",
          );
        }
      } else {
        // GEN-096 (D8g): always-nullable variant for optional named lists.
        final nullablePicked = _pickListCoerce(elementType, true);
        buffer.writeln(
          "        final $localName = ${nullablePicked.method}<${nullablePicked.generic}>(named['${param.name}'], '${param.name}');",
        );
      }
      return true;
    }

    // ENG-001: Check for Set types - need coercion
    if (_isSetType(param.type)) {
      final elementType = _getSetElementType(
        param.type,
        typeToUri: param.typeToUri,
        classTypeParams: classTypeParams,
        sourceFilePath: sourceFilePath,
      );
      final coerceMethod = isNullable ? 'D4.coerceSetOrNull' : 'D4.coerceSet';
      if (param.isRequired) {
        final requiredCheck = isNullable
            ? "!named.containsKey('${param.name}')"
            : "!named.containsKey('${param.name}') || named['${param.name}'] == null";
        buffer.writeln("        if ($requiredCheck) {");
        buffer.writeln(
          "          throw ArgumentError('$contextName: Missing required named argument \"${param.name}\"');",
        );
        buffer.writeln("        }");
        buffer.writeln(
          "        final $localName = $coerceMethod<$elementType>(named['${param.name}'], '${param.name}');",
        );
      } else if (param.defaultValue != null) {
        if (_isWrappableDefault(
          param.defaultValue!,
          typeToUri: param.typeToUri,
          sourceFilePath: sourceFilePath,
        )) {
          final typedDefault = _getTypedDefaultValue(
            param.defaultValue!,
            param.type,
            typeToUri: param.typeToUri,
            classTypeParams: classTypeParams,
            sourceFilePath: sourceFilePath,
          );
          buffer.writeln(
            "        final $localName = named.containsKey('${param.name}') && named['${param.name}'] != null",
          );
          buffer.writeln(
            "            ? $coerceMethod<$elementType>(named['${param.name}'], '${param.name}')",
          );
          buffer.writeln("            : $typedDefault;");
        } else {
          _recordNonWrappableDefault(
            contextName,
            param.name,
            param.defaultValue!,
          );
          buffer.writeln(
            "        // TODO: Non-wrappable default: ${param.defaultValue}",
          );
          final requiredCheck = isNullable
              ? "!named.containsKey('${param.name}')"
              : "!named.containsKey('${param.name}') || named['${param.name}'] == null";
          buffer.writeln("        if ($requiredCheck) {");
          buffer.writeln(
            "          throw ArgumentError('$contextName: Parameter \"${param.name}\" has non-wrappable default (${_escapeString(param.defaultValue!)}). Value must be specified but was null.');",
          );
          buffer.writeln("        }");
          buffer.writeln(
            "        final $localName = $coerceMethod<$elementType>(named['${param.name}'], '${param.name}');",
          );
        }
      } else {
        buffer.writeln(
          "        final $localName = D4.coerceSetOrNull<$elementType>(named['${param.name}'], '${param.name}');",
        );
      }
      return true;
    }

    // Check if the parameter is a function type that needs wrapping
    // First check if we have function type info from resolved type analysis
    FunctionTypeInfo? funcInfo = param.functionTypeInfo;

    // If not, check if the parameter type itself is a function typedef (fallback for syntactic parsing)
    if (funcInfo == null) {
      // Only strip the trailing ? (for nullable function type), preserve inner nullable types
      var baseType = param.type;
      if (baseType.endsWith('?')) {
        baseType = baseType.substring(0, baseType.length - 1);
      }
      if (_isFunctionTypeName(baseType)) {
        // Get function type info - try known aliases first, then parse
        final lookupName = _getUnprefixedTypeName(baseType);
        funcInfo = _knownFunctionTypeAliasInfo[lookupName];
        funcInfo ??= _parseFunctionType(baseType);
      }
    }

    if (funcInfo != null) {
      // Generate extraction of raw InterpretedFunction value
      // Use camelCase suffix to satisfy non_constant_identifier_names lint
      final rawVarName = '${localName}Raw';
      if (param.isRequired) {
        // GEN-071: Required nullable params only check containsKey, non-nullable also check null
        final requiredCheck = isNullable
            ? "!named.containsKey('${param.name}')"
            : "!named.containsKey('${param.name}') || named['${param.name}'] == null";
        buffer.writeln("        if ($requiredCheck) {");
        buffer.writeln(
          "          throw ArgumentError('$contextName: Missing required named argument \"${param.name}\"');",
        );
        buffer.writeln("        }");
        buffer.writeln("        final $rawVarName = named['${param.name}'];");
      } else {
        buffer.writeln("        final $rawVarName = named['${param.name}'];");
      }

      // GEN-069: Nullability is based on the DECLARED TYPE, not optionality.
      final wrapperExpr = _generateFunctionWrapper(
        callbackVarName: rawVarName,
        funcInfo: funcInfo,
        isNullable: isNullable,
        typeToUri: param.typeToUri,
        classTypeParams: classTypeParams,
        sourceFilePath: sourceFilePath,
      );

      if (callExpressions != null) {
        callExpressions[param.name] = wrapperExpr;
      } else {
        // If no callExpressions map, generate as local variable (for backwards compat)
        buffer.writeln("        final $localName = $wrapperExpr;");
      }
      return true;
    }

    // Check for Map types - need coercion
    if (_isMapType(param.type)) {
      final (keyType, valueType) = _getMapTypeArgs(
        param.type,
        typeToUri: param.typeToUri,
        classTypeParams: classTypeParams,
        sourceFilePath: sourceFilePath,
      );

      // Check if value type is a function type - needs inline conversion
      final cleanValueType = valueType.replaceAll('?', '');
      final isFunctionValue = _isFunctionTypeName(cleanValueType);

      if (isFunctionValue) {
        // Get function type info for the value type
        FunctionTypeInfo? valueFuncInfo;
        final lookupName = _getUnprefixedTypeName(cleanValueType);
        valueFuncInfo = _knownFunctionTypeAliasInfo[lookupName];
        valueFuncInfo ??= _parseFunctionType(cleanValueType);

        if (valueFuncInfo != null) {
          // Generate inline conversion code
          if (param.isRequired) {
            // GEN-071: Required nullable params only check containsKey, non-nullable also check null
            final requiredCheck = isNullable
                ? "!named.containsKey('${param.name}')"
                : "!named.containsKey('${param.name}') || named['${param.name}'] == null";
            buffer.writeln("        if ($requiredCheck) {");
            buffer.writeln(
              "          throw ArgumentError('$contextName: Missing required named argument \"${param.name}\"');",
            );
            buffer.writeln("        }");
            final lines = _generateInlineFunctionMapConversion(
              localName: localName,
              rawMapExpr: "named['${param.name}']",
              keyType: keyType,
              valueType: valueType,
              funcInfo: valueFuncInfo,
              isNullable: isNullable,
              typeToUri: param.typeToUri,
              classTypeParams: classTypeParams,
              sourceFilePath: sourceFilePath,
            );
            for (final line in lines) {
              buffer.writeln(line);
            }
          } else if (param.defaultValue != null) {
            // Optional with default
            if (_isWrappableDefault(
              param.defaultValue!,
              typeToUri: param.typeToUri,
              sourceFilePath: sourceFilePath,
            )) {
              final typedDefault = _getTypedDefaultValue(
                param.defaultValue!,
                param.type,
                typeToUri: param.typeToUri,
                classTypeParams: classTypeParams,
                sourceFilePath: sourceFilePath,
              );
              // Declare variable before the if block for proper scoping
              final fullMapType = 'Map<$keyType, $valueType>';
              if (isNullable) {
                buffer.writeln("        $fullMapType? $localName;");
              } else {
                buffer.writeln(
                  "        var $localName = <$keyType, $valueType>{};",
                );
              }
              buffer.writeln(
                "        if (named.containsKey('${param.name}') && named['${param.name}'] != null) {",
              );
              final lines = _generateInlineFunctionMapConversion(
                localName: localName,
                rawMapExpr: "named['${param.name}']",
                keyType: keyType,
                valueType: valueType,
                funcInfo: valueFuncInfo,
                isNullable: isNullable,
                declareVariable: false,
                typeToUri: param.typeToUri,
                classTypeParams: classTypeParams,
                sourceFilePath: sourceFilePath,
                indent: '          ',
              );
              for (final line in lines) {
                buffer.writeln(line);
              }
              buffer.writeln("        } else {");
              buffer.writeln("          $localName = $typedDefault;");
              buffer.writeln("        }");
            } else {
              // Non-wrappable default
              _recordNonWrappableDefault(
                contextName,
                param.name,
                param.defaultValue!,
              );
              buffer.writeln(
                "        // TODO: Non-wrappable default: ${param.defaultValue}",
              );
              // GEN-071: Required nullable params only check containsKey, non-nullable also check null
              final requiredCheck = isNullable
                  ? "!named.containsKey('${param.name}')"
                  : "!named.containsKey('${param.name}') || named['${param.name}'] == null";
              buffer.writeln("        if ($requiredCheck) {");
              buffer.writeln(
                "          throw ArgumentError('$contextName: Parameter \"${param.name}\" has non-wrappable default. Value must be specified.');",
              );
              buffer.writeln("        }");
              final lines = _generateInlineFunctionMapConversion(
                localName: localName,
                rawMapExpr: "named['${param.name}']",
                keyType: keyType,
                valueType: valueType,
                funcInfo: valueFuncInfo,
                isNullable: isNullable,
                typeToUri: param.typeToUri,
                classTypeParams: classTypeParams,
                sourceFilePath: sourceFilePath,
              );
              for (final line in lines) {
                buffer.writeln(line);
              }
            }
          } else {
            // Optional without default
            // Declare variable before the if block for proper scoping
            final fullMapType = 'Map<$keyType, $valueType>';
            if (isNullable) {
              buffer.writeln("        $fullMapType? $localName;");
            } else {
              buffer.writeln(
                "        var $localName = <$keyType, $valueType>{};",
              );
            }
            buffer.writeln(
              "        if (named.containsKey('${param.name}') && named['${param.name}'] != null) {",
            );
            final lines = _generateInlineFunctionMapConversion(
              localName: localName,
              rawMapExpr: "named['${param.name}']",
              keyType: keyType,
              valueType: valueType,
              funcInfo: valueFuncInfo,
              isNullable: isNullable,
              declareVariable: false,
              typeToUri: param.typeToUri,
              classTypeParams: classTypeParams,
              sourceFilePath: sourceFilePath,
              indent: '          ',
            );
            for (final line in lines) {
              buffer.writeln(line);
            }
            buffer.writeln("        } else {");
            if (isNullable) {
              buffer.writeln("          $localName = null;");
            } else {
              // Keep empty map default (already set at declaration)
            }
            buffer.writeln("        }");
          }
          return true;
        }
      }

      // Non-function value type: use D4.coerceMap as before
      final coerceMethod = isNullable ? 'D4.coerceMapOrNull' : 'D4.coerceMap';
      if (param.isRequired) {
        // GEN-071: Required nullable params only check containsKey, non-nullable also check null
        final requiredCheck = isNullable
            ? "!named.containsKey('${param.name}')"
            : "!named.containsKey('${param.name}') || named['${param.name}'] == null";
        buffer.writeln("        if ($requiredCheck) {");
        buffer.writeln(
          "          throw ArgumentError('$contextName: Missing required named argument \"${param.name}\"');",
        );
        buffer.writeln("        }");
        buffer.writeln(
          "        final $localName = $coerceMethod<$keyType, $valueType>(named['${param.name}'], '${param.name}');",
        );
      } else if (param.defaultValue != null) {
        // Check if default is wrappable
        if (_isWrappableDefault(
          param.defaultValue!,
          typeToUri: param.typeToUri,
          sourceFilePath: sourceFilePath,
        )) {
          final typedDefault = _getTypedDefaultValue(
            param.defaultValue!,
            param.type,
            typeToUri: param.typeToUri,
            classTypeParams: classTypeParams,
            sourceFilePath: sourceFilePath,
          );
          buffer.writeln(
            "        final $localName = named.containsKey('${param.name}') && named['${param.name}'] != null",
          );
          buffer.writeln(
            "            ? $coerceMethod<$keyType, $valueType>(named['${param.name}'], '${param.name}')",
          );
          buffer.writeln("            : $typedDefault;");
        } else {
          // Non-wrappable default for Map - record warning
          _recordNonWrappableDefault(
            contextName,
            param.name,
            param.defaultValue!,
          );
          buffer.writeln(
            "        // TODO: Non-wrappable default: ${param.defaultValue}",
          );
          // GEN-071: Required nullable params only check containsKey, non-nullable also check null
          final requiredCheck = isNullable
              ? "!named.containsKey('${param.name}')"
              : "!named.containsKey('${param.name}') || named['${param.name}'] == null";
          buffer.writeln("        if ($requiredCheck) {");
          buffer.writeln(
            "          throw ArgumentError('$contextName: Parameter \"${param.name}\" has non-wrappable default (${_escapeString(param.defaultValue!)}). Value must be specified but was null.');",
          );
          buffer.writeln("        }");
          buffer.writeln(
            "        final $localName = $coerceMethod<$keyType, $valueType>(named['${param.name}'], '${param.name}');",
          );
        }
      } else {
        buffer.writeln(
          "        final $localName = D4.coerceMapOrNull<$keyType, $valueType>(named['${param.name}'], '${param.name}');",
        );
      }
      return true;
    }

    // C47: Record types as named parameters need InterpretedRecord→native
    // record conversion. The positional-param path already does this via
    // _generateRecordParamExtraction (see line ~7069). Mirror that pattern
    // here so constructors / methods with named record params don't fall
    // through to the Standard extraction below — which emits a plain
    // `D4.getOptionalNamedArg<(T1, T2)?>(named, '...')` that can't coerce
    // an InterpretedRecord to a native Dart record.
    {
      final resolvedTypeForRecord = _getTypeArgument(
        param.type,
        typeToUri: param.typeToUri,
        classTypeParams: classTypeParams,
        sourceFilePath: sourceFilePath,
      );
      var baseResolved = resolvedTypeForRecord;
      if (baseResolved.endsWith('?')) {
        baseResolved = baseResolved.substring(0, baseResolved.length - 1);
      }
      if (_isRecordType(baseResolved)) {
        final parsed = _parseRecordType(baseResolved);
        // C47: Use D4.extractBridgedArg for each field — record fields may
        // be wrapped in BridgedInstance / BridgedEnumValue, so a raw `as`
        // cast fails. extractBridgedArg unwraps then casts.
        final parts = <String>[];
        for (var i = 0; i < parsed.positionalTypes.length; i++) {
          parts.add(
            "D4.extractBridgedArg<${parsed.positionalTypes[i]}>("
            "${localName}Raw.positionalFields[$i], "
            "'${param.name}.field$i')",
          );
        }
        for (final entry in parsed.namedFields.entries) {
          parts.add(
            "${entry.key}: D4.extractBridgedArg<${entry.value}>("
            "${localName}Raw.namedFields['${entry.key}'], "
            "'${param.name}.${entry.key}')",
          );
        }
        final recordLiteral = '(${parts.join(', ')})';

        buffer.writeln(
          "        final ${localName}Raw = named['${param.name}'];",
        );
        if (param.isRequired && !isNullable) {
          buffer.writeln("        if (${localName}Raw == null) {");
          buffer.writeln(
            "          throw ArgumentError('$contextName: Missing required named argument \"${param.name}\"');",
          );
          buffer.writeln("        }");
          buffer.writeln(
            "        final $localName = ${localName}Raw is InterpretedRecord",
          );
          buffer.writeln("            ? $recordLiteral");
          buffer.writeln("            : ${localName}Raw as $resolvedTypeForRecord;");
        } else if (param.defaultValue != null) {
          final prefixedDefault = _prefixDefaultValue(
            param.defaultValue!,
            sourceUri,
            typeToUri: param.typeToUri,
            sourceFilePath: sourceFilePath,
          );
          if (prefixedDefault != null) {
            buffer.writeln("        final $localName = ${localName}Raw == null");
            buffer.writeln("            ? $prefixedDefault");
            buffer.writeln("            : ${localName}Raw is InterpretedRecord");
            buffer.writeln("                ? $recordLiteral");
            buffer.writeln(
              "                : ${localName}Raw as $resolvedTypeForRecord;",
            );
          } else {
            _recordNonWrappableDefault(
              contextName,
              param.name,
              param.defaultValue!,
            );
            buffer.writeln(
              "        // TODO: Non-wrappable default: ${param.defaultValue}",
            );
            buffer.writeln("        if (${localName}Raw == null) {");
            buffer.writeln(
              "          throw ArgumentError('$contextName: Parameter \"${param.name}\" has non-wrappable default (${_escapeString(param.defaultValue!)}). Value must be specified but was null.');",
            );
            buffer.writeln("        }");
            buffer.writeln(
              "        final $localName = ${localName}Raw is InterpretedRecord",
            );
            buffer.writeln("            ? $recordLiteral");
            buffer.writeln(
              "            : ${localName}Raw as $resolvedTypeForRecord;",
            );
          }
        } else {
          // Optional, no default — nullable result (matches Standard extraction's
          // getOptionalNamedArg semantics).
          buffer.writeln("        final $localName = ${localName}Raw == null");
          buffer.writeln("            ? null");
          buffer.writeln("            : ${localName}Raw is InterpretedRecord");
          buffer.writeln("                ? $recordLiteral");
          buffer.writeln(
            "                : ${localName}Raw as $resolvedTypeForRecord;",
          );
        }
        return true;
      }
    }

    // Standard extraction for other types
    final helperMethod = param.isRequired
        ? 'D4.getRequiredNamedArg'
        : (param.defaultValue != null
              ? 'D4.getNamedArgWithDefault'
              : 'D4.getOptionalNamedArg');
    final typeArg = _getTypeArgument(
      param.type,
      typeToUri: param.typeToUri,
      classTypeParams: classTypeParams,
      sourceFilePath: sourceFilePath,
    );
    if (param.defaultValue != null) {
      final prefixedDefault = _prefixDefaultValue(
        param.defaultValue!,
        sourceUri,
        typeToUri: param.typeToUri,
        sourceFilePath: sourceFilePath,
      );
      if (prefixedDefault != null) {
        // Wrappable default - use normal named arg with default.
        //
        // B5/R6: for a known VM↔web signature-skew parameter the VM-derived
        // type is nullable (`T?`) but the web parameter is non-nullable (`T`).
        // Append `?? default` so the local infers the non-null `T`, which
        // assigns cleanly under both SDKs.
        final skewSuffix =
            isNullable &&
                _isVmWebSkewParam(skewClassName, contextName, param.name)
            ? ' ?? $prefixedDefault'
            : '';
        buffer.writeln(
          "        final $localName = $helperMethod<$typeArg>"
          "(named, '${param.name}', $prefixedDefault)$skewSuffix;",
        );
      } else {
        // Non-wrappable default - use TODO helper and record warning
        _recordNonWrappableDefault(
          contextName,
          param.name,
          param.defaultValue!,
        );
        buffer.writeln(
          "        // TODO: Non-wrappable default: ${param.defaultValue}",
        );
        buffer.writeln(
          "        final $localName = D4.getRequiredNamedArgTodoDefault<$typeArg>"
          "(named, '${param.name}', '$contextName', '${_escapeString(param.defaultValue!)}');",
        );
      }
    } else {
      if (!param.isRequired && !param.type.endsWith('?')) {
        buffer.writeln(
          "        final $localName = D4.getRequiredNamedArgTodoDefault<$typeArg>"
          "(named, '${param.name}', '$contextName', '<default unavailable>');",
        );
      } else {
        buffer.writeln(
          "        final $localName = $helperMethod<$typeArg>"
          "(named, '${param.name}'${param.isRequired ? ", '$contextName'" : ''});",
        );
      }
    }
    return true;
  }

  /// Gets the type argument for helper functions.
  ///
  /// Resolves type parameters to concrete types:
  /// - Single-letter type parameters (T, R, E, etc.) become `Object`
  /// - Generic types like `List<T>` become `List<Object>`
  /// - Nullable types have their `?` suffix stripped for helper type arg
  /// - External types are prefixed with their import prefix
  /// - Function types and function typedefs are simplified to `dynamic`
  ///
  /// If [typeToUri] is non-empty, external types will be prefixed.
  /// If [classTypeParams] is provided, generic type parameters will be resolved
  /// to their bounds (e.g., E -> TomObject).
  ///
  /// Uses caching to prevent redundant resolution and detects recursive type bounds
  /// (like `T extends Comparable<T>`) to prevent infinite recursion.
  String _getTypeArgument(
    String type, {
    Map<String, String> typeToUri = const {},
    Map<String, String?> classTypeParams = const {},
    String? sourceFilePath,
  }) {
    // Create a cache key that includes the context
    // IMPORTANT: Include both keys AND values to distinguish E:null from E:Identifiable
    // IMPORTANT: Include typeToUri for the base type name, since different callers
    // may provide different typeToUri maps (e.g., one member has the URI, another doesn't),
    // and the resolution result depends critically on this URI.
    final typeParamsKey = classTypeParams.entries
        .map((e) => '${e.key}=${e.value ?? 'null'}')
        .join(',');
    // Extract the base type name (strip nullable suffix) to look up in typeToUri
    var cacheBaseType = type;
    if (cacheBaseType.endsWith('?')) {
      cacheBaseType = cacheBaseType.substring(0, cacheBaseType.length - 1);
    }
    // Strip any prefix (e.g., "pkg.Type" -> "Type")
    if (cacheBaseType.contains('.') && !cacheBaseType.contains('<')) {
      cacheBaseType = cacheBaseType.split('.').last;
    }
    final typeUriKey = typeToUri[cacheBaseType] ?? '';
    final cacheKey = '$type|$typeParamsKey|${sourceFilePath ?? ''}|$typeUriKey';

    // Check cache first
    if (_typeResolutionCache.containsKey(cacheKey)) {
      return _typeResolutionCache[cacheKey]!;
    }

    // Detect recursive type bounds - if this type is already being resolved, use dynamic
    if (_typeResolutionInProgress.contains(cacheKey)) {
      // Recursive type bound detected (e.g., T extends Comparable<T>)
      return 'dynamic';
    }

    // Mark this type as being resolved
    _typeResolutionInProgress.add(cacheKey);

    try {
      final result = _resolveTypeArgument(
        type,
        typeToUri: typeToUri,
        classTypeParams: classTypeParams,
        sourceFilePath: sourceFilePath,
      );
      // Cache the result
      _typeResolutionCache[cacheKey] = result;
      // GEN-079: Record non-core generic types for relaxer generation.
      // This is the single centralized recording point — every type
      // resolution flows through here, so all generic specializations
      // are captured automatically.
      _recordResolvedGenericType(result);
      return result;
    } finally {
      // Remove from in-progress set
      _typeResolutionInProgress.remove(cacheKey);
    }
  }

  /// Dart core generic types handled by `.cast()` conversions in the bridge
  /// generator. These do NOT need relaxer wrappers.
  static const _coreGenericTypes = {
    'List',
    'Set',
    'Map',
    'Iterable',
    'Iterator',
    'Future',
    'Stream',
    'Comparable',
  };

  /// GEN-079: Records a generic extraction site if the raw (unprefixed) type
  /// GEN-079: Records a resolved generic type for relaxer generation.
  ///
  /// Analyses the RESOLVED type string (which has import prefixes like
  /// `material.Animation<ui.Color>`) and records the unprefixed base type
  /// and type argument. Called centrally from [_getTypeArgument] after
  /// type resolution, so ALL generic types flowing through the generator
  /// are captured automatically.
  void _recordResolvedGenericType(String resolvedType) {
    if (_currentModuleName == null) return;

    // Strip nullable suffix
    var type = resolvedType;
    if (type.endsWith('?')) {
      type = type.substring(0, type.length - 1);
    }

    // Must be a generic type
    final ltIdx = type.indexOf('<');
    if (ltIdx == -1) return;

    // Extract base type name and strip import prefix (e.g., "material.Animation" → "Animation")
    var baseTypeName = type.substring(0, ltIdx).trim();
    final dotIdx = baseTypeName.lastIndexOf('.');
    if (dotIdx != -1) {
      baseTypeName = baseTypeName.substring(dotIdx + 1);
    }
    // Strip '$' bridge-class prefix (e.g., "$Animation" → "Animation")
    if (baseTypeName.startsWith(r'$')) {
      baseTypeName = baseTypeName.substring(1);
    }

    // Skip Dart core collection types — handled by .cast() in the generator
    if (_coreGenericTypes.contains(baseTypeName)) return;

    // Parse the inner type argument (handling nested generics)
    var depth = 0;
    var gtIdx = -1;
    for (var i = ltIdx; i < type.length; i++) {
      if (type[i] == '<') depth++;
      if (type[i] == '>') {
        depth--;
        if (depth == 0) {
          gtIdx = i;
          break;
        }
      }
    }
    if (gtIdx == -1) return;

    var typeArg = type.substring(ltIdx + 1, gtIdx).trim();
    if (typeArg.isEmpty || typeArg == 'dynamic') return;

    // Strip ALL import prefixes from type arg, including nested generics.
    // Import prefixes are lowercase identifiers before a dot+uppercase:
    //   "flutter_163.State<flutter_163.StatefulWidget>" → "State<StatefulWidget>"
    //   "ui.Color" → "Color"
    //   "flutter_10.ValueNotifier<int>" → "ValueNotifier<int>"
    typeArg = typeArg.replaceAll(RegExp(r'[a-z_]\w*\.(?=[A-Z])'), '');

    // Strip '$' bridge-class prefix from all type names.
    // Bridge code uses $Icon, $Color etc. for wrapper classes, but the relaxer
    // needs bare Flutter type names (Icon, Color).
    typeArg = typeArg.replaceAll(RegExp(r'\$(?=[A-Z])'), '');

    // Strip nullable suffix from type arg
    if (typeArg.endsWith('?')) {
      typeArg = typeArg.substring(0, typeArg.length - 1);
    }

    // Skip unresolved type parameters (e.g., T, V, E, K, S) — these are
    // generic placeholders, not concrete specializations.
    if (typeArg.length <= 2 &&
        typeArg.codeUnits.every((c) => c >= 65 && c <= 90)) {
      return;
    }

    _genericExtractionSites.add(
      GenericExtractionSite(
        baseTypeName: baseTypeName,
        typeArg: typeArg,
        moduleName: _currentModuleName!,
      ),
    );
  }

  /// GEN-057: Generates a cast expression for setter values.
  ///
  /// For generic collection types like List<T> and Map<K,V>, the interpreter
  /// creates generic List<Object?> and Map<Object?, Object?> at runtime.
  /// Direct casting fails because Dart lists/maps are not covariant for casting.
  ///
  /// GEN-075: For non-collection types, uses D4.extractBridgedArg to correctly
  /// unwrap BridgedInstance values (e.g., BridgedInstance<Offset> → Offset).
  ///
  /// This method generates proper conversion expressions:
  /// - `List<String>` → `(value as List).cast<String>().toList()`
  /// - `List<String>?` → `value == null ? null : (value as List).cast<String>().toList()`
  /// - `Map<String, int>` → `(value as Map).cast<String, int>()`
  /// - Other types → `D4.extractBridgedArg<Type>(value, 'name')`
  String _generateSetterCast(
    String type, {
    String paramName = 'value',
    Map<String, String> typeToUri = const {},
    Map<String, String?> classTypeParams = const {},
    String? sourceFilePath,
  }) {
    // Handle nullable types first
    var baseType = type;
    final isNullable = baseType.endsWith('?');
    if (isNullable) {
      baseType = baseType.substring(0, baseType.length - 1);
    }

    // Check for List<T> pattern
    if (baseType.startsWith('List<') && baseType.endsWith('>')) {
      final elementType = baseType.substring(5, baseType.length - 1);
      final prefixedElementType = _getTypeArgument(
        elementType,
        typeToUri: typeToUri,
        classTypeParams: classTypeParams,
        sourceFilePath: sourceFilePath,
      );

      // Cluster C27 FIX: Use D4.coerceList instead of a CastList view.
      // D4rt creates List<Object?> for literals, with elements potentially
      // wrapped in BridgedInstance or BridgedEnumValue. A `.cast<T>()` view
      // only checks the type on element access, which fails when an
      // enum-typed setter receives BridgedEnumValue elements. coerceList
      // unwraps each element before the cast.
      if (isNullable) {
        return "value == null ? null : D4.coerceList<$prefixedElementType>(value, '$paramName')";
      } else {
        return "D4.coerceList<$prefixedElementType>(value, '$paramName')";
      }
    }

    // Check for Set<T> pattern
    if (baseType.startsWith('Set<') && baseType.endsWith('>')) {
      final elementType = baseType.substring(4, baseType.length - 1);
      final prefixedElementType = _getTypeArgument(
        elementType,
        typeToUri: typeToUri,
        classTypeParams: classTypeParams,
        sourceFilePath: sourceFilePath,
      );

      // Cluster C27 FIX: Use D4.coerceSet instead of a CastSet view.
      // See List<T> handling above for the same root cause.
      if (isNullable) {
        return "value == null ? null : D4.coerceSet<$prefixedElementType>(value, '$paramName')";
      } else {
        return "D4.coerceSet<$prefixedElementType>(value, '$paramName')";
      }
    }

    // Check for Map<K, V> pattern
    if (baseType.startsWith('Map<') && baseType.endsWith('>')) {
      // Parse the key and value types from Map<K, V>
      final inner = baseType.substring(4, baseType.length - 1);
      final types = _splitFunctionParams(inner);
      if (types.length == 2) {
        final rawKeyType = types[0].trim();
        final rawValueType = types[1].trim();
        final prefixedKeyType = _getTypeArgument(
          rawKeyType,
          typeToUri: typeToUri,
          classTypeParams: classTypeParams,
          sourceFilePath: sourceFilePath,
        );
        String prefixedValueType;

        final nullableValue = rawValueType.endsWith('?');
        final nonNullableValue = nullableValue
            ? rawValueType.substring(0, rawValueType.length - 1)
            : rawValueType;
        final unprefixedValue = _getUnprefixedTypeName(nonNullableValue);

        if (unprefixedValue == 'VoidCallback') {
          prefixedValueType = nullableValue
              ? 'void Function()?'
              : 'void Function()';
        } else {
          prefixedValueType = _getTypeArgument(
            rawValueType,
            typeToUri: typeToUri,
            classTypeParams: classTypeParams,
            sourceFilePath: sourceFilePath,
          );
        }

        // Cluster C27 FIX: Use D4.coerceMap instead of a CastMap view.
        // CastMap views type-check on key/value access; this fails when
        // D4rt elements are wrapped in BridgedInstance/BridgedEnumValue.
        if (isNullable) {
          return "value == null ? null : D4.coerceMap<$prefixedKeyType, $prefixedValueType>(value, '$paramName', visitor)";
        } else {
          return "D4.coerceMap<$prefixedKeyType, $prefixedValueType>(value, '$paramName', visitor)";
        }
      }
    }

    // Default: use D4.extractBridgedArg for proper BridgedInstance unwrapping
    // GEN-075: This correctly handles BridgedInstance<Offset> → Offset,
    // BridgedInstance<Color> → Color, etc., plus int→double promotion.
    final prefixedType = _getTypeArgument(
      type,
      typeToUri: typeToUri,
      classTypeParams: classTypeParams,
      sourceFilePath: sourceFilePath,
    );
    if (isNullable) {
      final nonNullablePrefixedType = _getTypeArgument(
        baseType,
        typeToUri: typeToUri,
        classTypeParams: classTypeParams,
        sourceFilePath: sourceFilePath,
      );
      return "D4.extractBridgedArgOrNull<$nonNullablePrefixedType>(value, '$paramName')";
    }
    // For dynamic type, no extraction needed
    if (prefixedType == 'dynamic') {
      return 'value as $prefixedType';
    }
    return "D4.extractBridgedArg<$prefixedType>(value, '$paramName')";
  }

  /// Internal implementation of type argument resolution.
  /// Called by [_getTypeArgument] after caching and recursion checks.
  String _resolveTypeArgument(
    String type, {
    Map<String, String> typeToUri = const {},
    Map<String, String?> classTypeParams = const {},
    String? sourceFilePath,
  }) {
    // Handle nullable types first - strip the ?
    var baseType = type;
    var isNullable = false;
    if (baseType.endsWith('?')) {
      baseType = baseType.substring(0, baseType.length - 1);
      isNullable = true;
    }

    // GEN-065: Guard against InvalidType from the Dart analyzer.
    // When the analyzer can't resolve a type (e.g., super/field formals without
    // explicit type annotations, callback params from unresolvable deps),
    // getDisplayString() returns literal "InvalidType". Use dynamic instead.
    if (baseType == 'InvalidType' || baseType.contains('InvalidType')) {
      return 'dynamic';
    }

    var normalizedTypeForParams = baseType;
    if (normalizedTypeForParams.contains('.') &&
        !normalizedTypeForParams.contains('<')) {
      normalizedTypeForParams = normalizedTypeForParams.split('.').last;
    }

    // Handle inline function types (e.g., Object? Function(Object?))
    // Parse and resolve types within the function signature with proper prefixes
    if (baseType.contains('Function(') || baseType.contains(') Function')) {
      final resolved = _resolveInlineFunctionType(
        baseType,
        typeToUri: typeToUri,
        classTypeParams: classTypeParams,
        sourceFilePath: sourceFilePath,
      );
      return isNullable ? '$resolved?' : resolved;
    }

    // Handle known function type aliases (typedef names) - use dynamic since we can't bridge them
    if (_knownFunctionTypeAliases.contains(baseType)) {
      return 'dynamic';
    }

    // Handle record types like (ParsedHeadline, int, int) or (String name, int age)
    if (baseType.startsWith('(') && baseType.endsWith(')')) {
      final result = _resolveRecordTypeWithPrefixes(
        baseType,
        typeToUri,
        classTypeParams: classTypeParams,
        sourceFilePath: sourceFilePath,
      );
      return isNullable ? '$result?' : result;
    }

    // Check if type is a class type parameter first (e.g., COL_TYPE, DART_TYPE, DBTYPE)
    // This handles both single-letter (T, E, K) and multi-character (COL_TYPE) type params
    if (classTypeParams.containsKey(normalizedTypeForParams)) {
      final bound = classTypeParams[normalizedTypeForParams];
      if (bound != null) {
        if (bound == _functionGenericParamSentinel) {
          return isNullable
              ? '$normalizedTypeForParams?'
              : normalizedTypeForParams;
        }
        // Check if the bound contains the same type parameter (recursive bound)
        // e.g., T extends Comparable<T> - we detect this by checking if the bound
        // mentions the same type parameter
        if (_containsTypeParameter(bound, normalizedTypeForParams)) {
          // Recursive bounds cannot be safely narrowed on raw generic bridge
          // classes; using dynamic avoids invalid assignability (e.g. Flutter
          // Slotted* renderObject parameters).
          return 'dynamic';
        }
        // Use the bound type (e.g., E -> TomObject)
        // Recursively resolve in case the bound itself needs prefixing
        final resolvedBound = _getTypeArgument(
          bound,
          typeToUri: typeToUri,
          classTypeParams: classTypeParams,
          sourceFilePath: sourceFilePath,
        );
        if (isNullable && !resolvedBound.endsWith('?')) {
          return '$resolvedBound?';
        }
        return resolvedBound;
      }
      return 'dynamic';
    }

    // Handle generic type parameters (T, R, E, K, V, S, etc.) that aren't in classTypeParams
    // Use dynamic as fallback - allows implicit casts for flexibility.
    // NOTE: For callback return types specifically, the calling code should handle
    // the FutureOr<T> vs FutureOr<dynamic> issue separately (see GEN-061).
    if (_isGenericTypeParameter(normalizedTypeForParams)) {
      return 'dynamic';
    }

    // Handle generic types with type arguments like List<T>, Map<K, V>
    if (baseType.contains('<')) {
      final result = _resolveGenericTypeWithPrefixes(
        baseType,
        typeToUri,
        classTypeParams: classTypeParams,
        sourceFilePath: sourceFilePath,
      );
      return isNullable ? '$result?' : result;
    }

    // Strip any existing prefix from source (e.g., jwt.JWTKey -> JWTKey)
    // The source code may have prefixed types, but we need to apply our own prefixes
    var unprefixedType = baseType;
    if (baseType.contains('.') && !baseType.contains('<')) {
      // This looks like a prefixed type - extract just the class name
      final parts = baseType.split('.');
      unprefixedType = parts.last;
    }

    // Check if this type needs a prefix
    final uri = typeToUri[unprefixedType];
    if (uri != null) {
      // Check if this is an SDK type (dart:*).
      if (uri.startsWith('dart:')) {
        final shouldPrefixSdk =
            !_isBuiltInType(unprefixedType) &&
            (uri == 'dart:math' || _exportedTypeNames.contains(unprefixedType));
        if (shouldPrefixSdk) {
          final existingSdkPrefix = _importPrefixes[uri];
          final sdkPrefix =
              (existingSdkPrefix != null && existingSdkPrefix.isNotEmpty)
              ? existingSdkPrefix
              : _generateImportPrefix(uri);
          _importPrefixes[uri] = sdkPrefix;
          final result = '$sdkPrefix.$unprefixedType';
          return isNullable ? '$result?' : result;
        }
        final result = unprefixedType;
        return isNullable ? '$result?' : result;
      }

      // Local file:// URIs - convert to package: and use its prefix from _importPrefixes
      if (uri.startsWith('file://') || uri.startsWith('file:///')) {
        final localPath = Uri.parse(uri).toFilePath();
        final packageUri = _getPackageUri(localPath);
        if (packageUri.startsWith('package:')) {
          final pkgPrefix = _importPrefixes[packageUri];
          if (pkgPrefix != null && pkgPrefix.isNotEmpty) {
            final result = '$pkgPrefix.$unprefixedType';
            return isNullable ? '$result?' : result;
          }
          // Not in direct imports — try auxiliary
          _addAuxiliaryImport(packageUri, unprefixedType);
          final auxPrefix = _getOrCreateAuxiliaryPrefix(packageUri);
          final result = '$auxPrefix.$unprefixedType';
          return isNullable ? '$result?' : result;
        }
        _recordMissingExport(
          'type argument (local file, could not resolve)',
          unprefixedType,
        );
        return 'dynamic';
      }

      final prefix = _importPrefixes[uri];
      if (prefix != null) {
        if (prefix.isEmpty) {
          final result = unprefixedType;
          return isNullable ? '$result?' : result;
        }
        // With direct source imports, the type is accessible via its prefix.
        // Only expand typedefs if the type is not otherwise importable.
        if (!_isTypeExported(unprefixedType) &&
            _typedefExpansions.containsKey(unprefixedType)) {
          final expanded = _typedefExpansions[unprefixedType]!;
          final resolved = _resolveInlineFunctionType(
            expanded,
            typeToUri: typeToUri,
            classTypeParams: classTypeParams,
            sourceFilePath: sourceFilePath,
          );
          return isNullable ? '$resolved?' : resolved;
        }
        final result = '$prefix.$unprefixedType';
        return isNullable ? '$result?' : result;
      } else {
        // GEN-055b: URI exists in typeToUri but no prefix was registered.
        // Normalize to package: URI first (typeToUri may contain bare file paths).
        var resolvedUri = uri;
        if (uri.startsWith('file://') || uri.startsWith('file:///')) {
          resolvedUri = _getPackageUri(Uri.parse(uri).toFilePath());
        } else if (!uri.startsWith('package:') && !uri.startsWith('dart:')) {
          resolvedUri = _getPackageUri(uri);
        }
        // Try to find an existing import prefix for the normalized URI
        if (resolvedUri.startsWith('package:')) {
          final pkgPrefix = _importPrefixes[resolvedUri];
          if (pkgPrefix != null && pkgPrefix.isNotEmpty) {
            final result = '$pkgPrefix.$unprefixedType';
            return isNullable ? '$result?' : result;
          }
          // Try auxiliary import mechanism (may have been pre-collected)
          final auxPrefix = _getOrCreateAuxiliaryPrefix(resolvedUri);
          if (_auxiliaryPrefixes.containsKey(resolvedUri)) {
            final result = '$auxPrefix.$unprefixedType';
            return isNullable ? '$result?' : result;
          }
        }
        // Fallback: generate a unique prefix on-the-fly (late import).
        final prefix = _generateUniqueImportPrefix(uri);
        _importPrefixes[uri] = prefix;
        _recordMissingExport(
          'missing import for type',
          '$unprefixedType (added import for $uri as $prefix)',
        );
        final result = '$prefix.$unprefixedType';
        return isNullable ? '$result?' : result;
      }
    }

    // For non-built-in types without URI info, try auxiliary imports from source file
    if (!_isBuiltInType(unprefixedType)) {
      if (sourceFilePath != null) {
        final auxUri = _resolveTypeFromSourceImports(
          unprefixedType,
          sourceFilePath,
        );
        if (auxUri != null) {
          // GEN-068b: When _resolveTypeFromSourceImports returns a barrel URI
          // (e.g., package:tom_core_kernel/tom_core_kernel.dart), it may not have
          // a prefix in _importPrefixes. Before creating an auxiliary prefix for
          // the barrel, check if the type's actual source file is already imported
          // via _globalTypeToUri → _importPrefixes lookup.
          final existingAuxPrefix = _importPrefixes[auxUri];
          if (existingAuxPrefix != null && existingAuxPrefix.isNotEmpty) {
            final result = '$existingAuxPrefix.$unprefixedType';
            return isNullable ? '$result?' : result;
          }
          // auxUri is not directly imported — check _globalTypeToUri for a more
          // specific URI (the actual source file) that may already be imported.
          final globalUri = _globalTypeToUri[unprefixedType];
          if (globalUri != null) {
            var resolvedGlobalUri = globalUri;
            if (globalUri.startsWith('file://') ||
                globalUri.startsWith('file:///')) {
              final localPath = Uri.parse(globalUri).toFilePath();
              final packageUri = _getPackageUri(localPath);
              if (packageUri.startsWith('package:')) {
                resolvedGlobalUri = packageUri;
              }
            } else if (!globalUri.startsWith('package:') &&
                !globalUri.startsWith('dart:')) {
              final packageUri = _getPackageUri(globalUri);
              if (packageUri.startsWith('package:')) {
                resolvedGlobalUri = packageUri;
              }
            }
            final globalPrefix = _importPrefixes[resolvedGlobalUri];
            if (globalPrefix != null && globalPrefix.isNotEmpty) {
              final result = '$globalPrefix.$unprefixedType';
              return isNullable ? '$result?' : result;
            }
          }
          _addAuxiliaryImport(auxUri, unprefixedType);
          final prefix = _getOrCreateAuxiliaryPrefix(auxUri);
          final result = '$prefix.$unprefixedType';
          return isNullable ? '$result?' : result;
        }
      }

      // GEN-055: Check global type registry BEFORE source file fallback.
      // Types may have been resolved by the analyzer for other members but are
      // not in this member's typeToUri. The global registry captures all type→URI
      // mappings seen across all source files. This must be checked before the
      // source file path fallback, which would incorrectly use the declaring
      // class's file prefix for types that are actually defined elsewhere.
      final globalUri = _globalTypeToUri[unprefixedType];
      if (globalUri != null) {
        if (globalUri.startsWith('dart:')) {
          final shouldPrefixSdk =
              !_isBuiltInType(unprefixedType) &&
              (globalUri == 'dart:math' ||
                  _exportedTypeNames.contains(unprefixedType));
          if (shouldPrefixSdk) {
            final existingSdkPrefix = _importPrefixes[globalUri];
            final sdkPrefix =
                (existingSdkPrefix != null && existingSdkPrefix.isNotEmpty)
                ? existingSdkPrefix
                : _generateImportPrefix(globalUri);
            _importPrefixes[globalUri] = sdkPrefix;
            final result = '$sdkPrefix.$unprefixedType';
            return isNullable ? '$result?' : result;
          }
          final result = unprefixedType;
          return isNullable ? '$result?' : result;
        }
        // Normalize file:// URIs to package: URIs so they match _importPrefixes keys
        var resolvedGlobalUri = globalUri;
        if (globalUri.startsWith('file://') ||
            globalUri.startsWith('file:///')) {
          final localPath = Uri.parse(globalUri).toFilePath();
          final packageUri = _getPackageUri(localPath);
          if (packageUri.startsWith('package:')) {
            resolvedGlobalUri = packageUri;
          }
        } else if (!globalUri.startsWith('package:') &&
            !globalUri.startsWith('dart:')) {
          final packageUri = _getPackageUri(globalUri);
          if (packageUri.startsWith('package:')) {
            resolvedGlobalUri = packageUri;
          }
        }
        // Check if there's already a direct import prefix for this URI
        final existingPrefix = _importPrefixes[resolvedGlobalUri];
        if (existingPrefix != null && existingPrefix.isNotEmpty) {
          final result = '$existingPrefix.$unprefixedType';
          return isNullable ? '$result?' : result;
        }
        _addAuxiliaryImport(resolvedGlobalUri, unprefixedType);
        final prefix = _getOrCreateAuxiliaryPrefix(resolvedGlobalUri);
        final result = '$prefix.$unprefixedType';
        return isNullable ? '$result?' : result;
      }

      if (sourceFilePath != null) {
        final sourceUri = _getPackageUri(sourceFilePath);
        // Only use sourceFilePath prefix if the type is NOT exported from the barrel.
        // For exported types, sourceFilePath is the USING class's file, not the file
        // that defines the type. Using it would give a wrong prefix (e.g., $tom_build_cli_4
        // for a type defined in bridge_configuration.dart/$tom_build_cli_1).
        // Exported types should have been resolved by typeToUri, _resolveTypeFromSourceImports,
        // or _globalTypeToUri above. If we get here, the type genuinely can't be found.
        if (sourceUri.startsWith('package:') &&
            !_isTypeExported(unprefixedType)) {
          // GEN-066: Before using the source file's prefix, try textual import scanning
          // to find if the type is from a transitive dependency. This catches types like
          // Trace (from package:stack_trace) and SettingsYaml (from package:settings_yaml)
          // that the analyzer couldn't resolve because they're transitive deps.
          final textUri = _resolveTypeByImportTextScan(
            unprefixedType,
            sourceFilePath,
          );
          if (textUri != null) {
            // Found the type in a transitive dependency import.
            // Check if we can import it (has a prefix registered or can create auxiliary).
            final textPrefix = _importPrefixes[textUri];
            if (textPrefix != null && textPrefix.isNotEmpty) {
              final result = '$textPrefix.$unprefixedType';
              return isNullable ? '$result?' : result;
            }
            // The type is from a transitive dependency — we can try to use auxiliary imports,
            // but if the package is not a direct dependency, the import won't compile.
            // Use dynamic instead to be safe.
            _recordMissingExport(
              'type from transitive dependency (using dynamic)',
              '$unprefixedType (from $textUri, used in $sourceFilePath)',
            );
            return 'dynamic';
          }
          // Non-exported type, possibly defined in the source file itself
          final srcPrefix = _importPrefixes[sourceUri];
          if (srcPrefix != null && srcPrefix.isNotEmpty) {
            final result = '$srcPrefix.$unprefixedType';
            return isNullable ? '$result?' : result;
          }
        }
        if (sourceFilePath.startsWith(workspacePath)) {
          // Try to use source file's prefix from _importPrefixes
          final sourceUri2 = _getPackageUri(sourceFilePath);
          final srcPrefix2 = _importPrefixes[sourceUri2];
          if (srcPrefix2 != null && srcPrefix2.isNotEmpty) {
            final result = '$srcPrefix2.$unprefixedType';
            return isNullable ? '$result?' : result;
          }
        }
        // GEN-069: Last resort for exported types defined in the same file as sourceFilePath.
        // When _isTypeExported is true, the block above is skipped because the comment assumes
        // sourceFilePath points to the USING class's file, not the type's definition file.
        // But for types defined in the same file (e.g., ParsedHeadline in markdown_parser.dart),
        // sourceFilePath IS the correct file. Try the sourceFilePath prefix unconditionally.
        {
          final lastResortUri = _getPackageUri(sourceFilePath);
          final lastResortPrefix = _importPrefixes[lastResortUri];
          if (lastResortPrefix != null && lastResortPrefix.isNotEmpty) {
            final result = '$lastResortPrefix.$unprefixedType';
            return isNullable ? '$result?' : result;
          }
        }
      }
      // Type is not exported or has no URI info - check if it's a typedef we can expand
      if (_typedefExpansions.containsKey(unprefixedType)) {
        final expanded = _typedefExpansions[unprefixedType]!;
        // Resolve types within the expanded function type
        final resolved = _resolveInlineFunctionType(
          expanded,
          typeToUri: typeToUri,
          classTypeParams: classTypeParams,
          sourceFilePath: sourceFilePath,
        );
        return isNullable ? '$resolved?' : resolved;
      }
      _recordMissingExport(
        'type argument (not exported, using dynamic)',
        unprefixedType,
      );
      return 'dynamic';
    }

    return type;
  }

  /// Returns true if the type is a Dart built-in type.
  /// These types are from dart:core or other commonly used dart: libraries
  /// that don't need import prefixes.
  static bool _isBuiltInType(String typeName) {
    const builtInTypes = {
      // dart:core types
      'int', 'double', 'num', 'String', 'bool', 'void', 'dynamic', 'Object',
      'List',
      'Map',
      'Set',
      'Iterable',
      'Iterator',
      'Future',
      'Stream',
      'Function',
      'Type', 'Symbol', 'Null', 'Never', 'Duration', 'DateTime', 'Uri', 'Enum',
      'BigInt', 'Comparable', 'Pattern', 'Match', 'RegExp', 'Runes',
      'StringBuffer', 'StringSink', 'Sink', 'Error', 'Exception', 'StackTrace',
      'Record', 'FutureOr', 'MapEntry', 'Invocation', 'FormatException',
      'StateError', 'ArgumentError', 'RangeError', 'UnsupportedError',
      'ConcurrentModificationError', 'OutOfMemoryError', 'StackOverflowError',
      // dart:typed_data types
      'Uint8List', 'Int8List', 'Uint8ClampedList', 'Int16List', 'Uint16List',
      'Int32List', 'Uint32List', 'Int64List', 'Uint64List', 'Float32List',
      'Float64List', 'ByteBuffer', 'ByteData', 'TypedData', 'Endian',
      // dart:async types
      'Completer', 'Timer', 'StreamController', 'StreamSubscription',
      'StreamSink', 'EventSink', 'Zone', 'ZoneDelegate', 'ZoneSpecification',
      // dart:io types
      'File', 'Directory', 'FileSystemEntity', 'Platform', 'Process',
      'ProcessResult', 'Stdin', 'Stdout', 'Socket', 'ServerSocket',
      'RawSocket', 'RawServerSocket', 'HttpClient', 'HttpServer',
      'HttpRequest', 'HttpResponse', 'Cookie', 'ContentType',
      'InternetAddress', 'IOSink', 'RandomAccessFile', 'Link',
      // dart:convert types
      'Codec', 'Converter', 'Encoding', 'JsonCodec', 'JsonDecoder',
      'JsonEncoder', 'Utf8Codec', 'Utf8Decoder', 'Utf8Encoder',
      'Base64Codec', 'Base64Decoder', 'Base64Encoder', 'AsciiCodec',
      'Latin1Codec', 'LineSplitter', 'HtmlEscape',
      // dart:isolate types
      'Isolate', 'SendPort', 'ReceivePort', 'Capability',
    };
    return builtInTypes.contains(typeName);
  }

  /// Resolves generic types with import prefixes.
  String _resolveGenericTypeWithPrefixes(
    String type,
    Map<String, String> typeToUri, {
    Map<String, String?> classTypeParams = const {},
    String? sourceFilePath,
  }) {
    final openBracket = type.indexOf('<');
    if (openBracket == -1) return type;

    final baseType = type.substring(0, openBracket);
    final argsStr = type.substring(openBracket + 1, type.length - 1);

    // Prefix the base type if needed
    String prefixedBase = baseType;
    final baseUri = typeToUri[baseType];
    if (baseUri != null) {
      // SDK types: prefix when clash-prone.
      if (baseUri.startsWith('dart:')) {
        final shouldPrefixSdk =
            !_isBuiltInType(baseType) &&
            (baseUri == 'dart:math' || _exportedTypeNames.contains(baseType));
        if (shouldPrefixSdk) {
          final existingSdkPrefix = _importPrefixes[baseUri];
          final sdkPrefix =
              (existingSdkPrefix != null && existingSdkPrefix.isNotEmpty)
              ? existingSdkPrefix
              : _generateImportPrefix(baseUri);
          _importPrefixes[baseUri] = sdkPrefix;
          prefixedBase = '$sdkPrefix.$baseType';
        } else {
          prefixedBase = baseType;
        }
      } else if (baseUri.startsWith('file://') ||
          baseUri.startsWith('file:///')) {
        // Local file:// URIs - convert to package: and use _importPrefixes
        final localPath = Uri.parse(baseUri).toFilePath();
        final packageUri = _getPackageUri(localPath);
        final pkgPrefix = _importPrefixes[packageUri];
        if (pkgPrefix != null && pkgPrefix.isNotEmpty) {
          prefixedBase = '$pkgPrefix.$baseType';
        } else if (packageUri.startsWith('package:')) {
          _addAuxiliaryImport(packageUri, baseType);
          prefixedBase = '${_getOrCreateAuxiliaryPrefix(packageUri)}.$baseType';
        }
      } else {
        final prefix = _importPrefixes[baseUri];
        if (prefix != null) {
          prefixedBase = prefix.isEmpty ? baseType : '$prefix.$baseType';
        } else {
          // GEN-055b: URI exists but no prefix. Try auxiliary import first.
          if (baseUri.startsWith('package:')) {
            final auxPrefix = _getOrCreateAuxiliaryPrefix(baseUri);
            if (_importPrefixes.containsKey(baseUri) ||
                _auxiliaryPrefixes.containsKey(baseUri)) {
              prefixedBase = '$auxPrefix.$baseType';
            } else {
              final prefix = _generateUniqueImportPrefix(baseUri);
              _importPrefixes[baseUri] = prefix;
              prefixedBase = '$prefix.$baseType';
            }
          } else {
            final prefix = _generateUniqueImportPrefix(baseUri);
            _importPrefixes[baseUri] = prefix;
            prefixedBase = '$prefix.$baseType';
          }
        }
      }
    } else if (!_isBuiltInType(baseType)) {
      // Try auxiliary imports from source file if available
      if (sourceFilePath != null) {
        final auxUri = _resolveTypeFromSourceImports(baseType, sourceFilePath);
        if (auxUri != null) {
          _addAuxiliaryImport(auxUri, baseType);
          final prefix = _getOrCreateAuxiliaryPrefix(auxUri);
          prefixedBase = '$prefix.$baseType';
        }
      }

      if (prefixedBase == baseType) {
        // Non-built-in type without URI info - check if exported from barrel
        if (!_isTypeExported(baseType)) {
          if (sourceFilePath != null) {
            final sourceUri = _getPackageUri(sourceFilePath);
            if (sourceUri.startsWith('package:')) {
              _addAuxiliaryImport(sourceUri, baseType);
              final prefix = _getOrCreateAuxiliaryPrefix(sourceUri);
              prefixedBase = '$prefix.$baseType';
            }
          }
          if (prefixedBase != baseType) {
            // Use auxiliary import from source file
          } else {
            // GEN-017: Check global type registry before falling to dynamic
            final globalUri = _globalTypeToUri[baseType];
            if (globalUri != null) {
              if (globalUri.startsWith('dart:')) {
                prefixedBase = baseType;
              } else {
                _addAuxiliaryImport(globalUri, baseType);
                final auxPrefix = _getOrCreateAuxiliaryPrefix(globalUri);
                prefixedBase = '$auxPrefix.$baseType';
              }
            } else {
              // Type not exported, use dynamic for the whole generic type
              _recordMissingExport(
                'generic base type (not exported, using dynamic)',
                baseType,
              );
              return 'dynamic';
            }
          }
          // Type not exported, use dynamic for the whole generic type
        }
        // Type is available but maybe not via barrel - look up prefix from global type registry
        if (prefixedBase == baseType) {
          final gUri = _globalTypeToUri[baseType];
          if (gUri != null) {
            final gPrefix = _importPrefixes[gUri];
            if (gPrefix != null && gPrefix.isNotEmpty) {
              prefixedBase = '$gPrefix.$baseType';
            } else {
              _addAuxiliaryImport(gUri, baseType);
              prefixedBase = '${_getOrCreateAuxiliaryPrefix(gUri)}.$baseType';
            }
          } else if (sourceFilePath != null) {
            final sourceUri = _getPackageUri(sourceFilePath);
            final srcPrefix = _importPrefixes[sourceUri];
            if (srcPrefix != null && srcPrefix.isNotEmpty) {
              prefixedBase = '$srcPrefix.$baseType';
            }
          }
        }
      }
    }

    // Parse and resolve type arguments with prefixes
    final resolvedArgs = _resolveTypeArgumentsWithPrefixes(
      argsStr,
      typeToUri,
      classTypeParams: classTypeParams,
      sourceFilePath: sourceFilePath,
    );

    return '$prefixedBase<$resolvedArgs>';
  }

  /// Resolves type arguments with import prefixes.
  /// [classTypeParams] contains the class's generic type parameter bounds.
  String _resolveTypeArgumentsWithPrefixes(
    String argsStr,
    Map<String, String> typeToUri, {
    Map<String, String?> classTypeParams = const {},
    String? sourceFilePath,
  }) {
    final args = <String>[];
    var depth = 0;
    var start = 0;

    for (var i = 0; i < argsStr.length; i++) {
      final char = argsStr[i];
      if (char == '<') {
        depth++;
      } else if (char == '>') {
        depth--;
      } else if (char == ',' && depth == 0) {
        args.add(argsStr.substring(start, i).trim());
        start = i + 1;
      }
    }
    args.add(argsStr.substring(start).trim());

    // Resolve each argument with prefixes
    return args
        .map((arg) {
          final argIsNullable = arg.endsWith('?');
          var baseArg = argIsNullable ? arg.substring(0, arg.length - 1) : arg;
          var lookupArg = baseArg;
          if (lookupArg.contains('.') && !lookupArg.contains('<')) {
            lookupArg = lookupArg.split('.').last;
          }
          if (classTypeParams.containsKey(baseArg) ||
              _isGenericTypeParameter(baseArg)) {
            // Use bound from class type parameters if available
            final bound = classTypeParams[baseArg];
            if (bound != null) {
              if (bound == _functionGenericParamSentinel) {
                return argIsNullable ? '$baseArg?' : baseArg;
              }
              // Recursively resolve the bound type
              final resolved = _getTypeArgument(
                bound,
                typeToUri: typeToUri,
                classTypeParams: classTypeParams,
                sourceFilePath: sourceFilePath,
              );
              // GEN-070: Preserve nullability suffix when resolving type params.
              // If the original arg was T?, the resolved type should also be
              // nullable (e.g., T? where T extends Object → Object?).
              if (argIsNullable && !resolved.endsWith('?')) {
                return '$resolved?';
              }
              return resolved;
            }
            return 'dynamic';
          }
          if (baseArg.contains('<')) {
            return _resolveGenericTypeWithPrefixes(
              arg,
              typeToUri,
              classTypeParams: classTypeParams,
              sourceFilePath: sourceFilePath,
            );
          }
          // Check if this type needs a prefix
          final uri = typeToUri[lookupArg] ?? typeToUri[baseArg];
          if (uri != null) {
            // SDK types need prefix only when clash-prone.
            if (uri.startsWith('dart:')) {
              final shouldPrefixSdk =
                  !_isBuiltInType(baseArg) &&
                  (uri == 'dart:math' || _exportedTypeNames.contains(baseArg));
              if (shouldPrefixSdk) {
                final existingSdkPrefix = _importPrefixes[uri];
                final sdkPrefix =
                    (existingSdkPrefix != null && existingSdkPrefix.isNotEmpty)
                    ? existingSdkPrefix
                    : _generateImportPrefix(uri);
                _importPrefixes[uri] = sdkPrefix;
                return '$sdkPrefix.$lookupArg';
              }
              return argIsNullable ? '$lookupArg?' : lookupArg;
            }
            // Local file:// URIs - convert to package: and use _importPrefixes
            if (uri.startsWith('file://') || uri.startsWith('file:///')) {
              final localPath = Uri.parse(uri).toFilePath();
              final packageUri = _getPackageUri(localPath);
              if (packageUri.startsWith('package:')) {
                final pkgPrefix = _importPrefixes[packageUri];
                if (pkgPrefix != null && pkgPrefix.isNotEmpty) {
                  return '$pkgPrefix.$lookupArg';
                }
                _addAuxiliaryImport(packageUri, lookupArg);
                final auxPrefix = _getOrCreateAuxiliaryPrefix(packageUri);
                return '$auxPrefix.$lookupArg';
              }
              _recordMissingExport(
                'type argument (local file, could not resolve)',
                baseArg,
              );
              return 'dynamic';
            }
            final prefix = _importPrefixes[uri];
            if (prefix != null) {
              return prefix.isEmpty ? lookupArg : '$prefix.$lookupArg';
            }
            // GEN-055b: URI exists but no import prefix. Try auxiliary prefix.
            if (uri.startsWith('package:')) {
              final auxPrefix = _getOrCreateAuxiliaryPrefix(uri);
              if (_auxiliaryPrefixes.containsKey(uri)) {
                return '$auxPrefix.$lookupArg';
              }
            }
          }
          // Try auxiliary imports if available
          if (sourceFilePath != null) {
            final auxUri = _resolveTypeFromSourceImports(
              baseArg,
              sourceFilePath,
            );
            if (auxUri != null) {
              _addAuxiliaryImport(auxUri, lookupArg);
              final prefix = _getOrCreateAuxiliaryPrefix(auxUri);
              return '$prefix.$lookupArg';
            }
          }
          // Non-built-in type without URI info
          if (!_isBuiltInType(lookupArg)) {
            // GEN-055: Check global type registry BEFORE source file fallback
            final globalUri =
                _globalTypeToUri[lookupArg] ?? _globalTypeToUri[baseArg];
            if (globalUri != null) {
              if (globalUri.startsWith('dart:')) {
                final shouldPrefixSdk =
                    !_isBuiltInType(lookupArg) &&
                    (globalUri == 'dart:math' ||
                        _exportedTypeNames.contains(lookupArg));
                if (shouldPrefixSdk) {
                  final existingSdkPrefix = _importPrefixes[globalUri];
                  final sdkPrefix =
                      (existingSdkPrefix != null &&
                          existingSdkPrefix.isNotEmpty)
                      ? existingSdkPrefix
                      : _generateImportPrefix(globalUri);
                  _importPrefixes[globalUri] = sdkPrefix;
                  return '$sdkPrefix.$lookupArg';
                }
                return argIsNullable ? '$lookupArg?' : lookupArg;
              }
              _addAuxiliaryImport(globalUri, lookupArg);
              final auxPrefix = _getOrCreateAuxiliaryPrefix(globalUri);
              return '$auxPrefix.$lookupArg';
            }
            if (sourceFilePath != null) {
              final sourceUri = _getPackageUri(sourceFilePath);
              if (sourceUri.startsWith('package:') &&
                  _isTypeExported(lookupArg)) {
                _addAuxiliaryImport(sourceUri, lookupArg);
                final prefix = _getOrCreateAuxiliaryPrefix(sourceUri);
                return '$prefix.$lookupArg';
              }
              if (sourceFilePath.startsWith(workspacePath)) {
                // Try source file's prefix from _importPrefixes
                final sourceUri = _getPackageUri(sourceFilePath);
                final srcPrefix = _importPrefixes[sourceUri];
                if (srcPrefix != null && srcPrefix.isNotEmpty) {
                  return '$srcPrefix.$lookupArg';
                }
              }
            }
            _recordMissingExport(
              'type argument (not exported, using dynamic)',
              lookupArg,
            );
            return 'dynamic';
          }
          return argIsNullable ? '$lookupArg?' : lookupArg;
        })
        .join(', ');
  }

  /// Checks if a resolved type string represents a Dart record type.
  /// Record types start with `(` and end with `)`, e.g., `(int, int)` or `({int min, int max})`.
  bool _isRecordType(String type) {
    if (type.isEmpty) return false;
    final trimmed = type.trim();
    return trimmed.startsWith('(') &&
        trimmed.endsWith(')') &&
        !trimmed.contains('=>');
  }

  /// Parses a record type string into positional field types and named field entries.
  /// Returns a record with (positionalTypes: List<String>, namedFields: Map<String, String>).
  ///
  /// Example:
  /// - `(int, int)` → positional: ['int', 'int'], named: {}
  /// - `({int min, int max})` → positional: [], named: {'min': 'int', 'max': 'int'}
  /// - `(String, {int count})` → positional: ['String'], named: {'count': 'int'}
  ({List<String> positionalTypes, Map<String, String> namedFields})
  _parseRecordType(String type) {
    final inner = type.substring(1, type.length - 1).trim();
    if (inner.isEmpty) return (positionalTypes: [], namedFields: {});

    final positionalTypes = <String>[];
    final namedFields = <String, String>{};

    // Check if the entire content is a named field group
    if (inner.startsWith('{') && inner.endsWith('}')) {
      final namedContent = inner.substring(1, inner.length - 1).trim();
      _parseNamedFieldsInto(namedContent, namedFields);
      return (positionalTypes: positionalTypes, namedFields: namedFields);
    }

    // Parse fields with depth tracking for nested types
    final fields = <String>[];
    var depth = 0;
    var genericDepth = 0;
    var braceDepth = 0;
    var start = 0;

    for (var i = 0; i < inner.length; i++) {
      final char = inner[i];
      if (char == '(')
        depth++;
      else if (char == ')')
        depth--;
      else if (char == '<')
        genericDepth++;
      else if (char == '>')
        genericDepth--;
      else if (char == '{')
        braceDepth++;
      else if (char == '}')
        braceDepth--;
      else if (char == ',' &&
          depth == 0 &&
          genericDepth == 0 &&
          braceDepth == 0) {
        fields.add(inner.substring(start, i).trim());
        start = i + 1;
      }
    }
    fields.add(inner.substring(start).trim());

    for (final field in fields) {
      if (field.startsWith('{') && field.endsWith('}')) {
        // Named field group
        final namedContent = field.substring(1, field.length - 1).trim();
        _parseNamedFieldsInto(namedContent, namedFields);
      } else {
        // Positional field — just a type
        positionalTypes.add(field.trim());
      }
    }

    return (positionalTypes: positionalTypes, namedFields: namedFields);
  }

  /// Parses comma-separated named fields like "int min, int max" into a map.
  void _parseNamedFieldsInto(String content, Map<String, String> namedFields) {
    if (content.isEmpty) return;

    final fields = <String>[];
    var depth = 0;
    var genericDepth = 0;
    var start = 0;

    for (var i = 0; i < content.length; i++) {
      final char = content[i];
      if (char == '(')
        depth++;
      else if (char == ')')
        depth--;
      else if (char == '<')
        genericDepth++;
      else if (char == '>')
        genericDepth--;
      else if (char == ',' && depth == 0 && genericDepth == 0) {
        fields.add(content.substring(start, i).trim());
        start = i + 1;
      }
    }
    fields.add(content.substring(start).trim());

    for (final field in fields) {
      final spaceIndex = field.lastIndexOf(' ');
      if (spaceIndex > 0) {
        final typePart = field.substring(0, spaceIndex).trim();
        final namePart = field.substring(spaceIndex + 1).trim();
        namedFields[namePart] = typePart;
      }
    }
  }

  /// Generates parameter extraction code for a record-typed parameter.
  /// Converts `InterpretedRecord` from the interpreter to a native Dart record.
  ///
  /// Example output for `(int, int)` parameter:
  /// ```
  ///   final pair\$raw = positional[0];
  ///   final pair = pair\$raw is InterpretedRecord
  ///       ? (pair\$raw.positionalFields[0] as int, pair\$raw.positionalFields[1] as int)
  ///       : pair\$raw as (int, int);
  /// ```
  List<String> _generateRecordParamExtraction({
    required String localName,
    required String resolvedType,
    required int positionalIndex,
    required String paramName,
    required String funcName,
    required String indent,
  }) {
    final lines = <String>[];
    final rawName = '$localName\$raw';
    final parsed = _parseRecordType(resolvedType);

    lines.add('$indent  final $rawName = positional[$positionalIndex];');

    // Build the InterpretedRecord→native record conversion expression.
    // C47: Use D4.extractBridgedArg for each field — record fields may be
    // wrapped in BridgedInstance / BridgedEnumValue, so a raw `as` cast
    // fails. extractBridgedArg unwraps then casts.
    final parts = <String>[];

    // Positional fields
    for (var i = 0; i < parsed.positionalTypes.length; i++) {
      parts.add(
        "D4.extractBridgedArg<${parsed.positionalTypes[i]}>("
        "$rawName.positionalFields[$i], "
        "'$paramName.field$i')",
      );
    }

    // Named fields
    for (final entry in parsed.namedFields.entries) {
      parts.add(
        "${entry.key}: D4.extractBridgedArg<${entry.value}>("
        "$rawName.namedFields['${entry.key}'], "
        "'$paramName.${entry.key}')",
      );
    }

    final recordLiteral = '(${parts.join(', ')})';
    lines.add('$indent  final $localName = $rawName is InterpretedRecord');
    lines.add('$indent      ? $recordLiteral');
    lines.add('$indent      : $rawName as $resolvedType;');

    return lines;
  }

  /// Generates return code that converts a native Dart record to `InterpretedRecord`.
  ///
  /// Example output for `({int min, int max})` return type:
  /// ```
  ///   final \$result = \$pkg.findMinMax(numbers);
  ///   return InterpretedRecord([], {'min': \$result.min, 'max': \$result.max});
  /// ```
  String _generateRecordReturnWrapper({
    required String callExpr,
    required String returnType,
    required String indent,
  }) {
    final parsed = _parseRecordType(returnType);
    final lines = StringBuffer();

    lines.writeln('$indent  final \$result = $callExpr;');

    // Build the InterpretedRecord construction
    final positionalArgs = <String>[];
    for (var i = 0; i < parsed.positionalTypes.length; i++) {
      positionalArgs.add('\$result.\$${i + 1}');
    }

    final namedArgs = <String>[];
    for (final name in parsed.namedFields.keys) {
      namedArgs.add("'$name': \$result.$name");
    }

    final positionalStr = '[${positionalArgs.join(', ')}]';
    final namedStr = namedArgs.isEmpty ? '{}' : '{${namedArgs.join(', ')}}';

    lines.write(
      '$indent  return InterpretedRecord($positionalStr, $namedStr);',
    );

    return lines.toString();
  }

  /// Resolves record types like (ParsedHeadline, int, int) or (String name, int age)
  /// by prefixing each type in the record.
  ///
  /// Handles:
  /// - Positional fields: `(int, String)`
  /// - Named fields: `({int x, String y})`
  /// - Mixed fields: `(int, {String name})`
  /// - Function types in fields: `(void Function(), int)`
  /// - Nested records: `((int, String), bool)`
  String _resolveRecordTypeWithPrefixes(
    String type,
    Map<String, String> typeToUri, {
    Map<String, String?> classTypeParams = const {},
    String? sourceFilePath,
  }) {
    // Strip the outer parentheses
    final inner = type.substring(1, type.length - 1).trim();
    if (inner.isEmpty) return type;

    // Check if the entire content is a named field group (starts with {)
    if (inner.startsWith('{') && inner.endsWith('}')) {
      // Pure named record: ({int x, String y})
      final namedContent = inner.substring(1, inner.length - 1).trim();
      final resolved = _resolveRecordNamedFields(
        namedContent,
        typeToUri,
        classTypeParams: classTypeParams,
        sourceFilePath: sourceFilePath,
      );
      return '({$resolved})';
    }

    // Parse record fields, handling nested types carefully
    final fields = <String>[];
    var depth = 0;
    var genericDepth = 0;
    var braceDepth = 0;
    var start = 0;

    for (var i = 0; i < inner.length; i++) {
      final char = inner[i];
      if (char == '(')
        depth++;
      else if (char == ')')
        depth--;
      else if (char == '<')
        genericDepth++;
      else if (char == '>')
        genericDepth--;
      else if (char == '{')
        braceDepth++;
      else if (char == '}')
        braceDepth--;
      else if (char == ',' &&
          depth == 0 &&
          genericDepth == 0 &&
          braceDepth == 0) {
        fields.add(inner.substring(start, i).trim());
        start = i + 1;
      }
    }
    fields.add(inner.substring(start).trim());

    // Resolve each field
    final resolvedFields = fields
        .map((field) {
          // Check for named field group: {Type name, Type2 name2}
          if (field.startsWith('{') && field.endsWith('}')) {
            final namedContent = field.substring(1, field.length - 1).trim();
            final resolved = _resolveRecordNamedFields(
              namedContent,
              typeToUri,
              classTypeParams: classTypeParams,
              sourceFilePath: sourceFilePath,
            );
            return '{$resolved}';
          }

          // Check for named record fields like "String name" or "int age"
          final spaceIndex = field.lastIndexOf(' ');
          if (spaceIndex > 0) {
            // This might be "TypeName fieldName" - check if last part is a valid identifier
            final typePart = field.substring(0, spaceIndex).trim();
            final namePart = field.substring(spaceIndex + 1).trim();
            // Check if namePart looks like a field name (starts with lowercase)
            if (namePart.isNotEmpty &&
                namePart[0].toLowerCase() == namePart[0] &&
                !namePart.contains('<')) {
              final resolvedType = _getTypeArgument(
                typePart,
                typeToUri: typeToUri,
                classTypeParams: classTypeParams,
                sourceFilePath: sourceFilePath,
              );
              return '$resolvedType $namePart';
            }
          }
          // Positional record field - just a type
          return _getTypeArgument(
            field,
            typeToUri: typeToUri,
            classTypeParams: classTypeParams,
            sourceFilePath: sourceFilePath,
          );
        })
        .join(', ');

    return '($resolvedFields)';
  }

  /// Resolves named fields within a record's named section.
  /// E.g., "int x, String y" from ({int x, String y})
  String _resolveRecordNamedFields(
    String content,
    Map<String, String> typeToUri, {
    Map<String, String?> classTypeParams = const {},
    String? sourceFilePath,
  }) {
    if (content.isEmpty) return content;

    // Parse comma-separated named fields
    final fields = <String>[];
    var depth = 0;
    var genericDepth = 0;
    var start = 0;

    for (var i = 0; i < content.length; i++) {
      final char = content[i];
      if (char == '(')
        depth++;
      else if (char == ')')
        depth--;
      else if (char == '<')
        genericDepth++;
      else if (char == '>')
        genericDepth--;
      else if (char == ',' && depth == 0 && genericDepth == 0) {
        fields.add(content.substring(start, i).trim());
        start = i + 1;
      }
    }
    fields.add(content.substring(start).trim());

    // Resolve each named field (each is "Type name")
    return fields
        .map((field) {
          final spaceIndex = field.lastIndexOf(' ');
          if (spaceIndex > 0) {
            final typePart = field.substring(0, spaceIndex).trim();
            final namePart = field.substring(spaceIndex + 1).trim();
            final resolvedType = _getTypeArgument(
              typePart,
              typeToUri: typeToUri,
              classTypeParams: classTypeParams,
              sourceFilePath: sourceFilePath,
            );
            return '$resolvedType $namePart';
          }
          // Fallback: just resolve as type
          return _getTypeArgument(
            field,
            typeToUri: typeToUri,
            classTypeParams: classTypeParams,
            sourceFilePath: sourceFilePath,
          );
        })
        .join(', ');
  }

  /// Checks if a type is a generic type parameter.
  bool _isGenericTypeParameter(String type) {
    // Single uppercase letter (T, R, E, K, V, S, etc.)
    if (type.length == 1 && type.toUpperCase() == type) {
      return true;
    }

    // Multi-character type parameters following common naming conventions:
    // - T1, T2, K2, V2, etc. (letter + digit)
    // - TValue, TKey, TResult, TElement, TItem, TOutput, TState, TData, etc.
    if (type.length >= 2) {
      // Pattern: single uppercase letter followed by digit(s) - T1, T2, K2, V2
      if (type[0].toUpperCase() == type[0] &&
          RegExp(r'^[A-Z][0-9]+$').hasMatch(type)) {
        return true;
      }

      // Pattern: T followed by PascalCase word - TValue, TKey, TOutput, etc.
      if (type.startsWith('T') &&
          type.length > 1 &&
          type[1].toUpperCase() == type[1] &&
          RegExp(r'^T[A-Z][a-zA-Z0-9]*$').hasMatch(type)) {
        return true;
      }
    }

    return false;
  }

  /// Checks if a type string contains a specific type parameter.
  /// Used to detect recursive type bounds like `T extends Comparable<T>`.
  bool _containsTypeParameter(String typeString, String typeParam) {
    // Simple check: look for the type parameter as a word boundary
    // This handles cases like "Comparable<T>" where T is the type parameter
    final pattern = RegExp(
      r'(?<![a-zA-Z_])' + RegExp.escape(typeParam) + r'(?![a-zA-Z_0-9])',
    );
    return pattern.hasMatch(typeString);
  }

  /// Checks if a function has any type parameters with recursive bounds.
  ///
  /// A recursive bound is one where the bound mentions the type parameter itself,
  /// like `T extends Comparable<T>`. These cannot be inferred at runtime and
  /// require special type dispatch handling.
  ///
  /// Returns the list of type parameter names that have recursive bounds.
  List<String> _getRecursiveBoundTypeParams(
    Map<String, String?> typeParameters,
  ) {
    final result = <String>[];
    for (final entry in typeParameters.entries) {
      final typeParam = entry.key;
      final bound = entry.value;
      if (bound != null && _containsTypeParameter(bound, typeParam)) {
        result.add(typeParam);
      }
    }
    return result;
  }

  /// Generates runtime type dispatch code for functions with recursive type bounds.
  ///
  /// For a function like `List<T> sortItems<T extends Comparable<T>>(List<T> items)`,
  /// generates:
  /// ```dart
  /// final items = positional[0] as List;
  /// if (items.isEmpty) return <dynamic>[];
  /// final first = items.first;
  /// if (first is int) return $pkg.sortItems<int>(items.cast<int>());
  /// if (first is String) return $pkg.sortItems<String>(items.cast<String>());
  /// // ... more types ...
  /// throw ArgumentError('sortItems: unsupported type ${first.runtimeType}');
  /// ```
  void _generateRecursiveBoundDispatch(
    StringBuffer buffer,
    GlobalFunctionInfo func,
    String prefixedFuncName,
    List<String> recursiveTypeParams,
    String indent,
  ) {
    // Print warning about recursive type bounds
    // ignore: avoid_print
    print(
      '  Warning: Function "${func.name}" has recursive type bounds '
      '(${recursiveTypeParams.join(', ')}). '
      'Runtime dispatch limited to: ${recursiveBoundTypes.map((t) => t.typeName).join(', ')}',
    );

    // Find the first parameter that uses the recursive type param
    // This is our "sample" to detect the runtime type
    ParameterInfo? sampleParam;
    String? sampleParamType;
    int sampleParamIndex = 0;

    for (var i = 0; i < func.parameters.length; i++) {
      final param = func.parameters[i];
      if (param.isNamed) continue;

      for (final typeParam in recursiveTypeParams) {
        if (_containsTypeParameter(param.type, typeParam)) {
          sampleParam = param;
          sampleParamType = param.type;
          sampleParamIndex = i;
          break;
        }
      }
      if (sampleParam != null) break;
    }

    if (sampleParam == null) {
      // No parameter uses the recursive type - fallback to dynamic
      buffer.writeln(
        '$indent// Warning: Recursive type bound but no sample parameter found',
      );
      buffer.writeln(
        '${indent}throw ArgumentError("${func.name}: Cannot infer type for recursive bound");',
      );
      return;
    }

    // Generate type dispatch based on the sample parameter
    final isListType = _isListType(sampleParamType!);

    if (isListType) {
      // For List<T>, check the element type
      buffer.writeln(
        '${indent}final sample = positional[$sampleParamIndex] as List;',
      );
      buffer.writeln('${indent}if (sample.isEmpty) return <dynamic>[];');
      buffer.writeln('${indent}final firstElem = sample.first;');

      for (final boundType in recursiveBoundTypes) {
        final typeName = boundType.prefixedTypeName;
        buffer.writeln('${indent}if (firstElem is $typeName) {');

        // Generate cast calls for all list parameters of the recursive type
        final castArgs = <String>[];
        var posIndex = 0;
        for (final p in func.parameters) {
          if (p.isNamed) {
            castArgs.add(
              '${p.name}: positional[$posIndex]',
            ); // Won't happen, but safety
          } else {
            if (_isListType(p.type) &&
                recursiveTypeParams.any(
                  (tp) => _containsTypeParameter(p.type, tp),
                )) {
              castArgs.add('(positional[$posIndex] as List).cast<$typeName>()');
            } else if (recursiveTypeParams.any(
              (tp) => _containsTypeParameter(p.type, tp),
            )) {
              castArgs.add('positional[$posIndex] as $typeName');
            } else {
              castArgs.add('positional[$posIndex]');
            }
            posIndex++;
          }
        }

        buffer.writeln(
          '$indent  return $prefixedFuncName<$typeName>(${castArgs.join(', ')});',
        );
        buffer.writeln('$indent}');
      }
    } else {
      // For single value T, check directly
      buffer.writeln('${indent}final sample = positional[$sampleParamIndex];');

      for (final boundType in recursiveBoundTypes) {
        final typeName = boundType.prefixedTypeName;
        buffer.writeln('${indent}if (sample is $typeName) {');

        // Generate cast calls for all parameters of the recursive type
        final castArgs = <String>[];
        var posIndex = 0;
        for (final p in func.parameters) {
          if (p.isNamed) {
            castArgs.add('${p.name}: positional[$posIndex]');
          } else {
            if (recursiveTypeParams.any(
              (tp) => _containsTypeParameter(p.type, tp),
            )) {
              castArgs.add('positional[$posIndex] as $typeName');
            } else {
              castArgs.add('positional[$posIndex]');
            }
            posIndex++;
          }
        }

        buffer.writeln(
          '$indent  return $prefixedFuncName<$typeName>(${castArgs.join(', ')});',
        );
        buffer.writeln('$indent}');
      }
    }

    // Fallback error
    final typesList = recursiveBoundTypes.map((t) => t.typeName).join(', ');
    buffer.writeln(
      "${indent}throw ArgumentError('${func.name}: Unsupported type for recursive bound. "
      "Supported types: $typesList. Got: \${sample.runtimeType}');",
    );
  }

  /// Extracts the base type from a generic type string.
  /// For "Comparable<T>", returns "Comparable".
  /// For "List<Map<K, V>>", returns "List".
  /// For non-generic types, returns the input unchanged.
  String _extractBaseType(String type) {
    final ltIndex = type.indexOf('<');
    if (ltIndex > 0) {
      return type.substring(0, ltIndex);
    }
    return type;
  }

  /// Checks if a type is a List type (e.g., List<String>, List<int>).
  bool _isListType(String type) {
    final baseType = type.endsWith('?')
        ? type.substring(0, type.length - 1)
        : type;
    // GEN-075: Also match Iterable<> — D4rt sends lists for both
    return (baseType.startsWith('List<') || baseType.startsWith('Iterable<')) &&
        baseType.endsWith('>');
  }

  /// GEN-096 (D8g): pick the correct D4 coerce method + generic argument
  /// for a list parameter. When the resolved [elementType] is itself a
  /// `List<X>` (or `List<X>?`) — i.e. the parameter is `List<List<X>>` —
  /// emit `D4.coerceNestedList<X>` instead of `D4.coerceList<List<X>>`.
  /// `coerceList<List<X>>` cannot synthesize the typed inner `List<X>` at
  /// runtime: the inner row arrives as `List<dynamic>` and the
  /// `as List<X>` cast fails, e.g. for `TwoDimensionalChildListDelegate`'s
  /// `children: List<List<Widget>>` parameter.
  ({String method, String generic}) _pickListCoerce(
    String elementType,
    bool isNullable,
  ) {
    var inner = elementType;
    if (inner.endsWith('?')) {
      inner = inner.substring(0, inner.length - 1);
    }
    if (inner.startsWith('List<') && inner.endsWith('>')) {
      final innerInner = inner.substring(5, inner.length - 1);
      return (
        method: isNullable
            ? 'D4.coerceNestedListOrNull'
            : 'D4.coerceNestedList',
        generic: innerInner,
      );
    }
    return (
      method: isNullable ? 'D4.coerceListOrNull' : 'D4.coerceList',
      generic: elementType,
    );
  }

  /// RC-7: Emit a parameter-aware enum method adapter with proper collection
  /// coercion.
  ///
  /// Instead of `Function.apply(t.method, positional, named)`, this emits
  /// explicit parameter extraction with `D4.coerceSet<T>()`,
  /// `D4.coerceList<T>()`, etc. for collection-typed parameters.
  void _emitEnumMethodWithCoercion(
    StringBuffer buffer,
    String methodName,
    EnumMethodDetail methodDetail,
    String sourceFile,
  ) {
    final positionalParams =
        methodDetail.parameters.where((p) => !p.isNamed).toList();
    final namedParams =
        methodDetail.parameters.where((p) => p.isNamed).toList();

    // Emit positional parameter extraction with coercion
    final posArgNames = <String>[];
    for (int i = 0; i < positionalParams.length; i++) {
      final param = positionalParams[i];
      final localName = param.name.isNotEmpty ? param.name : 'p$i';
      final isNullable = param.type.endsWith('?');

      if (_isSetType(param.type)) {
        final elementType = _getSetElementType(
          param.type,
          typeToUri: param.typeToUri,
          sourceFilePath: sourceFile,
        );
        final coerceMethod =
            isNullable ? 'D4.coerceSetOrNull' : 'D4.coerceSet';
        if (param.isRequired) {
          buffer.writeln(
            "            final $localName = $coerceMethod<$elementType>(positional[$i], '${param.name}');",
          );
        } else {
          buffer.writeln(
            "            final $localName = positional.length > $i ? $coerceMethod<$elementType>(positional[$i], '${param.name}') : ${isNullable ? 'null' : '<$elementType>{}'};",
          );
        }
      } else if (_isListType(param.type)) {
        final elementType = _getListElementType(
          param.type,
          typeToUri: param.typeToUri,
          sourceFilePath: sourceFile,
        );
        final coerceMethod =
            isNullable ? 'D4.coerceListOrNull' : 'D4.coerceList';
        if (param.isRequired) {
          buffer.writeln(
            "            final $localName = $coerceMethod<$elementType>(positional[$i], '${param.name}');",
          );
        } else {
          buffer.writeln(
            "            final $localName = positional.length > $i ? $coerceMethod<$elementType>(positional[$i], '${param.name}') : ${isNullable ? 'null' : '<$elementType>[]'};",
          );
        }
      } else {
        // Non-collection parameter — pass through with optional bounds check
        if (param.isRequired) {
          buffer.writeln(
            "            final $localName = positional[$i];",
          );
        } else {
          buffer.writeln(
            "            final $localName = positional.length > $i ? positional[$i] : null;",
          );
        }
      }
      posArgNames.add(localName);
    }

    // Emit named parameter extraction with coercion
    final namedArgExprs = <String>[];
    for (final param in namedParams) {
      final localName = param.name;
      final isNullable = param.type.endsWith('?');

      if (_isSetType(param.type)) {
        final elementType = _getSetElementType(
          param.type,
          typeToUri: param.typeToUri,
          sourceFilePath: sourceFile,
        );
        final coerceMethod =
            isNullable ? 'D4.coerceSetOrNull' : 'D4.coerceSet';
        buffer.writeln(
          "            final $localName = named.containsKey('${param.name}') ? $coerceMethod<$elementType>(named['${param.name}'], '${param.name}') : ${isNullable || !param.isRequired ? 'null' : '<$elementType>{}'};",
        );
      } else if (_isListType(param.type)) {
        final elementType = _getListElementType(
          param.type,
          typeToUri: param.typeToUri,
          sourceFilePath: sourceFile,
        );
        final coerceMethod =
            isNullable ? 'D4.coerceListOrNull' : 'D4.coerceList';
        buffer.writeln(
          "            final $localName = named.containsKey('${param.name}') ? $coerceMethod<$elementType>(named['${param.name}'], '${param.name}') : ${isNullable || !param.isRequired ? 'null' : '<$elementType>[]'};",
        );
      } else {
        // Non-collection named parameter — pass through
        buffer.writeln(
          "            final $localName = named['${param.name}'];",
        );
      }
      namedArgExprs.add('$localName: $localName');
    }

    // Emit the method call with coerced arguments
    final allArgs = [...posArgNames, ...namedArgExprs].join(', ');
    buffer.writeln("            return t.$methodName($allArgs);");
  }

  /// Checks if a type is a Map type (e.g., Map<String, int>).
  bool _isMapType(String type) {
    final baseType = type.endsWith('?')
        ? type.substring(0, type.length - 1)
        : type;
    return baseType.startsWith('Map<') && baseType.endsWith('>');
  }

  /// ENG-001: Checks if a type is a Set type (e.g., Set<String>, Set<WidgetState>).
  bool _isSetType(String type) {
    final baseType = type.endsWith('?')
        ? type.substring(0, type.length - 1)
        : type;
    return baseType.startsWith('Set<') && baseType.endsWith('>');
  }

  /// ENG-001: Extracts the element type from a Set type (e.g., Set<String> -> String).
  String _getSetElementType(
    String setType, {
    Map<String, String> typeToUri = const {},
    Map<String, String?> classTypeParams = const {},
    String? sourceFilePath,
  }) {
    var baseType = setType.endsWith('?')
        ? setType.substring(0, setType.length - 1)
        : setType;
    final elementType = baseType.substring(4, baseType.length - 1);

    // Check if element type is a known function type alias
    if (_isFunctionTypeName(elementType.replaceAll('?', ''))) {
      return 'dynamic';
    }

    return _getTypeArgument(
      elementType,
      typeToUri: typeToUri,
      classTypeParams: classTypeParams,
      sourceFilePath: sourceFilePath,
    );
  }

  /// Extracts the element type from a List type (e.g., List<String> -> String).
  /// If the element type is a function type alias, returns 'dynamic'.
  String _getListElementType(
    String listType, {
    Map<String, String> typeToUri = const {},
    Map<String, String?> classTypeParams = const {},
    String? sourceFilePath,
  }) {
    var baseType = listType.endsWith('?')
        ? listType.substring(0, listType.length - 1)
        : listType;
    // GEN-075: Handle both List<> and Iterable<> prefixes
    final prefixLen = baseType.startsWith('Iterable<') ? 9 : 5;
    final elementType = baseType.substring(prefixLen, baseType.length - 1);

    // Check if element type is a known function type alias
    // These can't be passed from D4rt, so we use dynamic
    if (_isFunctionTypeName(elementType.replaceAll('?', ''))) {
      return 'dynamic';
    }

    return _getTypeArgument(
      elementType,
      typeToUri: typeToUri,
      classTypeParams: classTypeParams,
      sourceFilePath: sourceFilePath,
    );
  }

  /// Extracts the raw element type from a List/Iterable type without any prefixing.
  /// Used to check if the element is a function typedef.
  String _extractListElementType(String listType) {
    var baseType = listType.endsWith('?')
        ? listType.substring(0, listType.length - 1)
        : listType;
    // GEN-075: Handle both List<> and Iterable<> prefixes
    final prefixLen = baseType.startsWith('Iterable<') ? 9 : 5;
    return baseType
        .substring(prefixLen, baseType.length - 1)
        .replaceAll('?', '');
  }

  /// Known function typedef names that can't be bridged.
  /// These are common function type aliases from Flutter, Dart SDK, and D4rt.
  static const _knownFunctionTypeAliases = {
    // D4rt/tom_d4rt types
    'BridgeRegistrar', // void Function(D4rt)
    'D4rtEvaluator', // Future<dynamic> Function(...)
    'NativeFunctionImpl', // Object? Function(...)
    // DCli types
    'LineAction', // void Function(String line)
    'CancelableLineAction', // bool Function(String line)
    // Dart core types
    'Comparator', // int Function(T, T)
    // Flutter types
    'VoidCallback', // void Function()
    'ValueChanged', // void Function(T)
    'ValueGetter', // T Function()
    'ValueSetter', // void Function(T)
    'WidgetBuilder', // Widget Function(BuildContext)
    'TransitionBuilder', // Widget Function(BuildContext, Widget?)
    'IndexedWidgetBuilder', // Widget Function(BuildContext, int)
    'NullableIndexedWidgetBuilder', // Widget? Function(BuildContext, int)
    'RouteFactory', // Route<dynamic>? Function(RouteSettings)
    'GenerateAppTitle', // String Function(BuildContext)
    'PageRouteFactory', // PageRoute<T> Function(RouteSettings, WidgetBuilder)
    'PopupMenuItemBuilder', // List<PopupMenuEntry<T>> Function(BuildContext)
    'SelectableDayPredicate', // bool Function(DateTime)
    'FormFieldValidator', // String? Function(T?)
    'FormFieldSetter', // void Function(T?)
    'FormFieldBuilder', // Widget Function(FormFieldState<T>)
    'InputCounterWidgetBuilder', // Widget? Function(BuildContext, {required int currentLength, required bool isFocused, required int? maxLength})
    'ScrollableWidgetBuilder', // Widget Function(BuildContext, ScrollController)
    'StatefulWidgetBuilder', // Widget Function(BuildContext, StateSetter)
    'LayoutWidgetBuilder', // Widget Function(BuildContext, BoxConstraints)
    'OrientationWidgetBuilder', // Widget Function(BuildContext, Orientation)
    'AnimatedTransitionBuilder', // Widget Function(Widget, Animation<double>)
    'CreateRectTween', // Tween<Rect?>? Function(Rect?, Rect?)
    'CreatePlatformViewCallback', // PlatformViewCreatedCallback
    'GestureTapCallback', // void Function()
    'GestureTapDownCallback', // void Function(TapDownDetails)
    'GestureTapUpCallback', // void Function(TapUpDetails)
    'GestureTapCancelCallback', // void Function()
    'GestureLongPressCallback', // void Function()
    'GestureDragCallback', // void Function(...)
    'DragUpdateCallback', // void Function(DragUpdateDetails)
    'DragEndCallback', // void Function(DragEndDetails)
    'PointerEnterEventListener', // void Function(PointerEnterEvent)
    'PointerExitEventListener', // void Function(PointerExitEvent)
    'PointerHoverEventListener', // void Function(PointerHoverEvent)
    // async package types
    'ErrorHandler', // void Function(Object error)
    'ZoneBinaryCallback', // R Function(T1, T2)
    'ZoneCallback', // R Function()
    'ZoneUnaryCallback', // R Function(T)
    'HandleUncaughtErrorHandler', // void Function(Zone, ZoneDelegate, Zone, Object, StackTrace)
    'RegisterCallback', // ZoneCallback<R> Function(Zone, ZoneDelegate, Zone, R Function())
    'RunHandler', // R Function(Zone, ZoneDelegate, Zone, R Function())
  };

  /// Checks if a type name is a known function typedef.
  bool _isFunctionTypeName(String typeName) {
    // Check known function type aliases
    if (_knownFunctionTypeAliases.contains(typeName)) {
      return true;
    }
    // Check for prefixed versions (e.g., core.LineAction, $pkg.VoidCallback)
    final dotIndex = typeName.lastIndexOf('.');
    if (dotIndex != -1) {
      final unprefixedName = typeName.substring(dotIndex + 1);
      if (_knownFunctionTypeAliases.contains(unprefixedName)) {
        return true;
      }
    }
    // Also check for inline function types
    if (typeName.contains('Function(') || typeName.contains(') Function')) {
      return true;
    }
    return false;
  }

  /// Resolves an inline function type by prefixing types within it.
  /// For example, `void Function(TomObservable observable)` becomes
  /// `void Function($pkg.TomObservable observable)`.
  String _resolveInlineFunctionType(
    String funcType, {
    Map<String, String> typeToUri = const {},
    Map<String, String?> classTypeParams = const {},
    String? sourceFilePath,
  }) {
    // Parse the function type to get its components
    final funcInfo = _parseFunctionType(funcType);
    if (funcInfo == null) {
      // Couldn't parse - return as-is
      return funcType;
    }

    // Resolve return type
    final resolvedReturnType = _getTypeArgument(
      funcInfo.returnType,
      typeToUri: typeToUri,
      classTypeParams: classTypeParams,
      sourceFilePath: sourceFilePath,
    );
    final returnTypeStr = funcInfo.returnTypeNullable
        ? '$resolvedReturnType?'
        : resolvedReturnType;

    // Resolve positional parameter types
    final resolvedPositional = <String>[];
    for (final paramType in funcInfo.positionalParamTypes) {
      final resolved = paramType.contains('Function(')
          ? _resolveInlineFunctionType(
              paramType,
              typeToUri: typeToUri,
              classTypeParams: classTypeParams,
              sourceFilePath: sourceFilePath,
            )
          : _getTypeArgument(
              paramType,
              typeToUri: typeToUri,
              classTypeParams: classTypeParams,
              sourceFilePath: sourceFilePath,
            );
      resolvedPositional.add(resolved);
    }

    // Resolve named parameter types
    final resolvedNamed = <String>[];
    for (final entry in funcInfo.namedParamTypes.entries) {
      final namedType = entry.value;
      final resolved = namedType.contains('Function(')
          ? _resolveInlineFunctionType(
              namedType,
              typeToUri: typeToUri,
              classTypeParams: classTypeParams,
              sourceFilePath: sourceFilePath,
            )
          : _getTypeArgument(
              namedType,
              typeToUri: typeToUri,
              classTypeParams: classTypeParams,
              sourceFilePath: sourceFilePath,
            );
      final isRequired = funcInfo.namedParamRequired[entry.key] ?? false;
      if (isRequired) {
        resolvedNamed.add('required $resolved ${entry.key}');
      } else {
        resolvedNamed.add('$resolved ${entry.key}');
      }
    }

    // Build the resolved function type string
    final params = StringBuffer();
    if (resolvedPositional.isNotEmpty) {
      params.write(resolvedPositional.join(', '));
    }
    if (resolvedNamed.isNotEmpty) {
      if (resolvedPositional.isNotEmpty) {
        params.write(', ');
      }
      params.write('{${resolvedNamed.join(', ')}}');
    }

    return '$returnTypeStr Function($params)';
  }

  /// Parses a function type string and extracts its signature.
  /// Returns null if the type cannot be parsed.
  ///
  /// Handles patterns like:
  /// - `void Function()`
  /// - `String Function(int, String)`
  /// - `void Function(int value)?`
  /// - `Widget Function(T)`
  /// - `String? Function(String)?`
  FunctionTypeInfo? _parseFunctionType(String typeStr) {
    // Remove trailing nullable marker for the function type itself
    var funcType = typeStr.trim();
    if (funcType.endsWith('?')) {
      funcType = funcType.substring(0, funcType.length - 1).trim();
    }

    // Check for inline function type pattern:
    // ReturnType Function(Params)
    // ReturnType Function<T>(Params)
    final funcMatch = RegExp(
      r'^(.+?)\s+Function(?:<([^>]+)>)?\((.*)\)$',
    ).firstMatch(funcType);
    if (funcMatch == null) {
      // Check known typedef aliases
      final aliasInfo =
          _knownFunctionTypeAliasInfo[typeStr.replaceAll('?', '')];
      if (aliasInfo != null) {
        return aliasInfo;
      }
      return null;
    }

    final returnTypeStr = funcMatch.group(1)!.trim();
    final genericTypeParamsStr = funcMatch.group(2)?.trim();
    final paramsStr = funcMatch.group(3)!.trim();

    // Parse return type
    var returnType = returnTypeStr;
    var returnTypeNullable = false;
    if (returnType.endsWith('?')) {
      returnTypeNullable = true;
      returnType = returnType.substring(0, returnType.length - 1);
    }

    // Parse parameters
    final positionalParamTypes = <String>[];
    final namedParamTypes = <String, String>{};
    final namedParamRequired = <String, bool>{};
    final genericTypeParameters = <String, String?>{};

    if (genericTypeParamsStr != null && genericTypeParamsStr.isNotEmpty) {
      final genericParams = _splitFunctionParams(genericTypeParamsStr);
      for (final rawParam in genericParams) {
        final param = rawParam.trim();
        if (param.isEmpty) continue;
        final extendsIndex = param.indexOf(' extends ');
        if (extendsIndex == -1) {
          genericTypeParameters[param] = null;
        } else {
          final name = param.substring(0, extendsIndex).trim();
          final bound = param.substring(extendsIndex + 9).trim();
          genericTypeParameters[name] = bound;
        }
      }
    }

    if (paramsStr.isNotEmpty) {
      // Split parameters, handling nested generics
      final params = _splitFunctionParams(paramsStr, trackCurlyBraces: false);
      var inNamedSection = false;

      for (var param in params) {
        param = param.trim();
        if (param.isEmpty) continue;

        // Check for named parameters section
        if (param.startsWith('{')) {
          inNamedSection = true;
          param = param.substring(1).trim();
        }
        if (param.endsWith('}')) {
          param = param.substring(0, param.length - 1).trim();
        }

        if (inNamedSection) {
          // Named parameter: "required Type name" or "Type name" or "Type? name"
          final isRequired = param.startsWith('required ');
          if (isRequired) {
            param = param.substring(9).trim();
          }
          // Split "Type name" - last word is name, rest is type
          final parts = param.split(RegExp(r'\s+'));
          if (parts.length >= 2) {
            final name = parts.last;
            final type = parts.sublist(0, parts.length - 1).join(' ');
            namedParamTypes[name] = type;
            namedParamRequired[name] = isRequired;
          }
        } else {
          // Positional parameter: "Type" or "Type name"
          // We only need the type, so take everything except the last word if it looks like a name
          final normalizedParam = param.replaceAll('?', '').trim();
          if (_isFunctionTypeName(normalizedParam)) {
            positionalParamTypes.add(param);
            continue;
          }
          final parts = param.split(RegExp(r'\s+'));
          if (parts.length == 1) {
            positionalParamTypes.add(parts[0]);
          } else {
            // Last part might be a name (no < or > and not a keyword)
            final lastPart = parts.last;
            if (!lastPart.contains('<') &&
                !lastPart.contains('>') &&
                !_isTypeKeyword(lastPart)) {
              positionalParamTypes.add(
                parts.sublist(0, parts.length - 1).join(' '),
              );
            } else {
              positionalParamTypes.add(param);
            }
          }
        }
      }
    }

    return FunctionTypeInfo(
      returnType: returnType,
      returnTypeNullable: returnTypeNullable,
      positionalParamTypes: positionalParamTypes,
      namedParamTypes: namedParamTypes,
      namedParamRequired: namedParamRequired,
      genericTypeParameters: genericTypeParameters,
    );
  }

  /// Checks if a string is a type keyword (not a parameter name)
  bool _isTypeKeyword(String s) {
    return s == 'dynamic' ||
        s == 'void' ||
        s == 'Object' ||
        s == 'int' ||
        s == 'double' ||
        s == 'String' ||
        s == 'bool' ||
        s == 'num' ||
        s == 'Function' ||
        s == 'Never';
  }

  /// Splits function parameters string handling nested generics
  List<String> _splitFunctionParams(
    String paramsStr, {
    bool trackCurlyBraces = true,
  }) {
    final result = <String>[];
    var depth = 0;
    var current = StringBuffer();

    for (var i = 0; i < paramsStr.length; i++) {
      final char = paramsStr[i];
      if (char == '<' || char == '(' || (trackCurlyBraces && char == '{')) {
        depth++;
        current.write(char);
      } else if (char == '>' ||
          char == ')' ||
          (trackCurlyBraces && char == '}')) {
        depth--;
        current.write(char);
      } else if (char == ',' && depth == 0) {
        result.add(current.toString());
        current = StringBuffer();
      } else {
        current.write(char);
      }
    }
    if (current.isNotEmpty) {
      result.add(current.toString());
    }
    return result;
  }

  /// Known function typedef info for common aliases
  static final _knownFunctionTypeAliasInfo = <String, FunctionTypeInfo>{
    'VoidCallback': FunctionTypeInfo(returnType: 'void'),
    'ValueChanged': FunctionTypeInfo(
      returnType: 'void',
      positionalParamTypes: ['T'],
    ),
    'ValueGetter': FunctionTypeInfo(returnType: 'T'),
    'ValueSetter': FunctionTypeInfo(
      returnType: 'void',
      positionalParamTypes: ['T'],
    ),
    // DCli function types
    'LineAction': FunctionTypeInfo(
      returnType: 'void',
      positionalParamTypes: ['String'],
    ),
    'CancelableLineAction': FunctionTypeInfo(
      returnType: 'bool',
      positionalParamTypes: ['String'],
    ),
  };

  /// Extracts FunctionTypeInfo from a resolved DartType.
  /// Returns null if the type is not a function type.
  ///
  /// ENG-010: Now handles typedef aliases that resolve to function types
  /// (e.g., `GestureCallback` → `void Function(GestureDetails)`).
  static FunctionTypeInfo? extractFunctionTypeInfoFromDartType(
    DartType dartType,
  ) {
    // ENG-010: Unwrap nullable types to check the base type.
    // E.g., `GestureCallback?` → `GestureCallback` → `void Function(GestureDetails)`
    var effectiveType = dartType;
    if (effectiveType.nullabilitySuffix == NullabilitySuffix.question) {
      // Get the non-nullable version by stripping '?'
      // For TypeAliasType, we need to check the aliased type
      final element = effectiveType.element;
      if (element is TypeAliasElement) {
        final aliasedType = element.aliasedType;
        if (aliasedType is FunctionType) {
          effectiveType = aliasedType;
        }
      }
    }

    // ENG-010: Handle typedef aliases that resolve to function types.
    // E.g., `typedef GestureCallback = void Function(GestureDetails details);`
    if (effectiveType is! FunctionType) {
      final element = effectiveType.element;
      if (element is TypeAliasElement) {
        final aliasedType = element.aliasedType;
        if (aliasedType is FunctionType) {
          effectiveType = aliasedType;
        }
      }
    }

    // Handle type aliases that resolve to function types
    if (effectiveType is FunctionType) {
      final returnTypeStr = effectiveType.returnType.getDisplayString();
      final returnTypeNullable = returnTypeStr.endsWith('?');
      final returnType = returnTypeNullable
          ? returnTypeStr.substring(0, returnTypeStr.length - 1)
          : returnTypeStr;

      final positionalParamTypes = <String>[];
      final namedParamTypes = <String, String>{};
      final namedParamRequired = <String, bool>{};
      final genericTypeParameters = <String, String?>{};
      final functionDisplay = effectiveType.getDisplayString();
      final genericMatch = RegExp(
        r'Function<([^>]+)>\(',
      ).firstMatch(functionDisplay);
      if (genericMatch != null) {
        final genericParams = genericMatch
            .group(1)!
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty);
        for (final param in genericParams) {
          final extendsIndex = param.indexOf(' extends ');
          if (extendsIndex == -1) {
            genericTypeParameters[param] = null;
          } else {
            final name = param.substring(0, extendsIndex).trim();
            final bound = param.substring(extendsIndex + 9).trim();
            genericTypeParameters[name] = bound;
          }
        }
      }

      for (final param in effectiveType.formalParameters) {
        final paramType = param.type.getDisplayString();
        final paramName = param.name;
        if (param.isNamed && paramName != null) {
          namedParamTypes[paramName] = paramType;
          namedParamRequired[paramName] = param.isRequired;
        } else {
          positionalParamTypes.add(paramType);
        }
      }

      return FunctionTypeInfo(
        returnType: returnType,
        returnTypeNullable: returnTypeNullable,
        positionalParamTypes: positionalParamTypes,
        namedParamTypes: namedParamTypes,
        namedParamRequired: namedParamRequired,
        genericTypeParameters: genericTypeParameters,
      );
    }

    return null;
  }

  /// Returns a default literal value for a non-nullable Dart type,
  /// or null if no safe default can be determined.
  ///
  /// Used by [_generateFunctionWrapper] (GEN-063) to provide default values
  /// for non-nullable, non-required named parameters in generated closures.
  static String? _defaultLiteralForType(String type) {
    // Strip any import prefix (e.g., $package_1.bool -> bool)
    final base = type.contains('.') ? type.split('.').last : type;
    return switch (base) {
      'bool' => 'false',
      'int' => '0',
      'double' => '0.0',
      'num' => '0',
      'String' => "''",
      _ => null,
    };
  }

  /// Returns `true` when [castType] is a primitive/built-in scalar that does
  /// not need to be routed through `D4.extractBridgedArg` (the GEN-081b
  /// interface-proxy path). Primitives are always native Dart values when a
  /// callback returns them, so a plain `as <Type>` cast is correct and matches
  /// the legacy emission shape that downstream tests assert on
  /// (`as bool`, `as String`, …).
  ///
  /// Recognised primitives: `bool`, `int`, `double`, `num`, `String`, plus
  /// their nullable variants. Bare `Object` / `Object?` / `dynamic` are
  /// already handled by the `skipCast` and `castCallbackResult` branches
  /// above and are not part of this list.
  static bool _isPrimitiveCastType(String castType) {
    final stripped = castType.endsWith('?')
        ? castType.substring(0, castType.length - 1)
        : castType;
    const primitives = {'bool', 'int', 'double', 'num', 'String'};
    return primitives.contains(stripped);
  }

  /// Generates a wrapper that converts an InterpretedFunction to a native function.
  ///
  /// Example output for `void Function(int, String)`:
  /// ```dart
  /// (int p0, String p1) {
  ///   (callback as InterpretedFunction).call(visitor, [p0, p1]);
  /// }
  /// ```
  ///
  /// Example output for `String Function(int)?`:
  /// ```dart
  /// callback == null ? null : (int p0) {
  ///   return (callback as InterpretedFunction).call(visitor, [p0]) as String;
  /// }
  /// ```
  String _generateFunctionWrapper({
    required String callbackVarName,
    required FunctionTypeInfo funcInfo,
    required bool isNullable,
    String visitorExpr = 'visitor!',
    Map<String, String> typeToUri = const {},
    Map<String, String?> classTypeParams = const {},
    String? sourceFilePath,
  }) {
    final scopedTypeParams = <String, String?>{
      ...classTypeParams,
      for (final entry in funcInfo.genericTypeParameters.entries)
        entry.key: _functionGenericParamSentinel,
    };

    // Generate parameter list for the wrapper function
    final paramList = <String>[];
    final argList = <String>[];

    for (var i = 0; i < funcInfo.positionalParamTypes.length; i++) {
      final rawParamType = funcInfo.positionalParamTypes[i];
      // Prefix the parameter type using _getTypeArgument
      var paramType = _getTypeArgument(
        rawParamType,
        typeToUri: typeToUri,
        classTypeParams: scopedTypeParams,
        sourceFilePath: sourceFilePath,
      );
      // GEN-062 fix: When a callback parameter is itself a function type with
      // unresolved types (becomes Function(dynamic)), use just 'Function' instead.
      // This avoids contravariance issues: Function(dynamic) is NOT compatible
      // with Function(SpecificType), but Function is compatible with all function types.
      if (paramType.contains('Function(') && paramType.contains('dynamic')) {
        paramType = 'Function';
      }
      final paramName = 'p$i';
      paramList.add('$paramType $paramName');
      final normalizedParamType = paramType.trim();
      final normalizedRawParamType = rawParamType.trim();
      if (normalizedParamType == 'void' || normalizedRawParamType == 'void') {
        argList.add('null');
      } else {
        argList.add(paramName);
      }
    }

    // Handle named parameters if any
    if (funcInfo.namedParamTypes.isNotEmpty) {
      final namedParams = <String>[];
      for (final entry in funcInfo.namedParamTypes.entries) {
        final isRequired = funcInfo.namedParamRequired[entry.key] ?? false;
        // Prefix the parameter type using _getTypeArgument
        final paramType = _getTypeArgument(
          entry.value,
          typeToUri: typeToUri,
          classTypeParams: scopedTypeParams,
          sourceFilePath: sourceFilePath,
        );
        // GEN-063 fix: Non-nullable, non-required named params in closures
        // need either a default value or the `required` keyword.
        // Without this, the generated closure is invalid Dart code.
        if (isRequired) {
          namedParams.add('required $paramType ${entry.key}');
        } else if (paramType.endsWith('?')) {
          // Nullable types can be optional without a default (defaults to null)
          namedParams.add('$paramType ${entry.key}');
        } else {
          // Non-nullable, non-required: must provide a type-appropriate default
          final defaultValue = _defaultLiteralForType(paramType);
          if (defaultValue != null) {
            namedParams.add('$paramType ${entry.key} = $defaultValue');
          } else {
            // Unknown non-nullable type: fall back to required (safest)
            namedParams.add('required $paramType ${entry.key}');
          }
        }
      }
      paramList.add('{${namedParams.join(', ')}}');
      // Named args need to be passed as a map
    }

    final paramsStr = paramList.join(', ');
    final argsStr = argList.isNotEmpty ? '[${argList.join(', ')}]' : '[]';

    // Generate named args map if there are named parameters
    String namedArgsStr = '{}';
    if (funcInfo.namedParamTypes.isNotEmpty) {
      final namedArgEntries = funcInfo.namedParamTypes.keys
          .map((name) => "'$name': $name")
          .join(', ');
      namedArgsStr = '{$namedArgEntries}';
    }

    // Build the call expression using D4.callInterpreterCallback
    // This handles both InterpretedFunction and NativeFunction (e.g., print)
    String callExpr;
    if (funcInfo.namedParamTypes.isEmpty) {
      callExpr =
          'D4.callInterpreterCallback($visitorExpr, $callbackVarName, $argsStr)';
    } else {
      callExpr =
          'D4.callInterpreterCallback($visitorExpr, $callbackVarName, $argsStr, $namedArgsStr)';
    }

    // Build the wrapper body - prefix return type
    final prefixedReturnType = _getTypeArgument(
      funcInfo.returnType,
      typeToUri: typeToUri,
      classTypeParams: scopedTypeParams,
      sourceFilePath: sourceFilePath,
    );

    String genericTypeParamsDecl = '';
    if (funcInfo.genericTypeParameters.isNotEmpty) {
      final genericDeclParts = funcInfo.genericTypeParameters.entries
          .map((entry) {
            final bound = entry.value;
            if (bound == null || bound.isEmpty) {
              return entry.key;
            }
            final resolvedBound = _getTypeArgument(
              bound,
              typeToUri: typeToUri,
              classTypeParams: scopedTypeParams,
              sourceFilePath: sourceFilePath,
            );
            return '${entry.key} extends $resolvedBound';
          })
          .join(', ');
      genericTypeParamsDecl = '<$genericDeclParts>';
    }
    String wrapperBody;
    String? wrapperReturnCastType;
    if (funcInfo.isVoid) {
      // B.14: when cooperative yielding is on, emit the void callback as an
      // `async` closure (see the `async` modifier at wrapper assembly below)
      // that yields 1 ms after the call so the embedder can pump input/frames
      // during long synchronous interpreted runs. Off (default) ⇒ the
      // historical synchronous wrapper (byte-identical output).
      wrapperBody = yieldVoidCallbacks
          ? '{ $callExpr; await Future.delayed(const Duration(milliseconds: 1)); }'
          : '{ $callExpr; }';
    } else {
      // GEN-061 fix: FutureOr<dynamic> is not assignable to FutureOr<T> where T is bounded.
      // When the return type is FutureOr<dynamic> (from unresolved type parameter),
      // use FutureOr<Object?> which is assignable to FutureOr<T> where T defaults
      // to Object? (the default upper bound for unbounded type parameters in Dart).
      //
      // C11 fix: previously this used `FutureOr<Object>` (non-nullable). That
      // rejected void-returning callbacks like `sf.then((v) { ... })` because
      // the void return surfaces as `null` at the boundary, and
      // `extractBridgedArg<FutureOr<Object>>` throws on null. The nullable
      // variant `FutureOr<Object?>` combined with the `castCallbackResult`
      // routing below accepts null safely.
      var effectiveReturnType = prefixedReturnType;
      if (prefixedReturnType == 'FutureOr<dynamic>') {
        effectiveReturnType = 'FutureOr<Object?>';
      }
      final nullableReturnType = _makeNullable(effectiveReturnType);
      final castType = funcInfo.returnTypeNullable
          ? nullableReturnType
          : effectiveReturnType;
      final normalizedReturnType = funcInfo.returnType.replaceAll(' ', '');
      wrapperReturnCastType = castType;

      // ENG-011: Use castCallbackResult for generic returns (when type is dynamic or Object).
      // This handles null safely when the callback's return type is a type parameter
      // that could be nullable or non-nullable depending on how it's instantiated.
      // C11: Also route `FutureOr<Object?>` through castCallbackResult so that
      // void-returning callbacks (whose result surfaces as null) are accepted.
      final isDynamicReturn =
          normalizedReturnType == 'dynamic' ||
          castType == 'dynamic' ||
          castType == 'Object?' ||
          castType == 'FutureOr<Object?>';

      if (isDynamicReturn) {
        // Use castCallbackResult to handle null safely for generic returns
        wrapperBody = '{ return D4.castCallbackResult<$castType>($callExpr); }';
      } else {
        final skipCast =
            castType == 'Object?' &&
            (normalizedReturnType == 'dynamic' ||
                normalizedReturnType == 'Object' ||
                normalizedReturnType == 'Object?');
        if (skipCast) {
          wrapperBody = '{ return $callExpr; }';
        } else {
          // GEN-094: For `List<X>` return types, route through
          // `D4.coerceList<X>` rather than `extractBridgedArg<List<X>>`.
          // The interpreter produces `List<Object?>` for script-side
          // collection-literal returns (`<Widget>[...]` loses its
          // type argument in the bundle format), and coerceList is the
          // path that unwraps each element and preserves type via per-
          // element cast. Without this, callbacks with typed-List returns
          // (e.g., `headerSliverBuilder: (...) => <Widget>[...]` on
          // NestedScrollView) fail with `List<Object?> is not List<Widget>`.
          if (castType.startsWith('List<') && castType.endsWith('>')) {
            final inner =
                castType.substring('List<'.length, castType.length - 1);
            wrapperBody =
                "{ return D4.coerceList<$inner>($callExpr, 'callback'); }";
          } else if (castType.startsWith('Future<') &&
              (castType.endsWith('>') || castType.endsWith('>?'))) {
            // GEN-???: For `Future<X>` callback returns from interpreted
            // async functions, the interpreter produces a `Future<Object?>`
            // (the completer-backed future in `callable.dart` uses
            // `Completer<Object?>()`). A synchronous `as Future<X>` cast
            // on that value fails reified-generics checks at runtime,
            // which Flutter then silently catches inside the dismiss /
            // navigation pipelines — so the async callback never
            // "completes" from Flutter's perspective even though the
            // script ran to completion.
            //
            // Fix: route the result through `Future.value(...)` and
            // `.then((v) => v as $inner)` so the cast happens at value
            // resolution time on the unboxed result, producing a
            // properly-typed `Future<X>` chain that Flutter can await.
            //
            // Applies to both nullable (`Future<X>?`) and non-nullable
            // (`Future<X>`) outer types. For nullable, a null callback
            // result short-circuits to `null` instead of materialising a
            // dummy Future — semantically matches "no future, don't wait".
            final isOuterNullable = castType.endsWith('?');
            final stripped = isOuterNullable
                ? castType.substring(0, castType.length - 1)
                : castType;
            final inner = stripped.substring(
                'Future<'.length, stripped.length - 1);
            // `Future<void>` is special — `v as void` is not valid Dart.
            // The result of the callback is intentionally discarded; we
            // only need a Future that resolves once the script-side
            // async work completes. `Future.value(...)` of an Object?
            // is directly assignable to `Future<void>`.
            final isVoidInner = inner.trim() == 'void';
            if (isOuterNullable) {
              wrapperBody = isVoidInner
                  ? "{ final r = $callExpr; return r == null ? null : Future.value(r); }"
                  : "{ final r = $callExpr; return r == null ? null : Future.value(r).then((v) => v as $inner); }";
            } else {
              wrapperBody = isVoidInner
                  ? "{ return Future.value($callExpr); }"
                  : "{ return Future.value($callExpr).then((v) => v as $inner); }";
            }
          } else if (_isPrimitiveCastType(castType)) {
            // Cluster CB: Primitive return types (bool, int, double, num,
            // String, plus nullable variants) cannot be InterpretedInstance
            // values — they're always native Dart values returned by the
            // callback. A simple `as <Type>` cast is sufficient and avoids
            // the extractBridgedArg detour. Restoring the legacy emission
            // (pre-GEN-081b) for these types keeps G-CB-7/11/12 green
            // without sacrificing GEN-081b interface-proxy routing for
            // class return types below.
            wrapperBody = '{ return $callExpr as $castType; }';
          } else {
            // GEN-081b: route the callback result through extractBridgedArg
            // so a script-returned InterpretedInstance gets wrapped by the
            // registered interface-proxy factory. Pass `visitor` so the
            // resolver has a context even when `_activeVisitor` is null
            // (typical during Flutter's own callback dispatch).
            //
            // Cluster FLP (G-FLP-16/23/30): also append `as $castType` to
            // the result so the wrapper text contains the literal
            // `as <PrefixedReturnType>` cast that downstream tests assert
            // on (return-type preservation through bridge). The cast is
            // redundant with `extractBridgedArg<T>`'s declared return
            // type but makes the cast site explicit in the source —
            // matching the legacy pre-GEN-081b emission shape.
            wrapperBody =
                "{ return D4.extractBridgedArg<$castType>($callExpr, 'callback', visitor) as $castType; }";
          }
        }
      }
    }

    // Build complete wrapper. B.14: the yielded void wrapper body uses `await`,
    // so the closure must be `async`. Every other wrapper stays synchronous
    // (byte-identical output). A `Future<void> Function(...)` is assignable to a
    // `void Function(...)` slot, so native APIs still accept the wrapper.
    final asyncModifier =
        (yieldVoidCallbacks && funcInfo.isVoid) ? 'async ' : '';
    var wrapper = '$genericTypeParamsDecl($paramsStr) $asyncModifier$wrapperBody';

    // Cluster FLP (G-FLP-28): for non-generic, non-void wrappers, append an
    // explicit function-type cast `as <ReturnType> Function(<paramTypes>)`
    // so the wrapper text contains the canonical function-type signature
    // (parameter-name/default-value stripped). Without this, primitive-
    // return wrappers like `bool Function(Object?)` emit only the closure
    // body `(Object? p0) { ... as bool; }` and lose the function-type
    // signature, which contravariance tests assert on.
    //
    // Skip the cast when:
    //   • the wrapper is generic (`<T>(...)`) — generic function types
    //     cannot be expressed as a literal function type in an `as` cast
    //     outside a typedef declaration;
    //   • the typedef has any named parameters — function types cannot
    //     carry default values, and downstream tests (G-FLP-07) regex on
    //     the textual `{bool allowUpscaling}` shape that would otherwise
    //     be introduced by the cast for non-nullable optional named
    //     parameters that the wrapper closure handles via a default.
    if (wrapperReturnCastType != null &&
        // Skip the outer function-type cast when the return type is `dynamic`.
        // Dart resolves the type argument of a generic callback parameter
        // (e.g. `RecognizerCallback<T>` in `T? invokeCallback<T>(...)`) from
        // the contextual type at the call site. A `dynamic Function()` cast
        // forces T = dynamic, which then conflicts when the caller's context
        // is `Object Function()` (T inferred to Object from the bridge
        // adapter's `Object?` return). Without the cast, the closure literal
        // gets its return type from inference and assigns cleanly. This does
        // not regress G-FLP-28 (Object? Function(Object?) text) because that
        // test exercises non-dynamic returns.
        wrapperReturnCastType != 'dynamic' &&
        funcInfo.genericTypeParameters.isEmpty &&
        funcInfo.namedParamTypes.isEmpty) {
      final funcTypeSig = _buildFunctionTypeSignature(
        funcInfo: funcInfo,
        returnCastType: wrapperReturnCastType,
        scopedTypeParams: scopedTypeParams,
        typeToUri: typeToUri,
        sourceFilePath: sourceFilePath,
      );
      if (funcTypeSig != null) {
        wrapper = '($wrapper) as $funcTypeSig';
      }
    }

    if (isNullable) {
      return '$callbackVarName == null ? null : $wrapper';
    } else {
      return wrapper;
    }
  }

  /// Cluster FLP (G-FLP-28): build the canonical function-type signature
  /// (`<Return> Function(<positional>, {<named>})`) for a callback wrapper.
  ///
  /// Parameter names and default values are intentionally omitted — function
  /// types in Dart do not carry them. The returned signature is suitable for
  /// use as the right-hand side of an `as` cast applied to the closure literal
  /// produced by [_generateFunctionWrapper].
  ///
  /// Returns `null` when the signature cannot be safely synthesised (e.g.,
  /// nested function types that contain unresolved generics that would make
  /// the cast a contravariance hazard).
  String? _buildFunctionTypeSignature({
    required FunctionTypeInfo funcInfo,
    required String returnCastType,
    required Map<String, String?> scopedTypeParams,
    Map<String, String> typeToUri = const {},
    String? sourceFilePath,
  }) {
    String resolveParamType(String rawParamType) {
      var paramType = _getTypeArgument(
        rawParamType,
        typeToUri: typeToUri,
        classTypeParams: scopedTypeParams,
        sourceFilePath: sourceFilePath,
      );
      // GEN-062 parity: nested function types with unresolved generics
      // collapse to bare `Function` to keep contravariance valid. Mirror
      // the same rule used when emitting the wrapper parameter list.
      if (paramType.contains('Function(') && paramType.contains('dynamic')) {
        paramType = 'Function';
      }
      return paramType;
    }

    final positionalSigs = <String>[
      for (final raw in funcInfo.positionalParamTypes) resolveParamType(raw),
    ];

    final namedSigs = <String>[];
    for (final entry in funcInfo.namedParamTypes.entries) {
      final isRequired = funcInfo.namedParamRequired[entry.key] ?? false;
      final resolved = resolveParamType(entry.value);
      if (isRequired) {
        namedSigs.add('required $resolved ${entry.key}');
      } else {
        namedSigs.add('$resolved ${entry.key}');
      }
    }

    final params = StringBuffer();
    if (positionalSigs.isNotEmpty) {
      params.write(positionalSigs.join(', '));
    }
    if (namedSigs.isNotEmpty) {
      if (positionalSigs.isNotEmpty) params.write(', ');
      params.write('{${namedSigs.join(', ')}}');
    }
    return '$returnCastType Function($params)';
  }

  /// Generates inline map conversion code for maps with function values.
  ///
  /// This is needed because D4.coerceMap cannot cast InterpretedFunction
  /// to typed function signatures due to Dart's strict function subtyping.
  /// Instead, we generate inline code that creates properly-typed wrappers.
  ///
  /// If [declareVariable] is false, assumes the variable is already declared
  /// and only generates the population code (for use in if/else blocks).
  ///
  /// Returns the generated code lines as a list of strings.
  List<String> _generateInlineFunctionMapConversion({
    required String localName,
    required String rawMapExpr,
    required String keyType,
    required String valueType,
    required FunctionTypeInfo funcInfo,
    required bool isNullable,
    bool declareVariable = true,
    String visitorExpr = 'visitor',
    Map<String, String> typeToUri = const {},
    Map<String, String?> classTypeParams = const {},
    String? sourceFilePath,
    String indent = '        ',
  }) {
    final lines = <String>[];
    final rawVarName = '${localName}Raw';
    final fullMapType = 'Map<$keyType, $valueType>';

    // Declare raw map variable
    lines.add('$indent// Convert map with function values inline');
    lines.add('${indent}final $rawVarName = $rawMapExpr as Map?;');

    // Initialize result map
    if (declareVariable) {
      if (isNullable) {
        lines.add('$indent$fullMapType? $localName;');
      } else {
        lines.add('${indent}final $localName = <$keyType, $valueType>{};');
      }
    } else {
      // Variable already declared - initialize it
      if (!isNullable) {
        lines.add('$indent$localName = <$keyType, $valueType>{};');
      }
    }

    lines.add('${indent}if ($rawVarName != null) {');

    // Generate the wrapper expression for the map value
    // We'll use a temp variable 'v' for the raw value
    final wrapperExpr = _generateFunctionWrapper(
      callbackVarName: 'v',
      funcInfo: funcInfo,
      isNullable: false, // Individual values - handle null in the loop
      visitorExpr: visitorExpr,
      typeToUri: typeToUri,
      classTypeParams: classTypeParams,
      sourceFilePath: sourceFilePath,
    );

    // Loop over entries
    lines.add('$indent  for (final entry in $rawVarName.entries) {');
    // RC-4: Use D4.extractBridgedArg for map keys to unwrap BridgedInstance.
    // Direct `as` cast fails when the key is wrapped in BridgedInstance.
    lines.add(
      "$indent    final k = D4.extractBridgedArg<$keyType>(entry.key, '$localName[key]');",
    );
    lines.add('$indent    final v = entry.value;');
    lines.add('$indent    if (v == null) {');

    // Handle null value
    if (valueType.endsWith('?')) {
      if (isNullable) {
        lines.add('$indent      $localName ??= <$keyType, $valueType>{};');
        lines.add('$indent      $localName![k] = null;');
      } else {
        lines.add('$indent      $localName[k] = null;');
      }
    } else {
      lines.add(
        '$indent      // Skip null values for non-nullable function type',
      );
    }
    lines.add('$indent    } else if (v is Callable) {');

    // Wrap Callable
    if (isNullable) {
      lines.add('$indent      $localName ??= <$keyType, $valueType>{};');
      lines.add('$indent      $localName![k] = $wrapperExpr;');
    } else {
      lines.add('$indent      $localName[k] = $wrapperExpr;');
    }

    lines.add('$indent    } else {');

    // Direct cast for already-typed value
    if (isNullable) {
      lines.add('$indent      $localName ??= <$keyType, $valueType>{};');
      lines.add('$indent      $localName![k] = v as $valueType;');
    } else {
      lines.add('$indent      $localName[k] = v as $valueType;');
    }

    lines.add('$indent    }');
    lines.add('$indent  }');
    lines.add('$indent}');

    return lines;
  }

  /// Extracts the key and value types from a Map type.
  /// Returns a record with (keyType, valueType).
  (String, String) _getMapTypeArgs(
    String mapType, {
    Map<String, String> typeToUri = const {},
    Map<String, String?> classTypeParams = const {},
    String? sourceFilePath,
  }) {
    var baseType = mapType.endsWith('?')
        ? mapType.substring(0, mapType.length - 1)
        : mapType;
    // Extract content between Map< and >
    final argsStr = baseType.substring(4, baseType.length - 1);

    // Parse the two type arguments (handling nested generics)
    var depth = 0;
    var splitIndex = -1;
    for (var i = 0; i < argsStr.length; i++) {
      final char = argsStr[i];
      if (char == '<') {
        depth++;
      } else if (char == '>') {
        depth--;
      } else if (char == ',' && depth == 0) {
        splitIndex = i;
        break;
      }
    }

    if (splitIndex == -1) {
      // Fallback: assume simple types
      return ('Object', 'Object');
    }

    final keyType = _getTypeArgument(
      argsStr.substring(0, splitIndex).trim(),
      typeToUri: typeToUri,
      classTypeParams: classTypeParams,
      sourceFilePath: sourceFilePath,
    );
    final rawValueType = argsStr.substring(splitIndex + 1).trim();
    var valueType = _getTypeArgument(
      rawValueType,
      typeToUri: typeToUri,
      classTypeParams: classTypeParams,
      sourceFilePath: sourceFilePath,
    );
    // GEN-067 fix: When a map value type is a function type alias that was
    // erased to 'dynamic' by _getTypeArgument(), try to expand the typedef
    // to preserve the actual function type for the Map's type argument.
    // Map<String, dynamic> is not assignable to Map<String, WidgetBuilder>.
    if (valueType == 'dynamic') {
      final cleanedValue = rawValueType.replaceAll('?', '');
      if (_knownFunctionTypeAliases.contains(cleanedValue) ||
          _isFunctionTypeName(cleanedValue)) {
        // Try typedef expansion first
        final expanded = _typedefExpansions[cleanedValue];
        if (expanded != null) {
          valueType = _getTypeArgument(
            expanded,
            typeToUri: typeToUri,
            classTypeParams: classTypeParams,
            sourceFilePath: sourceFilePath,
          );
          if (rawValueType.endsWith('?') && !valueType.endsWith('?')) {
            valueType = '$valueType?';
          }
        } else {
          // Fall back to 'Function' which is better than 'dynamic' for function types
          valueType = rawValueType.endsWith('?') ? 'Function?' : 'Function';
        }
      }
    }
    return (keyType, valueType);
  }

  /// Collects import URIs from resolved type information in classes and global functions.
  ///
  /// This uses the typeImportUris fields populated by the resolved analyzer,
  /// rather than a hardcoded type-to-import mapping.
  Set<String> _collectResolvedTypeImports(
    List<ClassInfo> classes, {
    List<GlobalFunctionInfo> globalFunctions = const [],
  }) {
    final imports = <String>{};

    for (final cls in classes) {
      // Check constructor parameters
      for (final ctor in cls.constructors) {
        // Excluded constructors are never emitted, so their parameter types
        // must not drag imports (e.g. `Image.file`'s dart:io File) into the
        // generated header. See [_isConstructorExcluded].
        if (_isConstructorExcluded(cls.name, ctor.name ?? '')) {
          continue;
        }
        for (final param in ctor.parameters) {
          imports.addAll(param.typeImportUris);
          // Also collect from typeToUri in case typeImportUris is incomplete
          imports.addAll(param.typeToUri.values);
        }
      }

      // Check member return types and parameters
      for (final member in cls.members) {
        imports.addAll(member.returnTypeImportUris);
        // Also collect from returnTypeToUri
        imports.addAll(member.returnTypeToUri.values);
        for (final param in member.parameters) {
          imports.addAll(param.typeImportUris);
          // Also collect from typeToUri
          imports.addAll(param.typeToUri.values);
        }
      }
    }

    // Also collect from global functions (return types AND parameter types)
    for (final func in globalFunctions) {
      // Return type imports
      imports.addAll(func.returnTypeImportUris);
      imports.addAll(func.returnTypeToUri.values);
      // Parameter type imports
      for (final param in func.parameters) {
        imports.addAll(param.typeImportUris);
        imports.addAll(param.typeToUri.values);
      }
    }

    return imports;
  }

  /// GEN-057: Post-processes global functions to fix up missing return type URIs.
  ///
  /// When parsing files with prefixed return types (e.g., `core.Which`), the analyzer
  /// may return InvalidType because the import prefix resolution wasn't available.
  /// This method looks up the unprefixed type name in `_globalTypeToUri` (populated
  /// during parsing of all files) and creates fixed-up GlobalFunctionInfo objects.
  ///
  /// Returns a new list of GlobalFunctionInfo with resolved return type URIs.
  List<GlobalFunctionInfo> _fixupReturnTypeUris(
    List<GlobalFunctionInfo> functions,
  ) {
    return functions.map((func) {
      // If return type URIs are already populated, keep as-is
      if (func.returnTypeImportUris.isNotEmpty) return func;

      // Try to resolve the return type from _globalTypeToUri
      final returnType = func.returnType;
      final rawTypeName = returnType.contains('.')
          ? returnType.split('.').last
          : returnType;

      // Skip void, dynamic, and built-in types
      if (rawTypeName == 'void' ||
          rawTypeName == 'dynamic' ||
          rawTypeName == 'Never' ||
          _isBuiltInType(rawTypeName)) {
        return func;
      }

      final uri = _globalTypeToUri[rawTypeName];
      if (uri == null) return func;

      // Create a new GlobalFunctionInfo with the fixed-up return type URIs
      return GlobalFunctionInfo(
        name: func.name,
        returnType: func.returnType,
        returnTypeImportUris: {uri},
        returnTypeToUri: {rawTypeName: uri},
        parameters: func.parameters,
        sourceFile: func.sourceFile,
        hasTypeParameters: func.hasTypeParameters,
        typeParameters: func.typeParameters,
      );
    }).toList();
  }

  /// Generates a display signature string for a constructor.
  String _getConstructorSignature(ClassInfo cls, ConstructorInfo ctor) {
    final buffer = StringBuffer();
    if (ctor.isConst) buffer.write('const ');
    if (ctor.isFactory) buffer.write('factory ');
    buffer.write(cls.name);
    if (ctor.name != null && ctor.name!.isNotEmpty) {
      buffer.write('.${ctor.name}');
    }
    buffer.write('(');
    buffer.write(_formatParameters(ctor.parameters));
    buffer.write(')');
    return buffer.toString();
  }

  /// Generates a display signature string for a method.
  String _getMethodSignature(MemberInfo method) {
    if (method.isGetter) {
      return '${method.returnType} get ${method.name}';
    }
    if (method.isSetter) {
      final paramType = method.parameters.isNotEmpty
          ? method.parameters.first.type
          : 'dynamic';
      return 'set ${method.name}($paramType value)';
    }
    final buffer = StringBuffer();
    buffer.write('${method.returnType} ${method.name}(');
    buffer.write(_formatParameters(method.parameters));
    buffer.write(')');
    return buffer.toString();
  }

  /// Formats parameter list for display.
  String _formatParameters(List<ParameterInfo> parameters) {
    final positional = parameters.where((p) => !p.isNamed).toList();
    final named = parameters.where((p) => p.isNamed).toList();
    final requiredPositional = positional.where((p) => p.isRequired).toList();
    final optionalPositional = positional.where((p) => !p.isRequired).toList();

    final parts = <String>[];

    // Required positional
    for (final p in requiredPositional) {
      parts.add('${p.type} ${p.name}');
    }

    // Optional positional (in brackets)
    if (optionalPositional.isNotEmpty && named.isEmpty) {
      final optParts = optionalPositional
          .map((p) {
            final def = p.defaultValue != null ? ' = ${p.defaultValue}' : '';
            return '${p.type} ${p.name}$def';
          })
          .join(', ');
      parts.add('[$optParts]');
    }

    // Named parameters (in braces)
    if (named.isNotEmpty) {
      final namedParts = named
          .map((p) {
            final req = p.isRequired ? 'required ' : '';
            final def = p.defaultValue != null ? ' = ${p.defaultValue}' : '';
            return '$req${p.type} ${p.name}$def';
          })
          .join(', ');
      parts.add('{$namedParts}');
    }

    return parts.join(', ');
  }

  /// Generates a display signature string for a global function.
  String _getGlobalFunctionSignature(GlobalFunctionInfo func) {
    final buffer = StringBuffer();
    buffer.write('${func.returnType} ${func.name}(');
    buffer.write(_formatParameters(func.parameters));
    buffer.write(')');
    return buffer.toString();
  }
}

// =============================================================================
// CODE GENERATION UTILITIES
// =============================================================================

/// Generates a length check expression that uses isEmpty/isNotEmpty where appropriate.
///
/// For index 0, generates `collection.isEmpty` instead of `collection.length <= 0`
/// to satisfy the prefer_is_empty lint rule.
String _lengthCheckLessThanOrEqual(String collection, int index) {
  if (index == 0) {
    return '$collection.isEmpty';
  }
  return '$collection.length <= $index';
}

/// Generates a length check expression that uses isEmpty/isNotEmpty where appropriate.
///
/// For index 0, generates `collection.isNotEmpty` instead of `collection.length > 0`
/// to satisfy the prefer_is_empty lint rule.
String _lengthCheckGreaterThan(String collection, int index) {
  if (index == 0) {
    return '$collection.isNotEmpty';
  }
  return '$collection.length > $index';
}
