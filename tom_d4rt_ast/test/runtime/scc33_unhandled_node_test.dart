import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// SCC33 mirror coverage for `tom_d4rt_ast`.
///
/// Unit-level rather than script-level, for the same reason as the SCB10 and
/// SCC28 mirror suites: `tom_d4rt_exec` — the only runner that could execute a
/// script against *this* tree — resolves `tom_d4rt_ast` from pub.dev rather
/// than by path, so it cannot see unpublished local edits. The behavioural
/// cases live in `tom_d4rt/test/scc33_unhandled_node_test.dart`.
///
/// **The defect this pins presented differently in the two trees, and this one
/// was the quieter.** `GeneralizingAstVisitor.visitNode` (analyzer) recurses
/// into the node's children, so in `tom_d4rt` an unhandled `NamedExpression`
/// walked into its label and tried to resolve it as a variable — wrong, but at
/// least noisy when no such variable existed. `SAstVisitor.visitNode` does not
/// recurse: it simply answered `null`. So on this side an unhandled node
/// produced a *value*, and the program carried it until something several
/// frames away could not take it. That is the mechanism that let `#foo`
/// evaluate to `null` for the life of the project (SCB11) while the eventual
/// error blamed a bridge.
void main() {
  /// A visitor with just enough context to dispatch a node.
  ///
  /// `NoOpModuleContext` is sufficient because none of these cases import.
  InterpreterVisitor makeVisitor() => InterpreterVisitor(
    globalEnvironment: Environment(),
    moduleContext: NoOpModuleContext(),
  );

  group('SCC33/AST: an unhandled node raises instead of answering null', () {
    test('F-SCC33-AST-1: visitNode raises a diagnostic naming the node type '
        'and its offset [2026-09-05]', () {
      final visitor = makeVisitor();
      // A type-annotation node is never *evaluated* — reaching the evaluating
      // visitor with one means dispatch went wrong, which is exactly the
      // situation the backstop exists to announce.
      final node = SNamedType(
        offset: 42,
        length: 3,
        name: SSimpleIdentifier(offset: 42, length: 3, name: 'Foo'),
      );

      expect(
        () => visitor.visitNode(node),
        throwsA(
          isA<UnimplementedD4rtException>()
              .having((e) => e.toString(), 'message', contains('SNamedType'))
              .having((e) => e.toString(), 'offset', contains('42'))
              .having(
                (e) => e.toString(),
                'explanation',
                contains('no handler'),
              ),
        ),
      );
    });

    test(
      'F-SCC33-AST-2: the diagnostic names the node type, so the report '
      'points at the construct rather than at a later victim [2026-09-05]',
      () {
        final visitor = makeVisitor();
        // Two different unhandled types must produce two different messages —
        // a generic "unsupported node" would reintroduce the blame problem in a
        // louder form.
        final a = SNamedType(
          offset: 0,
          length: 3,
          name: SSimpleIdentifier(offset: 0, length: 3, name: 'Foo'),
        );
        final b = SFormalParameterList(
          offset: 7,
          length: 2,
          parameters: const [],
        );

        String messageFor(SAstNode node) {
          try {
            visitor.visitNode(node);
          } catch (e) {
            return e.toString();
          }
          fail('visitNode(${node.runtimeType}) did not raise');
        }

        expect(messageFor(a), contains('SNamedType'));
        expect(messageFor(b), contains('SFormalParameterList'));
        expect(messageFor(a), isNot(equals(messageFor(b))));
      },
    );
  });

  group('SCC33/AST: the two nodes that legitimately reached the default', () {
    test('F-SCC33-AST-3: a named argument evaluates to its expression, not to '
        'null [2026-09-05]', () {
      final visitor = makeVisitor();
      final node = SNamedExpression(
        offset: 0,
        length: 4,
        name: SLabel(
          offset: 0,
          length: 2,
          label: SSimpleIdentifier(offset: 0, length: 1, name: 'a'),
        ),
        expression: SIntegerLiteral(offset: 3, length: 1, value: 7),
      );

      // Before SCC33 this answered `null`, so every site that *dispatched* a
      // named argument rather than unwrapping it field-wise bound `null`. The
      // redirecting-constructor initializer in `callable.dart` is such a site:
      // `A() : this.named(a: 5)` passed `null`, not `5`.
      expect(node.accept<Object?>(visitor), 7);
    });

    test('F-SCC33-AST-4: a typedef evaluates to nothing without walking its '
        'type-level children [2026-09-05]', () {
      final visitor = makeVisitor();
      // The alias' type parameters and function type are type-level syntax with
      // no value to compute. Recursing into them was the only reason further
      // node types reached the default, so this handler must NOT recurse — if
      // it did, the backstop above would now raise on a legal program.
      final node = STypedefDeclaration(
        offset: 0,
        length: 20,
        name: SSimpleIdentifier(offset: 8, length: 7, name: 'IntList'),
        type: SNamedType(
          offset: 10,
          length: 9,
          name: SSimpleIdentifier(offset: 10, length: 4, name: 'List'),
        ),
      );

      expect(node.accept<Object?>(visitor), isNull);
    });
  });
}
