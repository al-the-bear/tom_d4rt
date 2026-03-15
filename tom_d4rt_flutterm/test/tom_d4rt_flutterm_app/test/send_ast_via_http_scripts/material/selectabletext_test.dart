// D4rt test script: Tests SelectableText from material
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SelectableText test executing');

  // Test basic SelectableText
  final selectBasic = SelectableText('This is selectable text');
  print('SelectableText basic created');

  // Test SelectableText with style
  final selectStyled = SelectableText(
    'Styled selectable text',
    style: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
    ),
  );
  print('SelectableText with style created');

  // Test SelectableText with textAlign center
  final selectCenter = SelectableText(
    'Center aligned selectable text',
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 16.0),
  );
  print('SelectableText with textAlign=center created');

  // Test SelectableText with textAlign right
  final selectRight = SelectableText(
    'Right aligned selectable text',
    textAlign: TextAlign.right,
    style: TextStyle(fontSize: 16.0),
  );
  print('SelectableText with textAlign=right created');

  // Test SelectableText with maxLines
  final selectMaxLines = SelectableText(
    'This is a long selectable text that should be limited to two lines maximum. It will be truncated if it exceeds the maximum number of lines specified.',
    maxLines: 2,
    style: TextStyle(fontSize: 14.0),
  );
  print('SelectableText with maxLines=2 created');

  // Test SelectableText with maxLines=1
  final selectSingleLine = SelectableText(
    'Single line selectable text that might overflow',
    maxLines: 1,
    style: TextStyle(fontSize: 14.0),
  );
  print('SelectableText with maxLines=1 created');

  // Test SelectableText with cursorColor
  final selectCursor = SelectableText(
    'Custom cursor color',
    cursorColor: Colors.red,
    style: TextStyle(fontSize: 16.0),
  );
  print('SelectableText with cursorColor=red created');

  // Test SelectableText with cursorWidth
  final selectCursorWidth = SelectableText(
    'Wide cursor',
    cursorWidth: 4.0,
    cursorColor: Colors.blue,
    style: TextStyle(fontSize: 16.0),
  );
  print('SelectableText with cursorWidth=4 created');

  // Test SelectableText with semanticsLabel
  final selectSemantics = SelectableText(
    'Accessible text',
    semanticsLabel: 'This is accessible selectable text for screen readers',
    style: TextStyle(fontSize: 16.0),
  );
  print('SelectableText with semanticsLabel created');

  // Test SelectableText with showCursor
  final selectShowCursor = SelectableText(
    'Always show cursor',
    showCursor: true,
    cursorColor: Colors.green,
    cursorWidth: 2.0,
    style: TextStyle(fontSize: 16.0),
  );
  print('SelectableText with showCursor=true created');

  // Test SelectableText with textDirection
  final selectDirection = SelectableText(
    'Left to right text',
    textDirection: TextDirection.ltr,
    style: TextStyle(fontSize: 16.0),
  );
  print('SelectableText with textDirection=ltr created');

  // Test SelectableText with large text
  final selectLarge = SelectableText(
    'Large selectable',
    style: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.purple,
    ),
  );
  print('SelectableText with large font created');

  // Test SelectableText with italic style
  final selectItalic = SelectableText(
    'Italic selectable text',
    style: TextStyle(
      fontSize: 16.0,
      fontStyle: FontStyle.italic,
      color: Colors.deepOrange,
    ),
  );
  print('SelectableText with italic style created');

  // Test SelectableText with onTap
  final selectTap = SelectableText(
    'Tap me - I am selectable',
    onTap: () {
      print('SelectableText tapped');
    },
    style: TextStyle(
      fontSize: 16.0,
      color: Colors.teal,
      decoration: TextDecoration.underline,
    ),
  );
  print('SelectableText with onTap created');

  // Test SelectableText with textScaler
  final selectScaled = SelectableText(
    'Scaled text',
    textScaler: TextScaler.linear(1.5),
    style: TextStyle(fontSize: 14.0),
  );
  print('SelectableText with textScaler=1.5 created');

  print('All SelectableText tests completed');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '=== SelectableText Tests ===',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        SizedBox(height: 8.0),
        Text('Basic:', style: TextStyle(fontWeight: FontWeight.bold)),
        selectBasic,
        SizedBox(height: 8.0),
        Text('Styled:', style: TextStyle(fontWeight: FontWeight.bold)),
        selectStyled,
        SizedBox(height: 8.0),
        Text('Center aligned:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 300.0, child: selectCenter),
        SizedBox(height: 8.0),
        Text('Right aligned:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 300.0, child: selectRight),
        SizedBox(height: 8.0),
        Text('MaxLines=2:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 250.0, child: selectMaxLines),
        SizedBox(height: 8.0),
        Text('Single line:', style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(width: 200.0, child: selectSingleLine),
        SizedBox(height: 8.0),
        Text(
          'Cursor color=red:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        selectCursor,
        SizedBox(height: 8.0),
        Text('Cursor width=4:', style: TextStyle(fontWeight: FontWeight.bold)),
        selectCursorWidth,
        SizedBox(height: 8.0),
        Text('Semantics label:', style: TextStyle(fontWeight: FontWeight.bold)),
        selectSemantics,
        SizedBox(height: 8.0),
        Text('Show cursor:', style: TextStyle(fontWeight: FontWeight.bold)),
        selectShowCursor,
        SizedBox(height: 8.0),
        Text('Text direction:', style: TextStyle(fontWeight: FontWeight.bold)),
        selectDirection,
        SizedBox(height: 8.0),
        Text('Large font:', style: TextStyle(fontWeight: FontWeight.bold)),
        selectLarge,
        SizedBox(height: 8.0),
        Text('Italic:', style: TextStyle(fontWeight: FontWeight.bold)),
        selectItalic,
        SizedBox(height: 8.0),
        Text('With onTap:', style: TextStyle(fontWeight: FontWeight.bold)),
        selectTap,
        SizedBox(height: 8.0),
        Text('Scaled 1.5x:', style: TextStyle(fontWeight: FontWeight.bold)),
        selectScaled,
        SizedBox(height: 16.0),
        Text('Key Points:', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('• SelectableText allows user to select and copy text'),
        Text('• style controls text appearance (font, color, weight)'),
        Text('• textAlign controls horizontal alignment'),
        Text('• maxLines limits visible lines'),
        Text('• cursorColor and cursorWidth customize the cursor'),
        Text('• semanticsLabel provides screen reader description'),
      ],
    ),
  );
}
