// D4rt test script: Tests ShaderMask, BackdropFilter, ImageFiltered,
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
// ColorFiltered (as widgets), OrientationBuilder, CheckedModeBanner
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Shader/filter widgets test executing');

  // ========== ShaderMask ==========
  print('--- ShaderMask Tests ---');

  final shaderMask = ShaderMask(
    shaderCallback: (Rect bounds) {
      return LinearGradient(
        colors: [Colors.black, Colors.transparent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(bounds);
    },
    blendMode: BlendMode.dstIn,
    child: Container(width: 100.0, height: 100.0, color: Colors.blue),
  );
  print('ShaderMask created with blendMode: ${shaderMask.blendMode}');

  // ========== BackdropFilter ==========
  print('--- BackdropFilter Tests ---');

  final backdropFilter = BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
    blendMode: BlendMode.srcOver,
    child: Container(
      width: 100.0,
      height: 100.0,
      color: Colors.white.withAlpha(128),
    ),
  );
  print('BackdropFilter created with blendMode: ${backdropFilter.blendMode}');

  // ========== ImageFiltered ==========
  print('--- ImageFiltered Tests ---');

  final imageFiltered = ImageFiltered(
    imageFilter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
    child: Container(width: 80.0, height: 80.0, color: Colors.green),
  );
  print('ImageFiltered created');

  // ========== ColorFiltered ==========
  print('--- ColorFiltered Tests ---');

  final colorFiltered = ColorFiltered(
    colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
    child: Container(width: 80.0, height: 80.0, color: Colors.blue),
  );
  print('ColorFiltered created');

  final colorFilteredMatrix = ColorFiltered(
    colorFilter: ColorFilter.matrix([
      0.2126,
      0.7152,
      0.0722,
      0.0,
      0.0,
      0.2126,
      0.7152,
      0.0722,
      0.0,
      0.0,
      0.2126,
      0.7152,
      0.0722,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      1.0,
      0.0,
    ]),
    child: Text('Grayscale'),
  );
  print('ColorFiltered with matrix created');

  // ========== CheckedModeBanner ==========
  print('--- CheckedModeBanner Tests ---');

  final banner = CheckedModeBanner(child: Text('Banner child'));
  print('CheckedModeBanner created');

  print('All shader/filter widget tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shader/Filter Widget Tests',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            shaderMask,
            SizedBox(height: 8.0),
            ClipRect(
              child: Stack(
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    color: Colors.blue,
                    child: Text('Behind'),
                  ),
                  backdropFilter,
                ],
              ),
            ),
            SizedBox(height: 8.0),
            imageFiltered,
            SizedBox(height: 8.0),
            colorFiltered,
            SizedBox(height: 8.0),
            colorFilteredMatrix,
          ],
        ),
      ),
    ),
  );
}
