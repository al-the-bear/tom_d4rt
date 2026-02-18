/// Analysis target for dart analyzer package
///
/// This file exports the analyzer AST model classes and serves as the
/// entry point for analysis. The analyzer package provides Dart's
/// static analysis infrastructure.
library;

// Core AST classes
export 'package:analyzer/dart/ast/ast.dart';

// AST visitor patterns
export 'package:analyzer/dart/ast/visitor.dart';

// Element model (semantic analysis)
export 'package:analyzer/dart/element/element.dart';

// Type system
export 'package:analyzer/dart/element/type.dart';

// Analysis error handling
export 'package:analyzer/dart/analysis/results.dart';
