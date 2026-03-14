// D4rt test script: Tests FittedSizes from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FittedSizes test executing');
  final results = <String>[];

  // ========== Basic FittedSizes Tests ==========
  print('Testing FittedSizes constructor...');

  // Test 1: Create FittedSizes with source and destination
  final sourceSize1 = Size(200.0, 100.0);
  final destSize1 = Size(100.0, 50.0);
  final fitted1 = FittedSizes(sourceSize1, destSize1);
  assert(fitted1.source == sourceSize1, 'Source should match');
  assert(fitted1.destination == destSize1, 'Destination should match');
  results.add(
    'FittedSizes: source=${fitted1.source}, dest=${fitted1.destination}',
  );
  print('FittedSizes created: ${fitted1.source} -> ${fitted1.destination}');

  // Test 2: Square sizes
  final sourceSize2 = Size(150.0, 150.0);
  final destSize2 = Size(75.0, 75.0);
  final fitted2 = FittedSizes(sourceSize2, destSize2);
  assert(
    fitted2.source.width == fitted2.source.height,
    'Source should be square',
  );
  assert(
    fitted2.destination.width == fitted2.destination.height,
    'Dest should be square',
  );
  results.add(
    'Square FittedSizes: ${fitted2.source} -> ${fitted2.destination}',
  );
  print('Square: ${fitted2.source} -> ${fitted2.destination}');

  // Test 3: Different aspect ratios
  final sourceSize3 = Size(400.0, 300.0); // 4:3
  final destSize3 = Size(160.0, 90.0); // 16:9
  final fitted3 = FittedSizes(sourceSize3, destSize3);
  results.add('Different ratios: ${fitted3.source} -> ${fitted3.destination}');
  print('Different ratios: ${fitted3.source} -> ${fitted3.destination}');

  // ========== applyBoxFit Tests ==========
  print('Testing applyBoxFit function...');

  // Test 4: BoxFit.contain - fits inside preserving aspect ratio
  final inputSize = Size(800.0, 600.0);
  final outputBox = Size(400.0, 400.0);
  final containResult = applyBoxFit(BoxFit.contain, inputSize, outputBox);
  assert(
    containResult.source == inputSize,
    'Contain source should be full input',
  );
  results.add(
    'BoxFit.contain: source=${containResult.source}, dest=${containResult.destination}',
  );
  print('Contain: ${containResult.destination}');

  // Test 5: BoxFit.cover - covers fully, may clip
  final coverResult = applyBoxFit(BoxFit.cover, inputSize, outputBox);
  results.add(
    'BoxFit.cover: source=${coverResult.source}, dest=${coverResult.destination}',
  );
  print('Cover: ${coverResult.destination}');

  // Test 6: BoxFit.fill - stretches to fill
  final fillResult = applyBoxFit(BoxFit.fill, inputSize, outputBox);
  assert(fillResult.destination == outputBox, 'Fill should use full output');
  results.add(
    'BoxFit.fill: source=${fillResult.source}, dest=${fillResult.destination}',
  );
  print('Fill: ${fillResult.destination}');

  // Test 7: BoxFit.fitWidth
  final fitWidthResult = applyBoxFit(BoxFit.fitWidth, inputSize, outputBox);
  results.add('BoxFit.fitWidth: dest=${fitWidthResult.destination}');
  print('FitWidth: ${fitWidthResult.destination}');

  // Test 8: BoxFit.fitHeight
  final fitHeightResult = applyBoxFit(BoxFit.fitHeight, inputSize, outputBox);
  results.add('BoxFit.fitHeight: dest=${fitHeightResult.destination}');
  print('FitHeight: ${fitHeightResult.destination}');

  // Test 9: BoxFit.none - no scaling
  final noneResult = applyBoxFit(BoxFit.none, inputSize, outputBox);
  results.add('BoxFit.none: dest=${noneResult.destination}');
  print('None: ${noneResult.destination}');

  // Test 10: BoxFit.scaleDown
  final scaleDownResult = applyBoxFit(BoxFit.scaleDown, inputSize, outputBox);
  results.add('BoxFit.scaleDown: dest=${scaleDownResult.destination}');
  print('ScaleDown: ${scaleDownResult.destination}');

  // ========== All BoxFit Values ==========
  print('Testing all BoxFit values...');

  for (final fit in BoxFit.values) {
    final result = applyBoxFit(fit, Size(1920.0, 1080.0), Size(300.0, 200.0));
    results.add(
      'BoxFit.${fit.name}: ${result.destination.width.toStringAsFixed(1)}x${result.destination.height.toStringAsFixed(1)}',
    );
    print('BoxFit.${fit.name}: ${result.destination}');
  }

  // ========== Edge Cases ==========
  print('Testing edge cases...');

  // Test 11: Zero destination
  final zeroDestResult = applyBoxFit(
    BoxFit.contain,
    Size(100.0, 100.0),
    Size.zero,
  );
  results.add('Zero dest: ${zeroDestResult.destination}');
  print('Zero dest: ${zeroDestResult.destination}');

  // Test 12: Very small source
  final smallResult = applyBoxFit(
    BoxFit.contain,
    Size(1.0, 1.0),
    Size(100.0, 100.0),
  );
  results.add('Small source: ${smallResult.destination}');
  print('Small source: ${smallResult.destination}');

  // Test 13: Very large source
  final largeResult = applyBoxFit(
    BoxFit.contain,
    Size(10000.0, 10000.0),
    Size(100.0, 100.0),
  );
  results.add('Large source: ${largeResult.destination}');
  print('Large source: ${largeResult.destination}');

  // ========== Aspect Ratio Calculations ==========
  print('Testing aspect ratio scenarios...');

  final aspectRatios = [
    {'w': 16.0, 'h': 9.0, 'name': '16:9'},
    {'w': 4.0, 'h': 3.0, 'name': '4:3'},
    {'w': 1.0, 'h': 1.0, 'name': '1:1'},
    {'w': 9.0, 'h': 16.0, 'name': '9:16'},
    {'w': 21.0, 'h': 9.0, 'name': '21:9'},
  ];

  for (final ar in aspectRatios) {
    final sourceAR = Size((ar['w'] as double) * 100, (ar['h'] as double) * 100);
    final result = applyBoxFit(BoxFit.contain, sourceAR, Size(200.0, 200.0));
    results.add(
      'Aspect ${ar['name']}: ${result.destination.width.toStringAsFixed(0)}x${result.destination.height.toStringAsFixed(0)}',
    );
    print('${ar['name']}: ${result.destination}');
  }

  // ========== FittedSizes Equality ==========
  print('Testing FittedSizes equality...');

  final fittedA = FittedSizes(Size(10.0, 10.0), Size(5.0, 5.0));
  final fittedB = FittedSizes(Size(10.0, 10.0), Size(5.0, 5.0));
  final fittedC = FittedSizes(Size(10.0, 10.0), Size(6.0, 6.0));

  assert(fittedA.source == fittedB.source, 'Sources should match');
  assert(
    fittedA.destination == fittedB.destination,
    'Destinations should match',
  );
  results.add(
    'Equality: A==B (same) ${fittedA.source == fittedB.source && fittedA.destination == fittedB.destination}',
  );
  results.add(
    'Inequality: A!=C (diff dest) ${fittedA.destination != fittedC.destination}',
  );
  print('Equality tests completed');

  print('FittedSizes test completed: ${results.length} tests passed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'FittedSizes Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Text('Total tests: ${results.length}', style: TextStyle(fontSize: 14)),
      Divider(),
      ...results.map(
        (r) => Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Text(r, style: TextStyle(fontSize: 11)),
        ),
      ),
    ],
  );
}
