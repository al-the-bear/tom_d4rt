import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('PointCore tests', () {
    test('Point properties [2026-02-10 06:37]', () {
      const source = '''
      import 'dart:math';
      main() {
        Point p = Point(3, 4);
        return [p.x, p.y, p.magnitude];
      }
      ''';
      expect(execute(source), equals([3, 4, 5.0]));
    });

    test('Point distanceTo [2026-02-10 06:37]', () {
      const source = '''
      import 'dart:math';
      main() {
        Point p1 = Point(3, 4);
        Point p2 = Point(0, 0);
        return p1.distanceTo(p2);
      }
      ''';
      expect(execute(source), equals(5.0));
    });

    test('Point squaredDistanceTo [2026-02-10 06:37]', () {
      const source = '''
      import 'dart:math';
      main() {
        Point p1 = Point(3, 4);
        Point p2 = Point(0, 0);
        return p1.squaredDistanceTo(p2);
      }
      ''';
      expect(execute(source), equals(25));
    });

    test('Point toString [2026-02-10 06:37]', () {
      const source = '''
      import 'dart:math';
      main() {
        Point p = Point(3, 4);
        return p.toString();
      }
      ''';
      expect(execute(source), equals('Point(3, 4)'));
    });

    test('Point equality and hashCode [2026-02-10 06:37]', () {
      const source = '''
      import 'dart:math';
      main() {
        Point p1 = Point(3, 4);
        Point p2 = Point(3, 4);
        Point p3 = Point(0, 0);
        return [p1 == p2, p1 == p3, p1.hashCode == p2.hashCode];
      }
      ''';
      expect(execute(source), equals([true, false, true]));
    });
  });
}
