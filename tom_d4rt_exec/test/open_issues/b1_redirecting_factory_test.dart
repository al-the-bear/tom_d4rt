/// Repro + regression for OPEN B.1 — redirecting factory constructors
/// (`factory X() = Y`). A redirecting factory must resolve its redirect target
/// (concrete subclass + named/unnamed constructor) and instantiate it,
/// forwarding the call arguments.
///
/// Historic failure: `factory Shape() = Circle;` left `Shape()` trying to
/// instantiate the abstract class directly ("Cannot instantiate abstract class
/// 'Shape'"); a named redirect `factory Shape.named(r) = Circle.r;` failed with
/// "Cannot execute non-constructor function 'named' with empty body" because
/// the `redirectedConstructor` target was never captured or resolved.
///
/// This is the analyzer-free AST runtime: source is compiled to a bundle via
/// the `tom_d4rt_exec` front end, then interpreted by `D4rtRunner`. Mirrors the
/// analyzer-based twin in
/// `tom_d4rt/test/open_issues/b1_redirecting_factory_test.dart`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  group('OPEN B.1 — redirecting factory constructors (AST)', () {
    test(
      'unnamed redirect `factory X() = Y` resolves to the subclass',
      () async {
        final d4rt = D4rt();
        final bundle = await d4rt.createBundleFromSource('''
abstract class Shape {
  factory Shape() = Circle;
  double area();
}
class Circle implements Shape {
  Circle();
  double area() => 3.14;
}
double main() {
  final s = Shape();
  return s.area();
}
''');
        final runner = D4rtRunner();
        final result = runner.executeBundle(bundle);
        expect(result, 3.14);
      },
    );

    test('named redirect `factory X.n(..) = Y.m` forwards arguments', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
abstract class Shape {
  factory Shape.named(double r) = Circle.r;
  double area();
}
class Circle implements Shape {
  final double radius;
  Circle.r(this.radius);
  double area() => radius * radius;
}
double main() {
  return Shape.named(2.0).area();
}
''');
      final runner = D4rtRunner();
      final result = runner.executeBundle(bundle);
      expect(result, 4.0);
    });

    test(
      'redirect to a default unnamed constructor with positional args',
      () async {
        final d4rt = D4rt();
        final bundle = await d4rt.createBundleFromSource('''
abstract class Animal {
  factory Animal(String name) = Dog;
  String describe();
}
class Dog implements Animal {
  final String name;
  Dog(this.name);
  String describe() => 'Dog: \$name';
}
String main() {
  return Animal('Rex').describe();
}
''');
        final runner = D4rtRunner();
        final result = runner.executeBundle(bundle);
        expect(result, 'Dog: Rex');
      },
    );

    test('generic redirect `factory X() = Y<int>` resolves the type', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
abstract class Box<T> {
  factory Box() = IntBox;
  int size();
}
class IntBox implements Box<int> {
  IntBox();
  int size() => 42;
}
int main() {
  final b = Box<int>();
  return b.size();
}
''');
      final runner = D4rtRunner();
      final result = runner.executeBundle(bundle);
      expect(result, 42);
    });
  });
}
