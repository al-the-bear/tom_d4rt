import 'package:d4_example/example_project.dart' as pkg;

void main() {
  List<dynamic> items = [1, 2, 3];
  var result = pkg.firstOrNull(items);
  print(result);
}
