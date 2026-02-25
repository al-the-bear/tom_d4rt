import 'package:tom_d4rt/src/environment.dart';
import 'package:tom_d4rt/src/stdlib/math/math.dart';
import 'package:tom_d4rt/src/stdlib/math/point.dart';
import 'package:tom_d4rt/src/stdlib/math/rectangle.dart';
import 'package:tom_d4rt/src/stdlib/math/random.dart';

export 'package:tom_d4rt/src/environment.dart';
export 'package:tom_d4rt/src/stdlib/math/math.dart';
export 'package:tom_d4rt/src/stdlib/math/point.dart';
export 'package:tom_d4rt/src/stdlib/math/rectangle.dart';
export 'package:tom_d4rt/src/stdlib/math/random.dart';

class MathStdlib {
  static void register(Environment environment) {
    MathMath.register(environment);
    environment.defineBridge(RandomMath.definition);
    environment.defineBridge(PointMath.definition);
    environment.defineBridge(RectangleMath.definition);
  }
}
