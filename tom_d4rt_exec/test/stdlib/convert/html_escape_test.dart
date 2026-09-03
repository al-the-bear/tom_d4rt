// SCB3: HtmlEscapeMode's named constants must be reachable as STATIC members.
//
// The mechanical member diff (tool/stdlib_member_diff.dart) surfaced this as a
// round-trip break rather than a plain gap: `HtmlEscapeMode` was registered,
// and `HtmlEscape`'s constructor accepts a mode — but the four constants
// (`element`, `attribute`, `sqAttribute`, `unknown`) were declared in the
// bridge's *instance* `getters` map, so `HtmlEscapeMode.element` — a static
// read — could not resolve. The bridge therefore advertised a mode parameter
// that no script could supply a value for, and `HtmlEscape.mode` was absent so
// the mode could not be read back off a constructed escaper either.
//
// Note on the surface being pinned: `HtmlEscapeMode` exposes **no public `name`
// getter** — the backing field is private and `toString()` is the only way to
// read the mode's name. The four escape flags are the rest of its public API.

import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('HtmlEscapeMode static constants', () {
    test('F-SCB3-1: the four named modes resolve as static members '
        '[2026-07-28]', () {
      // `sqAttribute` really does stringify as "attribute" — the SDK builds it
      // with that name. Pinned deliberately so a future "fix" to the bridge
      // that invents a nicer name fails here instead of silently diverging.
      const source = '''
      import 'dart:convert';
      main() {
        return [
          HtmlEscapeMode.element.toString(),
          HtmlEscapeMode.attribute.toString(),
          HtmlEscapeMode.sqAttribute.toString(),
          HtmlEscapeMode.unknown.toString(),
        ];
      }
      ''';
      expect(execute(source),
          equals(['element', 'attribute', 'attribute', 'unknown']));
    });

    test('F-SCB3-2: a mode constant can be handed to the HtmlEscape '
        'constructor [2026-07-28]', () {
      // This is the round trip the bridge advertised but could not complete:
      // the constructor took a mode it was impossible to name.
      const source = '''
      import 'dart:convert';
      main() {
        final esc = HtmlEscape(HtmlEscapeMode.attribute);
        return esc.convert('a "b" <c>');
      }
      ''';
      expect(execute(source), equals('a &quot;b&quot; &lt;c&gt;'));
    });

    test('F-SCB3-3: HtmlEscape.mode reads back the mode it was built with '
        '[2026-07-28]', () {
      const source = '''
      import 'dart:convert';
      main() {
        final esc = HtmlEscape(HtmlEscapeMode.element);
        return [esc.mode is HtmlEscapeMode, esc.mode.toString()];
      }
      ''';
      expect(execute(source), equals([true, 'element']));
    });

    test('F-SCB3-4: the escape flags of each mode are exposed [2026-07-28]',
        () {
      // The flags are what make a mode meaningful; without them a script that
      // receives a mode cannot tell what it will do.
      const source = '''
      import 'dart:convert';
      main() {
        final a = HtmlEscapeMode.attribute;
        final u = HtmlEscapeMode.unknown;
        return [
          a.escapeQuot, a.escapeApos, a.escapeLtGt, a.escapeSlash,
          u.escapeQuot, u.escapeApos, u.escapeLtGt, u.escapeSlash,
        ];
      }
      ''';
      expect(execute(source),
          equals([true, false, true, false, true, true, true, true]));
    });

    test('F-SCB3-5: a custom mode round-trips through HtmlEscape '
        '[2026-07-28]', () {
      const source = '''
      import 'dart:convert';
      main() {
        final m = HtmlEscapeMode(name: 'mine', escapeApos: true);
        final esc = HtmlEscape(m);
        return [esc.mode.toString(), esc.convert("it's"), m.toString()];
      }
      ''';
      expect(execute(source), equals(['mine', 'it&#39;s', 'mine']));
    });

    test('F-SCB3-6: the default htmlEscape global still works alongside the '
        'constants [2026-07-28]', () {
      const source = '''
      import 'dart:convert';
      main() {
        return [htmlEscape.convert('<a>'), htmlEscape.mode.toString()];
      }
      ''';
      expect(execute(source), equals(['&lt;a&gt;', 'unknown']));
    });

    test('F-SCB3-7: element mode leaves quotes alone — the modes are '
        'distinguishable in behaviour [2026-07-28]', () {
      // Two modes that differ only in flags must actually produce different
      // output; otherwise the constants could be aliased without detection.
      const source = '''
      import 'dart:convert';
      main() {
        final e = HtmlEscape(HtmlEscapeMode.element).convert('a "b" <c>');
        final u = HtmlEscape(HtmlEscapeMode.unknown).convert('a "b" <c>');
        return [e, u, e == u];
      }
      ''';
      expect(
          execute(source),
          equals([
            'a "b" &lt;c&gt;',
            'a &quot;b&quot; &lt;c&gt;',
            false,
          ]));
    });
  });
}
