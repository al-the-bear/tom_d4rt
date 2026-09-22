// REPO-WIDE GUARD (tom_d4rt) — a type reachable through either interpreter's
// public API must be nameable through it.
//
// Its subject reaches OUTSIDE this package: it resolves `tom_d4rt_ast`'s three
// barrels as well as this one's. It runs only when tom_d4rt's suite runs, and a
// session working elsewhere in the repo reaches none of it. SCD129 made that
// arrangement visible rather than incidental: `grep -rn 'REPO-WIDE GUARD'
// */test` lists every one, and `scd129_repo_wide_guard_index_test.dart` fails
// if a new one arrives without this banner.

/// SCE156 — every type in the signature of a public member of an exported type
/// must itself be exported.
///
/// ## The property, and why it needs no oracle
///
/// `scd134_barrel_surface_parity_test.dart` compares the two barrels' exported
/// TOP-LEVEL names. That is a real check and it has a real ceiling: the twin is
/// its oracle, so it cannot see a type BOTH lines forget to export, and it does
/// not look at members at all. All three defects scd134 was written after were
/// instances of a stronger property that needs no twin —
/// `BridgedEnumDefinition.buildBridgedEnum()` returns `BridgedEnum`,
/// `Environment.getRuntimeType` returns one, `InterpreterVisitor.moduleLoader`
/// is a public field of type `ModuleLoader`. A consumer receives the value and
/// cannot write its name without reaching into `src/`.
///
/// This file asserts that property directly, over a RESOLVED export namespace:
/// for every name a barrel exports, walk its public members and check that
/// every type mentioned in a signature is in the same namespace.
///
/// ## Measured 2026-09-23, and the first run is the headline
///
/// | barrel                        | exported | members | unexported reachable |
/// | ----------------------------- | -------: | ------: | -------------------: |
/// | `tom_d4rt/d4rt.dart`          |      156 |    1156 | 79, every one analyzer |
/// | `tom_d4rt_ast/runtime.dart`   |      343 |    3200 |                    0 |
/// | `tom_d4rt_ast/d4rt.dart`      |      344 |    3201 |                    0 |
/// | `tom_d4rt_ast/ast.dart`       |      192 |    2053 |                    0 |
///
/// The work this came from expected a noisy first run to triage down. After the
/// analyzer exemption below — which was anticipated, not invented to make the
/// number look good — NOTHING survives. That is why [_findings] is asserted
/// EMPTY rather than ratcheted against a recorded baseline: there is no
/// baseline to record, and a hard zero is both a stronger guard and a cheaper
/// one to keep honest.
///
/// ## The one exemption, and what it is made to detect
///
/// The reference line's public surface is the analyzer AST: `InterpreterVisitor`
/// has a `visitX(X node)` for essentially every node type, `LoadedModule.ast` is
/// a `CompilationUnit`, `InterpretedFunction.constructor` takes a
/// `ConstructorDeclaration`. Re-exporting `package:analyzer` from `d4rt.dart` is
/// not something anybody wants; a consumer that needs those types imports the
/// analyzer, which it already has. So the exemption is deliberate — and it is
/// made to earn its place by F-SCE156-3, which asserts it catches a great many
/// names HERE and exactly none on the analyzer-free line. An analyzer type
/// surfacing through a `tom_d4rt_ast` barrel would be a far larger finding than
/// a missing export, and this is what would say so.
///
/// `package:_fe_analyzer_shared` is named beside it rather than folded in
/// silently: `TokenType`, reached through
/// `InterpreterVisitor.computeCompoundValue(operatorType)`, is the analyzer's
/// own dependency and the same category, but a reader should not have to infer
/// that from a package name.
///
/// ## One file, both lines
///
/// The analyzer-free tree cannot host this check — it resolves libraries with
/// `package:analyzer`, which is the one dependency `tom_d4rt_ast` exists to not
/// have. So it lives here and reaches across, the same arrangement the
/// user-bridge de-dup, `scd134` and `scd156` already use: one copy reporting on
/// the pair, rather than two copies that can disagree about what they check.
///
/// ## Ablation, because a guard that has never failed is a guess
///
/// | ablation                                              | -1  | -2  | -3  |
/// | ----------------------------------------------------- | --- | --- | --- |
/// | AST barrel drops its `environment.dart` export         | RED | ok  | ok  |
/// | `_exemptPackages` emptied                              | RED | ok  | RED |
/// | the `TopLevelFunctionElement` case removed             | ok  | RED | ok  |
/// | both of the above rows 1 and a package named exempt    | ok  | ok  | RED |
/// | none                                                   | ok  | ok  | ok  |
///
/// Row 1 is the real defect class and it reports it in the real shape:
/// *`Environment` is reachable but not exported — AstModuleLoader
/// .globalEnvironment, ...*, which is scd134's third finding rediscovered
/// without a twin to compare against. Row 4 is how the "inert on the
/// analyzer-free line" half of F-SCE156-3 was measured rather than assumed:
/// there is no way to make that line genuinely reach an analyzer type, so the
/// export was dropped and the declaring package named exempt, which produces
/// the same state by a different route.
///
/// ## What this file deliberately does NOT do
///
/// It does not compare MEMBERS between the twins. That is a different check
/// with a different oracle, and the case that prompted the question —
/// `D4rtRunner.bridgedLibraryUris`, which has no counterpart on `D4rt` — is
/// decided rather than left silent: it is the set of library URIs a host-side
/// bundler must skip when compiling a script to an `AstBundle`, and the
/// reference line parses source in process, so no reference consumer has
/// anything to skip. A legitimate divergence, recorded here because the
/// alternative is for it to stay an open question in a todo nobody re-reads.
library;

import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:test/test.dart';

import 'sibling_trees.dart';

/// The barrels this guard resolves, as (package dir, lib-relative path).
const _barrels = <(String, String)>[
  ('tom_d4rt', 'lib/d4rt.dart'),
  ('tom_d4rt_ast', 'lib/runtime.dart'),
  ('tom_d4rt_ast', 'lib/d4rt.dart'),
  ('tom_d4rt_ast', 'lib/ast.dart'),
];

/// Packages whose types are deliberately NOT re-exported.
///
/// See the library doc. F-SCE156-3 holds this to being load-bearing on the
/// reference line and inert on the analyzer-free one.
const _exemptPackages = <String>{'analyzer', '_fe_analyzer_shared'};

/// Floors for the control. Well under the measured counts — they exist to
/// catch a walk that resolved nothing, not to track the numbers.
const _minExportedNames = 100;
const _minMembersWalked = 800;

bool _isPublic(String? name) =>
    name != null && name.isNotEmpty && !name.startsWith('_');

String? _packageOf(Uri? uri) {
  if (uri == null || uri.scheme != 'package') return null;
  final segments = uri.pathSegments;
  return segments.isEmpty ? null : segments.first;
}

/// Every named element mentioned by [type], transitively through type
/// arguments, function signatures, record fields and type-parameter bounds.
void _collect(DartType? type, Set<Element> out, Set<DartType> seen) {
  if (type == null || !seen.add(type)) return;
  switch (type) {
    case InterfaceType():
      out.add(type.element);
      for (final argument in type.typeArguments) {
        _collect(argument, out, seen);
      }
    case FunctionType():
      _collect(type.returnType, out, seen);
      for (final parameter in type.formalParameters) {
        _collect(parameter.type, out, seen);
      }
    case RecordType():
      for (final field in type.positionalFields) {
        _collect(field.type, out, seen);
      }
      for (final field in type.namedFields) {
        _collect(field.type, out, seen);
      }
    case TypeParameterType():
      _collect(type.bound, out, seen);
    default:
      break;
  }
}

/// One barrel's measurement.
class _Surface {
  _Surface(this.label);

  final String label;
  int exportedNames = 0;
  int membersWalked = 0;

  /// `<declaring package>|<type name>` → the sites that reach it.
  final Map<String, Set<String>> unexported = {};

  /// Namespace entry kinds the walk does not understand. Non-empty means the
  /// measurement silently skipped part of the surface.
  final Set<String> unhandled = {};

  /// Findings whose declaring package is NOT exempt — the actual defect set.
  Map<String, Set<String>> get findings => {
    for (final entry in unexported.entries)
      if (!_exemptPackages.contains(entry.key.split('|').first))
        entry.key: entry.value,
  };

  /// Findings the exemption absorbed.
  int get exempted => unexported.length - findings.length;
}

Future<_Surface> _measure(String absolutePath, String label) async {
  final collection = AnalysisContextCollection(includedPaths: [absolutePath]);
  final context = collection.contextFor(absolutePath);
  final resolved = await context.currentSession.getResolvedLibrary(
    absolutePath,
  );
  if (resolved is! ResolvedLibraryResult) {
    fail('could not resolve $label ($absolutePath): ${resolved.runtimeType}');
  }

  final surface = _Surface(label);
  final namespace = resolved.element.exportNamespace.definedNames2;
  final exported = namespace.values.toSet();
  surface.exportedNames = namespace.length;

  void check(String site, DartType? type) {
    final referenced = <Element>{};
    _collect(type, referenced, <DartType>{});
    for (final element in referenced) {
      if (!_isPublic(element.name)) continue;
      final package = _packageOf(element.library?.uri);
      if (package == null) continue; // dart:* and unnamed sources.
      if (exported.contains(element)) continue;
      surface.unexported
          .putIfAbsent('$package|${element.name}', () => <String>{})
          .add(site);
    }
  }

  for (final entry in namespace.entries) {
    final element = entry.value;
    final owner = entry.key;

    void walkExecutable(
      String label,
      DartType returnType,
      List<FormalParameterElement> parameters,
    ) {
      surface.membersWalked++;
      check('$owner$label', returnType);
      for (final parameter in parameters) {
        check('$owner$label(${parameter.name})', parameter.type);
      }
    }

    // `fields`/`getters`/`setters`/`methods` are declared on InterfaceElement
    // and ExtensionElement separately, with no common supertype carrying them.
    void walkMembers({
      required List<FieldElement> fields,
      required List<GetterElement> getters,
      required List<SetterElement> setters,
      required List<MethodElement> methods,
    }) {
      for (final field in fields) {
        if (field.isSynthetic || !_isPublic(field.name)) continue;
        surface.membersWalked++;
        check('$owner.${field.name}', field.type);
      }
      for (final getter in getters) {
        if (getter.isSynthetic || !_isPublic(getter.name)) continue;
        surface.membersWalked++;
        check('$owner.${getter.name}', getter.returnType);
      }
      for (final setter in setters) {
        if (setter.isSynthetic || !_isPublic(setter.name)) continue;
        surface.membersWalked++;
        for (final parameter in setter.formalParameters) {
          check('$owner.${setter.name}=', parameter.type);
        }
      }
      for (final method in methods) {
        if (!_isPublic(method.name)) continue;
        walkExecutable(
          '.${method.name}()',
          method.returnType,
          method.formalParameters,
        );
      }
    }

    switch (element) {
      case InterfaceElement():
        walkMembers(
          fields: element.fields,
          getters: element.getters,
          setters: element.setters,
          methods: element.methods,
        );
        for (final constructor in element.constructors) {
          if (constructor.isSynthetic || !_isPublic(constructor.name)) continue;
          surface.membersWalked++;
          for (final parameter in constructor.formalParameters) {
            check(
              '$owner.${constructor.name}(${parameter.name})',
              parameter.type,
            );
          }
        }
        for (final typeParameter in element.typeParameters) {
          check('$owner<${typeParameter.name}>', typeParameter.bound);
        }
      case ExtensionElement():
        surface.membersWalked++;
        check('$owner (extended type)', element.extendedType);
        walkMembers(
          fields: element.fields,
          getters: element.getters,
          setters: element.setters,
          methods: element.methods,
        );
      case TypeAliasElement():
        surface.membersWalked++;
        check('$owner (aliased type)', element.aliasedType);
      case TopLevelFunctionElement():
        walkExecutable('()', element.returnType, element.formalParameters);
      case GetterElement():
        surface.membersWalked++;
        check(owner, element.returnType);
      case SetterElement():
        surface.membersWalked++;
        for (final parameter in element.formalParameters) {
          check('$owner=', parameter.type);
        }
      case TopLevelVariableElement():
        surface.membersWalked++;
        check(owner, element.type);
      default:
        surface.unhandled.add('$owner -> ${element.runtimeType}');
    }
  }

  return surface;
}

void main() {
  // SCD158: the paths below are built relative to the package this runs in, so
  // a copy elsewhere would resolve a different set of barrels in silence.
  requirePackage('tom_d4rt', subject: "both interpreter lines' public barrels");

  late List<_Surface> surfaces;

  setUpAll(() async {
    // `parent`, not a join with `..` — the analyzer rejects an included path
    // carrying a `..` segment even when it resolves to a real file.
    final repoRoot = Directory.current.parent.path;
    surfaces = [
      for (final (package, relative) in _barrels)
        await _measure('$repoRoot/$package/$relative', '$package/$relative'),
    ];
  });

  group('SCE156: public member types are nameable through the same barrel', () {
    test('F-SCE156-1: no public signature mentions a type the barrel does not '
        'export', () {
      final report = <String>[];
      for (final surface in surfaces) {
        for (final entry in surface.findings.entries) {
          final parts = entry.key.split('|');
          report.add(
            '${surface.label}: `${parts[1]}` (from package:${parts[0]}) is '
            'reachable but not exported — ${entry.value.take(4).join(', ')}',
          );
        }
      }
      expect(
        report,
        isEmpty,
        reason:
            'a consumer receives one of these values and cannot write its name '
            'without an implementation import. Export it from the barrel, or — '
            'if it is genuinely not part of the surface — stop returning it '
            'from a public member:\n  ${report.join('\n  ')}',
      );
    });

    test('F-SCE156-2 (control): the walk reached a real surface and understood '
        'all of it', () {
      for (final surface in surfaces) {
        expect(
          surface.exportedNames,
          greaterThanOrEqualTo(_minExportedNames),
          reason:
              '${surface.label} resolved but exported almost nothing, so '
              'F-SCE156-1 passed by iterating an empty namespace',
        );
        expect(
          surface.membersWalked,
          greaterThanOrEqualTo(_minMembersWalked),
          reason:
              '${surface.label} exported names but no members were walked, '
              'which is the other way F-SCE156-1 passes over nothing',
        );
        expect(
          surface.unhandled,
          isEmpty,
          reason:
              '${surface.label} holds namespace entries of a kind this walk '
              'does not handle, so part of its surface went unchecked '
              'silently. Add the case rather than accepting the gap:\n  '
              '${surface.unhandled.join('\n  ')}',
        );
      }
    });

    test('F-SCE156-3: the analyzer exemption is load-bearing here and inert on '
        'the analyzer-free line', () {
      final reference = surfaces.firstWhere(
        (s) => s.label == 'tom_d4rt/lib/d4rt.dart',
      );
      expect(
        reference.exempted,
        greaterThan(20),
        reason:
            'the exemption absorbed ${reference.exempted} names on the '
            'reference line. It exists because that line\'s public surface IS '
            'the analyzer AST; if it has stopped catching anything, the '
            'exemption is dead and belongs deleted, not kept as a permanently '
            'true exception nobody can evaluate',
      );

      for (final surface in surfaces) {
        if (identical(surface, reference)) continue;
        expect(
          surface.exempted,
          0,
          reason:
              '${surface.label} reaches ${surface.exempted} analyzer '
              'type(s) through its public API. That line is analyzer-free by '
              'design and its zero-dependency claim is what makes Flutter and '
              'web use possible — this is a larger finding than a missing '
              'export',
        );
      }
    });
  });
}
