// Stage 2 of the calculator: turn tokens into an expression tree (AST).
//
// Demonstrates a relative import (`import 'tokenizer.dart';`) that the
// interpreter resolves through the runner's in-memory source map, plus a small
// class hierarchy with a polymorphic `evaluate` method.

import 'tokenizer.dart';

/// Base class for every node in the expression tree.
abstract class Expr {
  /// Evaluate this node against the variable [environment].
  double evaluate(Map<String, double> environment);
}

/// A literal number, e.g. `42`.
class NumberExpr extends Expr {
  final double value;
  NumberExpr(this.value);

  @override
  double evaluate(Map<String, double> environment) => value;
}

/// A variable reference, e.g. `x`.
class VariableExpr extends Expr {
  final String name;
  VariableExpr(this.name);

  @override
  double evaluate(Map<String, double> environment) {
    final value = environment[name];
    if (value == null) {
      throw StateError('Unknown variable "$name"');
    }
    return value;
  }
}

/// An assignment, e.g. `x = 1 + 2`. Stores into the environment and returns it.
class AssignExpr extends Expr {
  final String name;
  final Expr value;
  AssignExpr(this.name, this.value);

  @override
  double evaluate(Map<String, double> environment) {
    final result = value.evaluate(environment);
    environment[name] = result;
    return result;
  }
}

/// A binary operation, e.g. `a * b`.
class BinaryExpr extends Expr {
  final TokenType op;
  final Expr left;
  final Expr right;
  BinaryExpr(this.op, this.left, this.right);

  @override
  double evaluate(Map<String, double> environment) {
    final l = left.evaluate(environment);
    final r = right.evaluate(environment);
    switch (op) {
      case TokenType.plus:
        return l + r;
      case TokenType.minus:
        return l - r;
      case TokenType.star:
        return l * r;
      case TokenType.slash:
        if (r == 0) throw StateError('Division by zero');
        return l / r;
      default:
        throw StateError('Not a binary operator: ${op.name}');
    }
  }
}

/// A unary negation, e.g. `-x`.
class NegateExpr extends Expr {
  final Expr operand;
  NegateExpr(this.operand);

  @override
  double evaluate(Map<String, double> environment) => -operand.evaluate(environment);
}

/// A hand-written recursive-descent parser.
///
/// Grammar (lowest precedence first):
///   statement := identifier "=" expression | expression
///   expression := term (("+" | "-") term)*
///   term       := factor (("*" | "/") factor)*
///   factor     := number | identifier | "(" expression ")" | "-" factor
class Parser {
  final List<Token> _tokens;
  int _pos = 0;

  Parser(this._tokens);

  Token get _current => _tokens[_pos];

  Token _advance() => _tokens[_pos++];

  bool _match(TokenType type) {
    if (_current.type == type) {
      _advance();
      return true;
    }
    return false;
  }

  /// Parse the token stream into a single [Expr] tree.
  Expr parse() {
    final expr = _statement();
    if (_current.type != TokenType.eof) {
      throw FormatException('Unexpected token: $_current');
    }
    return expr;
  }

  Expr _statement() {
    // Lookahead for `identifier =` to detect an assignment.
    if (_current.type == TokenType.identifier &&
        _tokens[_pos + 1].type == TokenType.assign) {
      final name = _advance().text;
      _advance(); // consume '='
      return AssignExpr(name, _expression());
    }
    return _expression();
  }

  Expr _expression() {
    var expr = _term();
    while (_current.type == TokenType.plus || _current.type == TokenType.minus) {
      final op = _advance().type;
      expr = BinaryExpr(op, expr, _term());
    }
    return expr;
  }

  Expr _term() {
    var expr = _factor();
    while (_current.type == TokenType.star || _current.type == TokenType.slash) {
      final op = _advance().type;
      expr = BinaryExpr(op, expr, _factor());
    }
    return expr;
  }

  Expr _factor() {
    if (_match(TokenType.minus)) {
      return NegateExpr(_factor());
    }
    if (_current.type == TokenType.number) {
      return NumberExpr(_advance().value);
    }
    if (_current.type == TokenType.identifier) {
      return VariableExpr(_advance().text);
    }
    if (_match(TokenType.lparen)) {
      final expr = _expression();
      if (!_match(TokenType.rparen)) {
        throw FormatException('Expected ")"');
      }
      return expr;
    }
    throw FormatException('Unexpected token: $_current');
  }
}
