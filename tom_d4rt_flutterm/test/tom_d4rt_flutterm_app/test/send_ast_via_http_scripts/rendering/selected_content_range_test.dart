// D4rt test script: Tests SelectedContentRange from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectedContentRange test executing');

  // ========== Basic SelectedContentRange creation ==========
  print('--- Basic SelectedContentRange ---');
  final range1 = SelectedContentRange(startOffset: 0, endOffset: 10);
  print('  created: ${range1.runtimeType}');
  print('  startOffset: ${range1.startOffset}');
  print('  endOffset: ${range1.endOffset}');

  // ========== Different start/end values ==========
  print('--- Different start/end values ---');
  final rangeZeroZero = SelectedContentRange(startOffset: 0, endOffset: 0);
  final rangeLarge = SelectedContentRange(startOffset: 1000, endOffset: 5000);
  final rangeSmall = SelectedContentRange(startOffset: 5, endOffset: 6);
  print(
    '  zero range: ${rangeZeroZero.startOffset} to ${rangeZeroZero.endOffset}',
  );
  print('  large range: ${rangeLarge.startOffset} to ${rangeLarge.endOffset}');
  print('  small range: ${rangeSmall.startOffset} to ${rangeSmall.endOffset}');

  // ========== Calculate range length ==========
  print('--- Range length calculations ---');
  print('  range1 length: ${range1.endOffset - range1.startOffset}');
  print(
    '  zeroZero length: ${rangeZeroZero.endOffset - rangeZeroZero.startOffset}',
  );
  print('  large length: ${rangeLarge.endOffset - rangeLarge.startOffset}');
  print('  small length: ${rangeSmall.endOffset - rangeSmall.startOffset}');

  // ========== Check if range is empty ==========
  print('--- Empty range check ---');
  final isEmpty1 = range1.startOffset == range1.endOffset;
  final isEmpty2 = rangeZeroZero.startOffset == rangeZeroZero.endOffset;
  print('  range1 isEmpty: $isEmpty1');
  print('  rangeZeroZero isEmpty: $isEmpty2');

  // ========== Multiple ranges ==========
  print('--- Multiple ranges ---');
  final ranges = [
    SelectedContentRange(startOffset: 0, endOffset: 50),
    SelectedContentRange(startOffset: 50, endOffset: 100),
    SelectedContentRange(startOffset: 100, endOffset: 200),
    SelectedContentRange(startOffset: 200, endOffset: 250),
  ];
  print('  Created ${ranges.length} ranges');
  for (var i = 0; i < ranges.length; i++) {
    print('  [$i] ${ranges[i].startOffset} to ${ranges[i].endOffset}');
  }

  // ========== Check contiguous ranges ==========
  print('--- Contiguous range check ---');
  for (var i = 0; i < ranges.length - 1; i++) {
    final isContiguous = ranges[i].endOffset == ranges[i + 1].startOffset;
    print('  ranges[$i] -> ranges[${i + 1}] contiguous: $isContiguous');
  }

  // ========== Equality behavior ==========
  print('--- Equality behavior ---');
  final rangeA = SelectedContentRange(startOffset: 10, endOffset: 20);
  final rangeB = SelectedContentRange(startOffset: 10, endOffset: 20);
  final rangeC = SelectedContentRange(startOffset: 10, endOffset: 30);
  print('  rangeA == rangeA: ${rangeA == rangeA}');
  print('  rangeA == rangeB: ${rangeA == rangeB}');
  print('  rangeA == rangeC: ${rangeA == rangeC}');
  print(
    '  rangeA.startOffset == rangeB.startOffset: ${rangeA.startOffset == rangeB.startOffset}',
  );
  print(
    '  rangeA.endOffset == rangeB.endOffset: ${rangeA.endOffset == rangeB.endOffset}',
  );

  // ========== HashCode ==========
  print('--- HashCode ---');
  print('  rangeA.hashCode: ${rangeA.hashCode}');
  print('  rangeB.hashCode: ${rangeB.hashCode}');
  print('  rangeC.hashCode: ${rangeC.hashCode}');

  // ========== ToString ==========
  print('--- ToString ---');
  print('  range1.toString(): ${range1.toString()}');
  print('  rangeA.toString(): ${rangeA.toString()}');

  // ========== Range with single character ==========
  print('--- Single character ranges ---');
  final singleChar = SelectedContentRange(startOffset: 100, endOffset: 101);
  print(
    '  single char range: ${singleChar.startOffset} to ${singleChar.endOffset}',
  );
  print('  length: ${singleChar.endOffset - singleChar.startOffset}');

  print('SelectedContentRange test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'SelectedContentRange Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Basic range: ${range1.startOffset} to ${range1.endOffset}'),
          Text('Range length: ${range1.endOffset - range1.startOffset}'),
          Text(
            'Zero range length: ${rangeZeroZero.endOffset - rangeZeroZero.startOffset}',
          ),
          Text(
            'Large range: ${rangeLarge.startOffset} to ${rangeLarge.endOffset}',
          ),
          Text('Ranges created: ${ranges.length}'),
        ],
      ),
    ),
  );
}
