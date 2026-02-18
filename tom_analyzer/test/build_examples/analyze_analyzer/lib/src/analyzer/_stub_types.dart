// Generated stub types for external dependencies
// ignore_for_file: unused_element, camel_case_types, one_member_abstracts
// ignore_for_file: duplicate_definition, constant_identifier_names

/// Stub for analyzer Token type
class Token {
  Token? get next => null;
  Token? get previous => null;
  int get offset => 0;
  int get length => 0;
  String get lexeme => '';
}

/// Stub for analyzer SyntacticEntity type
abstract class SyntacticEntity {
  int get offset;
  int get length;
  int get end;
}

/// Stub for analyzer Precedence type
class Precedence implements Comparable<Precedence> {
  final int value;
  const Precedence._(this.value);
  static const Precedence none = Precedence._(0);
  static const Precedence assignment = Precedence._(1);
  @override
  int compareTo(Precedence other) => value.compareTo(other.value);
}

/// Stub for ChildEntities
class ChildEntities extends Iterable<SyntacticEntity> {
  @override
  Iterator<SyntacticEntity> get iterator => <SyntacticEntity>[].iterator;
}

/// Stub for LineInfo
class LineInfo {
  const LineInfo.fromContent(String content);
  int getOffsetOfLine(int line) => 0;
  int getLocation(int offset) => 0;
}

/// Stub for FeatureSet
abstract class FeatureSet {}

/// Stub for LanguageVersion
abstract class LanguageVersion {
  int get major;
  int get minor;
}

/// Stub for LibraryLanguageVersion
abstract class LibraryLanguageVersion extends LanguageVersion {}

/// Stub for AnalysisSession
abstract class AnalysisSession {}

/// Stub for Source
abstract class Source {}

/// Stub for SourceRange
class SourceRange {
  final int offset;
  final int length;
  const SourceRange(this.offset, this.length);
}

/// Stub for TypeProvider
abstract class TypeProvider {}

/// Stub for NullabilitySuffix
enum NullabilitySuffix { question, star, none }

/// Stub for ElementKind
enum ElementKind {
  CLASS, CONSTRUCTOR, EXTENSION, EXTENSION_TYPE, FIELD, FUNCTION,
  GETTER, IMPORT, LIBRARY, LOCAL_VARIABLE, METHOD, MIXIN,
  PARAMETER, PREFIX, SETTER, TOP_LEVEL_VARIABLE, TYPE_ALIAS, TYPE_PARAMETER, ENUM,
}

/// Stub for NodeListImpl (internal implementation)
class NodeListImpl<E> extends Iterable<E> {
  final List<E> _nodes = [];
  @override
  Iterator<E> get iterator => _nodes.iterator;
  Token? get beginToken => null;
  Token? get endToken => null;
}

/// Stub for ArgumentListImpl (internal implementation)
abstract class ArgumentListImpl {}

/// Stub for TypeArgumentListImpl (internal implementation)
abstract class TypeArgumentListImpl {}

/// Stub for GuardedPatternImpl (internal implementation)
abstract class GuardedPatternImpl {}

/// Stub for CaseClauseImpl (internal implementation)
abstract class CaseClauseImpl {}

/// Stub for PatternFieldNameImpl (internal implementation)
abstract class PatternFieldNameImpl {}

/// Stub for AttemptedConstantEvaluationResult
abstract class AttemptedConstantEvaluationResult {}

/// Stub for LocalVariableInfo
abstract class LocalVariableInfo {}

/// Stub for Name (internal type for member resolution)
abstract class Name {
  String get name;
  bool get isPrivate;
  bool get isPublic;
}

