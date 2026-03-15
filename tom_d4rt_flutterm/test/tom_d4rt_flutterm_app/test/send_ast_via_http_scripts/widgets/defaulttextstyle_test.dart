// D4rt test script: Tests DefaultTextStyle, AnimatedDefaultTextStyle from widgets
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DefaultTextStyle test executing');

  // ========== DEFAULTTEXTSTYLE ==========
  print('--- DefaultTextStyle Tests ---');

  // DefaultTextStyle provides a default text style to descendants
  final styledText = DefaultTextStyle(
    style: TextStyle(
      fontSize: 20.0,
      color: Colors.blue,
      fontWeight: FontWeight.bold,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Inherits default style'),
        Text('Also uses default style'),
        Text('Overridden', style: TextStyle(color: Colors.red)),
      ],
    ),
  );
  print('DefaultTextStyle with blue bold 20.0 created');

  // Test with textAlign
  final alignedText = DefaultTextStyle(
    style: TextStyle(fontSize: 16.0, color: Colors.green),
    textAlign: TextAlign.center,
    child: Text('Centered text'),
  );
  print('DefaultTextStyle with textAlign.center created');

  // Test with softWrap false
  final noWrapText = DefaultTextStyle(
    style: TextStyle(fontSize: 14.0),
    softWrap: false,
    child: Text('No wrapping text here'),
  );
  print('DefaultTextStyle with softWrap=false created');

  // Test with overflow
  final overflowText = DefaultTextStyle(
    style: TextStyle(fontSize: 14.0),
    overflow: TextOverflow.ellipsis,
    child: Text('This text might be too long and will be ellipsized'),
  );
  print('DefaultTextStyle with overflow=ellipsis created');

  // Test with maxLines
  final maxLinesText = DefaultTextStyle(
    style: TextStyle(fontSize: 14.0),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    child: Text('Line 1\nLine 2\nLine 3 - should be hidden'),
  );
  print('DefaultTextStyle with maxLines=2 created');

  // Test DefaultTextStyle.merge
  final mergedStyle = DefaultTextStyle.merge(
    style: TextStyle(fontStyle: FontStyle.italic),
    child: Text('Merged italic style'),
  );
  print('DefaultTextStyle.merge created');

  // Test DefaultTextStyle.of
  // (needs to be inside the tree to work properly)

  // ========== ANIMATEDDEFAULTTEXTSTYLE ==========
  print('--- AnimatedDefaultTextStyle Tests ---');

  final animatedStyle = AnimatedDefaultTextStyle(
    style: TextStyle(
      fontSize: 24.0,
      color: Colors.purple,
      fontWeight: FontWeight.w600,
    ),
    duration: Duration(milliseconds: 300),
    child: Text('Animated text style'),
  );
  print('AnimatedDefaultTextStyle created');

  // With curve
  final animatedCurved = AnimatedDefaultTextStyle(
    style: TextStyle(fontSize: 18.0, color: Colors.orange),
    duration: Duration(milliseconds: 500),
    curve: Curves.easeInOut,
    child: Text('Curved animation'),
  );
  print('AnimatedDefaultTextStyle with curve created');

  // With textAlign
  final animatedAligned = AnimatedDefaultTextStyle(
    style: TextStyle(fontSize: 16.0, color: Colors.teal),
    duration: Duration(milliseconds: 200),
    textAlign: TextAlign.right,
    softWrap: true,
    maxLines: 3,
    overflow: TextOverflow.fade,
    child: Text('Animated aligned text'),
  );
  print('AnimatedDefaultTextStyle with all params created');

  print('All DefaultTextStyle tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DefaultTextStyle Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            styledText,
            SizedBox(height: 8.0),
            alignedText,
            SizedBox(height: 8.0),
            animatedStyle,
            SizedBox(height: 8.0),
            animatedCurved,
          ],
        ),
      ),
    ),
  );
}
