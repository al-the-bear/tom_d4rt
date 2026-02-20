import 'package:d4rt_generator_example/test_classes.dart' as pkg;

void main() {
  List<dynamic> items = [1, 2, 3];
  var result = pkg.firstOrNull(items);
  print(result);
}
