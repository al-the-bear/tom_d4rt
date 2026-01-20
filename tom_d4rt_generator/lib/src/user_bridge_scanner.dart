/// User Bridge Scanner
///
/// Scans source files for user bridge classes (extending D4UserBridge)
/// and extracts override information for the bridge generator.
library;

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

/// Information about a user bridge class and its overrides.
class UserBridgeInfo {
  /// The name of the target class (e.g., "MyList" from "MyListUserBridge").
  final String targetClassName;

  /// The name of the user bridge class (e.g., "MyListUserBridge").
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
    required this.targetClassName,
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
      'UserBridgeInfo($targetClassName <- $userBridgeClassName)';
}

/// Scans source files for user bridge classes.
class UserBridgeScanner extends RecursiveAstVisitor<void> {
  /// Map of target class name to user bridge info.
  final Map<String, UserBridgeInfo> _userBridges = {};

  /// Set of class names that extend D4UserBridge (to exclude from generation).
  final Set<String> _d4UserBridgeClasses = {};

  /// Current source file being scanned.
  String _currentSourceFile = '';

  /// Get all discovered user bridges.
  Map<String, UserBridgeInfo> get userBridges => Map.unmodifiable(_userBridges);

  /// Get all class names that extend D4UserBridge.
  Set<String> get d4UserBridgeClasses => Set.unmodifiable(_d4UserBridgeClasses);

  /// Scan a compilation unit for user bridge classes.
  void scanUnit(CompilationUnit unit, String sourceFile) {
    _currentSourceFile = sourceFile;
    unit.visitChildren(this);
  }

  /// Get user bridge info for a target class, if available.
  UserBridgeInfo? getUserBridgeFor(String className) {
    return _userBridges[className];
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

      // Check if it follows the naming convention {ClassName}UserBridge
      if (className.endsWith('UserBridge')) {
        final targetClassName =
            className.substring(0, className.length - 'UserBridge'.length);
        if (targetClassName.isNotEmpty) {
          final info = _extractUserBridgeInfo(node, targetClassName, className);
          _userBridges[targetClassName] = info;
        }
      }
    }

    super.visitClassDeclaration(node);
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
    String targetClassName,
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
      final constructorName = _extractMemberName(methodName, 'overrideConstructor');
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
