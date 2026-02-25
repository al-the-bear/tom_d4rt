import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'package:d4_example/example_project.dart' as $pkg;

void testInBridgeContext() {
  final Map<String, NativeFunctionImpl> funcs = {
    'firstOrNull': (visitor, positional, named, typeArgs) {
      D4.requireMinArgs(positional, 1, 'firstOrNull');
      final items = D4.getRequiredArg<List<Object>>(positional, 0, 'items', 'firstOrNull');
      return $pkg.firstOrNull(items);
    },
  };
  print(funcs);
}

void main() {
  testInBridgeContext();
}
