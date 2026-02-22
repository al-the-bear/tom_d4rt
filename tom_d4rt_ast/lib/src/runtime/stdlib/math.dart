import 'package:tom_d4rt_ast/src/runtime/environment.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/math/math.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/math/point.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/math/rectangle.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/math/random.dart';

export 'package:tom_d4rt_ast/src/runtime/environment.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/math/math.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/math/point.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/math/rectangle.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/math/random.dart';

class MathStdlib {
  static void register(Environment environment) {
    MathMath.register(environment);
    environment.defineBridge(RandomMath.definition);
    environment.defineBridge(PointMath.definition);
    environment.defineBridge(RectangleMath.definition);
  }
}
