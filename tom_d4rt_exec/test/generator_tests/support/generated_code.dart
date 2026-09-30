/// Reading generated code for assertions, independent of its layout (SCG5).
///
/// The generator runs `DartFormatter` over everything it writes, so a
/// call that fits on one line in the emitter can arrive split across several,
/// with a trailing comma the formatter adds. Assertions in this suite are
/// about CONTENT — which call is emitted, with which arguments — and pinning
/// them to one formatter version's line breaks would make every formatter
/// upgrade a suite-wide rewrite. So tests read generated files through
/// [readGeneratedCode], which flattens layout the formatter owns:
///
///   * every run of whitespace, newlines included, becomes one space;
///   * no space just inside `(`, `[`, or before `)`, `]`, and no trailing comma
///     before them; the same for a type-argument list's `<` and `>`;
///   * no space before a `.` or `?.` the formatter broke a member chain at;
///   * braces are left alone: the emitter already writes `{ x; }` and a
///     trailing comma before `}`.
///
/// An expectation is written in the flattened form, which is what a one-line
/// emitter template reads like anyway.
library;

import 'dart:io';

/// [code] with the formatter's layout flattened; see the library comment.
String normalizeGeneratedCode(String code) {
  var s = code.replaceAll(RegExp(r'\s+'), ' ');
  // Argument and element lists the formatter split one per line.
  s = s.replaceAllMapped(RegExp(r'([\(\[]) '), (m) => m[1]!);
  s = s.replaceAllMapped(RegExp(r',? ?([\)\]])'), (m) => m[1]!);
  // A type-argument list split the same way: `Foo< A, B, >`.
  s = s.replaceAllMapped(RegExp(r'(\w)< '), (m) => '${m[1]}<');
  s = s.replaceAll(RegExp(r', ?>'), '>');
  // ...and its closing `>` put on its own line: `Foo<Bar<Baz > >`. Only a `>`
  // followed by another closer, a comma or a paren is a type argument's; a
  // comparison `a > b` is followed by an operand and keeps its spaces.
  s = s.replaceAll(RegExp(r' >(?= ?[>,\)\(\];{?])'), '>');
  // A member chain split before its `.`: `Foo .bar`.
  s = s.replaceAllMapped(RegExp(r' (\??\.)([\w$])'), (m) => '${m[1]}${m[2]}');
  // Braces are left as they are: the emitter already writes `{ x; }` and a
  // trailing comma before `}`, which is what a block or map literal the
  // formatter split flattens back to.
  return s;
}

/// The generated file at [path], flattened by [normalizeGeneratedCode].
Future<String> readGeneratedCode(String path) async =>
    normalizeGeneratedCode(await File(path).readAsString());

/// Synchronous [readGeneratedCode].
String readGeneratedCodeSync(String path) =>
    normalizeGeneratedCode(File(path).readAsStringSync());
