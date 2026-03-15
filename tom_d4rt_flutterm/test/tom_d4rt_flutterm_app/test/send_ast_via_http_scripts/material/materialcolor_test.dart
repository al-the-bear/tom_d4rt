// D4rt test script: Tests MaterialColor, MaterialAccentColor from material
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialColor test executing');

  // ========== MATERIALCOLOR ==========
  print('--- MaterialColor Tests ---');

  // Test predefined MaterialColors
  final primaryBlue = Colors.blue;
  print('Colors.blue: primary=${primaryBlue.value}');

  // Test MaterialColor shade access
  print('Blue shades:');
  print('  shade50: ${Colors.blue.shade50}');
  print('  shade100: ${Colors.blue.shade100}');
  print('  shade200: ${Colors.blue.shade200}');
  print('  shade300: ${Colors.blue.shade300}');
  print('  shade400: ${Colors.blue.shade400}');
  print('  shade500: ${Colors.blue.shade500}');
  print('  shade600: ${Colors.blue.shade600}');
  print('  shade700: ${Colors.blue.shade700}');
  print('  shade800: ${Colors.blue.shade800}');
  print('  shade900: ${Colors.blue.shade900}');

  // Test custom MaterialColor
  final customMaterial = MaterialColor(0xFF4CAF50, <int, Color>{
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
  print('Custom MaterialColor created');
  print('Custom shade500: ${customMaterial.shade500}');
  print('Custom shade100: ${customMaterial.shade100}');
  print('Custom shade900: ${customMaterial.shade900}');

  // Test all predefined MaterialColors
  final redColor = Colors.red;
  final pinkColor = Colors.pink;
  final purpleColor = Colors.purple;
  final deepPurpleColor = Colors.deepPurple;
  final indigoColor = Colors.indigo;
  final blueColor = Colors.blue;
  final lightBlueColor = Colors.lightBlue;
  final cyanColor = Colors.cyan;
  final tealColor = Colors.teal;
  final greenColor = Colors.green;
  final lightGreenColor = Colors.lightGreen;
  final limeColor = Colors.lime;
  final yellowColor = Colors.yellow;
  final amberColor = Colors.amber;
  final orangeColor = Colors.orange;
  final deepOrangeColor = Colors.deepOrange;
  final brownColor = Colors.brown;
  final greyColor = Colors.grey;
  final blueGreyColor = Colors.blueGrey;
  print('All predefined MaterialColors accessed');

  // ========== MATERIALACCENTCOLOR ==========
  print('--- MaterialAccentColor Tests ---');

  // Test predefined MaterialAccentColors
  final accentBlue = Colors.blueAccent;
  print('Colors.blueAccent: ${accentBlue.value}');

  // Test MaterialAccentColor shade access
  print('Blue accent shades:');
  print('  shade100: ${Colors.blueAccent.shade100}');
  print('  shade200: ${Colors.blueAccent.shade200}');
  print('  shade400: ${Colors.blueAccent.shade400}');
  print('  shade700: ${Colors.blueAccent.shade700}');

  // Test custom MaterialAccentColor
  final customAccent = MaterialAccentColor(0xFF448AFF, <int, Color>{
    100: Color(0xFF82B1FF),
    200: Color(0xFF448AFF),
    400: Color(0xFF2979FF),
    700: Color(0xFF2962FF),
  });
  print('Custom MaterialAccentColor created');
  print('Custom accent shade200: ${customAccent.shade200}');
  print('Custom accent shade400: ${customAccent.shade400}');
  print('Custom accent shade700: ${customAccent.shade700}');

  // Test all predefined MaterialAccentColors
  final redAccent = Colors.redAccent;
  final pinkAccent = Colors.pinkAccent;
  final purpleAccent = Colors.purpleAccent;
  final deepPurpleAccent = Colors.deepPurpleAccent;
  final indigoAccent = Colors.indigoAccent;
  final lightBlueAccent = Colors.lightBlueAccent;
  final cyanAccent = Colors.cyanAccent;
  final tealAccent = Colors.tealAccent;
  final greenAccent = Colors.greenAccent;
  final lightGreenAccent = Colors.lightGreenAccent;
  final limeAccent = Colors.limeAccent;
  final yellowAccent = Colors.yellowAccent;
  final amberAccent = Colors.amberAccent;
  final orangeAccent = Colors.orangeAccent;
  final deepOrangeAccent = Colors.deepOrangeAccent;
  print('All predefined MaterialAccentColors accessed');

  // Test color usage in widgets
  print('--- Color Usage in Widgets ---');

  print('MaterialColor test completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'MaterialColor Test',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),

        Text(
          'MaterialColor Shades (Blue):',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            Container(
              width: 50,
              height: 50,
              color: Colors.blue.shade50,
              child: Center(child: Text('50')),
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.blue.shade100,
              child: Center(child: Text('100')),
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.blue.shade200,
              child: Center(child: Text('200')),
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.blue.shade300,
              child: Center(child: Text('300')),
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.blue.shade400,
              child: Center(
                child: Text('400', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.blue.shade500,
              child: Center(
                child: Text('500', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.blue.shade600,
              child: Center(
                child: Text('600', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.blue.shade700,
              child: Center(
                child: Text('700', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.blue.shade800,
              child: Center(
                child: Text('800', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              color: Colors.blue.shade900,
              child: Center(
                child: Text('900', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),

        SizedBox(height: 24.0),
        Text(
          'MaterialAccentColor Shades:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            Container(
              width: 60,
              height: 50,
              color: Colors.blueAccent.shade100,
              child: Center(child: Text('100')),
            ),
            Container(
              width: 60,
              height: 50,
              color: Colors.blueAccent.shade200,
              child: Center(
                child: Text('200', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: 60,
              height: 50,
              color: Colors.blueAccent.shade400,
              child: Center(
                child: Text('400', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: 60,
              height: 50,
              color: Colors.blueAccent.shade700,
              child: Center(
                child: Text('700', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),

        SizedBox(height: 24.0),
        Text(
          'Custom MaterialColor:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            Container(
              width: 50,
              height: 50,
              color: customMaterial.shade50,
              child: Center(child: Text('50')),
            ),
            Container(
              width: 50,
              height: 50,
              color: customMaterial.shade200,
              child: Center(child: Text('200')),
            ),
            Container(
              width: 50,
              height: 50,
              color: customMaterial.shade500,
              child: Center(
                child: Text('500', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              color: customMaterial.shade700,
              child: Center(
                child: Text('700', style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              width: 50,
              height: 50,
              color: customMaterial.shade900,
              child: Center(
                child: Text('900', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),

        SizedBox(height: 24.0),
        Text(
          'All MaterialColors:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            Container(width: 40, height: 40, color: Colors.red),
            Container(width: 40, height: 40, color: Colors.pink),
            Container(width: 40, height: 40, color: Colors.purple),
            Container(width: 40, height: 40, color: Colors.deepPurple),
            Container(width: 40, height: 40, color: Colors.indigo),
            Container(width: 40, height: 40, color: Colors.blue),
            Container(width: 40, height: 40, color: Colors.lightBlue),
            Container(width: 40, height: 40, color: Colors.cyan),
            Container(width: 40, height: 40, color: Colors.teal),
            Container(width: 40, height: 40, color: Colors.green),
            Container(width: 40, height: 40, color: Colors.lightGreen),
            Container(width: 40, height: 40, color: Colors.lime),
            Container(width: 40, height: 40, color: Colors.yellow),
            Container(width: 40, height: 40, color: Colors.amber),
            Container(width: 40, height: 40, color: Colors.orange),
            Container(width: 40, height: 40, color: Colors.deepOrange),
            Container(width: 40, height: 40, color: Colors.brown),
            Container(width: 40, height: 40, color: Colors.grey),
            Container(width: 40, height: 40, color: Colors.blueGrey),
          ],
        ),

        SizedBox(height: 24.0),
        Text(
          'All MaterialAccentColors:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            Container(width: 40, height: 40, color: Colors.redAccent),
            Container(width: 40, height: 40, color: Colors.pinkAccent),
            Container(width: 40, height: 40, color: Colors.purpleAccent),
            Container(width: 40, height: 40, color: Colors.deepPurpleAccent),
            Container(width: 40, height: 40, color: Colors.indigoAccent),
            Container(width: 40, height: 40, color: Colors.blueAccent),
            Container(width: 40, height: 40, color: Colors.lightBlueAccent),
            Container(width: 40, height: 40, color: Colors.cyanAccent),
            Container(width: 40, height: 40, color: Colors.tealAccent),
            Container(width: 40, height: 40, color: Colors.greenAccent),
            Container(width: 40, height: 40, color: Colors.lightGreenAccent),
            Container(width: 40, height: 40, color: Colors.limeAccent),
            Container(width: 40, height: 40, color: Colors.yellowAccent),
            Container(width: 40, height: 40, color: Colors.amberAccent),
            Container(width: 40, height: 40, color: Colors.orangeAccent),
            Container(width: 40, height: 40, color: Colors.deepOrangeAccent),
          ],
        ),
      ],
    ),
  );
}
