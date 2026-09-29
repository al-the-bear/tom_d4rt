// SCE236 — the unsupported-node diagnostic quotes its source, and the two
// trees now build the message with one body.
//
// This tree renders the node with the analyzer's `toSource()`. The twin has no
// renderer and quotes the bundle's source instead
// (`tom_d4rt_ast/test/runtime/sce236_node_source_test.dart`). The two
// `visitNode` bodies are identical and only `_nodeExcerpt` differs, which is
// what closed SCD199's recorded divergence rather than moving it.

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  test('F-SCE236-1: the unsupported-node message quotes the node\'s source '
      '[2026-09-29] (PASS)', () {
    final unit = parseString(content: 'Object? f() => weird + 1;').unit;
    final expression =
        ((unit.declarations.single as FunctionDeclaration)
                    .functionExpression
                    .body
                as ExpressionFunctionBody)
            .expression;
    final visitor = InterpreterVisitor(
      globalEnvironment: Environment(),
      moduleLoader: ModuleLoader(Environment(), {}, {}, {}),
    );
    expect(
      () => visitor.visitNode(expression),
      throwsA(
        isA<UnimplementedD4rtException>().having(
          (e) => e.message,
          'message',
          allOf(
            contains("Unsupported AST node 'BinaryExpressionImpl'"),
            contains("Source: 'weird + 1'."),
          ),
        ),
      ),
    );
  });
}
