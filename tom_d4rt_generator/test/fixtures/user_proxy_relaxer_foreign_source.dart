/// Test fixture for SCE154: proxy / relaxer directives whose annotations come
/// from somewhere other than `package:tom_d4rt`.
///
/// `user_proxy_relaxer_source.dart` imports `package:tom_d4rt/d4rt.dart`, so
/// every directive the scanner has ever been tested against carried an
/// annotation from the REFERENCE interpreter. SCE154 mirrored
/// `d4rt_user_proxy_annotation.dart` into `tom_d4rt_ast` so the analyzer-free
/// line can follow the instruction its own `generator/d4.dart` doc comment
/// gives — and that only works if [UserProxyRelaxerScanner] identifies a
/// directive by the annotation's NAME rather than by the library it was
/// declared in.
///
/// The marker bases and annotations are declared HERE, locally, rather than
/// imported from `package:tom_d4rt_ast/runtime.dart`. Two reasons, and both
/// are the point:
///
/// 1. It is the stronger claim. An annotation reached from a library with no
///    relation to either interpreter proves URI-independence outright; one
///    imported from the AST package would only prove that the scanner accepts
///    a second specific URI.
/// 2. `tom_d4rt_generator` must not grow a dependency on an interpreter it
///    does not use, and could not usefully have one here anyway: the twins and
///    the generator resolve published packages (DGUC6), so a fixture importing
///    the mirrored annotation would be red until `tom_d4rt_ast` ships it.
///
/// That the AST tree's copy exists and is shape-identical to the reference is
/// held elsewhere — `tom_d4rt/test/scd134_barrel_surface_parity_test.dart` for
/// the exported surface, `scd183_mirror_source_sync_test.dart` and
/// `scd199_mirror_body_agreement_test.dart` for the bodies. This file holds
/// the half neither of those can see: that the generator does not care.
library;

/// Local stand-in for `D4UserProxy` — same name, unrelated library.
abstract class D4UserProxy {}

/// Local stand-in for `D4UserRelaxer` — same name, unrelated library.
abstract class D4UserRelaxer {}

/// Local stand-in for the `@D4rtUserProxy` annotation.
class D4rtUserProxy {
  final String libraryPath;
  final String baseClass;
  final List<String> variants;

  const D4rtUserProxy(
    this.libraryPath,
    this.baseClass, {
    this.variants = const [],
  });
}

/// Local stand-in for the `@D4rtUserRelaxer` annotation.
class D4rtUserRelaxer {
  final String libraryPath;
  final String baseClass;
  final List<String> variants;

  const D4rtUserRelaxer(
    this.libraryPath,
    this.baseClass, {
    this.variants = const [],
  });
}

/// Explicit two-parameter proxy directive.
@D4rtUserProxy(
  'package:ast_line_pkg/forms.dart',
  'AstFormList',
  variants: ['Customer, CustomerDetailForm', 'Order, OrderForm'],
)
class AstFormListUserProxy extends D4UserProxy {}

/// Wildcard-pattern relaxer directive.
@D4rtUserRelaxer(
  'package:ast_line_pkg/models.dart',
  'AstFormList',
  variants: [r'*DO, $1Form'],
)
class AstFormListUserRelaxer extends D4UserRelaxer {}
