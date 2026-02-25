import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/comparable.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/double.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/error.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/exceptions.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/invocation.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/never.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/int.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/iterable.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/list.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/map.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/null.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/num.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/object.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/patern.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/set.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/sink.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/string.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/runes.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/string_buffer.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/string_sink.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/symbol.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/bigint.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/bool.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/iterator.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/date_time.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/duration.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/type.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/uri.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/stack_trace.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/regexp.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core/function.dart';

export 'package:tom_d4rt_ast/src/runtime/environment.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/double.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/int.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/iterable.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/list.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/map.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/num.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/patern.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/set.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/sink.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/string.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/runes.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/string_buffer.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/string_sink.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/bigint.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/bool.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/iterator.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/date_time.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/duration.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/uri.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/stack_trace.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/regexp.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/function.dart';
export 'package:tom_d4rt_ast/src/runtime/stdlib/core/exceptions.dart';

class CoreStdlib {
  static void register(Environment environment) {
    environment.defineBridge(DoubleCore.definition);
    environment.defineBridge(IntCore.definition);
    environment.defineBridge(IterableCore.definition);
    environment.defineBridge(ListCore.definition);
    environment.defineBridge(MapCore.definition);
    environment.defineBridge(MapEntryCore.definition);
    environment.defineBridge(NumCore.definition);
    environment.defineBridge(PatternCore.definition);
    environment.defineBridge(MatchCore.definition);
    environment.defineBridge(SetCore.definition);
    environment.defineBridge(SinkCore.definition);
    environment.defineBridge(StringCore.definition);
    environment.defineBridge(RunesCore.definition);
    environment.defineBridge(StringBufferCore.definition);
    environment.defineBridge(StringSinkCore.definition);
    environment.defineBridge(BigIntCore.definition);
    environment.defineBridge(BoolCore.definition);
    environment.defineBridge(IteratorCore.definition);
    environment.defineBridge(DateTimeCore.definition);
    environment.defineBridge(DurationCore.definition);
    environment.defineBridge(UriCore.definition);
    environment.defineBridge(StackTraceCore.definition);
    environment.defineBridge(RegExpCore.definition);
    environment.defineBridge(RegExpMatchCore.definition);
    environment.defineBridge(FunctionCore.definition);
    environment.defineBridge(FormatExceptionCore.definition);
    environment.defineBridge(ExceptionCore.definition);
    environment.defineBridge(ObjectCore.definition);
    environment.defineBridge(TypeCore.definition);
    environment.defineBridge(NullCore.definition);
    environment.defineBridge(ComparableCore.definition);
    environment.defineBridge(NeverCore.definition);
    environment.defineBridge(SymbolCore.definition);
    environment.defineBridge(ErrorCore.definition);
    environment.defineBridge(StateErrorCore.definition);
    environment.defineBridge(ArgumentErrorCore.definition);
    environment.defineBridge(RangeErrorCore.definition);
    environment.defineBridge(UnsupportedErrorCore.definition);
    environment.defineBridge(UnimplementedErrorCore.definition);
    environment.defineBridge(InvocationCore.definition); // Bug-78 FIX
    environment.define(
        'dynamic',
        NativeFunction((visitor, arguments, namedArguments, typeArguments) {
          return dynamic;
        }, arity: 0, name: 'dynamic'));
    environment.define(
        'print',
        NativeFunction((visitor, arguments, namedArguments, typeArguments) {
          print(arguments[0]);
          return null;
        }, arity: 1, name: 'print'));
    environment.define(
        'identical',
        NativeFunction((visitor, arguments, namedArguments, typeArguments) {
          if (arguments.length != 2) {
            throw RuntimeD4rtException('identical requires two arguments.');
          }
          return identical(arguments[0], arguments[1]);
        }, arity: 2, name: 'identical'));
  }
}
