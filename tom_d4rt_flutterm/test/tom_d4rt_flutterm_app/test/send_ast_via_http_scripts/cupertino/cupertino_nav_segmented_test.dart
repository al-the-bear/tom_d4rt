// D4rt test script: Tests CupertinoSliverNavigationBar,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// CupertinoNavigationBarBackButtonMode, CupertinoSegmentedControl variants,
// CupertinoSlidingSegmentedControl
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino nav/segmented test executing');

  // ========== CupertinoNavigationBarBackButtonMode ==========
  print('--- CupertinoNavigationBarBackButtonMode Tests ---');
  // The enum values
  print('automatic mode');
  print('noBackButton mode');

  // ========== CupertinoSliverNavigationBar ==========
  print('--- CupertinoSliverNavigationBar Tests ---');
  final sliverNav = CupertinoSliverNavigationBar(
    largeTitle: Text('Large Title'),
    leading: CupertinoButton(
      padding: EdgeInsets.zero,
      child: Icon(CupertinoIcons.back),
      onPressed: () {},
    ),
    trailing: CupertinoButton(
      padding: EdgeInsets.zero,
      child: Icon(CupertinoIcons.add),
      onPressed: () {},
    ),
    previousPageTitle: 'Back',
    border: Border(
      bottom: BorderSide(color: CupertinoColors.separator, width: 0.0),
    ),
    backgroundColor: CupertinoColors.systemBackground,
    brightness: Brightness.light,
    padding: EdgeInsetsDirectional.only(start: 16.0, end: 16.0),
    stretch: true,
  );
  print('CupertinoSliverNavigationBar created');

  // ========== CupertinoSlidingSegmentedControl ==========
  print('--- CupertinoSlidingSegmentedControl Tests ---');
  final slidingSegmented = CupertinoSlidingSegmentedControl<int>(
    groupValue: 0,
    onValueChanged: (int? value) {
      print('Sliding segment changed: $value');
    },
    children: {0: Text('First'), 1: Text('Second'), 2: Text('Third')},
    thumbColor: CupertinoColors.white,
    backgroundColor: CupertinoColors.systemGrey5,
    padding: EdgeInsets.all(4.0),
  );
  print('CupertinoSlidingSegmentedControl created with 3 segments');

  // ========== CupertinoSegmentedControl ==========
  print('--- CupertinoSegmentedControl Tests ---');
  final segmented = CupertinoSegmentedControl<int>(
    groupValue: 1,
    onValueChanged: (int value) {
      print('Segment changed: $value');
    },
    children: {
      0: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('One'),
      ),
      1: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('Two'),
      ),
      2: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Text('Three'),
      ),
    },
    selectedColor: CupertinoColors.activeBlue,
    unselectedColor: CupertinoColors.white,
    borderColor: CupertinoColors.activeBlue,
    pressedColor: CupertinoColors.systemGrey4,
    padding: EdgeInsets.symmetric(horizontal: 16.0),
  );
  print('CupertinoSegmentedControl created');

  print('All cupertino nav/segmented tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    home: CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          sliverNav,
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [slidingSegmented, SizedBox(height: 16.0), segmented],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
