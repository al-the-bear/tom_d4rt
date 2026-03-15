// D4rt test script: Tests ExpansionTile from Flutter material (focused coverage)
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ExpansionTile focused test executing');

  // Variation 1: Basic ExpansionTile
  final widget1 = ExpansionTile(
    title: Text('Basic Tile'),
    children: [
      ListTile(title: Text('Child 1')),
      ListTile(title: Text('Child 2')),
    ],
  );
  print('ExpansionTile(basic) created');

  // Variation 2: ExpansionTile with subtitle
  final widget2 = ExpansionTile(
    title: Text('Titled Tile'),
    subtitle: Text('Subtitle text'),
    children: [
      Padding(padding: EdgeInsets.all(16.0), child: Text('Expandable content')),
    ],
  );
  print('ExpansionTile(subtitle) created');

  // Variation 3: ExpansionTile with leading icon
  final widget3 = ExpansionTile(
    leading: Icon(Icons.settings),
    title: Text('Settings'),
    children: [
      ListTile(leading: Icon(Icons.volume_up), title: Text('Sound')),
      ListTile(leading: Icon(Icons.brightness_6), title: Text('Display')),
    ],
  );
  print('ExpansionTile(leading: Icon) created');

  // Variation 4: ExpansionTile with trailing
  final widget4 = ExpansionTile(
    title: Text('Custom Trailing'),
    trailing: Icon(Icons.arrow_downward, color: Colors.blue),
    children: [ListTile(title: Text('Content'))],
  );
  print('ExpansionTile(trailing: custom Icon) created');

  // Variation 5: ExpansionTile initiallyExpanded
  final widget5 = ExpansionTile(
    title: Text('Expanded By Default'),
    initiallyExpanded: true,
    children: [
      Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.green.shade50,
        child: Text('This content is visible immediately'),
      ),
    ],
  );
  print('ExpansionTile(initiallyExpanded: true) created');

  // Variation 6: ExpansionTile with backgroundColor and collapsedBackgroundColor
  final widget6 = ExpansionTile(
    title: Text('Colored Tile'),
    backgroundColor: Colors.blue.shade50,
    collapsedBackgroundColor: Colors.grey.shade100,
    children: [
      Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Colored expanded content'),
      ),
    ],
  );
  print('ExpansionTile(backgroundColor, collapsedBackgroundColor) created');

  // Variation 7: ExpansionTile with textColor and collapsedTextColor
  final widget7 = ExpansionTile(
    title: Text('Styled Text'),
    textColor: Colors.blue,
    collapsedTextColor: Colors.grey,
    iconColor: Colors.blue,
    collapsedIconColor: Colors.grey,
    children: [ListTile(title: Text('Styled child'))],
  );
  print(
    'ExpansionTile(textColor, collapsedTextColor, iconColor, collapsedIconColor) created',
  );

  // Variation 8: ExpansionTile with tilePadding and childrenPadding
  final widget8 = ExpansionTile(
    title: Text('Padded Tile'),
    tilePadding: EdgeInsets.symmetric(horizontal: 24.0),
    childrenPadding: EdgeInsets.all(16.0),
    expandedCrossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Child with padding'),
      SizedBox(height: 8),
      Text('Another child'),
    ],
  );
  print(
    'ExpansionTile(tilePadding, childrenPadding, expandedCrossAxisAlignment) created',
  );

  // Variation 9: ExpansionTile with controlAffinity
  final widget9 = ExpansionTile(
    title: Text('Leading Control'),
    controlAffinity: ListTileControlAffinity.leading,
    children: [ListTile(title: Text('Expansion arrow on the left'))],
  );
  print('ExpansionTile(controlAffinity: leading) created');

  // Variation 10: ExpansionTile with shape and collapsedShape
  final widget10 = ExpansionTile(
    title: Text('Shaped Tile'),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      side: BorderSide(color: Colors.blue),
    ),
    collapsedShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
      side: BorderSide(color: Colors.grey),
    ),
    children: [ListTile(title: Text('Shaped content'))],
  );
  print('ExpansionTile(shape, collapsedShape) created');

  // Variation 11: ExpansionTile with onExpansionChanged callback
  final widget11 = ExpansionTile(
    title: Text('Callback Tile'),
    onExpansionChanged: (bool expanded) {
      print('Expansion changed: $expanded');
    },
    children: [ListTile(title: Text('Tracked expansion'))],
  );
  print('ExpansionTile(onExpansionChanged) created');

  print('ExpansionTile focused test completed');
  return SingleChildScrollView(
    child: Column(
      children: [
        widget1,
        widget2,
        widget3,
        widget4,
        widget5,
        widget6,
        widget7,
        widget8,
        widget9,
        widget10,
        widget11,
      ],
    ),
  );
}
