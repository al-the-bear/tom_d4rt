// D4rt test script: Tests CupertinoLinearActivityIndicator from cupertino
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoLinearActivityIndicator test executing');

  // ===== 1. Progress at various values =====
  print('--- Progress values ---');
  final progressValues = [0.0, 0.25, 0.5, 0.75, 1.0];
  final indicators = <Widget>[];
  for (final p in progressValues) {
    indicators.add(
      Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            SizedBox(width: 50.0, child: Text('${(p * 100).toInt()}%')),
            Expanded(child: CupertinoLinearActivityIndicator(progress: p)),
          ],
        ),
      ),
    );
    print('  progress $p indicator created');
  }

  // ===== 2. Custom height =====
  print('--- Custom height ---');
  final thinIndicator = CupertinoLinearActivityIndicator(
    progress: 0.6,
    height: 2.0,
  );
  print('  thin indicator (height: 2.0) created');

  final thickIndicator = CupertinoLinearActivityIndicator(
    progress: 0.6,
    height: 12.0,
  );
  print('  thick indicator (height: 12.0) created');

  final defaultHeight = CupertinoLinearActivityIndicator(progress: 0.6);
  print('  default height (4.5) indicator created');

  // ===== 3. Custom color =====
  print('--- Custom color ---');
  final blueIndicator = CupertinoLinearActivityIndicator(
    progress: 0.7,
    color: CupertinoColors.activeBlue,
  );
  print('  blue indicator created');

  final greenIndicator = CupertinoLinearActivityIndicator(
    progress: 0.5,
    color: CupertinoColors.systemGreen,
  );
  print('  green indicator created');

  final redIndicator = CupertinoLinearActivityIndicator(
    progress: 0.3,
    color: CupertinoColors.systemRed,
  );
  print('  red indicator created');

  final orangeIndicator = CupertinoLinearActivityIndicator(
    progress: 0.9,
    color: CupertinoColors.systemOrange,
  );
  print('  orange indicator created');

  // ===== 4. Combined: custom color + custom height =====
  print('--- Combined customization ---');
  final combined = CupertinoLinearActivityIndicator(
    progress: 0.85,
    height: 8.0,
    color: CupertinoColors.systemPurple,
  );
  print('  combined (height: 8.0, color: purple, progress: 0.85)');

  // ===== 5. Zero and full progress edge cases =====
  print('--- Edge cases ---');
  final empty = CupertinoLinearActivityIndicator(progress: 0.0);
  final full = CupertinoLinearActivityIndicator(progress: 1.0);
  print('  zero progress: created');
  print('  full progress: created');

  print('CupertinoLinearActivityIndicator test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('LinearActivityIndicator'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Progress values:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...indicators,
              SizedBox(height: 16.0),
              Text('Heights:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4.0),
              Text('Thin (2.0):'),
              thinIndicator,
              SizedBox(height: 8.0),
              Text('Default (4.5):'),
              defaultHeight,
              SizedBox(height: 8.0),
              Text('Thick (12.0):'),
              thickIndicator,
              SizedBox(height: 16.0),
              Text('Colors:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 4.0),
              blueIndicator,
              SizedBox(height: 4.0),
              greenIndicator,
              SizedBox(height: 4.0),
              redIndicator,
              SizedBox(height: 4.0),
              orangeIndicator,
              SizedBox(height: 16.0),
              Text('Combined:', style: TextStyle(fontWeight: FontWeight.bold)),
              combined,
              SizedBox(height: 16.0),
              Text(
                'Edge cases:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.0),
              empty,
              SizedBox(height: 4.0),
              full,
            ],
          ),
        ),
      ),
    ),
  );
}
