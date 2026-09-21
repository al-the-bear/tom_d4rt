// SCE76: the defect class no mirror-based audit can see.
//
// `dart:mirrors` ERASES the type parameters of a generic function type. For
//
//     Set.castFrom<S, T>(Set<S> source, {Set<R> Function<R>()? newSet})
//
// the parameter's `FunctionTypeMirror` reports `simpleName` as
// `() -> dart.core.Set` and `typeVariables.length == 0` — indistinguishable
// from an ordinary `Set Function()` callback. Measured on SDK 3.12.2.
//
// WHY THAT MATTERS. SCD37 established that a generic-function parameter is a
// shape the bridge CANNOT honour: the callee instantiates it at a type the
// caller never writes, and the callable model has no path for a caller-side
// type instantiation. Such a member must REJECT the argument rather than
// accept and ignore it, because a silent drop returns the wrong concrete
// implementation and the script misbehaves far from the call.
//
// SO THE CLASS HAD NO INSTRUMENT. SCD36 built `--returns` and a static
// parameter pass into `tool/stdlib_member_diff.dart`, and neither can see this
// one: the parameter pass reads types through mirrors, so a generic-function
// parameter looks like an ordinary callback and passes. The first attempt
// during SCD37 was exactly that mirror sweep, filtered on
// `FunctionTypeMirror.typeVariables`. It returned ZERO across the whole corpus
// and would have "confirmed" there was nothing to look at.
//
// WHY THIS READS THE SDK SOURCES, AND WITH A PARSER RATHER THAN A GREP. The
// information mirrors destroys still exists in the source text, so the source
// is the only oracle available. SCD37 used a grep, and the grep needs a
// word-boundary guard to stay honest — without it `_ZoneFunction<RunHandler>(`
// matches, giving 34 hits of which 33 are a class name that happens to end in
// `Function`. Even guarded it still reports 8, of which one is a line inside a
// `///` comment in `core/function.dart` and six are `typedef` declarations for
// the `dart:async` zone handlers.
//
// Parsing excludes all seven STRUCTURALLY rather than by luck: a comment is
// not a parameter, and a typedef is not a member. That is the difference
// between a check that happens to be right today and one that stays right, and
// it is also what lets the finding be reported as the `(class, member,
// parameter)` triple a reader can act on rather than as a file and a line.

import 'dart:io';

import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:test/test.dart';

/// The bridged surface, and only it.
///
/// Sweeping all of `lib/` finds generic-function parameters in libraries d4rt
/// does not bridge — `dart:ffi`, and `dart:async`'s zone internals — which are
/// not defects and would make the register below a maintenance tax with no
/// reader. These six directories are what the stdlib bridges cover.
const _bridgedLibraries = <String>[
  'core',
  'collection',
  'convert',
  'async',
  'typed_data',
  'io',
];

/// Every generic-function parameter on a bridged member, and why it is
/// unsupported.
///
/// A NEW ENTRY IS NOT A ROUTINE ADDITION. It means an SDK upgrade gave a
/// bridged member a parameter the callable model cannot honour, and the member
/// must be made to reject it — SCD37 is the worked example, in
/// `lib/src/stdlib/core/set.dart` and `test/stdlib/cast_from_family_test.dart`.
/// Adding the entry without the rejection records the defect instead of fixing
/// it.
const _known = <String, String>{
  'Set.castFrom(newSet)':
      'The callee instantiates `newSet` at `R`, a type the caller never '
      'writes, and the callable model has no caller-side instantiation. SCD37 '
      'made the bridge reject it with a diagnostic that names the argument, '
      'rather than accept and ignore it: a dropped `newSet` returns a view '
      'over a LinkedHashSet where the script asked for something else, and '
      'every value comparison still passes.',
};

/// `<Class>.<member>(<parameter>)` for each generic-function parameter.
class _Census extends RecursiveAstVisitor<void> {
  _Census(this.found, this.ordinaryCallbacks);

  final Set<String> found;

  /// Ordinary function-typed parameters — `bool Function(E)` and friends —
  /// which the bridge handles fine. Counted so F-SCE76-3 can show that the
  /// filter DISCRIMINATES rather than simply matching almost nothing.
  final List<String> ordinaryCallbacks;

  String? _class;

  @override
  void visitClassDeclaration(ClassDeclaration node) {
    _class = node.name.lexeme;
    super.visitClassDeclaration(node);
    _class = null;
  }

  @override
  void visitExtensionDeclaration(ExtensionDeclaration node) {
    _class = node.name?.lexeme ?? '<extension>';
    super.visitExtensionDeclaration(node);
    _class = null;
  }

  @override
  void visitMethodDeclaration(MethodDeclaration node) =>
      _scan(node.parameters, node.name.lexeme);

  @override
  void visitConstructorDeclaration(ConstructorDeclaration node) =>
      _scan(node.parameters, node.name?.lexeme ?? '<new>');

  @override
  void visitFunctionDeclaration(FunctionDeclaration node) =>
      _scan(node.functionExpression.parameters, node.name.lexeme);

  void _scan(FormalParameterList? params, String member) {
    if (params == null) return;
    for (final p in params.parameters) {
      final inner = p is DefaultFormalParameter ? p.parameter : p;
      if (inner is! SimpleFormalParameter) continue;
      final type = inner.type;
      // The discriminator, and the whole point of the file: a `GenericFunction
      // Type` with type parameters of its own. `Set Function()` is the same
      // node with `typeParameters == null`, and is an ordinary callback the
      // bridge handles fine.
      if (type is! GenericFunctionType) continue;
      final owner = _class;
      if (owner == null) continue; // a top-level function, not a bridged member
      final label = '$owner.$member(${inner.name?.lexeme ?? '?'})';
      if (type.typeParameters?.typeParameters.isEmpty ?? true) {
        ordinaryCallbacks.add(label);
        continue;
      }
      found.add(label);
    }
  }
}

/// The SDK's `lib/`, derived from the running VM rather than from `which dart`.
///
/// This workspace runs Dart from the Flutter bundle
/// (`<flutter>/bin/cache/dart-sdk`), so a hardcoded path or a PATH lookup is
/// wrong on some fleet host. `Platform.resolvedExecutable` is the VM actually
/// executing this test, so the sources it names are the sources it was built
/// from.
Directory? _sdkLib() {
  final lib = Directory(
    Uri.file(Platform.resolvedExecutable).resolve('../lib/').toFilePath(),
  );
  return lib.existsSync() ? lib : null;
}

void main() {
  group('SCE76: generic-function parameters on bridged members', () {
    final sdk = _sdkLib();

    test('F-SCE76-1: the census equals the recorded set [2026-09-21] '
        '(PASS)', () {
      final found = <String>{};
      final ordinary = <String>[];
      var filesRead = 0;
      for (final dir in _bridgedLibraries) {
        final d = Directory('${sdk!.path}$dir');
        if (!d.existsSync()) continue;
        for (final f in d.listSync(recursive: true).whereType<File>()) {
          if (!f.path.endsWith('.dart')) continue;
          filesRead++;
          final unit = parseString(
            content: f.readAsStringSync(),
            featureSet: FeatureSet.latestLanguageVersion(),
            throwIfDiagnostics: false,
          ).unit;
          unit.accept(_Census(found, ordinary));
        }
      }

      // NON-VACUITY, asserted before the comparison. A resolvable path that
      // reads nothing, or a parser that silently fails on every file, would
      // otherwise give an empty census and a green run — which is the exact
      // shape of the mirror sweep this file exists to replace.
      // Measured 2026-09-21 on SDK 3.12.2: 113 files read, 115 ordinary
      // callback parameters, 1 generic-function parameter. The thresholds sit
      // well below those so an SDK reshuffle moves the counts without turning
      // this red — they exist to catch a sweep that read NOTHING, not to pin a
      // count.
      expect(
        filesRead,
        greaterThan(40),
        reason: 'the sweep read almost nothing, so its emptiness means nothing',
      );

      // F-SCE76-3, asserted here so it shares the one expensive sweep. The
      // filter turns on a single nullable field, and getting it backwards
      // would report EVERY callback parameter — hundreds of them — or none.
      // A census of one is only meaningful beside the population it was drawn
      // from, so the population is measured too.
      expect(
        ordinary.length,
        greaterThan(40),
        reason:
            'the same sweep found almost no ORDINARY callback parameters, so '
            'the filter is not discriminating between the two shapes — it is '
            'matching almost nothing, and a census of one proves nothing',
      );

      expect(
        found,
        equals(_known.keys.toSet()),
        reason:
            'A member here takes a parameter the callable model cannot honour. '
            'It must REJECT the argument with a diagnostic that names it — '
            'SCD37 in `lib/src/stdlib/core/set.dart` is the worked example — '
            'and then be recorded in `_known` with the reason. Pin the '
            'rejection with a THROW assertion: a bridge that accepts and '
            'ignores the argument passes every value comparison that can be '
            'written about it.',
      );
    }, skip: sdk == null ? _noSdkReason : null);

    test('F-SCE76-2: every recorded entry carries a reason [2026-09-21] '
        '(PASS)', () {
      // A register whose entries say only "unsupported" is a list of names
      // nobody can act on. The reason is what tells the next reader whether
      // the entry is still true.
      final thin = _known.entries
          .where((e) => e.value.trim().length < 80)
          .map((e) => e.key)
          .toList();
      expect(thin, isEmpty, reason: 'entries with no usable reason: $thin');
    });
  });
}

/// Stated rather than silent, because an unresolvable path that passes is the
/// vacuity failure SCD36 spent its budget on. The MECHANISM: this case reads
/// the SDK's own `lib/` sources, and a Dart distribution that ships without
/// them (a stripped container image) makes the property unobservable here
/// rather than false. Evidence it is normally present: derived from
/// `Platform.resolvedExecutable`, which on this fleet resolves to
/// `<flutter>/bin/cache/dart-sdk/bin/dart` and whose sibling `lib/` exists.
const String _noSdkReason =
    'the SDK sources are not on disk beside the running VM, so the census has '
    'nothing to read — the property is unobservable here, not false';
