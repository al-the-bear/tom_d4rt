// SCC28 — "member absent" is a typed signal, not a sentence.
//
// THE DEFECT SHAPE
//
// Member lookup failed by throwing `RuntimeD4rtException("Undefined property
// '<name>' on <receiver>")`, and eight sites in each mirrored visitor then asked
// `e.message.contains("Undefined property '$name'")` to decide between two
// entirely different continuations:
//
//   true  → the member is genuinely absent; try extension-method resolution
//   false → something else went wrong inside the member; propagate it
//
// A formatted, human-readable diagnostic was the control-flow signal. Three
// things followed from that, and all three are the reason this is a test rather
// than a comment:
//
//   1. The message could not be reworded. Any edit to those strings — including
//      a typo fix or a translation — silently disables extension-method
//      resolution for every receiver kind routed through the edited site.
//      `dart analyze` cannot see it, and the failure is a *wrong answer*
//      (`NoSuchMethod`-shaped error where a working extension method exists),
//      not a crash.
//   2. The raise sites could not be typed. SCB10 converted only the four *final*
//      member-lookup failures to `D4rtNoSuchMethodError` — the ones reached
//      after extension lookup and any user `noSuchMethod` have already had their
//      chance, where nothing sniffs. Every intermediate site had to stay a
//      `RuntimeD4rtException` with that exact wording, because a
//      `D4rtNoSuchMethodError` has no `.message` of the sniffed shape and is not
//      caught by the `on RuntimeD4rtException` clauses doing the sniffing.
//   3. The test was a substring test, so it matched too much (see F-SCC28-9).
//
// WHAT REPLACED IT
//
// `UndefinedMemberD4rtException`, a `RuntimeD4rtException` subtype carrying the
// absent member's name as a field. Subtyping is what let this land site by site
// instead of as one sweep: every surrounding `on RuntimeD4rtException` handler
// keeps catching, and `toString()` is inherited, so the diagnostics are
// unchanged to the byte. The change is visible only in the type — which is
// exactly what makes the message free to be reworded afterwards.
//
// WHY THE PRIMARY GUARD IS A SOURCE SCAN
//
// The property being protected is "no site decides this by reading text", and
// that is a property of the source, not of any one execution. A behavioural test
// can only show that the sites which exist today take the right branch today; it
// cannot notice a ninth site added next month with a fresh `contains(...)`.
// F-SCC28-1 can, and it covers both mirrored trees, so re-introducing the
// pattern in either half fails here.
//
// The behavioural cases are not redundant with it: the scan would also pass if
// the branches had been deleted outright, so F-SCC28-3..8 pin that each receiver
// kind still resolves its extension members through the typed signal.

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Packages whose sources are mirrors of one another, relative to the repo root.
const _mirroredPackages = ['tom_d4rt', 'tom_d4rt_ast', 'tom_d4rt_exec'];

/// The two mirrored interpreter visitors, relative to the repo root.
const _mirroredVisitors = [
  'tom_d4rt/lib/src/interpreter_visitor.dart',
  'tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart',
];

/// The d4rt repo root, found by walking up from the current directory.
///
/// Same approach as SCC26: look for a directory holding all the mirrored
/// packages rather than counting `..` segments, because the runner's cwd is a
/// convention rather than a guarantee of the layout.
Directory? _repoRoot() {
  var dir = Directory.current.absolute;
  for (var i = 0; i < 6; i++) {
    final hasAll = _mirroredPackages.every(
      (p) => Directory('${dir.path}/$p').existsSync(),
    );
    if (hasAll) return dir;
    final parent = dir.parent;
    if (parent.path == dir.path) break;
    dir = parent;
  }
  return null;
}

/// Lines of [file] that branch on member-lookup diagnostic text.
///
/// Matches a `.contains(` whose argument mentions the member-lookup wording, in
/// either of the two forms the interpreter composes (`Undefined property 'x'`
/// and `Undefined property or method 'x'`). Comments are excluded: the
/// wording is quoted in prose all over both trees — that is documentation, and
/// documentation is not control flow.
List<String> _messageSniffingLines(File file) {
  final hits = <String>[];
  final lines = file.readAsLinesSync();
  for (var i = 0; i < lines.length; i++) {
    final line = lines[i];
    if (line.trimLeft().startsWith('//')) continue;
    if (!line.contains('.contains(')) continue;
    // The wording may wrap onto the following line, as it does at the
    // `visitSimpleIdentifier` site, so look at the pair.
    final window = i + 1 < lines.length ? '$line\n${lines[i + 1]}' : line;
    if (window.contains('Undefined property')) {
      hits.add('${file.path}:${i + 1}: ${line.trim()}');
    }
  }
  return hits;
}

void main() {
  final repoRoot = _repoRoot();

  group('SCC28: member absence is typed, not spelled', () {
    test('F-SCC28-1: no site in either mirrored visitor branches on '
        'member-lookup diagnostic text [2026-09-05]', () {
      // Needs the sibling checkout. A published copy of this package cannot see
      // `tom_d4rt_ast`, and a red test there would be noise rather than a
      // finding — same reasoning as F-SCC26-3.
      if (repoRoot == null) {
        markTestSkipped('mirrored checkout not present');
        return;
      }
      final hits = <String>[];
      for (final relative in _mirroredVisitors) {
        final file = File('${repoRoot.path}/$relative');
        expect(file.existsSync(), isTrue, reason: '$relative should exist');
        hits.addAll(_messageSniffingLines(file));
      }
      expect(
        hits,
        isEmpty,
        reason:
            'These sites decide whether to attempt extension-method lookup by '
            'reading a human-readable message. Use '
            '`e is UndefinedMemberD4rtException && e.memberName == <name>` '
            'instead — otherwise rewording the diagnostic silently disables '
            'extension methods, and no analyzer will say so:\n'
            '${hits.join('\n')}',
      );
    });

    test('F-SCC28-2: the typed signal is a RuntimeD4rtException, so the '
        'surrounding handlers still catch it [2026-09-05]', () {
      // Subtyping is the whole migration strategy: had this been a sibling of
      // `RuntimeD4rtException` rather than a subtype, every one of the ~40
      // `on RuntimeD4rtException` clauses between a raise site and its sniffer
      // would have had to change in the same commit.
      final e = UndefinedMemberD4rtException(
        "Undefined property 'foo' on Bar.",
        memberName: 'foo',
      );
      expect(e, isA<RuntimeD4rtException>());
      expect(e, isA<D4rtException>());
      expect(e.memberName, 'foo');
      // Diagnostics are unchanged to the byte — SCB10's `toString()` is
      // inherited, so nothing that reads the message for a human moved.
      expect(e.toString(), "Runtime Error: Undefined property 'foo' on Bar.");
    });
  });

  group('SCC28: extension resolution still works through the typed signal', () {
    final d4rt = D4rt();

    dynamic run(String script) => d4rt.execute(source: script);

    test('F-SCC28-3: extension getter on an interpreted instance resolves via '
        'PropertyAccess [2026-09-05]', () {
      // Routes through the `visitPropertyAccess` sniffer.
      expect(
        run('''
        class Box { int v = 7; }
        extension BoxX on Box { int get doubled => v * 2; }
        main() { return Box().doubled; }
      '''),
        14,
      );
    });

    test('F-SCC28-4: extension method on an interpreted instance resolves via '
        'MethodInvocation [2026-09-05]', () {
      expect(
        run('''
        class Box { int v = 7; }
        extension BoxX on Box { int plus(int n) => v + n; }
        main() { return Box().plus(3); }
      '''),
        10,
      );
    });

    test('F-SCC28-5: extension getter on an enum value resolves '
        '[2026-09-05]', () {
      // The enum receiver has its own raise site (`InterpretedEnumValue.get`)
      // and its own pair of sniffers, separate from the instance ones.
      expect(
        run('''
        enum Status { active, done }
        extension StatusX on Status { String get label => 'S:\$name'; }
        main() { return Status.active.label; }
      '''),
        'S:active',
      );
    });

    test('F-SCC28-6: extension method on an enum value resolves '
        '[2026-09-05]', () {
      expect(
        run('''
        enum Status { active, done }
        extension StatusX on Status { String twice() => '\$name\$name'; }
        main() { return Status.done.twice(); }
      '''),
        'donedone',
      );
    });

    test('F-SCC28-7: extension member resolves through implicit `this` '
        '[2026-09-05]', () {
      // `visitSimpleIdentifier` — the one site that sniffed *both* wordings,
      // because an implicit-`this` receiver may be an interpreted instance
      // ("Undefined property") or a bridged one ("Undefined property or
      // method"). Both are the same type now, so one test covers the pair.
      expect(
        run('''
        class Box {
          int v = 4;
          int use() => tripled;
        }
        extension BoxX on Box { int get tripled => v * 3; }
        main() { return Box().use(); }
      '''),
        12,
      );
    });

    test('F-SCC28-8: a genuinely absent member still reports the same '
        'diagnostic [2026-09-05]', () {
      // The false branch. Nothing resolves it, so the failure has to survive
      // the typed signal and reach the host — with its wording intact, since
      // this is what a script author reads.
      expect(
        () => run('''
          class Box { int v = 1; }
          main() { return Box().missing; }
        '''),
        throwsA(
          predicate<Object>(
            (e) => e.toString().contains("Undefined property 'missing'"),
            'reports the absent member by name',
          ),
        ),
      );
    });

    test('F-SCC28-9: an inner failure naming the same member does not steal '
        'the extension branch [2026-09-05]', () {
      // The substring test could not tell "the member you asked for is absent"
      // from "the member ran and something *inside it* was absent" whenever the
      // two shared a name. Here `Outer.tag` exists and its body fails, so the
      // correct behaviour is to propagate that failure — NOT to quietly answer
      // with `OuterX.tag`, which is what a receiver-blind substring match
      // invites. The typed signal does not fix this on its own (both failures
      // name `tag`); what it does is make the receiver available to fix it,
      // which is SCD87. Pinned here so that work has a starting assertion.
      const script = '''
          class Inner {}
          class Outer {
            String get tag => Inner().tag;
          }
          extension OuterX on Outer { String get tag => 'extension'; }
          main() { return Outer().tag; }
        ''';
      // MEASURED, not predicted: the extension wins, so `Inner().tag` — a
      // genuine error in the getter's body — is swallowed and replaced by an
      // unrelated value. Asserting the wrong answer is the only honest way to
      // pin it: a test that demanded the right one would fail, and a test that
      // accepted either would assert nothing. When SCD87 lands, this case
      // flips to expecting the propagated failure, and the flip is the proof
      // the fix worked.
      expect(run(script), 'extension');
    });
  });
}
