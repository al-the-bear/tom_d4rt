/// Tom D4rt Bridge Generator
///
/// D4rt bridge generator for creating BridgedClass implementations from Dart source.
///
/// This package provides the [BridgeGenerator] class that analyzes Dart source
/// files and generates corresponding BridgedClass registrations for use with
/// the D4rt interpreter.
///
/// ## Usage
///
/// ```dart
/// import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';
///
/// final generator = BridgeGenerator(
///   workspacePath: '/path/to/project',
///   packageName: 'my_package',
///   sourceImport: 'my_package.dart',
/// );
///
/// final result = await generator.generateBridgesFromExports(
///   barrelFiles: ['lib/my_package.dart'],
///   outputPath: 'lib/src/d4rt_bridges/my_package_bridges.b.dart',
///   moduleName: 'All',
/// );
/// ```
library;

export 'src/bridge_api.dart';
export 'src/bridge_config.dart';
export 'src/bridge_generator.dart';
export 'src/corpus_type_scanner.dart';
export 'src/file_generators.dart';
export 'src/proxy_generator.dart';
export 'src/generic_constructor_generator.dart';
export 'src/generic_interceptor_generator.dart';
export 'src/relaxer_generator.dart';
export 'src/render_box_proxy_generator.dart';
export 'src/state_proxy_generator.dart';
export 'src/superarg_proxy_generator.dart';
export 'src/typearg_proxy_generator.dart';
export 'src/user_variant_pattern.dart';

// Export builder for build_runner integration
export 'builder.dart' show d4rtBridgeBuilder;
