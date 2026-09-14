import 'dart:io';
import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:tom_d4rt/src/static_name_report.dart';

/// Every string literal handed to an `execute(...)`-shaped call in a test file.
class _ScriptHarvester extends GeneralizingAstVisitor<void> {
  final scripts = <(String, int)>[];
  @override
  void visitMethodInvocation(MethodInvocation node) {
    const runners = {'execute', 'executeSource', 'run', 'evalSource'};
    if (runners.contains(node.methodName.name)) {
      final args = node.argumentList.arguments;
      // A helper that takes its declarations in a separate argument
      // (`run(body, prelude: 'class MyEx ...')`) hands this harvester only
      // half a program. Sweeping that half reports the prelude's own class
      // names as undefined — a harness artifact, not a finding.
      final hasSeparateSource = args.whereType<NamedExpression>().any(
        (a) => a.expression is StringLiteral,
      );
      if (args.isNotEmpty && !hasSeparateSource) {
        final first = args.first;
        if (first is StringLiteral) {
          final v = first.stringValue;
          if (v != null && v.trim().isNotEmpty) scripts.add((v, node.offset));
        }
      }
    }
    super.visitMethodInvocation(node);
  }
}

Set<String> stdlibGlobals() {
  final names = <String>{
    'print',
    'int',
    'double',
    'num',
    'String',
    'bool',
    'List',
    'Map',
    'Set',
    'Iterable',
    'Object',
    'dynamic',
    'void',
    'Function',
    'Future',
    'Stream',
    'Duration',
    'DateTime',
    'RegExp',
    'StringBuffer',
    'Uri',
    'BigInt',
    'Comparable',
    'Symbol',
    'Type',
    'Record',
    'Null',
    'Never',
    'Enum',
    'identical',
    'identityHashCode',
    'main',
    'Invocation',
    'Expando',
  };
  final res = [
    RegExp(r"name: '([A-Za-z_][A-Za-z0-9_]*)'"),
    RegExp(r"\.define\('([A-Za-z_][A-Za-z0-9_]*)'"),
    RegExp(r"'([A-Za-z_][A-Za-z0-9_]*)': \(visitor,"),
  ];
  for (final f in Directory(
    'lib/src/stdlib',
  ).listSync(recursive: true).whereType<File>()) {
    if (!f.path.endsWith('.dart')) continue;
    final src = f.readAsStringSync();
    for (final re in res) {
      for (final m in re.allMatches(src)) {
        names.add(m.group(1)!);
      }
    }
  }
  return names;
}

void main(List<String> args) {
  final globals = stdlibGlobals();
  stderr.writeln('harvested ${globals.length} global names');
  var scripts = 0, parseFail = 0, suppressed = 0, clean = 0, dirty = 0;
  final hits = <String, int>{};
  final examples = <String, String>{};

  for (final f in Directory(
    args.isEmpty ? 'test' : args[0],
  ).listSync(recursive: true).whereType<File>()) {
    if (!f.path.endsWith('_test.dart')) continue;
    final unit = parseString(
      content: f.readAsStringSync(),
      featureSet: FeatureSet.latestLanguageVersion(),
      throwIfDiagnostics: false,
    ).unit;
    final h = _ScriptHarvester();
    unit.visitChildren(h);
    for (final (src, off) in h.scripts) {
      scripts++;
      final parsed = parseString(
        content: src,
        featureSet: FeatureSet.latestLanguageVersion(),
        throwIfDiagnostics: false,
      );
      // A snippet that does not parse is not this pass's business: d4rt would
      // fail it at parse time, before any resolution question arises.
      if (parsed.errors.any((e) => e.severity.name == 'ERROR')) {
        parseFail++;
        continue;
      }
      final unaccounted = parsed.unit.directives
          .whereType<ImportDirective>()
          .map((d) => d.uri.stringValue ?? '')
          .where((u) => !u.startsWith('dart:'))
          .toList();
      final report = reportUnresolvedNames(
        parsed.unit,
        globals,
        hasUnresolvedImports: unaccounted.isNotEmpty,
      );
      if (report.suppressed) {
        suppressed++;
      } else if (report.isClean) {
        clean++;
      } else {
        dirty++;
        for (final u in report.unresolved) {
          hits[u.name] = (hits[u.name] ?? 0) + 1;
          examples.putIfAbsent(u.name, () => '${f.path}@$off: $u');
        }
      }
    }
  }
  print(
    'scripts=$scripts parseFail=$parseFail suppressed=$suppressed '
    'clean=$clean dirty=$dirty',
  );
  print('distinct unresolved names=${hits.length}');
  final sorted = hits.entries.toList()
    ..sort((a, b) => b.value.compareTo(a.value));
  for (final e in sorted.take(30)) {
    print('  ${e.value.toString().padLeft(4)}  ${e.key}');
    print('        e.g. ${examples[e.key]}');
  }
}
