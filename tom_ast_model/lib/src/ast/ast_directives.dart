// Serializable AST directives
// ignore_for_file: constant_identifier_names

part of 'ast_core.dart';

// ============================================================================
// Import Directive
// ============================================================================

class SImportDirective extends SNamespaceDirective {
  @override
  final int offset;
  @override
  final int length;

  @override
  final List<SAnnotation> metadata;
  final SStringLiteral? uri;
  final SSimpleIdentifier? prefix;
  final List<SConfiguration> configurations;
  final List<SCombinator> combinators;
  final bool isDeferred;

  SImportDirective({
    required this.offset,
    required this.length,
    this.metadata = const [],
    this.uri,
    this.prefix,
    this.configurations = const [],
    this.combinators = const [],
    this.isDeferred = false,
  });

  @override
  String get nodeType => 'ImportDirective';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'metadata': metadata.map((a) => a.toJson()).toList(),
    if (uri != null) 'uri': uri!.toJson(),
    if (prefix != null) 'prefix': prefix!.toJson(),
    'configurations': configurations.map((c) => c.toJson()).toList(),
    'combinators': combinators.map((c) => c.toJson()).toList(),
    'isDeferred': isDeferred,
  };

  factory SImportDirective.fromJson(Map<String, dynamic> json) {
    return SImportDirective(
      offset: json['offset'] as int,
      length: json['length'] as int,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      uri:
          SAstNodeFactory.fromJson(json['uri'] as Map<String, dynamic>?)
              as SStringLiteral?,
      prefix: json['prefix'] != null
          ? SSimpleIdentifier.fromJson(json['prefix'] as Map<String, dynamic>)
          : null,
      configurations: SAstNodeFactory.listFromJson<SConfiguration>(
        json['configurations'] as List?,
      ),
      combinators: SAstNodeFactory.listFromJson<SCombinator>(
        json['combinators'] as List?,
      ),
      isDeferred: json['isDeferred'] as bool? ?? false,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitImportDirective(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in metadata) {
      child.accept(visitor);
    }
    uri?.accept(visitor);
    prefix?.accept(visitor);
    for (final child in configurations) {
      child.accept(visitor);
    }
    for (final child in combinators) {
      child.accept(visitor);
    }
  }
}

// ============================================================================
// Export Directive
// ============================================================================

class SExportDirective extends SNamespaceDirective {
  @override
  final int offset;
  @override
  final int length;

  @override
  final List<SAnnotation> metadata;
  final SStringLiteral? uri;
  final List<SConfiguration> configurations;
  final List<SCombinator> combinators;

  SExportDirective({
    required this.offset,
    required this.length,
    this.metadata = const [],
    this.uri,
    this.configurations = const [],
    this.combinators = const [],
  });

  @override
  String get nodeType => 'ExportDirective';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'metadata': metadata.map((a) => a.toJson()).toList(),
    if (uri != null) 'uri': uri!.toJson(),
    'configurations': configurations.map((c) => c.toJson()).toList(),
    'combinators': combinators.map((c) => c.toJson()).toList(),
  };

  factory SExportDirective.fromJson(Map<String, dynamic> json) {
    return SExportDirective(
      offset: json['offset'] as int,
      length: json['length'] as int,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      uri:
          SAstNodeFactory.fromJson(json['uri'] as Map<String, dynamic>?)
              as SStringLiteral?,
      configurations: SAstNodeFactory.listFromJson<SConfiguration>(
        json['configurations'] as List?,
      ),
      combinators: SAstNodeFactory.listFromJson<SCombinator>(
        json['combinators'] as List?,
      ),
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitExportDirective(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in metadata) {
      child.accept(visitor);
    }
    uri?.accept(visitor);
    for (final child in configurations) {
      child.accept(visitor);
    }
    for (final child in combinators) {
      child.accept(visitor);
    }
  }
}

// ============================================================================
// Part Directives
// ============================================================================

class SPartDirective extends SUriBasedDirective {
  @override
  final int offset;
  @override
  final int length;

  @override
  final List<SAnnotation> metadata;
  final SStringLiteral? uri;

  SPartDirective({
    required this.offset,
    required this.length,
    this.metadata = const [],
    this.uri,
  });

  @override
  String get nodeType => 'PartDirective';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'metadata': metadata.map((a) => a.toJson()).toList(),
    if (uri != null) 'uri': uri!.toJson(),
  };

  factory SPartDirective.fromJson(Map<String, dynamic> json) {
    return SPartDirective(
      offset: json['offset'] as int,
      length: json['length'] as int,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      uri:
          SAstNodeFactory.fromJson(json['uri'] as Map<String, dynamic>?)
              as SStringLiteral?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitPartDirective(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in metadata) {
      child.accept(visitor);
    }
    uri?.accept(visitor);
  }
}

class SPartOfDirective extends SDirective {
  @override
  final int offset;
  @override
  final int length;

  @override
  final List<SAnnotation> metadata;
  final SStringLiteral? uri;
  final SIdentifier? libraryName;

  SPartOfDirective({
    required this.offset,
    required this.length,
    this.metadata = const [],
    this.uri,
    this.libraryName,
  });

  @override
  String get nodeType => 'PartOfDirective';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'metadata': metadata.map((a) => a.toJson()).toList(),
    if (uri != null) 'uri': uri!.toJson(),
    if (libraryName != null) 'libraryName': libraryName!.toJson(),
  };

  factory SPartOfDirective.fromJson(Map<String, dynamic> json) {
    return SPartOfDirective(
      offset: json['offset'] as int,
      length: json['length'] as int,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      uri:
          SAstNodeFactory.fromJson(json['uri'] as Map<String, dynamic>?)
              as SStringLiteral?,
      libraryName:
          SAstNodeFactory.fromJson(json['libraryName'] as Map<String, dynamic>?)
              as SIdentifier?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitPartOfDirective(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in metadata) {
      child.accept(visitor);
    }
    uri?.accept(visitor);
    libraryName?.accept(visitor);
  }
}

// ============================================================================
// Library Directive
// ============================================================================

class SLibraryDirective extends SDirective {
  @override
  final int offset;
  @override
  final int length;

  @override
  final List<SAnnotation> metadata;
  final SIdentifier? name;

  SLibraryDirective({
    required this.offset,
    required this.length,
    this.metadata = const [],
    this.name,
  });

  @override
  String get nodeType => 'LibraryDirective';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'metadata': metadata.map((a) => a.toJson()).toList(),
    if (name != null) 'name': name!.toJson(),
  };

  factory SLibraryDirective.fromJson(Map<String, dynamic> json) {
    return SLibraryDirective(
      offset: json['offset'] as int,
      length: json['length'] as int,
      metadata:
          (json['metadata'] as List?)
              ?.map((a) => SAnnotation.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      name:
          SAstNodeFactory.fromJson(json['name'] as Map<String, dynamic>?)
              as SIdentifier?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitLibraryDirective(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in metadata) {
      child.accept(visitor);
    }
    name?.accept(visitor);
  }
}

// ============================================================================
// Show/Hide Combinators
// ============================================================================

class SShowCombinator extends SCombinator {
  @override
  final int offset;
  @override
  final int length;

  final List<SSimpleIdentifier> shownNames;

  SShowCombinator({
    required this.offset,
    required this.length,
    this.shownNames = const [],
  });

  @override
  String get nodeType => 'ShowCombinator';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'shownNames': shownNames.map((n) => n.toJson()).toList(),
  };

  factory SShowCombinator.fromJson(Map<String, dynamic> json) {
    return SShowCombinator(
      offset: json['offset'] as int,
      length: json['length'] as int,
      shownNames:
          (json['shownNames'] as List?)
              ?.map(
                (n) => SSimpleIdentifier.fromJson(n as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitShowCombinator(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in shownNames) {
      child.accept(visitor);
    }
  }
}

class SHideCombinator extends SCombinator {
  @override
  final int offset;
  @override
  final int length;

  final List<SSimpleIdentifier> hiddenNames;

  SHideCombinator({
    required this.offset,
    required this.length,
    this.hiddenNames = const [],
  });

  @override
  String get nodeType => 'HideCombinator';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'hiddenNames': hiddenNames.map((n) => n.toJson()).toList(),
  };

  factory SHideCombinator.fromJson(Map<String, dynamic> json) {
    return SHideCombinator(
      offset: json['offset'] as int,
      length: json['length'] as int,
      hiddenNames:
          (json['hiddenNames'] as List?)
              ?.map(
                (n) => SSimpleIdentifier.fromJson(n as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitHideCombinator(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in hiddenNames) {
      child.accept(visitor);
    }
  }
}

// ============================================================================
// Configurations (conditional imports/exports)
// ============================================================================

/// A dotted name — the left-hand side of a configuration's condition, as in
/// `dart.library.io`.
class SDottedName extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  final List<SSimpleIdentifier> components;

  SDottedName({
    required this.offset,
    required this.length,
    this.components = const [],
  });

  @override
  String get nodeType => 'DottedName';

  /// The components joined with `.`, as written in source.
  String get name => components.map((c) => c.name).join('.');

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    'components': components.map((c) => c.toJson()).toList(),
  };

  factory SDottedName.fromJson(Map<String, dynamic> json) {
    return SDottedName(
      offset: json['offset'] as int,
      length: json['length'] as int,
      components:
          (json['components'] as List?)
              ?.map(
                (c) => SSimpleIdentifier.fromJson(c as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitDottedName(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    for (final child in components) {
      child.accept(visitor);
    }
  }
}

/// One conditional branch of an import or export directive:
/// `if (dart.library.io) 'io.dart'`, or with an explicit test value,
/// `if (dart.library.io == 'true') 'io.dart'`.
///
/// The condition is PRESERVED, not evaluated. Which branch applies depends on
/// the target platform, which the model does not know — resolving it is the
/// bundler's job at compile time, or the runner's at load time.
class SConfiguration extends SAstNode {
  @override
  final int offset;
  @override
  final int length;

  /// The declaration name being tested, e.g. `dart.library.io`.
  final SDottedName? name;

  /// The value the name is compared against, when the source writes
  /// `== '...'`. Absent means the implicit test against `'true'`.
  final SStringLiteral? value;

  /// The URI taken when the condition holds.
  final SStringLiteral? uri;

  SConfiguration({
    required this.offset,
    required this.length,
    this.name,
    this.value,
    this.uri,
  });

  @override
  String get nodeType => 'Configuration';

  @override
  Map<String, dynamic> toJson() => {
    'nodeType': nodeType,
    'offset': offset,
    'length': length,
    if (name != null) 'name': name!.toJson(),
    if (value != null) 'value': value!.toJson(),
    if (uri != null) 'uri': uri!.toJson(),
  };

  factory SConfiguration.fromJson(Map<String, dynamic> json) {
    return SConfiguration(
      offset: json['offset'] as int,
      length: json['length'] as int,
      name: json['name'] != null
          ? SDottedName.fromJson(json['name'] as Map<String, dynamic>)
          : null,
      value:
          SAstNodeFactory.fromJson(json['value'] as Map<String, dynamic>?)
              as SStringLiteral?,
      uri:
          SAstNodeFactory.fromJson(json['uri'] as Map<String, dynamic>?)
              as SStringLiteral?,
    );
  }

  @override
  T? accept<T>(SAstVisitor<T> visitor) => visitor.visitConfiguration(this);

  @override
  void visitChildren(SAstVisitor visitor) {
    name?.accept(visitor);
    value?.accept(visitor);
    uri?.accept(visitor);
  }
}
