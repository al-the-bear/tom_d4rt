// D4rt test script: Tests FractionalOffsetTween from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/animation.dart';

dynamic build(BuildContext context) {
  print('FractionalOffsetTween test executing');

  // ========== Basic FractionalOffsetTween creation ==========
  print('--- Basic FractionalOffsetTween ---');
  final tween1 = FractionalOffsetTween(
    begin: FractionalOffset.topLeft,
    end: FractionalOffset.bottomRight,
  );
  print('  created: ${tween1.runtimeType}');
  print('  begin: ${tween1.begin}');
  print('  end: ${tween1.end}');

  // ========== Lerp at different values ==========
  print('--- Lerp at different t values ---');
  print('  lerp(0.0): ${tween1.lerp(0.0)}');
  print('  lerp(0.25): ${tween1.lerp(0.25)}');
  print('  lerp(0.5): ${tween1.lerp(0.5)}');
  print('  lerp(0.75): ${tween1.lerp(0.75)}');
  print('  lerp(1.0): ${tween1.lerp(1.0)}');

  // ========== Transform method ==========
  print('--- Transform method ---');
  print('  transform(0.0): ${tween1.transform(0.0)}');
  print('  transform(0.5): ${tween1.transform(0.5)}');
  print('  transform(1.0): ${tween1.transform(1.0)}');

  // ========== Different FractionalOffset values ==========
  print('--- Different FractionalOffset values ---');
  final tween2 = FractionalOffsetTween(
    begin: FractionalOffset(0.0, 0.0),
    end: FractionalOffset(1.0, 1.0),
  );
  print('  tween2 begin: ${tween2.begin}');
  print('  tween2 end: ${tween2.end}');
  print('  tween2.lerp(0.5): ${tween2.lerp(0.5)}');

  final tween3 = FractionalOffsetTween(
    begin: FractionalOffset(-0.5, -0.5),
    end: FractionalOffset(1.5, 1.5),
  );
  print('  tween3 begin: ${tween3.begin}');
  print('  tween3 end: ${tween3.end}');
  print('  tween3.lerp(0.5): ${tween3.lerp(0.5)}');

  // ========== Named FractionalOffset constants ==========
  print('--- Named FractionalOffset constants ---');
  final tweenCenter = FractionalOffsetTween(
    begin: FractionalOffset.center,
    end: FractionalOffset.bottomCenter,
  );
  print('  center to bottomCenter');
  print('  begin: ${tweenCenter.begin}');
  print('  end: ${tweenCenter.end}');
  print('  lerp(0.5): ${tweenCenter.lerp(0.5)}');

  final tweenCorners = FractionalOffsetTween(
    begin: FractionalOffset.topRight,
    end: FractionalOffset.bottomLeft,
  );
  print('  topRight to bottomLeft');
  print('  lerp(0.5): ${tweenCorners.lerp(0.5)}');

  // ========== Chain method ==========
  print('--- Chain method ---');
  final chainedTween = tween1.chain(CurveTween(curve: Curves.easeInOut));
  print('  chained tween created: ${chainedTween.runtimeType}');

  // ========== Null begin/end handling ==========
  print('--- Null handling ---');
  final tweenNullBegin = FractionalOffsetTween(
    begin: null,
    end: FractionalOffset.center,
  );
  print('  null begin tween.end: ${tweenNullBegin.end}');

  final tweenNullEnd = FractionalOffsetTween(
    begin: FractionalOffset.center,
    end: null,
  );
  print('  null end tween.begin: ${tweenNullEnd.begin}');

  print('FractionalOffsetTween test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('FractionalOffsetTween Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Basic tween: ${tween1.runtimeType}'),
          Text('Begin: ${tween1.begin}'),
          Text('End: ${tween1.end}'),
          Text('Lerp(0.0): ${tween1.lerp(0.0)}'),
          Text('Lerp(0.5): ${tween1.lerp(0.5)}'),
          Text('Lerp(1.0): ${tween1.lerp(1.0)}'),
          Text('Center to bottom: ${tweenCenter.lerp(0.5)}'),
        ],
      ),
    ),
  );
}
