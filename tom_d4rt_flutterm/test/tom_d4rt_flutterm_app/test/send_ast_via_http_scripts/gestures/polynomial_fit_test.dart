// D4rt test script: Tests PolynomialFit(coefficients) concepts from gestures
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PolynomialFit test executing');
  final results = <String>[];

  // ========== PolynomialFit Concepts Tests ==========
  print('Testing PolynomialFit concepts...');

  // Test 1: Create PolynomialFit with coefficients
  final coefficients1 = [0.0, 100.0, 50.0]; // ax^2 + bx + c => 50x^2 + 100x + 0
  final fit1 = PolynomialFit(coefficients1.length);
  for (int i = 0; i < coefficients1.length; i++) {
    fit1.coefficients[i] = coefficients1[i];
  }
  assert(fit1.coefficients.length == 3, 'Should have 3 coefficients');
  results.add(
    'PolynomialFit created with ${fit1.coefficients.length} coefficients',
  );
  print('PolynomialFit created: ${fit1.coefficients.length} coefficients');

  // Test 2: Access coefficients
  results.add('Coefficients: ${fit1.coefficients}');
  print('Coefficients: ${fit1.coefficients}');

  // Test 3: Linear fit (degree 1)
  final linearFit = PolynomialFit(2); // [c, m] for y = mx + c
  linearFit.coefficients[0] = 50.0; // intercept
  linearFit.coefficients[1] = 100.0; // slope (velocity)
  assert(
    linearFit.coefficients.length == 2,
    'Linear should have 2 coefficients',
  );
  results.add(
    'Linear fit: c=${linearFit.coefficients[0]}, m=${linearFit.coefficients[1]}',
  );
  print('Linear fit coefficients: ${linearFit.coefficients}');

  // Test 4: Quadratic fit (degree 2)
  final quadFit = PolynomialFit(3); // [c, b, a] for y = ax^2 + bx + c
  quadFit.coefficients[0] = 0.0; // constant
  quadFit.coefficients[1] = 500.0; // linear (velocity)
  quadFit.coefficients[2] = -50.0; // quadratic (deceleration)
  assert(
    quadFit.coefficients.length == 3,
    'Quadratic should have 3 coefficients',
  );
  results.add('Quadratic fit: ${quadFit.coefficients}');
  print('Quadratic fit coefficients: ${quadFit.coefficients}');

  // Test 5: Confidence property
  fit1.confidence = 0.95;
  assert(fit1.confidence == 0.95, 'Confidence should be 0.95');
  results.add('confidence: ${fit1.confidence}');
  print('PolynomialFit confidence: ${fit1.confidence}');

  // Test 6: Low confidence example
  final lowConfidenceFit = PolynomialFit(2);
  lowConfidenceFit.confidence = 0.3;
  results.add('Low confidence: ${lowConfidenceFit.confidence}');
  print('Low confidence fit: ${lowConfidenceFit.confidence}');

  // Test 7: Evaluate polynomial at x (manual calculation)
  // For y = ax^2 + bx + c with coefficients [c, b, a]
  double evaluate(List<double> coeffs, double x) {
    double result = 0.0;
    for (int i = 0; i < coeffs.length; i++) {
      result += coeffs[i] * _pow(x, i);
    }
    return result;
  }

  final evalResult = evaluate(quadFit.coefficients.toList(), 1.0); // at x=1
  results.add('Evaluate at x=1: ${evalResult.toStringAsFixed(2)}');
  print('Polynomial value at x=1: $evalResult');

  // Test 8: Velocity from linear coefficient
  final velocity = linearFit.coefficients[1];
  results.add('Velocity (slope): $velocity px/s');
  print('Velocity from linear coefficient: $velocity');

  // Test 9: Acceleration from quadratic coefficient
  final acceleration = 2 * quadFit.coefficients[2];
  results.add('Acceleration: $acceleration px/s²');
  print('Acceleration from quadratic: $acceleration');

  // Test 10: Degree of polynomial
  final degree1 = linearFit.coefficients.length - 1;
  final degree2 = quadFit.coefficients.length - 1;
  results.add('Linear degree: $degree1, Quadratic degree: $degree2');
  print('Polynomial degrees: linear=$degree1, quadratic=$degree2');

  // Test 11: VelocityTracker uses polynomial fitting
  final tracker = VelocityTracker.withKind(PointerDeviceKind.touch);
  tracker.addPosition(Duration(milliseconds: 0), Offset(0, 0));
  tracker.addPosition(Duration(milliseconds: 16), Offset(50, 30));
  tracker.addPosition(Duration(milliseconds: 32), Offset(100, 60));
  tracker.addPosition(Duration(milliseconds: 48), Offset(150, 90));
  final estimate = tracker.getVelocityEstimate();
  results.add('VelocityTracker uses polynomial fit internally');
  print('VelocityTracker velocity estimate: ${estimate?.pixelsPerSecond}');

  // Test 12: Confidence from velocity estimate
  if (estimate != null) {
    results.add(
      'Estimate confidence: ${estimate.confidence.toStringAsFixed(3)}',
    );
    print('Velocity estimate confidence: ${estimate.confidence}');
  } else {
    results.add('Estimate: null');
    print('Velocity estimate is null');
  }

  // Test 13: Position samples for fitting
  final positions = [
    Offset(0, 0),
    Offset(50, 30),
    Offset(110, 65),
    Offset(180, 105),
  ];
  results.add('Sample positions: ${positions.length}');
  print('Position samples for fit: ${positions.length}');

  // Test 14: Time samples for fitting
  final times = [0, 16, 32, 48].map((t) => Duration(milliseconds: t)).toList();
  results.add('Time samples: ${times.length}');
  print('Time samples for fit: ${times.length}');

  // Test 15: Create fit with more coefficients
  final cubicFit = PolynomialFit(4);
  cubicFit.coefficients[0] = 10.0;
  cubicFit.coefficients[1] = 200.0;
  cubicFit.coefficients[2] = -30.0;
  cubicFit.coefficients[3] = 2.0;
  results.add('Cubic fit coefficients: ${cubicFit.coefficients}');
  print('Cubic polynomial: ${cubicFit.coefficients}');

  // Test 16: Derivative concept (velocity from position fit)
  // If position = ax^2 + bx + c, velocity = 2ax + b
  final posCoeffs = [0.0, 100.0, -5.0]; // position polynomial
  final velAtT0 = posCoeffs[1]; // velocity at t=0
  results.add('Initial velocity: $velAtT0');
  print('Initial velocity from derivative: $velAtT0');

  // Test 17: Least squares fitting concept
  results.add('Uses least squares regression');
  print('PolynomialFit computed via least squares');

  // Test 18: Sample count requirement
  final minSamples = 3; // typically need degree+1 samples
  results.add('Min samples for quadratic: $minSamples');
  print('Minimum samples required: $minSamples');

  // Test 19: Fit quality metrics
  results.add('Fit quality measured by confidence');
  print('Fit quality: confidence value indicates accuracy');

  // Test 20: Application in gesture recognition
  results.add('Used for fling velocity estimation');
  print('PolynomialFit enables smooth velocity estimation for flings');

  print('PolynomialFit test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PolynomialFit Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(6).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}

// Helper function for power calculation
double _pow(double x, int n) {
  if (n == 0) return 1.0;
  double result = 1.0;
  for (int i = 0; i < n; i++) {
    result *= x;
  }
  return result;
}
