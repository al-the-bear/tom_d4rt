import 'package:tom_d4rt_ast/runtime.dart';

extension InterpretedInstanceExtension on InterpretedInstance {
  T? getNativeObject<T>() {
    return bridgedSuperObject as T?;
  }
}
