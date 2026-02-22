/// Dart Overview D4rt Interpreter Failure Tests - Round 2
///
/// Isolated test cases for additional D4rt interpreter failures found after
/// the initial G-DOV fixes. Each test reproduces a specific interpreter
/// limitation with a minimal code snippet.
///
/// These failures were identified by re-running all 20 Dart Overview areas
/// through the D4rt interpreter (run_overview_in_d4rt.dart) after the initial
/// 12 G-DOV bug fixes. 7 areas still fail.
///
/// | ID       | Area       | Root Cause                                       |
/// |----------|------------|--------------------------------------------------|
/// | G-DOV2-1 | operators  | Cast to nullable type (as String?)               |
/// | G-DOV2-2 | functions  | Factory constructor tear-off (Class.fromMap)     |
/// | G-DOV2-3 | classes    | Factory constructor on abstract class            |
/// | G-DOV2-4 | generics   | Function-level type parameter bound (Comparable) |
/// | G-DOV2-5 | patterns   | CastPatternImpl not implemented                  |
/// | G-DOV2-6 | mixins     | super.name forwarding through mixin chain        |
/// | G-DOV2-7 | extensions | Extension on enum type resolution                |
// ignore_for_file: file_names
@TestOn('vm')
@Timeout(Duration(minutes: 2))
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// Execute a D4rt source string and return the result.
///
/// Throws on interpreter errors so tests can catch them.
dynamic _execute(String source) {
  final d4rt = D4rt()..setDebug(false);
  return d4rt.execute(
    library: 'package:test/main.dart',
    sources: {'package:test/main.dart': source},
  );
}

void main() {
  group('Dart Overview Failures Round 2', () {
    // =========================================================================
    // G-DOV2-1: Cast to nullable type (as String?)
    // =========================================================================
    // Error: Cast failed with 'as' : the value does not match the target type (String?)
    // File: operators/type_operators/run_type_operators.dart:114
    //
    // The interpreter does not properly handle casting to nullable types.
    // When casting a value to a nullable type like String?, the interpreter
    // treats it as a regular cast and fails because it expects an exact match.
    test('G-DOV2-1: Cast to nullable type (as String?) [2026-02-10 21:30] (FAIL)',
        () {
      const source = '''
void main() {
  Object? nullableObj = 'I might be null';
  String? nullableStr = nullableObj as String?;
  print('Cast to String?: \$nullableStr');

  nullableObj = null;
  nullableStr = nullableObj as String?;
  print('Cast null to String?: \$nullableStr');
}
''';
      expect(() => _execute(source), returnsNormally);
    });

    // =========================================================================
    // G-DOV2-2: Factory constructor tear-off (Class.fromMap)
    // =========================================================================
    // Error: Undefined static member 'fromMap' on class 'Settings'.
    // File: functions/higher_order/run_higher_order.dart:113
    //
    // When using a factory constructor as a tear-off in map(), the interpreter
    // fails to resolve it as a static member / factory constructor.
    test(
        'G-DOV2-2: Factory constructor tear-off (Class.fromMap) [2026-02-10 21:30] (FAIL)',
        () {
      const source = '''
class Settings {
  final String name;
  Settings(this.name);

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(map['name'] as String);
  }

  @override
  String toString() => 'Settings(\$name)';
}

void main() {
  var configs = [
    {'name': 'Config1'},
    {'name': 'Config2'},
  ];
  // Using factory constructor as tear-off
  var settings = configs.map(Settings.fromMap).toList();
  print('Created settings: \$settings');
}
''';
      expect(() => _execute(source), returnsNormally);
    });

    // =========================================================================
    // G-DOV2-3: Factory constructor on abstract class
    // =========================================================================
    // Error: Cannot instantiate abstract class 'Shape'.
    // File: classes/constructors/run_constructors.dart:78
    //
    // When calling a factory constructor on an abstract class, the interpreter
    // incorrectly treats it as an attempt to instantiate the abstract class
    // directly, rather than delegating to the factory which returns a concrete
    // subclass.
    test(
        'G-DOV2-3: Factory constructor on abstract class [2026-02-10 21:30] (FAIL)',
        () {
      const source = '''
abstract class Shape {
  double get area;

  factory Shape.create(String type, double dimension) {
    switch (type) {
      case 'circle':
        return CircleShape(dimension);
      case 'square':
        return SquareShape(dimension);
      default:
        throw ArgumentError('Unknown shape: \$type');
    }
  }
}

class CircleShape implements Shape {
  final double radius;
  CircleShape(this.radius);

  @override
  double get area => 3.14159 * radius * radius;
}

class SquareShape implements Shape {
  final double side;
  SquareShape(this.side);

  @override
  double get area => side * side;
}

void main() {
  Shape circle = Shape.create('circle', 5);
  Shape square = Shape.create('square', 4);
  print('Circle area: \${circle.area}');
  print('Square area: \${square.area}');
}
''';
      expect(() => _execute(source), returnsNormally);
    });

    // =========================================================================
    // G-DOV2-4: Function-level type parameter bound (Comparable)
    // =========================================================================
    // Error: Type argument 'num' for type parameter 'T' does not satisfy
    //        bound 'Comparable' in function 'clamp'
    // File: generics/type_bounds/run_type_bounds.dart:102
    //
    // When calling a generic function with a type bound (T extends Comparable<T>),
    // the interpreter does not recognize that num implements Comparable<num>.
    // This differs from the class-level check which was fixed in G-DOV-9.
    test(
        'G-DOV2-4: Function-level type parameter bound (Comparable) [2026-02-10 21:30] (FAIL)',
        () {
      const source = '''
T clamp<T extends Comparable<T>>(T value, T min, T max) {
  if (value.compareTo(min) < 0) return min;
  if (value.compareTo(max) > 0) return max;
  return value;
}

void main() {
  print('clamp(15, 10, 20): \${clamp<num>(15, 10, 20)}');
  print('clamp(5, 10, 20): \${clamp<num>(5, 10, 20)}');
  print('clamp(25, 10, 20): \${clamp<num>(25, 10, 20)}');
}
''';
      expect(() => _execute(source), returnsNormally);
    });

    // =========================================================================
    // G-DOV2-5: CastPatternImpl not implemented
    // =========================================================================
    // Error: Pattern type not yet supported in _matchAndBind: CastPatternImpl
    // File: patterns/pattern_types/run_pattern_types.dart:160
    //
    // The interpreter does not support cast patterns (var x as Type) in
    // pattern matching contexts like if-case statements.
    test('G-DOV2-5: CastPatternImpl not implemented [2026-02-10 21:30] (FAIL)',
        () {
      const source = '''
void main() {
  Object obj = [1, 2, 3];
  if (obj case var items as List<int>) {
    print('Cast to List<int>: \$items');
  }
}
''';
      expect(() => _execute(source), returnsNormally);
    });

    // =========================================================================
    // G-DOV2-6: super.name forwarding through mixin chain
    // =========================================================================
    // Error: Missing concrete implementation for inherited abstract getter 'name'
    //        in class 'Eagle'.
    // File: mixins/basics/run_basics.dart:191
    //
    // When a class uses super.name forwarding in the constructor (like
    // Eagle(super.name)), the interpreter doesn't properly recognize that the
    // 'name' getter is provided by the parent class Bird, not the mixin.
    test(
        'G-DOV2-6: super.name forwarding through mixin chain [2026-02-10 21:30] (FAIL)',
        () {
      const source = '''
abstract class Animal {
  String get name;
  void move();
}

mixin Flying on Animal {
  void fly() {
    print('\$name is flying high!');
  }

  @override
  void move() {
    fly();
  }
}

class Bird extends Animal {
  @override
  final String name;

  Bird(this.name);

  @override
  void move() {
    print('\$name is moving');
  }
}

class Eagle extends Bird with Flying {
  Eagle(super.name);
}

void main() {
  var eagle = Eagle('Eddie');
  print('Eagle name: \${eagle.name}');
  eagle.fly();
}
''';
      expect(() => _execute(source), returnsNormally);
    });

    // =========================================================================
    // G-DOV2-7: Extension on enum type resolution
    // =========================================================================
    // Error: Undefined property 'displayName' on enum value 'Status.active'.
    // File: extensions/basics/run_basics.dart:113
    //
    // The interpreter does not properly resolve extension methods/getters
    // defined on enum types.
    test(
        'G-DOV2-7: Extension on enum type resolution [2026-02-10 21:30] (FAIL)',
        () {
      const source = '''
enum Status { active, inactive, pending }

extension StatusExtension on Status {
  String get displayName {
    return switch (this) {
      Status.active => 'Active',
      Status.inactive => 'Inactive',
      Status.pending => 'Pending',
    };
  }

  bool get isActive => this == Status.active;
}

void main() {
  var status = Status.active;
  print('status: \$status');
  print('displayName: \${status.displayName}');
  print('isActive: \${status.isActive}');
}
''';
      expect(() => _execute(source), returnsNormally);
    });
  });
}
