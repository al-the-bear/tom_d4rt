// D4rt test script: Tests ReorderableListView from Flutter material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ReorderableListView test executing');

  // Variation 1: Basic ReorderableListView with ListTiles
  final widget1 = ReorderableListView(
    onReorder: (old, newIdx) {
      print('reorder $old -> $newIdx');
    },
    children: [
      ListTile(key: ValueKey(0), title: Text('Item 0')),
      ListTile(key: ValueKey(1), title: Text('Item 1')),
      ListTile(key: ValueKey(2), title: Text('Item 2')),
    ],
  );
  print('ReorderableListView(basic 3 items) created');

  // Variation 2: ReorderableListView with padding
  final widget2 = ReorderableListView(
    padding: EdgeInsets.all(16),
    onReorder: (old, newIdx) {
      print('reorder with padding $old -> $newIdx');
    },
    children: [
      ListTile(
        key: ValueKey(10),
        title: Text('Padded 0'),
        leading: Icon(Icons.drag_handle),
      ),
      ListTile(
        key: ValueKey(11),
        title: Text('Padded 1'),
        leading: Icon(Icons.drag_handle),
      ),
      ListTile(
        key: ValueKey(12),
        title: Text('Padded 2'),
        leading: Icon(Icons.drag_handle),
      ),
      ListTile(
        key: ValueKey(13),
        title: Text('Padded 3'),
        leading: Icon(Icons.drag_handle),
      ),
    ],
  );
  print('ReorderableListView(with padding) created');

  // Variation 3: ReorderableListView.builder
  final widget3 = ReorderableListView.builder(
    onReorder: (old, newIdx) {
      print('builder reorder $old -> $newIdx');
    },
    itemCount: 5,
    itemBuilder: (context, index) => ListTile(
      key: ValueKey(index),
      title: Text('Builder Item $index'),
      subtitle: Text('Subtitle $index'),
    ),
  );
  print('ReorderableListView.builder(itemCount: 5) created');

  // Variation 4: ReorderableListView with header and custom children
  final widget4 = ReorderableListView(
    header: Container(
      padding: EdgeInsets.all(16),
      color: Colors.blue.shade100,
      child: Text('Reorderable List Header'),
    ),
    onReorder: (old, newIdx) {
      print('header list reorder $old -> $newIdx');
    },
    children: [
      Card(
        key: ValueKey(20),
        child: ListTile(title: Text('Card Item 0')),
      ),
      Card(
        key: ValueKey(21),
        child: ListTile(title: Text('Card Item 1')),
      ),
      Card(
        key: ValueKey(22),
        child: ListTile(title: Text('Card Item 2')),
      ),
    ],
  );
  print('ReorderableListView(with header) created');

  print('ReorderableListView test completed');
  return Column(
    children: [
      Expanded(child: widget1),
      Expanded(child: widget2),
      Expanded(child: widget3),
      Expanded(child: widget4),
    ],
  );
}
