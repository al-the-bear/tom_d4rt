// ignore_for_file: avoid_print
// D4rt test script: Tests BoxConstraints from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Rendering BoxConstraints test executing');

  // ========== BOXCONSTRAINTS ==========
  print('--- BoxConstraints Tests ---');

  // Test BoxConstraints() default
  final defaultConstraints = BoxConstraints();
  print(
    'BoxConstraints() default: minW=${defaultConstraints.minWidth}, maxW=${defaultConstraints.maxWidth}',
  );
  print(
    '  minH=${defaultConstraints.minHeight}, maxH=${defaultConstraints.maxHeight}',
  );

  // Test BoxConstraints with all values
  final fullConstraints = BoxConstraints(
    minWidth: 50.0,
    maxWidth: 200.0,
    minHeight: 30.0,
    maxHeight: 150.0,
  );
  print(
    'Full constraints: minW=${fullConstraints.minWidth}, maxW=${fullConstraints.maxWidth}',
  );
  print(
    '  minH=${fullConstraints.minHeight}, maxH=${fullConstraints.maxHeight}',
  );

  // Test BoxConstraints.tight
  final tightConstraints = BoxConstraints.tight(Size(100.0, 80.0));
  print(
    'BoxConstraints.tight(100x80): minW=${tightConstraints.minWidth}, maxW=${tightConstraints.maxWidth}',
  );
  print('  isTight=${tightConstraints.isTight}');

  // Test BoxConstraints.tightFor
  final tightForWidthConstraints = BoxConstraints.tightFor(width: 100.0);
  print(
    'BoxConstraints.tightFor(width: 100): width=${tightForWidthConstraints.minWidth}==${tightForWidthConstraints.maxWidth}',
  );

  final tightForHeightConstraints = BoxConstraints.tightFor(height: 80.0);
  print(
    'BoxConstraints.tightFor(height: 80): height=${tightForHeightConstraints.minHeight}==${tightForHeightConstraints.maxHeight}',
  );

  final tightForBothConstraints = BoxConstraints.tightFor(
    width: 100.0,
    height: 80.0,
  );
  print(
    'BoxConstraints.tightFor(both): ${tightForBothConstraints.minWidth}x${tightForBothConstraints.minHeight}',
  );

  // Test BoxConstraints.tightForFinite
  final tightFiniteConstraints = BoxConstraints.tightForFinite(
    width: 100.0,
    height: 80.0,
  );
  print(
    'BoxConstraints.tightForFinite: ${tightFiniteConstraints.minWidth}x${tightFiniteConstraints.minHeight}',
  );

  // Test BoxConstraints.loose
  final looseConstraints = BoxConstraints.loose(Size(200.0, 150.0));
  print(
    'BoxConstraints.loose(200x150): minW=${looseConstraints.minWidth}, maxW=${looseConstraints.maxWidth}',
  );
  print(
    '  hasInfiniteWidth=${looseConstraints.hasInfiniteWidth}, hasInfiniteHeight=${looseConstraints.hasInfiniteHeight}',
  );

  // Test BoxConstraints.expand
  final expandConstraints = BoxConstraints.expand();
  print(
    'BoxConstraints.expand(): isInfinite for both: ${expandConstraints.maxWidth.isInfinite && expandConstraints.maxHeight.isInfinite}',
  );

  final expandWidthConstraints = BoxConstraints.expand(width: 100.0);
  print(
    'BoxConstraints.expand(width: 100): width=${expandWidthConstraints.minWidth}',
  );

  final expandHeightConstraints = BoxConstraints.expand(height: 80.0);
  print(
    'BoxConstraints.expand(height: 80): height=${expandHeightConstraints.minHeight}',
  );

  // Test isTight property
  print('isTight for tight: ${tightConstraints.isTight}');
  print('isTight for loose: ${looseConstraints.isTight}');

  // Test isNormalized property
  final normalizedConstraints = BoxConstraints(minWidth: 50.0, maxWidth: 100.0);
  print('isNormalized (normal): ${normalizedConstraints.isNormalized}');

  // Test hasBoundedWidth/hasBoundedHeight
  print('hasBoundedWidth (tight): ${tightConstraints.hasBoundedWidth}');
  print('hasBoundedHeight (tight): ${tightConstraints.hasBoundedHeight}');
  print('hasBoundedWidth (expand): ${expandConstraints.hasBoundedWidth}');
  print('hasBoundedHeight (expand): ${expandConstraints.hasBoundedHeight}');

  // Test hasInfiniteWidth/hasInfiniteHeight
  print('hasInfiniteWidth (expand): ${expandConstraints.hasInfiniteWidth}');
  print('hasInfiniteHeight (expand): ${expandConstraints.hasInfiniteHeight}');
  print('hasInfiniteWidth (tight): ${tightConstraints.hasInfiniteWidth}');

  // Test constrain method
  final constrainBase = BoxConstraints(
    minWidth: 50.0,
    maxWidth: 150.0,
    minHeight: 30.0,
    maxHeight: 100.0,
  );
  final constrainedSmall = constrainBase.constrain(Size(10.0, 10.0));
  print(
    'constrain(10x10): ${constrainedSmall.width}x${constrainedSmall.height}',
  );

  final constrainedLarge = constrainBase.constrain(Size(200.0, 200.0));
  print(
    'constrain(200x200): ${constrainedLarge.width}x${constrainedLarge.height}',
  );

  final constrainedNormal = constrainBase.constrain(Size(100.0, 60.0));
  print(
    'constrain(100x60): ${constrainedNormal.width}x${constrainedNormal.height}',
  );

  // Test constrainWidth
  print('constrainWidth(10): ${constrainBase.constrainWidth(10.0)}');
  print('constrainWidth(200): ${constrainBase.constrainWidth(200.0)}');
  print('constrainWidth(100): ${constrainBase.constrainWidth(100.0)}');

  // Test constrainHeight
  print('constrainHeight(10): ${constrainBase.constrainHeight(10.0)}');
  print('constrainHeight(200): ${constrainBase.constrainHeight(200.0)}');
  print('constrainHeight(60): ${constrainBase.constrainHeight(60.0)}');

  // Test constrainDimensions
  final constrainedDims = constrainBase.constrainDimensions(100.0, 60.0);
  print(
    'constrainDimensions(100, 60): ${constrainedDims.width}x${constrainedDims.height}',
  );

  // Test constrainSizeAndAttemptToPreserveAspectRatio
  final aspectPreserved = constrainBase
      .constrainSizeAndAttemptToPreserveAspectRatio(Size(300.0, 200.0));
  print(
    'constrainAspectRatio(300x200): ${aspectPreserved.width}x${aspectPreserved.height}',
  );

  // Test deflate
  final deflated = fullConstraints.deflate(EdgeInsets.all(10.0));
  print('deflate(10): minW=${deflated.minWidth}, maxW=${deflated.maxWidth}');

  // Test copyWith
  final copied = fullConstraints.copyWith(minWidth: 100.0, maxHeight: 200.0);
  print(
    'copyWith(minW=100, maxH=200): minW=${copied.minWidth}, maxH=${copied.maxHeight}',
  );

  // Test enforce
  final enforceBase = BoxConstraints(
    minWidth: 0.0,
    maxWidth: 300.0,
    minHeight: 0.0,
    maxHeight: 300.0,
  );
  final enforcedConstraints = BoxConstraints(
    minWidth: 50.0,
    maxWidth: 100.0,
    minHeight: 30.0,
    maxHeight: 80.0,
  );
  final enforced = enforceBase.enforce(enforcedConstraints);
  print('enforce: minW=${enforced.minWidth}, maxW=${enforced.maxWidth}');
  print('  minH=${enforced.minHeight}, maxH=${enforced.maxHeight}');

  // Test tighten
  final tightened = looseConstraints.tighten(width: 100.0, height: 80.0);
  print(
    'tighten(100, 80): minW=${tightened.minWidth}, maxW=${tightened.maxWidth}',
  );

  // Test loosen
  final loosened = tightConstraints.loosen();
  print('loosen(tight): minW=${loosened.minWidth}, maxW=${loosened.maxWidth}');

  // Test normalize
  final normalized = BoxConstraints(
    minWidth: 100.0,
    maxWidth: 50.0,
  ).normalize();
  print(
    'normalize(minW>maxW): minW=${normalized.minWidth}, maxW=${normalized.maxWidth}',
  );

  // Test flipped
  final flipped = BoxConstraints(
    minWidth: 50.0,
    maxWidth: 100.0,
    minHeight: 30.0,
    maxHeight: 80.0,
  ).flipped;
  print('flipped: minW=${flipped.minWidth}, maxW=${flipped.maxWidth}');
  print('  minH=${flipped.minHeight}, maxH=${flipped.maxHeight}');

  // Test biggest/smallest properties
  print('biggest (full): ${fullConstraints.biggest}');
  print('smallest (full): ${fullConstraints.smallest}');

  // Test isSatisfiedBy
  print(
    'isSatisfiedBy(100x60): ${constrainBase.isSatisfiedBy(Size(100.0, 60.0))}',
  );
  print(
    'isSatisfiedBy(10x10): ${constrainBase.isSatisfiedBy(Size(10.0, 10.0))}',
  );

  // Test == and hashCode
  final c1 = BoxConstraints(minWidth: 50.0, maxWidth: 100.0);
  final c2 = BoxConstraints(minWidth: 50.0, maxWidth: 100.0);
  final c3 = BoxConstraints(minWidth: 60.0, maxWidth: 100.0);
  print('equality (same): ${c1 == c2}');
  print('equality (different): ${c1 == c3}');
  print('hashCode match: ${c1.hashCode == c2.hashCode}');

  // Test BoxConstraints.lerp
  final lerpStart = BoxConstraints(
    minWidth: 0.0,
    maxWidth: 100.0,
    minHeight: 0.0,
    maxHeight: 100.0,
  );
  final lerpEnd = BoxConstraints(
    minWidth: 50.0,
    maxWidth: 200.0,
    minHeight: 50.0,
    maxHeight: 200.0,
  );
  final lerped = BoxConstraints.lerp(lerpStart, lerpEnd, 0.5);
  print('lerp at 0.5: minW=${lerped?.minWidth}, maxW=${lerped?.maxWidth}');

  print('Rendering BoxConstraints test completed');

  // Return a visual representation
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BoxConstraints Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text(
              'Tight Constraints (100x80):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              constraints: BoxConstraints.tight(Size(100.0, 80.0)),
              color: Color(0xFF2196F3),
              child: Center(
                child: Text(
                  '100x80',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
            SizedBox(height: 8.0),

            Text(
              'Loose Constraints (max 150x100):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              constraints: BoxConstraints.loose(Size(150.0, 100.0)),
              color: Color(0xFFE53935),
              child: Center(
                child: Text(
                  'Max 150x100',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
            SizedBox(height: 8.0),

            Text(
              'Min/Max Constraints:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              constraints: BoxConstraints(
                minWidth: 80.0,
                maxWidth: 200.0,
                minHeight: 40.0,
                maxHeight: 80.0,
              ),
              color: Color(0xFF4CAF50),
              child: Center(
                child: Text(
                  '80-200 x 40-80',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
            SizedBox(height: 8.0),

            Text(
              'TightFor Width:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              constraints: BoxConstraints.tightFor(width: 120.0),
              color: Color(0xFFFF9800),
              child: Center(
                child: Text(
                  'Width 120',
                  style: TextStyle(color: Color(0xFFFFFFFF)),
                ),
              ),
            ),
            SizedBox(height: 8.0),

            Text(
              'Constrain Demo (base: 50-150 x 30-100):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Container(
                      width: 50.0,
                      height: 30.0,
                      color: Color(0xFF9C27B0),
                      child: Text(
                        'Min',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Color(0xFFFFFFFF),
                        ),
                      ),
                    ),
                    Text('50x30', style: TextStyle(fontSize: 10.0)),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 100.0,
                      height: 60.0,
                      color: Color(0xFF9C27B0),
                      child: Center(
                        child: Text(
                          'Mid',
                          style: TextStyle(color: Color(0xFFFFFFFF)),
                        ),
                      ),
                    ),
                    Text('100x60', style: TextStyle(fontSize: 10.0)),
                  ],
                ),
                Column(
                  children: [
                    Container(
                      width: 150.0,
                      height: 100.0,
                      color: Color(0xFF9C27B0),
                      child: Center(
                        child: Text(
                          'Max',
                          style: TextStyle(color: Color(0xFFFFFFFF)),
                        ),
                      ),
                    ),
                    Text('150x100', style: TextStyle(fontSize: 10.0)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
