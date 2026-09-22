/// SCD77 — `Uri.isScheme` and `TimeoutException.toString` were the wrong KIND of
/// member, and nothing observable depended on them being right.
///
/// Both were registered as getters. `isScheme` is `bool isScheme(String)` in the
/// SDK, so its getter returned the native tear-off; `toString` is a method that
/// was ALSO registered as a method, which shadowed the getter and left it
/// unreachable. Measured before the change, every script-visible behaviour was
/// already correct: `uri.isScheme('https')` → `true`, the `uri.isScheme`
/// tear-off callable, `e.toString()`, the `e.toString` tear-off and `'$e'` all
/// right. So this file's job is not to prove a bug fixed — it is to pin the
/// behaviour that a normalisation could quietly break, because a change nobody
/// can see going wrong is the kind that goes wrong.
///
/// ## What the normalisation bought, and what it cost
///
/// Bought: `F-SCC24-1`'s exemption map is empty. Every entry there was a member
/// the sweep could not check, and the sweep is the whole point of SCC24.
///
/// Cost, stated plainly because it is a real behaviour change: the `isScheme`
/// tear-off used to be the NATIVE closure, so `u.isScheme.runtimeType` read
/// `(String) => bool` and `u.isScheme is Function` was `true`. As a bridged
/// method it reads `BridgedMethodCallable` and `is Function` is `false` — which
/// is what EVERY other bridged method already does. Measured 2026-09-13:
/// `'abc'.substring`, `<int>[].add`, `1.toString` and `e.toString` all report
/// `BridgedMethodCallable` and all fail `is Function`, while a script function
/// or closure passes it. So `isScheme` was the one accidental exception and this
/// change removes the exception rather than creating one. The general defect —
/// a bridged tear-off is not `is Function` — is filed as sce121_aimm.
///
/// ## Control
///
/// Reverting `isScheme` to a getter leaves every case in this file passing, and
/// that is the finding rather than a weakness: the behaviour was never broken.
/// What fails is `F-SCD77-4` in `scc24_native_name_coverage_test.dart`, which
/// reads the DECLARATION. F-SCD77-2 is the one case here that would catch a
/// botched move — a method whose adapter took its argument from the wrong place
/// fails it — and F-SCD77-3 is what would catch deleting the wrong `toString`
/// registration of the two.
library;

import 'package:tom_d4rt/d4rt.dart';
import 'package:test/test.dart';

/// Runs [body] as the body of `main()` and returns its value.
Object? run(String body, {String imports = ''}) {
  final d4rt = D4rt()..setDebug(false);
  return d4rt.execute(
    library: 'package:test/main.dart',
    sources: {'package:test/main.dart': '$imports\nmain() { $body }'},
  );
}

void main() {
  group('SCD77: the member kind is normalised, the behaviour is not', () {
    test(
      'F-SCD77-1: uri.isScheme(...) answers for the scheme it was asked about '
      '[2026-09-13]',
      () {
        // The assertion the todo made by hand and did not leave behind.
        expect(
          run(
            "final u = Uri.parse('https://a.b/c'); return u.isScheme('https');",
          ),
          isTrue,
        );
        expect(
          run(
            "final u = Uri.parse('https://a.b/c'); return u.isScheme('http');",
          ),
          isFalse,
          reason:
              'an adapter that ignored positionalArgs[0] would pass the true '
              'case and fail this one',
        );
        expect(
          run(
            "final u = Uri.parse('mailto:a@b.c'); return u.isScheme('MAILTO');",
          ),
          isTrue,
          reason:
              'the SDK comparison is case-insensitive; the bridge must not '
              'add a comparison of its own',
        );
      },
    );

    test('F-SCD77-2: the tear-off still works as a value [2026-09-13]', () {
      // The move from `getters` to `methods` could have taken this with it:
      // a bridged method tears off, but only because the interpreter makes it
      // so, and nothing else in the suite says that about a method with a
      // required positional argument.
      expect(
        run(
          "final u = Uri.parse('https://a.b/c'); final f = u.isScheme; "
          "return [f('https'), f('http')];",
        ),
        [true, false],
      );
      expect(
        run(
          "final u = Uri.parse('https://a.b/c'); return u.isScheme is Function;",
        ),
        isTrue,
        reason:
            'FLIPPED BY SCE121, which is the point of having written the false '
            'down rather than omitting it. A native function value used to '
            'fail `is Function` in a script whether it arrived through a '
            'getter or a method — measured on both shapes — so a script\'s '
            '`if (x is Function) x()` guard rejected a value the interpreter '
            'could call. The `Function` bridge answers with the interpreter\'s '
            'own `Callable` interface now. `is String Function(int)` and '
            '`runtimeType` are still not function types; see Lim-11',
      );
    });

    test('F-SCD77-3: TimeoutException renders through the method that survived '
        '[2026-09-13]', () {
      // `toString` was registered twice — as a getter and as a method — and
      // the method shadowed the getter, so the getter was dead code. Deleting
      // the wrong one of the two would fail here rather than in a corpus run
      // three weeks later.
      const imports = "import 'dart:async';";
      const build = "final e = TimeoutException('slow', Duration(seconds: 1));";
      expect(
        run('$build return e.toString();', imports: imports),
        'TimeoutException after 0:00:01.000000: slow',
      );
      expect(
        run('$build final f = e.toString; return f();', imports: imports),
        'TimeoutException after 0:00:01.000000: slow',
        reason:
            'the tear-off has to come from the method, not from a getter '
            'that returns a String',
      );
      expect(
        run("$build return 'E=\$e';", imports: imports),
        'E=TimeoutException after 0:00:01.000000: slow',
        reason: 'interpolation goes through stringify, a third route again',
      );
      expect(
        run(
          "final e = TimeoutException('slow'); return e.message;",
          imports: imports,
        ),
        'slow',
      );
    });
  });
}
