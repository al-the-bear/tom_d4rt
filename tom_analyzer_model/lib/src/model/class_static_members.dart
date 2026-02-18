part of 'model.dart';

/// Aggregates static members of a class.
class ClassStaticMembers {
  final List<MethodInfo> methods;
  final List<FieldInfo> fields;
  final List<GetterInfo> getters;
  final List<SetterInfo> setters;

  const ClassStaticMembers({
    required this.methods,
    required this.fields,
    required this.getters,
    required this.setters,
  });
}
