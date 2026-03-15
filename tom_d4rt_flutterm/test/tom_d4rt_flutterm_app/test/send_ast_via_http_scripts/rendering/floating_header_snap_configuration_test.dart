// D4rt test script: Tests FloatingHeaderSnapConfiguration from rendering
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FloatingHeaderSnapConfiguration test executing');

  // ========== Basic FloatingHeaderSnapConfiguration creation ==========
  print('--- Basic FloatingHeaderSnapConfiguration ---');
  final config1 = FloatingHeaderSnapConfiguration(
    curve: Curves.easeInOut,
    duration: Duration(milliseconds: 300),
  );
  print('  created: ${config1.runtimeType}');
  print('  curve: ${config1.curve}');
  print('  duration: ${config1.duration}');

  // ========== Different curves ==========
  print('--- Different curves ---');
  final linearConfig = FloatingHeaderSnapConfiguration(
    curve: Curves.linear,
    duration: Duration(milliseconds: 200),
  );
  print('  linear curve: ${linearConfig.curve}');
  print('  linear duration: ${linearConfig.duration}');

  final bounceConfig = FloatingHeaderSnapConfiguration(
    curve: Curves.bounceOut,
    duration: Duration(milliseconds: 500),
  );
  print('  bounce curve: ${bounceConfig.curve}');
  print('  bounce duration: ${bounceConfig.duration}');

  final elasticConfig = FloatingHeaderSnapConfiguration(
    curve: Curves.elasticOut,
    duration: Duration(milliseconds: 400),
  );
  print('  elastic curve: ${elasticConfig.curve}');
  print('  elastic duration: ${elasticConfig.duration}');

  // ========== Duration variations ==========
  print('--- Duration variations ---');
  final shortDuration = FloatingHeaderSnapConfiguration(
    curve: Curves.easeIn,
    duration: Duration(milliseconds: 100),
  );
  print('  short duration: ${shortDuration.duration.inMilliseconds}ms');

  final longDuration = FloatingHeaderSnapConfiguration(
    curve: Curves.easeOut,
    duration: Duration(milliseconds: 1000),
  );
  print('  long duration: ${longDuration.duration.inMilliseconds}ms');

  final zeroDuration = FloatingHeaderSnapConfiguration(
    curve: Curves.ease,
    duration: Duration.zero,
  );
  print('  zero duration: ${zeroDuration.duration.inMilliseconds}ms');

  // ========== Comparing configurations ==========
  print('--- Comparing configurations ---');
  final configA = FloatingHeaderSnapConfiguration(
    curve: Curves.easeInOut,
    duration: Duration(milliseconds: 300),
  );
  final configB = FloatingHeaderSnapConfiguration(
    curve: Curves.easeInOut,
    duration: Duration(milliseconds: 300),
  );
  print('  configA.curve: ${configA.curve}');
  print('  configB.curve: ${configB.curve}');
  print('  same curve type: ${configA.curve == configB.curve}');
  print('  same duration: ${configA.duration == configB.duration}');

  // ========== RuntimeType checks ==========
  print('--- RuntimeType checks ---');
  print('  config1.runtimeType: ${config1.runtimeType}');
  print('  linearConfig.runtimeType: ${linearConfig.runtimeType}');

  print('FloatingHeaderSnapConfiguration test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'FloatingHeaderSnapConfiguration Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Basic config: ${config1.runtimeType}'),
          Text('Curve: ${config1.curve}'),
          Text('Duration: ${config1.duration.inMilliseconds}ms'),
          Text('Linear curve: ${linearConfig.curve}'),
          Text('Bounce curve: ${bounceConfig.curve}'),
          Text('Short duration: ${shortDuration.duration.inMilliseconds}ms'),
          Text('Long duration: ${longDuration.duration.inMilliseconds}ms'),
        ],
      ),
    ),
  );
}
