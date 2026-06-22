import 'package:tom_d4rt_v2/d4rt.dart';

extension InterpretedInstanceExtension on InterpretedInstance {
  T? getNativeObject<T>() {
    return bridgedSuperObject as T?;
  }
}
