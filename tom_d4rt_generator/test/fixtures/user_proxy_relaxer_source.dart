/// Test fixture for the annotation-driven proxy / relaxer directive scanner
/// scanner.
///
/// Declares `@D4rtUserProxy` / `@D4rtUserRelaxer` directive classes — extending
/// the `D4UserProxy` / `D4UserRelaxer` marker bases — exactly as a downstream
/// project would place them under `lib/src/d4rt_user_proxies/` and
/// `lib/src/d4rt_user_relaxers/`. The scanner resolves this library and turns
/// each declared variant string into the concrete generic-instantiation tuples
/// the emitter consumes.
library;

import 'package:tom_d4rt/d4rt.dart';

/// Explicit two-parameter proxy directive.
@D4rtUserProxy(
  'package:my_pkg/forms.dart',
  'TomFormList',
  variants: ['Customer, CustomerDetailForm', 'Order, OrderForm'],
)
class TomFormListUserProxy extends D4UserProxy {}

/// Wildcard-pattern relaxer directive: every `*DO` class pairs with its `*Form`.
@D4rtUserRelaxer(
  'package:my_pkg/models.dart',
  'TomFormList',
  variants: [r'*DO, $1Form'],
)
class TomFormListUserRelaxer extends D4UserRelaxer {
  @override
  String get baseTypeName => 'TomFormList';
}

/// Single-parameter relaxer directive (no pattern).
@D4rtUserRelaxer(
  'package:my_pkg/notifiers.dart',
  'ValueNotifier',
  variants: ['Color'],
)
class ValueNotifierUserRelaxer extends D4UserRelaxer {
  @override
  String get baseTypeName => 'ValueNotifier';
}

/// Marker-base class with NO recognized annotation — the scanner must record it
/// as a directive class (for exclusion) but emit a warning and skip it.
class UnannotatedUserProxy extends D4UserProxy {}
