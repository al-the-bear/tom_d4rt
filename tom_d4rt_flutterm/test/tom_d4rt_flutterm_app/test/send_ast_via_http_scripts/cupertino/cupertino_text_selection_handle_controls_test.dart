// D4rt test script: Tests CupertinoTextSelectionHandleControls from cupertino
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// NOTE: CupertinoTextSelectionHandleControls is NOT bridged in d4rt.
// This test demonstrates the class through its superclass behavior and
// CupertinoTextField integration where it is used internally.
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoTextSelectionHandleControls test executing');

  // ===== 1. Create instance (handle-only controls, no toolbar) =====
  print('--- CupertinoTextSelectionHandleControls ---');
  final handleControls = CupertinoTextSelectionHandleControls();
  print('  created: ${handleControls.runtimeType}');

  // ===== 2. getHandleSize =====
  print('--- getHandleSize ---');
  final sizes = [12.0, 16.0, 20.0, 24.0, 32.0];
  for (final fs in sizes) {
    final size = handleControls.getHandleSize(fs);
    print('  fontSize $fs -> ${size.width}x${size.height}');
  }

  // ===== 3. getHandleAnchor for each type =====
  print('--- getHandleAnchor ---');
  final types = [
    TextSelectionHandleType.left,
    TextSelectionHandleType.right,
    TextSelectionHandleType.collapsed,
  ];
  for (final type in types) {
    final anchor = handleControls.getHandleAnchor(type, 16.0);
    print('  $type -> dx:${anchor.dx}, dy:${anchor.dy}');
  }

  // ===== 4. Compare with CupertinoTextSelectionControls =====
  print('--- Comparison with full controls ---');
  final fullControls = CupertinoTextSelectionControls();
  final handleSize16 = handleControls.getHandleSize(16.0);
  final fullSize16 = fullControls.getHandleSize(16.0);
  print('  handleControls size@16: $handleSize16');
  print('  fullControls size@16: $fullSize16');
  print('  sizes match: ${handleSize16 == fullSize16}');

  final handleAnchorLeft = handleControls.getHandleAnchor(TextSelectionHandleType.left, 16.0);
  final fullAnchorLeft = fullControls.getHandleAnchor(TextSelectionHandleType.left, 16.0);
  print('  handleControls anchor left: $handleAnchorLeft');
  print('  fullControls anchor left: $fullAnchorLeft');

  // ===== 5. CupertinoTextField uses handle controls internally =====
  print('--- TextField integration ---');
  final textField = CupertinoTextField(
    placeholder: 'Select text to see handles',
    controller: TextEditingController(text: 'Sample text for selection'),
  );
  print('  text field created');

  // ===== 6. Multiple selection-enabled fields =====
  print('--- Multiple selectable fields ---');
  final editableFields = <Widget>[];
  final labels = ['Name', 'Email', 'Phone', 'Address'];
  for (final label in labels) {
    editableFields.add(Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: CupertinoTextField(
        placeholder: label,
        prefix: Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text('$label:'),
        ),
      ),
    ));
  }
  print('  ${editableFields.length} editable fields created');

  // ===== 7. Handle size scaling verification =====
  print('--- Handle size at extreme font sizes ---');
  final extremeSizes = [8.0, 72.0, 96.0];
  for (final fs in extremeSizes) {
    final size = handleControls.getHandleSize(fs);
    print('  fontSize $fs -> ${size.width}x${size.height}');
  }

  print('CupertinoTextSelectionHandleControls test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('HandleControls')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Handle Controls Test', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              Text('Type: ${handleControls.runtimeType}'),
              SizedBox(height: 8.0),
              Text('Handle sizes:'),
              for (final fs in sizes)
                Text('  ${fs}px: ${handleControls.getHandleSize(fs)}'),
              SizedBox(height: 16.0),
              Text('Select text in fields:', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8.0),
              textField,
              SizedBox(height: 12.0),
              ...editableFields,
            ],
          ),
        ),
      ),
    ),
  );
}
