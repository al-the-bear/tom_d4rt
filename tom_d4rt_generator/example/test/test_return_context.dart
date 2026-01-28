import 'package:d4rt_generator_example/test_classes.dart' as pkg;

Object? testWithReturnContext() {
  List<dynamic> items = [1, 2, 3];
  return pkg.firstOrNull(items);
}

dynamic testWithDynamicReturn() {
  List<dynamic> items = [1, 2, 3];
  return pkg.firstOrNull(items);
}

void main() {
  print(testWithReturnContext());
  print(testWithDynamicReturn());
}
