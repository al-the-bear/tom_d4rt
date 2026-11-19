/// The former bundle type with a static facts table (ghissues69, GitHub #18
/// option 3), kept as a deprecated alias: [AstBundle.facts] carries the
/// table since tom_d4rt_ast 0.251.0.
library;

import 'package:tom_ast_model/tom_ast_model.dart' show SStaticFacts;
import 'package:tom_d4rt_ast/runtime.dart' show AstBundle, AstBundleFormat;

/// The bundle key of the static facts table ([AstBundleFormat.keyFacts]).
///
/// Optional and additive: a reader that does not know it reads the bundle as
/// before, so the bundle format version does not change for it.
const String bundleFactsKey = AstBundleFormat.keyFacts;

/// An [AstBundle] whose [facts] are set.
///
/// The bundler returns a plain [AstBundle] with [AstBundle.facts]; this type
/// stays for code that names it. Its JSON, bytes and ZIP form are the plain
/// bundle's, the table included.
@Deprecated(
  'Use AstBundle and AstBundle.facts (tom_d4rt_ast 0.251.0); the bundler '
  'returns a plain AstBundle since tom_ast_generator 0.2.11.',
)
class ResolvedAstBundle extends AstBundle {
  ResolvedAstBundle({
    required super.entryPointUri,
    required super.modules,
    required SStaticFacts super.facts,
    super.sources,
    super.generator,
  });

  /// The static facts of the bundle's modules.
  @override
  SStaticFacts get facts => super.facts!;

  /// The facts table of a bundle serialized by `toBytes` (gzip-compressed
  /// JSON), or null when it has none, or one of another format: the
  /// [AstBundle.facts] of the bundle read back.
  static SStaticFacts? readFacts(List<int> bytes) =>
      AstBundle.fromBytes(bytes).facts;

  /// The facts table of a bundle's JSON, or null: the [AstBundle.facts] of
  /// the bundle read from it.
  static SStaticFacts? factsOf(Map<String, dynamic> json) =>
      AstBundle.fromJson(json).facts;
}
