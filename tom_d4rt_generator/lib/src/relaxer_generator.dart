/// D4rt Relaxer Generator — Auto-generates GEN-079 type-relaxing wrappers.
///
/// Post-processing generator that scans generated bridge files for generic
/// extraction patterns (e.g., `extractBridgedArg<Animation<double>>`) and
/// produces:
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
    show ClassInfo, MemberInfo;
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

/// A discovered generic extraction site in a generated bridge file.
// ignore: comment_references
class _ExtractionSite {
  /// The generic base type name (e.g., 'ValueNotifier').
  final String baseTypeName;

  /// The inner type argument (e.g., 'MagnifierInfo', 'Color?').
  final String typeArg;

  /// The module this extraction was found in.
  final String moduleName;

  _ExtractionSite({
    required this.baseTypeName,
    required this.typeArg,
    required this.moduleName,
  });
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
/// This runs as a post-processing step after the main bridge generator has
/// produced all `*.b.dart` files. It scans those files for generic type
/// extraction patterns, identifies which wrappers are needed, and writes
/// a single output file containing wrapper classes, factory functions,
/// and a registration function.
///
/// Parameters:
/// - [config]: The bridge configuration (must have `generateRelaxers: true`).
/// - [projectPath]: Absolute path to the project root.
/// - [globalClassLookup]: Map of class name → ClassInfo from the orchestrator.
/// - [onWarning]: Optional callback for non-fatal warnings.
Future<RelaxerGenerationResult> generateRelaxers({
  required BridgeConfig config,
  required String projectPath,
  required Map<String, ClassInfo> globalClassLookup,
  void Function(String)? onWarning,
}) async {
  if (!config.generateRelaxers) {
    return const RelaxerGenerationResult();
  }

  if (config.relaxerOutputPath == null) {
    return const RelaxerGenerationResult(
      errors: ['generateRelaxers is true but relaxerOutputPath is not set'],
    );
  }

  final errors = <String>[];
  final warnings = <String>[];

  void warn(String msg) {
    warnings.add(msg);
    onWarning?.call(msg);
  }

  // -------------------------------------------------------------------------
  // Step 1: Scan generated bridge files for generic extraction patterns
  // -------------------------------------------------------------------------
  final moduleExtractions = _scanBridgeFiles(config, projectPath, warn);

  if (moduleExtractions.isEmpty) {
    warn('No generic extraction patterns found in bridge files');
    return RelaxerGenerationResult(warnings: warnings);
  }

  // -------------------------------------------------------------------------
  // Step 2: Build RelaxerTarget list from extraction data
  // -------------------------------------------------------------------------
  final targets = _buildRelaxerTargets(
    moduleExtractions,
    globalClassLookup,
    config,
    projectPath,
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

  // Registration function
  _writeRegistrationFunction(buffer, factoryNames);

  // -------------------------------------------------------------------------
  // Step 4: Write the output file
  // -------------------------------------------------------------------------
  final outputPath = p.join(
    projectPath,
    ensureBDartExtension(config.relaxerOutputPath!),
  );
  final outputDir = Directory(p.dirname(outputPath));
  if (!outputDir.existsSync()) {
    outputDir.createSync(recursive: true);
  }
  await File(outputPath).writeAsString(buffer.toString());

  print(
    '  RELAXER: Generated $wrappersGenerated wrapper classes, '
    '$factoriesGenerated factory functions → $outputPath',
  );

  return RelaxerGenerationResult(
    outputFile: outputPath,
    wrapperClassesGenerated: wrappersGenerated,
    factoryFunctionsGenerated: factoriesGenerated,
    errors: errors,
    warnings: warnings,
  );
}

// =============================================================================
// Step 1: Scanning bridge files
// =============================================================================

/// Scans generated bridge files for extraction patterns like
/// `D4.extractBridgedArg<Base<Arg>>`.
///
/// Returns a list of [_ExtractionSite] entries grouping each occurrence by
/// base type, inner type arg, and source module.
List<_ExtractionSite> _scanBridgeFiles(
  BridgeConfig config,
  String projectPath,
  void Function(String) warn,
) {
  final results = <_ExtractionSite>[];

  for (final module in config.modules) {
    if (module.outputPath.isEmpty) continue;

    final filePath = p.join(projectPath, module.outputPath);
    final file = File(filePath);
    if (!file.existsSync()) {
      warn('Bridge file not found: $filePath');
      continue;
    }

    final content = file.readAsStringSync();
    final extractions = _extractGenericTypeArgs(content);

    for (final (baseType, typeArg) in extractions) {
      // Skip 'dynamic' — no mismatch possible
      if (typeArg == 'dynamic') continue;

      results.add(
        _ExtractionSite(
          baseTypeName: baseType,
          typeArg: typeArg,
          moduleName: module.name,
        ),
      );
    }
  }

  return results;
}

/// Parses a bridge file's content and extracts all (baseType, innerTypeArg)
/// pairs from generic extraction calls.
///
/// Handles patterns like:
/// - `D4.extractBridgedArg<$prefix.Base<$prefix.Arg>>`
/// - `D4.getRequiredNamedArg<$prefix.Base<$prefix.Arg?>>`
/// - `D4.getOptionalNamedArg<Base<Arg>>`
List<(String baseType, String innerArg)> _extractGenericTypeArgs(
  String content,
) {
  final results = <(String, String)>[];
  final methods = [
    'extractBridgedArg',
    'extractBridgedArgOrNull',
    'getRequiredNamedArg',
    'getOptionalNamedArg',
    'getNamedArgWithDefault',
    'getRequiredArg',
    'getOptionalArgWithDefault',
    'getRequiredNamedArgTodoDefault',
  ];

  for (final method in methods) {
    final prefix = 'D4.$method<';
    var searchFrom = 0;

    while (true) {
      final idx = content.indexOf(prefix, searchFrom);
      if (idx == -1) break;

      final typeStart = idx + prefix.length;

      // Find the matching '>' for the outer generic bracket.
      // We need to track nesting depth because the type argument may
      // itself contain generics (e.g., `Map<String, int>`).
      var depth = 1;
      var pos = typeStart;
      while (pos < content.length && depth > 0) {
        if (content[pos] == '<') depth++;
        if (content[pos] == '>') depth--;
        pos++;
      }
      if (depth != 0) {
        searchFrom = pos;
        continue;
      }

      // typeStr is the full type argument, e.g.:
      // '$flutter_1.Animation<double>'
      // '$flutter_10.ValueNotifier<$flutter_284.MagnifierInfo>'
      final typeStr = content.substring(typeStart, pos - 1);

      // Strip import prefixes ($identifier.)
      final cleanType = typeStr.replaceAll(RegExp(r'\$\w+\.'), '');

      // Parse first-level generic: 'Base<InnerArg>'
      final ltIdx = cleanType.indexOf('<');
      if (ltIdx == -1) {
        // Not a generic type — skip
        searchFrom = pos;
        continue;
      }

      final baseType = cleanType.substring(0, ltIdx);

      // Find matching '>' for the inner generic
      var d = 0;
      var gtIdx = -1;
      for (var i = ltIdx; i < cleanType.length; i++) {
        if (cleanType[i] == '<') d++;
        if (cleanType[i] == '>') {
          d--;
          if (d == 0) {
            gtIdx = i;
            break;
          }
        }
      }
      if (gtIdx == -1) {
        searchFrom = pos;
        continue;
      }

      final innerArg = cleanType.substring(ltIdx + 1, gtIdx);
      results.add((baseType, innerArg));

      searchFrom = pos;
    }
  }

  return results;
}

// =============================================================================
// Step 2: Building relaxer targets
// =============================================================================

/// Builds the list of [_RelaxerTarget] from raw extraction sites.
///
/// Groups extractions by base type, resolves ClassInfo from the global lookup,
/// and checks for GEN-075 constructor switches.
List<_RelaxerTarget> _buildRelaxerTargets(
  List<_ExtractionSite> extractions,
  Map<String, ClassInfo> globalClassLookup,
  BridgeConfig config,
  String projectPath,
  void Function(String) warn,
) {
  // Group by base type → module → Set<typeArg>
  final grouped = <String, Map<String, Set<String>>>{};
  for (final site in extractions) {
    final moduleMap = grouped.putIfAbsent(site.baseTypeName, () => {});
    moduleMap.putIfAbsent(site.moduleName, () => {}).add(site.typeArg);
  }

  // Check which classes have GEN-075 switches
  final gen075Classes = _scanForGEN075Classes(config, projectPath);

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

/// Scans generated bridge files for GEN-075 comments to identify which
/// classes have type-dispatch constructor switches.
Set<String> _scanForGEN075Classes(BridgeConfig config, String projectPath) {
  final result = <String>{};
  // Pattern: a _create{ClassName}Bridge function before a GEN-075 comment
  final pattern = RegExp(
    r'BridgedClass _create(\w+)Bridge\(\)',
  );

  for (final module in config.modules) {
    if (module.outputPath.isEmpty) continue;
    final filePath = p.join(projectPath, module.outputPath);
    final file = File(filePath);
    if (!file.existsSync()) continue;

    final lines = file.readAsLinesSync();
    String? currentBridgeClass;

    for (final line in lines) {
      final match = pattern.firstMatch(line);
      if (match != null) {
        currentBridgeClass = match.group(1);
      }
      if (line.contains('GEN-075') && currentBridgeClass != null) {
        result.add(currentBridgeClass);
      }
    }
  }

  return result;
}

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

  // Check if constructor has T-typed required parameters
  final requiredParams = defaultCtor.parameters.where((p) => p.isRequired);
  final hasTPosParam = requiredParams.any(
    (p) => !p.isNamed && tPattern.hasMatch(p.type),
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

  // Explicit toString override — required for classes whose interface has
  // String toString({DiagnosticLevel minLevel}) (like Diagnosticable,
  // RenderObject). Object.toString() has incompatible signature and
  // noSuchMethod can't resolve it (it's already a concrete implementation).
  buf.writeln('  @override');
  buf.writeln('  String toString({dynamic minLevel}) =>');
  buf.writeln("    _inner.toString();");
  buf.writeln();

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
// Helper functions
// =============================================================================

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
