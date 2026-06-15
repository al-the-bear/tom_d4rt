// shape_report — polymorphism across a bridged abstract class.
//
// Builds a mixed list of native Circle/Rect objects (both are Shape subclasses)
// and treats them polymorphically: area, contains, describe.

import 'package:d4rt_advanced_sample/d4rt_advanced_sample.dart';

void main(List<String> args) {
  final shapes = <Shape>[
    Circle(Vector2(0, 0), 2),
    Rect(Vector2(5, 5), 4, 3),
    Circle(Vector2(-3, 1), 1.5),
  ];

  final probe = Vector2(0, 1);
  print('Probe point: $probe\n');

  var totalArea = 0.0;
  for (final shape in shapes) {
    totalArea += shape.area;
    final inside = shape.contains(probe) ? 'contains probe' : '-';
    print('${shape.describe().padRight(16)} area=${shape.area.toStringAsFixed(2).padLeft(7)}  $inside');
  }

  print('\nTotal area of ${shapes.length} shapes: ${totalArea.toStringAsFixed(2)}');
}
