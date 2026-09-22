/// Annotations for D4rt user-defined proxy and relaxer generation directives.
///
/// These annotations let a downstream project declare proxy / relaxer
/// generation for its **own** generic classes — including multi-type-parameter
/// generics that the auto-generator does not cover — without editing
/// `buildkit.yaml`. They mirror the conventions of [D4rtUserBridge]: a const
/// annotation carrying string-syntax arguments, applied to a class extending a
/// marker base (`D4UserProxy` / `D4UserRelaxer`) that the generator pre-scans.
///
/// ## Variant syntax
///
/// Each entry in [D4rtUserProxy.variants] / [D4rtUserRelaxer.variants] is a
/// comma-separated list of slots, one slot per type parameter of the generic
/// base class. A slot is either a literal type name, or — for at most one slot
/// per variant — a single-`*` wildcard pattern whose captures fill the other
/// slots via `$0` / `$1` templates:
///
/// - `$0` = the full matched name (e.g. `CustomerDO`).
/// - `$1` = the wildcard-captured substring (e.g. `Customer`).
/// - The `*` must be at the start (`*DO` ⇒ `endsWith`) or end (`Customer*` ⇒
///   `startsWith`) of exactly one slot.
///
/// ```dart
/// // Explicit two-parameter combinations.
/// @D4rtUserProxy(
///   'package:my_pkg/forms.dart',
///   'TomFormList',
///   variants: ['Customer, CustomerDetailForm', 'Order, OrderForm'],
/// )
/// class TomFormListUserProxy extends D4UserProxy {}
///
/// // Wildcard-pattern variant: every `*DO` class pairs with its `*Form`.
/// @D4rtUserRelaxer(
///   'package:my_pkg/models.dart',
///   'TomFormList',
///   variants: ['*DO, $1Form'],
/// )
/// class TomFormListUserRelaxer extends D4UserRelaxer {
///   @override
///   String get baseTypeName => 'TomFormList';
/// }
/// ```
///
/// The variant strings are parsed and expanded by the analyzer-free engine in
/// `package:tom_d4rt_generator/src/user_variant_pattern.dart`.
///
/// ## Placement
///
/// User-proxy directive classes belong in `lib/src/d4rt_user_proxies/` and
/// user-relaxer directive classes in `lib/src/d4rt_user_relaxers/` of the
/// project that generates the bridges — modeled on the `lib/src/d4rt_user_bridges/`
/// pre-scan folder.
library;

/// Annotation marking a class as a D4rt user-defined **proxy** directive.
///
/// Drives generation of `D4rt<Class>` proxy subclasses for the generic base
/// [baseClass] across the declared [variants]. See the library doc for the
/// variant syntax.
class D4rtUserProxy {
  /// The package URI of the library declaring [baseClass].
  ///
  /// Format: `package:package_name/path/to/file.dart`.
  final String libraryPath;

  /// The unparameterized generic base class name, e.g. `'TomFormList'`.
  final String baseClass;

  /// The declared type-argument variants. Each entry is a comma-separated slot
  /// list (one slot per type parameter), either explicit literals or a single
  /// wildcard-pattern slot with `$0`/`$1` templates.
  final List<String> variants;

  /// Creates a [D4rtUserProxy] annotation.
  const D4rtUserProxy(
    this.libraryPath,
    this.baseClass, {
    this.variants = const [],
  });
}

/// Annotation marking a class as a D4rt user-defined **relaxer** directive.
///
/// Drives generation of `$RelaxedClass<V>` relaxer cases for the generic base
/// [baseClass] across the declared [variants]. See the library doc for the
/// variant syntax.
class D4rtUserRelaxer {
  /// The package URI of the library declaring [baseClass].
  ///
  /// Format: `package:package_name/path/to/file.dart`.
  final String libraryPath;

  /// The unparameterized generic base class name, e.g. `'TomFormList'`.
  final String baseClass;

  /// The declared type-argument variants. Each entry is a comma-separated slot
  /// list (one slot per type parameter), either explicit literals or a single
  /// wildcard-pattern slot with `$0`/`$1` templates.
  final List<String> variants;

  /// Creates a [D4rtUserRelaxer] annotation.
  const D4rtUserRelaxer(
    this.libraryPath,
    this.baseClass, {
    this.variants = const [],
  });
}
