// SCD72 — a host that logs a script object sees the `toString()` the script
// wrote.
//
// `InterpretedInstance.toString()` returned a fixed diagnostic string and never
// dispatched to the instance's own override, so `'$e'` on a script-defined
// exception printed `<instance of MyErr>` instead of `MyErr: boom`. Inside a
// script, interpolation already worked — `InterpreterVisitor.stringify` has
// dispatched to the override for a long time — which is exactly why this was
// easy to miss: the gap only showed at the boundary where an instance reaches
// native code.
//
// AND IT SHOWED THERE MORE THAN THE TODO SAID. Measured before the fix, the
// diagnostic form leaked in three places, not one: a host interpolating a value
// returned by `execute`, a `D4rt.onUncaughtError` hook, and — inside a script —
// any native container holding the instance (`'${[e]}'` gave
// `[<instance of MyErr>]`, because `List.toString()` is native and calls the
// native `toString`). The third is a script-visible bug on its own.
//
// WHY A VISITOR HAD TO BE STORED. Dispatching to interpreted code needs an
// `InterpreterVisitor`, and `toString()` is a plain `Object` override with
// nowhere to receive one. `D4.activeVisitor` — the ambient one the interpreter
// already maintains around every call — was the cheap candidate and it is not
// enough: measured, it is NULL inside an `onUncaughtError` hook, because the
// interpreter has unwound by the time the embedder runs. So the reference is
// stored on the CLASS (`InterpretedClass.declaringVisitor`), one per class
// rather than one per instance: classes are few, instances are many, and the
// class is what owns the method being dispatched. A captured visitor was
// measured still able to dispatch after `execute` returned.
//
// THE CONTRACT SPLITS BY CALLER, and F-SCD72-4 and -5 are the two halves:
//
//   * `stringify` (interpolation inside a script) keeps Dart's semantics — a
//     throwing `toString` propagates, and `toString() => '$this'` overflows the
//     stack. Both did before this change and both still do.
//   * `toString()` (what HOST code reaches) does not throw for anything
//     recoverable. A host's first act on receiving an error is to log it, and a
//     second exception raised while reporting the first is worse than an
//     imperfect string — the reasoning behind the SDK's own `Error.safeToString`.
//
// TWO VM ERRORS ARE THE EXCEPTION TO THAT, AND THE REASON IS MEASURED. The
// first draft caught everything; a pair of mutually-interpolating objects then
// stopped raising `StackOverflowError` and started HANGING — the overflow
// unwound into the catch, the diagnostic form was returned, the caller resumed
// on a still-full stack and overflowed again, forever. `StackOverflowError` and
// `OutOfMemoryError` are rethrown. Swallowing an unrecoverable VM error turns a
// fast crash into a livelock, which is the one outcome worse than the exception.
//
// CONTROL, measured by reverting `toString()` to the diagnostic form: `+2 -5`.
// F-SCD72-3 (no override) and F-SCD72-5 (in-script semantics) keep passing, and
// they are the rails — -3 stops the fix from rendering classes that never asked
// for it, and -5 stops it from being applied to the path that must keep Dart's
// propagating behaviour.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// A script class with a `toString` override, and a `main` that returns one.
const _withOverride = '''
class MyErr {
  final String m;
  MyErr(this.m);
  String toString() => 'MyErr: ' + m;
}
main() => MyErr('boom');
''';

Object? run(String source) => D4rt().execute(source: source, name: 'main');

void main() {
  group('SCD72: a host sees the script\'s toString', () {
    test('F-SCD72-1: interpolating a returned instance uses the override '
        '[2026-09-13] (PASS)', () {
      final instance = run(_withOverride);
      expect(instance, isA<InterpretedInstance>());
      // The assertion is on the STRING a host would log, not on a rendering
      // helper — `'$instance'` is the thing that was wrong.
      expect('$instance', 'MyErr: boom');
      expect(instance.toString(), 'MyErr: boom');
    });

    test(
      'F-SCD72-2: an onUncaughtError hook sees it too [2026-09-13] (PASS)',
      () async {
        // The case the todo was filed for. It is the hardest one because the
        // interpreter has already unwound: the error arrives from a stream
        // callback after `main` returned, so there is no ambient visitor.
        final seen = <String>[];
        final d4rt = D4rt()..setDebug(false);
        d4rt.onUncaughtError = (error, _) => seen.add('$error');
        final result = d4rt.execute(
          library: 'package:test/main.dart',
          sources: {
            'package:test/main.dart': '''
              class MyErr {
                final String m;
                MyErr(this.m);
                String toString() => 'MyErr: ' + m;
              }
              main() {
                Stream.fromIterable([1]).listen((v) { throw MyErr('boom'); });
                return 'started';
              }
            ''',
          },
        );
        if (result is Future) await result;
        await Future<void>.delayed(const Duration(milliseconds: 120));
        expect(seen, ['MyErr: boom']);
      },
    );

    test('F-SCD72-3: a class with no override keeps the diagnostic form '
        '[2026-09-13] (PASS)', () {
      // THE RAIL. The fix must render what the script asked to render and
      // nothing else; a version that always dispatched would have to invent
      // something for a class that declares no `toString`, and the
      // interpreter's own description is the right answer there.
      expect(
        '${run('class Bare { }\nmain() => Bare();')}',
        '<instance of Bare>',
      );
    });

    test('F-SCD72-4: a throwing override falls back instead of escaping '
        '[2026-09-13] (PASS)', () {
      // The done-when's second half. A host interpolating this must get a
      // string, not an exception — it is very likely already inside an error
      // handler.
      const cases = <String, String>{
        'throws':
            "class T { String toString() => throw StateError('x'); }\n"
            'main() => T();',
        'reads an undefined name':
            'class M { String toString() => nope; }\nmain() => M();',
      };
      cases.forEach((label, source) {
        final instance = run(source);
        expect(
          () => '$instance',
          returnsNormally,
          reason: 'a $label override must not escape into host code',
        );
        expect('$instance', startsWith('<instance of '), reason: label);
      });

      // A non-String return is a script bug rather than a failure: render it
      // the way `stringify` does rather than discarding it.
      expect('${run('class N { toString() => 42; }\nmain() => N();')}', '42');
    });

    test('F-SCD72-5: in-script interpolation keeps Dart semantics '
        '[2026-09-13] (PASS)', () {
      // THE OTHER RAIL, and the reason the two paths are allowed to differ.
      // Inside a script a throwing `toString` propagates, exactly as in real
      // Dart — the host-safety rule above must not leak in here and silently
      // turn a script's exception into a placeholder string.
      expect(
        () => run(
          "class T { String toString() => throw StateError('x'); }\n"
          "main() { return '\${T()}'; }",
        ),
        throwsA(anything),
      );
      // And the working case still works, through the visitor rather than
      // through `Object.toString()`.
      expect(
        run(
          "class G { String toString() => 'G!'; }\nmain() { return '\${G()}'; }",
        ),
        'G!',
      );
      // `toString() => '$this'` overflows the stack in real Dart and in d4rt,
      // before this change and after. It is deliberately NOT asserted here: a
      // `StackOverflowError` caught in-process leaves the isolate in a state
      // no later test should have to trust. Measured by hand, both before and
      // after.
    });

    test('F-SCD72-6: a native container holding the instance renders it '
        '[2026-09-13] (PASS)', () {
      // The script-visible half of the same defect, and the one the todo did
      // not mention: `List.toString()` is native, so it reaches
      // `Object.toString()` and not the interpreter's `stringify`. Before the
      // fix this was `[<instance of MyErr>]`.
      expect(
        run('''
            class MyErr {
              final String m;
              MyErr(this.m);
              String toString() => 'MyErr: ' + m;
            }
            main() { return '\${[MyErr('boom')]}'; }
          '''),
        '[MyErr: boom]',
      );
    });

    test('F-SCD72-7: a cycle through a native container terminates '
        '[2026-09-13] (PASS)', () {
      // Why the re-entry guard exists, and the case that earns it. The
      // override renders a list that holds the instance itself, so dispatch
      // re-enters through the native `List.toString()`. The guard returns the
      // diagnostic form for the inner visit, which terminates; without it
      // this recurses until the stack goes.
      final instance = run('''
          class C {
            var self;
            String toString() => 'C:' + self.toString();
          }
          main() { var c = C(); c.self = [c]; return c; }
        ''');
      expect('$instance', 'C:[<instance of C>]');
    });
  });
}
