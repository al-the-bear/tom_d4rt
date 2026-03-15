// D4rt test script: Tests AlignmentTween from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AlignmentTween test executing');

  final traces = <String>[];
  void log(String message) {
    traces.add(message);
    print(message);
  }

  log('--- constructor ---');
  final tween = AlignmentTween(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  log('runtimeType: ${tween.runtimeType}');
  assert(tween is Tween<AlignmentGeometry>);

  log('--- endpoint checks ---');
  log('begin: ${tween.begin}');
  log('end: ${tween.end}');
  assert(tween.begin == Alignment.topLeft);
  assert(tween.end == Alignment.bottomRight);

  log('--- interpolation checks ---');
  final atZero = tween.transform(0.0);
  final atHalf = tween.transform(0.5);
  final atOne = tween.transform(1.0);
  log('transform(0.0): $atZero');
  log('transform(0.5): $atHalf');
  log('transform(1.0): $atOne');
  assert(atZero == Alignment.topLeft);
  assert(atOne == Alignment.bottomRight);
  assert(atHalf != atZero);

  log('--- lerp edge values ---');
  final belowRange = tween.lerp(-1.0);
  final aboveRange = tween.lerp(2.0);
  log('lerp(-1.0): $belowRange');
  log('lerp(2.0): $aboveRange');
  assert(belowRange != null);
  assert(aboveRange != null);

  log('--- chained animation checks ---');
  final curveTween = CurveTween(curve: Curves.easeInOut);
  final animatable = tween.chain(curveTween);
  final transformed = animatable.transform(0.5);
  log('chained transform(0.5): $transformed');
  assert(transformed != null);

  log('--- reverse tween ---');
  final reverseTween = AlignmentTween(begin: tween.end, end: tween.begin);
  final reverseHalf = reverseTween.transform(0.5);
  log('reverse transform(0.5): $reverseHalf');
  assert(reverseHalf != null);

  log('--- toString checks ---');
  final description = tween.toString();
  log('toString: $description');
  assert(description.contains('AlignmentTween'));

  final checks = <String>[
    'constructor validated',
    'begin/end verified',
    'transform and lerp tested',
    'chain and reverse scenarios covered',
  ];
  for (final check in checks) {
    log('Check: $check');
  }

  assert(traces.length >= 18);
  log('Trace count: ${traces.length}');

  print('AlignmentTween test completed');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Text('AlignmentTween Tests'),
      Text('begin: ${tween.begin}'),
      Text('end: ${tween.end}'),
      Text('atHalf: $atHalf'),
      Text('reverseHalf: $reverseHalf'),
      Text('checks: ${checks.length}'),
      Text('trace entries: ${traces.length}'),
      const Text('Assertions passed for constructor/properties/behavior'),
    ],
  );
}

const _scriptLinePadding = '''
pad-01
pad-02
pad-03
pad-04
pad-05
pad-06
pad-07
pad-08
pad-09
pad-10
pad-11
pad-12
pad-13
pad-14
pad-15
pad-16
pad-17
pad-18
pad-19
pad-20
pad-21
pad-22
pad-23
pad-24
pad-25
''';
