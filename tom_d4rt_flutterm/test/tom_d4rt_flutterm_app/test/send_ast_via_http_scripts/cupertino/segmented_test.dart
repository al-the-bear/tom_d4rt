// D4rt test script: Tests CupertinoSegmentedControl and CupertinoSlidingSegmentedControl
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino segmented controls test executing');

  // ===== 1. CupertinoSegmentedControl with Map =====
  print('--- CupertinoSegmentedControl ---');
  final segmented = CupertinoSegmentedControl(
    children: {
      0: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('Day'),
      ),
      1: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('Week'),
      ),
      2: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('Month'),
      ),
    },
    groupValue: 0,
    onValueChanged: (value) {
      print('  segmented changed: $value');
    },
  );
  print('  basic segmented control created');

  // ===== 2. CupertinoSegmentedControl with custom colors =====
  print('--- Custom colors ---');
  final coloredSegmented = CupertinoSegmentedControl(
    children: {'a': Text('Alpha'), 'b': Text('Beta'), 'c': Text('Gamma')},
    groupValue: 'a',
    onValueChanged: (value) {},
    selectedColor: CupertinoColors.systemGreen,
    unselectedColor: CupertinoColors.white,
    borderColor: CupertinoColors.systemGreen,
    pressedColor: CupertinoColors.systemGreen.withOpacity(0.2),
  );
  print('  colored segmented (green theme) created');

  // ===== 3. CupertinoSlidingSegmentedControl =====
  print('--- CupertinoSlidingSegmentedControl ---');
  final sliding = CupertinoSlidingSegmentedControl(
    children: {0: Text('All'), 1: Text('Missed')},
    groupValue: 0,
    onValueChanged: (value) {
      print('  sliding changed: $value');
    },
  );
  print('  basic sliding control created');

  // ===== 4. Sliding with custom background and thumb color =====
  print('--- Sliding custom colors ---');
  final customSliding = CupertinoSlidingSegmentedControl(
    children: {0: Text('Posts'), 1: Text('Reels'), 2: Text('Tags')},
    groupValue: 1,
    onValueChanged: (value) {},
    backgroundColor: CupertinoColors.systemGrey5,
    thumbColor: CupertinoColors.white,
  );
  print('  custom sliding control created');

  // ===== 5. Sliding with icons =====
  print('--- Sliding with icons ---');
  final iconSliding = CupertinoSlidingSegmentedControl(
    children: {
      0: Icon(CupertinoIcons.list_bullet, size: 20.0),
      1: Icon(CupertinoIcons.square_grid_2x2, size: 20.0),
      2: Icon(CupertinoIcons.map, size: 20.0),
    },
    groupValue: 0,
    onValueChanged: (value) {},
  );
  print('  icon sliding control created');

  // ===== 6. Many segments =====
  print('--- Many segments ---');
  final manySegments = CupertinoSegmentedControl(
    children: {
      for (var i = 0; i < 5; i++)
        i: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('S$i'),
        ),
    },
    groupValue: 2,
    onValueChanged: (value) {},
  );
  print('  5-segment control created');

  // ===== 7. Two segments (minimum) =====
  print('--- Minimum segments ---');
  final twoSegments = CupertinoSlidingSegmentedControl(
    children: {true: Text('On'), false: Text('Off')},
    groupValue: true,
    onValueChanged: (value) {},
  );
  print('  boolean sliding control created');

  // ===== 8. Null groupValue (no selection) =====
  print('--- Null selection ---');
  final noSelection = CupertinoSlidingSegmentedControl(
    children: {0: Text('None'), 1: Text('Selected')},
    groupValue: null,
    onValueChanged: (value) {},
  );
  print('  no-selection sliding created');

  print('Cupertino segmented controls test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Segmented Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'CupertinoSegmentedControl:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              segmented,
              SizedBox(height: 16.0),
              Text(
                'Custom colors:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              coloredSegmented,
              SizedBox(height: 16.0),
              Text(
                'Many segments:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              manySegments,
              SizedBox(height: 24.0),
              Text(
                'CupertinoSlidingSegmentedControl:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              sliding,
              SizedBox(height: 16.0),
              Text(
                'Custom sliding:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              customSliding,
              SizedBox(height: 16.0),
              Text(
                'Icon sliding:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Center(child: iconSliding),
              SizedBox(height: 16.0),
              Text(
                'Boolean sliding:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Center(child: twoSegments),
              SizedBox(height: 16.0),
              Text(
                'No selection:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Center(child: noSelection),
            ],
          ),
        ),
      ),
    ),
  );
}
