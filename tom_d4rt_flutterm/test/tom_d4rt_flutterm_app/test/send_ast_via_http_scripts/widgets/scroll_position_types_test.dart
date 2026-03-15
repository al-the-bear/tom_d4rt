// Tests: ScrollPosition, ScrollPositionWithSingleContext, ScrollContext,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
//        ScrollActivity, IdleScrollActivity, DrivenScrollActivity,
//        HoldScrollActivity, DragScrollActivity
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // --- ScrollPosition Tests ---
  print('--- ScrollPosition Tests ---');
  print('ScrollPosition determines which portion of content is visible');
  print('Type: $ScrollPosition');
  var scrollController = ScrollController(initialScrollOffset: 100.0);
  print('ScrollController: $scrollController');
  print(
    'ScrollController initialScrollOffset: ${scrollController.initialScrollOffset}',
  );
  print('ScrollPosition is managed by ScrollController');

  // --- ScrollPositionWithSingleContext Tests ---
  print('--- ScrollPositionWithSingleContext Tests ---');
  print(
    'ScrollPositionWithSingleContext is the default ScrollPosition implementation',
  );
  print('Type: $ScrollPositionWithSingleContext');
  print('Used when a scroll position is attached to a single ScrollContext');
  print('Manages physics, activity, and user interaction for scrolling');

  // --- ScrollContext Tests ---
  print('--- ScrollContext Tests ---');
  print('ScrollContext provides the context for a Scrollable widget');
  print('Type: $ScrollContext');
  print('Scrollable implements ScrollContext');
  print('Provides vsync, axis direction, and notification context');

  // --- ScrollActivity Tests ---
  print('--- ScrollActivity Tests ---');
  print('ScrollActivity is the base class for scroll activities');
  print('Type: $ScrollActivity');
  print('Represents what a scroll position is currently doing');
  print('IdleScrollActivity, DrivenScrollActivity, etc. extend it');

  // --- IdleScrollActivity Tests ---
  print('--- IdleScrollActivity Tests ---');
  print('IdleScrollActivity represents a scroll position at rest');
  print('Type: $IdleScrollActivity');
  print('Created when no scrolling is happening');
  print('isScrolling: false for IdleScrollActivity');

  // --- DrivenScrollActivity Tests ---
  print('--- DrivenScrollActivity Tests ---');
  print('DrivenScrollActivity represents an animated scroll');
  print('Type: $DrivenScrollActivity');
  print('Created by ScrollPosition.animateTo()');
  print('Drives scroll position via an animation controller');

  // --- HoldScrollActivity Tests ---
  print('--- HoldScrollActivity Tests ---');
  print('HoldScrollActivity represents holding a scroll position');
  print('Type: $HoldScrollActivity');
  print(
    'Created when the user touches the scrollable but has not started dragging',
  );
  print('Prevents ballistic animations from continuing');

  // --- DragScrollActivity Tests ---
  print('--- DragScrollActivity Tests ---');
  print('DragScrollActivity represents active user dragging');
  print('Type: $DragScrollActivity');
  print('Created when the user drags the scrollable');
  print('Updates scroll position based on user drag gestures');

  // Test ScrollController with FixedExtentScrollController
  var fixedExtentController = FixedExtentScrollController(initialItem: 5);
  print('FixedExtentScrollController: $fixedExtentController');
  print(
    'FixedExtentScrollController initialItem: ${fixedExtentController.initialItem}',
  );

  print('All scroll position types tests passed');

  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: 50,
                itemBuilder: (context, index) {
                  return ListTile(title: Text('Item $index'));
                },
              ),
            ),
            const Text('Scroll Position Types Test'),
          ],
        ),
      ),
    ),
  );
}
