// D4rt test script: Tests ColorScheme, MaterialColor, MaterialAccentColor,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// ThemeDataTween, theme concepts
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Color scheme test executing');

  // ========== ColorScheme ==========
  print('--- ColorScheme Tests ---');
  final lightScheme = ColorScheme.light(
    primary: Colors.blue,
    onPrimary: Colors.white,
    secondary: Colors.green,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
  );
  print('ColorScheme.light created');
  print('  primary: ${lightScheme.primary}');
  print('  secondary: ${lightScheme.secondary}');
  print('  brightness: ${lightScheme.brightness}');

  final darkScheme = ColorScheme.dark(
    primary: Colors.blue.shade200,
    secondary: Colors.green.shade200,
  );
  print('ColorScheme.dark created');
  print('  brightness: ${darkScheme.brightness}');

  // fromSeed
  final seedScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
  print('ColorScheme.fromSeed(deepPurple)');
  print('  primary: ${seedScheme.primary}');
  print('  primaryContainer: ${seedScheme.primaryContainer}');

  // copyWith
  final modified = lightScheme.copyWith(primary: Colors.orange);
  print('copyWith primary: ${modified.primary}');

  // ========== MaterialColor ==========
  print('--- MaterialColor Tests ---');
  final matColor = MaterialColor(0xFF4CAF50, {
    50: Color(0xFFE8F5E9),
    100: Color(0xFFC8E6C9),
    200: Color(0xFFA5D6A7),
    300: Color(0xFF81C784),
    400: Color(0xFF66BB6A),
    500: Color(0xFF4CAF50),
    600: Color(0xFF43A047),
    700: Color(0xFF388E3C),
    800: Color(0xFF2E7D32),
    900: Color(0xFF1B5E20),
  });
  print('MaterialColor created');
  print('  shade50: ${matColor.shade50}');
  print('  shade500: ${matColor.shade500}');
  print('  shade900: ${matColor.shade900}');

  // Built-in material colors
  print('Colors.blue.shade100: ${Colors.blue.shade100}');
  print('Colors.red.shade400: ${Colors.red.shade400}');
  print('Colors.green.shade700: ${Colors.green.shade700}');

  // ========== MaterialAccentColor ==========
  print('--- MaterialAccentColor Tests ---');
  final accentColor = MaterialAccentColor(0xFF448AFF, {
    100: Color(0xFF82B1FF),
    200: Color(0xFF448AFF),
    400: Color(0xFF2979FF),
    700: Color(0xFF2962FF),
  });
  print('MaterialAccentColor created');
  print('  shade100: ${accentColor.shade100}');
  print('  shade200: ${accentColor.shade200}');
  print('  shade700: ${accentColor.shade700}');

  // Built-in accent colors
  print('Colors.blueAccent: ${Colors.blueAccent}');
  print('Colors.redAccent: ${Colors.redAccent}');

  print('All color scheme tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    theme: ThemeData(colorScheme: seedScheme),
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Color Scheme Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final shade in [100, 300, 500, 700, 900])
                  Container(width: 40, height: 40, color: Colors.blue[shade]),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
