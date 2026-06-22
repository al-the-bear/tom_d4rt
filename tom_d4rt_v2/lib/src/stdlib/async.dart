import 'package:tom_d4rt_v2/src/environment.dart';
import 'package:tom_d4rt_v2/src/stdlib/async/completer.dart';
import 'package:tom_d4rt_v2/src/stdlib/async/future.dart';
import 'package:tom_d4rt_v2/src/stdlib/async/stream.dart';
import 'package:tom_d4rt_v2/d4rt.dart';
import 'package:tom_d4rt_v2/src/stdlib/async/stream_controller.dart';
import 'package:tom_d4rt_v2/src/stdlib/async/timer.dart';

export 'package:tom_d4rt_v2/src/stdlib/async/completer.dart';
export 'package:tom_d4rt_v2/src/environment.dart';
export 'package:tom_d4rt_v2/src/stdlib/async/future.dart';
export 'package:tom_d4rt_v2/src/stdlib/async/stream.dart';

class AsyncStdlib {
  static void register(Environment environment) {
    CompleterStdlib.register(environment);
    FutureStdlib.register(environment);
    AsyncStreamStdlib.register(environment);
    TimerStdlib.register(environment);
    AsyncStreamControllerStdlib.register(environment);
  }
}
