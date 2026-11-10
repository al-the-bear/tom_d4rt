// RUNNER BUCKET: guard — run_guard_tests.sh
// ghissues25 — a script class that extends `DiagnosticableTree` or mixes in
// `Diagnosticable` runs the members it inherits on a native proxy that calls
// the script's overrides (GEN-130).
//
// Measured 2026-11-10 (published tom_d4rt 1.231.1 / tom_d4rt_ast 0.212.1): on
// a script `class Leaf extends DiagnosticableTree`, `toDiagnosticsNode()`,
// `toStringDeep()` and `toStringShort()` answered null, so
// `foundation/diagnosticable_tree_node_test.dart` was refused; on a script
// `class Box with Diagnosticable`, `toString()` threw `Invalid target:
// expected Diagnosticable, got InterpretedInstance`. `d4rt_runtime_registrations
// .dart` registers proxies for both (`_InterpretedDiagnosticableTree`,
// `_InterpretedDiagnosticable`). The mixin's members already reach a proxy
// registered by name. A superclass's inherited members reach it only when the
// proxy is marked as the instance's receiver (`D4.markProxyIsReceiver`,
// tom_d4rt 1.249.0 / tom_d4rt_ast 0.229.0), which this package can call once
// it resolves those versions (ghissues999).

import 'package:flutter_test/flutter_test.dart';
import 'package:tom_ast_generator/tom_ast_generator.dart' show AstBundler;
import 'package:tom_d4rt_flutter_ast/tom_d4rt_flutter_ast.dart';

const _script = r'''
import 'package:flutter/foundation.dart';

class Leaf extends DiagnosticableTree {
  Leaf(this.name, [this.children = const <Leaf>[]]);
  final String name;
  final List<Leaf> children;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('name', name));
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() => <DiagnosticsNode>[
    for (final c in children) c.toDiagnosticsNode(name: c.name),
  ];
}

class Box with Diagnosticable {
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('n', 3));
  }
}

class Named with Diagnosticable {
  @override
  String toStringShort() => 'Named!';
}

List<Object?> mixin() => <Object?>[
  Box().toString(),
  Box().toDiagnosticsNode().getProperties().length,
  Named().toString(),
];

List<Object?> tree() {
  final root = Leaf('root', <Leaf>[Leaf('a'), Leaf('b')]);
  final DiagnosticsNode node = root.toDiagnosticsNode(name: 'root');
  return <Object?>[
    node.getChildren().length,
    node.getProperties().length,
    root.toStringShort().startsWith('Leaf#'),
    root.toStringDeep().contains('name: "a"'),
  ];
}
''';

Future<List<Object?>> _run(String entry) async {
  final d4rt = FlutterD4rt();
  final bundle = await AstBundler(
    bridgedLibraries: d4rt.interpreter.bridgedLibraryUris,
  ).createFromSource('$_script\nList<Object?> main() => $entry();\n');
  return (await d4rt.executeAsync<List<Object?>>(bundle)).toList();
}

void main() {
  group('ghissues25: script Diagnosticable / DiagnosticableTree classes', () {
    test('GHI25-F1: a class mixing in Diagnosticable renders through its '
        'overrides [2026-11-10]', () async {
      final r = await _run('mixin');
      expect(r[0], matches(RegExp(r'^Box#[0-9a-f]{5}\(n: 3\)$')));
      expect(r[1], 1);
      expect(r[2], 'Named!');
    });

    test(
      'GHI25-F2: a class extending DiagnosticableTree builds its node and '
      'deep string through its overrides [2026-11-10]',
      () async {
        expect(await _run('tree'), [2, 1, true, true]);
      },
      skip:
          'ghissues999: the DiagnosticableTree proxy runs inherited members only '
          'once it is marked with D4.markProxyIsReceiver, which needs tom_d4rt '
          '1.249.0 / tom_d4rt_ast 0.229.0 (unpublished; this package resolves '
          'the published interpreter). Measured passing on the tree under '
          'tool/prepublish_overrides.dart --set with the mark added, 2026-11-10 '
          '(GEN-130, ghissues25).',
    );
  });
}
