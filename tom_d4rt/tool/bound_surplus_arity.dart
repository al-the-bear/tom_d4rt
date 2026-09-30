/// Bounds the stdlib adapters that drop a surplus positional argument (SCF36).
///
///     dart run tool/bound_surplus_arity.dart            # report, edit nothing
///     dart run tool/bound_surplus_arity.dart --write    # insert the guards
///
/// For every adapter `tool/stdlib_surplus_census.dart` reports UNGUARDED, this
/// inserts `D4.checkArity(positionalArgs, '<Class>.<member>', atMost: N);` as
/// the adapter's first statement — the SCC85 / SCD204 shape. Only in
/// `tom_d4rt`; `tool/mirror_stdlib.dart --write` carries the edit to the twin.
///
/// N IS THE SDK'S POSITIONAL COUNT, NEVER `maxIndex + 1`. An adapter that reads
/// only `[0]` of a member with an optional second positional parameter would,
/// bounded at 1, reject a legal call. So N is read from the running SDK
/// through `dart:mirrors` — required plus optional positional parameters of
/// the constructor, static member or instance member (inherited ones
/// included) the adapter is registered as. Mirrors answer from the SDK itself,
/// the same reason SCD189 asks them rather than a hand-typed table.
///
/// It edits only what it can decide, and REPORTS the rest:
///
///   * NO SDK MEMBER — the bridge's class or member has no SDK counterpart
///     (an interpreter-only helper). Nothing to read N from; left alone.
///   * SDK ALLOWS FEWER — the adapter reads beyond the SDK's positional count.
///     A bound would reject what the adapter handles; left alone.
///   * FORWARDS FEWER — N exceeds what the adapter reads, so a LEGAL argument is
///     ignored. Bounded at N (surplus beyond the SDK's count is still an
///     error), and listed: the ignored argument is a second, separate gap.
library;

// The eight libraries the stdlib bridges, imported so `dart:mirrors` has them
// loaded when it is asked about their classes.
// ignore_for_file: unused_import
import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'dart:math';
import 'dart:mirrors';
import 'dart:typed_data';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';

import 'stdlib_surplus_census.dart';

const _sdkLibraries = [
  'dart:core',
  'dart:async',
  'dart:collection',
  'dart:convert',
  'dart:io',
  'dart:isolate',
  'dart:math',
  'dart:typed_data',
];

/// The SDK class a bridge named [name] stands for, or null.
ClassMirror? _sdkClass(String name) {
  for (final uri in _sdkLibraries) {
    final library = currentMirrorSystem().libraries[Uri.parse(uri)];
    final declaration = library?.declarations[Symbol(name)];
    if (declaration is ClassMirror) return declaration;
  }
  // Several dart:io classes are declared in an internal library and only
  // re-exported (`HttpHeaders`, `WebSocket` live in `dart:_http`), so fall
  // back to every library the isolate has loaded.
  for (final library in currentMirrorSystem().libraries.values) {
    final declaration = library.declarations[Symbol(name)];
    if (declaration is ClassMirror && !declaration.isPrivate) {
      return declaration;
    }
  }
  return null;
}

/// Members the bridges expose that are EXTENSION methods in the SDK, which
/// `dart:mirrors` does not see: `Class.member` to the SDK's positional count.
const _extensionArity = <String, int>{
  // `EnumByName.byName` on `Iterable<T extends Enum>`, bridged on `List` for
  // `values.byName(...)`.
  'List.byName': 1,
};

int _positional(MethodMirror m) => m.parameters.where((p) => !p.isNamed).length;

/// The SDK's positional count for [member] of [cls], registered in the bridge
/// map named [mapName], or null when the SDK has no such member.
int? sdkPositionalCount(ClassMirror cls, String mapName, String member) {
  MethodMirror? constructor() {
    for (final d in cls.declarations.values) {
      if (d is MethodMirror &&
          d.isConstructor &&
          MirrorSystem.getName(d.constructorName) == member) {
        return d;
      }
    }
    return null;
  }

  final m = switch (mapName) {
    // A factory or named constructor is often registered among the statics
    // (`Future.delayed`), so both maps try both.
    'constructors' ||
    'staticMethods' => constructor() ?? cls.staticMembers[Symbol(member)],
    _ =>
      cls.instanceMembers[Symbol(member)] ?? _declaredInHierarchy(cls, member),
  };
  return m == null ? null : _positional(m);
}

/// [member] as declared on [cls] or anything it extends, implements or mixes
/// in.
///
/// `instanceMembers` follows only the superclass chain, so it misses every
/// member an abstract class or interface gets by IMPLEMENTING another:
/// `HashSet implements Set`, and `add` / `contains` live on `Set` / `Iterable`.
MethodMirror? _declaredInHierarchy(ClassMirror cls, String member) {
  final seen = <ClassMirror>{};
  final queue = [cls];
  while (queue.isNotEmpty) {
    final c = queue.removeLast();
    if (!seen.add(c.originalDeclaration as ClassMirror)) continue;
    final d = c.declarations[Symbol(member)];
    if (d is MethodMirror && !d.isStatic && !d.isConstructor) return d;
    // A field declares its getter implicitly: a getter reads no positional
    // argument, which is what the member's arity is.
    if (d is VariableMirror && !d.isStatic) return null;
    queue.addAll(c.superinterfaces);
    if (c.superclass != null) queue.add(c.superclass!);
    queue.addAll(c.mixin == c ? const [] : [c.mixin]);
  }
  return null;
}

/// One adapter the census reported unguarded, located for editing.
class Site {
  Site(this.file, this.className, this.mapName, this.member, this.fn);
  final String file;
  final String className;
  final String mapName;
  final String member;
  final FunctionExpression fn;
}

class _SiteWalker extends RecursiveAstVisitor<void> {
  _SiteWalker(this.file, this.wanted, this.out);
  final String file;

  /// Line numbers the census reported unguarded in this file.
  final Set<int> wanted;
  final List<Site> out;
  late final LineLookup lines;

  @override
  void visitFunctionExpression(FunctionExpression node) {
    final params = node.parameters?.parameters ?? const [];
    final names = [for (final p in params) p.name?.lexeme];
    final isAdapter =
        names.isNotEmpty &&
        names.first == 'visitor' &&
        names.contains('positionalArgs');
    if (!isAdapter) return super.visitFunctionExpression(node);
    if (!wanted.contains(lines(node.offset))) return;
    final entry = node.parent;
    if (entry is! MapLiteralEntry || entry.key is! SimpleStringLiteral) return;
    final map = entry.parent;
    final named = map?.parent;
    if (named is! NamedExpression) return;
    final args = named.parent;
    if (args is! ArgumentList) return;
    String? className;
    for (final a in args.arguments) {
      if (a is NamedExpression &&
          a.name.label.name == 'name' &&
          a.expression is SimpleStringLiteral) {
        className = (a.expression as SimpleStringLiteral).value;
      }
    }
    if (className == null) return;
    out.add(
      Site(
        file,
        className,
        named.name.label.name,
        (entry.key as SimpleStringLiteral).value,
        node,
      ),
    );
  }
}

typedef LineLookup = int Function(int offset);

void main(List<String> args) {
  final write = args.contains('--write');
  const root = 'lib/src/stdlib';
  final unguarded = surplusCensus(
    root,
  ).where((f) => f.verdict == Verdict.unguarded).toList();
  final byFile = <String, Set<int>>{};
  final maxIndexAt = <String, int>{};
  for (final f in unguarded) {
    (byFile[f.file] ??= <int>{}).add(f.line);
    maxIndexAt['${f.file}:${f.line}:${f.key}'] = f.maxIndex;
  }

  var bounded = 0;
  final noSdk = <String>[];
  final sdkFewer = <String>[];
  final forwardsFewer = <String>[];

  for (final MapEntry(key: rel, value: lineSet) in byFile.entries) {
    final path = '$root/$rel';
    final content = File(path).readAsStringSync();
    final result = parseString(
      content: content,
      featureSet: FeatureSet.latestLanguageVersion(),
      throwIfDiagnostics: false,
    );
    final sites = <Site>[];
    final walker = _SiteWalker(rel, lineSet, sites)
      ..lines = (o) => result.lineInfo.getLocation(o).lineNumber;
    result.unit.accept(walker);
    for (final line in lineSet) {
      if (!sites.any(
        (s) => result.lineInfo.getLocation(s.fn.offset).lineNumber == line,
      )) {
        noSdk.add(
          '$rel:$line  (not located: not a map entry of a BridgedClass)',
        );
      }
    }

    final edits = <(int, int, String)>[];
    for (final site in sites) {
      final line = result.lineInfo.getLocation(site.fn.offset).lineNumber;
      final where = '$rel:$line  ${site.className}.${site.member}';
      final maxIndex = maxIndexAt['$rel:$line:${site.member}'] ?? -1;
      final cls = _sdkClass(site.className);
      final n =
          _extensionArity['${site.className}.${site.member}'] ??
          (cls == null
              ? null
              : sdkPositionalCount(cls, site.mapName, site.member));
      if (n == null) {
        noSdk.add('$where  (${site.mapName})');
        continue;
      }
      if (n < maxIndex + 1) {
        sdkFewer.add('$where  (SDK $n, reads up to [$maxIndex])');
        continue;
      }
      if (n > maxIndex + 1) {
        forwardsFewer.add('$where  (SDK $n, reads up to [$maxIndex])');
      }
      final label = site.member.isEmpty
          ? '${site.className}.new'
          : '${site.className}.${site.member}';
      final guard = "D4.checkArity(positionalArgs, '$label', atMost: $n);";
      final body = site.fn.body;
      if (body is BlockFunctionBody) {
        edits.add((body.block.leftBracket.end, 0, '\n$guard'));
      } else if (body is ExpressionFunctionBody) {
        final expr = body.expression;
        edits.add((
          body.functionDefinition.offset,
          expr.end - body.functionDefinition.offset,
          '{\n$guard\nreturn ${content.substring(expr.offset, expr.end)};\n}',
        ));
      } else {
        noSdk.add('$where  (unexpected body shape)');
        continue;
      }
      bounded++;
    }
    if (write && edits.isNotEmpty) {
      var updated = content;
      edits.sort((a, b) => b.$1.compareTo(a.$1));
      for (final (offset, length, text) in edits) {
        updated = updated.replaceRange(offset, offset + length, text);
      }
      File(path).writeAsStringSync(updated);
    }
  }

  print(
    '${unguarded.length} unguarded; ${write ? 'bounded' : 'would bound'} '
    '$bounded; ${noSdk.length} with no SDK member; ${sdkFewer.length} where '
    'the SDK allows fewer than the adapter reads; ${forwardsFewer.length} '
    'bounded that ignore a legal argument.',
  );
  void section(String title, List<String> items) {
    if (items.isEmpty) return;
    print('\n$title');
    for (final i in items..sort()) {
      print('  $i');
    }
  }

  section('NO SDK MEMBER — left alone:', noSdk);
  section('SDK ALLOWS FEWER — left alone:', sdkFewer);
  section(
    'FORWARDS FEWER — bounded at the SDK count; the adapter ignores a '
    'legal argument:',
    forwardsFewer,
  );
}
