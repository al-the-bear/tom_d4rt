// DFIN5 (dgub14): declarations an IMPORTED module carries reach the importer.
//
// tom_d4rt_exec has its own module loader, and it lacked two passes the other
// two loaders have: static-field initializers deferred until every class is
// populated, and the extension-type declaration pass. A probe on 2026-10-03
// returned 2 and 14 here and failed in exec.
//
// Twin: tom_d4rt_exec ports this file verbatim.
import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? _run(Map<String, String> modules, String main) => D4rt().execute(
  library: 'package:app/main.dart',
  sources: {...modules, 'package:app/main.dart': main},
);

void main() {
  group('DFIN5: imported module declarations', () {
    test('DFIN5-1: a static field that constructs a class declared LATER in '
        'the imported module [2026-10-03]', () {
      expect(
        _run(
          {
            'package:app/a.dart': '''
class A { static final List<B> items = [B(1), B(2)]; }
class B { final int v; B(this.v); }
''',
          },
          '''
import 'package:app/a.dart';
int main() => A.items.length;
''',
        ),
        2,
      );
    });

    test('DFIN5-2: an extension type declared in the imported module '
        '[2026-10-03]', () {
      expect(
        _run(
          {
            'package:app/money.dart': '''
extension type Amount(int cents) {
  int get doubled => cents * 2;
}
''',
          },
          '''
import 'package:app/money.dart';
int main() => Amount(7).doubled;
''',
        ),
        14,
      );
    });
  });
}
