import 'package:d4_example/example_project.dart' as pkg;

Object? testWithExplicitType() {
  List<dynamic> items = [1, 2, 3];
  return pkg.firstOrNull<dynamic>(items);
}

void main() {
  print(testWithExplicitType());
}
