/// Serializable token representation.
///
/// Replaces the analyzer's `Token` class with a simple data class
/// that can be serialized.
library;

import 'package:meta/meta.dart';

/// Token type enumeration matching analyzer's TokenType.
enum STokenType {
  // Keywords
  abstractKeyword,
  asKeyword,
  assertKeyword,
  asyncKeyword,
  awaitKeyword,
  breakKeyword,
  caseKeyword,
  catchKeyword,
  classKeyword,
  constKeyword,
  continueKeyword,
  covariantKeyword,
  defaultKeyword,
  deferredKeyword,
  doKeyword,
  dynamicKeyword,
  elseKeyword,
  enumKeyword,
  exportKeyword,
  extendsKeyword,
  extensionKeyword,
  externalKeyword,
  factoryKeyword,
  falseKeyword,
  finalKeyword,
  finallyKeyword,
  forKeyword,
  functionKeyword,
  getKeyword,
  hideKeyword,
  ifKeyword,
  implementsKeyword,
  importKeyword,
  inKeyword,
  interfaceKeyword,
  isKeyword,
  lateKeyword,
  libraryKeyword,
  mixinKeyword,
  nativeKeyword,
  newKeyword,
  nullKeyword,
  ofKeyword,
  onKeyword,
  operatorKeyword,
  partKeyword,
  requiredKeyword,
  rethrowKeyword,
  returnKeyword,
  sealedKeyword,
  setKeyword,
  showKeyword,
  staticKeyword,
  superKeyword,
  switchKeyword,
  syncKeyword,
  thisKeyword,
  throwKeyword,
  trueKeyword,
  tryKeyword,
  typedefKeyword,
  varKeyword,
  voidKeyword,
  whenKeyword,
  whileKeyword,
  withKeyword,
  yieldKeyword,

  // Operators and punctuation
  ampersand,
  ampersandAmpersand,
  ampersandAmpersandEq,
  ampersandEq,
  at,
  bang,
  bangEq,
  bangEqEq,
  bar,
  barBar,
  barBarEq,
  barEq,
  caret,
  caretEq,
  closeBrace,
  closeBracket,
  closeParen,
  colon,
  comma,
  eq,
  eqEq,
  eqEqEq,
  gt,
  gtEq,
  gtGt,
  gtGtEq,
  gtGtGt,
  gtGtGtEq,
  hash,
  lt,
  ltEq,
  ltLt,
  ltLtEq,
  minus,
  minusEq,
  minusMinus,
  openBrace,
  openBracket,
  openParen,
  percent,
  percentEq,
  period,
  periodPeriod,
  periodPeriodPeriod,
  periodPeriodPeriodQuestion,
  plus,
  plusEq,
  plusPlus,
  question,
  questionPeriod,
  questionQuestion,
  questionQuestionEq,
  semicolon,
  slash,
  slashEq,
  star,
  starEq,
  tilde,
  tildeSlash,
  tildeSlashEq,

  // Literals and identifiers
  identifier,
  integerLiteral,
  doubleLiteral,
  stringLiteral,
  multiLineStringLiteral,

  // Comments
  singleLineComment,
  multiLineComment,
  documentationComment,

  // Special
  eof,
  stringInterpolationExpression,
  stringInterpolationIdentifier,

  // Arrow
  arrow,
}

/// A serializable representation of a token.
///
/// This replaces the analyzer's `Token` class which has linked-list
/// structure and cannot be easily serialized.
@immutable
class SToken {
  /// The type of this token.
  final STokenType type;

  /// The lexeme (source text) of this token.
  final String lexeme;

  /// The offset of the first character of this token within the source.
  final int offset;

  /// The length of this token's lexeme.
  int get length => lexeme.length;

  /// The offset after the last character of this token.
  int get end => offset + length;

  const SToken({
    required this.type,
    required this.lexeme,
    required this.offset,
  });

  /// Creates a synthetic token with no source location.
  const SToken.synthetic(this.type, this.lexeme) : offset = -1;

  /// Converts this token to a JSON-serializable map.
  Map<String, dynamic> toJson() => {
        'type': type.name,
        'lexeme': lexeme,
        'offset': offset,
      };

  /// Creates a token from a JSON map.
  factory SToken.fromJson(Map<String, dynamic> json) {
    return SToken(
      type: STokenType.values.firstWhere((t) => t.name == json['type']),
      lexeme: json['lexeme'] as String,
      offset: json['offset'] as int,
    );
  }

  @override
  String toString() => lexeme;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SToken &&
          type == other.type &&
          lexeme == other.lexeme &&
          offset == other.offset;

  @override
  int get hashCode => Object.hash(type, lexeme, offset);
}

/// Extension to get keyword from lexeme.
extension STokenTypeExtension on String {
  /// Converts a keyword lexeme to its token type.
  STokenType? get keywordType {
    return switch (this) {
      'abstract' => STokenType.abstractKeyword,
      'as' => STokenType.asKeyword,
      'assert' => STokenType.assertKeyword,
      'async' => STokenType.asyncKeyword,
      'await' => STokenType.awaitKeyword,
      'break' => STokenType.breakKeyword,
      'case' => STokenType.caseKeyword,
      'catch' => STokenType.catchKeyword,
      'class' => STokenType.classKeyword,
      'const' => STokenType.constKeyword,
      'continue' => STokenType.continueKeyword,
      'covariant' => STokenType.covariantKeyword,
      'default' => STokenType.defaultKeyword,
      'deferred' => STokenType.deferredKeyword,
      'do' => STokenType.doKeyword,
      'dynamic' => STokenType.dynamicKeyword,
      'else' => STokenType.elseKeyword,
      'enum' => STokenType.enumKeyword,
      'export' => STokenType.exportKeyword,
      'extends' => STokenType.extendsKeyword,
      'extension' => STokenType.extensionKeyword,
      'external' => STokenType.externalKeyword,
      'factory' => STokenType.factoryKeyword,
      'false' => STokenType.falseKeyword,
      'final' => STokenType.finalKeyword,
      'finally' => STokenType.finallyKeyword,
      'for' => STokenType.forKeyword,
      'Function' => STokenType.functionKeyword,
      'get' => STokenType.getKeyword,
      'hide' => STokenType.hideKeyword,
      'if' => STokenType.ifKeyword,
      'implements' => STokenType.implementsKeyword,
      'import' => STokenType.importKeyword,
      'in' => STokenType.inKeyword,
      'interface' => STokenType.interfaceKeyword,
      'is' => STokenType.isKeyword,
      'late' => STokenType.lateKeyword,
      'library' => STokenType.libraryKeyword,
      'mixin' => STokenType.mixinKeyword,
      'native' => STokenType.nativeKeyword,
      'new' => STokenType.newKeyword,
      'null' => STokenType.nullKeyword,
      'of' => STokenType.ofKeyword,
      'on' => STokenType.onKeyword,
      'operator' => STokenType.operatorKeyword,
      'part' => STokenType.partKeyword,
      'required' => STokenType.requiredKeyword,
      'rethrow' => STokenType.rethrowKeyword,
      'return' => STokenType.returnKeyword,
      'sealed' => STokenType.sealedKeyword,
      'set' => STokenType.setKeyword,
      'show' => STokenType.showKeyword,
      'static' => STokenType.staticKeyword,
      'super' => STokenType.superKeyword,
      'switch' => STokenType.switchKeyword,
      'sync' => STokenType.syncKeyword,
      'this' => STokenType.thisKeyword,
      'throw' => STokenType.throwKeyword,
      'true' => STokenType.trueKeyword,
      'try' => STokenType.tryKeyword,
      'typedef' => STokenType.typedefKeyword,
      'var' => STokenType.varKeyword,
      'void' => STokenType.voidKeyword,
      'when' => STokenType.whenKeyword,
      'while' => STokenType.whileKeyword,
      'with' => STokenType.withKeyword,
      'yield' => STokenType.yieldKeyword,
      _ => null,
    };
  }
}
