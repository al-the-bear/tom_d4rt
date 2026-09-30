// WONEPRPD132: `D4rt.parse` + `D4rt.executeProgram` — a script parsed once and
// run many times. An embedder that re-runs one script (the Webwork script
// host) caches the program and pays for the parse once.
import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  group('D4rt.parse / executeProgram', () {
    test('WONEPRPD132-1: a program runs as execute runs its source', () {
      const source = 'int main() => 6 * 7;';
      final program = D4rt().parse(source);
      expect(D4rt().executeProgram(program), 42);
      expect(D4rt().execute(source: source), 42);
      expect(program.source, source);
      expect(program.basePath, isNull);
    });

    test('WONEPRPD132-2: two runs of one program share no state', () {
      final d4rt = D4rt();
      final program = d4rt.parse('''
        var count = 0;
        final made = <Box>[];
        class Box { Box() { made.add(this); } }
        int main() { count++; Box(); Box(); return count * 10 + made.length; }
      ''');
      expect(d4rt.executeProgram(program), 12);
      expect(d4rt.executeProgram(program), 12);
      expect(D4rt().executeProgram(program), 12);
    });

    test('WONEPRPD132-3: the entry point and its arguments are per run', () {
      final program = D4rt().parse('''
        String greet(String greeting, {required String name}) =>
            '\$greeting \$name';
        int main() => 0;
      ''');
      final d4rt = D4rt();
      expect(
        d4rt.executeProgram(
          program,
          name: 'greet',
          positionalArgs: ['Hello'],
          namedArgs: {'name': 'World'},
        ),
        'Hello World',
      );
      expect(d4rt.executeProgram(program), 0);
    });

    test('WONEPRPD132-4: a parse error is raised by parse, before any run', () {
      expect(
        () => D4rt().parse('int main( => 1;'),
        throwsA(isA<SourceCodeD4rtException>()),
      );
    });

    test('WONEPRPD132-5: a runtime error is raised by the run, each time', () {
      final d4rt = D4rt();
      final program = d4rt.parse('int main() => throw StateError("boom");');
      for (var i = 0; i < 2; i++) {
        expect(() => d4rt.executeProgram(program), throwsA(anything));
      }
    });

    test('WONEPRPD132-6: an async program completes on every run', () async {
      final d4rt = D4rt();
      final program = d4rt.parse('''
        Future<int> main() async { await Future.delayed(Duration.zero); return 7; }
      ''');
      expect(await d4rt.executeProgram(program), 7);
      expect(await d4rt.executeProgram(program), 7);
    });

    test(
      'WONEPRPD132-7: a program outlives its interpreter being disposed',
      () {
        // A resident embedder disposes between runs to release what the
        // interpreter retains; the program is the embedder's, not the
        // interpreter's, so it must survive that.
        final d4rt = D4rt();
        final program = d4rt.parse('var n = 0; int main() { n++; return n; }');
        expect(d4rt.executeProgram(program), 1);
        d4rt.dispose();
        expect(d4rt.executeProgram(program), 1);
        d4rt.dispose();
        expect(d4rt.executeProgram(program), 1);
      },
    );
  });
}
