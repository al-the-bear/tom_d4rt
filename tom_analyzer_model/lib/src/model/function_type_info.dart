part of 'model.dart';

/// Describes a function type signature.
class FunctionTypeInfo {
  final String id;
  final TypeReference returnType;
  final List<TypeParameterInfo> typeParameters;
  final List<ParameterInfo> parameters;

  const FunctionTypeInfo({
    required this.id,
    required this.returnType,
    this.typeParameters = const [],
    this.parameters = const [],
  });
}
