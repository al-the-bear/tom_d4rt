// D4rt test script: Tests HSLColor, HSVColor, ColorSwatch
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ColorsTest test executing');

  // HSLColor
  final hslColor = HSLColor.fromAHSL(1.0, 210.0, 0.8, 0.5);
  print('HSLColor alpha: ${hslColor.alpha}');
  print('HSLColor hue: ${hslColor.hue}');
  print('HSLColor saturation: ${hslColor.saturation}');
  print('HSLColor lightness: ${hslColor.lightness}');

  final hslToColor = hslColor.toColor();
  print('HSLColor.toColor(): $hslToColor');

  // HSLColor with different values
  final hslRed = HSLColor.fromAHSL(1.0, 0.0, 1.0, 0.5);
  final hslRedColor = hslRed.toColor();
  print('HSLColor red hue=0: $hslRedColor');

  // HSLColor withLightness
  final hslLight = hslColor.withLightness(0.8);
  print('HSLColor withLightness(0.8): ${hslLight.toColor()}');

  // HSVColor
  final hsvColor = HSVColor.fromAHSV(1.0, 120.0, 0.9, 0.8);
  print('HSVColor alpha: ${hsvColor.alpha}');
  print('HSVColor hue: ${hsvColor.hue}');
  print('HSVColor saturation: ${hsvColor.saturation}');
  print('HSVColor value: ${hsvColor.value}');

  final hsvToColor = hsvColor.toColor();
  print('HSVColor.toColor(): $hsvToColor');

  // HSVColor with different values
  final hsvBlue = HSVColor.fromAHSV(1.0, 240.0, 0.7, 0.9);
  final hsvBlueColor = hsvBlue.toColor();
  print('HSVColor blue hue=240: $hsvBlueColor');

  // HSVColor withValue
  final hsvDark = hsvColor.withValue(0.3);
  print('HSVColor withValue(0.3): ${hsvDark.toColor()}');

  // ColorSwatch
  final swatch = ColorSwatch<int>(0xFF4CAF50, {
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
  print('ColorSwatch value: $swatch');
  print('ColorSwatch[50]: ${swatch[50]}');
  print('ColorSwatch[500]: ${swatch[500]}');
  print('ColorSwatch[900]: ${swatch[900]}');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 200.0,
        height: 40.0,
        color: hslToColor,
        child: Center(
          child: Text(
            'HSLColor (h:210, s:0.8, l:0.5)',
            style: TextStyle(color: Colors.white, fontSize: 11.0),
          ),
        ),
      ),
      SizedBox(height: 4.0),
      Container(
        width: 200.0,
        height: 40.0,
        color: hslLight.toColor(),
        child: Center(
          child: Text(
            'HSLColor lightness=0.8',
            style: TextStyle(fontSize: 11.0),
          ),
        ),
      ),
      SizedBox(height: 4.0),
      Container(
        width: 200.0,
        height: 40.0,
        color: hsvToColor,
        child: Center(
          child: Text(
            'HSVColor (h:120, s:0.9, v:0.8)',
            style: TextStyle(color: Colors.white, fontSize: 11.0),
          ),
        ),
      ),
      SizedBox(height: 4.0),
      Container(
        width: 200.0,
        height: 40.0,
        color: hsvDark.toColor(),
        child: Center(
          child: Text(
            'HSVColor value=0.3',
            style: TextStyle(color: Colors.white, fontSize: 11.0),
          ),
        ),
      ),
      SizedBox(height: 8.0),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 30.0, height: 30.0, color: swatch[50]),
          Container(width: 30.0, height: 30.0, color: swatch[200]),
          Container(width: 30.0, height: 30.0, color: swatch[400]),
          Container(width: 30.0, height: 30.0, color: swatch[600]),
          Container(width: 30.0, height: 30.0, color: swatch[900]),
        ],
      ),
      SizedBox(height: 4.0),
      Text('ColorSwatch samples', style: TextStyle(fontSize: 11.0)),
    ],
  );
}
