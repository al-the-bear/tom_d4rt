import 'dart:convert';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:test/test.dart';
import 'package:tom_ast_generator/tom_ast_generator.dart';

void main() {
  group('AST Serialization', () {
    test('SSimpleIdentifier serialization round-trip', () {
      final identifier = SSimpleIdentifier(
        offset: 0,
        length: 7,
        name: 'testVar',
        inDeclarationContext: false,
      );

      final json = identifier.toJson();
      final restored = SSimpleIdentifier.fromJson(json);

      expect(restored.name, equals('testVar'));
      expect(restored.offset, equals(0));
      expect(restored.length, equals(7));
    });

    test('SIntegerLiteral serialization round-trip', () {
      final literal = SIntegerLiteral(
        offset: 10,
        length: 2,
        value: 42,
      );

      final json = literal.toJson();
      final restored = SIntegerLiteral.fromJson(json);

      expect(restored.value, equals(42));
      expect(restored.offset, equals(10));
    });

    test('Full Dart code round-trip serialization', () {
      const dartCode = '''
void hello() {
  print('Hello, world!');
}
''';

      // Parse
      final parseResult = parseString(content: dartCode);

      // Convert to serializable AST
      final converter = AstConverter();
      final ast = converter.convertCompilationUnit(parseResult.unit);

      // Serialize
      final jsonEncoder = JsonEncoder.withIndent('  ');
      final json1 = jsonEncoder.convert(ast.toJson());

      // Deserialize
      final decoded = jsonDecode(json1) as Map<String, dynamic>;
      final ast2 = SCompilationUnit.fromJson(decoded);

      // Re-serialize
      final json2 = jsonEncoder.convert(ast2.toJson());

      // Compare
      expect(json1, equals(json2));
      expect(ast.declarations.length, equals(1));
    });
  });
}
