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

  group('Static resolver coordinates (perf plan_3 §9 S2 step c)', () {
    // Walk a converted unit and collect every SSimpleIdentifier *use* node.
    List<SSimpleIdentifier> collectIdentifiers(SAstNode root) {
      final collector = _IdentifierCollector();
      root.accept(collector);
      return collector.found;
    }

    test('innermost-block local use carries a depth-0 coordinate', () {
      const dartCode = '''
void main() {
  var x = 1;
  print(x);
}
''';
      final converter = AstConverter();
      final ast = converter.convertCompilationUnit(
        parseString(content: dartCode).unit,
      );

      // The single resolvable use is `x` inside `print(x)`: same innermost
      // block as its `var x` declaration → depth 0, slot 0.
      final uses = collectIdentifiers(ast)
          .where((id) => id.name == 'x' && id.resolvedDepth != null)
          .toList();
      expect(uses, hasLength(1));
      expect(uses.single.resolvedDepth, equals(0));
      expect(uses.single.resolvedSlot, equals(0));
    });

    test('resolver coordinates survive toJson/fromJson round-trip', () {
      const dartCode = '''
void main() {
  var a = 1;
  var b = 2;
  print(a);
  print(b);
}
''';
      final converter = AstConverter();
      final ast = converter.convertCompilationUnit(
        parseString(content: dartCode).unit,
      );

      Map<String, ({int? depth, int? slot})> coordsByName(SAstNode root) {
        final out = <String, ({int? depth, int? slot})>{};
        for (final id in collectIdentifiers(root)) {
          if (id.resolvedDepth != null) {
            out[id.name] = (depth: id.resolvedDepth, slot: id.resolvedSlot);
          }
        }
        return out;
      }

      final before = coordsByName(ast);
      // `a` → slot 0, `b` → slot 1, both at depth 0.
      expect(before['a'], equals((depth: 0, slot: 0)));
      expect(before['b'], equals((depth: 0, slot: 1)));

      final restored = SCompilationUnit.fromJson(
        jsonDecode(jsonEncode(ast.toJson())) as Map<String, dynamic>,
      );
      expect(coordsByName(restored), equals(before));
    });

    test('unresolved nodes omit coordinate keys (backward-compatible JSON)', () {
      // A top-level reference (no enclosing block local) stays unresolved, so
      // its JSON must NOT contain the resolved* keys — pre-S2 byte-compatible.
      const dartCode = 'final greeting = identityHashCode;';
      final converter = AstConverter();
      final ast = converter.convertCompilationUnit(
        parseString(content: dartCode).unit,
      );
      final json = jsonEncode(ast.toJson());
      expect(json.contains('resolvedDepth'), isFalse);
      expect(json.contains('resolvedSlot'), isFalse);
    });
  });

  group('Static resolver slot carriers + eligibility (perf plan_3 §4.6 S3b)', () {
    SAstNode convert(String dartCode) => AstConverter().convertCompilationUnit(
          parseString(content: dartCode).unit,
        );

    List<T> collect<T extends SAstNode>(SAstNode root) {
      final c = _NodeCollector<T>();
      root.accept(c);
      return c.found;
    }

    /// The function-body block of `main` is the outermost (first in pre-order)
    /// block in these single-function fixtures.
    SBlock mainBlock(SAstNode root) => collect<SBlock>(root).first;

    SVariableDeclaration declNamed(SAstNode root, String name) =>
        collect<SVariableDeclaration>(root)
            .firstWhere((d) => d.name?.name == name);

    test('block carries slotCount and declarations carry declSlot', () {
      final ast = convert('''
void main() {
  var a = 1;
  var b = 2;
  print(a);
  print(b);
}
''');
      expect(mainBlock(ast).slotCount, equals(2));
      expect(declNamed(ast, 'a').declSlot, equals(0));
      expect(declNamed(ast, 'b').declSlot, equals(1));
    });

    test('a local escaping into a nested block is ineligible (no slot)', () {
      final ast = convert('''
void main() {
  var a = 1;
  {
    print(a);
  }
}
''');
      // `a` is read from a nested block (depth 1) → escaped → not slotted.
      expect(mainBlock(ast).slotCount, equals(0));
      expect(declNamed(ast, 'a').declSlot, isNull);
      final use = collect<SSimpleIdentifier>(ast)
          .where((id) => id.name == 'a' && !id.inDeclarationContext)
          .single;
      expect(use.resolvedSlot, isNull);
    });

    test('an assigned local is ineligible in the read-only cut', () {
      final ast = convert('''
void main() {
  var a = 1;
  a = 2;
  print(a);
}
''');
      // `a = 2` demotes `a` out of slot eligibility (read-only first cut).
      expect(mainBlock(ast).slotCount, equals(0));
      expect(declNamed(ast, 'a').declSlot, isNull);
    });

    test('eligible siblings compact around an ineligible local', () {
      final ast = convert('''
void main() {
  var a = 1;
  var b = 2;
  var c = 3;
  b = 9;
  print(a);
  print(c);
}
''');
      // `b` is assigned → ineligible; `a` and `c` compact to dense 0,1.
      expect(mainBlock(ast).slotCount, equals(2));
      expect(declNamed(ast, 'a').declSlot, equals(0));
      expect(declNamed(ast, 'b').declSlot, isNull);
      expect(declNamed(ast, 'c').declSlot, equals(1));
    });
  });
}

/// Collects every [SSimpleIdentifier] reachable from a node, descending through
/// all children (the mirror [GeneralizingSAstVisitor.visitNode] does not recurse
/// by default).
class _IdentifierCollector extends GeneralizingSAstVisitor<void> {
  final List<SSimpleIdentifier> found = [];

  @override
  void visitNode(SAstNode node) => node.visitChildren(this);

  @override
  void visitSimpleIdentifier(SSimpleIdentifier node) => found.add(node);
}

/// Collects every node of type [T] reachable from a root, in pre-order
/// (parents before children), descending through all children.
class _NodeCollector<T extends SAstNode> extends GeneralizingSAstVisitor<void> {
  final List<T> found = [];

  @override
  void visitNode(SAstNode node) {
    if (node is T) found.add(node);
    node.visitChildren(this);
  }
}
