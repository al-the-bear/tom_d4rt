// D4rt test script: Tests PolynomialFit from gestures
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PolynomialFit test executing');

  // PolynomialFit is used by LeastSquaresSolver
  // Create via LeastSquaresSolver.solve()
  final solver = LeastSquaresSolver(
    [0.0, 1.0, 2.0, 3.0], // x values
    [0.0, 2.0, 4.0, 6.0], // y values (linear: y = 2x)
    [1.0, 1.0, 1.0, 1.0], // weights
  );

  // Solve for degree 1 (linear)
  final fit = solver.solve(1);

  print('Created PolynomialFit via LeastSquaresSolver');
  print('fit.runtimeType: ${fit?.runtimeType}');

  if (fit != null) {
    // Test coefficients
    print('\nCoefficients:');
    print('coefficients: ${fit.coefficients}');
    print('coefficients[0] (intercept): ${fit.coefficients[0]}');
    print('coefficients[1] (slope): ${fit.coefficients[1]}');

    // Test confidence
    print('\nFit quality:');
    print('confidence: ${fit.confidence}');
    print('confidence ~1.0 means perfect fit');
  }

  // Test with quadratic fit
  print('\nQuadratic fit example:');
  final solver2 = LeastSquaresSolver(
    [0.0, 1.0, 2.0, 3.0],
    [0.0, 1.0, 4.0, 9.0], // y = x^2
    [1.0, 1.0, 1.0, 1.0],
  );
  final quadFit = solver2.solve(2);
  if (quadFit != null) {
    print('coefficients: ${quadFit.coefficients}');
    print('confidence: ${quadFit.confidence}');
  }

  // Explain purpose
  print('\nPolynomialFit purpose:');
  print('- Result of polynomial least-squares fitting');
  print('- Contains fitted coefficients');
  print('- Includes confidence measure');
  print('- Used for velocity estimation in gestures');

  // Usage in gesture system
  print('\nUsage in gestures:');
  print('- VelocityTracker uses polynomial fitting');
  print('- Fits position samples over time');
  print('- Derives velocity from fitted polynomial');
  print('- Degree 2 (quadratic) typical for velocity');

  print('\nPolynomialFit test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PolynomialFit Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Polynomial curve fitting result'),
      if (fit != null) ...[
        Text(
          'Linear: coeffs=${fit.coefficients.map((c) => c.toStringAsFixed(2)).join(", ")}',
        ),
        Text('confidence: ${fit.confidence.toStringAsFixed(4)}'),
      ],
      Text('Used for: velocity estimation'),
    ],
  );
}
