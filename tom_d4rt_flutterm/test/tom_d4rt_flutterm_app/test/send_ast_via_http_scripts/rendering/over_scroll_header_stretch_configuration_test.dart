// D4rt test script: Tests OverScrollHeaderStretchConfiguration from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OverScrollHeaderStretchConfiguration test executing');

  // ========== Basic OverScrollHeaderStretchConfiguration creation ==========
  print('--- Basic OverScrollHeaderStretchConfiguration ---');
  final config1 = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 100.0,
  );
  print('  created: ${config1.runtimeType}');
  print('  stretchTriggerOffset: ${config1.stretchTriggerOffset}');

  // ========== Different stretchTriggerOffset values ==========
  print('--- Different stretchTriggerOffset values ---');
  final config50 = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 50.0,
  );
  print('  stretchTriggerOffset = 50: ${config50.stretchTriggerOffset}');

  final config100 = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 100.0,
  );
  print('  stretchTriggerOffset = 100: ${config100.stretchTriggerOffset}');

  final config150 = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 150.0,
  );
  print('  stretchTriggerOffset = 150: ${config150.stretchTriggerOffset}');

  final config200 = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 200.0,
  );
  print('  stretchTriggerOffset = 200: ${config200.stretchTriggerOffset}');

  // ========== onStretchTrigger callback ==========
  print('--- onStretchTrigger callback ---');
  bool triggered = false;
  final configWithCallback = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 100.0,
    onStretchTrigger: () async {
      triggered = true;
      print('  Stretch trigger activated!');
      return;
    },
  );
  print('  config with callback: ${configWithCallback.runtimeType}');
  print(
    '  has onStretchTrigger: ${configWithCallback.onStretchTrigger != null}',
  );

  // ========== Callback variations ==========
  print('--- Callback variations ---');
  int callCount = 0;
  final configCounter = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 80.0,
    onStretchTrigger: () async {
      callCount++;
      print('  callback count: $callCount');
    },
  );
  print(
    '  counter config: stretchTriggerOffset=${configCounter.stretchTriggerOffset}',
  );

  final configNoCallback = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 120.0,
  );
  print('  no callback config: ${configNoCallback.onStretchTrigger == null}');

  // ========== Small offset values ==========
  print('--- Small offset values ---');
  final config10 = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 10.0,
  );
  print('  small offset (10): ${config10.stretchTriggerOffset}');

  final config25 = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 25.0,
  );
  print('  small offset (25): ${config25.stretchTriggerOffset}');

  // ========== Large offset values ==========
  print('--- Large offset values ---');
  final config300 = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 300.0,
  );
  print('  large offset (300): ${config300.stretchTriggerOffset}');

  final config500 = OverScrollHeaderStretchConfiguration(
    stretchTriggerOffset: 500.0,
  );
  print('  large offset (500): ${config500.stretchTriggerOffset}');

  // ========== RuntimeType checks ==========
  print('--- RuntimeType checks ---');
  print('  config1.runtimeType: ${config1.runtimeType}');
  print('  configWithCallback.runtimeType: ${configWithCallback.runtimeType}');

  // ========== Multiple configurations ==========
  print('--- Multiple configurations ---');
  final offsets = [50.0, 75.0, 100.0, 125.0, 150.0];
  final configs = offsets.map((offset) {
    return OverScrollHeaderStretchConfiguration(
      stretchTriggerOffset: offset,
      onStretchTrigger: () async {
        print('  triggered at offset $offset');
      },
    );
  }).toList();
  for (int i = 0; i < configs.length; i++) {
    print('  config $i: offset=${configs[i].stretchTriggerOffset}');
  }

  print('OverScrollHeaderStretchConfiguration test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'OverScrollHeaderStretchConfiguration Tests',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Type: ${config1.runtimeType}'),
          Text('stretchTriggerOffset: ${config1.stretchTriggerOffset}'),
          SizedBox(height: 8.0),
          Text('Different offsets:'),
          Text('  50.0: ${config50.stretchTriggerOffset}'),
          Text('  100.0: ${config100.stretchTriggerOffset}'),
          Text('  150.0: ${config150.stretchTriggerOffset}'),
          Text('  200.0: ${config200.stretchTriggerOffset}'),
          SizedBox(height: 8.0),
          Text('With callback: ${configWithCallback.onStretchTrigger != null}'),
          Text('No callback: ${configNoCallback.onStretchTrigger == null}'),
          SizedBox(height: 8.0),
          Text('Use case: SliverAppBar stretch effect'),
          Text('Triggers refresh on overscroll'),
        ],
      ),
    ),
  );
}
