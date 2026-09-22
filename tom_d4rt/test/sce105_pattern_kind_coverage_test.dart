// SCE105 — every pattern kind the language has reaches a branch, and the set is
// derived rather than remembered.
//
// SCD64 found that `(p)`, `p?` and `p!` had no branch in `_matchAndBind` at all.
// They had been unavailable for the entire life of the pattern support, through
// a corpus of thousands of green tests, because a construct nobody writes
// produces no failure. Its own notes said the rest plainly: the gap "was found
// by a probe aimed at something else, which means the set of unsupported
// pattern kinds is not known".
//
// An audit answered that for one afternoon. It was a throwaway script, so by
// the next morning the set was unknown again — and the next language version
// adds a kind and the same silence resumes.
//
// WHY F-SCD64-7 IS NOT THIS. That case runs twelve kinds through a matching and
// a non-matching scrutinee, which is a control for SCD64's change. Its list is
// HAND-WRITTEN, so a new pattern kind is absent from it by construction — which
// is exactly the case that needs catching. A list of what we remembered cannot
// report what we forgot.
//
// DERIVED FROM THE ANALYZER, which publishes the answer twice over and needs
// both halves. `DartPattern` is a sealed hierarchy in
// `lib/src/dart/ast/ast.dart`, so its concrete descendants are the kinds — but
// that file also declares the `*Impl` classes, and taking the hierarchy alone
// makes every public interface look like an abstract intermediate with one
// implementation. The second half is `lib/dart/ast/ast.dart`, the barrel whose
// `export ... show` list IS the public AST surface; intersecting with it keeps
// the interfaces and drops the implementations.
//
// Reading both rather than a list here means a new kind arrives with the
// analyzer upgrade rather than when somebody notices.
//
// PARSED, NOT GREPPED, and the reason is specific rather than stylistic: this
// file's own source contains every class name it searches for, so a grep over
// the tree finds its own text and reports perfect coverage. Both sides go
// through the analyzer — the hierarchy from a parse of the analyzer's ast.dart,
// the branches from a parse of `interpreter_visitor.dart`.
//
// A RATCHET, NOT A REQUIREMENT. Some kind will legitimately be unimplemented at
// some point, and a guard that cannot say so gets deleted the first time it is
// inconvenient. [_unhandledBaseline] records the gap — empty today — and
// F-SCE105-2 fails in BOTH directions: a new gap appears, or a recorded one is
// closed without the baseline being updated. The second half is what stops the
// baseline from outliving its cause, which is how every other register in this
// repo has rotted.
//
// ABLATED, three ways:
//
//   rename the `ParenthesizedPattern` branch  -> -2 names it as a new gap AND
//                                                -3 names the new spelling as
//                                                a kind the language lacks
//   add a fictional entry to the baseline     -> -2 fails from the other side
//   (the -1 rails are argued, not ablated: an empty parse cannot be staged
//    without deleting the thing being measured)
//
// The first is worth reading twice. A RENAME lights up both directions at
// once, which is a clearer signal than either alone — "X disappeared and Y
// appeared" rather than "X disappeared", which is what a one-sided guard would
// have said and would have sent the reader looking for a deletion.

import 'dart:convert';
import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:test/test.dart';

/// Pattern kinds with no branch in `_matchAndBind`, and why.
///
/// EMPTY, and that is a measurement rather than an aspiration: SCD64 closed the
/// last three. An entry here is a deliberate, named gap — not a list of things
/// to get round to — and F-SCE105-2 rejects both a gap that is not recorded and
/// a recording whose gap is gone.
const Map<String, String> _unhandledBaseline = <String, String>{};

/// The directory this package's own config resolves `analyzer` to.
///
/// The package CONFIG rather than a guessed pub-cache path: the config is what
/// the analyzer this test IMPORTS was loaded from, so the hierarchy read here
/// is the one the interpreter actually receives nodes from.
Directory? _analyzerRoot() {
  final config = File('.dart_tool/package_config.json');
  if (!config.existsSync()) return null;
  final decoded = jsonDecode(config.readAsStringSync()) as Map<String, dynamic>;
  for (final entry in decoded['packages'] as List<dynamic>) {
    final package = entry as Map<String, dynamic>;
    if (package['name'] != 'analyzer') continue;
    final uri = Uri.parse(package['rootUri'] as String);
    final path = uri.hasScheme
        ? uri.toFilePath()
        : File('.dart_tool/${package['rootUri']}').absolute.path;
    return Directory(Directory(path).absolute.path);
  }
  return null;
}

/// The names `lib/dart/ast/ast.dart` exports — the public AST surface.
///
/// The discriminator between an interface and its implementation: both are
/// declared in the same source file, and only the interface is exported.
Set<String> _exportedNames(String source) {
  final unit = parseString(content: source, throwIfDiagnostics: false).unit;
  return <String>{
    for (final directive in unit.directives)
      if (directive is ExportDirective)
        for (final combinator in directive.combinators)
          if (combinator is ShowCombinator)
            for (final name in combinator.shownNames) name.name,
  };
}

/// Every class declared in [source], mapped to the names it extends,
/// implements or mixes in.
Map<String, Set<String>> _classSupertypes(String source) {
  final unit = parseString(content: source, throwIfDiagnostics: false).unit;
  final result = <String, Set<String>>{};
  for (final declaration in unit.declarations) {
    if (declaration is! ClassDeclaration) continue;
    final supers = <String>{
      if (declaration.extendsClause case final c?) c.superclass.name.lexeme,
      for (final i in declaration.implementsClause?.interfaces ?? const [])
        i.name.lexeme,
      for (final m in declaration.withClause?.mixinTypes ?? const [])
        m.name.lexeme,
    };
    result[declaration.name.lexeme] = supers;
  }
  return result;
}

/// The CONCRETE kinds under [root] in [supertypes].
///
/// A descendant that is itself the supertype of another descendant is an
/// abstract intermediate — `VariablePattern` is the one that exists today — and
/// is not a kind a script can write, so the interpreter is not asked to have a
/// branch for it.
Set<String> _concreteKinds(Map<String, Set<String>> supertypes, String root) {
  final descendants = <String>{};
  var changed = true;
  while (changed) {
    changed = false;
    supertypes.forEach((name, supers) {
      if (descendants.contains(name)) return;
      if (supers.any((s) => s == root || descendants.contains(s))) {
        descendants.add(name);
        changed = true;
      }
    });
  }
  final intermediates = <String>{
    for (final name in descendants)
      ...supertypes[name]!.where(descendants.contains),
  };
  return descendants.difference(intermediates);
}

/// Collects `pattern is X` type tests.
class _PatternIsCollector extends RecursiveAstVisitor<void> {
  final Set<String> names = {};

  @override
  void visitIsExpression(IsExpression node) {
    final target = node.expression;
    final type = node.type;
    if (target is SimpleIdentifier &&
        target.name == 'pattern' &&
        type is NamedType) {
      names.add(type.name.lexeme);
    }
    super.visitIsExpression(node);
  }
}

/// The kinds `_matchAndBind` dispatches on, read from the visitor's source.
Set<String> _handledKinds() {
  final source = File('lib/src/interpreter_visitor.dart').readAsStringSync();
  final unit = parseString(content: source, throwIfDiagnostics: false).unit;
  for (final declaration in unit.declarations) {
    if (declaration is! ClassDeclaration) continue;
    for (final member in declaration.members) {
      if (member is! MethodDeclaration) continue;
      if (member.name.lexeme != '_matchAndBind') continue;
      final collector = _PatternIsCollector();
      member.accept(collector);
      return collector.names;
    }
  }
  return {};
}

void main() {
  final analyzerRoot = _analyzerRoot();
  final astFile = analyzerRoot == null
      ? null
      : File('${analyzerRoot.path}/lib/src/dart/ast/ast.dart');
  final barrelFile = analyzerRoot == null
      ? null
      : File('${analyzerRoot.path}/lib/dart/ast/ast.dart');

  group('SCE105: every pattern kind reaches a branch', () {
    late Set<String> kinds;
    late Set<String> handled;

    setUp(() {
      if (astFile == null ||
          !astFile.existsSync() ||
          barrelFile == null ||
          !barrelFile.existsSync()) {
        kinds = <String>{};
      } else {
        final exported = _exportedNames(barrelFile.readAsStringSync());
        final supertypes = <String, Set<String>>{
          for (final entry in _classSupertypes(
            astFile.readAsStringSync(),
          ).entries)
            if (exported.contains(entry.key)) entry.key: entry.value,
        };
        kinds = _concreteKinds(supertypes, 'DartPattern');
      }
      handled = _handledKinds();
    });

    test('F-SCE105-1 (anti-vacuity): both parses found something '
        '[2026-09-22] (PASS)', () {
      // Asserted BEFORE anything is concluded from either set. A parse that
      // returns empty satisfies every comparison below while checking nothing,
      // and there are two of them — the analyzer moving its declarations, or
      // `_matchAndBind` being renamed, each turns this file into a guard that
      // passes over nothing.
      expect(
        barrelFile?.existsSync(),
        isTrue,
        reason:
            'The analyzer package config did not lead to '
            'lib/dart/ast/ast.dart, whose export list is what tells an '
            'interface from its implementation.',
      );
      expect(
        astFile?.existsSync(),
        isTrue,
        reason:
            'The analyzer package config did not lead to '
            'lib/src/dart/ast/ast.dart. This guard derives the pattern kinds '
            'from that file; find where the hierarchy moved to rather than '
            'replacing it with a list here, which is the thing it exists to '
            'avoid.',
      );
      expect(
        kinds.length,
        greaterThanOrEqualTo(12),
        reason:
            'Only ${kinds.length} pattern kinds were derived from the '
            "analyzer's DartPattern hierarchy: $kinds. Fifteen when this was "
            'written; far fewer means the parse stopped finding them.',
      );
      expect(
        handled.length,
        greaterThanOrEqualTo(12),
        reason:
            'Only ${handled.length} `pattern is X` tests were found in '
            '_matchAndBind: $handled. The dispatch has not shrunk that far — '
            'the method was probably renamed or split.',
      );
    });

    test('F-SCE105-2: the unhandled set is exactly the baseline '
        '[2026-09-22] (PASS)', () {
      final unhandled = kinds.difference(handled);
      final appeared = unhandled.difference(_unhandledBaseline.keys.toSet());
      final closed = _unhandledBaseline.keys.toSet().difference(unhandled);

      expect(
        appeared,
        isEmpty,
        reason:
            'These pattern kinds have no branch in _matchAndBind, so a script '
            'using one dies on it:\n  ${appeared.join('\n  ')}\n\n'
            'Implement the branch, or add the kind to _unhandledBaseline with '
            'the reason it cannot be implemented yet. A recorded gap is a '
            'decision; an unrecorded one is the silence SCD64 spent a todo on.',
      );
      expect(
        closed,
        isEmpty,
        reason:
            'These kinds are recorded as unhandled but now have a branch:\n'
            '  ${closed.join('\n  ')}\n\n'
            'Remove them from _unhandledBaseline. A baseline that outlives its '
            'cause reads as unfinished work that is already done, and is how '
            'every other register here has rotted.',
      );
    });

    test('F-SCE105-3: no branch dispatches on a kind the language lacks '
        '[2026-09-22] (PASS)', () {
      // The other direction, and not symmetry for its own sake: a branch for a
      // type the analyzer no longer produces is dead code that reads as
      // coverage. It is also how this guard would first notice a RENAME — the
      // kind would appear in `appeared` above and here at once, which is a
      // clearer signal than either alone.
      final unknown = handled.difference(kinds);
      expect(
        unknown,
        isEmpty,
        reason:
            '_matchAndBind dispatches on these, which are not concrete '
            "DartPattern kinds in the analyzer it resolves:\n"
            '  ${unknown.join('\n  ')}\n\n'
            'Either the analyzer renamed or removed the kind — in which case '
            'the branch is dead — or it became an abstract intermediate, in '
            'which case the branch is unreachable for a different reason.',
      );
    });
  });
}
