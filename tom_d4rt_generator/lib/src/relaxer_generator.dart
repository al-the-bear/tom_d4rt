/// D4rt Relaxer Generator — Auto-generates GEN-079 type-relaxing wrappers.
///
/// Generates relaxer wrappers from pre-collected data gathered during bridge
/// code generation and the analyzer. The bridge generator records generic
/// extraction sites (e.g., `extractBridgedArg<Animation<double>>`) and GEN-075
/// class names during code emission, then passes them to this generator.
///
/// Produces:
///
/// 1. **Wrapper classes** (`$RelaxedAnimation<V>`, `$RelaxedValueNotifier<V>`, …)
///    that extend or implement the generic base type with correct delegation.
/// 2. **Per-module factory functions** with switch-based type-arg dispatch.
/// 3. **A `registerRelaxers()` function** that registers all factories with
///    `D4.registerGenericTypeWrapper()`.
///
/// See `doc/generics_wrapper_and_type_relaxation_strategy.md` for the full
/// design rationale and architecture.
library;

import 'dart:io';

import 'package:path/path.dart' as p;

import 'bridge_config.dart';
import 'bridge_generator.dart'
    show ClassInfo, ConstructorInfo, GenericExtractionSite, MemberInfo,
         ParameterInfo;
import 'file_generators.dart' show ensureBDartExtension;

// =============================================================================
// Result types
// =============================================================================

/// Result of relaxer generation.
class RelaxerGenerationResult {
  /// The output file path written (null if generation was skipped).
  final String? outputFile;

  /// Number of wrapper classes generated.
  final int wrapperClassesGenerated;

  /// Number of factory functions generated.
  final int factoryFunctionsGenerated;

  /// Errors that prevented generation.
  final List<String> errors;

  /// Non-fatal warnings.
  final List<String> warnings;

  const RelaxerGenerationResult({
    this.outputFile,
    this.wrapperClassesGenerated = 0,
    this.factoryFunctionsGenerated = 0,
    this.errors = const [],
    this.warnings = const [],
  });

  bool get isSuccess => errors.isEmpty;
}

/// Collected information about a generic base type that needs a relaxer.
class _RelaxerTarget {
  /// The unparameterized class name (e.g., 'ValueNotifier').
  final String baseTypeName;

  /// ClassInfo from the global lookup (may be null if not found).
  final ClassInfo? classInfo;

  /// Whether this class has GEN-075 constructor switches (D4rt constructs it).
  final bool hasConstructorSwitch;

  /// Per-module type arguments: moduleName → `Set<innerTypeArgString>`.
  final Map<String, Set<String>> moduleTypeArgs;

  _RelaxerTarget({
    required this.baseTypeName,
    this.classInfo,
    this.hasConstructorSwitch = false,
    Map<String, Set<String>>? moduleTypeArgs,
  }) : moduleTypeArgs = moduleTypeArgs ?? {};

  /// All unique non-dynamic type args across all modules.
  Set<String> get allTypeArgs =>
      moduleTypeArgs.values.expand((s) => s).toSet();
}

// =============================================================================
// Main entry point
// =============================================================================

/// Generates relaxer wrapper classes and factory functions.
///
/// Uses pre-collected data from the bridge generator rather than scanning
/// generated files. The bridge generator records generic extraction sites
/// and GEN-075 class names during code emission.
///
/// Parameters:
/// - [config]: The bridge configuration.
/// - [projectPath]: Absolute path to the project root.
/// - [globalClassLookup]: Map of class name → ClassInfo from the orchestrator.
/// - [genericExtractionSites]: Pre-collected generic extraction sites from bridge generation.
/// - [gen075Classes]: Class names with GEN-075 type-dispatch constructor switches.
/// - [onWarning]: Optional callback for non-fatal warnings.
Future<RelaxerGenerationResult> generateRelaxers({
  required BridgeConfig config,
  required String projectPath,
  required Map<String, ClassInfo> globalClassLookup,
  List<GenericExtractionSite> genericExtractionSites = const [],
  Set<String> gen075Classes = const {},
  void Function(String)? onWarning,
}) async {
  // relaxerOutputPath always has a value (auto-derived default), but guard
  // for programmatic callers who pass a config with the constructor default.
  final outputPath = config.relaxerOutputPath;

  final errors = <String>[];
  final warnings = <String>[];

  void warn(String msg) {
    warnings.add(msg);
    onWarning?.call(msg);
  }

  // -------------------------------------------------------------------------
  // Step 1: Use pre-collected generic extraction sites from bridge generator
  // -------------------------------------------------------------------------
  if (genericExtractionSites.isEmpty) {
    warn('No generic extraction sites collected during bridge generation');
    return RelaxerGenerationResult(warnings: warnings);
  }

  // -------------------------------------------------------------------------
  // Step 2: Build RelaxerTarget list from pre-collected extraction data
  // -------------------------------------------------------------------------
  final targets = _buildRelaxerTargets(
    genericExtractionSites,
    globalClassLookup,
    gen075Classes,
    warn,
  );

  if (targets.isEmpty) {
    warn('No relaxer targets identified after filtering');
    return RelaxerGenerationResult(warnings: warnings);
  }

  // -------------------------------------------------------------------------
  // Step 3: Generate the output file
  // -------------------------------------------------------------------------
  final buffer = StringBuffer();

  // Header
  _writeFileHeader(buffer, config);

  // Imports — collect from module barrel URIs
  _writeImports(buffer, config);

  // Wrapper classes
  var wrappersGenerated = 0;
  for (final target in targets) {
    if (target.classInfo == null) {
      warn('No ClassInfo for ${target.baseTypeName} — skipping wrapper');
      continue;
    }
    // Only generate wrappers for single-type-parameter classes
    if (target.classInfo!.typeParameters.length != 1) {
      warn(
        '${target.baseTypeName} has ${target.classInfo!.typeParameters.length} '
        'type params — skipping wrapper (only single-param supported)',
      );
      continue;
    }
    final wrapperCode = _generateWrapperClass(
      target.baseTypeName,
      target.classInfo!,
      globalClassLookup,
      warn,
    );
    if (wrapperCode != null) {
      buffer.writeln(wrapperCode);
      wrappersGenerated++;
    }
  }

  // Per-module factory functions
  var factoriesGenerated = 0;
  final factoryNames = <String, List<String>>{}; // baseType → [factoryNames]
  for (final target in targets) {
    if (target.classInfo == null) continue;
    if (target.classInfo!.typeParameters.length != 1) continue;

    for (final entry in target.moduleTypeArgs.entries) {
      final moduleName = entry.key;
      final typeArgs = entry.value;
      if (typeArgs.isEmpty) continue;

      final funcName = _factoryFunctionName(target.baseTypeName, moduleName);
      final code = _generateFactoryFunction(
        target.baseTypeName,
        moduleName,
        typeArgs,
        funcName,
      );
      if (code.isEmpty) continue; // All type args were filtered (e.g., self-referential bounds)
      buffer.writeln(code);
      factoriesGenerated++;
      (factoryNames[target.baseTypeName] ??= []).add(funcName);
    }
  }

  // Scan for user-defined relaxer extensions
  final userRelaxers = scanUserRelaxers(
    outputPath,
    projectPath,
    warn,
  );

  // Add user relaxer imports if any exist
  if (userRelaxers.isNotEmpty) {
    // Insert user imports into the import section (before wrapper classes)
    // We generate the import at the top of the file by prepending
    final userImportBuf = StringBuffer();
    final importedUris = <String>{};
    for (final entry in userRelaxers) {
      if (importedUris.add(entry.importUri)) {
        userImportBuf.writeln("import '${entry.importUri}';");
      }
    }
    // Note: We insert user imports inline with the generated code.
    // The import block was already written to buffer, so we prepend
    // user relaxer registrations to the registration function.
    for (final entry in userRelaxers) {
      (factoryNames[entry.baseTypeName] ??= []).add(entry.factoryFunctionName);
    }
  }

  // Registration function
  _writeRegistrationFunction(buffer, factoryNames);

  // -------------------------------------------------------------------------
  // Step 3b: Generate RC-2 generic constructor registrations
  // -------------------------------------------------------------------------
  final genericCtorCount = _writeGenericConstructorSection(
    buffer,
    globalClassLookup,
    warn,
  );

  // -------------------------------------------------------------------------
  // Step 4: Write the output file (only if there are actual wrappers)
  // -------------------------------------------------------------------------
  if (wrappersGenerated == 0 && factoriesGenerated == 0 &&
      userRelaxers.isEmpty && genericCtorCount == 0) {
    // Nothing to generate — don't create an empty file.
    return RelaxerGenerationResult(warnings: warnings);
  }

  final outputFilePath = p.join(
    projectPath,
    ensureBDartExtension(outputPath),
  );
  final outputDir = Directory(p.dirname(outputFilePath));
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }
  await File(outputFilePath).writeAsString(buffer.toString());

  print(
    '  RELAXER: Generated $wrappersGenerated wrapper classes, '
    '$factoriesGenerated factory functions, '
    '$genericCtorCount generic constructor registrations → $outputFilePath',
  );

  return RelaxerGenerationResult(
    outputFile: outputFilePath,
    wrapperClassesGenerated: wrappersGenerated,
    factoryFunctionsGenerated: factoriesGenerated,
    errors: errors,
    warnings: warnings,
  );
}

// =============================================================================
// Step 2: Building relaxer targets
// =============================================================================

/// Builds the list of [_RelaxerTarget] from pre-collected extraction sites.
///
/// Groups extractions by base type, resolves ClassInfo from the global lookup,
/// and marks classes with GEN-075 constructor switches.
List<_RelaxerTarget> _buildRelaxerTargets(
  List<GenericExtractionSite> extractions,
  Map<String, ClassInfo> globalClassLookup,
  Set<String> gen075Classes,
  void Function(String) warn,
) {
  // Group by base type → module → Set<typeArg>
  final grouped = <String, Map<String, Set<String>>>{};
  for (final site in extractions) {
    // Skip 'dynamic' — no mismatch possible
    if (site.typeArg == 'dynamic') continue;

    final moduleMap = grouped.putIfAbsent(site.baseTypeName, () => {});
    moduleMap.putIfAbsent(site.moduleName, () => {}).add(site.typeArg);
  }

  final targets = <_RelaxerTarget>[];
  for (final entry in grouped.entries) {
    final baseTypeName = entry.key;
    final moduleTypeArgs = entry.value;

    // Skip Dart core collection types — these are handled by .cast() in the
    // bridge generator, not by relaxer wrappers.
    if (_dartCoreGenericTypes.contains(baseTypeName)) continue;

    final classInfo = globalClassLookup[baseTypeName];
    if (classInfo == null) {
      warn(
        'No ClassInfo for generic base type "$baseTypeName" '
        '— it may be from dart:core or an unscanned package',
      );
    }

    targets.add(
      _RelaxerTarget(
        baseTypeName: baseTypeName,
        classInfo: classInfo,
        hasConstructorSwitch: gen075Classes.contains(baseTypeName),
        moduleTypeArgs: moduleTypeArgs,
      ),
    );
  }

  // Sort by name for deterministic output
  targets.sort((a, b) => a.baseTypeName.compareTo(b.baseTypeName));
  return targets;
}

/// Dart core generic types that the bridge generator already handles with
/// `.cast()` conversions rather than relaxer wrappers.
const _dartCoreGenericTypes = {
  'List',
  'Set',
  'Map',
  'Iterable',
  'Iterator',
  'Future',
  'Stream',
  'Comparable',
};

// =============================================================================
// Step 3a: File header and imports
// =============================================================================

void _writeFileHeader(StringBuffer buffer, BridgeConfig config) {
  buffer.writeln('/// D4rt GEN-079 Relaxer Wrappers for ${config.name}');
  buffer.writeln('///');
  buffer.writeln(
    '/// Auto-generated wrapper classes and factory functions for generic',
  );
  buffer.writeln(
    '/// type relaxation. These enable `extractBridgedArg<Base<Arg>>` to',
  );
  buffer.writeln(
    '/// succeed when the runtime value has `<dynamic>` type arguments.',
  );
  buffer.writeln('///');
  buffer.writeln('/// DO NOT EDIT — generated by d4rtgen relaxer generator.');
  buffer.writeln('library;');
  buffer.writeln();
  buffer.writeln('// ignore_for_file: unused_import');
  buffer.writeln('// ignore_for_file: invalid_implementation_override');
  buffer.writeln();
}

void _writeImports(StringBuffer buffer, BridgeConfig config) {
  // Import D4 runtime for registration
  final d4rtImport = config.d4rtImport ?? 'package:tom_d4rt/d4rt.dart';
  buffer.writeln("import '$d4rtImport' show D4;");
  buffer.writeln();

  // Import all barrel files from modules to get access to all types
  final dartImports = <String>[];
  final packageImports = <String>[];

  for (final module in config.modules) {
    final barrel = module.barrelImport;
    if (barrel == null) continue;
    if (barrel.startsWith('dart:')) {
      if (!dartImports.contains(barrel)) dartImports.add(barrel);
    } else if (barrel.startsWith('package:')) {
      if (!packageImports.contains(barrel)) packageImports.add(barrel);
    }
  }

  dartImports.sort();
  packageImports.sort();

  for (final uri in dartImports) {
    buffer.writeln("import '$uri';");
  }
  if (dartImports.isNotEmpty) buffer.writeln();
  for (final uri in packageImports) {
    buffer.writeln("import '$uri';");
  }
  buffer.writeln();
}

// =============================================================================
// Step 3b: Wrapper class generation
// =============================================================================

/// Generates a `$Relaxed{BaseType}<V>` wrapper class from ClassInfo.
///
/// Returns the generated code as a string, or null if generation fails.
String? _generateWrapperClass(
  String baseTypeName,
  ClassInfo classInfo,
  Map<String, ClassInfo> globalClassLookup,
  void Function(String) warn,
) {
  final typeParamName = classInfo.typeParameters.keys.first;
  final typeParamBound = classInfo.typeParameters.values.first;
  final wrapperName = '\$Relaxed$baseTypeName';

  // Determine extends vs implements
  final useExtends = _canExtend(classInfo, globalClassLookup, typeParamName);

  final buf = StringBuffer();

  // Bound declaration (e.g., `<V extends Object>` or just `<V>`)
  // Replace the original type param name with V in the bound too (handles
  // self-referential bounds like ThemeExtension<T extends ThemeExtension<T>>)
  final rawBound = typeParamBound != null
      ? _replaceTypeParam(typeParamBound, typeParamName, 'V')
      : null;
  final boundDecl = rawBound != null ? '<V extends $rawBound>' : '<V>';
  final keyword = useExtends ? 'extends' : 'implements';

  buf.writeln('// ---------------------------------------------------------------------------');
  buf.writeln('// $wrapperName');
  buf.writeln('// ---------------------------------------------------------------------------');
  buf.writeln();
  buf.writeln('/// Auto-generated GEN-079 relaxer wrapper for $baseTypeName<V>.');
  buf.writeln('class $wrapperName$boundDecl $keyword $baseTypeName<V> {');
  buf.writeln('  final $baseTypeName _inner;');

  // Detect ChangeNotifier pattern for bidirectional sync
  final isChangeNotifier = _isChangeNotifierSubclass(
    classInfo,
    globalClassLookup,
  );

  if (isChangeNotifier) {
    buf.writeln('  bool _syncing = false;');
  }

  buf.writeln();

  // Constructor
  _writeConstructor(
    buf,
    wrapperName,
    baseTypeName,
    classInfo,
    globalClassLookup,
    typeParamName,
    useExtends,
    isChangeNotifier,
  );

  // Listener forwarding for ChangeNotifier subclasses
  if (isChangeNotifier && useExtends) {
    buf.writeln();
    buf.writeln('  /// Forward notifications from _inner → wrapper.');
    buf.writeln('  void _forwardNotify() {');
    buf.writeln('    if (!_syncing) {');
    buf.writeln('      _syncing = true;');

    // Find the primary T-valued getter (usually 'value')
    final tGetter = _findPrimaryTGetter(classInfo, globalClassLookup, typeParamName);
    if (tGetter != null) {
      buf.writeln('      super.${tGetter.name} = _inner.${tGetter.name} as V;');
    } else {
      buf.writeln('      notifyListeners();');
    }

    buf.writeln('      _syncing = false;');
    buf.writeln('    }');
    buf.writeln('  }');
  }

  // Member overrides
  final tPattern = RegExp('\\b${RegExp.escape(typeParamName)}\\b');

  // Collect all instance members (including inherited)
  final allGetters = classInfo.allInstanceGetters(globalClassLookup);
  final allSetters = classInfo.allInstanceSetters(globalClassLookup);
  final allMethods = classInfo.allInstanceMethods(globalClassLookup);

  // Filter to members involving T (or abstract members we must override)
  final tGetters = allGetters.where(
    (m) => tPattern.hasMatch(m.returnType),
  ).toList();

  final tSetters = allSetters.where(
    (m) => m.parameters.any((p) => tPattern.hasMatch(p.type)),
  ).toList();

  final tMethods = allMethods.where(
    (m) =>
        tPattern.hasMatch(m.returnType) ||
        m.parameters.any((p) => tPattern.hasMatch(p.type)),
  ).toList();

  // For `implements`, we also need to override all abstract non-T members.
  // For `extends`, we only override T-involving members.
  // In practice, for the relaxer wrapper, overriding T-involving members
  // is the core requirement. Non-T abstract members are handled by the base
  // class (for extends) or need delegation (for implements).
  if (!useExtends) {
    // For implements: add noSuchMethod to suppress unimplemented member errors,
    // then only override T-involving members that need type casts.
    // Dart's implicit noSuchMethod forwarders handle all other interface members.
    _writeImplementsDelegation(
      buf,
      classInfo,
      globalClassLookup,
      typeParamName,
      tPattern,
      tGetters,
      tSetters,
      tMethods,
    );
  } else {
    // For extends: only override T-involving members
    _writeExtendsDelegation(
      buf,
      tGetters,
      tSetters,
      tMethods,
      typeParamName,
      isChangeNotifier,
    );
  }

  // Dispose override for ChangeNotifier subclasses
  if (isChangeNotifier && useExtends) {
    buf.writeln();
    buf.writeln('  @override');
    buf.writeln('  void dispose() {');
    buf.writeln('    _inner.removeListener(_forwardNotify);');
    buf.writeln('    super.dispose();');
    buf.writeln('  }');
  }

  buf.writeln('}');
  buf.writeln();

  return buf.toString();
}

/// Whether the class can be extended (has a suitable constructor).
///
/// Returns false for abstract classes, sealed classes, and classes without
/// a suitable unnamed constructor. Also rejects constructors with required
/// positional parameters that can't be satisfied from `_inner`, such as:
/// - More than 1 required positional param
/// - A T-typed required positional param with no public T-getter to source
///   the value from (e.g., DisposableBuildContext stores T in a private field)
bool _canExtend(
  ClassInfo classInfo,
  Map<String, ClassInfo> classLookup,
  String typeParamName,
) {
  if (classInfo.isAbstract || classInfo.isSealed) return false;
  if (classInfo.constructors.isEmpty) return false;

  final tPattern = RegExp('\\b${RegExp.escape(typeParamName)}\\b');

  // Check for default or simple constructor
  for (final ctor in classInfo.constructors) {
    if (ctor.isFactory) continue;
    if (ctor.name != null) continue; // Only unnamed constructors

    final requiredPositional = ctor.parameters
        .where((p) => p.isRequired && !p.isNamed)
        .toList();

    // Reject constructors with >1 required positional param
    if (requiredPositional.length > 1) return false;

    // If the single required positional param involves T, verify we can get
    // the value from _inner via a public getter
    if (requiredPositional.length == 1 &&
        tPattern.hasMatch(requiredPositional.first.type)) {
      final tGetter = _findPrimaryTGetter(classInfo, classLookup, typeParamName);
      if (tGetter == null) return false; // Can't source T value
    }

    return true;
  }

  return false;
}

/// Checks if the class is a ChangeNotifier subclass by walking the
/// inheritance chain.
bool _isChangeNotifierSubclass(
  ClassInfo classInfo,
  Map<String, ClassInfo> classLookup,
) {
  var current = classInfo;
  final visited = <String>{};

  while (true) {
    if (current.name == 'ChangeNotifier') return true;
    if (current.superclass == null) return false;
    if (visited.contains(current.name)) return false; // cycle guard
    visited.add(current.name);

    final parent = classLookup[current.superclass];
    if (parent == null) {
      // Check by name only (might not be in lookup)
      return current.superclass == 'ChangeNotifier';
    }
    current = parent;
  }
}

/// Checks if the class is a Listenable subclass by walking the chain.
// ignore: unused_element
bool _isListenableSubclass(
  ClassInfo classInfo,
  Map<String, ClassInfo> classLookup,
) {
  var current = classInfo;
  final visited = <String>{};

  while (true) {
    if (current.name == 'Listenable' || current.name == 'Animation') {
      return true;
    }
    if (current.superclass == null) return false;
    if (visited.contains(current.name)) return false;
    visited.add(current.name);

    final parent = classLookup[current.superclass];
    if (parent == null) {
      return const {'Listenable', 'Animation', 'ChangeNotifier'}
          .contains(current.superclass);
    }
    current = parent;
  }
}

/// Finds the primary T-valued getter (typically 'value') for ChangeNotifier.
MemberInfo? _findPrimaryTGetter(
  ClassInfo classInfo,
  Map<String, ClassInfo> classLookup,
  String typeParamName,
) {
  final tPattern = RegExp('\\b${RegExp.escape(typeParamName)}\\b');
  final allGetters = classInfo.allInstanceGetters(classLookup);

  // Prefer 'value' if it exists and involves T
  for (final g in allGetters) {
    if (g.name == 'value' && tPattern.hasMatch(g.returnType)) return g;
  }

  // Otherwise return the first T-involving getter
  for (final g in allGetters) {
    if (tPattern.hasMatch(g.returnType)) return g;
  }

  return null;
}

/// Writes the constructor for the wrapper class.
void _writeConstructor(
  StringBuffer buf,
  String wrapperName,
  String baseTypeName,
  ClassInfo classInfo,
  Map<String, ClassInfo> classLookup,
  String typeParamName,
  bool useExtends,
  bool isChangeNotifier,
) {
  final tPattern = RegExp('\\b${RegExp.escape(typeParamName)}\\b');

  if (!useExtends) {
    // implements → simple constructor, no super call
    buf.writeln('  $wrapperName(this._inner);');
    return;
  }

  // extends → need super call
  final defaultCtor = classInfo.constructors
      .where((c) => !c.isFactory && c.name == null)
      .firstOrNull;

  if (defaultCtor == null) {
    // No default constructor — shouldn't happen since _canExtend checks this
    buf.writeln('  $wrapperName(this._inner);');
    return;
  }

  // Check if constructor has T-typed required parameters.
  // Only match when T IS the param type (possibly nullable), not when T
  // appears inside a complex type like `T Function()` or `Container<T>`.
  final exactTPattern = RegExp('^${RegExp.escape(typeParamName)}\\??\$');
  final requiredParams = defaultCtor.parameters.where((p) => p.isRequired);
  final hasTPosParam = requiredParams.any(
    (p) => !p.isNamed && exactTPattern.hasMatch(p.type.trim()),
  );

  if (defaultCtor.parameters.isEmpty) {
    // Parameterless constructor
    buf.writeln('  $wrapperName(this._inner)${isChangeNotifier ? ' {' : ';'}');
    if (isChangeNotifier) {
      buf.writeln('    _inner.addListener(_forwardNotify);');
      buf.writeln('  }');
    }
  } else if (hasTPosParam) {
    // Constructor takes T value — pass _inner's primary value
    final tGetter = _findPrimaryTGetter(classInfo, classLookup, typeParamName);
    if (tGetter == null) {
      // Can't find a suitable T-typed getter — treat as implements instead.
      // This returns null to signal the caller to switch strategies.
      // For now, use a safe fallback constructor.
      buf.writeln('  $wrapperName(this._inner) : super(_inner as V) {');
    } else {
      final valueExpr = '_inner.${tGetter.name} as V';
      buf.writeln('  $wrapperName(this._inner) : super($valueExpr) {');
    }
    if (isChangeNotifier) {
      buf.writeln('    _inner.addListener(_forwardNotify);');
    }
    buf.writeln('  }');
  } else {
    // Constructor has required params — forward from _inner with casts
    // for T-involving parameters.
    final args = <String>[];
    for (final param in defaultCtor.parameters.where((p) => p.isRequired)) {
      final involvesT = tPattern.hasMatch(param.type);
      final castExpr = involvesT ? ' as ${_replaceTypeParam(param.type, typeParamName, 'V')}' : '';
      if (param.isNamed) {
        args.add('${param.name}: _inner.${param.name}$castExpr');
      } else {
        args.add('_inner.${param.name}$castExpr');
      }
    }
    buf.writeln(
      '  $wrapperName(this._inner) : super(${args.join(', ')})${isChangeNotifier ? ' {' : ';'}',
    );
    if (isChangeNotifier) {
      buf.writeln('    _inner.addListener(_forwardNotify);');
      buf.writeln('  }');
    }
  }
}

/// Writes member overrides for `extends` wrappers (only T-involving members).
void _writeExtendsDelegation(
  StringBuffer buf,
  List<MemberInfo> tGetters,
  List<MemberInfo> tSetters,
  List<MemberInfo> tMethods,
  String typeParamName,
  bool isChangeNotifier,
) {
  for (final getter in tGetters) {
    final castReturn = _replaceTypeParam(getter.returnType, typeParamName, 'V');
    buf.writeln();
    buf.writeln('  @override');
    buf.writeln(
      '  $castReturn get ${getter.name} => _inner.${getter.name} as $castReturn;',
    );
  }

  for (final setter in tSetters) {
    final param = setter.parameters.first;
    final castType = _replaceTypeParam(param.type, typeParamName, 'V');
    buf.writeln();
    buf.writeln('  @override');
    if (isChangeNotifier) {
      buf.writeln('  set ${setter.name}($castType ${param.name}) {');
      buf.writeln('    if (!_syncing) {');
      buf.writeln('      _syncing = true;');
      buf.writeln('      _inner.${setter.name} = ${param.name};');
      buf.writeln('      super.${setter.name} = ${param.name};');
      buf.writeln('      _syncing = false;');
      buf.writeln('    }');
      buf.writeln('  }');
    } else {
      buf.writeln(
        '  set ${setter.name}($castType ${param.name}) { _inner.${setter.name} = ${param.name}; }',
      );
    }
  }

  for (final method in tMethods) {
    // Skip methods with their own type parameters — these can't be properly
    // delegated without matching the generic signature (e.g., drive<U>)
    if (method.hasTypeParameters) continue;

    final castReturn =
        _replaceTypeParam(method.returnType, typeParamName, 'V');
    final paramSig = _buildMethodParamSignature(method, typeParamName);
    final callArgs = _buildMethodCallArgs(method);
    final needsCast = RegExp('\\b${RegExp.escape(typeParamName)}\\b')
        .hasMatch(method.returnType);

    buf.writeln();
    buf.writeln('  @override');
    if (method.returnType == 'void') {
      buf.writeln(
        '  void ${method.name}($paramSig) => _inner.${method.name}($callArgs);',
      );
    } else if (needsCast) {
      buf.writeln(
        '  $castReturn ${method.name}($paramSig) => _inner.${method.name}($callArgs) as $castReturn;',
      );
    } else {
      buf.writeln(
        '  ${method.returnType} ${method.name}($paramSig) => _inner.${method.name}($callArgs);',
      );
    }
  }
}

/// Writes member overrides for `implements` wrappers.
///
/// Uses Dart's implicit noSuchMethod forwarding: by overriding `noSuchMethod`,
/// unimplemented interface members get automatic stub methods that call
/// `noSuchMethod` instead of producing compilation errors. We only explicitly
/// override T-involving members that need type casts.
void _writeImplementsDelegation(
  StringBuffer buf,
  ClassInfo classInfo,
  Map<String, ClassInfo> classLookup,
  String typeParamName,
  RegExp tPattern,
  List<MemberInfo> tGetters,
  List<MemberInfo> tSetters,
  List<MemberInfo> tMethods,
) {
  // noSuchMethod override — suppresses all unimplemented member errors.
  // At runtime, unimplemented members throw NoSuchMethodError which is
  // acceptable since bridge code only accesses T-involving members.
  buf.writeln();
  buf.writeln('  @override');
  buf.writeln('  dynamic noSuchMethod(Invocation invocation) =>');
  buf.writeln('    super.noSuchMethod(invocation);');
  buf.writeln();

  // GEN-079: Detect if the class hierarchy has a non-standard toString
  // signature (e.g., Diagnosticable.toString({DiagnosticLevel minLevel})).
  // Object.toString() is already concrete, so noSuchMethod can't handle it.
  // We generate an override only when the analyzer data shows parameters.
  final toStringOverride = _findNonStandardToString(
    classInfo,
    classLookup,
  );
  if (toStringOverride != null) {
    buf.writeln('  @override');
    buf.writeln('  String toString($toStringOverride) =>');
    buf.writeln("    _inner.toString();");
    buf.writeln();
  }

  // Override T-involving getters with cast
  for (final getter in tGetters) {
    final castReturn = _replaceTypeParam(getter.returnType, typeParamName, 'V');
    buf.writeln('  @override');
    buf.writeln(
      '  $castReturn get ${getter.name} => _inner.${getter.name} as $castReturn;',
    );
    buf.writeln();
  }

  // Override T-involving setters
  for (final setter in tSetters) {
    final param = setter.parameters.first;
    final castType = _replaceTypeParam(param.type, typeParamName, 'V');
    buf.writeln('  @override');
    buf.writeln(
      '  set ${setter.name}($castType ${param.name}) { _inner.${setter.name} = ${param.name}; }',
    );
    buf.writeln();
  }

  // Override T-involving methods (skip methods with method-level type params)
  for (final method in tMethods) {
    // Skip methods with their own type parameters — these can't be properly
    // delegated without matching the generic signature
    if (method.hasTypeParameters) continue;

    final castReturn =
        _replaceTypeParam(method.returnType, typeParamName, 'V');
    final paramSig = _buildMethodParamSignature(method, typeParamName);
    final callArgs = _buildMethodCallArgs(method);
    final needsCast = tPattern.hasMatch(method.returnType);

    buf.writeln('  @override');
    if (method.returnType == 'void') {
      buf.writeln(
        '  void ${method.name}($paramSig) => _inner.${method.name}($callArgs);',
      );
    } else if (needsCast) {
      buf.writeln(
        '  $castReturn ${method.name}($paramSig) => _inner.${method.name}($callArgs) as $castReturn;',
      );
    } else {
      buf.writeln(
        '  ${method.returnType} ${method.name}($paramSig) => _inner.${method.name}($callArgs);',
      );
    }
    buf.writeln();
  }
}

// =============================================================================
// Step 3c: Factory function generation
// =============================================================================

/// Generates a per-module factory function.
///
/// Example output:
/// ```dart
/// Object? _relaxValueNotifier$widgets(Object value, String innerTypeArg) {
///   if (value is! ValueNotifier) return null;
///   return switch (innerTypeArg) {
///     'MagnifierInfo' => $RelaxedValueNotifier<MagnifierInfo>(value),
///     'EdgeInsets' => $RelaxedValueNotifier<EdgeInsets>(value),
///     _ => null,
///   };
/// }
/// ```
String _generateFactoryFunction(
  String baseTypeName,
  String moduleName,
  Set<String> typeArgs,
  String funcName,
) {
  final wrapperName = '\$Relaxed$baseTypeName';
  // Filter out type args that reference the base type itself (self-referential
  // bounds like ThemeExtension<ThemeExtension<T>> produce invalid factory cases).
  // Use word-boundary matching to avoid false positives (e.g., "StatefulWidget"
  // should NOT be filtered for base type "State").
  final selfRefPattern = RegExp('\\b${RegExp.escape(baseTypeName)}\\b');
  final sortedArgs = typeArgs
      .where((arg) => !selfRefPattern.hasMatch(arg))
      .toList()
    ..sort();

  // If all args were filtered, skip this factory entirely
  if (sortedArgs.isEmpty) return '';

  final buf = StringBuffer();
  buf.writeln(
    '/// Auto-generated relaxer factory for $baseTypeName — $moduleName layer types.',
  );
  buf.writeln(
    'Object? $funcName(Object value, String innerTypeArg) {',
  );
  buf.writeln('  if (value is! $baseTypeName) return null;');
  buf.writeln('  return switch (innerTypeArg) {');

  for (final arg in sortedArgs) {
    buf.writeln("    '$arg' => $wrapperName<$arg>(value),");
  }

  buf.writeln('    _ => null,');
  buf.writeln('  };');
  buf.writeln('}');
  buf.writeln();

  return buf.toString();
}

/// Generates the factory function name: `_relax{Base}${module}`.
String _factoryFunctionName(String baseTypeName, String moduleName) {
  // Clean module name: flutter_foundation → foundation, dart_ui → dartUi
  final cleanModule = moduleName
      .replaceAll(RegExp(r'^flutter_'), '')
      .replaceAll(RegExp(r'^dart_'), 'dart')
      .replaceAllMapped(
        RegExp(r'_(\w)'),
        (m) => m.group(1)!.toUpperCase(),
      );
  return '_relax$baseTypeName\$$cleanModule';
}

// =============================================================================
// Step 3d: Registration function
// =============================================================================

/// Writes the `registerRelaxers()` function.
void _writeRegistrationFunction(
  StringBuffer buffer,
  Map<String, List<String>> factoryNames,
) {
  buffer.writeln('// =============================================================================');
  buffer.writeln('// Registration');
  buffer.writeln('// =============================================================================');
  buffer.writeln();
  buffer.writeln('/// Register all auto-generated relaxer factories with the D4 runtime.');
  buffer.writeln('///');
  buffer.writeln('/// Call this once during bridge setup — replaces the old hand-written');
  buffer.writeln('/// `registerGenericTypeRelaxers()` function.');
  buffer.writeln('void registerRelaxers() {');

  // Sort by base type for deterministic output
  final sortedBaseTypes = factoryNames.keys.toList()..sort();
  for (final baseType in sortedBaseTypes) {
    final names = factoryNames[baseType]!;
    for (final funcName in names) {
      buffer.writeln(
        "  D4.registerGenericTypeWrapper('$baseType', $funcName);",
      );
    }
  }

  buffer.writeln('}');
  buffer.writeln();
}

// =============================================================================
// Step 4: User relaxer scanner
// =============================================================================

/// A discovered user-defined relaxer extension.
class UserRelaxerEntry {
  /// The base type name this relaxer handles (e.g., 'MyGenericType').
  final String baseTypeName;

  /// The factory function name from the user file.
  final String factoryFunctionName;

  /// Import URI for the user relaxer file.
  final String importUri;

  const UserRelaxerEntry({
    required this.baseTypeName,
    required this.factoryFunctionName,
    required this.importUri,
  });
}

/// Scans for user-defined relaxer files matching `*_user_relaxer.dart`
/// in the `user_relaxers/` subdirectory relative to the relaxer output path.
///
/// User relaxer files allow hand-written relaxer factories for types that
/// the auto-generator can't handle (e.g., multi-type-parameter generics,
/// special construction patterns).
///
/// Expected file structure:
/// ```dart
/// // my_type_user_relaxer.dart
/// Object? relaxMyType(Object value, String innerTypeArg) {
///   // Custom relaxer logic
/// }
/// ```
///
/// The scanner looks for top-level functions matching `relax{TypeName}`.
List<UserRelaxerEntry> scanUserRelaxers(
  String relaxerOutputPath,
  String projectPath,
  void Function(String) warn,
) {
  final results = <UserRelaxerEntry>[];
  final outputDir = p.dirname(p.join(projectPath, relaxerOutputPath));
  final userRelaxerDir = Directory(p.join(outputDir, 'user_relaxers'));

  if (!userRelaxerDir.existsSync()) return results;

  final relaxerFiles = userRelaxerDir
      .listSync()
      .whereType<File>()
      .where((f) => f.path.endsWith('_user_relaxer.dart'));

  final funcPattern = RegExp(
    r'^\s*Object\?\s+(relax\w+)\s*\(',
    multiLine: true,
  );

  for (final file in relaxerFiles) {
    try {
      final content = file.readAsStringSync();
      final matches = funcPattern.allMatches(content);

      for (final match in matches) {
        final funcName = match.group(1)!;
        // Extract base type from function name: relax{TypeName} → TypeName
        if (funcName.length <= 5) continue; // 'relax' + at least 1 char
        final baseTypeName = funcName.substring(5); // Strip 'relax'

        // Compute import URI relative to the project
        final relativePath = p.relative(file.path, from: projectPath);
        final importUri = 'package:${p.split(relativePath).skip(1).join('/')}';

        results.add(
          UserRelaxerEntry(
            baseTypeName: baseTypeName,
            factoryFunctionName: funcName,
            importUri: importUri,
          ),
        );
      }
    } catch (e) {
      warn('Failed to scan user relaxer ${file.path}: $e');
    }
  }

  return results;
}

// =============================================================================
// Helper functions
// =============================================================================

/// Checks if the class hierarchy has a `toString` with a non-standard
/// signature (i.e., with parameters beyond Object's parameterless `toString()`).
///
/// Returns the parameter signature string (e.g., `{dynamic minLevel}`) if a
/// non-standard toString is found, or null if `Object.toString()` suffices.
///
/// This replaces the previous hardcoded `toString({dynamic minLevel})` override
/// that was specific to Flutter's `Diagnosticable` hierarchy. Now it detects
/// the actual signature from the analyzer data.
String? _findNonStandardToString(
  ClassInfo classInfo,
  Map<String, ClassInfo> classLookup,
) {
  // Walk the inheritance chain looking for a toString with parameters
  final allMethods = classInfo.allInstanceMethods(classLookup);
  for (final method in allMethods) {
    if (method.name == 'toString' && method.parameters.isNotEmpty) {
      // Found a toString with parameters — build the parameter signature
      // Use 'dynamic' for parameter types to avoid import dependencies
      // in the generated relaxer file.
      final paramParts = <String>[];
      for (final param in method.parameters) {
        if (param.isNamed) {
          paramParts.add('dynamic ${param.name}');
        } else {
          paramParts.add('dynamic ${param.name}');
        }
      }
      // All known cases use named parameters (e.g., {DiagnosticLevel minLevel})
      final hasNamed = method.parameters.any((p) => p.isNamed);
      if (hasNamed) {
        return '{${paramParts.join(', ')}}';
      }
      return paramParts.join(', ');
    }
  }
  return null;
}

/// Replaces occurrences of a type parameter name with 'V' in a type string.
///
/// Uses word boundary matching to avoid replacing partial matches
/// (e.g., 'T' in 'TextStyle').
String _replaceTypeParam(String typeStr, String typeParamName, String replacement) {
  return typeStr.replaceAll(
    RegExp('\\b${RegExp.escape(typeParamName)}\\b'),
    replacement,
  );
}

/// Builds a method parameter signature with T replaced by V.
///
/// Handles required positional, optional positional (`[T? arg]`), and
/// named parameters (`{required T arg}` or `{T? arg}`).
String _buildMethodParamSignature(MemberInfo method, String typeParamName) {
  if (method.parameters.isEmpty) return '';

  final parts = <String>[];
  final requiredPos = method.parameters
      .where((p) => !p.isNamed && p.isRequired)
      .toList();
  final optionalPos = method.parameters
      .where((p) => !p.isNamed && !p.isRequired)
      .toList();
  final named = method.parameters.where((p) => p.isNamed).toList();

  for (final param in requiredPos) {
    final type = _replaceTypeParam(param.type, typeParamName, 'V');
    parts.add('$type ${param.name}');
  }

  if (optionalPos.isNotEmpty) {
    final optParts = <String>[];
    for (final param in optionalPos) {
      final type = _replaceTypeParam(param.type, typeParamName, 'V');
      optParts.add('$type ${param.name}');
    }
    parts.add('[${optParts.join(', ')}]');
  }

  if (named.isNotEmpty) {
    final namedParts = <String>[];
    for (final param in named) {
      final type = _replaceTypeParam(param.type, typeParamName, 'V');
      final prefix = param.isRequired ? 'required ' : '';
      namedParts.add('$prefix$type ${param.name}');
    }
    parts.add('{${namedParts.join(', ')}}');
  }

  return parts.join(', ');
}

/// Builds the call arguments for delegating to _inner.method(...).
String _buildMethodCallArgs(MemberInfo method) {
  if (method.parameters.isEmpty) return '';

  final parts = <String>[];
  for (final param in method.parameters) {
    if (param.isNamed) {
      parts.add('${param.name}: ${param.name}');
    } else {
      parts.add(param.name);
    }
  }

  return parts.join(', ');
}

// =============================================================================
// RC-2: Generic Constructor Auto-Generation
// =============================================================================

/// Primitive types that are always included in dispatches for unbounded type
/// parameters.
const _rc2PrimitiveTypes = ['String', 'int', 'double', 'bool', 'num'];

/// Types to skip in dispatches (core Dart types, not useful as type args).
const _rc2SkipTypes = {
  // Core Dart types
  'Object',
  'dynamic',
  'void',
  'Null',
  'Never',
  'Function',
  'Record',
  'Type',
  'Symbol',
  'Enum',
  'Pattern',
  'RegExp',
  'StackTrace',
  'Comparable',
  'Invocation',
  'Match',
  'BidirectionalIterator',
  'Iterator',
  'MapEntry',
  'Stopwatch',
  'StringSink',
  'Sink',
  'StringBuffer',
  'RuneIterator',
  'Runes',
  'UriData',
  'int',
  'double',
  'String',
  'bool',
  'num',
  'FutureOr', // async primitive, not a concrete type
  // Common type parameter names (not actual types)
  'T',
  'E',
  'K',
  'V',
  'R',
  'S',
  // package:meta annotations (not instantiable)
  'Immutable',
  'Required',
  'Sealed',
  'UseResult',
  // package:vector_math types (not imported in relaxer output)
  'Vector2',
  'Vector3',
  'Vector4',
  'Matrix2',
  'Matrix3',
  'Matrix4',
  'Quaternion',
  'Aabb2',
  'Aabb3',
  'Obb3',
  'Plane',
  'Ray',
  'Sphere',
  'Triangle',
  'Frustum',
};

/// Generates the RC-2 generic constructor registration section.
///
/// Returns the number of generic constructor registrations generated.
int _writeGenericConstructorSection(
  StringBuffer buffer,
  Map<String, ClassInfo> globalClassLookup,
  void Function(String) warn,
) {
  // Find all eligible generic classes: single type param, non-abstract,
  // non-sealed, has at least one non-factory constructor.
  final eligible = <String, ClassInfo>{};
  for (final entry in globalClassLookup.entries) {
    final cls = entry.value;
    if (cls.typeParameters.isEmpty) continue;
    if (cls.typeParameters.length != 1) continue; // Single type param only
    if (cls.isAbstract || cls.isSealed) continue;
    if (!cls.constructors.any((c) => !c.isFactory)) continue;
    eligible[entry.key] = cls;
  }

  if (eligible.isEmpty) return 0;

  // Collect all concrete bridged class names for type dispatches
  final allBridgedTypes = globalClassLookup.entries
      .where((e) =>
          !e.value.isAbstract &&
          !e.value.isSealed &&
          !_rc2SkipTypes.contains(e.key))
      .map((e) => e.key)
      .toList()
    ..sort();

  buffer.writeln(
    '// =============================================================================',
  );
  buffer.writeln('// RC-2: Generic Constructor Registrations');
  buffer.writeln(
    '// =============================================================================',
  );
  buffer.writeln();

  // Generate per-class factory functions
  final registrations =
      <({String className, String ctorName, String funcName})>[];

  for (final entry in eligible.entries.toList()
    ..sort((a, b) => a.key.compareTo(b.key))) {
    final className = entry.key;
    final cls = entry.value;

    for (final ctor in cls.constructors) {
      if (ctor.isFactory) continue;

      final ctorName = ctor.name ?? '';
      final safeName = ctorName.isEmpty ? '' : '_$ctorName';
      final funcName = '_rc2$className$safeName';

      _writeGenericConstructorFactory(
        buffer,
        cls,
        ctor,
        className,
        funcName,
        allBridgedTypes,
        globalClassLookup,
      );
      registrations.add((
        className: className,
        ctorName: ctorName,
        funcName: funcName,
      ));
    }
  }

  // Write registerGenericConstructors() function
  buffer.writeln(
    '/// RC-2: Register auto-generated generic constructor factories.',
  );
  buffer.writeln('///');
  buffer.writeln(
    '/// Enables scripts to construct generic classes with explicit type',
  );
  buffer.writeln(
    "/// arguments (e.g., `GlobalKey<NavigatorState>()`). Uses chaining —",
  );
  buffer.writeln(
    '/// downstream packages can register additional type dispatches.',
  );
  buffer.writeln('void registerGenericConstructors() {');
  for (final r in registrations) {
    buffer.writeln(
      "  D4.registerGenericConstructor('${r.className}', '${r.ctorName}', ${r.funcName});",
    );
  }
  buffer.writeln('}');
  buffer.writeln();

  return registrations.length;
}

/// Generates a single generic constructor factory function.
void _writeGenericConstructorFactory(
  StringBuffer buffer,
  ClassInfo cls,
  ConstructorInfo ctor,
  String className,
  String funcName,
  List<String> allBridgedTypes,
  Map<String, ClassInfo> globalClassLookup,
) {
  final typeParamName = cls.typeParameters.keys.first;
  final typeParamBound = cls.typeParameters.values.first;
  final ctorSuffix = ctor.name != null ? '.${ctor.name}' : '';

  final positionalParams = ctor.parameters.where((p) => !p.isNamed).toList();
  final namedParams = ctor.parameters.where((p) => p.isNamed).toList();

  // Determine which params are typed with the class type parameter.
  // This includes both exact matches (T, T?) and types containing the
  // type param (e.g., MessageCodec<T>, List<T>).
  bool isTypeParamTyped(ParameterInfo p) {
    final t = p.type.replaceAll('?', '');
    // Exact match
    if (t == typeParamName) return true;
    // Contains the type param as a type argument (e.g., Foo<T>)
    if (RegExp('\\b$typeParamName\\b').hasMatch(t)) return true;
    return false;
  }

  // Is the type parameter bounded to a non-trivial type?
  // Note: 'Object' (non-nullable) is NOT unbounded since 'dynamic' doesn't satisfy it.
  // Only 'Object?' (nullable) and no bound at all are truly unbounded.
  final isUnbounded = typeParamBound == null || typeParamBound == 'Object?';

  buffer.writeln(
    '/// RC-2: Generic constructor factory for `$className<$typeParamName>$ctorSuffix`.',
  );
  // Use the GenericConstructorFactory signature with inferred types via lambda
  // in the registration call. Here we declare a plain function.
  buffer.writeln('Object? $funcName(');
  buffer.writeln('  dynamic visitor,');
  buffer.writeln('  List<Object?> positional,');
  buffer.writeln('  Map<String, Object?> named,');
  buffer.writeln('  List<dynamic>? typeArgs,');
  buffer.writeln(') {');
  buffer.writeln(
    '  final typeName = typeArgs?.isNotEmpty == true '
    "? typeArgs!.first.name as String? : null;",
  );
  buffer.writeln('  if (typeName == null) return null;');

  // Extract fixed-type params before the switch
  for (var i = 0; i < positionalParams.length; i++) {
    final p = positionalParams[i];
    if (!isTypeParamTyped(p)) {
      final castType = _rc2NullableCast(p.type);
      buffer.writeln(
        '  final ${_rc2SafeName(p.name)} = positional.length > $i '
        '? positional[$i] as $castType : null;',
      );
    } else {
      // Type-param-typed positional: extract as dynamic
      buffer.writeln(
        '  final ${_rc2SafeName(p.name)} = positional.length > $i '
        '? positional[$i] : null;',
      );
    }
  }
  for (final p in namedParams) {
    if (!isTypeParamTyped(p)) {
      final castType = _rc2NullableCast(p.type);
      buffer.writeln(
        "  final ${_rc2SafeName(p.name)} = named.containsKey('${p.name}') "
        "? named['${p.name}'] as $castType : null;",
      );
    } else {
      buffer.writeln(
        "  final ${_rc2SafeName(p.name)} = named.containsKey('${p.name}') "
        "? named['${p.name}'] : null;",
      );
    }
  }

  buffer.writeln('  return switch (typeName) {');

  // Primitive dispatches (for unbounded type params)
  if (isUnbounded) {
    _writeRC2Case(
      buffer, className, ctorSuffix, 'dynamic',
      "'dynamic' || 'Object' || 'Object?'",
      positionalParams, namedParams, typeParamName,
    );
    for (final prim in _rc2PrimitiveTypes) {
      _writeRC2Case(
        buffer, className, ctorSuffix, prim, "'$prim'",
        positionalParams, namedParams, typeParamName,
      );
    }
  }

  // Bridged class dispatches
  for (final typeName in allBridgedTypes) {
    if (typeName == className) continue;

    // If bounded, check superclass chain
    if (!isUnbounded) {
      if (!_rc2SatisfiesBound(
          typeName, typeParamBound, globalClassLookup)) {
        continue;
      }
    }

    _writeRC2Case(
      buffer, className, ctorSuffix, typeName, "'$typeName'",
      positionalParams, namedParams, typeParamName,
    );
  }

  buffer.writeln('    _ => null,');
  buffer.writeln('  };');
  buffer.writeln('}');
  buffer.writeln();
}

/// Writes a single switch case for a generic constructor dispatch.
void _writeRC2Case(
  StringBuffer buffer,
  String className,
  String ctorSuffix,
  String typeArg,
  String casePattern,
  List<ParameterInfo> positionalParams,
  List<ParameterInfo> namedParams,
  String typeParamName,
) {
  final args = <String>[];

  // Helper: check if type exactly matches or contains the type param
  bool containsTypeParam(String type) {
    final t = type.replaceAll('?', '');
    if (t == typeParamName) return true;
    return RegExp('\\b$typeParamName\\b').hasMatch(t);
  }

  // Helper: substitute type param with concrete type arg
  String substituteTypeParam(String type) {
    return type.replaceAll(RegExp('\\b$typeParamName\\b'), typeArg);
  }

  // Positional args
  for (final p in positionalParams) {
    final safeName = _rc2SafeName(p.name);
    final isExactTypeParam = p.type.replaceAll('?', '') == typeParamName;
    final hasTypeParam = containsTypeParam(p.type);
    final isNullable = p.type.endsWith('?') || !p.isRequired;

    if (hasTypeParam) {
      if (isExactTypeParam) {
        // Exact type param match (T or T?)
        if (typeArg == 'dynamic') {
          // No cast needed for dynamic — anything assigns to dynamic
          // But still need ! for non-nullable params since extaction produces nullable
          args.add(isNullable ? safeName : '$safeName!');
        } else {
          args.add('$safeName as $typeArg${isNullable ? '?' : ''}');
        }
      } else {
        // Contains type param (e.g., MessageCodec<T>) — substitute and cast
        final substitutedType = substituteTypeParam(p.type);
        final castType = _rc2NullableCast(substitutedType);
        args.add(isNullable ? '$safeName as $castType' : '($safeName as $castType)!');
      }
    } else {
      // Non-type-param-typed: add ! if param type is non-nullable
      final needsAssert = !p.type.endsWith('?');
      args.add(needsAssert ? '$safeName!' : safeName);
    }
  }

  // Named args — only include if they have a value
  final namedArgParts = <String>[];
  for (final p in namedParams) {
    final safeName = _rc2SafeName(p.name);
    final isExactTypeParam = p.type.replaceAll('?', '') == typeParamName;
    final hasTypeParam = containsTypeParam(p.type);
    final isNullable = p.type.endsWith('?') || !p.isRequired;

    if (hasTypeParam) {
      if (isExactTypeParam) {
        if (typeArg == 'dynamic') {
          namedArgParts.add('${p.name}: ${isNullable ? safeName : '$safeName!'}');
        } else {
          namedArgParts.add(
            '${p.name}: $safeName as $typeArg${isNullable ? '?' : ''}',
          );
        }
      } else {
        final substitutedType = substituteTypeParam(p.type);
        final castType = _rc2NullableCast(substitutedType);
        namedArgParts.add(isNullable
            ? '${p.name}: $safeName as $castType'
            : '${p.name}: ($safeName as $castType)!');
      }
    } else {
      // Non-type-param-typed: add ! if param type is non-nullable
      final needsAssert = !p.type.endsWith('?');
      namedArgParts.add('${p.name}: ${needsAssert ? '$safeName!' : safeName}');
    }
  }

  final allArgs = [...args, ...namedArgParts].join(', ');
  buffer.writeln(
    '    $casePattern => $className<$typeArg>$ctorSuffix($allArgs),',
  );
}

/// Checks if [typeName] satisfies the [bound] using the class hierarchy.
bool _rc2SatisfiesBound(
  String typeName,
  String bound,
  Map<String, ClassInfo> classLookup,
) {
  // Direct match
  if (typeName == bound) return true;

  // Walk superclass chain
  var current = typeName;
  final visited = <String>{};
  while (classLookup.containsKey(current) && visited.add(current)) {
    final cls = classLookup[current]!;
    final superclass = cls.superclass;
    if (superclass == null) break;
    if (superclass == bound) return true;
    current = superclass;
  }
  return false;
}

/// Makes a type nullable for safe null-coalescing casts.
String _rc2NullableCast(String type) {
  if (type.endsWith('?')) return type;
  return '$type?';
}

/// Ensures a parameter name is safe (avoids Dart keywords).
String _rc2SafeName(String name) {
  const keywords = {'default', 'class', 'abstract', 'switch', 'case', 'new'};
  if (keywords.contains(name)) return '$name\$';
  return name;
}
