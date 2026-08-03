/// Annotation-driven user proxy / relaxer scanner.
///
/// Discovers downstream `@D4rtUserProxy` / `@D4rtUserRelaxer` directive classes
/// — exactly as [UserBridgeScanner] discovers `@D4rtUserBridge` classes — and
/// turns each declared type-argument variant into the concrete generic
/// instantiation tuples the proxy/relaxer emitter consumes.
///
/// The scanner is split deliberately:
///
/// - [UserVariantDirective] is the **analyzer-free** core: it parses the
///   declarative variant strings (via the engine in `user_variant_pattern.dart`)
///   into [TypeArgVariantSpec]s, validates uniform arity, and expands/renders
///   them against a candidate class pool. All of the new multi-type-parameter
///   and wildcard-pattern *expansion-to-source* logic lives here, so it is fully
///   unit-testable without resolving any libraries.
/// - [UserProxyRelaxerScanner] is the thin **element-walker** that reads the
///   annotation fields off a resolved [LibraryElement] and builds directives —
///   structurally identical to [UserBridgeScanner], so the two stay in lockstep.
///
/// Wiring these directives into the live `generateProxies` / `generateRelaxers`
/// output (and the `lib/src/d4rt_user_proxies/` + `…_user_relaxers/` folder
/// pre-scan) is the heavyweight regen-gated tail; this module delivers the
/// discovery + expansion + rendering that the wiring will consume.
library;

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';

import 'user_variant_pattern.dart';

/// Whether a directive drives **proxy** or **relaxer** generation.
enum UserVariantKind {
  /// `@D4rtUserProxy` — drives `D4rt<Base>` proxy generation.
  proxy,

  /// `@D4rtUserRelaxer` — drives `$Relaxed<Base>` relaxer generation.
  relaxer,
}

/// A discovered `@D4rtUserProxy` / `@D4rtUserRelaxer` directive, with its
/// variant strings parsed into [TypeArgVariantSpec]s.
///
/// Build one with [UserVariantDirective.parse]; the factory validates that all
/// variants declare the same number of slots (a generic base has a fixed arity)
/// and surfaces malformed patterns as a [FormatException].
class UserVariantDirective {
  /// Whether this is a proxy or relaxer directive.
  final UserVariantKind kind;

  /// The package URI of the library declaring [baseClass].
  ///
  /// Format: `package:package_name/path/to/file.dart`.
  final String libraryPath;

  /// The unparameterized generic base class name, e.g. `'TomFormList'`.
  final String baseClass;

  /// The parsed variant specs (one per `variants` entry).
  final List<TypeArgVariantSpec> variantSpecs;

  /// The name of the directive class carrying the annotation
  /// (e.g. `'TomFormListUserProxy'`).
  final String directiveClassName;

  /// The source file the directive class was declared in.
  final String sourceFile;

  const UserVariantDirective._({
    required this.kind,
    required this.libraryPath,
    required this.baseClass,
    required this.variantSpecs,
    required this.directiveClassName,
    required this.sourceFile,
  });

  /// Parse the raw annotation arguments into a directive.
  ///
  /// [variants] are the raw comma-separated slot strings carried by the
  /// annotation. Throws [FormatException] when a variant is malformed (empty
  /// slot, more than one `*`, or a `$0`/`$1` template with no wildcard slot) and
  /// [ArgumentError] when the variants do not all share the same arity.
  factory UserVariantDirective.parse({
    required UserVariantKind kind,
    required String libraryPath,
    required String baseClass,
    required List<String> variants,
    required String directiveClassName,
    required String sourceFile,
  }) {
    final specs = variants.map(TypeArgVariantSpec.parse).toList();
    if (specs.isNotEmpty) {
      final arity = specs.first.arity;
      for (final spec in specs) {
        if (spec.arity != arity) {
          throw ArgumentError(
            'All variants for "$baseClass" must share the same arity; '
            'expected $arity, found ${spec.arity} in $spec '
            '($directiveClassName)',
          );
        }
      }
    }
    return UserVariantDirective._(
      kind: kind,
      libraryPath: libraryPath,
      baseClass: baseClass,
      variantSpecs: specs,
      directiveClassName: directiveClassName,
      sourceFile: sourceFile,
    );
  }

  /// The type-parameter arity of [baseClass] (0 when no variants are declared).
  int get arity => variantSpecs.isEmpty ? 0 : variantSpecs.first.arity;

  /// Whether any variant is wildcard-pattern driven (vs. all explicit literals).
  bool get hasPattern => variantSpecs.any((s) => s.isPattern);

  /// Expand the variants into concrete type-argument tuples.
  ///
  /// Explicit variants ignore [candidates]; pattern variants iterate them. The
  /// result is de-duplicated, first-seen order preserved.
  List<List<String>> expand(Iterable<String> candidates) =>
      expandUserVariants(variantSpecs, candidates);

  /// Render each expanded tuple as a concrete generic instantiation of
  /// [baseClass], e.g. `TomFormList<Customer, CustomerDetailForm>`.
  ///
  /// This is the multi-type-parameter + wildcard expansion-to-source the
  /// proxy/relaxer emitter splices into the generated registration cases.
  List<String> renderInstantiations(Iterable<String> candidates) => [
        for (final tuple in expand(candidates)) '$baseClass<${tuple.join(', ')}>',
      ];

  @override
  String toString() =>
      'UserVariantDirective(${kind.name} $directiveClassName → $baseClass'
      ', ${variantSpecs.length} variant(s))';
}

/// Renders a deterministic, golden-stable source block listing the concrete
/// generic instantiations a set of [directives] expands to against a
/// [candidatePool].
///
/// The block is the analyzer-free, regen-independent artifact that the
/// future `generateProxies` / `generateRelaxers` wiring will consume — keeping
/// the (new) multi-param + wildcard rendering testable in isolation. Entries are
/// grouped per directive, in declaration order, each instantiation on its own
/// line under a `// <kind> <baseClass>` header.
String renderUserVariantInstantiationBlock(
  Iterable<UserVariantDirective> directives,
  Iterable<String> candidatePool,
) {
  final pool = candidatePool.toList();
  final buffer = StringBuffer();
  for (final directive in directives) {
    buffer.writeln('// ${directive.kind.name} ${directive.baseClass}');
    final instantiations = directive.renderInstantiations(pool);
    if (instantiations.isEmpty) {
      buffer.writeln('//   (no matching candidates)');
    } else {
      for (final inst in instantiations) {
        buffer.writeln('//   $inst');
      }
    }
  }
  return buffer.toString();
}

/// Scans resolved libraries for `@D4rtUserProxy` / `@D4rtUserRelaxer` directive
/// classes (those extending the `D4UserProxy` / `D4UserRelaxer` marker bases).
///
/// Structurally identical to [UserBridgeScanner]: callers resolve each directive
/// file through an `AnalysisContextCollection` and hand the resulting
/// [LibraryElement] to [scanLibrary]. Discovered directives are exposed via
/// [proxyDirectives] / [relaxerDirectives]; [directiveClassNames] lists the
/// directive classes themselves so the bridge generator can exclude them from
/// normal bridge generation (as it does for `D4UserBridge` classes).
class UserProxyRelaxerScanner {
  final List<UserVariantDirective> _proxyDirectives = [];
  final List<UserVariantDirective> _relaxerDirectives = [];
  final Set<String> _directiveClassNames = {};

  /// Optional callback invoked when a marker-base class carries no recognized
  /// annotation (mirrors [UserBridgeScanner.onWarning]).
  final void Function(String message)? onWarning;

  /// Creates a scanner. [onWarning] is invoked for malformed/un-annotated
  /// directive classes.
  UserProxyRelaxerScanner({this.onWarning});

  /// All discovered proxy directives, in scan order.
  List<UserVariantDirective> get proxyDirectives =>
      List.unmodifiable(_proxyDirectives);

  /// All discovered relaxer directives, in scan order.
  List<UserVariantDirective> get relaxerDirectives =>
      List.unmodifiable(_relaxerDirectives);

  /// Names of every directive class found (proxy + relaxer), for exclusion from
  /// normal bridge generation.
  Set<String> get directiveClassNames => Set.unmodifiable(_directiveClassNames);

  /// Whether a class should be excluded from generation (it is a directive).
  bool shouldExcludeClass(String className) =>
      _directiveClassNames.contains(className);

  /// Scan a resolved [library] for proxy/relaxer directive classes.
  void scanLibrary(LibraryElement library, String sourceFile) {
    for (final classElement in library.classes) {
      _processClass(classElement, sourceFile);
    }
  }

  void _processClass(ClassElement classElement, String sourceFile) {
    final kind = _markerKind(classElement);
    if (kind == null) return;
    final className = classElement.name;
    if (className == null) return;
    _directiveClassNames.add(className);

    final parsed = _extractAnnotation(classElement, kind);
    if (parsed == null) {
      onWarning?.call(
        '$className extends ${_markerName(kind)} but has no '
        '@${_annotationName(kind)} annotation, ignoring',
      );
      return;
    }
    final (libraryPath, baseClass, variants) = parsed;

    final UserVariantDirective directive;
    try {
      directive = UserVariantDirective.parse(
        kind: kind,
        libraryPath: libraryPath,
        baseClass: baseClass,
        variants: variants,
        directiveClassName: className,
        sourceFile: sourceFile,
      );
    } on FormatException catch (e) {
      onWarning?.call('Malformed variant in $className: ${e.message}');
      return;
    } on ArgumentError catch (e) {
      onWarning?.call('Inconsistent variants in $className: ${e.message}');
      return;
    }

    switch (kind) {
      case UserVariantKind.proxy:
        _proxyDirectives.add(directive);
      case UserVariantKind.relaxer:
        _relaxerDirectives.add(directive);
    }
  }

  /// Returns the directive kind if [classElement]'s direct supertype is the
  /// `D4UserProxy` or `D4UserRelaxer` marker base, else null.
  UserVariantKind? _markerKind(ClassElement classElement) {
    final supertypeName = classElement.supertype?.element.name;
    return switch (supertypeName) {
      'D4UserProxy' => UserVariantKind.proxy,
      'D4UserRelaxer' => UserVariantKind.relaxer,
      _ => null,
    };
  }

  /// Read the matching annotation's `(libraryPath, baseClass, variants)`.
  (String, String, List<String>)? _extractAnnotation(
    ClassElement classElement,
    UserVariantKind kind,
  ) {
    final wanted = _annotationName(kind);
    for (final annotation in classElement.metadata.annotations) {
      final value = annotation.computeConstantValue();
      final type = value?.type;
      if (type is! InterfaceType) continue;
      if (type.element.name != wanted) continue;

      final libraryPath = value!.getField('libraryPath')?.toStringValue();
      final baseClass = value.getField('baseClass')?.toStringValue();
      if (libraryPath == null || baseClass == null) continue;

      final rawVariants = value.getField('variants')?.toListValue();
      final variants = <String>[
        if (rawVariants != null)
          for (final entry in rawVariants)
            if (entry.toStringValue() case final String s) s,
      ];
      return (libraryPath, baseClass, variants);
    }
    return null;
  }

  static String _markerName(UserVariantKind kind) =>
      kind == UserVariantKind.proxy ? 'D4UserProxy' : 'D4UserRelaxer';

  static String _annotationName(UserVariantKind kind) =>
      kind == UserVariantKind.proxy ? 'D4rtUserProxy' : 'D4rtUserRelaxer';
}
