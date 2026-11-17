/// ghissues70 (GitHub #18, option B2): the static facts of a resolved bundle,
/// indexed by the AST node each is about, and the stamp check that decides
/// whether a run uses them.
library;

import 'package:tom_d4rt_ast/ast.dart';
import 'package:tom_d4rt_ast/src/runtime/ast_bundle.dart';
import 'package:tom_d4rt_ast/src/runtime/exceptions.dart';
import 'package:tom_d4rt_ast/src/runtime/runtime_interfaces.dart';

/// A fact with the table its type indices refer to.
typedef StaticFactEntry = ({SStaticFact fact, SStaticFacts table});

/// Node -> fact for the bundles whose facts are in use.
///
/// A bundle's facts are keyed by module URI and node `offset:length`; the
/// interpreter has the node, not its module. So [install] walks each module
/// once and attaches each node's fact to the node itself (an [Expando]: the
/// facts go when the nodes go). A run of a bundle whose stamp does not agree
/// with the host [uninstall]s them, so nothing it reads differs from a
/// bundle without facts.
abstract final class StaticFactsIndex {
  static final Expando<StaticFactEntry> _byNode = Expando('staticFact');

  /// Per bundle: whether its facts are attached to its nodes now.
  static final Expando<bool> _installed = Expando('staticFactsInstalled');

  /// The fact recorded for [node], or null.
  static StaticFactEntry? of(SAstNode node) => _byNode[node];

  /// Attaches [bundle]'s facts to its nodes (once per bundle).
  static void install(AstBundle bundle) {
    final facts = bundle.facts;
    if (facts == null || _installed[bundle] == true) return;
    _walk(bundle, facts, attach: true);
    _installed[bundle] = true;
  }

  /// Detaches [bundle]'s facts from its nodes, if they were attached.
  static void uninstall(AstBundle bundle) {
    final facts = bundle.facts;
    if (facts == null || _installed[bundle] != true) return;
    _walk(bundle, facts, attach: false);
    _installed[bundle] = false;
  }

  static void _walk(
    AstBundle bundle,
    SStaticFacts facts, {
    required bool attach,
  }) {
    for (final MapEntry(key: uri, value: unit) in bundle.modules.entries) {
      if (facts.modules[uri]?.isNotEmpty != true) continue;
      unit.accept(_Attach(uri, facts, attach));
    }
  }
}

class _Attach extends SAstVisitor<void> {
  final String _module;
  final SStaticFacts _facts;
  final bool _attach;

  _Attach(this._module, this._facts, this._attach);

  @override
  void visitNode(SAstNode node) {
    final fact = _facts.factAt(_module, node.offset, node.length);
    if (fact != null) {
      StaticFactsIndex._byNode[node] = _attach
          ? (fact: fact, table: _facts)
          : null;
    }
    node.visitChildren(this);
  }
}

/// The types [indices] name in [table], each resolved by its name through
/// [lookup] (the current scope's `Environment.get`); null when one cannot be
/// named there - the interpreter then approximates as without facts.
List<RuntimeType>? staticFactTypes(
  List<int> indices,
  SStaticFacts table,
  Object? Function(String name) lookup,
) {
  final types = <RuntimeType>[];
  for (final index in indices) {
    final type = _staticFactType(table, index, lookup);
    if (type == null) return null;
    types.add(type);
  }
  return types;
}

RuntimeType? _staticFactType(
  SStaticFacts table,
  int index,
  Object? Function(String name) lookup,
) {
  final type = table.type(index);
  RuntimeType base;
  switch (type.kind) {
    case SFactTypeKind.dynamicType:
      return const NamedRuntimeType('dynamic');
    case SFactTypeKind.interface || SFactTypeKind.typeParameter:
      final name = type.name;
      if (name == null) return null;
      try {
        final resolved = lookup(name);
        if (resolved is! RuntimeType) return null;
        base = resolved;
      } on RuntimeD4rtException {
        return null;
      }
    default:
      // void, Never, function and record types: not named in a scope.
      return null;
  }
  if (type.typeArguments.isNotEmpty) {
    final arguments = staticFactTypes(type.typeArguments, table, lookup);
    if (arguments == null) return null;
    base = AppliedRuntimeType(base, arguments);
  }
  return type.nullable ? NullableRuntimeType(base) : base;
}

/// The stamp check of `doc/resolved_bundles.md`: the facts describe the
/// program as the analyzer saw it, and a run uses them only where the host
/// agrees.
///
/// * every stamped package the host declares a bridge version for
///   ([bridgedPackageVersions]) must have exactly that version;
/// * the stamp's Dart SDK `major.minor` must equal [hostSdkVersion]'s, when
///   the host can tell it (null on the web);
/// * what the host cannot tell is not compared.
///
/// Returns null when they agree, else the mismatch, naming both versions.
String? staticFactsStampMismatch(
  SFactsStamp stamp, {
  required Map<String, String> bridgedPackageVersions,
  required String? hostSdkVersion,
}) {
  final problems = <String>[];
  for (final MapEntry(key: package, value: version) in stamp.packages.entries) {
    final bridged = bridgedPackageVersions[package];
    if (bridged != null && bridged != version) {
      problems.add(
        'package $package: bundled against $version, bridged $bridged',
      );
    }
  }
  final bundled = _majorMinor(stamp.sdkVersion);
  final host = hostSdkVersion == null ? null : _majorMinor(hostSdkVersion);
  if (bundled != null && host != null && bundled != host) {
    problems.add(
      'Dart SDK: bundled against ${_first(stamp.sdkVersion)}, '
      'running on ${_first(hostSdkVersion!)}',
    );
  }
  return problems.isEmpty ? null : problems.join('; ');
}

String? _majorMinor(String version) =>
    RegExp(r'^(\d+)\.(\d+)').firstMatch(version.trim())?.group(0);

String _first(String version) => version.trim().split(' ').first;
