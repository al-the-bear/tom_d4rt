// D4rt test: CLS09 - Computed getters
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test Rectangle computed getters
  var rect = Rectangle(5.0, 3.0);
  if (rect.area != 15.0) {
    errors.add('Rectangle.area expected 15.0, got ${rect.area}');
  }
  if (rect.perimeter != 16.0) {
    errors.add('Rectangle.perimeter expected 16.0, got ${rect.perimeter}');
  }

  // Test Circle computed getters
  var circle = Circle(5.0);
  if (circle.diameter != 10.0) {
    errors.add('Circle.diameter expected 10.0, got ${circle.diameter}');
  }

  // Check circumference approximately 31.4159 (2 * 3.14159 * 5.0)
  var expectedCircumference = 31.4159;
  if ((circle.circumference - expectedCircumference).abs() > 0.001) {
    errors.add('Circle.circumference expected ~$expectedCircumference, got ${circle.circumference}');
  }

  // Check circleArea approximately 78.5397 (3.14159 * 25.0)
  var expectedArea = 78.53975;
  if ((circle.circleArea - expectedArea).abs() > 0.001) {
    errors.add('Circle.circleArea expected ~$expectedArea, got ${circle.circleArea}');
  }

  if (errors.isEmpty) {
    print('CLS09_PASSED');
  } else {
    print('CLS09_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
