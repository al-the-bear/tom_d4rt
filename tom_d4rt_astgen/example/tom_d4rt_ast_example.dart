import 'dart:convert';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:tom_d4rt_astgen/tom_d4rt_astgen.dart';

void main() {
  // Example: Parse a Dart snippet and serialize it to JSON
  const dartCode = '''
void hello() {
  print('Hello, world!');
}
''';

  // Parse the Dart code
  final parseResult = parseString(content: dartCode);

  // Convert to serializable AST
  final converter = AstConverter();
  final ast = converter.convertCompilationUnit(parseResult.unit);

  // Serialize to JSON
  final jsonEncoder = JsonEncoder.withIndent('  ');
  final json = jsonEncoder.convert(ast.toJson());
  print('AST JSON:');
  print(json);

  // Deserialize from JSON
  final decoded = jsonDecode(json) as Map<String, dynamic>;
  final restored = SCompilationUnit.fromJson(decoded);
  print('\nRestored AST has ${restored.declarations.length} declarations');
}
