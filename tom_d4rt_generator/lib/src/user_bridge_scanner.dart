/// User Bridge Scanner
///
/// Scans source files for user bridge classes (extending D4UserBridge)
/// and extracts override information for the bridge generator.
///
/// User bridges must be annotated with `@D4rtUserBridge(libraryPath)` or
/// `@D4rtGlobalsUserBridge(libraryPath)` to be recognized.
library;

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

/// Information about a user bridge class and its overrides.
class UserBridgeInfo {
  /// The library path this bridge overrides (from @D4rtUserBridge annotation).
  ///
  /// Format: `package:package_name/path/to/file.dart`
  final String libraryPath;

  /// Optional: The specific class name to override.
  ///
  /// If null, overrides apply to any class matching the naming convention.
  final String? targetClassName;

  /// The name of the user bridge class (e.g., "MyCollectionUserBridge").
  final String userBridgeClassName;

  /// The source file containing the user bridge.
  final String sourceFile;

  /// Override methods for constructors.
  /// Key: constructor name (empty string for default, "named" for Foo.named())
  final Map<String, String> constructorOverrides;

  /// Override methods for instance getters.
  /// Key: getter name, Value: override method name
  final Map<String, String> getterOverrides;

  /// Override methods for instance setters.
  /// Key: setter name, Value: override method name
  final Map<String, String> setterOverrides;

  /// Override methods for instance methods.
  /// Key: method name, Value: override method name
  final Map<String, String> methodOverrides;

  /// Override methods for static getters.
  final Map<String, String> staticGetterOverrides;

  /// Override methods for static setters.
  final Map<String, String> staticSetterOverrides;

  /// Override methods for static methods.
  final Map<String, String> staticMethodOverrides;

  /// Override methods for operators.
  /// Key: operator symbol (e.g., "[]", "+"), Value: override method name
  final Map<String, String> operatorOverrides;

  /// Whether the user bridge has a nativeNames getter.
  final bool hasNativeNames;

  UserBridgeInfo({
    required this.libraryPath,
    this.targetClassName,
    required this.userBridgeClassName,
    required this.sourceFile,
    this.constructorOverrides = const {},
    this.getterOverrides = const {},
    this.setterOverrides = const {},
    this.methodOverrides = const {},
    this.staticGetterOverrides = const {},
    this.staticSetterOverrides = const {},
    this.staticMethodOverrides = const {},
    this.operatorOverrides = const {},
    this.hasNativeNames = false,
  });

  /// Check if any overrides exist.
  bool get hasOverrides =>
      constructorOverrides.isNotEmpty ||
      getterOverrides.isNotEmpty ||
      setterOverrides.isNotEmpty ||
      methodOverrides.isNotEmpty ||
      staticGetterOverrides.isNotEmpty ||
      staticSetterOverrides.isNotEmpty ||
      staticMethodOverrides.isNotEmpty ||
      operatorOverrides.isNotEmpty ||
      hasNativeNames;

  /// Get override method for a constructor.
  String? getConstructorOverride(String name) => constructorOverrides[name];

  /// Get override method for an instance getter.
  String? getGetterOverride(String name) => getterOverrides[name];

  /// Get override method for an instance setter.
  String? getSetterOverride(String name) => setterOverrides[name];

  /// Get override method for an instance method.
  String? getMethodOverride(String name) => methodOverrides[name];

  /// Get override method for a static getter.
  String? getStaticGetterOverride(String name) => staticGetterOverrides[name];

  /// Get override method for a static setter.
  String? getStaticSetterOverride(String name) => staticSetterOverrides[name];

  /// Get override method for a static method.
  String? getStaticMethodOverride(String name) => staticMethodOverrides[name];

  /// Get override method for an operator.
  String? getOperatorOverride(String operator) => operatorOverrides[operator];

  @override
  String toString() =>
      'UserBridgeInfo($userBridgeClassName for $libraryPath${targetClassName != null ? '::$targetClassName' : ''})';
}

/// Information about global overrides from a GlobalsUserBridge class.
///
/// This class holds override information for top-level functions, variables,
/// and getters that are not associated with any class.
class GlobalsUserBridgeInfo {
  /// The library path this bridge overrides (from @D4rtGlobalsUserBridge).
  ///
  /// Format: `package:package_name/path/to/file.dart`
  final String libraryPath;

  /// The name of the globals user bridge class.
  final String userBridgeClassName;

  /// The source file containing the user bridge.
  final String sourceFile;

  /// Override methods for global variables.
  /// Key: variable name, Value: override method name
  final Map<String, String> globalVariableOverrides;

  /// Override methods for global getters.
  /// Key: getter name, Value: override method name
  final Map<String, String> globalGetterOverrides;

  /// Override methods for top-level functions.
  /// Key: function name, Value: override method name
  final Map<String, String> globalFunctionOverrides;

  GlobalsUserBridgeInfo({
    required this.libraryPath,
    required this.userBridgeClassName,
    required this.sourceFile,
    this.globalVariableOverrides = const {},
    this.globalGetterOverrides = const {},
    this.globalFunctionOverrides = const {},
  });

  /// Check if any overrides exist.
  bool get hasOverrides =>
      globalVariableOverrides.isNotEmpty ||
      globalGetterOverrides.isNotEmpty ||
      globalFunctionOverrides.isNotEmpty;

  /// Get override method for a global variable.
  String? getGlobalVariableOverride(String name) =>
      globalVariableOverrides[name];

  /// Get override method for a global getter.
  String? getGlobalGetterOverride(String name) => globalGetterOverrides[name];

  /// Get override method for a top-level function.
  String? getGlobalFunctionOverride(String name) =>
      globalFunctionOverrides[name];

  @override
  String toString() =>
      'GlobalsUserBridgeInfo($userBridgeClassName for $libraryPath)';
}

/// Callback for emitting warnings during scanning.
typedef WarningCallback = void Function(String message);

/// Scans source files for user bridge classes.
///
/// User bridges must be annotated with `@D4rtUserBridge(libraryPath)` or
/// `@D4rtGlobalsUserBridge(libraryPath)` to be recognized. Classes extending
/// D4UserBridge without the annotation will emit a warning and be ignored.
class UserBridgeScanner extends RecursiveAstVisitor<void> {
  /// Map of (libraryPath, className) -> user bridge info.
  ///
  /// The key is a tuple of library path and optional class name.
  /// If className is null, the bridge applies to any class from that library.
  final Map<(String libraryPath, String? className), UserBridgeInfo>
      _userBridges = {};

  /// Set of class names that extend D4UserBridge (to exclude from generation).
  final Set<String> _d4UserBridgeClasses = {};

  /// Globals user bridges by library path.
  final Map<String, GlobalsUserBridgeInfo> _globalsUserBridges = {};

  /// Current source file being scanned.
  String _currentSourceFile = '';

  /// Optional callback for emitting warnings.
  WarningCallback? onWarning;

  /// Creates a new UserBridgeScanner.
  ///
  /// [onWarning] is called when a D4UserBridge class is found without
  /// the required annotation.
  UserBridgeScanner({this.onWarning});

  /// Get all discovered user bridges.
  Map<(String, String?), UserBridgeInfo> get userBridges =>
      Map.unmodifiable(_userBridges);

  /// Get all class names that extend D4UserBridge.
  Set<String> get d4UserBridgeClasses => Set.unmodifiable(_d4UserBridgeClasses);

  /// Get all globals user bridges.
  Map<String, GlobalsUserBridgeInfo> get globalsUserBridges =>
      Map.unmodifiable(_globalsUserBridges);

  /// Get globals user bridge for a specific library, if available.
  GlobalsUserBridgeInfo? getGlobalsUserBridgeFor(String libraryPath) {
    return _globalsUserBridges[libraryPath];
  }

  /// Legacy getter for backward compatibility.
  ///
  /// Returns the first globals user bridge found, or null.
  @Deprecated('Use getGlobalsUserBridgeFor(libraryPath) instead')
  GlobalsUserBridgeInfo? get globalsUserBridge =>
      _globalsUserBridges.isNotEmpty ? _globalsUserBridges.values.first : null;

  /// Scan a compilation unit for user bridge classes.
  void scanUnit(CompilationUnit unit, String sourceFile) {
    _currentSourceFile = sourceFile;
    unit.visitChildren(this);
  }

  /// Get user bridge info for a specific library and class.
  ///
  /// First checks for exact match (libraryPath, className), then falls back
  /// to library-only match (libraryPath, null).
  UserBridgeInfo? getUserBridgeFor(String libraryPath, String className) {
    // First try exact match with class name
    final exactMatch = _userBridges[(libraryPath, className)];
    if (exactMatch != null) return exactMatch;

    // Fall back to library-only match
    return _userBridges[(libraryPath, null)];
  }

  /// Get user bridge info by class name only (legacy behavior).
  ///
  /// Searches all bridges for one whose naming convention matches.
  /// This is for backward compatibility with tests.
  @Deprecated('Use getUserBridgeFor(libraryPath, className) instead')
  UserBridgeInfo? getUserBridgeByClassName(String className) {
    for (final info in _userBridges.values) {
      // Check if naming convention matches
      final expectedBridgeName = '${className}UserBridge';
      if (info.userBridgeClassName == expectedBridgeName) {
        return info;
      }
      // Also check explicit targetClassName
      if (info.targetClassName == className) {
        return info;
      }
    }
    return null;
  }

  /// Check if a class should be excluded (extends D4UserBridge).
  bool shouldExcludeClass(String className) {
    return _d4UserBridgeClasses.contains(className);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    final className = node.name.lexeme;

    // Check if this class extends D4UserBridge
    if (_extendsD4UserBridge(node)) {
      _d4UserBridgeClasses.add(className);

      // Try to extract annotation
      final annotation = _extractD4rtUserBridgeAnnotation(node);
      final globalsAnnotation = _extractD4rtGlobalsUserBridgeAnnotation(node);

      if (annotation != null) {
        // Has @D4rtUserBridge annotation - process it
        final (libraryPath, targetClass) = annotation;
        final info = _extractUserBridgeInfo(
          node,
          libraryPath,
          targetClass,
          className,
        );
        _userBridges[(libraryPath, targetClass)] = info;
      } else if (globalsAnnotation != null) {
        // Has @D4rtGlobalsUserBridge annotation - process it
        final libraryPath = globalsAnnotation;
        _globalsUserBridges[libraryPath] = _extractGlobalsUserBridgeInfo(
          node,
          libraryPath,
          className,
        );
      } else {
        // No annotation - emit warning
        final warning =
            'UserBridge $className has no @D4rtUserBridge or @D4rtGlobalsUserBridge annotation, ignoring';
        onWarning?.call(warning);
      }
    }

    super.visitClassDeclaration(node);
  }

  /// Extract @D4rtUserBridge annotation from a class.
  ///
  /// Returns (libraryPath, className?) or null if not found.
  (String, String?)? _extractD4rtUserBridgeAnnotation(ClassDeclaration node) {
    for (final annotation in node.metadata) {
      final name = annotation.name.name;
      if (name == 'D4rtUserBridge') {
        final arguments = annotation.arguments?.arguments;
        if (arguments != null && arguments.isNotEmpty) {
          // First argument: libraryPath (required)
          final libraryArg = arguments.first;
          String? libraryPath;
          if (libraryArg is StringLiteral) {
            libraryPath = libraryArg.stringValue;
          }

          if (libraryPath == null) continue;

          // Second argument: className (optional)
          String? targetClassName;
          if (arguments.length > 1) {
            final classArg = arguments[1];
            if (classArg is StringLiteral) {
              targetClassName = classArg.stringValue;
            }
          }

          return (libraryPath, targetClassName);
        }
      }
    }
    return null;
  }

  /// Extract @D4rtGlobalsUserBridge annotation from a class.
  ///
  /// Returns libraryPath or null if not found.
  String? _extractD4rtGlobalsUserBridgeAnnotation(ClassDeclaration node) {
    for (final annotation in node.metadata) {
      final name = annotation.name.name;
      if (name == 'D4rtGlobalsUserBridge') {
        final arguments = annotation.arguments?.arguments;
        if (arguments != null && arguments.isNotEmpty) {
          final libraryArg = arguments.first;
          if (libraryArg is StringLiteral) {
            return libraryArg.stringValue;
          }
        }
      }
    }
    return null;
  }

  /// Check if a class extends D4UserBridge.
  bool _extendsD4UserBridge(ClassDeclaration node) {
    final extendsClause = node.extendsClause;
    if (extendsClause == null) return false;

    final superclassName = extendsClause.superclass.name.lexeme;
    return superclassName == 'D4UserBridge';
  }

  /// Extract override information from a user bridge class.
  UserBridgeInfo _extractUserBridgeInfo(
    ClassDeclaration node,
    String libraryPath,
    String? targetClassName,
    String userBridgeClassName,
  ) {
    final constructorOverrides = <String, String>{};
    final getterOverrides = <String, String>{};
    final setterOverrides = <String, String>{};
    final methodOverrides = <String, String>{};
    final staticGetterOverrides = <String, String>{};
    final staticSetterOverrides = <String, String>{};
    final staticMethodOverrides = <String, String>{};
    final operatorOverrides = <String, String>{};
    var hasNativeNames = false;

    for (final member in node.members) {
      if (member is MethodDeclaration) {
        final methodName = member.name.lexeme;

        // Check for static nativeNames getter
        if (methodName == 'nativeNames' && member.isGetter && member.isStatic) {
          hasNativeNames = true;
          continue;
        }

        // Parse static override methods only
        if (member.isStatic && methodName.startsWith('override')) {
          _parseOverrideMethod(
            methodName,
            constructorOverrides,
            getterOverrides,
            setterOverrides,
            methodOverrides,
            staticGetterOverrides,
            staticSetterOverrides,
            staticMethodOverrides,
            operatorOverrides,
          );
        }
      }

      // Check for static nativeNames field
      if (member is FieldDeclaration && member.isStatic) {
        for (final variable in member.fields.variables) {
          if (variable.name.lexeme == 'nativeNames') {
            hasNativeNames = true;
          }
        }
      }
    }

    return UserBridgeInfo(
      libraryPath: libraryPath,
      targetClassName: targetClassName,
      userBridgeClassName: userBridgeClassName,
      sourceFile: _currentSourceFile,
      constructorOverrides: constructorOverrides,
      getterOverrides: getterOverrides,
      setterOverrides: setterOverrides,
      methodOverrides: methodOverrides,
      staticGetterOverrides: staticGetterOverrides,
      staticSetterOverrides: staticSetterOverrides,
      staticMethodOverrides: staticMethodOverrides,
      operatorOverrides: operatorOverrides,
      hasNativeNames: hasNativeNames,
    );
  }

  /// Extract override information from a globals user bridge class.
  GlobalsUserBridgeInfo _extractGlobalsUserBridgeInfo(
    ClassDeclaration node,
    String libraryPath,
    String userBridgeClassName,
  ) {
    final globalVariableOverrides = <String, String>{};
    final globalGetterOverrides = <String, String>{};
    final globalFunctionOverrides = <String, String>{};

    for (final member in node.members) {
      if (member is MethodDeclaration) {
        final methodName = member.name.lexeme;

        // Parse static override methods only
        if (member.isStatic && methodName.startsWith('override')) {
          _parseGlobalOverrideMethod(
            methodName,
            globalVariableOverrides,
            globalGetterOverrides,
            globalFunctionOverrides,
          );
        }
      }
    }

    return GlobalsUserBridgeInfo(
      libraryPath: libraryPath,
      userBridgeClassName: userBridgeClassName,
      sourceFile: _currentSourceFile,
      globalVariableOverrides: globalVariableOverrides,
      globalGetterOverrides: globalGetterOverrides,
      globalFunctionOverrides: globalFunctionOverrides,
    );
  }

  /// Parse a global override method name and add to appropriate map.
  void _parseGlobalOverrideMethod(
    String methodName,
    Map<String, String> globalVariableOverrides,
    Map<String, String> globalGetterOverrides,
    Map<String, String> globalFunctionOverrides,
  ) {
    // Global variables: overrideGlobalVariableName
    if (methodName.startsWith('overrideGlobalVariable')) {
      final memberName =
          _extractMemberName(methodName, 'overrideGlobalVariable');
      if (memberName.isNotEmpty) {
        globalVariableOverrides[memberName] = methodName;
      }
      return;
    }

    // Global getters: overrideGlobalGetterName
    if (methodName.startsWith('overrideGlobalGetter')) {
      final memberName = _extractMemberName(methodName, 'overrideGlobalGetter');
      if (memberName.isNotEmpty) {
        globalGetterOverrides[memberName] = methodName;
      }
      return;
    }

    // Global functions: overrideGlobalFunctionName
    if (methodName.startsWith('overrideGlobalFunction')) {
      final memberName =
          _extractMemberName(methodName, 'overrideGlobalFunction');
      if (memberName.isNotEmpty) {
        globalFunctionOverrides[memberName] = methodName;
      }
      return;
    }
  }

  /// Parse an override method name and add to appropriate map.
  void _parseOverrideMethod(
    String methodName,
    Map<String, String> constructorOverrides,
    Map<String, String> getterOverrides,
    Map<String, String> setterOverrides,
    Map<String, String> methodOverrides,
    Map<String, String> staticGetterOverrides,
    Map<String, String> staticSetterOverrides,
    Map<String, String> staticMethodOverrides,
    Map<String, String> operatorOverrides,
  ) {
    // Constructor: overrideConstructor, overrideConstructorNamed
    if (methodName == 'overrideConstructor') {
      constructorOverrides[''] = methodName;
      return;
    }
    if (methodName.startsWith('overrideConstructor') &&
        methodName.length > 'overrideConstructor'.length) {
      final constructorName =
          _extractMemberName(methodName, 'overrideConstructor');
      constructorOverrides[constructorName] = methodName;
      return;
    }

    // Operators
    if (methodName.startsWith('overrideOperator')) {
      final operatorMethod = methodName;
      final operator = _operatorFromMethodName(operatorMethod);
      if (operator != null) {
        operatorOverrides[operator] = methodName;
      }
      return;
    }

    // Static getters: overrideStaticGetterName
    if (methodName.startsWith('overrideStaticGetter')) {
      final memberName = _extractMemberName(methodName, 'overrideStaticGetter');
      staticGetterOverrides[memberName] = methodName;
      return;
    }

    // Static setters: overrideStaticSetterName
    if (methodName.startsWith('overrideStaticSetter')) {
      final memberName = _extractMemberName(methodName, 'overrideStaticSetter');
      staticSetterOverrides[memberName] = methodName;
      return;
    }

    // Static methods: overrideStaticMethodName
    if (methodName.startsWith('overrideStaticMethod')) {
      final memberName = _extractMemberName(methodName, 'overrideStaticMethod');
      staticMethodOverrides[memberName] = methodName;
      return;
    }

    // Instance getters: overrideGetterName
    if (methodName.startsWith('overrideGetter')) {
      final memberName = _extractMemberName(methodName, 'overrideGetter');
      getterOverrides[memberName] = methodName;
      return;
    }

    // Instance setters: overrideSetterName
    if (methodName.startsWith('overrideSetter')) {
      final memberName = _extractMemberName(methodName, 'overrideSetter');
      setterOverrides[memberName] = methodName;
      return;
    }

    // Instance methods: overrideMethodName
    if (methodName.startsWith('overrideMethod')) {
      final memberName = _extractMemberName(methodName, 'overrideMethod');
      methodOverrides[memberName] = methodName;
      return;
    }
  }

  /// Extract member name from override method name.
  /// E.g., "overrideGetterValue" -> "value" (lowercase first letter)
  String _extractMemberName(String methodName, String prefix) {
    if (methodName.length <= prefix.length) return '';
    final name = methodName.substring(prefix.length);
    // Convert first letter to lowercase
    if (name.isEmpty) return '';
    return name[0].toLowerCase() + name.substring(1);
  }

  /// Map operator override method names to operators.
  static const _operatorMethodToSymbol = {
    'overrideOperatorIndex': '[]',
    'overrideOperatorIndexAssign': '[]=',
    'overrideOperatorPlus': '+',
    'overrideOperatorMinus': '-',
    'overrideOperatorMultiply': '*',
    'overrideOperatorDivide': '/',
    'overrideOperatorIntegerDivide': '~/',
    'overrideOperatorModulo': '%',
    'overrideOperatorEquals': '==',
    'overrideOperatorLessThan': '<',
    'overrideOperatorGreaterThan': '>',
    'overrideOperatorLessThanOrEqual': '<=',
    'overrideOperatorGreaterThanOrEqual': '>=',
    'overrideOperatorBitwiseAnd': '&',
    'overrideOperatorBitwiseOr': '|',
    'overrideOperatorBitwiseXor': '^',
    'overrideOperatorBitwiseNot': '~',
    'overrideOperatorLeftShift': '<<',
    'overrideOperatorRightShift': '>>',
    'overrideOperatorUnsignedRightShift': '>>>',
    'overrideOperatorUnaryMinus': 'unary-',
  };

  /// Get operator symbol from override method name.
  String? _operatorFromMethodName(String methodName) {
    return _operatorMethodToSymbol[methodName];
  }
}
