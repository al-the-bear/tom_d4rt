/// Tom Bridge Generator
///
/// Centralized D4rt bridge generator for all Tom Framework projects.
/// 
/// This package provides the [BridgeGenerator] class that analyzes Dart source
/// files and generates corresponding BridgedClass registrations for use with
/// the D4rt interpreter.
///
/// ## Usage
///
/// ```dart
/// import 'package:tom_bridge_generator/tom_bridge_generator.dart';
///
/// final generator = BridgeGenerator(
///   workspacePath: '/path/to/project',
///   packageName: 'my_package',
///   sourceImport: 'my_package.dart',
/// );
///
/// final result = await generator.generateBridgesFromExports(
///   barrelFiles: ['lib/my_package.dart'],
///   outputPath: 'lib/src/d4rt_bridges/my_package_bridges.dart',
///   moduleName: 'All',
/// );
/// ```
library;

export 'src/bridge_generator.dart';
