// D4rt test script: Tests RawScrollbar from Flutter material
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawScrollbar test executing');

  // Variation 1: Basic RawScrollbar wrapping ListView
  final widget1 = RawScrollbar(
    child: ListView.builder(
      itemCount: 30,
      itemBuilder: (BuildContext ctx, int index) {
        return ListTile(title: Text('Item $index'));
      },
    ),
  );
  print('RawScrollbar(basic, ListView.builder) created');

  // Variation 2: RawScrollbar with thumbVisibility
  final widget2 = RawScrollbar(
    thumbVisibility: true,
    child: ListView(
      children: [
        Container(
          height: 80,
          color: Colors.red.shade100,
          child: Center(child: Text('Red')),
        ),
        Container(
          height: 80,
          color: Colors.blue.shade100,
          child: Center(child: Text('Blue')),
        ),
        Container(
          height: 80,
          color: Colors.green.shade100,
          child: Center(child: Text('Green')),
        ),
        Container(
          height: 80,
          color: Colors.orange.shade100,
          child: Center(child: Text('Orange')),
        ),
        Container(
          height: 80,
          color: Colors.purple.shade100,
          child: Center(child: Text('Purple')),
        ),
        Container(
          height: 80,
          color: Colors.teal.shade100,
          child: Center(child: Text('Teal')),
        ),
      ],
    ),
  );
  print('RawScrollbar(thumbVisibility: true) created');

  // Variation 3: RawScrollbar with thickness
  final widget3 = RawScrollbar(
    thickness: 12.0,
    thumbVisibility: true,
    child: SingleChildScrollView(
      child: Column(
        children: List.generate(20, (i) {
          return Container(
            height: 50,
            color: i % 2 == 0 ? Colors.grey.shade200 : Colors.white,
            child: Center(child: Text('Row $i')),
          );
        }),
      ),
    ),
  );
  print('RawScrollbar(thickness: 12) created');

  // Variation 4: RawScrollbar with thumbColor
  final widget4 = RawScrollbar(
    thumbColor: Colors.red,
    thumbVisibility: true,
    child: ListView.builder(
      itemCount: 25,
      itemBuilder: (ctx, i) => ListTile(title: Text('Red thumb item $i')),
    ),
  );
  print('RawScrollbar(thumbColor: red) created');

  // Variation 5: RawScrollbar with radius
  final widget5 = RawScrollbar(
    radius: Radius.circular(8.0),
    thumbVisibility: true,
    thumbColor: Colors.blue,
    child: ListView.builder(
      itemCount: 20,
      itemBuilder: (ctx, i) => ListTile(title: Text('Rounded thumb $i')),
    ),
  );
  print('RawScrollbar(radius: 8) created');

  // Variation 6: RawScrollbar with fadeDuration and timeToFade
  final widget6 = RawScrollbar(
    fadeDuration: Duration(milliseconds: 500),
    timeToFade: Duration(seconds: 2),
    child: ListView.builder(
      itemCount: 15,
      itemBuilder: (ctx, i) => ListTile(title: Text('Fade item $i')),
    ),
  );
  print('RawScrollbar(fadeDuration, timeToFade) created');

  // Variation 7: RawScrollbar with padding
  final widget7 = RawScrollbar(
    padding: EdgeInsets.symmetric(vertical: 8.0),
    thumbVisibility: true,
    child: ListView.builder(
      itemCount: 20,
      itemBuilder: (ctx, i) => ListTile(title: Text('Padded item $i')),
    ),
  );
  print('RawScrollbar(padding) created');

  // Variation 8: RawScrollbar with crossAxisMargin and mainAxisMargin
  final widget8 = RawScrollbar(
    crossAxisMargin: 4.0,
    mainAxisMargin: 8.0,
    thumbVisibility: true,
    thumbColor: Colors.green,
    child: ListView.builder(
      itemCount: 20,
      itemBuilder: (ctx, i) => ListTile(title: Text('Margined item $i')),
    ),
  );
  print('RawScrollbar(crossAxisMargin, mainAxisMargin) created');

  // Variation 9: RawScrollbar with minThumbLength
  final widget9 = RawScrollbar(
    minThumbLength: 48.0,
    thumbVisibility: true,
    child: ListView.builder(
      itemCount: 100,
      itemBuilder: (ctx, i) => ListTile(title: Text('Min length $i')),
    ),
  );
  print('RawScrollbar(minThumbLength: 48) created');

  // Variation 10: RawScrollbar interactive (trackVisibility)
  final widget10 = RawScrollbar(
    thumbVisibility: true,
    trackVisibility: true,
    trackColor: Colors.grey.shade200,
    trackBorderColor: Colors.grey.shade400,
    trackRadius: Radius.circular(4.0),
    interactive: true,
    child: ListView.builder(
      itemCount: 50,
      itemBuilder: (ctx, i) => ListTile(title: Text('Track visible $i')),
    ),
  );
  print(
    'RawScrollbar(trackVisibility, trackColor, trackBorderColor, interactive) created',
  );

  print('RawScrollbar test completed');
  return Column(
    children: [
      Expanded(child: widget1),
      SizedBox(height: 8),
      Expanded(child: widget4),
      SizedBox(height: 8),
      Expanded(child: widget10),
    ],
  );
}
