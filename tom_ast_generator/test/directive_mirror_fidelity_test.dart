// SCE49: the mirror AST's directive nodes are held 1:1 against the analyzer's.
//
// The quest's core principle is that `tom_ast_model` is a 1:1 mirror of the
// analyzer AST, and that when something does not work the fix goes in the AST
// model rather than the interpreter. `configurations` is what the absence of a
// check for that principle costs: the analyzer had the field, the mirror did
// not, and a conditional import lost its branches in the copy — silently, for
// as long as nobody happened to look.
//
// This test is the ratchet that makes the NEXT missing field fail instead of
// disappear. For each analyzer directive node it enumerates — by reflection,
// not by hand — every getter the class and its directive-layer superinterfaces
// declare, and requires each one to be classified exactly once: either as
// MIRRORED, naming the field on the mirror node that carries it (which must
// exist), or as deliberately NOT mirrored, with the reason.
//
// A getter the analyzer adds later is in neither set, and the test fails naming
// it. A mirrored field deleted from the model fails too.
//
// The walk stops at `AstNode`: `parent`, `root`, `beginToken`, `childEntities`
// and friends are the analyzer's tree plumbing, shared by every node, and the
// mirror deliberately reduces all of it to `offset`/`length`. Classifying that
// surface per node would say the same thing sixty times.

import 'dart:mirrors';

import 'package:analyzer/dart/ast/ast.dart' as analyzer;
import 'package:test/test.dart';
import 'package:tom_ast_generator/tom_ast_generator.dart';

/// How one analyzer getter is accounted for on the mirror side.
sealed class Fate {
  const Fate();
}

/// Carried by the named field on the mirror node.
class Mirrored extends Fate {
  const Mirrored(this.field);
  final String field;
}

/// Deliberately absent from the mirror, for [reason].
class Absent extends Fate {
  const Absent(this.reason);
  final String reason;
}

const _tokenOnly = Absent(
  'a token: its text is fixed and its position is covered by offset/length',
);
const _resolutionOnly = Absent(
  'resolution output — the mirror is a parse-only model with no element layer',
);
const _analyzerPlumbing = Absent(
  "analyzer-side comment plumbing; the mirror keeps a unit's comments on "
  'SCompilationUnit and does not attach them per node',
);

/// One analyzer node class, and the mirror class it is held against.
class Pairing {
  const Pairing(this.analyzerClass, this.mirrorClass, this.fates);
  final Type analyzerClass;
  final Type mirrorClass;
  final Map<String, Fate> fates;
}

const _pairings = <Pairing>[
  Pairing(analyzer.ImportDirective, SImportDirective, {
    'uri': Mirrored('uri'),
    'prefix': Mirrored('prefix'),
    'configurations': Mirrored('configurations'),
    'combinators': Mirrored('combinators'),
    'metadata': Mirrored('metadata'),
    'deferredKeyword': Mirrored('isDeferred'),
    'importKeyword': _tokenOnly,
    'asKeyword': _tokenOnly,
    'semicolon': _tokenOnly,
    'libraryImport': _resolutionOnly,
    'documentationComment': _analyzerPlumbing,
    'sortedCommentAndAnnotations': _analyzerPlumbing,
    'firstTokenAfterCommentAndMetadata': _analyzerPlumbing,
  }),
  Pairing(analyzer.ExportDirective, SExportDirective, {
    'uri': Mirrored('uri'),
    'configurations': Mirrored('configurations'),
    'combinators': Mirrored('combinators'),
    'metadata': Mirrored('metadata'),
    'exportKeyword': _tokenOnly,
    'semicolon': _tokenOnly,
    'libraryExport': _resolutionOnly,
    'documentationComment': _analyzerPlumbing,
    'sortedCommentAndAnnotations': _analyzerPlumbing,
    'firstTokenAfterCommentAndMetadata': _analyzerPlumbing,
  }),
  Pairing(analyzer.Configuration, SConfiguration, {
    'name': Mirrored('name'),
    'value': Mirrored('value'),
    'uri': Mirrored('uri'),
    'ifKeyword': _tokenOnly,
    'leftParenthesis': _tokenOnly,
    'equalToken': _tokenOnly,
    'rightParenthesis': _tokenOnly,
    'resolvedUri': _resolutionOnly,
  }),
  Pairing(analyzer.DottedName, SDottedName, {
    'components': Mirrored('components'),
  }),
];

/// Every public instance getter [type] and its superinterfaces declare, down to
/// but not including `AstNode`.
Set<String> analyzerGetters(Type type) {
  final found = <String>{};

  void walk(ClassMirror c) {
    final name = MirrorSystem.getName(c.simpleName);
    // `Object` is reached through every interface's implicit superclass, and
    // `hashCode`/`runtimeType` are not fields anyone could mirror.
    if (name == 'AstNode' || name == 'Object') return;
    for (final declaration in c.declarations.values) {
      if (declaration is MethodMirror &&
          declaration.isGetter &&
          !declaration.isStatic &&
          !declaration.isPrivate) {
        found.add(MirrorSystem.getName(declaration.simpleName));
      }
    }
    for (final superinterface in c.superinterfaces) {
      walk(superinterface);
    }
    final superclass = c.superclass;
    if (superclass != null) walk(superclass);
  }

  walk(reflectClass(type));
  return found;
}

/// Every public instance field or getter [type] and its superclasses expose.
Set<String> mirrorMembers(Type type) {
  final found = <String>{};

  void walk(ClassMirror? c) {
    if (c == null || c.simpleName == const Symbol('Object')) return;
    for (final declaration in c.declarations.values) {
      if (declaration.isPrivate) continue;
      if (declaration is VariableMirror && !declaration.isStatic) {
        found.add(MirrorSystem.getName(declaration.simpleName));
      } else if (declaration is MethodMirror &&
          declaration.isGetter &&
          !declaration.isStatic) {
        found.add(MirrorSystem.getName(declaration.simpleName));
      }
    }
    walk(c.superclass);
  }

  walk(reflectClass(type));
  return found;
}

void main() {
  for (final pairing in _pairings) {
    final analyzerName = MirrorSystem.getName(
      reflectClass(pairing.analyzerClass).simpleName,
    );
    final mirrorName = MirrorSystem.getName(
      reflectClass(pairing.mirrorClass).simpleName,
    );

    group('SCE49: $analyzerName ↔ $mirrorName', () {
      test('F-SCE49-FID-$analyzerName-1: every analyzer getter is classified '
          '[2026-09-18] (PASS)', () {
        final unclassified = analyzerGetters(
          pairing.analyzerClass,
        ).difference(pairing.fates.keys.toSet());

        expect(
          unclassified,
          isEmpty,
          reason:
              'analyzer.$analyzerName declares ${unclassified.join(', ')}, '
              'which this test has never heard of. Either mirror the field '
              'on $mirrorName and record it as Mirrored, or record why it is '
              'Absent — but do not let it disappear, which is what SCE49 was.',
        );
      });

      test(
        'F-SCE49-FID-$analyzerName-2: nothing is classified that the analyzer '
        'no longer declares [2026-09-18] (PASS)',
        () {
          final stale = pairing.fates.keys.toSet().difference(
            analyzerGetters(pairing.analyzerClass),
          );

          expect(
            stale,
            isEmpty,
            reason:
                'this test classifies ${stale.join(', ')}, which '
                'analyzer.$analyzerName no longer declares — so the '
                'classification is describing an analyzer that is gone.',
          );
        },
      );

      test(
        'F-SCE49-FID-$analyzerName-3: every field claimed as mirrored exists '
        'on the mirror node [2026-09-18] (PASS)',
        () {
          final members = mirrorMembers(pairing.mirrorClass);
          final claimed = {
            for (final entry in pairing.fates.entries)
              if (entry.value case Mirrored(:final field)) entry.key: field,
          };
          final missing = {
            for (final entry in claimed.entries)
              if (!members.contains(entry.value)) entry.key: entry.value,
          };

          expect(
            missing,
            isEmpty,
            reason:
                '$mirrorName is missing ${missing.values.join(', ')}, claimed '
                'here as mirroring ${missing.keys.join(', ')}.',
          );
        },
      );
    });
  }
}
