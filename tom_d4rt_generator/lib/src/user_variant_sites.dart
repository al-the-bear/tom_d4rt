/// Turning `@D4rtUserRelaxer` directives into generic extraction sites.
///
/// sce47: `UserProxyRelaxerScanner` was fully implemented and unit-tested but
/// constructed nowhere under `lib/`, so the annotations changed no generated
/// byte. This is the join between the discovery half and the emission half,
/// and it is a pure function on purpose: the pre-scan that feeds it needs a
/// resolved analyzer context, while this needs nothing but the parsed
/// directives, so it is testable without one.
///
/// WHY EXTRACTION SITES. A directive says "treat `Base<Arg>` as a relaxer
/// target". A [GenericExtractionSite] is exactly that fact, discovered from
/// USAGE rather than declared — so the existing relaxer pipeline already knows
/// how to consume it, and the annotation needs no second emitter.
library;

import 'bridge_generator.dart' show GenericExtractionSite;
import 'user_proxy_relaxer_scanner.dart';

/// The module name recorded on sites that came from a directive rather than
/// from a scanned usage, so a reader of the generator's diagnostics can tell
/// the two apart.
const String userDirectiveModuleName = 'user-directive';

/// One [GenericExtractionSite] per type-argument tuple the [directives]
/// expand to against [candidatePool].
///
/// [candidatePool] is what a wildcard pattern expands against — in the live
/// pipeline, every class the package bridges. Explicit (non-pattern) variants
/// ignore it, so a directive naming concrete arguments works even when the
/// pool is empty.
List<GenericExtractionSite> userVariantExtractionSites(
  Iterable<UserVariantDirective> directives,
  Iterable<String> candidatePool,
) {
  final pool = candidatePool.toList();
  return [
    for (final directive in directives)
      for (final tuple in directive.expand(pool))
        GenericExtractionSite(
          baseTypeName: directive.baseClass,
          // A multi-parameter variant renders as `A, B`, matching how the
          // relaxer emitter spells an instantiation. The emitter only builds
          // wrappers for single-parameter classes and warns by name on the
          // rest, so a multi-parameter directive is reported rather than
          // silently dropped.
          typeArg: tuple.join(', '),
          moduleName: userDirectiveModuleName,
        ),
  ];
}
