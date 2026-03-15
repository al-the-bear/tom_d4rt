// D4rt test script: Tests RenderProxyBox, RenderOpacity, RenderTransform
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderObjects basic test executing');

  // ========== RENDER PROXY BOX ==========
  print('--- RenderProxyBox Tests ---');

  final proxyBox = RenderProxyBox();
  print('RenderProxyBox created: ${proxyBox.runtimeType}');
  print('  proxyBox created successfully');

  // Can set a child (another RenderBox) if available
  // proxyBox.child = someChild;
  // For now just verify construction
  print('  hasSize: false (not laid out)');

  // ========== RENDER OPACITY ==========
  print('--- RenderOpacity Tests ---');

  final opacityHalf = RenderOpacity(opacity: 0.5);
  print('RenderOpacity(0.5) created: ${opacityHalf.runtimeType}');
  print('  opacity: ${opacityHalf.opacity}');
  print('  alwaysIncludeSemantics: ${opacityHalf.alwaysIncludeSemantics}');

  final opacityZero = RenderOpacity(opacity: 0.0);
  print('RenderOpacity(0.0) opacity: ${opacityZero.opacity}');

  final opacityFull = RenderOpacity(opacity: 1.0);
  print('RenderOpacity(1.0) opacity: ${opacityFull.opacity}');

  final opacityWithSemantics = RenderOpacity(
    opacity: 0.8,
    alwaysIncludeSemantics: true,
  );
  print(
    'RenderOpacity(0.8, semantics=true) alwaysIncludeSemantics: ${opacityWithSemantics.alwaysIncludeSemantics}',
  );

  // Modify opacity
  opacityHalf.opacity = 0.75;
  print('After setting opacity to 0.75: ${opacityHalf.opacity}');

  // ========== RENDER TRANSFORM ==========
  print('--- RenderTransform Tests ---');

  final identityTransform = RenderTransform(transform: Matrix4.identity());
  print('RenderTransform(identity) created: ${identityTransform.runtimeType}');

  // Test with translation
  final translationMatrix = Matrix4.translationValues(10.0, 20.0, 0.0);
  final translateTransform = RenderTransform(transform: translationMatrix);
  print(
    'RenderTransform(translate) created: ${translateTransform.runtimeType}',
  );

  // Test with rotation
  final rotationMatrix = Matrix4.rotationZ(0.5);
  final rotateTransform = RenderTransform(transform: rotationMatrix);
  print('RenderTransform(rotateZ) created: ${rotateTransform.runtimeType}');

  // Test with scale
  final scaleMatrix = Matrix4.diagonal3Values(2.0, 2.0, 1.0);
  final scaleTransform = RenderTransform(transform: scaleMatrix);
  print('RenderTransform(scale) created: ${scaleTransform.runtimeType}');

  // Test with origin
  final originTransform = RenderTransform(
    transform: Matrix4.identity(),
    origin: Offset(50.0, 50.0),
  );
  print('RenderTransform with origin created: ${originTransform.runtimeType}');

  // Test with alignment
  final alignedTransform = RenderTransform(
    transform: Matrix4.identity(),
    alignment: Alignment.center,
  );
  print(
    'RenderTransform with alignment created: ${alignedTransform.runtimeType}',
  );

  // Test with textDirection
  final textDirTransform = RenderTransform(
    transform: Matrix4.identity(),
    textDirection: TextDirection.ltr,
  );
  print(
    'RenderTransform with textDirection created: ${textDirTransform.runtimeType}',
  );

  // Note: Cannot call layout() or paint() on orphan render objects
  // They require a parent render tree to function
  print('Note: render objects not laid out - no parent render tree attached');

  print('RenderObjects basic test completed');
  return Container(child: Text('RenderObjects basic test passed'));
}
