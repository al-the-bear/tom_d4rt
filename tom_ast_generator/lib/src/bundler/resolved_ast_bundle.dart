/// A bundle with a static facts table (ghissues69, GitHub #18 option 3).
library;

import 'dart:convert';
import 'dart:io';

import 'package:tom_ast_model/tom_ast_model.dart' show SStaticFacts;
import 'package:tom_d4rt_ast/runtime.dart' show AstBundle;

/// The bundle key of the static facts table.
///
/// Optional and additive: a reader that does not know it reads the bundle as
/// before (`AstBundle.fromJson` takes known keys only), so the bundle format
/// version does not change for it.
const String bundleFactsKey = 'facts';

/// An [AstBundle] that carries the [facts] its resolving bundler recorded.
///
/// Its JSON - and so [toBytes] - holds the table under [bundleFactsKey].
/// [readFacts] reads it back from those bytes; `AstBundle.fromBytes` reads
/// such bytes as a plain bundle. The ZIP form ([toZip]) does not carry the
/// table yet.
class ResolvedAstBundle extends AstBundle {
  /// The static facts of the bundle's modules.
  final SStaticFacts facts;

  ResolvedAstBundle({
    required super.entryPointUri,
    required super.modules,
    required this.facts,
    super.sources,
    super.generator,
  });

  @override
  Map<String, dynamic> toJson() => {
    ...super.toJson(),
    bundleFactsKey: facts.toJson(),
  };

  /// The facts table of a bundle serialized by [toBytes] (gzip-compressed
  /// JSON), or null when it has none, or one of another format.
  static SStaticFacts? readFacts(List<int> bytes) => factsOf(
    jsonDecode(utf8.decode(gzip.decode(bytes))) as Map<String, dynamic>,
  );

  /// The facts table of a bundle's JSON, or null.
  static SStaticFacts? factsOf(Map<String, dynamic> json) {
    final table = json[bundleFactsKey];
    return table is Map<String, dynamic> ? SStaticFacts.fromJson(table) : null;
  }
}
