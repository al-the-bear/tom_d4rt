// Fixture for gen134_generic_function_field_getter_test.dart.

typedef Changed<T> = void Function(T value);

class Picker<T> {
  Picker(this.value, this.onChanged, this.values, this.make);

  final T value;
  final Changed<T?>? onChanged;
  final List<T> values;
  final T Function() make;
  final int count = 0;
}
