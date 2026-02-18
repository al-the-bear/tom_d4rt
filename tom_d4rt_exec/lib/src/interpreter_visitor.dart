import 'dart:async';
import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_exec/src/bridge/bridged_enum.dart';
import 'package:tom_d4rt_exec/src/utils/extensions/string.dart';
import 'package:tom_d4rt_exec/src/module_loader.dart';

/// Main visitor that walks the AST and interprets the code.
/// Uses a two-pass approach (DeclarationVisitor first).
class InterpreterVisitor extends GeneralizingSAstVisitor<Object?> {
  Environment environment;
  final Environment globalEnvironment;
  final ModuleLoader moduleLoader; // Field for ModuleLoader
  InterpretedFunction? currentFunction; // Track the function being executed
  AsyncExecutionState? currentAsyncState;
  Set<String> _currentStatementLabels = {};

  /// For sync* generators: the list to collect yielded values into.
  /// When non-null, yield statements add directly to this list.
  List<Object?>? syncGeneratorValues;

  /// For lazy sync* generators: when true, yield throws SyncYieldSuspension
  /// to pause execution and bubble up through the call stack.
  bool isLazySyncGeneratorContext = false;

  InterpreterVisitor({
    required this.globalEnvironment,
    required this.moduleLoader, // Accept ModuleLoader in the constructor
    Uri? initiallibrary, // New: Optional URI for the initial source
  }) : environment = globalEnvironment {
    if (initiallibrary != null) {
      // Sets the base URI in the ModuleLoader for the initial source code.
      // This is crucial for resolving relative imports in this initial source code.
      moduleLoader.currentlibrary = initiallibrary;
      Logger.debug(
          "[InterpreterVisitor] Initial source URI set in ModuleLoader to: $initiallibrary");
    }
    // Initialize currentAsyncState if it's null and we are in an async context implicitly
    // This might be more complex depending on how top-level async calls are handled
  }

  @override
  Object? visitCompilationUnit(SCompilationUnit node) {
    // Restore simple sequential processing
    Object? lastValue;
    for (final declaration in node.declarations) {
      lastValue = declaration.accept<Object?>(this);
    }
    return lastValue;
  }

  @override
  Object? visitBlock(SBlock node) {
    return executeBlock(node.statements, Environment(enclosing: environment));
  }

  Object? executeBlock(
      List<SAstNode> statements, Environment blockEnvironment) {
    final previousEnvironment = environment;
    Object? lastValue;
    try {
      environment = blockEnvironment;
      for (final statement in statements) {
        // Explicitly handle declarations within blocks
        if (statement is SFunctionDeclaration ||
            statement is SClassDeclaration ||
            statement is SMixinDeclaration ||
            statement
                is STopLevelVariableDeclaration || // Technically not a statement, but might appear?
            statement is SVariableDeclarationStatement) {
          // This is a proper statement
          lastValue = statement.accept<Object?>(this);
          // Check for suspension after declaration execution
          if (lastValue is AsyncSuspensionRequest) {
            return lastValue; // Propagate suspension
          }
          lastValue = null; // Declarations don't produce a carry value
        } else {
          lastValue = statement.accept<Object?>(this);
          // if the execution of the statement returns an async suspension request,
          // we propagate it immediately upwards.
          if (lastValue is AsyncSuspensionRequest) {
            return lastValue;
          }
        }
        // Handle ReturnException, BreakException, ContinueException if needed (propagate or consume)
        // This simple version just propagates them implicitly by not catching them here.
      }
    } finally {
      environment = previousEnvironment;
    }
    return lastValue;
  }

  @override
  Object? visitTopLevelVariableDeclaration(STopLevelVariableDeclaration node) {
    for (final variable in node.variables!.variables) {
      if (variable.name!.name == '_') {
        // Evaluate initializer for potential side effects, but don't define
        variable.initializer?.accept<Object?>(this);
      } else {
        Object? value;
        if (variable.initializer != null) {
          value = variable.initializer!.accept<Object?>(this);
        }
        environment.define(variable.name!.name, value);
      }
    }
    return null;
  }

  @override
  Object? visitPatternVariableDeclarationStatement(
      SPatternVariableDeclarationStatement node) {
    final patternDecl = node.declaration;
    final pattern = patternDecl.pattern;
    final initializer = patternDecl.expression;

    // Evaluate the right-hand side value
    final rhsValue = initializer.accept<Object?>(this);

    // Match and bind the pattern to the value
    try {
      _matchAndBind(pattern, rhsValue, environment);
    } on PatternMatchD4rtException catch (e) {
      // Convert pattern match failures to standard RuntimeError for now
      throw RuntimeD4rtException("Pattern match failed: ${e.message}");
    } catch (e, s) {
      // Add stack trace capture
      Logger.error(
          "during pattern binding: $e\nStack trace:\n$s"); // Display the stack trace
      // Catch other potential errors during binding
      throw RuntimeD4rtException("Error during pattern binding: $e");
    }
    return null;
  }

  @override
  Object? visitVariableDeclarationStatement(
      SVariableDeclarationStatement node) {
    // Simply visit the declaration list. The list visitor handles definition.
    return node.variables!.accept<Object?>(this);
    // return null; // Statements usually return null unless they are Return/Throw/etc.
  }

  // Handles the list of variables in a single declaration statement.

  @override
  Object? visitExpressionStatement(SExpressionStatement node) {
    return node.expression!.accept<Object?>(this);
  }

  @override
  Object? visitAsExpression(SAsExpression node) {
    final value = node.expression!.accept<Object?>(this);
    final typeNode = node.type;
    if (typeNode is SNamedType) {
      final typeName = typeNode.name!.name;
      // G-DOV2-1 FIX: Handle nullable types (e.g., String?, int?)
      // If the type is nullable (has a '?' suffix), then null is always allowed
      final isNullable = typeNode.isNullable;
      if (isNullable && value == null) {
        return value; // Null is valid for any nullable type
      }
      switch (typeName) {
        case 'int':
          if (value is int) return value;
          break;
        case 'double':
          if (value is double) return value;
          break;
        case 'num':
          if (value is num) return value;
          break;
        case 'String':
          if (value is String) return value;
          break;
        case 'bool':
          if (value is bool) return value;
          break;
        case 'List':
          if (value is List) return value;
          break;
        case 'Null':
          if (value == null) return value;
          break;
        case 'Object':
          // G-DOV2-1 FIX: For Object?, null is valid (handled above)
          // For Object, any non-null value is valid
          if (value != null || isNullable) return value;
          break;
        case 'dynamic':
          return value;
        default:
          // For custom/interpreted types, we can add logic here
          // For now, we accept all (permissive behavior)
          return value;
      }
    }
    throw RuntimeD4rtException(
        "Cast failed with 'as' : the value does not match the target type (${typeNode.toString()})");
  }

  @override
  Object? visitIntegerLiteral(SIntegerLiteral node) {
    return node.value;
  }

  @override
  Object? visitDoubleLiteral(SDoubleLiteral node) {
    return node.value;
  }

  @override
  Object? visitBooleanLiteral(SBooleanLiteral node) {
    return node.value;
  }

  Object? visitStringLiteral(SAstNode node) {
    if (node is SSimpleStringLiteral) {
      return node.value;
    } else if (node is SAdjacentStrings) {
      // Handle adjacent strings like 'Hello ' 'World!'
      final buffer = StringBuffer();
      for (final stringLiteral in node.strings) {
        if (stringLiteral is SSimpleStringLiteral) {
          buffer.write(stringLiteral.value);
        } else if (stringLiteral is SStringInterpolation) {
          // G-DOV-1/2 FIX: Handle SStringInterpolation children within SAdjacentStrings
          buffer.write(visitStringInterpolation(stringLiteral));
        } else {
          // Recursively handle nested adjacent strings or other string types
          final value = visitStringLiteral(stringLiteral);
          buffer.write(value.toString());
        }
      }
      return buffer.toString();
    }
    throw UnimplementedD4rtException(
      'Type de StringLiteral non géré: ${node.runtimeType}',
    );
  }

  @override
  Object? visitNullLiteral(SNullLiteral node) {
    return null;
  }

  @override
  Object? visitSimpleIdentifier(SSimpleIdentifier node) {
    final name = node.name;

    Logger.debug(
        "[visitSimpleIdentifier] Looking for '$name'. Visitor env: ${environment.hashCode}");

    // Lexical search & Bridges
    try {
      // Use environment.get() which handles strings and bridges
      final value = environment.get(name);
      // If get() succeeds, the value is found (variable or bridge)
      Logger.debug(
          "[visitSimpleIdentifier] Found '$name' via environment.get() -> ${value?.runtimeType}");

      // Handle late variables
      if (value is LateVariable) {
        Logger.debug("[visitSimpleIdentifier] Accessing late variable '$name'");
        return value
            .value; // This will trigger lazy initialization or throw if uninitialized
      }

      if (name == 'initialValue') {
        Logger.debug(
            "[visitSimpleIdentifier] Returning '$name' = $value (from lexical/bridge)");
      }
      return value;
    } on RuntimeD4rtException catch (getErr) {
      // Ignore get() error for now, try 'this' then
      Logger.debug(
          "[visitSimpleIdentifier] '$name' not found lexically or as bridge. Trying implicit 'this'. Error: ${getErr.message}");
    }

    // Implicit attempt via 'this'
    // (Only if not found lexically/as bridge)
    Object? thisInstance;
    try {
      thisInstance = environment.get('this');
    } on RuntimeD4rtException {
      // 'this' does not exist in the current environment.
      // Before giving up, try searching static methods in the current class if we're in a static context
      if (currentFunction != null &&
          currentFunction!.ownerType is InterpretedClass) {
        final ownerClass = currentFunction!.ownerType as InterpretedClass;
        Logger.debug(
            "[visitSimpleIdentifier] 'this' not found, but we're in class '${ownerClass.name}'. Checking static members for '$name'.");

        // Check static methods
        final staticMethod = ownerClass.findStaticMethod(name);
        if (staticMethod != null) {
          Logger.debug(
              "[visitSimpleIdentifier] Found static method '$name' in current class '${ownerClass.name}'.");
          return staticMethod;
        }

        // Check static getters
        final staticGetter = ownerClass.findStaticGetter(name);
        if (staticGetter != null) {
          Logger.debug(
              "[visitSimpleIdentifier] Found static getter '$name' in current class '${ownerClass.name}'.");
          return staticGetter;
        }

        // Check static fields
        try {
          final staticField = ownerClass.getStaticField(name);
          Logger.debug(
              "[visitSimpleIdentifier] Found static field '$name' in current class '${ownerClass.name}'.");
          return staticField;
        } on RuntimeD4rtException {
          // Static field not found, continue to final error
        }
      }

      // This is the end of the search, the identifier is undefined.
      throw RuntimeD4rtException("Undefined variable: $name");
    }

    // 'this' was found, now we try to access the member.
    try {
      if (thisInstance is InterpretedInstance) {
        // Access the property on 'this'
        final member = thisInstance.get(name, visitor: this);
        Logger.debug(
            "[visitSimpleIdentifier] Found '$name' via implicit InterpretedInstance 'this'. Member: ${member?.runtimeType}");
        return member; // Return the field value or bound function (getter/method)
      } else if (toBridgedInstance(thisInstance).$2) {
        final bridgedInstance = toBridgedInstance(thisInstance).$1!;

        Logger.debug(
            "[visitSimpleIdentifier] Trying implicit 'this' access on BridgedInstance (${bridgedInstance.bridgedClass.name}) for member '$name'.");
        // Check instance getter FIRST
        final getterAdapter =
            bridgedInstance.bridgedClass.findInstanceGetterAdapter(name);
        if (getterAdapter != null) {
          Logger.debug(
              "[visitSimpleIdentifier] Found BRIDGED GETTER '$name' via implicit 'this'. Calling adapter...");
          final getterResult =
              getterAdapter(this, bridgedInstance.nativeObject);
          if (name == 'initialValue') {
            Logger.debug(
                "[visitSimpleIdentifier] Returning '$name' = $getterResult (from BridgedInstance getter this)");
          }
          return getterResult;
        }
        Logger.debug(
            "[visitSimpleIdentifier]   Bridged getter '$name' not found. Checking for method...");
        // Then check instance method
        final methodAdapter =
            bridgedInstance.bridgedClass.findInstanceMethodAdapter(name);
        if (methodAdapter != null) {
          Logger.debug(
              "[visitSimpleIdentifier] Found BRIDGED METHOD '$name' via implicit 'this'. Binding...");
          // Return a callable bound to the instance

          final boundCallable =
              BridgedMethodCallable(bridgedInstance, methodAdapter, name);
          if (name == 'initialValue') {
            Logger.debug(
                "[visitSimpleIdentifier] Returning '$name' = $boundCallable (bound method from BridgedInstance this)");
          }
          return boundCallable;
        }
        Logger.debug(
            "[visitSimpleIdentifier]   Bridged method '$name' not found either.");
        // If neither getter nor method, error
        throw RuntimeD4rtException(
            "Undefined property or method '$name' on bridged instance of '${bridgedInstance.bridgedClass.name}' accessed via implicit 'this'.");
      } // +++ NEW BLOCK +++
      else if (thisInstance is InterpretedEnumValue) {
        Logger.debug(
            "[visitSimpleIdentifier] Found '$name' via implicit InterpretedEnumValue 'this'.");
        // Delegate to the get method of the enum value, passing visitor
        // This will execute getters or return bound methods/fields.
        final enumMember = thisInstance.get(name, this);
        if (name == 'initialValue') {
          Logger.debug(
              "[visitSimpleIdentifier] Returning '$name' = $enumMember (from EnumValue this)");
        }
        return enumMember;
      }
      throw RuntimeD4rtException(
          "Undefined variable: $name (this exists as native type ${thisInstance?.runtimeType}");
    } on RuntimeD4rtException catch (thisErr) {
      // 'this' not found OR instance.get() failed
      // If get() failed with a specific error, propagate it if it is NOT "Undefined property".
      if (thisErr.message.contains("Undefined property '$name'") ||
          thisErr.message.contains("Undefined property or method '$name'")) {
        Logger.debug(
            "[SSimpleIdentifier] Direct access failed for '$name' via implicit 'this'. Trying extension lookup on ${thisInstance?.runtimeType}.");
        if (thisInstance != null) {
          // Check that 'this' exists before searching
          try {
            final extensionMember =
                environment.findExtensionMember(thisInstance, name);

            if (extensionMember is ExtensionMemberCallable) {
              if (extensionMember.isGetter) {
                Logger.debug(
                    "[SSimpleIdentifier] Found extension getter '$name' via implicit 'this'. Calling...");
                // Extension getters are called with the instance as the only positional argument
                final extensionPositionalArgs = [thisInstance];
                try {
                  return extensionMember
                      .call(this, extensionPositionalArgs, {});
                } on ReturnException catch (e) {
                  return e.value;
                } catch (e) {
                  throw RuntimeD4rtException(
                      "Error executing extension getter '$name' via implicit 'this': $e");
                }
              } else if (!extensionMember.isOperator &&
                  !extensionMember.isSetter) {
                // Return the extension method itself (not bound)
                Logger.debug(
                    "[SSimpleIdentifier] Found extension method '$name' via implicit 'this'. Returning callable.");
                // Return a bound instance instead of the raw method.
                return BoundExtensionCallable(thisInstance, extensionMember);
              }
              // Operators/setters are generally not accessible directly via a simple identifier
            }
            // No suitable extension member found, fall through to final error
            Logger.debug(
                "[SSimpleIdentifier] No suitable extension member found for '$name' via implicit 'this'.");
          } on RuntimeD4rtException catch (findError) {
            // Error during extension lookup itself
            Logger.debug(
                "[SSimpleIdentifier] Error during extension lookup for '$name' via implicit 'this': ${findError.message}");
            // Fall through to final error
          }
        } else {
          Logger.debug(
              "[SSimpleIdentifier] Cannot search extension for '$name' because implicit 'this' is null.");
        }
      }
      // Relaunch the error if it was NOT "Undefined property" OR if extension lookup failed.
      else if (thisErr.message
          .contains("non implémenté pour BridgedInstance")) {
        // Relaunch the specific BridgeInstance errors
        rethrow;
      }

      // Before final error, try static method lookup in enclosing class
      final enclosingClass = _findEnclosingClass();
      if (enclosingClass != null) {
        Logger.debug(
            "[visitSimpleIdentifier] Final attempt: checking static members for '$name' in enclosing class '${enclosingClass.name}'.");

        // Check static methods
        final staticMethod = enclosingClass.findStaticMethod(name);
        if (staticMethod != null) {
          Logger.debug(
              "[visitSimpleIdentifier] Found static method '$name' in enclosing class '${enclosingClass.name}' (final attempt).");
          return staticMethod;
        }

        // Check static getters
        final staticGetter = enclosingClass.findStaticGetter(name);
        if (staticGetter != null) {
          Logger.debug(
              "[visitSimpleIdentifier] Found static getter '$name' in enclosing class '${enclosingClass.name}' (final attempt).");
          return staticGetter;
        }

        // Check static fields
        try {
          final staticField = enclosingClass.getStaticField(name);
          Logger.debug(
              "[visitSimpleIdentifier] Found static field '$name' in enclosing class '${enclosingClass.name}' (final attempt).");
          return staticField;
        } on RuntimeD4rtException {
          // Static field not found, continue to final error
        }
      }

      // If the initial error was 'Undefined property' AND that extension lookup failed,
      // or if the initial error was something else, raise the final "Undefined variable" error.
      throw RuntimeD4rtException(
          "Undefined variable: $name (Original error: ${thisErr.message})");
    }
  }

  @override
  Object? visitThisExpression(SThisExpression node) {
    try {
      return environment.get('this');
    } on RuntimeD4rtException {
      // This should ideally not happen if called within a valid method/constructor context
      throw RuntimeD4rtException(
          "Keyword 'this' used outside of an instance context.");
    }
  }

  /// Helper method to find an enclosing class that might contain static members
  /// Searches through the environment chain and currentFunction hierarchy
  InterpretedClass? _findEnclosingClass() {
    // First, try the current function's owner
    if (currentFunction != null &&
        currentFunction!.ownerType is InterpretedClass) {
      return currentFunction!.ownerType as InterpretedClass;
    }

    // If that doesn't work, search the environment chain for class instances
    // This is a fallback approach - look for any classes defined in parent scopes
    Environment? current = environment;
    while (current != null) {
      for (final value in current.values.values) {
        if (value is InterpretedClass) {
          // Found a class in this environment - this might be our enclosing class
          // We need to check if we're inside a method of this class
          // This is a heuristic - in a proper implementation, we'd track the lexical scope better
          Logger.debug(
              "[_findEnclosingClass] Found class '${value.name}' in environment chain");
          return value;
        }
      }
      current = current.enclosing;
    }

    return null;
  }

  @override
  Object? visitPrefixedIdentifier(SPrefixedIdentifier node) {
    final prefixValue = node.prefix!.accept<Object?>(this);
    if (prefixValue is AsyncSuspensionRequest) {
      // Propagate the suspension so that the state machine resumes this node after resolution
      return prefixValue;
    }
    final memberName = node.identifier!.name;

    // Handle the case where the prefix is an environment (prefixed import)
    if (prefixValue is Environment) {
      Logger.debug(
          "[SPrefixedIdentifier] The prefix '${node.prefix.toString()}' resolved to an Environment. Searching for '$memberName' in this environment.");
      try {
        // The call to get() on the prefixed environment could return a function (which must be called if it's a getter)
        // or a direct value.
        final member = prefixValue.get(memberName);
        // If it's an InterpretedFunction and a getter, it must be called.
        if (member is InterpretedFunction && member.isGetter) {
          Logger.debug(
              "[SPrefixedIdentifier] Member '$memberName' is a getter. Calling...");
          return member.call(this, [],
              {}); // Call without 'this' because it's a prefixed import
        }
        Logger.debug(
            "[SPrefixedIdentifier] Member '$memberName' found directly: $member");
        return member; // Return the value/function directly
      } on RuntimeD4rtException catch (e) {
        throw RuntimeD4rtException(
            "Erreur lors de la récupération du membre '$memberName' de l'import préfixé '${node.prefix.toString()}': ${e.message}");
      }
    }

    if (prefixValue is InterpretedClass) {
      // Static access
      try {
        return prefixValue.getStaticField(memberName);
      } on RuntimeD4rtException catch (_) {
        InterpretedFunction? staticMember =
            prefixValue.findStaticGetter(memberName);
        staticMember ??= prefixValue.findStaticMethod(memberName);
        if (staticMember != null) {
          if (staticMember.isGetter) {
            return staticMember.call(this, [], {});
          } else {
            return staticMember;
          }
        } else {
          // G-DOV-5 FIX: Handle constructor tear-offs (Class.new)
          // Return the class itself as it implements Callable and its call()
          // method properly creates an instance and calls the constructor.
          if (memberName == 'new') {
            final constructor = prefixValue.findConstructor('');
            if (constructor != null) return prefixValue;
          }
          // G-DOV2-2 FIX: Handle named constructor tear-offs (Class.fromMap, etc.)
          // Named constructors can be used as tear-offs when passed to higher-order functions
          final namedConstructor = prefixValue.findConstructor(memberName);
          if (namedConstructor != null) {
            // Return a callable that will invoke this named constructor
            return _NamedConstructorTearOff(
                prefixValue, namedConstructor, memberName);
          }
          throw RuntimeD4rtException(
              "Undefined static member '$memberName' on class '${prefixValue.name}'.");
        }
      }
    } else if (prefixValue is InterpretedEnum) {
      if (memberName == 'values') {
        Logger.debug(
            "[SPrefixedIdentifier] Accessing static getter 'values' on enum '${prefixValue.name}'.");
        return prefixValue.valuesList;
      }

      // Check enum values first
      final value = prefixValue.values[memberName];
      if (value != null) {
        Logger.debug(
            "[SPrefixedIdentifier] Accessing enum value '$memberName' on enum '${prefixValue.name}'.");
        return value;
      }

      // Check static fields
      if (prefixValue.staticFields.containsKey(memberName)) {
        Logger.debug(
            "[SPrefixedIdentifier] Accessing static field '$memberName' on enum '${prefixValue.name}'.");
        return prefixValue.staticFields[memberName];
      }

      // Check static getters
      final staticGetter = prefixValue.staticGetters[memberName];
      if (staticGetter != null) {
        Logger.debug(
            "[SPrefixedIdentifier] Calling static getter '$memberName' on enum '${prefixValue.name}'.");
        return staticGetter.call(this, [], {});
      }

      // Check static methods
      final staticMethod = prefixValue.staticMethods[memberName];
      if (staticMethod != null) {
        Logger.debug(
            "[SPrefixedIdentifier] Accessing static method '$memberName' on enum '${prefixValue.name}'.");
        return staticMethod;
      }

      // Check mixins for static members (reverse order)
      for (final mixin in prefixValue.mixins.reversed) {
        // Check static fields
        try {
          final mixinStaticField = mixin.getStaticField(memberName);
          Logger.debug(
              "[SPrefixedIdentifier] Found static field '$memberName' from mixin '${mixin.name}' for enum '${prefixValue.name}'");
          return mixinStaticField;
        } on RuntimeD4rtException {
          // Continue to next check
        }

        // Check static getters
        final mixinStaticGetter = mixin.findStaticGetter(memberName);
        if (mixinStaticGetter != null) {
          Logger.debug(
              "[SPrefixedIdentifier] Found static getter '$memberName' from mixin '${mixin.name}' for enum '${prefixValue.name}'");
          return mixinStaticGetter.call(this, [], {});
        }

        // Check static methods
        final mixinStaticMethod = mixin.findStaticMethod(memberName);
        if (mixinStaticMethod != null) {
          Logger.debug(
              "[SPrefixedIdentifier] Found static method '$memberName' from mixin '${mixin.name}' for enum '${prefixValue.name}'");
          return mixinStaticMethod;
        }
      }

      // Not found
      throw RuntimeD4rtException(
          "Undefined static member '$memberName' on enum '${prefixValue.name}'. Available enum values: ${prefixValue.valueNames.join(', ')}");
    } else if (prefixValue is BridgedClass) {
      final bridgedClass = prefixValue;
      Logger.debug(
          "[SPrefixedIdentifier] Static access on BridgedClass: ${bridgedClass.name}.$memberName");
      final staticGetter = bridgedClass.findStaticGetterAdapter(memberName);
      if (staticGetter != null) {
        return staticGetter(this);
      }
      final staticMethod = bridgedClass.findStaticMethodAdapter(memberName);
      if (staticMethod != null) {
        // Return the static method as a callable value
        Logger.debug(
            "[SPrefixedIdentifier] Returning bridged static method '$memberName' as value from '${bridgedClass.name}'.");
        return BridgedStaticMethodCallable(
            bridgedClass, staticMethod, memberName);
      } else {
        throw RuntimeD4rtException(
            "Undefined static member '$memberName' on bridged class '${bridgedClass.name}'.");
      }
    } else if (prefixValue is InterpretedExtension) {
      // Handle static member access on extensions
      final extension = prefixValue;
      Logger.debug(
          "[SPrefixedIdentifier] Static access on Extension: ${extension.name ?? '<unnamed>'}.$memberName");

      // Check static field
      if (extension.staticFields.containsKey(memberName)) {
        return extension.staticFields[memberName];
      }

      // Check static getter
      final staticGetter = extension.findStaticGetter(memberName);
      if (staticGetter != null) {
        return staticGetter.call(this, [], {});
      }

      // Check static method
      final staticMethod = extension.findStaticMethod(memberName);
      if (staticMethod != null) {
        return staticMethod;
      }

      throw RuntimeD4rtException(
          "Undefined static member '$memberName' on extension '${extension.name ?? '<unnamed>'}'.");
    } else if (prefixValue is InterpretedInstance) {
      try {
        final member = prefixValue.get(memberName, visitor: this);
        if (member is InterpretedFunction && member.isGetter) {
          return member.bind(prefixValue).call(this, [], {});
        } else {
          return member;
        }
      } on RuntimeD4rtException catch (e) {
        if (e.message.contains("Undefined property '$memberName'")) {
          final extensionMember =
              environment.findExtensionMember(prefixValue, memberName);
          if (extensionMember is ExtensionMemberCallable) {
            if (extensionMember.isGetter) {
              return extensionMember.call(this, [prefixValue], {});
            } else if (!extensionMember.isOperator &&
                !extensionMember.isSetter) {
              return extensionMember;
            }
          }
        }
        throw RuntimeD4rtException(
            "${e.message} (accessing property via SPrefixedIdentifier '$memberName')");
      }
    } else if (prefixValue is InterpretedEnumValue) {
      if (memberName == 'index') {
        Logger.debug(
            "[SPrefixedIdentifier] Accessing getter 'index' on enum value '$prefixValue'.");
        return prefixValue.index;
      } else if (memberName == 'toString') {
        Logger.debug(
            "[SPrefixedIdentifier] Accessing method 'toString' on enum value '$prefixValue'. Returning callable.");
        // Return directly the string for simplicity in prefixed access?
        // No, return a callable function to be consistent with methods.
        return NativeFunction((_, args, __, ___) {
          if (args.isNotEmpty) {
            throw RuntimeD4rtException("toString() takes no arguments.");
          }
          return prefixValue.toString();
        }, arity: 0, name: 'toString');
      } else if (memberName == 'name') {
        Logger.debug(
            "[SPrefixedIdentifier] Explicitly accessing 'name' on enum value '$prefixValue'. Returning value.");
        return prefixValue.name; // Access directly the 'name' property
      } else {
        Logger.debug(
            "[SPrefixedIdentifier] Accessing member '$memberName' on enum value '$prefixValue'. Calling get()...");
        try {
          // Pass 'this' (the visitor) to allow getter execution if needed.
          return prefixValue.get(memberName, this);
        } on ReturnException catch (e) {
          // If get() executes a getter that throws ReturnException
          return e.value;
        } on RuntimeD4rtException catch (e) {
          // G-DOV2-7 FIX: Try extension lookup if direct access fails
          if (e.message.contains("Undefined property '$memberName'")) {
            Logger.debug(
                "[SPrefixedIdentifier] Direct access failed for '$memberName' on enum $prefixValue. Trying extension lookup...");
            final extensionMember =
                environment.findExtensionMember(prefixValue, memberName);
            if (extensionMember is ExtensionMemberCallable) {
              if (extensionMember.isGetter) {
                Logger.debug(
                    "[SPrefixedIdentifier] Found extension getter '$memberName' for enum. Calling...");
                return extensionMember.call(this, [prefixValue], {});
              } else if (!extensionMember.isOperator &&
                  !extensionMember.isSetter) {
                Logger.debug(
                    "[SPrefixedIdentifier] Found extension method '$memberName' for enum. Returning tear-off.");
                return extensionMember;
              }
            }
          }
          // Propagate error if extension lookup failed
          throw RuntimeD4rtException(
              "Error getting member '$memberName' from enum value '$prefixValue': ${e.message}");
        } catch (e) {
          // Propagate other errors from get()
          throw RuntimeD4rtException(
              "Error getting member '$memberName' from enum value '$prefixValue': $e");
        }
      }
    } else if (toBridgedInstance(prefixValue).$2) {
      final bridgedInstance = toBridgedInstance(prefixValue).$1!;
      final getterAdapter =
          bridgedInstance.bridgedClass.findInstanceGetterAdapter(memberName);
      if (getterAdapter != null) {
        return getterAdapter(this, bridgedInstance.nativeObject);
      }
      final methodAdapter =
          bridgedInstance.bridgedClass.findInstanceMethodAdapter(memberName);
      if (methodAdapter != null) {
        return BridgedMethodCallable(bridgedInstance, methodAdapter, memberName)
            .call(this, [], {});
      }

      // No adapter found, try extension methods/getters
      try {
        final extensionMember =
            environment.findExtensionMember(bridgedInstance, memberName);
        if (extensionMember is ExtensionMemberCallable) {
          if (extensionMember.isGetter) {
            Logger.debug(
                "[SPrefixedIdentifier] Found extension getter '$memberName' for ${bridgedInstance.bridgedClass.name}. Calling...");
            final extensionArgs = <Object?>[bridgedInstance];
            return extensionMember.call(this, extensionArgs, {});
          } else if (!extensionMember.isOperator && !extensionMember.isSetter) {
            Logger.debug(
                "[SPrefixedIdentifier] Found extension method '$memberName' for ${bridgedInstance.bridgedClass.name}. Returning callable.");
            return BoundExtensionCallable(bridgedInstance, extensionMember);
          }
        }
      } on RuntimeD4rtException catch (findError) {
        Logger.debug(
            "[SPrefixedIdentifier] Error finding extension '$memberName' for ${bridgedInstance.bridgedClass.name}: ${findError.message}");
      }

      throw RuntimeD4rtException(
          "Undefined property or method '$memberName' on bridged instance of '${bridgedInstance.bridgedClass.name}'.");
    } else if (prefixValue is InterpretedRecord) {
      // Accessing field of a record
      final record = prefixValue;
      Logger.debug(
          "[SPrefixedIdentifier] Access on InterpretedRecord: .$memberName");

      // Check for Object methods (hashCode, runtimeType, toString)
      switch (memberName) {
        case 'hashCode':
          return record.hashCode;
        case 'runtimeType':
          return record.runtimeType;
      }

      // Check if it's a positional field access ($1, $2, ...)
      if (memberName.startsWith('\$') && memberName.length > 1) {
        try {
          final index = int.parse(memberName.substring(1)) - 1;
          if (index >= 0 && index < record.positionalFields.length) {
            return record.positionalFields[index];
          } else {
            throw RuntimeD4rtException(
                "Record positional field index \$$index out of bounds (0..${record.positionalFields.length - 1}).");
          }
        } catch (e) {
          // Handle parse errors or other issues
          throw RuntimeD4rtException(
              "Invalid positional record field accessor '$memberName'.");
        }
      } else {
        // Check if it's a named field access
        if (record.namedFields.containsKey(memberName)) {
          return record.namedFields[memberName];
        } else {
          throw RuntimeD4rtException(
              "Record has no field named '$memberName'. Available fields: ${record.namedFields.keys.join(', ')}");
        }
      }
    } else if (prefixValue is InterpretedExtensionTypeInstance) {
      // Lim-1 FIX: Handle property access on extension type instances
      final extensionInstance = prefixValue;
      Logger.debug(
          "[SPrefixedIdentifier] Access on InterpretedExtensionTypeInstance: .$memberName");

      // Check for Object methods first (hashCode, runtimeType, toString)
      switch (memberName) {
        case 'hashCode':
          return extensionInstance.representationValue.hashCode;
        case 'runtimeType':
          return extensionInstance.extensionType;
      }

      // Delegate to the extension type instance's get() method
      try {
        return extensionInstance.get(memberName, this);
      } on ReturnException catch (e) {
        // If get() executes a getter that throws ReturnException
        return e.value;
      }
    } else if (prefixValue is BridgedEnum) {
      Logger.debug(
          "[SPrefixedIdentifier] Accessing value on BridgedEnum: ${prefixValue.name}.$memberName");
      final enumValue = prefixValue.getValue(memberName);
      if (enumValue != null) {
        return enumValue; // Return the BridgedEnumValue
      } else {
        throw RuntimeD4rtException(
            "Undefined enum value '$memberName' on bridged enum '${prefixValue.name}'.");
      }
    } else if (prefixValue is BridgedEnumValue) {
      final bridgedEnumValue = prefixValue;
      Logger.debug(
          "[SPrefixedIdentifier] Accessing property '$memberName' on BridgedEnumValue (within InterpretedEnumValue block): $bridgedEnumValue");
      try {
        // Use the get() method of BridgedEnumValue
        return bridgedEnumValue.get(memberName);
      } on ReturnException catch (e) {
        return e.value;
      } on RuntimeD4rtException {
        // Relaunch the RuntimeErrors directly
        rethrow;
      } catch (e, s) {
        // Catch other potential errors (ex: from the adapter)
        Logger.error(
            "[SPrefixedIdentifier] Native exception during bridged enum property get '$bridgedEnumValue.$memberName': $e\n$s");
        throw RuntimeD4rtException(
            "Native error during bridged enum property get '$memberName' on $bridgedEnumValue: $e");
      }
    } else {
      try {
        final extensionMember =
            environment.findExtensionMember(prefixValue, memberName);

        if (extensionMember is ExtensionMemberCallable) {
          // Handle extension getter call immediately
          if (extensionMember.isGetter) {
            Logger.debug(
                "[SPrefixedIdentifier] Found extension getter '$memberName' (fallback). Calling...");
            final extensionPositionalArgs = [
              prefixValue
            ]; // Getter takes receiver
            return extensionMember.call(this, extensionPositionalArgs, {});
          } else if (!extensionMember.isOperator && !extensionMember.isSetter) {
            // Return extension method itself if it's not a getter/setter/operator
            Logger.debug(
                "[SPrefixedIdentifier] Found extension method '$memberName' (fallback). Returning callable.");
            return extensionMember;
          }
          // If it's an operator or setter, we probably shouldn't reach here via SPrefixedIdentifier
          // Fall through to Stdlib if it wasn't a getter or regular method.
        }
        // If no suitable extension found, proceed to Stdlib call
        Logger.debug(
            "[SPrefixedIdentifier] No suitable extension found for '$memberName' (fallback). Trying Stdlib...");
      } on RuntimeD4rtException catch (findError) {
        // If findExtensionMember itself threw (e.g., type not found), proceed to Stdlib
        Logger.debug(
            "[SPrefixedIdentifier] Error finding extension '$memberName' (fallback): ${findError.message}. Trying Stdlib...");
      }

      throw RuntimeD4rtException(
          "Cannot access property '$memberName' on target of type ${prefixValue?.runtimeType}.");
    }
  }

  @override
  Object? visitBinaryExpression(SBinaryExpression node) {
    final operator = node.operator;

    // Handle logical OR (||) with short-circuiting FIRST - don't evaluate right operand yet
    if (operator == '||') {
      final leftValue = node.leftOperand!.accept<Object?>(this);
      if (leftValue is AsyncSuspensionRequest) return leftValue;
      if (leftValue is! bool) {
        throw RuntimeD4rtException(
            "Left operand of '||' must be bool, got ${leftValue?.runtimeType}.");
      }
      // If left is true, return true without evaluating right
      if (leftValue) return true;
      // Left is false, now evaluate right operand
      final rightValue = node.rightOperand!.accept<Object?>(this);
      if (rightValue is AsyncSuspensionRequest) return rightValue;
      if (rightValue is! bool) {
        throw RuntimeD4rtException(
            "Right operand of '||' must be bool, got ${rightValue?.runtimeType}.");
      }
      return rightValue;
    }

    // Handle logical AND (&&) with short-circuiting SECOND - don't evaluate right operand yet
    if (operator == '&&') {
      final leftValue = node.leftOperand!.accept<Object?>(this);
      if (leftValue is AsyncSuspensionRequest) return leftValue;
      if (leftValue is! bool) {
        throw RuntimeD4rtException(
            "Left operand of '&&' must be bool, got ${leftValue?.runtimeType}.");
      }
      // If left is false, return false without evaluating right
      if (!leftValue) return false;
      // Left is true, now evaluate right operand
      final rightValue = node.rightOperand!.accept<Object?>(this);
      if (rightValue is AsyncSuspensionRequest) return rightValue;
      if (rightValue is! bool) {
        throw RuntimeD4rtException(
            "Right operand of '&&' must be bool, got ${rightValue?.runtimeType}.");
      }
      return rightValue;
    }

    // Handle null-coalescing (??) with short-circuiting - don't evaluate right operand yet
    if (operator == '??') {
      final leftValue = node.leftOperand!.accept<Object?>(this);
      if (leftValue is AsyncSuspensionRequest) return leftValue;
      // If left is not null, return it without evaluating right
      if (leftValue != null) return leftValue;
      // Left is null, evaluate right operand
      final rightValue = node.rightOperand!.accept<Object?>(this);
      if (rightValue is AsyncSuspensionRequest) return rightValue;
      return rightValue;
    }

    // For all other operators, evaluate both operands
    final leftOperandValue = node.leftOperand!.accept<Object?>(this);
    final rightOperandValue = node.rightOperand!.accept<Object?>(this);

    Logger.debug("[SBinaryExpression DEBUG] Operator: $operator");
    Logger.debug("  Left operand type: ${leftOperandValue?.runtimeType}");
    Logger.debug("  Left operand value: $leftOperandValue");
    Logger.debug("  Right operand type: ${rightOperandValue?.runtimeType}");
    Logger.debug("  Right operand value: $rightOperandValue");

    if (leftOperandValue is AsyncSuspensionRequest) {
      return leftOperandValue;
    }
    if (rightOperandValue is AsyncSuspensionRequest) {
      return rightOperandValue;
    }

    final leftBridgedInstance = toBridgedInstance(leftOperandValue);
    final left = leftBridgedInstance.$2
        ? leftBridgedInstance.$1!.nativeObject
        : (leftOperandValue is InterpretedFunction)
            ? leftOperandValue.call(this, [])
            : leftOperandValue;
    final rightBridgedInstance = toBridgedInstance(rightOperandValue);
    final right = rightBridgedInstance.$2
        ? rightBridgedInstance.$1!.nativeObject
        : (rightOperandValue is InterpretedFunction)
            ? rightOperandValue.call(this, [])
            : rightOperandValue;

    if (left is num && right is num) {
      switch (operator) {
        case '+':
          return left + right;
        case '-':
          return left - right;
        case '*':
          return left * right;
        case '/':
          // For double division, Dart returns infinity for division by zero
          if (left is double || right is double) {
            return left.toDouble() / right.toDouble();
          }
          // For integer division that will produce double, also return infinity
          return left.toDouble() / right.toDouble();
        case '>':
          return left > right;
        case '<':
          return left < right;
        case '>=':
          return left >= right;
        case '<=':
          return left <= right;
        case '%':
          if (right == 0) throw RuntimeD4rtException("Modulo by zero.");
          return left % right;
        case '~/':
          if (right == 0)
            throw RuntimeD4rtException("Integer division by zero.");
          return left ~/ right;
        default:
          break;
      }
    }

    // Moved this block BEFORE standard ==, !=, <, <=, >, >= checks
    final operatorName = operator;

    // Check for class operator methods FIRST (before extensions and built-in operators)
    if (leftOperandValue is InterpretedInstance) {
      final operatorMethod = leftOperandValue.findOperator(operatorName);
      if (operatorMethod != null) {
        Logger.debug(
            "[SBinaryExpression] Found class operator '$operatorName' on ${leftOperandValue.klass.name}. Calling...");
        try {
          return operatorMethod
              .bind(leftOperandValue)
              .call(this, [rightOperandValue], {});
        } on ReturnException catch (e) {
          return e.value;
        } catch (e) {
          throw RuntimeD4rtException(
              "Error executing class operator '$operatorName': $e");
        }
      }
    }

    // Check for bridged operator methods (e.g., +, -, *, /, etc. on BridgedInstance)
    if (toBridgedInstance(leftOperandValue).$2) {
      final bridgedInstance = toBridgedInstance(leftOperandValue).$1!;
      final bridgedClass = bridgedInstance.bridgedClass;

      final methodAdapter =
          bridgedClass.findInstanceMethodAdapter(operatorName);

      if (methodAdapter != null) {
        Logger.debug(
            "[SBinaryExpression] Found bridged operator '$operatorName' for ${bridgedClass.name}. Calling adapter...");
        try {
          // Unwrap right operand if it's a BridgedInstance
          final rightArg = toBridgedInstance(rightOperandValue).$2
              ? toBridgedInstance(rightOperandValue).$1!.nativeObject
              : rightOperandValue;
          return methodAdapter(
              this, bridgedInstance.nativeObject, [rightArg], {}, null);
        } catch (e, s) {
          Logger.error(
              "[SBinaryExpression] Native exception during bridged operator '$operatorName' on ${bridgedClass.name}: $e\\n$s");
          throw RuntimeD4rtException(
              "Native error during bridged operator '$operatorName' on ${bridgedClass.name}: $e");
        }
      }
    }

    // Only try extension immediately for operators where standard checks might bypass it
    // (e.g., ==, !=, <, >, <=, >= which have generic fallbacks)
    bool checkExtensionEarly = [
      '==',
      '!=',
      '<',
      '<=',
      '>',
      '>=',
      '|', // Also check early for missing operators like |
      '&', // and &
      '^' // and ^ if BigInt support was incomplete
      // Add other operators here if needed
    ].contains(operatorName);

    if (checkExtensionEarly) {
      try {
        final extensionOperator =
            environment.findExtensionMember(leftOperandValue, operatorName);

        if (extensionOperator is ExtensionMemberCallable &&
            extensionOperator.isOperator) {
          Logger.debug(
              "[SBinaryExpression] Found extension operator '$operatorName' (early check) for type ${leftOperandValue?.runtimeType}. Calling...");
          final extensionPositionalArgs = [leftOperandValue, rightOperandValue];
          try {
            return extensionOperator.call(this, extensionPositionalArgs, {});
          } on ReturnException catch (e) {
            return e.value;
          } catch (e) {
            throw RuntimeD4rtException(
                "Error executing extension operator '$operatorName': $e");
          }
        }
        // If no suitable extension operator found early, continue to standard checks
        Logger.debug(
            "[SBinaryExpression] No suitable extension operator '$operatorName' found (early check) for type ${leftOperandValue?.runtimeType}. Continuing...");
      } on RuntimeD4rtException catch (findError) {
        // findExtensionMember throws if no member is found at all.
        Logger.debug(
            "[SBinaryExpression] No extension member '$operatorName' found (early check) for type ${leftOperandValue?.runtimeType}. Error: ${findError.message}");
        // Continue to standard checks even if lookup failed early
      }
    }

    switch (operator) {
      case '+':
        if (left is String && right is String) return left + right;
        if (left is BigInt && right is BigInt) return left + right;
        if (left is Duration && right is Duration) return left + right;
        if (left is List && right is List) return left + right;
      case '-':
        if (left is BigInt && right is BigInt) return left - right;
        if (left is Duration && right is Duration) return left - right;
      case '*':
        if (left is String && right is int) return left * right;
        if (left is BigInt && right is BigInt) return left * right;
        if (left is Duration && right is num) return left * right;
      case '/':
        if (left is BigInt && right is BigInt) return left / right;
      case '~/':
        if (left is BigInt && right is BigInt) return left ~/ right;
        if (left is Duration && right is int) return left ~/ right;
      case '%':
        if (left is BigInt && right is BigInt) return left % right;
      case '==':
        // Special handling for BridgedEnumValue comparison
        if (leftOperandValue is BridgedEnumValue &&
            rightOperandValue is BridgedEnumValue) {
          final result = leftOperandValue == rightOperandValue;
          return result;
        }

        // Special handling for mixed native enum and BridgedEnumValue comparison
        if ((leftOperandValue is BridgedEnumValue &&
                rightOperandValue is Enum) ||
            (leftOperandValue is Enum &&
                rightOperandValue is BridgedEnumValue)) {
          // Convert both to their native enum values for comparison
          final leftNative = leftOperandValue is BridgedEnumValue
              ? leftOperandValue.nativeValue
              : leftOperandValue;
          final rightNative = rightOperandValue is BridgedEnumValue
              ? rightOperandValue.nativeValue
              : rightOperandValue;

          final result = leftNative == rightNative;
          return result;
        }

        // Special handling for Type vs BridgedClass comparison
        // (e.g., value.runtimeType == int)
        if (left is Type && right is BridgedClass) {
          return left == right.nativeType;
        }
        if (left is BridgedClass && right is Type) {
          return left.nativeType == right;
        }

        return left == right;
      case '!=':
        // Special handling for BridgedEnumValue comparison
        if (leftOperandValue is BridgedEnumValue &&
            rightOperandValue is BridgedEnumValue) {
          return leftOperandValue != rightOperandValue;
        }

        // Special handling for mixed native enum and BridgedEnumValue comparison
        if ((leftOperandValue is BridgedEnumValue &&
                rightOperandValue is Enum) ||
            (leftOperandValue is Enum &&
                rightOperandValue is BridgedEnumValue)) {
          final leftNative = leftOperandValue is BridgedEnumValue
              ? leftOperandValue.nativeValue
              : leftOperandValue;
          final rightNative = rightOperandValue is BridgedEnumValue
              ? rightOperandValue.nativeValue
              : rightOperandValue;
          return leftNative != rightNative;
        }

        // Special handling for Type vs BridgedClass comparison
        // (e.g., value.runtimeType != int)
        if (left is Type && right is BridgedClass) {
          return left != right.nativeType;
        }
        if (left is BridgedClass && right is Type) {
          return left.nativeType != right;
        }

        return left != right;
      case '<':
        return left as dynamic < right;
      case '<=':
        return left as dynamic <= right;
      case '>':
        return left as dynamic > right;
      case '>=':
        return left as dynamic >= right;
      case '^':
        if (left is int && right is int) return left ^ right;
        if (left is BigInt && right is BigInt) return left ^ right;
        throw RuntimeD4rtException('Unsupported binary operator "$operator"');
      case '&':
        if (left is int && right is int) return left & right;
        if (left is BigInt && right is BigInt) return left & right;
        throw RuntimeD4rtException('Unsupported binary operator "$operator"');
      case '|':
        if (left is int && right is int) return left | right;
        if (left is BigInt && right is BigInt) return left | right;
        throw RuntimeD4rtException('Unsupported binary operator "$operator"');
      case '>>':
        if (left is int && right is int) return left >> right;
        if (left is BigInt && right is int) return left >> right;
        throw RuntimeD4rtException('Unsupported binary operator "$operator"');
      case '<<':
        if (left is int && right is int) return left << right;
        if (left is BigInt && right is int) return left << right;
        throw RuntimeD4rtException('Unsupported binary operator "$operator"');
      case '>>>':
        if (left is int && right is int) return left >>> right;
        // Note: BigInt doesn't support >>> operator in Dart
        throw RuntimeD4rtException('Unsupported binary operator "$operator"');
      default:
        break;
    }

    if (operator == '+' && (left is String || right is String)) {
      return '${stringify(left)}${stringify(right)}'; // stringify already handles BridgedInstance indirectly via toString
    }

    if (!checkExtensionEarly) {
      // Only run this if we didn't already check (and potentially succeed/fail) earlier
      try {
        final extensionOperator =
            environment.findExtensionMember(leftOperandValue, operatorName);

        if (extensionOperator is ExtensionMemberCallable &&
            extensionOperator.isOperator) {
          Logger.debug(
              "[SBinaryExpression] Found extension operator '$operatorName' (late check) for type ${leftOperandValue?.runtimeType}. Calling...");
          final extensionPositionalArgs = [leftOperandValue, rightOperandValue];
          try {
            return extensionOperator.call(this, extensionPositionalArgs, {});
          } on ReturnException catch (e) {
            return e.value; // Should not happen for operators, but handle
          } catch (e) {
            throw RuntimeD4rtException(
                "Error executing extension operator '$operatorName': $e");
          }
        }
        Logger.debug(
            "[SBinaryExpression] No suitable extension operator '$operatorName' found (late check) for type ${leftOperandValue?.runtimeType}.");
      } on RuntimeD4rtException catch (findError) {
        Logger.debug(
            "[SBinaryExpression] No extension member '$operatorName' found (late check) for type ${leftOperandValue?.runtimeType}. Error: ${findError.message}");
        // Fall through to the final standard error below.
      }
    }

    throw RuntimeD4rtException(
        'Unsupported operator ($operator) for types ${leftOperandValue?.runtimeType} and ${rightOperandValue?.runtimeType}');
  }

  @override
  Object? visitIndexExpression(SIndexExpression node) {
    final target = node.target;
    final index = node.index;
    final targetValue = target?.accept<Object?>(this);

    // Handle null-aware indexing: x?[i] returns null if x is null
    if (node.isNullAware && targetValue == null) {
      return null;
    }

    final indexValue = index!.accept<Object?>(this);

    if (targetValue is AsyncSuspensionRequest) return targetValue;
    if (indexValue is AsyncSuspensionRequest) return indexValue;

    if (targetValue is Map) {
      return targetValue[indexValue];
    }
    if (targetValue is String && indexValue is int) {
      return targetValue[indexValue];
    } else if (targetValue is List) {
      if (indexValue is int) {
        if (indexValue < 0 || indexValue >= targetValue.length) {
          throw RuntimeD4rtException('Index out of range: $indexValue');
        }
        return targetValue[indexValue];
      } else {
        throw RuntimeD4rtException('List index must be an integer');
      }
    } else if (targetValue is InterpretedInstance) {
      // Check for class operator [] method
      final operatorMethod = targetValue.findOperator('[]');
      if (operatorMethod != null) {
        Logger.debug(
            "[visitIndexExpression] Found class operator '[]' on ${targetValue.klass.name}. Calling...");
        try {
          return operatorMethod.bind(targetValue).call(this, [indexValue], {});
        } on ReturnException catch (e) {
          return e.value;
        } catch (e) {
          throw RuntimeD4rtException("Error executing class operator '[]': $e");
        }
      }
    } else if (toBridgedInstance(targetValue).$2) {
      final bridgedInstance = toBridgedInstance(targetValue).$1!;
      final bridgedClass = bridgedInstance.bridgedClass;
      final operatorName = '[]';

      final methodAdapter =
          bridgedClass.findInstanceMethodAdapter(operatorName);

      if (methodAdapter != null) {
        Logger.debug(
            "[visitIndexExpression] Found bridged operator '$operatorName' for ${bridgedClass.name}. Calling adapter...");
        try {
          return methodAdapter(
              this, bridgedInstance.nativeObject, [indexValue], {}, null);
        } catch (e, s) {
          Logger.error(
              "[visitIndexExpression] Native exception during bridged operator '$operatorName' on ${bridgedClass.name}: $e\\n$s");
          throw RuntimeD4rtException(
              "Native error during bridged operator '$operatorName' on ${bridgedClass.name}: $e");
        }
      }
      Logger.debug(
          "[visitIndexExpression] Bridged operator '$operatorName' not found directly for ${bridgedClass.name}. Trying extensions.");
    }

    const operatorNameForExtension = '[]';
    try {
      final extensionOperator = environment.findExtensionMember(
          targetValue, operatorNameForExtension);

      if (extensionOperator is ExtensionMemberCallable &&
          extensionOperator.isOperator) {
        Logger.debug(
            "[SIndexExpression] Found extension operator '[]' for type ${targetValue?.runtimeType}. Calling...");
        final extensionPositionalArgs = [targetValue, indexValue];
        try {
          return extensionOperator.call(this, extensionPositionalArgs, {});
        } on ReturnException catch (e) {
          return e.value;
        } catch (e) {
          throw RuntimeD4rtException(
              "Error executing extension operator '[]': $e");
        }
      }
      Logger.debug(
          "[SIndexExpression] No suitable extension operator '[]' found for type ${targetValue?.runtimeType}.");
    } on RuntimeD4rtException catch (findError) {
      Logger.debug(
          "[SIndexExpression] No extension member '[]' found for type ${targetValue?.runtimeType}. Error: ${findError.message}");
    }

    throw RuntimeD4rtException(
        'Unsupported target for indexing: ${targetValue?.runtimeType}');
  }

  @override
  Object? visitAssignmentExpression(SAssignmentExpression node) {
    final lhs = node.leftHandSide;
    // Evaluate RHS once, used by multiple branches below
    Object? rhsValue = node.rightHandSide!.accept<Object?>(this);

    // Handle suspension on the right-hand side
    if (rhsValue is AsyncSuspensionRequest) {
      Logger.debug(
          "[visitAssignmentExpression] RHS suspended. Propagating suspension.");
      // The state machine (_determineNextNodeAfterAwait) will handle resumption.
      // It needs to know this SAssignmentExpression was the context.
      return rhsValue;
    }
    // END NEW

    final operatorType = node.operator;

    // Case 1: Simple variable assignment (lexical or implicit this)
    if (lhs is SSimpleIdentifier) {
      final variableName = lhs.name;

      Environment? definingEnv =
          environment.findDefiningEnvironment(variableName);

      if (definingEnv != null) {
        // Check if the variable is a LateVariable
        final variableValue = definingEnv.get(variableName);
        if (variableValue is LateVariable) {
          if (operatorType == '=') {
            // Simple assignment to late variable
            variableValue.assign(rhsValue);
            return rhsValue;
          } else {
            // Compound assignment to late variable
            final currentValue =
                variableValue.value; // May throw if not initialized
            Object? newValue =
                computeCompoundValue(currentValue, rhsValue, operatorType);
            variableValue.assign(newValue);
            return newValue;
          }
        } else {
          // Regular variable handling
          if (operatorType == '=') {
            return environment.assign(
                variableName, rhsValue); // Use original assign for lexical
          } else {
            // Handle compound assignments on lexical variables
            final currentValue =
                environment.get(variableName); // Get from lexical scope
            Object? newValue =
                computeCompoundValue(currentValue, rhsValue, operatorType);
            return environment.assign(
                variableName, newValue); // Assign back to lexical scope
          }
        }
      } else {
        try {
          final thisInstance = environment.get('this');
          if (thisInstance is InterpretedInstance) {
            if (operatorType == '=') {
              Logger.debug(
                  "[Assignment - implicit this] Checking for direct setter '$variableName' on ${thisInstance.runtimeType}");
              final setter =
                  thisInstance.klass.findInstanceSetter(variableName);
              if (setter != null) {
                Logger.debug(
                    "[Assignment - implicit this] Found direct setter. Calling...");
                // Call setter on 'this'
                setter.bind(thisInstance).call(this, [rhsValue], {});
                return rhsValue; // Assignment expression returns RHS value
              } else {
                Logger.debug(
                    "[Assignment - implicit this] No direct setter found. Trying extension setter for '$variableName' on ${thisInstance.runtimeType}");
                final extensionSetter =
                    environment.findExtensionMember(thisInstance, variableName);
                if (extensionSetter is ExtensionMemberCallable &&
                    extensionSetter.isSetter) {
                  Logger.debug(
                      "[Assignment - implicit this] Found extension setter '$variableName'. Calling...");
                  final extensionPositionalArgs = [
                    thisInstance, // Target is 'this'
                    rhsValue // Value to assign
                  ];
                  try {
                    extensionSetter.call(this, extensionPositionalArgs, {});
                    Logger.debug(
                        "[Assignment - implicit this] Extension setter call finished.");
                    return rhsValue; // Simple assignment returns RHS
                  } catch (e) {
                    throw RuntimeD4rtException(
                        "Error executing extension setter '$variableName' via implicit 'this': $e");
                  }
                } else {
                  Logger.debug(
                      "[Assignment - implicit this] No extension setter found for '$variableName'. Falling back to direct field set.");
                  // Assign directly to field on 'this' (original fallback)
                  // WARNING: This might be incorrect if the intent was purely extension based.
                  // Dart would typically throw if no setter (direct or extension) exists and no field exists.
                  // Consider throwing here if direct field assignment isn't desired.
                  try {
                    thisInstance.set(variableName, rhsValue, this);
                    Logger.debug(
                        "[Assignment - implicit this] Direct field set successful (?).");
                    return rhsValue; // Assignment expression returns RHS value
                  } on RuntimeD4rtException catch (fieldSetError) {
                    Logger.debug(
                        "[Assignment - implicit this] Direct field set failed: ${fieldSetError.message}");
                    // If both direct setter, extension setter, and direct field set fail, THEN throw.
                    throw RuntimeD4rtException(
                        "Cannot assign to '$variableName' on implicit 'this': No setter (direct or extension) or assignable field found.");
                  }
                }
              }
            } else {
              // 1. Get current value from 'this' (field or getter)
              final currentValue = thisInstance
                  .get(variableName); // May throw if undefined on instance

              // 2. Calculate new value
              Object? newValue =
                  computeCompoundValue(currentValue, rhsValue, operatorType);

              // 3. Set new value on 'this' (field or setter)
              final setter =
                  thisInstance.klass.findInstanceSetter(variableName);
              if (setter != null) {
                setter.bind(thisInstance).call(this, [newValue], {});
              } else {
                thisInstance.set(variableName, newValue, this);
              }
              // Compound assignment returns the NEW value
              return newValue;
            }
          } else if (toBridgedInstance(thisInstance).$2) {
            if (rhsValue is BridgedEnumValue) {
              rhsValue = rhsValue.nativeValue;
            }
            final bridgedInstance = toBridgedInstance(thisInstance).$1!;
            final bridgedClass = bridgedInstance.bridgedClass;
            final setterAdapter =
                bridgedClass.findInstanceSetterAdapter(variableName);

            if (setterAdapter != null) {
              if (operatorType == '=') {
                // Simple assignment: this.bridgedProp = value
                Logger.debug(
                    "[Assignment] Assigning to bridged 'this'.$variableName via setter adapter.");
                setterAdapter(this, thisInstance.nativeObject, rhsValue);
                return rhsValue; // Simple assignment returns RHS value
              } else {
                // Compound assignment: this.bridgedProp op= value
                // 1. Get current value (requires a getter adapter)
                final getterAdapter =
                    bridgedClass.findInstanceGetterAdapter(variableName);
                if (getterAdapter == null) {
                  throw RuntimeD4rtException(
                      "Cannot perform compound assignment on '${bridgedClass.name}.$variableName' via implicit 'this': No getter found.");
                }
                final currentValue =
                    getterAdapter(this, thisInstance.nativeObject);
                // 2. Calculate new value
                Object? newValue =
                    computeCompoundValue(currentValue, rhsValue, operatorType);
                // 3. Set new value via setter adapter
                Logger.debug(
                    "[Assignment] Compound assigning to bridged 'this'.$variableName via setter adapter.");
                setterAdapter(this, thisInstance.nativeObject, newValue);
                return newValue; // Compound assignment returns new value
              }
            } else {
              // No setter adapter found
              throw RuntimeD4rtException(
                  "Cannot assign to property '$variableName' on bridged instance of '${bridgedClass.name}' accessed via implicit 'this': No setter found.");
            }
          } else {
            // 'this' exists but is not an InterpretedInstance or BridgedInstance
            throw RuntimeD4rtException(
                "Assigning to undefined variable '$variableName'.");
          }
        } on RuntimeD4rtException catch (e) {
          // If 'this' doesn't exist or getting/setting on 'this' failed
          // Use the original error if it came from get/set, otherwise standard undefined.
          if (e.message.contains("Undefined property '$variableName'") ||
              e.message.contains("Undefined static member")) {
            rethrow; // Propagate specific error from get/set
          }
          throw RuntimeD4rtException(
              "Assigning to undefined variable '$variableName'.");
        }
      }
    }

    // Case 2: SPropertyAccess assignment (target.property op= value)
    else if (lhs is SPropertyAccess) {
      final targetExpression = lhs.target; // Keep expression for check below
      final targetValue = targetExpression?.accept<Object?>(this);
      final propertyName = lhs.propertyName!.name;
      // rhsValue and operatorType already available from the top

      if (targetValue is BoundSuper) {
        // This handles cases like: super.value = expression; or super.value += expression;
        final instance = targetValue.instance;
        final startClass = targetValue.startLookupClass;
        InterpretedClass? currentClass = startClass;
        InterpretedFunction? superSetter;
        InterpretedFunction? superGetter;

        // Look for the setter in the superclass hierarchy starting from startClass
        BridgedClass? bridgedSetter;
        while (currentClass != null) {
          final setter = currentClass.findInstanceSetter(propertyName);
          if (setter != null) {
            superSetter = setter;
            break;
          }
          // Check bridged superclass
          if (currentClass.bridgedSuperclass != null) {
            final bridged = currentClass.bridgedSuperclass!;
            if (bridged.setters.containsKey(propertyName)) {
              bridgedSetter = bridged;
              break;
            }
          }
          currentClass = currentClass.superclass;
        }

        // For compound operators, we also need to get the current value
        Object? currentValue;
        BridgedClass? bridgedGetter;
        if (operatorType != '=') {
          // First try to find a getter
          currentClass = startClass;
          while (currentClass != null) {
            final getter = currentClass.findInstanceGetter(propertyName);
            if (getter != null) {
              superGetter = getter;
              break;
            }
            // Check bridged superclass
            if (currentClass.bridgedSuperclass != null) {
              final bridged = currentClass.bridgedSuperclass!;
              if (bridged.getters.containsKey(propertyName)) {
                bridgedGetter = bridged;
                break;
              }
            }
            currentClass = currentClass.superclass;
          }

          // Get the current value using getter or bridged getter
          if (superGetter != null) {
            currentValue = superGetter.bind(instance).call(this, [], {});
          } else if (bridgedGetter != null) {
            final bridgedTarget = instance.bridgedSuperObject;
            if (bridgedTarget == null) {
              throw RuntimeD4rtException(
                  "Cannot access bridged property '$propertyName': bridgedSuperObject is null");
            }
            currentValue =
                bridgedGetter.getters[propertyName]!(this, bridgedTarget);
          } else {
            // Try to get field value directly
            try {
              currentValue = instance.get(propertyName);
            } catch (e) {
              throw RuntimeD4rtException(
                  "Cannot read '$propertyName' from superclass chain of '${instance.klass.name}' for compound 'super' assignment: $e");
            }
          }
        }

        if (operatorType == '=') {
          // Simple assignment: super.value = rhsValue
          if (superSetter != null) {
            superSetter.bind(instance).call(this, [rhsValue], {});
            return rhsValue;
          } else if (bridgedSetter != null) {
            final bridgedTarget = instance.bridgedSuperObject;
            if (bridgedTarget == null) {
              throw RuntimeD4rtException(
                  "Cannot set bridged property '$propertyName': bridgedSuperObject is null");
            }
            bridgedSetter.setters[propertyName]!(this, bridgedTarget, rhsValue);
            return rhsValue;
          } else {
            // Try direct field assignment
            try {
              instance.set(propertyName, rhsValue);
              return rhsValue;
            } catch (e) {
              throw RuntimeD4rtException(
                  "Setter for '$propertyName' not found in superclass chain of '${instance.klass.name}' for 'super' assignment: $e");
            }
          }
        } else {
          // Compound assignment: super.value += rhsValue, etc.
          // Compute new value
          final newValue =
              computeCompoundValue(currentValue, rhsValue, operatorType);

          // Set new value
          if (superSetter != null) {
            superSetter.bind(instance).call(this, [newValue], {});
          } else if (bridgedSetter != null) {
            final bridgedTarget = instance.bridgedSuperObject;
            if (bridgedTarget == null) {
              throw RuntimeD4rtException(
                  "Cannot set bridged property '$propertyName': bridgedSuperObject is null");
            }
            bridgedSetter.setters[propertyName]!(this, bridgedTarget, newValue);
          } else {
            // Try direct field assignment
            try {
              instance.set(propertyName, newValue);
            } catch (e) {
              throw RuntimeD4rtException(
                  "Cannot set '$propertyName' in superclass chain of '${instance.klass.name}' for compound 'super' assignment: $e");
            }
          }

          return newValue;
        }
      } else if (targetValue is InterpretedInstance) {
        // This code block was accidentally removed or modified, restore it.
        if (operatorType == '=') {
          // Simple assignment: target.property = rhsValue
          final setter = targetValue.klass.findInstanceSetter(propertyName);
          if (setter != null) {
            setter.bind(targetValue).call(this, [rhsValue], {});
            Logger.debug(
                "[Assignment] Assigned via direct setter for '$propertyName'");
            return rhsValue;
          }
          // No direct setter, try extension setter
          final extensionSetter =
              environment.findExtensionMember(targetValue, propertyName);
          if (extensionSetter is ExtensionMemberCallable &&
              extensionSetter.isSetter) {
            Logger.debug(
                "[Assignment] Assigning via extension setter for '$propertyName'");
            final extensionPositionalArgs = [
              targetValue,
              rhsValue
            ]; // Target + value
            try {
              extensionSetter.call(this, extensionPositionalArgs, {});
              return rhsValue;
            } catch (e) {
              throw RuntimeD4rtException(
                  "Error executing extension setter '$propertyName': $e");
            }
          }
          // No direct or extension setter, assign to field
          Logger.debug(
              "[Assignment] No direct or extension setter found for '$propertyName', assigning to field.");
          targetValue.set(propertyName, rhsValue, this);
          return rhsValue; // Simple Assignment returns RHS value
        } else {
          // Compound assignment: target.property op= rhsValue
          // 1. Get current value
          final currentValue = targetValue
              .get(propertyName); // Use instance.get (handles field/getter)
          // 2. Calculate new value
          Object? newValue =
              computeCompoundValue(currentValue, rhsValue, operatorType);
          // 3. Set new value (via setter or direct field access)
          final setter = targetValue.klass.findInstanceSetter(propertyName);
          if (setter != null) {
            setter.bind(targetValue).call(this, [newValue], {});
          } else {
            // Assign directly to field if no setter (using the instance's set method)
            targetValue.set(propertyName, newValue, this);
          }
          return newValue; // Compound returns new value
        }
      }
      // Handle assignment to static property (targetValue is InterpretedClass)
      else if (targetValue is InterpretedClass) {
        if (operatorType == '=') {
          // Simple assignment: Class.property = rhsValue
          final staticSetter = targetValue.findStaticSetter(propertyName);
          if (staticSetter != null) {
            staticSetter.call(this, [rhsValue], {});
          } else {
            // Assign directly to static field if no setter
            targetValue.setStaticField(propertyName, rhsValue);
          }
          return rhsValue; // Simple Assignment returns RHS value
        } else {
          // Compound assignment: Class.property op= rhsValue
          // 1. Get current value (static field or getter)
          Object? currentValue;
          final staticGetter = targetValue.findStaticGetter(propertyName);
          if (staticGetter != null) {
            currentValue = staticGetter.call(this, [], {});
          } else {
            // If no getter, try getting the field directly
            try {
              currentValue = targetValue.getStaticField(propertyName);
            } catch (_) {
              throw RuntimeD4rtException(
                  "Cannot get value for compound assignment on static member '$propertyName'. No getter or field found.");
            }
          }

          // 2. Calculate new value
          Object? newValue =
              computeCompoundValue(currentValue, rhsValue, operatorType);

          // 3. Set new value (static setter or direct field access)
          final staticSetter = targetValue.findStaticSetter(propertyName);
          if (staticSetter != null) {
            staticSetter.call(this, [newValue], {});
          } else {
            targetValue.setStaticField(propertyName, newValue);
          }
          return newValue; // Compound returns new value
        }
      } else if (toBridgedInstance(targetValue).$2) {
        if (rhsValue is BridgedEnumValue) {
          rhsValue = rhsValue.nativeValue;
        }
        final bridgedInstance = toBridgedInstance(targetValue).$1!;
        final setterAdapter = bridgedInstance.bridgedClass
            .findInstanceSetterAdapter(propertyName);

        if (setterAdapter != null) {
          if (operatorType == '=') {
            // Simple assignment: bridgedInstance.property = value
            Logger.debug(
                "[Assignment] Assigning to bridged instance property '${bridgedInstance.bridgedClass.name}.$propertyName' via setter adapter.");
            setterAdapter(this, bridgedInstance.nativeObject, rhsValue);
            return rhsValue; // Simple assignment returns RHS value
          } else {
            // Compound assignment: bridgedInstance.property op= value
            // 1. Get current value (requires a getter adapter)
            final getterAdapter = bridgedInstance.bridgedClass
                .findInstanceGetterAdapter(propertyName);
            if (getterAdapter == null) {
              throw RuntimeD4rtException(
                  "Cannot perform compound assignment on '${bridgedInstance.bridgedClass.name}.$propertyName': No getter adapter found.");
            }
            final currentValue =
                getterAdapter(this, bridgedInstance.nativeObject);
            // 2. Calculate new value
            Object? newValue =
                computeCompoundValue(currentValue, rhsValue, operatorType);
            // 3. Set new value via setter adapter
            Logger.debug(
                "[Assignment] Compound assigning to bridged instance property '${bridgedInstance.bridgedClass.name}.$propertyName' via setter adapter.");
            setterAdapter(this, bridgedInstance.nativeObject, newValue);
            return newValue; // Compound assignment returns new value
          }
        } else {
          // No setter adapter found
          throw RuntimeD4rtException(
              "Cannot assign to property '$propertyName' on bridged instance of '${bridgedInstance.bridgedClass.name}': No setter adapter found.");
        }
      } else if (targetValue is BoundBridgedSuper) {
        if (rhsValue is BridgedEnumValue) {
          rhsValue = rhsValue.nativeValue;
        }
        // This handles: super.property = rhsValue; or super.property += rhsValue;
        final instance = targetValue.instance; // Instance 'this'
        final bridgedSuper = targetValue.startLookupClass;
        final nativeSuperObject = instance.bridgedSuperObject;

        if (nativeSuperObject == null) {
          throw RuntimeD4rtException(
              "Internal error: Cannot assign to super property '$propertyName' on bridged superclass '${bridgedSuper.name}' because the native super object is missing.");
        }

        // Find the bridged setter adapter
        final setterAdapter =
            bridgedSuper.findInstanceSetterAdapter(propertyName);

        if (operatorType == '=') {
          // Simple assignment
          if (setterAdapter != null) {
            try {
              // Call the setter adapter with the native object and the new value
              setterAdapter(this, nativeSuperObject, rhsValue);
              return rhsValue; // Assignment returns the right value
            } catch (e, s) {
              Logger.error(
                  "Native exception during super assignment to bridged setter '${bridgedSuper.name}.$propertyName': $e\\n$s");
              throw RuntimeD4rtException(
                  "Native error during super assignment to bridged setter '$propertyName': $e");
            }
          } else {
            // No setter found
            throw RuntimeD4rtException(
                "Setter for '$propertyName' not found in bridged superclass '${bridgedSuper.name}' for 'super' assignment.");
          }
        } else {
          // Compound assignment: super.property += rhsValue, etc.
          // Need both getter and setter
          final getterAdapter =
              bridgedSuper.findInstanceGetterAdapter(propertyName);
          if (getterAdapter == null) {
            throw RuntimeD4rtException(
                "Cannot perform compound assignment on bridged super property '${bridgedSuper.name}.$propertyName': No getter adapter found.");
          }
          if (setterAdapter == null) {
            throw RuntimeD4rtException(
                "Cannot perform compound assignment on bridged super property '${bridgedSuper.name}.$propertyName': No setter adapter found.");
          }

          try {
            // Get current value
            final currentValue = getterAdapter(this, nativeSuperObject);

            // Compute new value
            final newValue =
                computeCompoundValue(currentValue, rhsValue, operatorType);

            // Set new value
            setterAdapter(this, nativeSuperObject, newValue);

            return newValue;
          } catch (e, s) {
            Logger.error(
                "Native exception during compound super assignment to bridged property '${bridgedSuper.name}.$propertyName': $e\\n$s");
            throw RuntimeD4rtException(
                "Native error during compound super assignment to bridged property '$propertyName': $e");
          }
        }
      } else {
        throw RuntimeD4rtException(
            "Assignment target must be an instance, class, or super property, got ${targetValue?.runtimeType}.");
      }
    }
    // Case 3: SPrefixedIdentifier assignment (prefix.identifier op= value)
    else if (lhs is SPrefixedIdentifier) {
      final target = lhs.prefix!.accept<Object?>(this);
      final propertyName = lhs.identifier!.name;
      // rhsValue and operatorType already available from the top

      if (target is InterpretedInstance) {
        if (operatorType == '=') {
          // Simple assignment: target.property = rhsValue
          final setter = target.klass.findInstanceSetter(propertyName);
          if (setter != null) {
            setter.bind(target).call(this, [rhsValue], {});
            Logger.debug(
                "[Assignment] Assigned via direct setter for SPrefixedIdentifier '$propertyName'");
            return rhsValue;
          }

          final extensionSetter =
              environment.findExtensionMember(target, propertyName);
          if (extensionSetter is ExtensionMemberCallable &&
              extensionSetter.isSetter) {
            Logger.debug(
                "[Assignment] Assigning via extension setter for SPrefixedIdentifier '$propertyName'");
            final extensionPositionalArgs = [
              target,
              rhsValue
            ]; // Target + value
            try {
              extensionSetter.call(this, extensionPositionalArgs, {});
              return rhsValue;
            } catch (e) {
              throw RuntimeD4rtException(
                  "Error executing extension setter '$propertyName': $e");
            }
          }

          Logger.debug(
              "[Assignment] No direct or extension setter found for SPrefixedIdentifier '$propertyName', assigning to field.");
          target.set(propertyName, rhsValue, this);
          return rhsValue; // Simple Assignment returns RHS value
        } else {
          // Compound assignment: target.property op= rhsValue
          final currentValue = target.get(propertyName);
          Object? newValue =
              computeCompoundValue(currentValue, rhsValue, operatorType);
          final setter = target.klass.findInstanceSetter(propertyName);
          if (setter != null) {
            setter.bind(target).call(this, [newValue], {});
          } else {
            target.set(propertyName, newValue, this);
          }
          return newValue; // Compound returns new value
        }
      } else if (target is InterpretedClass) {
        if (operatorType == '=') {
          // Simple assignment: Class.property = rhsValue
          final staticSetter = target.findStaticSetter(propertyName);
          if (staticSetter != null) {
            staticSetter.call(this, [rhsValue], {});
          } else {
            // Assign directly to static field if no setter
            target.setStaticField(propertyName, rhsValue);
          }
          return rhsValue; // Simple Assignment returns RHS value
        } else {
          // Compound assignment: Class.property op= rhsValue
          Object? currentValue;
          final staticGetter = target.findStaticGetter(propertyName);
          if (staticGetter != null) {
            currentValue = staticGetter.call(this, [], {});
          } else {
            try {
              currentValue = target.getStaticField(propertyName);
            } catch (_) {
              throw RuntimeD4rtException(
                  "Cannot get value for compound assignment on static member '$propertyName'. No getter or field found.");
            }
          }
          Object? newValue =
              computeCompoundValue(currentValue, rhsValue, operatorType);
          final staticSetter = target.findStaticSetter(propertyName);
          if (staticSetter != null) {
            staticSetter.call(this, [newValue], {});
          } else {
            target.setStaticField(propertyName, newValue);
          }
          return newValue; // Compound returns new value
        }
      } else if (target is BridgedClass) {
        final bridgedClass = target;
        if (operatorType == '=') {
          // Simple assignment: BridgedClass.property = rhsValue
          final staticSetter =
              bridgedClass.findStaticSetterAdapter(propertyName);
          if (staticSetter == null) {
            throw RuntimeD4rtException(
                "Bridged class '${bridgedClass.name}' has no static setter named '$propertyName'.");
          }
          Logger.debug(
              "[Assignment] Assigning to static bridged property '${bridgedClass.name}.$propertyName' via setter adapter.");
          staticSetter(this, rhsValue);
          return rhsValue; // Simple Assignment returns RHS value
        } else {
          // Compound assignment: BridgedClass.property op= rhsValue
          // 1. Get current static value
          final staticGetter =
              bridgedClass.findStaticGetterAdapter(propertyName);
          if (staticGetter == null) {
            throw RuntimeD4rtException(
                "Cannot perform compound assignment on static '${bridgedClass.name}.$propertyName': No static getter found.");
          }
          final currentValue = staticGetter(this);
          // 2. Calculate new value
          Object? newValue =
              computeCompoundValue(currentValue, rhsValue, operatorType);
          // 3. Set new static value
          final staticSetter =
              bridgedClass.findStaticSetterAdapter(propertyName);
          if (staticSetter == null) {
            // Should have been caught by getter check, but defensive programming
            throw RuntimeD4rtException(
                "Cannot perform compound assignment on static '${bridgedClass.name}.$propertyName': No static setter found after getter.");
          }
          Logger.debug(
              "[Assignment] Compound assigning to static bridged property '${bridgedClass.name}.$propertyName' via setter adapter.");
          staticSetter(this, newValue);
          return newValue; // Compound returns new value
        }
      } else if (target is InterpretedExtension) {
        final extension = target;
        if (operatorType == '=') {
          // Simple assignment: Extension.staticField = rhsValue
          final staticSetter = extension.findStaticSetter(propertyName);
          if (staticSetter != null) {
            staticSetter.call(this, [rhsValue], {});
            Logger.debug(
                "[Assignment] Assigned to static extension property '${extension.name ?? '<unnamed>'}.$propertyName' via setter.");
          } else if (extension.staticFields.containsKey(propertyName)) {
            extension.setStaticField(propertyName, rhsValue);
            Logger.debug(
                "[Assignment] Assigned to static extension field '${extension.name ?? '<unnamed>'}.$propertyName'.");
          } else {
            throw RuntimeD4rtException(
                "Extension '${extension.name ?? '<unnamed>'}' has no static setter or field named '$propertyName'.");
          }
          return rhsValue;
        } else {
          // Compound assignment: Extension.property op= rhsValue
          // 1. Get current value
          Object? currentValue;
          final staticGetter = extension.findStaticGetter(propertyName);
          if (staticGetter != null) {
            currentValue = staticGetter.call(this, [], {});
          } else if (extension.staticFields.containsKey(propertyName)) {
            currentValue = extension.getStaticField(propertyName);
          } else {
            throw RuntimeD4rtException(
                "Cannot get value for compound assignment on static extension member '$propertyName'. No getter or field found.");
          }
          // 2. Calculate new value
          Object? newValue =
              computeCompoundValue(currentValue, rhsValue, operatorType);
          // 3. Set new value
          final staticSetter = extension.findStaticSetter(propertyName);
          if (staticSetter != null) {
            staticSetter.call(this, [newValue], {});
          } else if (extension.staticFields.containsKey(propertyName)) {
            extension.setStaticField(propertyName, newValue);
          } else {
            throw RuntimeD4rtException(
                "Cannot set value for compound assignment on static extension member '$propertyName'. No setter or field found.");
          }
          return newValue;
        }
      } else if (toBridgedInstance(target).$2) {
        if (rhsValue is BridgedEnumValue) {
          rhsValue = rhsValue.nativeValue;
        }
        final bridgedInstance = toBridgedInstance(target).$1!;

        final setterAdapter = bridgedInstance.bridgedClass
            .findInstanceSetterAdapter(propertyName);

        if (setterAdapter != null) {
          if (operatorType == '=') {
            // Simple assignment: bridgedInstance.property = value
            Logger.debug(
                "[Assignment - SPropertyAccess] Assigning to bridged instance property '${bridgedInstance.bridgedClass.name}.$propertyName' via setter adapter.");
            setterAdapter(this, bridgedInstance.nativeObject, rhsValue);
            return rhsValue; // Simple assignment returns RHS value
          } else {
            // Compound assignment: bridgedInstance.property op= value
            // 1. Get current value (requires a getter adapter)
            final getterAdapter = bridgedInstance.bridgedClass
                .findInstanceGetterAdapter(propertyName);
            if (getterAdapter == null) {
              throw RuntimeD4rtException(
                  "Cannot perform compound assignment on '${bridgedInstance.bridgedClass.name}.$propertyName': No getter adapter found.");
            }
            final currentValue =
                getterAdapter(this, bridgedInstance.nativeObject);
            // 2. Calculate new value
            Object? newValue =
                computeCompoundValue(currentValue, rhsValue, operatorType);
            // 3. Set new value via setter adapter
            Logger.debug(
                "[Assignment - SPropertyAccess] Compound assigning to bridged instance property '${bridgedInstance.bridgedClass.name}.$propertyName' via setter adapter.");
            setterAdapter(this, bridgedInstance.nativeObject, newValue);
            return newValue; // Compound assignment returns new value
          }
        } else {
          // No setter adapter found
          throw RuntimeD4rtException(
              "Cannot assign to property '$propertyName' on bridged instance of '${bridgedInstance.bridgedClass.name}': No setter adapter found.");
        }
      } else {
        throw RuntimeD4rtException(
            "Assignment target must be an instance or class for SPrefixedIdentifier, got ${target?.runtimeType}.");
      }
    } else {
      if (lhs is SIndexExpression) {
        final targetValue = lhs.target?.accept<Object?>(this);
        final indexValue = lhs.index!.accept<Object?>(this);

        // Determine the value to actually assign
        Object? finalValueToAssign;
        if (operatorType == '=') {
          finalValueToAssign = rhsValue; // Simple assignment
        } else {
          // Compound assignment (e.g., list[i] += 10)
          // 1. Get current value using index operator []
          Object? currentValue;
          if (targetValue is Map) {
            currentValue = targetValue[indexValue];
          } else if (targetValue is List && indexValue is int) {
            if (indexValue < 0 || indexValue >= targetValue.length) {
              throw RuntimeD4rtException(
                  'Index out of range for compound assignment read: $indexValue');
            }
            currentValue = targetValue[indexValue];
          } else if (targetValue is InterpretedInstance) {
            // Check for class operator [] method for reading current value
            final operatorMethod = targetValue.findOperator('[]');
            if (operatorMethod != null) {
              try {
                currentValue = operatorMethod
                    .bind(targetValue)
                    .call(this, [indexValue], {});
              } on ReturnException catch (e) {
                currentValue = e.value;
              } catch (e) {
                throw RuntimeD4rtException(
                    "Error executing class operator '[]' for compound read: $e");
              }
            } else {
              // No class operator found, try extensions
              try {
                final extensionGetter =
                    environment.findExtensionMember(targetValue, '[]');
                if (extensionGetter is ExtensionMemberCallable &&
                    extensionGetter.isOperator) {
                  final extensionPositionalArgs = [targetValue, indexValue];
                  try {
                    currentValue =
                        extensionGetter.call(this, extensionPositionalArgs, {});
                  } on ReturnException catch (e) {
                    currentValue = e.value;
                  } catch (e) {
                    throw RuntimeD4rtException(
                        "Error executing extension operator '[]' for compound read: $e");
                  }
                } else {
                  throw RuntimeD4rtException(
                      'Cannot read current value for compound index assignment on ${targetValue.klass.name}: No operator [] found (class or extension).');
                }
              } on RuntimeD4rtException catch (e) {
                throw RuntimeD4rtException(
                    'Cannot read current value for compound index assignment on ${targetValue.klass.name}: ${e.message}');
              }
            }
          } else if (toBridgedInstance(targetValue).$2) {
            // Handle BridgedInstance for reading current value via [] operator
            final bridgedInstance = toBridgedInstance(targetValue).$1!;
            final bridgedClass = bridgedInstance.bridgedClass;
            final operatorName = '[]';

            final methodAdapter =
                bridgedClass.findInstanceMethodAdapter(operatorName);
            if (methodAdapter != null) {
              Logger.debug(
                  "[visitAssignmentExpression-Index] Found bridged operator '$operatorName' for ${bridgedClass.name}. Calling adapter for compound read...");
              try {
                currentValue = methodAdapter(
                    this, bridgedInstance.nativeObject, [indexValue], {}, null);
              } catch (e, s) {
                Logger.error(
                    "[visitAssignmentExpression-Index] Native exception during bridged operator '$operatorName' read on ${bridgedClass.name}: $e\\n$s");
                throw RuntimeD4rtException(
                    "Native error during bridged operator '$operatorName' read on ${bridgedClass.name}: $e");
              }
            } else {
              throw RuntimeD4rtException(
                  'Cannot read current value for compound index assignment on ${bridgedClass.name}: No bridged operator [] found.');
            }
          } else {
            try {
              final extensionGetter =
                  environment.findExtensionMember(targetValue, '[]');
              if (extensionGetter is ExtensionMemberCallable &&
                  extensionGetter.isOperator) {
                final extensionPositionalArgs = [targetValue, indexValue];
                try {
                  currentValue =
                      extensionGetter.call(this, extensionPositionalArgs, {});
                } on ReturnException catch (e) {
                  currentValue = e.value;
                } // Handle potential returns
                catch (e) {
                  throw RuntimeD4rtException(
                      "Error executing extension operator '[]' for compound read: $e");
                }
              } else {
                throw RuntimeD4rtException(
                    'Cannot read current value for compound index assignment on type ${targetValue?.runtimeType}: No standard or extension operator [] found.');
              }
            } on RuntimeD4rtException catch (e) {
              throw RuntimeD4rtException(
                  'Cannot read current value for compound index assignment on type ${targetValue?.runtimeType}: ${e.message}');
            }
          }

          // 2. Calculate the new value
          finalValueToAssign =
              computeCompoundValue(currentValue, rhsValue, operatorType);
        }

        // Now, perform the assignment with finalValueToAssign
        if (targetValue is Map) {
          targetValue[indexValue] = finalValueToAssign;
          return finalValueToAssign;
        } else if (targetValue is List && indexValue is int) {
          if (indexValue < 0 || indexValue >= targetValue.length) {
            throw RuntimeD4rtException(
                'Index out of range for assignment: $indexValue');
          }
          targetValue[indexValue] = finalValueToAssign;
          return finalValueToAssign;
        } else if (targetValue is InterpretedInstance) {
          // Check for class operator []= method
          final operatorMethod = targetValue.findOperator('[]=');
          if (operatorMethod != null) {
            Logger.debug(
                "[visitAssignmentExpression-Index] Found class operator '[]=' on ${targetValue.klass.name}. Calling...");
            try {
              operatorMethod
                  .bind(targetValue)
                  .call(this, [indexValue, finalValueToAssign], {});
              return finalValueToAssign;
            } on ReturnException catch (_) {
              return finalValueToAssign; // []= should not return a value, but assignment expression returns assigned value
            } catch (e) {
              throw RuntimeD4rtException(
                  "Error executing class operator '[]=': $e");
            }
          } else {
            // No class operator found, try extensions
            const operatorName = '[]=';
            try {
              final extensionSetter =
                  environment.findExtensionMember(targetValue, operatorName);
              if (extensionSetter is ExtensionMemberCallable &&
                  extensionSetter.isOperator) {
                Logger.debug(
                    "[Assignment] Found extension operator '[]=' for ${targetValue.klass.name}. Calling...");
                // Args: receiver (targetValue), index (indexValue), value (finalValueToAssign)
                final extensionPositionalArgs = [
                  targetValue,
                  indexValue,
                  finalValueToAssign
                ];
                try {
                  extensionSetter.call(this, extensionPositionalArgs, {});
                  // '[]=' operator should not return a meaningful value, but the assignment expression returns the assigned value
                  return finalValueToAssign;
                } catch (e) {
                  throw RuntimeD4rtException(
                      "Error executing extension operator '[]=': $e");
                }
              } else {
                throw RuntimeD4rtException(
                    'Cannot assign to index on ${targetValue.klass.name}: No operator []= found (class or extension).');
              }
            } on RuntimeD4rtException catch (findError) {
              throw RuntimeD4rtException(
                  'Cannot assign to index on ${targetValue.klass.name}: ${findError.message}');
            }
          }
        } else if (toBridgedInstance(targetValue).$2) {
          final bridgedInstance = toBridgedInstance(targetValue).$1!;
          final bridgedClass = bridgedInstance.bridgedClass;
          final operatorName = '[]=';

          final methodAdapter =
              bridgedClass.findInstanceMethodAdapter(operatorName);
          if (methodAdapter != null) {
            Logger.debug(
                "[visitAssignmentExpression-Index] Found bridged operator '$operatorName' for ${bridgedClass.name}. Calling adapter...");
            try {
              methodAdapter(this, bridgedInstance.nativeObject,
                  [indexValue, finalValueToAssign], {}, null);
              return finalValueToAssign;
            } catch (e, s) {
              Logger.error(
                  "[visitAssignmentExpression-Index] Native exception during bridged operator '$operatorName' on ${bridgedClass.name}: $e\\n$s");
              throw RuntimeD4rtException(
                  "Native error during bridged operator '$operatorName' on ${bridgedClass.name}: $e");
            }
          }
          throw RuntimeD4rtException(
              "[Bridged operator '$operatorName' not found directly for ${bridgedClass.name}. Trying extensions.");
        } else {
          const operatorName = '[]=';
          try {
            final extensionSetter =
                environment.findExtensionMember(targetValue, operatorName);
            if (extensionSetter is ExtensionMemberCallable &&
                extensionSetter.isOperator) {
              Logger.debug(
                  "[Assignment] Found extension operator '[]=' for type ${targetValue?.runtimeType}. Calling...");
              // Args: receiver (targetValue), index (indexValue), value (finalValueToAssign)
              final extensionPositionalArgs = [
                targetValue,
                indexValue,
                finalValueToAssign
              ];
              try {
                extensionSetter.call(this, extensionPositionalArgs, {});
                // '[]=' operator should not return a meaningful value, but the assignment expression returns the assigned value
                return finalValueToAssign;
              } catch (e) {
                throw RuntimeD4rtException(
                    "Error executing extension operator '[]=': $e");
              }
            } // else: No suitable extension operator found, fall through
            Logger.debug(
                "[Assignment] No suitable extension operator '[]=' found for type ${targetValue?.runtimeType}.");
          } on RuntimeD4rtException catch (findError) {
            Logger.debug(
                "[Assignment] No extension member '[]=' found for type ${targetValue?.runtimeType}. Error: ${findError.message}");
            // Fall through to the final error
          }

          // If neither standard nor extension assignment worked
          throw RuntimeD4rtException(
              'Unsupported target for index assignment: ${targetValue?.runtimeType}');
        }
      } else {
        throw UnimplementedD4rtException(
            'Assignation à une cible non gérée: ${lhs.runtimeType}');
      }
    }
  }

  @override
  Object? visitMethodInvocation(SMethodInvocation node) {
    Object? calleeValue;
    Object? targetValue; // Keep track of the target object/class
    // Argument lists - declared here, evaluated later if needed

    // Determine if this is a conditional call by inspecting the source
    final isNullAware = node.toString().contains('?.');

    if (node.target == null) {
      // Simple function call (or class constructor call)
      calleeValue = node.methodName!.accept<Object?>(this);
      targetValue = null; // No target
    } else {
      // Property/Method call on a target (instance or class)
      targetValue = node.target!.accept<Object?>(this);
      final methodName = node.methodName!.name;

      // Null safety support: if the target is null and the call is null-aware, return null
      if (targetValue == null) {
        if (isNullAware) {
          return null;
        }
        throw RuntimeD4rtException(
            "Cannot invoke method '$methodName' on null. Use '?.' for null-aware method invocation.");
      }

      // BLOCK FOR HANDLING PREFIXED IMPORTS
      if (targetValue is Environment) {
        Logger.debug(
            "[SMethodInvocation] Target is an Environment (prefixed import '${node.target!.toString()}'). Looking for method '$methodName' in this environment.");
        try {
          calleeValue = targetValue.get(methodName);
          // The 'targetValue' for the call will be null because this is not an instance method on the environment itself,
          // but a function retrieved from this environment.
          // Functions obtained in this way are already "autonomous" or correctly bound if they come from classes.
        } on RuntimeD4rtException catch (e) {
          throw RuntimeD4rtException(
              "Method '$methodName' not found in imported module '${node.target!.toString()}'. Error: ${e.message}");
        }
        // calleeValue is now the function/method of the imported module.
        // The call logic will be handled in the final visitMethodInvocation.
      } else if (targetValue is InterpretedInstance) {
        // Instance method call
        try {
          // Get should return the BOUND method
          calleeValue = targetValue.get(methodName);
          Logger.debug(
              "[SMethodInvocation] Found direct instance member '$methodName' on ${targetValue.klass.name}. Type: ${calleeValue?.runtimeType}");
        } on RuntimeD4rtException catch (e) {
          if (e.message.contains("Undefined property '$methodName'")) {
            Logger.debug(
                "[SMethodInvocation] Direct instance method '$methodName' failed/not found on ${targetValue.klass.name}. Error: ${e.message}. Trying extension method...");
            try {
              final extensionCallable =
                  environment.findExtensionMember(targetValue, methodName);

              if (extensionCallable is ExtensionMemberCallable &&
                  !extensionCallable
                      .isOperator && // Ensure it's a regular method
                  !extensionCallable.isGetter &&
                  !extensionCallable.isSetter) {
                Logger.debug(
                    "[SMethodInvocation] Found extension method '$methodName'. Evaluating args and calling...");

                // Evaluate arguments (must be done here as direct call failed)
                final evaluationResult =
                    _evaluateArgumentsAsync(node.argumentList);
                if (evaluationResult is AsyncSuspensionRequest) {
                  return evaluationResult; // Propagate suspension
                }
                final (positionalArgs, namedArgs) =
                    evaluationResult as (List<Object?>, Map<String, Object?>);
                List<RuntimeType>? evaluatedTypeArguments;
                final typeArgsNode = node.typeArguments;
                if (typeArgsNode != null) {
                  evaluatedTypeArguments = typeArgsNode.arguments
                      .map((typeNode) => _resolveTypeAnnotation(typeNode))
                      .toList();
                }

                // Prepare arguments for extension method:
                // First arg is the receiver (the target instance)
                final extensionPositionalArgs = [
                  targetValue,
                  ...positionalArgs
                ];

                // Call the extension method
                try {
                  // Return the result of the extension call directly
                  return extensionCallable.call(this, extensionPositionalArgs,
                      namedArgs, evaluatedTypeArguments);
                } on ReturnException catch (returnExc) {
                  return returnExc.value;
                } catch (execError) {
                  throw RuntimeD4rtException(
                      "Error executing extension method '$methodName': $execError");
                }
              } else {
                // No suitable extension found - check for noSuchMethod
                Logger.debug(
                    "[SMethodInvocation] Extension method '$methodName' not found or not applicable. Checking for noSuchMethod...");

                // Bug-78 FIX: Check for noSuchMethod before throwing error
                final noSuchMethod =
                    targetValue.klass.findInstanceMethod('noSuchMethod');
                if (noSuchMethod != null) {
                  Logger.debug(
                      "[SMethodInvocation] Found noSuchMethod on ${targetValue.klass.name}. Invoking...");

                  // Evaluate arguments for the noSuchMethod call
                  final evaluationResult =
                      _evaluateArgumentsAsync(node.argumentList);
                  if (evaluationResult is AsyncSuspensionRequest) {
                    return evaluationResult;
                  }
                  final (positionalArgs, namedArgs) =
                      evaluationResult as (List<Object?>, Map<String, Object?>);

                  // Create an Invocation.method for this method call
                  final namedArgsSymbol = namedArgs
                      .map((key, value) => MapEntry(Symbol(key), value));
                  final invocation = Invocation.method(
                      Symbol(methodName), positionalArgs, namedArgsSymbol);

                  final boundNoSuchMethod = noSuchMethod.bind(targetValue);
                  try {
                    return boundNoSuchMethod.call(this, [invocation], {});
                  } on ReturnException catch (returnExc) {
                    return returnExc.value;
                  }
                }

                throw RuntimeD4rtException(
                    "Instance of '${targetValue.klass.name}' has no method named '$methodName' and no suitable extension method found. Original error: (${e.message})");
              }
            } on RuntimeD4rtException catch (findError) {
              // Error during the findExtensionMember call itself
              Logger.debug(
                  "[SMethodInvocation] Error during extension lookup for '$methodName': ${findError.message}. Checking for noSuchMethod...");

              // Bug-78 FIX: Check for noSuchMethod before throwing error
              final noSuchMethod =
                  targetValue.klass.findInstanceMethod('noSuchMethod');
              if (noSuchMethod != null) {
                Logger.debug(
                    "[SMethodInvocation] Found noSuchMethod on ${targetValue.klass.name}. Invoking...");

                // Evaluate arguments for the noSuchMethod call
                final evaluationResult =
                    _evaluateArgumentsAsync(node.argumentList);
                if (evaluationResult is AsyncSuspensionRequest) {
                  return evaluationResult;
                }
                final (positionalArgs, namedArgs) =
                    evaluationResult as (List<Object?>, Map<String, Object?>);

                // Create an Invocation.method for this method call
                final namedArgsSymbol =
                    namedArgs.map((key, value) => MapEntry(Symbol(key), value));
                final invocation = Invocation.method(
                    Symbol(methodName), positionalArgs, namedArgsSymbol);

                final boundNoSuchMethod = noSuchMethod.bind(targetValue);
                try {
                  return boundNoSuchMethod.call(this, [invocation], {});
                } on ReturnException catch (returnExc) {
                  return returnExc.value;
                }
              }

              throw RuntimeD4rtException(
                  "Instance of '${targetValue.klass.name}' has no method named '$methodName'. Error during extension lookup: ${findError.message}. Original error: (${e.message})");
            }
          } else {
            // The error during direct get() wasn't "Undefined property", rethrow it
            rethrow;
          }
        }
        // We check if it's callable later (if direct lookup succeeded)
      } else if (targetValue is InterpretedEnumValue) {
        try {
          // Get should return the BOUND method (or execute getter)
          // Pass the visitor to potentially execute getters
          calleeValue = targetValue.get(methodName, this);
          Logger.debug(
              "[SMethodInvocation] Found enum instance member '$methodName' on $targetValue. Type: ${calleeValue?.runtimeType}");
        } on RuntimeD4rtException catch (e) {
          // Try Extension Method if Direct Fails (similar to InterpretedInstance)
          if (e.message.contains("Undefined property '$methodName'")) {
            Logger.debug(
                "[SMethodInvocation] Direct enum method '$methodName' failed/not found on $targetValue. Error: ${e.message}. Trying extension method...");
            try {
              final extensionCallable =
                  environment.findExtensionMember(targetValue, methodName);
              if (extensionCallable is ExtensionMemberCallable &&
                  !extensionCallable.isOperator &&
                  !extensionCallable.isGetter &&
                  !extensionCallable.isSetter) {
                Logger.debug(
                    "[SMethodInvocation] Found extension method '$methodName' for enum value. Evaluating args and calling...");
                final evaluationResult =
                    _evaluateArgumentsAsync(node.argumentList);
                if (evaluationResult is AsyncSuspensionRequest) {
                  return evaluationResult; // Propagate suspension
                }
                final (positionalArgs, namedArgs) =
                    evaluationResult as (List<Object?>, Map<String, Object?>);
                List<RuntimeType>?
                    evaluatedTypeArguments; // Handle type args if needed

                final extensionPositionalArgs = [
                  targetValue,
                  ...positionalArgs
                ];
                try {
                  return extensionCallable.call(this, extensionPositionalArgs,
                      namedArgs, evaluatedTypeArguments);
                } on ReturnException catch (returnExc) {
                  return returnExc.value;
                } catch (execError) {
                  throw RuntimeD4rtException(
                      "Error executing extension method '$methodName' on enum value: $execError");
                }
              } else {
                if (methodName == 'toString') {
                  return targetValue.toString();
                } else if (methodName == 'runtimeType') {
                  return targetValue.runtimeType;
                }
                Logger.debug(
                    "[SMethodInvocation] Extension method '$methodName' for enum value not found or not applicable. Rethrowing original error.");
                throw RuntimeD4rtException(
                    "Enum value '$targetValue' has no method named '$methodName' and no suitable extension method found. Original error: (${e.message})");
              }
            } on RuntimeD4rtException catch (findError) {
              Logger.debug(
                  "[SMethodInvocation] Error during extension lookup for '$methodName' on enum value: ${findError.message}. Rethrowing original error.");
              throw RuntimeD4rtException(
                  "Enum value '$targetValue' has no method named '$methodName'. Error during extension lookup: ${findError.message}. Original error: (${e.message})");
            }
          } else {
            rethrow; // Rethrow other errors from get()
          }
        }
      } else if (toBridgedInstance(targetValue).$2) {
        final bridgedInstance = toBridgedInstance(targetValue).$1!;
        final bridgedClass = bridgedInstance.bridgedClass;
        switch (methodName) {
          case 'toString':
            return targetValue.toString();
          default:
        }
        // Use directly methods because we need the BridgedMethodCallable
        final adapter = bridgedClass.methods[methodName];

        if (adapter != null) {
          final evaluationResult = _evaluateArgumentsAsync(node.argumentList);
          if (evaluationResult is AsyncSuspensionRequest) {
            return evaluationResult; // Propagate suspension
          }
          final (positionalArgs, namedArgs) =
              evaluationResult as (List<Object?>, Map<String, Object?>);

          try {
            // Call the adapter with the native object
            return adapter(this, bridgedInstance.nativeObject, positionalArgs,
                namedArgs, null);
          } on ReturnException catch (e) {
            // Native calls shouldn't throw ReturnException directly, but handle defensively
            return e.value;
          } catch (e, s) {
            // Add the stack trace for debugging
            Logger.log("Native Error Stack Trace: $s"); // Print stack trace
            // Catch potential errors from the native code/adapter
            throw RuntimeD4rtException(
                "Native error during bridged method call '$methodName' on ${bridgedClass.name}: $e");
          }
        } else {
          // No adapter found for this method name, try extension methods
          Logger.debug(
              "[visitMethodInvocation] Bridged method '$methodName' not found directly for ${bridgedClass.name}. Trying extensions.");
          try {
            final extensionMethod =
                environment.findExtensionMember(targetValue, methodName);
            if (extensionMethod is ExtensionMemberCallable) {
              Logger.debug(
                  "[visitMethodInvocation] Found extension method '$methodName' for ${bridgedClass.name}. Calling...");
              final evaluationResult =
                  _evaluateArgumentsAsync(node.argumentList);
              if (evaluationResult is AsyncSuspensionRequest) {
                return evaluationResult; // Propagate suspension
              }
              final (positionalArgs, namedArgs) =
                  evaluationResult as (List<Object?>, Map<String, Object?>);

              final extensionArgs = <Object?>[targetValue];
              extensionArgs.addAll(positionalArgs);
              return extensionMethod.call(this, extensionArgs, namedArgs);
            } else {
              throw RuntimeD4rtException(
                  "Bridged class '${bridgedClass.name}' has no instance method named '$methodName'.");
            }
          } on RuntimeD4rtException catch (findError) {
            throw RuntimeD4rtException(
                "Bridged class '${bridgedClass.name}' has no instance method named '$methodName'. Error during extension lookup: ${findError.message}");
          }
        }
        // Note: This block returns directly or throws, it does not set calleeValue.
      }
      // Handle static method call OR NAMED CONSTRUCTOR call
      else if (targetValue is InterpretedClass) {
        // Check for NAMED CONSTRUCTOR first
        final namedConstructor = targetValue.findConstructor(methodName);
        if (namedConstructor != null) {
          // It's a named constructor call
          // G-DOV2-3 FIX: Check abstract AFTER finding constructor, skip if factory
          if (targetValue.isAbstract && !namedConstructor.isFactory) {
            throw RuntimeD4rtException(
                "Cannot instantiate abstract class '${targetValue.name}'.");
          }

          final evaluationResult = _evaluateArgumentsAsync(node.argumentList);
          if (evaluationResult is AsyncSuspensionRequest) {
            return evaluationResult; // Propagate suspension
          }
          final (positionalArgs, namedArgs) =
              evaluationResult as (List<Object?>, Map<String, Object?>);

          try {
            // Handle factory constructors differently from regular constructors
            if (namedConstructor.isFactory) {
              // Factory constructors should create and return their own instance
              // Do NOT create an instance beforehand
              Logger.debug(
                  "[SMethodInvocation] Calling factory constructor '$methodName' directly");
              final result =
                  namedConstructor.call(this, positionalArgs, namedArgs);
              return result;
            } else {
              // Regular constructor: create instance first, then call constructor
              // 1. Create and initialize instance fields (using the class's public helper)
              // Pass null for type arguments as they aren't applicable to named constructor resolution here
              final instance =
                  targetValue.createAndInitializeInstance(this, null);
              // 2. Bind 'this' and call the named constructor logic
              final boundConstructor = namedConstructor.bind(instance);
              boundConstructor.call(
                  this, positionalArgs, namedArgs); // Pass evaluated args
              // Constructor call implicitly returns the bound instance.
              return instance; // Return the created and potentially modified instance
            }
          } on ReturnException catch (e) {
            return e.value;
          } on RuntimeD4rtException catch (e) {
            throw RuntimeD4rtException(
                "Error during named constructor '$methodName' for class '${targetValue.name}': ${e.message}");
          }
        } else {
          // Not a named constructor, check for STATIC METHOD
          final staticMethod = targetValue.findStaticMethod(methodName);
          if (staticMethod != null) {
            calleeValue =
                staticMethod; // It's already the function, no binding needed
          } else {
            throw RuntimeD4rtException(
                "Class '${targetValue.name}' has no static method or named constructor named '$methodName'.");
          }
        }
      } else if (targetValue is InterpretedEnum) {
        final staticMethod = targetValue.staticMethods[methodName];
        if (staticMethod != null) {
          calleeValue = staticMethod; // Static method, no binding needed
        } else {
          // Check mixins for static methods (reverse order)
          bool found = false;
          for (final mixin in targetValue.mixins.reversed) {
            final mixinStaticMethod = mixin.findStaticMethod(methodName);
            if (mixinStaticMethod != null) {
              calleeValue = mixinStaticMethod;
              found = true;
              Logger.debug(
                  "[SMethodInvocation] Found static method '$methodName' from mixin '${mixin.name}' for enum '${targetValue.name}'");
              break;
            }
          }

          if (!found) {
            // Before throwing, let's check if it's a built-in method call like 'values'
            // This could potentially be handled by the stdlib call later, but maybe check here?
            // For now, assume only user-defined static methods are intended.
            throw RuntimeD4rtException(
                "Enum '${targetValue.name}' has no static method named '$methodName'.");
          }
        }
      } else if (targetValue is InterpretedExtension) {
        // Static method call on extension
        final extension = targetValue;
        final staticMethod = extension.findStaticMethod(methodName);
        if (staticMethod != null) {
          calleeValue = staticMethod;
          Logger.debug(
              "[SMethodInvocation] Found static method '$methodName' on extension '${extension.name ?? '<unnamed>'}'");
        } else {
          throw RuntimeD4rtException(
              "Extension '${extension.name ?? '<unnamed>'}' has no static method named '$methodName'.");
        }
      } else if (targetValue is BridgedEnumValue) {
        // This is a method call on a bridged enum value.
        // It must use the invoke() method of BridgedEnumValue.
        final evaluationResult = _evaluateArgumentsAsync(node.argumentList);
        if (evaluationResult is AsyncSuspensionRequest) {
          return evaluationResult; // Propagate suspension
        }
        final (positionalArgs, namedArgs) =
            evaluationResult as (List<Object?>, Map<String, Object?>);
        try {
          return targetValue.invoke(
              this, methodName, positionalArgs, namedArgs);
        } on RuntimeD4rtException {
          // Relaunch the RuntimeErrors directly
          rethrow;
        } catch (e, s) {
          // Catch other potential errors (ex: from the adapter)
          Logger.error(
              "[visitMethodInvocation] Native exception during bridged enum method call '$targetValue.$methodName': $e\n$s");
          throw RuntimeD4rtException(
              "Native error during bridged enum method call '$methodName' on $targetValue: $e");
        }
      } else if (targetValue is BridgedClass) {
        // This is a method call on a bridged class (bridged constructor or static method)
        final bridgedClass = targetValue;
        final methodName = node.methodName!.name;
        Logger.debug(
            "[visitMethodInvocation] Target is BridgedClass: '$methodName' on '${bridgedClass.name}'");

        // 1. Try to find a constructor adapter
        final constructorAdapter =
            bridgedClass.findConstructorAdapter(methodName);

        if (constructorAdapter != null) {
          Logger.debug(
              "[visitMethodInvocation] Found Bridged CONSTRUCTOR adapter for '$methodName'");
          final evaluationResult = _evaluateArgumentsAsync(node.argumentList);
          if (evaluationResult is AsyncSuspensionRequest) {
            return evaluationResult; // Propagate suspension
          }
          final (positionalArgs, namedArgs) =
              evaluationResult as (List<Object?>, Map<String, Object?>);

          try {
            final nativeObject =
                constructorAdapter(this, positionalArgs, namedArgs);

            if (nativeObject == null) {
              throw RuntimeD4rtException(
                  "Bridged constructor adapter for '${bridgedClass.name}.$methodName' returned null unexpectedly.");
            }

            // Don't wrap Futures or Streams - they need to be usable directly
            if (nativeObject is Future || nativeObject is Stream) {
              Logger.debug(
                  "[visitMethodInvocation]   Returning native ${nativeObject.runtimeType} directly (not wrapping)");
              return nativeObject;
            }

            final bridgedInstance = BridgedInstance(bridgedClass, nativeObject);
            Logger.debug(
                "[visitMethodInvocation]   Created BridgedInstance wrapping native: ${nativeObject.runtimeType}");
            return bridgedInstance; // Retourner l'instance pontée créée
          } on RuntimeD4rtException catch (e) {
            // Relaunch the adapter error
            throw RuntimeD4rtException(
                "Error during bridged constructor '$methodName' for class '${bridgedClass.name}': ${e.message}");
          } catch (e, s) {
            // Catch native errors from the adapter/native constructor
            Logger.error(
                "[visitMethodInvocation] Native exception during bridged constructor '${bridgedClass.name}.$methodName': $e\n$s");
            throw RuntimeD4rtException(
                "Native error during bridged constructor '$methodName' for class '${bridgedClass.name}': $e");
          }
        } else {
          final staticMethodAdapter =
              bridgedClass.findStaticMethodAdapter(methodName);

          if (staticMethodAdapter != null) {
            Logger.debug(
                "[visitMethodInvocation] Found Bridged STATIC METHOD adapter for '$methodName'");
            final evaluationResult = _evaluateArgumentsAsync(node.argumentList);
            if (evaluationResult is AsyncSuspensionRequest) {
              return evaluationResult; // Propagate suspension
            }
            final (positionalArgs, namedArgs) =
                evaluationResult as (List<Object?>, Map<String, Object?>);

            // Evaluate type arguments for generic methods
            List<RuntimeType>? evaluatedTypeArguments;
            final typeArgsNode = node.typeArguments;
            if (typeArgsNode != null) {
              evaluatedTypeArguments = typeArgsNode.arguments
                  .map((typeNode) => _resolveTypeAnnotation(typeNode))
                  .toList();
            }

            try {
              final result = staticMethodAdapter(
                  this, positionalArgs, namedArgs, evaluatedTypeArguments);

              return result;
            } on RuntimeD4rtException catch (e) {
              throw RuntimeD4rtException(
                  "Error during static bridged method call '$methodName' on ${bridgedClass.name}: ${e.message}");
            } catch (e, s) {
              Logger.warn(
                  "[visitMethodInvocation] Native exception during static bridged method call '${bridgedClass.name}.$methodName': $e\n$s");
              throw RuntimeD4rtException(
                  "Native error during static bridged method call '$methodName' on ${bridgedClass.name}: $e");
            }
          } else {
            throw RuntimeD4rtException(
                "Bridged class '${bridgedClass.name}' has no constructor or static method named '$methodName'.");
          }
        }
      } else if (targetValue is BoundSuper) {
        final instance = targetValue.instance;
        final startClass = targetValue.startLookupClass;
        InterpretedClass? currentClass = startClass;
        InterpretedFunction? superMethod;

        // Look for the method in the superclass hierarchy
        while (currentClass != null) {
          final method = currentClass.findInstanceMethod(methodName);
          if (method != null) {
            superMethod = method;
            break;
          }
          currentClass = currentClass.superclass;
        }

        if (superMethod != null) {
          // Bind the found super method to the original instance ('this')
          calleeValue = superMethod.bind(instance);
        } else {
          throw RuntimeD4rtException(
              "Method '$methodName' not found in superclass chain of '${instance.klass.name}'.");
        }
        // Arguments are evaluated below, calleeValue is now the bound super method
      } else if (targetValue is BoundBridgedSuper) {
        final instance = targetValue.instance; // L'instance 'this' interprétée
        final bridgedSuper = targetValue.startLookupClass;
        final nativeSuperObject =
            instance.bridgedSuperObject; // Retrieve the native object

        if (nativeSuperObject == null) {
          throw RuntimeD4rtException(
              "Internal error: Cannot call super method '$methodName' on bridged superclass '${bridgedSuper.name}' because the native super object is missing.");
        }

        // Find the method adapter in the bridged class
        final methodAdapter =
            bridgedSuper.findInstanceMethodAdapter(methodName);

        if (methodAdapter != null) {
          // Evaluate the arguments
          final evaluationResult = _evaluateArgumentsAsync(node.argumentList);
          if (evaluationResult is AsyncSuspensionRequest) {
            return evaluationResult; // Propagate suspension
          }
          final (positionalArgs, namedArgs) =
              evaluationResult as (List<Object?>, Map<String, Object?>);

          // Evaluate type arguments for generic methods
          List<RuntimeType>? evaluatedTypeArguments;
          final typeArgsNode = node.typeArguments;
          if (typeArgsNode != null) {
            evaluatedTypeArguments = typeArgsNode.arguments
                .map((typeNode) => _resolveTypeAnnotation(typeNode))
                .toList();
          }

          // Call the adapter with the native object as target
          try {
            return methodAdapter(this, nativeSuperObject, positionalArgs,
                namedArgs, evaluatedTypeArguments);
          } catch (e, s) {
            Logger.error(
                "Native exception during super call to bridged method '${bridgedSuper.name}.$methodName': $e\n$s");
            throw RuntimeD4rtException(
                "Native error during super call to bridged method '$methodName': $e");
          }
        } else {
          throw RuntimeD4rtException(
              "Method '$methodName' not found in bridged superclass '${bridgedSuper.name}'.");
        }
        // This block returns directly or throws an exception
      }

      // Handle Function.call() - all Dart functions have an implicit 'call' method
      else if (targetValue is Callable && methodName == 'call') {
        // Calling .call() on a function is equivalent to invoking the function
        final evaluationResult = _evaluateArgumentsAsync(node.argumentList);
        if (evaluationResult is AsyncSuspensionRequest) {
          return evaluationResult; // Propagate suspension
        }
        final (positionalArgs, namedArgs) =
            evaluationResult as (List<Object?>, Map<String, Object?>);
        List<RuntimeType>? evaluatedTypeArguments;
        final typeArgsNode = node.typeArguments;
        if (typeArgsNode != null) {
          evaluatedTypeArguments = typeArgsNode.arguments
              .map((typeNode) => _resolveTypeAnnotation(typeNode))
              .toList();
        }

        try {
          return targetValue.call(
              this, positionalArgs, namedArgs, evaluatedTypeArguments);
        } on ReturnException catch (e) {
          return e.value;
        }
      }

      //
      else {
        final evaluationResult = _evaluateArgumentsAsync(node.argumentList);
        if (evaluationResult is AsyncSuspensionRequest) {
          return evaluationResult; // Propagate suspension
        }
        final (positionalArgs, namedArgs) =
            evaluationResult as (List<Object?>, Map<String, Object?>);
        List<RuntimeType>? evaluatedTypeArguments;
        final typeArgsNode = node.typeArguments;
        if (typeArgsNode != null) {
          evaluatedTypeArguments = typeArgsNode.arguments
              .map((typeNode) => _resolveTypeAnnotation(typeNode))
              .toList();
        }

        final extensionCallable =
            environment.findExtensionMember(targetValue, methodName);

        if (extensionCallable is ExtensionMemberCallable) {
          Logger.debug(
              "[SMethodInvocation] Found extension method '$methodName'. Calling...");
          // Prepend the target instance to the positional arguments for the extension call
          final extensionPositionalArgs = [targetValue, ...positionalArgs];
          try {
            // Call the extension method
            return extensionCallable.call(this, extensionPositionalArgs,
                namedArgs, evaluatedTypeArguments);
          } on ReturnException catch (e) {
            return e.value;
          } catch (e) {
            throw RuntimeD4rtException(
                "Error executing extension method '$methodName': $e");
          }
        } else {
          // No extension method found either, rethrow the original stdlib error
          Logger.debug(
              "[SMethodInvocation] Extension method '$methodName' not found. Rethrowing original error.");
          throw RuntimeD4rtException(
              "Undefined property or method '$methodName' on ${targetValue.runtimeType}.");
        }
      }
    }

    // Check if the resolved value is callable
    if (calleeValue is Callable) {
      final evaluationResult = _evaluateArgumentsAsync(node.argumentList);
      if (evaluationResult is AsyncSuspensionRequest) {
        return evaluationResult; // Propagate suspension
      }
      final (positionalArgs, namedArgs) =
          evaluationResult as (List<Object?>, Map<String, Object?>);

      // Evaluate Type Arguments for Method Invocation
      List<RuntimeType>? evaluatedTypeArguments;
      final typeArgsNode = node.typeArguments;
      if (typeArgsNode != null) {
        evaluatedTypeArguments = typeArgsNode.arguments
            .map((typeNode) => _resolveTypeAnnotation(typeNode))
            .toList();
        Logger.debug(
            "[SMethodInvocation] Evaluated type arguments: $evaluatedTypeArguments");
      }

      // Perform the call
      try {
        // The call logic now works for functions, bound instance methods,
        // static methods, and constructors (which are handled by InterpretedClass.call)
        // Pass the evaluated type arguments
        return calleeValue.call(
            this, positionalArgs, namedArgs, evaluatedTypeArguments);
      } on ReturnException catch (e) {
        return e.value;
      }
      // Catch other potential runtime errors from the call itself
    } else if (calleeValue is BridgedClass && node.target == null) {
      // Call of a bridged default constructor (ex: StringBuffer())
      final bridgedClass = calleeValue;
      final constructorAdapter = bridgedClass
          .findConstructorAdapter(''); // Search for the default constructor ''

      if (constructorAdapter != null) {
        Logger.debug(
            "[visitMethodInvocation] Calling default bridged constructor for '${bridgedClass.name}'");

        final evaluationResult = _evaluateArgumentsAsync(node.argumentList);
        if (evaluationResult is AsyncSuspensionRequest) {
          return evaluationResult; // Propagate suspension
        }
        final (positionalArgs, namedArgs) =
            evaluationResult as (List<Object?>, Map<String, Object?>);

        try {
          final nativeObject =
              constructorAdapter(this, positionalArgs, namedArgs);
          if (nativeObject == null) {
            throw RuntimeD4rtException(
                "Default bridged constructor adapter for '${bridgedClass.name}' returned null.");
          }

          // Don't wrap Futures or Streams - they need to be usable directly
          if (nativeObject is Future || nativeObject is Stream) {
            Logger.debug(
                "[visitMethodInvocation]   Returning native ${nativeObject.runtimeType} directly (not wrapping)");
            return nativeObject;
          }

          final bridgedInstance = BridgedInstance(bridgedClass, nativeObject);
          Logger.debug(
              "[visitMethodInvocation]   Created BridgedInstance wrapping native: ${nativeObject.runtimeType}");
          return bridgedInstance;
        } on RuntimeD4rtException catch (e) {
          throw RuntimeD4rtException(
              "Error during default bridged constructor for '${bridgedClass.name}': ${e.message}");
        } catch (e, s) {
          Logger.error(
              "[visitMethodInvocation] Native exception during default bridged constructor '${bridgedClass.name}': $e\n$s");
          throw RuntimeD4rtException(
              "Native error during default bridged constructor for '${bridgedClass.name}': $e");
        }
      } else {
        // If we have a BridgedClass but no default constructor ''
        throw RuntimeD4rtException(
            "'${bridgedClass.name}' is not callable (no default constructor bridge found).");
      }
    } else {
      // INTER-001 FIX: Check for BridgedInstance with call() method
      final bridgedResult = toBridgedInstance(calleeValue);
      if (bridgedResult.$2) {
        final bridgedInstance = bridgedResult.$1!;
        final callMethodAdapter =
            bridgedInstance.bridgedClass.findInstanceMethodAdapter('call');
        if (callMethodAdapter != null) {
          Logger.debug(
              "[MethodInvoke] Found 'call' method on BridgedInstance (${bridgedInstance.bridgedClass.name}). Invoking...");
          final (positionalArgs, namedArgs) =
              _evaluateArguments(node.argumentList);
          List<RuntimeType>? evaluatedTypeArguments;
          final typeArgsNode = node.typeArguments;
          if (typeArgsNode != null) {
            evaluatedTypeArguments = typeArgsNode.arguments
                .map((typeNode) => _resolveTypeAnnotation(typeNode))
                .toList();
          }
          try {
            return callMethodAdapter(this, bridgedInstance.nativeObject,
                positionalArgs, namedArgs, evaluatedTypeArguments);
          } on ReturnException catch (e) {
            return e.value;
          }
        }
      }

      // Callee is NOT a standard Callable or a BridgedClass constructor
      // Try Extension 'call' Method
      const methodName = 'call';
      try {
        final extensionMethod =
            environment.findExtensionMember(calleeValue, methodName);

        if (extensionMethod is ExtensionMemberCallable &&
            !extensionMethod
                .isOperator && // Ensure it's a regular method named 'call'
            !extensionMethod.isGetter &&
            !extensionMethod.isSetter) {
          Logger.debug(
              "[MethodInvoke] Found extension method 'call' for non-callable type ${calleeValue?.runtimeType}. Calling...");

          // Need to re-evaluate args here as they weren't necessarily evaluated
          // if calleeValue wasn't Callable earlier.
          final (positionalArgs, namedArgs) =
              _evaluateArguments(node.argumentList);
          List<RuntimeType>? evaluatedTypeArguments;
          final typeArgsNode = node.typeArguments;
          if (typeArgsNode != null) {
            evaluatedTypeArguments = typeArgsNode.arguments
                .map((typeNode) => _resolveTypeAnnotation(typeNode))
                .toList();
          }

          // Prepare arguments for extension method:
          // First arg is the receiver (the object being called)
          final extensionPositionalArgs = [calleeValue, ...positionalArgs];

          try {
            // Call the extension method
            return extensionMethod.call(this, extensionPositionalArgs,
                namedArgs, evaluatedTypeArguments);
          } on ReturnException catch (e) {
            return e.value;
          } catch (e) {
            throw RuntimeD4rtException(
                "Error executing extension method 'call': $e");
          }
        }
        Logger.debug(
            "[MethodInvoke] No suitable extension method 'call' found for non-callable type ${calleeValue?.runtimeType}.");
      } on RuntimeD4rtException catch (findError) {
        Logger.debug(
            "[MethodInvoke] No extension member 'call' found for non-callable type ${calleeValue?.runtimeType}. Error: ${findError.message}");
        // Fall through to the final standard error below.
      }

      // Original Error: The expression evaluated did not yield a callable function or an object with a callable 'call' extension.
      String nameForError = "<unknown>";
      if (node.target == null) {
        nameForError = node.methodName!.name;
      } else {
        nameForError = node.toString(); // Approximate representation
      }
      if (calleeValue != null) {
        return calleeValue;
      }
      throw RuntimeD4rtException(
          "'$nameForError' (type: ${calleeValue?.runtimeType}) is not callable and has no 'call' extension method.");
    }
  }

  // Update SPropertyAccess to call getters AND handle 'super'
  @override
  Object? visitPropertyAccess(SPropertyAccess node) {
    final target = node.target?.accept<Object?>(this);
    if (target is AsyncSuspensionRequest) {
      // Propagate suspension so the state machine resumes this node after resolution
      return target;
    }

    // Determine if this is a conditional access by inspecting the source
    final isNullAware = node.toString().contains('?.');
    final propertyName = node.propertyName!.name;

    // Null safety support: if the target is null and the access is null-aware, return null
    if (target == null) {
      if (isNullAware) {
        return null;
      }
      // G-DOV-10/11 FIX: Try extension lookup on nullable types before throwing
      final extensionMember =
          environment.findExtensionMember(target, propertyName, visitor: this);
      if (extensionMember != null) {
        if (extensionMember is InterpretedFunction &&
            extensionMember.isGetter) {
          // Execute extension getter with 'this' bound to null
          final extensionEnv = Environment(enclosing: environment);
          extensionEnv.define('this', null);
          final prevEnv = environment;
          environment = extensionEnv;
          try {
            return extensionMember.call(this, [], {});
          } finally {
            environment = prevEnv;
          }
        }
        return extensionMember;
      }
      throw RuntimeD4rtException(
          "Cannot access property '$propertyName' on null. Use '?.' for null-aware access.");
    }

    Logger.debug(
        "[SPropertyAccess: ${node.toString()}] Target type: ${target.runtimeType}, Target value: ${target.toString()}");

    if (target is InterpretedInstance) {
      // Standard Instance Access: Try direct first, then extension
      try {
        final member = target.get(propertyName,
            visitor: this); // .get() handles inheritance
        if (member is InterpretedFunction && member.isGetter) {
          return member
              .call(this, [], {}); // .get already returned bound getter
        } else {
          return member; // field value or bound method
        }
      } on RuntimeD4rtException catch (e) {
        // Try Extension Lookup Before Error
        if (e.message.contains("Undefined property '$propertyName'")) {
          Logger.debug(
              "[SPropertyAccess] Direct access failed for '$propertyName'. Trying extension lookup on ${target.runtimeType}.");
          try {
            final extensionMember =
                environment.findExtensionMember(target, propertyName);

            if (extensionMember is ExtensionMemberCallable) {
              if (extensionMember.isGetter) {
                Logger.debug(
                    "[SPropertyAccess] Found extension getter '$propertyName'. Calling...");
                // Getters are called with the instance as the first (and only) positional argument
                final extensionPositionalArgs = [target];
                return extensionMember.call(this, extensionPositionalArgs, {});
              } else if (!extensionMember.isOperator &&
                  !extensionMember.isSetter) {
                // Return the extension method itself (it's not bound yet)
                Logger.debug(
                    "[SPropertyAccess] Found extension method '$propertyName'. Returning callable.");
                return extensionMember;
              }
            }
            // No suitable extension found, fall through to rethrow original error
            Logger.debug(
                "[SPropertyAccess] No suitable extension member found for '$propertyName'.");
          } on RuntimeD4rtException catch (findError) {
            // Error during extension lookup itself
            Logger.debug(
                "[SPropertyAccess] Error during extension lookup for '$propertyName': ${findError.message}");
            // Fall through to rethrow original error
          }
        }
        // Rethrow original error if it wasn't "Undefined property"or if extension lookup failed
        throw RuntimeD4rtException(
            "${e.message} (accessing property via SPropertyAccess '$propertyName')");
      }
    } else if (target is InterpretedEnumValue) {
      try {
        // Get should execute the getter or return the field/bound method
        // Pass the visitor to potentially execute getters
        final member = target.get(propertyName, this);

        // Check if the result from get was already the final value (field or executed getter)
        // or if it's a bound method that shouldn't be called here.
        if (member is Callable) {
          // Property access should generally not return a raw callable method.
          // If get() returned a bound method, it means the propertyName matched a method name,
          // which is not what property access typically expects.
          // However, Dart allows accessing methods like properties to get a tear-off.
          // So, we return the bound method (Callable) here.
          Logger.debug(
              "[SPropertyAccess] Accessed enum method '$propertyName' on $target as tear-off. Returning bound method.");
          return member;
        } else {
          // Must be a field value or the result of an executed getter.
          Logger.debug(
              "[SPropertyAccess] Accessed enum field/getter '$propertyName' on $target. Value: $member");
          return member;
        }
      } on RuntimeD4rtException catch (e) {
        // Try Extension Getter if Direct Fails (similar to InterpretedInstance)
        if (e.message.contains("Undefined property '$propertyName'")) {
          Logger.debug(
              "[SPropertyAccess] Direct access failed for '$propertyName' on enum $target. Trying extension lookup...");
          try {
            final extensionMember =
                environment.findExtensionMember(target, propertyName);
            if (extensionMember is ExtensionMemberCallable) {
              if (extensionMember.isGetter) {
                Logger.debug(
                    "[SPropertyAccess] Found extension getter '$propertyName' for enum. Calling...");
                final extensionPositionalArgs = [target];
                return extensionMember.call(this, extensionPositionalArgs, {});
              } else if (!extensionMember.isOperator &&
                  !extensionMember.isSetter) {
                Logger.debug(
                    "[SPropertyAccess] Found extension method '$propertyName' for enum. Returning tear-off.");
                return extensionMember;
              }
            }
            Logger.debug(
                "[SPropertyAccess] No suitable extension member found for '$propertyName' on enum.");
          } on RuntimeD4rtException catch (findError) {
            Logger.debug(
                "[SPropertyAccess] Error during extension lookup for '$propertyName' on enum: ${findError.message}");
          }
        }
        // Rethrow original error or error from extension lookup
        throw RuntimeD4rtException(
            "${e.message} (accessing property via SPropertyAccess '$propertyName' on enum value '$target')");
      }
    } else if (target is InterpretedEnum) {
      // Accessing static member on the enum itself
      InterpretedFunction? staticGetter = target.staticGetters[propertyName];
      if (staticGetter != null) {
        // Call the static getter
        return staticGetter.call(this, [], {});
      }
      Object? staticField = target.staticFields[propertyName];
      if (target.staticFields.containsKey(propertyName)) {
        // Return static field value (could be null)
        return staticField;
      }
      InterpretedFunction? staticMethod = target.staticMethods[propertyName];
      if (staticMethod != null) {
        // Return the static method itself (tear-off)
        return staticMethod;
      }

      // Check mixins for static members (reverse order)
      for (final mixin in target.mixins.reversed) {
        final mixinStaticGetter = mixin.findStaticGetter(propertyName);
        if (mixinStaticGetter != null) {
          Logger.debug(
              "[SPropertyAccess] Found static getter '$propertyName' from mixin '${mixin.name}' for enum '${target.name}'");
          return mixinStaticGetter.call(this, [], {});
        }

        final mixinStaticMethod = mixin.findStaticMethod(propertyName);
        if (mixinStaticMethod != null) {
          Logger.debug(
              "[SPropertyAccess] Found static method '$propertyName' from mixin '${mixin.name}' for enum '${target.name}'");
          return mixinStaticMethod;
        }

        // Check static fields - use try/catch since getStaticField throws if not found
        try {
          final mixinStaticField = mixin.getStaticField(propertyName);
          Logger.debug(
              "[SPropertyAccess] Found static field '$propertyName' from mixin '${mixin.name}' for enum '${target.name}'");
          return mixinStaticField;
        } on RuntimeD4rtException {
          // Continue to next mixin
        }
      }

      // Check for built-in 'values'
      if (propertyName == 'values') {
        return target.valuesList;
      }

      // Not found
      throw RuntimeD4rtException(
          "Undefined static property '$propertyName' on enum '${target.name}'.");
    } else if (target is InterpretedClass) {
      // Static Access (no change)
      try {
        // Check static fields first (no inheritance for static fields in Dart)
        return target.getStaticField(propertyName);
      } on RuntimeD4rtException catch (_) {
        // If not a field, check static methods/getters
        InterpretedFunction? staticMember =
            target.findStaticGetter(propertyName);
        staticMember ??= target.findStaticMethod(propertyName);

        if (staticMember != null) {
          if (staticMember.isGetter) {
            return staticMember.call(this, [], {}); // Call static getter
          } else {
            // Return static method function itself (not bound)
            return staticMember;
          }
        } else {
          throw RuntimeD4rtException(
              "Undefined static member '$propertyName' on class '${target.name}'.");
        }
      }
    } else if (target is BoundSuper) {
      // Super Property Access
      final instance = target.instance;
      final startClass = target.startLookupClass;
      InterpretedClass? currentClass =
          startClass; // Start search from superclass

      while (currentClass != null) {
        // Check instance field in the bound instance's fields
        // Use the new public getter on the instance to access the field value
        try {
          final fieldValue = instance.getField(propertyName);
          // Field found on the instance, return its value regardless of where we are in the super hierarchy lookup
          return fieldValue;
        } on RuntimeD4rtException {
          // Field doesn't exist directly on the instance, continue searching for getters/methods
        }

        // Check instance getter in the current class in hierarchy
        final getter = currentClass.findInstanceGetter(propertyName);
        if (getter != null) {
          // Bind getter to the original instance and call
          return getter.bind(instance).call(this, [], {});
        }
        // Check instance method (less common for property access, but possible)
        final method = currentClass.findInstanceMethod(propertyName);
        if (method != null) {
          // Bind method to the original instance and return the bound method
          return method.bind(instance);
        }
        // Move up the hierarchy
        currentClass = currentClass.superclass;
      }
      // Not found in superclass hierarchy
      throw RuntimeD4rtException(
          "Undefined property '$propertyName' accessed via 'super' on instance of '${instance.klass.name}'.");
    } else if (target is BridgedClass) {
      final bridgedClass = target;
      Logger.debug(
          "[SPropertyAccess] Static access on BridgedClass: ${bridgedClass.name}.$propertyName");

      final staticGetter = bridgedClass.findStaticGetterAdapter(propertyName);
      if (staticGetter != null) {
        Logger.debug("[SPropertyAccess]   Found static getter adapter.");
        return staticGetter(this); // Call static getter adapter
      }

      final staticMethod = bridgedClass.findStaticMethodAdapter(propertyName);
      if (staticMethod != null) {
        Logger.debug("[SPropertyAccess]   Found static method adapter.");
        throw UnimplementedD4rtException(
            "Returning bridged static methods as values from SPropertyAccess is not yet supported.");
        // return BridgedStaticMethodCallable(bridgedClass, staticMethod, propertyName);
      } else {
        throw RuntimeD4rtException(
            "Undefined static member '$propertyName' on bridged class '${bridgedClass.name}'.");
      }
    } else if (toBridgedInstance(target).$2) {
      final bridgedInstance = toBridgedInstance(target).$1!;
      Logger.debug(
          "[SPropertyAccess] Access on BridgedInstance: ${bridgedInstance.bridgedClass.name}.$propertyName");
      switch (propertyName) {
        case 'runtimeType':
          return target.runtimeType;
        case 'hashCode':
          return target.hashCode;
        default:
      }
      final getterAdapter =
          bridgedInstance.bridgedClass.findInstanceGetterAdapter(propertyName);
      if (getterAdapter != null) {
        Logger.debug("[SPropertyAccess]   Found instance getter adapter.");
        return getterAdapter(
            this, bridgedInstance.nativeObject); // Call instance getter adapter
      }

      final methodAdapter =
          bridgedInstance.bridgedClass.findInstanceMethodAdapter(propertyName);
      if (methodAdapter != null) {
        Logger.debug(
            "[SPropertyAccess]   Found instance method adapter. Binding...");
        // Return a callable bound to the instance
        return BridgedMethodCallable(
            bridgedInstance, methodAdapter, propertyName);
      }

      // Try extension lookup before throwing error
      Logger.debug(
          "[SPropertyAccess] Direct access failed for '$propertyName' on BridgedInstance. Trying extension lookup...");
      final extensionMember =
          environment.findExtensionMember(bridgedInstance, propertyName);

      if (extensionMember is ExtensionMemberCallable) {
        if (extensionMember.isGetter) {
          Logger.debug(
              "[SPropertyAccess] Found extension getter '$propertyName' for BridgedInstance. Calling...");
          // Getters are called with the native object as the first positional argument
          final extensionPositionalArgs = [bridgedInstance.nativeObject];
          return extensionMember.call(this, extensionPositionalArgs, {});
        } else if (!extensionMember.isOperator && !extensionMember.isSetter) {
          Logger.debug(
              "[SPropertyAccess] Found extension method '$propertyName' for BridgedInstance. Returning tear-off.");
          return extensionMember;
        }
      }

      throw RuntimeD4rtException(
          "Undefined property or method '$propertyName' on bridged instance of '${bridgedInstance.bridgedClass.name}'.");
    } else if (target is InterpretedRecord) {
      // Accessing field of a record
      final record = target;
      Logger.debug(
          "[SPropertyAccess] Access on InterpretedRecord: .$propertyName");
      // Check if it's a positional field access (\$1, \$2, ...)
      if (propertyName.startsWith('\$') && propertyName.length > 1) {
        try {
          final index = int.parse(propertyName.substring(1)) - 1;
          if (index >= 0 && index < record.positionalFields.length) {
            return record.positionalFields[index];
          } else {
            throw RuntimeD4rtException(
                "Record positional field index \$$index out of bounds (0..${record.positionalFields.length - 1}).");
          }
        } catch (e) {
          // Handle parse errors or other issues
          throw RuntimeD4rtException(
              "Invalid positional record field accessor '$propertyName'.");
        }
      } else {
        // Check if it's a named field access
        if (record.namedFields.containsKey(propertyName)) {
          return record.namedFields[propertyName];
        } else {
          throw RuntimeD4rtException(
              "Record has no field named '$propertyName'. Available fields: ${record.namedFields.keys.join(', ')}");
        }
      }
    } else if (target is BridgedEnumValue) {
      return target.get(propertyName);
    } else if (target is BridgedEnum) {
      Logger.debug(
          "[SPropertyAccess] Accessing value on BridgedEnum: ${target.name}.$propertyName");
      final enumValue = target.getValue(propertyName);
      if (enumValue != null) {
        return enumValue; // Return the BridgedEnumValue
      } else {
        throw RuntimeD4rtException(
            "Undefined enum value '$propertyName' on bridged enum '${target.name}'.");
      }
    } else if (target is BoundBridgedSuper) {
      final instance = target.instance; // The interpreted 'this' instance
      final bridgedSuper = target.startLookupClass;
      final nativeSuperObject =
          instance.bridgedSuperObject; // Retrieve the native object

      if (nativeSuperObject == null) {
        throw RuntimeD4rtException(
            "Internal error: Cannot access super property '$propertyName' on bridged superclass '${bridgedSuper.name}' because the native super object is missing.");
      }

      // Try the bridged getter
      final getterAdapter =
          bridgedSuper.findInstanceGetterAdapter(propertyName);
      if (getterAdapter != null) {
        try {
          return getterAdapter(this, nativeSuperObject);
        } catch (e, s) {
          Logger.error(
              "Native exception during super access to bridged getter '${bridgedSuper.name}.$propertyName': $e\n$s");
          throw RuntimeD4rtException(
              "Native error during super access to bridged getter '$propertyName': $e");
        }
      }

      // Try the bridged method (for tear-off)
      final methodAdapter =
          bridgedSuper.findInstanceMethodAdapter(propertyName);
      if (methodAdapter != null) {
        // Return a callable bound to the native object
        return BridgedSuperMethodCallable(
            nativeSuperObject, methodAdapter, propertyName, bridgedSuper.name);
      }

      // Not found
      throw RuntimeD4rtException(
          "Undefined property or method '$propertyName' accessed via 'super' on bridged superclass '${bridgedSuper.name}'.");
    } else {
      // Check if target is a native enum that has been bridged
      final bridgedEnumValue = environment.getBridgedEnumValue(target);
      if (bridgedEnumValue != null) {
        Logger.debug(
            "[SPropertyAccess] Found bridged enum value for native enum ${target.runtimeType}");
        try {
          return bridgedEnumValue.get(propertyName);
        } catch (e) {
          throw RuntimeD4rtException(
              "Undefined property '$propertyName' on bridged enum value '${bridgedEnumValue.name}'.");
        }
      }

      Logger.debug(
          "[SPropertyAccess] Looking for extension getter '$propertyName' for target type ${target.runtimeType}.");
      final extensionCallable =
          environment.findExtensionMember(target, propertyName);

      if (extensionCallable is ExtensionMemberCallable &&
          extensionCallable.isGetter) {
        Logger.debug(
            "[SPropertyAccess] Found extension getter '$propertyName'. Calling...");
        // Prepend the target instance to the positional arguments for the extension call
        final extensionPositionalArgs = [
          target
        ]; // Getters take no explicit args
        try {
          // Call the extension getter
          return extensionCallable.call(this, extensionPositionalArgs, {});
        } on ReturnException catch (e) {
          return e.value;
        } catch (e) {
          throw RuntimeD4rtException(
              "Error executing extension getter '$propertyName': $e");
        }
      } else {
        // No extension getter found either, rethrow the original stdlib error
        Logger.debug(
            "[SPropertyAccess] Extension getter '$propertyName' not found. Rethrowing original error.");
        throw RuntimeD4rtException(
            "Undefined property or method '$propertyName' on ${target.runtimeType}.");
      }
    }
  }

  String stringify(Object? value) {
    if (value == null) return 'null';
    if (value is bool) return value.toString();
    return value.toString();
  }

  @override
  Object? visitIfStatement(SIfStatement node) {
    // Evaluate the expression
    final expressionValue = node.condition!.accept<Object?>(this);

    // If the evaluation returns an AsyncSuspensionRequest, return it immediately
    if (expressionValue is AsyncSuspensionRequest) {
      Logger.debug(
          "[SIfStatement] Expression suspended (AsyncSuspensionRequest). Propagating.");
      return expressionValue;
    }

    // Check if this is an if-case statement (pattern matching)
    final caseClause = node.caseClause;
    if (caseClause != null) {
      // This is an if-case statement: if (expr case Pattern when guard) { ... }
      final cc = caseClause;
      final gp = cc.guardedPattern;
      final pattern = gp.pattern;
      final guard = gp.whenClause?.expression;

      // Create a temporary environment for pattern variable bindings
      final caseEnvironment = Environment(enclosing: environment);

      try {
        // Attempt to match the pattern against the expression value
        _matchAndBind(pattern, expressionValue, caseEnvironment);
        Logger.debug(
            "[SIfStatement] Pattern ${pattern.runtimeType} matched value ${expressionValue?.runtimeType}");

        // Pattern matched, now check the guard (if it exists)
        bool guardPassed = true;
        if (guard != null) {
          final previousVisitorEnv = environment;
          try {
            environment = caseEnvironment; // Evaluate guard in case scope
            final guardResult = guard.accept<Object?>(this);
            if (guardResult is! bool) {
              throw RuntimeD4rtException(
                  "If-case 'when' clause must evaluate to a boolean.");
            }
            guardPassed = guardResult;
            Logger.debug("[SIfStatement] Guard evaluated to: $guardPassed");
          } finally {
            environment = previousVisitorEnv;
          }
        }

        // If pattern matched and guard passed, execute thenStatement
        if (guardPassed) {
          final previousVisitorEnv = environment;
          try {
            environment = caseEnvironment; // Execute body in case scope
            node.thenStatement!.accept<Object?>(this);
          } finally {
            environment = previousVisitorEnv;
          }
        } else if (node.elseStatement != null) {
          // Guard failed, execute elseStatement
          node.elseStatement!.accept<Object?>(this);
        }
      } on PatternMatchD4rtException {
        // Pattern didn't match, execute elseStatement if present
        Logger.debug(
            "[SIfStatement] Pattern ${pattern.runtimeType} did not match. Executing else if present.");
        if (node.elseStatement != null) {
          node.elseStatement!.accept<Object?>(this);
        }
      }

      return null;
    }

    // Regular boolean condition if statement
    bool conditionResult;
    final bridgedInstance = toBridgedInstance(expressionValue);
    if (expressionValue is bool) {
      conditionResult = expressionValue;
    } else if (bridgedInstance.$2 && bridgedInstance.$1?.nativeObject is bool) {
      conditionResult = bridgedInstance.$1!.nativeObject as bool;
    } else {
      throw RuntimeD4rtException(
          "The condition of an 'if' must be a boolean, but was ${expressionValue?.runtimeType}.");
    }

    if (conditionResult) {
      node.thenStatement!.accept<Object?>(this);
    } else if (node.elseStatement != null) {
      node.elseStatement!.accept<Object?>(this);
    }

    return null; // The If instruction normally ends with null
  }

  @override
  Object? visitWhileStatement(SWhileStatement node) {
    while (true) {
      // Handle condition being BridgedInstance<bool>
      final conditionValue = node.condition!.accept<Object?>(this);
      bool conditionResult;
      final bridgedInstance = toBridgedInstance(conditionValue);
      if (conditionValue is bool) {
        conditionResult = conditionValue;
      } else if (bridgedInstance.$2 &&
          bridgedInstance.$1?.nativeObject is bool) {
        conditionResult = bridgedInstance.$1!.nativeObject as bool;
      } else {
        throw RuntimeD4rtException(
            "The condition of a 'while' loop must be a boolean, but was ${conditionValue?.runtimeType}.");
      }

      if (!conditionResult) {
        break;
      }

      try {
        // Condition is true, execute the body
        node.body!.accept<Object?>(this);
      } on BreakException catch (e) {
        Logger.debug(
            "[While] Caught BreakException (label: ${e.label}) with current labels: $_currentStatementLabels");
        if (e.label == null || _currentStatementLabels.contains(e.label)) {
          // Unlabeled break OR labeled break targeting this loop.
          Logger.debug("[While] Breaking loop.");
          break; // Exit the while loop
        } else {
          // Labeled break targeting an outer construct.
          Logger.debug("[While] Rethrowing outer break...");
          rethrow;
        }
      } on ContinueException catch (e) {
        Logger.debug(
            "[While] Caught ContinueException (label: ${e.label}) with current labels: $_currentStatementLabels");
        if (e.label == null || _currentStatementLabels.contains(e.label)) {
          // Unlabeled continue OR labeled continue targeting this loop.
          Logger.debug("[While] Continuing loop.");
          continue; // Skip to the next iteration
        } else {
          // Labeled continue targeting an outer loop.
          Logger.debug("[While] Rethrowing outer continue...");
          rethrow;
        }
      }
      // Other exceptions will propagate up
    }
    return null;
  }

  @override
  Object? visitDoStatement(SDoStatement node) {
    do {
      try {
        // Execute the body first
        node.body!.accept<Object?>(this);
      } on BreakException catch (e) {
        Logger.debug(
            "[DoWhile] Caught BreakException (label: ${e.label}) with current labels: $_currentStatementLabels");
        if (e.label == null || _currentStatementLabels.contains(e.label)) {
          Logger.debug("[DoWhile] Breaking loop.");
          break; // Exit the do-while loop
        } else {
          Logger.debug("[DoWhile] Rethrowing outer break...");
          rethrow;
        }
      } on ContinueException catch (e) {
        Logger.debug(
            "[DoWhile] Caught ContinueException (label: ${e.label}) with current labels: $_currentStatementLabels");
        if (e.label == null || _currentStatementLabels.contains(e.label)) {
          Logger.debug("[DoWhile] Continuing loop condition check.");
          // For do-while, continue still needs to check the condition
          // So we fall through to the condition check below
        } else {
          Logger.debug("[DoWhile] Rethrowing outer continue...");
          rethrow;
        }
      }

      // Then evaluate the condition
      // Handle condition being BridgedInstance<bool>
      final conditionValue = node.condition!.accept<Object?>(this);
      Logger.debug("[DoWhile] Condition value: $conditionValue");
      bool conditionResult;
      final bridgedInstance = toBridgedInstance(conditionValue);
      Logger.debug("[DoWhile] Bridged instance: $bridgedInstance");
      if (conditionValue is bool) {
        conditionResult = conditionValue;
      } else if (bridgedInstance.$2 &&
          bridgedInstance.$1?.nativeObject is bool) {
        conditionResult = bridgedInstance.$1!.nativeObject as bool;
      } else {
        throw RuntimeD4rtException(
            "The condition of a 'do-while' loop must be a boolean, but was ${conditionValue?.runtimeType}.");
      }

      if (!conditionResult) {
        break;
      }
    } while (true);

    return null;
  }

  @override
  Object? visitForStatement(SForStatement node) {
    final loopParts = node.forLoopParts;

    if (loopParts is SForPartsWithDeclarations) {
      // Classic for loop: for (var i = 0; ... ; ...)
      _executeClassicFor(loopParts.variables, loopParts.condition,
          loopParts.updaters, node.body!);
    } else if (loopParts is SForPartsWithExpression) {
      // Classic for loop: for (i = 0; ... ; ...)
      _executeClassicFor(loopParts.initialization, loopParts.condition,
          loopParts.updaters, node.body!);
    } else if (loopParts is SForEachPartsWithDeclaration) {
      // For-in loop: for (var item in list) or await for (var item in stream)
      if (loopParts.isAwait) {
        // await for loop - expect Stream
        return _executeAwaitForIn(
            loopParts.loopVariable!, loopParts.iterable!, node.body!);
      } else {
        // Regular for-in loop - expect Iterable
        _executeForIn(loopParts.loopVariable!, loopParts.iterable!, node.body!);
      }
    } else if (loopParts is SForEachPartsWithIdentifier) {
      // For-in loop: for (item in list) or await for (item in stream)
      if (loopParts.isAwait) {
        // await for loop - expect Stream
        return _executeAwaitForIn(
            loopParts.identifier!, loopParts.iterable!, node.body!);
      } else {
        // Regular for-in loop - expect Iterable
        _executeForIn(loopParts.identifier!, loopParts.iterable!, node.body!);
      }
    } else {
      // Should not happen with valid Dart code
      throw StateD4rtException(
          'Unknown ForLoopParts type: ${loopParts.runtimeType}');
    }

    return null; // For loops don't produce a value
  }

  // Helper method to execute the logic of a classic for loop
  void _executeClassicFor(SAstNode? initialization, SAstNode? condition,
      List<SAstNode>? updaters, SAstNode body) {
    // 1. Create loop environment
    final loopEnvironment = Environment(enclosing: environment);
    final previousEnvironment = environment;
    environment = loopEnvironment;

    try {
      // 2. Execute initialization (if it exists)
      if (initialization != null) {
        // If initialization is a SVariableDeclarationList, visit it directly.
        // If it's an Expression (like in SForPartsWithExpression), visit it.
        initialization.accept<Object?>(this);
      }

      // 3. Loop execution
      while (true) {
        // 3.a Evaluate condition
        bool conditionResult = true; // Default to true if no condition
        if (condition != null) {
          final evalResult = condition.accept<Object?>(this);
          final bridgedInstance = toBridgedInstance(evalResult);
          if (evalResult is bool) {
            conditionResult = evalResult;
          } else if (bridgedInstance.$2 &&
              bridgedInstance.$1?.nativeObject is bool) {
            conditionResult = bridgedInstance.$1!.nativeObject as bool;
          } else {
            throw RuntimeD4rtException(
                "The condition of a 'for' loop must be a boolean, but was ${evalResult?.runtimeType}.");
          }
        }

        if (!conditionResult) {
          break;
        }

        // 3.b Execute body
        try {
          body.accept<Object?>(this);
        } on BreakException catch (e) {
          Logger.debug(
              "[For] Caught BreakException (label: ${e.label}) with current labels: $_currentStatementLabels");
          if (e.label == null || _currentStatementLabels.contains(e.label)) {
            Logger.debug("[For] Breaking loop.");
            break; // Exit the for loop entirely
          } else {
            Logger.debug("[For] Rethrowing outer break...");
            rethrow;
          }
        } on ContinueException catch (e) {
          Logger.debug(
              "[For] Caught ContinueException (label: ${e.label}) with current labels: $_currentStatementLabels");
          if (e.label == null || _currentStatementLabels.contains(e.label)) {
            Logger.debug("[For] Continuing to updaters.");
            // Skip directly to updaters for this iteration
            // The `continue` below will handle jumping to the next iteration
          } else {
            Logger.debug("[For] Rethrowing outer continue...");
            rethrow;
          }
        }

        // 3.c Execute updaters (if they exist)
        try {
          if (updaters != null) {
            for (final updater in updaters) {
              updater.accept<Object?>(this);
            }
          }
        } on BreakException {
          // This should technically not happen if break is only thrown from the body,
          // but handle defensively.
          break;
        }
        // Continue exception in updaters should just proceed to the next iteration check

        // `continue` effectively happens here by looping back
      }
    } finally {
      // 4. Restore previous environment
      environment = previousEnvironment;
    }
  }

  // Helper method to execute the logic of a for-in loop (simplified)
  void _executeForIn(SAstNode loopVariableOrIdentifier,
      SAstNode iterableExpression, SAstNode body) {
    final expressionValue = iterableExpression.accept<Object?>(this);

    // Handle iterable being BridgedInstance<Iterable>
    Object? iterableValue;
    if (toBridgedInstance(expressionValue).$2) {
      final bridgedInstance = toBridgedInstance(expressionValue).$1!;
      if (bridgedInstance.nativeObject is Iterable) {
        iterableValue = bridgedInstance.nativeObject;
      } else {
        throw RuntimeD4rtException(
            'Value used in for-in loop must be an Iterable, but got BridgedInstance containing ${bridgedInstance.nativeObject.runtimeType}');
      }
    } else if (expressionValue is Iterable) {
      iterableValue = expressionValue;
    } else {
      throw RuntimeD4rtException(
          'Value used in for-in loop must be an Iterable, but got ${expressionValue?.runtimeType}');
    }

    if (iterableValue is Iterable) {
      // Check the unwrapped iterableValue
      final loopEnvironment = Environment(enclosing: environment);
      final previousEnvironment = environment;
      environment = loopEnvironment;

      try {
        String variableName;
        if (loopVariableOrIdentifier is SDeclaredIdentifier) {
          variableName = loopVariableOrIdentifier.identifier!.name;
          environment.define(variableName, null); // Define before loop
        } else if (loopVariableOrIdentifier is SSimpleIdentifier) {
          variableName = loopVariableOrIdentifier.name;
          try {
            environment.get(variableName); // Check existence
          } catch (e) {
            throw RuntimeD4rtException(
                "Variable '$variableName' for for-in loop is not defined.");
          }
        } else {
          throw StateD4rtException(
              'Unexpected for-in loop variable type: ${loopVariableOrIdentifier.runtimeType}');
        }

        // Iterate over the native list
        for (final element in iterableValue) {
          // Assign current element to the loop variable
          environment.assign(variableName, element);

          // Execute the body
          try {
            body.accept<Object?>(this);
          } on BreakException catch (e) {
            Logger.debug(
                "[ForIn] Caught BreakException (label: ${e.label}) with current labels: $_currentStatementLabels");
            if (e.label == null || _currentStatementLabels.contains(e.label)) {
              Logger.debug("[ForIn] Breaking loop.");
              break; // Exit the for-in loop
            } else {
              Logger.debug("[ForIn] Rethrowing outer break...");
              rethrow;
            }
          } on ContinueException catch (e) {
            Logger.debug(
                "[ForIn] Caught ContinueException (label: ${e.label}) with current labels: $_currentStatementLabels");
            if (e.label == null || _currentStatementLabels.contains(e.label)) {
              Logger.debug("[ForIn] Continuing loop.");
              continue; // Go to the next element
            } else {
              Logger.debug("[ForIn] Rethrowing outer continue...");
              rethrow;
            }
          }
        }
      } finally {
        // Restore previous environment
        environment = previousEnvironment;
      }
    } else {
      // Should not happen after the check above
      throw StateD4rtException(
          'Internal error: Expected Iterable but got ${iterableValue.runtimeType}');
    }
  }

  // Helper method to execute the logic of an await for-in loop (for streams)
  Object? _executeAwaitForIn(SAstNode loopVariableOrIdentifier,
      SAstNode iterableExpression, SAstNode body) {
    final expressionValue = iterableExpression.accept<Object?>(this);

    // Handle stream being BridgedInstance<Stream>
    Object? streamValue;
    if (toBridgedInstance(expressionValue).$2) {
      final bridgedInstance = toBridgedInstance(expressionValue).$1!;
      if (bridgedInstance.nativeObject is Stream) {
        streamValue = bridgedInstance.nativeObject;
      } else {
        throw RuntimeD4rtException(
            'Value used in await for-in loop must be a Stream, but got BridgedInstance containing ${bridgedInstance.nativeObject.runtimeType}');
      }
    } else if (expressionValue is Stream) {
      streamValue = expressionValue;
    } else {
      throw RuntimeD4rtException(
          'Value used in await for-in loop must be a Stream, but got ${expressionValue?.runtimeType}');
    }

    if (streamValue is Stream) {
      // Create a suspension request for converting the stream to a list first
      if (currentAsyncState == null) {
        throw RuntimeD4rtException(
            "await for statement can only be used inside async functions");
      }

      // Convert the stream to a list first, then process it as a regular for-in loop
      return AsyncSuspensionRequest(
        _convertStreamAndProcessForIn(
            loopVariableOrIdentifier, streamValue, body),
        currentAsyncState!,
      );
    } else {
      // Should not happen after the check above
      throw StateD4rtException(
          'Internal error: Expected Stream but got ${streamValue.runtimeType}');
    }
  }

  // Convert stream to list and then process as regular for-in loop
  Future<Object?> _convertStreamAndProcessForIn(
      SAstNode loopVariableOrIdentifier,
      Stream<Object?> stream,
      SAstNode body) async {
    // Convert stream to list
    final List<Object?> items = await stream.toList();

    // Now process as a regular for-in loop with the list
    _executeForInWithItems(loopVariableOrIdentifier, items, body);

    return null; // await for loops don't produce a value
  }

  // Execute for-in loop with a list of items (reused logic from _executeForIn)
  void _executeForInWithItems(
      SAstNode loopVariableOrIdentifier, List<Object?> items, SAstNode body) {
    // G-DOV-12 FIX: Create a dedicated loop environment (like _executeForIn does)
    // to ensure the loop variable is properly scoped and accessible.
    final loopEnvironment = Environment(enclosing: environment);
    final previousEnvironment = environment;
    environment = loopEnvironment;
    try {
      String variableName;
      if (loopVariableOrIdentifier is SDeclaredIdentifier) {
        variableName = loopVariableOrIdentifier.identifier!.name;
        // Define the loop variable in the loop environment
        environment.define(variableName, null);
      } else if (loopVariableOrIdentifier is SSimpleIdentifier) {
        variableName = loopVariableOrIdentifier.name;
        try {
          environment.get(variableName); // Check existence in enclosing scope
        } catch (e) {
          throw RuntimeD4rtException(
              "Variable '$variableName' for for-in loop is not defined.");
        }
      } else {
        throw StateD4rtException(
            'Unexpected for-in loop variable type: ${loopVariableOrIdentifier.runtimeType}');
      }

      // Iterate over the items
      for (final element in items) {
        // Assign current element to the loop variable
        environment.assign(variableName, element);

        // Execute the body
        try {
          body.accept<Object?>(this);
        } on BreakException catch (e) {
          Logger.debug(
              "[AwaitForIn] Caught BreakException (label: ${e.label}) with current labels: $_currentStatementLabels");
          if (e.label == null || _currentStatementLabels.contains(e.label)) {
            Logger.debug("[AwaitForIn] Breaking loop.");
            break; // Exit the for-in loop
          } else {
            Logger.debug("[AwaitForIn] Rethrowing outer break...");
            rethrow;
          }
        } on ContinueException catch (e) {
          Logger.debug(
              "[AwaitForIn] Caught ContinueException (label: ${e.label}) with current labels: $_currentStatementLabels");
          if (e.label == null || _currentStatementLabels.contains(e.label)) {
            Logger.debug("[AwaitForIn] Continuing loop.");
            continue; // Go to the next element
          } else {
            Logger.debug("[AwaitForIn] Rethrowing outer continue...");
            rethrow;
          }
        }
      }
    } finally {
      environment = previousEnvironment;
    }
  }

  // Add handler for SVariableDeclarationList used in SForPartsWithDeclarations
  @override
  Object? visitVariableDeclarationList(SVariableDeclarationList node) {
    // We need to ensure variables are defined in the current environment.
    // visitVariableDeclaration is NOT automatically called for node.variables
    // by the generalizing visitor when visiting the list itself.
    for (final variable in node.variables) {
      if (variable.name!.name == '_') {
        // Evaluate initializer for potential side effects, but don't define
        variable.initializer?.accept<Object?>(this);
      } else {
        // Check if this is a late variable
        final isLate = node.isLate;
        final isFinal = node.isFinal;
        final variableName = variable.name!.name;

        if (isLate) {
          // Handle late variable
          if (variable.initializer != null) {
            // Late variable with lazy initializer
            final lateVar = LateVariable(variableName, () {
              // Create a closure that will evaluate the initializer when accessed
              return variable.initializer!.accept<Object?>(this);
            }, isFinal: isFinal);
            environment.define(variableName, lateVar);
            Logger.debug(
                "[VariableDeclList] Defined late variable '$variableName' with lazy initializer.");
          } else {
            // Late variable without initializer
            final lateVar = LateVariable(variableName, null, isFinal: isFinal);
            environment.define(variableName, lateVar);
            Logger.debug(
                "[VariableDeclList] Defined late variable '$variableName' without initializer.");
          }
        } else {
          // Regular (non-late) variable handling
          Object? initValue;
          Object? result; // Value returned by accept() (could be suspension)

          if (variable.initializer != null) {
            result = variable.initializer!.accept<Object?>(this);
            if (result is AsyncSuspensionRequest) {
              // Async initializer: Define as null for now, result holds suspension
              Logger.debug(
                  "[VariableDeclList] Async init for '$variableName'. Defined as null.");
              environment.define(variableName, null);
              // Propagate the suspension request.
              // If there are multiple async inits, the LAST suspension request wins.
            } else {
              // Sync initializer: Use the computed value
              initValue = result;
              Logger.debug(
                  "[VariableDeclList] Sync init for '$variableName'. Defined as $initValue.");
              environment.define(variableName, initValue);
            }
          } else {
            // No initializer: Define as null
            Logger.debug(
                "[VariableDeclList] No init for '$variableName'. Defined as null.");
            environment.define(variableName, null);
            result = null; // No suspension
          }

          // If the result of the variable's init was a suspension, we need to return it
          // to signal the state machine.
          if (result is AsyncSuspensionRequest) {
            // If any variable initialization caused suspension, return that suspension immediately.
            // The state machine needs to handle this before processing subsequent variables.
            Logger.debug(
                "[VariableDeclList] Propagating suspension from initializer of '$variableName'.");
            return result;
          }
        }
      }
    }
    // If no suspension occurred (or only sync initializers for all variables)
    return null; // Original behavior
  }

  @override
  Object? visitBreakStatement(SBreakStatement node) {
    final label = node.label?.name;
    Logger.debug(
        "[SBreakStatement] BREAKING: About to throw BreakException (label: $label). Current async state: ${currentAsyncState?.hashCode}");
    Logger.debug(
        "[SBreakStatement] Stack trace for break: ${StackTrace.current}");
    throw BreakException(label);
  }

  @override
  Object? visitContinueStatement(SContinueStatement node) {
    final label = node.label?.name;
    Logger.debug(
        "[SContinueStatement] Throwing ContinueException (label: $label)");
    throw ContinueException(label);
  }

  @override
  Object? visitYieldStatement(SYieldStatement node) {
    final value = node.expression!.accept<Object?>(this);
    Logger.debug(
        "[SYieldStatement] Yielding value: $value (star: ${node.isStar})");

    // If we're in an async* generator (with real async state), create a suspension
    if (currentAsyncState?.isGenerator == true) {
      final controller = currentAsyncState!.generatorStreamController!;

      if (node.isStar) {
        // yield* - handle asynchronously
        return AsyncSuspensionRequest(
            _handleYieldStarAsync(value, controller), currentAsyncState!,
            isYieldSuspension: true);
      } else {
        // regular yield - send to stream and create minimal suspension
        controller.add(value);
        // Create a completed future suspension to continue execution
        return AsyncSuspensionRequest(Future.value(null), currentAsyncState!,
            isYieldSuspension: true);
      }
    }

    // If we're in a sync* generator context, add directly to the values list
    if (syncGeneratorValues != null) {
      if (node.isStar) {
        // yield* - expand iterable
        if (value is Iterable) {
          syncGeneratorValues!.addAll(value);
        } else {
          throw RuntimeD4rtException(
              "yield* expression must be an Iterable, got ${value.runtimeType}");
        }
      } else {
        syncGeneratorValues!.add(value);
      }
      return null; // Continue execution
    }

    // Lim-4/Bug-43 FIX: If we're in a lazy sync* context, throw suspension to pause
    if (isLazySyncGeneratorContext) {
      throw SyncGeneratorYieldSuspension(value, isYieldStar: node.isStar);
    }

    // Fallback for other contexts
    return YieldValue(value, isYieldStar: node.isStar);
  }

  // Handle yield* in async generator context asynchronously
  Future<Object?> _handleYieldStarAsync(
      Object? value, StreamController<Object?> controller) async {
    if (value is Stream) {
      await for (final item in value) {
        controller.add(item);
      }
    } else if (value is Iterable) {
      for (final item in value) {
        controller.add(item);
      }
    } else {
      controller.addError(RuntimeD4rtException(
          "yield* expression must be a Stream or Iterable, got ${value.runtimeType}"));
    }
    return null;
  }

  @override
  Object? visitListLiteral(SListLiteral node) {
    final List<Object?> list = [];
    for (final element in node.elements) {
      _processCollectionElement(element, list, isMap: false);
    }

    // If this is a const list, return an unmodifiable version
    if (node.isConst) {
      return List.unmodifiable(list);
    }

    return list;
  }

  @override
  Object? visitParenthesizedExpression(SParenthesizedExpression node) {
    return node.expression!.accept<Object?>(this);
  }

  @override
  Object? visitCascadeExpression(SCascadeExpression node) {
    // 1. Evaluate the target expression ONCE.
    final targetValue = node.target!.accept<Object?>(this);

    // 2. Execute each cascade section ON THE ORIGINAL targetValue.
    for (final section in node.cascadeSections) {
      // We need to manually handle each section type, forcing the target.
      if (section is SMethodInvocation) {
        _executeCascadeMethodInvocation(targetValue, section);
      } else if (section is SPropertyAccess) {
        // Evaluate property access for potential side effects (getters), but discard result.
        _executeCascadePropertyAccess(targetValue, section);
      } else if (section is SAssignmentExpression) {
        _executeCascadeAssignment(targetValue, section);
      } else if (section is SIndexExpression) {
        // Evaluate index expression for potential side effects (getters?), but discard result.
        _executeCascadeIndexAccess(targetValue, section);
      } else {
        // Should not happen with valid cascade sections
        throw UnimplementedD4rtException(
            'Cascade section type not handled: ${section.runtimeType}');
      }
    }

    // 3. The cascade expression evaluates to the original target value.
    return targetValue;
  }

  void _executeCascadeMethodInvocation(
      Object? targetValue, SMethodInvocation node) {
    if (targetValue == null) {
      // Dart's .. operator throws on null, ?.. does nothing.
      // Since we can't easily distinguish here, we mimic ?.. and do nothing.
      Logger.debug(
          "[Cascade] Target is null, skipping method invocation section.");
      return;
    }

    final methodName = node.methodName!.name;
    final (positionalArgs, namedArgs) = _evaluateArguments(node.argumentList);
    List<RuntimeType>? evaluatedTypeArguments;
    final typeArgsNode = node.typeArguments;
    if (typeArgsNode != null) {
      evaluatedTypeArguments = typeArgsNode.arguments
          .map((typeNode) => _resolveTypeAnnotation(typeNode))
          .toList();
    }

    // Check if the method invocation has its own target (e.g., ..members.add('Alice'))
    // In this case, node.target is SPropertyAccess to 'members'
    Object? actualTarget = targetValue;
    if (node.target != null) {
      // The method has a target (e.g., ..members.add(...)  where members is the target)
      // We need to evaluate the target, but substitute the cascade target for SCascadeExpression references
      final nodeTarget = node.target!;
      if (nodeTarget is SPropertyAccess) {
        // This is like ..members.add(...) - first get 'members' from cascade target
        final propertyName = nodeTarget.propertyName!.name;
        if (targetValue is InterpretedInstance) {
          actualTarget = targetValue.get(propertyName, visitor: this);
        } else if (targetValue is Map) {
          actualTarget = targetValue[propertyName];
        } else if (toBridgedInstance(targetValue).$2) {
          final bridgedInstance = toBridgedInstance(targetValue).$1!;
          final getter = bridgedInstance.bridgedClass
              .findInstanceGetterAdapter(propertyName);
          if (getter != null) {
            actualTarget = getter(this, bridgedInstance.nativeObject);
          } else {
            throw RuntimeD4rtException(
                "Property '$propertyName' not found on ${bridgedInstance.bridgedClass.name} in cascade.");
          }
        } else {
          throw RuntimeD4rtException(
              "Cannot access property '$propertyName' on ${targetValue.runtimeType} in cascade.");
        }
      } else if (nodeTarget is SIndexExpression) {
        // This is like ..[index].method(...)
        final indexValue = nodeTarget.index!.accept<Object?>(this);
        if (targetValue is List && indexValue is int) {
          actualTarget = targetValue[indexValue];
        } else if (targetValue is Map) {
          actualTarget = targetValue[indexValue];
        } else {
          throw RuntimeD4rtException(
              "Index access not supported on ${targetValue.runtimeType} in cascade.");
        }
      } else {
        // For other target types, evaluate normally
        actualTarget = nodeTarget.accept<Object?>(this);
      }
    }

    if (actualTarget == null) {
      Logger.debug(
          "[Cascade] Actual target is null after property resolution, skipping.");
      return;
    }

    // Resolve and call method ON actualTarget (not the original cascade target)
    if (actualTarget is InterpretedInstance) {
      final callee = actualTarget.get(methodName); // Gets bound method
      if (callee is Callable) {
        callee.call(this, positionalArgs, namedArgs, evaluatedTypeArguments);
      } else {
        throw RuntimeD4rtException(
            "Member '$methodName' on interpreted instance is not callable in cascade.");
      }
    } else if (toBridgedInstance(actualTarget).$2) {
      // Use bridged method lookup first
      final bridgedInstance = toBridgedInstance(actualTarget).$1!;
      final adapter =
          bridgedInstance.bridgedClass.findInstanceMethodAdapter(methodName);
      if (adapter != null) {
        adapter(this, bridgedInstance.nativeObject, positionalArgs, namedArgs,
            evaluatedTypeArguments);
      } else {
        throw RuntimeD4rtException(
            "Bridged instance method '$methodName' not found in cascade.");
      }
    } else if (actualTarget is List) {
      // Handle List methods directly for un-bridged lists (from property access)
      _invokeListMethod(actualTarget, methodName, positionalArgs, namedArgs);
    } else if (actualTarget is Map) {
      // Handle Map methods directly
      _invokeMapMethod(actualTarget, methodName, positionalArgs, namedArgs);
    } else if (actualTarget is Set) {
      // Handle Set methods directly
      _invokeSetMethod(actualTarget, methodName, positionalArgs, namedArgs);
    } else if (toBridgedInstance(actualTarget).$2) {
      final bridgedInstance = toBridgedInstance(actualTarget).$1!;
      final adapter =
          bridgedInstance.bridgedClass.findInstanceMethodAdapter(methodName);
      if (adapter != null) {
        adapter(this, bridgedInstance.nativeObject, positionalArgs, namedArgs,
            evaluatedTypeArguments);
      } else {
        throw RuntimeD4rtException(
            "Bridged instance method '$methodName' not found in cascade.");
      }
    } else {
      throw RuntimeD4rtException(
          "Cannot invoke method '$methodName' on ${actualTarget.runtimeType} in cascade.");
    }
    // Ignore the return value of the method call in a cascade
  }

  /// Helper to invoke List methods directly
  Object? _invokeListMethod(List list, String methodName,
      List<Object?> positionalArgs, Map<String, Object?> namedArgs) {
    switch (methodName) {
      case 'add':
        list.add(positionalArgs.first);
        return null;
      case 'addAll':
        list.addAll(positionalArgs.first as Iterable);
        return null;
      case 'insert':
        list.insert(positionalArgs[0] as int, positionalArgs[1]);
        return null;
      case 'remove':
        return list.remove(positionalArgs.first);
      case 'removeAt':
        return list.removeAt(positionalArgs.first as int);
      case 'clear':
        list.clear();
        return null;
      case 'removeLast':
        return list.removeLast();
      case 'insertAll':
        list.insertAll(positionalArgs[0] as int, positionalArgs[1] as Iterable);
        return null;
      default:
        throw RuntimeD4rtException(
            "List method '$methodName' not supported in cascade context.");
    }
  }

  /// Helper to invoke Map methods directly
  Object? _invokeMapMethod(Map map, String methodName,
      List<Object?> positionalArgs, Map<String, Object?> namedArgs) {
    switch (methodName) {
      case 'addAll':
        map.addAll(positionalArgs.first as Map);
        return null;
      case 'remove':
        return map.remove(positionalArgs.first);
      case 'clear':
        map.clear();
        return null;
      case 'putIfAbsent':
        return map.putIfAbsent(positionalArgs[0], () => positionalArgs[1]);
      default:
        throw RuntimeD4rtException(
            "Map method '$methodName' not supported in cascade context.");
    }
  }

  /// Helper to invoke Set methods directly
  Object? _invokeSetMethod(Set set, String methodName,
      List<Object?> positionalArgs, Map<String, Object?> namedArgs) {
    switch (methodName) {
      case 'add':
        return set.add(positionalArgs.first);
      case 'addAll':
        set.addAll(positionalArgs.first as Iterable);
        return null;
      case 'remove':
        return set.remove(positionalArgs.first);
      case 'clear':
        set.clear();
        return null;
      default:
        throw RuntimeD4rtException(
            "Set method '$methodName' not supported in cascade context.");
    }
  }

  Object? _executeCascadePropertyAccess(
      Object? targetValue, SPropertyAccess node) {
    if (targetValue == null) {
      Logger.debug(
          "[Cascade] Target is null, skipping property access section.");
      return null;
    }

    final propertyName = node.propertyName!.name;
    // Resolve property/getter ON targetValue
    if (targetValue is InterpretedInstance) {
      final member = targetValue.get(propertyName);
      if (member is InterpretedFunction && member.isGetter) {
        return member.call(this, [],
            {}); // Call getter, return its value (needed for assignment LHS)
      } else {
        return member; // Return field value (needed for assignment LHS)
      }
    } else if (toBridgedInstance(targetValue).$2) {
      final bridgedInstance = toBridgedInstance(targetValue).$1!;
      final getter =
          bridgedInstance.bridgedClass.findInstanceGetterAdapter(propertyName);
      if (getter != null) {
        return getter(this, bridgedInstance.nativeObject);
      }
      // If no getter, maybe it's a method to be used in assignment? Unlikely.
      throw RuntimeD4rtException(
          "Bridged instance property '$propertyName' (getter) not found in cascade.");
    } else {
      throw RuntimeD4rtException(
          "property '$propertyName' (getter) not found in cascade.");
    }
  }

  Object? _executeCascadeIndexAccess(
      Object? targetValue, SIndexExpression node) {
    if (targetValue == null) {
      Logger.debug("[Cascade] Target is null, skipping index access section.");
      return null;
    }

    final indexValue = node.index!.accept<Object?>(this);
    // Perform index access ON targetValue
    if (targetValue is List) {
      if (indexValue is int) {
        if (indexValue < 0 || indexValue >= targetValue.length) {
          throw RuntimeD4rtException(
              'Index out of range in cascade: $indexValue');
        }
        return targetValue[indexValue];
      } else {
        throw RuntimeD4rtException('List index must be an integer in cascade.');
      }
    } else if (targetValue is Map) {
      return targetValue[indexValue];
    } else if (targetValue is String && indexValue is int) {
      return targetValue[indexValue];
    } else {
      throw RuntimeD4rtException(
          'Unsupported target for index access in cascade: ${targetValue.runtimeType}');
    }
    // Return the accessed value (needed for assignment LHS)
  }

  void _executeCascadeAssignment(
      Object? targetValue, SAssignmentExpression node) {
    if (targetValue == null) {
      Logger.debug("[Cascade] Target is null, skipping assignment section.");
      return;
    }

    final rhsValue = node.rightHandSide!.accept<Object?>(this);
    final operatorType = node.operator;
    final lhs = node.leftHandSide;

    if (lhs is SSimpleIdentifier) {
      // Property assignment: targetValue.propertyName op= rhsValue
      final propertyName = lhs.name;
      Object? newValue;
      if (operatorType == '=') {
        newValue = rhsValue;
      } else {
        // Compound assignment
        Object? currentValue;
        // Need to get the current value from the target
        if (targetValue is InterpretedInstance) {
          currentValue = targetValue.get(propertyName);
        } else if (toBridgedInstance(targetValue).$2) {
          final bridgedInstance = toBridgedInstance(targetValue).$1!;
          final getter = bridgedInstance.bridgedClass
              .findInstanceGetterAdapter(propertyName);
          if (getter == null) {
            throw RuntimeD4rtException(
                "No getter '$propertyName' for compound assignment in cascade.");
          }
          currentValue = getter(this, bridgedInstance.nativeObject);
        } else {
          throw RuntimeD4rtException(
              "Cannot get property '$propertyName' for compound assignment on ${targetValue.runtimeType} in cascade.");
        }
        newValue = computeCompoundValue(currentValue, rhsValue, operatorType);
      }

      // Set the value on the target
      if (targetValue is InterpretedInstance) {
        final setter = targetValue.klass.findInstanceSetter(propertyName);
        if (setter != null) {
          setter.bind(targetValue).call(this, [newValue], {});
        } else {
          targetValue.set(propertyName, newValue, this); // Direct field set
        }
      } else if (toBridgedInstance(targetValue).$2) {
        final bridgedInstance = toBridgedInstance(targetValue).$1!;
        final setter = bridgedInstance.bridgedClass
            .findInstanceSetterAdapter(propertyName);
        if (setter == null) {
          throw RuntimeD4rtException(
              "No setter '$propertyName' for assignment in cascade.");
        }
        setter(this, bridgedInstance.nativeObject, newValue);
      } else {
        throw RuntimeD4rtException(
            "Cannot set property '$propertyName' on ${targetValue.runtimeType} in cascade.");
      }
    } else if (lhs is SIndexExpression) {
      // Index assignment in cascade. The SIndexExpression may target:
      // 1. The cascade target directly: ..[index] = value (lhs.target is null or SCascadeExpression)
      // 2. A property on the cascade target: ..property[index] = value (lhs.target is SPropertyAccess)
      final indexValue = lhs.index!.accept<Object?>(this);

      // Bug-94 FIX: Resolve the actual indexable target. If the SIndexExpression
      // has an explicit target (e.g. SPropertyAccess for ..headers['key']),
      // resolve that property on the cascade target first.
      Object? indexTarget = targetValue;
      final lhsTarget = lhs.target;
      if (lhsTarget != null && lhsTarget is SPropertyAccess) {
        final propName = lhsTarget.propertyName!.name;
        if (targetValue is InterpretedInstance) {
          indexTarget = targetValue.get(propName);
        } else if (toBridgedInstance(targetValue).$2) {
          final bridgedInstance = toBridgedInstance(targetValue).$1!;
          final getter =
              bridgedInstance.bridgedClass.findInstanceGetterAdapter(propName);
          if (getter != null) {
            indexTarget = getter(this, bridgedInstance.nativeObject);
          }
        }
      }

      Object? newValue;

      if (operatorType == '=') {
        newValue = rhsValue;
      } else {
        // Compound assignment
        Object? currentValue;
        if (indexTarget is List) {
          if (indexValue is! int)
            throw RuntimeD4rtException('List index must be int.');
          if (indexValue < 0 || indexValue >= indexTarget.length) {
            throw RuntimeD4rtException('Index out of range.');
          }
          currentValue = indexTarget[indexValue];
        } else if (indexTarget is Map) {
          currentValue = indexTarget[indexValue];
        } else {
          throw RuntimeD4rtException(
              "Compound index assignment target must be List or Map in cascade.");
        }
        newValue = computeCompoundValue(currentValue, rhsValue, operatorType);
      }

      // Set the value
      if (indexTarget is List) {
        if (indexValue is! int)
          throw RuntimeD4rtException('List index must be int.');
        if (indexValue < 0 || indexValue >= indexTarget.length) {
          throw RuntimeD4rtException('Index out of range.');
        }
        indexTarget[indexValue] = newValue;
      } else if (indexTarget is Map) {
        indexTarget[indexValue] = newValue;
      } else {
        throw RuntimeD4rtException(
            "Index assignment target must be List or Map in cascade.");
      }
    } else if (lhs is SPropertyAccess) {
      // Cascade assignment like: target..property = value or target..property += value
      // Note: targetValue is the original cascade target, NOT lhs.target
      final propertyName = lhs.propertyName!.name;
      Object? newValue;

      if (operatorType == '=') {
        newValue = rhsValue; // Simple assignment
      } else {
        // Compound assignment
        Object? currentValue;
        // 1. Get current value from targetValue using propertyName
        if (targetValue is InterpretedInstance) {
          currentValue = targetValue.get(propertyName); // Handles field/getter
        } else if (toBridgedInstance(targetValue).$2) {
          final bridgedInstance = toBridgedInstance(targetValue).$1!;
          final getter = bridgedInstance.bridgedClass
              .findInstanceGetterAdapter(propertyName);
          if (getter == null) {
            throw RuntimeD4rtException(
                "No getter '$propertyName' for compound assignment in cascade.");
          }
          currentValue = getter(this, bridgedInstance.nativeObject);
        } else {
          throw RuntimeD4rtException(
              "Cannot get property '$propertyName' for compound assignment on ${targetValue.runtimeType} in cascade.");
        }
        // 2. Compute new value
        newValue = computeCompoundValue(currentValue, rhsValue, operatorType);
      }

      // 3. Set the new value on targetValue using propertyName
      if (targetValue is InterpretedInstance) {
        final setter = targetValue.klass.findInstanceSetter(propertyName);
        if (setter != null) {
          setter.bind(targetValue).call(this, [newValue], {});
        } else {
          // Direct field assignment if no setter
          targetValue.set(propertyName, newValue, this);
        }
      } else if (toBridgedInstance(targetValue).$2) {
        final bridgedInstance = toBridgedInstance(targetValue).$1!;
        final setter = bridgedInstance.bridgedClass
            .findInstanceSetterAdapter(propertyName);
        if (setter == null) {
          throw RuntimeD4rtException(
              "No setter '$propertyName' for assignment in cascade.");
        }
        setter(this, bridgedInstance.nativeObject, newValue);
      } else {
        throw RuntimeD4rtException(
            "Cannot set property '$propertyName' on ${targetValue.runtimeType} in cascade.");
      }
    } else {
      throw UnimplementedD4rtException(
          'Unsupported assignment LHS in cascade: ${lhs.runtimeType}');
    }
    // Assignment in cascade doesn't produce a value to be used further.
  }

  void _processCollectionElement(SAstNode element, Object collection,
      {required bool isMap}) {
    if (element is SMapLiteralEntry) {
      if (!isMap) {
        throw RuntimeD4rtException(
            "Unexpected SMapLiteralEntry ('key: value') in a non-map literal.");
      }
      if (collection is Map) {
        final key = element.key!.accept<Object?>(this);
        final value = element.value!.accept<Object?>(this);
        collection[key] = value;
      } else {
        // Should not happen if isMap is true
        throw StateD4rtException(
            "Internal error: Expected Map for map literal.");
      }
    } else if (element is SSpreadElement) {
      final expressionValue = element.expression!.accept<Object?>(this);
      if (element.isNullAware && expressionValue == null) {
        // Null-aware spread with null value, do nothing
        return;
      }
      if (isMap) {
        Map? mapToAdd;
        final bridgedInstance = toBridgedInstance(expressionValue);
        if (expressionValue is Map) {
          mapToAdd = expressionValue;
        } else if (bridgedInstance.$2 &&
            bridgedInstance.$1?.nativeObject is Map) {
          mapToAdd = bridgedInstance.$1!.nativeObject as Map;
        } else {
          throw RuntimeD4rtException(
              'Spread element in a Map literal requires a Map, but got ${expressionValue?.runtimeType}');
        }
        (collection as Map).addAll(mapToAdd);
      } else {
        // List or Set Spread Logic...
        Object? iterableToAdd;
        if (toBridgedInstance(expressionValue).$2) {
          final bridgedInstance = toBridgedInstance(expressionValue).$1!;
          if (bridgedInstance.nativeObject is Iterable) {
            iterableToAdd = bridgedInstance.nativeObject;
          } else {
            // BridgedInstance does not contain an Iterable
            throw RuntimeD4rtException(
                'Spread element in a ${collection is List ? 'List' : 'Set'} literal requires an Iterable, but got BridgedInstance containing ${bridgedInstance.nativeObject.runtimeType}');
          }
        } else if (expressionValue is Iterable) {
          // Original check: If not BridgedInstance, check if it's directly Iterable
          iterableToAdd = expressionValue;
        } else {
          // Neither BridgedInstance with Iterable nor direct Iterable
          throw RuntimeD4rtException(
              'Spread element in a ${collection is List ? 'List' : 'Set'} literal requires an Iterable, but got ${expressionValue?.runtimeType}');
        }

        // Now use iterableToAdd which is guaranteed to be Iterable
        // Should always be non-null if no error thrown
        if (collection is List) {
          collection.addAll(iterableToAdd as Iterable); // Cast is safe here
        } else if (collection is Set) {
          collection.addAll(iterableToAdd as Iterable); // Cast is safe here
        } else {
          throw StateD4rtException(
              "Internal error: Expected List or Set for non-map literal.");
        }
        // else case handled by error throws above
      }
    } else if (element is SIfElement) {
      final conditionValue = element.condition!.accept<Object?>(this);
      bool conditionResult;
      final bridgedInstance = toBridgedInstance(conditionValue);
      if (conditionValue is bool) {
        conditionResult = conditionValue;
      } else if (bridgedInstance.$2 &&
          bridgedInstance.$1?.nativeObject is bool) {
        conditionResult = bridgedInstance.$1!.nativeObject as bool;
      } else {
        throw RuntimeD4rtException(
            'Condition in collection \'if\' must be a boolean, but got ${conditionValue?.runtimeType}');
      }

      if (conditionResult) {
        _processCollectionElement(element.thenElement!, collection,
            isMap: isMap);
      } else if (element.elseElement != null) {
        _processCollectionElement(element.elseElement!, collection,
            isMap: isMap);
      }
    } else if (element is SForElement) {
      final loopParts = element.forLoopParts;
      if (loopParts is SForEachPartsWithDeclaration ||
          loopParts is SForEachPartsWithIdentifier) {
        final iterableExpression = loopParts is SForEachPartsWithDeclaration
            ? loopParts.iterable
            : (loopParts as SForEachPartsWithIdentifier).iterable;
        final loopVariableNode = loopParts is SForEachPartsWithDeclaration
            ? loopParts.loopVariable
            : (loopParts as SForEachPartsWithIdentifier).identifier;

        final iterableValue = iterableExpression!.accept<Object?>(this);

        if (iterableValue is Iterable) {
          final loopEnvironment = Environment(enclosing: environment);
          final previousEnvironment = environment;
          environment = loopEnvironment;

          try {
            String variableName;
            if (loopVariableNode is SDeclaredIdentifier) {
              variableName = loopVariableNode.identifier!.name;
              environment.define(variableName, null); // Define before loop
            } else if (loopVariableNode is SSimpleIdentifier) {
              variableName = loopVariableNode.name;
            } else {
              throw StateD4rtException(
                  'Unexpected for-in loop variable type: ${loopVariableNode.runtimeType}');
            }

            for (final item in iterableValue) {
              environment.assign(variableName, item);
              _processCollectionElement(element.body!, collection,
                  isMap: isMap);
            }
          } finally {
            environment = previousEnvironment;
          }
        } else {
          throw RuntimeD4rtException(
              'Value used in collection \'for-in\' must be an Iterable, but got ${iterableValue?.runtimeType}');
        }
      } else if (loopParts is SForPartsWithDeclarations ||
          loopParts is SForPartsWithExpression) {
        SAstNode? initialization;
        SAstNode? condition;
        List<SAstNode>? updaters;
        if (loopParts is SForPartsWithDeclarations) {
          initialization = loopParts.variables;
          condition = loopParts.condition;
          updaters = loopParts.updaters;
        } else if (loopParts is SForPartsWithExpression) {
          initialization = loopParts.initialization;
          condition = loopParts.condition;
          updaters = loopParts.updaters;
        }
        final loopEnvironment = Environment(enclosing: environment);
        final previousEnvironment = environment;
        environment = loopEnvironment;
        try {
          // Initialisation
          if (initialization != null) {
            initialization.accept<Object?>(this);
          }
          // Boucle
          while (true) {
            bool conditionResult = true;
            if (condition != null) {
              final evalResult = condition.accept<Object?>(this);
              final bridgedInstance = toBridgedInstance(evalResult);
              if (evalResult is bool) {
                conditionResult = evalResult;
              } else if (bridgedInstance.$2 &&
                  bridgedInstance.$1?.nativeObject is bool) {
                conditionResult = bridgedInstance.$1!.nativeObject as bool;
              } else {
                throw RuntimeD4rtException(
                    "The condition of a 'for' loop must be a boolean, but was ${evalResult?.runtimeType}.");
              }
            }
            if (!conditionResult) break;
            _processCollectionElement(element.body!, collection, isMap: isMap);
            if (updaters != null) {
              for (final updater in updaters) {
                updater.accept<Object?>(this);
              }
            }
          }
        } finally {
          environment = previousEnvironment;
        }
      } else {
        throw UnimplementedD4rtException(
            'Unsupported for-loop type in collection literal: ${loopParts.runtimeType}');
      }
    } else if (element.nodeType == 'NullAwareElement') {
      // TODO: SNullAwareElement not yet in serialized AST - use nodeType check
      // Use element.value as per analyzer AST definition
      final value = (element as dynamic).value?.accept<Object?>(this);
      if (value != null) {
        if (collection is List) {
          collection.add(value);
        } else if (collection is Set) {
          collection.add(value);
        } else {
          // Should not happen if isMap is false
          throw StateD4rtException(
              "Internal error: Expected List or Set for NullAwareElement.");
        }
      }
      // If value is null, do nothing.
    } else {
      // General expression element (not a specific collection element type)
      final value = element.accept<Object?>(this);
      if (isMap) {
        throw RuntimeD4rtException(
            "Expected a SMapLiteralEntry ('key: value') but got an expression in map literal.");
      } else if (collection is List) {
        collection.add(value);
      } else if (collection is Set) {
        collection.add(value);
      }
    }
  }

  @override
  Object? visitFunctionDeclaration(SFunctionDeclaration node) {
    // Create a function object that captures the current environment (closure)
    // Use the .declaration constructor
    final returnType = node.returnType;
    final body0 = node.functionExpression!.body;
    bool isAsync = (body0 is SBlockFunctionBody)
        ? body0.isAsync
        : (body0 is SExpressionFunctionBody)
            ? body0.isAsync
            : false;
    bool isNullable = false;
    if (returnType is SNamedType) {
      isNullable = returnType.toString().contains('?');
    }

    // Handle type parameters for generic functions
    Environment? tempEnvironment;
    final typeParameters = node.functionExpression!.typeParameters;

    if (typeParameters != null) {
      Logger.debug(
          "[InterpreterVisitor.visitFunctionDeclaration] Function '${node.name!.name}' has ${typeParameters.typeParameters.length} type parameters");

      // Create a temporary environment for type resolution
      tempEnvironment = Environment(enclosing: environment);

      // Create temporary type parameter placeholders
      for (final typeParam in typeParameters.typeParameters) {
        final paramName = typeParam.name!.name;

        // Create a simple STypeParameter placeholder in the temp environment
        final typeParamPlaceholder = TypeParameter(paramName);
        tempEnvironment.define(paramName, typeParamPlaceholder);

        Logger.debug(
            "[InterpreterVisitor.visitFunctionDeclaration]   Defined type parameter '$paramName' in temp environment");
      }
    }

    // Use the temp environment (if any) for type resolution, otherwise use the normal environment
    final resolveEnvironment = tempEnvironment ?? environment;

    final declaredReturnType = tempEnvironment != null
        ? _resolveTypeAnnotationWithEnvironment(
            node.returnType, resolveEnvironment,
            isAsync: isAsync)
        : _resolveTypeAnnotation(node.returnType, isAsync: isAsync);

    final function = InterpretedFunction.declaration(
        node, environment, declaredReturnType, isNullable);
    // Define the function in the current environment
    environment.define(node.name!.name, function);
    return null; // Declaration itself doesn't return a value
  }

  // Handle function expressions (anonymous functions)
  @override
  Object? visitFunctionExpression(SFunctionExpression node) {
    // Create a function object capturing the current environment (closure)
    // Use the .expression constructor since it might be anonymous
    final function = InterpretedFunction.expression(node, environment);
    // Return the function object itself as the value of the expression
    return function;
  }

  @override
  Object? visitReturnStatement(SReturnStatement node) {
    // Walk up the AST to find the enclosing function
    // Bug-73, Bug-74 FIX: A SFunctionDeclaration contains a SFunctionExpression as its child,
    // so we need to find the SFunctionDeclaration (which has the name) rather than stopping
    // at the inner SFunctionExpression.
    SAstNode eDecl = node;
    if (eDecl is SFunctionDeclaration) {
      // Named function - prefer this over SFunctionExpression
    } else if (eDecl is SFunctionExpression) {
      // TODO: SAstNode has no parent reference in serialized AST
      // Check if parent is a SFunctionDeclaration - if so, use that instead
      // In the serialized AST we can't check parent, so just use the expression as-is
    }
    // TODO: SAstNode has no parent reference in serialized AST - cannot walk up

    Object? returnValue;
    if (node.expression != null) {
      returnValue = node.expression!.accept<Object?>(this);
      if (returnValue is AsyncSuspensionRequest) {
        return returnValue;
      }
    } else {
      returnValue = null;
    }

    if (eDecl is SFunctionDeclaration || eDecl is SFunctionExpression) {
      bool isNullable = false;
      String functionName = '<anonymous>';
      RuntimeType? declaredType;
      RuntimeType? valueRuntimeType;

      try {
        InterpretedFunction? currentCallable;

        if (eDecl is SFunctionDeclaration) {
          functionName = eDecl.name!.name;
          currentCallable =
              environment.get(functionName) as InterpretedFunction?;
        } else if (eDecl is SFunctionExpression) {
          // For anonymous functions (closures), use currentFunction from visitor
          currentCallable = currentFunction;
        }

        if (currentCallable is InterpretedFunction) {
          declaredType = currentCallable.declaredReturnType;
          isNullable = currentCallable.isNullable;

          // Special handling for async* generators: return without value should be allowed
          if (currentCallable.isAsyncGenerator && returnValue == null) {
            throw ReturnException(returnValue); // Exit generator cleanly
          }
        }
        valueRuntimeType = environment.getRuntimeType(returnValue);

        String declaredTypeDetails = "N/A";
        if (declaredType != null) {
          declaredTypeDetails =
              "Name: ${declaredType.name}, Hash: ${declaredType.hashCode}";
          if (declaredType is BridgedClass) {
            declaredTypeDetails +=
                ", NativeType: ${declaredType.nativeType}, NativeHash: ${declaredType.nativeType.hashCode}";
          }
        }

        String valueRuntimeTypeDetails = "N/A";
        if (valueRuntimeType != null) {
          valueRuntimeTypeDetails =
              "Name: ${valueRuntimeType.name}, Hash: ${valueRuntimeType.hashCode}";
          if (valueRuntimeType is BridgedClass) {
            valueRuntimeTypeDetails +=
                ", NativeType: ${valueRuntimeType.nativeType}, NativeHash: ${valueRuntimeType.nativeType.hashCode}";
          }
        }

        Logger.debug("[visitReturnStatement] Function: '$functionName'");
        Logger.debug(
            "[visitReturnStatement]   Declared Type: $declaredTypeDetails");
        Logger.debug(
            "[visitReturnStatement]   Value Runtime Type: $valueRuntimeTypeDetails");
        Logger.debug(
            "[visitReturnStatement]   Return Value: $returnValue (Type: ${returnValue?.runtimeType})");
        Logger.debug(
            "[visitReturnStatement]   Is Declared Type Nullable: $isNullable");

        if (declaredType != null && valueRuntimeType != null) {
          Logger.debug(
              "[visitReturnStatement]   declaredType.isSubtypeOf(valueRuntimeType) = ${declaredType.isSubtypeOf(valueRuntimeType)}");
        }

        if (valueRuntimeType != null) {
          if (declaredType != null) {
            if (declaredType.name != "dynamic" &&
                !declaredType.isSubtypeOf(valueRuntimeType,
                    value: returnValue)) {
              bool showError = true;
              if (isNullable && returnValue == null) {
                showError = false;
              }
              if (declaredType.name == "void" && returnValue == null) {
                showError = false;
              }
              if (declaredType.name == "Object" && returnValue != null) {
                showError = false;
              }
              // Bug-73 FIX: In async functions, returning a Future<T> when declared type is T is allowed
              // Dart automatically awaits the inner Future. Check if:
              // 1. The function is async (currentCallable.isAsync)
              // 2. The return value is a Future
              // 3. The declared type matches the Future's inner type (or is void)
              if (currentCallable != null &&
                  currentCallable.isAsync &&
                  returnValue is Future) {
                // Allow returning Future from async function - Dart awaits it
                showError = false;
              }

              // Bug-93 FIX: Dart implicitly promotes int to double when the
              // declared return type is double and the value is an int.
              if (declaredType.name == 'double' && returnValue is int) {
                showError = false;
                returnValue = returnValue.toDouble();
              }

              if (showError) {
                final declaredTypeName =
                    isNullable ? '${declaredType.name}?' : declaredType.name;
                throw RuntimeD4rtException(
                    "A value of type '${valueRuntimeType.name}' can't be returned from the function '$functionName' because it has a return type of '$declaredTypeName'.");
              }
            }
          }
        }
      } catch (e) {
        // Log before rethrow for more context in case of unexpected error here
        Logger.error(
            "[visitReturnStatement] Error during type check for function '$functionName': $e");
        if (e is Error) {
          Logger.error("Stack trace: ${e.stackTrace}");
        }
        rethrow;
      }
    }

    // For non-suspended results, throw the exception to unwind the stack.
    throw ReturnException(returnValue);
  }

  @override
  Object? visitConditionalExpression(SConditionalExpression node) {
    final conditionValue = node.condition!.accept<Object?>(this);
    bool conditionResult;
    final bridgedInstance = toBridgedInstance(conditionValue);
    if (conditionValue is bool) {
      conditionResult = conditionValue;
    } else if (bridgedInstance.$2 && bridgedInstance.$1?.nativeObject is bool) {
      conditionResult = bridgedInstance.$1!.nativeObject as bool;
    } else {
      throw RuntimeD4rtException(
          "The condition of a conditional expression must be a boolean, but was ${conditionValue?.runtimeType}.");
    }

    if (conditionResult) {
      return node.thenExpression!.accept<Object?>(this);
    } else {
      return node.elseExpression!.accept<Object?>(this);
    }
  }

  @override
  Object? visitPrefixExpression(SPrefixExpression node) {
    final operatorType = node.operator;
    final operandNode = node.operand;
    final operandValue = operandNode!.accept<Object?>(this);
    final bridgedInstance = toBridgedInstance(operandValue);
    final operand =
        bridgedInstance.$2 ? bridgedInstance.$1!.nativeObject : operandValue;

    switch (operatorType) {
      case '!': // Logical NOT
        // Use unwrapped operand for check
        if (operand is bool) {
          return !operand;
        } else {
          // Error uses original value type
          throw RuntimeD4rtException(
              "Operand for '!' must be a boolean, but was ${operandValue?.runtimeType}.");
        }

      case '-': // Unary minus (negation)
        // Use unwrapped operand for check
        if (operand is num) {
          return -operand;
        } else if (operand is BigInt) {
          return -operand;
        } else if (operandValue is InterpretedInstance) {
          // Check for class operator - method
          final operatorMethod = operandValue.findOperator('-');
          if (operatorMethod != null) {
            Logger.debug(
                "[PrefixExpr] Found class operator '-' on ${operandValue.klass.name}. Calling...");
            try {
              return operatorMethod.bind(operandValue).call(this, [], {});
            } on ReturnException catch (e) {
              return e.value;
            } catch (e) {
              throw RuntimeD4rtException(
                  "Error executing class operator '-': $e");
            }
          }
          // No class operator found, try extensions
        }

        // Check for bridged operator methods (unary -)
        if (toBridgedInstance(operandValue).$2) {
          final bridgedInstance = toBridgedInstance(operandValue).$1!;
          final bridgedClass = bridgedInstance.bridgedClass;
          final methodAdapter = bridgedClass.findInstanceMethodAdapter('-');
          if (methodAdapter != null) {
            Logger.debug(
                "[PrefixExpr] Found bridged unary operator '-' for ${bridgedClass.name}. Calling adapter...");
            try {
              // Unary operator - call with empty positional args
              return methodAdapter(
                  this, bridgedInstance.nativeObject, [], {}, null);
            } catch (e, s) {
              Logger.error(
                  "[PrefixExpr] Native exception during bridged unary operator '-' on ${bridgedClass.name}: $e\\n$s");
              throw RuntimeD4rtException(
                  "Native error during bridged unary operator '-' on ${bridgedClass.name}: $e");
            }
          }
        }

        const operatorName = '-';
        try {
          final extensionOperator =
              environment.findExtensionMember(operandValue, operatorName);
          if (extensionOperator is ExtensionMemberCallable &&
              extensionOperator.isOperator) {
            Logger.debug(
                "[PrefixExpr] Found extension operator '-' for type ${operandValue?.runtimeType}. Calling...");
            // Args: receiver (operandValue)
            try {
              return extensionOperator.call(this, [operandValue], {});
            } on ReturnException catch (e) {
              return e.value;
            } catch (e) {
              throw RuntimeD4rtException(
                  "Error executing extension operator '-': $e");
            }
          }
        } on RuntimeD4rtException catch (findError) {
          Logger.debug(
              "[PrefixExpr] Extension operator '-' not found for type ${operandValue?.runtimeType}. Error: ${findError.message}");
          // Fall through
        }
        // Error uses original value type if extension not found/failed
        throw RuntimeD4rtException(
            "Operand for unary '-' must be a number or have an operator defined, but was ${operandValue?.runtimeType}.");

      case '~': // Bitwise NOT (~)
        if (operand is int) {
          return ~operand;
        } else if (operand is BigInt) {
          // BigInt does not have a standard unary ~ operator in Dart
          // We rely solely on extensions for BigInt bitwise NOT
        } else if (operandValue is InterpretedInstance) {
          // Check for class operator ~ method
          final operatorMethod = operandValue.findOperator('~');
          if (operatorMethod != null) {
            Logger.debug(
                "[PrefixExpr] Found class operator '~' on ${operandValue.klass.name}. Calling...");
            try {
              return operatorMethod.bind(operandValue).call(this, [], {});
            } on ReturnException catch (e) {
              return e.value;
            } catch (e) {
              throw RuntimeD4rtException(
                  "Error executing class operator '~': $e");
            }
          }
          // No class operator found, try extensions
        }

        // Check for bridged operator methods (unary ~)
        if (toBridgedInstance(operandValue).$2) {
          final bridgedInstance = toBridgedInstance(operandValue).$1!;
          final bridgedClass = bridgedInstance.bridgedClass;
          final methodAdapter = bridgedClass.findInstanceMethodAdapter('~');
          if (methodAdapter != null) {
            Logger.debug(
                "[PrefixExpr] Found bridged unary operator '~' for ${bridgedClass.name}. Calling adapter...");
            try {
              // Unary operator - call with empty positional args
              return methodAdapter(
                  this, bridgedInstance.nativeObject, [], {}, null);
            } catch (e, s) {
              Logger.error(
                  "[PrefixExpr] Native exception during bridged unary operator '~' on ${bridgedClass.name}: $e\\n$s");
              throw RuntimeD4rtException(
                  "Native error during bridged unary operator '~' on ${bridgedClass.name}: $e");
            }
          }
        }

        // Try Extension Operator '~' (for non-int or BigInt)
        const operatorNameTilde = '~';
        try {
          final extensionOperator =
              environment.findExtensionMember(operandValue, operatorNameTilde);
          if (extensionOperator is ExtensionMemberCallable &&
              extensionOperator.isOperator) {
            Logger.debug(
                "[PrefixExpr] Found extension operator '~' for type ${operandValue?.runtimeType}. Calling...");
            // Args: receiver (operandValue)
            try {
              return extensionOperator.call(this, [operandValue], {});
            } on ReturnException catch (e) {
              return e.value;
            } catch (e) {
              throw RuntimeD4rtException(
                  "Error executing extension operator '~': $e");
            }
          }
        } on RuntimeD4rtException catch (findError) {
          Logger.debug(
              "[PrefixExpr] Extension operator '~' not found for type ${operandValue?.runtimeType}. Error: ${findError.message}");
          // Fall through
        }
        // Error if neither standard nor extension worked
        throw RuntimeD4rtException(
            "Operand for unary '~' must be an int or have an operator defined, but was ${operandValue?.runtimeType}.");

      case '++': // Prefix increment (++x)
      case '--': // Prefix decrement (--x)
        // Re-evaluate and unwrap operand specifically for ++/--
        final operandValue = operandNode.accept<Object?>(this);
        final bridgedInstance = toBridgedInstance(operandValue);
        final assignOperand = bridgedInstance.$2
            ? bridgedInstance.$1!.nativeObject
            : operandValue;

        // Check if AST node is assignable (SSimpleIdentifier or SPropertyAccess for now)
        if (operandNode is SSimpleIdentifier) {
          final variableName = operandNode.name;
          // We need the current value (already got it as assignOperand)
          final currentValue = assignOperand;

          if (currentValue is num) {
            final newValue =
                operatorType == '++' ? currentValue + 1 : currentValue - 1;
            // Assign the new value back to the variable
            environment.assign(variableName, newValue);
            // Return the *new* value
            return newValue;
          } else if (operandValue is InterpretedInstance) {
            // Use custom + operator with literal 1
            final operatorMethod = operandValue.findOperator('+');
            if (operatorMethod != null) {
              try {
                // For ++x, we create appropriate operand and call x + operand
                final operand =
                    _createIncrementOperand(currentValue, operatorType == '++');
                // Note: For --, we could either call x + (-1) or x - 1
                // Let's use + with -1 for consistency
                final newValue =
                    operatorMethod.bind(operandValue).call(this, [operand], {});
                // Assign the new value back to the variable
                environment.assign(variableName, newValue);
                // Return the *new* value
                return newValue;
              } on ReturnException catch (e) {
                final newValue = e.value;
                // Assign the new value back to the variable
                environment.assign(variableName, newValue);
                // Return the *new* value
                return newValue;
              } catch (e) {
                throw RuntimeD4rtException(
                    "Error executing custom operator '+' for prefix '${operatorType == '++' ? '++' : '--'}': $e");
              }
            } else {
              throw RuntimeD4rtException(
                  "Cannot increment/decrement object of type '${operandValue.klass.name}': No operator '+' found.");
            }
          } else {
            // Requires finding operator +/-, then assigning back.
            // Complex, skip for now.
            // Error uses original value type
            throw RuntimeD4rtException(
                "Operand for prefix '${operatorType == '++' ? '++' : '--'}' must be a number, but was ${operandValue?.runtimeType}. Extension support TBD.");
          }
        } else if (operandNode is SPropertyAccess) {
          // Handle property access like obj.field++
          final targetValue = operandNode.target?.accept<Object?>(this);
          final propertyName = operandNode.propertyName!.name;

          if (targetValue is InterpretedInstance) {
            // Get current value via getter or field
            final currentValue = targetValue.get(propertyName);

            // Calculate new value
            Object? newValue;
            if (currentValue is num) {
              newValue =
                  operatorType == '++' ? currentValue + 1 : currentValue - 1;
            } else if (currentValue is InterpretedInstance) {
              // Use custom + operator with literal 1
              final operatorMethod = currentValue.findOperator('+');
              if (operatorMethod != null) {
                try {
                  // For ++x, we create a literal 1 and call x + 1
                  operatorType == '++' ? 1 : -1;
                  // Note: For --, we could either call x + (-1) or x - 1
                  // Let's use + with -1 for consistency
                  newValue = operatorMethod
                      .bind(currentValue)
                      .call(this, [operand], {});
                } on ReturnException catch (e) {
                  newValue = e.value;
                } catch (e) {
                  throw RuntimeD4rtException(
                      "Error executing custom operator '+' for prefix '${operatorType == '++' ? '++' : '--'}': $e");
                }
              } else {
                throw RuntimeD4rtException(
                    "Cannot increment/decrement object of type '${currentValue.klass.name}': No operator '+' found.");
              }
            } else {
              throw RuntimeD4rtException(
                  "Cannot increment/decrement property '$propertyName' of type '${currentValue?.runtimeType}': Expected number or object with '+' operator.");
            }

            // Set new value via setter or field
            final setter = targetValue.klass.findInstanceSetter(propertyName);
            if (setter != null) {
              setter.bind(targetValue).call(this, [newValue], {});
            } else {
              targetValue.set(propertyName, newValue, this);
            }

            // Return the *new* value for prefix operators
            return newValue;
          } else {
            throw RuntimeD4rtException(
                "Cannot increment/decrement property on non-instance object of type '${targetValue?.runtimeType}'.");
          }
        } else if (operandNode is SPrefixedIdentifier) {
          // Handle prefixed identifier like obj.field++ (parsed as SPrefixedIdentifier)
          final targetValue = operandNode.prefix!.accept<Object?>(this);
          final propertyName = operandNode.identifier!.name;

          if (targetValue is InterpretedInstance) {
            // Get current value via getter or field
            final currentValue = targetValue.get(propertyName);

            // Calculate new value
            Object? newValue;
            if (currentValue is num) {
              newValue =
                  operatorType == '++' ? currentValue + 1 : currentValue - 1;
            } else if (currentValue is InterpretedInstance) {
              // Use custom + operator with literal 1
              final operatorMethod = currentValue.findOperator('+');
              if (operatorMethod != null) {
                try {
                  // For ++x, we create a literal 1 and call x + 1
                  operatorType == '++' ? 1 : -1;
                  // Note: For --, we could either call x + (-1) or x - 1
                  // Let's use + with -1 for consistency
                  newValue = operatorMethod
                      .bind(currentValue)
                      .call(this, [operand], {});
                } on ReturnException catch (e) {
                  newValue = e.value;
                } catch (e) {
                  throw RuntimeD4rtException(
                      "Error executing custom operator '+' for prefix '${operatorType == '++' ? '++' : '--'}': $e");
                }
              } else {
                throw RuntimeD4rtException(
                    "Cannot increment/decrement object of type '${currentValue.klass.name}': No operator '+' found.");
              }
            } else {
              throw RuntimeD4rtException(
                  "Cannot increment/decrement property '$propertyName' of type '${currentValue?.runtimeType}': Expected number or object with '+' operator.");
            }

            // Set new value via setter or field
            final setter = targetValue.klass.findInstanceSetter(propertyName);
            if (setter != null) {
              setter.bind(targetValue).call(this, [newValue], {});
            } else {
              targetValue.set(propertyName, newValue, this);
            }

            // Return the *new* value for prefix operators
            return newValue;
          } else if (targetValue is InterpretedExtension) {
            // Handle static field/getter increment/decrement on extension (prefix)
            final extension = targetValue;

            // Get current value via static getter or field
            Object? currentValue;
            final staticGetter = extension.findStaticGetter(propertyName);
            if (staticGetter != null) {
              currentValue = staticGetter.call(this, [], {});
            } else if (extension.staticFields.containsKey(propertyName)) {
              currentValue = extension.getStaticField(propertyName);
            } else {
              throw RuntimeD4rtException(
                  "Extension '${extension.name}' has no static field or getter named '$propertyName'.");
            }

            // Calculate new value
            Object? newValue;
            if (currentValue is num) {
              newValue =
                  operatorType == '++' ? currentValue + 1 : currentValue - 1;
            } else {
              throw RuntimeD4rtException(
                  "Cannot increment/decrement static property '$propertyName' of type '${currentValue?.runtimeType}': Expected number.");
            }

            // Set new value via static setter or field
            final staticSetter = extension.findStaticSetter(propertyName);
            if (staticSetter != null) {
              staticSetter.call(this, [newValue], {});
            } else if (extension.staticFields.containsKey(propertyName)) {
              extension.setStaticField(propertyName, newValue);
            } else {
              throw RuntimeD4rtException(
                  "Extension '${extension.name}' has no static setter or field named '$propertyName'.");
            }

            // Return the *new* value for prefix operators
            return newValue;
          } else {
            throw RuntimeD4rtException(
                "Cannot increment/decrement property on non-instance object of type '${targetValue?.runtimeType}'.");
          }
        } else if (operandNode is SIndexExpression) {
          // Handle index access like ++array[i]
          final targetValue = operandNode.target?.accept<Object?>(this);
          final indexValue = operandNode.index!.accept<Object?>(this);

          // Get current value via [] operator or direct access
          Object? currentValue;
          if (targetValue is List) {
            final index = indexValue as int;
            currentValue = targetValue[index];
          } else if (targetValue is Map) {
            currentValue = targetValue[indexValue];
          } else if (targetValue is InterpretedInstance) {
            // Use class operator [] if available
            final operatorMethod = targetValue.findOperator('[]');
            if (operatorMethod != null) {
              try {
                currentValue = operatorMethod
                    .bind(targetValue)
                    .call(this, [indexValue], {});
              } on ReturnException catch (e) {
                currentValue = e.value;
              } catch (e) {
                throw RuntimeD4rtException(
                    "Error executing class operator '[]' for prefix '${operatorType == '++' ? '++' : '--'}': $e");
              }
            } else {
              throw RuntimeD4rtException(
                  "Cannot read index for prefix increment/decrement on ${targetValue.klass.name}: No operator '[]' found.");
            }
          } else {
            throw RuntimeD4rtException(
                "Cannot apply prefix '${operatorType == '++' ? '++' : '--'}' to index of type '${targetValue?.runtimeType}'.");
          }

          // Calculate new value
          Object? newValue;
          if (currentValue is num) {
            newValue =
                operatorType == '++' ? currentValue + 1 : currentValue - 1;
          } else if (currentValue is InterpretedInstance) {
            // Use custom + operator with literal 1
            final operatorMethod = currentValue.findOperator('+');
            if (operatorMethod != null) {
              try {
                final operand =
                    _createIncrementOperand(currentValue, operatorType == '++');
                newValue =
                    operatorMethod.bind(currentValue).call(this, [operand], {});
              } on ReturnException catch (e) {
                newValue = e.value;
              } catch (e) {
                throw RuntimeD4rtException(
                    "Error executing custom operator '+' for prefix '${operatorType == '++' ? '++' : '--'}': $e");
              }
            } else {
              throw RuntimeD4rtException(
                  "Cannot increment/decrement object at index of type '${currentValue.klass.name}': No operator '+' found.");
            }
          } else {
            throw RuntimeD4rtException(
                "Cannot increment/decrement value at index of type '${currentValue?.runtimeType}': Expected number or object with '+' operator.");
          }

          // Set new value via []= operator or direct access
          if (targetValue is List) {
            final index = indexValue as int;
            targetValue[index] = newValue;
          } else if (targetValue is Map) {
            targetValue[indexValue] = newValue;
          } else if (targetValue is InterpretedInstance) {
            // Use class operator []= if available
            final operatorMethod = targetValue.findOperator('[]=');
            if (operatorMethod != null) {
              try {
                operatorMethod
                    .bind(targetValue)
                    .call(this, [indexValue, newValue], {});
              } on ReturnException catch (_) {
                // []= should not return a value, but assignment expression returns assigned value
              } catch (e) {
                throw RuntimeD4rtException(
                    "Error executing class operator '[]=' for prefix '${operatorType == '++' ? '++' : '--'}': $e");
              }
            } else {
              throw RuntimeD4rtException(
                  "Cannot write index for prefix increment/decrement on ${targetValue.klass.name}: No operator '[]=' found.");
            }
          }

          // Return the *new* value for prefix operators
          return newValue;
        } else {
          Logger.debug("Operand type: ${operandNode.runtimeType}");
          throw RuntimeD4rtException(
              "Operand for prefix '${operatorType == '++' ? '++' : '--'}' must be an assignable variable, property, or index.");
        }
      default:
        // Check for class operators first for any other unary operators
        final String operatorLexeme = node.operator;
        if (operandValue is InterpretedInstance) {
          final operatorMethod = operandValue.findOperator(operatorLexeme);
          if (operatorMethod != null) {
            Logger.debug(
                "[PrefixExpr] Found class operator '$operatorLexeme' on ${operandValue.klass.name}. Calling...");
            try {
              return operatorMethod.bind(operandValue).call(this, [], {});
            } on ReturnException catch (e) {
              return e.value;
            } catch (e) {
              throw RuntimeD4rtException(
                  "Error executing class operator '$operatorLexeme': $e");
            }
          }
        }

        // Check for extension operators if no class operator found
        try {
          final extensionOperator =
              environment.findExtensionMember(operandValue, operatorLexeme);
          if (extensionOperator is ExtensionMemberCallable &&
              extensionOperator.isOperator) {
            Logger.debug(
                "[PrefixExpr] Found generic extension operator '$operatorLexeme' for type ${operandValue?.runtimeType}. Calling...");
            try {
              return extensionOperator.call(this, [operandValue], {});
            } on ReturnException catch (e) {
              return e.value;
            } catch (e) {
              throw RuntimeD4rtException(
                  "Error executing extension operator '$operatorLexeme': $e");
            }
          }
        } on RuntimeD4rtException {
          // Fall through if no generic extension op found
        }
        throw UnimplementedD4rtException(
            'Unary prefix operator not handled: ${node.operator} ($operatorType)');
    }
  }

  @override
  Object? visitPostfixExpression(SPostfixExpression node) {
    final operatorType = node.operator;

    // Support for the non-null assertion operator (!)
    if (operatorType == '!') {
      final operandValue = node.operand!.accept<Object?>(this);
      if (operandValue == null) {
        throw RuntimeD4rtException(
            "Null check operator used on a null value at ${node.toString()}");
      }
      return operandValue;
    }

    // Check if operand is assignable (SSimpleIdentifier or SPropertyAccess)
    if (node.operand is SSimpleIdentifier) {
      final variableName = (node.operand as SSimpleIdentifier).name;
      Object? operandValue;
      InterpretedInstance? thisInstance;
      bool isInstanceField = false;

      // Try lexical scope first, then implicit 'this'
      try {
        operandValue = environment.get(variableName); // Try lexical scope
      } on RuntimeD4rtException {
        // Not found lexically, try implicit 'this'
        try {
          final potentialThis = environment.get('this');
          if (potentialThis is InterpretedInstance) {
            thisInstance = potentialThis;
            operandValue = thisInstance.get(variableName); // Get from instance
            isInstanceField = true;
          } else {
            throw RuntimeD4rtException("Undefined variable: $variableName");
          }
        } on RuntimeD4rtException {
          throw RuntimeD4rtException("Undefined variable: $variableName");
        }
      }
      final bridgedInstance = toBridgedInstance(operandValue);
      final currentValue =
          bridgedInstance.$2 ? bridgedInstance.$1!.nativeObject : operandValue;

      if (currentValue is num) {
        final newValue =
            operatorType == '++' ? currentValue + 1 : currentValue - 1;

        // Assign back to correct target (lexical or instance)
        if (isInstanceField && thisInstance != null) {
          final setter = thisInstance.klass.findInstanceSetter(variableName);
          if (setter != null) {
            setter.bind(thisInstance).call(this, [newValue], {});
          } else {
            thisInstance.set(
                variableName, newValue, this); // Assign to instance field
          }
        } else {
          environment.assign(
              variableName, newValue); // Assign to lexical variable
        }

        return operandValue; // Return the original value
      } else if (operandValue is InterpretedInstance) {
        // Use custom + operator with literal 1
        final operatorMethod = operandValue.findOperator('+');
        if (operatorMethod != null) {
          try {
            // For x++, we create a literal 1 and call x + 1
            final operand =
                _createIncrementOperand(currentValue, operatorType == '++');
            Object? newValue =
                operatorMethod.bind(operandValue).call(this, [operand], {});

            // Assign back to correct target (lexical or instance)
            if (isInstanceField && thisInstance != null) {
              final setter =
                  thisInstance.klass.findInstanceSetter(variableName);
              if (setter != null) {
                setter.bind(thisInstance).call(this, [newValue], {});
              } else {
                thisInstance.set(
                    variableName, newValue, this); // Assign to instance field
              }
            } else {
              environment.assign(
                  variableName, newValue); // Assign to lexical variable
            }

            return operandValue; // Return the original value for postfix
          } on ReturnException catch (e) {
            final newValue = e.value;

            // Assign back to correct target (lexical or instance)
            if (isInstanceField && thisInstance != null) {
              final setter =
                  thisInstance.klass.findInstanceSetter(variableName);
              if (setter != null) {
                setter.bind(thisInstance).call(this, [newValue], {});
              } else {
                thisInstance.set(
                    variableName, newValue, this); // Assign to instance field
              }
            } else {
              environment.assign(
                  variableName, newValue); // Assign to lexical variable
            }

            return operandValue; // Return the original value for postfix
          } catch (e) {
            throw RuntimeD4rtException(
                "Error executing custom operator '+' for postfix '${operatorType == '++' ? '++' : '--'}': $e");
          }
        } else {
          throw RuntimeD4rtException(
              "Cannot increment/decrement object of type '${operandValue.klass.name}': No operator '+' found.");
        }
      } else {
        throw RuntimeD4rtException(
            "Operand for postfix '${operatorType == '++' ? '++' : '--'}' must be a number, but was ${operandValue?.runtimeType}.");
      }
    } else if (node.operand is SPropertyAccess) {
      // Handle property access like obj.field++
      final propertyAccess = node.operand as SPropertyAccess;
      final targetValue = propertyAccess.target?.accept<Object?>(this);
      final propertyName = propertyAccess.propertyName!.name;

      if (targetValue is InterpretedInstance) {
        // Get current value via getter or field
        final currentValue = targetValue.get(propertyName);
        final originalValue = currentValue; // Save for return

        // Calculate new value
        Object? newValue;
        if (currentValue is num) {
          newValue = operatorType == '++' ? currentValue + 1 : currentValue - 1;
        } else if (currentValue is InterpretedInstance) {
          // Use custom + operator with literal 1
          final operatorMethod = currentValue.findOperator('+');
          if (operatorMethod != null) {
            try {
              // For x++, we create a literal 1 and call x + 1
              final operand =
                  _createIncrementOperand(currentValue, operatorType == '++');
              newValue =
                  operatorMethod.bind(currentValue).call(this, [operand], {});
            } on ReturnException catch (e) {
              newValue = e.value;
            } catch (e) {
              throw RuntimeD4rtException(
                  "Error executing custom operator '+' for postfix '${operatorType == '++' ? '++' : '--'}': $e");
            }
          } else {
            throw RuntimeD4rtException(
                "Cannot increment/decrement object of type '${currentValue.klass.name}': No operator '+' found.");
          }
        } else {
          throw RuntimeD4rtException(
              "Cannot increment/decrement property '$propertyName' of type '${currentValue?.runtimeType}': Expected number or object with '+' operator.");
        }

        // Set new value via setter or field
        final setter = targetValue.klass.findInstanceSetter(propertyName);
        if (setter != null) {
          setter.bind(targetValue).call(this, [newValue], {});
        } else {
          targetValue.set(propertyName, newValue, this);
        }

        // Return the *original* value for postfix operators
        return originalValue;
      } else {
        throw RuntimeD4rtException(
            "Cannot increment/decrement property on non-instance object of type '${targetValue?.runtimeType}'.");
      }
    } else if (node.operand is SPrefixedIdentifier) {
      // Handle prefixed identifier like obj.field++ (parsed as SPrefixedIdentifier)
      final prefixedIdentifier = node.operand as SPrefixedIdentifier;
      final targetValue = prefixedIdentifier.prefix!.accept<Object?>(this);
      final propertyName = prefixedIdentifier.identifier!.name;

      if (targetValue is InterpretedInstance) {
        // Get current value via getter or field
        final currentValue = targetValue.get(propertyName);
        final originalValue = currentValue; // Save for return

        // Calculate new value
        Object? newValue;
        if (currentValue is num) {
          newValue = operatorType == '++' ? currentValue + 1 : currentValue - 1;
        } else if (currentValue is InterpretedInstance) {
          // Use custom + operator with literal 1
          final operatorMethod = currentValue.findOperator('+');
          if (operatorMethod != null) {
            try {
              // For x++, we create a literal 1 and call x + 1
              final operand =
                  _createIncrementOperand(currentValue, operatorType == '++');
              newValue =
                  operatorMethod.bind(currentValue).call(this, [operand], {});
            } on ReturnException catch (e) {
              newValue = e.value;
            } catch (e) {
              throw RuntimeD4rtException(
                  "Error executing custom operator '+' for postfix '${operatorType == '++' ? '++' : '--'}': $e");
            }
          } else {
            throw RuntimeD4rtException(
                "Cannot increment/decrement object of type '${currentValue.klass.name}': No operator '+' found.");
          }
        } else {
          throw RuntimeD4rtException(
              "Cannot increment/decrement property '$propertyName' of type '${currentValue?.runtimeType}': Expected number or object with '+' operator.");
        }

        // Set new value via setter or field
        final setter = targetValue.klass.findInstanceSetter(propertyName);
        if (setter != null) {
          setter.bind(targetValue).call(this, [newValue], {});
        } else {
          targetValue.set(propertyName, newValue, this);
        }

        // Return the *original* value for postfix operators
        return originalValue;
      } else if (targetValue is InterpretedExtension) {
        // Handle static field/getter increment/decrement on extension
        final extension = targetValue;

        // Get current value via static getter or field
        Object? currentValue;
        final staticGetter = extension.findStaticGetter(propertyName);
        if (staticGetter != null) {
          currentValue = staticGetter.call(this, [], {});
        } else if (extension.staticFields.containsKey(propertyName)) {
          currentValue = extension.getStaticField(propertyName);
        } else {
          throw RuntimeD4rtException(
              "Extension '${extension.name}' has no static field or getter named '$propertyName'.");
        }

        final originalValue = currentValue; // Save for return

        // Calculate new value
        Object? newValue;
        if (currentValue is num) {
          newValue = operatorType == '++' ? currentValue + 1 : currentValue - 1;
        } else {
          throw RuntimeD4rtException(
              "Cannot increment/decrement static property '$propertyName' of type '${currentValue?.runtimeType}': Expected number.");
        }

        // Set new value via static setter or field
        final staticSetter = extension.findStaticSetter(propertyName);
        if (staticSetter != null) {
          staticSetter.call(this, [newValue], {});
        } else if (extension.staticFields.containsKey(propertyName)) {
          extension.setStaticField(propertyName, newValue);
        } else {
          throw RuntimeD4rtException(
              "Extension '${extension.name}' has no static setter or field named '$propertyName'.");
        }

        // Return the *original* value for postfix operators
        return originalValue;
      } else {
        throw RuntimeD4rtException(
            "Cannot increment/decrement property on non-instance object of type '${targetValue?.runtimeType}'.");
      }
    } else if (node.operand is SIndexExpression) {
      // Handle index access like array[i]++
      final indexExpression = node.operand as SIndexExpression;
      final targetValue = indexExpression.target?.accept<Object?>(this);
      final indexValue = indexExpression.index!.accept<Object?>(this);

      // Get current value via [] operator or direct access
      Object? currentValue;
      if (targetValue is List) {
        final index = indexValue as int;
        currentValue = targetValue[index];
      } else if (targetValue is Map) {
        currentValue = targetValue[indexValue];
      } else if (targetValue is InterpretedInstance) {
        // Use class operator [] if available
        final operatorMethod = targetValue.findOperator('[]');
        if (operatorMethod != null) {
          try {
            currentValue =
                operatorMethod.bind(targetValue).call(this, [indexValue], {});
          } on ReturnException catch (e) {
            currentValue = e.value;
          } catch (e) {
            throw RuntimeD4rtException(
                "Error executing class operator '[]' for postfix '${operatorType == '++' ? '++' : '--'}': $e");
          }
        } else {
          throw RuntimeD4rtException(
              "Cannot read index for postfix increment/decrement on ${targetValue.klass.name}: No operator '[]' found.");
        }
      } else {
        throw RuntimeD4rtException(
            "Cannot apply postfix '${operatorType == '++' ? '++' : '--'}' to index of type '${targetValue?.runtimeType}'.");
      }

      final originalValue = currentValue; // Save for return

      // Calculate new value
      Object? newValue;
      if (currentValue is num) {
        newValue = operatorType == '++' ? currentValue + 1 : currentValue - 1;
      } else if (currentValue is InterpretedInstance) {
        // Use custom + operator with literal 1
        final operatorMethod = currentValue.findOperator('+');
        if (operatorMethod != null) {
          try {
            final operand =
                _createIncrementOperand(currentValue, operatorType == '++');
            newValue =
                operatorMethod.bind(currentValue).call(this, [operand], {});
          } on ReturnException catch (e) {
            newValue = e.value;
          } catch (e) {
            throw RuntimeD4rtException(
                "Error executing custom operator '+' for postfix '${operatorType == '++' ? '++' : '--'}': $e");
          }
        } else {
          throw RuntimeD4rtException(
              "Cannot increment/decrement object at index of type '${currentValue.klass.name}': No operator '+' found.");
        }
      } else {
        throw RuntimeD4rtException(
            "Cannot increment/decrement value at index of type '${currentValue?.runtimeType}': Expected number or object with '+' operator.");
      }

      // Set new value via []= operator or direct access
      if (targetValue is List) {
        final index = indexValue as int;
        targetValue[index] = newValue;
      } else if (targetValue is Map) {
        targetValue[indexValue] = newValue;
      } else if (targetValue is InterpretedInstance) {
        // Use class operator []= if available
        final operatorMethod = targetValue.findOperator('[]=');
        if (operatorMethod != null) {
          try {
            operatorMethod
                .bind(targetValue)
                .call(this, [indexValue, newValue], {});
          } on ReturnException catch (_) {
            // []= should not return a value, but assignment expression returns assigned value
          } catch (e) {
            throw RuntimeD4rtException(
                "Error executing class operator '[]=' for postfix '${operatorType == '++' ? '++' : '--'}': $e");
          }
        } else {
          throw RuntimeD4rtException(
              "Cannot write index for postfix increment/decrement on ${targetValue.klass.name}: No operator '[]=' found.");
        }
      }

      // Return the *original* value for postfix operators
      return originalValue;
    } else {
      throw RuntimeD4rtException(
          "Operand for postfix '${operatorType == '++' ? '++' : '--'}' must be an assignable variable or property.");
    }
  }

  // Handle String Interpolation: "Value is ${expr}"
  @override
  Object? visitStringInterpolation(SStringInterpolation node) {
    final buffer = StringBuffer();
    for (final element in node.elements) {
      if (element is SInterpolationString) {
        buffer.write(element.value);
      } else if (element is SInterpolationExpression) {
        final value = element.expression!.accept<Object?>(this);
        // If the value is an async suspension, propagate it upward
        if (value is AsyncSuspensionRequest) {
          return value;
        }
        buffer.write(stringify(value)); // Use stringify helper
      } else {
        // Should not happen based on AST structure
        throw StateD4rtException(
            'Unknown interpolation element: ${element.runtimeType}');
      }
    }
    return buffer.toString();
  }

  @override
  Object? visitSuperExpression(SSuperExpression node) {
    if (currentFunction == null || currentFunction?.ownerType == null) {
      // Use ownerType
      throw RuntimeD4rtException(
          "'super' can only be used within an instance method.");
    }
    final ownerType = currentFunction!.ownerType!; // Use ownerType
    // Need to ensure ownerType is actually a class for super access
    if (ownerType is! InterpretedClass) {
      throw RuntimeD4rtException(
          "'super' used outside of a class context (found ${ownerType.runtimeType}).");
    }
    final definingClass =
        ownerType; // Can safely use ownerType as InterpretedClass now

    InterpretedClass? standardSuperclass = definingClass.superclass;
    BridgedClass? bridgedSuperclass = definingClass.bridgedSuperclass;

    if (standardSuperclass == null && bridgedSuperclass == null) {
      throw RuntimeD4rtException(
          "Class '${definingClass.name}' does not have a standard or bridged superclass, cannot use 'super'.");
    }

    // Get the current 'this' instance
    try {
      final thisInstance = environment.get('this');
      if (thisInstance is InterpretedInstance) {
        // Pass the correct superclass type to BoundSuper
        if (standardSuperclass != null) {
          return BoundSuper(thisInstance, standardSuperclass);
        } else {
          // bridgedSuperclass cannot be null here due to the check above
          return BoundBridgedSuper(thisInstance, bridgedSuperclass!);
        }
      } else {
        // Should not happen if currentFunction is set correctly
        throw RuntimeD4rtException(
            "Cannot find 'this' instance when using 'super'.");
      }
    } on RuntimeD4rtException {
      throw RuntimeD4rtException(
          "Cannot find 'this' instance when using 'super'.");
    }
  }

  @override
  Object? visitLabeledStatement(SLabeledStatement node) {
    final labelNames = node.labels.map((l) => l.label!.name).toSet();
    final oldLabels = _currentStatementLabels;
    _currentStatementLabels = labelNames;
    Logger.debug("[SLabeledStatement] Entering with labels: $labelNames");

    try {
      return node.statement!.accept<Object?>(this);
    } on BreakException catch (e) {
      Logger.debug(
          "[SLabeledStatement] Caught BreakException (label: ${e.label}) with current labels: $_currentStatementLabels");
      if (e.label != null && _currentStatementLabels.contains(e.label)) {
        // This break was targeting this labeled statement.
        Logger.debug(
            "[SLabeledStatement] Consuming labeled break: '${e.label}'.");
        return null; // Effectively breaks out of the labeled statement.
      } else {
        // Unlabeled break or break for an outer label, rethrow.
        Logger.debug("[SLabeledStatement] Rethrowing break...");
        rethrow;
      }
    }
    // ContinueException with a label matching this statement is an error
    // (you can only continue loops/switch members), so we don't catch it here.
    // It should be caught by the loop/switch or propagate further up.
    finally {
      Logger.debug("[SLabeledStatement] Exiting labels: $labelNames");
      _currentStatementLabels = oldLabels;
    }
  }

  @override
  Object? visitClassDeclaration(SClassDeclaration node) {
    final className = node.name!.name;
    Logger.debug(
        "[Visitor.visitClassDeclaration] START for '$className' in env: ${environment.hashCode}");

    // Retrieve the placeholder class object created in Pass 1
    Object? placeholder = environment.get(className);
    if (placeholder == null || placeholder is! InterpretedClass) {
      // This should not happen if Pass 1 worked correctly
      throw StateD4rtException(
          "Placeholder for class '$className' not found or invalid during Pass 2.");
    }
    final klass = placeholder;
    Logger.debug(
        "[Visitor.visitClassDeclaration] Retrieved placeholder for '$className' (hash: ${klass.hashCode})");

    // Resolve and populate relationships ON THE EXISTING klass object
    // Superclass lookup
    // InterpretedClass? superclass; // Keep this commented or remove
    if (node.extendsClause != null) {
      final superclassName = node.extendsClause!.superclass!.name!.name;
      Logger.debug(
          "[Visitor.visitClassDeclaration]   Trying to get superclass '$superclassName' from env: ${environment.hashCode}");
      Object? potentialSuperclass;
      try {
        potentialSuperclass = environment.get(superclassName);
      } on RuntimeD4rtException {
        throw RuntimeD4rtException(
            "Superclass '$superclassName' not found for class '$className'. Ensure it's defined.");
      }

      if (potentialSuperclass is InterpretedClass) {
        // Standard Dart Superclass
        final superclass = potentialSuperclass;

        // Add checks for final and interface modifiers
        // Note: sealed and interface classes CAN be extended within the same library/file,
        // and in D4rt all interpreted code is considered the same library
        //
        // For 'final' classes:
        // - A 'final' class cannot be extended outside its library
        // - An 'abstract final' class CAN be extended within the same library (needs implementation)
        // - Since all D4rt code is considered the same library, we only block non-abstract final classes
        if (superclass.isFinal && !superclass.isAbstract) {
          throw RuntimeD4rtException(
              "Class '$className' cannot extend final class '$superclassName'.");
        }
        // Interface classes can be extended within the same library, so we allow it in D4rt
        // sealed classes are also allowed to be extended - they restrict external libraries only

        // Set the superclass and clear bridged superclass
        klass.superclass = superclass;
        klass.bridgedSuperclass = null;
        Logger.debug(
            "[Visitor.visitClassDeclaration] Set standard superclass '$superclassName' for '$className'");
      } else if (potentialSuperclass is BridgedClass) {
        final bridgedSuperclass = potentialSuperclass;
        // No modifier checks needed for bridged classes (yet?)

        // Set the bridged superclass and clear standard superclass
        klass.bridgedSuperclass = bridgedSuperclass;
        klass.superclass = null;
        Logger.debug(
            "[Visitor.visitClassDeclaration] Set BRIDGED superclass '$superclassName' for '$className'");
      } else {
        throw RuntimeD4rtException(
            "Superclass '$superclassName' for class '$className' resolved to ${potentialSuperclass?.runtimeType}, which is not a class or bridged class.");
      }
    }

    // Interface lookup
    if (node.implementsClause != null) {
      Logger.debug(
          "[Visitor.visitClassDeclaration] Processing 'implements' clause for '$className' in env: ${environment.hashCode}");
      for (final interfaceType in node.implementsClause!.interfaces) {
        final interfaceName = interfaceType.name!.name;
        Logger.debug(
            "[Visitor.visitClassDeclaration]   Trying to get interface '$interfaceName' from env: ${environment.hashCode}");
        try {
          final potentialInterface = environment.get(interfaceName);
          if (potentialInterface is InterpretedClass) {
            // Add checks for base modifier only
            // Note: sealed classes CAN be implemented within the same library/file
            if (potentialInterface.isBase) {
              throw RuntimeD4rtException(
                  "Class '$className' cannot implement base class '$interfaceName' outside of its library.");
            }
            // sealed classes are allowed to be implemented - they restrict external libraries only

            // Add to the interfaces list of the existing klass object
            klass.interfaces.add(potentialInterface);
            Logger.debug(
                "[Visitor.visitClassDeclaration] Added interface '$interfaceName' for '$className'");
          } else if (potentialInterface is BridgedClass) {
            // Support for bridged interfaces like Comparable, Exception
            klass.bridgedInterfaces.add(potentialInterface);
            Logger.debug(
                "[Visitor.visitClassDeclaration] Added bridged interface '$interfaceName' for '$className'");
          } else {
            throw RuntimeD4rtException(
                "Class '$className' cannot implement non-class '$interfaceName' (${potentialInterface?.runtimeType}).");
          }
        } on RuntimeD4rtException {
          throw RuntimeD4rtException(
              "Interface '$interfaceName' not found for class '$className'. Ensure it's defined.");
        }
      }
    }

    // Mixin application lookup
    if (node.withClause != null) {
      Logger.debug(
          "[Visitor.visitClassDeclaration] Processing 'with' clause for '$className' in env: ${environment.hashCode}");
      for (final mixinType in node.withClause!.mixinTypes) {
        final mixinName = mixinType.name!.name;
        Logger.debug(
            "[Visitor.visitClassDeclaration]   Trying to get mixin '$mixinName' from env: ${environment.hashCode}");

        Object? mixin;
        try {
          mixin = environment.get(mixinName);
        } on RuntimeD4rtException {
          throw RuntimeD4rtException(
              "Mixin '$mixinName' not found during lookup for class '$className'. Ensure it's defined (as a mixin or class mixin).");
        }

        if (mixin is InterpretedClass) {
          if (!mixin.isMixin) {
            throw RuntimeD4rtException(
                "Class '$mixinName' cannot be used as a mixin because it's not declared with 'mixin' or 'class mixin'.");
          }

          // Add checks for base modifier only
          // Note: sealed classes CAN be mixed in within the same library/file
          if (mixin.isBase) {
            throw RuntimeD4rtException(
                "Class '$className' cannot mix in base class '$mixinName' outside of its library.");
          }
          // sealed classes are allowed to be mixed in - they restrict external libraries only

          // Add to the mixins list of the existing klass object
          klass.mixins.add(mixin);
          Logger.debug(
              "[Visitor.visitClassDeclaration] Applied interpreted mixin '$mixinName' to '$className'");
        } else if (mixin is BridgedClass) {
          // Support for bridged classes as mixins
          if (!mixin.canBeUsedAsMixin) {
            throw RuntimeD4rtException(
                "Bridged class '$mixinName' cannot be used as a mixin. Set canBeUsedAsMixin=true when registering the bridge.");
          }

          // Add to the bridged mixins list
          klass.bridgedMixins.add(mixin);
          Logger.debug(
              "[Visitor.visitClassDeclaration] Applied bridged mixin '$mixinName' to '$className'");
        } else {
          throw RuntimeD4rtException(
              "Identifier '$mixinName' resolved to ${mixin?.runtimeType}, which is not a class/mixin, for class '$className'.");
        }
      }
    }

    // Populate members ON THE EXISTING klass object
    final staticInitEnv = environment; // Statics use the class definition env
    final originalVisitorEnv = environment; // Backup visitor env

    Logger.debug(
        "[Visitor.visitClassDeclaration] Processing members for '$className' (hash: ${klass.hashCode})");

    for (final member in node.members) {
      if (member is SMethodDeclaration) {
        final methodName = member.name!.name;
        // Pass the ALREADY RETRIEVED klass object
        final function =
            InterpretedFunction.method(member, staticInitEnv, klass);

        if (member.isStatic) {
          if (member.isGetter) {
            klass.staticGetters[methodName] = function;
          } else if (member.isSetter) {
            klass.staticSetters[methodName] = function;
          } else {
            klass.staticMethods[methodName] = function;
          }
        } else if (!member.isAbstract) {
          if (member.isGetter) {
            klass.getters[methodName] = function;
          } else if (member.isSetter) {
            klass.setters[methodName] = function;
          } else if (member.isOperator) {
            // Add operator methods to the operators map
            klass.operators[methodName] = function;
          } else {
            klass.methods[methodName] = function;
          }
        } else {
          // Abstract
          if (!klass.isAbstract) {
            throw RuntimeD4rtException(
                "Abstract methods can only be declared in abstract classes. Method '${klass.name}.$methodName'.");
          }
          if (member.body is! SEmptyFunctionBody) {
            throw RuntimeD4rtException(
                "Abstract methods cannot have a body. Method '${klass.name}.$methodName'.");
          }
          if (member.isGetter) {
            klass.getters[methodName] = function;
          } else if (member.isSetter) {
            klass.setters[methodName] = function;
          } else if (member.isOperator) {
            // Add abstract operator methods to the operators map
            klass.operators[methodName] = function;
          } else {
            klass.methods[methodName] = function;
          }
        }
      } else if (member is SConstructorDeclaration) {
        final function =
            InterpretedFunction.constructor(member, staticInitEnv, klass);
        final constructorName = member.name?.name ?? '';
        klass.constructors[constructorName] = function;
      } else if (member is SFieldDeclaration) {
        // Defer static field processing - collect them for later
        if (!member.isStatic) {
          klass.fieldDeclarations.add(member);
        }
      } else {
        throw StateD4rtException('Unknown member type: ${member.runtimeType}');
      }
    }

    // TWO-PASS STATIC FIELD PROCESSING to handle sibling references (Bug-23)
    // Pass 1: Register all static field names in the class environment with null values
    final staticFieldDecls = <SVariableDeclaration>[];
    final staticFieldMeta =
        <String, (bool isLate, bool isFinal, SAstNode? initializer)>{};
    for (final member in node.members) {
      if (member is SFieldDeclaration && member.isStatic) {
        final isLate = member.fields!.isLate;
        final isFinal = member.fields!.isFinal;
        for (final variable in member.fields!.variables) {
          final fieldName = variable.name!.name;
          staticFieldDecls.add(variable);
          staticFieldMeta[fieldName] = (isLate, isFinal, variable.initializer);
          // Pre-register all static fields so they can reference each other
          klass.staticFields[fieldName] = null;
        }
      }
    }

    // Pass 2: Evaluate all static field initializers (now all fields are known)
    // Create a child environment that can shadow with evaluated field values
    final staticFieldEvalEnv = Environment(enclosing: staticInitEnv);
    try {
      environment = staticFieldEvalEnv;
      for (final variable in staticFieldDecls) {
        final fieldName = variable.name!.name;
        final (isLate, isFinal, initializer) = staticFieldMeta[fieldName]!;

        if (isLate) {
          // Handle late static field
          if (initializer != null) {
            // Late static field with lazy initializer
            final lateVar = LateVariable(fieldName, () {
              // Create a closure that will evaluate the initializer when accessed
              final savedEnv = environment;
              try {
                environment = staticFieldEvalEnv;
                return initializer.accept<Object?>(this);
              } finally {
                environment = savedEnv;
              }
            }, isFinal: isFinal);
            klass.staticFields[fieldName] = lateVar;
            // Also define in eval environment for sibling access
            staticFieldEvalEnv.define(fieldName, lateVar);
            Logger.debug(
                "[ClassDecl] Defined late static field '$fieldName' with lazy initializer for class '${klass.name}'.");
          } else {
            // Late static field without initializer
            final lateVar = LateVariable(fieldName, null, isFinal: isFinal);
            klass.staticFields[fieldName] = lateVar;
            staticFieldEvalEnv.define(fieldName, lateVar);
            Logger.debug(
                "[ClassDecl] Defined late static field '$fieldName' without initializer for class '${klass.name}'.");
          }
        } else {
          // Regular static field handling
          Object? value;
          if (initializer != null) {
            value = initializer.accept<Object?>(this);
          }
          klass.staticFields[fieldName] = value;
          // Define the evaluated value in the environment so subsequent fields can access it
          staticFieldEvalEnv.define(fieldName, value);
        }
      }
    } finally {
      environment = originalVisitorEnv;
    }

    Logger.debug(
        "[Visitor.visitClassDeclaration] Finished processing members for '$className'");

    // Final Checks (run on the populated klass object)
    // Check for unimplemented abstract members
    if (!klass.isAbstract) {
      final inheritedAbstract = klass.getAbstractInheritedMembers();
      // G-DOV-6/7 FIX: Use getAllConcreteMembers() to walk the full superclass chain
      // (not just this class + mixins), so grandparent concrete implementations are found.
      final concreteMembers = klass.getAllConcreteMembers();
      final fieldNames =
          klass.getInstanceFieldNames(); // Fields also satisfy abstract getters
      for (final abstractName in inheritedAbstract.keys) {
        // Check if the abstract member is satisfied by a concrete method/getter/setter OR a field
        if (!concreteMembers.containsKey(abstractName) &&
            !fieldNames.contains(abstractName)) {
          final abstractMember = inheritedAbstract[abstractName]!;
          String memberType = "method";
          if (abstractMember.isGetter) memberType = "getter";
          if (abstractMember.isSetter) memberType = "setter";
          throw RuntimeD4rtException(
              "Missing concrete implementation for inherited abstract $memberType '$abstractName' in class '${klass.name}'.");
        }
      }
    }

    // Check for unimplemented interface members
    if (!klass.isAbstract) {
      final requiredInterfaceMembers = klass.getAllInterfaceMembers();
      final availableConcreteMembers = klass.getAllConcreteMembers();
      for (final requiredName in requiredInterfaceMembers.keys) {
        if (!availableConcreteMembers.containsKey(requiredName)) {
          final memberType = requiredInterfaceMembers[requiredName]!;
          throw RuntimeD4rtException(
              "Missing concrete implementation for interface $memberType '$requiredName' in class '${klass.name}'.");
        }
      }
    }
    Logger.debug("[Visitor.visitClassDeclaration] END for '$className'");
    // No need to define/assign klass in the environment here, it was done in Pass 1.
    return null; // Class declaration statement doesn't return a value
  }

  @override
  Object? visitAssertStatement(SAssertStatement node) {
    // Assertions are always enabled in this interpreter for now.
    final conditionValue = node.condition!.accept<Object?>(this);

    final bridgedInstance = toBridgedInstance(conditionValue);
    bool conditionResult;
    if (conditionValue is bool) {
      conditionResult = conditionValue;
    } else if (bridgedInstance.$2 && bridgedInstance.$1?.nativeObject is bool) {
      conditionResult = bridgedInstance.$1!.nativeObject as bool;
    } else {
      throw RuntimeD4rtException(
        "Assertion condition must be a boolean, but was ${conditionValue?.runtimeType}.",
      );
    }

    if (!conditionResult) {
      // Condition is false, evaluate the message and throw.
      String assertionMessage = "Assertion failed";
      if (node.message != null) {
        final messageValue = node.message!.accept<Object?>(this);
        assertionMessage = "Assertion failed: ${stringify(messageValue)}";
      }
      // Mimic Dart's AssertionError by throwing a RuntimeError.
      throw RuntimeD4rtException(assertionMessage);
    }

    return null; // Assert statements don't produce a value.
  }

  // Visit Mixin Declaration (Adjusted for Two-Pass)
  @override
  Object? visitMixinDeclaration(SMixinDeclaration node) {
    final mixinName = node.name!.name;
    Logger.debug(
        "[Visitor.visitMixinDeclaration] START for '$mixinName' in env: ${environment.hashCode}");

    // Retrieve the placeholder mixin object created in Pass 1
    Object? placeholder = environment.get(mixinName);
    if (placeholder == null ||
        placeholder is! InterpretedClass ||
        !placeholder.isMixin) {
      throw StateD4rtException(
          "Placeholder for mixin '$mixinName' not found or invalid during Pass 2.");
    }
    final mixinClass = placeholder;
    Logger.debug(
        "[Visitor.visitMixinDeclaration] Retrieved placeholder for mixin '$mixinName' (hash: ${mixinClass.hashCode})");

    // Resolve 'on' clause constraints ON THE EXISTING mixinClass object
    if (node.onClause != null) {
      mixinClass.onClauseTypes.clear(); // Clear existing before populating
      for (final typeNode in node.onClause!.superclassConstraints) {
        final typeName = typeNode.name!.name;
        try {
          final potentialType = environment.get(typeName);
          if (potentialType is InterpretedClass) {
            // Add to the onClauseTypes list of the existing mixinClass object
            mixinClass.onClauseTypes.add(potentialType);
            Logger.debug(
                "[Visitor.visitMixinDeclaration] Added 'on' constraint '$typeName' for '$mixinName'");
          } else {
            throw RuntimeD4rtException(
                "Type '$typeName' in 'on' clause of mixin '$mixinName' is not a class (${potentialType?.runtimeType}).");
          }
        } on RuntimeD4rtException {
          throw RuntimeD4rtException(
              "Type '$typeName' in 'on' clause of mixin '$mixinName' not found. Ensure it's defined.");
        }
      }
    }

    // Populate members ON THE EXISTING mixinClass object
    final declarationEnv =
        environment; // Members use the mixin's declaration env
    final originalVisitorEnv = environment;

    Logger.debug(
        "[Visitor.visitMixinDeclaration] Processing members for mixin '$mixinName' (hash: ${mixinClass.hashCode})");

    try {
      environment = declarationEnv;
      for (final member in node.members) {
        if (member is SMethodDeclaration) {
          final methodName = member.name!.name;
          // Methods capture the GLOBAL environment via the mixinClass
          final function =
              InterpretedFunction.method(member, globalEnvironment, mixinClass);
          if (member.isStatic) {
            // Static members belong to the mixin definition itself
            if (member.isGetter) {
              mixinClass.staticGetters[methodName] = function;
            } else if (member.isSetter) {
              mixinClass.staticSetters[methodName] = function;
            } else {
              mixinClass.staticMethods[methodName] = function;
            }
          } else {
            if (member.isGetter) {
              mixinClass.getters[methodName] = function;
            } else if (member.isSetter) {
              mixinClass.setters[methodName] = function;
            } else if (member.isOperator) {
              // Add operator methods to the operators map for mixins
              mixinClass.operators[methodName] = function;
            } else {
              mixinClass.methods[methodName] = function;
            }
          }
        } else if (member is SFieldDeclaration) {
          if (member.isStatic) {
            for (final variable in member.fields!.variables) {
              mixinClass.staticFields[variable.name!.name] =
                  variable.initializer?.accept<Object?>(this);
            }
          } else {
            mixinClass.fieldDeclarations.add(member);
          }
        } else if (member is SConstructorDeclaration) {
          throw RuntimeD4rtException(
              "Mixins cannot declare constructors ('$mixinName').");
        }
      }
    } finally {
      environment = originalVisitorEnv;
    }

    Logger.debug("[Visitor.visitMixinDeclaration] END for '$mixinName'");
    return null; // Mixin declaration doesn't return a value
  }

  @override
  Object? visitEnumDeclaration(SEnumDeclaration node) {
    final enumName = node.name!.name;
    Logger.debug(
        "[Visitor.visitEnumDeclaration] START (Pass 2) for '$enumName'");

    // Retrieve the enum placeholder object created in Pass 1
    final enumObj = environment.get(enumName);
    if (enumObj == null || enumObj is! InterpretedEnum) {
      throw StateD4rtException(
          "Enum placeholder object for '$enumName' not found or invalid during Pass 2.");
    }

    // Process Mixin Application (similar to class mixin handling)
    if (node.withClause != null) {
      Logger.debug(
          "[Visitor.visitEnumDeclaration] Processing 'with' clause for '$enumName'");
      for (final mixinType in node.withClause!.mixinTypes) {
        final mixinName = mixinType.name!.name;
        Logger.debug(
            "[Visitor.visitEnumDeclaration]   Trying to get mixin '$mixinName'");

        Object? mixin;
        try {
          mixin = environment.get(mixinName);
        } on RuntimeD4rtException {
          throw RuntimeD4rtException(
              "Mixin '$mixinName' not found during lookup for enum '$enumName'. Ensure it's defined (as a mixin or class mixin).");
        }

        if (mixin is InterpretedClass) {
          if (!mixin.isMixin) {
            throw RuntimeD4rtException(
                "Class '$mixinName' cannot be used as a mixin because it's not declared with 'mixin' or 'class mixin'.");
          }

          // Add to the mixins list of the enum object
          enumObj.mixins.add(mixin);
          Logger.debug(
              "[Visitor.visitEnumDeclaration] Applied interpreted mixin '$mixinName' to '$enumName'");
        } else if (mixin is BridgedClass) {
          // Support for bridged classes as mixins
          if (!mixin.canBeUsedAsMixin) {
            throw RuntimeD4rtException(
                "Bridged class '$mixinName' cannot be used as a mixin. Set canBeUsedAsMixin=true when registering the bridge.");
          }

          // Add to the bridged mixins list
          enumObj.bridgedMixins.add(mixin);
          Logger.debug(
              "[Visitor.visitEnumDeclaration] Applied bridged mixin '$mixinName' to '$enumName'");
        } else {
          throw RuntimeD4rtException(
              "Identifier '$mixinName' resolved to ${mixin?.runtimeType}, which is not a class/mixin, for enum '$enumName'.");
        }
      }
    }

    // Process Members (Static and Instance)
    // Members defined in the enum body (methods, getters, fields, constructors)
    final originalVisitorEnv = environment; // Save original environment
    try {
      // Members are defined in the enum's declaration scope
      environment = enumObj.declarationEnvironment;
      for (final member in node.members) {
        if (member is SMethodDeclaration) {
          final methodName = member.name!.name;
          // Methods capture the enum's declaration environment implicitly
          final function =
              InterpretedFunction.method(member, environment, enumObj);

          if (member.isStatic) {
            if (member.isGetter) {
              enumObj.staticGetters[methodName] = function;
            } else if (member.isSetter) {
              enumObj.staticSetters[methodName] = function;
            } else {
              enumObj.staticMethods[methodName] = function;
            }
            Logger.debug(
                "[Visitor.visitEnumDeclaration]   Processed static method/getter/setter: $methodName");
          } else {
            if (member.isAbstract) {
              throw RuntimeD4rtException(
                  "Enums cannot have abstract members ('$enumName.$methodName').");
            }
            if (member.isGetter) {
              enumObj.getters[methodName] = function;
            } else if (member.isSetter) {
              enumObj.setters[methodName] = function;
            } else {
              enumObj.methods[methodName] = function;
            }
            Logger.debug(
                "[Visitor.visitEnumDeclaration]   Processed instance method/getter/setter: $methodName");
          }
        } else if (member is SConstructorDeclaration) {
          if (member.isFactory) {
            throw UnimplementedD4rtException(
                "Factory constructors in enums are not yet supported.");
          }
          if (member.redirectedConstructor != null) {
            throw UnimplementedD4rtException(
                "Redirecting constructors in enums are not yet supported.");
          }
          // Check if it's the default unnamed constructor or a named one
          final constructorName = member.name?.name ?? '';
          // Constructors also capture the enum's declaration environment
          final function =
              InterpretedFunction.constructor(member, environment, enumObj);

          enumObj.constructors[constructorName] = function;
          Logger.debug(
              "[Visitor.visitEnumDeclaration]   Processed constructor: ${constructorName.isEmpty ? enumName : '$enumName.$constructorName'}");
        } else if (member is SFieldDeclaration) {
          // Store field declarations for instance initialization
          // Only non-static fields are relevant for enum value instances
          if (!member.isStatic) {
            enumObj.fieldDeclarations.add(member);
            for (final variable in member.fields!.variables) {
              Logger.debug(
                  "[Visitor.visitEnumDeclaration]   Stored instance field declaration: ${variable.name!.name}");
            }
          } else {
            // Evaluate static fields immediately
            for (final variable in member.fields!.variables) {
              final fieldName = variable.name!.name;
              Object? value;
              if (variable.initializer != null) {
                value = variable.initializer!.accept<Object?>(this);
              }
              enumObj.staticFields[fieldName] = value;
              Logger.debug(
                  "[Visitor.visitEnumDeclaration]   Evaluated static field: $fieldName = $value");
            }
          }
        } else {
          Logger.warn(
              "[Visitor.visitEnumDeclaration]   Ignoring unknown member type: ${member.runtimeType}");
        }
      }
    } finally {
      environment = originalVisitorEnv; // Restore environment
    }

    // Instantiate Enum Values
    Logger.debug(
        "[Visitor.visitEnumDeclaration]   Instantiating enum values...");
    for (int i = 0; i < node.constants.length; i++) {
      final constantDecl = node.constants[i];
      final valueName = constantDecl.name!.name;

      if (enumObj.values.containsKey(valueName)) {
        Logger.warn(
            "[Visitor.visitEnumDeclaration] Enum value '$enumName.$valueName' already exists (should not happen).");
        continue;
      }

      // Create the runtime value instance (without initialized fields yet)
      final enumValueInstance = InterpretedEnumValue(enumObj, valueName, i);

      // Initialize Instance Fields using Constructor
      final constructorInvocation = constantDecl.arguments;
      // TODO: constructorSelector not available in serialized AST SArgumentList
      final constructorName = '';
      final constructorFunc = enumObj.constructors[constructorName];

      if (constructorFunc == null && constructorInvocation != null) {
        throw RuntimeD4rtException(
            "Enum '$enumName' does not have a constructor named '$constructorName' required by constant '$valueName'.");
      }
      if (constructorFunc == null &&
          enumObj.constructors.isNotEmpty &&
          enumObj.constructors.containsKey('')) {
        throw RuntimeD4rtException(
            "Enum '$enumName' has a default constructor but constant '$valueName' doesn't call it implicitly (requires explicit `()` if args are needed or constructor exists).");
      }
      // If there are NO constructors defined at all, and no args are passed, it's okay.
      if (constructorFunc != null && constructorInvocation != null) {
        Logger.debug(
            "[Visitor.visitEnumDeclaration]     Calling constructor '${constructorName.isEmpty ? enumName : '$enumName.$constructorName'}' for value '$valueName'");
        // Evaluate arguments for the constructor call
        final (positionalArgs, namedArgs) =
            _evaluateArguments(constructorInvocation);

        // Call the constructor function, binding `this` to the enumValueInstance.
        // The constructor's call method needs to handle field initialization.
        try {
          // Use the _prepareExecutionEnvironment helper? Or call directly?
          // Need to ensure constructor initializers (: this.field = arg) run.
          // Let's assume constructorFunc.call handles this when isInitializer is true.
          final boundConstructor = constructorFunc.bind(enumValueInstance);
          boundConstructor.call(this, positionalArgs, namedArgs);
          Logger.debug(
              "[Visitor.visitEnumDeclaration]     Constructor call finished for '$valueName'. Fields: $enumValueInstance"); // Log instance directly for now
        } on RuntimeD4rtException catch (e) {
          throw RuntimeD4rtException(
              "Error executing constructor for enum value '$enumName.$valueName': ${e.message}");
        } catch (e) {
          throw RuntimeD4rtException(
              "Unexpected error executing constructor for enum value '$enumName.$valueName': $e");
        }
      } else if (constructorFunc == null &&
          constructorInvocation == null &&
          enumObj.constructors.isNotEmpty) {
        // Has constructors, but none called and no default exists implicitly.
        throw RuntimeD4rtException(
            "Enum constant '$enumName.$valueName' must call a constructor if the enum defines any.");
      } else {
        Logger.debug(
            "[Visitor.visitEnumDeclaration]     No constructor called for '$valueName' (enum has no explicit constructors or constant has no args).");
        // Initialize fields from declarations if no constructor called?
        // This might mirror class field initialization before constructor body.
        final fieldInitEnv =
            Environment(enclosing: enumObj.declarationEnvironment);
        fieldInitEnv.define('this', enumValueInstance);
        final originalVisitorEnvForFields = environment;
        try {
          environment = fieldInitEnv;
          for (final fieldDecl in enumObj.fieldDeclarations) {
            for (final variable in fieldDecl.fields!.variables) {
              if (variable.initializer != null) {
                final fieldName = variable.name!.name;
                final value = variable.initializer!.accept<Object?>(this);
                enumValueInstance.setField(fieldName, value);
                Logger.debug(
                    "[Visitor.visitEnumDeclaration]     Initialized instance field '$fieldName'=$value for '$valueName' (default init).");
              }
            }
          }
        } finally {
          environment = originalVisitorEnvForFields;
        }
      }

      // Store the fully initialized instance in the enum object's map
      enumObj.values[valueName] = enumValueInstance;
      Logger.debug(
          "[Visitor.visitEnumDeclaration]   Created and initialized instance for '$enumName.$valueName' with index $i");
    }

    // Pre-cache the values list
    try {
      enumObj.valuesList; // Access the getter to trigger cache creation
      Logger.debug(
          "[Visitor.visitEnumDeclaration]   Cached 'values' list for '$enumName'.");
    } catch (e) {
      // Log error if caching fails (shouldn't happen ideally)
      Logger.error(
          "[Visitor.visitEnumDeclaration] Failed to cache 'values' for '$enumName': $e");
    }

    Logger.debug("[Visitor.visitEnumDeclaration] END (Pass 2) for '$enumName'");
    return null; // Declaration doesn't return a value
  }

  // Helper function to compute compound assignment values
  Object? computeCompoundValue(
      Object? currentValue, Object? rhsValue, String operatorType) {
    // Unwrap BridgedInstance if necessary
    final bridgedInstance = toBridgedInstance(currentValue);
    final left =
        bridgedInstance.$2 ? bridgedInstance.$1!.nativeObject : currentValue;
    final right = rhsValue;

    if (operatorType == '+=') {
      // Use unwrapped left/right for calculation
      if (left is num && right is num) {
        return left + right;
      } else if (left is String && right != null) {
        return left + stringify(right);
      } else if (left is List && right is List) {
        // For List += List, create a new list with both elements
        // This is how Dart's List + operator works
        return [...left, ...right];
      }
      // Fall through to extension check if standard types don't match
    } else if (operatorType == '-=') {
      // Use unwrapped left/right for calculation
      if (left is num && right is num) {
        return left - right;
      }
      // Fall through
    } else if (operatorType == '*=') {
      // Use unwrapped left/right for calculation
      if (left is num && right is num) {
        return left * right;
      }
      // Fall through
    } else if (operatorType == '/=') {
      // Use unwrapped left/right for calculation
      if (left is num && right is num) {
        if (right == 0) throw RuntimeD4rtException("Division by zero in '/='.");
        return left.toDouble() / right.toDouble();
      }
      // Fall through
    } else if (operatorType == '~/=') {
      // Use unwrapped left/right for calculation
      if (left is num && right is num) {
        if (rhsValue == 0) {
          throw RuntimeD4rtException("Integer division by zero in '~/='.");
        }
        return left ~/ right;
      }
      // Fall through
    } else if (operatorType == '%=') {
      // Use unwrapped left/right for calculation
      if (left is num && right is num) {
        if (right == 0) throw RuntimeD4rtException("Modulo by zero in '%='.");
        return left % right;
      }
      // Fall through
    } else if (operatorType == '??=') {
      // Note: Uses original currentValue, not unwrapped 'left'
      if (currentValue == null) {
        return rhsValue; // If left is null, assign right
      } else {
        return currentValue; // If left is not null, keep left
      }
    } else if (operatorType == '&=') {
      // Bitwise AND assignment (&=)
      if (left is int && right is int) {
        return left & right;
      } else if (left is BigInt && right is BigInt) {
        return left & right;
      }
      // Fall through to extension search
    } else if (operatorType == '|=') {
      // Bitwise OR assignment (|=)
      if (left is int && right is int) {
        return left | right;
      } else if (left is BigInt && right is BigInt) {
        return left | right;
      }
      // Fall through to extension search
    } else if (operatorType == '^=') {
      // Bitwise XOR assignment (^=)
      if (left is int && right is int) {
        return left ^ right;
      } else if (left is BigInt && right is BigInt) {
        return left ^ right;
      }
      // Fall through to extension search
    } else if (operatorType == '>>=') {
      // Right shift assignment (>>=)
      if (left is int && right is int) {
        return left >> right;
      } else if (left is BigInt && right is int) {
        return left >> right;
      }
      // Fall through to extension search
    } else if (operatorType == '<<=') {
      // Left shift assignment (<<=)
      if (left is int && right is int) {
        return left << right;
      } else if (left is BigInt && right is int) {
        return left << right;
      }
      // Fall through to extension search
    } else if (operatorType == '>>>=') {
      // Unsigned right shift assignment (>>>=)
      if (left is int && right is int) {
        return left >>> right;
      }
      // Note: BigInt doesn't support >>> operator
      // Fall through to extension search
    }

    Logger.debug(
        "[CompoundAssign] Standard op failed for $operatorType. Trying extension operator.");
    final String? operatorName = _mapCompoundToOperatorName(operatorType);

    if (operatorName != null) {
      try {
        final extensionOperator =
            environment.findExtensionMember(currentValue, operatorName);

        if (extensionOperator is ExtensionMemberCallable &&
            extensionOperator.isOperator) {
          Logger.debug(
              "[CompoundAssign] Found extension operator '$operatorName' for type ${currentValue?.runtimeType}. Calling...");
          // Call the extension operator method
          // Args: receiver (currentValue), right-hand-side (rhsValue)
          final extensionPositionalArgs = [currentValue, rhsValue];
          try {
            return extensionOperator.call(this, extensionPositionalArgs, {});
          } on ReturnException catch (e) {
            return e.value; // Should not happen for operators, but handle
          } catch (e) {
            throw RuntimeD4rtException(
                "Error executing extension operator '$operatorName' for compound assignment: $e");
          }
        }
        Logger.debug(
            "[CompoundAssign] No suitable extension operator '$operatorName' found for type ${currentValue?.runtimeType}.");
      } on RuntimeD4rtException catch (findError) {
        Logger.debug(
            "[CompoundAssign] No extension member '$operatorName' found for type ${currentValue?.runtimeType}. Error: ${findError.message}");
        // Fall through to the final unimplemented error
      }
    }

    throw UnimplementedD4rtException(
        'Compound assignment operator $operatorType not handled for types ${currentValue?.runtimeType} and ${rhsValue?.runtimeType}');
  }

  // Map compound assignment token to operator method name
  String? _mapCompoundToOperatorName(String compoundOp) {
    switch (compoundOp) {
      case '+=':
        return '+';
      case '-=':
        return '-';
      case '*=':
        return '*';
      case '/=':
        return '/';
      case '%=':
        return '%';
      case '~/=':
        return '~/';
      case '&=':
        return '&';
      case '|=':
        return '|';
      case '^=':
        return '^';
      case '>>=':
        return '>>';
      case '<<=':
        return '<<';
      case '>>>=':
        return '>>>';
      // '??=' (??=) doesn't map to a binary operator method.
      default:
        return null;
    }
  }

  /// Check if a List matches the expected generic type argument
  bool _checkGenericListType(List list, SAstNode elementTypeNode) {
    // If list is empty, we can't verify element types
    if (list.isEmpty) {
      return true; // Accept empty lists for any type
    }

    // Check each element
    for (final element in list) {
      if (!_checkValueMatchesType(element, elementTypeNode)) {
        return false;
      }
    }
    return true;
  }

  /// Check if a Map matches the expected generic type arguments
  bool _checkGenericMapType(
      Map map, SAstNode keyTypeNode, SAstNode valueTypeNode) {
    // If map is empty, we can't verify key/value types
    if (map.isEmpty) {
      return true; // Accept empty maps for any type
    }

    // Check each key-value pair
    for (final entry in map.entries) {
      if (!_checkValueMatchesType(entry.key, keyTypeNode)) {
        return false;
      }
      if (!_checkValueMatchesType(entry.value, valueTypeNode)) {
        return false;
      }
    }
    return true;
  }

  /// Check if a value matches a type annotation
  bool _checkValueMatchesType(Object? value, SAstNode typeNode) {
    if (typeNode is! SNamedType) {
      // For now, only handle SNamedType
      return true;
    }

    final typeName = typeNode.name!.name;

    // Handle nullable types
    if (typeNode.isNullable && value == null) {
      return true; // null matches nullable types
    }

    // Check built-in types
    switch (typeName) {
      case 'int':
        return value is int;
      case 'double':
        return value is double;
      case 'num':
        return value is num;
      case 'String':
        return value is String;
      case 'bool':
        return value is bool;
      case 'List':
        if (value is! List) return false;
        // Check nested generic type if present
        if (typeNode.typeArguments != null &&
            typeNode.typeArguments!.arguments.isNotEmpty) {
          return _checkGenericListType(
              value, typeNode.typeArguments!.arguments[0]);
        }
        return true;
      case 'Map':
        if (value is! Map) return false;
        // Check nested generic types if present
        if (typeNode.typeArguments != null &&
            typeNode.typeArguments!.arguments.length >= 2) {
          return _checkGenericMapType(
              value,
              typeNode.typeArguments!.arguments[0],
              typeNode.typeArguments!.arguments[1]);
        }
        return true;
      case 'Object':
      case 'dynamic':
        return value !=
            null; // Everything matches Object/dynamic (except null for Object)
      default:
        // For user-defined types, try to resolve from environment
        try {
          final targetType = environment.get(typeName);
          if (targetType is InterpretedClass) {
            return value is InterpretedInstance &&
                value.klass.isSubtypeOf(targetType);
          } else if (targetType is BridgedClass) {
            return value is BridgedInstance &&
                value.bridgedClass.isSubtypeOf(targetType);
          }
        } catch (_) {
          // If type not found, assume it matches (lenient approach)
          return true;
        }
        return true;
    }
  }

  dynamic visitIdentifier(SAstNode node) {
    final identName = (node as SSimpleIdentifier).name;
    final value = environment.get(identName);
    if (value == null) {
      // Log environment ID on failure
      Logger.debug(
          "[visitIdentifier] Failed to find '$identName' in env: ${environment.hashCode}");
      throw RuntimeD4rtException("Undefined variable: $identName");
    }
    return value;
  }

  bool _isInCatchBlock = false;

  InternalInterpreterD4rtException? _originalCaughtInternalExceptionForRethrow;

  @override
  Object? visitTryStatement(STryStatement node) {
    // Store the internal exception if caught
    InternalInterpreterD4rtException? caughtInternalException;
    StackTrace? caughtStackTrace;

    Object? tryResult;
    Object? returnValue; // Store either the try result or the catch result

    final originalEnv = environment; // Save to restore after catch/finally

    try {
      // 1. Execute the try block
      Logger.debug("[STryStatement] Entering try block");
      tryResult = node.body!.accept<Object?>(this);
      returnValue = tryResult; // Default value if no exception
      Logger.debug("[STryStatement] Try block completed normally");
    } on ReturnException {
      // If the try returns, the finally must execute, but we propagate the return
      Logger.debug(
          "[STryStatement] Propagating ReturnException from try block.");
      rethrow;
    } on BreakException {
      // Propagate for outer loops/switch
      Logger.debug("[STryStatement] Propagating BreakException from try block");
      rethrow;
    } on ContinueException {
      // Propagate for outer loops
      Logger.debug(
          "[STryStatement] Propagating ContinueException from try block");
      rethrow;
    } on InternalInterpreterD4rtException catch (e, s) {
      // Catch ONLY the exceptions already encapsulated (coming from a 'throw')
      Logger.debug(
          "[STryStatement] Caught internal exception in try block: ${e.originalThrownValue}");
      caughtInternalException = e; // Store the internal exception
      caughtStackTrace = s;
      returnValue = null; // No normal try result
    } catch (userException, userStack) {
      // Catch any other exception (potentially native)
      Logger.debug(
          "[STryStatement] Caught unexpected non-InternalInterpreterException in TRY: $userException");
      // Encapsulate the user/native exception in our internal type
      caughtInternalException = InternalInterpreterD4rtException(userException);
      caughtStackTrace = userStack;
      returnValue = null;
    }

    // 2. Execute the catch blocks (if an internal exception was raised AND stored)
    if (caughtInternalException != null) {
      // Use the ORIGINAL value from the internal exception for checks
      final originalThrownValue = caughtInternalException.originalThrownValue;

      Logger.debug(
          "[STryStatement] Looking for catch clauses for thrown value: ${stringify(originalThrownValue)} (type: ${originalThrownValue?.runtimeType})");

      for (final clause in node.catchClauses) {
        bool typeMatch = false;
        String? targetCatchTypeName;

        // Type check (on Type)
        if (clause.exceptionType == null) {
          // No 'on Type' clause, matches anything
          typeMatch = true;
          Logger.debug("[STryStatement] Catch clause matches any type.");
        } else {
          final typeNode = clause.exceptionType!;
          if (typeNode is SNamedType) {
            targetCatchTypeName = typeNode.name!.name;
            Logger.debug(
                "[STryStatement] Checking catch clause for type: $targetCatchTypeName");

            // Use originalThrownValue for type checking
            switch (targetCatchTypeName) {
              case 'int':
                typeMatch = originalThrownValue is int;
                break;
              case 'double':
                typeMatch = originalThrownValue is double;
                break;
              case 'num':
                typeMatch = originalThrownValue is num;
                break;
              case 'String':
                typeMatch = originalThrownValue is String;
                break;
              case 'bool':
                typeMatch = originalThrownValue is bool;
                break;
              case 'List':
                typeMatch = originalThrownValue is List;
                break;
              case 'Null':
                // This is tricky. 'on Null' might not be common.
                // Check if the original value is null.
                typeMatch = originalThrownValue == null;
                break;
              case 'Object':
                // Everything non-null is an Object?
                // Dart's 'on Object' catches non-null exceptions.
                typeMatch = originalThrownValue != null;
                break;
              case 'dynamic': // 'on dynamic' catches everything, like no 'on' clause
                typeMatch = true;
                break;
              case 'void': // Cannot catch on void
                typeMatch = false;
                break;
              case 'Exception':
                // Match any native Exception subtype
                typeMatch = originalThrownValue is Exception;
                break;
              case 'Error':
                // Match any native Error subtype
                typeMatch = originalThrownValue is Error;
                break;
              case 'FormatException':
                typeMatch = originalThrownValue is FormatException;
                break;
              case 'StateError':
                typeMatch = originalThrownValue is StateError;
                break;
              case 'ArgumentError':
                typeMatch = originalThrownValue is ArgumentError;
                break;
              case 'RangeError':
                typeMatch = originalThrownValue is RangeError;
                break;
              case 'TypeError':
                typeMatch = originalThrownValue is TypeError;
                break;
              case 'UnsupportedError':
                typeMatch = originalThrownValue is UnsupportedError;
                break;
              default:
                // User-defined type
                try {
                  final targetType = environment.get(targetCatchTypeName);
                  if (targetType is InterpretedClass) {
                    // Check if the ORIGINAL thrown value is an instance of the target type
                    if (originalThrownValue is InterpretedInstance) {
                      typeMatch =
                          originalThrownValue.klass.isSubtypeOf(targetType);
                      Logger.debug(
                          "[STryStatement]   Checking instance '${originalThrownValue.klass.name}' against class '$targetCatchTypeName'. Result: $typeMatch");
                    } else {
                      // Native value cannot be subtype of user-defined class
                      typeMatch = false;
                      Logger.debug(
                          "[STryStatement]   Thrown value is native (${originalThrownValue?.runtimeType}), cannot match user class '$targetCatchTypeName'.");
                    }
                  } else if (targetType is BridgedClass) {
                    // G-DCLI-08/12 FIX: Handle native exceptions matched against bridged types
                    // When a native exception (e.g., RunException, CopyException) is thrown
                    // and caught with 'on RunException catch (e)', we need to match the
                    // native exception's type against the BridgedClass.
                    if (originalThrownValue != null) {
                      try {
                        final thrownBridge = globalEnvironment
                            .toBridgedClass(originalThrownValue.runtimeType);
                        // Check if the thrown value's bridge matches the catch type
                        typeMatch =
                            thrownBridge.nativeType == targetType.nativeType ||
                                thrownBridge.name == targetType.name;
                        Logger.debug(
                            "[STryStatement]   Checking native thrown '${thrownBridge.name}' against bridged class '$targetCatchTypeName'. Result: $typeMatch");
                      } catch (_) {
                        // Thrown value has no bridge - try runtime type name match
                        final thrownTypeName =
                            originalThrownValue.runtimeType.toString();
                        typeMatch = thrownTypeName == targetType.name ||
                            thrownTypeName.startsWith('${targetType.name}<');
                        Logger.debug(
                            "[STryStatement]   No bridge for thrown type '$thrownTypeName'. Name match against '$targetCatchTypeName': $typeMatch");
                      }
                    } else {
                      typeMatch = false;
                    }
                  } else {
                    // Target type name resolved, but it's not an InterpretedClass or BridgedClass
                    typeMatch = false;
                    Logger.warn(
                        "[STryStatement] Catch clause type '$targetCatchTypeName' not found or not a class/mixin.");
                  }
                } catch (e) {
                  // Error resolving targetCatchTypeName
                  Logger.warn(
                      "[STryStatement] Error resolving catch clause type '$targetCatchTypeName': $e");
                  typeMatch = false;
                }
            }
          } else {
            // Handle other type nodes like FunctionType if necessary
            Logger.warn(
                "[STryStatement] Unsupported catch clause type node: ${clause.exceptionType.runtimeType}");
            typeMatch = false;
          }
        }

        if (typeMatch) {
          Logger.debug(
              "[STryStatement] Found matching catch clause${targetCatchTypeName != null ? ' for type $targetCatchTypeName' : ''}.");
          final exceptionParameterName = clause.exceptionParameter?.name;
          final stackTraceParameterName = clause.stackTraceParameter?.name;

          // Create an environment for the catch block
          environment =
              originalEnv; // Restore the environment before creating the catch environment
          final catchEnv = Environment(enclosing: environment);
          if (exceptionParameterName != null) {
            // Define with the ORIGINAL thrown value
            catchEnv.define(exceptionParameterName, originalThrownValue);
            Logger.debug(
                "[STryStatement] Defined exception var '$exceptionParameterName' with original value: ${stringify(originalThrownValue)}");
          }
          if (stackTraceParameterName != null) {
            // Store the textual representation of the stack trace
            // Ensure caughtStackTrace is not null before calling toString()
            final stackTraceString =
                caughtStackTrace?.toString() ?? "Stack trace unavailable";
            catchEnv.define(stackTraceParameterName, stackTraceString);
            Logger.debug(
                "[STryStatement] Defined stacktrace var '$stackTraceParameterName'."); // Don't print full trace here
          }

          // Execute the catch block in its environment
          environment = catchEnv;
          _isInCatchBlock = true;
          _originalCaughtInternalExceptionForRethrow =
              caughtInternalException; // Store the internal exception for potential rethrow
          //
          try {
            Logger.debug("[STryStatement] Entering catch block body");
            returnValue = clause.body!.accept<Object?>(this);
            Logger.debug("[STryStatement] Catch block completed normally");
            // The exception is handled, clear caughtInternalException to not rethrow it after finally
            caughtInternalException = null;
          } on ReturnException {
            // The catch made a return, we propagate it immediately but the finally must execute
            Logger.debug(
                "[STryStatement] Caught ReturnException in CATCH block");
            // IMPORTANT: Clean the rethrow state BEFORE rethrowing
            _isInCatchBlock = false;
            _originalCaughtInternalExceptionForRethrow = null;
            rethrow; // IMPORTANT: Ensure the return ends the function
          } on InternalInterpreterD4rtException catch (catchInternalError, catchStack) {
            if (identical(catchInternalError,
                _originalCaughtInternalExceptionForRethrow)) {
              // This is the exception rethrown by 'rethrow'. It must be allowed to propagate.
              Logger.debug(
                  "[STryStatement] Identified rethrown exception. Propagating.");
              // IMPORTANT: Clean the rethrow state BEFORE rethrowing
              _isInCatchBlock = false;
              _originalCaughtInternalExceptionForRethrow = null;
              rethrow; // Relaunch to let the outer mechanism handle it
            } else {
              // This is a NEW internal exception coming from the catch body.
              Logger.debug(
                  "[STryStatement] Caught NEW internal exception in CATCH block: ${catchInternalError.originalThrownValue}");
              caughtInternalException =
                  catchInternalError; // The new internal exception replaces the old one
              caughtStackTrace = catchStack; // Update stack trace too
              // The new exception is NOT handled by this try/catch
              returnValue = null;
            }
          } catch (nativeError, nativeStack) {
            // Catch other unexpected errors from catch block
            Logger.debug(
                "[STryStatement] Caught unexpected non-InternalInterpreterException in CATCH: $nativeError");
            // Wrap it as InternalInterpreterException to propagate
            caughtInternalException =
                InternalInterpreterD4rtException(nativeError);
            caughtStackTrace = nativeStack;
            returnValue = null;
          } finally {
            // IMPORTANT: Clean the rethrow state if we exit the catch
            _isInCatchBlock = false;
            _originalCaughtInternalExceptionForRethrow = null;
            environment =
                originalEnv; // Restore the environment after the catch
          }
          // Exit the for loop of catch clauses, because we found a match
          break;
        } else {
          Logger.debug(
              "[STryStatement] Skipping catch clause (type mismatch: needed $targetCatchTypeName, got ${originalThrownValue?.runtimeType})");
        }
      } // fin boucle for catchClauses
    } // fin if (caughtInternalException != null)

    // 3. Execute the finally block (always)
    // Store potential exception from finally block (must be internal type now)
    InternalInterpreterD4rtException? finallyInternalException;

    if (node.finallyBlock != null) {
      environment = originalEnv; // Ensure we are in the correct environment
      Logger.debug("[STryStatement] Entering finally block");
      try {
        node.finallyBlock!.accept<Object?>(this);
        Logger.debug("[STryStatement] Finally block completed normally");
      } on ReturnException {
        // If finally returns, it overrides everything
        Logger.debug("[STryStatement] Caught ReturnException in FINALLY block");
        rethrow; // The return of the finally is the final value
      } on InternalInterpreterD4rtException catch (e) {
        // Catch internal exceptions coming from finally (throw/rethrow in finally)
        Logger.debug(
            "[STryStatement] Caught internal exception in FINALLY block: ${e.originalThrownValue}");
        // The internal exception of the finally prevails
        finallyInternalException = e; // Store internal exception
        // We might want to store the stack trace too if needed later
      } catch (e) {
        // Catch other unexpected errors from finally block
        Logger.debug(
            "[STryStatement] Caught unexpected non-InternalInterpreterException in FINALLY: $e");
        // Wrap it as InternalInterpreterException
        finallyInternalException = InternalInterpreterD4rtException(e);
      }
    }

    // 4. Déterminer le résultat final
    if (finallyInternalException != null) {
      Logger.debug(
          "[STryStatement] Rethrowing internal exception from FINALLY: ${finallyInternalException.originalThrownValue}");
      throw finallyInternalException; // The internal exception of the Finally always prevails
    }

    // If there is an unhandled internal exception (either original, or from a catch) and no exception from the finally
    if (caughtInternalException != null /* && !exceptionHandled */) {
      // Note: If it was handled, caughtInternalException was set to null inside the matching catch block.
      // So, if caughtInternalException is still non-null here, it means it wasn't handled.
      Logger.debug(
          "[STryStatement] Rethrowing unhandled internal exception from TRY/CATCH: ${caughtInternalException.originalThrownValue}");
      throw caughtInternalException;
    }

    // Otherwise, return the value (either from the try, or from the catch that handled the exception)
    // Note: if a catch made a return, it was already propagated by the 'rethrow' above.
    Logger.debug("[STryStatement] Exiting normally, returning: $returnValue");
    return returnValue;
  }

  @override
  Object? visitThrowExpression(SThrowExpression node) {
    // 1. Evaluate the expression that is thrown
    final thrownValue = node.expression!.accept<Object?>(this);

    // 2. Create and throw an InternalInterpreterException.
    final message = stringify(thrownValue); // Keep for debug log
    Logger.debug("[SThrowExpression] Throwing (original value): $message");
    // Throw the specific internal exception, wrapping the original value
    throw InternalInterpreterD4rtException(thrownValue);
    // We don't capture stack trace here, the 'catch' block does it.
  }

  @override
  Object? visitRethrowExpression(SRethrowExpression node) {
    final asyncState = currentAsyncState;
    if (asyncState == null) {
      if (!_isInCatchBlock ||
          _originalCaughtInternalExceptionForRethrow == null) {
        throw RuntimeD4rtException(
            "'rethrow' can only be used within a catch block.");
      }
      Logger.debug(
          "[Rethrow] Rethrowing original internal exception: ${_originalCaughtInternalExceptionForRethrow!.originalThrownValue}");
      // Re-launch the *original internal exception* that was caught by the enclosing catch block
      throw _originalCaughtInternalExceptionForRethrow!;
    }
    if (!asyncState.isHandlingErrorForRethrow) {
      throw RuntimeD4rtException(
          "'rethrow' can only be used within a catch block.");
    }
    final originalError = asyncState.originalErrorForRethrow;
    if (originalError == null) {
      // Should not happen if isHandlingErrorForRethrow is true, but safety check
      throw StateD4rtException(
          "Internal error: Inconsistent state for rethrow.");
    }
    Logger.debug(
        "[Rethrow] Rethrowing original internal exception: ${originalError.originalThrownValue}");
    // Set flag to indicate this is a rethrow, not a new exception
    asyncState.isCurrentlyRethrowing = true;
    // Relaunch the original exception stored in the async state
    throw originalError;
  }

  @override
  Object? visitIsExpression(SIsExpression node) {
    final expressionValue = node.expression!.accept<Object?>(this);
    final typeNode = node.type;
    bool result = false;

    if (typeNode is SNamedType) {
      final typeName = typeNode.name!.name;

      // Handle built-in types first
      switch (typeName) {
        case 'int':
          result = expressionValue is int;
          break;
        case 'double':
          result = expressionValue is double;
          break;
        case 'num':
          result = expressionValue is num;
          break;
        case 'String':
          result = expressionValue is String;
          break;
        case 'bool':
          result = expressionValue is bool;
          break;
        case 'List':
          if (expressionValue is! List) {
            result = false;
          } else if (typeNode.typeArguments == null ||
              typeNode.typeArguments!.arguments.isEmpty) {
            // No type arguments specified, just check if it's a List
            result = true;
          } else {
            // Check generic type arguments
            result = _checkGenericListType(
                expressionValue, typeNode.typeArguments!.arguments[0]);
          }
          break;
        case 'Map':
          if (expressionValue is! Map) {
            result = false;
          } else if (typeNode.typeArguments == null ||
              typeNode.typeArguments!.arguments.isEmpty) {
            // No type arguments specified, just check if it's a Map
            result = true;
          } else {
            // Check generic type arguments
            final typeArgs = typeNode.typeArguments!.arguments;
            if (typeArgs.length >= 2) {
              result = _checkGenericMapType(
                  expressionValue, typeArgs[0], typeArgs[1]);
            } else {
              result = true; // Partial generic, just accept
            }
          }
          break;
        case 'Null':
          result = expressionValue == null;
          break;
        case 'Object':
          // Everything non-null is an Object?
          result = expressionValue != null;
          break;
        case 'dynamic': // 'is dynamic' is always true
        case 'void': // 'is void' is always false (or error?) - let's say false
          result = typeName == 'dynamic';
          break;
        default:
          try {
            final targetType = environment.get(typeName);

            if (targetType is BridgedClass) {
              if (expressionValue is BridgedInstance) {
                // Use the new helper method
                result = expressionValue.bridgedClass.isSubtypeOf(targetType);
              } else {
                // A non-instance value cannot be a subtype of a user-defined class
                result = false;
              }
            } else if (targetType is InterpretedClass) {
              if (expressionValue is InterpretedInstance) {
                // Use the new helper method
                result = expressionValue.klass.isSubtypeOf(targetType);
              } else {
                // A non-instance value cannot be a subtype of a user-defined class
                result = false;
              }
            } else if (targetType is NativeFunction &&
                targetType.call(this, []) is Type) {
              final object = targetType.call(this, []);

              return expressionValue.runtimeType == object;
            } else {
              throw RuntimeD4rtException(
                  "Type '$typeName' not found or is not a ${expressionValue.runtimeType}.");
            }
          } on RuntimeD4rtException catch (e) {
            // Propagate type lookup error
            // Wrap in InternalInterpreterException to be caught correctly
            throw InternalInterpreterD4rtException(
                RuntimeD4rtException("Type check failed: ${e.message}"));
          }
      }
    } else {
      // Handle FunctionType, etc., later if needed
      throw UnimplementedD4rtException(
          'Type check for ${typeNode.runtimeType} not implemented.');
    }

    // Handle negation (is!)
    if (node.isNot) {
      return !result;
    } else {
      return result;
    }
  }

  /// Recursively check if a CollectionElement represents a map entry.
  /// This handles SForElement, SIfElement, and SMapLiteralEntry directly.
  bool _isMapLiteralElement(SAstNode element) {
    if (element is SMapLiteralEntry) {
      return true;
    } else if (element is SForElement) {
      return _isMapLiteralElement(element.body!);
    } else if (element is SIfElement) {
      return _isMapLiteralElement(element.thenElement!);
    }
    return false;
  }

  @override
  Object? visitSetOrMapLiteral(SSetOrMapLiteral node) {
    bool isMap;
    bool typeExplicit = false;

    // Check explicit type arguments first
    if (node.typeArguments != null &&
        node.typeArguments!.arguments.isNotEmpty) {
      isMap = node.typeArguments!.arguments.length == 2;
      typeExplicit = true;
      Logger.debug(
          "[SSetOrMapLiteral] Determined type via explicit args: isMap = $isMap");
    } else {
      // No explicit types, infer from content
      isMap = false; // Default to Set if unsure initially
      bool onlySpreads = true;
      SAstNode? firstEffectiveElement;

      for (final element in node.elements) {
        // Check if element (or its inner body) is a SMapLiteralEntry
        if (_isMapLiteralElement(element)) {
          isMap = true;
          onlySpreads = false;
          firstEffectiveElement = element;
          Logger.debug(
              "[SSetOrMapLiteral] Determined isMap = true (found SMapLiteralEntry or element containing one).");
          break; // Found a map entry, definitely a map
        }
        if (element is! SSpreadElement && firstEffectiveElement == null) {
          firstEffectiveElement = element;
          onlySpreads = false;
          // If it's an Expression, isMap remains false (it's a Set)
          Logger.debug(
              "[SSetOrMapLiteral] Determined isMap = false (found first non-spread Expression).");
        }
        if (element is! SSpreadElement) {
          onlySpreads = false;
        }
      }

      // Handle empty literal or spread-only literal
      if (!typeExplicit) {
        // Re-evaluate if type wasn't explicit
        if (node.elements.isEmpty) {
          isMap = true; // Empty literal defaults to Map
          Logger.debug(
              "[SSetOrMapLiteral] Determined isMap = true (empty literal).");
        } else if (onlySpreads) {
          // Only spread elements, no explicit type args. Infer from first spread.
          Logger.debug(
              "[SSetOrMapLiteral] Only spreads found. Inferring type from first spread element.");
          final firstSpread = node.elements.first as SSpreadElement;
          final spreadValue = firstSpread.expression!.accept<Object?>(this);
          // Check if the evaluated spread value is a Map or looks like one
          final bridgedInstance = toBridgedInstance(spreadValue);
          if (spreadValue is Map ||
              (bridgedInstance.$2 && bridgedInstance.$1?.nativeObject is Map)) {
            isMap = true;
            Logger.debug(
                "[SSetOrMapLiteral]   First spread evaluated to Map. Setting isMap = true.");
          } else {
            isMap = false; // Assume Set otherwise
            Logger.debug(
                "[SSetOrMapLiteral]   First spread did not evaluate to Map. Setting isMap = false.");
          }
        } else if (firstEffectiveElement != null &&
            _isMapLiteralElement(firstEffectiveElement)) {
          isMap =
              true; // Confirmation if first non-spread was entry (or contains one)
        } else {
          isMap = false; // If first non-spread was Expression, it's a Set
        }
      }
    }

    // Create and populate the collection
    final Object collection = isMap ? <Object?, Object?>{} : <Object?>{};

    for (final element in node.elements) {
      try {
        _processCollectionElement(element, collection, isMap: isMap);
      } on RuntimeD4rtException catch (e) {
        final literalType = isMap ? "Map" : "Set";
        // Check if error already contains context to avoid duplication
        if (!e.message.contains('in $literalType literal')) {
          throw RuntimeD4rtException("${e.message} (in $literalType literal)");
        } else {
          rethrow; // Rethrow original error with context
        }
      }
    }

    // If this is a const collection, return an unmodifiable version
    if (node.isConst) {
      if (isMap) {
        return Map.unmodifiable(collection as Map<Object?, Object?>);
      } else {
        return Set.unmodifiable(collection as Set<Object?>);
      }
    }

    return collection;
  }

  // Resolve TypeAnnotation AST node to RuntimeType
  RuntimeType _resolveTypeAnnotation(SAstNode? typeNode,
      {bool isAsync = false}) {
    return _resolveTypeAnnotationWithEnvironment(typeNode, environment,
        isAsync: isAsync);
  }

  // Resolve TypeAnnotation AST node to RuntimeType using a specific environment
  RuntimeType _resolveTypeAnnotationWithEnvironment(
      SAstNode? typeNode, Environment env,
      {bool isAsync = false}) {
    if (typeNode == null) {
      return BridgedClass(nativeType: dynamic, name: 'dynamic');
    }
    if (typeNode is SNamedType) {
      String typeName = isAsync
          ? typeNode
              .toString()
              .replaceAll('?', '')
              .substringAfter('<')
              .substringBeforeLast('>')
          : typeNode.name!.name;
      if (typeName.contains('<') && typeName.contains('>')) {
        typeName = typeName.substring(0, typeName.indexOf('<'));
      }
      if (typeName == "void") {
        // void is not a valid type literal expression; use Null as runtime placeholder
        return BridgedClass(nativeType: Null, name: 'void');
      }
      Logger.debug("[ResolveType] Resolving SNamedType: $typeName");
      try {
        final resolved = env.get(typeName);
        if (resolved is RuntimeType) {
          Logger.debug(
              "[ResolveType]   Resolved to RuntimeType: ${resolved.name}");
          return resolved;
        } else {
          throw RuntimeD4rtException(
              "Symbol '$typeName' resolved to non-type value: $resolved");
        }
      } on RuntimeD4rtException {
        // Handle special case: 'dynamic' type doesn't exist in environment usually
        if (typeName == 'dynamic') {
          Logger.debug("[ResolveType]   Resolved to dynamic (special case)");
          // Need a representation for dynamic. Using a placeholder for now.
          // Ideally, have a predefined DynamicRuntimeType() instance.
          return BridgedClass(
              nativeType: Object, name: 'dynamic'); // Corrected placeholder
        }
        throw RuntimeD4rtException("Type '$typeName' not found.");
      }
    } else if (typeNode is SRecordTypeAnnotation) {
      // Handle record type annotations like (int, int) or (int, {String name})
      // For now, return a placeholder that represents the Record type
      // D4rt uses Dart's native Record type at runtime
      Logger.debug(
          "[ResolveType] Resolving SRecordTypeAnnotation: ${typeNode.toString()}");
      return BridgedClass(nativeType: Record, name: 'Record');
    } else if (typeNode is SGenericFunctionType) {
      // Handle function type annotations like int Function(int) or void Function(String, int)
      // For runtime purposes, we treat all function types as the Function type
      Logger.debug(
          "[ResolveType] Resolving SGenericFunctionType: ${typeNode.toString()}");
      return BridgedClass(nativeType: Function, name: 'Function');
    } else {
      Logger.error(
          "[ResolveType] Unsupported TypeAnnotation type: ${typeNode.runtimeType}");
      throw UnimplementedD4rtException(
          "Type resolution for ${typeNode.runtimeType} not implemented yet.");
    }
  }

  @override
  Object? visitInstanceCreationExpression(SInstanceCreationExpression node) {
    final constructorNameNode = node.constructorName!.type;
    final constructorName =
        constructorNameNode!.name!.name; // Name of the class
    final namedConstructorPart = node
        .constructorName!.name?.name; // Name of the named constructor (or null)

    Logger.debug(
        "[InstanceCreation] Creating instance of '$constructorName'${namedConstructorPart != null ? '.$namedConstructorPart' : ''}");

    // Resolve the type
    Object? typeValue;
    try {
      typeValue = environment.get(constructorName);
    } on RuntimeD4rtException {
      throw RuntimeD4rtException(
          "Type '$constructorName' not found for instantiation.");
    }

    // Check the resolved type
    if (typeValue is InterpretedClass) {
      // CASE 1: InterpretedClass
      final klass = typeValue;
      Logger.debug(
          "[InstanceCreation]   Type resolved to InterpretedClass: '$constructorName'");

      // Find and call the constructor (interpreted)
      final constructorLookupName =
          namedConstructorPart ?? ''; // Use '' for default
      final constructor = klass.findConstructor(constructorLookupName);

      if (constructor == null) {
        throw RuntimeD4rtException(
            "Class '$constructorName' does not have a constructor named '$constructorLookupName'.");
      }

      // G-DOV2-3 FIX: Check if the class is abstract AFTER finding the constructor
      // Factory constructors are allowed on abstract classes
      if (klass.isAbstract && !constructor.isFactory) {
        throw RuntimeD4rtException(
            "Cannot instantiate abstract class '$constructorName'.");
      }

      // Evaluate the arguments
      final evaluationResult = _evaluateArgumentsAsync(node.argumentList);
      if (evaluationResult is AsyncSuspensionRequest) {
        return evaluationResult; // Propagate suspension
      }
      final (positionalArgs, namedArgs) =
          evaluationResult as (List<Object?>, Map<String, Object?>);

      try {
        // Evaluate the type arguments
        List<RuntimeType>? evaluatedTypeArguments;
        final typeArgsNode = node.constructorName!.type!.typeArguments;
        if (typeArgsNode != null) {
          evaluatedTypeArguments = typeArgsNode.arguments
              .map((typeNode) => _resolveTypeAnnotation(typeNode))
              .toList();
        }

        // Handle factory constructors differently from regular constructors
        if (constructor.isFactory) {
          // Factory constructors don't need a pre-created instance
          // They are responsible for creating and returning their own instance
          Logger.debug(
              "[InstanceCreation] Calling factory constructor '$constructorLookupName'");

          // Call the factory constructor directly without creating an instance first
          // The factory will create its own instance and return it
          final result = constructor.call(
              this, positionalArgs, namedArgs, evaluatedTypeArguments);

          // Factory constructors should return an instance of the expected type
          if (result is InterpretedInstance && result.klass == klass) {
            return result;
          } else if (result is InterpretedInstance) {
            throw RuntimeD4rtException(
                "Factory constructor '$constructorLookupName' returned an instance of '${result.klass.name}' but expected '$constructorName'.");
          } else {
            throw RuntimeD4rtException(
                "Factory constructor '$constructorLookupName' must return an instance, but returned ${result?.runtimeType}.");
          }
        } else {
          // Regular constructors: create instance first, then call constructor
          Logger.debug(
              "[InstanceCreation] Calling regular constructor '$constructorLookupName'");

          // Create and initialize the fields, passing the type arguments
          final instance =
              klass.createAndInitializeInstance(this, evaluatedTypeArguments);
          // Bind 'this' and call the constructor logic
          final boundConstructor = constructor.bind(instance);
          boundConstructor.call(
              this, positionalArgs, namedArgs, evaluatedTypeArguments);
          // The constructor call returns the instance
          return instance;
        }
      } on ReturnException catch (e) {
        // Handle return exceptions (applies to both factory and regular constructors)
        if (constructor.isFactory) {
          // For factory constructors, the return value is the actual result
          return e.value;
        } else {
          // For regular constructors, check if returned value is valid
          if (e.value != null && e.value is InterpretedInstance) {
            final instance = e.value as InterpretedInstance; // Explicit cast
            if (instance.klass == klass) {
              // Check on the casted instance
              return instance;
            }
          }
          // If the condition fails (null, not InterpretedInstance, or wrong class)
          throw RuntimeD4rtException(
              "Constructor return value error for '$constructorName'.");
        }
      } on RuntimeD4rtException catch (e) {
        // Simplified error message
        throw RuntimeD4rtException(
            "Constructor execution error for '$constructorName.': ${e.message}");
      }
    } else if (typeValue is BridgedClass) {
      // CASE 2: BridgedClass
      final bridgedClass = typeValue;
      Logger.debug(
          "[InstanceCreation]   Type resolved to BridgedClass: '$constructorName'");

      final (positionalArgs, namedArgs) = _evaluateArguments(node.argumentList);

      // Find the constructor adapter (bridged)
      final constructorLookupName =
          namedConstructorPart ?? ''; // Use '' if null
      final constructorAdapter =
          bridgedClass.findConstructorAdapter(constructorLookupName);

      if (constructorAdapter == null) {
        throw RuntimeD4rtException(
            "Bridged class '$constructorName' does not have a registered constructor named '$constructorLookupName'. Check bridge definition.");
      }

      // Call the constructor adapter
      try {
        // The adapter is responsible for:
        // 1. Converting the interpreted positionalArgs/namedArgs to native types.
        // 2. Calling the actual native constructor.
        // 3. Returning the created native object.
        final nativeObject =
            constructorAdapter(this, positionalArgs, namedArgs);

        // Check if the adapter returned a value (it should)
        if (nativeObject == null) {
          throw RuntimeD4rtException(
              "Bridged constructor adapter for '\$constructorName.$constructorLookupName' returned null unexpectedly.");
        }

        // Don't wrap Futures in BridgedInstance - they need to be awaitable directly
        // Similarly, don't wrap Streams as they need direct subscription
        if (nativeObject is Future || nativeObject is Stream) {
          Logger.debug(
              "[InstanceCreation]   Returning native ${nativeObject.runtimeType} directly (not wrapping)");
          return nativeObject;
        }

        // Wrap the native object in BridgedInstance
        final bridgedInstance = BridgedInstance(bridgedClass, nativeObject);
        Logger.debug(
            "[InstanceCreation]   Successfully created BridgedInstance wrapping native object: \${nativeObject.runtimeType}");
        return bridgedInstance;
      } on RuntimeD4rtException catch (e) {
        // If the adapter itself raises a RuntimeError (e.g. conversion failure)
        throw RuntimeD4rtException(
            "Error during bridged constructor '$constructorLookupName' for class '$constructorName': ${e.message}");
      } catch (e) {
        // Catch potential native exceptions raised by the adapter or the native constructor
        Logger.error(
            "[InstanceCreation] Native exception during bridged constructor '$constructorName.$constructorLookupName': \$e\\n\$s");
        // Encapsulate the native error in a RuntimeError for propagation
        throw RuntimeD4rtException(
            "Native error during bridged constructor '$constructorLookupName' for class '$constructorName': \$e");
      }
    } else {
      // CASE 3: The resolved type is neither InterpretedClass nor BridgedClass
      throw RuntimeD4rtException(
          "Identifier '$constructorName' resolved to ${typeValue?.runtimeType}, which is not a class type that can be instantiated.");
    }
  }

  (List<Object?>, Map<String, Object?>) _evaluateArguments(
      SArgumentList? argumentList) {
    if (argumentList == null) return (<Object?>[], <String, Object?>{});
    List<Object?> positionalArgs = [];
    Map<String, Object?> namedArgs = {};
    bool namedArgsEncountered = false;

    for (final arg in argumentList.arguments) {
      if (arg is SNamedExpression) {
        namedArgsEncountered = true;
        final name = arg.name!.label!.name;
        final value = arg.expression!.accept<Object?>(this);

        // Check for async suspension in named arguments
        if (value is AsyncSuspensionRequest) {
          return value as dynamic; // Propagate suspension request
        }

        if (namedArgs.containsKey(name)) {
          throw RuntimeD4rtException(
              "Named argument '$name' provided more than once.");
        }
        final bridgedInstance = toBridgedInstance(value);
        namedArgs[name] = _bridgeInterpreterValueToNative(
            bridgedInstance.$2 ? bridgedInstance.$1!.nativeObject : value);
      } else {
        if (namedArgsEncountered) {
          throw RuntimeD4rtException(
              "Positional arguments cannot follow named arguments.");
        }
        final a = arg.accept<Object?>(this);

        // Check for async suspension in positional arguments
        if (a is AsyncSuspensionRequest) {
          return a as dynamic; // Propagate suspension request
        }

        final bridgedInstance = toBridgedInstance(a);
        positionalArgs.add(_bridgeInterpreterValueToNative(
            bridgedInstance.$2 ? bridgedInstance.$1!.nativeObject : a));
      }
    }

    return (positionalArgs, namedArgs);
  }

  Object? _bridgeInterpreterValueToNative(Object? interpreterValue) {
    if (interpreterValue is BridgedInstance) {
      return interpreterValue.nativeObject;
    }

    if (interpreterValue is BridgedEnumValue) {
      return interpreterValue.nativeValue;
    }

    return interpreterValue;
  }

  /// Evaluates arguments for async function calls, handling await expressions.
  /// Returns either (List&lt;Object?&gt;, Map&lt;String, Object?&gt;) or AsyncSuspensionRequest.
  Object? _evaluateArgumentsAsync(SArgumentList? argumentList) {
    if (argumentList == null) return (<Object?>[], <String, Object?>{});
    List<Object?> positionalArgs = [];
    Map<String, Object?> namedArgs = {};
    bool namedArgsEncountered = false;

    for (final arg in argumentList.arguments) {
      if (arg is SNamedExpression) {
        namedArgsEncountered = true;
        final name = arg.name!.label!.name;
        final value = arg.expression!.accept<Object?>(this);

        // Check for async suspension in named arguments
        if (value is AsyncSuspensionRequest) {
          Logger.debug(
              "[_evaluateArgumentsAsync] Async suspension in named argument '$name'");
          return value; // Propagate suspension request
        }

        if (namedArgs.containsKey(name)) {
          throw RuntimeD4rtException(
              "Named argument '$name' provided more than once.");
        }
        final bridgedInstance = toBridgedInstance(value);
        namedArgs[name] = _bridgeInterpreterValueToNative(
            bridgedInstance.$2 ? bridgedInstance.$1!.nativeObject : value);
      } else {
        if (namedArgsEncountered) {
          throw RuntimeD4rtException(
              "Positional arguments cannot follow named arguments.");
        }
        final a = arg.accept<Object?>(this);

        // Check for async suspension in positional arguments
        if (a is AsyncSuspensionRequest) {
          Logger.debug(
              "[_evaluateArgumentsAsync] Async suspension in positional argument");
          return a; // Propagate suspension request
        }

        final bridgedInstance = toBridgedInstance(a);
        positionalArgs.add(_bridgeInterpreterValueToNative(
            bridgedInstance.$2 ? bridgedInstance.$1!.nativeObject : a));
      }
    }

    Logger.debug(
        "[_evaluateArgumentsAsync] All arguments evaluated successfully: ${positionalArgs.length} positional, ${namedArgs.length} named");
    return (positionalArgs, namedArgs);
  }

  // Add SFunctionExpressionInvocation handler
  @override
  Object? visitFunctionExpressionInvocation(
      SFunctionExpressionInvocation node) {
    // 1. Evaluate the function expression itself.
    // This should result in a Callable (like InterpretedFunction or NativeFunction).
    final calleeValue = node.function!.accept<Object?>(this);

    // 2. Evaluate arguments (shared logic).
    final (positionalArgs, namedArgs) = _evaluateArguments(node.argumentList);

    // 3. Evaluate type arguments (shared logic).
    List<RuntimeType>? evaluatedTypeArguments;
    final typeArgsNode = node.typeArguments;
    if (typeArgsNode != null) {
      evaluatedTypeArguments = typeArgsNode.arguments
          .map((typeNode) => _resolveTypeAnnotation(typeNode))
          .toList();
    }

    // 4. Check if it's actually callable (standard callable).
    if (calleeValue is Callable) {
      // 5. Perform the standard call.
      try {
        return calleeValue.call(
            this, positionalArgs, namedArgs, evaluatedTypeArguments);
      } on ReturnException catch (e) {
        return e.value;
      }
    }

    // INTER-001 FIX: Check if it's a BridgedInstance with a call() method
    final bridgedResult = toBridgedInstance(calleeValue);
    if (bridgedResult.$2) {
      final bridgedInstance = bridgedResult.$1!;
      final callMethodAdapter =
          bridgedInstance.bridgedClass.findInstanceMethodAdapter('call');
      if (callMethodAdapter != null) {
        Logger.debug(
            "[FuncExprInvoke] Found 'call' method on BridgedInstance (${bridgedInstance.bridgedClass.name}). Invoking...");
        try {
          return callMethodAdapter(this, bridgedInstance.nativeObject,
              positionalArgs, namedArgs, evaluatedTypeArguments);
        } on ReturnException catch (e) {
          return e.value;
        }
      }
    }

    // Try Extension 'call' Method
    {
      const methodName = 'call';
      try {
        final extensionMethod =
            environment.findExtensionMember(calleeValue, methodName);

        if (extensionMethod is ExtensionMemberCallable &&
            !extensionMethod
                .isOperator && // Ensure it's a regular method named 'call'
            !extensionMethod.isGetter &&
            !extensionMethod.isSetter) {
          Logger.debug(
              "[FuncExprInvoke] Found extension method 'call' for type ${calleeValue?.runtimeType}. Calling...");

          // Prepare arguments for extension method:
          // First arg is the receiver (the object being called)
          final extensionPositionalArgs = [calleeValue, ...positionalArgs];

          try {
            // Call the extension method
            return extensionMethod.call(this, extensionPositionalArgs,
                namedArgs, evaluatedTypeArguments);
          } on ReturnException catch (e) {
            return e.value;
          } catch (e) {
            throw RuntimeD4rtException(
                "Error executing extension method 'call': $e");
          }
        }
        Logger.debug(
            "[FuncExprInvoke] No suitable extension method 'call' found for type ${calleeValue?.runtimeType}.");
      } on RuntimeD4rtException catch (findError) {
        Logger.debug(
            "[FuncExprInvoke] No extension member 'call' found for type ${calleeValue?.runtimeType}. Error: ${findError.message}");
        // Fall through to the final standard error below.
      }

      // Original Error: The expression evaluated did not yield a callable function or an object with a callable 'call' extension.
      throw RuntimeD4rtException(
          "Attempted to call something that is not a function and has no 'call' extension method. Got type: ${calleeValue?.runtimeType}");
    }
  }

  @override
  Object? visitConstructorReference(SConstructorReference node) {
    final cName = node.constructorName;
    final typeNode = cName.type;
    final constructorId = cName.name; // Null for default
    final constructorLookupName = constructorId?.name ?? '';

    // Resolve the class type
    final className = typeNode!.name!.name;
    Object? classValue;
    try {
      classValue = environment.get(className);
    } on RuntimeD4rtException {
      throw RuntimeD4rtException(
          "Type '$className' not found for constructor reference.");
    }

    if (classValue is InterpretedClass) {
      // Find the InterpretedFunction for the constructor
      final constructorFunction =
          classValue.findConstructor(constructorLookupName);
      if (constructorFunction == null) {
        throw RuntimeD4rtException(
            "Constructor '$constructorLookupName' not found for class '$className'.");
      }
      // Return the constructor function itself as the tear-off value
      return constructorFunction;
    } else if (classValue is BridgedClass) {
      // Find the adapter (just to check existence)
      final adapter = classValue.findConstructorAdapter(constructorLookupName);
      if (adapter == null) {
        throw RuntimeD4rtException(
            "Bridged constructor '$constructorLookupName' not found for class '$className'.");
      }

      throw UnimplementedD4rtException(
          "Tear-off for bridged constructors ('$className.$constructorLookupName') is not yet supported.");
    } else {
      throw RuntimeD4rtException(
          "Identifier '$className' did not resolve to a class type.");
    }
  }

  @override
  Object? visitFunctionReference(SFunctionReference node) {
    // The actual logic is in visiting the underlying function expression
    // (Identifier, SPropertyAccess, SConstructorReference, etc.)
    // which should return the Callable/Function object itself.
    return node.function.accept<Object?>(this);
  }

  @override
  Object? visitEmptyStatement(SEmptyStatement node) {
    // An empty statement does nothing.
    return null;
  }

  @override
  Object? visitSwitchStatement(SSwitchStatement node) {
    final switchValue = node.expression!.accept<Object?>(this);
    final switchEnvironment = Environment(enclosing: environment);
    final previousEnvironment = environment;
    environment = switchEnvironment;

    // Build a map of labels to member indices for 'continue <label>'
    final Map<String, int> labelToIndex = {};
    for (int i = 0; i < node.members.length; i++) {
      final member = node.members[i];
      List<dynamic> labels = [];
      if (member is SSwitchCase) {
        labels = member.labels;
      } else if (member is SSwitchDefault) {
        labels = member.labels;
      } else if (member is SSwitchPatternCase) {
        labels = member.labels;
      }
      for (final label in labels) {
        final labelName = (label is SLabel)
            ? label.label?.name
            : (label as SAstNode).toString();
        if (labelName != null) labelToIndex[labelName] = i;
      }
    }

    bool matched = false; // Has any case matched the switchValue?
    bool execute =
        false; // Should we execute statements in the current/next section?
    int startIndex = 0; // Starting index for processing members

    try {
      while (true) {
        // outer loop for continue with label
        try {
          for (int i = startIndex; i < node.members.length; i++) {
            final member = node.members[i];
            List<SAstNode> statementsToExecute = [];

            if (member is SSwitchCase) {
              if (!matched) {
                final caseValue = member.expression!.accept<Object?>(this);
                Logger.debug(
                    "[Switch] Checking legacy case value: $caseValue against $switchValue");
                if (switchValue == caseValue) {
                  matched = true;
                  execute = true;
                  Logger.debug("[Switch] Matched legacy case: $caseValue");
                }
              }
              statementsToExecute = member.statements;
            } else if (member is SSwitchPatternCase) {
              // Try explicit cast to potentially help the linter
              final gp = member.guardedPattern;
              final pattern = gp.pattern;
              if (pattern is SConstantPattern) {
                // This handles 'case <constant>:'
                if (!matched) {
                  // Access expression from the SConstantPattern
                  final caseValue = pattern.expression.accept<Object?>(this);
                  Logger.debug(
                      "[Switch] Checking pattern case value: $caseValue against $switchValue");
                  if (switchValue == caseValue) {
                    matched = true;
                    execute = true; // Start executing
                    Logger.debug("[Switch] Matched pattern case: $caseValue");
                  }
                }
                statementsToExecute = member.statements;
              } else {
                // Handle other pattern types using our improved _matchAndBind function
                if (!matched) {
                  // Create a temporary environment for pattern matching in switch
                  final tempEnvironment = Environment(enclosing: environment);
                  try {
                    _matchAndBind(pattern, switchValue, tempEnvironment);
                    // If we get here, the pattern matched
                    matched = true;
                    // G-DOV-8 FIX: Execute pattern case body in the pattern's own scope
                    // and do NOT fall through to subsequent cases (Dart 3 semantics).
                    Logger.debug(
                        "[Switch] Matched pattern case: ${pattern.runtimeType}");

                    // Check guard clause (when)
                    final gpWhenClause = gp.whenClause;
                    if (gpWhenClause != null) {
                      final prevEnv = environment;
                      environment = tempEnvironment;
                      try {
                        final guardResult =
                            gpWhenClause.expression.accept<Object?>(this);
                        if (guardResult != true) {
                          environment = prevEnv;
                          // Guard failed, pattern doesn't match - reset matched so other cases can try
                          matched = false;
                          Logger.debug(
                              "[Switch] Guard clause failed, skipping case");
                          statementsToExecute = member.statements;
                          continue; // Skip to next case member
                        }
                      } catch (e) {
                        environment = prevEnv;
                        rethrow;
                      }
                      environment = prevEnv;
                    }

                    // Execute statements in the pattern environment
                    final prevEnv = environment;
                    environment = tempEnvironment;
                    try {
                      for (final statement in member.statements) {
                        statement.accept<Object?>(this);
                      }
                    } on BreakException catch (e) {
                      environment = prevEnv;
                      if (e.label == null ||
                          _currentStatementLabels.contains(e.label)) {
                        break; // Exit the loop over members
                      } else {
                        rethrow;
                      }
                    } on ContinueException catch (e) {
                      environment = prevEnv;
                      if (e.label != null &&
                          labelToIndex.containsKey(e.label)) {
                        startIndex = labelToIndex[e.label]!;
                        matched = true;
                        execute = true;
                        throw ContinueSwitchLabel();
                      } else {
                        rethrow;
                      }
                    } catch (e) {
                      environment = prevEnv;
                      rethrow;
                    }
                    environment = prevEnv;
                    // Pattern cases do not fall through - break out
                    break;
                  } on PatternMatchD4rtException catch (e) {
                    Logger.debug(
                        "[Switch] Pattern ${pattern.runtimeType} did not match: ${e.message}");
                    // Pattern didn't match, continue to next case
                  }
                }
                statementsToExecute = member.statements;
              }
            } else if (member is SSwitchDefault) {
              Logger.debug("[Switch] Reached default case.");
              if (!matched || execute) {
                // Execute default if no match OR fallthrough
                execute = true;
              }
              statementsToExecute = member.statements;
            } else {
              throw StateD4rtException(
                  'Unknown switch member type: ${member.runtimeType}');
            }

            // Execute statements if needed (either matched this round or fell through)
            if (execute) {
              Logger.debug(
                  "[Switch] Executing statements for matched/fallthrough/default...");
              try {
                for (final statement in statementsToExecute) {
                  statement.accept<Object?>(this);
                }
                // Fall-through continues if no break
              } on BreakException catch (e) {
                Logger.debug(
                    "[Switch] Caught BreakException (label: ${e.label}) with current labels: $_currentStatementLabels");
                if (e.label == null ||
                    _currentStatementLabels.contains(e.label)) {
                  // Unlabeled break OR labeled break targeting this switch.
                  Logger.debug("[Switch] Breaking switch.");
                  execute = false; // Stop execution after this block
                  break; // Exit the loop over members
                } else {
                  // Labeled break targeting an outer construct.
                  Logger.debug("[Switch] Rethrowing outer break...");
                  rethrow;
                }
              } on ContinueException catch (e) {
                if (e.label != null && labelToIndex.containsKey(e.label)) {
                  // Continue to a labeled case in this switch
                  Logger.debug("[Switch] Continue to labeled case: ${e.label}");
                  startIndex = labelToIndex[e.label]!;
                  matched =
                      true; // Mark as matched so we execute the target case
                  execute = true;
                  throw ContinueSwitchLabel(); // Signal to restart from target index
                } else {
                  // 'continue' without a label or with unknown label
                  throw RuntimeD4rtException(
                      "'continue' is not valid inside a switch case/default block without a loop target.");
                }
              }
            }
          }
          // Normal completion - exit the while(true) loop
          break;
        } on ContinueSwitchLabel {
          // Restart execution from startIndex (already set before throwing)
          continue;
        }
      }
    } finally {
      environment = previousEnvironment;
    }

    return null; // Switch statements don't produce a value.
  }

  // Await Expression (Partial Support)
  @override
  Object? visitAwaitExpression(SAwaitExpression node) {
    // Check for async state machine: do we have an async state?
    if (currentAsyncState == null) {
      // This shouldn't happen if the call is properly orchestrated
      throw StateD4rtException(
          "Internal error: 'await' encountered outside of a managed async execution state.");
    }

    // Initial check: Are we in an async function?
    if (!currentAsyncState!.function.isAsync) {
      throw RuntimeD4rtException(
          "'await' can only be used inside an async function.");
    }

    // Check if we are in invocation resumption mode
    if (currentAsyncState!.isInvocationResumptionMode) {
      Logger.debug(
          "[SAwaitExpression] In invocation resumption mode, returning last await result: ${currentAsyncState!.lastAwaitResult}");
      return currentAsyncState!.lastAwaitResult;
    }

    Logger.debug("[SAwaitExpression] Evaluating expression for await...");
    final expressionValue = node.expression!.accept<Object?>(this);

    // HANDLING NESTED SUSPENSIONS
    if (expressionValue is AsyncSuspensionRequest) {
      // If the awaited expression itself is an await, just propagate its suspension request.
      Logger.debug(
          "[SAwaitExpression] Awaited expression itself suspended. Propagating AsyncSuspensionRequest.");
      return expressionValue;
    }

    // Bug-92: Unwrap BridgedInstance containing a Future
    // When Future is created via bridged constructor, it gets wrapped in BridgedInstance
    // We need to unwrap it to get the actual Future for await
    Object? futureValue = expressionValue;
    if (expressionValue is BridgedInstance &&
        expressionValue.nativeObject is Future) {
      futureValue = expressionValue.nativeObject;
      Logger.debug(
          "[SAwaitExpression] Unwrapped BridgedInstance to get native Future.");
    }

    if (futureValue is Future) {
      Logger.debug(
          "[SAwaitExpression] Expression evaluated to a Future. Returning AsyncSuspensionRequest.");
      final future = futureValue as Future<Object?>;

      // CRUCIAL: Return the suspension request with the future and the current state.
      // The async state machine will use this information.
      // Note: currentAsyncState cannot be null here because of the previous check.
      return AsyncSuspensionRequest(future, currentAsyncState!);
    } else {
      // The argument to 'await' MUST be a Future.
      throw RuntimeD4rtException(
          "The argument to 'await' must be a Future, but received type: ${expressionValue?.runtimeType}");
    }
  }

  // =======================================================================
  // Pattern Matching Helper
  // =======================================================================

  /// Attempts to match the [pattern] against the [value].
  /// If successful, binds any variables declared in the pattern within the [environment].
  /// Throws [PatternMatchD4rtException] on failure.
  void _matchAndBind(SAstNode pattern, Object? value, Environment environment) {
    Logger.debug(
        "[_matchAndBind] Matching pattern ${pattern.runtimeType} against value ${value?.runtimeType}");

    if (pattern is SDeclaredVariablePattern) {
      // Handles: var x, final T x, int x
      final name = pattern.name;
      if (name == '_') {
        // Wildcard name in declaration: match succeeds, no binding
        Logger.debug("[_matchAndBind] Wildcard (declared) match success.");
        return;
      }
      environment.define(name, value);
      Logger.debug("[_matchAndBind] Bound variable '$name' = $value");
    } else if (pattern is SWildcardPattern) {
      // Handles: _ when used as a standalone sub-pattern
      Logger.debug("[_matchAndBind] Wildcard (sub-pattern) match success.");
      return; // Match succeeds, no binding
    } else if (pattern is SAssignedVariablePattern) {
      // Handles assignment patterns like: (a, _) = record;
      final name = pattern.name;
      if (name == '_') {
        // Wildcard name in assignment: match succeeds, no binding
        Logger.debug("[_matchAndBind] Wildcard (assigned) match success.");
        return;
      }
      try {
        environment.assign(name, value);
        Logger.debug("[_matchAndBind] Assigned variable '$name' = $value");
      } on RuntimeD4rtException catch (e) {
        // Convert assignment errors (e.g., variable not defined) to PatternMatchException
        throw PatternMatchD4rtException(
            "Failed to assign pattern variable '$name': ${e.message}");
      }
    } else if (pattern is SConstantPattern) {
      // Handles: case 1:, case "abc":, case MyClass.constant:
      // Evaluate the constant expression within the pattern
      final patternValue = pattern.expression.accept<Object?>(this);
      // Compare the switch value against the evaluated pattern constant
      // Use simple equality check for now.
      if (value != patternValue) {
        throw PatternMatchD4rtException(
            "Constant pattern value $patternValue does not match switch value $value");
      }
      Logger.debug(
          "[_matchAndBind] Constant pattern matched: $value == $patternValue");
      // No binding needed for constant patterns
    } else if (pattern is SListPattern) {
      // Handles: [p1, p2, ...], including rest elements like [p1, ...rest]
      if (value is! List) {
        throw PatternMatchD4rtException(
            "Expected a List, but got ${value?.runtimeType}");
      }

      // Check if there's a rest element and handle accordingly
      final restElementIndex =
          pattern.elements.indexWhere((e) => e is SRestPatternElement);

      if (restElementIndex == -1) {
        // No rest element: exact length match required
        if (pattern.elements.length != value.length) {
          throw PatternMatchD4rtException(
              "List pattern expected ${pattern.elements.length} elements, but List has ${value.length}.");
        }

        // Match subpatterns recursively
        for (int i = 0; i < pattern.elements.length; i++) {
          final element = pattern.elements[i];
          final subValue = value[i];

          // Extract the actual pattern from the element wrapper
          Logger.debug(
              "[_matchAndBind]   Matching list element $i: ${element.runtimeType} against ${subValue?.runtimeType}");
          _matchAndBind(element, subValue, environment);
        }
      } else {
        // Has rest element: more complex matching
        final SRestPatternElement restElement =
            pattern.elements[restElementIndex] as SRestPatternElement;
        final beforeRestCount = restElementIndex;
        final afterRestCount = pattern.elements.length - restElementIndex - 1;
        final minRequiredLength = beforeRestCount + afterRestCount;

        if (value.length < minRequiredLength) {
          throw PatternMatchD4rtException(
              "List pattern expected at least $minRequiredLength elements, but List has ${value.length}.");
        }

        // Match elements before rest
        for (int i = 0; i < beforeRestCount; i++) {
          final element = pattern.elements[i];
          final subValue = value[i];

          Logger.debug(
              "[_matchAndBind]   Matching list element $i (before rest): ${element.runtimeType} against ${subValue?.runtimeType}");
          _matchAndBind(element, subValue, environment);
        }

        // Handle rest element
        final restStartIndex = beforeRestCount;
        final restEndIndex = value.length - afterRestCount;
        final restValues = value.sublist(restStartIndex, restEndIndex);

        if (restElement.pattern != null) {
          // Rest element has a pattern (e.g., ...rest), bind the sublist
          Logger.debug(
              "[_matchAndBind]   Matching rest element: ${restElement.pattern!.runtimeType} against List of ${restValues.length} elements");
          _matchAndBind(restElement.pattern!, restValues, environment);
        }
        // If restElement.pattern is null, it's just "..." (anonymous rest), no binding needed

        // Match elements after rest
        for (int i = 0; i < afterRestCount; i++) {
          final patternIndex = restElementIndex + 1 + i;
          final valueIndex = value.length - afterRestCount + i;
          final element = pattern.elements[patternIndex];
          final subValue = value[valueIndex];

          Logger.debug(
              "[_matchAndBind]   Matching list element $valueIndex (after rest): ${element.runtimeType} against ${subValue?.runtimeType}");
          _matchAndBind(element, subValue, environment);
        }
      }
      Logger.debug("[_matchAndBind] List pattern matched successfully.");
    } else if (pattern is SMapPattern) {
      // Handles: {'key': p1, 'key2': p2, ...}, including rest elements like {'key': p1, ...rest}
      if (value is! Map) {
        throw PatternMatchD4rtException(
            "Expected a Map, but got ${value?.runtimeType}");
      }

      final Set<Object?> matchedKeys = {};

      // Match regular entries first
      for (int i = 0; i < pattern.elements.length; i++) {
        final element = pattern.elements[i];

        // ignore: unnecessary_type_check
        if (element is SMapPatternEntry) {
          final keyPatternExpr = element.key;
          final valuePattern = element.value;

          final keyToLookup = keyPatternExpr.accept<Object?>(this);

          if (!value.containsKey(keyToLookup)) {
            throw PatternMatchD4rtException(
                "Map pattern key '$keyToLookup' not found in the map.");
          }

          final subValue = value[keyToLookup];
          Logger.debug(
              "[_matchAndBind]   Matching map entry '$keyToLookup': ${valuePattern.runtimeType} against ${subValue?.runtimeType}");
          _matchAndBind(valuePattern, subValue, environment);
          matchedKeys.add(keyToLookup);
        } else if (element is SRestPatternElement) {
          // Handle rest element
          // Note: elements is List<SMapPatternEntry>, so promotion doesn't
          // work for SRestPatternElement. Use explicit cast.
          final restElem = element as SRestPatternElement;
          final remainingEntries = <Object?, Object?>{};
          for (final entry in value.entries) {
            if (!matchedKeys.contains(entry.key)) {
              remainingEntries[entry.key] = entry.value;
            }
          }

          if (restElem.pattern != null) {
            // Rest element has a pattern (e.g., ...rest), bind the remaining map
            Logger.debug(
                "[_matchAndBind]   Matching rest element: ${restElem.pattern!.runtimeType} against Map of ${remainingEntries.length} entries");
            _matchAndBind(restElem.pattern!, remainingEntries, environment);
          }
          // If element.pattern is null, it's just "..." (anonymous rest), no binding needed
        } else {
          throw StateD4rtException(
              "Unexpected MapPatternElement type: ${element.runtimeType}");
        }
      }

      Logger.debug("[_matchAndBind] Map pattern matched successfully.");
    } else if (pattern is SRecordPattern) {
      Logger.debug(
          '[_matchAndBind] Matching pattern ${pattern.runtimeType} against value ${value.runtimeType}');
      if (value is! InterpretedRecord) {
        Logger.debug(
            'DEBUG [_matchAndBind] Mismatch: Value is not an InterpretedRecord.');
        // Failure case handled by throwing or returning normally if not exhaustive
        // Depending on context (declaration vs refutable)
        // For now, let's assume declaration context (must match or throw)
        throw PatternMatchD4rtException(
            'Expected a Record, but got ${value?.runtimeType}'); // Corrected message
      }

      final positionalPatternFields = pattern.fields
          .cast<SPatternField>()
          .where((f) => f.name == null)
          .toList();
      final namedPatternFieldsNodes = pattern.fields
          .cast<SPatternField>()
          .where((f) => f.name != null)
          .toList();

      Logger.debug(
          '[_matchAndBind]   Pattern positional fields count: ${positionalPatternFields.length}');
      Logger.debug(
          '[_matchAndBind]   Value positional fields count: ${value.positionalFields.length}');
      Logger.debug(
          '[_matchAndBind]   Pattern named fields count: ${namedPatternFieldsNodes.length}');
      Logger.debug(
          '[_matchAndBind]   Value named fields count: ${value.namedFields.length}');

      // Check positional fields count FIRST
      if (positionalPatternFields.length > value.positionalFields.length) {
        // Adjusted error message to match test expectation
        throw RuntimeD4rtException(
            'Pattern match failed: Record pattern expected at least ${positionalPatternFields.length} positional fields, but Record only has ${value.positionalFields.length}.');
      }

      // Match positional fields
      for (int i = 0; i < positionalPatternFields.length; i++) {
        final fieldPatternNode = positionalPatternFields[i];
        final fieldValue = value.positionalFields[i];
        Logger.debug(
            'DEBUG [_matchAndBind]   Matching record positional field $i: ${fieldPatternNode.runtimeType} against ${fieldValue?.runtimeType ?? 'null'}');

        // Assume fieldPatternNode IS a RecordPatternField because it came from pattern.fields
        // We need the actual pattern nested within the field.
        // Directly access .pattern assuming the node type is correct (dynamic access if needed)
        final fieldPattern = (fieldPatternNode as dynamic).pattern;

        // Recursive call, rely on exceptions for failure
        _matchAndBind(fieldPattern, fieldValue, environment);
        Logger.debug(
            'DEBUG [_matchAndBind]     Positional field $i match success.');
      }

      // Match named fields
      for (final fieldNode in namedPatternFieldsNodes) {
        // We know fieldNode has name != null here
        // fieldNode is SPatternField from the cast above

        // Use the corrected access path
        // For shorthand syntax (:name), field name comes from the pattern itself
        String? fieldName = fieldNode.name?.name;
        if (fieldName == null) {
          // Shorthand syntax: (:name) - name comes from the pattern
          final fieldSubPattern = fieldNode.pattern;
          if (fieldSubPattern is SDeclaredVariablePattern) {
            fieldName = fieldSubPattern.name;
          }
        }
        if (fieldName == null) {
          // This case implies we couldn't determine the field name from either source
          throw StateD4rtException(
              'Internal error: Named field detected but name lexeme is null.');
        }

        Logger.debug(
            'DEBUG [_matchAndBind]   Matching record named field \'$fieldName\': ${fieldNode.pattern.runtimeType} against value type ${value.namedFields[fieldName]?.runtimeType ?? 'null'}');

        if (!value.namedFields.containsKey(fieldName)) {
          throw PatternMatchD4rtException(
              'Record pattern named field \'$fieldName\' not found in the record.');
        }
        final fieldValue = value.namedFields[fieldName];

        // Recursive match on the pattern inside the field
        _matchAndBind(fieldNode.pattern, fieldValue, environment);
        Logger.debug(
            'DEBUG [_matchAndBind]     Named field \'$fieldName\' match success.');
      }

      Logger.debug('[_matchAndBind] Record pattern matched successfully.');
      // Success: function completes normally
    } else if (pattern is SObjectPattern) {
      // Handles: ClassName(field1: pattern1, field2: pattern2)
      final objTypeName = pattern.type.name!.name;
      Logger.debug(
          '[_matchAndBind] Matching object pattern $objTypeName against value ${value?.runtimeType}');

      // Get the expected type name
      final expectedTypeName = objTypeName;

      // Check if the value is of the expected type
      bool typeMatches = false;
      String actualTypeName = value?.runtimeType.toString() ?? 'null';

      // Handle InterpretedInstance specially - check class hierarchy
      if (value is InterpretedInstance) {
        // Check if the instance's class or any of its supertypes match the expected type
        if (value.klass.name == expectedTypeName) {
          typeMatches = true;
        } else {
          // Check superclass chain
          InterpretedClass? current = value.klass.superclass;
          while (current != null && !typeMatches) {
            if (current.name == expectedTypeName) {
              typeMatches = true;
            }
            current = current.superclass;
          }
          // Check interfaces
          if (!typeMatches) {
            for (final interface in value.klass.interfaces) {
              if (interface.name == expectedTypeName) {
                typeMatches = true;
                break;
              }
            }
          }
          // Check mixins
          if (!typeMatches) {
            for (final mixin in value.klass.mixins) {
              if (mixin.name == expectedTypeName) {
                typeMatches = true;
                break;
              }
            }
          }
        }
        actualTypeName = value.klass.name;
      } else if (expectedTypeName == 'int' && value is int) {
        typeMatches = true;
      } else if (expectedTypeName == 'double' && value is double) {
        typeMatches = true;
      } else if (expectedTypeName == 'num' && value is num) {
        typeMatches = true;
      } else if (expectedTypeName == 'String' && value is String) {
        typeMatches = true;
      } else if (expectedTypeName == 'bool' && value is bool) {
        typeMatches = true;
      } else if (expectedTypeName == 'List' && value is List) {
        typeMatches = true;
      } else if (expectedTypeName == 'Map' && value is Map) {
        typeMatches = true;
      } else if (expectedTypeName == 'Set' && value is Set) {
        typeMatches = true;
      } else if (value != null && actualTypeName.endsWith(expectedTypeName)) {
        // Basic heuristic: if the actual type name ends with expected type name
        typeMatches = true;
      } else {
        // Check if the value has an interpreted class that matches
        try {
          final expectedType = environment.get(expectedTypeName);
          if (expectedType is RuntimeType) {
            typeMatches = true;
          }
        } catch (e) {
          // Type not found in environment
        }
      }

      if (!typeMatches) {
        throw PatternMatchD4rtException(
            "Object pattern expected type '$expectedTypeName', but got '$actualTypeName'");
      }

      // Match each field pattern
      for (final field in pattern.fields) {
        final pf = field;
        final fieldName = pf.name;
        final fieldPattern = pf.pattern;

        // Get the field name string - handle shorthand syntax (:fieldName)
        String fieldNameStr;
        if (fieldName != null && fieldName.name != null) {
          fieldNameStr = fieldName.name!;
        } else if (fieldPattern is SDeclaredVariablePattern) {
          // Shorthand syntax: (:fieldName) means field name is the variable name
          fieldNameStr = fieldPattern.name;
        } else {
          throw PatternMatchD4rtException(
              "Object pattern field name could not be determined");
        }

        // Extract the field value from the object
        Object? fieldValue;

        if (value is InterpretedInstance) {
          // Use InterpretedInstance.get() to access fields/getters
          try {
            fieldValue = value.get(fieldNameStr, visitor: this);
          } catch (e) {
            throw PatternMatchD4rtException(
                "Object pattern field '$fieldNameStr' not found on '${value.klass.name}': $e");
          }
        } else if (value is Map && value.containsKey(fieldNameStr)) {
          fieldValue = value[fieldNameStr];
        } else {
          throw PatternMatchD4rtException(
              "Object pattern field access '$fieldNameStr' is not supported for type '${value?.runtimeType}'");
        }

        Logger.debug(
            "[_matchAndBind]   Matching object field '$fieldNameStr': ${fieldPattern.runtimeType} against ${fieldValue?.runtimeType}");
        _matchAndBind(fieldPattern, fieldValue, environment);
      }

      Logger.debug("[_matchAndBind] Object pattern matched successfully.");
    } else if (pattern is SRelationalPattern) {
      // G-DOV-3/4 FIX: Handle relational patterns (>= x, <= x, > x, < x, == x, != x)
      final operand = pattern.operand.accept<Object?>(this);
      final operator = pattern.operator;
      Logger.debug(
          "[_matchAndBind] SRelationalPattern: comparing $value $operator $operand");
      bool matches = false;
      if (value is Comparable && operand is Comparable) {
        final cmp = value.compareTo(operand);
        switch (operator) {
          case '<':
            matches = cmp < 0;
          case '<=':
            matches = cmp <= 0;
          case '>':
            matches = cmp > 0;
          case '>=':
            matches = cmp >= 0;
          case '==':
            matches = value == operand;
          case '!=':
            matches = value != operand;
          default:
            throw UnimplementedD4rtException(
                "Relational pattern operator not supported: $operator");
        }
      } else if (operator == '==') {
        matches = value == operand;
      } else if (operator == '!=') {
        matches = value != operand;
      } else {
        throw PatternMatchD4rtException(
            "Cannot compare $value ($operator) with $operand - not both Comparable");
      }
      if (!matches) {
        throw PatternMatchD4rtException(
            "Relational pattern $operator $operand did not match value $value");
      }
    } else if (pattern is SLogicalOrPattern) {
      // Lim-8, Bug-13, Bug-68 FIX: Handle Logical OR patterns (pattern1 || pattern2)
      // Try matching the left operand first, if that fails, try the right operand
      Logger.debug(
          "[_matchAndBind] SLogicalOrPattern: trying left operand ${pattern.leftOperand.runtimeType}");
      try {
        _matchAndBind(pattern.leftOperand, value, environment);
        Logger.debug("[_matchAndBind] SLogicalOrPattern: left operand matched");
        return; // Left matched, done
      } on PatternMatchD4rtException {
        // Left didn't match, try right
        Logger.debug(
            "[_matchAndBind] SLogicalOrPattern: left failed, trying right operand ${pattern.rightOperand.runtimeType}");
        _matchAndBind(pattern.rightOperand, value, environment);
        Logger.debug(
            "[_matchAndBind] SLogicalOrPattern: right operand matched");
        // If right also throws, the exception propagates up
      }
    } else if (pattern is SLogicalAndPattern) {
      // G-DOV-3/4 FIX: Handle Logical AND patterns (pattern1 && pattern2)
      // Both operands must match for the pattern to match
      Logger.debug(
          "[_matchAndBind] SLogicalAndPattern: trying left operand ${pattern.leftOperand.runtimeType}");
      _matchAndBind(pattern.leftOperand, value, environment);
      Logger.debug(
          "[_matchAndBind] SLogicalAndPattern: left matched, trying right operand ${pattern.rightOperand.runtimeType}");
      _matchAndBind(pattern.rightOperand, value, environment);
      Logger.debug("[_matchAndBind] SLogicalAndPattern: both operands matched");
    } else if (pattern is SCastPattern) {
      // G-DOV2-5 FIX: Handle cast patterns (var x as Type)
      // The cast pattern matches if the value can be cast to the specified type,
      // then binds the casted value to the sub-pattern
      final targetType = pattern.type;
      Logger.debug(
          "[_matchAndBind] SCastPattern: casting value to ${targetType.toString()}");

      // Try to perform the cast - reuse visitAsExpression logic
      // Create a synthetic SAsExpression node to evaluate the cast
      bool castSucceeds = false;
      if (targetType is SNamedType) {
        final typeName = targetType.name!.name;
        final isNullable = targetType.isNullable;

        // Check if the cast would succeed
        if (isNullable && value == null) {
          castSucceeds = true;
        } else {
          switch (typeName) {
            case 'int':
              castSucceeds = value is int;
            case 'double':
              castSucceeds = value is double;
            case 'num':
              castSucceeds = value is num;
            case 'String':
              castSucceeds = value is String;
            case 'bool':
              castSucceeds = value is bool;
            case 'List':
              castSucceeds = value is List;
            case 'Map':
              castSucceeds = value is Map;
            case 'Set':
              castSucceeds = value is Set;
            case 'Object':
              castSucceeds = value != null || isNullable;
            case 'dynamic':
              castSucceeds = true;
            default:
              // For custom types, be permissive
              castSucceeds = true;
          }
        }
      } else {
        // For complex type annotations, be permissive
        castSucceeds = true;
      }

      if (!castSucceeds) {
        throw PatternMatchD4rtException(
            "Cast pattern failed: value ${value?.runtimeType} cannot be cast to ${targetType.toString()}");
      }

      // Cast succeeded, now match the sub-pattern
      _matchAndBind(pattern.pattern, value, environment);
      Logger.debug("[_matchAndBind] SCastPattern: matched successfully");
    } else {
      throw UnimplementedD4rtException(
          "Pattern type not yet supported in _matchAndBind: ${pattern.runtimeType}");
    }
  }

  @override
  Object? visitRecordLiteral(SRecordLiteral node) {
    final positional = <Object?>[];
    final named = <String, Object?>{};

    for (final field in node.fields) {
      if (field is SNamedExpression) {
        final name = field.name!.label!.name;
        final value = field.expression!.accept<Object?>(this);
        if (named.containsKey(name)) {
          throw RuntimeD4rtException(
              "Record literal field '$name' specified more than once.");
        }
        named[name] = value;
      } else {
        // Positional field: expression
        if (named.isNotEmpty) {
          // As per Dart spec, positional fields must come before named fields
          throw RuntimeD4rtException(
              "Positional fields must come before named fields in record literal.");
        }
        positional.add(field.accept<Object?>(this));
      }
    }
    Logger.debug("[visitRecordLiteral] Created record: ($positional, $named)");
    return InterpretedRecord(positional, named);
  }

  @override
  Object? visitPatternAssignment(SPatternAssignment node) {
    // 1. Evaluate the right-hand side expression
    final rhsValue = node.expression.accept<Object?>(this);

    // 2. Match the pattern against the value and bind variables
    try {
      _matchAndBind(node.pattern, rhsValue, environment);
    } on PatternMatchD4rtException catch (e) {
      // Convert pattern match failures into standard RuntimeErrors for assignment expressions
      throw RuntimeD4rtException("Pattern assignment failed: ${e.message}");
    } catch (e) {
      // Catch other potential errors during binding
      throw RuntimeD4rtException("Error during pattern assignment: $e");
    }

    // 3. Pattern assignment expression evaluates to the RHS value
    return rhsValue;
  }

  @override
  Object? visitSwitchExpression(SSwitchExpression node) {
    final switchValue = node.expression.accept<Object?>(this);
    final originalEnvironment = environment; // Backup current environment

    for (final caseExpr in node.cases) {
      final switchCase = caseExpr;
      final switchGp = switchCase.guardedPattern;
      final pattern = switchGp.pattern;
      final guard = switchGp.whenClause?.expression;
      final body = switchCase.expression;

      // Create a temporary environment for this case's pattern variables
      // Enclose the *original* environment where the switch expression is evaluated
      final caseEnvironment = Environment(enclosing: originalEnvironment);

      try {
        // Attempt to match and bind variables in the temporary environment
        _matchAndBind(pattern, switchValue, caseEnvironment);
        Logger.debug(
            "[SwitchExpr] Pattern ${pattern.runtimeType} matched value ${switchValue?.runtimeType}");

        // Pattern matched, now check the guard (if it exists)
        bool guardPassed = true;
        if (guard != null) {
          final previousVisitorEnv = environment; // Backup
          try {
            environment = caseEnvironment; // Evaluate guard in case scope
            final guardResult = guard.accept<Object?>(this);
            if (guardResult is! bool) {
              throw RuntimeD4rtException(
                  "Switch expression 'when' clause must evaluate to a boolean.");
            }
            guardPassed = guardResult;
            Logger.debug("[SwitchExpr] Guard evaluated to: $guardPassed");
          } finally {
            environment = previousVisitorEnv; // Restore
          }
        }

        // If guard passed (or no guard), evaluate and return the body result
        if (guardPassed) {
          Logger.debug("[SwitchExpr] Guard passed or absent. Evaluating body.");

          final previousVisitorEnv = environment; // Backup
          try {
            environment = caseEnvironment; // Evaluate body in case scope
            final result = body.accept<Object?>(this);
            Logger.debug("[SwitchExpr] Body evaluated to: $result. Returning.");
            return result; // Return the result of the matching case's body
          } finally {
            environment = previousVisitorEnv; // Restore
          }
        }
      } on PatternMatchD4rtException catch (e) {
        // Pattern didn't match, try the next case
        Logger.debug(
            "[SwitchExpr] Pattern ${pattern.runtimeType} did not match: ${e.message}. Trying next case.");
        continue;
      }
      // If we reach here, it means the pattern matched but the guard failed.
      Logger.debug(
          "[SwitchExpr] Pattern matched but guard failed. Trying next case.");
    } // End of loop through cases

    // If no case matched and returned a value
    throw RuntimeD4rtException(
        "Switch expression was not exhaustive for value: $switchValue (${switchValue?.runtimeType})");
  }

  @override
  Object? visitExtensionDeclaration(SExtensionDeclaration node) {
    final extensionName = node.name?.name;
    Logger.debug(
        "[visitExtensionDeclaration] Declaring extension: ${extensionName ?? '<unnamed>'}");

    // 1. Resolve the 'on' type
    final onTypeNode = node.extendedType;
    if (onTypeNode == null) {
      // This might happen for extension types, which are different.
      // For now, assume classic extensions always have an 'on' clause.
      Logger.warn(
          "[visitExtensionDeclaration] Extension '${extensionName ?? '<unnamed>'}' has no 'on' clause, skipping.");
      return null;
    }

    // Resolve the type name from the AST node
    String onTypeName;
    bool isOnNullableType = false; // G-DOV-10/11: Track nullable on-type
    if (onTypeNode is SNamedType) {
      onTypeName = onTypeNode.name!.name;
      isOnNullableType = onTypeNode.isNullable; // Check for 'T?' syntax
    } else {
      Logger.warn(
          "[visitExtensionDeclaration] Unsupported 'on' type node for resolution: ${onTypeNode.runtimeType}. Skipping extension.");
      return null;
    }

    // Look up the RuntimeType in the environment
    RuntimeType onRuntimeType;
    try {
      final typeValue = environment.get(onTypeName);

      // Handle Resolution of Native/Bridged Types
      if (typeValue is RuntimeType) {
        // Standard case: Found an InterpretedClass/Mixin or existing BridgedClass
        onRuntimeType = typeValue;
        Logger.debug(
            "[visitExtensionDeclaration] Resolved 'on' type '$onTypeName' to RuntimeType: ${onRuntimeType.name}");
      } else if (typeValue is NativeFunction) {
        // Heuristic: If environment.get returns a NativeFunction for a common type name,
        // assume it represents the native type and find/create a corresponding BridgedClass.
        // This relies on the global environment being populated correctly with type bridges.
        BridgedClass? bridgedType = _getBridgedClassForNativeType(onTypeName);
        if (bridgedType != null) {
          onRuntimeType = bridgedType;
          Logger.debug(
              "[visitExtensionDeclaration] Resolved native 'on' type '$onTypeName' to BridgedClass: ${onRuntimeType.name}");
        } else {
          // We found something, but couldn't map it to a known bridged type
          throw RuntimeD4rtException(
              "Symbol '$onTypeName' resolved to NativeFunction but could not map to a known BridgedClass.");
        }
      } else {
        // Resolved to something unexpected (e.g., an instance, null, etc.)
        throw RuntimeD4rtException(
            "Symbol '$onTypeName' resolved to non-type: ${typeValue?.runtimeType}");
      }
    } on RuntimeD4rtException catch (e) {
      // Check if the error is specifically "Undefined variable"which means the type wasn't found at all.
      if (e.message.contains("Undefined variable: $onTypeName")) {
        // Special handling for core types that might not be explicitly defined if stdlib wasn't fully loaded?
        // Or maybe they are always NativeFunctions?
        BridgedClass? coreBridgedType =
            _getBridgedClassForNativeType(onTypeName);
        if (coreBridgedType != null) {
          onRuntimeType = coreBridgedType;
          Logger.debug(
              "[visitExtensionDeclaration] Resolved unfound core 'on' type '$onTypeName' to BridgedClass: ${onRuntimeType.name}");
        } else {
          // Type genuinely not found or not a recognized core type
          throw RuntimeD4rtException(
              "Could not resolve 'on' type '$onTypeName' for extension '${extensionName ?? '<unnamed>'}': Type not found or not a recognized core type.");
        }
      } else {
        // Propagate other RuntimeErrors (like the non-type error from above)
        throw RuntimeD4rtException(
            "Could not resolve 'on' type '$onTypeName' for extension '${extensionName ?? '<unnamed>'}': ${e.message}");
      }
    }

    // 2. Process members (methods, getters, setters, operators) - both instance and static
    final members = <String, Callable>{};
    final staticMethods = <String, Callable>{};
    final staticGetters = <String, Callable>{};
    final staticSetters = <String, Callable>{};
    final staticFields = <String, Object?>{};

    for (final member in node.members) {
      if (member is SMethodDeclaration) {
        final methodName =
            member.name!.name; // Operator names like '+', '[]' are also lexemes

        if (member.isStatic) {
          // Handle static methods, getters, and setters
          final function =
              InterpretedFunction.method(member, environment, null);

          if (member.isGetter) {
            staticGetters[methodName] = function;
            Logger.debug(
                "[visitExtensionDeclaration]   Added static getter: $methodName");
          } else if (member.isSetter) {
            staticSetters[methodName] = function;
            Logger.debug(
                "[visitExtensionDeclaration]   Added static setter: $methodName");
          } else {
            staticMethods[methodName] = function;
            Logger.debug(
                "[visitExtensionDeclaration]   Added static method: $methodName");
          }
        } else {
          // Create InterpretedExtensionMethod for instance method-like declarations
          final function =
              InterpretedExtensionMethod(member, environment, onRuntimeType);
          members[methodName] = function;
          String memberType = "method";
          if (member.isGetter) memberType = "getter";
          if (member.isSetter) memberType = "setter";
          if (member.isOperator) memberType = "operator";
          Logger.debug(
              "[visitExtensionDeclaration]   Added extension $memberType: $methodName");
        }
      } else if (member is SFieldDeclaration) {
        // Only static fields are allowed in extensions.
        if (!member.isStatic) {
          Logger.warn(
              "[visitExtensionDeclaration] Instance fields are not allowed in extensions. Skipping field '$member'.");
          continue; // Skip instance fields
        }
        // Handle static fields - store in the InterpretedExtension object
        for (final variable in member.fields!.variables) {
          final fieldName = variable.name!.name;
          Object? value;
          if (variable.initializer != null) {
            // Evaluate static initializer immediately in the current environment
            try {
              value = variable.initializer!.accept<Object?>(this);
            } catch (e) {
              throw RuntimeD4rtException(
                  "Error evaluating static initializer for extension field '$fieldName': $e");
            }
          }
          // Store in staticFields map instead of environment
          staticFields[fieldName] = value;
          Logger.debug(
              "[visitExtensionDeclaration]   Stored static field: $fieldName");
        }
      } else {
        Logger.warn(
            "[visitExtensionDeclaration] Unsupported extension member type: ${member.runtimeType}. Skipping.");
      }
    }

    // 3. Create and store the InterpretedExtension
    final interpretedExtension = InterpretedExtension(
      name: extensionName,
      onType: onRuntimeType,
      isOnNullableType: isOnNullableType, // G-DOV-10/11: Pass nullable flag
      members: members,
      staticMethods: staticMethods,
      staticGetters: staticGetters,
      staticSetters: staticSetters,
      staticFields: staticFields,
    );

    // How to store it? In the environment associated with its name?
    // Or in a separate list in the environment?
    // Let's try defining it by name if it has one, otherwise maybe a special list.
    if (extensionName != null) {
      environment.define(extensionName, interpretedExtension);
      Logger.debug(
          "[visitExtensionDeclaration] Defined named extension '$extensionName' in environment.");
    } else {
      // Store unnamed extensions in a special list in the environment
      environment.addUnnamedExtension(interpretedExtension);
      Logger.debug(
          "[visitExtensionDeclaration] Added unnamed extension to environment list.");
    }

    return null; // Declarations typically return null
  }

  /// Lim-1 FIX: Handle extension type declarations (Dart 3.3+)
  @override
  Object? visitExtensionTypeDeclaration(SExtensionTypeDeclaration node) {
    final typeName = node.name!.name;
    Logger.debug(
        "[visitExtensionTypeDeclaration] Declaring extension type: $typeName");

    // Get the representation field name and type
    final representation = node.representation;
    final representationFieldName = representation.fieldName;
    final representationTypeNode = representation.fieldType;

    Logger.debug(
        "[visitExtensionTypeDeclaration] Representation field: $representationFieldName, type: ${representationTypeNode.toString()}");

    // Resolve the representation type
    RuntimeType? representationType;
    if (representationTypeNode is SNamedType) {
      final representationTypeName = representationTypeNode.name!.name;
      try {
        final typeValue = environment.get(representationTypeName);
        if (typeValue is RuntimeType) {
          representationType = typeValue;
        }
      } catch (e) {
        // Type not found, leave as null
        Logger.debug(
            "[visitExtensionTypeDeclaration] Could not resolve representation type: $e");
      }
    }

    // Collect getters and methods from members
    final getters = <String, InterpretedFunction>{};
    final methods = <String, InterpretedFunction>{};

    // G-DOV3-1 FIX: Create the extension type first so we can pass it as owner
    // to the methods/getters (needed for bind() to work)
    final extensionType = InterpretedExtensionType(
      typeName,
      representationFieldName,
      representationType,
      environment,
      getters, // Will be populated below
      methods, // Will be populated below
    );

    // Define it in the environment early so methods can reference the type
    environment.define(typeName, extensionType);

    for (final member in node.members) {
      if (member is SMethodDeclaration) {
        final methodName = member.name!.name;
        final isGetter = member.isGetter;
        final isSetter = member.isSetter;
        final isStatic = member.isStatic;

        if (isStatic) {
          // Skip static members for now
          continue;
        }

        // Create the interpreted function using the method constructor
        // G-DOV3-1 FIX: Pass extension type as owner so bind() works
        final interpretedMethod =
            InterpretedFunction.method(member, environment, extensionType);

        if (isGetter) {
          getters[methodName] = interpretedMethod;
          Logger.debug(
              "[visitExtensionTypeDeclaration]   Added getter: $methodName");
        } else if (!isSetter) {
          methods[methodName] = interpretedMethod;
          Logger.debug(
              "[visitExtensionTypeDeclaration]   Added method: $methodName");
        }
      }
    }

    Logger.debug(
        "[visitExtensionTypeDeclaration] Defined extension type '$typeName' in environment.");

    return null;
  }

  BridgedClass? _getBridgedClassForNativeType(String typeName) {
    // This function maps core Dart type names (as strings) to their
    // corresponding BridgedClass representations used by the interpreter.
    // This relies on these BridgedClass instances being available (e.g., created during stdlib setup).
    // We get them from the global environment.
    Object? typeValue;
    try {
      // Use globalEnvironment which should have stdlib types defined.
      typeValue = globalEnvironment.get(typeName);
    } on RuntimeD4rtException {
      // Type not found in global environment
      Logger.warn(
          "[_getBridgedClassForNativeType] Type '$typeName' not found in global environment.");
      return null;
    }

    if (typeValue is BridgedClass) {
      // Successfully found the corresponding BridgedClass
      return typeValue;
    } else {
      // Found the name, but it wasn't a BridgedClass (e.g., maybe the NativeFunction constructor)
      Logger.warn(
          "[_getBridgedClassForNativeType] Symbol '$typeName' found in global env but is not a BridgedClass (type: ${typeValue?.runtimeType}).");
      // Special case: Maybe it maps to a fundamental type like Object?
      if (typeName == 'dynamic') {
        try {
          final objectType = globalEnvironment.get('Object');
          if (objectType is BridgedClass) return objectType;
          // ignore: empty_catches
        } on RuntimeD4rtException {}
      }
      return null;
    }
  }

  @override
  Object? visitSuperConstructorInvocation(SSuperConstructorInvocation node) {
    // 1. Retrieve the 'this' instance currently being created.
    InterpretedInstance? thisInstance;
    try {
      final thisValue = environment.get('this');
      if (thisValue is InterpretedInstance) {
        thisInstance = thisValue;
      } else {
        throw RuntimeD4rtException(
            "Internal error: 'this' is not an InterpretedInstance during super constructor call.");
      }
    } on RuntimeD4rtException {
      throw RuntimeD4rtException(
          "Internal error: Could not find 'this' during super constructor call.");
    }

    // 2. Check that the class has a bridged superclass.
    final currentClass = thisInstance.klass;
    final bridgedSuper = currentClass.bridgedSuperclass;
    if (bridgedSuper == null) {
      // If the superclass is interpreted, this call should be handled differently
      // (standard inherited constructor call).
      // For now, assume that if we get here, it's because of a bridged superclass.
      throw RuntimeD4rtException(
          "Cannot call super() constructor: Class '${currentClass.name}' does not have a registered bridged superclass.");
    }

    // 3. Determine the name of the super constructor to call.
    final constructorName =
        node.constructorName?.name ?? ''; // '' for the default

    // 4. Find the constructor adapter for the bridged superclass.
    final constructorAdapter =
        bridgedSuper.findConstructorAdapter(constructorName);
    if (constructorAdapter == null) {
      throw RuntimeD4rtException(
          "Bridged superclass '${bridgedSuper.name}' has no constructor named '$constructorName'.");
    }

    // 5. Evaluate the arguments passed to super(...).
    final (positionalArgs, namedArgs) = _evaluateArguments(node.argumentList);

    // 6. Call the constructor adapter.
    Object? nativeSuperObject;
    try {
      nativeSuperObject = constructorAdapter(this, positionalArgs, namedArgs);
      if (nativeSuperObject == null) {
        throw RuntimeD4rtException(
            "Bridged super constructor adapter for '${bridgedSuper.name}.$constructorName' returned null.");
      }
    } catch (e, s) {
      Logger.error(
          "Native exception during super constructor call to '${bridgedSuper.name}.$constructorName': $e\n$s");
      throw RuntimeD4rtException(
          "Native error during super constructor call '$constructorName': $e");
    }

    // 7. Store the returned native object on the 'this' instance.
    thisInstance.bridgedSuperObject = nativeSuperObject;
    Logger.debug(
        "[SSuperConstructorInvocation] Stored native super object (${nativeSuperObject.runtimeType}) on instance of ${currentClass.name}.");

    return null; // The super() call itself doesn't return a value.
  }

  @override
  Object? visitImportDirective(SImportDirective node) {
    final importUriString = (node.uri as SSimpleStringLiteral?)?.value;
    if (importUriString == null) {
      Logger.warn(
          "[visitImportDirective] Import directive with null URI string.");
      return null; // Return null if the URI is null
    }

    Logger.debug(
        "[InterpreterVisitor.visitImportDirective] START processing import: $importUriString");

    Uri resolvedUri;
    final importUri = Uri.parse(importUriString);

    if (importUri.isScheme('dart') || importUri.isScheme('package')) {
      resolvedUri = importUri;
      Logger.debug(
          "[visitImportDirective] Using absolute/unresolvable URI: $resolvedUri");
    } else {
      final baseUri = moduleLoader.currentlibrary;

      if (baseUri != null) {
        Logger.debug(
            "[visitImportDirective] Attempting to resolve relative URI '$importUriString' relative to '$baseUri'");
        resolvedUri = baseUri.resolveUri(importUri);
        Logger.debug(
            "[visitImportDirective] Resolved relative URI: $resolvedUri");
      } else {
        throw RuntimeD4rtException(
            "Unable to resolve relative import '$importUriString': Base URI not defined in ModuleLoader. "
            "Either provide a basePath parameter or use absolute URIs.");
      }
    }

    final prefixIdentifier = node.prefix; // Get the prefix identifier
    final prefixName = prefixIdentifier?.name;

    // Extract the show/hide combinators from the import directive BEFORE loading
    Set<String>? showNames;
    Set<String>? hideNames;

    for (final combinator in node.combinators) {
      if (combinator is SShowCombinator) {
        showNames ??= {};
        showNames.addAll(combinator.shownNames.map((id) => id.name));
        Logger.debug(
            "[visitImportDirective] Combinator: show ${combinator.shownNames.map((id) => id.name).join(', ')}");
      } else if (combinator is SHideCombinator) {
        hideNames ??= {};
        hideNames.addAll(combinator.hiddenNames.map((id) => id.name));
        Logger.debug(
            "[visitImportDirective] Combinator: hide ${combinator.hiddenNames.map((id) => id.name).join(', ')}");
      }
    }

    Logger.debug(
        "[visitImportDirective] Loading module for resolved URI: $resolvedUri (prefix: $prefixName, show: $showNames, hide: $hideNames)");

    // Pass show/hide to loadModule so bridged content respects the filters
    LoadedModule loadedModule = moduleLoader.loadModule(resolvedUri,
        showNames: showNames, hideNames: hideNames);

    if (prefixName != null) {
      Logger.debug(
          "[visitImportDirective] Importation du module '${resolvedUri.toString()}' avec le préfixe '$prefixName'. Show: $showNames, Hide: $hideNames");

      Environment envForPrefix;
      if (showNames != null || hideNames != null) {
        // Apply show/hide to the exported environment of the loaded module BEFORE defining it for the prefix
        envForPrefix = loadedModule.exportedEnvironment
            .shallowCopyFiltered(showNames: showNames, hideNames: hideNames);
      } else {
        envForPrefix = loadedModule.exportedEnvironment;
      }
      environment.definePrefixedImport(prefixName, envForPrefix);
    } else {
      Logger.debug(
          "[visitImportDirective] Direct import of module '${resolvedUri.toString()}' into the current environment. Show: $showNames, Hide: $hideNames");
      // Apply show/hide directly during import into the current environment
      environment.importEnvironment(loadedModule.exportedEnvironment,
          show: showNames, hide: hideNames);
    }
    return null; // Import directives do not produce a value.
  }

  /// Helper method to create the appropriate operand for ++ and -- operators.
  /// For numeric types, returns 1 or -1 directly.
  /// For custom classes, attempts to create an instance with value 1 or -1.
  Object? _createIncrementOperand(Object? targetValue, bool isIncrement) {
    if (targetValue is! InterpretedInstance) {
      // For primitive types (num, int, double), return the literal value
      return isIncrement ? 1 : -1;
    }

    // For custom class instances, try to create an instance of the same class
    // with the value 1 or -1. This handles cases like CustomNumber(1).
    try {
      final klass = targetValue.klass;
      final operandValue = isIncrement ? 1 : -1;

      // Try to create an instance with the operand value
      final newInstance = klass.call(this, [operandValue], {});
      return newInstance;
    } catch (e) {
      // If we can't create an instance, fall back to the literal value
      // This allows the operator to handle the error appropriately
      return isIncrement ? 1 : -1;
    }
  }
} // End of InterpreterVisitor class

/// G-DOV2-2 FIX: A callable tear-off for named/factory constructors.
///
/// When a named constructor is accessed as a tear-off (e.g., `Settings.fromMap`
/// passed to `map()`), this class wraps the constructor to make it callable
/// with positional/named arguments as if it were a regular function.
class _NamedConstructorTearOff implements Callable {
  final InterpretedClass _klass;
  final InterpretedFunction _constructor;
  final String _constructorName;

  _NamedConstructorTearOff(
      this._klass, this._constructor, this._constructorName);

  @override
  int get arity => _constructor.arity;

  @override
  Object? call(InterpreterVisitor visitor, List<Object?> positionalArguments,
      [Map<String, Object?>? namedArguments,
      List<RuntimeType>? explicitTypeArguments]) {
    Logger.debug(
        "[_NamedConstructorTearOff] Invoking constructor '$_constructorName' on class '${_klass.name}'");

    final namedArgs = namedArguments ?? {};

    try {
      // Handle factory constructors differently from regular constructors
      if (_constructor.isFactory) {
        // Factory constructors create and return their own instance
        Logger.debug(
            "[_NamedConstructorTearOff] Calling factory constructor '$_constructorName'");
        final result = _constructor.call(
            visitor, positionalArguments, namedArgs, explicitTypeArguments);
        // Handle return from factory constructor
        if (result is InterpretedInstance) {
          return result;
        }
        return result;
      } else {
        // Regular constructors: create instance first, then call constructor
        Logger.debug(
            "[_NamedConstructorTearOff] Calling regular constructor '$_constructorName'");

        // Create and initialize the fields
        final instance =
            _klass.createAndInitializeInstance(visitor, explicitTypeArguments);
        // Bind 'this' and call the constructor logic
        final boundConstructor = _constructor.bind(instance);
        boundConstructor.call(
            visitor, positionalArguments, namedArgs, explicitTypeArguments);
        return instance;
      }
    } on ReturnException catch (e) {
      // Handle return exceptions (applies to both factory and regular constructors)
      return e.value;
    } on RuntimeD4rtException {
      rethrow;
    } catch (e) {
      throw RuntimeD4rtException(
          "Error during named constructor '$_constructorName' for class '${_klass.name}': $e");
    }
  }

  @override
  String toString() => '${_klass.name}.$_constructorName';
}
