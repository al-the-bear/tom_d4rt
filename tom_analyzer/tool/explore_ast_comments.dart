/// Explores what the analyzer can provide for AST, source code, and comments.
///
/// This is a proof-of-concept to understand how to:
/// 1. Access the full AST (not just elements)
/// 2. Recover comments (including inline comments)
/// 3. Get source code ranges
/// 4. Regenerate source from AST
library;

import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:path/path.dart' as p;

void main() async {
  // Analyze a simple file from dart_overview
  final testFile = p.join(
    Directory.current.path,
    'test/dart_overview/lib/comments/basics/run_basics.dart',
  );

  print('Analyzing: $testFile');
  print('');

  // Create analysis context
  final collection = AnalysisContextCollection(
    includedPaths: [testFile],
    resourceProvider: PhysicalResourceProvider.INSTANCE,
  );

  final context = collection.contextFor(testFile);
  final result = await context.currentSession.getResolvedUnit(testFile);

  if (result is ResolvedUnitResult) {
    final unit = result.unit;
    print('=== COMPILATION UNIT INFO ===');
    print('');

    // 1. Access the full source code
    print('--- Source Code Range ---');
    print('Offset: ${unit.offset}');
    print('Length: ${unit.length}');
    print('End: ${unit.end}');
    print('');

    // 2. Get all comments (before first token)
    print('--- Comments Before First Token ---');
    Token? token = unit.beginToken;
    Token? precedingComment = token.precedingComments;
    while (precedingComment != null) {
      print('  Type: ${precedingComment.type}');
      print('  Lexeme: ${precedingComment.lexeme.substring(0, precedingComment.lexeme.length.clamp(0, 60))}...');
      print('  Offset: ${precedingComment.offset}');
      print('');
      precedingComment = precedingComment.next;
    }

    // 3. Walk through all declarations and show their comments
    print('=== DECLARATIONS WITH COMMENTS ===');
    print('');

    final visitor = _CommentCollectorVisitor(result.content);
    unit.visitChildren(visitor);

    print('');
    print('=== COMMENT STATISTICS ===');
    print('Total declarations: ${visitor.declarationCount}');
    print('Declarations with doc comments: ${visitor.docCommentCount}');
    print('Inline comments found: ${visitor.inlineCommentCount}');

    // 4. Show how to regenerate source code
    print('');
    print('=== SOURCE CODE REGENERATION ===');
    final firstClass = unit.declarations.whereType<ClassDeclaration>().firstOrNull;
    if (firstClass != null) {
      print('First class: ${firstClass.name.lexeme}');
      final startOffset = firstClass.offset;
      final endOffset = firstClass.end;
      print('Source range: $startOffset - $endOffset');
      print('');
      print('Regenerated source (first 500 chars):');
      print('---');
      final source = result.content.substring(startOffset, endOffset);
      print(source.substring(0, source.length.clamp(0, 500)));
      print('---');
    }

    // 5. Check if we can serialize AST info
    print('');
    print('=== SERIALIZATION CHECK ===');
    print('Can we serialize AST nodes? Need to extract key data:');
    for (final decl in unit.declarations.take(3)) {
      final info = _extractSerializableInfo(decl, result.content);
      print('');
      print('Declaration: ${decl.runtimeType}');
      print('  Name: ${info['name']}');
      print('  Offset: ${info['offset']}');
      print('  Length: ${info['length']}');
      print('  HasDocComment: ${info['hasDocComment']}');
      print('  DocComment length: ${(info['docComment'] as String?)?.length ?? 0}');
    }
  } else {
    print('Failed to resolve: ${result.runtimeType}');
  }
}

class _CommentCollectorVisitor extends RecursiveAstVisitor<void> {
  final String source;
  int declarationCount = 0;
  int docCommentCount = 0;
  int inlineCommentCount = 0;

  _CommentCollectorVisitor(this.source);

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    _processNode('Class', node.name.lexeme, node);
    super.visitClassDeclaration(node);
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) {
    _processNode('Method', node.name.lexeme, node);
    super.visitMethodDeclaration(node);
  }

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) {
    _processNode('Function', node.name.lexeme, node);
    super.visitFunctionDeclaration(node);
  }

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    final names = node.fields.variables.map((v) => v.name.lexeme).join(', ');
    _processNode('Field', names, node);
    super.visitFieldDeclaration(node);
  }

  void _processNode(String kind, String name, AstNode node) {
    declarationCount++;

    // Check for doc comment
    Comment? docComment;
    if (node is AnnotatedNode) {
      docComment = node.documentationComment;
    }

    if (docComment != null) {
      docCommentCount++;
      print('$kind: $name');
      print('  Doc comment: ${docComment.tokens.length} tokens');
      if (docComment.tokens.isNotEmpty) {
        final firstLine = docComment.tokens.first.lexeme;
        print('  First line: ${firstLine.substring(0, firstLine.length.clamp(0, 60))}...');
      }
    }

    // Check for inline comments by scanning tokens in the node
    Token? token = node.beginToken;
    while (token != null && token.offset < node.end) {
      final comment = token.precedingComments;
      if (comment != null) {
        // Count inline comments (not doc comments)
        Token? c = comment;
        while (c != null) {
          if (!c.lexeme.startsWith('///')) {
            inlineCommentCount++;
          }
          c = c.next;
        }
      }
      if (token == node.endToken) break;
      token = token.next;
    }
  }
}

Map<String, Object?> _extractSerializableInfo(Declaration decl, String source) {
  String? name;
  Comment? docComment;

  if (decl is NamedCompilationUnitMember) {
    name = decl.name.lexeme;
  }
  final annotatedDecl = decl as AnnotatedNode;
  docComment = annotatedDecl.documentationComment;

  return {
    'name': name,
    'offset': decl.offset,
    'length': decl.length,
    'hasDocComment': docComment != null,
    'docComment': docComment != null
        ? source.substring(docComment.offset, docComment.end)
        : null,
    'sourceCode': source.substring(decl.offset, decl.end),
  };
}
