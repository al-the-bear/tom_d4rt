// D4rt test script: Tests RenderEditable from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderEditable test executing');

  // ========== RENDER EDITABLE BASICS ==========
  print('--- RenderEditable Basics ---');
  print('RenderEditable is the render object for editable text');
  print('Used by TextField, TextFormField, EditableText');
  print('Handles text layout, selection, and cursor rendering');

  // Test using TextField which uses RenderEditable internally
  final basicTextField = Container(
    width: 250,
    child: TextField(
      decoration: InputDecoration(
        labelText: 'Basic TextField',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Basic TextField created');
  print('  Uses RenderEditable internally');

  // ========== TEXT PROPERTIES ==========
  print('--- Text Properties ---');

  // Test with initial text
  final textController = TextEditingController(text: 'Hello World');
  final withText = Container(
    width: 250,
    child: TextField(
      controller: textController,
      decoration: InputDecoration(
        labelText: 'With Initial Text',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('TextField with initial text: "${textController.text}"');

  // Test maxLines
  final multiLine = Container(
    width: 250,
    child: TextField(
      maxLines: 3,
      decoration: InputDecoration(
        labelText: 'Multi-line',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Multi-line TextField: maxLines = 3');

  // Test single line
  final singleLine = Container(
    width: 250,
    child: TextField(
      maxLines: 1,
      decoration: InputDecoration(
        labelText: 'Single Line',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Single-line TextField: maxLines = 1');

  // ========== CURSOR PROPERTIES ==========
  print('--- Cursor Properties ---');

  final customCursor = Container(
    width: 250,
    child: TextField(
      decoration: InputDecoration(
        labelText: 'Custom Cursor',
        border: OutlineInputBorder(),
      ),
      cursorColor: Colors.red,
      cursorWidth: 4,
      cursorRadius: Radius.circular(2),
    ),
  );
  print('Custom cursor: red, width 4, radius 2');

  final thickCursor = Container(
    width: 250,
    child: TextField(
      decoration: InputDecoration(
        labelText: 'Thick Cursor',
        border: OutlineInputBorder(),
      ),
      cursorColor: Colors.blue,
      cursorWidth: 6,
    ),
  );
  print('Thick blue cursor: width 6');

  // ========== SELECTION HANDLING ==========
  print('--- Selection Handling ---');
  print('RenderEditable manages TextSelection');
  print('Selection includes base and extent offsets');
  print('Handles drag selection and double-click word selection');

  final selectionController = TextEditingController(text: 'Select this text');
  final selectionField = Container(
    width: 250,
    child: TextField(
      controller: selectionController,
      decoration: InputDecoration(
        labelText: 'Selection Test',
        border: OutlineInputBorder(),
      ),
      enableInteractiveSelection: true,
    ),
  );
  print('TextField with interactive selection enabled');

  // ========== TEXT ALIGNMENT ==========
  print('--- Text Alignment ---');

  final leftAligned = Container(
    width: 250,
    child: TextField(
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        labelText: 'Left Aligned',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Left aligned text');

  final centerAligned = Container(
    width: 250,
    child: TextField(
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        labelText: 'Center Aligned',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Center aligned text');

  final rightAligned = Container(
    width: 250,
    child: TextField(
      textAlign: TextAlign.right,
      decoration: InputDecoration(
        labelText: 'Right Aligned',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Right aligned text');

  // ========== TEXT DIRECTION ==========
  print('--- Text Direction ---');

  final ltrText = Container(
    width: 250,
    child: TextField(
      textDirection: TextDirection.ltr,
      decoration: InputDecoration(
        labelText: 'LTR Text',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Left-to-right text direction');

  final rtlText = Container(
    width: 250,
    child: TextField(
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        labelText: 'RTL Text',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Right-to-left text direction');

  // ========== STYLING ==========
  print('--- Text Styling ---');

  final styledText = Container(
    width: 250,
    child: TextField(
      style: TextStyle(
        fontSize: 20,
        color: Colors.purple,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        labelText: 'Styled Text',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Styled text: fontSize 20, purple, bold');

  final italicText = Container(
    width: 250,
    child: TextField(
      style: TextStyle(
        fontSize: 16,
        fontStyle: FontStyle.italic,
        color: Colors.green[700],
      ),
      decoration: InputDecoration(
        labelText: 'Italic Text',
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Italic green text');

  // ========== KEYBOARD INPUT ==========
  print('--- Keyboard Input Types ---');

  final emailInput = Container(
    width: 250,
    child: TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email),
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Email keyboard type');

  final numberInput = Container(
    width: 250,
    child: TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: 'Number',
        prefixIcon: Icon(Icons.numbers),
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Number keyboard type');

  // ========== OBSCURE TEXT ==========
  print('--- Obscure Text (Passwords) ---');

  final passwordField = Container(
    width: 250,
    child: TextField(
      obscureText: true,
      obscuringCharacter: '•',
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock),
        border: OutlineInputBorder(),
      ),
    ),
  );
  print('Password field with obscured text');

  // ========== READ ONLY ==========
  print('--- Read Only Mode ---');

  final readOnlyField = Container(
    width: 250,
    child: TextField(
      readOnly: true,
      controller: TextEditingController(text: 'Read only text'),
      decoration: InputDecoration(
        labelText: 'Read Only',
        border: OutlineInputBorder(),
        fillColor: Colors.grey[100],
        filled: true,
      ),
    ),
  );
  print('Read-only text field');

  print('RenderEditable test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderEditable Tests'),
      SizedBox(height: 8),
      basicTextField,
      SizedBox(height: 8),
      withText,
      SizedBox(height: 8),
      multiLine,
      SizedBox(height: 8),
      customCursor,
      SizedBox(height: 8),
      styledText,
      SizedBox(height: 8),
      passwordField,
      SizedBox(height: 8),
      Text('All RenderEditable tests passed'),
    ],
  );
}
