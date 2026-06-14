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
// ignore: implementation_imports
import 'package:analyzer/src/dart/analysis/analysis_context_collection.dart'
    show AnalysisContextCollectionImpl;
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:path/path.dart' as p;

import 'bridge_config.dart';
import 'file_generators.dart' show ensureBDartExtension;
import 'sdk_utils.dart' show getSdkPath;
import 'type_rendering.dart' show renderDartType, renderDartTypeExpanded;

/// Information about a method that needs proxying.
class _AbstractMethodInfo {
  final String name;
  final String returnType;

  /// C17: typedef-expanded return type used as the type argument to
  /// `D4.extractBridgedArg<T>` and as the input to `_parseFunctionType` in
  /// `_emitTypedReturn`. For function-typed typedef aliases (e.g.
  /// `SemanticsBuilderCallback?`), [returnType] preserves the alias for the
  /// proxy class's field/getter signatures while [extractionReturnType]
  /// expands to `List<CustomPainterSemantics> Function(Size)?` so the
  /// runtime can recognise it as a function type and wrap interpreted
  /// callables correctly. For non-function types this is identical to
  /// [returnType].
  final String extractionReturnType;
  final List<_MethodParam> params;
  final bool isGetter;

  /// Whether this method is abstract (required callback) or overridable
  /// (optional callback with super fallback).
  final bool isAbstract;

  _AbstractMethodInfo({
    required this.name,
    required this.returnType,
    String? extractionReturnType,
    required this.params,
    this.isGetter = false,
    this.isAbstract = true,
  }) : extractionReturnType = extractionReturnType ?? returnType;

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

  /// Whether each type parameter is F-bounded (references its own enclosing
  /// class in its bound, e.g. `T extends ThemeExtension<T>`). F-bounded
  /// params require `dynamic` in the proxy factory registration so the
  /// recursive bound check doesn't fail. Other params can use a concrete
  /// top-of-hierarchy (`Object`) so that the registered proxy survives an
  /// `is RouteInformationParser<Object>?` check at the bridge boundary
  /// (Dart's `is` is strict for invariant generics — see GEN-118b).
  /// Parallel to [typeParameterNames].
  final List<bool> typeParameterIsFBounded;

  const ProxyGenerationInfo({
    required this.className,
    required this.proxyName,
    required this.methodCount,
    required this.importUri,
    this.abstractMethods = const [],
    this.overridableMethods = const [],
    this.typeParameterNames = const [],
    this.typeParameterIsFBounded = const [],
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
///
/// Phase 4 / summary-refactoring-plan: the caller can now pass an
/// already-built [analysisContext]. When supplied, the proxy generator
/// reuses it instead of constructing its own
/// [AnalysisContextCollectionImpl] — this lets `BridgeGenerator`
/// (via `bridge_api.dart`) share a single summary-loaded context with the
/// proxy stage and avoids paying the summary-scan cost twice per project.
///
/// When [analysisContext] is null and [librarySummaryPaths] and/or
/// [sdkSummaryPath] are provided (typically by
/// `package:tom_analyzer_shared`'s `runSummaryCacheStage`), the internal
/// [AnalysisContextCollectionImpl] loads those bundles instead of
/// re-scanning dependency sources from disk. If neither is supplied, a
/// source-backed [AnalysisContextCollection] is built as a final fallback
/// so the generator is still usable in isolation (e.g., from tests).
Future<ProxyGenerationResult> generateProxies({
  required BridgeConfig config,
  required String projectPath,
  List<String>? librarySummaryPaths,
  String? sdkSummaryPath,
  AnalysisContextCollection? analysisContext,
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

  final hasSummaries =
      (librarySummaryPaths != null && librarySummaryPaths.isNotEmpty) ||
          sdkSummaryPath != null;
  final AnalysisContextCollection collection = analysisContext ??
      (hasSummaries
          ? AnalysisContextCollectionImpl(
              includedPaths: [absoluteProjectPath],
              sdkPath: sdkSummaryPath == null ? getSdkPath() : null,
              sdkSummaryPath: sdkSummaryPath,
              librarySummaryPaths: librarySummaryPaths ?? const [],
            )
          : AnalysisContextCollection(
              includedPaths: [absoluteProjectPath],
              sdkPath: getSdkPath(),
            ));

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
  buffer.writeln(
    '// ignore_for_file: unused_import, invalid_use_of_protected_member, unnecessary_non_null_assertion, invalid_use_of_visible_for_testing_member',
  );
  buffer.writeln();

  // Collect all unique import URIs needed
  final importUris = <String>{};
  final classImportMap = <String, String>{};

  // D4rt runtime import for proxy factory registration (GEN-092). Routed
  // through `config.d4rtImport` so source-based (`package:tom_d4rt/d4rt.dart`)
  // and AST-based (`package:tom_d4rt_exec/d4rt.dart`, which re-exports
  // `tom_d4rt_ast/runtime.dart`) consumers get the right `D4` symbol.
  // Falls back to the legacy `tom_d4rt_ast/runtime.dart` when no import is
  // configured, matching pre-fix behaviour.
  importUris.add(
    config.d4rtImport ?? 'package:tom_d4rt_ast/runtime.dart',
  );

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
            // Phase 4 / W6-reuse: render bound via the shared typedef-
            // preserving helper so a bound like `VoidCallback` stays an
            // alias in the proxy declaration instead of expanding to a
            // raw `void Function()`.
            return bound != null ? '${tp.name} extends ${renderDartType(bound)}' : tp.name;
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
          buffer.writeln('  ${method.returnType} ${method.name}($paramSig) =>');
          buffer.writeln('      ${method.callbackName}($callArgs);');
        } else {
          buffer.writeln('  ${method.returnType} ${method.name}($paramSig) =>');
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
        // GEN-118b: detect F-bounded type params so the factory emitter
        // can pick between `<Object>` (sound, accepted by `is Foo<Object>?`
        // checks at bridge call sites) and `<dynamic>` (required when the
        // bound references the enclosing class recursively).
        typeParameterIsFBounded: typeParams.map((tp) {
          final bound = tp.bound;
          if (bound == null) return false;
          final boundStr = renderDartType(bound);
          // Heuristic: F-bounded if the bound mentions the enclosing
          // class name. Matches `T extends ThemeExtension<T>` or any
          // variant. Avoids false positives by requiring the class name
          // followed by `<` to skip unrelated identifiers.
          return boundStr.contains('$className<');
        }).toList(),
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
///
/// GEN-118 (Cluster B #6): walks the supertype chain so that proxies for
/// classes like `RouterDelegate<T> extends Listenable` also include the
/// inherited abstract methods (`addListener` / `removeListener`). Without
/// this walk, the generated concrete proxy class would fail to compile
/// (missing concrete implementations of `Listenable.addListener` and
/// `Listenable.removeListener`).
List<_AbstractMethodInfo> _getAbstractMethods(ClassElement element) {
  final methods = <_AbstractMethodInfo>[];
  final processedNames = <String>{};

  // Concrete members anywhere in the supertype chain (including the
  // target class itself) shadow any inherited abstract with the same
  // name. For example, `DataTableSource extends ChangeNotifier extends
  // Listenable` inherits a concrete `addListener` from `ChangeNotifier`
  // even though `Listenable.addListener` is abstract — so the target
  // class is NOT abstract for that member and the proxy should not
  // require an `onAddListener` callback.
  final concreteInHierarchy = <String>{};
  void collectConcrete(ClassElement cls) {
    for (final method in cls.methods) {
      final methodName = method.name;
      if (methodName != null &&
          !method.isAbstract &&
          !method.isPrivate &&
          !method.isStatic) {
        concreteInHierarchy.add(methodName);
      }
    }
    for (final getter in cls.getters) {
      if (!getter.isAbstract &&
          !getter.isPrivate &&
          !getter.isStatic &&
          !getter.isSynthetic) {
        concreteInHierarchy.add(getter.displayName);
      }
    }
  }

  collectConcrete(element);
  for (final superType in element.allSupertypes) {
    final superElement = superType.element;
    if (superElement is ClassElement && superElement.name != 'Object') {
      collectConcrete(superElement);
    }
  }

  // Step 1: abstract methods declared directly on the target class.
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
  for (final getter in element.getters) {
    if (getter.isAbstract && !getter.isPrivate && !getter.isStatic) {
      final getterName = getter.displayName;
      if (!processedNames.contains(getterName)) {
        processedNames.add(getterName);
        methods.add(_accessorElementToInfo(getter));
      }
    }
  }

  // Step 2 (GEN-118): inherited abstract methods from supertypes that the
  // target does not provide a concrete override for. Skip Object since
  // its members never need a proxy callback.
  for (final superType in element.allSupertypes) {
    final superElement = superType.element;
    if (superElement is! ClassElement || superElement.name == 'Object') {
      continue;
    }
    for (final method in superElement.methods) {
      final methodName = method.name;
      if (methodName == null ||
          !method.isAbstract ||
          method.isPrivate ||
          method.isStatic) {
        continue;
      }
      if (processedNames.contains(methodName) ||
          concreteInHierarchy.contains(methodName)) {
        continue;
      }
      processedNames.add(methodName);
      methods.add(_methodElementToInfo(method));
    }
    for (final getter in superElement.getters) {
      if (!getter.isAbstract || getter.isPrivate || getter.isStatic) {
        continue;
      }
      final getterName = getter.displayName;
      if (processedNames.contains(getterName) ||
          concreteInHierarchy.contains(getterName)) {
        continue;
      }
      processedNames.add(getterName);
      methods.add(_accessorElementToInfo(getter));
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
    if (superElement is ClassElement && superElement.name != 'Object') {
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
    // Phase 4 / W6-reuse: shared helper preserves function-typedef
    // aliases (`VoidCallback`, `ValueChanged<T>`, …) in the proxy
    // signature, matching what the bridge generator emits.
    returnType: renderDartType(method.returnType),
    // C17: expanded form for `extractBridgedArg<T>` so typedef-aliased
    // function returns parse as function types at runtime.
    extractionReturnType: renderDartTypeExpanded(method.returnType),
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
    returnType: renderDartType(accessor.returnType),
    // C17: see _methodElementToInfo.
    extractionReturnType: renderDartTypeExpanded(accessor.returnType),
    params: [],
    isGetter: true,
    isAbstract: isAbstract,
  );
}

_MethodParam _paramElementToInfo(FormalParameterElement param) {
  var renderedType = renderDartType(param.type);
  // GEN-117 (Cluster B #5): When an abstract method declares an optional
  // positional parameter with a non-nullable type and no default value
  // (e.g. `BoxPainter createBoxPainter([VoidCallback onChanged])` on
  // `Decoration`), the declaration is only legal on abstract methods.
  // A concrete override (which the generated proxy emits) requires the
  // parameter to be nullable or to carry an explicit default. Function
  // types have no canonical zero default, so the proxy lifts the type
  // to nullable. This matches what concrete Flutter subclasses do (e.g.
  // `BoxDecoration.createBoxPainter([VoidCallback? onChanged])`).
  if (param.isOptionalPositional &&
      param.defaultValueCode == null &&
      !renderedType.endsWith('?')) {
    renderedType = '$renderedType?';
  }
  return _MethodParam(
    name: param.name ?? '',
    type: renderedType,
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

// SDK path resolution is provided by sdk_utils.dart (getSdkPath).

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
  buffer.writeln('// Proxy Factory Registration (GEN-092)');
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
    buffer.writeln("  // Register factory for ${proxy.className}");
    buffer.writeln(
      "  D4.registerInterfaceProxy('${proxy.className}', "
      '(visitor, instance) {',
    );
    // GEN-104: emit explicit <dynamic, ...> type args for generic proxies so
    // F-bounded type parameters (e.g. `ThemeExtension<T extends
    // ThemeExtension<T>>`) compile. Without this Dart's type inference picks
    // `Object?` which then fails the recursive bound check.
    //
    // GEN-118b: for non-F-bounded params we use `Object` (not `dynamic`)
    // because at the bridge call site the consumer type is typically
    // `Foo<Object>?` (e.g., `MaterialApp.router(routeInformationParser:
    // RouteInformationParser<Object>?)`). Dart's `is` for invariant
    // generics treats `Foo<dynamic>` as distinct from `Foo<Object>`, so
    // `<dynamic>` would fail the runtime check and the proxy would be
    // rejected even when registered. `<Object>` is the universal
    // top-non-nullable concrete type that satisfies both the bridge's
    // declared parameter and any unbounded T. F-bounded params still
    // need `<dynamic>` so the recursive bound check doesn't trip.
    final typeParameterReplacements = List<String>.generate(
      proxy.typeParameterNames.length,
      (i) {
        final fBounded = i < proxy.typeParameterIsFBounded.length
            ? proxy.typeParameterIsFBounded[i]
            : false;
        return fBounded ? 'dynamic' : 'Object';
      },
    );
    final typeArgList = proxy.typeParameterNames.isEmpty
        ? ''
        : '<${typeParameterReplacements.join(', ')}>';
    buffer.writeln('    return ${proxy.proxyName}$typeArgList(');

    // Abstract methods — always provide a callback
    for (final method in proxy.abstractMethods) {
      _generateFactoryCallback(
        buffer,
        method,
        isRequired: true,
        typeParameterNames: proxy.typeParameterNames,
        typeParameterReplacements: typeParameterReplacements,
      );
    }

    // Overridable methods — provide callback only if interpreted class overrides
    for (final method in proxy.overridableMethods) {
      _generateFactoryCallback(
        buffer,
        method,
        isRequired: false,
        typeParameterNames: proxy.typeParameterNames,
        typeParameterReplacements: typeParameterReplacements,
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
  List<String> typeParameterReplacements = const [],
}) {
  final callbackName = method.callbackName;
  final methodName = method.name;
  final isVoid = method.returnType == 'void';

  // Erase class type parameters (e.g. T → dynamic/Object) since the factory
  // closure is not inside the generic class scope. GEN-118b: erase to the
  // same concrete type used in the factory's proxy instantiation so the
  // callback's runtime signature matches the proxy class field type.
  //
  // C17: erase on the typedef-expanded return type so the
  // `extractBridgedArg<T>` call inside the delegation body sees the
  // explicit `R Function(A)` form for typedef-aliased function returns.
  // The proxy class field/getter signatures (emitted earlier) still use
  // the alias-preserved `method.returnType`.
  final erasedExtractionReturnType = _eraseTypeParams(
    method.extractionReturnType,
    typeParameterNames,
    typeParameterReplacements,
  );

  if (method.isGetter) {
    // Getter callback
    if (isRequired) {
      buffer.writeln('      $callbackName: () {');
      _generateGetterDelegation(
        buffer, methodName, erasedExtractionReturnType,
      );
      buffer.writeln('      },');
    } else {
      // Overridable getter — only wire if interpreted class has it
      buffer.writeln(
        "      $callbackName: instance.klass.findInstanceGetter('$methodName') != null",
      );
      buffer.writeln('          ? () {');
      _generateGetterDelegation(
        buffer, methodName, erasedExtractionReturnType,
      );
      buffer.writeln('          }');
      buffer.writeln('          : null,');
    }
  } else {
    // Regular method callback
    final paramDecl = _buildFactoryParamDecl(
      method.params,
      typeParameterNames,
      typeParameterReplacements,
    );
    final argList = _buildFactoryArgList(method.params);
    final namedArgMap = _buildFactoryNamedArgMap(method.params);

    if (isRequired) {
      buffer.writeln('      $callbackName: ($paramDecl) {');
      _generateMethodDelegation(
        buffer,
        methodName,
        erasedExtractionReturnType,
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
        erasedExtractionReturnType,
        argList,
        namedArgMap,
        isVoid: isVoid,
      );
      buffer.writeln('          }');
      buffer.writeln('          : null,');
    }
  }
}

/// Parsed shape of a function-typed return type, e.g.
/// `List<CustomPainterSemantics> Function(Size)?` →
///   `(returnType: 'List<CustomPainterSemantics>', paramTypes: ['Size'], isNullable: true)`
///
/// Returns `null` when [type] is not an explicit `R Function(...)` form
/// (typedefs like `VoidCallback` would resolve to `Function`-ish strings
/// only if the analyzer expanded them; the bridge generator emits the
/// expanded form for most Flutter typedefs).
class _FnType {
  _FnType(this.returnType, this.paramTypes, this.isNullable);
  final String returnType;
  final List<String> paramTypes;
  final bool isNullable;
}

_FnType? _parseFunctionType(String type) {
  // Strip leading whitespace.
  String t = type.trim();
  // Detect trailing `?` for the *outer* type (whole function is nullable).
  bool isNullable = false;
  if (t.endsWith('?')) {
    isNullable = true;
    t = t.substring(0, t.length - 1).trimRight();
  }
  // Find the LAST occurrence of ` Function(` so generics in the return
  // type don't trip us up (e.g. `Map<String, Function()>` is NOT a
  // function-typed value itself; it has no top-level ` Function(`).
  // Top-level detection: scan for `Function(` at depth-0 brackets.
  int depth = 0;
  int fnIndex = -1;
  for (int i = 0; i < t.length; i++) {
    final c = t[i];
    if (c == '<') depth++;
    if (c == '>') depth--;
    if (depth == 0 && t.startsWith('Function(', i)) {
      fnIndex = i;
      // Don't break — pick the latest top-level Function( so a return type
      // like `int Function(int) Function(int)` parses as the outer.
    }
  }
  if (fnIndex < 0) return null;
  // Return type is everything before ` Function(`, trimmed.
  String rt = t.substring(0, fnIndex).trimRight();
  if (rt.isEmpty) {
    // Closure-form `Function(...)` with no return type — treat as dynamic.
    rt = 'dynamic';
  }
  // Args: substring inside the parentheses following `Function(`.
  // Find matching close paren.
  final openParen = fnIndex + 'Function'.length;
  if (openParen >= t.length || t[openParen] != '(') return null;
  int paren = 1;
  int closeParen = -1;
  for (int i = openParen + 1; i < t.length; i++) {
    final c = t[i];
    if (c == '(') paren++;
    if (c == ')') {
      paren--;
      if (paren == 0) {
        closeParen = i;
        break;
      }
    }
  }
  if (closeParen < 0) return null;
  // After the close paren, only `?` and whitespace allowed (trailing `?`
  // already stripped). Anything else (e.g. trailing generic args) → bail.
  final after = t.substring(closeParen + 1).trim();
  if (after.isNotEmpty) return null;
  // Split args by top-level commas (ignore commas inside `<>` or nested `()`).
  final argString = t.substring(openParen + 1, closeParen).trim();
  final paramTypes = <String>[];
  if (argString.isNotEmpty) {
    int aDepth = 0;
    int aStart = 0;
    for (int i = 0; i < argString.length; i++) {
      final c = argString[i];
      if (c == '<' || c == '(' || c == '{' || c == '[') aDepth++;
      if (c == '>' || c == ')' || c == '}' || c == ']') aDepth--;
      if (c == ',' && aDepth == 0) {
        paramTypes.add(_stripParamName(argString.substring(aStart, i).trim()));
        aStart = i + 1;
      }
    }
    paramTypes.add(_stripParamName(argString.substring(aStart).trim()));
  }
  return _FnType(rt, paramTypes, isNullable);
}

/// Strip a possible parameter name from a `Type name` chunk so we keep just
/// the type. (`Size size` → `Size`, `BuildContext context` → `BuildContext`.)
/// Type strings without a trailing identifier are returned unchanged
/// (`List<int>` stays `List<int>`).
String _stripParamName(String chunk) {
  // Identifier at end (preceded by whitespace) → strip it.
  final m = RegExp(r'^(.+?)\s+([A-Za-z_][A-Za-z0-9_]*)$').firstMatch(chunk);
  return m == null ? chunk : m.group(1)!.trim();
}

/// Builds typed parameter list for a wrapper closure (e.g. `Size p0` →
/// `(Size p0)`). Returns the parameter declaration and the call-site arg
/// list as a tuple.
({String params, List<String> argNames}) _buildTypedWrapperParams(
    List<String> paramTypes) {
  final params = <String>[];
  final argNames = <String>[];
  for (int i = 0; i < paramTypes.length; i++) {
    final n = 'p$i';
    params.add('${paramTypes[i]} $n');
    argNames.add(n);
  }
  return (params: '(${params.join(', ')})', argNames: argNames);
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
    _emitTypedReturn(buffer, returnType, 'result', getterName, indent: '          ');
  }
  buffer.writeln('        }');
  // Try field access as fallback
  buffer.writeln('        try {');
  buffer.writeln("          final field = instance.getField('$getterName');");
  if (isVoid) {
    buffer.writeln('          return;');
  } else {
    _emitTypedReturn(buffer, returnType, 'field', getterName, indent: '          ');
  }
  buffer.writeln('        } catch (_) {}');
  buffer.writeln(
    "        throw StateError("
    "'Interpreted class \${instance.klass.name} does not implement $getterName');",
  );
}

/// Emit `return ...;` for an interpreter call result, choosing between a
/// plain `extractBridgedArg<T>` and — for function-typed `T` — a typed
/// closure that wraps the returned `Callable` and constructs a Dart
/// closure with the exact static signature [returnType] requires.
///
/// Bug-47 fix: Dart's reified function-type subtyping rejects a
/// `dynamic Function(dynamic)` wrapper as `R Function(A)?`. Emitting a
/// typed closure at the proxy call-site sidesteps the round-trip through
/// `extractBridgedArg`'s untyped wrapper.
void _emitTypedReturn(
  StringBuffer buffer,
  String returnType,
  String resultVar,
  String memberName, {
  required String indent,
}) {
  final fn = _parseFunctionType(returnType);
  if (fn == null) {
    // GEN-117 (Cluster B #5): forward the proxy-factory `visitor` so the
    // InterpretedInstance branch of `extractBridgedArg` can resolve nested
    // proxies (e.g. `Decoration.createBoxPainter` returning a script-side
    // `BoxPainter` subclass needs the visitor to materialise a
    // `D4rtBoxPainter`).
    buffer.writeln(
      "$indent return D4.extractBridgedArg<$returnType>($resultVar, '$memberName', visitor);",
    );
    return;
  }
  // Function-typed return value. Emit a typed wrapper that constructs a
  // closure of the exact required shape from the InterpretedFunction.
  if (fn.isNullable) {
    buffer.writeln('$indent if ($resultVar == null) return null;');
  }
  buffer.writeln('$indent if ($resultVar is Callable) {');
  buffer.writeln('$indent   final _callable = $resultVar;');
  final wp = _buildTypedWrapperParams(fn.paramTypes);
  final argList = wp.argNames.join(', ');
  if (fn.returnType == 'void') {
    buffer.writeln('$indent   return ${wp.params} {');
    buffer.writeln(
      "$indent     _callable.call(visitor, [$argList], {});",
    );
    buffer.writeln('$indent   };');
  } else {
    buffer.writeln('$indent   return ${wp.params} {');
    buffer.writeln(
      "$indent     final _out = _callable.call(visitor, [$argList], {});",
    );
    // Bug-47b: Dart-script list literals return `List<dynamic>` whose
    // elements may still be `BridgedInstance<Object>` wrappers. When the
    // wrapper's static return type is `List<E>` (or `List<E>?`), unwrap
    // each element through `extractBridgedArg<E>` and rebuild a typed
    // `List<E>`; a plain `.cast<E>()` would fail because the wrappers are
    // not yet of type E.
    final isNullableList = fn.returnType.endsWith('?');
    final listInner = isNullableList
        ? fn.returnType.substring(0, fn.returnType.length - 1)
        : fn.returnType;
    final listMatch = RegExp(r'^List<(.+)>$').firstMatch(listInner);
    if (listMatch != null) {
      final elementType = listMatch.group(1)!;
      if (isNullableList) {
        buffer.writeln('$indent     if (_out == null) return null;');
      }
      buffer.writeln('$indent     if (_out is List) {');
      buffer.writeln(
        "$indent       return _out.map((e) => D4.extractBridgedArg<$elementType>(e, '$memberName', visitor)).toList();",
      );
      buffer.writeln('$indent     }');
    }
    buffer.writeln(
      "$indent     return D4.extractBridgedArg<${fn.returnType}>(_out, '$memberName', visitor);",
    );
    buffer.writeln('$indent   };');
  }
  buffer.writeln('$indent }');
  // Fallback: maybe the value is already a native function of the right
  // type (e.g. returned from another bridge call). Let extractBridgedArg
  // attempt the cast.
  buffer.writeln(
    "$indent return D4.extractBridgedArg<$returnType>($resultVar, '$memberName', visitor);",
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
    // Bug-47: function-typed return values need typed-wrapper emission;
    // see _emitTypedReturn.
    _emitTypedReturn(buffer, returnType, 'result', methodName,
        indent: '          ');
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
  List<String> typeParameterReplacements = const [],
]) {
  if (params.isEmpty) return '';

  final parts = <String>[];
  final positional = params.where((p) => !p.isNamed && !p.isOptionalPositional);
  final optionalPositional = params.where((p) => p.isOptionalPositional);
  final named = params.where((p) => p.isNamed);

  for (final p in positional) {
    parts.add('${_eraseTypeParams(p.type, typeParameterNames, typeParameterReplacements)} ${p.name}');
  }
  if (optionalPositional.isNotEmpty) {
    final optParts = optionalPositional.map(
      (p) => '${_eraseTypeParams(p.type, typeParameterNames, typeParameterReplacements)} ${p.name}',
    );
    parts.add('[${optParts.join(', ')}]');
  }
  if (named.isNotEmpty) {
    final namedParts = named.map((p) {
      final req = p.isRequired ? 'required ' : '';
      return '$req${_eraseTypeParams(p.type, typeParameterNames, typeParameterReplacements)} ${p.name}';
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
String _eraseTypeParams(
  String type,
  List<String> typeParamNames, [
  List<String>? replacements,
]) {
  if (typeParamNames.isEmpty) return type;

  var result = type;
  for (var i = 0; i < typeParamNames.length; i++) {
    final tp = typeParamNames[i];
    final repl =
        (replacements != null && i < replacements.length) ? replacements[i] : 'dynamic';
    // Use word-boundary matching to only replace standalone type param names,
    // not substrings of other identifiers (e.g., 'Type' should not become
    // 'dynamicype').
    result = result.replaceAllMapped(
      RegExp('\\b${RegExp.escape(tp)}\\b'),
      (_) => repl,
    );
  }
  return result;
}
