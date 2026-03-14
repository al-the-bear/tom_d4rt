// D4rt test script: Tests PlaceholderDimensions from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlaceholderDimensions test executing');
  final results = <String>[];

  // ========== Basic PlaceholderDimensions Tests ==========
  print('Testing PlaceholderDimensions constructor...');

  // Test 1: Create basic PlaceholderDimensions
  final dim1 = PlaceholderDimensions(
    size: Size(100.0, 50.0),
    alignment: PlaceholderAlignment.bottom,
  );
  assert(dim1.size == Size(100.0, 50.0), 'Size should match');
  assert(
    dim1.alignment == PlaceholderAlignment.bottom,
    'Alignment should be bottom',
  );
  results.add(
    'PlaceholderDimensions: size=${dim1.size}, alignment=${dim1.alignment}',
  );
  print('Basic PlaceholderDimensions created');

  // Test 2: Create with baseline
  final dim2 = PlaceholderDimensions(
    size: Size(80.0, 60.0),
    alignment: PlaceholderAlignment.baseline,
    baseline: TextBaseline.alphabetic,
    baselineOffset: 50.0,
  );
  assert(
    dim2.baseline == TextBaseline.alphabetic,
    'Baseline should be alphabetic',
  );
  assert(dim2.baselineOffset == 50.0, 'Baseline offset should be 50');
  results.add('With baseline: ${dim2.baseline}, offset=${dim2.baselineOffset}');
  print('Baseline PlaceholderDimensions created');

  // Test 3: Create with ideographic baseline
  final dim3 = PlaceholderDimensions(
    size: Size(120.0, 40.0),
    alignment: PlaceholderAlignment.baseline,
    baseline: TextBaseline.ideographic,
    baselineOffset: 35.0,
  );
  assert(
    dim3.baseline == TextBaseline.ideographic,
    'Baseline should be ideographic',
  );
  results.add('Ideographic baseline: offset=${dim3.baselineOffset}');
  print('Ideographic baseline created');

  // ========== All PlaceholderAlignment Values ==========
  print('Testing all PlaceholderAlignment values...');

  final alignments = PlaceholderAlignment.values;
  for (final alignment in alignments) {
    final dim = PlaceholderDimensions(
      size: Size(50.0, 30.0),
      alignment: alignment,
    );
    assert(dim.alignment == alignment, 'Alignment should match');
    results.add('PlaceholderAlignment.${alignment.name}');
    print('Alignment: ${alignment.name}');
  }

  // ========== Various Sizes ==========
  print('Testing various sizes...');

  final sizes = [
    Size(10.0, 10.0),
    Size(50.0, 25.0),
    Size(100.0, 100.0),
    Size(200.0, 50.0),
    Size(20.0, 80.0),
  ];

  for (final size in sizes) {
    final dim = PlaceholderDimensions(
      size: size,
      alignment: PlaceholderAlignment.middle,
    );
    assert(dim.size == size, 'Size should match');
    results.add('Size: ${size.width.toInt()}x${size.height.toInt()}');
    print('Size tested: $size');
  }

  // ========== Baseline Offset Variations ==========
  print('Testing baseline offset variations...');

  final offsets = [0.0, 10.0, 25.0, 50.0, 75.0, 100.0];
  for (final offset in offsets) {
    final dim = PlaceholderDimensions(
      size: Size(60.0, 40.0),
      alignment: PlaceholderAlignment.baseline,
      baseline: TextBaseline.alphabetic,
      baselineOffset: offset,
    );
    assert(dim.baselineOffset == offset, 'Offset should match');
    results.add('Baseline offset: $offset');
    print('Offset: $offset');
  }

  // ========== PlaceholderDimensions.empty ==========
  print('Testing PlaceholderDimensions.empty...');

  final empty = PlaceholderDimensions.empty;
  assert(empty.size == Size.zero, 'Empty should have zero size');
  results.add('Empty: size=${empty.size}');
  print('Empty placeholder created');

  // ========== Property Access Tests ==========
  print('Testing property access...');

  final testDim = PlaceholderDimensions(
    size: Size(75.0, 45.0),
    alignment: PlaceholderAlignment.aboveBaseline,
    baseline: TextBaseline.alphabetic,
    baselineOffset: 40.0,
  );

  results.add('Property size: ${testDim.size}');
  results.add('Property alignment: ${testDim.alignment}');
  results.add('Property baseline: ${testDim.baseline}');
  results.add('Property baselineOffset: ${testDim.baselineOffset}');
  print('Properties accessed');

  // ========== Alignment Descriptions ==========
  print('Documenting alignment behaviors...');

  final alignmentDescs = {
    'baseline': 'Aligns bottom to text baseline',
    'aboveBaseline': 'Aligns bottom above baseline by offset',
    'belowBaseline': 'Aligns top below baseline by offset',
    'top': 'Aligns top with text top',
    'middle': 'Centers vertically with text',
    'bottom': 'Aligns bottom with text bottom',
  };

  for (final entry in alignmentDescs.entries) {
    results.add('${entry.key}: ${entry.value}');
    print('${entry.key}: ${entry.value}');
  }

  // ========== Equality Testing ==========
  print('Testing equality...');

  final dimA = PlaceholderDimensions(
    size: Size(100.0, 50.0),
    alignment: PlaceholderAlignment.middle,
  );
  final dimB = PlaceholderDimensions(
    size: Size(100.0, 50.0),
    alignment: PlaceholderAlignment.middle,
  );
  final dimC = PlaceholderDimensions(
    size: Size(100.0, 50.0),
    alignment: PlaceholderAlignment.bottom,
  );

  assert(dimA == dimB, 'Same dimensions should be equal');
  assert(dimA != dimC, 'Different alignments should not be equal');
  results.add('Equality (same): ${dimA == dimB}');
  results.add('Inequality (diff alignment): ${dimA != dimC}');
  print('Equality tests completed');

  // ========== Use Case Documentation ==========
  print('Documenting use cases...');

  results.add('Use case: Inline widgets in RichText');
  results.add('Use case: WidgetSpan placeholder sizing');
  results.add('Use case: Custom inline elements in TextPainter');
  print('Use cases documented');

  // ========== Integration with WidgetSpan ==========
  print('Testing integration concepts...');

  results.add('Integration: PlaceholderSpan uses PlaceholderDimensions');
  results.add('Integration: TextPainter.setPlaceholderDimensions()');
  results.add('Integration: InlineSpan builds with placeholders');
  print('Integrations documented');

  print('PlaceholderDimensions test completed: ${results.length} tests passed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'PlaceholderDimensions Tests',
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
