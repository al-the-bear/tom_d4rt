import 'package:d4_example/example_project.dart' as pkg;

Object? testWithReturnContext() {
  List<Object> items = [1, 2, 3];
  return pkg.firstOrNull(items);
}

dynamic testWithDynamicReturn() {
  List<Object> items = [1, 2, 3];
  return pkg.firstOrNull(items);
}

void main() {
  print(testWithReturnContext());
  print(testWithDynamicReturn());
}
