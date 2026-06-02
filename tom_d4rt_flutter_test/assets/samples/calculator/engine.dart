// Calculator engine — pure state, no Flutter imports.
//
// The engine models a four-operation desk calculator with full
// operator precedence (`×` and `÷` bind tighter than `+` and `−`),
// a scrolling history of completed calculations, and live display
// of the operand currently being typed. It is intentionally a
// plain `class` (not a `ChangeNotifier`) — the host `State<T>`
// drives `setState` after every public mutation, which keeps the
// canonical d4rt-friendly StatefulWidget pattern intact.
//
// Token model
//   The running expression is held as a `List<String>` of tokens
//   where every token is either:
//     • a non-empty decimal numeral (e.g. `"42"`, `"3.14"`,
//       `"-5"` after `±` toggles the sign), or
//     • a single operator character: `"+"`, `"-"`, `"*"`, `"/"`.
//   The token at the end of the list is special: if it's a
//   numeral, that's the operand the user is currently typing.
//   New digit / dot inputs append to it. If the last token is an
//   operator, a new digit starts a fresh numeral token.
//
// Evaluation
//   `_evaluate(tokens)` runs the classic two-pass operator-
//   precedence walk. Pass 1 folds `×` and `÷` left-to-right;
//   pass 2 folds `+` and `−` left-to-right. Division by zero
//   bubbles up as the literal display string `"Error"`.
//
// Why no `ChangeNotifier`?
//   The plan for this sample explicitly calls out the canonical
//   StatefulWidget + `State<T>` + `setState` pattern. Routing
//   state through a script-defined `ChangeNotifier` would add a
//   listener layer for no benefit — every mutation is already
//   triggered by a button tap, and the host calls `setState`
//   directly after each call.

/// Single completed calculation: the expression as a human-
/// readable string and its numeric result.
class HistoryEntry {
  final String expression;
  final String result;

  const HistoryEntry({required this.expression, required this.result});

  @override
  String toString() => '$expression = $result';
}

class CalculatorEngine {
  CalculatorEngine();

  // ── Tokens for the in-progress expression ───────────────────────
  final List<String> _tokens = <String>['0'];

  // ── History of completed calculations (most recent last) ────────
  final List<HistoryEntry> _history = <HistoryEntry>[];

  /// True immediately after an `=` press — the next digit / dot
  /// input must replace the displayed result rather than append.
  bool _justEvaluated = false;

  /// True when the last evaluation produced `"Error"` (division
  /// by zero, malformed expression). Any new input clears it.
  bool _hasError = false;

  // ── Accessors ───────────────────────────────────────────────────

  /// Current expression as a single human-readable string, e.g.
  /// `"12 + 7 ×"`. Returns an empty string when only an operand
  /// is being typed (the operand is shown big via [display]).
  String get expression {
    if (_hasError) return '';
    if (_tokens.length <= 1) return '';
    // Everything except the last numeral token.
    final parts = <String>[];
    for (int i = 0; i < _tokens.length - 1; i++) {
      parts.add(_pretty(_tokens[i]));
    }
    // If the last token is an operator (mid-input), show it too.
    final last = _tokens[_tokens.length - 1];
    if (_isOperator(last)) {
      parts.add(_pretty(last));
    }
    return parts.join(' ');
  }

  /// The big-text content: the operand the user is currently
  /// typing or the result of the most recent `=`.
  String get display {
    if (_hasError) return 'Error';
    final last = _tokens[_tokens.length - 1];
    if (_isOperator(last)) {
      // Operand position is empty — show the previous numeral so
      // the screen never looks blank.
      if (_tokens.length >= 2) {
        return _tokens[_tokens.length - 2];
      }
      return '0';
    }
    return last;
  }

  /// Most-recent-last list of completed calculations.
  List<HistoryEntry> get history => List<HistoryEntry>.unmodifiable(_history);

  bool get hasError => _hasError;
  bool get justEvaluated => _justEvaluated;

  // ── Inputs ──────────────────────────────────────────────────────

  void inputDigit(String digit) {
    assert(digit.length == 1 && '0123456789'.contains(digit),
        'digit must be one of 0-9');
    if (_hasError || _justEvaluated) {
      _resetForFreshInput();
    }
    final last = _tokens[_tokens.length - 1];
    if (_isOperator(last)) {
      _tokens.add(digit);
      return;
    }
    if (last == '0') {
      // No leading zeros — replace.
      _tokens[_tokens.length - 1] = digit;
      return;
    }
    _tokens[_tokens.length - 1] = last + digit;
  }

  void inputDot() {
    if (_hasError || _justEvaluated) {
      _resetForFreshInput();
    }
    final last = _tokens[_tokens.length - 1];
    if (_isOperator(last)) {
      // Start a new operand "0.".
      _tokens.add('0.');
      return;
    }
    if (last.contains('.')) return; // already has a decimal point
    _tokens[_tokens.length - 1] = '$last.';
  }

  void inputOperator(String op) {
    assert(op == '+' || op == '-' || op == '*' || op == '/',
        'operator must be one of + - * /');
    if (_hasError) {
      _resetForFreshInput();
    }
    // If we just evaluated, start a new expression from the result.
    _justEvaluated = false;
    final last = _tokens[_tokens.length - 1];
    if (_isOperator(last)) {
      // Replace the trailing operator — user changed their mind.
      _tokens[_tokens.length - 1] = op;
      return;
    }
    // Strip a trailing "." so "5." + "+" becomes "5 +".
    if (last.endsWith('.')) {
      _tokens[_tokens.length - 1] = last.substring(0, last.length - 1);
    }
    _tokens.add(op);
  }

  /// Toggle the sign of the operand currently being typed.
  void negate() {
    if (_hasError || _justEvaluated) return;
    final last = _tokens[_tokens.length - 1];
    if (_isOperator(last)) return;
    if (last == '0') return;
    if (last.startsWith('-')) {
      _tokens[_tokens.length - 1] = last.substring(1);
    } else {
      _tokens[_tokens.length - 1] = '-$last';
    }
  }

  /// Convert the current operand to its percentage (divide by 100).
  void percent() {
    if (_hasError || _justEvaluated) return;
    final last = _tokens[_tokens.length - 1];
    if (_isOperator(last)) return;
    final parsed = double.tryParse(last);
    if (parsed == null) return;
    _tokens[_tokens.length - 1] = _formatNumber(parsed / 100.0);
  }

  /// Remove the last input character (digit / dot / operator).
  /// If the current operand is the lone `"0"` placeholder this is
  /// a no-op.
  void backspace() {
    if (_hasError) {
      _resetForFreshInput();
      return;
    }
    _justEvaluated = false;
    final last = _tokens[_tokens.length - 1];
    if (_isOperator(last)) {
      _tokens.removeLast();
      return;
    }
    if (last.length > 1) {
      // Avoid leaving an isolated "-" sign (from negate).
      final next = last.substring(0, last.length - 1);
      if (next == '-') {
        _tokens[_tokens.length - 1] = '0';
      } else {
        _tokens[_tokens.length - 1] = next;
      }
      return;
    }
    // Single-char operand → either reset to "0" or remove the
    // entire operand if there's an operator to fall back to.
    if (_tokens.length == 1) {
      _tokens[0] = '0';
      return;
    }
    _tokens.removeLast();
  }

  /// Clear the current entry (the trailing operand). If only a
  /// `"0"` is in flight, this is equivalent to [clearAll].
  void clearEntry() {
    _justEvaluated = false;
    if (_hasError) {
      _resetForFreshInput();
      return;
    }
    final last = _tokens[_tokens.length - 1];
    if (_isOperator(last)) return;
    if (_tokens.length == 1) {
      _tokens[0] = '0';
      return;
    }
    _tokens[_tokens.length - 1] = '0';
  }

  /// Clear everything (operand + running expression). History is
  /// preserved.
  void clearAll() {
    _tokens.clear();
    _tokens.add('0');
    _justEvaluated = false;
    _hasError = false;
  }

  /// Discard the persisted history strip.
  void clearHistory() {
    _history.clear();
  }

  /// Evaluate the current expression and replace the displayed
  /// value with the result.
  void equals() {
    if (_hasError) return;
    // Drop trailing operator / dot so "5 + =" computes "5 = 5".
    while (_tokens.isNotEmpty &&
        _isOperator(_tokens[_tokens.length - 1])) {
      _tokens.removeLast();
    }
    if (_tokens.isEmpty) {
      _tokens.add('0');
      return;
    }
    final cleaned = <String>[];
    for (int i = 0; i < _tokens.length; i++) {
      var t = _tokens[i];
      if (!_isOperator(t) && t.endsWith('.')) {
        t = t.substring(0, t.length - 1);
      }
      cleaned.add(t);
    }
    final expressionString = _renderExpression(cleaned);
    final result = _evaluate(cleaned);
    if (result == null) {
      _hasError = true;
      _justEvaluated = true;
      _tokens.clear();
      _tokens.add('0');
      _history.add(HistoryEntry(
        expression: expressionString,
        result: 'Error',
      ));
      return;
    }
    final formatted = _formatNumber(result);
    _history.add(HistoryEntry(
      expression: expressionString,
      result: formatted,
    ));
    _tokens.clear();
    _tokens.add(formatted);
    _justEvaluated = true;
  }

  // ── Internals ───────────────────────────────────────────────────

  void _resetForFreshInput() {
    _tokens.clear();
    _tokens.add('0');
    _justEvaluated = false;
    _hasError = false;
  }

  static bool _isOperator(String token) {
    return token == '+' || token == '-' || token == '*' || token == '/';
  }

  /// Human-friendly form of a single token (turns `*`→`×`, `/`→`÷`).
  static String _pretty(String token) {
    if (token == '*') return '×';
    if (token == '/') return '÷';
    return token;
  }

  static String _renderExpression(List<String> tokens) {
    final parts = <String>[];
    for (int i = 0; i < tokens.length; i++) {
      parts.add(_pretty(tokens[i]));
    }
    return parts.join(' ');
  }

  /// Two-pass operator-precedence evaluator. Returns `null` on
  /// division by zero or any other arithmetic failure.
  static double? _evaluate(List<String> tokens) {
    if (tokens.isEmpty) return null;
    // Pass 1: copy tokens, folding * / left to right.
    final pass1 = <String>[];
    pass1.add(tokens[0]);
    int i = 1;
    while (i < tokens.length) {
      final op = tokens[i];
      if (i + 1 >= tokens.length) return null; // dangling operator
      final rhs = tokens[i + 1];
      if (op == '*' || op == '/') {
        final lhs = pass1.removeLast();
        final lhsNum = double.tryParse(lhs);
        final rhsNum = double.tryParse(rhs);
        if (lhsNum == null || rhsNum == null) return null;
        if (op == '/' && rhsNum == 0.0) return null;
        final folded = op == '*' ? lhsNum * rhsNum : lhsNum / rhsNum;
        pass1.add(_formatNumber(folded));
      } else {
        pass1.add(op);
        pass1.add(rhs);
      }
      i += 2;
    }
    // Pass 2: fold + - left to right.
    var acc = double.tryParse(pass1[0]);
    if (acc == null) return null;
    int j = 1;
    while (j < pass1.length) {
      final op = pass1[j];
      if (j + 1 >= pass1.length) return null;
      final rhsNum = double.tryParse(pass1[j + 1]);
      if (rhsNum == null) return null;
      if (op == '+') {
        acc = acc! + rhsNum;
      } else if (op == '-') {
        acc = acc! - rhsNum;
      } else {
        return null;
      }
      j += 2;
    }
    return acc;
  }

  /// Format a double as a calculator string — integer values
  /// render without a decimal point, others trim trailing zeros.
  static String _formatNumber(double value) {
    if (value.isNaN || value.isInfinite) return 'Error';
    if (value == value.truncateToDouble() &&
        value.abs() < 1e16) {
      // Render as integer when it fits.
      return value.toInt().toString();
    }
    // Up to 10 fractional digits, trim trailing zeros.
    var s = value.toStringAsFixed(10);
    // Trim trailing zeros.
    while (s.endsWith('0')) {
      s = s.substring(0, s.length - 1);
    }
    if (s.endsWith('.')) {
      s = s.substring(0, s.length - 1);
    }
    return s;
  }
}
