import 'package:tom_d4rt_ast/src/runtime/stdlib/core.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/async.dart';

class Stdlib {
  final Environment environment;

  Stdlib(this.environment);

  void register() {
    CoreStdlib.register(environment);
    AsyncStdlib.register(environment);
  }
}
