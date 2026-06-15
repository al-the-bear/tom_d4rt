// Stage 3 of the calculator: a stateful evaluator that ties the pipeline
// together and remembers variables across lines.
//
// Imports both earlier stages with relative paths; the runner resolves them
// from the example folder.

import 'tokenizer.dart';
import 'parser.dart';

/// Evaluates calculator expressions, keeping assigned variables between calls.
///
/// ```
/// final calc = Calculator();
/// calc.eval('x = 6');      // 6.0, x is remembered
/// calc.eval('x * 7');      // 42.0
/// ```
class Calculator {
  /// The live variable bindings. Persists across [eval] calls.
  final Map<String, double> environment = {};

  /// Tokenize, parse and evaluate a single [line]. Returns its numeric value.
  double eval(String line) {
    final tokens = tokenize(line);
    final ast = Parser(tokens).parse();
    return ast.evaluate(environment);
  }

  /// Evaluate every line in [program], returning the value of the last line.
  /// Blank lines are skipped.
  double run(List<String> program) {
    var last = 0.0;
    for (final line in program) {
      if (line.trim().isEmpty) continue;
      last = eval(line);
    }
    return last;
  }
}
