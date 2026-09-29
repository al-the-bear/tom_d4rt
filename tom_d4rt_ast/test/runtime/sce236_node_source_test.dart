/// SCE236 — the analyzer-free interpreter quotes the source a diagnostic is
/// about.
///
/// `visitNode` (no handler for a construct) reported only a node type and an
/// offset: `tom_ast_model` has no `toSource()`, and an offset is useless to
/// someone holding a bundle compiled elsewhere. A bundle built with its
/// sources now yields `'<excerpt>' (<uri>:<line>:<column>)`; one without them
/// still names the module.
///
/// The fixture puts a STRUCTURALLY EQUAL node, at the same offset, in both
/// modules. Mirror nodes compare structurally, so a lookup by `==` would pick
/// the wrong module; F-SCE236-AST-2 is what says the lookup is by identity.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

const _libSource = 'Object? helper() {\n  return weird;\n}\n';
const _mainSource = 'Object? main() {\n  return weird;\n}\n';

/// `return weird;` in a function named [name].
SCompilationUnit _unit(String name, SSimpleIdentifier target) =>
    SCompilationUnit(
      offset: 0,
      length: 0,
      declarations: [
        SFunctionDeclaration(
          offset: 0,
          length: 0,
          name: SSimpleIdentifier(offset: 8, length: name.length, name: name),
          functionExpression: SFunctionExpression(
            offset: 0,
            length: 0,
            parameters: SFormalParameterList(offset: 0, length: 0),
            body: SBlockFunctionBody(
              offset: 0,
              length: 0,
              block: SBlock(
                offset: 0,
                length: 0,
                statements: [
                  SReturnStatement(offset: 0, length: 0, expression: target),
                ],
              ),
            ),
          ),
        ),
      ],
    );

void main() {
  // `weird` sits at line 2, column 10 of the lib source: 19 characters of
  // the first line and its newline, then `  return `.
  final libNode = SSimpleIdentifier(offset: 28, length: 5, name: 'weird');
  final mainNode = SSimpleIdentifier(offset: 26, length: 5, name: 'weird');
  // Equal to `libNode` in every field, in a different module.
  final lookalike = SSimpleIdentifier(offset: 28, length: 5, name: 'weird');

  final modules = {
    'package:t/main.dart': _unit('main', mainNode),
    'package:t/lib.dart': _unit('helper', libNode),
    'package:t/other.dart': _unit('other', lookalike),
  };
  final sources = {
    'package:t/main.dart': _mainSource,
    'package:t/lib.dart': _libSource,
    'package:t/other.dart': _libSource,
  };

  test('F-SCE236-AST-1: with the source bundled, the excerpt and its '
      'line:column are quoted [2026-09-29] (PASS)', () {
    expect(
      describeNodeSource(libNode, modules: modules, sources: sources),
      "'weird' (package:t/lib.dart:2:10)",
    );
  });

  test('F-SCE236-AST-2: the module is found by identity, not by structural '
      'equality [2026-09-29] (PASS)', () {
    expect(libNode == lookalike, isTrue, reason: 'the premise of this case');
    expect(moduleContaining(lookalike, modules), 'package:t/other.dart');
    expect(moduleContaining(libNode, modules), 'package:t/lib.dart');
  });

  test('F-SCE236-AST-3: without sources the module and offset are named '
      '[2026-09-29] (PASS)', () {
    expect(
      describeNodeSource(libNode, modules: modules),
      allOf(contains('not bundled: package:t/lib.dart'), contains('28')),
    );
    expect(
      describeNodeSource(
        SSimpleIdentifier(offset: 0, length: 1, name: 'x'),
        modules: modules,
      ),
      contains('no loaded module contains this node'),
    );
  });

  test('F-SCE236-AST-4: the excerpt reaches the unsupported-node message '
      '[2026-09-29] (PASS)', () {
    final env = Environment();
    final visitor = InterpreterVisitor(
      globalEnvironment: env,
      moduleContext: AstModuleLoader(
        modules: modules,
        sources: sources,
        globalEnvironment: env,
        runner: D4rtRunner(),
      ),
    );
    expect(
      () => visitor.visitNode(libNode),
      throwsA(
        isA<UnimplementedD4rtException>().having(
          (e) => e.message,
          'message',
          contains("Source: 'weird' (package:t/lib.dart:2:10)."),
        ),
      ),
    );
  });
}
