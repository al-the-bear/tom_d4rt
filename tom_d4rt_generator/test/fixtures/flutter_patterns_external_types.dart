library;

/// External type used as an upper bound in flutter_patterns_source.dart.
class ExternalBoundLike {
  final int id;
  const ExternalBoundLike(this.id);
}

typedef ExternalBuilderLike = Object Function(String context);

typedef ExternalStateSetterLike = void Function(void Function());

typedef ExternalStatefulBuilderLike =
  Object Function(String context, ExternalStateSetterLike setState);

typedef ExternalVoidCallbackLike = void Function();

typedef ExternalStateSetterViaAliasLike =
    void Function(ExternalVoidCallbackLike callback);

typedef ExternalStatefulBuilderViaAliasLike = Object Function(
  String context,
  ExternalStateSetterViaAliasLike setState,
);

typedef ExternalNullablePredicateLike<T extends Object> = bool Function(
  T? value,
);

class ExternalSchedulerBindingLike {}

typedef ExternalSchedulingStrategyLike = bool Function({
  required int priority,
  required ExternalSchedulerBindingLike scheduler,
});
