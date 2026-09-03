// SCB3: StdioType's named constants must be reachable as STATIC members.
//
// Found by the mechanical member diff (tool/stdlib_member_diff.dart) and
// classified as a round-trip break, not a gap. `stdioType(stdout)` was bridged
// and returns a `StdioType`, and `StdioType` itself was registered — but its
// four constants (`terminal`, `pipe`, `file`, `other`) sat in the bridge's
// *instance* `getters` map, so `StdioType.terminal` could not resolve. The
// result was a value a script could obtain but had no way to compare against
// anything, which is strictly worse than the class being absent: the failure
// only appears at the comparison, after the call has already succeeded.

import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('StdioType static constants', () {
    test('F-SCB3-8: the four constants resolve as static members '
        '[2026-07-28]', () {
      const source = '''
      import 'dart:io';
      main() {
        return [
          StdioType.terminal.name,
          StdioType.pipe.name,
          StdioType.file.name,
          StdioType.other.name,
        ];
      }
      ''';
      expect(execute(source), equals(['terminal', 'pipe', 'file', 'other']));
    });

    test('F-SCB3-9: stdioType() result is comparable against the constants — '
        'the round trip [2026-07-28]', () {
      // Under `dart test` the stdout handle is a pipe, but asserting *which*
      // constant would tie the test to how it was launched. What must hold is
      // that the returned value is one of the four and identity comparison
      // works at all — that is the capability the break removed.
      const source = '''
      import 'dart:io';
      main() {
        final t = stdioType(stdout);
        final all = [
          StdioType.terminal, StdioType.pipe, StdioType.file, StdioType.other
        ];
        var matches = 0;
        for (final c in all) { if (identical(t, c)) matches++; }
        return [t is StdioType, matches];
      }
      ''';
      expect(execute(source), equals([true, 1]));
    });

    test('F-SCB3-10: constants are usable in an equality branch '
        '[2026-07-28]', () {
      // The idiomatic consumer shape: branch on the type to decide whether to
      // emit ANSI colour. Requires both the static read and `==`.
      const source = '''
      import 'dart:io';
      main() {
        final t = stdioType(stdout);
        if (t == StdioType.terminal) return 'tty';
        if (t == StdioType.pipe) return 'piped';
        if (t == StdioType.file) return 'redirected';
        return 'other';
      }
      ''';
      expect(execute(source),
          isIn(['tty', 'piped', 'redirected', 'other']));
    });

    test('F-SCB3-11: toString carries the StdioType prefix [2026-07-28]', () {
      const source = '''
      import 'dart:io';
      main() {
        return StdioType.terminal.toString();
      }
      ''';
      expect(execute(source), equals('StdioType: terminal'));
    });

    test('F-SCB3-12: StdioType works as a declared type [2026-07-28]', () {
      const source = '''
      import 'dart:io';
      main() {
        StdioType t = StdioType.file;
        return [t is StdioType, t.name];
      }
      ''';
      expect(execute(source), equals([true, 'file']));
    });
  });
}
