// GitHub al-the-bear/tom_d4rt#11 — the relaxer and RC-2 constructor factories
// dispatch through switches of at most 64 selectors.
//
// The full Flutter bridge set generated 99 factories whose `switch` named about
// 3 200 type names each (measured 2026-11-09 on the committed
// tom_d4rt_flutter_ast relaxer file: 176 563 selectors in 99 switches), and a
// release AOT build of it did not finish. `writeBoundedSelectorDispatch` keeps
// a dispatch of up to 64 distinct selectors as the one switch it always was
// and splits a larger one into leaf functions behind a binary search on the
// selector. The cases follow the repair proposed in #11: the 64/65 boundary,
// duplicate selectors (the first arm wins), arguments typed in the leaves, an
// unknown selector, and an empty dispatch. GH11-5 compiles and runs generated
// dispatches; GH11-6 checks the real relaxer and constructor factories.

import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bounded_dispatch.dart';
import 'package:tom_d4rt_generator/src/relaxer_generator.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart'
    show ClassInfo, ConstructorInfo, ParameterInfo;

/// Arms `S0`..`S<n-1>`, each yielding `'v<i>'`.
List<DispatchArm> _arms(int n) => [
  for (var i = 0; i < n; i++) DispatchArm(['S$i'], "'v$i'"),
];

BoundedDispatch _dispatch(List<DispatchArm> arms, {int? maxSelectors}) =>
    writeBoundedSelectorDispatch(
      selector: 'sel',
      arms: arms,
      fallback: 'null',
      returnType: 'Object?',
      leafPrefix: '_pick',
      maxSelectors: maxSelectors ?? maxSelectorsPerDispatchLeaf,
    );

int _switchCount(String code) => 'switch ('.allMatches(code).length;

/// Compiles and runs a program whose `pick(value, sel)` is [dispatch] over a
/// `Box` value, and returns what it answers for each of [selectors].
Future<List<Object?>> _runDispatch(
  BoundedDispatch dispatch,
  List<String> selectors,
) async {
  final dir = Directory.systemTemp.createTempSync('gh11_dispatch_');
  addTearDown(() => dir.deleteSync(recursive: true));
  final program = File('${dir.path}/main.dart')
    ..writeAsStringSync('''
import 'dart:convert';

class Box {
  Box(this.tag);
  final String tag;
}

Object? pick(Object value, String sel) {
  if (value is! Box) return null;
${dispatch.statements}}

${dispatch.leafFunctions}
void main(List<String> args) {
  final box = Box('b');
  print(jsonEncode([for (final s in args) pick(box, s)]));
}
''');
  final result = await Process.run(Platform.resolvedExecutable, [
    'run',
    program.path,
    ...selectors,
  ]);
  expect(result.exitCode, 0, reason: '${result.stdout}\n${result.stderr}');
  return jsonDecode((result.stdout as String).trim()) as List<Object?>;
}

void main() {
  group('GH11: bounded selector dispatch', () {
    test('GH11-1: 64 distinct selectors stay one switch, written as before '
        '[2026-11-09]', () {
      final d = _dispatch(_arms(64));
      expect(d.leafFunctions, isEmpty);
      final lines = d.statements.split('\n');
      expect(lines.first, '  return switch (sel) {');
      expect(lines[1], "    'S0' => 'v0',");
      expect(lines[64], "    'S63' => 'v63',");
      expect(lines[65], '    _ => null,');
      expect(lines[66], '  };');
    });

    test('GH11-2: 65 distinct selectors split into leaves of at most 64 '
        '[2026-11-09]', () {
      final d = _dispatch(_arms(65));
      expect(d.statements, isNot(contains('switch (')));
      expect(d.statements, contains("sel.compareTo('"));
      expect(_switchCount(d.leafFunctions), 2);
      for (final leaf in d.leafFunctions.split(RegExp(r'\n(?=///)'))) {
        expect(
          RegExp(
            r"^\s+'[^']*'( \|\| '[^']*')* =>",
            multiLine: true,
          ).allMatches(leaf).length,
          lessThanOrEqualTo(64),
        );
      }
      // 3 233 selectors, the largest relaxer switch measured: 51 leaves.
      final big = _dispatch(_arms(3233));
      expect(_switchCount(big.leafFunctions), 51);
    });

    test('GH11-3: a duplicate selector counts once and keeps its first arm '
        '[2026-11-09]', () {
      // 65 arms, one repeating S0: 64 distinct selectors, one switch.
      final withDuplicate = [
        ..._arms(64),
        const DispatchArm(['S0'], "'late'"),
      ];
      expect(_dispatch(withDuplicate).leafFunctions, isEmpty);
      // Past the bound the duplicate is dropped and S0 keeps 'v0'.
      final split = _dispatch([
        ..._arms(65),
        const DispatchArm(['S0'], "'late'"),
      ]);
      expect(split.leafFunctions, isNot(contains("'late'")));
      expect(split.leafFunctions, contains("'S0' => 'v0'"));
    });

    test('GH11-4: an arm with several selectors keeps them together within a '
        'leaf, and no selector is lost [2026-11-09]', () {
      final arms = [
        const DispatchArm(['dynamic', 'Object', 'Object?'], "'top'"),
        ..._arms(100),
      ];
      final d = _dispatch(arms);
      final selectors = RegExp(
        r"'([^']*)'(?= \|\| | =>)",
      ).allMatches(d.leafFunctions).map((m) => m.group(1)).toList();
      expect(selectors.toSet(), {
        'dynamic',
        'Object',
        'Object?',
        for (var i = 0; i < 100; i++) 'S$i',
      });
      expect(selectors.length, 103);
      expect(d.leafFunctions, contains("'Object' || 'Object?' => 'top'"));
    });

    test('GH11-5: generated dispatches compile and answer as the single '
        'switch would, for every selector, an unknown one, typed arguments '
        'and an empty dispatch [2026-11-09]', () async {
      // 130 arms over a typed `Box value` (three leaves), plus a duplicate.
      final arms = [
        for (var i = 0; i < 130; i++) DispatchArm(['T$i'], "'\${value.tag}$i'"),
        const DispatchArm(['T5'], "'duplicate'"),
      ];
      final typed = writeBoundedSelectorDispatch(
        selector: 'sel',
        arms: arms,
        fallback: 'null',
        returnType: 'Object?',
        leafPrefix: '_pick',
        parameters: [(type: 'Box', name: 'value')],
      );
      expect(_switchCount(typed.leafFunctions), 3);
      final selectors = [
        for (var i = 0; i < 130; i++) 'T$i',
        'missing',
        '',
        'T99x',
      ];
      expect(await _runDispatch(typed, selectors), [
        for (var i = 0; i < 130; i++) 'b$i',
        null,
        null,
        null,
      ]);

      final empty = _dispatch(const []);
      expect(empty.leafFunctions, isEmpty);
      expect(await _runDispatch(empty, ['T0']), [null]);
    });

    test('GH11-6: the relaxer and RC-2 constructor factories of a large '
        'dispatch are bounded [2026-11-09]', () {
      final types = {for (var i = 0; i < 200; i++) 'Type$i'};
      final factory = generateRelaxerFactoryFunctionForTesting(
        'Holder',
        'widgets',
        types,
        r'_relaxHolder$widgets',
      );
      expect(factory, contains(r'Object? _relaxHolder$widgets('));
      expect(factory, contains("innerTypeArg.compareTo('"));
      expect(
        factory,
        contains(
          r'Object? _relaxHolder$widgets$leaf0(String innerTypeArg, '
          'Holder value) {',
        ),
      );
      expect(_switchCount(factory), 4);

      final small = generateRelaxerFactoryFunctionForTesting(
        'Holder',
        'widgets',
        {'A', 'B'},
        r'_relaxHolder$widgets',
      );
      expect(
        small,
        contains(
          '  return switch (innerTypeArg) {\n'
          r"    'A' => $RelaxedHolder<A>(value),"
          '\n'
          r"    'B' => $RelaxedHolder<B>(value),"
          '\n'
          '    _ => null,\n'
          '  };\n'
          '}\n',
        ),
      );

      // RC-2: `Holder<T>(T value, double scale, {String? label})` over 200
      // bridged types. The leaves take `visitor` and every extracted argument,
      // typed as the extraction types it.
      final holder = ClassInfo(
        name: 'Holder',
        sourceFile: 'package:holder/holder.dart',
        typeParameters: {'T': null},
        constructors: [
          ConstructorInfo(
            parameters: [
              ParameterInfo(name: 'value', type: 'T'),
              ParameterInfo(name: 'scale', type: 'double'),
              ParameterInfo(
                name: 'label',
                type: 'String?',
                isNamed: true,
                isRequired: false,
              ),
            ],
          ),
        ],
      );
      final ctorFactory = generateGenericConstructorFactoryForTesting(
        holder,
        holder.constructors.single,
        '_rc2Holder',
        types.toList()..sort(),
        {'Holder': holder},
      );
      expect(ctorFactory, contains("typeName.compareTo('"));
      expect(
        ctorFactory,
        contains(
          r'Object? _rc2Holder$leaf0(String typeName, dynamic visitor, '
          'Object? value, double? scale, String? label) {',
        ),
      );
      // 200 bridged types + the primitive arms of an unbounded T: past 64.
      expect(_switchCount(ctorFactory), greaterThan(1));
      expect(ctorFactory, contains("'Type0' => Holder<Type0>("));
    });

    test('GH11-7: a bound below 1 is refused [2026-11-09]', () {
      expect(() => _dispatch(_arms(3), maxSelectors: 0), throwsArgumentError);
    });
  });
}
