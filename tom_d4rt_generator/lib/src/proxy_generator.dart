/// D4rt Proxy Class Generator
///
/// Generates proxy/adapter subclasses for abstract classes, enabling D4rt
/// scripts to provide callback implementations for abstract methods.
///
/// For example, given `abstract class CustomPainter`:
/// ```dart
/// class D4rtCustomPainter extends CustomPainter {
///   final void Function(Canvas, Size) onPaint;
///   final bool Function(CustomPainter) onShouldRepaint;
///   D4rtCustomPainter({required this.onPaint, required this.onShouldRepaint});
///   @override void paint(Canvas c, Size s) => onPaint(c, s);
///   @override bool shouldRepaint(CustomPainter p) => onShouldRepaint(p);
/// }
/// ```
library;

import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:path/path.dart' as p;

import 'bridge_config.dart';
import 'file_generators.dart' show ensureBDartExtension;

/// Information about a method that needs proxying.
class _AbstractMethodInfo {
  final String name;
  final String returnType;
  final List<_MethodParam> params;
  final bool isGetter;

  /// Whether this method is abstract (required callback) or overridable
  /// (optional callback with super fallback).
  final bool isAbstract;

  _AbstractMethodInfo({
    required this.name,
    required this.returnType,
    required this.params,
    this.isGetter = false,
    this.isAbstract = true,
  });

  /// The Function type signature for the callback parameter.
  String get callbackType {
    if (isGetter) {
      return '$returnType Function()';
    }
    final paramTypes = params
        .map((p) {
          if (p.isNamed) {
            return '${p.isRequired ? 'required ' : ''}${p.type} ${p.name}';
          }
          return p.type;
        })
        .join(', ');

    final hasNamed = params.any((p) => p.isNamed);
    final hasPositional = params.any((p) => !p.isNamed);

    if (hasNamed && hasPositional) {
      final positional = params.where((p) => !p.isNamed).map((p) => p.type);
      final named = params
          .where((p) => p.isNamed)
          .map((p) => '${p.isRequired ? 'required ' : ''}${p.type} ${p.name}');
      return '$returnType Function(${positional.join(', ')}, {${named.join(', ')}})';
    } else if (hasNamed) {
      return '$returnType Function({$paramTypes})';
    }
    return '$returnType Function($paramTypes)';
  }

  /// The callback parameter name (e.g., 'onPaint', 'onShouldRepaint').
  String get callbackName => 'on${name[0].toUpperCase()}${name.substring(1)}';
}

class _MethodParam {
  final String name;
  final String type;
  final bool isNamed;
  final bool isRequired;
  final bool isOptionalPositional;
  final String? defaultValue;

  _MethodParam({
    required this.name,
    required this.type,
    this.isNamed = false,
    this.isRequired = false,
    this.isOptionalPositional = false,
    this.defaultValue,
  });
}

/// Information about a generated proxy class.
class ProxyGenerationInfo {
  /// The target abstract class name.
  final String className;

  /// The generated proxy class name.
  final String proxyName;

  /// The number of abstract methods that are proxied.
  final int methodCount;

  /// The import URI needed for the target class.
  final String importUri;

  /// Abstract methods (required callbacks).
  // ignore: library_private_types_in_public_api
  final List<_AbstractMethodInfo> abstractMethods;

  /// Overridable methods (optional callbacks with super fallback).
  // ignore: library_private_types_in_public_api
  final List<_AbstractMethodInfo> overridableMethods;

  /// Type parameter names from the class (e.g., `['T']` for `CustomClipper&lt;T&gt;`).
  /// Used to replace with `dynamic` in factory callback code where the type
  /// parameter is not in scope.
  final List<String> typeParameterNames;

  const ProxyGenerationInfo({
    required this.className,
    required this.proxyName,
    required this.methodCount,
    required this.importUri,
    this.abstractMethods = const [],
    this.overridableMethods = const [],
    this.typeParameterNames = const [],
  });
}

/// Result of proxy generation.
class ProxyGenerationResult {
  /// The output file path written.
  final String? outputFile;

  /// Info about each generated proxy.
  final List<ProxyGenerationInfo> proxies;

  /// Any errors encountered.
  final List<String> errors;

  const ProxyGenerationResult({
    this.outputFile,
    this.proxies = const [],
    this.errors = const [],
  });

  bool get isSuccess => errors.isEmpty && proxies.isNotEmpty;
}

/// Generates proxy classes for configured abstract delegates.
///
/// Uses the Dart analyzer to resolve abstract class methods and generates
/// proxy subclasses that delegate to callback functions.
Future<ProxyGenerationResult> generateProxies({
  required BridgeConfig config,
  required String projectPath,
}) async {
  if (!config.generateProxies || config.proxyClasses.isEmpty) {
    return const ProxyGenerationResult();
  }

  if (config.proxiesOutputPath == null) {
    return const ProxyGenerationResult(
      errors: ['generateProxies is true but proxiesOutputPath is not set'],
    );
  }

  final errors = <String>[];
  final proxies = <ProxyGenerationInfo>[];

  // Set up analyzer context for the project
  final absoluteProjectPath = p.isAbsolute(projectPath)
      ? projectPath
      : p.normalize(p.join(Directory.current.path, projectPath));

  final sdkPath = _getSdkPath();

  final collection = AnalysisContextCollection(
    includedPaths: [absoluteProjectPath],
    sdkPath: sdkPath,
  );

  // Resolve barrel imports to find target classes.
  // We need to search across all module barrel files for the target classes.
  final barrelUris = <String>[];
  for (final module in config.modules) {
    if (module.barrelImport != null) {
      barrelUris.add(module.barrelImport!);
    }
    for (final bf in module.barrelFiles) {
      if (bf.startsWith('package:') || bf.startsWith('dart:')) {
        if (!barrelUris.contains(bf)) barrelUris.add(bf);
      }
    }
  }

  // Collect all proxy class entries with their resolved elements
  final proxyEntries = <(ProxyClassConfig, ClassElement, String barrelUri)>[];

  // For each proxy class, find it in the barrel exports
  for (final proxyConfig in config.proxyClasses) {
    var found = false;

    for (final barrelUri in barrelUris) {
      final element = await _findClassInBarrel(
        collection,
        barrelUri,
        proxyConfig.className,
        absoluteProjectPath,
      );
      if (element != null) {
        proxyEntries.add((proxyConfig, element, barrelUri));
        found = true;
        break;
      }
    }

    if (!found) {
      errors.add(
        'Proxy class "${proxyConfig.className}" not found in any module barrel file',
      );
    }
  }

  if (proxyEntries.isEmpty) {
    return ProxyGenerationResult(errors: errors);
  }

  // Generate the proxy file content
  final buffer = StringBuffer();
  buffer.writeln('/// D4rt Proxy Classes for ${config.name}');
  buffer.writeln('///');
  buffer.writeln(
    '/// Generated proxy/adapter subclasses that delegate abstract methods',
  );
  buffer.writeln(
    '/// to callback functions, enabling D4rt scripts to implement',
  );
  buffer.writeln('/// abstract delegates.');
  buffer.writeln('///');
  buffer.writeln('/// DO NOT EDIT — generated by d4rtgen proxy generator.');
  buffer.writeln('library;');
  buffer.writeln();

  // ignore_for_file for common generated code issues
  buffer.writeln('// ignore_for_file: unused_import');
  buffer.writeln();

  // Collect all unique import URIs needed
  final importUris = <String>{};
  final classImportMap = <String, String>{};

  // Always add D4rt runtime import for proxy factory registration (GEN-092)
  importUris.add('package:tom_d4rt_ast/runtime.dart');

  for (final (proxyConfig, element, barrelUri) in proxyEntries) {
    // Determine the best import for this class
    final importUri = _getBestImportUri(element, barrelUri);
    importUris.add(importUri);
    classImportMap[proxyConfig.className] = importUri;

    // Also collect imports for parameter types used in abstract and
    // overridable methods
    final abstractMethods = _getAbstractMethods(element);
    final overridableMethods = _getOverridableMethods(element);
    for (final method in [...abstractMethods, ...overridableMethods]) {
      for (final param in method.params) {
        final paramTypeImport = _getTypeImportUri(param.type, element);
        if (paramTypeImport != null) importUris.add(paramTypeImport);
      }
      final returnImport = _getTypeImportUri(method.returnType, element);
      if (returnImport != null) importUris.add(returnImport);
    }
  }

  // Write imports — separate dart: from package:
  final dartImports = importUris.where((u) => u.startsWith('dart:')).toList()
    ..sort();
  final packageImports =
      importUris.where((u) => u.startsWith('package:')).toList()..sort();

  for (final uri in dartImports) {
    buffer.writeln("import '$uri';");
  }
  if (dartImports.isNotEmpty && packageImports.isNotEmpty) {
    buffer.writeln();
  }
  for (final uri in packageImports) {
    buffer.writeln("import '$uri';");
  }
  buffer.writeln();

  // Generate each proxy class
  for (final (proxyConfig, element, barrelUri) in proxyEntries) {
    final abstractMethods = _getAbstractMethods(element);
    final overridableMethods = _getOverridableMethods(element);
    final allMethods = [...abstractMethods, ...overridableMethods];

    if (abstractMethods.isEmpty && overridableMethods.isEmpty) {
      errors.add(
        'Class "${proxyConfig.className}" has no abstract or overridable methods to proxy',
      );
      continue;
    }

    final proxyName = proxyConfig.effectiveProxyName;
    final className = proxyConfig.className;

    // Handle generic classes
    final typeParams = element.typeParameters;
    final typeParamDecl = typeParams.isNotEmpty
        ? '<${typeParams.map((tp) {
            final bound = tp.bound;
            return bound != null ? '${tp.name} extends ${bound.getDisplayString()}' : tp.name;
          }).join(', ')}>'
        : '';
    final typeParamUse = typeParams.isNotEmpty
        ? '<${typeParams.map((tp) => tp.name).join(', ')}>'
        : '';

    // Class doc comment
    buffer.writeln('/// D4rt proxy for [$className].');
    buffer.writeln('///');
    buffer.writeln(
      '/// Delegates abstract methods to callback functions, enabling',
    );
    buffer.writeln('/// D4rt scripts to implement [$className] via named');
    buffer.writeln('/// function parameters.');
    buffer.writeln(
      'class $proxyName$typeParamDecl extends $className$typeParamUse {',
    );

    // Fields for each callback — abstract are required, overridable are nullable
    for (final method in allMethods) {
      buffer.writeln('  /// Callback for [$className.${method.name}].');
      if (method.isAbstract) {
        buffer.writeln(
          '  final ${method.callbackType} ${method.callbackName};',
        );
      } else {
        buffer.writeln(
          '  final ${method.callbackType}? ${method.callbackName};',
        );
      }
      buffer.writeln();
    }

    // Constructor
    buffer.writeln(
      '  /// Creates a [$proxyName] with callback implementations.',
    );
    buffer.write('  $proxyName({');
    buffer.writeln();
    for (final method in allMethods) {
      if (method.isAbstract) {
        buffer.writeln('    required this.${method.callbackName},');
      } else {
        buffer.writeln('    this.${method.callbackName},');
      }
    }
    buffer.writeln('  });');
    buffer.writeln();

    // Override methods
    for (final method in allMethods) {
      buffer.writeln('  @override');
      if (method.isGetter) {
        if (method.isAbstract) {
          buffer.writeln(
            '  ${method.returnType} get ${method.name} => ${method.callbackName}();',
          );
        } else {
          buffer.writeln(
            '  ${method.returnType} get ${method.name} => '
            '${method.callbackName} != null '
            '? ${method.callbackName}!() '
            ': super.${method.name};',
          );
        }
      } else {
        final paramSig = _buildParamSignature(method.params);
        final callArgs = _buildCallArgs(method.params);
        if (method.isAbstract) {
          buffer.writeln(
            '  ${method.returnType} ${method.name}($paramSig) =>',
          );
          buffer.writeln('      ${method.callbackName}($callArgs);');
        } else {
          buffer.writeln(
            '  ${method.returnType} ${method.name}($paramSig) =>',
          );
          buffer.writeln(
            '      ${method.callbackName} != null '
            '? ${method.callbackName}!($callArgs) '
            ': super.${method.name}($callArgs);',
          );
        }
      }
      buffer.writeln();
    }

    buffer.writeln('}');
    buffer.writeln();

    proxies.add(
      ProxyGenerationInfo(
        className: className,
        proxyName: proxyName,
        methodCount: allMethods.length,
        importUri: classImportMap[className] ?? barrelUri,
        abstractMethods: abstractMethods,
        overridableMethods: overridableMethods,
        typeParameterNames: typeParams
            .map((tp) => tp.name)
            .whereType<String>()
            .toList(),
      ),
    );

    print(
      '  PROXY: Generated $proxyName for $className '
      '(${abstractMethods.length} abstract + '
      '${overridableMethods.length} overridable methods)',
    );
  }

  // =========================================================================
  // GEN-092: Generate registerProxyFactories() function
  // =========================================================================
  if (proxies.isNotEmpty) {
    _generateProxyFactoryRegistration(buffer, proxies);
  }

  // Write the output file
  final outputPath = p.join(
    projectPath,
    ensureBDartExtension(config.proxiesOutputPath!),
  );
  final outputDir = Directory(p.dirname(outputPath));
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }
  await File(outputPath).writeAsString(buffer.toString());

  return ProxyGenerationResult(
    outputFile: outputPath,
    proxies: proxies,
    errors: errors,
  );
}

/// Finds a class by name in a barrel file's exported symbols.
Future<ClassElement?> _findClassInBarrel(
  AnalysisContextCollection collection,
  String barrelUri,
  String className,
  String projectPath,
) async {
  try {
    // Get the analysis context for the project
    final context = collection.contexts.first;

    // Resolve the barrel URI to a library element
    LibraryElement? libraryElement;

    if (barrelUri.startsWith('dart:')) {
      // SDK library — resolve via the analysis session
      final result = await context.currentSession.getLibraryByUri(barrelUri);
      if (result is LibraryElementResult) {
        libraryElement = result.element;
      }
    } else if (barrelUri.startsWith('package:')) {
      final result = await context.currentSession.getLibraryByUri(barrelUri);
      if (result is LibraryElementResult) {
        libraryElement = result.element;
      }
    }

    if (libraryElement == null) return null;

    // Search the library's exported namespace for the class
    final exportNamespace = libraryElement.exportNamespace;
    final element = exportNamespace.get2(className);
    if (element is ClassElement) {
      return element;
    }

    return null;
  } catch (e) {
    // Barrel might not be resolvable — skip silently
    return null;
  }
}

/// Gets the abstract methods of a class (including inherited abstract methods).
List<_AbstractMethodInfo> _getAbstractMethods(ClassElement element) {
  final methods = <_AbstractMethodInfo>[];
  final processedNames = <String>{};

  // Get all abstract methods from the class and its supertypes
  // We want methods that are truly abstract in the target class
  for (final method in element.methods) {
    final methodName = method.name;
    if (methodName != null &&
        method.isAbstract &&
        !method.isPrivate &&
        !method.isStatic) {
      processedNames.add(methodName);
      methods.add(_methodElementToInfo(method));
    }
  }

  // Also check abstract getters
  for (final getter in element.getters) {
    if (getter.isAbstract && !getter.isPrivate && !getter.isStatic) {
      final getterName = getter.displayName;
      if (!processedNames.contains(getterName)) {
        processedNames.add(getterName);
        methods.add(_accessorElementToInfo(getter));
      }
    }
  }

  return methods;
}

/// Gets non-abstract overridable methods from the class and its supertypes.
///
/// These are concrete methods that D4rt scripts may want to optionally
/// override. The proxy will fall back to `super.method()` when no callback
/// is provided.
List<_AbstractMethodInfo> _getOverridableMethods(ClassElement element) {
  final methods = <_AbstractMethodInfo>[];
  final processedNames = <String>{};

  // Collect names of abstract methods first — we skip those
  for (final method in element.methods) {
    if (method.isAbstract && !method.isPrivate && !method.isStatic) {
      final methodName = method.name;
      if (methodName != null) processedNames.add(methodName);
    }
  }
  for (final getter in element.getters) {
    if (getter.isAbstract && !getter.isPrivate && !getter.isStatic) {
      processedNames.add(getter.displayName);
    }
  }

  // Also skip Object methods and common framework internals
  const skipMethods = {
    'toString',
    'noSuchMethod',
    'hashCode',
    'runtimeType',
    '==',
  };
  processedNames.addAll(skipMethods);

  // Collect non-abstract overridable methods from the class hierarchy
  void collectFrom(ClassElement cls) {
    for (final method in cls.methods) {
      final methodName = method.name;
      if (methodName != null &&
          !method.isAbstract &&
          !method.isPrivate &&
          !method.isStatic &&
          !processedNames.contains(methodName)) {
        processedNames.add(methodName);
        methods.add(_methodElementToInfo(method, isAbstract: false));
      }
    }
    for (final getter in cls.getters) {
      final getterName = getter.displayName;
      if (!getter.isAbstract &&
          !getter.isPrivate &&
          !getter.isStatic &&
          !getter.isSynthetic &&
          !processedNames.contains(getterName)) {
        processedNames.add(getterName);
        methods.add(_accessorElementToInfo(getter, isAbstract: false));
      }
    }
  }

  // Start from the target class itself, then walk supertypes
  collectFrom(element);
  for (final superType in element.allSupertypes) {
    final superElement = superType.element;
    if (superElement is ClassElement &&
        superElement.name != 'Object') {
      collectFrom(superElement);
    }
  }

  return methods;
}

_AbstractMethodInfo _methodElementToInfo(
  MethodElement method, {
  bool isAbstract = true,
}) {
  return _AbstractMethodInfo(
    name: method.displayName,
    returnType: method.returnType.getDisplayString(),
    params: method.formalParameters.map(_paramElementToInfo).toList(),
    isAbstract: isAbstract,
  );
}

_AbstractMethodInfo _accessorElementToInfo(
  PropertyAccessorElement accessor, {
  bool isAbstract = true,
}) {
  return _AbstractMethodInfo(
    name: accessor.displayName,
    returnType: accessor.returnType.getDisplayString(),
    params: [],
    isGetter: true,
    isAbstract: isAbstract,
  );
}

_MethodParam _paramElementToInfo(FormalParameterElement param) {
  return _MethodParam(
    name: param.name ?? '',
    type: param.type.getDisplayString(),
    isNamed: param.isNamed,
    isRequired: param.isRequired,
    isOptionalPositional: param.isOptionalPositional,
    defaultValue: param.defaultValueCode,
  );
}

/// Gets the best import URI for a class element.
String _getBestImportUri(ClassElement element, String barrelUri) {
  // Prefer the barrel URI (e.g., 'package:flutter/painting.dart') over
  // the source file URI (e.g., 'package:flutter/src/painting/custom_painter.dart')
  // because barrel imports are stable API.
  return barrelUri;
}

/// Gets import URI for a type string if it's not a core type.
String? _getTypeImportUri(String type, ClassElement contextElement) {
  // Strip nullable and generic suffixes for lookup
  final baseType = type
      .replaceAll('?', '')
      .replaceAll(RegExp(r'<.*>'), '')
      .trim();

  // Skip core types that don't need imports
  const coreTypes = {
    'void',
    'dynamic',
    'Object',
    'bool',
    'int',
    'double',
    'num',
    'String',
    'List',
    'Map',
    'Set',
    'Iterable',
    'Future',
    'Stream',
    'Function',
    'Type',
    'Null',
    'Never',
  };
  if (coreTypes.contains(baseType)) return null;

  // The contextElement's library should already provide the needed imports
  // via its barrel import. We don't add extra imports for types that come
  // from the same barrel.
  return null;
}

/// Builds the parameter signature string for a method override.
String _buildParamSignature(List<_MethodParam> params) {
  if (params.isEmpty) return '';

  final positional = params.where((p) => !p.isNamed && !p.isOptionalPositional);
  final optionalPositional = params.where((p) => p.isOptionalPositional);
  final named = params.where((p) => p.isNamed);

  final parts = <String>[];

  for (final p in positional) {
    parts.add('${p.type} ${p.name}');
  }

  if (optionalPositional.isNotEmpty) {
    final optParts = optionalPositional.map((p) {
      if (p.defaultValue != null) {
        return '${p.type} ${p.name} = ${p.defaultValue}';
      }
      return '${p.type} ${p.name}';
    });
    parts.add('[${optParts.join(', ')}]');
  }

  if (named.isNotEmpty) {
    final namedParts = named.map((p) {
      final req = p.isRequired ? 'required ' : '';
      if (p.defaultValue != null && !p.isRequired) {
        return '$req${p.type} ${p.name} = ${p.defaultValue}';
      }
      return '$req${p.type} ${p.name}';
    });
    parts.add('{${namedParts.join(', ')}}');
  }

  return parts.join(', ');
}

/// Builds the call arguments for delegating to the callback.
String _buildCallArgs(List<_MethodParam> params) {
  if (params.isEmpty) return '';

  final parts = <String>[];
  for (final p in params) {
    if (p.isNamed) {
      parts.add('${p.name}: ${p.name}');
    } else {
      parts.add(p.name);
    }
  }
  return parts.join(', ');
}

/// Gets the Dart SDK path.
String? _getSdkPath() {
  // Check DART_SDK environment variable first
  final envSdk = Platform.environment['DART_SDK'];
  if (envSdk != null && Directory(envSdk).existsSync()) {
    return envSdk;
  }

  // Try to detect from dart executable
  final dartExe = Platform.resolvedExecutable;
  final binDir = p.dirname(dartExe);
  final sdkDir = p.dirname(binDir);
  if (File(p.join(sdkDir, 'lib', 'core', 'core.dart')).existsSync()) {
    return sdkDir;
  }

  // For Flutter SDK, dart is inside flutter/bin/cache/dart-sdk/bin/
  final flutterSdkDir = p.dirname(p.dirname(binDir));
  if (File(p.join(flutterSdkDir, 'lib', 'core', 'core.dart')).existsSync()) {
    return flutterSdkDir;
  }

  return null;
}

// =============================================================================
// GEN-092: Proxy factory registration generation
// =============================================================================

/// Generates the `registerProxyFactories()` function that registers
/// interface proxy factories with `D4.registerInterfaceProxy()`.
///
/// Each factory creates a proxy instance with callbacks that delegate
/// to the `InterpretedInstance`'s methods via `findInstanceMethod` / `findInstanceGetter`.
void _generateProxyFactoryRegistration(
  StringBuffer buffer,
  List<ProxyGenerationInfo> proxies,
) {
  buffer.writeln(
    '// =========================================================================',
  );
  buffer.writeln(
    '// Proxy Factory Registration (GEN-092)',
  );
  buffer.writeln(
    '// =========================================================================',
  );
  buffer.writeln();
  buffer.writeln(
    '/// Registers interface proxy factories for all generated proxy classes.',
  );
  buffer.writeln('///');
  buffer.writeln(
    '/// Call this during bridge initialization to enable D4rt scripts to',
  );
  buffer.writeln(
    '/// create interpreted subclasses of these abstract classes.',
  );
  buffer.writeln(
    '/// Each factory bridges InterpretedInstance method calls to native',
  );
  buffer.writeln('/// proxy callbacks.');
  buffer.writeln('void registerProxyFactories() {');

  for (final proxy in proxies) {
    buffer.writeln(
      "  // Register factory for ${proxy.className}",
    );
    buffer.writeln(
      "  D4.registerInterfaceProxy('${proxy.className}', "
      '(visitor, instance) {',
    );
    buffer.writeln('    return ${proxy.proxyName}(');

    // Abstract methods — always provide a callback
    for (final method in proxy.abstractMethods) {
      _generateFactoryCallback(
        buffer,
        method,
        isRequired: true,
        typeParameterNames: proxy.typeParameterNames,
      );
    }

    // Overridable methods — provide callback only if interpreted class overrides
    for (final method in proxy.overridableMethods) {
      _generateFactoryCallback(
        buffer,
        method,
        isRequired: false,
        typeParameterNames: proxy.typeParameterNames,
      );
    }

    buffer.writeln('    );');
    buffer.writeln('  });');
    buffer.writeln();
  }

  buffer.writeln('}');
  buffer.writeln();
}

/// Generates a single callback argument for a proxy factory.
///
/// For [isRequired] (abstract) methods, the callback always delegates to the
/// interpreted instance via `findInstanceMethod`/`findInstanceGetter`.
/// For optional (overridable) methods, the callback is only provided if the
/// interpreted class explicitly overrides the method.
void _generateFactoryCallback(
  StringBuffer buffer,
  _AbstractMethodInfo method, {
  required bool isRequired,
  List<String> typeParameterNames = const [],
}) {
  final callbackName = method.callbackName;
  final methodName = method.name;
  final isVoid = method.returnType == 'void';

  // Erase class type parameters (e.g. T → dynamic) since the factory
  // closure is not inside the generic class scope.
  final erasedReturnType = _eraseTypeParams(method.returnType, typeParameterNames);

  if (method.isGetter) {
    // Getter callback
    if (isRequired) {
      buffer.writeln('      $callbackName: () {');
      _generateGetterDelegation(buffer, methodName, erasedReturnType);
      buffer.writeln('      },');
    } else {
      // Overridable getter — only wire if interpreted class has it
      buffer.writeln(
        "      $callbackName: instance.klass.findInstanceGetter('$methodName') != null",
      );
      buffer.writeln('          ? () {');
      _generateGetterDelegation(buffer, methodName, erasedReturnType);
      buffer.writeln('          }');
      buffer.writeln('          : null,');
    }
  } else {
    // Regular method callback
    final paramDecl = _buildFactoryParamDecl(method.params, typeParameterNames);
    final argList = _buildFactoryArgList(method.params);
    final namedArgMap = _buildFactoryNamedArgMap(method.params);

    if (isRequired) {
      buffer.writeln('      $callbackName: ($paramDecl) {');
      _generateMethodDelegation(
        buffer,
        methodName,
        erasedReturnType,
        argList,
        namedArgMap,
        isVoid: isVoid,
      );
      buffer.writeln('      },');
    } else {
      // Overridable method — only wire if interpreted class has it
      buffer.writeln(
        "      $callbackName: instance.klass.findInstanceMethod('$methodName') != null",
      );
      buffer.writeln('          ? ($paramDecl) {');
      _generateMethodDelegation(
        buffer,
        methodName,
        erasedReturnType,
        argList,
        namedArgMap,
        isVoid: isVoid,
      );
      buffer.writeln('          }');
      buffer.writeln('          : null,');
    }
  }
}

/// Generates code to delegate a getter access to the interpreted instance.
void _generateGetterDelegation(
  StringBuffer buffer,
  String getterName,
  String returnType,
) {
  final isVoid = returnType == 'void';
  buffer.writeln(
    "        final getter = instance.klass.findInstanceGetter('$getterName');",
  );
  buffer.writeln('        if (getter != null) {');
  buffer.writeln(
    '          final result = getter.bind(instance).call(visitor, [], {});',
  );
  if (isVoid) {
    buffer.writeln('          return;');
  } else {
    buffer.writeln(
      "          return D4.extractBridgedArg<$returnType>(result, '$getterName');",
    );
  }
  buffer.writeln('        }');
  // Try field access as fallback
  buffer.writeln('        try {');
  buffer.writeln(
    "          final field = instance.getField('$getterName');",
  );
  if (isVoid) {
    buffer.writeln('          return;');
  } else {
    buffer.writeln(
      "          return D4.extractBridgedArg<$returnType>(field, '$getterName');",
    );
  }
  buffer.writeln('        } catch (_) {}');
  buffer.writeln(
    "        throw StateError("
    "'Interpreted class \${instance.klass.name} does not implement $getterName');",
  );
}

/// Generates code to delegate a method call to the interpreted instance.
void _generateMethodDelegation(
  StringBuffer buffer,
  String methodName,
  String returnType,
  String argList,
  String namedArgMap, {
  required bool isVoid,
}) {
  buffer.writeln(
    "        final method = instance.klass.findInstanceMethod('$methodName');",
  );
  buffer.writeln('        if (method != null) {');
  buffer.writeln(
    '          final result = method.bind(instance).call(visitor, [$argList], {$namedArgMap});',
  );
  if (isVoid) {
    buffer.writeln('          return;');
  } else {
    buffer.writeln(
      "          return D4.extractBridgedArg<$returnType>(result, '$methodName');",
    );
  }
  buffer.writeln('        }');
  buffer.writeln(
    "        throw StateError("
    "'Interpreted class \${instance.klass.name} does not implement $methodName');",
  );
}

/// Builds the parameter declaration for a factory callback function.
/// Unlike the proxy class which uses typed params, the callback just uses
/// the variable names since types are inferred from the Function typedef.
String _buildFactoryParamDecl(
  List<_MethodParam> params, [
  List<String> typeParameterNames = const [],
]) {
  if (params.isEmpty) return '';

  final parts = <String>[];
  final positional =
      params.where((p) => !p.isNamed && !p.isOptionalPositional);
  final optionalPositional = params.where((p) => p.isOptionalPositional);
  final named = params.where((p) => p.isNamed);

  for (final p in positional) {
    parts.add('${_eraseTypeParams(p.type, typeParameterNames)} ${p.name}');
  }
  if (optionalPositional.isNotEmpty) {
    final optParts = optionalPositional
        .map((p) => '${_eraseTypeParams(p.type, typeParameterNames)} ${p.name}');
    parts.add('[${optParts.join(', ')}]');
  }
  if (named.isNotEmpty) {
    final namedParts = named.map((p) {
      final req = p.isRequired ? 'required ' : '';
      return '$req${_eraseTypeParams(p.type, typeParameterNames)} ${p.name}';
    });
    parts.add('{${namedParts.join(', ')}}');
  }
  return parts.join(', ');
}

/// Builds the positional argument list for delegating to the interpreter.
String _buildFactoryArgList(List<_MethodParam> params) {
  final positional = params.where((p) => !p.isNamed);
  return positional.map((p) => p.name).join(', ');
}

/// Builds the named argument map for delegating to the interpreter.
String _buildFactoryNamedArgMap(List<_MethodParam> params) {
  final named = params.where((p) => p.isNamed);
  if (named.isEmpty) return '';
  return named.map((p) => "'${p.name}': ${p.name}").join(', ');
}

/// Replaces class type parameter names with `dynamic` in a type string.
///
/// Used in factory callback code generation where the class type parameter
/// (e.g., `T` in `CustomClipper&lt;T&gt;`) is not in scope since the factory
/// closure lives outside the generic class.
///
/// Examples with typeParamNames = `['T']`:
///   `T` → `dynamic`
///   `CustomClipper&lt;T&gt;` → `CustomClipper&lt;dynamic&gt;`
///   `Map&lt;String, T&gt;` → `Map&lt;String, dynamic&gt;`
///   `Path` → `Path` (unchanged)
String _eraseTypeParams(String type, List<String> typeParamNames) {
  if (typeParamNames.isEmpty) return type;

  var result = type;
  for (final tp in typeParamNames) {
    // Use word-boundary matching to only replace standalone type param names,
    // not substrings of other identifiers (e.g., 'Type' should not become
    // 'dynamicype').
    result = result.replaceAllMapped(
      RegExp('\\b${RegExp.escape(tp)}\\b'),
      (_) => 'dynamic',
    );
  }
  return result;
}
