// D4rt test script: Tests InputDecorationTheme, TextSelectionThemeData,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// TextSelectionControls, TextField advanced, TextEditingController advanced,
// MaxLengthEnforcement, SmartDashesType, SmartQuotesType
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('Text field theme test executing');

  // ========== InputDecorationTheme ==========
  print('--- InputDecorationTheme Tests ---');
  final inputTheme = InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.blue),
    floatingLabelStyle: TextStyle(color: Colors.blue[700]),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    floatingLabelAlignment: FloatingLabelAlignment.start,
    helperStyle: TextStyle(color: Colors.grey),
    helperMaxLines: 1,
    hintStyle: TextStyle(color: Colors.grey),
    hintFadeDuration: Duration(milliseconds: 200),
    errorStyle: TextStyle(color: Colors.red),
    errorMaxLines: 2,
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    isDense: false,
    isCollapsed: false,
    iconColor: Colors.grey,
    prefixIconColor: Colors.grey,
    prefixStyle: TextStyle(color: Colors.black),
    suffixIconColor: Colors.grey,
    suffixStyle: TextStyle(color: Colors.black),
    counterStyle: TextStyle(fontSize: 12),
    filled: true,
    fillColor: Colors.grey[100],
    focusColor: Colors.blue[50],
    hoverColor: Colors.blue[25],
    activeIndicatorBorder: BorderSide(color: Colors.blue, width: 2),
    outlineBorder: BorderSide(color: Colors.grey),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey[300]!),
      borderRadius: BorderRadius.circular(8),
    ),
    alignLabelWithHint: false,
    constraints: BoxConstraints(maxWidth: 400),
  );
  print('InputDecorationTheme created');

  // ========== TextSelectionThemeData ==========
  print('--- TextSelectionThemeData Tests ---');
  final selectionTheme = TextSelectionThemeData(
    cursorColor: Colors.blue,
    selectionColor: Colors.blue[200],
    selectionHandleColor: Colors.blue[700],
  );
  print('TextSelectionThemeData created');
  print('  cursorColor: ${selectionTheme.cursorColor}');
  print('  selectionColor: ${selectionTheme.selectionColor}');
  print('  selectionHandleColor: ${selectionTheme.selectionHandleColor}');

  // ========== TextEditingController advanced ==========
  print('--- TextEditingController Advanced Tests ---');
  final controller = TextEditingController(text: 'Hello World');
  print('TextEditingController created: text=${controller.text}');
  print('  value: ${controller.value}');

  controller.selection = TextSelection(baseOffset: 0, extentOffset: 5);
  print('  selection: ${controller.selection}');

  final selectedText = controller.selection.textInside(controller.text);
  print('  selectedText: $selectedText');

  controller.text = 'New Text';
  print('  Updated text: ${controller.text}');

  controller.clear();
  print('  After clear: "${controller.text}"');

  // ========== TextField advanced ==========
  print('--- TextField Advanced Tests ---');
  final textField = TextField(
    controller: TextEditingController(text: 'Test'),
    decoration: InputDecoration(
      labelText: 'Advanced Field',
      border: OutlineInputBorder(),
    ),
    keyboardType: TextInputType.text,
    textInputAction: TextInputAction.done,
    textCapitalization: TextCapitalization.sentences,
    style: TextStyle(fontSize: 16),
    strutStyle: StrutStyle(fontSize: 16, height: 1.5),
    textAlign: TextAlign.start,
    textAlignVertical: TextAlignVertical.center,
    textDirection: TextDirection.ltr,
    readOnly: false,
    showCursor: true,
    autofocus: false,
    obscureText: false,
    obscuringCharacter: '•',
    autocorrect: true,
    smartDashesType: SmartDashesType.enabled,
    smartQuotesType: SmartQuotesType.enabled,
    enableSuggestions: true,
    maxLines: 1,
    minLines: 1,
    expands: false,
    maxLength: 100,
    maxLengthEnforcement: MaxLengthEnforcement.enforced,
    onChanged: (value) => print('  Changed: $value'),
    onEditingComplete: () => print('  Editing complete'),
    onSubmitted: (value) => print('  Submitted: $value'),
    onTap: () => print('  Tapped'),
    onTapOutside: (event) => print('  Tapped outside'),
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9 ]')),
      LengthLimitingTextInputFormatter(100),
    ],
    enabled: true,
    cursorWidth: 2.0,
    cursorHeight: 20.0,
    cursorRadius: Radius.circular(2),
    cursorColor: Colors.blue,
    cursorOpacityAnimates: true,
    selectionHeightStyle: BoxHeightStyle.tight,
    selectionWidthStyle: BoxWidthStyle.tight,
    scrollPadding: EdgeInsets.all(20),
    enableInteractiveSelection: true,
    clipBehavior: Clip.hardEdge,
    enableIMEPersonalizedLearning: true,
    scribbleEnabled: true,
  );
  print('TextField advanced created');

  // ========== MaxLengthEnforcement ==========
  print('--- MaxLengthEnforcement Tests ---');
  for (final enforcement in MaxLengthEnforcement.values) {
    print('  MaxLengthEnforcement.$enforcement');
  }

  // ========== SmartDashesType ==========
  print('--- SmartDashesType Tests ---');
  for (final t in SmartDashesType.values) {
    print('  SmartDashesType.$t');
  }

  // ========== SmartQuotesType ==========
  print('--- SmartQuotesType Tests ---');
  for (final t in SmartQuotesType.values) {
    print('  SmartQuotesType.$t');
  }

  // ========== TextInputType ==========
  print('--- TextInputType Tests ---');
  final types = [
    TextInputType.text,
    TextInputType.multiline,
    TextInputType.number,
    TextInputType.phone,
    TextInputType.datetime,
    TextInputType.emailAddress,
    TextInputType.url,
    TextInputType.visiblePassword,
    TextInputType.name,
    TextInputType.streetAddress,
    TextInputType.none,
  ];
  for (final t in types) {
    print('  TextInputType: $t');
  }

  print('All text field theme tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    theme: ThemeData(
      inputDecorationTheme: inputTheme,
      textSelectionTheme: selectionTheme,
    ),
    home: Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [textField]),
      ),
    ),
  );
}
