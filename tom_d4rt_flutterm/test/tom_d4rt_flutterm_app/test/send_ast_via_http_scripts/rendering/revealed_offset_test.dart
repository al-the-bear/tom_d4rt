// D4rt test script: Tests RevealedOffset from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RevealedOffset test executing');

  // ========== Basic RevealedOffset creation ==========
  print('--- Basic RevealedOffset ---');
  final offset1 = RevealedOffset(
    offset: 100.0,
    rect: Rect.fromLTWH(0.0, 100.0, 200.0, 50.0),
  );
  print('  created: ${offset1.runtimeType}');
  print('  offset: ${offset1.offset}');
  print('  rect: ${offset1.rect}');

  // ========== Different offset values ==========
  print('--- Different offset values ---');
  final offsetZero = RevealedOffset(
    offset: 0.0,
    rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
  );
  final offsetNegative = RevealedOffset(
    offset: -50.0,
    rect: Rect.fromLTWH(0.0, -50.0, 100.0, 100.0),
  );
  final offsetLarge = RevealedOffset(
    offset: 10000.0,
    rect: Rect.fromLTWH(0.0, 10000.0, 100.0, 100.0),
  );
  print('  zero offset: ${offsetZero.offset}');
  print('  negative offset: ${offsetNegative.offset}');
  print('  large offset: ${offsetLarge.offset}');

  // ========== Different rect configurations ==========
  print('--- Different rect configurations ---');
  final rectFromLTRB = RevealedOffset(
    offset: 50.0,
    rect: Rect.fromLTRB(10.0, 50.0, 210.0, 150.0),
  );
  print('  rect fromLTRB: ${rectFromLTRB.rect}');
  print('  rect width: ${rectFromLTRB.rect.width}');
  print('  rect height: ${rectFromLTRB.rect.height}');

  final rectFromCenter = RevealedOffset(
    offset: 75.0,
    rect: Rect.fromCenter(
      center: Offset(100.0, 75.0),
      width: 80.0,
      height: 60.0,
    ),
  );
  print('  rect fromCenter: ${rectFromCenter.rect}');
  print('  rect center: ${rectFromCenter.rect.center}');

  // ========== Zero rect ==========
  print('--- Zero rect ---');
  final zeroRect = RevealedOffset(offset: 0.0, rect: Rect.zero);
  print('  rect.isEmpty: ${zeroRect.rect.isEmpty}');
  print('  rect: ${zeroRect.rect}');

  // ========== Rect properties ==========
  print('--- Rect properties from RevealedOffset ---');
  final testOffset = RevealedOffset(
    offset: 200.0,
    rect: Rect.fromLTWH(10.0, 200.0, 150.0, 75.0),
  );
  print('  rect.left: ${testOffset.rect.left}');
  print('  rect.top: ${testOffset.rect.top}');
  print('  rect.right: ${testOffset.rect.right}');
  print('  rect.bottom: ${testOffset.rect.bottom}');
  print('  rect.width: ${testOffset.rect.width}');
  print('  rect.height: ${testOffset.rect.height}');
  print('  rect.topLeft: ${testOffset.rect.topLeft}');
  print('  rect.bottomRight: ${testOffset.rect.bottomRight}');
  print('  rect.size: ${testOffset.rect.size}');

  // ========== Offset relation to rect ==========
  print('--- Offset relation to rect ---');
  print(
    '  offset matches rect.top: ${testOffset.offset == testOffset.rect.top}',
  );
  print('  offset value: ${testOffset.offset}');
  print('  rect.top value: ${testOffset.rect.top}');

  // ========== Multiple RevealedOffsets ==========
  print('--- Multiple RevealedOffsets ---');
  final offsets = [
    RevealedOffset(offset: 0.0, rect: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0)),
    RevealedOffset(
      offset: 100.0,
      rect: Rect.fromLTWH(0.0, 100.0, 100.0, 100.0),
    ),
    RevealedOffset(
      offset: 200.0,
      rect: Rect.fromLTWH(0.0, 200.0, 100.0, 100.0),
    ),
    RevealedOffset(
      offset: 300.0,
      rect: Rect.fromLTWH(0.0, 300.0, 100.0, 100.0),
    ),
  ];
  print('  Created ${offsets.length} RevealedOffsets');
  for (var i = 0; i < offsets.length; i++) {
    print(
      '  [$i] offset: ${offsets[i].offset}, rect.top: ${offsets[i].rect.top}',
    );
  }

  // ========== ToString ==========
  print('--- ToString ---');
  print('  offset1.toString(): ${offset1.toString()}');

  // ========== Equality behavior ==========
  print('--- Equality behavior ---');
  final offsetA = RevealedOffset(
    offset: 100.0,
    rect: Rect.fromLTWH(0.0, 100.0, 50.0, 50.0),
  );
  final offsetB = RevealedOffset(
    offset: 100.0,
    rect: Rect.fromLTWH(0.0, 100.0, 50.0, 50.0),
  );
  print('  offsetA == offsetA: ${offsetA == offsetA}');
  print('  offsetA == offsetB: ${offsetA == offsetB}');
  print(
    '  offsetA.offset == offsetB.offset: ${offsetA.offset == offsetB.offset}',
  );
  print('  offsetA.rect == offsetB.rect: ${offsetA.rect == offsetB.rect}');

  print('RevealedOffset test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'RevealedOffset Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Basic offset: ${offset1.offset}'),
          Text('Basic rect: ${offset1.rect}'),
          Text('Zero offset: ${offsetZero.offset}'),
          Text('Negative offset: ${offsetNegative.offset}'),
          Text('Large offset: ${offsetLarge.offset}'),
          Text('Rect center: ${rectFromCenter.rect.center}'),
          Text('Multiple offsets created: ${offsets.length}'),
        ],
      ),
    ),
  );
}
