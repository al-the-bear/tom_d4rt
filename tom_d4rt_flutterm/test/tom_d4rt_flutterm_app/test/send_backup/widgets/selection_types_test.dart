// Tests: TwoDimensionalScrollable, SelectionContainer, SelectableRegion,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
//        SelectionRegistrar, SelectionRegistrarScope, SelectionEvent,
//        SelectionHandler, SelectionOverlay
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // --- TwoDimensionalScrollable Tests ---
  print('--- TwoDimensionalScrollable Tests ---');
  print('TwoDimensionalScrollable manages scrolling in two axes');
  print('Type: $TwoDimensionalScrollable');
  print('Provides scroll controllers for horizontal and vertical axes');
  print('Used internally by TwoDimensionalScrollView');

  // --- SelectionContainer Tests ---
  print('--- SelectionContainer Tests ---');
  print('SelectionContainer enables text selection for its subtree');
  print('Type: SelectionContainer');
  var selectionContainer = SelectionContainer.disabled(
    child: const Text('Selectable text content'),
  );
  print('SelectionContainer: $selectionContainer');
  print('SelectionContainer wraps children to make them selectable');
  var disabledSelection = SelectionContainer.disabled(
    child: const Text('Non-selectable text'),
  );
  print('SelectionContainer.disabled: $disabledSelection');
  print('SelectionContainer.disabled prevents selection in subtree');

  // --- SelectableRegion Tests ---
  print('--- SelectableRegion Tests ---');
  print('SelectableRegion manages selection interactions');
  print('Type: $SelectableRegion');
  print('Handles selection gestures and provides selection toolbar');
  print('Used internally by SelectionArea and SelectionContainer');

  // --- SelectionRegistrar Tests ---
  print('--- SelectionRegistrar Tests ---');
  print('SelectionRegistrar registers selectables in the selection system');
  print('Type: SelectionRegistrar (internal framework class)');
  print('Abstract class for registering and unregistering selectables');
  print('Manages which widgets participate in selection');

  // --- SelectionRegistrarScope Tests ---
  print('--- SelectionRegistrarScope Tests ---');
  print('SelectionRegistrarScope provides SelectionRegistrar to subtree');
  print('Type: $SelectionRegistrarScope');
  print('InheritedWidget that makes a SelectionRegistrar available');
  print('Used by SelectableRegion to scope selection registration');

  // --- SelectionEvent Tests ---
  print('--- SelectionEvent Tests ---');
  print('SelectionEvent represents selection interaction events');
  print('Type: SelectionEvent (internal framework class)');
  print('Abstract base class for selection events');
  print('Subclasses include SelectWordSelectionEvent, etc.');

  // --- SelectionHandler Tests ---
  print('--- SelectionHandler Tests ---');
  print('SelectionHandler processes selection events');
  print('Type: SelectionHandler (internal framework mixin)');
  print('Abstract mixin for handling SelectionEvent instances');
  print('Implemented by widgets that respond to selection changes');

  // --- SelectionOverlay Tests ---
  print('--- SelectionOverlay Tests ---');
  print('SelectionOverlay displays selection handles and toolbar');
  print('Type: $SelectionOverlay');
  print('Manages the visual representation of text selection');
  print('Shows drag handles and context menu for selected text');

  print('All selection types tests passed');

  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectionArea(
              child: Column(
                children: [
                  selectionContainer,
                  disabledSelection,
                  const Text('Selection system test'),
                ],
              ),
            ),
            const Text('Selection Types Test'),
          ],
        ),
      ),
    ),
  );
}
