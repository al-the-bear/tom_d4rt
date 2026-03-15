// D4rt test script: Tests RenderAspectRatio, RenderFittedBox, RenderLimitedBox, RenderIntrinsicWidth, RenderIntrinsicHeight
// we don't ignore for file, we write test that following the usual guidelines:  avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderObjects sizing test executing');

  // ========== RENDER ASPECT RATIO ==========
  print('--- RenderAspectRatio Tests ---');

  final aspectRatio16x9 = RenderAspectRatio(aspectRatio: 16.0 / 9.0);
  print('RenderAspectRatio(16:9) created: ${aspectRatio16x9.runtimeType}');
  print('  aspectRatio: ${aspectRatio16x9.aspectRatio}');

  final aspectRatio1x1 = RenderAspectRatio(aspectRatio: 1.0);
  print('RenderAspectRatio(1:1) aspectRatio: ${aspectRatio1x1.aspectRatio}');

  final aspectRatio4x3 = RenderAspectRatio(aspectRatio: 4.0 / 3.0);
  print('RenderAspectRatio(4:3) aspectRatio: ${aspectRatio4x3.aspectRatio}');

  // Modify aspectRatio
  aspectRatio16x9.aspectRatio = 2.0;
  print('After setting aspectRatio to 2.0: ${aspectRatio16x9.aspectRatio}');

  // ========== RENDER FITTED BOX ==========
  print('--- RenderFittedBox Tests ---');

  final fittedBoxDefault = RenderFittedBox();
  print('RenderFittedBox() created: ${fittedBoxDefault.runtimeType}');
  print('  fit: ${fittedBoxDefault.fit}');
  print('  alignment: ${fittedBoxDefault.alignment}');
  print('  clipBehavior: ${fittedBoxDefault.clipBehavior}');

  final fittedBoxContain = RenderFittedBox(
    fit: BoxFit.contain,
    alignment: Alignment.center,
  );
  print('RenderFittedBox(contain, center):');
  print('  fit: ${fittedBoxContain.fit}');
  print('  alignment: ${fittedBoxContain.alignment}');

  final fittedBoxCover = RenderFittedBox(
    fit: BoxFit.cover,
    alignment: Alignment.topLeft,
    clipBehavior: Clip.hardEdge,
  );
  print('RenderFittedBox(cover, topLeft, hardEdge):');
  print('  fit: ${fittedBoxCover.fit}');
  print('  alignment: ${fittedBoxCover.alignment}');
  print('  clipBehavior: ${fittedBoxCover.clipBehavior}');

  final fittedBoxFill = RenderFittedBox(
    fit: BoxFit.fill,
    textDirection: TextDirection.ltr,
  );
  print('RenderFittedBox(fill) fit: ${fittedBoxFill.fit}');

  // Modify properties
  fittedBoxDefault.fit = BoxFit.scaleDown;
  print('After setting fit to scaleDown: ${fittedBoxDefault.fit}');

  // ========== BOX FIT ENUM ==========
  print('--- BoxFit enum values ---');
  print('BoxFit.fill: ${BoxFit.fill}');
  print('BoxFit.contain: ${BoxFit.contain}');
  print('BoxFit.cover: ${BoxFit.cover}');
  print('BoxFit.fitWidth: ${BoxFit.fitWidth}');
  print('BoxFit.fitHeight: ${BoxFit.fitHeight}');
  print('BoxFit.none: ${BoxFit.none}');
  print('BoxFit.scaleDown: ${BoxFit.scaleDown}');

  // ========== RENDER LIMITED BOX ==========
  print('--- RenderLimitedBox Tests ---');

  final limitedBox = RenderLimitedBox();
  print('RenderLimitedBox() created: ${limitedBox.runtimeType}');
  print('  maxWidth: ${limitedBox.maxWidth}');
  print('  maxHeight: ${limitedBox.maxHeight}');

  final limitedBoxCustom = RenderLimitedBox(maxWidth: 200.0, maxHeight: 150.0);
  print('RenderLimitedBox(200x150):');
  print('  maxWidth: ${limitedBoxCustom.maxWidth}');
  print('  maxHeight: ${limitedBoxCustom.maxHeight}');

  // Modify properties
  limitedBox.maxWidth = 300.0;
  print('After setting maxWidth to 300: ${limitedBox.maxWidth}');
  limitedBox.maxHeight = 250.0;
  print('After setting maxHeight to 250: ${limitedBox.maxHeight}');

  // ========== RENDER INTRINSIC WIDTH ==========
  print('--- RenderIntrinsicWidth Tests ---');

  final intrinsicWidth = RenderIntrinsicWidth();
  print('RenderIntrinsicWidth() created: ${intrinsicWidth.runtimeType}');
  print('  stepWidth: ${intrinsicWidth.stepWidth}');
  print('  stepHeight: ${intrinsicWidth.stepHeight}');

  final intrinsicWidthCustom = RenderIntrinsicWidth(
    stepWidth: 50.0,
    stepHeight: 25.0,
  );
  print('RenderIntrinsicWidth(50, 25):');
  print('  stepWidth: ${intrinsicWidthCustom.stepWidth}');
  print('  stepHeight: ${intrinsicWidthCustom.stepHeight}');

  // Modify properties
  intrinsicWidth.stepWidth = 100.0;
  print('After setting stepWidth to 100: ${intrinsicWidth.stepWidth}');

  // ========== RENDER INTRINSIC HEIGHT ==========
  print('--- RenderIntrinsicHeight Tests ---');

  final intrinsicHeight = RenderIntrinsicHeight();
  print('RenderIntrinsicHeight() created: ${intrinsicHeight.runtimeType}');

  // RenderIntrinsicHeight has no special configuration properties
  // It sizes its child to the child's intrinsic height
  print('Note: RenderIntrinsicHeight sizes child to intrinsic height');

  // Note: Cannot call layout() or paint() on orphan render objects
  print('Note: render objects not laid out - no parent render tree attached');

  print('RenderObjects sizing test completed');
  return Container(child: Text('RenderObjects sizing test passed'));
}
