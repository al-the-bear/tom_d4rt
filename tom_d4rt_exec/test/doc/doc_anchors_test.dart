import 'dart:io';

import 'package:test/test.dart';

/// SCC88 — every intra-document link in `doc/` resolves to a heading.
///
/// WHAT WAS BROKEN. `d4rt_limitations.md` opens with a bug index: one table row
/// per finding, each linking to its detail section. 35 of those anchors
/// resolved to nothing, and two other docs carried five more. The rows
/// themselves were intact and carried a status, so the table still read as
/// authoritative — only the navigation was dead.
///
/// WHY A TEST AND NOT A PROOFREAD. A dead anchor does nothing visible in a
/// browser: the page simply does not move. The reader concludes the section is
/// missing rather than that the link is wrong, so the genuinely-present
/// sections are collateral damage. And nobody scrolls a 3000-line document to
/// check — the breakage arrived with the initial group-repo import and survived
/// every edit since, which is the argument that a human check does not happen.
///
/// PER-PACKAGE BY DESIGN. Each copy walks its OWN  — the paths are
/// relative to the package root, so this is one of the cases SCD158 describes
/// where a ported structural test changes subject, and here that is the point:
/// exec carried two of the dead anchors in its own copy of BRIDGING_GUIDE.md.
///
/// SLUGIFICATION follows GitHub's rule, which is what these files are read
/// with: lowercase, drop everything that is not a word character, whitespace or
/// hyphen, then spaces to hyphens. Backticks are stripped BEFORE punctuation so
/// `` `Foo` `` and `Foo` produce the same slug.
///
/// REPEATED HEADINGS ARE NORMAL HERE and the suffix rule is not optional. Each
/// bug section in `d4rt_limitations.md` carries the same sub-headings, so
/// "Problem Description" appears 75 times and "Where is the problem?" 60. On
/// GitHub the second occurrence is `#problem-description-1`, the third `-2`,
/// and so on. [anchorsDefinedBy] builds that full set; comparing against bare
/// slugs alone would report every link to a repeated section as broken.
String slugify(String heading) {
  final withoutCode = heading.replaceAll('`', '');
  final stripped = withoutCode.toLowerCase().replaceAll(
    RegExp(r'[^\w\s-]'),
    '',
  );
  return stripped.trim().replaceAll(RegExp(r'\s+'), '-');
}

/// Headings, skipping fenced code blocks — a `# comment` inside a shell block
/// is not a heading, and counting it would invent anchors that do not exist.
List<String> headingsOf(String markdown) {
  final out = <String>[];
  var inFence = false;
  for (final line in markdown.split('\n')) {
    if (RegExp(r'^\s*(```|~~~)').hasMatch(line)) {
      inFence = !inFence;
      continue;
    }
    if (inFence) continue;
    final m = RegExp(r'^(#{1,6})\s+(.*)$').firstMatch(line);
    if (m != null) out.add(m.group(2)!.trim());
  }
  return out;
}

/// Every anchor a document DEFINES, including GitHub's `-1`/`-2` suffixes for
/// headings that slugify alike. Order matters: the suffix counts occurrences in
/// document order, so this walks the headings as they appear.
Set<String> anchorsDefinedBy(String markdown) {
  final seen = <String, int>{};
  final defined = <String>{};
  for (final heading in headingsOf(markdown)) {
    final base = slugify(heading);
    final n = seen[base] ?? 0;
    defined.add(n == 0 ? base : '$base-$n');
    seen[base] = n + 1;
  }
  return defined;
}

/// `](#anchor)` targets, which are the only links this file judges. An external
/// URL is somebody else's uptime problem; an intra-doc anchor is ours.
List<String> anchorsOf(String markdown) => RegExp(
  r'\]\(#([^)]+)\)',
).allMatches(markdown).map((m) => m.group(1)!).toList();

void main() {
  final docDir = Directory('doc');

  List<File> docs() {
    expect(
      docDir.existsSync(),
      isTrue,
      reason:
          'doc/ is missing, so this guard would pass by checking nothing. Run '
          'from the package root.',
    );
    return docDir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.md'))
        .toList()
      ..sort((a, b) => a.path.compareTo(b.path));
  }

  group('SCC88: intra-document anchors resolve', () {
    test('F-SCC88-1: the guard is looking at a real corpus [2026-09-07]', () {
      // Guards against the version of this file that passes by checking
      // nothing — an empty doc/, a changed heading syntax, or being run from
      // the wrong directory.
      //
      // It asserts HEADINGS, not anchors. Anchor counts differ legitimately per
      // package (measured 2026-09-07: tom_d4rt 177, tom_d4rt_exec 64,
      // tom_d4rt_ast 0), and a package whose docs simply carry no intra-doc
      // links is a valid state, not a broken guard. Headings are the thing the
      // parser must find for F-SCC88-2 to mean anything, and every package's
      // doc/ has plenty.
      final files = docs();
      expect(files, isNotEmpty);
      final totalHeadings = files.fold<int>(
        0,
        (n, f) => n + headingsOf(f.readAsStringSync()).length,
      );
      expect(
        totalHeadings,
        greaterThan(50),
        reason:
            'The smallest doc/ in the three d4rt packages had 168 headings on '
            '2026-09-07. Finding almost none means the heading parser stopped '
            'matching — probably a fence or syntax change — and F-SCC88-2 is '
            'now comparing links against an empty anchor set, which it would '
            'report as every link broken rather than silently pass. Fix the '
            'parser before trusting either result.',
      );
    });

    test('F-SCC88-1b: link extraction still works where links exist '
        '[2026-09-07]', () {
      // The other half, and the reason it is a separate case: it can only be
      // asserted for a corpus that HAS links. Skipped rather than weakened for
      // one that does not.
      final withLinks = docs()
          .where((f) => anchorsOf(f.readAsStringSync()).isNotEmpty)
          .length;
      expect(
        withLinks,
        greaterThan(0),
        skip: anchorsOf(docs().map((f) => f.readAsStringSync()).join()).isEmpty
            ? 'This package has no intra-doc anchors, so there is nothing to '
                  'extract. Valid — tom_d4rt_ast is in that state.'
            : null,
      );
    });

    test('F-SCC88-2: every `](#anchor)` names a heading in its own file '
        '[2026-09-07]', () {
      final broken = <String>[];
      for (final file in docs()) {
        final text = file.readAsStringSync();
        final defined = anchorsDefinedBy(text);
        for (final anchor in anchorsOf(text).toSet()) {
          if (!defined.contains(anchor)) {
            broken.add('${file.path}  ->  #$anchor');
          }
        }
      }
      expect(
        broken,
        isEmpty,
        reason:
            'These links point at headings that do not exist. A dead anchor is '
            'silent in a browser — the page does not move — so a reader '
            'concludes the section is missing rather than that the link is '
            'wrong. Either correct the anchor, or, if the section genuinely '
            'does not exist, UNLINK the text and say so where the reader will '
            'look (see the note above the Issue Tracker table in '
            'd4rt_limitations.md).\n${broken.join('\n')}',
      );
    });

    test('F-SCC88-3: the suffix rule matches GitHub, because this corpus '
        'depends on it [2026-09-07]', () {
      // Replaces an earlier assertion that no two headings share a slug. That
      // was the wrong requirement: repeated sub-headings are how this corpus is
      // structured — "Problem Description" appears 75 times in
      // d4rt_limitations.md, once per bug — and renaming them to satisfy a test
      // would damage the document to protect the model. The model was the thing
      // that was incomplete, so it is the thing that changed.
      const markdown = '''
# Alpha

## Problem Description

## Problem Description

## Problem Description

## Other
''';
      expect(
        anchorsDefinedBy(markdown),
        equals({
          'alpha',
          'problem-description',
          'problem-description-1',
          'problem-description-2',
          'other',
        }),
      );
    });

    test('F-SCC88-4: a link to a repeated section resolves, and one past the '
        'end does not [2026-09-07]', () {
      // The property F-SCC88-2 leans on, and the failure mode it would show if
      // the suffix rule were dropped again: `-1` must resolve, `-9` must not.
      const markdown = '''
# Doc

[first](#problem-description) [second](#problem-description-1)

## Problem Description

## Problem Description
''';
      final defined = anchorsDefinedBy(markdown);
      expect(defined, contains('problem-description'));
      expect(defined, contains('problem-description-1'));
      expect(defined, isNot(contains('problem-description-9')));
      for (final anchor in anchorsOf(markdown)) {
        expect(defined, contains(anchor));
      }
    });
  });
}
