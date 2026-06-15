// Entry point of the calculator example.
//
// The runner calls `main(args)` where `args` is the list of strings passed
// after the example name. If you pass an expression it is evaluated; otherwise
// a short demo program runs.
//
//   ./run_example.sh calculator                 # runs the demo program below
//   ./run_example.sh calculator "(2 + 3) * 4"   # evaluates one expression

import 'evaluator.dart';
import 'util/format.dart';

void main(List<String> args) {
  final calc = Calculator();

  if (args.isNotEmpty) {
    final expr = args.join(' ');
    // `formatResult` comes from the `util/` subfolder — a subfolder-relative
    // import the runner resolves against this file's location.
    print(formatResult(expr, calc.eval(expr)));
    return;
  }

  // A small program that shows variables persisting across lines.
  final program = [
    'radius = 3',
    'pi = 3.14159',
    'area = pi * radius * radius',
    'circumference = 2 * pi * radius',
    'area + circumference',
  ];

  print('Running calculator demo:');
  for (final line in program) {
    if (line.contains('=') && !line.contains('==')) {
      final value = calc.eval(line);
      print('  $line   -> $value');
    } else {
      print('  $line   = ${calc.eval(line)}');
    }
  }

  print('\nFinal environment: ${calc.environment}');
}
