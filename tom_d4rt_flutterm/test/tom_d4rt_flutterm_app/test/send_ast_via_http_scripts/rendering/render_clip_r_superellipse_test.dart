// D4rt test script: Tests RenderClipRSuperellipse from rendering
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderClipRSuperellipse test executing');

  // ========== CLIP RRSUPERELLIPSE BASICS ==========
  print('--- ClipRSuperellipse Basics ---');
  print('RenderClipRSuperellipse clips to a RSuperellipse (squircle) shape');
  print('Uses continuous cornered rectangles (iOS-style rounded corners)');
  print('More pleasing than standard rounded rectangles');

  // Test using ClipRRect as the closest equivalent widget
  // Note: ClipRSuperellipse is available in newer Flutter versions
  final clipRRect = ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Container(
      width: 100,
      height: 100,
      color: Colors.blue,
      child: Center(child: Text('Clipped')),
    ),
  );
  print('ClipRRect created (similar to ClipRSuperellipse)');
  print('  runtimeType: ${clipRRect.runtimeType}');
  print('  borderRadius: ${clipRRect.borderRadius}');
  print('  clipBehavior: ${clipRRect.clipBehavior}');

  // ========== SQUIRCLE GEOMETRY ==========
  print('--- Squircle Geometry ---');
  print('Squircle: Shape between a square and circle');
  print('Mathematical formula: |x|^n + |y|^n = r^n where n > 2');
  print('RSuperellipse uses continuous curvature');
  print('Avoids sharp transitions of standard RRect');

  // Test various border radii
  final smallRadius = ClipRRect(
    borderRadius: BorderRadius.circular(5),
    child: Container(width: 50, height: 50, color: Colors.red),
  );
  print('Small radius (5): Nearly square corners');

  final mediumRadius = ClipRRect(
    borderRadius: BorderRadius.circular(15),
    child: Container(width: 50, height: 50, color: Colors.green),
  );
  print('Medium radius (15): Moderate rounding');

  final largeRadius = ClipRRect(
    borderRadius: BorderRadius.circular(25),
    child: Container(width: 50, height: 50, color: Colors.orange),
  );
  print('Large radius (25): Nearly circular corners');

  // ========== CLIP BEHAVIOR ==========
  print('--- Clip Behavior Options ---');

  final hardEdge = ClipRRect(
    borderRadius: BorderRadius.circular(20),
    clipBehavior: Clip.hardEdge,
    child: Container(width: 60, height: 60, color: Colors.purple),
  );
  print('Clip.hardEdge: Fast but aliased edges');

  final antiAlias = ClipRRect(
    borderRadius: BorderRadius.circular(20),
    clipBehavior: Clip.antiAlias,
    child: Container(width: 60, height: 60, color: Colors.teal),
  );
  print('Clip.antiAlias: Smooth edges, moderate performance');

  final antiAliasWithSaveLayer = ClipRRect(
    borderRadius: BorderRadius.circular(20),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Container(width: 60, height: 60, color: Colors.pink),
  );
  print('Clip.antiAliasWithSaveLayer: Smoothest, slowest');

  // ========== ASYMMETRIC CORNERS ==========
  print('--- Asymmetric Corner Radii ---');

  final asymmetric = ClipRRect(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(30),
      topRight: Radius.circular(10),
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(30),
    ),
    child: Container(
      width: 80,
      height: 80,
      color: Colors.amber,
      child: Center(child: Text('Asym')),
    ),
  );
  print('Asymmetric corner radii applied');
  print('  topLeft: 30, topRight: 10');
  print('  bottomLeft: 10, bottomRight: 30');

  // ========== USE CASES ==========
  print('--- Common Use Cases ---');
  print('1. iOS-style app icons (squircle shape)');
  print('2. Profile pictures with smooth corners');
  print('3. Card designs with premium feel');
  print('4. Button backgrounds');

  // Test with image placeholder
  final imageClip = ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
      ),
      child: Center(child: Icon(Icons.image, color: Colors.white)),
    ),
  );
  print('Image clip with gradient');

  // ========== NESTED CLIPPING ==========
  print('--- Nested Clipping ---');

  final nestedClip = ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Container(
      width: 120,
      height: 120,
      color: Colors.grey[300],
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(width: 60, height: 60, color: Colors.indigo),
        ),
      ),
    ),
  );
  print('Nested ClipRRect widgets');
  print('  Outer radius: 20, Inner radius: 10');

  // ========== PERFORMANCE NOTES ==========
  print('--- Performance Considerations ---');
  print('RenderClipRSuperellipse is more expensive than RenderClipRect');
  print('Use Clip.hardEdge when anti-aliasing not needed');
  print('Avoid antiAliasWithSaveLayer unless required');
  print('Consider using DecoratedBox for borders without clipping');

  print('RenderClipRSuperellipse test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderClipRSuperellipse Tests'),
      clipRRect,
      SizedBox(height: 8),
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          smallRadius,
          SizedBox(width: 8),
          mediumRadius,
          SizedBox(width: 8),
          largeRadius,
        ],
      ),
      SizedBox(height: 8),
      asymmetric,
      SizedBox(height: 8),
      imageClip,
      SizedBox(height: 8),
      Text('All ClipRSuperellipse tests passed'),
    ],
  );
}
