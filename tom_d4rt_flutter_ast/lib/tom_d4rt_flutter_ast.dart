/// D4rt Flutter Material bridge — execute D4rt scripts that produce Flutter widget trees.
///
/// This package extends the D4rt interpreter with Flutter Material bridges,
/// allowing D4rt scripts to construct and return real Flutter widgets.
///
/// ## Usage
///
/// ```dart
/// final d4rt = FlutterD4rt();
///
/// // Execute a bundle and get a Widget
/// final widget = d4rt.build<Widget>(bundle, context);
///
/// // Or asynchronously
/// final widget = await d4rt.buildAsync<Widget>(bundle, context);
/// ```
library;

export 'src/flutter_d4rt.dart';
export 'src/bridges/material_bridges.b.dart' show FlutterMaterialBridges;

// Re-export key runtime types for convenience. These resolve entirely within
// the analyzer-free `tom_d4rt_ast` core — this package has no dependency on
// `tom_d4rt_exec`. `D4rt` is the alias for `D4rtRunner` exposed by
// `tom_d4rt_ast/d4rt.dart`.
export 'package:tom_d4rt_ast/d4rt.dart'
    show D4rt, D4rtRunner, AstBundle, BridgedInstance, BridgedEnumValue;

