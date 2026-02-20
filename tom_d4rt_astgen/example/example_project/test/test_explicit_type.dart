import 'package:d4rt_generator_example/test_classes.dart' as pkg;

Object? testWithExplicitType() {
  List<dynamic> items = [1, 2, 3];
  return pkg.firstOrNull<dynamic>(items);
}

void main() {
  print(testWithExplicitType());
}
