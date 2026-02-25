/// D4 Target Validation Example
///
/// Demonstrates the D4 class helper for target validation in instance
/// methods and getters. When D4rt calls a bridged method, the `target`
/// parameter may be wrapped in a BridgedInstance or may be a native object.
///
/// D4.validateTarget handles both cases and provides clear error messages.
///
/// Run with: dart run example/advanced_bridging/d4_target_validation_example.dart
library;

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';

// =============================================================================
// Example Class Hierarchy for Bridging
// =============================================================================

/// Base shape class.
abstract class Shape {
  String get type;
  double get area;
}

/// A circle shape.
class Circle implements Shape {
  final double radius;

  Circle(this.radius);

  @override
  String get type => 'Circle';

  @override
  double get area => 3.14159 * radius * radius;

  double get circumference => 2 * 3.14159 * radius;
}

/// A rectangle shape.
class Rectangle implements Shape {
  final double width;
  final double height;

  Rectangle(this.width, this.height);

  @override
  String get type => 'Rectangle';

  @override
  double get area => width * height;

  double get perimeter => 2 * (width + height);

  Rectangle scale(double factor) {
    return Rectangle(width * factor, height * factor);
  }
}

/// A canvas that can contain shapes.
class Canvas {
  final List<Shape> _shapes = [];

  void addShape(Shape shape) {
    _shapes.add(shape);
  }

  List<Shape> get shapes => List.unmodifiable(_shapes);

  double get totalArea {
    return _shapes.fold(0.0, (sum, shape) => sum + shape.area);
  }
}

// =============================================================================
// Bridge Implementation Using D4.validateTarget
// =============================================================================

BridgedClass createCircleBridge() {
  return BridgedClass(
    nativeType: Circle,
    name: 'Circle',
    constructors: {
      '': (visitor, positional, named) {
        final radius =
            D4.getRequiredArg<double>(positional, 0, 'radius', 'Circle');
        return Circle(radius);
      },
    },
    getters: {
      // D4.validateTarget ensures `target` is a Circle
      // and unwraps BridgedInstance if needed
      'type': (visitor, target) =>
          D4.validateTarget<Circle>(target, 'Circle').type,
      'area': (visitor, target) =>
          D4.validateTarget<Circle>(target, 'Circle').area,
      'radius': (visitor, target) =>
          D4.validateTarget<Circle>(target, 'Circle').radius,
      'circumference': (visitor, target) =>
          D4.validateTarget<Circle>(target, 'Circle').circumference,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final circle = D4.validateTarget<Circle>(target, 'Circle');
        return 'Circle(radius: ${circle.radius})';
      },
    },
  );
}

BridgedClass createRectangleBridge() {
  return BridgedClass(
    nativeType: Rectangle,
    name: 'Rectangle',
    constructors: {
      '': (visitor, positional, named) {
        final width =
            D4.getRequiredArg<double>(positional, 0, 'width', 'Rectangle');
        final height =
            D4.getRequiredArg<double>(positional, 1, 'height', 'Rectangle');
        return Rectangle(width, height);
      },
    },
    getters: {
      'type': (visitor, target) =>
          D4.validateTarget<Rectangle>(target, 'Rectangle').type,
      'area': (visitor, target) =>
          D4.validateTarget<Rectangle>(target, 'Rectangle').area,
      'width': (visitor, target) =>
          D4.validateTarget<Rectangle>(target, 'Rectangle').width,
      'height': (visitor, target) =>
          D4.validateTarget<Rectangle>(target, 'Rectangle').height,
      'perimeter': (visitor, target) =>
          D4.validateTarget<Rectangle>(target, 'Rectangle').perimeter,
    },
    methods: {
      'scale': (visitor, target, positional, named, typeArgs) {
        final rect = D4.validateTarget<Rectangle>(target, 'Rectangle');
        final factor =
            D4.getRequiredArg<double>(positional, 0, 'factor', 'scale');
        return rect.scale(factor);
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final rect = D4.validateTarget<Rectangle>(target, 'Rectangle');
        return 'Rectangle(${rect.width} x ${rect.height})';
      },
    },
  );
}

BridgedClass createCanvasBridge() {
  return BridgedClass(
    nativeType: Canvas,
    name: 'Canvas',
    constructors: {
      '': (visitor, positional, named) => Canvas(),
    },
    getters: {
      'shapes': (visitor, target) =>
          D4.validateTarget<Canvas>(target, 'Canvas').shapes,
      'totalArea': (visitor, target) =>
          D4.validateTarget<Canvas>(target, 'Canvas').totalArea,
    },
    methods: {
      'addShape': (visitor, target, positional, named, typeArgs) {
        final canvas = D4.validateTarget<Canvas>(target, 'Canvas');

        // The shape argument may be a BridgedInstance or native object
        // D4.extractBridgedArg handles both cases
        final shape = D4.extractBridgedArg<Shape>(positional[0], 'shape');

        canvas.addShape(shape);
        return null;
      },
    },
  );
}

// =============================================================================
// Demonstration
// =============================================================================

void main() async {
  print('D4 Target Validation Example');
  print('=' * 60);

  final d4rt = D4rt();

  // Register all shape bridges
  d4rt.registerBridgedClass(createCircleBridge(), 'package:example/example.dart');
  d4rt.registerBridgedClass(createRectangleBridge(), 'package:example/example.dart');
  d4rt.registerBridgedClass(createCanvasBridge(), 'package:example/example.dart');

  final script = '''
import 'package:example/example.dart';

void main() {
  // Create shapes
  final circle = Circle(5.0);
  final rect1 = Rectangle(10.0, 20.0);
  final rect2 = Rectangle(3.0, 4.0);
  
  // Access properties using validated target
  print('Circle:');
  print('  Type: \${circle.type}');
  print('  Radius: \${circle.radius}');
  print('  Area: \${circle.area}');
  print('  Circumference: \${circle.circumference}');
  
  print('\\nRectangle:');
  print('  Type: \${rect1.type}');
  print('  Width: \${rect1.width}');
  print('  Height: \${rect1.height}');
  print('  Area: \${rect1.area}');
  print('  Perimeter: \${rect1.perimeter}');
  
  // Scale creates a new rectangle
  final scaled = rect2.scale(2.0);
  print('\\nScaled Rectangle:');
  print('  Original: \$rect2 (area: \${rect2.area})');
  print('  Scaled: \$scaled (area: \${scaled.area})');
  
  // Add shapes to canvas
  final canvas = Canvas();
  canvas.addShape(circle);
  canvas.addShape(rect1);
  canvas.addShape(rect2);
  
  print('\\nCanvas:');
  print('  Shape count: \${canvas.shapes.length}');
  print('  Total area: \${canvas.totalArea}');
  
  // Iterate over shapes
  print('\\nAll shapes on canvas:');
  for (final shape in canvas.shapes) {
    print('  - \${shape.type}: area = \${shape.area}');
  }
}
''';

  print('\nExecuting script...\n');
  await d4rt.execute(source: script);

  print('\n' + '=' * 60);
  print('Example completed!');
}
