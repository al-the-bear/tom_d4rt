part of 'model.dart';

/// Variance of a type parameter.
enum TypeParameterVariance {
  covariant,
  contravariant,
  invariant,
}

/// Information about a type parameter and its bounds.
class TypeParameterInfo {
  final String id;
  final String name;
  final TypeReference? bound;
  final TypeReference? defaultType;
  final TypeParameterVariance? variance;

  const TypeParameterInfo({
    required this.id,
    required this.name,
    this.bound,
    this.defaultType,
    this.variance,
  });
}
