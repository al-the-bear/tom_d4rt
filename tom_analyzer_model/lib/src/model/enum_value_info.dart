part of 'model.dart';

/// Represents a single enum value.
class EnumValueInfo {
  final String id;
  final String name;
  final EnumInfo parentEnum;
  final String? documentation;
  final List<AnnotationInfo> annotations;
  final int index;

  const EnumValueInfo({
    required this.id,
    required this.name,
    required this.parentEnum,
    required this.index,
    this.documentation,
    this.annotations = const [],
  });
}
