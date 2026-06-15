// Stage 1 of the calculator: turn a source string into a list of tokens.
//
// This file is a plain D4rt script. It uses only language built-ins (String,
// classes, enums, lists) — no host library, no bridges. The runner loads it
// because `parser.dart` imports it with a relative path.

/// The kinds of token the calculator understands.
enum TokenType { number, plus, minus, star, slash, lparen, rparen, identifier, assign, eof }

/// A single lexical token with its source text and (for numbers) value.
class Token {
  final TokenType type;
  final String text;
  final double value;

  Token(this.type, this.text, [this.value = 0]);

  @override
  String toString() => '${type.name}("$text")';
}

/// Converts `expr` into a list of [Token]s, ending with a `eof` token.
///
/// Throws [FormatException] on an unexpected character so the caller can
/// report a precise error.
List<Token> tokenize(String expr) {
  final tokens = <Token>[];
  var i = 0;

  bool isDigit(String c) => c.codeUnitAt(0) >= 48 && c.codeUnitAt(0) <= 57;
  bool isAlpha(String c) {
    final u = c.codeUnitAt(0);
    return (u >= 65 && u <= 90) || (u >= 97 && u <= 122) || c == '_';
  }

  while (i < expr.length) {
    final c = expr[i];

    if (c == ' ' || c == '\t' || c == '\n') {
      i++;
      continue;
    }

    if (isDigit(c) || c == '.') {
      final start = i;
      while (i < expr.length && (isDigit(expr[i]) || expr[i] == '.')) {
        i++;
      }
      final text = expr.substring(start, i);
      tokens.add(Token(TokenType.number, text, double.parse(text)));
      continue;
    }

    if (isAlpha(c)) {
      final start = i;
      while (i < expr.length && (isAlpha(expr[i]) || isDigit(expr[i]))) {
        i++;
      }
      tokens.add(Token(TokenType.identifier, expr.substring(start, i)));
      continue;
    }

    switch (c) {
      case '+':
        tokens.add(Token(TokenType.plus, c));
      case '-':
        tokens.add(Token(TokenType.minus, c));
      case '*':
        tokens.add(Token(TokenType.star, c));
      case '/':
        tokens.add(Token(TokenType.slash, c));
      case '(':
        tokens.add(Token(TokenType.lparen, c));
      case ')':
        tokens.add(Token(TokenType.rparen, c));
      case '=':
        tokens.add(Token(TokenType.assign, c));
      default:
        throw FormatException('Unexpected character "$c" at position $i');
    }
    i++;
  }

  tokens.add(Token(TokenType.eof, ''));
  return tokens;
}
