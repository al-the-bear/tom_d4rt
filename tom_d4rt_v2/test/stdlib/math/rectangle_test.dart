import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('RectangleCore tests', () {
    test('I-MISC-438: Rectangle properties. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:math';
      main() {
        Rectangle r = Rectangle(0, 0, 10, 20);
        return [r.left, r.top, r.width, r.height, r.right, r.bottom];
      }
      ''';
      expect(execute(source), equals([0, 0, 10, 20, 10, 20]));
    });

    test('I-MISC-434: Rectangle containsPoint. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:math';
      main() {
        Rectangle r = Rectangle(0, 0, 10, 20);
        return [r.containsPoint(Point(5, 5)), r.containsPoint(Point(15, 5))];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('I-MISC-435: Rectangle containsRectangle. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:math';
      main() {
        Rectangle r1 = Rectangle(0, 0, 10, 20);
        Rectangle r2 = Rectangle(1, 1, 5, 5);
        Rectangle r3 = Rectangle(5, 5, 10, 10);
        return [r1.containsRectangle(r2), r1.containsRectangle(r3)];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('I-MISC-436: Rectangle intersects. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:math';
      main() {
        Rectangle r1 = Rectangle(0, 0, 10, 20);
        Rectangle r2 = Rectangle(5, 5, 10, 10);
        Rectangle r3 = Rectangle(15, 15, 5, 5);
        return [r1.intersects(r2), r1.intersects(r3)];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('I-MISC-437: Rectangle intersection. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:math';
      main() {
        Rectangle r1 = Rectangle(0, 0, 10, 20);
        Rectangle r2 = Rectangle(5, 5, 10, 10);
        Rectangle r3 = Rectangle(15, 15, 5, 5);
        Rectangle? intersect1 = r1.intersection(r2);
        Rectangle? intersect2 = r1.intersection(r3);
        return [
          intersect1 == null ? null : [intersect1.left, intersect1.top, intersect1.width, intersect1.height],
          intersect2 == null ? null : [intersect2.left, intersect2.top, intersect2.width, intersect2.height]
        ];
      }
      ''';
      expect(
          execute(source),
          equals([
            [5, 5, 5, 10],
            null
          ]));
    });

    test('I-MISC-439: Rectangle toString. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:math';
      main() {
        Rectangle r = Rectangle(0, 0, 10, 20);
        return r.toString();
      }
      ''';
      expect(execute(source), equals('Rectangle (0, 0) 10 x 20'));
    });

    test('I-MISC-440: Rectangle equality and hashCode. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:math';
      main() {
        Rectangle r1 = Rectangle(0, 0, 10, 20);
        Rectangle r2 = Rectangle(0, 0, 10, 20);
        Rectangle r3 = Rectangle(5, 5, 10, 10);
        return [r1 == r2, r1 == r3, r1.hashCode == r2.hashCode];
      }
      ''';
      expect(execute(source), equals([true, false, true]));
    });
  });
}
