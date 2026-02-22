import 'package:tom_d4rt_ast/src/runtime/environment.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/async/completer.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/async/future.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/async/stream.dart';
import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/async/stream_controller.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/async/timer.dart';

export 'package:tom_d4rt_ast/src/runtime/stdlib/async/completer.dart';
export 'package:tom_d4rt_ast/src/runtime/environment.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/async/future.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/async/stream.dart';

class AsyncStdlib {
  static void register(Environment environment) {
    CompleterStdlib.register(environment);
    FutureStdlib.register(environment);
    AsyncStreamStdlib.register(environment);
    TimerStdlib.register(environment);
    AsyncStreamControllerStdlib.register(environment);
  }
}
