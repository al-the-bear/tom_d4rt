import 'package:d4_example/example_project.dart' as pkg;

void main() {
  // Test covariance
  List<dynamic> dynamicList = [1, 2, 3];
  List<Object> objectList = [1, 2, 3];
  
  // This should work - List<dynamic> passed to List<T>
  var r1 = pkg.firstOrNull(dynamicList);
  print('r1: $r1');
  
  // This should work too
  var r2 = pkg.firstOrNull(objectList);
  print('r2: $r2');
}
