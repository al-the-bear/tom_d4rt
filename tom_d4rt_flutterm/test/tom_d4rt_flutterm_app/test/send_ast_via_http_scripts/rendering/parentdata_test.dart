// D4rt test script: Tests StackParentData, FlexParentData, BoxParentData, SliverGridParentData concepts
// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, unused_local_variable, unnecessary_type_check, unnecessary_import, deprecated_member_use, unused_import, unnecessary_null_comparison, unnecessary_brace_in_string_interps, sized_box_for_whitespace, sort_child_properties_last, prefer_function_declarations_over_variables, prefer_is_empty, avoid_unnecessary_containers, invalid_use_of_protected_member, equal_elements_in_set, dead_code, dead_null_aware_expression, unnecessary_string_interpolations, prefer_iterable_wheretype, prefer_final_fields, no_leading_underscores_for_local_identifiers, curly_braces_in_flow_control_structures, use_super_parameters, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_logic_in_create_state, avoid_function_literals_in_foreach_calls, use_null_aware_elements, unused_element, unused_field, unrelated_type_equality_checks, invalid_null_aware_operator, depend_on_referenced_packages, unnecessary_non_null_assertion, use_of_void_result, invalid_return_type_for_catch_error, override_on_non_overriding_member, duplicate_import, directive_after_declaration, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_const_declarations, unnecessary_const, undefined_getter, undefined_setter, undefined_method, undefined_function, undefined_named_parameter, undefined_identifier, undefined_class, undefined_operator, undefined_enum_constant, undefined_prefixed_name, missing_required_argument, not_enough_positional_arguments, extra_positional_arguments, argument_type_not_assignable, const_with_non_const, const_initialized_with_non_constant_value, const_with_undefined_constructor, invalid_constant, instantiate_abstract_class, static_access_to_instance_member, invocation_of_non_function_expression, non_abstract_class_inherits_abstract_member, no_generative_constructors_in_superclass, invalid_override, invalid_implementation_override, invalid_assignment, implements_non_class, type_test_with_undefined_name, unchecked_use_of_nullable_value, assignment_to_final, assignment_to_final_no_setter, implicit_super_initializer_missing_arguments, non_bool_condition, new_with_undefined_constructor_default, non_constant_default_value, final_not_initialized, duplicate_definition, duplicate_ignore, strict_top_level_inference, prefer_typing_uninitialized_variables, field_initializer_outside_constructor, named_parameter_outside_group, obsolete_colon_for_default_value, expected_identifier_but_got_keyword, use_function_type_syntax_for_parameters, missing_function_parameters, missing_function_body, not_a_type, unused_element_parameter, invalid_use_of_internal_member, non_type_as_type_argument, unnecessary_nullable_for_final_variable_declarations, await_in_wrong_context, non_constant_identifier_names
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('ParentData test executing');

  // ========== BOX PARENT DATA ==========
  print('--- BoxParentData Tests ---');

  final boxParentData = BoxParentData();
  print('BoxParentData created: ${boxParentData.runtimeType}');
  print('  offset: ${boxParentData.offset}');

  boxParentData.offset = Offset(10.0, 20.0);
  print('After setting offset: ${boxParentData.offset}');

  boxParentData.offset = Offset(50.0, 100.0);
  print('After setting offset again: ${boxParentData.offset}');

  boxParentData.offset = Offset.zero;
  print('After setting offset to zero: ${boxParentData.offset}');

  // ========== STACK PARENT DATA ==========
  print('--- StackParentData Tests ---');

  final stackData = StackParentData();
  print('StackParentData created: ${stackData.runtimeType}');

  // Set positioning properties
  stackData.top = 10.0;
  stackData.left = 20.0;
  stackData.right = null;
  stackData.bottom = null;
  stackData.width = 100.0;
  stackData.height = 80.0;
  print('StackParentData set:');
  print('  top: ${stackData.top}');
  print('  left: ${stackData.left}');
  print('  right: ${stackData.right}');
  print('  bottom: ${stackData.bottom}');
  print('  width: ${stackData.width}');
  print('  height: ${stackData.height}');
  print('  isPositioned: ${stackData.isPositioned}');

  // All null = not positioned
  final stackDataEmpty = StackParentData();
  print('StackParentData(empty) isPositioned: ${stackDataEmpty.isPositioned}');

  // Only right and bottom
  final stackDataRB = StackParentData();
  stackDataRB.right = 30.0;
  stackDataRB.bottom = 40.0;
  print('StackParentData(right=30, bottom=40):');
  print('  right: ${stackDataRB.right}');
  print('  bottom: ${stackDataRB.bottom}');
  print('  isPositioned: ${stackDataRB.isPositioned}');

  // ========== FLEX PARENT DATA ==========
  print('--- FlexParentData Tests ---');

  // FlexParentData is used by RenderFlex children
  // It extends BoxParentData and adds flex/fit properties
  final flexData = FlexParentData();
  print('FlexParentData created: ${flexData.runtimeType}');
  print('  flex: ${flexData.flex}');
  print('  fit: ${flexData.fit}');

  flexData.flex = 2;
  print('After setting flex=2: ${flexData.flex}');

  flexData.fit = FlexFit.tight;
  print('After setting fit=tight: ${flexData.fit}');

  flexData.fit = FlexFit.loose;
  print('After setting fit=loose: ${flexData.fit}');

  // offset from BoxParentData
  flexData.offset = Offset(5.0, 10.0);
  print('FlexParentData offset: ${flexData.offset}');

  // ========== FLEX FIT ENUM ==========
  print('--- FlexFit values ---');
  print('FlexFit.tight: ${FlexFit.tight}');
  print('FlexFit.loose: ${FlexFit.loose}');

  // ========== MULTI CHILD LAYOUT PARENT DATA ==========
  print('--- MultiChildLayoutParentData Tests ---');

  final multiChildData = MultiChildLayoutParentData();
  print('MultiChildLayoutParentData created: ${multiChildData.runtimeType}');
  print('  id: ${multiChildData.id}');
  print('  offset: ${multiChildData.offset}');

  multiChildData.id = 'header';
  print('After setting id=header: ${multiChildData.id}');

  multiChildData.offset = Offset(0.0, 50.0);
  print('After setting offset: ${multiChildData.offset}');

  // ========== SLIVER PHYSICAL PARENT DATA ==========
  print('--- SliverPhysicalParentData Tests ---');

  final sliverPhysData = SliverPhysicalParentData();
  print('SliverPhysicalParentData created: ${sliverPhysData.runtimeType}');
  print('  paintOffset: ${sliverPhysData.paintOffset}');

  sliverPhysData.paintOffset = Offset(0.0, 100.0);
  print('After setting paintOffset: ${sliverPhysData.paintOffset}');

  // ========== SLIVER LOGICAL PARENT DATA ==========
  print('--- SliverLogicalParentData Tests ---');

  final sliverLogData = SliverLogicalParentData();
  print('SliverLogicalParentData created: ${sliverLogData.runtimeType}');
  print('  layoutOffset: ${sliverLogData.layoutOffset}');

  sliverLogData.layoutOffset = 200.0;
  print('After setting layoutOffset: ${sliverLogData.layoutOffset}');

  // ========== RELATIVE RECT ==========
  print('--- RelativeRect Tests ---');

  final relRect = RelativeRect.fromLTRB(10.0, 20.0, 30.0, 40.0);
  print('RelativeRect.fromLTRB(10,20,30,40):');
  print('  left: ${relRect.left}');
  print('  top: ${relRect.top}');
  print('  right: ${relRect.right}');
  print('  bottom: ${relRect.bottom}');

  final relRectFill = RelativeRect.fill;
  print('RelativeRect.fill:');
  print('  left: ${relRectFill.left}');
  print('  top: ${relRectFill.top}');
  print('  right: ${relRectFill.right}');
  print('  bottom: ${relRectFill.bottom}');

  final relRectFromSize = RelativeRect.fromSize(
    Rect.fromLTWH(10, 20, 100, 80),
    Size(200, 150),
  );
  print('RelativeRect.fromSize:');
  print('  left: ${relRectFromSize.left}');
  print('  top: ${relRectFromSize.top}');
  print('  right: ${relRectFromSize.right}');
  print('  bottom: ${relRectFromSize.bottom}');

  final relRectFromRect = RelativeRect.fromRect(
    Rect.fromLTWH(10, 20, 100, 80),
    Rect.fromLTWH(0, 0, 200, 150),
  );
  print('RelativeRect.fromRect:');
  print('  left: ${relRectFromRect.left}');
  print('  top: ${relRectFromRect.top}');

  // RelativeRect methods
  final shifted = relRect.shift(Offset(5.0, 5.0));
  print('RelativeRect.shift(5,5): left=${shifted.left}, top=${shifted.top}');

  final inflated = relRect.inflate(2.0);
  print('RelativeRect.inflate(2): left=${inflated.left}, top=${inflated.top}');

  final deflated = relRect.deflate(1.0);
  print('RelativeRect.deflate(1): left=${deflated.left}, top=${deflated.top}');

  final rect = relRect.toRect(Rect.fromLTWH(0, 0, 200, 150));
  print('RelativeRect.toRect: $rect');

  final size = relRect.toSize(Size(200, 150));
  print('RelativeRect.toSize: $size');

  // ========== POSITIONED WIDGET USAGE ==========
  print('--- Positioned widget with parent data ---');

  final positioned = Positioned(
    left: 10,
    top: 20,
    width: 100,
    height: 80,
    child: Text('Positioned child'),
  );
  print('Positioned widget created: ${positioned.runtimeType}');
  print('  left: ${positioned.left}');
  print('  top: ${positioned.top}');
  print('  width: ${positioned.width}');
  print('  height: ${positioned.height}');

  print('ParentData test completed');
  return Container(child: Text('ParentData test passed'));
}
