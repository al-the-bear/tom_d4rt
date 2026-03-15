// D4rt test script: Tests CupertinoMagnifier from cupertino
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoMagnifier test executing');

  // ========== CUPERTINOMAGNIFIER ==========
  print('--- CupertinoMagnifier Tests ---');

  // Test basic CupertinoMagnifier with defaults
  final basicMagnifier = CupertinoMagnifier();
  print('Basic CupertinoMagnifier created');

  // Test CupertinoMagnifier with custom size
  final customSizeMagnifier = CupertinoMagnifier(size: Size(100.0, 50.0));
  print('CupertinoMagnifier with custom size created');

  // Test CupertinoMagnifier with borderRadius
  final roundedMagnifier = CupertinoMagnifier(
    borderRadius: BorderRadius.circular(20.0),
  );
  print('CupertinoMagnifier with borderRadius created');

  // Test CupertinoMagnifier with custom insets
  final insetsMagnifier = CupertinoMagnifier(
    additionalFocalPointOffset: Offset(0.0, -10.0),
  );
  print('CupertinoMagnifier with additionalFocalPointOffset created');

  // Test CupertinoMagnifier with all params
  final fullMagnifier = CupertinoMagnifier(
    size: Size(120.0, 60.0),
    borderRadius: BorderRadius.circular(16.0),
    additionalFocalPointOffset: Offset(0.0, -5.0),
  );
  print('CupertinoMagnifier with all params created');

  // Test small magnifier
  final smallMagnifier = CupertinoMagnifier(
    size: Size(60.0, 30.0),
    borderRadius: BorderRadius.circular(8.0),
  );
  print('Small CupertinoMagnifier created');

  // Test large magnifier
  final largeMagnifier = CupertinoMagnifier(
    size: Size(200.0, 100.0),
    borderRadius: BorderRadius.circular(24.0),
  );
  print('Large CupertinoMagnifier created');

  // Test CupertinoMagnifier with zero offset
  final zeroOffsetMagnifier = CupertinoMagnifier(
    additionalFocalPointOffset: Offset.zero,
  );
  print('CupertinoMagnifier with zero offset created');

  print('All CupertinoMagnifier tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Magnifier Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CupertinoMagnifier Sizes:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text('Default magnifier:'),
              SizedBox(height: 8.0),
              SizedBox(width: 100.0, height: 50.0, child: basicMagnifier),
              SizedBox(height: 16.0),
              Text('Small magnifier:'),
              SizedBox(height: 8.0),
              SizedBox(width: 80.0, height: 40.0, child: smallMagnifier),
              SizedBox(height: 16.0),
              Text('Custom size magnifier:'),
              SizedBox(height: 8.0),
              SizedBox(width: 120.0, height: 60.0, child: customSizeMagnifier),
              SizedBox(height: 16.0),
              Text('Rounded magnifier:'),
              SizedBox(height: 8.0),
              SizedBox(width: 100.0, height: 50.0, child: roundedMagnifier),
              SizedBox(height: 16.0),
              Text('Full params magnifier:'),
              SizedBox(height: 8.0),
              SizedBox(width: 140.0, height: 70.0, child: fullMagnifier),
              SizedBox(height: 24.0),
              Text(
                'Tests Completed:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text('• CupertinoMagnifier default'),
              Text('• CupertinoMagnifier custom size'),
              Text('• CupertinoMagnifier borderRadius'),
              Text('• CupertinoMagnifier additionalFocalPointOffset'),
              Text('• CupertinoMagnifier full params'),
            ],
          ),
        ),
      ),
    ),
  );
}
