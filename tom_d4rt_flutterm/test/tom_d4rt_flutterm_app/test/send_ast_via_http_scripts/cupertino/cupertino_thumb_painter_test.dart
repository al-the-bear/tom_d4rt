// D4rt test script: Tests CupertinoThumbPainter from cupertino
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoThumbPainter test executing');

  // ===== 1. Default constructor =====
  print('--- Default CupertinoThumbPainter ---');
  final defaultPainter = CupertinoThumbPainter();
  print('  default painter created: ${defaultPainter.runtimeType}');

  // ===== 2. With custom color =====
  print('--- Custom color ---');
  final bluePainter = CupertinoThumbPainter(color: CupertinoColors.activeBlue);
  print('  blue painter created');

  final redPainter = CupertinoThumbPainter(color: CupertinoColors.systemRed);
  print('  red painter created');

  final grayPainter = CupertinoThumbPainter(color: CupertinoColors.systemGrey);
  print('  gray painter created');

  // ===== 3. With custom shadows =====
  print('--- Custom shadows ---');
  final customShadows = CupertinoThumbPainter(
    shadows: [
      BoxShadow(
        color: Color(0x33000000),
        blurRadius: 4.0,
        offset: Offset(0.0, 2.0),
      ),
    ],
  );
  print('  custom shadows painter created');

  final noShadows = CupertinoThumbPainter(shadows: []);
  print('  no-shadow painter created');

  final heavyShadows = CupertinoThumbPainter(
    shadows: [
      BoxShadow(
        color: Color(0x66000000),
        blurRadius: 8.0,
        offset: Offset(0.0, 4.0),
      ),
      BoxShadow(
        color: Color(0x1A000000),
        blurRadius: 16.0,
        offset: Offset(0.0, 8.0),
      ),
    ],
  );
  print('  heavy shadows painter created (2 shadows)');

  // ===== 4. switchThumb named constructor =====
  print('--- CupertinoThumbPainter.switchThumb ---');
  final switchDefault = CupertinoThumbPainter.switchThumb();
  print('  switch thumb default: ${switchDefault.runtimeType}');

  final switchColored = CupertinoThumbPainter.switchThumb(
    color: CupertinoColors.systemGreen,
  );
  print('  switch thumb green created');

  final switchCustom = CupertinoThumbPainter.switchThumb(
    color: CupertinoColors.white,
    shadows: [
      BoxShadow(
        color: Color(0x40000000),
        blurRadius: 6.0,
        offset: Offset(0.0, 3.0),
      ),
    ],
  );
  print('  switch thumb custom created');

  // ===== 5. Static properties =====
  print('--- Static properties ---');
  print('  radius: ${CupertinoThumbPainter.radius}');
  print('  extension: ${CupertinoThumbPainter.extension}');

  // ===== 6. Color + shadows combined =====
  print('--- Combined customization ---');
  final combined = CupertinoThumbPainter(
    color: Color(0xFFE8E8E8),
    shadows: [
      BoxShadow(
        color: Color(0x22000000),
        blurRadius: 3.0,
        offset: Offset(0.0, 1.0),
      ),
    ],
  );
  print('  combined painter created');

  // ===== 7. Visual demo with CupertinoSwitch and CupertinoSlider =====
  print('--- Usage context ---');
  final switchWidget = CupertinoSwitch(value: true, onChanged: (v) {});
  print('  CupertinoSwitch uses thumb painter internally');

  final slider = CupertinoSlider(value: 0.5, onChanged: (v) {});
  print('  CupertinoSlider uses thumb painter internally');

  print('CupertinoThumbPainter test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('ThumbPainter Test')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'CupertinoThumbPainter',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12.0),
              Text('Static radius: ${CupertinoThumbPainter.radius}'),
              Text('Static extension: ${CupertinoThumbPainter.extension}'),
              SizedBox(height: 16.0),
              Text(
                'CupertinoSwitch (uses thumb):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              switchWidget,
              SizedBox(height: 12.0),
              CupertinoSwitch(value: false, onChanged: (v) {}),
              SizedBox(height: 16.0),
              Text(
                'CupertinoSlider (uses thumb):',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              slider,
              SizedBox(height: 8.0),
              CupertinoSlider(value: 0.0, onChanged: (v) {}),
              SizedBox(height: 8.0),
              CupertinoSlider(value: 1.0, onChanged: (v) {}),
            ],
          ),
        ),
      ),
    ),
  );
}
