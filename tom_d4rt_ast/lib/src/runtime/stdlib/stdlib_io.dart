import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';

class StdlibIo {
  static void register(Environment environment) {
    IoStdlib.register(environment);
  }
}
