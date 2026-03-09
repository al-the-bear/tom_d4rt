// D4rt test script: Tests LeastSquaresSolver from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LeastSquaresSolver test executing');

  // Linear fit: y = 2x + 1
  final solver = LeastSquaresSolver(
    [0.0, 1.0, 2.0, 3.0, 4.0],
    [1.0, 3.0, 5.0, 7.0, 9.0],
    [1.0, 1.0, 1.0, 1.0, 1.0],
  );
  final result = solver.solve(1); // degree 1 = linear
  print('Linear fit: confidence=${result?.confidence}');
  if (result != null) {
    print('coefficients: ${result.coefficients}');
  }

  // Quadratic fit: y = x^2
  final solver2 = LeastSquaresSolver(
    [0.0, 1.0, 2.0, 3.0],
    [0.0, 1.0, 4.0, 9.0],
    [1.0, 1.0, 1.0, 1.0],
  );
  final result2 = solver2.solve(2);
  print('Quadratic fit: ${result2?.confidence}');

  print('LeastSquaresSolver test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('LeastSquaresSolver Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Linear fit: conf=${result?.confidence.toStringAsFixed(4)}'),
    Text('Quadratic fit: conf=${result2?.confidence.toStringAsFixed(4)}'),
  ]);
}
