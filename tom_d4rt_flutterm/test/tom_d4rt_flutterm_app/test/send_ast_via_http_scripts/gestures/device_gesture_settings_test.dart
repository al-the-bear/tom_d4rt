import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

void _expectCondition(bool condition, String message) {
  if (!condition) {
    throw StateError('Assertion failed: $message');
  }
  print('✅ $message');
}

String _describeSettings(DeviceGestureSettings settings) {
  return 'touchSlop=${settings.touchSlop}, hashCode=${settings.hashCode}';
}

double _average(List<double> values) {
  if (values.isEmpty) {
    return 0;
  }
  final sum = values.reduce((left, right) => left + right);
  return sum / values.length;
}

List<DeviceGestureSettings> _createSamples() {
  return const [
    DeviceGestureSettings(touchSlop: 18.0),
    DeviceGestureSettings(touchSlop: 24.0),
    DeviceGestureSettings(touchSlop: null),
    DeviceGestureSettings(touchSlop: 0.0),
    DeviceGestureSettings(touchSlop: -0.5),
    DeviceGestureSettings(touchSlop: 10000.0),
  ];
}

dynamic build(BuildContext context) {
  print('--- DeviceGestureSettings comprehensive test start ---');

  final samples = _createSamples();
  print('DeviceGestureSettings sample count: ${samples.length}');
  for (final sample in samples) {
    print('Sample -> ${_describeSettings(sample)}');
  }

  _expectCondition(samples.length == 6, 'Created expected number of settings samples');

  final baseA = const DeviceGestureSettings(touchSlop: 18.0);
  final baseB = const DeviceGestureSettings(touchSlop: 18.0);
  final variant = const DeviceGestureSettings(touchSlop: 24.0);
  final nullable = const DeviceGestureSettings(touchSlop: null);

  _expectCondition(baseA.touchSlop == 18.0, 'baseA stores touchSlop 18.0');
  _expectCondition(baseB.touchSlop == 18.0, 'baseB stores touchSlop 18.0');
  _expectCondition(variant.touchSlop == 24.0, 'variant stores touchSlop 24.0');
  _expectCondition(nullable.touchSlop == null, 'nullable settings store null touchSlop');

  _expectCondition(baseA == baseB, 'Equal values compare equal');
  _expectCondition(baseA.hashCode == baseB.hashCode, 'Equal values have same hashCode');
  _expectCondition(baseA != variant, 'Different values compare unequal');
  _expectCondition(baseA.toString().contains('18'), 'toString includes touchSlop value');

  final touchSlopValues = samples.map((sample) => sample.touchSlop).toList(growable: false);
  final nonNullValues = touchSlopValues.whereType<double>().toList(growable: false);

  print('touchSlop values: $touchSlopValues');
  print('non-null touchSlop values: $nonNullValues');

  _expectCondition(touchSlopValues.length == samples.length, 'touchSlop extraction keeps sample count');
  _expectCondition(nonNullValues.length == samples.length - 1, 'Exactly one sample has null touchSlop');
  _expectCondition(nonNullValues.contains(0.0), 'Edge case 0.0 touchSlop is represented');
  _expectCondition(nonNullValues.any((value) => value < 0), 'Negative touchSlop sample is represented');
  _expectCondition(nonNullValues.any((value) => value > 1000), 'Large touchSlop sample is represented');

  final sorted = [...nonNullValues]..sort();
  _expectCondition(sorted.first == -0.5, 'Sorted non-null values start with negative edge');
  _expectCondition(sorted.last == 10000.0, 'Sorted non-null values end with large edge');

  final average = _average(nonNullValues);
  final median = sorted[sorted.length ~/ 2];
  print('touchSlop average: $average');
  print('touchSlop median candidate: $median');
  _expectCondition(average > 0, 'Average remains positive with one negative sample');
  _expectCondition(median == 18.0, 'Median candidate reflects central value');

  final mediaQuery = MediaQueryData(gestureSettings: baseA);
  _expectCondition(mediaQuery.gestureSettings == baseA, 'MediaQueryData stores gestureSettings value');

  final reconstructed = DeviceGestureSettings(touchSlop: baseA.touchSlop);
  _expectCondition(reconstructed == baseA, 'Reconstructed settings match original by value');
  _expectCondition(reconstructed.hashCode == baseA.hashCode, 'Reconstructed settings keep matching hashCode');

    final summary =
      'DeviceGestureSettings summary -> count=${samples.length}, nonNull=${nonNullValues.length}, min=${sorted.first}, max=${sorted.last}, avg=$average, median=$median, hasNull=${touchSlopValues.contains(null)}';
  print(summary);
  print('--- DeviceGestureSettings comprehensive test complete ---');

  return Container(
    padding: const EdgeInsets.all(8),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('DeviceGestureSettings Comprehensive Tests'),
        Text('Sample count: ${samples.length}'),
        Text('Touch slops: $touchSlopValues'),
        Text('Non-null count: ${nonNullValues.length}'),
        Text('Min non-null: ${sorted.first}'),
        Text('Max non-null: ${sorted.last}'),
        Text('Average non-null: $average'),
        Text('Median candidate: $median'),
        Text('Contains null: ${touchSlopValues.contains(null)}'),
        Text('baseA == baseB: ${baseA == baseB}'),
        Text('baseA != variant: ${baseA != variant}'),
        Text(summary),
      ],
    ),
  );
}
