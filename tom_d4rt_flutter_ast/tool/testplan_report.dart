// ignore_for_file: avoid_print
/// Generates the Flutter bridge testplans from what the package actually has.
///
/// Run from the tom_d4rt_flutter_ast project root:
///
///     dart run tool/testplan_report.dart           # write the testplans
///     dart run tool/testplan_report.dart --check   # exit 1 if any is stale
///
/// The class lists come from the generated bridges: every name a bridge file
/// registers in `classSourceUris()`, `enumSourceUris()` or `classAliases()`,
/// grouped by the library that declares it (`package:flutter/src/<library>/`,
/// `dart:ui`, or another package). Whether a class is exercised comes from the
/// corpus: a class is exercised when a script that a corpus driver sends, in a
/// test that is not skipped, names it in its code - not in a comment or a
/// string, and not as a class the script declares itself (a local shim of the
/// same name does not exercise the bridge). The tiers (Essential, Important,
/// Secondary, Hardly Relevant) are the only hand-maintained input: the tables
/// of `_copilot_guidelines/testpriority_<library>.md`; a bridged class no
/// priority file names is Hardly Relevant.
///
/// Output, all under `_copilot_guidelines/`: `testplan_<library>.md` per
/// library, `testplan_<tier>.md` per tier, and the block between the
/// `testplan_report` markers in `flutter_bridge_test_plan.md`. The guard
/// `test/testplan_fresh_test.dart` runs [buildTestplans] and fails when a
/// committed file differs or a priority row names a class the bridges do not
/// register.
library;

import 'dart:io';

import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:path/path.dart' as p;

const String scriptsDir =
    'test/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts';
const String guidelinesDir = '_copilot_guidelines';
const String bridgesDir = 'lib/src/bridges';
const String summaryFile = 'flutter_bridge_test_plan.md';
const String beginMarker = '<!-- testplan_report:begin -->';
const String endMarker = '<!-- testplan_report:end -->';

/// The tiers, highest first, as the priority files spell their headings.
const List<String> tiers = [
  'Essential',
  'Important',
  'Secondary',
  'Hardly Relevant',
];

/// One bridged name.
class BridgedName {
  BridgedName(this.name, this.kind, this.library, this.sourceUri);

  final String name;

  /// [name], or `name@library` when two libraries declare a bridged name of
  /// that spelling (`Image` in dart:ui and in widgets).
  late final String key;

  /// `class`, `enum` or `alias of <target>`.
  final String kind;
  final String library;
  final String sourceUri;
}

/// What the corpus does with one bridged name.
class Usage {
  /// Scripts a running (not skipped) driver test sends that name it.
  final Set<String> running = {};

  /// Scripts that name it but are only sent by skipped tests, or by no test.
  final Set<String> other = {};
}

/// The generated files (path relative to the package root -> content) and the
/// findings that make the input invalid.
class TestplanBuild {
  TestplanBuild(this.files, this.findings);

  final Map<String, String> files;
  final List<String> findings;
}

/// The library a declaring URI belongs to.
String libraryOf(String uri) {
  if (uri.startsWith('dart:ui') || uri.contains('/sky_engine/')) {
    return 'dart_ui';
  }
  final flutter = RegExp(r'^package:flutter/src/([a-z_]+)/').firstMatch(uri);
  if (flutter != null) return flutter.group(1)!;
  final pkg = RegExp(r'^package:([a-z_0-9]+)/').firstMatch(uri);
  if (pkg != null) return pkg.group(1)!;
  final dart = RegExp(r'^dart:([a-z_]+)').firstMatch(uri);
  return dart != null ? 'dart_${dart.group(1)}' : 'other';
}

/// The entries of the `static Map<String, String> <name>() { ... }` maps.
Map<String, String> _stringMap(String source, String name) {
  final out = <String, String>{};
  final body = RegExp(
    'static Map<String, String> $name\\(\\) \\{(.*?)\\n  \\}',
    dotAll: true,
  );
  for (final m in body.allMatches(source)) {
    for (final e in RegExp(
      r"'([A-Za-z_$][\w$]*)':\s*'([^']+)'",
    ).allMatches(m.group(1)!)) {
      out[e.group(1)!] = e.group(2)!;
    }
  }
  return out;
}

/// Every bridged name, by [BridgedName.key]. A name registered by several
/// bridge files under one declaring URI is one entry (the files re-export
/// it); two declarations of one name are two entries.
Map<String, BridgedName> readBridgedNames(String root) {
  final byDeclaration = <String, BridgedName>{};
  final aliases = <String, String>{};
  final files =
      Directory(p.join(root, bridgesDir))
          .listSync()
          .whereType<File>()
          .where((f) => f.path.endsWith('.b.dart'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  for (final file in files) {
    final source = file.readAsStringSync();
    for (final (map, kind) in [
      ('classSourceUris', 'class'),
      ('enumSourceUris', 'enum'),
    ]) {
      _stringMap(source, map).forEach(
        (n, uri) => byDeclaration.putIfAbsent(
          '$n|$uri',
          () => BridgedName(n, kind, libraryOf(uri), uri),
        ),
      );
    }
    aliases.addAll(_stringMap(source, 'classAliases'));
  }
  final spelled = <String, List<BridgedName>>{};
  for (final b in byDeclaration.values) {
    spelled.putIfAbsent(b.name, () => []).add(b);
  }
  aliases.forEach((alias, target) {
    final targets = spelled[target];
    if (targets == null || targets.length != 1 || spelled.containsKey(alias)) {
      return;
    }
    final t = targets.single;
    spelled[alias] = [
      BridgedName(alias, 'alias of $target', t.library, t.sourceUri),
    ];
  });
  final names = <String, BridgedName>{};
  for (final list in spelled.values) {
    for (final b in list) {
      b.key = list.length == 1 ? b.name : '${b.name}@${b.library}';
      names[b.key] = b;
    }
  }
  return names;
}

/// The [BridgedName.key]s of the bridged names a script's code uses, minus
/// the names it declares itself. A name two libraries declare is attributed
/// by how the script reaches it: through an import prefix, by that import's
/// library; unprefixed, by the script's unprefixed imports (Flutter's
/// libraries before `dart:ui` and `package:vector_math`).
Set<String> usedBridgedKeys(
  String source,
  Map<String, List<BridgedName>> byName,
) {
  final unit = parseString(content: source, throwIfDiagnostics: false).unit;
  final prefixes = <String, String>{};
  final unprefixed = <String>[];
  for (final d in unit.directives.whereType<ImportDirective>()) {
    final uri = d.uri.stringValue ?? '';
    final prefix = d.prefix?.name;
    if (prefix != null) {
      prefixes[prefix] = uri;
    } else {
      unprefixed.add(uri);
    }
  }
  final collector = _NameCollector(prefixes.keys.toSet());
  unit.accept(collector);
  BridgedName? pick(List<BridgedName> candidates, List<String> uris) {
    BridgedName? first(bool Function(BridgedName) test) =>
        candidates.where(test).firstOrNull;
    if (uris.any((u) => u.startsWith('package:flutter/'))) {
      final f = first(
        (b) => b.library != 'dart_ui' && b.library != 'vector_math',
      );
      if (f != null) return f;
    }
    if (uris.contains('dart:ui')) {
      final f = first((b) => b.library == 'dart_ui');
      if (f != null) return f;
    }
    if (uris.any((u) => u.startsWith('package:vector_math/'))) {
      final f = first((b) => b.library == 'vector_math');
      if (f != null) return f;
    }
    return null;
  }

  final keys = <String>{};
  for (final (prefix, name) in collector.uses) {
    if (collector.declared.contains(name) && prefix == null) continue;
    final candidates = byName[name];
    if (candidates == null) continue;
    if (candidates.length == 1) {
      keys.add(candidates.single.key);
      continue;
    }
    final uris = prefix == null
        ? unprefixed
        : [if (prefixes[prefix] != null) prefixes[prefix]!];
    final chosen = pick(candidates, uris);
    if (chosen != null) keys.add(chosen.key);
  }
  return keys;
}

class _NameCollector extends RecursiveAstVisitor<void> {
  _NameCollector(this.importPrefixes);

  final Set<String> importPrefixes;

  /// `(import prefix or null, name)` for every name used in code.
  final Set<(String?, String)> uses = {};
  final Set<String> declared = {};

  // A doc comment's `[Name]` references are identifiers inside the Comment
  // node; naming a class in a comment does not use it.
  @override
  void visitComment(Comment node) {}

  @override
  void visitPrefixedIdentifier(PrefixedIdentifier node) {
    if (importPrefixes.contains(node.prefix.name)) {
      uses.add((node.prefix.name, node.identifier.name));
      return;
    }
    super.visitPrefixedIdentifier(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final target = node.target;
    if (target is SimpleIdentifier && importPrefixes.contains(target.name)) {
      uses.add((target.name, node.methodName.name));
      node.argumentList.accept(this);
      node.typeArguments?.accept(this);
      return;
    }
    super.visitMethodInvocation(node);
  }

  @override
  void visitSimpleIdentifier(SimpleIdentifier node) {
    uses.add((null, node.name));
    super.visitSimpleIdentifier(node);
  }

  @override
  void visitNamedType(NamedType node) {
    uses.add((node.importPrefix?.name.lexeme, node.name.lexeme));
    super.visitNamedType(node);
  }

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    declared.add(node.namePart.typeName.lexeme);
    super.visitClassDeclaration(node);
  }

  @override
  void visitMixinDeclaration(MixinDeclaration node) {
    declared.add(node.name.lexeme);
    super.visitMixinDeclaration(node);
  }

  @override
  void visitEnumDeclaration(EnumDeclaration node) {
    declared.add(node.namePart.typeName.lexeme);
    super.visitEnumDeclaration(node);
  }

  @override
  void visitGenericTypeAlias(GenericTypeAlias node) {
    declared.add(node.name.lexeme);
    super.visitGenericTypeAlias(node);
  }
}

/// The scripts the drivers send, each with whether some sending test runs
/// (is not skipped). Paths relative to [scriptsDir].
Map<String, bool> readSentScripts(String root) {
  final sent = <String, bool>{};
  final drivers =
      Directory(p.join(root, 'test'))
          .listSync()
          .whereType<File>()
          .where(
            (f) => RegExp(
              r'flutter_(base|extended)_\d+_test\.dart$',
            ).hasMatch(f.path),
          )
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  for (final driver in drivers) {
    final unit = parseString(
      content: driver.readAsStringSync(),
      throwIfDiagnostics: false,
    ).unit;
    unit.accept(_SendCollector(sent));
  }
  return sent;
}

class _SendCollector extends RecursiveAstVisitor<void> {
  _SendCollector(this.sent);

  final Map<String, bool> sent;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    if (node.target == null && node.methodName.name == 'test') {
      final args = node.argumentList.arguments;
      final skip = args
          .whereType<NamedArgument>()
          .where((a) => a.name.lexeme == 'skip')
          .map((a) => a.argumentExpression)
          .firstOrNull;
      final skipped = skip != null && skip is! NullLiteral;
      final paths = <String>[];
      node.accept(_SendPathCollector(paths));
      for (final path in paths) {
        sent[path] = (sent[path] ?? false) || !skipped;
      }
      return;
    }
    super.visitMethodInvocation(node);
  }
}

class _SendPathCollector extends RecursiveAstVisitor<void> {
  _SendPathCollector(this.paths);

  final List<String> paths;

  @override
  void visitMethodInvocation(MethodInvocation node) {
    final target = node.target;
    if (node.methodName.name == 'send' &&
        target is SimpleIdentifier &&
        target.name == 'SendTestRunner') {
      final first = node.argumentList.arguments.firstOrNull;
      if (first is SimpleStringLiteral) paths.add(first.value);
    }
    super.visitMethodInvocation(node);
  }
}

/// The tier of each name the priority files classify, with its description,
/// and the findings. `testpriority_<library>.md` classifies the classes
/// `<library>` declares: a row naming a class the bridges do not register, a
/// class of another library, or a class twice is a finding.
({Map<String, (String, String)> tierOf, List<String> findings}) readTiers(
  String root,
  Map<String, BridgedName> bridged,
) {
  final tierOf = <String, (String, String)>{};
  final findings = <String>[];
  final files =
      Directory(p.join(root, guidelinesDir))
          .listSync()
          .whereType<File>()
          .where((f) => p.basename(f.path).startsWith('testpriority_'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  for (final file in files) {
    final name = p.basename(file.path);
    final library = name.substring(
      'testpriority_'.length,
      name.length - '.md'.length,
    );
    String? tier;
    final lines = file.readAsLinesSync();
    for (var i = 0; i < lines.length; i++) {
      final line = lines[i];
      final heading = RegExp(r'^## (.+?)\s*$').firstMatch(line);
      if (heading != null) {
        final t = heading.group(1)!;
        tier = tiers.contains(t) ? t : null;
        continue;
      }
      if (tier == null || !line.startsWith('|')) continue;
      final cells = line.split('|').map((c) => c.trim()).toList();
      if (cells.length < 3) continue;
      final cls = cells[1];
      if (cls == 'Class' || cls.startsWith('-')) continue;
      final where = '$guidelinesDir/$name:${i + 1}';
      final spellings = bridged.values.where((x) => x.name == cls).toList();
      final b =
          spellings.where((x) => x.library == library).firstOrNull ??
          spellings.firstOrNull;
      if (b == null) {
        findings.add('$where: `$cls` is not a name the bridges register');
      } else if (b.library != library) {
        findings.add(
          '$where: `$cls` is declared in ${b.library}; classify it in '
          'testpriority_${b.library}.md',
        );
      } else if (tierOf.containsKey(b.key)) {
        findings.add('$where: `$cls` is classified twice');
      } else {
        tierOf[b.key] = (tier, cells[2]);
      }
    }
  }
  return (tierOf: tierOf, findings: findings);
}

String _scripts(Usage? u) {
  if (u == null) return '';
  final list = (u.running.isNotEmpty ? u.running : u.other).toList()..sort();
  final shown = list.take(3).join(', ');
  return list.length > 3 ? '$shown, +${list.length - 3}' : shown;
}

String _status(Usage? u) {
  if (u != null && u.running.isNotEmpty) return '✅';
  if (u != null && u.other.isNotEmpty) return '🟨';
  return '⬜';
}

String _percent(int part, int whole) =>
    whole == 0 ? '0.0%' : '${(100 * part / whole).toStringAsFixed(1)}%';

const String _generatedNote =
    '<!-- GENERATED by tool/testplan_report.dart - do not edit; run '
    '`dart run tool/testplan_report.dart`. The tiers are edited in '
    'testpriority_<library>.md. -->';

const String _legend =
    'Status: ✅ a script a running corpus test sends uses the class in its '
    'code; 🟨 only scripts no running test sends (skipped or not wired) use '
    'it; ⬜ no script uses it. "Used" means named in code - not in a comment '
    'or a string, and not as a class the script declares itself.';

/// Builds every generated file from the package at [root].
TestplanBuild buildTestplans(String root) {
  final bridged = readBridgedNames(root);
  final byName = <String, List<BridgedName>>{};
  for (final b in bridged.values) {
    byName.putIfAbsent(b.name, () => []).add(b);
  }
  final sent = readSentScripts(root);
  final usage = <String, Usage>{};
  final scriptFiles =
      Directory(p.join(root, scriptsDir))
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));
  for (final file in scriptFiles) {
    final rel = p.posix.joinAll(
      p.split(p.relative(file.path, from: p.join(root, scriptsDir))),
    );
    final running = sent[rel] ?? false;
    for (final key in usedBridgedKeys(file.readAsStringSync(), byName)) {
      final u = usage.putIfAbsent(key, Usage.new);
      (running ? u.running : u.other).add(rel);
    }
  }
  final (:tierOf, :findings) = readTiers(root, bridged);
  String tierFor(String key) => tierOf[key]?.$1 ?? 'Hardly Relevant';

  final files = <String, String>{};
  final byLibrary = <String, List<BridgedName>>{};
  for (final b in bridged.values) {
    byLibrary.putIfAbsent(b.library, () => []).add(b);
  }
  final libraries = byLibrary.keys.toList()..sort();
  final stats = <String, (int, int, int)>{};

  for (final lib in libraries) {
    final rows = byLibrary[lib]!..sort((a, b) => a.name.compareTo(b.name));
    final exercised = rows
        .where((r) => usage[r.key]?.running.isNotEmpty ?? false)
        .length;
    final partly = rows.where((r) => _status(usage[r.key]) == '🟨').length;
    stats[lib] = (rows.length, exercised, partly);
    final b = StringBuffer()
      ..writeln('# Test Plan: $lib')
      ..writeln()
      ..writeln(_generatedNote)
      ..writeln()
      ..writeln(
        'Every name the bridges register for `$lib` '
        '(${rows.length}), with its tier and the corpus scripts that use it. '
        '$_legend',
      )
      ..writeln()
      ..writeln(
        '- **Exercised:** $exercised of ${rows.length} '
        '(${_percent(exercised, rows.length)})',
      )
      ..writeln('- **Used only by scripts no running test sends:** $partly')
      ..writeln(
        '- **Not used by any script:** ${rows.length - exercised - partly}',
      )
      ..writeln()
      ..writeln('| # | Name | Kind | Tier | Status | Scripts |')
      ..writeln('|---|------|------|------|--------|---------|');
    var i = 0;
    for (final r in rows) {
      i++;
      final u = usage[r.key];
      b.writeln(
        '| $i | ${r.name} | ${r.kind} | ${tierFor(r.key)} | ${_status(u)} | '
        '${_scripts(u)} |',
      );
    }
    files['$guidelinesDir/testplan_$lib.md'] = b.toString();
  }

  for (final tier in tiers) {
    final slug = tier.toLowerCase().replaceAll(' ', '_');
    final members = bridged.values.where((b) => tierFor(b.key) == tier).toList()
      ..sort((a, b) {
        final byLib = a.library.compareTo(b.library);
        return byLib != 0 ? byLib : a.name.compareTo(b.name);
      });
    final exercised = members
        .where((m) => usage[m.key]?.running.isNotEmpty ?? false)
        .length;
    final b = StringBuffer()
      ..writeln('# Test Plan: $tier Classes')
      ..writeln()
      ..writeln(_generatedNote)
      ..writeln()
      ..writeln(
        tier == 'Hardly Relevant'
            ? 'The bridged names the priority files classify as Hardly '
                  'Relevant, and every bridged name they do not classify. '
                  '$_legend'
            : 'The bridged names the priority files classify as $tier. '
                  '$_legend',
      )
      ..writeln()
      ..writeln(
        '- **Exercised:** $exercised of ${members.length} '
        '(${_percent(exercised, members.length)})',
      );
    String? current;
    for (final m in members) {
      if (m.library != current) {
        current = m.library;
        final n = members.where((x) => x.library == current).length;
        b
          ..writeln()
          ..writeln('## $current ($n)')
          ..writeln()
          ..writeln('| Name | Description | Status | Scripts |')
          ..writeln('|------|-------------|--------|---------|');
      }
      final u = usage[m.key];
      final desc = tierOf[m.key]?.$2 ?? '(not classified)';
      b.writeln('| ${m.name} | $desc | ${_status(u)} | ${_scripts(u)} |');
    }
    files['$guidelinesDir/testplan_$slug.md'] = b.toString();
  }

  final summary = StringBuffer()
    ..writeln(beginMarker)
    ..writeln(_generatedNote)
    ..writeln()
    ..writeln(
      'Measured by `tool/testplan_report.dart` from the bridges and the '
      'corpus. A name is counted once, under the library that declares it, '
      'however many bridge files register it. $_legend',
    )
    ..writeln()
    ..writeln('| Library | Bridged | Exercised | 🟨 | ⬜ | Coverage |')
    ..writeln('|---------|---------|-----------|----|----|----------|');
  var total = 0, totalEx = 0, totalPartly = 0;
  for (final lib in libraries) {
    final (n, ex, partly) = stats[lib]!;
    total += n;
    totalEx += ex;
    totalPartly += partly;
    summary.writeln(
      '| [$lib](testplan_$lib.md) | $n | $ex | $partly | ${n - ex - partly} | '
      '${_percent(ex, n)} |',
    );
  }
  summary
    ..writeln(
      '| **Total** | **$total** | **$totalEx** | **$totalPartly** | '
      '**${total - totalEx - totalPartly}** | **${_percent(totalEx, total)}** |',
    )
    ..writeln()
    ..writeln('By tier:')
    ..writeln()
    ..writeln('| Tier | Bridged | Exercised | Coverage |')
    ..writeln('|------|---------|-----------|----------|');
  for (final tier in tiers) {
    final slug = tier.toLowerCase().replaceAll(' ', '_');
    final members = bridged.values.where((b) => tierFor(b.key) == tier);
    final ex = members
        .where((m) => usage[m.key]?.running.isNotEmpty ?? false)
        .length;
    summary.writeln(
      '| [$tier](testplan_$slug.md) | ${members.length} | $ex | '
      '${_percent(ex, members.length)} |',
    );
  }
  summary.write(endMarker);

  final summaryPath = p.join(root, guidelinesDir, summaryFile);
  final existing = File(summaryPath).readAsStringSync();
  final start = existing.indexOf(beginMarker);
  final end = existing.indexOf(endMarker);
  if (start < 0 || end < start) {
    findings.add(
      '$guidelinesDir/$summaryFile: the $beginMarker / $endMarker block is '
      'missing',
    );
  } else {
    files['$guidelinesDir/$summaryFile'] =
        existing.substring(0, start) +
        summary.toString() +
        existing.substring(end + endMarker.length);
  }
  return TestplanBuild(files, findings);
}

/// The generated files whose committed content differs, or that are missing.
List<String> staleFiles(String root, TestplanBuild build) => [
  for (final e in build.files.entries)
    if (!File(p.join(root, e.key)).existsSync() ||
        File(p.join(root, e.key)).readAsStringSync() != e.value)
      e.key,
];

/// `testplan_*.md` files under the guidelines that the tool no longer writes
/// (a library or tier that disappeared).
List<String> orphanedPlans(String root, TestplanBuild build) => [
  for (final f in Directory(p.join(root, guidelinesDir)).listSync())
    if (f is File &&
        p.basename(f.path).startsWith('testplan_') &&
        p.basename(f.path).endsWith('.md') &&
        !build.files.containsKey('$guidelinesDir/${p.basename(f.path)}'))
      '$guidelinesDir/${p.basename(f.path)}',
];

void main(List<String> args) {
  final root = Directory.current.path;
  final build = buildTestplans(root);
  for (final f in build.findings) {
    print('FINDING: $f');
  }
  if (args.contains('--check')) {
    final stale = [...staleFiles(root, build), ...orphanedPlans(root, build)];
    for (final s in stale) {
      print('STALE: $s');
    }
    if (stale.isNotEmpty || build.findings.isNotEmpty) exitCode = 1;
    return;
  }
  for (final e in build.files.entries) {
    File(p.join(root, e.key)).writeAsStringSync(e.value);
  }
  for (final o in orphanedPlans(root, build)) {
    print('ORPHANED (not written by the tool, delete it): $o');
  }
  print('wrote ${build.files.length} files');
  if (build.findings.isNotEmpty) exitCode = 1;
}
