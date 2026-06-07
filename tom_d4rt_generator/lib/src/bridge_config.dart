/// D4rt Bridge Configuration
///
/// Represents the configuration for generating D4rt bridges from a JSON file.
library;

import 'dart:convert';
import 'dart:io';

/// Configuration for a single module within a project.
class ModuleConfig {
  /// The name of the module.
  final String name;

  /// List of barrel files to process for this module.
  final List<String> barrelFiles;

  /// Output path for the generated bridge file.
  final String outputPath;

  /// Optional import path for the barrel file.
  final String? barrelImport;

  /// Patterns to exclude from processing.
  final List<String> excludePatterns;

  /// Specific class names to exclude from processing.
  final List<String> excludeClasses;

  /// Specific enum names to exclude from processing.
  final List<String> excludeEnums;

  /// Specific global function names to exclude from processing.
  final List<String> excludeFunctions;

  /// Specific constructors to exclude from processing, qualified by class.
  ///
  /// Each entry is `ClassName.constructorName` (e.g. `Image.file`). Use
  /// `ClassName.new` to target the unnamed/default constructor. The class
  /// itself is still bridged — only the listed constructor is dropped.
  ///
  /// This is the mechanism for keeping a widely-used class while pruning a
  /// single constructor that drags in an unwanted dependency (e.g. dropping
  /// `Image.file`, which takes a `dart:io` `File`, from the web-safe bridges).
  final List<String> excludeConstructors;

  /// Specific global variable names to exclude from processing.
  final List<String> excludeVariables;

  /// Glob patterns for source URIs to exclude.
  ///
  /// These patterns are matched against the source URI of classes, enums,
  /// functions, and variables (e.g., `package:dcli/src/shell/shell.dart`).
  ///
  /// Patterns may also include element selectors after '#', to exclude only
  /// specific symbols from a source file:
  /// - `package:dcli_core/src/functions/backup.dart#backupFile,restoreFile`
  /// - `package:dcli_core/src/util/file.dart#*Temp*`
  ///
  /// Example patterns:
  /// - `package:dcli/src/shell/**` - exclude all files in dcli's shell folder
  /// - `package:*/src/internal/*` - exclude internal folders from any package
  /// - `package:some_pkg/**` - exclude entire package
  final List<String> excludeSourcePatterns;

  /// Whether to follow all re-exports from external packages by default.
  ///
  /// When true (default), the generator will follow `export 'package:...'`
  /// directives and generate bridges for classes in those packages.
  /// Use [skipReExports] to exclude specific packages from being followed.
  ///
  /// When false, only packages listed in [followReExports] will be followed.
  final bool followAllReExports;

  /// List of external packages to skip when following re-exports.
  ///
  /// Only used when [followAllReExports] is true. Package names in this list
  /// will not be followed even if they appear in export directives.
  ///
  /// Example: `['some_large_package', 'internal_only']`
  final List<String> skipReExports;

  /// List of external packages to follow re-exports from.
  ///
  /// Only used when [followAllReExports] is false.
  /// When a barrel file re-exports from an external package (e.g.,
  /// `export 'package:tom_basics/tom_basics.dart';`), only packages
  /// in this list will be followed for generating bridges.
  ///
  /// Example: `['tom_basics', 'tom_crypto']`
  final List<String> followReExports;

  /// Optional show clause for the generated import statement.
  ///
  /// When specified, the generated import in getImportBlock() will include
  /// `show ClassName1, ClassName2, ...` to limit what symbols are visible
  /// to D4rt scripts from this module.
  ///
  /// Example: `['TomService', 'TomEnvironment']`
  final List<String> importShowClause;

  /// Optional hide clause for the generated import statement.
  ///
  /// When specified, the generated import in getImportBlock() will include
  /// `hide functionName, ClassName, ...` to exclude specific symbols
  /// from being visible to D4rt scripts from this module.
  ///
  /// This is useful for resolving duplicate global function/variable names
  /// when multiple modules export the same symbol.
  ///
  /// Example: `['prettyJson', 'mergeMapsOneSided']`
  final List<String> importHideClause;

  /// Whether to generate bridges for deprecated elements.
  ///
  /// When false (default), classes, methods, functions, and variables
  /// marked with @deprecated or @Deprecated() are skipped during generation.
  /// A summary of skipped elements is printed at the end of generation.
  ///
  /// When true, deprecated elements are included in the generated bridges.
  /// The generated file will include `deprecated_member_use` in ignore_for_file.
  final bool generateDeprecatedElements;

  const ModuleConfig({
    required this.name,
    required this.barrelFiles,
    required this.outputPath,
    this.barrelImport,
    this.excludePatterns = const [],
    this.excludeClasses = const [],
    this.excludeEnums = const [],
    this.excludeFunctions = const [],
    this.excludeConstructors = const [],
    this.excludeVariables = const [],
    this.excludeSourcePatterns = const [],
    this.followAllReExports = true,
    this.skipReExports = const [],
    this.followReExports = const [],
    this.importShowClause = const [],
    this.importHideClause = const [],
    this.generateDeprecatedElements = false,
  });

  factory ModuleConfig.fromJson(Map<String, dynamic> json) {
    final barrelImport = json['barrelImport'] as String?;
    final barrelFilesList = json['barrelFiles'] as List?;
    // Default barrelFiles to [barrelImport] if not provided
    final barrelFiles =
        barrelFilesList?.cast<String>() ??
        (barrelImport != null ? [barrelImport] : <String>[]);

    return ModuleConfig(
      name: json['name'] as String,
      barrelFiles: barrelFiles,
      outputPath: json['outputPath'] as String,
      barrelImport: barrelImport,
      excludePatterns: (json['excludePatterns'] as List?)?.cast<String>() ?? [],
      excludeClasses: (json['excludeClasses'] as List?)?.cast<String>() ?? [],
      excludeEnums: (json['excludeEnums'] as List?)?.cast<String>() ?? [],
      excludeFunctions:
          (json['excludeFunctions'] as List?)?.cast<String>() ?? [],
      excludeConstructors:
          (json['excludeConstructors'] as List?)?.cast<String>() ?? [],
      excludeVariables:
          (json['excludeVariables'] as List?)?.cast<String>() ?? [],
      excludeSourcePatterns:
          (json['excludeSourcePatterns'] as List?)?.cast<String>() ?? [],
      followAllReExports: json['followAllReExports'] as bool? ?? true,
      skipReExports: (json['skipReExports'] as List?)?.cast<String>() ?? [],
      followReExports: (json['followReExports'] as List?)?.cast<String>() ?? [],
      importShowClause:
          (json['importShowClause'] as List?)?.cast<String>() ?? [],
      importHideClause:
          (json['importHideClause'] as List?)?.cast<String>() ?? [],
      generateDeprecatedElements:
          json['generateDeprecatedElements'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'barrelFiles': barrelFiles,
      'outputPath': outputPath,
      if (barrelImport != null) 'barrelImport': barrelImport,
      if (excludePatterns.isNotEmpty) 'excludePatterns': excludePatterns,
      if (excludeClasses.isNotEmpty) 'excludeClasses': excludeClasses,
      if (excludeEnums.isNotEmpty) 'excludeEnums': excludeEnums,
      if (excludeFunctions.isNotEmpty) 'excludeFunctions': excludeFunctions,
      if (excludeConstructors.isNotEmpty)
        'excludeConstructors': excludeConstructors,
      if (excludeVariables.isNotEmpty) 'excludeVariables': excludeVariables,
      if (excludeSourcePatterns.isNotEmpty)
        'excludeSourcePatterns': excludeSourcePatterns,
      if (!followAllReExports) 'followAllReExports': followAllReExports,
      if (skipReExports.isNotEmpty) 'skipReExports': skipReExports,
      if (followReExports.isNotEmpty) 'followReExports': followReExports,
      if (importShowClause.isNotEmpty) 'importShowClause': importShowClause,
      if (importHideClause.isNotEmpty) 'importHideClause': importHideClause,
      if (generateDeprecatedElements)
        'generateDeprecatedElements': generateDeprecatedElements,
    };
  }
}

/// Configuration for an imported bridge package.
///
/// This allows the generated dartscript.dart to import and call registration
/// methods from external bridge packages.
class ImportedBridgeConfig {
  /// The import path for the bridge package (e.g., 'package:tom_d4rt_dcli/dartscript.b.dart').
  final String import;

  /// The registration class name (e.g., 'TomD4rtDcliBridge').
  final String className;

  const ImportedBridgeConfig({required this.import, required this.className});

  factory ImportedBridgeConfig.fromJson(Map<String, dynamic> json) {
    return ImportedBridgeConfig(
      import: json['import'] as String,
      className: json['class'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'import': import, 'class': className};
  }
}

/// Configuration for a proxy class to be generated.
///
/// Proxy classes are adapter subclasses of abstract classes that delegate
/// abstract methods to callback `Function` parameters. This enables D4rt
/// scripts to provide implementations of abstract delegates like
/// `CustomPainter`, `CustomClipper`, etc.
class ProxyClassConfig {
  /// The fully qualified class name to generate a proxy for (e.g., 'CustomPainter').
  final String className;

  /// Optional custom name for the generated proxy class.
  /// Defaults to 'D4rt{className}' (e.g., 'D4rtCustomPainter').
  final String? proxyName;

  /// Bridged mixin names for which a *declared-variant* native proxy class
  /// should be generated in addition to the plain proxy (MCI#3 / A3+A4).
  ///
  /// Some bridged base classes (notably `State` and `RenderBox`) need a
  /// native proxy that *actually mixes in* a real Flutter mixin
  /// (`SingleTickerProviderStateMixin`, `RestorationMixin`,
  /// `AutomaticKeepAliveClientMixin`, …) because the mixin's overrides must
  /// run natively — Dart cannot add a mixin to a class at runtime. Rather
  /// than hand-writing one near-verbatim proxy class per mixin, the generator
  /// emits one variant per name here from a single parameterized template
  /// (the re-entrancy-guarded lifecycle set plus a per-mixin extra-override
  /// slot). The empty default keeps the feature dormant.
  ///
  /// Example in buildkit.yaml:
  /// ```yaml
  /// d4rtgen:
  ///   proxyClasses:
  ///     - className: State
  ///       mixinVariants:
  ///         - SingleTickerProviderStateMixin
  ///         - TickerProviderStateMixin
  ///         - RestorationMixin
  ///         - AutomaticKeepAliveClientMixin
  /// ```
  final List<String> mixinVariants;

  /// Generic type-argument variants for which a typed native proxy class
  /// should be generated, plus a `registerInterfaceProxy` selector switch
  /// that picks the variant matching the script's reified bridged-super type
  /// argument (MCI#6 / B1).
  ///
  /// An invariant generic delegate such as `CustomClipper<T>` cannot be
  /// satisfied by a single `CustomClipper<Path>` proxy: Flutter's downstream
  /// `clipper.getClip(size) as RRect` cast fails when the script declared
  /// `extends CustomClipper<RRect>`. So one typed proxy per concrete type
  /// argument is needed, each returning a non-null fallback of its own `T`.
  /// Rather than hand-write four near-verbatim classes plus the selector,
  /// the generator emits them from this allow-list. The type-arg name is
  /// analyzer-validatable; the per-variant [TypeArgProxyVariant.defaultExpr]
  /// is the only extra human input (there is no generic non-null default for
  /// an arbitrary `T`). The empty default keeps the feature dormant.
  ///
  /// Example in buildkit.yaml:
  /// ```yaml
  /// d4rtgen:
  ///   proxyClasses:
  ///     - className: CustomClipper
  ///       typeArgVariants:
  ///         - typeArg: Path           # first entry is the default arm
  ///           defaultExpr: Path()
  ///         - typeArg: Rect
  ///           defaultExpr: Offset.zero & size
  ///         - typeArg: RRect
  ///           defaultExpr: RRect.fromRectAndCorners(Offset.zero & size)
  /// ```
  final List<TypeArgProxyVariant> typeArgVariants;

  /// Default value expressions for *required* super-constructor formals, keyed
  /// by formal name (MCI#7 / B2).
  ///
  /// Some bridged base classes (`BoxScrollView`, `TwoDimensionalScrollView`,
  /// `TwoDimensionalViewport`, `RenderTwoDimensionalViewport`) have **required**
  /// super-constructor parameters. The generator strips the abstract ctor, so a
  /// script subclass's `super(...)` call has nowhere to land natively — the
  /// proxy must re-read the captured `super(...)` args off the
  /// `InterpretedInstance` (`_readSuperArg<T>(instance, 'name', visitor)`) and
  /// forward them to the real native super-constructor. The generator already
  /// knows the super-formal list and types from the analyzer; the only human
  /// input is a sane **default** for each required formal the script might omit
  /// (e.g. `scrollDirection` → `Axis.vertical`). Script-supplied `super(...)`
  /// args always win — the default is only used when the captured arg is null.
  /// The empty default keeps the feature dormant.
  ///
  /// Example in buildkit.yaml:
  /// ```yaml
  /// d4rtgen:
  ///   proxyClasses:
  ///     - className: BoxScrollView
  ///       superArgDefaults:
  ///         scrollDirection: Axis.vertical
  ///         reverse: 'false'
  ///         clipBehavior: Clip.hardEdge
  /// ```
  final Map<String, String> superArgDefaults;

  const ProxyClassConfig({
    required this.className,
    this.proxyName,
    this.mixinVariants = const [],
    this.typeArgVariants = const [],
    this.superArgDefaults = const {},
  });

  factory ProxyClassConfig.fromJson(Map<String, dynamic> json) {
    if (json case {'className': final String name}) {
      return ProxyClassConfig(
        className: name,
        proxyName: json['proxyName'] as String?,
        mixinVariants:
            (json['mixinVariants'] as List?)?.cast<String>() ?? const [],
        typeArgVariants: (json['typeArgVariants'] as List?)
                ?.map((e) => TypeArgProxyVariant.fromYaml(e as Object))
                .toList() ??
            const [],
        superArgDefaults: (json['superArgDefaults'] as Map?)
                ?.map((k, v) => MapEntry(k.toString(), v.toString())) ??
            const {},
      );
    }
    throw ArgumentError('ProxyClassConfig requires className: $json');
  }

  /// Parse from a simple string (just the class name) or a map.
  factory ProxyClassConfig.fromYaml(Object value) {
    if (value is String) {
      return ProxyClassConfig(className: value);
    }
    if (value is Map) {
      return ProxyClassConfig.fromJson(
        value.map((k, v) => MapEntry(k.toString(), v)),
      );
    }
    throw ArgumentError('ProxyClassConfig expects String or Map, got: $value');
  }

  Map<String, dynamic> toJson() {
    return {
      'className': className,
      if (proxyName != null) 'proxyName': proxyName,
      if (mixinVariants.isNotEmpty) 'mixinVariants': mixinVariants,
      if (typeArgVariants.isNotEmpty)
        'typeArgVariants': typeArgVariants.map((v) => v.toJson()).toList(),
      if (superArgDefaults.isNotEmpty) 'superArgDefaults': superArgDefaults,
    };
  }

  /// The name of the generated proxy class.
  String get effectiveProxyName => proxyName ?? 'D4rt$className';
}

/// A single generic type-argument variant of a [ProxyClassConfig].
///
/// Drives one typed native proxy class (e.g. `_InterpretedCustomClipperRRect`)
/// and one arm of the `registerInterfaceProxy` selector switch (MCI#6 / B1).
class TypeArgProxyVariant {
  /// The concrete type argument this variant specialises for (e.g. `RRect`).
  /// Analyzer-validatable — must name a real type reachable from the proxy
  /// file's imports.
  final String typeArg;

  /// The non-null fallback expression returned when the script does not
  /// implement the abstract method (or it throws). There is no generic
  /// non-null default for an arbitrary `T`, so this is supplied per variant
  /// (e.g. `Path()`, `Offset.zero & size`,
  /// `RRect.fromRectAndCorners(Offset.zero & size)`). The expression may
  /// reference the abstract method's parameter (`size`).
  final String defaultExpr;

  const TypeArgProxyVariant({required this.typeArg, required this.defaultExpr});

  factory TypeArgProxyVariant.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'typeArg': final String typeArg,
          'defaultExpr': final String defaultExpr,
        }) {
      return TypeArgProxyVariant(typeArg: typeArg, defaultExpr: defaultExpr);
    }
    throw ArgumentError(
      'TypeArgProxyVariant requires typeArg + defaultExpr: $json',
    );
  }

  factory TypeArgProxyVariant.fromYaml(Object value) {
    if (value is Map) {
      return TypeArgProxyVariant.fromJson(
        value.map((k, v) => MapEntry(k.toString(), v)),
      );
    }
    throw ArgumentError('TypeArgProxyVariant expects a Map, got: $value');
  }

  Map<String, dynamic> toJson() => {
        'typeArg': typeArg,
        'defaultExpr': defaultExpr,
      };
}

/// Declarative spec for a generic method/static interceptor whose adapter drops
/// the script-supplied `<T>` at the bridge boundary (MCI#8 / B4 — R4).
///
/// A handful of Flutter lookups (e.g. `RadioGroup.maybeOf<T>(context)`,
/// `ThemeData.extension<T>()`) are keyed by the *exact* reified type argument.
/// The generated bridge adapter forwards them without `<T>`, so the native call
/// resolves to `<dynamic>` and misses. The interpreter exposes an interceptor
/// hook (`D4.findBridgedMethodInterceptor` / `findBridgedStaticMethodInterceptor`)
/// at the top of these adapters; the previously **hand-written** interceptor
/// bodies re-dispatched the generic over an allow-list of common type-arg names:
///
/// ```dart
/// final byType = switch (typeName) {
///   'String' => RadioGroup.maybeOf<String>(ctx),
///   'int' => RadioGroup.maybeOf<int>(ctx),
///   ...
///   _ => null,
/// };
/// ```
///
/// This config templates exactly that re-dispatch half. The R5 ancestor-walk
/// fallback for script-defined `<T>` stays hand-written (retired later by
/// MCI#11): when [fallbackExpr] is supplied the generated body ends with
/// `if (byType != null) return byType;` followed by `return $fallbackExpr;`,
/// otherwise it simply returns the switch result.
///
/// YAML form:
/// ```yaml
/// d4rtgen:
///   genericInterceptors:
///     - className: RadioGroup
///       methodName: maybeOf
///       isStatic: true
///       typeArgVariants: [String, int, double, num, bool, Object]
///       fallbackExpr: _radioGroupMaybeOfFallback(visitor, positional, named, typeArgs)
/// ```
class GenericInterceptorConfig {
  /// The conceptual owner class — both the runtime registry key and the
  /// receiver of a static re-dispatch (e.g. `RadioGroup`). For instance
  /// methods the receiver is the validated `target` instead.
  final String className;

  /// The intercepted method name (e.g. `maybeOf`).
  final String methodName;

  /// Whether the method is static. Static interceptors are registered via
  /// `D4.registerBridgedStaticMethodInterceptor` and receive
  /// `(visitor, positional, named, typeArgs)`; instance interceptors use
  /// `D4.registerBridgedMethodInterceptor` and receive
  /// `(visitor, target, positional, named, typeArgs)`.
  final bool isStatic;

  /// The allow-list of concrete type-arg names to re-dispatch over, in switch
  /// order (e.g. `['String', 'int', 'double', 'num', 'bool', 'Object']`). Each
  /// becomes one `case`/arm calling `receiver.methodName<TypeArg>(ctx)`.
  final List<String> typeArgVariants;

  /// Zero-based index of the positional argument carrying the `BuildContext`
  /// (the single argument forwarded to the generic call). Defaults to `0`.
  final int contextArgIndex;

  /// The expected static type of the forwarded context argument, used for the
  /// `is!` guard. Defaults to `BuildContext`.
  final String contextArgType;

  /// Optional hand-written fallback expression evaluated when the re-dispatch
  /// switch returns null (the R5 ancestor-walk half kept until MCI#11). When
  /// null the generated body returns the switch result directly.
  final String? fallbackExpr;

  const GenericInterceptorConfig({
    required this.className,
    required this.methodName,
    this.isStatic = false,
    this.typeArgVariants = const [],
    this.contextArgIndex = 0,
    this.contextArgType = 'BuildContext',
    this.fallbackExpr,
  });

  factory GenericInterceptorConfig.fromJson(Map<String, dynamic> json) {
    final className = json['className'];
    final methodName = json['methodName'];
    if (className is! String || methodName is! String) {
      throw ArgumentError(
        'GenericInterceptorConfig requires className + methodName: $json',
      );
    }
    return GenericInterceptorConfig(
      className: className,
      methodName: methodName,
      isStatic: json['isStatic'] as bool? ?? false,
      typeArgVariants: (json['typeArgVariants'] as List?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      contextArgIndex: json['contextArgIndex'] as int? ?? 0,
      contextArgType: json['contextArgType'] as String? ?? 'BuildContext',
      fallbackExpr: json['fallbackExpr'] as String?,
    );
  }

  factory GenericInterceptorConfig.fromYaml(Object value) {
    if (value is Map) {
      return GenericInterceptorConfig.fromJson(
        value.map((k, v) => MapEntry(k.toString(), v)),
      );
    }
    throw ArgumentError(
      'GenericInterceptorConfig expects a Map, got: $value',
    );
  }

  Map<String, dynamic> toJson() => {
        'className': className,
        'methodName': methodName,
        if (isStatic) 'isStatic': isStatic,
        if (typeArgVariants.isNotEmpty) 'typeArgVariants': typeArgVariants,
        if (contextArgIndex != 0) 'contextArgIndex': contextArgIndex,
        if (contextArgType != 'BuildContext') 'contextArgType': contextArgType,
        if (fallbackExpr != null) 'fallbackExpr': fallbackExpr,
      };
}

/// Configuration for a class to include in reduced relaxer/RC-2 generation.
///
/// Used only when [BridgeConfig.generateAllRelaxers] is `false`. Each entry
/// names a concrete bridged class that should remain an eligible generic
/// type-argument in the reduced relaxer factory and RC-2 constructor switches,
/// on top of the type-args discovered from real extraction sites.
///
/// Accepts a bare string (just the class name) or a map, mirroring
/// [ProxyClassConfig.fromYaml]:
/// ```yaml
/// d4rtgen:
///   generateAllRelaxers: false
///   relaxerClasses:
///     - AlertDialog
///     - className: SnackBar
/// ```
class RelaxerClassConfig {
  /// The class name to keep as an eligible relaxer/RC-2 type argument.
  final String className;

  const RelaxerClassConfig({required this.className});

  factory RelaxerClassConfig.fromJson(Map<String, dynamic> json) {
    if (json case {'className': final String name}) {
      return RelaxerClassConfig(className: name);
    }
    throw ArgumentError('RelaxerClassConfig requires className: $json');
  }

  /// Parse from a simple string (just the class name) or a map.
  factory RelaxerClassConfig.fromYaml(Object value) {
    if (value is String) {
      return RelaxerClassConfig(className: value);
    }
    if (value is Map<String, dynamic>) {
      return RelaxerClassConfig.fromJson(value);
    }
    throw ArgumentError(
      'RelaxerClassConfig expects String or Map, got: $value',
    );
  }

  Map<String, dynamic> toJson() => {'className': className};
}

/// Configuration for a single-type-parameter widget that must be **re-created**
/// (rather than relaxer-wrapped) with a script-supplied type argument.
///
/// Some immutable Flutter widgets — `DropdownMenuItem<T>`,
/// `DropdownMenuEntry<T>`, `ButtonSegment<T>` — cannot be wrapped by a
/// `$Relaxed` subclass (they are immutable and drive complex rendering).
/// Instead the generator emits a `D4.registerGenericTypeWrapper` re-creator
/// that reconstructs the widget with the correct `<T>` by reading the
/// constructor parameters back from the same-named instance getters.
///
/// Each entry lists the [className] and the concrete [innerTypes] for which a
/// `switch` arm is emitted (in addition to the always-present
/// `dynamic`/`Object` arm). Used by the relaxer generator's re-creator
/// emitter (MCI#5 / A5).
///
/// Example in buildkit.yaml:
/// ```yaml
/// d4rtgen:
///   recreatorClasses:
///     - DropdownMenuItem
///     - className: ButtonSegment
///       innerTypes: [String, int]
/// ```
class RecreatorClassConfig {
  /// The widget class name to emit a re-creator for.
  final String className;

  /// The concrete inner type arguments to emit `switch` arms for.
  final List<String> innerTypes;

  /// Default inner types when none are specified — mirrors the hand-written
  /// re-creators they replace.
  static const List<String> defaultInnerTypes = [
    'String',
    'int',
    'double',
    'bool',
    'num',
  ];

  const RecreatorClassConfig({
    required this.className,
    this.innerTypes = defaultInnerTypes,
  });

  factory RecreatorClassConfig.fromJson(Map<String, dynamic> json) {
    if (json case {'className': final String name}) {
      final inner = (json['innerTypes'] as List?)?.cast<String>();
      return RecreatorClassConfig(
        className: name,
        innerTypes: inner ?? defaultInnerTypes,
      );
    }
    throw ArgumentError('RecreatorClassConfig requires className: $json');
  }

  /// Parse from a simple string (just the class name) or a map.
  factory RecreatorClassConfig.fromYaml(Object value) {
    if (value is String) {
      return RecreatorClassConfig(className: value);
    }
    if (value is Map) {
      return RecreatorClassConfig.fromJson(
        value.map((k, v) => MapEntry(k.toString(), v)),
      );
    }
    throw ArgumentError(
      'RecreatorClassConfig expects String or Map, got: $value',
    );
  }

  Map<String, dynamic> toJson() => {
        'className': className,
        if (!_isDefaultInnerTypes) 'innerTypes': innerTypes,
      };

  bool get _isDefaultInnerTypes {
    if (innerTypes.length != defaultInnerTypes.length) return false;
    for (var i = 0; i < innerTypes.length; i++) {
      if (innerTypes[i] != defaultInnerTypes[i]) return false;
    }
    return true;
  }
}

/// Complete bridge configuration for a project.
class BridgeConfig {
  final String name;
  final List<ModuleConfig> modules;
  final String? helpersImport;

  /// Import path for the core D4rt runtime package.
  ///
  /// Defaults to `package:tom_d4rt/d4rt.dart` when not specified.
  /// Override this when using an alternative D4rt runtime package
  /// such as `package:tom_d4rt_exec/d4rt.dart`.
  ///
  /// Example in buildkit.yaml:
  /// ```yaml
  /// d4rtgen:
  ///   d4rtImport: package:tom_d4rt_exec/d4rt.dart
  /// ```
  final String? d4rtImport;
  final bool generateBarrel;
  final String? barrelPath;
  final bool generateDartscript;
  final String? dartscriptPath;
  final String? registrationClass;

  /// Central directory path for per-package bridge files.
  ///
  /// When specified, the generator will create one file per source package
  /// in this directory (e.g., `lib/src/d4rt_bridges/package_tom_basics_bridges.b.dart`).
  /// The per-barrel bridge files will then delegate to these per-package files,
  /// eliminating duplicate code when the same package is re-exported by multiple barrels.
  final String? libraryPath;

  /// Whether to generate a test runner script (d4rtrun.b.dart).
  ///
  /// When true, generates an executable Dart script that can run D4rt scripts
  /// or expressions with all generated bridges pre-registered. Supports
  /// running files, evaluating expressions, and validating bridge registrations.
  final bool generateTestRunner;

  /// Output path for the generated test runner script.
  ///
  /// Example: `bin/d4rtrun.b.dart`
  final String? testRunnerPath;

  /// List of external bridge packages to import and register.
  ///
  /// When specified, the generated dartscript.dart will import these packages
  /// and call their register() method before registering the local modules.
  /// This allows inheriting bridges from dependency packages.
  ///
  /// Example in build.yaml:
  /// ```yaml
  /// importedBridges:
  ///   - import: package:tom_d4rt_dcli/dartscript.b.dart
  ///     class: TomD4rtDcliBridge
  /// ```
  final List<ImportedBridgeConfig> importedBridges;

  /// Additional types to include in recursive bound dispatch.
  ///
  /// When a function has a type parameter with a recursive bound like
  /// `T extends Comparable<T>`, the generator creates runtime dispatch
  /// for known types. By default, this includes `num`, `String`, `DateTime`,
  /// `Duration`, and `BigInt`.
  ///
  /// Use this to add custom types that implement recursive bounds (like
  /// `Comparable<T>`). Each entry can be:
  /// - A simple type name for dart:core types: `'CustomNum'`
  /// - A package import with type: `'package:my_pkg/types.dart:MyComparable'`
  ///
  /// Example in buildkit.yaml:
  /// ```yaml
  /// d4rtgen:
  ///   recursiveBoundTypes:
  ///     - Duration
  ///     - package:my_pkg/types.dart:MyComparable
  /// ```
  final List<String> recursiveBoundTypes;

  /// Whether to generate proxy/adapter classes for abstract delegates.
  ///
  /// When true and [proxyClasses] is non-empty, the generator will
  /// create proxy subclasses that delegate abstract methods to callbacks.
  /// The output goes to [proxiesOutputPath].
  final bool generateProxies;

  /// Output path for the generated proxies file.
  ///
  /// The file will contain all proxy classes for this project.
  /// Example: `lib/src/bridges/flutter_proxies.b.dart`
  final String? proxiesOutputPath;

  /// List of abstract classes to generate proxy/adapter subclasses for.
  ///
  /// Each entry specifies a class name (and optionally a custom proxy name).
  /// The generator will analyze the class's abstract methods and create
  /// a proxy that accepts `Function` callbacks for each.
  ///
  /// Example in buildkit.yaml:
  /// ```yaml
  /// d4rtgen:
  ///   generateProxies: true
  ///   proxiesOutputPath: lib/src/bridges/flutter_proxies.b.dart
  ///   proxyClasses:
  ///     - CustomPainter
  ///     - className: CustomClipper
  ///       proxyName: D4rtCustomClipper
  /// ```
  final List<ProxyClassConfig> proxyClasses;

  /// Output path for the generated GEN-079 relaxer wrapper file.
  ///
  /// Relaxer generation is automatic during bridge generation. The generator
  /// will:
  /// 1. Collect generic type arguments from bridge analysis (`_getTypeArgument`)
  /// 2. Generate `$Relaxed{Base}<V>` wrapper classes for each generic base type
  /// 3. Generate per-module factory functions with type-arg switch dispatch
  /// 4. Generate a `registerRelaxers()` function for runtime registration
  ///
  /// If not explicitly set, defaults to `relaxers.b.dart` in the same directory
  /// as the first module's output path.
  ///
  /// To override in buildkit.yaml:
  /// ```yaml
  /// d4rtgen:
  ///   relaxerOutputPath: lib/src/bridges/flutter_relaxers.b.dart
  /// ```
  final String relaxerOutputPath;

  /// Package names whose relaxer modules should be imported and re-used.
  ///
  /// When a downstream package (e.g., `tom_d4rt_flutterm`) depends on a
  /// package that already generates relaxers (e.g., `tom_core_d4rt`), list
  /// those upstream package names here. The relaxer generator will import
  /// their registration functions and avoid re-generating duplicate wrappers.
  ///
  /// Example in buildkit.yaml:
  /// ```yaml
  /// d4rtgen:
  ///   priorRelaxerModules:
  ///     - tom_core_d4rt
  /// ```
  final List<String> priorRelaxerModules;

  /// Whether to generate the full combinatorial relaxer/RC-2 surface.
  ///
  /// When `true` (the **default** — keeps generate-everything behaviour), the
  /// relaxer factory switches (Category B) and the RC-2 generic constructor
  /// switches (Category C) enumerate *every* concrete bridged class as a
  /// candidate generic type-argument. This is what produces the ~181 k-line
  /// `flutter_relaxers.b.dart`.
  ///
  /// When `false`, the candidate type-argument enumeration is reduced to the
  /// union of (1) the type-args discovered from real generic extraction sites
  /// during bridge generation, (2) [relaxerClasses], and (3)
  /// [additionalRelaxerTypes]. This collapses the bulk of the generated file
  /// while keeping every actually-used type covered. The wrapper classes
  /// (Category A) and proxies (Category D) are unaffected.
  ///
  /// Example in buildkit.yaml:
  /// ```yaml
  /// d4rtgen:
  ///   generateAllRelaxers: false
  /// ```
  final bool generateAllRelaxers;

  /// Extra classes to keep as eligible relaxer/RC-2 type-args when
  /// [generateAllRelaxers] is `false`.
  ///
  /// Each entry is a bare class name or a `{className: ...}` map (see
  /// [RelaxerClassConfig.fromYaml]). Ignored when [generateAllRelaxers] is
  /// `true` (everything is already generated).
  final List<RelaxerClassConfig> relaxerClasses;

  /// Extra type names to keep as eligible relaxer/RC-2 type-args when
  /// [generateAllRelaxers] is `false`.
  ///
  /// Each entry may be a bare type name (`'Duration'`) or a package-qualified
  /// `'package:my_pkg/types.dart:MyType'` form (the bare type name after the
  /// final `:` is used for matching), mirroring [recursiveBoundTypes]. This is
  /// the field the corpus scanner (P&R step 5) emits an allowlist into.
  /// Ignored when [generateAllRelaxers] is `true`.
  final List<String> additionalRelaxerTypes;

  /// Single-type-parameter widgets to emit `D4.registerGenericTypeWrapper`
  /// re-creators for (MCI#5 / A5).
  ///
  /// Unlike relaxer wrappers, these are immutable widgets reconstructed with
  /// the script's `<T>` by reading constructor params back from same-named
  /// instance getters. See [RecreatorClassConfig]. Independent of
  /// [generateAllRelaxers] — the re-creators are always emitted for listed
  /// classes.
  final List<RecreatorClassConfig> recreatorClasses;

  const BridgeConfig({
    required this.name,
    required this.modules,
    this.helpersImport,
    this.d4rtImport,
    this.generateBarrel = true,
    this.barrelPath,
    this.generateDartscript = true,
    this.dartscriptPath,
    this.registrationClass,
    this.libraryPath,
    this.generateTestRunner = false,
    this.testRunnerPath,
    this.importedBridges = const [],
    this.recursiveBoundTypes = const [],
    this.generateProxies = false,
    this.proxiesOutputPath,
    this.proxyClasses = const [],
    this.relaxerOutputPath = 'lib/src/relaxers.b.dart',
    this.priorRelaxerModules = const [],
    this.generateAllRelaxers = true,
    this.relaxerClasses = const [],
    this.additionalRelaxerTypes = const [],
    this.recreatorClasses = const [],
  });

  factory BridgeConfig.fromJson(Map<String, dynamic> json) {
    final modules =
        (json['modules'] as List)
            .map((m) => ModuleConfig.fromJson(m as Map<String, dynamic>))
            .toList();
    return BridgeConfig(
      name: json['name'] as String,
      modules: modules,
      helpersImport: json['helpersImport'] as String?,
      d4rtImport: json['d4rtImport'] as String?,
      generateBarrel: json['generateBarrel'] as bool? ?? true,
      barrelPath: json['barrelPath'] as String?,
      generateDartscript: json['generateDartscript'] as bool? ?? true,
      dartscriptPath: json['dartscriptPath'] as String?,
      registrationClass: json['registrationClass'] as String?,
      libraryPath: json['libraryPath'] as String?,
      generateTestRunner: json['generateTestRunner'] as bool? ?? false,
      testRunnerPath: json['testRunnerPath'] as String?,
      importedBridges:
          (json['importedBridges'] as List?)
              ?.map(
                (m) => ImportedBridgeConfig.fromJson(m as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      recursiveBoundTypes:
          (json['recursiveBoundTypes'] as List?)?.cast<String>() ?? const [],
      generateProxies: json['generateProxies'] as bool? ?? false,
      proxiesOutputPath: json['proxiesOutputPath'] as String?,
      proxyClasses:
          (json['proxyClasses'] as List?)
              ?.map((e) => ProxyClassConfig.fromYaml(e))
              .toList() ??
          const [],
      relaxerOutputPath: json['relaxerOutputPath'] as String? ??
          _defaultRelaxerOutputPath(modules),
      priorRelaxerModules:
          (json['priorRelaxerModules'] as List?)?.cast<String>() ?? const [],
      generateAllRelaxers: json['generateAllRelaxers'] as bool? ?? true,
      relaxerClasses:
          (json['relaxerClasses'] as List?)
              ?.map((e) => RelaxerClassConfig.fromYaml(e as Object))
              .toList() ??
          const [],
      additionalRelaxerTypes:
          (json['additionalRelaxerTypes'] as List?)?.cast<String>() ?? const [],
      recreatorClasses:
          (json['recreatorClasses'] as List?)
              ?.map((e) => RecreatorClassConfig.fromYaml(e as Object))
              .toList() ??
          const [],
    );
  }

  /// Load configuration from a JSON file.
  ///
  /// Use [BuildConfigLoader.loadFromTomBuildYaml] instead to load from
  /// buildkit.yaml d4rtgen: section.
  @Deprecated(
    'Use BuildConfigLoader.loadFromTomBuildYaml() instead. '
    'JSON config files (d4rt_bridging.json) are no longer supported.',
  )
  static BridgeConfig fromFile(String filePath) {
    final file = File(filePath);
    if (!file.existsSync()) {
      throw FileSystemException('Configuration file not found', filePath);
    }

    final content = file.readAsStringSync();
    final json = jsonDecode(content) as Map<String, dynamic>;
    return BridgeConfig.fromJson(json);
  }

  /// Find all d4rt_bridging.json files in a directory.
  ///
  /// Use [hasTomBuildConfig] from tom_build_base instead to check for
  /// buildkit.yaml with d4rtgen: section.
  @Deprecated(
    'Use hasTomBuildConfig() from tom_build_base instead. '
    'JSON config files (d4rt_bridging.json) are no longer supported.',
  )
  static List<String> findConfigFiles(
    String directory, {
    bool recursive = false,
  }) {
    final dir = Directory(directory);
    if (!dir.existsSync()) {
      return [];
    }

    final results = <String>[];

    for (final entity in dir.listSync(
      recursive: recursive,
      followLinks: false,
    )) {
      if (entity is File && entity.path.endsWith('d4rt_bridging.json')) {
        results.add(entity.path);
      }
    }

    return results;
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'modules': modules.map((m) => m.toJson()).toList(),
      if (helpersImport != null) 'helpersImport': helpersImport,
      if (d4rtImport != null) 'd4rtImport': d4rtImport,
      'generateBarrel': generateBarrel,
      if (barrelPath != null) 'barrelPath': barrelPath,
      'generateDartscript': generateDartscript,
      if (dartscriptPath != null) 'dartscriptPath': dartscriptPath,
      if (registrationClass != null) 'registrationClass': registrationClass,
      if (libraryPath != null) 'libraryPath': libraryPath,
      'generateTestRunner': generateTestRunner,
      if (testRunnerPath != null) 'testRunnerPath': testRunnerPath,
      if (importedBridges.isNotEmpty)
        'importedBridges': importedBridges.map((b) => b.toJson()).toList(),
      if (recursiveBoundTypes.isNotEmpty)
        'recursiveBoundTypes': recursiveBoundTypes,
      if (generateProxies) 'generateProxies': generateProxies,
      if (proxiesOutputPath != null) 'proxiesOutputPath': proxiesOutputPath,
      if (proxyClasses.isNotEmpty)
        'proxyClasses': proxyClasses.map((p) => p.toJson()).toList(),
      'relaxerOutputPath': relaxerOutputPath,
      if (priorRelaxerModules.isNotEmpty)
        'priorRelaxerModules': priorRelaxerModules,
      if (!generateAllRelaxers) 'generateAllRelaxers': generateAllRelaxers,
      if (relaxerClasses.isNotEmpty)
        'relaxerClasses': relaxerClasses.map((r) => r.toJson()).toList(),
      if (additionalRelaxerTypes.isNotEmpty)
        'additionalRelaxerTypes': additionalRelaxerTypes,
      if (recreatorClasses.isNotEmpty)
        'recreatorClasses': recreatorClasses.map((r) => r.toJson()).toList(),
    };
  }

  /// Creates a copy of this config with the given fields replaced.
  BridgeConfig copyWith({
    String? name,
    List<ModuleConfig>? modules,
    String? helpersImport,
    String? d4rtImport,
    bool? generateBarrel,
    String? barrelPath,
    bool? generateDartscript,
    String? dartscriptPath,
    String? registrationClass,
    String? libraryPath,
    bool? generateTestRunner,
    String? testRunnerPath,
    List<ImportedBridgeConfig>? importedBridges,
    List<String>? recursiveBoundTypes,
    bool? generateProxies,
    String? proxiesOutputPath,
    List<ProxyClassConfig>? proxyClasses,
    String? relaxerOutputPath,
    List<String>? priorRelaxerModules,
    bool? generateAllRelaxers,
    List<RelaxerClassConfig>? relaxerClasses,
    List<String>? additionalRelaxerTypes,
    List<RecreatorClassConfig>? recreatorClasses,
  }) {
    return BridgeConfig(
      name: name ?? this.name,
      modules: modules ?? this.modules,
      helpersImport: helpersImport ?? this.helpersImport,
      d4rtImport: d4rtImport ?? this.d4rtImport,
      generateBarrel: generateBarrel ?? this.generateBarrel,
      barrelPath: barrelPath ?? this.barrelPath,
      generateDartscript: generateDartscript ?? this.generateDartscript,
      dartscriptPath: dartscriptPath ?? this.dartscriptPath,
      registrationClass: registrationClass ?? this.registrationClass,
      libraryPath: libraryPath ?? this.libraryPath,
      generateTestRunner: generateTestRunner ?? this.generateTestRunner,
      testRunnerPath: testRunnerPath ?? this.testRunnerPath,
      importedBridges: importedBridges ?? this.importedBridges,
      recursiveBoundTypes: recursiveBoundTypes ?? this.recursiveBoundTypes,
      generateProxies: generateProxies ?? this.generateProxies,
      proxiesOutputPath: proxiesOutputPath ?? this.proxiesOutputPath,
      proxyClasses: proxyClasses ?? this.proxyClasses,
      relaxerOutputPath: relaxerOutputPath ?? this.relaxerOutputPath,
      priorRelaxerModules: priorRelaxerModules ?? this.priorRelaxerModules,
      generateAllRelaxers: generateAllRelaxers ?? this.generateAllRelaxers,
      relaxerClasses: relaxerClasses ?? this.relaxerClasses,
      additionalRelaxerTypes:
          additionalRelaxerTypes ?? this.additionalRelaxerTypes,
      recreatorClasses: recreatorClasses ?? this.recreatorClasses,
    );
  }

  /// Derives a default relaxer output path from the first module's output
  /// directory, placing `relaxers.b.dart` alongside the module bridge files.
  static String _defaultRelaxerOutputPath(List<ModuleConfig> modules) {
    if (modules.isEmpty) return 'lib/src/relaxers.b.dart';
    final firstOutput = modules.first.outputPath;
    final lastSlash = firstOutput.lastIndexOf('/');
    if (lastSlash < 0) return 'relaxers.b.dart';
    return '${firstOutput.substring(0, lastSlash)}/relaxers.b.dart';
  }
}
