/// The static facts of a bundle: what the analyzer knew about chosen nodes
/// when a resolving bundler built it (GitHub al-the-bear/tom_d4rt#18,
/// option 3).
///
/// The mirror AST is an unresolved copy of the analyzer's AST (its node
/// classes stay one-to-one, SCE235), so an interpreter reading it works out at
/// run time what Dart decides statically. Where that is an approximation, a
/// resolving bundler can record the analyzer's answer here, beside the nodes,
/// and a runtime uses it when present:
///
/// * [SExtensionCallFact] - the static type of the receiver of an extension
///   member access (method, getter, setter, operator, index), the extension
///   it resolves to and that extension's type arguments;
/// * [STypeArgumentsFact] - the inferred type arguments of a generic call, an
///   instance creation or a collection literal that does not write them.
///
/// Facts are keyed by module URI and the node's `offset:length` in that
/// module ([SStaticFacts.factAt]). Types are [SFactType]s, interned in one
/// table per bundle ([SStaticFacts.types]) and referred to by index. A type
/// the bundler could not name gets no fact.
///
/// The table is optional and additive: a bundle without it, and a reader that
/// does not know it, behave as before. [SFactsStamp] records what the facts
/// were computed against, so a runtime can decline facts that may not match
/// its bridges.
library;

/// What a facts table was computed against: the Dart SDK and the versions of
/// the packages its types come from.
///
/// A runtime compares it with what it bridges (doc/resolved_bundles.md in
/// tom_ast_generator): for every [packages] entry the runtime bridges, the
/// version its bridges were generated from must equal the stamp's, and, where
/// the host can tell, the Dart SDK's `<major>.<minor>` must equal
/// [sdkVersion]'s. A mismatch makes the runtime ignore the facts and
/// approximate as without them. A package the bundle carries as source is
/// consistent with its facts by construction and is not compared.
class SFactsStamp {
  /// The Dart SDK version the facts were computed with, e.g. `3.13.7`.
  final String sdkVersion;

  /// Package name -> version, for the packages the facts' types come from
  /// whose version the bundler knew (`dart:` libraries are covered by
  /// [sdkVersion]).
  final Map<String, String> packages;

  const SFactsStamp({required this.sdkVersion, this.packages = const {}});

  Map<String, dynamic> toJson() => {
    'sdk': sdkVersion,
    if (packages.isNotEmpty) 'packages': packages,
  };

  factory SFactsStamp.fromJson(Map<String, dynamic> json) => SFactsStamp(
    sdkVersion: json['sdk'] as String? ?? '',
    packages: {
      for (final MapEntry(:key, :value)
          in ((json['packages'] as Map<String, dynamic>?) ?? const {}).entries)
        key: '$value',
    },
  );

  @override
  bool operator ==(Object other) =>
      other is SFactsStamp &&
      other.sdkVersion == sdkVersion &&
      _mapEquals(other.packages, packages);

  @override
  int get hashCode => Object.hash(
    sdkVersion,
    Object.hashAllUnordered(packages.entries.map((e) => '${e.key}=${e.value}')),
  );

  @override
  String toString() => 'SFactsStamp($sdkVersion, $packages)';
}

/// The kind of an [SFactType].
enum SFactTypeKind {
  /// A class, mixin, enum or extension type: [SFactType.libraryUri] and
  /// [SFactType.name] name it, [SFactType.typeArguments] are its arguments.
  interface('i'),

  /// A type parameter, by [SFactType.name].
  typeParameter('p'),

  /// A function type; [SFactType.display] spells it.
  function('f'),

  /// A record type; [SFactType.display] spells it.
  record('r'),

  /// `dynamic`.
  dynamicType('d'),

  /// `void`.
  voidType('v'),

  /// `Never`.
  neverType('n');

  /// The kind's tag in JSON.
  final String tag;

  const SFactTypeKind(this.tag);

  static SFactTypeKind fromTag(String tag) => values.firstWhere(
    (k) => k.tag == tag,
    orElse: () => throw FormatException('Unknown fact type kind "$tag"'),
  );
}

/// A type in a facts table: a structured reference the runtime resolves to
/// its own runtime type (by library URI and name), interned in
/// [SStaticFacts.types].
class SFactType {
  final SFactTypeKind kind;

  /// For [SFactTypeKind.interface]: the declaring library, e.g. `dart:core`
  /// or `package:p/model.dart`.
  final String? libraryUri;

  /// The class or type parameter name, e.g. `Map` or `T`.
  final String? name;

  /// For [SFactTypeKind.interface]: the type arguments, as indices into
  /// [SStaticFacts.types].
  final List<int> typeArguments;

  /// Whether the type is written with `?`.
  final bool nullable;

  /// For a function or record type: the type as Dart spells it.
  final String? display;

  const SFactType({
    required this.kind,
    this.libraryUri,
    this.name,
    this.typeArguments = const [],
    this.nullable = false,
    this.display,
  });

  Map<String, dynamic> toJson() => {
    'k': kind.tag,
    if (libraryUri != null) 'u': libraryUri,
    if (name != null) 'n': name,
    if (typeArguments.isNotEmpty) 'a': typeArguments,
    if (nullable) 'q': true,
    if (display != null) 's': display,
  };

  factory SFactType.fromJson(Map<String, dynamic> json) => SFactType(
    kind: SFactTypeKind.fromTag(json['k'] as String),
    libraryUri: json['u'] as String?,
    name: json['n'] as String?,
    typeArguments: [for (final a in (json['a'] as List?) ?? const []) a as int],
    nullable: json['q'] == true,
    display: json['s'] as String?,
  );

  @override
  bool operator ==(Object other) =>
      other is SFactType &&
      other.kind == kind &&
      other.libraryUri == libraryUri &&
      other.name == name &&
      _listEquals(other.typeArguments, typeArguments) &&
      other.nullable == nullable &&
      other.display == display;

  @override
  int get hashCode => Object.hash(
    kind,
    libraryUri,
    name,
    Object.hashAll(typeArguments),
    nullable,
    display,
  );

  @override
  String toString() => 'SFactType(${toJson()})';
}

/// One fact about one node.
sealed class SStaticFact {
  const SStaticFact();

  Map<String, dynamic> toJson();

  factory SStaticFact.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('x')) return SExtensionCallFact.fromJson(json);
    if (json.containsKey('t')) return STypeArgumentsFact.fromJson(json);
    throw FormatException('Unknown static fact: $json');
  }
}

/// An extension member access: the receiver's static type, the extension it
/// resolves to and the extension's type arguments (all type references are
/// indices into [SStaticFacts.types]).
class SExtensionCallFact extends SStaticFact {
  /// The receiver's static type.
  final int receiverType;

  /// The library declaring the extension.
  final String extensionLibraryUri;

  /// The extension's name; `null` for an unnamed extension.
  final String? extensionName;

  /// The extension's type arguments, one per type parameter.
  final List<int> typeArguments;

  const SExtensionCallFact({
    required this.receiverType,
    required this.extensionLibraryUri,
    this.extensionName,
    this.typeArguments = const [],
  });

  @override
  Map<String, dynamic> toJson() => {
    'x': [
      receiverType,
      extensionLibraryUri,
      extensionName,
      if (typeArguments.isNotEmpty) typeArguments,
    ],
  };

  factory SExtensionCallFact.fromJson(Map<String, dynamic> json) {
    final parts = json['x'] as List;
    return SExtensionCallFact(
      receiverType: parts[0] as int,
      extensionLibraryUri: parts[1] as String,
      extensionName: parts[2] as String?,
      typeArguments: parts.length > 3
          ? [for (final a in parts[3] as List) a as int]
          : const [],
    );
  }

  @override
  bool operator ==(Object other) =>
      other is SExtensionCallFact &&
      other.receiverType == receiverType &&
      other.extensionLibraryUri == extensionLibraryUri &&
      other.extensionName == extensionName &&
      _listEquals(other.typeArguments, typeArguments);

  @override
  int get hashCode => Object.hash(
    receiverType,
    extensionLibraryUri,
    extensionName,
    Object.hashAll(typeArguments),
  );

  @override
  String toString() => 'SExtensionCallFact(${toJson()})';
}

/// The inferred type arguments of a generic call, an instance creation or a
/// collection literal that does not write them (indices into
/// [SStaticFacts.types]).
class STypeArgumentsFact extends SStaticFact {
  final List<int> typeArguments;

  const STypeArgumentsFact(this.typeArguments);

  @override
  Map<String, dynamic> toJson() => {'t': typeArguments};

  factory STypeArgumentsFact.fromJson(Map<String, dynamic> json) =>
      STypeArgumentsFact([for (final a in json['t'] as List) a as int]);

  @override
  bool operator ==(Object other) =>
      other is STypeArgumentsFact &&
      _listEquals(other.typeArguments, typeArguments);

  @override
  int get hashCode => Object.hashAll(typeArguments);

  @override
  String toString() => 'STypeArgumentsFact($typeArguments)';
}

/// A bundle's facts table. See the library comment.
class SStaticFacts {
  /// The table's own format: the reader reads only this one and ignores a
  /// table of another (a bundle then runs as without facts). Bumped only for
  /// a change a reader of the old one would misread.
  static const int format = 1;

  /// What the facts were computed against.
  final SFactsStamp stamp;

  /// The interned types; facts refer to them by index.
  final List<SFactType> types;

  /// Module URI -> `offset:length` of the node -> its fact.
  final Map<String, Map<String, SStaticFact>> modules;

  const SStaticFacts({
    required this.stamp,
    this.types = const [],
    this.modules = const {},
  });

  /// The key of a node at [offset] with [length] in [modules].
  static String key(int offset, int length) => '$offset:$length';

  /// The fact recorded for the node at [offset] / [length] of [moduleUri],
  /// or null.
  SStaticFact? factAt(String moduleUri, int offset, int length) =>
      modules[moduleUri]?[key(offset, length)];

  /// The type [index] refers to.
  SFactType type(int index) => types[index];

  /// How many facts the table holds.
  int get factCount =>
      modules.values.fold(0, (sum, facts) => sum + facts.length);

  Map<String, dynamic> toJson() => {
    'format': format,
    'stamp': stamp.toJson(),
    'types': [for (final t in types) t.toJson()],
    'modules': {
      for (final MapEntry(key: uri, value: facts) in modules.entries)
        uri: {
          for (final MapEntry(:key, :value) in facts.entries)
            key: value.toJson(),
        },
    },
  };

  /// Reads a table written by [toJson]. A table of another [format] reads as
  /// null: facts are optional, and one this reader may misread is not used.
  static SStaticFacts? fromJson(Map<String, dynamic> json) {
    if (json['format'] != format) return null;
    return SStaticFacts(
      stamp: SFactsStamp.fromJson(json['stamp'] as Map<String, dynamic>),
      types: [
        for (final t in json['types'] as List)
          SFactType.fromJson(t as Map<String, dynamic>),
      ],
      modules: {
        for (final MapEntry(key: uri, value: facts)
            in (json['modules'] as Map<String, dynamic>).entries)
          uri: {
            for (final MapEntry(:key, :value)
                in (facts as Map<String, dynamic>).entries)
              key: SStaticFact.fromJson(value as Map<String, dynamic>),
          },
      },
    );
  }
}

/// Builds an [SStaticFacts] table, interning its types.
class SStaticFactsBuilder {
  final List<SFactType> _types = [];
  final Map<SFactType, int> _index = {};
  final Map<String, Map<String, SStaticFact>> _modules = {};

  /// The index of [type] in the table, adding it once.
  int intern(SFactType type) =>
      _index.putIfAbsent(type, () => (_types..add(type)).length - 1);

  /// Records [fact] for the node at [offset] / [length] of [moduleUri].
  void add(String moduleUri, int offset, int length, SStaticFact fact) {
    (_modules[moduleUri] ??= {})[SStaticFacts.key(offset, length)] = fact;
  }

  /// Whether no fact was added.
  bool get isEmpty => _modules.isEmpty;

  /// The table, stamped with [stamp].
  SStaticFacts build(SFactsStamp stamp) => SStaticFacts(
    stamp: stamp,
    types: List.unmodifiable(_types),
    modules: {
      for (final MapEntry(:key, :value) in _modules.entries)
        key: Map.unmodifiable(value),
    },
  );
}

bool _listEquals(List<int> a, List<int> b) {
  if (a.length != b.length) return false;
  for (var i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

bool _mapEquals(Map<String, String> a, Map<String, String> b) =>
    a.length == b.length && a.entries.every((e) => b[e.key] == e.value);
