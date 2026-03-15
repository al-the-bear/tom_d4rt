// D4rt test script: Tests Form, FormField, TextFormField, FormState,
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// InputDecoration advanced, InputBorder types, OutlineInputBorder, UnderlineInputBorder
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Form field test executing');

  final formKey = GlobalKey<FormState>();

  // ========== Form ==========
  print('--- Form Tests ---');
  print('FormState key created');

  // ========== TextFormField advanced ==========
  print('--- TextFormField Advanced Tests ---');

  // ========== InputDecoration advanced ==========
  print('--- InputDecoration Advanced Tests ---');
  final decoration1 = InputDecoration(
    labelText: 'Username',
    labelStyle: TextStyle(color: Colors.blue),
    floatingLabelStyle: TextStyle(color: Colors.blue[700]),
    floatingLabelBehavior: FloatingLabelBehavior.auto,
    floatingLabelAlignment: FloatingLabelAlignment.start,
    hintText: 'Enter username',
    hintStyle: TextStyle(color: Colors.grey),
    hintMaxLines: 1,
    helperText: 'Must be unique',
    helperStyle: TextStyle(color: Colors.grey[600]),
    helperMaxLines: 1,
    errorText: null,
    errorStyle: TextStyle(color: Colors.red),
    errorMaxLines: 2,
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 2),
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
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    prefixIcon: Icon(Icons.person),
    prefixIconConstraints: BoxConstraints(minWidth: 40, minHeight: 40),
    suffixIcon: Icon(Icons.clear),
    suffixIconConstraints: BoxConstraints(minWidth: 40, minHeight: 40),
    prefix: Text('@'),
    suffix: Text('.com'),
    counterText: '0/20',
    counterStyle: TextStyle(fontSize: 12),
    filled: true,
    fillColor: Colors.grey[100],
    focusColor: Colors.blue[50],
    hoverColor: Colors.blue[25],
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    isDense: false,
    isCollapsed: false,
    alignLabelWithHint: false,
    constraints: BoxConstraints(maxWidth: 400),
  );
  print('InputDecoration advanced created');
  print('  floatingLabelBehavior: ${decoration1.floatingLabelBehavior}');

  // ========== InputDecoration.collapsed ==========
  print('--- InputDecoration.collapsed Tests ---');
  final decorationCollapsed = InputDecoration.collapsed(
    hintText: 'Collapsed hint',
    hintStyle: TextStyle(color: Colors.grey),
    filled: true,
    fillColor: Colors.white,
    border: InputBorder.none,
  );
  print('InputDecoration.collapsed created');

  // ========== OutlineInputBorder ==========
  print('--- OutlineInputBorder Tests ---');
  final outlineBorder = OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2),
    borderRadius: BorderRadius.circular(12),
    gapPadding: 4.0,
  );
  print('OutlineInputBorder created');
  print('  borderRadius: ${outlineBorder.borderRadius}');
  print('  gapPadding: ${outlineBorder.gapPadding}');
  print('  isOutline: ${outlineBorder.isOutline}');

  // ========== UnderlineInputBorder ==========
  print('--- UnderlineInputBorder Tests ---');
  final underlineBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.green, width: 2),
    borderRadius: BorderRadius.circular(4),
  );
  print('UnderlineInputBorder created');
  print('  isOutline: ${underlineBorder.isOutline}');

  // ========== FloatingLabelBehavior ==========
  print('--- FloatingLabelBehavior Tests ---');
  for (final behavior in FloatingLabelBehavior.values) {
    print('  FloatingLabelBehavior.$behavior');
  }

  // ========== FloatingLabelAlignment ==========
  print('--- FloatingLabelAlignment Tests ---');
  print('  start: ${FloatingLabelAlignment.start}');
  print('  center: ${FloatingLabelAlignment.center}');

  // ========== Form + FormField widget ==========
  print('--- Form Widget Tests ---');
  final form = Form(
    key: formKey,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    onWillPop: () async => true,
    onChanged: () => print('  Form changed'),
    child: Column(
      children: [
        TextFormField(
          decoration: decoration1,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Required';
            if (value.length < 3) return 'Too short';
            return null;
          },
          onSaved: (value) => print('  Saved: $value'),
          onFieldSubmitted: (value) => print('  Submitted: $value'),
          onChanged: (value) => print('  Changed: $value'),
          initialValue: '',
          autovalidateMode: AutovalidateMode.disabled,
          maxLength: 20,
          maxLines: 1,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.none,
          obscureText: false,
          enableSuggestions: true,
          autocorrect: true,
          readOnly: false,
          enabled: true,
        ),
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Email',
            border: underlineBorder,
            prefixIcon: Icon(Icons.email),
          ),
          keyboardType: TextInputType.emailAddress,
          validator: (value) {
            if (value != null && !value.contains('@')) return 'Invalid email';
            return null;
          },
        ),
      ],
    ),
  );
  print('Form with TextFormField created');

  // ========== AutovalidateMode ==========
  print('--- AutovalidateMode Tests ---');
  for (final mode in AutovalidateMode.values) {
    print('  AutovalidateMode.$mode');
  }

  print('All form field tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(padding: EdgeInsets.all(16), child: form),
    ),
  );
}
