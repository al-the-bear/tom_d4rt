// Copyright (c) 2025 Thomas Schaller. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// Tests for [prepareProgramSource], the rule that turns whatever the user
/// handed a "run as a fresh program" command into something `D4rt.execute`
/// can actually run.
///
/// `execute(source:)` parses its argument as a compilation unit and calls the
/// top-level `main`. Bare statements are therefore not a program: `var x = 1;
/// f(x);` parses as a top-level variable followed by a function declaration
/// with no body. Every entry point that says "fresh program" — stdin, the
/// `exec` command and `.start-execute` — has to apply the same rule, which is
/// why it lives in one function rather than at each call site.
library;

import 'package:test/test.dart';
import 'package:tom_dcli_exec/src/cli/repl_base.dart';

const _imports = "import 'package:test_bridge/test_bridge.dart';";

void main() {
  group('prepareProgramSource', () {
    test('leaves a complete program untouched', () {
      const source = '''
import 'dart:math';
void main() {
  print(max(1, 2));
}
''';
      expect(prepareProgramSource(source, importBlock: _imports), source);
    });

    test('prefixes the import block when the program declares main', () {
      const source = 'void main() { print("fresh"); }';
      final result = prepareProgramSource(source, importBlock: _imports);

      expect(result, startsWith(_imports));
      expect(result, contains(source));
    });

    test('wraps bare statements in main and prefixes imports', () {
      const source = '''
var testVar = 100;
verify(testVar == 100, '.start-execute variable works');
''';
      final result = prepareProgramSource(source, importBlock: _imports);

      expect(result, startsWith(_imports));
      expect(result, contains('main(List<String> args)'));
      expect(result, contains('var testVar = 100;'));
      expect(result, contains('verify(testVar == 100,'));
    });

    test('recognises main with a return type and arguments', () {
      const source = 'Future<void> main(List<String> args) async {}';
      final result = prepareProgramSource(source, importBlock: _imports);

      // Recognised as a program, so it is prefixed rather than nested inside a
      // second main that would never be called.
      expect(result, isNot(contains('main(List<String> args) {')));
      expect(result, endsWith(source));
    });

    test('recognises main declared after a statement on the same line', () {
      // The CLI API tier is driven with sources of exactly this shape. Wrapping
      // one in a generated main would turn `testVar` into a local, so a later
      // `eval('testVar')` against the same environment would no longer see it.
      const source = 'var testVar = 42; void main() {}';
      final result = prepareProgramSource(source, importBlock: '');

      expect(result, source);
    });

    test('does not mistake a call to main() for a declaration of it', () {
      // `main();` is a statement, not a declaration. Treating it as a program
      // would hand execute() a unit whose only top-level member is invalid.
      const source = 'print("before"); main();';
      final result = prepareProgramSource(source, importBlock: _imports);

      expect(result, contains('main(List<String> args)'));
    });

    test('makes the generated main async when the statements await', () {
      // Bare statements that await are the common shape for a script; wrapping
      // them in a synchronous main would turn a working script into a parse
      // error about `await` outside an async function.
      const source = 'var f = await Future.value(1); print(f);';
      final result = prepareProgramSource(source, importBlock: _imports);

      expect(result, contains('async'));
      expect(result, contains('main(List<String> args)'));
    });

    test('leaves a synchronous wrapper synchronous', () {
      const source = 'print("no await here");';
      final result = prepareProgramSource(source, importBlock: _imports);

      expect(result, isNot(contains('async')));
    });

    test('omits the import block when it is empty', () {
      const source = 'print("hi");';
      final result = prepareProgramSource(source, importBlock: '');

      expect(result.trimLeft(), startsWith('Object?'));
    });
  });
}
