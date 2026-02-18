import 'package:tom_d4rt_exec/d4rt.dart';

extension InterpretedInstanceExtension on InterpretedInstance {
  T? getNativeObject<T>() {
    return bridgedSuperObject as T?;
  }
}
