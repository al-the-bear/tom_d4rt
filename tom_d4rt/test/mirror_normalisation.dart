/// The vocabulary two interpreter trees have to be compared in, and the one
/// place it is defined.
///
/// `tom_d4rt` and `tom_d4rt_ast` hold the same interpreter written against two
/// different AST libraries. Comparing them raw is meaningless — the twin says
/// `SMethodInvocation` where the reference says `MethodInvocation`, and that
/// difference is the whole point of the twin rather than a defect in it. So
/// every guard over the pair has to normalise first, and the normalisation has
/// to be the SAME one in each guard or their results are not comparable.
///
/// SCD183 measures FILES: after normalising, are the two copies token-identical
/// outside a named allow-list. SCD199 measures MEMBER BODIES, which is what is
/// left once a file is too divergent to compare whole. They disagreed on how
/// large the divergence is until they shared this code — one reported 99 % of
/// `interpreter_visitor.dart`'s tokens differing, the other 43 % of its
/// methods, and both were computing something real. Extracting the map is what
/// makes the two numbers two views of one measurement.
///
/// THE RENAME MAP IS DERIVED, never written down. A hand-kept list of ~195 type
/// names rots, and a rotted entry silently stops normalising one type — which
/// presents as a divergence in a file nobody has changed. Both callers assert a
/// floor on the map's size before believing any result computed through it.
library;

import 'dart:io';

/// The mirror AST package, relative to `tom_d4rt`'s package root. A sibling
/// checkout: all three packages live in the one `tom_d4rt` repository.
const mirrorModelRoot = '../tom_ast_model/lib';

/// Every type `tom_ast_model` declares.
///
/// Returns the empty set when [root] does not exist rather than throwing —
/// callers distinguish "no model" from "model with nothing in it" by the size
/// floor, which produces a message about the checkout instead of a wall of
/// false divergences.
Set<String> mirrorTypeNames({String root = mirrorModelRoot}) {
  final dir = Directory(root);
  if (!dir.existsSync()) return const {};
  final re = RegExp(r'\b(?:class|mixin|enum|typedef)\s+([A-Za-z0-9_]+)');
  final out = <String>{};
  for (final f
      in dir
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))) {
    for (final m in re.allMatches(f.readAsStringSync())) {
      out.add(m.group(1)!);
    }
  }
  return out;
}

/// The reference tree's spelling of a mirror type, or [token] unchanged.
///
/// Only names [mirrorTypes] actually declares are rewritten, so a variable
/// called `Sink` or a local `SomeThing` is left alone.
String denormaliseMirrorType(String token, Set<String> mirrorTypes) {
  if (!mirrorTypes.contains(token)) return token;
  if (token.startsWith('S') &&
      token.length > 1 &&
      token[1].toUpperCase() == token[1]) {
    return token.substring(1);
  }
  // `GeneralizingSAstVisitor`, `RecursiveSAstVisitor` and friends carry the S
  // in the middle rather than at the front.
  if (token.contains('SAst')) return token.replaceFirst('SAst', 'Ast');
  return token;
}

/// `[SMethodInvocation] …` inside a log string, rewritten to `[MethodInvocation]`.
///
/// The twin's log lines name the node type they are logging about, so they
/// carry the rename into string literals where the token-level map cannot
/// reach. A log prefix that names the twin's own node type is CORRECT, and
/// leaving it un-normalised reports seven method bodies as divergent for saying
/// the right thing.
///
/// Deliberately narrow: only a whole bracketed token whose `S`-prefixed form is
/// a declared mirror type is rewritten, so `[Setup]` and `'[Stack] …'` survive.
String denormaliseLogPrefix(String lexeme, Set<String> mirrorTypes) =>
    lexeme.replaceAllMapped(
      RegExp(r'\[S([A-Za-z0-9_]+)\]'),
      (m) => mirrorTypes.contains('S${m.group(1)!}')
          ? '[${m.group(1)!}]'
          : m.group(0)!,
    );

/// The two sides of where [a] and [b] stop agreeing, with the common prefix and
/// suffix trimmed off. `null` when they agree everywhere.
///
/// Trimming is what makes a divergence quotable, and it is also why a
/// whole-FILE application of this function overstates the disagreement: one
/// early difference leaves everything after it inside the residue. That is not
/// a flaw to fix here — it is the reason SCD199 applies the same function per
/// member body instead.
(String, String)? tokenDivergence(List<String> a, List<String> b) {
  var head = 0;
  while (head < a.length && head < b.length && a[head] == b[head]) {
    head++;
  }
  if (head == a.length && head == b.length) return null;
  var tail = 0;
  while (tail < a.length - head &&
      tail < b.length - head &&
      a[a.length - 1 - tail] == b[b.length - 1 - tail]) {
    tail++;
  }
  return (
    a.sublist(head, a.length - tail).join(' '),
    b.sublist(head, b.length - tail).join(' '),
  );
}

/// Every `.dart` file under [root], relative to it and sorted, skipping any
/// whose relative path starts with [excludedPrefix].
///
/// The empty list when [root] is absent — same contract as [mirrorTypeNames],
/// and the same requirement on callers to hold a size floor over the result.
List<String> dartFilesUnder(String root, {String excludedPrefix = ''}) {
  final dir = Directory(root);
  if (!dir.existsSync()) return const [];
  return dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .map((f) => f.path.substring(root.length + 1))
      .where((rel) => excludedPrefix.isEmpty || !rel.startsWith(excludedPrefix))
      .toList()
    ..sort();
}

/// A quotable slice of a token run, for a failure message.
///
/// The token count is appended when the run is elided, because the length of a
/// divergence is the first thing a reader wants and the excerpt alone cannot
/// say it.
String tokenExcerpt(String region) => region.length <= 240
    ? region
    : '${region.substring(0, 240)} … '
          '(${region.split(' ').length} tokens)';
