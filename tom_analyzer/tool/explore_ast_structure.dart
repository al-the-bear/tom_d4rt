/// Explores the actual AST structure to show what true AST-based regeneration would require.
///
/// This demonstrates the difference between:
/// 1. Source text extraction (what we currently do)
/// 2. AST structure serialization (what true AST-based regeneration requires)
library;

import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

void main() async {
  // Simple example code
  const sourceCode = '''
/// A sample class demonstrating AST structure.
class Person {
  /// The person's name.
  final String name;
  
  /// The person's age.
  int age;
  
  /// Creates a new person.
  Person(this.name, {this.age = 0});
  
  /// Greets someone.
  String greet(String other) {
    return 'Hello, \$other! I am \$name.';
  }
}
''';

  print('=== AST Structure Exploration ===\n');
  print('Source Code:');
  print('-' * 40);
  print(sourceCode);
  print('-' * 40);
  print('');

  // Parse into AST
  final parseResult = parseString(content: sourceCode);
  final unit = parseResult.unit;

  // Show the AST structure
  print('AST Structure (simplified):');
  print('-' * 40);
  final visitor = AstStructureVisitor();
  unit.accept(visitor);
  print('');

  // Show serialized AST (what true AST storage would look like)
  print('Serialized AST (JSON representation):');
  print('-' * 40);
  final serializer = AstSerializer();
  final json = serializer.serializeNode(unit);
  final prettyJson = const JsonEncoder.withIndent('  ').convert(json);
  print(prettyJson);
  print('');

  // Compare sizes
  final sourceSize = sourceCode.length;
  final astJsonSize = prettyJson.length;
  print('Size Comparison:');
  print('  Source code: $sourceSize bytes');
  print('  AST JSON: $astJsonSize bytes');
  print('  Ratio: ${(astJsonSize / sourceSize).toStringAsFixed(1)}x larger');
  print('');

  // Save both to files for comparison
  final outputDir = Directory('doc/generated/ast_comparison');
  await outputDir.create(recursive: true);

  await File('${outputDir.path}/source.dart').writeAsString(sourceCode);
  await File('${outputDir.path}/ast.json').writeAsString(prettyJson);

  print('Saved to: ${outputDir.path}/');
  print('  - source.dart (original source)');
  print('  - ast.json (serialized AST)');
}

/// Visitor that prints the AST structure with indentation.
class AstStructureVisitor extends RecursiveAstVisitor<void> {
  int _indent = 0;

  void _print(String message) {
    print('${'  ' * _indent}$message');
  }

  @override
  void visitCompilationUnit(CompilationUnit node) {
    _print('CompilationUnit');
    _indent++;
    for (final directive in node.directives) {
      directive.accept(this);
    }
    for (final declaration in node.declarations) {
      declaration.accept(this);
    }
    _indent--;
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    _print('ClassDeclaration: ${node.name.lexeme}');
    _indent++;
    if (node.documentationComment != null) {
      _print('DocumentationComment: "${_truncate(node.documentationComment!.toSource())}"');
    }
    for (final member in node.members) {
      member.accept(this);
    }
    _indent--;
  }

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    final names = node.fields.variables.map((v) => v.name.lexeme).join(', ');
    final type = node.fields.type?.toSource() ?? 'var';
    _print('FieldDeclaration: $type $names');
    _indent++;
    if (node.documentationComment != null) {
      _print('DocumentationComment: "${_truncate(node.documentationComment!.toSource())}"');
    }
    _indent--;
  }

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) {
    final name = node.name?.lexeme ?? '(default)';
    _print('ConstructorDeclaration: $name');
    _indent++;
    if (node.documentationComment != null) {
      _print('DocumentationComment: "${_truncate(node.documentationComment!.toSource())}"');
    }
    _print('Parameters: ${node.parameters.toSource()}');
    _indent--;
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    final returnType = node.returnType?.toSource() ?? 'void';
    _print('MethodDeclaration: $returnType ${node.name.lexeme}');
    _indent++;
    if (node.documentationComment != null) {
      _print('DocumentationComment: "${_truncate(node.documentationComment!.toSource())}"');
    }
    _print('Parameters: ${node.parameters?.toSource() ?? '()'}');
    if (node.body is BlockFunctionBody) {
      _print('Body: BlockFunctionBody');
    } else if (node.body is ExpressionFunctionBody) {
      _print('Body: ExpressionFunctionBody');
    }
    _indent--;
  }

  String _truncate(String s, [int maxLen = 50]) {
    final oneLine = s.replaceAll('\n', ' ').replaceAll(RegExp(r'\s+'), ' ');
    if (oneLine.length <= maxLen) return oneLine;
    return '${oneLine.substring(0, maxLen)}...';
  }
}

/// Serializes AST nodes to JSON.
class AstSerializer {
  Map<String, dynamic> serializeNode(AstNode node) {
    return switch (node) {
      CompilationUnit() => _serializeCompilationUnit(node),
      ClassDeclaration() => _serializeClassDeclaration(node),
      FieldDeclaration() => _serializeFieldDeclaration(node),
      ConstructorDeclaration() => _serializeConstructorDeclaration(node),
      MethodDeclaration() => _serializeMethodDeclaration(node),
      _ => {'type': node.runtimeType.toString(), 'source': node.toSource()},
    };
  }

  Map<String, dynamic> _serializeCompilationUnit(CompilationUnit node) {
    return {
      'type': 'CompilationUnit',
      'declarations': node.declarations.map(serializeNode).toList(),
    };
  }

  Map<String, dynamic> _serializeClassDeclaration(ClassDeclaration node) {
    return {
      'type': 'ClassDeclaration',
      'name': node.name.lexeme,
      'documentationComment': node.documentationComment?.toSource(),
      'abstractKeyword': node.abstractKeyword?.lexeme,
      'extendsClause': node.extendsClause?.toSource(),
      'implementsClause': node.implementsClause?.toSource(),
      'withClause': node.withClause?.toSource(),
      'typeParameters': node.typeParameters?.toSource(),
      'members': node.members.map(serializeNode).toList(),
    };
  }

  Map<String, dynamic> _serializeFieldDeclaration(FieldDeclaration node) {
    return {
      'type': 'FieldDeclaration',
      'documentationComment': node.documentationComment?.toSource(),
      'isStatic': node.isStatic,
      'fields': {
        'type': node.fields.type?.toSource(),
        'isFinal': node.fields.isFinal,
        'isConst': node.fields.isConst,
        'isLate': node.fields.isLate,
        'variables': node.fields.variables.map((v) {
          return <String, dynamic>{
            'name': v.name.lexeme,
            'initializer': v.initializer?.toSource(),
          };
        }).toList(),
      },
    };
  }

  Map<String, dynamic> _serializeConstructorDeclaration(ConstructorDeclaration node) {
    return {
      'type': 'ConstructorDeclaration',
      'name': node.name?.lexeme,
      'documentationComment': node.documentationComment?.toSource(),
      'isConst': node.constKeyword != null,
      'isFactory': node.factoryKeyword != null,
      'parameters': _serializeParameters(node.parameters),
      'initializers': node.initializers.map((i) => i.toSource()).toList(),
      'redirectedConstructor': node.redirectedConstructor?.toSource(),
      'body': node.body.toSource(),
    };
  }

  Map<String, dynamic> _serializeMethodDeclaration(MethodDeclaration node) {
    return {
      'type': 'MethodDeclaration',
      'name': node.name.lexeme,
      'documentationComment': node.documentationComment?.toSource(),
      'returnType': node.returnType?.toSource(),
      'isStatic': node.isStatic,
      'isAbstract': node.isAbstract,
      'isGetter': node.isGetter,
      'isSetter': node.isSetter,
      'isOperator': node.isOperator,
      'typeParameters': node.typeParameters?.toSource(),
      'parameters': node.parameters != null ? _serializeParameters(node.parameters!) : null,
      'body': _serializeBody(node.body),
    };
  }

  Map<String, dynamic> _serializeParameters(FormalParameterList params) {
    return {
      'type': 'FormalParameterList',
      'parameters': params.parameters.map((p) {
        return <String, dynamic>{
          'type': p.runtimeType.toString(),
          'name': p.name?.lexeme,
          'source': p.toSource(),
        };
      }).toList(),
    };
  }

  Map<String, dynamic> _serializeBody(FunctionBody body) {
    return {
      'type': body.runtimeType.toString(),
      'isAsynchronous': body.isAsynchronous,
      'isGenerator': body.isGenerator,
      'source': body.toSource(),
    };
  }
}
