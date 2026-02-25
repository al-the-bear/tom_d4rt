import 'package:tom_d4rt_ast/runtime.dart';

extension ListExtension<T> on List<T> {
  R? get<R>(int index) {
    try {
      return this[index] as R;
    } on RangeError {
      return null;
    }
  }

  List<dynamic> toNativeList() {
    return map((item) {
      if (item is BridgedInstance) {
        return item.nativeObject;
      }
      return item;
    }).toList();
  }
}
