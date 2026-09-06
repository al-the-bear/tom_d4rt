// SCB24 — every stdlib bridge definition that is written must be registered.
//
// THE DEFECT SHAPE
//
// `StringConversionConvert` and `ChunkedConversionConvert` were fully written —
// constructors, adapters, argument validation, the lot — exported from
// `convert.dart`, and NEVER passed to `defineBridge`. No script could name
// either one. SC9 found them by accident.
//
// This is a distinct failure from every gap the SDK audit catalogues. That
// audit looks for missing FILES, and by that measure these two libraries were
// complete: the file existed, the class existed, the adapters were being
// maintained. Only the one line that puts the definition into an `Environment`
// was absent.
//
// The cost was far larger than two classes. `StringConversionSink` is the
// argument every `Converter.startChunkedConversion` requires, so its absence
// made the entire chunked-conversion surface of `dart:convert` unreachable —
// a script got `Undefined variable: StringConversionSink` and had no
// workaround.
//
// WHAT IS ASSERTED, AND WHY IT IS NOT THE DIFF SCB24 DESCRIBED
//
// SCB24 proposed diffing the definitions declared under a registrar's folder
// against the ones passed to `defineBridge` in that registrar. That is a
// SOURCE-level check, and it has a blind spot the runtime version does not: a
// `defineBridge` call inside a `register()` method that nobody invokes reads as
// registered and is not. Both orphans SC9 found would have been caught either
// way, but the weaker check is not cheaper here — the environment has to be
// built regardless — so this asserts the property that actually matters:
//
//   every `static BridgedClass get …` declared anywhere under `lib/src/stdlib`
//   produces a bridge NAME that is live in a fully registered `Environment`.
//
// HOW THE DECLARED SIDE IS READ. With the analyzer, over unresolved ASTs. Note
// that an unresolved parse cannot tell a constructor call from a function call,
// so `BridgedClass(...)` arrives as a `MethodInvocation` rather than an
// `InstanceCreationExpression`; both are handled, and F-SCB24-3 fails loudly if
// the name could not be read rather than skipping the declaration — a scan that
// silently reads nothing would make this file pass while checking nothing.
//
// TREE ASYMMETRY: this file needs the `analyzer` package and so lives only in
// `tom_d4rt`. `tom_d4rt_ast` carries a weaker count-based twin; see its header.

import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';
// The stdlib registrars are not part of the published surface, so they are
// reached by same-package path rather than by widening `d4rt.dart` for a test.
import 'package:tom_d4rt/src/stdlib/collection.dart';
import 'package:tom_d4rt/src/stdlib/convert.dart';
import 'package:tom_d4rt/src/stdlib/io.dart';
import 'package:tom_d4rt/src/stdlib/isolate.dart';
import 'package:tom_d4rt/src/stdlib/math.dart';

const _stdlibRoot = 'lib/src/stdlib';

/// Reads the `name:` argument of the `BridgedClass(...)` a definition getter
/// builds.
class _BridgeNameFinder extends RecursiveAstVisitor<void> {
  String? name;

  void _scan(ArgumentList args) {
    for (final argument in args.arguments) {
      if (argument is NamedExpression && argument.name.label.name == 'name') {
        final value = argument.expression;
        if (value is SimpleStringLiteral) name ??= value.value;
      }
    }
  }

  @override
  void visitInstanceCreationExpression(InstanceCreationExpression node) {
    if (node.constructorName.type.toSource() == 'BridgedClass') {
      _scan(node.argumentList);
    }
    super.visitInstanceCreationExpression(node);
  }

  @override
  void visitMethodInvocation(MethodInvocation node) {
    // The unresolved-parse form of the same expression.
    if (node.methodName.name == 'BridgedClass') _scan(node.argumentList);
    super.visitMethodInvocation(node);
  }
}

/// One declared definition: where it lives and what it calls itself.
class _Declaration {
  const _Declaration(this.owner, this.file, this.bridgeName);
  final String owner; // `SomeClass.definition`
  final String file;
  final String? bridgeName; // null when the scan could not read it
}

List<_Declaration> _declaredDefinitions() {
  final found = <_Declaration>[];
  for (final file
      in Directory(_stdlibRoot)
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.dart'))) {
    final unit = parseFile(
      path: file.absolute.path,
      featureSet: FeatureSet.latestLanguageVersion(),
      throwIfDiagnostics: false,
    ).unit;
    for (final declaration in unit.declarations) {
      if (declaration is! ClassDeclaration) continue;
      for (final member in declaration.members) {
        if (member is! MethodDeclaration) continue;
        if (!member.isStatic || !member.isGetter) continue;
        if (member.returnType?.toSource() != 'BridgedClass') continue;
        final finder = _BridgeNameFinder();
        member.accept(finder);
        found.add(
          _Declaration(
            '${declaration.name.lexeme}.${member.name.lexeme}',
            file.path,
            finder.name,
          ),
        );
      }
    }
  }
  return found;
}

/// The same registration a script gets with every `dart:` library imported.
Environment _fullyRegisteredEnvironment() {
  final env = Environment();
  Stdlib(env).register(); // core + async + typed_data
  MathStdlib.register(env);
  ConvertStdlib.register(env);
  IoStdlib.register(env);
  CollectionStdlib.register(env);
  IsolateStdlib.register(env);
  return env;
}

void main() {
  final declarations = _declaredDefinitions();
  final live = _fullyRegisteredEnvironment().bridgedClassNames.toSet();

  test('F-SCB24-1: every declared bridge definition is registered '
      '[2026-09-06]', () {
    final unregistered = [
      for (final d in declarations)
        if (d.bridgeName != null && !live.contains(d.bridgeName))
          '${d.owner} -> "${d.bridgeName}"  (${d.file})',
    ]..sort();

    expect(
      unregistered,
      isEmpty,
      reason:
          'These bridge definitions are written but never reach an '
          'Environment, so no script can name the class they describe:\n'
          '  ${unregistered.join('\n  ')}\n\n'
          'Either add the `defineBridge` call to the owning registrar, or '
          'delete the definition — an unregistered definition is a bug or dead '
          'code, and both answers are cheap once it has a name.',
    );
  });

  test('F-SCB24-2: the source scan read a bridge name for every declaration '
      '[2026-09-06]', () {
    // F-SCB24-1 skips a declaration whose name it could not read, so without
    // this a scan that stopped matching would leave it asserting nothing. It
    // has already happened once: `BridgedClass(...)` parses as a
    // MethodInvocation in an unresolved AST, and the first version of this scan
    // handled only InstanceCreationExpression — it read 0 of 205 names and
    // F-SCB24-1 passed.
    final unreadable = [
      for (final d in declarations)
        if (d.bridgeName == null) '${d.owner}  (${d.file})',
    ]..sort();

    expect(
      unreadable,
      isEmpty,
      reason:
          'The scan found these definition getters but could not read the '
          '`name:` they pass to `BridgedClass`, so F-SCB24-1 is not checking '
          'them:\n  ${unreadable.join('\n  ')}\n'
          'Either the definition builds its BridgedClass in a shape '
          '_BridgeNameFinder does not recognise, or `name:` is not a literal.',
    );
  });

  test('F-SCB24-3: the scan and the registry both found a real corpus '
      '[2026-09-06]', () {
    // The floor under two emptiness assertions. Both pass on a scan that found
    // no files and an environment where nothing registered. The bounds are far
    // below the real figures (205 declarations, 205 live names measured
    // 2026-09-06) because the job is to separate "measured" from "measured
    // nothing", not to pin the count — pinning it would make every added bridge
    // an edit here.
    expect(declarations.length, greaterThan(150));
    expect(live.length, greaterThan(150));
  });
}
