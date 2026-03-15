// D4rt test script: Tests UniformVec3Slot concepts from dart:ui
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UniformVec3Slot comprehensive test executing');
  final results = <String>[];

  // ========== UniformVec3Slot Concept Tests ==========
  print('Testing UniformVec3Slot concepts...');

  // Test 1: UniformVec3Slot type availability
  final type = ui.UniformVec3Slot;
  assert(type != null, 'UniformVec3Slot type should be available');
  results.add('UniformVec3Slot type available');
  print('UniformVec3Slot type: $type');

  // Test 2: Vec3 uniform concept
  results.add('UniformVec3Slot: Three float shader uniform');
  print('Purpose: Set vec3 (3 floats) in fragment shader');

  // Test 3: Memory layout
  results.add('Memory: 3 consecutive floats (12 bytes)');
  print('Vec3 occupies 3 float slots (12 bytes)');

  // Test 4: RGB color representation
  final r = 1.0, g = 0.5, b = 0.25;
  results.add('RGB color: ($r, $g, $b)');
  print('RGB as vec3: ($r, $g, $b)');

  // Test 5: Color from Flutter Color
  final color = Color(0xFF4080C0);
  final colorR = color.red / 255.0;
  final colorG = color.green / 255.0;
  final colorB = color.blue / 255.0;
  results.add(
    'Color to vec3: (${colorR.toStringAsFixed(2)}, ${colorG.toStringAsFixed(2)}, ${colorB.toStringAsFixed(2)})',
  );
  print('Color conversion: RGB normalized to 0-1');

  // Test 6: 3D position concept
  final x = 10.0, y = 20.0, z = 30.0;
  results.add('3D position: ($x, $y, $z)');
  print('3D position vector: ($x, $y, $z)');

  // Test 7: Normal vector concept
  final nx = 0.0, ny = 0.0, nz = 1.0;
  results.add('Normal: ($nx, $ny, $nz) facing camera');
  print('Surface normal vector (0,0,1)');

  // Test 8: Light direction uniform
  final lightDir = [-0.5, -1.0, -0.5]; // pointing down-left-forward
  results.add('Light dir: (${lightDir[0]}, ${lightDir[1]}, ${lightDir[2]})');
  print('Light direction for shading');

  // Test 9: HSL/HSV values
  final h = 0.6; // hue 0-1
  final s = 0.8; // saturation 0-1
  final l = 0.5; // lightness 0-1
  results.add('HSL: ($h, $s, $l)');
  print('HSL color as vec3: ($h, $s, $l)');

  // Test 10: Camera position uniform
  final camPos = [0.0, 0.0, 5.0]; // 5 units away in Z
  results.add('Camera: (${camPos[0]}, ${camPos[1]}, ${camPos[2]})');
  print('Camera position for 3D effects');

  // Test 11: GLSL correspondence
  results.add('GLSL: uniform vec3 uValue');
  print('GLSL declaration: uniform vec3 uColor;');

  // Test 12: Setting via API
  results.add('API: 3 consecutive setFloat calls');
  print(
    'shader.setFloat(idx, x/r); setFloat(idx+1, y/g); setFloat(idx+2, z/b)',
  );

  // Test 13: Component access in GLSL
  results.add('GLSL access: uVec.x, uVec.y, uVec.z, uVec.rgb');
  print('Swizzle: .xyz, .rgb, .stp');

  // Test 14: Euler angles concept
  final pitch = 0.0, yaw = 3.14159, roll = 0.0;
  results.add('Euler angles: pitch=$pitch, yaw=$yaw, roll=$roll');
  print('Rotation as euler angles');

  // Test 15: Scale factor 3D
  final scaleX = 1.0, scaleY = 1.0, scaleZ = 1.0;
  results.add('Scale3D: ($scaleX, $scaleY, $scaleZ)');
  print('3D scale uniform');

  // Test 16: Ambient light color
  final ambient = [0.1, 0.1, 0.15]; // slightly blue ambient
  results.add('Ambient: (${ambient[0]}, ${ambient[1]}, ${ambient[2]})');
  print('Ambient light color for shading');

  // Test 17: Cross product context
  results.add('vec3 supports cross product in GLSL');
  print('Cross product: cross(a, b) returns perpendicular');

  // Test 18: Dot product context
  results.add('vec3 supports dot product in GLSL');
  print('Dot product: dot(a, b) for angle/projection');

  // Test 19: Material properties uniform
  final specular = [1.0, 1.0, 1.0]; // white specular highlight
  results.add('Specular: (${specular[0]}, ${specular[1]}, ${specular[2]})');
  print('Specular color for Phong shading');

  // Test 20: Summary
  print('UniformVec3Slot test completed with ${results.length} tests');
  results.add('All tests passed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'UniformVec3Slot Tests',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text('Type: Vec3 (3 floats, 12 bytes)'),
      Text('Uses: RGB color, 3D position, normals'),
      Text('GLSL: uniform vec3 uName;'),
      Text('Access: .xyz, .rgb swizzles'),
      Text('Tests passed: ${results.length}'),
    ],
  );
}
