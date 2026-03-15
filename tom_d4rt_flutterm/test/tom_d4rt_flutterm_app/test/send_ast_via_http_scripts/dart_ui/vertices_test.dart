// D4rt test script: Tests Vertices from dart:ui
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('dart:ui vertices test executing');

  // ========== VERTICES ==========
  print('--- Vertices Tests ---');

  // Basic triangle
  final triangle = Vertices(VertexMode.triangles, [
    Offset(0.0, 0.0),
    Offset(100.0, 0.0),
    Offset(50.0, 100.0),
  ]);
  print('Vertices triangle created');
  print('  runtimeType: ${triangle.runtimeType}');

  // Triangle with colors
  final coloredTriangle = Vertices(
    VertexMode.triangles,
    [Offset(0.0, 0.0), Offset(200.0, 0.0), Offset(100.0, 200.0)],
    colors: [Color(0xFFFF0000), Color(0xFF00FF00), Color(0xFF0000FF)],
  );
  print('Colored vertices triangle created');
  print('  runtimeType: ${coloredTriangle.runtimeType}');

  // Triangle strip
  final strip = Vertices(VertexMode.triangleStrip, [
    Offset(0.0, 0.0),
    Offset(50.0, 100.0),
    Offset(100.0, 0.0),
    Offset(150.0, 100.0),
  ]);
  print('Vertices triangleStrip created');
  print('  runtimeType: ${strip.runtimeType}');

  // Triangle fan
  final fan = Vertices(VertexMode.triangleFan, [
    Offset(100.0, 100.0), // center
    Offset(100.0, 0.0),
    Offset(200.0, 100.0),
    Offset(100.0, 200.0),
    Offset(0.0, 100.0),
  ]);
  print('Vertices triangleFan created');
  print('  runtimeType: ${fan.runtimeType}');

  // Vertices with texture coordinates
  final textured = Vertices(
    VertexMode.triangles,
    [Offset(0.0, 0.0), Offset(100.0, 0.0), Offset(50.0, 100.0)],
    textureCoordinates: [Offset(0.0, 0.0), Offset(1.0, 0.0), Offset(0.5, 1.0)],
  );
  print('Textured vertices created');
  print('  runtimeType: ${textured.runtimeType}');

  // Vertices with indices
  final indexed = Vertices(
    VertexMode.triangles,
    [
      Offset(0.0, 0.0), // 0
      Offset(100.0, 0.0), // 1
      Offset(100.0, 100.0), // 2
      Offset(0.0, 100.0), // 3
    ],
    indices: [0, 1, 2, 0, 2, 3], // Two triangles forming a quad
  );
  print('Indexed vertices (quad from 2 triangles) created');
  print('  runtimeType: ${indexed.runtimeType}');

  // Vertices with all parameters
  final fullVertices = Vertices(
    VertexMode.triangles,
    [Offset(0.0, 0.0), Offset(100.0, 0.0), Offset(50.0, 80.0)],
    colors: [Color(0xFFFF0000), Color(0xFF00FF00), Color(0xFF0000FF)],
    textureCoordinates: [Offset(0.0, 0.0), Offset(1.0, 0.0), Offset(0.5, 1.0)],
    indices: [0, 1, 2],
  );
  print('Full vertices with all params created');
  print('  runtimeType: ${fullVertices.runtimeType}');

  // ========== VERTEXMODE ==========
  print('--- VertexMode Tests ---');

  for (final mode in VertexMode.values) {
    print('  VertexMode.$mode: index=${mode.index}');
  }

  // ========== RETURN WIDGET ==========
  print('dart:ui vertices test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'dart:ui Vertices Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• Vertices - vertex mesh for drawing'),
          Text('• VertexMode - triangle/strip/fan'),
          SizedBox(height: 16.0),

          Text('Vertex Modes:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFF1F8E9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• triangles - each 3 vertices = 1 triangle'),
                Text('• triangleStrip - reuses previous 2 vertices'),
                Text('• triangleFan - reuses first + previous vertex'),
                SizedBox(height: 8.0),
                Text('Optional parameters:'),
                Text('  colors - per-vertex colors'),
                Text('  textureCoordinates - UV mapping'),
                Text('  indices - index buffer for reuse'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
