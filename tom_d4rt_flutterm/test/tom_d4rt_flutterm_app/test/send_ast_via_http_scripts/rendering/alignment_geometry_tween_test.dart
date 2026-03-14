// D4rt test script: Tests AlignmentGeometryTween from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AlignmentGeometryTween test executing');

  // ========== Basic AlignmentGeometryTween ==========
  print('--- Basic AlignmentGeometryTween ---');
  final tween = AlignmentGeometryTween(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  print('  begin: ${tween.begin}');
  print('  end: ${tween.end}');

  // ========== Lerp at various positions ==========
  print('--- Lerp values ---');
  final values = <(double, AlignmentGeometry?)>[];
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final result = tween.lerp(t);
    values.add((t, result));
    print('  t=$t: $result');
  }

  // ========== Center to corner ==========
  print('--- Center to corner ---');
  final centerToCorner = AlignmentGeometryTween(
    begin: Alignment.center,
    end: Alignment.topRight,
  );
  print('  lerp(0.5): ${centerToCorner.lerp(0.5)}');

  // ========== With Directional alignment ==========
  print('--- AlignmentDirectional ---');
  final directionalTween = AlignmentGeometryTween(
    begin: AlignmentDirectional.centerStart,
    end: AlignmentDirectional.centerEnd,
  );
  print('  begin: ${directionalTween.begin}');
  print('  end: ${directionalTween.end}');
  print('  lerp(0.5): ${directionalTween.lerp(0.5)}');

  // ========== Same alignment ==========
  print('--- Same alignment ---');
  final same = AlignmentGeometryTween(
    begin: Alignment.center,
    end: Alignment.center,
  );
  print('  lerp(0.5): ${same.lerp(0.5)}');

  // ========== Fractional alignments ==========
  print('--- Fractional alignments ---');
  final fractional = AlignmentGeometryTween(
    begin: Alignment(-0.5, -0.5),
    end: Alignment(0.5, 0.5),
  );
  print('  begin: ${fractional.begin}');
  print('  end: ${fractional.end}');
  print('  lerp(0.25): ${fractional.lerp(0.25)}');
  print('  lerp(0.75): ${fractional.lerp(0.75)}');

  print('AlignmentGeometryTween test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'AlignmentGeometryTween Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Basic tween: ${tween.begin} -> ${tween.end}'),
          Text('Lerp values tested: ${values.length}'),
          Text('Center to corner lerp(0.5): ${centerToCorner.lerp(0.5)}'),
          Text('Directional tween lerp(0.5): ${directionalTween.lerp(0.5)}'),
          Text('Same alignment lerp(0.5): ${same.lerp(0.5)}'),
          Text('Fractional lerp results: OK'),
        ],
      ),
    ),
  );
}
