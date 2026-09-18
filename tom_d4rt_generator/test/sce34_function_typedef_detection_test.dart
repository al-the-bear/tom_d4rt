// Whether a type is a function typedef is the ANALYZER's answer, not a lookup
// in a list of about fifty known names.
//
// `_isFunctionTypeName` decided it by name, and every callback emitter branched
// on that. The list gets both directions wrong, and both are measured here:
//
//   * an unlisted package-local typedef is MISSED. `List<ZomHandler>` took the
//     ordinary `D4.coerceList` path while the identically shaped
//     `List<VoidCallback>` was correctly refused — the scd7 fixture had to use
//     a listed name to reach the path it wanted to test, and says so.
//   * a CLASS that happens to share a listed typedef's name is MISCLASSIFIED.
//     A parameter of a class called `ErrorHandler` resolved to `dynamic`,
//     losing its type, while the same class under an unlisted name did not.
//
// The analyzer already knew: `extractFunctionTypeInfoFromDartType` unwraps a
// `TypeAliasElement` whose aliased type is a `FunctionType`. What was missing
// was carrying that verdict to the emitters, which is `ParameterInfo.
// resolvedTypeKinds`. The name list survives only for types the analyzer could
// not resolve.
//
// SINGLE-PARAMETER CALLBACKS WERE ALREADY CORRECT and are asserted anyway, so a
// regression there is caught: that path already preferred `functionTypeInfo`.

@Tags(['generation'])
library;

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

const _pkg = 'zom_sce34';

/// A package whose API puts an UNLISTED typedef in each callback position, next
/// to a listed one of the same shape, plus two classes that must keep their
/// types — one named like a listed typedef, one not.
void _writeFixture(Directory root) {
  final libDir = Directory(p.join(root.path, 'lib'))..createSync();
  File(
    p.join(root.path, 'pubspec.yaml'),
  ).writeAsStringSync("name: $_pkg\nenvironment:\n  sdk: '>=3.0.0 <4.0.0'\n");
  File(p.join(libDir.path, 'handlers.dart')).writeAsStringSync('''
typedef ZomHandler = void Function(int value);
typedef VoidCallback = void Function();

/// Shares a name with a listed typedef. It is a class.
class ErrorHandler {
  const ErrorHandler(this.code);
  final int code;
}

/// The same shape under a name the list does not contain — the control that
/// separates "the list did this" from "this is how classes render".
class ZomNotAHandler {
  const ZomNotAHandler(this.code);
  final int code;
}

class ZomTarget {
  void takeUnlisted(ZomHandler h) {}
  void takeUnlistedList(List<ZomHandler> hs) {}
  void takeUnlistedMap(Map<String, ZomHandler> hs) {}
  void takeListed(VoidCallback h) {}
  void takeListedList(List<VoidCallback> hs) {}
  void takeListedMap(Map<String, VoidCallback> hs) {}
  void takeErrorHandlerClass(ErrorHandler e) {}
  void takeControlClass(ZomNotAHandler c) {}
}
''');
}

/// Borrows the generator's own resolved config so the fixture's imports
/// resolve, then appends the fixture package.
void _writePackageConfig(Directory root) {
  final own = File(p.join('.dart_tool', 'package_config.json'));
  if (!own.existsSync()) {
    fail(
      'The generator package has no resolved .dart_tool/package_config.json. '
      'Run `dart pub get` in tom_d4rt_generator.',
    );
  }
  final config = jsonDecode(own.readAsStringSync()) as Map<String, dynamic>;
  final packages = [
    ...(config['packages'] as List).cast<Map<String, dynamic>>(),
    {
      'name': _pkg,
      'rootUri': root.uri.toString(),
      'packageUri': 'lib/',
      'languageVersion': '3.0',
    },
  ];
  Directory(p.join(root.path, '.dart_tool')).createSync(recursive: true);
  File(
    p.join(root.path, '.dart_tool', 'package_config.json'),
  ).writeAsStringSync(jsonEncode({'configVersion': 2, 'packages': packages}));
}

/// The emitted body of `method`, bounded by the next method key so a line is
/// never attributed to the wrong one.
String _bodyOf(String text, String method, List<String> allMethods) {
  final start = text.indexOf("'$method':");
  expect(start, greaterThanOrEqualTo(0), reason: '$method was not emitted');
  var end = text.length;
  for (final other in allMethods) {
    if (other == method) continue;
    final j = text.indexOf("'$other':", start + 1);
    if (j > start && j < end) end = j;
  }
  return text.substring(start, end);
}

void main() {
  late Directory root;
  late String emitted;

  const methods = [
    'takeUnlisted',
    'takeUnlistedList',
    'takeUnlistedMap',
    'takeListed',
    'takeListedList',
    'takeListedMap',
    'takeErrorHandlerClass',
    'takeControlClass',
  ];

  setUpAll(() async {
    root = Directory.systemTemp.createTempSync('sce34_');
    _writeFixture(root);
    _writePackageConfig(root);
    final generator = BridgeGenerator(
      workspacePath: root.path,
      packageName: _pkg,
      skipPrivate: true,
      helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
    );
    final output = p.join(root.path, 'out.b.dart');
    final result = await generator.generateBridges(
      sourceFiles: [p.join(root.path, 'lib', 'handlers.dart')],
      outputPath: output,
    );
    expect(result.errors, isEmpty, reason: 'fixture generation failed');
    emitted = File(output).readAsStringSync();
  });

  tearDownAll(() {
    if (root.existsSync()) root.deleteSync(recursive: true);
  });

  test('GEN-TYPEDEF-1: an unlisted typedef in a List is treated exactly as a '
      'listed one is [2026-09-18]', () {
    // sce35 changed WHAT that treatment is — both are now converted element
    // by element rather than refused. What this test is for is unchanged:
    // the two must not diverge because one name happens to be in a list.
    final unlisted = _bodyOf(emitted, 'takeUnlistedList', methods);
    final listed = _bodyOf(emitted, 'takeListedList', methods);

    expect(
      listed,
      contains('Convert list with function elements inline'),
      reason:
          'the listed typedef is the control; if this changed, the '
          'comparison below means nothing',
    );
    expect(
      unlisted,
      contains('Convert list with function elements inline'),
      reason:
          'decided by name, an unlisted typedef took the ordinary '
          'coerceList path instead',
    );
    expect(unlisted, isNot(contains('D4.coerceList<')));
  });

  test('GEN-TYPEDEF-2: an unlisted typedef as a Map value gets the wrapper '
      'conversion, as a listed one does [2026-09-18]', () {
    final unlisted = _bodyOf(emitted, 'takeUnlistedMap', methods);
    final listed = _bodyOf(emitted, 'takeListedMap', methods);

    expect(listed, isNot(contains('D4.coerceMap<')), reason: 'control');
    expect(
      unlisted,
      isNot(contains('D4.coerceMap<')),
      reason:
          'decided by name, an unlisted typedef took the ordinary '
          'coerceMap path instead of a wrapper map',
    );
  });

  test('GEN-TYPEDEF-3: a class sharing a listed typedef name keeps its type '
      '[2026-09-18]', () {
    final shared = _bodyOf(emitted, 'takeErrorHandlerClass', methods);
    final control = _bodyOf(emitted, 'takeControlClass', methods);

    // The control proves `dynamic` would have been the list's doing rather
    // than how every class renders.
    expect(control, contains('ZomNotAHandler>'));
    expect(
      shared,
      contains('ErrorHandler>'),
      reason:
          'the name list treated a class as a function type and erased '
          'its type to dynamic',
    );
    expect(shared, isNot(contains('getRequiredArg<dynamic>')));
  });

  test(
    'GEN-TYPEDEF-4: a single callback parameter is wrapped from the typedef\'s '
    'real signature, listed or not [2026-09-18]',
    () {
      // This path already preferred the analyzer before the change. Asserted so
      // that a later simplification cannot quietly hand it back to the list.
      expect(
        _bodyOf(emitted, 'takeUnlisted', methods),
        contains('(int p0)'),
        reason: "ZomHandler is void Function(int), so the wrapper takes an int",
      );
      expect(
        _bodyOf(emitted, 'takeListed', methods),
        contains('callInterpreterCallback'),
      );
    },
  );
}
