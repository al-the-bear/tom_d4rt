import 'package:d4rt_generator_example/test_classes.dart' as $pkg;

Object? testFunc() {
  final positional = [<int>[1, 2, 3]];
  
  // Simulate the bridge pattern
  T getArg<T>(List<Object?> args, int index) {
    return args[index] as T;
  }
  
  final items = getArg<List<Object>>(positional, 0);
  return $pkg.firstOrNull(items);
}

void main() {
  print(testFunc());
}
