import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:test/test.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
// `ModuleLoader` is not part of the public barrel; F-SCC33-5 constructs a
// visitor directly, which is the only way to reach the backstop now that every
// node type the language has today has a handler.
import 'package:tom_d4rt/src/module_loader.dart';

import 'interpreter_test.dart' show execute;

/// SCC33 — an unhandled AST node raises a named diagnostic instead of
/// evaluating to `null`.
///
/// THE MECHANISM, not the instance. SCB11 fixed `#foo`, which had evaluated to
/// `null` for the entire life of the project. The reason nobody saw it was not
/// that symbols are rare — it is that `GeneralizingAstVisitor.visitNode`
/// returns `null` for any node without a handler. A gap in an *evaluating*
/// visitor therefore produced a value rather than an error, and the program
/// carried that value until it reached something that could not take it. The
/// failure surfaced frames away, inside a bridge, blaming the wrong code.
///
/// Overriding `visitNode` to raise turns that class of defect from "wrong
/// answer, blamed elsewhere" into "named diagnostic, at the offset".
///
/// **Flipping the default is what found the bugs below.** The inherited default
/// did not merely return `null`, it first *recursed into the node's children*,
/// and two constructs depended on that recursion by accident. `NamedExpression`
/// is the one that mattered: walking its children reached the label and
/// resolved it as a *variable*, so `super(a: 7)` failed with "Undefined
/// variable: a" while `super(a: a)` appeared to work — in the forwarding form a
/// variable of that name happened to be in scope, so the accidental lookup
/// found the right value by the wrong route. Every pre-existing test wrote the
/// forwarding form, which is exactly why the suite never caught it.
void main() {
  group('SCC33: a named argument in an initializer binds its own value', () {
    test('F-SCC33-1: super() with a named literal binds the literal, not a '
        'same-named variable [2026-09-05]', () {
      // The non-forwarding form. Under the inherited default this raised
      // "Undefined variable: a", because the label was resolved as a variable.
      expect(
        execute('''
          class B { final int v; B({int a = 0}) : v = a; }
          class C extends B { C() : super(a: 7); }
          main() => C().v;
        '''),
        7,
      );
    });

    test('F-SCC33-2: super() with a named argument forwarding a parameter of '
        'the same name still binds the parameter [2026-09-05]', () {
      // The form every earlier test used. It passed before for the wrong
      // reason; it must still pass for the right one.
      expect(
        execute('''
          class B { final int v; B({int a = 0}) : v = a; }
          class C extends B { C(int a) : super(a: a); }
          main() => C(9).v;
        '''),
        9,
      );
    });

    test('F-SCC33-3: a redirecting this() constructor binds its named argument '
        '[2026-09-05]', () {
      expect(
        execute('''
          class A {
            final int v;
            A.named({int a = 0}) : v = a;
            A() : this.named(a: 5);
          }
          main() => A().v;
        '''),
        5,
      );
    });

    test(
      'F-SCC33-4: a named argument is evaluated exactly once [2026-09-05]',
      () {
        // The unwrap-vs-dispatch fix in `callable.dart` exists to prevent this:
        // dispatching the NamedExpression and *then* re-reading `arg.expression`
        // would run the argument's side effects twice.
        expect(
          execute('''
          int calls = 0;
          int bump() { calls = calls + 1; return calls; }
          class B { final int v; B({int a = 0}) : v = a; }
          class C extends B { C() : super(a: bump()); }
          main() { final c = C(); return [c.v, calls]; }
        '''),
          [1, 1],
        );
      },
    );
  });

  group('SCC33: the backstop announces an unhandled node', () {
    test('F-SCC33-5: visitNode raises a diagnostic naming the node type and '
        'offset [2026-09-05]', () {
      // Called directly: every node type the language has today is handled, so
      // there is no source that reaches the backstop. That is the point of the
      // audit — this test pins the *contract* the backstop offers when the next
      // node type the language grows arrives without a handler.
      final globals = Environment();
      final visitor = InterpreterVisitor(
        globalEnvironment: globals,
        moduleLoader: ModuleLoader(globals, {}, {}, {}),
      );

      expect(
        () => visitor.visitNode(_unhandledNode()),
        throwsA(
          isA<UnimplementedD4rtException>()
              .having(
                (e) => e.toString(),
                'names the type',
                contains('ArgumentList'),
              )
              .having((e) => e.toString(), 'explains', contains('no handler')),
        ),
      );
    });

    test('F-SCC33-6: a program using every construct the audit covers still '
        'runs, so the backstop is not firing on legal code [2026-09-05]', () {
      // The guard against over-correcting. `typedef` in particular must not
      // recurse into its type-level children, or this raises.
      expect(
        execute('''
          typedef IntList = List<int>;
          typedef Mapper = int Function(int);
          class P { final int x; final int y; P({this.x = 0, this.y = 0}); }
          int twice(int v) => v * 2;
          main() {
            final IntList xs = [1, 2, 3];
            final Mapper m = twice;
            void local() {}
            local();
            final p = P(x: 4, y: m(xs.length));
            return p.x + p.y;
          }
        '''),
        10,
      );
    });
  });
}

/// A node with no handler in the interpreter.
///
/// `ArgumentList` is read field-wise by whichever call site owns it and is
/// never dispatched, so it is a faithful stand-in for the situation the
/// backstop exists to announce: dispatch arrived somewhere it should not have.
ArgumentList _unhandledNode() {
  final unit = parseString(content: 'void main() { f(1); }').unit;
  final fn = unit.declarations.single as FunctionDeclaration;
  final body = fn.functionExpression.body as BlockFunctionBody;
  final stmt = body.block.statements.single as ExpressionStatement;
  return (stmt.expression as MethodInvocation).argumentList;
}
