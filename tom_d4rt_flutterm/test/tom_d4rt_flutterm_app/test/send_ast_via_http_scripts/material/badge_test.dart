// D4rt test script: Tests Badge and FlutterLogo from Flutter material
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Badge and FlutterLogo test executing');

  // ========== BADGE ==========
  print('--- Badge Tests ---');

  // Variation 1: Basic Badge (dot indicator)
  final widget1 = Badge(child: Icon(Icons.mail, size: 32));
  print('Badge(dot, child: Icon) created');

  // Variation 2: Badge with label
  final widget2 = Badge(
    label: Text('5'),
    child: Icon(Icons.notifications, size: 32),
  );
  print('Badge(label: 5) created');

  // Variation 3: Badge with large count
  final widget3 = Badge(
    label: Text('99+'),
    child: Icon(Icons.shopping_cart, size: 32),
  );
  print('Badge(label: 99+) created');

  // Variation 4: Badge with backgroundColor
  final widget4 = Badge(
    label: Text('3'),
    backgroundColor: Colors.green,
    child: Icon(Icons.message, size: 32),
  );
  print('Badge(backgroundColor: green) created');

  // Variation 5: Badge with textColor
  final widget5 = Badge(
    label: Text('7'),
    backgroundColor: Colors.blue,
    textColor: Colors.yellow,
    child: Icon(Icons.inbox, size: 32),
  );
  print('Badge(textColor: yellow) created');

  // Variation 6: Badge with isLabelVisible false
  final widget6 = Badge(
    label: Text('0'),
    isLabelVisible: false,
    child: Icon(Icons.chat, size: 32),
  );
  print('Badge(isLabelVisible: false) created');

  // Variation 7: Badge with offset
  final widget7 = Badge(
    label: Text('2'),
    offset: Offset(4, -4),
    child: Icon(Icons.favorite, size: 32),
  );
  print('Badge(offset) created');

  // Variation 8: Badge with alignment
  final widget8 = Badge(
    label: Text('1'),
    alignment: AlignmentDirectional.bottomEnd,
    child: Icon(Icons.star, size: 32),
  );
  print('Badge(alignment: bottomEnd) created');

  // Variation 9: Badge with textStyle
  final widget9 = Badge(
    label: Text('NEW'),
    textStyle: TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
    child: Icon(Icons.local_offer, size: 32),
  );
  print('Badge(textStyle) created');

  // Variation 10: Badge with padding
  final widget10 = Badge(
    label: Text('Hi'),
    padding: EdgeInsets.symmetric(horizontal: 8.0),
    child: Icon(Icons.person, size: 32),
  );
  print('Badge(padding) created');

  // ========== FLUTTERLOGO ==========
  print('--- FlutterLogo Tests ---');

  // Variation 11: Basic FlutterLogo
  final widget11 = FlutterLogo();
  print('FlutterLogo() created');

  // Variation 12: FlutterLogo with size
  final widget12 = FlutterLogo(size: 80);
  print('FlutterLogo(size: 80) created');

  // Variation 13: FlutterLogo with textColor
  final widget13 = FlutterLogo(size: 60, textColor: Colors.blue);
  print('FlutterLogo(textColor: blue) created');

  // Variation 14: FlutterLogo with style markOnly
  final widget14 = FlutterLogo(size: 100, style: FlutterLogoStyle.markOnly);
  print('FlutterLogo(style: markOnly) created');

  // Variation 15: FlutterLogo with style horizontal
  final widget15 = FlutterLogo(size: 120, style: FlutterLogoStyle.horizontal);
  print('FlutterLogo(style: horizontal) created');

  // Variation 16: FlutterLogo with style stacked
  final widget16 = FlutterLogo(size: 100, style: FlutterLogoStyle.stacked);
  print('FlutterLogo(style: stacked) created');

  // Variation 17: FlutterLogo with duration and curve
  final widget17 = FlutterLogo(
    size: 64,
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
  );
  print('FlutterLogo(duration, curve) created');

  print('Badge and FlutterLogo test completed');
  return SingleChildScrollView(
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [widget1, widget2, widget3, widget4, widget5],
        ),
        SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [widget6, widget7, widget8, widget9, widget10],
        ),
        SizedBox(height: 24),
        widget11,
        SizedBox(height: 8),
        widget12,
        SizedBox(height: 8),
        widget14,
        SizedBox(height: 8),
        widget15,
        SizedBox(height: 8),
        widget16,
        SizedBox(height: 8),
        widget17,
      ],
    ),
  );
}
